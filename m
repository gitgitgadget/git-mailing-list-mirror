Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7330BC433F5
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 18:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238820AbhLHS0w (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 13:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbhLHS0u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 13:26:50 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D00BC061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 10:23:18 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id n104-20020a9d2071000000b005799790cf0bso3607886ota.5
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 10:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=tF/zbVUYWB01QISeb1394Tjg0+N8CgELF97G7fPRdwE=;
        b=EuS4pPN34QDojyo2RGgNO0zCIeWOfdWYtx/h3y8/vJ2rZByFOi5DG4w2ynDaemp4T7
         F3iRdH/MalCRc0mWDJlVT82z/YAxenWpc6AZr4ggmd4a1jpslv/7Sj89SQrwIzvB2Igh
         YEyYah6axN0UJj74IlCsQ4D4rJw62a2JDVS9F537YgFqklY5WoGpkF2xjtXWxew6RWOU
         wySykLpuJ0Xpg/ctn8ydnsA9qy2b9w1vJ9CuxRHOnkrQouCaI7ZBv2FGrDhEi936tFrJ
         PHW9rJw+lPAbmsW5CCKKBobBEoiTW4jdlisqrBI16xIpR9VayUz8M8svBDh04Q2ce1tl
         NodQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tF/zbVUYWB01QISeb1394Tjg0+N8CgELF97G7fPRdwE=;
        b=lAc1xEzDbCo60OQxv2Sjn1mIuxIAQNKU7OOaLPin0/FVBCzFFHaZL6AEa+qix/iMEm
         D+DW6xNgofMx1QlIBzivtUWpLIss8RuULbCz7Gjz8RyHqDaHn2bCKvQg/wOOc+VG7Mxi
         iqkHlUJlOBF7nMXNhuYkvJHzviO0MhQEVa+WnQ2uAaTQ8zr7gNJIuIbTh0horQCpXUlz
         R9LrwM4pwtc8HnP1XjUpNA1pwXV4umPZH5lTSnMEHwU8J4ZKapaixHZ0ocxFzg5lt/vA
         h59XaKH4MO3hy867O9bXVrOZ3eb6HJHQnXsxs5smc7TSctQ29gU8Fw1gbuC9KzAcMKlS
         bFqQ==
X-Gm-Message-State: AOAM533x+S5wqYtjdtFw32NePz0smnIQh93Fe6lDIKEIk7DOlsEdlPVL
        ak0Tctv7urGedJoxFu9DQ5g=
X-Google-Smtp-Source: ABdhPJwZbDOed9/SngWVODJBcT/qH4oaHHOZd7n+p7JBuGAdlzEJWxnL4ArZ1NqUmEFkrKo0G1+/mw==
X-Received: by 2002:a9d:1908:: with SMTP id j8mr1001643ota.191.1638987797340;
        Wed, 08 Dec 2021 10:23:17 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:5056:be20:f10c:bfd5? ([2600:1700:e72:80a0:5056:be20:f10c:bfd5])
        by smtp.gmail.com with ESMTPSA id j10sm596624ooq.5.2021.12.08.10.23.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 10:23:16 -0800 (PST)
Message-ID: <d1275b30-b9b0-a416-3300-9809d880eb55@gmail.com>
Date:   Wed, 8 Dec 2021 13:23:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 2/2] ls-files: add --sparse option
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1080.git.1637077083.gitgitgadget@gmail.com>
 <e42c0feec94de0e4869cda1fc6b28bd7055774e3.1637077083.git.gitgitgadget@gmail.com>
 <211123.86h7c3wrg2.gmgdl@evledraar.gmail.com>
 <03a642fc-6310-1ea4-083e-9fe4530cf761@gmail.com>
 <CABPp-BGJJM757CoOPjP=XBK-cMMGJemaeruxXSN9TEGmk+NKvg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CABPp-BGJJM757CoOPjP=XBK-cMMGJemaeruxXSN9TEGmk+NKvg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/8/2021 12:04 PM, Elijah Newren wrote:
> On Wed, Dec 8, 2021 at 7:14 AM Derrick Stolee <stolee@gmail.com> wrote:

>> Taking your idea and applying it to 'ls-files' (without --stage to
>> avoid OIDs which would change depending on the hash algorithm), the
>> start of the test looks like this:
>>
>> test_expect_success 'ls-files' '
>>         init_repos &&
>>
>>         # Behavior agrees by default. Sparse index is expanded.
>>         test_all_match git ls-files &&
>>
>>         # With --sparse, the sparse index data changes behavior.
>>         git -C sparse-index ls-files --stage >out &&
>>         git -C sparse-index ls-files --stage --sparse >sparse &&
>>
>>         cat >expect <<-\EOF &&
>>          e
>>          folder1-
>>          folder1.x
>>         -folder1/0/0/0
>>         -folder1/0/1
>>         -folder1/a
>>         +folder1/
>>          folder10
>>         -folder2/0/0/0
>>         -folder2/0/1
>>         -folder2/a
>>         +folder2/
>>          g
>>         -x/a
>>         +x/
>>          z
>>         EOF
>>
>>         diff -u out sparse | tail -n 16 >actual &&
>>         test_cmp expect actual
>> '
> 
> This actually looks quite nice, though the magic '16' is kind of
> annoying.  Could we get rid of that -- perhaps using something to rip
> out the diff header, or using comm instead?

What I really want is "remove the first two lines of this file"
but perhaps "tail -n $(wc -l expect)" would suffice to avoid a
magic number?

> Also, perhaps 'dense' rather than 'out'?

Sounds good.

Thanks,
-Stolee
