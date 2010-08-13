From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] hash binary sha1 into patch id
Date: Fri, 13 Aug 2010 23:58:01 +0200
Message-ID: <20100813215801.GA24534@localhost>
References: <20100813094027.GA20906@localhost>
 <20100813200031.GD2003@burratino>
 <20100813212331.GA24127@localhost>
 <20100813213726.GB2516@burratino>
Reply-To: Clemens Buchacher <drizzd@aon.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Cc: git@vger.kernel.org, Marat Radchenko <marat@slonopotamus.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 13 23:58:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ok2GU-00038r-7U
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 23:58:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754090Ab0HMV6I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Aug 2010 17:58:08 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:57586 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753911Ab0HMV6G (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Aug 2010 17:58:06 -0400
Received: by eyg5 with SMTP id 5so516115eyg.19
        for <git@vger.kernel.org>; Fri, 13 Aug 2010 14:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:reply-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=52uP8RLGMKjVGZyryjI60piWPPpMT2K+Uin66GdXzq0=;
        b=kG3OgRjWR8fhuhWqfmjOd2R7T72OCSbYrG1z2EAmnDbwVCsEl5MV85Goj/GgGuwbec
         z4JptY4SJFfepLFyRxoO4xCUrAVEMvgFL5gEdUtEyYeYR2lWDDP7rkRqXoxW8bshxGHn
         Ky9Vupv43S+Wh+zb2/BfbPIKf5REP/i3kkhU8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=NvGtxcArYRDgINMZUcwt3QDTlKixPMfanvkUl6oe93VyGXm4LgjjQo33wqsNdkYq6O
         pV6vyxeI2ksKTyzaekx8GYwmJbKlJWEQ2XPUfhXUCxcy40GhBF+ELeSk2ANTNvb6r329
         kG09QVIYA2JkdpXCwvA8EhdNbwAHujfS4RBlk=
Received: by 10.213.19.67 with SMTP id z3mr1138759eba.87.1281736685657;
        Fri, 13 Aug 2010 14:58:05 -0700 (PDT)
Received: from darc.lan ([80.123.242.182])
        by mx.google.com with ESMTPS id a48sm5011893eei.1.2010.08.13.14.58.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 13 Aug 2010 14:58:04 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1Ok2GH-0006OV-It; Fri, 13 Aug 2010 23:58:01 +0200
Content-Disposition: inline
In-Reply-To: <20100813213726.GB2516@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153516>


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 13, 2010 at 04:37:26PM -0500, Jonathan Nieder wrote:
>=20
> FWIW what I was imagining was some structured binary format:
>=20
> With A some long string, patch 1:
>=20
>  A  --> AAA
>=20
> Patch 2:
>=20
>  AA --> AAA
>=20
> Ideally one would want an attempt to apply patch 2 to result in a
> conflict.  Probably that is far-fetched.

Actually, rebase will try to merge the respective branches and it
will typically succeed, because the post-images are the same. It
will fail due to conflict only if yet another patch has been
applied upstream on top of patch 1.

But that is also how textual changes behave. So for the sake of
consistency, it makes sense to require the pre-images to be the
same. I will resend an appropriate patch tomorrow.

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMZb/pAAoJELKdZexG8uqMKCEIAIZJpu8wXmTIRpU9p+TbNqvZ
r0mP2jExTmGbgJd6f22brLRXgEqouHj8WPn93OHz2KiqJBMAH8/TEz7nv+lqEzH+
4X/6A6U1HhS30W9Ipzrz5uJfuunsPto/rUR9pVb9jR5S/ncTU9FiCqlb90XuHLBt
mFPx+vP5BvUuvivzJGqw6EMNgcLWvRBnoHUH7WsgqoSjAkMebZzynPFoSRY6h0I+
m6/arX2VpzDboHXNM4gIo8pNItfX40L2ipPE423s0P8u1sFEkqKK+WMc9u2ykYgj
Dn8r67tbbPC88zlLZ+8zlFmXzCgQcihAuafjt8P7RNFlmnvhnBNhEope62LhDh8=
=KcP9
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
