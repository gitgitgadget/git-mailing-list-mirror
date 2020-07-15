Return-Path: <SRS0=3l3d=A2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1025DC433E1
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 19:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3D1C20657
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 19:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="X19Ul/vq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgGOTmY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jul 2020 15:42:24 -0400
Received: from mout.gmx.net ([212.227.15.18]:39899 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726661AbgGOTmX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jul 2020 15:42:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1594842129;
        bh=oQ4/3bCqM/GFg1wCTVBVDI36NRTuCj+FWZn9rI2TY/0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=X19Ul/vqJdy4Gf3kE6+C7nyzhrUQvlvpY4cQPLxyZrJdVL5TxjtYtmN44CQBREM6Z
         jSy2x0QEHW6Aj0VEamQ3TnGx1AT0hOflBnmeaTF3uPenE7EnqJehmp84DXb1FPHZso
         XvsxtbAngtIKXtcMb08nCZzYmAm6BH54QbdKQOFQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.94.224] ([213.196.212.204]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MUowV-1kLstk1jVp-00QiVk; Wed, 15
 Jul 2020 21:42:09 +0200
Date:   Wed, 15 Jul 2020 21:42:10 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 31/39] bundle: add new version for use with SHA-256
In-Reply-To: <20200713155617.GF11341@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.2007152141160.52@tvgsbejvaqbjf.bet>
References: <20200713024909.3714837-1-sandals@crustytoothpaste.net> <20200713024909.3714837-32-sandals@crustytoothpaste.net> <20200713155617.GF11341@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2102947002-1594842131=:52"
X-Provags-ID: V03:K1:XCi+2GEPum++2ousyh1/hsTkm0YZLRYciHDaHjvSmbDUcUT+bZb
 1p46f/VNmt7XXSRSK+JM4KPTiSS0gi9oAJ8Gr6Fe37UzE4i6Xu6zSP+5m3cXnA6z5IrZBhn
 51lDZMig9vn2SjAvaTDlnDmh0gri2TR3GPrHexvpacvbpgTKdhOSVlLI88hUeCj7fcYm7uD
 UHIHTASOpV45n2xJxG6dQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WKZnhEmnfLo=:Nr2L+Z0lPIX6f/3Y6h9HJM
 I+tQqTj4tNEy8kGpVSw3jcZG1u1e55iCpPxsnZ8UOuFFxQgpsIvbklvKhLJnfVR5kS7keAVM5
 ShE4+DGEo/67yIQlusvcxH+c9mjkaR3aLsjmaKw2QqU9VfUhGIxQZOdOrzLGFUxFOCh8t+/nD
 l/1TlNt1UfTl/lrcGQVWfOOp0Z5ZAyuO1n9wFBmZYlT9l+SEW9um6WMRofSF5Vp00TdcheDs4
 qvBEydQthuNQvGyXIwHW2QgmpBtN6HprtqInXg0ylt6B7gsCpZiGT1A0V2+J6d6e6s7/w+dBd
 oc9vbbTTPlshJrNzpOyTFBxirh9MJDa6Pp9EUy4NAEZ6TV2xYGxNJX9edzeqkV6O0DqkWIKYR
 y5n+mITLt8ut6bVpdX1q8BFQHCqCr0MYgJYcCWUud/rsfbajgFj3KsFa4dX15D+ApjQ0Uvo2g
 yDVjxPPzY7u9VZcqPgYB1goLApqoUNuNkbf0XMOV7xlJ+ISUqsR5jEKYlI02vY9LL4drFPSOH
 ck4WUwFSUy2MG1sEbMl7hKx/Xbt0zE1Eb+WcrHYi7XvjctM0vRY/ElTLpl5ItBHYsRtwi9R9u
 23JQgy36IfN3Wy7fEoeKDR0fhtqKFY6pRcinwqLjuieYbGgGYToIm3Lk2/dpXeXXDNWSttr3u
 KZQbopwSpghFeCWMjp/04mXxJddEmrA8gZ4pOppwevbngyBOQNc1eMufY/3zzjFH918pQJ3B0
 GsTyN5xvS9tf0hrOMKMm+TPJGv4P2trs1sHNEDIzwkSpiJWTGt5BGyVGDRX7TcJtzHD9Ww+m9
 cgrtKfezgDgpfCR2bLEXnq7wWag2DkoDArfThVjVXP67q+FO98ppwaaWhuyxRLH04cPVobWnV
 9VMlG1LMgNk3+m+YDQWxotdmBtmwfvLNf0hVlXwQJpNBjPlDjZJLCrAoZJRzINaT1Y5sPWMYP
 NTvfQoaIY4T9Vnh+7X7UoPEypQjpFRh8BIiKiSyFD7TlAV9VnWMS90iWI/gW2AWk5tGfKY3HN
 t5LxfQWjiyGJcynU0cR5ANyK/QOO+VK17ZIQ8qswLyEgHTa6PDPdwufn7OUG15Cxsf/oPgu2p
 RU4GOippdk5zahAmDxbC2ufHHq51kxV/EaspFJzGgPX9VstXHVqXw62G8yd3UCVqe8f+lFXlp
 +KzumYe3j2SxZ4sIHCl1UTxU07QDLeRBmk3lr7dLiGModD3PZdD3vEtZZdo7oYGEkIB75f4Ow
 NsqXXHYt5jT9jFIs8a7KGwa+o44MSA6skvIOm2A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2102947002-1594842131=:52
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, 13 Jul 2020, SZEDER G=C3=A1bor wrote:

