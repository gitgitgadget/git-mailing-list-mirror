From: Caleb Thompson <cjaysson@gmail.com>
Subject: Re: [PATCH v3 5/5] commit: support commit.verbose and --no-verbose
Date: Mon, 26 May 2014 15:47:14 -0500
Message-ID: <20140526204714.GA96869@sirius.att.net>
References: <20140525062427.GA94219@sirius.att.net>
 <1401130586-93105-1-git-send-email-caleb@calebthompson.io>
 <1401130586-93105-6-git-send-email-caleb@calebthompson.io>
 <20140526203304.GA11888@hudson.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Cc: git@vger.kernel.org
To: Jeremiah Mahler <jmmahler@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 26 22:47:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wp1nl-0001to-Qm
	for gcvg-git-2@plane.gmane.org; Mon, 26 May 2014 22:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412AbaEZUrS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2014 16:47:18 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:37509 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751218AbaEZUrR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2014 16:47:17 -0400
Received: by mail-ig0-f171.google.com with SMTP id c1so339694igq.10
        for <git@vger.kernel.org>; Mon, 26 May 2014 13:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=SLOGiD/DqlaZ53lJ7n/6Qr9BXl2LpIbqkUxQPwqfT88=;
        b=S6vz5WM7TG7tz1utxeht5HfgN28/J9CWge0L4EPLuUBmcvXGyhEIwAXClNZRIv/Pg3
         rTQ2RI7mDtW6FByYKLj8pi62yeMe51NoExKBimguyKwWqRrpP/6VYe/8TLwmc4Aotr0E
         kTKebAFwmiGMoBZJOWOaj3pZlrLqbmSeNKNpWjaxLOdd09je+g8hLqStRNOXZMCz6KvN
         MF3mW13z6Cc9GYHg5hPJn4ReIdswcrzR/RWElyKzj7huqHT+CLpIohK/4S3fgq+kpy5p
         FOybYNgSbOGAntNJWHa/WLpQY/iNN5b84BYftra5TRLCH6iHAOJKuIsA1FzzERwGHH14
         PXVQ==
X-Received: by 10.50.20.137 with SMTP id n9mr17319903ige.15.1401137236646;
        Mon, 26 May 2014 13:47:16 -0700 (PDT)
Received: from localhost ([2602:306:bd82:c710:189c:3425:edac:f018])
        by mx.google.com with ESMTPSA id ng14sm2348928igb.13.2014.05.26.13.47.15
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 26 May 2014 13:47:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140526203304.GA11888@hudson.localdomain>
X-PGP-Key: fp="B432 C068 2FD1 C2D0 6A8B 3951 1621 ADC2 A0AC E70A";
 id="0xA0ACE70A"; get=<http://calebthompson.io/pubkey.asc>;
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250122>


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The editors, `check-for-diff` and `check-for-no-diffs`, are grepping for the
output and lack thereof, respectively.

On Mon, May 26, 2014 at 01:33:04PM -0700, Jeremiah Mahler wrote:
> j
> On Mon, May 26, 2014 at 01:56:26PM -0500, Caleb Thompson wrote:
> > Add a new configuration variable commit.verbose to implicitly pass
> > =20
> ...
> > +test_expect_success 'commit shows verbose diff with set commit.verbose=
=3Dtrue' '
> > +	echo morecontent >>file &&
> > +	git add file &&
> > +	test_config commit.verbose true &&
> > +	test_set_editor "$(pwd)/check-for-diff" &&
> > +	git commit --amend
> > +'
> > +
> > +test_expect_success 'commit --verbose overrides verbose=3Dfalse' '
> > +	echo evenmorecontent >>file &&
> > +	git add file &&
> > +	test_config commit.verbose false  &&
> > +	test_set_editor "$(pwd)/check-for-diff" &&
> > +	git commit --amend --verbose
> > +'
> > +
> > +test_expect_success 'commit does not show verbose diff with commit.ver=
bose=3Dfalse' '
> > +	echo evenmorecontent >>file &&
> > +	git add file &&
> > +	test_config commit.verbose false &&
> > +	test_set_editor "$(pwd)/check-for-no-diff" &&
> > +	git commit --amend
> > +'
> > +
> > +test_expect_success 'commit --no-verbose overrides commit.verbose=3Dtr=
ue' '
> > +	echo evenmorecontent >>file &&
> > +	git add file &&
> > +	test_config commit.verbose true &&
> > +	test_set_editor "$(pwd)/check-for-no-diff" &&
> > +	git commit --amend --no-verbose
> > +'
> > +
> ...
> >=20
>=20
> It appears that these tests still aren't checking to see if the
> "verbose" output appears in the commit message.
>=20
> --=20
> Jeremiah Mahler
> jmmahler@gmail.com
> http://github.com/jmahler

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJTg6hSAAoJEBYhrcKgrOcK1tcIAIUV6+s3xYVSxPXHmyhZpipQ
34fpRpAzbuIFvR6dXNwXdOBjmdNFS9ICCFb9BeodNafynTWoZ9JW3u7Suk/LNFFA
qAkf3T7QbcL7iYfIYD/N3NsPbosikx7iw8ThYkhMiYH1nN6jN73rkOwGF+z+LGeg
2jslj2xftVS4z0jahiqgpspXYdDpDBXT4mJzVeswqaEOwWL1FcK59qBDQr8O6Eq8
aUJtW74KRYmJXRtyUSD03vR1pbrqbEY3JlxVU5NMIy4TWaMST6qi+EFU8G8GSvFW
enWgfuUdjPYVwJKYydlQgeQQAIH/GdLXDRrRlV0+O/wsgB9ZCgWzCZeZWWSHVMA=
=hb+7
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
