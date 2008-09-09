From: Marcus Griep <marcus@griep.us>
Subject: Re: [PATCH v2] Git.pm: Use File::Temp->tempfile instead of ->new
Date: Tue, 09 Sep 2008 13:55:18 -0400
Message-ID: <48C6B886.7020108@griep.us>
References: <1220889063-20387-1-git-send-email-marcus@griep.us> <1220892781-24343-1-git-send-email-marcus@griep.us> <48C628AA.4020100@statsbiblioteket.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2EF733AAF66DA12760C70BC5"
Cc: Git Mailing List <git@vger.kernel.org>,
	Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>,
	Abhijit Menon-Sen <ams@toroid.org>
To: "Tom G. Christensen" <tgc@statsbiblioteket.dk>
X-From: git-owner@vger.kernel.org Tue Sep 09 19:56:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kd7SI-0005OC-4V
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 19:56:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754535AbYIIRzj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 13:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754549AbYIIRzj
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 13:55:39 -0400
Received: from wx-out-0506.google.com ([66.249.82.229]:41505 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754390AbYIIRzi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 13:55:38 -0400
Received: by wx-out-0506.google.com with SMTP id h27so631985wxd.4
        for <git@vger.kernel.org>; Tue, 09 Sep 2008 10:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:sender;
        bh=pWo/OFUBriltLXcmcC2AXAPyEoauYpQCT9GMn719v5M=;
        b=pKKEEWMgO+dTuSeSInsSxFkz2iU0Dz5kzAiqV11lm4azzZfLuTCDaVEaH73sUblSoZ
         uq14TuStl4DXPx7ecb+lCmpU3nk01JGpJt2EbSP3ZYgTTzLu6NAb4MM0gUrLzFRZcNaL
         uSqLRTjyJICL4909AkvdCom/3D5AOFlUyzSK8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type:sender;
        b=aUzITSIkO8ufuWoocoY0uPv3edpNaStX3kcvmccNzTjbQbWnuyGpbv2CDy7sLFweMC
         e5Cc3Q/PE7VGZ8IGSY0K0z4ZjhlQSvrwYe/Uv7XVJUhpbxbffbJdcemwxGdmsISe99YG
         TpXbQFoyVABFKwUxzxUQYzs3pHuzX7XMGSoHQ=
Received: by 10.70.40.1 with SMTP id n1mr32482wxn.5.1220982932793;
        Tue, 09 Sep 2008 10:55:32 -0700 (PDT)
Received: from ?10.95.36.106? ( [4.79.245.132])
        by mx.google.com with ESMTPS id i16sm5085948wxd.27.2008.09.09.10.55.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Sep 2008 10:55:32 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <48C628AA.4020100@statsbiblioteket.dk>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95412>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2EF733AAF66DA12760C70BC5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Tom G. Christensen wrote:
> The testsuite now passes t9100-git-svn-basic.sh and instead fails at
> t9108-git-svn-glob.sh but this appears to be unrelated to the File::Tem=
p
> issue.
>=20
> --- expect.three        2008-09-09 07:34:39.000000000 +0000
> +++ stderr.three        2008-09-09 07:34:42.000000000 +0000
> @@ -1,2 +1,3 @@
> +Parentheses missing around "my" list at
> /home/tgc/projects/git/t/../git-svn line 4429.
>  Only one set of wildcard directories (e.g. '*' or '*/*/*') is
> supported: 'branches/*/t/*'
>=20
> * FAIL 3: test disallow multi-globs

It's probably another back-portability issue (It's not failing in my test=
suite).
However, I think that I know the offending line.  Can you give me the tex=
t of
your line 4429 in git-svn and I'll submit a separate patch to fix that ba=
ck
portability issue.

--=20
Marcus Griep
GPG Key ID: 0x5E968152
=E2=80=94=E2=80=94
http://www.boohaunt.net
=D7=90=D7=AA.=CF=88=CE=BF=C2=B4


--------------enig2EF733AAF66DA12760C70BC5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIVAwUBSMa4kQPFruyc22R/AQLyKQ/6AswLDnanHBcShPlMo+4IdnwKqaGfx2ac
zSSZqqbvUrO+LQJ2A5nleMsWwxbic2A/DiPWgcJjnWRu0Afd0tCjnJU6Uz9D/wSy
6dWyM3aYvECH+J2axKphu9HWijPRomuWDZLRv4PZcMzb50yKBXTrfz4ti8EUow04
lssmXGJFkXg/C2ULqxW1VV9nUfBe5l8yN2yK7nTCWykLVJJFBVnC37OE4/9QAqRm
hmUlaj4GZTwTPEUX7mfWvha0HtrD9dBoqq3oYTrpyK/ZvArkLP6MEfzHmQn6VjNR
Tdy8tace6ZJYYHjs9NPY8iR029wNLkYnc/AQAosv2TiOcuLbQGaGpbZ88K0yf0NN
msbB+DpM0kZVQySx3tEG33SdUnKz5PGAZ+vvev/NkjFkJ+3PccFjbmtLx7XzVbTD
b0cLKJSQ6rw/ND+ilcJ2gOnzbiMMviVdv1NWX7DIPsWT1rkQg4dGNEVCjqtcJUpI
yOOZW76b8wIQf5Xue+L2WvnoslKgBhbhXJoEKh6eeOyKnl2iavw98XARyLuTi+CK
KjYkOEVk3DJZ+qJe6kGebCCimMqLOjbGaNkfTgJJs6MREt9tQxcMaAzeyuXkvNKA
wU+PBTRiWaPyG1MJK+pmyusPkqSMDWIF2HawfUe3H2xV8Z7PeLCu8RAnGQh8fE2+
2++iEhpNY9A=
=K4Qt
-----END PGP SIGNATURE-----

--------------enig2EF733AAF66DA12760C70BC5--
