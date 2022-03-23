Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F58C433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 13:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243722AbiCWNM2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 09:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243354AbiCWNM1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 09:12:27 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263D55881C
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 06:10:54 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-de2cb87f6aso1589651fac.10
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 06:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=t8vK4uiJ7hhTTMrXIUhHkeIL3o5r6g0UxOmstb7zR5k=;
        b=hHpeOUxQl+Ilf6DbyK/rEo1r6Ze3ownPxFiqCLxOgvypMsYHeCPYAd7fBtn8elDCIj
         9Ol0COA+6oJYOWMeUkpbKjiV9bA4LuSs6ZDZgwJdjjIkrTJRRQpy2bznUcUpSf/IOzX4
         uI3Vd5ESbT9kvIJ5Ooh6uaHh8lb95HgdqabI+/exypTlCTjEjGQFe+GIOUQR9WHGX+tr
         I00DVbjjaMEtjR2surUhoxlDU3nzCAx34wCMHHMsqBrubZs+bNoBBcJCAZGxclw3yznP
         s23YqiOGSVf1ak0b9pHeaUykGxGTdrC2Uv1yJm5SPommy/c6iOC/VX4ofQsnzl9xO+07
         sb5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=t8vK4uiJ7hhTTMrXIUhHkeIL3o5r6g0UxOmstb7zR5k=;
        b=FZkAcg5hR/i77GuZry9VJaI/w/gW4138gIYNwgDQMRMquSJTMKQ+l16ZXP8ugp55Z0
         Z+Es2UfEt5Ejb07/CaSWW4KzhcfQRH7pefS899xQk1P17jDvawUm7dyEJ3PSziwH+QGR
         Ipv3D9/UrRgAwtQf/UzjqpprL63o7QJ/pu5irQhlqW9bMRWcAyFudPDkxl7QNpK3jHmL
         KMFHqRaD/R4FZNI5uN8HVQlTm1qBkQp6h9/xf+I0VhIAH/xZqIGHje2ynZNGyH+ukC2S
         vhHDd69QUWxFjMnbKZ79YfkuRTbku6YFbgDjO6Z4o8WwGH1TAxpmELCE+ZnubLhB6W70
         lmHA==
X-Gm-Message-State: AOAM532wdZeRjammLJ4+prtn7z++/4Qdi9LHjYddUB2KUONorVibfGzd
        RX6NG9gTTgv5xcswI87I28e8
X-Google-Smtp-Source: ABdhPJxi6EJZbgMCFGDYm7WzLFa+/HbTZmtoVkwcggCfRVoEcrgI/RgID/GxM+As2xyooN8bcYKLfQ==
X-Received: by 2002:a05:6870:5687:b0:dd:d21b:4e54 with SMTP id p7-20020a056870568700b000ddd21b4e54mr4189275oao.184.1648041053362;
        Wed, 23 Mar 2022 06:10:53 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id x6-20020a9d6d86000000b005cdb017ddcfsm58534otp.41.2022.03.23.06.10.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 06:10:53 -0700 (PDT)
Message-ID: <e61303b8-10ad-5b5b-d48b-cac89ac53d29@github.com>
Date:   Wed, 23 Mar 2022 09:10:52 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH 1/1] mv: integrate with sparse-index
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        git@vger.kernel.org
References: <20220315100145.214054-1-shaoxuan.yuan02@gmail.com>
 <20220315100145.214054-2-shaoxuan.yuan02@gmail.com>
 <1ab24e4b-1feb-e1bc-4ae4-c28a69f77e05@github.com>
 <CAJyCBORDOJUwTzOC+hYwGGPUBCXST0_mBdwRLh2N+cA=5k0d4A@mail.gmail.com>
 <675c7681-c495-727d-1262-ee8c6a5c8ce5@github.com>
 <CAJyCBORfAV_TV6DrOxgim4KtU9T-uTibOaQCsJZsi5_FQfci1Q@mail.gmail.com>
 <97a665fe-07c9-c4f6-4ab6-b6c0e1397c31@github.com>
 <xmqqo824cbxl.fsf@gitster.g>
 <e127dadb-7b44-55f8-16ea-9fcf94905db8@github.com>
 <xmqq8rt3xgmb.fsf@gitster.g>
 <b64c1805-dff9-3fd3-1e5e-84bd68d4b058@github.com>
 <CAJyCBORkauHAdDiHjQ2Agj3bNhLNPtKk-VW5=bNmBfNuQtv7hA@mail.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CAJyCBORkauHAdDiHjQ2Agj3bNhLNPtKk-VW5=bNmBfNuQtv7hA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/22/2022 4:38 AM, Shaoxuan Yuan wrote:
> Hi all,
> 
> On Tue, Mar 22, 2022 at 3:45 AM Derrick Stolee <derrickstolee@github.com> wrote:
>> I'm particularly surprised in how much 'git mv' doesn't work very
>> well in the sparse-checkout environment already, which makes things
>> more difficult than "just" doing the normal sparse index things.
>>
>> It's good that we are discovering them and working to fix them.
>>
>> Thanks,
>> -Stolee
> 
> Really appreciate the mentoring and tips here, I'm trying to make some progress
> now. The problems facing here certainly push me to explore more and know
> better about the codebase. Appreciate all the help :-)

A thought occurred to me while thinking about these difficulties:
perhaps it is better to start with 'git rm' since that does only
half of what 'git mv' does. It should be a smaller lift as a first
contribution. There is even a clear loop that is marked with "TODO:
audit for interaction with sparse-index."

As we've discovered in this thread, the direction for integrating
a builtin with the sparse index should follow this outline:

0. Test the builtin in t1092 with interactions inside and outside
   of the sparse-checkout cone.*

1. Add command_requires_full_index = 0 line to the builtin.

2. Check for failures and diagnose them.

3. Check for index expansion and remove them as necessary.
   (Go back to 2.)

4. Run performance tests.

(*) This step is the one we failed to focus enough on previously.

Of course, if you've already gotten really far on 'mv' and don't
want to switch context, then keep at it.

Thanks,
-Stolee
