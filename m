Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FAAB1F5CB
	for <e@80x24.org>; Mon, 22 Apr 2019 15:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbfDVPuw (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 11:50:52 -0400
Received: from mx0b-00256a01.pphosted.com ([67.231.153.242]:48572 "EHLO
        mx0b-00256a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727139AbfDVPuw (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 Apr 2019 11:50:52 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Apr 2019 11:50:51 EDT
Received: from pps.filterd (m0119692.ppops.net [127.0.0.1])
        by mx0b-00256a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3MFg4lY038658
        for <git@vger.kernel.org>; Mon, 22 Apr 2019 11:43:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=20180315; bh=RIuPsqmKya6Z575AlE1abL2DsWWdpTv998HWfeF89i8=;
 b=leNgvjy7V0BmI5Sm4z+lThYmg+Bi/bmTPFvCPPxCTqKvflryktMyi9TgvSKMVOhXOkwk
 M2Steq/6IrpxCSXECOPLgmcfrx3vpFQ+8Dqu49Eo6BfONFXQ3dyyDqPXZBRQlQIHhnRi
 jpaAolOESGo32UD0ouSmmTFCYQaHeDN7ryJW72nxG//XBK83BjDF+N86vxvNWlra6T4B
 BKTdZ/Vp3cPOM1jUdI74wiLnTzEU9SrYAmhwOquu2fkJ1aFL6rpbcXOSZpcM3E5q9bpK
 rOCeQyJJ9v+0URaFLXu/bP8ATaRQke96bC6xH/qDaQwbvUpkE5Jfn1GnVHci3s2oBUFB lw== 
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
        by mx0b-00256a01.pphosted.com with ESMTP id 2s0g9pju97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <git@vger.kernel.org>; Mon, 22 Apr 2019 11:43:44 -0400
Received: by mail-ot1-f69.google.com with SMTP id d38so7602950otb.22
        for <git@vger.kernel.org>; Mon, 22 Apr 2019 08:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RIuPsqmKya6Z575AlE1abL2DsWWdpTv998HWfeF89i8=;
        b=uPzagTQiGbOBvWOTjzOyDZ8oPakFxdJd383uMPw6NLOyNIc/EdXIRSLZtujHO+oA4y
         F/Ow8Edga9xEiXxJt9FSGVU5vCHat2Xt3bgkVVh0i79FD5vfhHEDONVPI7u1BKxtG8Bf
         lwfuVDTlrYEjLvn97aZwbSWAAQfLtlAvkRzK4SmHXrLdZID3dTX/XMABSMmH9SKSzJhR
         dpMV0jWJABMSfnA8o/Um7p6pcBg6bH6hahByggPP9YuK76+X4DGixCviXs4+K1t0l7RZ
         ZbXjzs2WZzMOCPKxCWFhYUy65x7rNPd8rMW3sUc8c1ygdDsuk0LE+dv1qhUK6Ao56Wmi
         TQRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RIuPsqmKya6Z575AlE1abL2DsWWdpTv998HWfeF89i8=;
        b=frHr/cI4K3V6iOzVl3BY0I4O1oPBiMRLH0NB5SJFQr1gpt4xU68B7WMAYnjS/LZ3qC
         bD4/rsVntwygvDscEFGIYCBkX1HunH0W3Eqtqvywd/CtgzT1O0Re5nB57gea4Vjw/jvH
         muVSWuoNYWpQ2cgqvommO3aUj9GwwYeVTZNFvi5q7Idg+kl1O95jYVam/GERyC1AGbPB
         DD7U/bwA++WPfyKr635NHtA4HRBar4UttTiHDywltzMyqOqbWKZEgIa9qPKqvPG5MdKX
         Ey/3jzgDF99H3EQ35GZ4M4PdWvJI19YM6dAQyqvzCANIBDpQTHcJfRgzQHFUbh1UicTV
         H/9g==
X-Gm-Message-State: APjAAAWoEwrc0NtySc+yAe7qnnToe5+UG3oz/NLs2jfBYDWA+sZg0wY3
        yv18sZhCT0vdW0Etq5cneZS7y7eOMgY6z11mo1nDH5FSlobaI5wqKcDljt8xBcAzhExm4siqaxh
        UKKQOgfT+ahg=
X-Received: by 2002:aca:310a:: with SMTP id x10mr10905964oix.161.1555947823321;
        Mon, 22 Apr 2019 08:43:43 -0700 (PDT)
X-Google-Smtp-Source: APXvYqykRbZFdP+UvIbojGzgi5eozQB16leu+Y2PvJs0p+L5EB3pXxNLX5pc1gByt4lynig1DPxQOw==
X-Received: by 2002:aca:310a:: with SMTP id x10mr10905948oix.161.1555947823091;
        Mon, 22 Apr 2019 08:43:43 -0700 (PDT)
Received: from LykOS.localdomain (216-165-95-140.natpool.nyu.edu. [216.165.95.140])
        by smtp.gmail.com with ESMTPSA id q25sm5641308otl.60.2019.04.22.08.43.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Apr 2019 08:43:42 -0700 (PDT)
Date:   Mon, 22 Apr 2019 11:43:41 -0400
From:   Santiago Torres Arias <santiago@nyu.edu>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2019, #04; Mon, 22)
Message-ID: <20190422154341.2uqudb645kja6fp7@LykOS.localdomain>
References: <xmqqd0le8t9l.fsf@gitster-ct.c.googlers.com>
 <20190422145237.v5xjelebyjxb3uko@LykOS.localdomain>
 <20190422152842.GC1633@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lurbf2mbtui5e2pw"
Content-Disposition: inline
In-Reply-To: <20190422152842.GC1633@sigill.intra.peff.net>
X-Orig-IP: 209.85.210.69
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=7 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=663 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904220118
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--lurbf2mbtui5e2pw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2019 at 11:28:42AM -0400, Jeff King wrote:
> On Mon, Apr 22, 2019 at 10:52:38AM -0400, Santiago Torres Arias wrote:
> > Hi,
> >=20
> > This is the second what's cooking that's gone by without mention of the
> > RFC patch regarding verify_tag[1]. Is this due to lack of interest or is
> > this an error on my side (f.e., did I forget to send something?).
>=20
> I think anything marked "RFC" that does not get much discussion is
> likely to get overlooked by a busy maintainer.=20

Aha, I was afraid of that. I didn't want to add too much noise as I've
seen there's a lot going on lately.

> :) I had your patch on my todo list, and I just wrote up some comments
> in that thread.
>=20

Thanks!
-Santiago

--lurbf2mbtui5e2pw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAly94S0ACgkQRo8SLOgW
IpXd3Q/+JUzgGlj+5eVNe7+wZNo21F3JEo7hdfjt5myvB8fJs1tUdL5P9dFraji/
kbOCLuPjY3mOPavCC47UmHqE83QSniBDRCrd4UFgyjSJlN5mAzXnqwBi6/+WQt6O
P4Mpei12gnT+Z/xadU+HMdWuxqbPjwDuRgMVj4gQ5GjOibIQcoLUCmHBdJTOrwoq
RqIFL5uZk4RPU7tTn0+SpQJKt0DbrRjIT7sS94THYU4o/vCS5WYr4UrDNDIANogX
rrFkpGjW1Gimz9AvufV5mu3ADn43Zr7KWrdLw5vYxFmYXRI7Am35mYSKP5a9WS/2
TCkOugFinbaR2H72f8mxjjpXnyK4//6u7hjRmQ/nh/ymkH/SeJuWQnEEHAaXjVrt
7JwORHmMOhyi1wjQ7ryo/GLKs/GJlXnp8ubkFZXANYEdUUyEhy/OJBVGbDE9ZRl8
2tHxvw8JGTs/mU/V59x5WMtjCBPfAiJlXAwTEmTMaWNjdMKg3Nh9tFRJoMUlpfu/
LQuDiCUrkBbyJSILNd5Ka47Tq6B/0rob6HQq1wG7E26FpOGxgMta3IITCn3oCxTy
VsKm1gyjDRTypPUFs0Lm+BTn8JjQniYfDlM+CEchOCD6yBJ3HhKovlJO/q9+5dai
/Y258NjCaTjGAwINchfFnrHnuBlNSxWS5OtYFK/aMw275k7A8dU=
=2J8s
-----END PGP SIGNATURE-----

--lurbf2mbtui5e2pw--
