Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0182120248
	for <e@80x24.org>; Wed,  6 Mar 2019 21:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfCFVo3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 16:44:29 -0500
Received: from mx0b-00256a01.pphosted.com ([67.231.153.242]:56388 "EHLO
        mx0b-00256a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726094AbfCFVo3 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 6 Mar 2019 16:44:29 -0500
X-Greylist: delayed 3915 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Mar 2019 16:44:29 EST
Received: from pps.filterd (m0144081.ppops.net [127.0.0.1])
        by mx0b-00256a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x26Kacq3044777
        for <git@vger.kernel.org>; Wed, 6 Mar 2019 15:39:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=20180315; bh=/7DYaYzjYvK/KPii5Haks8ZxUwI4mxVYfaeiFNQp3wM=;
 b=cqcAFDZcuX6pNTtbpF32PTshuFfL0FH5+P4ByDEFcIo+2cVqcVtT/Sd7ugCh9I++NxBr
 b8sZtiWysLxyZ39lMAFgAo1w2eKvMXSWI1fuIDDnn+JWr/4DRYbbljTK0pIIXe2GjO9n
 50vhfXCZqWQcAZta4raJ3WaV/iD9qWwzhKIYJG3fW0IeJ4BYKP95HHvp06wcZ25a7BwB
 FlZOYYBqb38lWMnivjGkIuyfJhQvbFy6HscGZkjT0ToDylQJUm5mk5tqS5ZNAuR4GrjQ
 p6OtiPy2kF5tnDmqUobGIx6WDm741VLeq4rUI1OLdsHplHEuqgOr3pc/0+3Zot56UV0Z ig== 
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
        by mx0b-00256a01.pphosted.com with ESMTP id 2r2mw5gnm7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <git@vger.kernel.org>; Wed, 06 Mar 2019 15:39:13 -0500
Received: by mail-oi1-f198.google.com with SMTP id f125so6996214oib.4
        for <git@vger.kernel.org>; Wed, 06 Mar 2019 12:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/7DYaYzjYvK/KPii5Haks8ZxUwI4mxVYfaeiFNQp3wM=;
        b=V8YAiOguEIPgUKVUBfthtDy3xZOXS8qUFnwOAaJV6w1btSqkSNIvLK9Rxo9s+DbFPw
         Ke3csc3+9zkksCwXVnaX7ZZ4CWy+7R3SFnWhLPYY0PVAeJxr6GmaPhXSoVLbmguOqxmh
         9B8LQycEUo2lyYclMoF68aT6NKlbsDVDZwnqHjTPNh6At6CYwaXYLHugzGMT14JqyqX9
         VeZCcu4byqONqNriTPHGkeMThp8YOSl7LRzlqWzQQ37wiHi1JI5gRqf6i2yxfvsHNWtw
         NqT0GG6YmknIW7vPXYRFd4pCHt8Wb2ZPfvA4GEEoSd/4WX56mWzX3AMdMqdRSRaaL18L
         BnxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/7DYaYzjYvK/KPii5Haks8ZxUwI4mxVYfaeiFNQp3wM=;
        b=R3OooOsuLN+6mSmb84tg9b5LYQqqXj7GGjmknYAP+53jbyAKVOqes1oCkgcyf3TtWS
         rgxiRVRVAzjWO/yo54NdOoz7jxOklhrBN3bpvjFBcOagEREmaBxFG4Lx0f+J0KQZkGc1
         D96EGbmNwL9e6r3aLYHKbiofmiFzWsCbWAA1QUR5viqJa8E74n+vX9DCJPRebOK478g1
         7No6HoTYxxHregqILnLHQ0IHolmM6QUsK/l35GUO6ztFonEYkhu9FCaytHFfdHgeYyEe
         iaPmQsKljAMuXV5Fftq7HyZ+L61U748WzZ4JBD2u1DDuSYz+TANDW//p8wuQ8gd1DfAy
         qGPw==
X-Gm-Message-State: APjAAAWZZNXYhyf2c00HpTFCzzFtH/hPbJA/E7ZDLsvfEnCdBoYbN47v
        jDSMy79qASam3Somw6CXWZ8yBiliiJDBmLTKsnr8eRdXaFkT4xi5EzeNOegpQIDiOSmcw0027lC
        /5dGQQ8QtOqk=
X-Received: by 2002:a9d:7d99:: with SMTP id j25mr5430056otn.267.1551904752972;
        Wed, 06 Mar 2019 12:39:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqyeEEo/XvonrF5cTfzmkIFdIKcWeQp/KHaLMuskEnRGHFyzrxia4bzLSdgjbpPUaOxIhysWbw==
X-Received: by 2002:a9d:7d99:: with SMTP id j25mr5430041otn.267.1551904752632;
        Wed, 06 Mar 2019 12:39:12 -0800 (PST)
Received: from LykOS.localdomain (216-165-95-185.natpool.nyu.edu. [216.165.95.185])
        by smtp.gmail.com with ESMTPSA id c84sm989157oia.41.2019.03.06.12.39.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 12:39:12 -0800 (PST)
Date:   Wed, 6 Mar 2019 15:39:11 -0500
From:   Santiago Torres <santiago@nyu.edu>
To:     Fabio Aiuto <polinice83@libero.it>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: Can't build first git commit
Message-ID: <20190306203910.xr2bwpqb3zrxnm63@LykOS.localdomain>
References: <1551729517.4092.1.camel@libero.it>
 <20190304204007.GA32691@sigill.intra.peff.net>
 <20190305191519.GA12791@sigill.intra.peff.net>
 <1551902320.1727.1.camel@libero.it>
 <20190306200356.GB23315@sigill.intra.peff.net>
 <1551903598.1727.3.camel@libero.it>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ywzob6mjqkylbhqj"
Content-Disposition: inline
In-Reply-To: <1551903598.1727.3.camel@libero.it>
X-Orig-IP: 209.85.167.198
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=7 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903060141
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ywzob6mjqkylbhqj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

That was proably my bad.=20

I still find it somewhat astounding that it compiles with a modern
toolchain after 15+ years. Many projects fail to do so (it's an
understandably high bar to have).

I'm glad this is possible and you were able to do so (maybe you want to
share your experiences about it somewhere? :))

