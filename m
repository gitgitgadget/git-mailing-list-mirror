From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH/RFC] rebase -p: do not redo the merge, but cherry-pick
 first-parent changes
Date: Thu, 24 May 2012 10:47:57 -0700
Message-ID: <CAOeW2eH85+qa2PXS55_xGwH+tpMDMEK76HywfpLTYrv_Dtg49Q@mail.gmail.com>
References: <4FBAA33D.1080703@kdbg.org>
	<CAOeW2eE9EW3gER7ZDThGABtZ0doNuUb70DnKrnzD+OeWYLO7cQ@mail.gmail.com>
	<7vzk8yzq35.fsf@alter.siamese.dyndns.org>
	<CAOeW2eGvEaQYk9KODmLzZuEBu-KhKcQeL4PE-4YHwSgtP0dJfA@mail.gmail.com>
	<7vehq9xz7a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>,
	Stephen Haberman <stephen@exigencecorp.com>,
	Andrew Wong <andrew.kw.w@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 24 19:48:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXc8o-0007fS-NM
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 19:48:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758750Ab2EXRr6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 May 2012 13:47:58 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:62755 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755738Ab2EXRr5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 May 2012 13:47:57 -0400
Received: by dady13 with SMTP id y13so55891dad.19
        for <git@vger.kernel.org>; Thu, 24 May 2012 10:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=iy3Mp+g0kRxXHooOaxtzVJI3Hk3YTiRg7HfEPLdhrB4=;
        b=rpeR63G01ksPjbkHqdwKs17O9PtrFAu+eJ65XDaAZDcVUCxnwxxzVWn9pKpR5RLdpA
         kqAxX1hmFK+6OE6iez4t9M8YyVZr9wNPz+ikTnqUqwBsdeCasq2MiSyx8MYLDqfrX18s
         X0+fZQPvt4m179YLRwEQadGkSo3jghflr99UOCKTf8YtG0C5hJwwAHgnN3Hl9XZkciXN
         dL0S4CrzY7vsQVS0/ZlNWdlZ64p50pfgZDta0+7reJ0XHphhbcajbPVQilrlhhMA8LEG
         oIEXfKVp5VXfTOTlVXGi0/W0wadG20p68k8qiwRW+T/ZHh+FKex1dM8bdD1S/dEPYUjF
         eztA==
Received: by 10.68.225.9 with SMTP id rg9mr22980867pbc.137.1337881677107; Thu,
 24 May 2012 10:47:57 -0700 (PDT)
Received: by 10.68.51.130 with HTTP; Thu, 24 May 2012 10:47:57 -0700 (PDT)
In-Reply-To: <7vehq9xz7a.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198398>

On Thu, May 24, 2012 at 10:31 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:
>
>> Yes, I've had the same idea myself. Anyway, as Johannes said, that's
>> probably something to consider for the sequencer.
>
> Are you saying that "rebase -any-variant" and the sequencer should be=
have
> differently? =C2=A0It is not immediately obvious to me why it is a go=
od idea.

That's not what I meant to say. I thought the sequencer is supposed to
replace much of git-rebase and I thought that's what Johannes was
referring to as well when he said not to make git-rebase too
intelligent. I assumed the reasoning was that any work spent on
git-rebase at this point will be thrown away once git-rebase instead
calls into the sequencer. But I have not been very involved in the
discussions about the sequencer, so I may very well have misunderstood
things. Or are you saying that even if it's true that git-rebase will
eventually call into the sequencer for much of its operation, this
specific part (if at all implemented) does not belong in the
sequencer?

Martin
