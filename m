From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: What's cooking in git.git (Dec 2015, #01; Tue, 1)
Date: Thu, 3 Dec 2015 03:02:20 +0000
Message-ID: <20151203030220.GB25412@vauxhall.crustytoothpaste.net>
References: <20151202002450.GA27994@sigill.intra.peff.net>
 <xmqq4mg05wmj.fsf@gitster.mtv.corp.google.com>
 <1449102580.14908.2.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="K8nIJk4ghYZn606h"
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Dec 03 04:02:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4KAE-0006BH-5n
	for gcvg-git-2@plane.gmane.org; Thu, 03 Dec 2015 04:02:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbbLCDC3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2015 22:02:29 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:54068 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932132AbbLCDC2 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Dec 2015 22:02:28 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:f2de:f1ff:feb8:36fd])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id E589C2808D;
	Thu,  3 Dec 2015 03:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1449111745;
	bh=AbH2a1aIT2JNrsW5IKJJ3zeOhqk1TyFQZrlvUzB9GBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pc62CdOEP+wQ0JOCH7WXSqD+0UhFWTJILvG5OwiKpyM/YgFCtqiLqJ00u9RWyOQBY
	 SX6jnQBKVvfgjtTLwnhasuQlvccrHvEXU9sWkWBMA5H8CuRj4WNaRaJBz4ISnTnMEL
	 LK0m4pj0oNwBhE/j975Y9bpb79f8d0Ctk9swF/Fm/yOx7bEOCwVpaxn1wi3wNB8FZP
	 0SCBFpFC0NHJj/eOWuErgCEPW8GO4Ug9bidMhN5LH5aiMHju7XL8gD8UwMbfpWFEEh
	 Nc6XZ7Fob+5WbgPkyjo29a+xH6uD1TSkZG2/0f1DCmmUGqyK9GjmPklNN3auubPaXH
	 2I4wkRP0ALZZLhJWoVZ5daH+MXY5qB8DgqnpvHBIVIssN8nuP3klTBJekL6iBboviP
	 McDc3YrzbHBYNvdqtndGmGMlw9EAVUvZiKfgphxl/21f9cGZxHslpempxAQB93lVET
	 N2Yt7/2JVMLnqev8Nj+xe7J+8f/1u3/dR6bTs7rDG2x6dAsKEns
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1449102580.14908.2.camel@twopensource.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.2.0-1-amd64)
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Score: -0.262 BAYES_00,RDNS_NONE,T_DKIM_INVALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281943>


--K8nIJk4ghYZn606h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 02, 2015 at 07:29:40PM -0500, David Turner wrote:
> From a selfish perspective, I, would prefer for object-ids to not happen
> quite yet for the refs code.  I have already prepared (but not yet sent)
> a new version of the refs backend vtable (and lmdb) code on top of
> refs-backend-pre-vtable, and it'll be a hassle to reroll it on top of
> new object-id stuff.
>=20
> I guess I'll go ahead and send mine now, and we can later make a
> decision about how to deal with the object-id stuff.

As Jeff pointed out, the patches to refs.c were mostly dropped, as the
code that they modified had been removed.  The likelihood of conflict is
therefore low unless you're using struct object a lot.

My preference is that new code use object_id where possible, because
otherwise I'm going to have to go through it later and fix it up.
Keeping in mind that the refs code is likely to undergo a lot of
changes, I'll try to keep away from it for now, but it will need to be
converted at some point.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--K8nIJk4ghYZn606h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.9 (GNU/Linux)

iQIcBAEBCgAGBQJWX7C8AAoJEL9TXYEfUvaL8qoQAM2GMz/MSpRDPQfBhM1Grdl/
zSw1Rc7d0+f+O1bOkd058hARh01stDo+hOF4P1QYq0lK+40PmmFf5IFA+Z+Youv7
JLbqSM9KDuLcm6UUjobhfkhLg3HQ7ygueq73zFPaWk6Ms/jYZP6Y1blVCzwsorLC
focla98UrePYoRCy6ZG3itSkppuBD4Z5aXfly2aEcxvvxgQ4xI5wfr37PNo36xFK
Zo/yUxd9c7TZyq6qCX7o/kE/tYudst4sXWSKqnN2DbptxlP9pJgbXdaVsU2ea/a2
B32MzYjHbiUeKuSGw6LTtBpVVko1e56i0WY9/bDCxIByOwh+yOOgh7sc/KpCFCor
bTrEusydiNE243F4n62HCtki1AgqZ9vBDDlgMpoVK7txPwqy2wDKH+drh5E/cMYs
wSu+IrM/zdfoindRACk1qYOCpMdafcUP8a72lAmmIWw2hp+/h1W2lr52fd9m+AO9
W95fyi5mAuAXFPABlybkdBMTYFZNg5DlYcFHkyJfSukyBB+s+fbdb4X4HnOp34lx
WE0R8HHjctCocxFFUn1oZmJy/RPbjDwK04X0q66JMBrFMaDp+tTGqGru1nsyezJZ
lNbvZcm8IzPRdTdwQOtFcrSQxErKyH0FMgglk8UjMvljE/dy8b5nwrylIwrs/NAc
t1/XKSYQ/zzu4G0dfBJp
=CAow
-----END PGP SIGNATURE-----

--K8nIJk4ghYZn606h--
