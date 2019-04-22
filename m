Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39FE91F5CB
	for <e@80x24.org>; Mon, 22 Apr 2019 15:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbfDVPrA (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 11:47:00 -0400
Received: from mx0a-00256a01.pphosted.com ([148.163.150.240]:54546 "EHLO
        mx0b-00256a01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726132AbfDVPrA (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 Apr 2019 11:47:00 -0400
Received: from pps.filterd (m0142701.ppops.net [127.0.0.1])
        by mx0b-00256a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3MFbVcX122521
        for <git@vger.kernel.org>; Mon, 22 Apr 2019 11:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=20180315; bh=wN+tfvy/obpWsXAMA7EjKwhYJPVkz2HR4Sn83YkN+F0=;
 b=yVfvV0KLIprVoKNUkw5JhlS4RnJnlgvI6tV1iCIBLlWtUGm4I5mXsWjmryyLxOz/KKSc
 9PjuOByGzFXGHgolC27I0TlFdMdCs8nptNFZalJS6lracT31Bok3ukduYhR9MTWeK4Fb
 OniH0CzjyprwCUjV/gbpBlIh0B57VmSvFuZ/7HCQHPMsECez//5MbfHUIdgRaN4cFXOK
 6H6+cPRW4wQ1li0+FfvXVBIP3N5jfBOf2VN2WxDqB30ZLY/G6flNFFZRBzSY7svDQBZx
 5F9OVYLKsUAbsiY8WKyG6GSe3QZGp2Eyif4d4fV9Lg4cjs9QMHJD47+V8IPkd8Uqa3Y5 Wg== 
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
        by mx0b-00256a01.pphosted.com with ESMTP id 2s0h06c3qh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <git@vger.kernel.org>; Mon, 22 Apr 2019 11:46:59 -0400
Received: by mail-ot1-f72.google.com with SMTP id i21so7611538otf.4
        for <git@vger.kernel.org>; Mon, 22 Apr 2019 08:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wN+tfvy/obpWsXAMA7EjKwhYJPVkz2HR4Sn83YkN+F0=;
        b=Vufj8UctstPhXRziXeZWyFDDxRsl5vYra6EPpWRE21R5mDDknrK6H7FGLYppSeT9Xf
         wanWi/OPQVSvvG8SPbQPmEIIO09ESb0T6GcIHmNZP0xNVAUWNkKeMN1Ku1nTVKsWg/br
         e2vPC0r0Rwv7FyKg1IIThjEIpOLRWIkrPDA2G7x0F616mUYb43WiYIXtSiyTNgeb7PwR
         MKM/cuwd8OGYI4/b8ZyWqsXpCCAJuKmdoGxhQEjWrIi19qXjfOoJrAfHtcVIf4hhUJ8L
         hdYeTWs9A8U9HaLnTRu7hQF/NOxUey3OyQlWz6KI5Mc5JlP1nNDw08KwtJZZ3Q6+oJZZ
         KPHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wN+tfvy/obpWsXAMA7EjKwhYJPVkz2HR4Sn83YkN+F0=;
        b=CpNTVMPf8xh23Me89W+7dysf/r/hkGlrFdQa9dRXPM/Q5RnDCEev7SBGkggYNF6HK+
         K0vLBgx0Q8iavJCrgvkZHpqmkTdIQ51dMIn0ex79K1GZKhd0K8/Xo6gJAQjqs2huHud3
         37h7JD8eHxIlkvo+EZuLCJviF9BZVPGtI5fBpxf3/e99G36ixrV+y/hUiIoOW363zfb9
         mbvnovOhhTDMhIJuYCqSjEZIUb01op0cChsXDHhjuAFhl7ZXa16RElHa//dmJbKbHp6D
         inATXtZpm+wWx78OJzH9xWItvkF6rEAMYhLCT/wXxug0tlaOYYsh4eL9lUzXBHl3ob6A
         q3xw==
X-Gm-Message-State: APjAAAV5Wat3kLDfD5vx4dwIkxEsjGk0KSNsLtezdBDXd/2UX2cKaiua
        +SbloAFA1cZvYrh+MbwKJBG/fhoYQ2M+MCl2fgmBRZ/LrGkxwnNlsgKyTFEC8G/jT4LsagwUBVO
        aO39gTWTcWrg=
X-Received: by 2002:a05:6830:128c:: with SMTP id z12mr12849953otp.101.1555948018233;
        Mon, 22 Apr 2019 08:46:58 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxOOmeKxGDmDMQTN42tfwmHLVBNMYD9t7/OSoGi74goAVdE2cAA1lN2mlSr7vRBM9K5WTEZAw==
X-Received: by 2002:a05:6830:128c:: with SMTP id z12mr12849938otp.101.1555948018060;
        Mon, 22 Apr 2019 08:46:58 -0700 (PDT)
Received: from LykOS.localdomain (216-165-95-140.natpool.nyu.edu. [216.165.95.140])
        by smtp.gmail.com with ESMTPSA id m21sm5951878otj.48.2019.04.22.08.46.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Apr 2019 08:46:57 -0700 (PDT)
Date:   Mon, 22 Apr 2019 11:46:56 -0400
From:   Santiago Torres Arias <santiago@nyu.edu>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.us
Subject: Re: [RFC PATCH] builtin:tag:verify_tag: allow gpg output + pretty
Message-ID: <20190422154655.sxyrkee7rnywoh2w@LykOS.localdomain>
References: <20190412201432.11328-1-santiago@nyu.edu>
 <20190422152726.GB1633@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tahffns2mlmf3iuk"
Content-Disposition: inline
In-Reply-To: <20190422152726.GB1633@sigill.intra.peff.net>
X-Orig-IP: 209.85.210.72
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=7 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904220118
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--tahffns2mlmf3iuk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> However, I don't think this patch is quite right, as it causes us to
> dump the whole tag contents to stdout, as well. E.g.:
>=20
>   [before]
>   $ git tag -v --format=3D'foo %(tag)' v2.21.0
>   foo v2.21.0
>=20
>   [after]
>   $ git tag -v --format=3D'foo %(tag)' v2.21.0
>   object 8104ec994ea3849a968b4667d072fedd1e688642
>   type commit
>   tag v2.21.0
>   tagger Junio C Hamano <gitster@pobox.com> 1551023739 -0800
>  =20
>   Git 2.21
>   gpg: Signature made Sun Feb 24 10:55:39 2019 EST
>   gpg:                using RSA key E1F036B1FEE7221FC778ECEFB0B5E88696AFE=
6CB
>   gpg: Good signature from "Junio C Hamano <gitster@pobox.com>" [full]
>   gpg:                 aka "Junio C Hamano <jch@google.com>" [full]
>   gpg:                 aka "Junio C Hamano <junio@pobox.com>" [full]
>   foo v2.21.0
>=20
> I think "git verify-tag" would need similar treatment, too:
>=20
>   $ git verify-tag v2.21.0
>   gpg: Signature made Sun Feb 24 10:55:39 2019 EST
>   gpg:                using RSA key E1F036B1FEE7221FC778ECEFB0B5E88696AFE=
6CB
>   gpg: Good signature from "Junio C Hamano <gitster@pobox.com>" [full]
>   gpg:                 aka "Junio C Hamano <jch@google.com>" [full]
>   gpg:                 aka "Junio C Hamano <junio@pobox.com>" [full]
>=20
>   $ git verify-tag --format=3D'foo %(tag)' v2.21.0
>   foo v2.21.0
>=20

Ah, let me look into these issues. I'm almost sure I also need to review
the test suite and adapt it to this behavior.

> In some ways I'm less concerned about verify-tag, though, because the
> point is that it should be scriptable. And scraping gpg's stderr is not
> ideal there. We should be parsing --status-fd ourselves and making the
> result available via format specifier, similar to the way "log
> --format=3D%G?" works.

I think that would be great, as we could make it simpler for verifiers
to parse gpg output.

> So I think ultimately that's the direction we want to go, but I think
> in the meantime restoring the gpg output to stderr especially for the
> porcelain "git tag -v" makes sense for human eyes.

Great! let me re-roll and make a more formal take on this.

Thanks!
-Santiago

--tahffns2mlmf3iuk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAly94e8ACgkQRo8SLOgW
IpWyYRAAv+FP0150g7ecBopmkyWCQxNa6FD4KXrzjXK2IPlDp4frSwMLu0sEPQZT
iaF3bYE8qYYwOiJek4DU6KtDgbvvEnEFCXO4O1wkao8+0YfChJ55Nvlj7w4z3yUu
1IcH8jR5w6GKhAAwwmt2+8pK/pT4TNwgRo/5B/xiybbcYbIJkDDA4bQWh8smqe/A
rrL8skYgC35qw1oqUN5s4Z33CN5JjI8wSBpDUU6AaYrchQ4FX9kn2+TFL98CGQUS
UQryqkFGgKDMtQH7G2P7b1M4F7a8StnI5EaEsAautrSfkuafInAYXFI+S+NdpFaL
FQJ265IZ4OHFiYt0JCkup2DGodmyBHbznY2g0Ai0d+kUx9ujMKChZGa2Atk4wk3o
58hu8khfswcCrfh+sBlgQVtUBiY4/hkLgEYK0ilrTqFlcNSeKwesr6ka7WvHSGXw
GoNWgPr+Aajrkv7WZmMA7scoduSY1c27rLxTbT2AEhpib7kzEXin9fCpwkJ6FkCM
uIJm9rUOFoI2OdOWhwKMoHJlphAykq9HrHyDqUAAq9HWNxlLUpmnJQuHbAYNHzs0
F6VZv/qUjWte1+MANg5T+iHhSCD6T3+AxWzuta0Cy8US0hH+xY4d6X0Q1sE5Dpwi
duXrSgygR0KG0Wzug1+2nymppiM/URW7Xv8cOgUeuMPt6vmJNOg=
=ntgP
-----END PGP SIGNATURE-----

--tahffns2mlmf3iuk--
