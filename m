From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Mon, 9 Sep 2013 18:17:07 -0500
Message-ID: <CAMP44s0YaQo7xAkPcV3xVTcYQStUVuyY=we-=KMgtZ-xgZzz1Q@mail.gmail.com>
References: <xmqqd2opu8hr.fsf@gitster.dls.corp.google.com>
	<CAMP44s2NzzS48BBpD_oQ24t2SYETte7_U4+O+32SOo5qhooQew@mail.gmail.com>
	<xmqqfvtlpm2l.fsf@gitster.dls.corp.google.com>
	<20130904081047.GB2582@serenity.lan>
	<20130904092527.GB22348@sigill.intra.peff.net>
	<CAMP44s3Vaqe-POwQb30AGdarf=ObdPUay3QEMqxHV3NKiPAouA@mail.gmail.com>
	<20130908041805.GB14019@sigill.intra.peff.net>
	<CAMP44s01LL2JCKzqa0Qc5MfBz9zfMXR4H8jZdauLOi-D0JVHpw@mail.gmail.com>
	<20130908172605.GF5359@vauxhall.crustytoothpaste.net>
	<CAMP44s0SLoD7ptgiYOg_vq+Jpo5uhWvzFC8Bd76JHo5zbjf8fg@mail.gmail.com>
	<20130909000153.GG5359@vauxhall.crustytoothpaste.net>
	<CAMP44s2seqO_0o=G2PjoL77HNSNcjTe4s6ZYj90_wsUT30pW8A@mail.gmail.com>
	<vpqr4cy4g5q.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Andreas Krey <a.krey@gmx.de>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Sep 10 01:17:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJAhn-0005M1-OZ
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 01:17:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756002Ab3IIXRK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 19:17:10 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:64399 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755756Ab3IIXRJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 19:17:09 -0400
Received: by mail-lb0-f169.google.com with SMTP id z5so5729365lbh.28
        for <git@vger.kernel.org>; Mon, 09 Sep 2013 16:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=NVKgcWcsJRkZAubsuCZl9C3DfdrffYI7bWoXEcCyuKo=;
        b=CwEF50k0QI8EGEP5aFIp8B7CMVPblbbByhdb00/gtbRgNbgInxu7puSxgrfAzxhH+g
         KBi2MAORjueId6mQsB+76YotullfFYqQopLHHAbiSKqM+ay7n4KpPMC+yrzS1PKA0Te/
         71SLiV4O9f20Ubd5sPYDVBZC8k0nJWIiUDFEOW5ZZP6hBn4TKEadzUWBC8riiTvxtWEk
         eXzq6tridtVFWvs2dyD7OR9DrqHnmkp1S2rScynD/uNTpaofQ3ARUvuLfDvl8GzlARAn
         ivd9MXRvJUeoYkgSNyKZf/chN6R7JPT4sgeJIm3bne99JHgIGsjxELd4Nz/pguWwTOQx
         qW4g==
X-Received: by 10.152.26.72 with SMTP id j8mr18520106lag.19.1378768627796;
 Mon, 09 Sep 2013 16:17:07 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Mon, 9 Sep 2013 16:17:07 -0700 (PDT)
In-Reply-To: <vpqr4cy4g5q.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234400>

On Mon, Sep 9, 2013 at 2:18 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Sun, Sep 8, 2013 at 7:01 PM, brian m. carlson
>> <sandals@crustytoothpaste.net> wrote:
>>
>>> Yes, that would be me.  My hesitance here is that as the one usually
>>> driving git updates (which so far have happened once a year), I will end
>>> up retraining forty developers.  I don't think the current behavior is
>>> broken or really problematic at all: merging has always been the
>>> default, and people have come to expect that.
>>
>> It may not be broken for you, but it is for other people. Would you be
>> so egocentric as to ignore everybody else because "it works for you"?
>
> It's not a matter of "works for me". Git currently "works" for all use
> cases because you can already merge or rebase. The proposed changes are
> not about allowing the behavior that works, but disallowing the behavior
> that doesn't.

If it works for all use cases why are we discussing this?

Hint: because it doesn't.

> I agree that allowing people to reject non-ff merge is a good idea.
>
> I strongly disagree that this should eventually become the default,
> though. I think it should really remain an opt-in (possibly with some
> non-scary warning advertizing for the feature).

That defeats the whole purpose of the proposal, which means that you
don't understand the problem.

The problem is the newcomers, and the newcomers will most definitely
not activate a configuration option to tell them that they are doing
something potentially undesirable.

By the time they learn about pull.mode, they probably already know
what a rebase is. So what is the point of the configuration in the
first place?

> First, the discussions on this thread show that it's hard to find the
> right behavior. My guess is that it's hard because we're trying to think
> for the users. I've used GNU Arch for a while, and this VCS was trying
> to impose what the developer thought was good for me. I had to fight
> with the tool whenever I tried to do something "non-standard". I don't
> want to go back there. Preventing _users_ to do something because _we_
> considered it was bad for them is wrong IMHO.

We are not preventing anybody from anything. The user can do 'git pull
--merge', the user can set 'pull.mode = merge', the user can do
anything he wants.

> I already mentionned another reason in
> http://thread.gmane.org/gmane.comp.version-control.git/225146/focus=229162 :
> "git rebase" is hard to use for many people. With "git merge", doing
> things wrong isn't so bad. If you forget to commit after a conflicted
> merge, you'll mix your changes with the merge, this is bad, but it
> works. With "git rebase", if you forget to "git rebase --continue" after
> a conflict, you end up in detached HEAD, with part of your own changes
> discarded. If my students end up in this situation, they'll stop using
> Git and exchange files by email.

That doesn't mean anything, you are assuming the user will do 'git
pull --rebase', and there's no rationale as to why they would end up
doing that.

> "git pull" is one of the first things one learns with Git, and
> _requiring_ users to chose between merge and rebase is a nonsense at
> this time of learning.

Let's use another core command as an illustration.

'git commit' by default "prevents" users from creating commits without
first adding changes to the staging area, and since it's a concept
unique to Git, it's fair to say that none of the newcomers understand
why 'git commit' is failing, the error messages is not particularly
useful either.

Following your rationale, by default 'git commit' should behave like
'git commit --all', and add all the changes in the work tree to the
new commit when there's no changes in the staging area, that would be
the easiest for the newcomers, but we don't do that, we "force" them
to understand what the staging area is, or do 'git commit --all', most
of the newcomers do the later.

So, if we draw a parallel with with pull, 'git pull --merge' is like
'git commit --all'; if they don't know what they are doing, that's
what they should type, and when the pull is non-fast-forward we error
out, just like we error out when there's nothing on the staging area.

-- 
Felipe Contreras
