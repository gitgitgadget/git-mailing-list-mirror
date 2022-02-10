Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13EDCC433F5
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 01:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbiBJBXg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Feb 2022 20:23:36 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:43678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbiBJBXd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Feb 2022 20:23:33 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3C51EEF5
        for <git@vger.kernel.org>; Wed,  9 Feb 2022 17:23:30 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id r27so4440003oiw.4
        for <git@vger.kernel.org>; Wed, 09 Feb 2022 17:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=luBKkWlxg/AKllEqU/x/YOr2VdI6MMftnacC0bS30X8=;
        b=cISAKOgZiCzpt3yPkv1xqsQsppmU2ztOSxhFzEI5ElckKS+voAyj0+YyXudFYEl2hz
         c9Jy5HTwh139dD7L9Hz0OnV/dfGXGuXQbsvcThbLJWOFiNz8bd4jftqaBGoqt8xgRb62
         D89rtAaScnGv7RtkFb4tNGwlasNGkvd7nPGMz/+iZJW2X4QygRsmbrnZnvThpId6YWgJ
         p9W88UXw6e2P1UCtqTNdpsA4hpaa5aEfjke9cdvHOnFDPB8JiAvX0IyU31t0vD5KmExx
         7AK1sHPXsPYG88o8OiMhXon0Ky6jRkE/7aOb14KIiBLBvpNLhRuGQY8ZAlTNVbYGOKsw
         Ic6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=luBKkWlxg/AKllEqU/x/YOr2VdI6MMftnacC0bS30X8=;
        b=iSIT0NlFmoPiQmQ44WJ56y6aGpw6eN7gnzREKaX7W4zGYTEBmRdI7ah9Vmf4lo8i+t
         MQagJqsWIPekb0d+AmxFjUY/gqAlUmuTsP/ILuaFqmtn7hbyyDmeCL15sSMEMssCjiho
         HxBamekX9RXhblB3w7UyqTylpCYOyntRSeXDHLd973noSdYrgmMSdVEsVHwCizsJmkf2
         GgEQKDLMnagCMizzEbwAIic9J5pPP2iteE+ai51p0uAG589El6+yaG7I5ssd6EAo7yrv
         GErPGcxIIypvqtKRbkwLwOpuGeQBPanmVrl0aLzx46/44c0sEpb3xkUiqMMEu4YDMnP8
         AmdA==
X-Gm-Message-State: AOAM531QIMJFQZhiILW7HhhPp+0Ixk0kj+Se4oFkvPceuSOyuPdPKS59
        LhELzMaJjCMagY3KSJVMaNBnCBtKJ3A=
X-Google-Smtp-Source: ABdhPJxy8nnuEym25794Iih0nTBj5KXSKUEXbbHUlSNi8u9CtZ7qswcestNBXo57AutQw9roXFHR9g==
X-Received: by 2002:a17:90a:8b06:: with SMTP id y6mr131357pjn.214.1644455892586;
        Wed, 09 Feb 2022 17:18:12 -0800 (PST)
Received: from [192.168.43.80] (subs02-180-214-232-83.three.co.id. [180.214.232.83])
        by smtp.gmail.com with ESMTPSA id u17sm14736434pgi.14.2022.02.09.17.18.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 17:18:12 -0800 (PST)
Message-ID: <81e8a217-356d-65cd-3a89-f20ef9c1a5d7@gmail.com>
Date:   Thu, 10 Feb 2022 08:18:07 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] t/t0015-hash.sh: removed unnecessary '\' at line end
Content-Language: en-US
To:     Jaydeep P Das <jaydeepjd.8914@gmail.com>, git@vger.kernel.org
References: <20220208092339.651761-1-jaydeepjd.8914@gmail.com>
 <20220208092339.651761-2-jaydeepjd.8914@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220208092339.651761-2-jaydeepjd.8914@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/02/22 16.23, Jaydeep P Das wrote:
> From: Jaydeep Das <jaydeepjd.8914@gmail.com>
> 
> The `|` at line end already imples that the statement is not over.
> So a `\` after that is redundant.
> 
> Signed-off-by: Jaydeep P Das <jaydeepjd.8914@gmail.com>
> ---
>   t/t0015-hash.sh | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/t/t0015-hash.sh b/t/t0015-hash.sh
> index 291e9061f3..086822fc45 100755
> --- a/t/t0015-hash.sh
> +++ b/t/t0015-hash.sh
> @@ -15,7 +15,7 @@ test_expect_success 'test basic SHA-1 hash values' '
>   	grep c12252ceda8be8994d5fa0290a47231c1d16aae3 actual &&
>   	printf "abcdefghijklmnopqrstuvwxyz" | test-tool sha1 >actual &&
>   	grep 32d10c7b8cf96570ca04ce37f2a19d84240d3a89 actual &&
> -	perl -e "$| = 1; print q{aaaaaaaaaa} for 1..100000;" | \
> +	perl -e "$| = 1; print q{aaaaaaaaaa} for 1..100000;" |
>   		test-tool sha1 >actual &&
>   	grep 34aa973cd4c4daa4f61eeb2bdbad27316534016f actual &&
>   	printf "blob 0\0" | test-tool sha1 >actual &&
> @@ -38,10 +38,10 @@ test_expect_success 'test basic SHA-256 hash values' '
>   	printf "abcdefghijklmnopqrstuvwxyz" | test-tool sha256 >actual &&
>   	grep 71c480df93d6ae2f1efad1447c66c9525e316218cf51fc8d9ed832f2daf18b73 actual &&
>   	# Try to exercise the chunking code by turning autoflush on.
> -	perl -e "$| = 1; print q{aaaaaaaaaa} for 1..100000;" | \
> +	perl -e "$| = 1; print q{aaaaaaaaaa} for 1..100000;" |
>   		test-tool sha256 >actual &&
>   	grep cdc76e5c9914fb9281a1c7e284d73e67f1809a48a497200e046d39ccc7112cd0 actual &&
> -	perl -e "$| = 1; print q{abcdefghijklmnopqrstuvwxyz} for 1..100000;" | \
> +	perl -e "$| = 1; print q{abcdefghijklmnopqrstuvwxyz} for 1..100000;" |
>   		test-tool sha256 >actual &&
>   	grep e406ba321ca712ad35a698bf0af8d61fc4dc40eca6bdcea4697962724ccbde35 actual &&
>   	printf "blob 0\0" | test-tool sha256 >actual &&

Looks OK.

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara
