Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7187B1F406
	for <e@80x24.org>; Wed, 16 May 2018 19:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751198AbeEPTBS (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 15:01:18 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:46716 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750778AbeEPTBR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 15:01:17 -0400
Received: by mail-qk0-f178.google.com with SMTP id s70-v6so1560664qks.13
        for <git@vger.kernel.org>; Wed, 16 May 2018 12:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=yDpyRFjX+n4inNWdfwFMotq4tLegL7OHfbaSCduYI3E=;
        b=Zoz649BQFyyfFZvxQTyYpteW978y/zJFaibWfnmeaAeKVTI7CHCvCE7pTb0EfuTD+C
         cFLmm8MXd9dwUu81XSJoxSd8/cgdNCcxyZTa6t5jZsQgoJXIajq5tey1NmcDGccVoiXS
         N90tIp8Iikd4xkpD0xosjSEzMfB1LYsaHz9Sc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=yDpyRFjX+n4inNWdfwFMotq4tLegL7OHfbaSCduYI3E=;
        b=fmSQ628kZ4iHiHtTaKgSXELKa/LrLAUcXnPmkx8s2MCI9A98r3sbZ2mnx7745cCXWo
         /Fv2Vt67OZ+ehzTEXaRj9EcLKGwkBidpu/rGX9I3eFWWUVNOf7RA8DsCU+A/qSJcMGgq
         CySIJBLafbV2zpH+0dj8kAkbRPh9FPeGEWQS7Ajq4sbOMMwukqO2uu2R6nnquJKUZh6i
         o6tEkwL2/GCIXeD7WHPt9BVZ8C9y4RR82AJy/BqkN/K8dyjSRTUHrABrxhJmI6X7frBF
         XCyDnFKOVgslMaR4wrVXmxItJpH3cZC9xJ8kLfGnJhg7TRGU4hHpCm7JWFPPkNI+t2UA
         CFsQ==
X-Gm-Message-State: ALKqPwdIWe0l6WxFXTlTYv+8oe2zS7VrHuUfGReCDrUaQH4s3dz4PLDP
        LHc6bjb+g6bS5qznisDEpVDlEQ==
X-Google-Smtp-Source: AB8JxZrMMlYqcLRVejyGOqqqRoAfdcj/K4Qzyd0YtKpxIy1HyrgqeFa4/ndKYHLzzrq99EXd3dtA8Q==
X-Received: by 2002:a37:2ace:: with SMTP id q75-v6mr2066823qkq.77.1526497276645;
        Wed, 16 May 2018 12:01:16 -0700 (PDT)
Received: from [10.137.0.22] (ca2x.mullvad.net. [162.219.176.251])
        by smtp.gmail.com with ESMTPSA id 13-v6sm2656693qtp.14.2018.05.16.12.01.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 May 2018 12:01:15 -0700 (PDT)
Subject: Re: worktrees vs. alternates
To:     Martin Fick <mfick@codeaurora.org>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>
References: <A33442B1-B37D-42E1-9C58-8AB583A43BC9@gmail.com>
 <87h8n7bhro.fsf@evledraar.gmail.com>
 <a933cb3a-6c04-d963-aeda-b5850ca8994c@linuxfoundation.org>
 <1950199.Z2x8tXoTfI@mfick-lnx>
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Organization: The Linux Foundation
Message-ID: <e8776c83-ea57-456d-5bc8-ca2fc990bed0@linuxfoundation.org>
Date:   Wed, 16 May 2018 15:01:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <1950199.Z2x8tXoTfI@mfick-lnx>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="cIp4HozKrvk6GdU6JdyGk0ton1JDXcRfj"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cIp4HozKrvk6GdU6JdyGk0ton1JDXcRfj
Content-Type: multipart/mixed; boundary="HHAA0xDCH4jwq7vOattN7l9oUCOn6wbwR";
 protected-headers="v1"
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Martin Fick <mfick@codeaurora.org>
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
 Derrick Stolee <stolee@gmail.com>, Lars Schneider
 <larsxschneider@gmail.com>, git <git@vger.kernel.org>,
 Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
Message-ID: <e8776c83-ea57-456d-5bc8-ca2fc990bed0@linuxfoundation.org>
Subject: Re: worktrees vs. alternates
References: <A33442B1-B37D-42E1-9C58-8AB583A43BC9@gmail.com>
 <87h8n7bhro.fsf@evledraar.gmail.com>
 <a933cb3a-6c04-d963-aeda-b5850ca8994c@linuxfoundation.org>
 <1950199.Z2x8tXoTfI@mfick-lnx>
In-Reply-To: <1950199.Z2x8tXoTfI@mfick-lnx>

--HHAA0xDCH4jwq7vOattN7l9oUCOn6wbwR
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: quoted-printable

On 05/16/18 14:26, Martin Fick wrote:
> If you are going to keep the unreferenced objects around=20
> forever, it might be better to keep them around in packed=20
> form?

I'm undecided about that. On the one hand this does create lots of small
files and inevitably causes (some) performance degradation. On the other
hand, I don't want to keep useless objects in the pack, because that
would also cause performance degradation for people cloning the "mother
repo." If my assumptions on any of that are incorrect, I'm happy to
learn more.

Best,
--=20
Konstantin Ryabitsev
Director, IT Infrastructure Security
The Linux Foundation


--HHAA0xDCH4jwq7vOattN7l9oUCOn6wbwR--

--cIp4HozKrvk6GdU6JdyGk0ton1JDXcRfj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQR2vl2yUnHhSB5njDW2xBzjVmSZbAUCWvx/+QAKCRC2xBzjVmSZ
bAogAPsE1GEHcKBM4BdQHIi/H8lWjmulMhXIcXUDRAzuoXffkQEAgRfMZazYV77z
APVQplskaD+OcjKRNL6WxgdvT5rZgQg=
=W/c4
-----END PGP SIGNATURE-----

--cIp4HozKrvk6GdU6JdyGk0ton1JDXcRfj--
