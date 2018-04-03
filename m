Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBD491F404
	for <e@80x24.org>; Tue,  3 Apr 2018 12:58:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932175AbeDCM6w (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 08:58:52 -0400
Received: from mail-pl0-f51.google.com ([209.85.160.51]:35735 "EHLO
        mail-pl0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932168AbeDCM6u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 08:58:50 -0400
Received: by mail-pl0-f51.google.com with SMTP id 61-v6so6686466plb.2
        for <git@vger.kernel.org>; Tue, 03 Apr 2018 05:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=/pCUYHTxxngQGIQ/EVxWAu31cy9X+zBNGl/KPG1t3/w=;
        b=TFoTZzAkU1mZnXrOWyHTdr7Ukj5EIf0yVtUNUTJjgUhGCrGi9fb3ZOinfy6xyRU8hc
         1ls05bAh0siQVg5IxzNLzioLbKRO2Ax5UH/u5mwuD8ncAEDRYUls/BvkEHlcNQ8H8J/r
         IHUiumFbiO2A+KZUnFbdIKeYUTjK5zUYggBeOeR5uJeMYHssOrvAWjGILlOnM0nrrkYL
         mLQ+y8uTz/QzJ/Gw820R8N6Cig2EGRpbnrfARELFwnQ61NoBqf10lFRKO3a1OGx884UN
         G4JJdGvL80I0QBTF69bBP17FWfVlay0cl6lEduSJfLMXz7G9gm44KhQUQ70aeEKcpGMf
         abrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=/pCUYHTxxngQGIQ/EVxWAu31cy9X+zBNGl/KPG1t3/w=;
        b=dq9vSNVbuyULIhtLFC3Q2mJrJ+Km4Vhu1lzl1vsEpHPt11/1I1MXCTEZhPFn8asOIm
         jO7qHZidSch63WQoAr3RYOuW6ZJ7qhAVbjk4FF/Q3Vuq1DGdOtL29IEvmGB5hYdC9XUq
         QyAhzciyag4gMTV/w6KHt+8ol2Yz4aTHaJ9kXlF6vueXEa7Nkx0aP5+lX90vIgYFeM+4
         gVbnjRmoX41LItAo43gOLZl5Q6hm4TLISKL+QEaHm43YlB9fzGYZ1nHHtoXjc+sriNTc
         HMtLUC1Cbw6wc41aQDN9jSLpqHJMKlge/W1FV/YvCO/+w1zcbh4h6QbUHRCtisxYp63Y
         //oA==
X-Gm-Message-State: AElRT7Ef0LBt1wN+g1OpYsOFaramweQ57j9jiHqv52dnOLmGijE+fxow
        7GftJv32qA/PVxh++6n8WJVSyOzM
X-Google-Smtp-Source: AIpwx49Tn7uDFPvf0U48Yjg0OBCgRV1RVo1Pkoo7ArzILLiIgheaHfiffR3nV4MNP2r2LXG26EH8fg==
X-Received: by 2002:a17:902:2983:: with SMTP id h3-v6mr14308095plb.80.1522760330299;
        Tue, 03 Apr 2018 05:58:50 -0700 (PDT)
Received: from [192.168.43.71] ([223.181.214.0])
        by smtp.gmail.com with ESMTPSA id w12sm5612804pfi.180.2018.04.03.05.58.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Apr 2018 05:58:48 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] t3200: verify "branch --list" sanity when rebasing
 from detached HEAD
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <20180324183844.4565-1-kaartic.sivaraam@gmail.com>
 <20180403043101.4072-1-kaartic.sivaraam@gmail.com>
 <20180403043101.4072-2-kaartic.sivaraam@gmail.com>
 <CAPig+cSrAN2LgL1dAEUoR4PJk-rUzHdqTusXm8MYUn7p6G4puQ@mail.gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=kaartic.sivaraam@gmail.com; keydata=
 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
 IZ7P/DJ/
Message-ID: <7f07a76a-c467-11b9-1d93-233c0892077d@gmail.com>
Date:   Tue, 3 Apr 2018 18:28:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cSrAN2LgL1dAEUoR4PJk-rUzHdqTusXm8MYUn7p6G4puQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="HgL7woLvdvspa1SOzYc1PfM9SuNQ8VBLo"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HgL7woLvdvspa1SOzYc1PfM9SuNQ8VBLo
Content-Type: multipart/mixed; boundary="hHf9iqPBaMvtUG2YuWxRNIn71LeprHwbB";
 protected-headers="v1"
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Git mailing list <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Message-ID: <7f07a76a-c467-11b9-1d93-233c0892077d@gmail.com>
Subject: Re: [PATCH v2 2/2] t3200: verify "branch --list" sanity when rebasing
 from detached HEAD
References: <20180324183844.4565-1-kaartic.sivaraam@gmail.com>
 <20180403043101.4072-1-kaartic.sivaraam@gmail.com>
 <20180403043101.4072-2-kaartic.sivaraam@gmail.com>
 <CAPig+cSrAN2LgL1dAEUoR4PJk-rUzHdqTusXm8MYUn7p6G4puQ@mail.gmail.com>
In-Reply-To: <CAPig+cSrAN2LgL1dAEUoR4PJk-rUzHdqTusXm8MYUn7p6G4puQ@mail.gmail.com>

--hHf9iqPBaMvtUG2YuWxRNIn71LeprHwbB
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On Tuesday 03 April 2018 01:30 PM, Eric Sunshine wrote:
>> Note that the "detached HEAD" test case might actually fail in some ca=
ses
>> as the actual output of "git branch --list" might contain remote branc=
h
>> names which is not considered by the test case as it is rare to happen=

>> in the test environment.
>=20
> This paragraph was not in the original patch[1]. I _think_ what you
> are saying (which took a while to decipher) is that if a command such
> as "git checkout origin/next" ever gets inserted into the script
> before the test, the test will be fooled since "git branch --list"
> will show "detached HEAD origin/next" rather than "detached HEAD
> d3adb33f", the latter of which is what the test is expecting.
>=20

Yeah, you're right. To know the reason for the unclear paragraph, see bel=
ow.


> Unfortunately, this paragraph makes it sound as if the test can fail
> randomly (which, I believe, is not the case), and nobody would want a
> test added which is unreliable, thus this paragraph is not helping to
> sell this patch (in fact, it's actively hurting it). Ideally, the test
> should be entirely deterministic so that it can't be fooled like this.
> Rather than including this (harmful) paragraph in the commit message,
> let's ensure that the test is deterministic (see below).
>=20

Sorry for the harmful and not so clear paragraph! I actually kept that
paragraph there to **remind me** that I have to fix the issue which it
describes before sending out the patch but I somehow forgot about it
after I added it initially :-(


>> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
>> @@ -1246,6 +1247,29 @@ test_expect_success '--merged is incompatible w=
ith --no-merged' '
>> +test_expect_success '--list during rebase from detached HEAD' '
>> +       test_when_finished "reset_rebase && git checkout master" &&
>> +       git checkout HEAD^0 &&
>=20
> This is the line which I think is causing concern for you. If someone
> inserted a new test before this one which invoked "git checkout
> origin/next" (or something), then even after "git checkout HEAD^0",
> "git branch --list" would still report the unexpected "detached HEAD
> origin/next". Let's fix this, and make the test deterministic, by
> doing this instead:
>=20
>     git checkout master^0 &&
>

Nice idea, will re-send a v3 with this fix and the harmful paragraph
removed.


Thanks,
Kaartic


--hHf9iqPBaMvtUG2YuWxRNIn71LeprHwbB--

--HgL7woLvdvspa1SOzYc1PfM9SuNQ8VBLo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEmrp5T6QugsbUnN0Nveda2sPWGWkFAlrDeoMACgkQveda2sPW
GWlEpg/8DV/DNYYAxXbSkpeq6QYKtNHEYBIn4EHMuIQpkOdq6i5sHSo6zYI3g+uS
wbznLaa3DWFE9fhWKg4sJc5i7uWvs4gtxYPgYGDy157k6082E79Czp6lgqvZ8MJW
y0aJUUGMbAi5Ga8bUiIS0GzhGtM+eH6uRcPigMHYtUTv3VKoJ6CXnN/OVwHX52mC
o72y02YlvQ8lni9mTp3iGmTv9qbV57BJSI7vE4SWRPb2nX0kK/Jet6N3AWAGvXWJ
JkusD+e3atDLdk5a3DZZoPXY6DS3KGPrOe6ArmjNs4jCH4NA1se6NXhWFck+JtOG
NrCbOqSUWrQm78bNpDGVNE4PsW/wKY+0Os6SuKdrDooFaI0nighJp46Ak7WQ/c0S
VMfq/ByUV/S/aw2ACuHtZunnYFdUgQkvyL1riNQA4QZXurlabV4924Hwq1kZq+fW
Y1bI6b11Ld/xqhX9wwTCdf3y4Z4bjDHjfelWVJaZCAOL5GL6x/Ke5mus60zfBAqC
3tKXTCmYTlugkSezmZ2J+tXP0p1rY/4TQ4zH9+dGatEKmplOCTGJLOpSfW76ovH0
8IBj4Q6rirLLqxzJ7B6OkOtgJRSt3UYyZllSWHgsz2g2n1pvrza7ZgSSe+MSz3ou
RLoGyDtF9VZyddKJwFROEbvzbS+IU1PnoBDoeAGOrgTGk3f9FgQ=
=kMhk
-----END PGP SIGNATURE-----

--HgL7woLvdvspa1SOzYc1PfM9SuNQ8VBLo--
