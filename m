From: Nathan Gray <n8gray@n8gray.org>
Subject: Re: push.default: current vs upstream
Date: Sat, 31 Mar 2012 22:58:50 -0700
Message-ID: <CA+7g9Jy=JRV8mXd6fxja3k1g2Vss6YZotPzVPs9xsPr6uoCg+Q@mail.gmail.com>
References: <7vd37wv77j.fsf@alter.siamese.dyndns.org>
	<20120329095236.GA11911@sigill.intra.peff.net>
	<7vbonfqezs.fsf@alter.siamese.dyndns.org>
	<20120329221154.GA1413@sigill.intra.peff.net>
	<7vfwcqq2dw.fsf@alter.siamese.dyndns.org>
	<20120330071358.GB30656@sigill.intra.peff.net>
	<7vty15ltuo.fsf@alter.siamese.dyndns.org>
	<20120330210112.GA20734@sigill.intra.peff.net>
	<CA+7g9JxK5DHj3vbdGgF2dEJxvn=_ZfjAv7Y+AL_P-aO1FVB6-w@mail.gmail.com>
	<201203312348.q2VNmsmc015543@no.baka.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: Seth Robertson <in-gitvger@baka.org>
X-From: git-owner@vger.kernel.org Sun Apr 01 07:58:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEDoX-0007VS-PZ
	for gcvg-git-2@plane.gmane.org; Sun, 01 Apr 2012 07:58:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751552Ab2DAF6x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Apr 2012 01:58:53 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:39394 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291Ab2DAF6w convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Apr 2012 01:58:52 -0400
Received: by bkcik5 with SMTP id ik5so1627228bkc.19
        for <git@vger.kernel.org>; Sat, 31 Mar 2012 22:58:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-originating-ip:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=IytlDUjQlO0AlUxG7jVhO88n7weU8XIYwUTMEM/iG2E=;
        b=hGfmY9ma7dU2X5YP/36IYWodbm8hxyi8PeQ/Vj91QOaOM1/vftXmNzHhEhqrvvG3XS
         rD+56RErDB7h23FP4bQK6/SHIk+5XYI5dFFtd5NvC41DKjXM1Aa9fpDzds5GlJwmOgtm
         OsFqnTE2btWBgdPZhX1i4zM5XjaB4dkG4CoFTXgKhVGsiZpTwUcwxnJlptHcChqsIP09
         O2j1lvQffmF0HfuGEoHYpOOh4+jcaP8XvhqO1I8fgSwrieLlOtVIeKZtWCP3vyJh+Shs
         US2JYHDWPZEgRNuO10S1GdGjuM2GWHFhigibjvZm6WNY7xQO+vItEtMY5MwLzdMk7ETb
         5cVA==
Received: by 10.204.128.201 with SMTP id l9mr1634942bks.90.1333259930432; Sat,
 31 Mar 2012 22:58:50 -0700 (PDT)
Received: by 10.204.128.200 with HTTP; Sat, 31 Mar 2012 22:58:50 -0700 (PDT)
X-Originating-IP: [66.75.229.176]
In-Reply-To: <201203312348.q2VNmsmc015543@no.baka.org>
X-Gm-Message-State: ALoCoQl1YRCXitGA5J6iPGhhPj6gdGbqmdBEwluPo9yclf13KhJEeIA2O4FfkF5lbecY/6bnSgpV
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194476>

On Sat, Mar 31, 2012 at 4:48 PM, Seth Robertson <in-gitvger@baka.org> w=
rote:
>
> In message <CA+7g9JxK5DHj3vbdGgF2dEJxvn=3D_ZfjAv7Y+AL_P-aO1FVB6-w@mai=
l.gmail.com>, Nathan Gray writes:
>
> =A0 =A0If a user does some work on his new "features/frobnitz" branch=
 and
> =A0 =A0does a "git push" only to find that his work has been committe=
d to the
> =A0 =A0company's master branch he will be confused, frustrated, and p=
ublicly
> =A0 =A0embarrassed. =A0He then has to apologize and figure out how to=
 revert
> =A0 =A0the changes. =A0I really don't see any scenario where that use=
r ends up
> =A0 =A0saying "oh yeah, I guess git was right and I was wrong."
>
> When working with a single remote, I tend to agree with you (though
> since I also think receive.denyDeletes should be on by default for
> shared repos the public humiliation of creating a branch when you did
> not mean to might still exist but of course it will be less damaging
> to others) . =A0However, tracking really comes into its own when work=
ing
> with multiple remotes. =A0Is creating a stumbling block between na=EF=
ve
> use and more sophisticated use really necessary?

Where's the stumbling block?  Nobody's talking about taking away the
upstream option, so sophisticated users who prefer upstream behavior
can configure their repos to get it.  The default should be tailored
for na=EFve users, not power users.

> However, the current message for this use case could seem to be
> tweaked to take care of this:
>
> $ git branch BB origin/B
> Branch BB set up to track remote branch B from origin.
>
> Add "If you push your changes will go there."
> And "See git branch --upstream to modify both settings"
>
> This provides the power of tracking with smaller possibility of
> the type of embarrassment you envision.

I like the idea of telling users where their pushes will go, but I
don't think this will work as well as you might expect.  You're
relying on a new user to read every part of the message, understand
the terminology, and internalize the meaning well enough to remember
it in the distant future when he's ready to push.  Considering the
onslaught of new concepts to absorb when a user switches from
centralized to distributed SCM that's a pretty tall order.

I think it's backwards to put a heavier cognitive load on newbies for
the sake of saving power users from running git config.  After all,
power users *love* running git config.  ;^)

Cheers,
-Nathan

--=20
http://n8gray.org
