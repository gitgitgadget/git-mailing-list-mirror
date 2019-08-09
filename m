Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9087A1F731
	for <e@80x24.org>; Fri,  9 Aug 2019 18:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437014AbfHISBz (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Aug 2019 14:01:55 -0400
Received: from mout.web.de ([212.227.15.4]:44275 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbfHISBz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Aug 2019 14:01:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1565373703;
        bh=A79nS3pDDIXL4QRP9E568I7ntHUvs4PmdaeI+LasBik=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=rkTMM+97NXOYw+jrm2M3/wwR9ii3+C+4glIhvu00KPLVqpDIyUMs37b7MgqlIVutw
         mAe53weOaThfl7CUkCti2i4CUBShEoUxl/R/+J1r6x+uIwzAg0lV6h2e5KFsxqllVd
         VNfUea+GEGimp+F2mMwhwfGhWPEuMR27wNFjW+EI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.24.71]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LzJyr-1iQYAo29SL-014ThV; Fri, 09
 Aug 2019 20:01:43 +0200
Subject: Re: [PATCH v2 5/7] quote: add sq_quote_argv_pretty_ltrim
To:     Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.298.git.gitgitgadget@gmail.com>
 <pull.298.v2.git.gitgitgadget@gmail.com>
 <5059776248b6686faaff37c97aa63d0212579cd8.1565273938.git.gitgitgadget@gmail.com>
 <xmqqh86rfs70.fsf@gitster-ct.c.googlers.com>
 <7dbee619-2495-6426-b02b-49fd59e4f028@jeffhostetler.com>
 <60c7b26c-e598-182b-421e-bdf5c0a8ac9f@web.de>
 <5651286b-cd28-68ba-4743-98d546dfa3b0@jeffhostetler.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <b3cf1b32-9e80-c9c5-ac9c-33f68ef8909d@web.de>
Date:   Fri, 9 Aug 2019 20:01:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5651286b-cd28-68ba-4743-98d546dfa3b0@jeffhostetler.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KUDHzx8RHfSiNIx/KmXXRbgumHFM9e2qNFmC1gNxhFa/ggqm9k5
 Xd+7Ou9/7PZiQy2gBNqpa41u4eo03aIO6qrygLeiFIm/xdk+ZQBdWEMByUAtskop0PaRaTf
 7txpdmvZ1h5HOkmtJl+vtb+ZgCwwlcm3acF83Y+4We9+55A5EfPVi9cHVnyV4HeHMDbFLtq
 gxOp7/d7NDY7kSnv3og4g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MXYTE6fq4AI=:pT2KtCbHZuIOKNCSGB04Iw
 emEQqTU/UiccgyyvqK/zDVwDfio9jlODeeQXkzCvWzDYZuQJU5sAuwH+nI2t4ERC3Z4QYf6KI
 r0XcAXs8ThJ49R7tcbGOp+3Ol9tcywRJhiEhClrENeo9H2x3Xbt6JaCGYFR2CwMsIgwJ3EKzw
 VQ8FxS4zpeaCMvSkCGQeUZJs9lK6mexnzteNpff5dp7hgG6tCJEa4FNEK3tA+MCJAHxOBnnG8
 LlXqGrF4VWcY5+wbfouABFIWIbzGGrzhIuZwy3nBqXfEXUxwz8axLmUzogjp7wuGL+BwmwllA
 qQbcqfJzAxadESCtDXxhWButbKFJ0W6HElcGAda76DrQbAn6giwauTpPtXWgIm7936mFjwneZ
 a92T+FSor3gk117PuHBI311fgJhd0Up9rXuz6xjyNAg3H3AN8Xr6AExqXCyNauqFq59iIxZta
 xZ/z0gQwHhbkpT0I9UK9Xs+BybzVFMtguIMpYVWqRSG7d7nUftngOAEc4QGaUgh6E0qNpuEdk
 IDKfBKEe3o8JAEWDyL8qAVeq2vi439e3qaNqTnFoJr+0Qhgm+oD8tzWjfcqYgpCMDxDB7BHpB
 3lXqHTCTaq5fiuyyAQgPZUAq1iE3IP6vP8PCsktGU4SUxKD7lBU+52LMBu6ZaR7cXgOBy1YyE
 mmeumiSCgiMyzRUW9vV0qqj7eJKeLKOi0tGNSzTdDH5ijh7evp0W7zGHhYqVVT3OhhbkATJAP
 thjUqS7iGj5hTXcit1cEV+iiAByBAOM8QAh2/M6X2cj+UVM3ja3ynBElyP25vTMdRhAyt1Gzr
 GGS887b5ds0koTjt1jc8F55MNPSYBfglAADMLDFkB1ma8njfh8JUryJ61dRCOivyAafUhZ0m1
 vi2tcJlTm0gG1LK/C5BoPYO8BeO1KMUUSkF08U7I2xzEB/8AaOa6Fcd44QvWdSZWiOxblxTrn
 QSnA7zRgl8SSV8kn35Or1SzqLQVDTCjFWkO/YDIyss+FAPkOgR8iai8htOqTjt5AEDVb2mPG8
 IpR+RxLRvtac+9RimWYCCd7FV2WX/Bft5SspI2xglehrnoarPf60mftyNZXd8ADnqVb8Gn9N8
 A+N4YbkkgbxCjXciQtIeqCQp17XvJhT2lZnolQjZwo4pJmQrTWMM2rLq0eIVn0q3J3rnZ2Oje
 FUHDE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.08.19 um 19:13 schrieb Jeff Hostetler:
> On 8/8/2019 6:49 PM, Ren=C3=A9 Scharfe wrote:
>> =C2=A0 void sq_quote_argv_pretty(struct strbuf *dst, const char **argv)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 int i;
>> -
>> -=C2=A0=C2=A0=C2=A0 for (i =3D 0; argv[i]; i++) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 strbuf_addch(dst, ' ');
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sq_quote_buf_pretty(dst, ar=
gv[i]);
>> -=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 strbuf_addch(dst, ' ');
>
> If I'm reading this correctly, this has slightly different behavior
> than the original version.=C2=A0 Perhaps:
>
> =C2=A0=C2=A0=C2=A0=C2=A0if (argv[0])
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 strbuf_addch(dst, ' ');

Oh, yes, thanks for spotting this.

Ren=C3=A9
