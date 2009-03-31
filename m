From: Brian Foster <brian.foster@innova-card.com>
Subject: Re: [Q] merging from one (kernel) stable to another?
Date: Tue, 31 Mar 2009 09:30:34 +0200
Message-ID: <200903310930.34617.brian.foster@innova-card.com>
References: <200903301024.08848.brian.foster@innova-card.com> <alpine.LNX.1.00.0903301311230.19665@iabervon.org>
Reply-To: Brian Foster <brian.foster@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git mailing list <git@vger.kernel.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Mar 31 09:32:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoYSh-0007Kc-05
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 09:32:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755737AbZCaHbF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Mar 2009 03:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754848AbZCaHbE
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 03:31:04 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:10789 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756689AbZCaHbC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Mar 2009 03:31:02 -0400
Received: by ey-out-2122.google.com with SMTP id 4so713729eyf.37
        for <git@vger.kernel.org>; Tue, 31 Mar 2009 00:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:reply-to:to
         :subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        bh=IF3G7u+OW7Yilh8YzAUvsTQRT2jFN7Qi8MhjDmTcQ1E=;
        b=nQnHqECz96Y6OY2fKtJeqZxJQA8IHd3PrU4wAo/KFeIFGinhrQ440pZMjlu47mvv9Q
         9nhRgqS5sVJifEncRkAY8q09910j7oY3ZhLwSN20Nhf5DAgkw/pWNcInCeAoUPfcdvC3
         VL2ySRg7Djk9c5eWOk/MPX7uq5k/JjjOOTlrQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:reply-to:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=VeaTBytMbcbb8XEI2hZbvVLmu950sPavw/4uzp/GGkxIc8bjw0kVr2n0JPVWLsiOCo
         6XLF2ORbrS7yfKFuP/xqBhKRfRQNiii53EcnyJj3yN2MKSqEh0kLdpASXiMfUUm0n4nk
         wAI3O8spBonX5IqTXBzsYFVvZAQaOGi5ymgSQ=
Received: by 10.210.37.16 with SMTP id k16mr1880398ebk.78.1238484658164;
        Tue, 31 Mar 2009 00:30:58 -0700 (PDT)
Received: from innova-card.com (LRouen-152-82-23-47.w80-13.abo.wanadoo.fr [80.13.118.47])
        by mx.google.com with ESMTPS id 2sm6250735ewy.38.2009.03.31.00.30.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 31 Mar 2009 00:30:57 -0700 (PDT)
User-Agent: KMail/1.10.4 (Linux/2.6.27-11-generic; KDE/4.1.4; x86_64; ; )
In-Reply-To: <alpine.LNX.1.00.0903301311230.19665@iabervon.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115232>

On Monday 30 March 2009 19:31:18 Daniel Barkalow wrote:
> On Mon, 30 Mar 2009, Brian Foster wrote:
> >   Whilst this question involves linux(-mips) kernel tree,
> >  it's a git(-related?) question, not a kernel question ....
> >=20
> >   We are currently in the process of upgrading our embedded
> >  system from kernel 2.6.21(-ish) to at least 2.6.26.8;  and
> >  later, at some time in the future on to 2.6.3x or something.
> >  Going from 2.6.21 to .22 to .23 and so on to .26, then to
> >  .26.1 and so on to .26.8 is =E2=80=9Ceasy=E2=80=9D in the sense th=
ere are
> >  very few conflicts with our existing baseline (e.g., just
> >  2 or 3 in 2 or 3 files).
> >=20
> >   .21 --> me --> .22 --> .23 ... --> .26 --> .27 --> master
> >      \              \       \           \      \
> >      .21-stable  .22-stable .23-stable   \     .27-stable
> >                                         .26.8
> >                                            \
> >                                            .26-stable
> >=20
> >   But (using 2.6.21-stable and 2.6.22-stable as proxies),
> >  tests indicate that going from .26.8 to .27 or anything
> >  later will have numerous conflicts (100s? in more than
> >  30 files).  Thinking about it, this isn't too surprising
> >  since the -stable branches cherry-pick important/benign
> >  fixes from later revisions.
>=20
> Why are you going from .26.8 to .27? Based on the -stable policy,
> there should be no reason not to skip .26.x between .26 and .27.

Daniel,

  That's a good question!  The policy to-date has been to
 ignore the -stable branches entirely, and go from release
 to release; i.e., .21 to .22 to ... to .26 to .27 et al.
 We (deliberately!) stay several releases behind (being
 bang-up-to-date isn't too important to our market/product,
 but having a robust secure system is extremely important).

  The current feeling is we should probably be moving from
 -stable to -stable, i.e., .21-stable to .22-stable to ...
 to .26-stable and later to .27-stable and so on.  This is
 based, in part, on observing the changes that are in -stable
 and realizing some of them are highly desirable.  This new
 idea/plan of going from -stable to -stable can change if
 there's a good reason.  It's currently in a state of flux.

  So I somewhat incorrectly described the thinking, mixing
 up our historical practice with the proposed new policy.
 In my defense, my I point out that we are particularly
 interested in some MIPS changes on .26-stable, and, at the
 the moment, have decided to not go to .27 for this cycle.
 (Admittedly, with the release of .29, the decision not to
 go to .27 has been challenged, but the issue hasn't been
 looked into in any detail (yet? as far as I know).)

  Anyways, good catch!  I take your point.  Many thanks.

>                                                            In fact, i=
t's
> not unlikely that merging both .26.8 and .27 will introduce bugs when=
 the
> same issue was fixed in different places in the two branches: a narro=
w
> patch to paper over the identified problem in -stable and an intrusiv=
e
> patch to change some API to make simpler code correct in the mainline=
=2E
>=20
> That is, the correct way of merging changes from -stable with the lat=
est
> mainline series is always to take the mainline version, even if the
> -stable changes don't conflict at all.

  Yep!  We don't want to merge changes from -stable
 into master (mainline).  That was a mistake in my
 description.  Again, thanks for pointing it out.

> It should actually be ideal to just merge your local changes directly=
 with
> the mainline kernel you want to end up using. But you might want to m=
erge
> first with earlier mainline kernels in order to get fewer or easier
> conflicts per step.

  Indeed.  We are progressing one release at a time.
 (I've been insisting on this!)  However, given we're
 not targeting .27 or later at this cycle, and that
 we know there are changes on .26-stable we want/need,
 it's (almost) a dead cert our next release will be
 based on some point in .26-stable (I'm using .26.8
 as a proxy as it's the latest (when I checked) tag
 on .26-stable).

  Things are in flux, and suggestions are certainly
 welcome.  Thanks for your very helpful observations.

cheers!
	-blf-

--=20
=E2=80=9CHow many surrealists does it take to   | Brian Foster
 change a lightbulb? Three. One calms   | somewhere in south of France
 the warthog, and two fill the bathtub  |   Stop E$$o (ExxonMobil)!
 with brightly-coloured machine tools.=E2=80=9D |      http://www.stope=
sso.com
