From: Robert David <robert.david.public@gmail.com>
Subject: Re: GSOC idea: build in scripts and cleanups
Date: Mon, 28 Mar 2011 10:55:22 +0200
Organization: DDM Praha
Message-ID: <201103281055.23578.robert.david.public@gmail.com>
References: <201103260141.20798.robert.david.public@gmail.com> <20110326021435.GA2352@elie> <20110326133939.GB2859@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart10413659.b6ifYWBI83";
  protocol="application/pgp-signature";
  micalg=pgp-sha256
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 28 10:55:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q48Eg-0007ML-7e
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 10:55:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753661Ab1C1Iza (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 04:55:30 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:52466 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753642Ab1C1Iz2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 04:55:28 -0400
Received: by fxm17 with SMTP id 17so2451836fxm.19
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 01:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:organization:to:subject:date:user-agent:cc
         :references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=NNGWLpCasVy+kOJZSBwYW2hnTR4vOua7vHrxc7zvDhY=;
        b=dhseRf8vUsfnEk/R3GpHzhz8w1qVUekmxXwN+4FS1nO8JbzlKldUajZHyq/7PSWeQa
         3aj8YwDcbE29Mr4lZnKKZLEh0WPPwUfvzZl6bv2cl9l+RrqDvKiycuob6stLcnT45qx9
         xTrkwkJxIjryNWrcinasRt1NpMu9G55wIl4mc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=IvyPyTOgINzqeIkrAeUrbo5N2fe0bszGlfskoqKb2bY+Xh4sMzocxzEb3spf1rLQRe
         P3lhIC5K0ddnxNML+ESf5FlK8fyX07PS/53dC1dAuZkaB9AxJmOEa2l7a5c7PtfDvgVc
         aBH3hI7xGMM2Mn3Iisp2n7yl+oAjUyxzcopDc=
Received: by 10.223.86.2 with SMTP id q2mr4135470fal.120.1301302527602;
        Mon, 28 Mar 2011 01:55:27 -0700 (PDT)
Received: from robert-eee.localnet (gate.chabry.cz [80.92.246.13])
        by mx.google.com with ESMTPS id n1sm1359562fam.40.2011.03.28.01.55.25
        (version=SSLv3 cipher=OTHER);
        Mon, 28 Mar 2011 01:55:25 -0700 (PDT)
User-Agent: KMail/1.13.5 (Linux/2.6.32-5-686; KDE/4.4.5; i686; ; )
In-Reply-To: <20110326133939.GB2859@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170112>

--nextPart10413659.b6ifYWBI83
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Dne sobota 26 b=C5=99ezna 2011 14:39:39 Jeff King napsal(a):
> On Fri, Mar 25, 2011 at 09:14:35PM -0500, Jonathan Nieder wrote:
> > > I was also thinking if there isn't PERL a better choice in rewriting
> > > shell scripts, due to planed porting (android, etc). Better than C.
> > > But I don't know android and other platform so much, so thats why I'm
> > > asking.
> >=20
> > So far (on Windows and various Unixen) it seems that C is much easier
> > to work with as far as porting goes.[2]
>=20
> If I were considering cleaning up and porting add--interactive to C, I
> think I would probably start with just porting the "-p" patch loop
> first. I think it's the part that most people use, and most callers
> don't support a generic "-i" but just the "-p" interface (e.g., you can
> do "git add -i" or "git add -p", but only "git checkout -p"). And that
> cuts down the size of the task somewhat.

I have read all the code in git-add--interactive. If I understand that=20
correct, you mean to separate -i and -p int two different commands.
And make the -p option more like the -i (but just only for patching).

And consequently port them to C.=20

>=20
> As far as cleanup versus features, I think Thomas would have to comment
> on that. He is the one who did the most work on patch-mode, and
> therefore the one who most thinks it needs cleaned up. :)
>=20

Is Thomas going to be a mentor in this task?

Robert David.


> > [1] Android is an odd example because the platform uses Java heavily
> > (so JGit might be a better fit for it).  Perhaps the wish for android
> > support should have been put on the Eclipse ideas page[2] and a link
> > added to git's; I dunno.
>=20
> Yeah, I'm not sure what an Android port would quite look like. In theory
> I could probably build stock git for my rooted N1 using a
> cross-compiler. But I can't imagine what I would use it for. A native
> app seems like it would be more useful, and that pretty much requires
> Java.
>=20
> -Peff

--nextPart10413659.b6ifYWBI83
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iF4EABEIAAYFAk2QTPsACgkQLSNWchw0XGxhBAEAjNpLygHlNudO773qCIaiNeXC
d0D9rimQSPCSEgIDIzQA/1Ru2+mMH6b6cPK85jL77JBJwtp9KrkdzdFKAyopIwc+
=7xv0
-----END PGP SIGNATURE-----

--nextPart10413659.b6ifYWBI83--
