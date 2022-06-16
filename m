Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE09C433EF
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 13:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbiFPNCc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 09:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbiFPNCa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 09:02:30 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3739C7A
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 06:02:28 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id b138so1370163iof.13
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 06:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=v1ZSqJyBAKPVYIpq6KluD/NoeWNKk28dlg+W39r2yiM=;
        b=aY2XQl36wug59LXMIFBBoxXRXV11xTtp38d9hALoXG7QApvkNF+SQWO66hSPaRbuTx
         8icbAz9eeEFowADSHiRf9h8RM2THS+6JaGmkVsaO+0Ez47/nyBO48YjHlw7AIb0XkSt8
         bgixX40UBVQK6RDnaYn5m01gg4fYiS0udB0Om5RkcbkiLEL4XhqIvCYxlpImCfVKFb8A
         9gPBzsIKxZn2wErOGj+Jf8S1wO7ydUwfrfGld89+H/Fp8hNibG23LjvitdtZgLjJr58T
         yP1OUwI4dMPzoG3gxsxnW8PK5GgyZypPTTlB+qJRpuY7p4i0/iZV3gGmNlqQBMlSpwjF
         6v6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=v1ZSqJyBAKPVYIpq6KluD/NoeWNKk28dlg+W39r2yiM=;
        b=Q88ZdZUFw5KrpSPMvTJT6ku4mJS3KXUplX7rxXICwev66XSlh4am6EjfxzRJ7q5yhq
         DLG9ErHOVJJYb03wpjAfpzU84E+Bca2xrzkM67nFrg5QfkZ//daiLUEKfYp1z7PWyuWJ
         W1PIHs7gPrnE+g5yTi29SjyuY2p3USpVFoWzczRMPHnm9Qi0qRKRVZcdn0NFHSqr2SeS
         6w+ds4w6U2gcc/yxZunK50D/n+9VD2OQpHyvkDGIwbSByU6obYm/iNajk7NsP49OB0ij
         0LOVv5PKdDe5g+WK/M/sf9oSTUJpSpSbkiuhbaJMdRURCDPWzQrM6zsKCG2pby7NYv2u
         wzhQ==
X-Gm-Message-State: AJIora+tjNCWh7sIS20lt4haqtKzwZBJ/T7v8OIDXpIauSX5+Rdpgg+0
        49OBgzA47poGhFABchf4kbXr
X-Google-Smtp-Source: AGRyM1tknSrgZ/Ha+if7Iss22qNrfOLNwfHgnQ1wGhMaiOV8wvLO4EMkHbfHoTYqD/6A8Uq5hBNrFg==
X-Received: by 2002:a05:6638:31c2:b0:335:dd22:83ec with SMTP id n2-20020a05663831c200b00335dd2283ecmr757768jav.88.1655384546372;
        Thu, 16 Jun 2022 06:02:26 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:cfb:ad5:8ed2:9eba? ([2600:1700:e72:80a0:cfb:ad5:8ed2:9eba])
        by smtp.gmail.com with ESMTPSA id z65-20020a6bc944000000b00669a9db946dsm1145813iof.17.2022.06.16.06.02.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 06:02:25 -0700 (PDT)
Message-ID: <e2ea1475-ce21-ef52-7301-3ed074c40f9b@github.com>
Date:   Thu, 16 Jun 2022 09:02:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] send-pack.c: add config push.useBitmaps
Content-Language: en-US
To:     Kyle Zhao via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, kylezhao <kylezhao@tencent.com>
References: <pull.1263.git.1655291320433.gitgitgadget@gmail.com>
 <pull.1263.v2.git.1655350617442.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1263.v2.git.1655350617442.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/15/2022 11:36 PM, Kyle Zhao via GitGitGadget wrote:
> From: Kyle Zhao <kylezhao@tencent.com>
> 
> This allows you to disable bitmaps for "git push". Default is false.
> 
> Reachability bitmaps are designed to speed up the "counting objects"
> phase of generating a pack during a clone or fetch. They are not
> optimized for Git clients sending a small topic branch via "git push".
> In some cases (see [1]), using reachability bitmaps during "git push"
> can cause significant performance regressions.
> 
> Add a new "push.useBitmaps" config option to disable reachability
> bitmaps during "git push". This allows reachability bitmaps to still
> be used in other areas, such as "git rev-list --use-bitmap-index".
> 
> [1]: https://lore.kernel.org/git/87zhoz8b9o.fsf@evledraar.gmail.com/
> 
> Signed-off-by: Kyle Zhao <kylezhao@tencent.com>
> ---
>     send-pack.c: add config push.useBitmaps
>     
>     This patch add config push.useBitmaps to prevent git push using bitmap.
>     
>     The origin discussion is here:
>     https://lore.kernel.org/git/b940e705fbe9454685757f2e3055e2ce@tencent.com/
>     
>     Thanks, -Kyle
>     
>     Changes since v1:
>     
>      * changed the commit message
>      * modified and added missing \n to push.txt
>      * used test_subcommand for test
>      * modified "if" statement for "git_config_get_bool()" in send-pack.c

This version satisfies the recommended changes I had from the last
version. As long as we think there is a benefit to having this
additional knob over just pack.useBitmaps, then this is good to go.

For my part, I think having the additional knob is less complicated
than requiring all users in this situation to shift from "push" to
a "fetch" (from the other side of the connection).

Thanks,
-Stolee
