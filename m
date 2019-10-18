Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECAFF1F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 16:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443001AbfJRQLq (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 12:11:46 -0400
Received: from mx0a-00256a01.pphosted.com ([148.163.150.240]:56468 "EHLO
        mx0b-00256a01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732391AbfJRQL0 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 18 Oct 2019 12:11:26 -0400
X-Greylist: delayed 1033 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Oct 2019 12:11:26 EDT
Received: from pps.filterd (m0094546.ppops.net [127.0.0.1])
        by mx0b-00256a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9IG6px3035494
        for <git@vger.kernel.org>; Fri, 18 Oct 2019 12:11:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=date : from : to :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=20180315; bh=lHM5I0HSXYkBgOqGtJf0Eu9mn/sHMvw0BcNA/VVfY04=;
 b=qDCRW8Qns0HUszZeOSiA3P+nO6wO4BkzjDlzfFXHxUZYPp0Kb4Z4aGNJnw4K7B7gQ0lK
 pQ0p10br548ocPyt/Kw4gFxjeps52+U61pM1hpRIl8XoRFVuwxE9OmlTV0z2Eg1c/alJ
 Hmk85OHQfHQU9wCZ4QwYKieVLZByXr1sKRdoNqlnftB7ZZmIJF0yh4ClcpAizfgtaEqk
 3/MMw3W7rJihlf/gauhvfSoikko8ZGQ+MsmO3Hm+OlUhmVt3hbGbeqtE6XpFfIHEEhC7
 Ej9RZALRhiLZhd3HcRyulhUEEdUWS0AJx71lGi9z+HgPpWmS0w+dnjTUQrZacgf8Xviz 2Q== 
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        by mx0b-00256a01.pphosted.com with ESMTP id 2vq7yk7yby-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <git@vger.kernel.org>; Fri, 18 Oct 2019 12:11:25 -0400
Received: by mail-qk1-f197.google.com with SMTP id g62so5941486qkb.20
        for <git@vger.kernel.org>; Fri, 18 Oct 2019 09:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lHM5I0HSXYkBgOqGtJf0Eu9mn/sHMvw0BcNA/VVfY04=;
        b=mh2MnBcQzL97cXsZ8di63e639C45jvmMREFZJd2yyV3W3WJPubQeLKV61Zl92y0q1X
         TULFo5wAWmtpaKdNW2rB7EVXp3Yvc3DleI+sZs7E/OQ2i8OzCe9HsBPKQmjNf25g2IYB
         6Kw/PXWzGckx5a8Rm99vw7MaG6nZhbvLN+yubZ3UsqtiQG9z8JfnV2IUKAPzTBR4Lmqz
         r8eXk3s+ldrvgpz35corD73KJS6Ia3pLCFP1OmJdDAy7Ic4MzBli87OowZmcXzipl6xp
         opX0fBJvJQPwOv7dLrbnTFXyQV81QhpbHXoc3sY3RdstvNz58EtxdotqjV/hxxZ5Vtur
         RKag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lHM5I0HSXYkBgOqGtJf0Eu9mn/sHMvw0BcNA/VVfY04=;
        b=kD4LLDxXrGRSS4ky56M3wAtO4DAFqlAQSifxxSix0hhtSZ9EfhlPemvdRny5WyD/zU
         3d9K6Xwq7tsA2K6eD+mMglPelM8jOtF8PMIg9qNf/2BNKUS/fd5oQ/t4ygrbMQU5ynbj
         ytkGkCquEbHGxdWVFqvDMYrlD+F+DvER9kY8Ed/b90AB5ervf2sBAT90cKCWTzKJjSbL
         J/aIooipA93MOT7CTZnLmbrzolDoPscDMsSyrWnQPBNTBDA6WOEvqawB88yPI3JwgzMT
         hTOEt+CAJ0e14Ga7Mbugx56yiqaSxtH2lCIQxmEj86fuGSa/0QauZiz4RwObF0ct3IIi
         N65A==
X-Gm-Message-State: APjAAAVLumZSLTOhOQaznGsf/4DAOLclKkqKt/IjkVGLVSw8/dZfx+2a
        mL7P+oODUJSX2hayGtC0aQIfXPsW/U0+dP8NexfxQRfpGTrZaAAAp3ik5DBfpJz30XAa7S5b4Dj
        WYkX0lawsyM8=
X-Received: by 2002:a0c:fd63:: with SMTP id k3mr10484618qvs.185.1571415083967;
        Fri, 18 Oct 2019 09:11:23 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw9oseEn9vueF+r2BvG0eNlqZ8HAgBLbGeWx2SxOoEkwS2LgxoYX5R4GCU2LZuVLBZfQZc5bQ==
X-Received: by 2002:a0c:fd63:: with SMTP id k3mr10484594qvs.185.1571415083693;
        Fri, 18 Oct 2019 09:11:23 -0700 (PDT)
Received: from LykOS.localdomain (216-165-95-130.natpool.nyu.edu. [216.165.95.130])
        by smtp.gmail.com with ESMTPSA id q200sm3073239qke.114.2019.10.18.09.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 09:11:23 -0700 (PDT)
Date:   Fri, 18 Oct 2019 12:11:22 -0400
From:   Santiago Torres Arias <santiago@nyu.edu>
To:     Vegard Nossum <vegard.nossum@oracle.com>, Willy Tarreau <w@1wt.eu>,
        workflows@vger.kernel.org, Git Mailing List <git@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Eric Wong <e@80x24.org>
Subject: Re: email as a bona fide git transport
Message-ID: <20191018161121.6qe5kkweh4u77gvn@LykOS.localdomain>
References: <b9fb52b8-8168-6bf0-9a72-1e6c44a281a5@oracle.com>
 <20191016111009.GE13154@1wt.eu>
 <20191016144517.giwip4yuaxtcd64g@LykOS.localdomain>
 <56664222-6c29-09dc-ef78-7b380b113c4a@oracle.com>
 <20191018155408.dk4tsjrne42ufpvv@LykOS.localdomain>
 <20191018160343.GB25456@chatter.i7.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5dbczkamho4hvge3"
Content-Disposition: inline
In-Reply-To: <20191018160343.GB25456@chatter.i7.local>
X-Orig-IP: 209.85.222.197
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 mlxlogscore=999 spamscore=0 priorityscore=1501 malwarescore=0
 suspectscore=7 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910180146
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--5dbczkamho4hvge3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2019 at 12:03:43PM -0400, Konstantin Ryabitsev wrote:
> On Fri, Oct 18, 2019 at 11:54:09AM -0400, Santiago Torres Arias wrote:
> > > Seeing how large this signature is, I have to admit that I am partial=
 to
> > > Konstantin's suggestion of using minisign. This seems like something
> > > that could be added to git as an alternative to gpg without too much
> > > trouble, I think.
> >=20
> > I wonder how big the pgp payload would be with ed25519 as the underlying
> > algorithm. AFAICT, the payload of a minisign signature vs a signature
> > packet have almost the same fields...
>=20
> It's smaller, but it's not a one-liner. Here's a comparison using ED25519
> keys of the same length:
>=20
> minisign:
>=20
> RWQ4kF9UdFgeSt3LqnS3WnrLlx2EnuIFW7euw5JnLUHY/79ipftmj7A2ug7FiR2WmnFNoSacW=
r7llBuyInVmRL/VRovj1LFtvA0=3D
>=20
> pgp:
>=20
> -----BEGIN PGP SIGNATURE-----
>=20
> iHUEARYIAB0WIQR2vl2yUnHhSB5njDW2xBzjVmSZbAUCXaniFAAKCRC2xBzjVmSZ
> bHA5AP46sSPFJfL2tbXwswvj0v2DjLAQ9doxl9bfj9iPZu+3qwEAw5qAMbjw9teL
> L7+NbJ0WVniDWTgt+5ruQ2V9vyfYxAc=3D
> =3DB/St

Yeah, the discrepancy mostly comes from pgp embedding a timestamp and a
longer keyid (+a full keyid fingerprint in pgp 2.1+). Minisign keyids
are 8 random bytes, apparently.

It doesn't seem like an amazing win in terms of succintness, imvho...

Cheers!
-Santiago.

--5dbczkamho4hvge3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAl2p5CkACgkQRo8SLOgW
IpVFkg/+IC6+ElikT3WhkNyWtIvmLoqVxdpvuKUNADxO0zmUg1m+jzaAktuAwjP8
Sn3jXRIT5vBXy8i8T+dyF37Qxovha3FAx03UepPZwNA+mqB/PCIq5l+lC+hMjOUd
xf0cjRhzb7bg3TTn4tTvTq4wrLNNOgAsoU+JKuM4vLdz0BI6xHKjEDmEeyPa8Ez/
l16V2/qpiQjhL85KVCdZzHkNnXdAw1lSd/Wd/BH6n/fFL6Ng17JG0fLyBVMjKdn7
I5tChT/sEgoEqpY51YeX8oNhbEMK4b14Id/u/JBNOL+NX/+OkVoklMGgvKW5TiWj
/INAR786NEIRoFHGM+61tDWFJl4t1SoTpf8eFNEhrOeJyIcnXSB7FPXuBB1uD+++
iEbyJtuUFdLi0iVbJgv1rBxZNIc3DTWIfA0outUn5Y5NSgeXGBNhTMNHE5QsqHDF
/3OLDm+5jGMeN9iePb7Cbb/oxt118c4LUVShrN67LmwOQ0cSl353Ct5sXFXe3f59
mHKxM1+F94viKVIPLdi2Yz99lH9FZ5NPyskRAP0yZEDeu+bPyGkdn+2PaiDxGFOx
1XcoI5wMjQ+eR3eftjufbWIUm4C/jtxG978nBaXN8yf00omWDccI3+fodCXDE5Mj
RCnJ8qi3/SUOs2OCcSQaWxB3PmiUuPDP+OP5evNuJYXuAU5OtGA=
=MEhz
-----END PGP SIGNATURE-----

--5dbczkamho4hvge3--
