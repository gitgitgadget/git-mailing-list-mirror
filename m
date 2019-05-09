Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52AE61F45F
	for <e@80x24.org>; Thu,  9 May 2019 17:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfEIRgo (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 13:36:44 -0400
Received: from mx0b-00256a01.pphosted.com ([67.231.153.242]:36758 "EHLO
        mx0b-00256a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726576AbfEIRgo (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 9 May 2019 13:36:44 -0400
Received: from pps.filterd (m0144081.ppops.net [127.0.0.1])
        by mx0b-00256a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x49HaWjI008080
        for <git@vger.kernel.org>; Thu, 9 May 2019 13:36:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=20180315; bh=7xc0RNuzc+UbkmmJL6q4P/uI6H7gcDpkJaMIuIXI5Bk=;
 b=TNqDjyzB3HVu+moSP/Z8Y88SkQMhb6XAowUlVdCGyAQ9/dP+wVydcTmcGQ3Zq6i2WGqn
 +gR/+MjMA0fgbjsLU3zKUmX3GcQh4qksuQ6ifWwnrHpZdOUcy7o8aTgaURJyt8Omg8s0
 U7+NQhYu9yp0s2JuSAGmlVMQfFV5lvvKCLk6YLlcvmw1YMMqd9pTtXHqyLQ4ZWAkbRZp
 a2RHjYUmU9rPjVaB0L2T1akKdce5DAjWXsmqiTQek009kbHwzS8FHGVl8qk3TCSBhm+g
 Vu8IoyVPd2IVwc0R5uUm9Cvz3HX7+fl96b1YKxmIazFR+eGhQEOgUUZTotdqfsK8HxZE bA== 
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        by mx0b-00256a01.pphosted.com with ESMTP id 2sccnxjf20-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <git@vger.kernel.org>; Thu, 09 May 2019 13:36:42 -0400
Received: by mail-qt1-f200.google.com with SMTP id o34so3389790qte.5
        for <git@vger.kernel.org>; Thu, 09 May 2019 10:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7xc0RNuzc+UbkmmJL6q4P/uI6H7gcDpkJaMIuIXI5Bk=;
        b=GyDphWtoQGMxJvt25foBQRB9FBW0c2lBqrfxyrLekk902T32xsDs3K+5YZoBZ/abek
         YDvKlRme84ipohUmb8/5s6iudOv6HAZ9Rt9FvP4Q+5OCFrquMMLcKd9b7PcOulad3k7i
         iO+5ePa7jkqPq3w6krDZXxvenNkIRgfq1oTNGLwiBXDEkYTbCELm0+mezxcxFseNNrOy
         e969sGUjgURUXnWdRAf0BHGMgTTbRu0zNt/Jxom4EFhe5i3UgFCOqkK5Rf8qHP1IQCb5
         AqRamVU2Eu3C4xEttszE49AHOz9Caz8jAn03vzxE+ZeIzsSrOzfHlp0Kt2t2oH6SWDNc
         C39Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7xc0RNuzc+UbkmmJL6q4P/uI6H7gcDpkJaMIuIXI5Bk=;
        b=FtTbZ73Qe7vWC91lHaUOpvVS1eL6QUQVGFooepyNUjTYK8PxwxfHPRp0dFE5sYIkD/
         6JdPDgksRao+9/g3Z22M+8Ou+cC+hNoldDQHnLnmkdXsEkxxoC1TVCusDXLIqxSpPk7L
         h/bYnjXHXJijIuLifShg2I3zvGDWE60swy3kpek2fDY8apbMjfnidmvE1qciU5eWzg83
         vbaVrkqdfLxapDNZv96IDyTfqQEdTO9pu6ChvYnEN7RYEcRrva2hU2oKU5TAgKatBGVD
         95r62NMFFDikZ7PxVcEiDluXWU8/BK6892nv+cYDEDnOe0OZOVFO6EeaxcXmJm5/cj0h
         CyRw==
X-Gm-Message-State: APjAAAWcjKRZbEAev9Jq66wfQrkO0GLpSVeUUxhtRDcDAKfQ6PHj4KoP
        8X0M5MxiDLByLeYEmjc37J5wAUN3nxQJWGYZxk33/EAMEz4H72mR8EKw3YZKxcgmgf3MiqxrfHB
        DQMR1msjUNE4=
X-Received: by 2002:aed:23d5:: with SMTP id k21mr4938158qtc.191.1557423402033;
        Thu, 09 May 2019 10:36:42 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwlsCgShN1mQi1vyNWUxtjbiHiUkVLhwGpvwUGVnOcHmVacIwTxIdraI/8vmqT5RsNIvwR7UA==
X-Received: by 2002:aed:23d5:: with SMTP id k21mr4938144qtc.191.1557423401900;
        Thu, 09 May 2019 10:36:41 -0700 (PDT)
Received: from LykOS.localdomain (216-165-95-145.natpool.nyu.edu. [216.165.95.145])
        by smtp.gmail.com with ESMTPSA id j25sm1506778qtc.24.2019.05.09.10.36.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 09 May 2019 10:36:41 -0700 (PDT)
Date:   Thu, 9 May 2019 13:36:40 -0400
From:   Santiago Torres Arias <santiago@nyu.edu>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.us,
        walters@verbum.org
Subject: Re: [PATCH 1/2] builtin/tag: do not omit -v gpg out for --format
Message-ID: <20190509173639.4dghpurz72vhxzzt@LykOS.localdomain>
References: <20190427202123.15380-1-santiago@nyu.edu>
 <20190427202123.15380-2-santiago@nyu.edu>
 <20190509073644.GA24493@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oo5a6oin2q6gaejc"
Content-Disposition: inline
In-Reply-To: <20190509073644.GA24493@sigill.intra.peff.net>
X-Orig-IP: 209.85.160.200
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=7 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=770 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905090101
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--oo5a6oin2q6gaejc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> So we're going to stop setting OMIT_STATUS ever, which makes sense.
>=20
> It took me a minute to figure out here that the behavior for VERBOSE is
> not changed, because we _overwrite_ flags, rather than just setting a
> single bit. But that's definitely the right thing to do when there's a
> format (both before and after your patch).
>=20
> So this looks good to me. I think we should probably cover it with a
> test in t7004.

Yes, that's something that surprised me originally, as these changes
don't make the test suite break in any way...

I'll add a patch to the series with a test for this.

Thanks for the review!
-Santiago.

--oo5a6oin2q6gaejc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAlzUZScACgkQRo8SLOgW
IpXHlA//Yn2ZjqJ1Co9d5vB7zZXmpYHiLO63uCzvQX3PpzK2O+VrtjOmlyA9lefi
SZ8ai2GXAtkXUr2UtJRACRWUFFF673g1DLOFSnHI1RA29PiYRMGh+0RAcoFerP9k
/AqzqumiNnwKoAXVO22BIyO7sJjAMubKHYXlLG+TVxefNyHxAzEI34OhuKGo7v94
olqNnwQTwdEPN2zyC6OWgdpYaua1BVwdx274cgzUv1TOalT5xaH2b6VdCpCnevWD
IdX0EswxstBGN9tUecHoyshtHSsPW5gHt12J04IzfjBXUsWIZAYnjG2byth5uNTl
2s8Op3UGDYtTrh6utMvIZ8PLVToAIFFNO4uZknid9xJ+jmXUGvqO6D0meDa3Uq6I
6QxxbMF05D59mLFgHfIgh0Jj+hOEChs0iBxsYoLHH44ZbEHIuSuYd9UqBOZysQv0
gTLFj+1LRDzvfovpO1QKP7KaX8C6FVsLFFOJkhVq+Ad1BKFp4uPGBAXwXT28/wLQ
vbz9ODh4vU/nRZeRkUerM5GASCWXT0/vWWv7BLD92Fr9y2iR+8hWr5PKVOR9ZWC9
pTT0mZVtg8zlDONt9FN4hkoYt/8n0SKG3Ymm666MoTXVsekuTGXKcNenq8TXbcv/
tMEUGqEavlpRlmSpII77lvlg8ccLnjFKJrl3LcvfHl5JyrTYb5Q=
=qb4d
-----END PGP SIGNATURE-----

--oo5a6oin2q6gaejc--
