From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH v3 2/6] notes: replace pseudorefs with real refs
Date: Wed, 29 Jul 2015 04:53:39 +0200
Message-ID: <CALKQrgff1AKBCsdFBTcthMb61gQwb4CjH=P7TPfpy1unMJ2_=g@mail.gmail.com>
References: <1438107144-24293-1-git-send-email-dturner@twopensource.com>
	<1438107144-24293-3-git-send-email-dturner@twopensource.com>
	<xmqqpp3cds44.fsf@gitster.dls.corp.google.com>
	<xmqqegjsdq3n.fsf@gitster.dls.corp.google.com>
	<CALKQrgdLC_sLkM3jyH6pnDoY+RTHr9wJR_VH6iirBWmvyHYcVA@mail.gmail.com>
	<xmqqpp3bc2u6.fsf@gitster.dls.corp.google.com>
	<CALKQrgfxc83-yjrCWZqC+pyPhbQDgYbrpCDSaBk78YypO=BXOg@mail.gmail.com>
	<xmqqlhdzby5o.fsf@gitster.dls.corp.google.com>
	<55B824BD.8000003@alum.mit.edu>
	<xmqqh9onbu53.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	David Turner <dturner@twopensource.com>,
	Git mailing list <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Philip Oakley <philipoakley@iee.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 04:54:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKHVX-0006RU-I1
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 04:54:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752396AbbG2Cxs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 22:53:48 -0400
Received: from locusts.copyleft.no ([188.94.218.116]:64621 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752352AbbG2Cxr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 22:53:47 -0400
Received: from mail-yk0-f177.google.com ([209.85.160.177])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1ZKHV3-0003Gr-8n
	for git@vger.kernel.org; Wed, 29 Jul 2015 04:53:45 +0200
Received: by ykax123 with SMTP id x123so112679623yka.1
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 19:53:39 -0700 (PDT)
X-Received: by 10.129.138.129 with SMTP id a123mr40945021ywg.139.1438138419396;
 Tue, 28 Jul 2015 19:53:39 -0700 (PDT)
Received: by 10.37.208.71 with HTTP; Tue, 28 Jul 2015 19:53:39 -0700 (PDT)
In-Reply-To: <xmqqh9onbu53.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274878>

On Wed, Jul 29, 2015 at 4:00 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>> It sounds like what a notes merge really wants is a new linked worktree
>> that has branch refs/notes/foo checked out:
>>
>> * This would allow multiple notes merges to take place at the same time
>> provided they target different merge references.
>>
>> * This would prevent multiple notes merges to the same notes reference
>> at the same time by the same mechanism that prevents the same branch
>> from being checked out in two linked worktrees at the same time.
>>
>> It's just a thought; I have no idea whether it is practical...
>
> That was certainly one of the possibilities that crossed my mind.
>
> In any case, the primary thing I am interested in at this point is
> to unblock David's "prepare things so that we can put primary refs
> in a different ref backends more easily" topic, and I've already
> made my point a few messages ago upstream:
>
>     I think it is OK for us to admit that the "notes" subsystem is
>     not quite ready to work well with multiple working tree world
>     yet [*1*], and move this series forward without worrying about
>     them.
>
> So doing the absolute minimum, leaving the "now what can we do to
> improve notes-merge process?" outside the scope of the topic.

That's exactly what I was also trying to do: David's topic should not
have to deal with NOTES_MERGE_* at all. Simply leave it all as
something that belongs in $GIT_COMMON_DIR, and let's solve concurrent
unrelated notes merges as a wholly independent, separate topic.

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