> On Mon, Jul 13, 2020 at 02:49:01AM +0000, brian m. carlson wrote:
> > @@ -23,17 +24,20 @@ static void add_to_ref_list(const struct object_id=
 *oid, const char *name,
> >  	list->nr++;
> >  }
> >
> > -static const struct git_hash_algo *detect_hash_algo(struct strbuf *bu=
f)
> > +static int parse_capability(struct bundle_header *header, const char =
*capability)
> >  {
> > -	size_t len =3D strcspn(buf->buf, " \n");
> > -	int algo;
> > -
> > -	algo =3D hash_algo_by_length(len / 2);
> > -	if (algo =3D=3D GIT_HASH_UNKNOWN)
> > -		return NULL;
> > -	return &hash_algos[algo];
> > +	const char *arg;
> > +	if (skip_prefix(capability, "object-format=3D", &arg)) {
> > +		int algo =3D hash_algo_by_name(arg);
> > +		if (algo =3D=3D GIT_HASH_UNKNOWN)
> > +			return error(_("unable to detect hash algorithm"));
> > +		header->hash_algo =3D &hash_algos[algo];
> > +		return 0;
> > +	}
> > +	return error(_("unknown capability '%s'"), capability);
> >  }
>
>
> > +test_expect_success 'git bundle v3 rejects unknown extensions' '
> > +	head -n2 bundle >new &&
> > +	echo "@unknown=3Dsilly" >>new &&
> > +	sed "1,2d" >>new &&
> > +	test_must_fail git bundle verify new 2>output &&
> > +	grep "unknown capability .unknown=3Dsilly." output
>
> This "unknown capability" error message is translated, so it should be
> checked with 'test_i18ngrep'.

In other words, this patch (which makes things work over here):

=2D- snipsnap --
Subject: [PATCH] fixup! bundle: add new version for use with SHA-256

=2D--
 t/t5607-clone-bundle.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5607-clone-bundle.sh b/t/t5607-clone-bundle.sh
index 4a2a3968cc1..ca4efd88d4a 100755
=2D-- a/t/t5607-clone-bundle.sh
+++ b/t/t5607-clone-bundle.sh
@@ -118,7 +118,7 @@ test_expect_success 'git bundle v3 rejects unknown ext=
ensions' '
 	echo "@unknown=3Dsilly" >>new &&
 	sed "1,2d" >>new &&
 	test_must_fail git bundle verify new 2>output &&
-	grep "unknown capability .unknown=3Dsilly." output
+	test_i18ngrep "unknown capability .unknown=3Dsilly." output
 '

 test_done
=2D-
2.26.0.windows.1

--8323328-2102947002-1594842131=:52--
