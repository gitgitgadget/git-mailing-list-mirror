From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH v3 2/6] notes: replace pseudorefs with real refs
Date: Wed, 29 Jul 2015 15:19:28 +0200
Message-ID: <CALKQrgfeFrr5SygixW=pJoOCheGR9kUhqwjNyuXGvzJnWU_LyQ@mail.gmail.com>
References: <1438107144-24293-1-git-send-email-dturner@twopensource.com>
	<1438107144-24293-3-git-send-email-dturner@twopensource.com>
	<xmqqpp3cds44.fsf@gitster.dls.corp.google.com>
	<xmqqegjsdq3n.fsf@gitster.dls.corp.google.com>
	<CALKQrgdLC_sLkM3jyH6pnDoY+RTHr9wJR_VH6iirBWmvyHYcVA@mail.gmail.com>
	<xmqqpp3bc2u6.fsf@gitster.dls.corp.google.com>
	<CALKQrgfxc83-yjrCWZqC+pyPhbQDgYbrpCDSaBk78YypO=BXOg@mail.gmail.com>
	<xmqqlhdzby5o.fsf@gitster.dls.corp.google.com>
	<CALKQrge31G7-Ng8kZmy8=MgB+WQ3-bKimxCxOHOOwUMDuvRBzA@mail.gmail.com>
	<xmqqzj2fa764.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Turner <dturner@twopensource.com>,
	Git mailing list <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Philip Oakley <philipoakley@iee.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 15:19:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKRGn-0007Fj-GA
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 15:19:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752382AbbG2NTh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 09:19:37 -0400
Received: from locusts.copyleft.no ([188.94.218.116]:61542 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819AbbG2NTg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 09:19:36 -0400
Received: from mail-yk0-f177.google.com ([209.85.160.177])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1ZKRGg-000OXV-7Z
	for git@vger.kernel.org; Wed, 29 Jul 2015 15:19:34 +0200
Received: by ykdu72 with SMTP id u72so7095661ykd.2
        for <git@vger.kernel.org>; Wed, 29 Jul 2015 06:19:28 -0700 (PDT)
X-Received: by 10.13.206.133 with SMTP id q127mr43760786ywd.10.1438175968378;
 Wed, 29 Jul 2015 06:19:28 -0700 (PDT)
Received: by 10.37.208.71 with HTTP; Wed, 29 Jul 2015 06:19:28 -0700 (PDT)
In-Reply-To: <xmqqzj2fa764.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274895>

On Wed, Jul 29, 2015 at 7:01 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Johan Herland <johan@herland.net> writes:
>
>> I believe it is a bad compromise. It complicates the code, and it
>> provides a concurrent notes merges that is unnecessarily tied to (and
>> dependent on) worktrees. For example, if I wanted to perform N
>> concurrent notes merges in a project that happens to have a huge
>> worktree, I would now have to create N copies of the huge worktree...
>
> Who said worktree has to be populated?  You should be able to have
> an absolutely empty checkout just like "clone --no-checkout".

IMHO that's an insane workaround that only serves to highlight the
conceptual problems of binding notes merges (as they are implemented
today) to worktrees.

I'm much more excited about Michael's idea of formalising the concept
of a notes tree checkout (although as already discussed, checking out
a notes tree is different from checking out a "regular" tree). Then, a
notes merge (as you already suggested) should be implemented by
creating a linked worktree whose HEAD is the notes ref being merged
into. I believe there are potential complications here as well (where
a notes-merge might behave differently from a regular merge), but
those should be solvable.

But, whatever. This is unrelated to David's current effort, and I
don't want to hold that up, so please move along, nothing to see here.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
