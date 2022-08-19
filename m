Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FB6C32771
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 19:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350263AbiHSTE2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 15:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349154AbiHSTEX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 15:04:23 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25CECACA4
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 12:04:21 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id o2so3990739iof.8
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 12:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=cgINUY2Hn2T9rUtSGHlkzuSvvsRYDNFwht6F4GWdU5c=;
        b=JElkoEEYyM/U/qVNIY9puUMPNG8KvdBMo7KOFtA/inveubmSex+lCpaUHUvtFvxByF
         HVNPuc1x7Vyyi80KS8k8hp4DksG8VSqA0VTCpCmW8WElkFUMgRKI/oU+19GkM2bM4Hzn
         iWOEBVNnB0UoPMeX/yYspO/DDkQfOpG+yvMy83lmlW0hOnLz4fSEV0EToKnJx19c+vZ+
         ALlm4/MfnrEzm8Dt4/MPiHFoy48vpYDDqVDgxikNqQKmVouzYts3LNed9Vx0T8ndTgkW
         MmuuyiXU/T0Qhy6zEgjIATgvYCFlBXm1ENwsp6zXP8kigcLxoB+CmLzDSuJPjqrOiXcK
         Ep8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=cgINUY2Hn2T9rUtSGHlkzuSvvsRYDNFwht6F4GWdU5c=;
        b=Q4oPO6HfXiAyVJVuyj3iRSTX2Kg0uZgJDgKjZhx9xEihp4oniERTrGa5kU2CLhZQWV
         3es0SedzROJveSy2isJ6+RP14LXvyFRJxqlNIzC1IGXq9j0wj8cVoZisYqMEpe3/8bFD
         ZlKI8o+uRxy3tr+xk75vJFPrh4Xc2gnUB6B0OItrxFI5DaWpCBfGwn29B3vAbe5H0+5P
         R/uMgHdpqHnLiix2LmjJmNFP3dKMQvL2MRcBkzam3jJOqZ7tBeoc3WuLMw9DZavUe9Hu
         9S4SFMzrNm35Lo8Sijn+tibS5JZjNI979cIynbiu4YJI32+1OVQRfAayY54VIO3GT4gq
         OgDQ==
X-Gm-Message-State: ACgBeo2ZCUYzBAuNLBFmk2XMTpFMEld7SfEclW/1HPUhw9K9+96Zp2Hw
        XwkBTkbXTon+MX2jLmVoO0UREkKipsUi
X-Google-Smtp-Source: AA6agR79frG/NXTzV0g8F7t3bZLcJsloF26ZOcz6ZZ+7dlEA1s0MS6rWMMekpJlRrN6zs3l/h/mTTA==
X-Received: by 2002:a6b:6d0e:0:b0:689:21ec:3267 with SMTP id a14-20020a6b6d0e000000b0068921ec3267mr3846918iod.143.1660935861258;
        Fri, 19 Aug 2022 12:04:21 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:55ca:650:1968:6180? ([2600:1700:e72:80a0:55ca:650:1968:6180])
        by smtp.gmail.com with ESMTPSA id j26-20020a056638053a00b003434de98f1asm2083840jar.28.2022.08.19.12.04.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 12:04:21 -0700 (PDT)
Message-ID: <cbbfbbdd-94de-d981-804b-fe199ca49754@github.com>
Date:   Fri, 19 Aug 2022 15:04:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 4/6] verify_one_sparse(): drop unused repository parameter
Content-Language: en-US
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <Yv9Oay+tNqhLDqVl@coredump.intra.peff.net>
 <Yv9O+HDMLKglLcqY@coredump.intra.peff.net>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <Yv9O+HDMLKglLcqY@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/19/2022 4:51 AM, Jeff King wrote:
> This function has never used its repository parameter since it was
> introduced in 9ad2d5ea71 (sparse-index: loose integration with
> cache_tree_verify(), 2021-03-30). As that commit notes, it may
> eventually be extended further, and that might require looking at a
> repository struct. But it would be easy to add it back later if
> necessary.

The good news is that 'struct index_state' now has a pointer to
its repository, so we wouldn't need to add it back in.

Thanks,
-Stolee

