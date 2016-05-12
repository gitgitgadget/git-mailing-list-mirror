From: Joey Hess <id@joeyh.name>
Subject: Re: proposal for extending smudge/clean filters with raw file access
Date: Thu, 12 May 2016 17:17:52 -0400
Message-ID: <20160512211752.GB10786@kitenet.net>
References: <20160512182432.GA27427@kitenet.net>
 <xmqq7fezdoe7.fsf@gitster.mtv.corp.google.com>
 <20160512204634.GA9292@kitenet.net>
 <xmqqy47fc7y7.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EuxKj2iCbKjpUGkD"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 12 23:18:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0xzj-0003w9-KN
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 23:18:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751970AbcELVSD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 17:18:03 -0400
Received: from kitenet.net ([66.228.36.95]:46402 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751330AbcELVSC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 17:18:02 -0400
X-Question: 42
Authentication-Results: kitenet.net;
	dkim=pass (1024-bit key; unprotected) header.d=joeyh.name header.i=@joeyh.name header.b=WN1NcAoX;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
	t=1463087872; bh=krcQlvumI4Kt+tURjglm000hnzHhjyJfdurO6ic50Ro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WN1NcAoXFmbSqcLwac7QveXfOb3wvCUdz/ZY7sLZZ4kZL0ddEgepJhpWJ2BVoc63G
	 K5Qq7/HIIA2BmhSasA+8VHMQkQu7qR+vv2U2iwooEDP451kBj4OuAgiKfjxNG5bxeB
	 kVSrUVWlQU/+8dGU7ohulQMeZPQPrlXxlPqdYVlM=
Content-Disposition: inline
In-Reply-To: <xmqqy47fc7y7.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-Spam-Status: No, score=-95.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_PBL,RCVD_IN_SORBS_DUL,
	RDNS_DYNAMIC,SPF_SOFTFAIL,USER_IN_WHITELIST autolearn=no autolearn_force=no
	version=3.4.1
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on kite.kitenet.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294480>


--EuxKj2iCbKjpUGkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Junio C Hamano wrote:
> > Secondly, and harder to get around, the filename passed to the clean
> > filter is not necessarily a path to the actual existing file that is
> > being cleaned.
>=20
> Either one of us is confused.  I was talking about updating the
> current "clean" implementation without changing its interface,
> i.e. gets fed via its standard input, expected to respond to its
> standard output.  There is no filename involved.

I'm talking about the %f that can be passed to the clean filter.
The context that I left out is that my clean filter could avoid reading
all of stdin, and quickly produce the cleaned result, but only if it
can examine the file that's being cleaned. Which is not currently
entirely safe to use the %f for.

There may be a way to make a clean filter that can do something useful
without reading all of stdin, and without examining the file that's
being cleaned. Maybe. Hard to see how. I don't feel such a hypothetical
clean filter is worth changing the current EPIPE behavior to support.

So I think it's better to add a separate clean-from-fs and keep the
current clean filter interface as it stands.

--=20
see shy jo

--EuxKj2iCbKjpUGkD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBVzTzAMkQ2SIlEuPHAQKZhw/+Kkac811yFDx3POwE3ZfpeV3LejU/t5lY
Bok4V/zWrL5R1TtSSdK6xyDLvtR1oGIMYjnJYm/fv02qzDzwpQWqpH1LlsS3FdKn
u+MxPlVRPaS2rNxQGAWY390qOfIa11ybtIZBXWgYw+ih6aJWCDDTKWbuAI3PXRbn
CgX7ssrcbeUIuk5V1rAHZkRw7Hc7gu8eaMkfFCfbtWvjvZQJpvhrIW+Z+JOn27TM
4wudsYaS47ktd2p/Pqp+KelGSSbPwYRqy20zdN8N/yHRH8szGMjg1JRLD9lWjQTk
WPcI5/+m/yTJ0uPzsQ5AEQ81CAl5XlL9n3E0qtxCdi5Fi66RONQffO4gvcXtwK3+
f1nnRnFnG2UE0QFT6NJfsIlV1FNNI96gKkVGu+zMSmzefmFQ7IGPL8t2uZY1QsX2
MHF/vlyGn2NI/go1tfmExuNM1DIkzTU7ROuDjDHA2IfNVeuLxf53TmfL3Cw51CAj
5hIwEU6CEOFTCv4m/NdMBasN3EfRP2E1XSA9jjMIOZihU9O6ccC6CE/ntOJrTzXP
xgkuOLsYnPsKH92LQXUjD5gUw7+osVobzYCUdMPBL3Cn+nKAZiQgJzNd6lE2t5QK
XkNwWge/NeQoNNhyPdo1FWky0NG7V+NBFm6fKsHe2fRP7x/050WEfO9FV7HY3k9N
QvinUaWvOl0=
=7O3Z
-----END PGP SIGNATURE-----

--EuxKj2iCbKjpUGkD--