Cheers!
-Santiago.


On Wed, Mar 06, 2019 at 09:19:58PM +0100, Fabio Aiuto wrote:
> Yes that's great.
> Why somebody told me about a outdate toolchain when I started this
> little thread about first git compiling? Sorry for my stupid question
> but the you just resolved with that make override...
> Maybe there's something I have to know?
>=20
> Il giorno mer, 06/03/2019 alle 15.03 -0500, Jeff King ha scritto:
> > On Wed, Mar 06, 2019 at 08:58:40PM +0100, Fabio Aiuto wrote:
> >=20
> > > Yes the fetch command wasn't written at that time, right? I didn't
> > > understand why should be better to work with the git code from
> > > github.
> > > There's something I misunderstood?
> >=20
> > I just mean that it is an interesting fact that modern Git and Git
> > v1.0
> > can still interact seamlessly over the network. I.e., you could still
> > collaborate with somebody using an ancient version of Git (hopefully
> > nobody is using v1.0, but logically it extends to all of the
> > intermediate versions).
> >=20
> > -Peff

--ywzob6mjqkylbhqj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAlyAL+4ACgkQRo8SLOgW
IpW4Ww//RU4yI5qt8efc3lX6l5hkm9JtXhfqKYYh7qpFmvgHrZjZ18ke1h37E5ly
aAS3lsvvPXT+oL0fcjg9jAdvnh2EgZHCJx2Klb0WbrTVWPrqmhaXu84mapIRY8N1
s1K737AJqBBdb6YWCSE7gRMCCfCuvS5CsPif8Lr2p8y9Z6ICHyqHnbe+B7VpcHCg
c6LuMZcUpP7qLJQkaLBFtJWsRPoVuqF/sc5GDKLBda2YgPm0XM6vWIryJHV3VkBr
X00NvuNY6rX95aQMNZzYHhSFOkmtzQNTjrZ+jpzsifTgWjftVL3MAfVod9hti/ue
oudnFDnK5U6IrjbbcTGjYZ8mlwHabhphm6DUg3yzsmq+ssfAsB/Yv8P2UPZoUQeC
KuhD2JKlUzDHZ2sc58xwmavxGQdrUgnDMbSPoPHtoMoPlqR+zLkNXYunBnRQDjLD
79R9Am9/w6EnqEtQKgmkTOE6oQPAdslgZyS703+wTiic3FZZAScpVtJZ9tUvafm8
UacA0exWqqzw8RKUyMuLYSJaEePEWqRK+h97ZwbU383XBlAVi54A363g4frp0osI
bl4HJOwdX5nAM0zMaE6/dmeLOiJRP3tVXXSXmregqHo2mwXZRQ0wAP3VkM/osC2H
kFxtTTdpVN09zguMJh11pvQx38ZFf6bl/IqF0Lh+uiM74ZmcLks=
=Q0lJ
-----END PGP SIGNATURE-----

--ywzob6mjqkylbhqj--
