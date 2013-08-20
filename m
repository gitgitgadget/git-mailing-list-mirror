From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCH 0/2] git-config and large integers
Date: Wed, 21 Aug 2013 00:44:22 +0200
Message-ID: <5213F146.1010509@googlemail.com>
References: <20130820223953.GA3429@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigFC6F4327790DC9D64723B85D"
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 21 00:44:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBuf3-00056L-Oh
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 00:44:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428Ab3HTWoW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 18:44:22 -0400
Received: from mail-ea0-f182.google.com ([209.85.215.182]:59965 "EHLO
	mail-ea0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987Ab3HTWoV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 18:44:21 -0400
Received: by mail-ea0-f182.google.com with SMTP id o10so483726eaj.27
        for <git@vger.kernel.org>; Tue, 20 Aug 2013 15:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type;
        bh=f1+Wbog/KS5nAvnFrv1jrRzAB5Kf97cz2wJP3kvjX4Y=;
        b=XL3G6ql1gMH6Y2h1/W4/225yvRET+bqUCHvwBY0J9ADa8lLeL6PAPiXWDVHdJ8M3xn
         Ichqqf/mHEsCHTsP1dnplI85aUW0RpK2s3WKzGp7yDRhJaWW36S1wJgemKIPJbduHba/
         YwdLLAnIqXtWc1trmYPvjNIJ4sStQzUSCC46hUccy6I+nV3mAYtvFMlQ+JTXAaqTWceq
         hXWzwqg036DcO1fZR3Byy16VQGEUUlQRf7Yo3NClDp7bQG92kH3HlIpd68mlgzD+0MnO
         VPhGGRKCSiktMKsizvQocVst3n5REpQcupFRHuWkgg+E7yDGfm9HGGrVxSniZr/LutWI
         RfXA==
X-Received: by 10.14.107.68 with SMTP id n44mr5019291eeg.26.1377038660484;
        Tue, 20 Aug 2013 15:44:20 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id t6sm5253287eel.12.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 20 Aug 2013 15:44:19 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
In-Reply-To: <20130820223953.GA3429@sigill.intra.peff.net>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232661>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFC6F4327790DC9D64723B85D
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/21/2013 12:39 AM, Jeff King wrote:
> I was playing with a hook for file size limits that wanted to store the=

> limit in git-config. It turns out we don't do a very good job of big
> integers:
>=20
>   $ git config foo.size 2g
>   $ git config --int foo.size
>   -2147483648
>=20
> Oops. After this series, we properly notice the error:
>=20
>   $ git config --int foo.size
>   fatal: bad config value for 'foo.size' in .git/config
>=20
> and even better, provide a way to access large values:
>=20
>   $ git config --ulong foo.size
>   2147483648
>=20

int, ulong...
How large will those be, I'd guess they are machine dependent?
So int being 32 bits as usual, but not on all machines.
(Those, which don't have 32 bits, are maybe not relevant anyways?)

Stefan




--------------enigFC6F4327790DC9D64723B85D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJSE/FGAAoJEJQCPTzLflhqL/0QAOMw/oznOkNGsBjOO9VoyMrp
BUG/vefcqQfyEJrlpeSPsSGfn8NWWMK5OTpCJNfE7ZQ7UDNYXsS3vxYYWGPfWMsb
0+NC8XUTzzsbK8lEtWfChtbxHcQMF1yceNI51eOhwFE2P/aSsq+1J2OTT3DiC2bd
LTYFxm7yhpw70SrEvCcp3ZA1f5vEO6ISWXgo1QJS6ZLBvrk6g1765IDEVs0iyYQt
njAPmN7HMB9gCdwZO5kfEb+RnyDBh/hgANE8hjSwuKOU7ZVbEpmxgZnnzf4Pqbv0
INV9L4lDK0gqsBdRcvO9yUVxIMvd6f0OaNpnaQWxKJ5+Z2w3o3r9PGyttPmtcIBe
T6TQgNdtwUk2IlSLfgjw+v9wzy4Slo5jHZPapcsZC/PsSsWMdOOjhs2LyxiC6Ym5
nx+ZDFo2ZWKkZMSCPlDzsnHeeo1i8LQPPHzT6ARh3gkNF+s5u4AqO9oZXFNy9z8C
cEAnU3bqcXf3g7RaNEJp0X83UpLQEWY3oTrYm8v8dmqiFsj6UZFsEeWykvcMzJDG
2JAHwVEA4Htlx7gUNmdVC3tCQah4eJOxP6InTD21cqHT6qPP8RJfWhZUK6rplmrS
MfqbKVVakAYAk3eTizWxj5sGLZMarE+a8RaEQpfWNO68rdPHAmIxMycB55TpcQDK
cDhjQLJnYVX9Yb/BOME0
=oLMl
-----END PGP SIGNATURE-----

--------------enigFC6F4327790DC9D64723B85D--
