From: Lanny Ripple <lanny@spotinfluence.com>
Subject: Re: Bug: rebase when an author uses accents in name on MacOSx
Date: Thu, 31 May 2012 09:56:45 -0500
Message-ID: <938B14B8-EA46-492B-A8C1-15C5E93F22AC@spotinfluence.com>
References: <06DD2F56-F956-46DF-84A4-3443D4702CDE@spotinfluence.com> <7vehq18c82.fsf@alter.siamese.dyndns.org> <20120531011911.GC5488@sigill.intra.peff.net> <7v62bc97w1.fsf@alter.siamese.dyndns.org> <78E7FEAC-6587-4EB3-B78B-08D321F53BF9@spotinfluence.com> <87bol4ifvn.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: multipart/signed; boundary="Apple-Mail=_58D5F826-9C81-4997-AB2F-9541692C99C5"; protocol="application/pgp-signature"; micalg=pgp-sha1
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	<git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu May 31 16:56:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sa6o4-0007My-45
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 16:56:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754640Ab2EaO4v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 May 2012 10:56:51 -0400
Received: from mail-gh0-f180.google.com ([209.85.160.180]:63442 "EHLO
	mail-gh0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753452Ab2EaO4u (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2012 10:56:50 -0400
Received: by ghbz12 with SMTP id z12so1017803ghb.11
        for <git@vger.kernel.org>; Thu, 31 May 2012 07:56:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :message-id:references:to:x-mailer:x-gm-message-state;
        bh=wNSjIJpP00fmzDg5gpn+zjD39FLOUAmRZAlPOvpdYmA=;
        b=dYZ31Ewa/mkR8nua88o9OzKOn/vftF2AV3emK/MKg9l8YvmOBADfguQtBN1Htg41/W
         TjU4OkspS1aIMmU7J5y6sgbB74JKbd2sWLNjKDJ3OH3G8piDUn5zLgvRn2Pl8znw7ieD
         pJ1OInYBdaNIofFaX4FkSmgJJtT5r0t34/fD9goKYZ0TyNF1t5j7zFoEIlQp6GhC0KnQ
         J3Nog0Tw8TBDgiVpPymQZ5TcMfaSIZdZxyHOmeg6NHE5xmpCSwUtiqctbHh9BRE7ix2X
         i3gz4ondo0l4raxfhOZPihpCE6nOt6KRbQHYaxENis2zma2NIHMKmdt3ss297/tzty2b
         xKng==
Received: by 10.182.53.100 with SMTP id a4mr2410153obp.3.1338476209471;
        Thu, 31 May 2012 07:56:49 -0700 (PDT)
Received: from [192.168.1.4] (c-98-198-192-29.hsd1.tx.comcast.net. [98.198.192.29])
        by mx.google.com with ESMTPS id k8sm2059165oeh.9.2012.05.31.07.56.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 31 May 2012 07:56:48 -0700 (PDT)
In-Reply-To: <87bol4ifvn.fsf@thomas.inf.ethz.ch>
X-Mailer: Apple Mail (2.1278)
X-Gm-Message-State: ALoCoQkslCtuxwpLPTpo+Bchu8LSdctLYNAlEcBRbNv7kafr92k4sYtmsyvrcivvoOigMCxeUhqG
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198917>


--Apple-Mail=_58D5F826-9C81-4997-AB2F-9541692C99C5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=iso-8859-1

A platform sed that is broken would be worked around by recognizing the =
platform.  If the bulk of platforms are sane then fixing the path for =
the platform is the easiest solution.  If the bulk of platforms don't =
have a sane sed then not using sed is probably the solution.  If you =
want to make the path variable then a platform config file built =
automatically figuring out default paths that could be changed by the =
host's admin comes to mind (much like, oh I don't know, building a list =
of shell variables named author-script to use during rebases).

You could modify the name, email, and timestamp so they didn't have to =
be parsed.  Separate lines in the header for name, email, and date would =
work.  A length encoding of the three fields at the beginning of the =
header line or in some other (new) location if backwards compatibility =
is a concern.  There's lots of rather straight-forward technical =
solutions.

Now if what you are saying is the social cost of applying any of those =
solutions is too high that's a horse of a different color.

Anyway thanks to everyone for the clue that got me working again,
  -ljr
---
Lanny Ripple
lanny@spotinfluence.com


On May 31, 2012, at 9:28 AM, Thomas Rast wrote:

> Lanny Ripple <lanny@spotinfluence.com> writes:
>=20
>> Bingo.
>>=20
>>  lanny;~> echo "R=E9mi Leblond" | LANG=3DC LC_ALL=3DC /usr/bin/sed =
-ne 's/.*/GIT_AUTHOR_NAME=3D'\''&'\''/p'
>>  GIT_AUTHOR_NAME=3D'R=E9mi Leblond'
>>=20
>> Just occurred to me that I'm using fink and that git-am doesn't use
>> /usr/bin/sed but just sed.  My suggestion is to be explicit on the
>> path in git-am.
>=20
> Then how would you work around a platform sed that is broken?  You =
can't
> just install a new one in another directory if we use an absolute =
path.
> Which apparently is what people have to do on Solaris, see the
> SANE_TOOL_PATH setting for the Makefile.
>=20
> --=20
> Thomas Rast
> trast@{inf,student}.ethz.ch


--Apple-Mail=_58D5F826-9C81-4997-AB2F-9541692C99C5
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.17 (Darwin)

iF4EAREIAAYFAk/Hhq4ACgkQ+owW65SoXfhw+AD/f5O6aP1tU6SMsGXvVbnD3oqO
tsvH7ihXIeIPJI5GmuMA/2M/ZBYWZUzK+OhAiB+bnmjRtzFNxWMTGf7sICFaxSyh
=rppv
-----END PGP SIGNATURE-----

--Apple-Mail=_58D5F826-9C81-4997-AB2F-9541692C99C5--
