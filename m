From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/6] notes: replace pseudorefs with real refs
Date: Wed, 29 Jul 2015 09:58:11 -0700
Message-ID: <xmqqio92aokc.fsf@gitster.dls.corp.google.com>
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
	<CALKQrgfeFrr5SygixW=pJoOCheGR9kUhqwjNyuXGvzJnWU_LyQ@mail.gmail.com>
	<xmqqpp3aapj9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Turner <dturner@twopensource.com>,
	Git mailing list <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Philip Oakley <philipoakley@iee.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Jul 29 18:58:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKUgU-0004Xl-4v
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 18:58:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753596AbbG2Q6Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 12:58:16 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:33545 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751457AbbG2Q6N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 12:58:13 -0400
Received: by pdbnt7 with SMTP id nt7so8945741pdb.0
        for <git@vger.kernel.org>; Wed, 29 Jul 2015 09:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=YZm/8HUXcFqDD2XBnjixTj9MvcX4mt0SLJ6bZsqzVM4=;
        b=o0IcWbj9YQ5ijRtyh6vzWRkF/szwdOS1CxoROGr8kCSQ+cxM7AC5J12NiUMJpMJkRS
         TKAzlGqDc2LQv9azXgFuDTTiWD0raqFijoHDPz83a4WILLEWGss/cGpL+M2O2qh86ZG6
         nJ/tbdN4MaG+wJPzGT0sQg+sOBg6ZxLwrc5SlCPje0uKmb5ZXl6AIzN3PGu5iwO0GmFd
         8DFu5OhLJcOVQJeOp5V9xcqrNj7QnTQgYDeNSAQid2UIGFAUQkW6J32Cw2Vf9wxk1lca
         mV2bWzEB91WuFCOBKbArEZgAVYELFBy9pcVT2I+mBFonpMzSDet/gXLtgRti2LTO9YAt
         OneA==
X-Received: by 10.70.140.70 with SMTP id re6mr94361124pdb.87.1438189093021;
        Wed, 29 Jul 2015 09:58:13 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:4c0b:2701:e242:17dc])
        by smtp.gmail.com with ESMTPSA id pb2sm7852598pdb.2.2015.07.29.09.58.11
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 29 Jul 2015 09:58:12 -0700 (PDT)
In-Reply-To: <xmqqpp3aapj9.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 29 Jul 2015 09:37:14 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274921>

Junio C Hamano <gitster@pobox.com> writes:

> If we do not change anything (not even applying the [v3 2/6] patch
> we are discussing),...

This one and...

> If there are reasons/limitations that make simultaneous "notes
> merge" of different notes in different $GIT_DIRs impossible, then I
> agree we shouldn't bother with [v3 2/6] patch.  We should just

... this one and ...

> declare "do not do it, it does not (yet) work".
>
> But if there isn't, [v3 2/6] is the absolute minimum thing we could

... this one.  All of these reference to [v3 2/6] are wrong.

The patch I meant was "[PATCH] notes: handle multiple worktrees",
http://thread.gmane.org/gmane.comp.version-control.git/274803/focus=274852

Sorry for the confusion.


> do to make "notes merge" usable by making sure that the user does
> not attempt merging the same refs/notes/commits in two different
> places.
