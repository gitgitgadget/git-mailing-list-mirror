From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: can we prevent reflog deletion when branch is deleted?
Date: Sun, 2 Jun 2013 15:50:40 +0530
Message-ID: <CAMK1S_hfnVLvJx=sOFr4nO09=NaD_jAbdZ4S2kQAAnn6i0wX4g@mail.gmail.com>
References: <CAMK1S_jY1tDCkyOamX8XNW9g8Dzf6yN9znwN6he-EVcOkBM1fQ@mail.gmail.com>
	<51A963B7.6060002@alum.mit.edu>
	<20130601050355.GA23408@sigill.intra.peff.net>
	<CALkWK0kcJH0t4i0BAPmMkNWwNzeJNdmg_wbt3ao-=R31kJ5noA@mail.gmail.com>
	<20130601090934.GA13904@sigill.intra.peff.net>
	<CALkWK0mwAc0bFon7B7nw1Nbvcwdf8m2_531qtrN-r28r9F+70Q@mail.gmail.com>
	<CAMK1S_hPups3SCwxhHRYWBJzpPreNVUfNdx1+_Hjy2_d0MMpaA@mail.gmail.com>
	<CALkWK0=SqCh-82F4ud+AxuzzEezyMWqMvc6HAPoxOk32vUND7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Git Mailing List <git@vger.kernel.org>,
	Elijah Newren <newren@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 02 12:20:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uj5P5-0000O0-C2
	for gcvg-git-2@plane.gmane.org; Sun, 02 Jun 2013 12:20:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753086Ab3FBKUn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Jun 2013 06:20:43 -0400
Received: from mail-we0-f175.google.com ([74.125.82.175]:65503 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752900Ab3FBKUl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jun 2013 06:20:41 -0400
Received: by mail-we0-f175.google.com with SMTP id x54so878453wes.34
        for <git@vger.kernel.org>; Sun, 02 Jun 2013 03:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=IB/3FNiuqyXkJ/SjhI4DOG9pIzG3oyk4Y9Rg7IqraXI=;
        b=usJvPVxCb+4az09ht76GtK8uyBQAEGrOwLv/pMzlNPcmpN3r+mcb74JiTSJ05mAnSY
         c3+seRCTKgGc0+C4NWj7yK+KrHEkJnBg5/KT3vxzhI8uteQ0Skv6CEGTk/4pkzpLXqqg
         dn1r6PnxqPm5XUdwnSQURun9HVhysl6g9o84ytmxrfbflUSdxEwiWDl0B2kg+fo1a1C3
         +osh4ev6wbBSNRQKHJcnmea1qFR2385huxCjoLOWHCvN1BlXyOe5eLaXyhj+nRheORCH
         U6HM9WqRLzWWloXPW3cElHe0rmd5pLwwItGu70Ym1KeeTYzoOYNPq9TmTEuimLy6f36p
         52Aw==
X-Received: by 10.180.74.10 with SMTP id p10mr8921962wiv.39.1370168440268;
 Sun, 02 Jun 2013 03:20:40 -0700 (PDT)
Received: by 10.194.170.65 with HTTP; Sun, 2 Jun 2013 03:20:40 -0700 (PDT)
In-Reply-To: <CALkWK0=SqCh-82F4ud+AxuzzEezyMWqMvc6HAPoxOk32vUND7A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226150>

On Sat, Jun 1, 2013 at 11:26 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Sitaram Chamarty wrote:
>> I think I'd have to be playing with *several* branches simultaneously
>> before I got to the point of forgetting the branch name!
>
> Yeah, I work on lots of small unrelated things: the patch-series I
> send in are usually the result of few hours of work (upto a few days).
>  I keep the branch around until I've rewritten it for enough re-rolls
> and am sufficiently sure that it'll hit master.
>
>> More to the point, your use case may be relevant for a non-bare repo
>> where "work" is being done, but for a bare repo on a server, I think
>> the branch name *does* have significance, because it's what people are
>> collaborating on.
>>
>> (Imagine someone accidentally nukes a branch, and then someone else
>> tries to "git pull" and finds it gone.  Any recovery at that point
>> must necessarily use the branch name).
>
> Ah, you're mostly talking about central workflows.  I'm on the other

Yes.  Not just because that's what "$dayjob" does, but also because
that's what gitolite does.

> end of the spectrum: I want triangular workflows (and git.git is
> slowly getting there).  However, I might have a (vague) thought on
> server-side safety in general: I think the harsh dichotomy in ff-only
> versus non-ff branches is very inelegant.  Imposing ff-only feels like
> a hammer solution, because what happens in practice is different: the
> `master` does not need to be rewritten most of the time, but I think
> it's useful to allow some "safe" rewrites to undo the mistake of
> checking in an private key or something [*1*].  By safety, I mean that

I suspect that's a big reason for why gitolite is so popular, at least
with central workflows.  It's trivial to set it up so master is
ff-only and any other branch is rewindable etc.

> git should give the user easy access to recent dangling objects by
> annotating it with enough information: sort of like a general-purpose
> "pretty" reflog that is gc-safe (configurable trunc_length?).  It's a
> serves more usecases than just the branch-removal problem.

Again, for "central workflow" folks, gitolite's log files actually
have enough info for all this and more.  Coupled with
"core.logAllRefUpdates", it's possible to recover anything that has
not been gc-ed, even deleted branches and tags.

But it would be nicer if git's own reflog is able to do that.  Hence
my original thought about preserving reflogs for deleted refs (even if
it is in a "graveyard" log to resolve the D/F conflict that Michael
and Peff were discussing up at the top of the thread).

> Ofcourse, the standard disclaimer applies: there's a high likelihood
> that I'm saying nonsense, because I've never worked in a central
> environment.
>
> [Footnotes]
>
> *1* It turns out that this is not uncommon:
> https://github.com/search?q=path%3A.ssh%2Fid_rsa&type=Code&ref=searchresults

Hah!  Lovely...

--
Sitaram
