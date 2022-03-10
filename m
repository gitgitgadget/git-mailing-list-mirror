Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C04FC433F5
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 16:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239917AbiCJQaj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 11:30:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236841AbiCJQai (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 11:30:38 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6EE4C7A4
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 08:29:37 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id t187so5171799pgb.1
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 08:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PkMqv+EfV0+THxAOZYyTQqrtOpzy6lNtffxrXQSig7o=;
        b=TmFAjJHoaKczNOMhjXw4GZHnwgeby4GXiwBc4p+ZGWYXfx8vWemUIBNFFNFuQEBPZy
         Ihe973V3YyHLD8RNgTmbU1RsUujvoxrdV9EdeVDa30nd8sPYSWMlroE2zUXe78IM6Hgc
         Z3woOGmhOT+2rDvPm/MPISRCjeda5oTyO2zhnFWSefgehoQp6plsb0DFCrk7v3rQSp+6
         qPC4tTEniWi4FKny9PQTKhnYVVWttF0fWowj4n86oKsbp9U+r8y1Z3hVsoA1Ps+lKpXA
         oigQbprBqkBzPKv4Il/NO921hbTGSVfUZJ1jcpLJaog3VbufuLBeWBA4aYpjN/UisYTW
         OLHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PkMqv+EfV0+THxAOZYyTQqrtOpzy6lNtffxrXQSig7o=;
        b=s7dDoU28WUx7FqHyiAb8moMVYIHQYUMVmcJh+le7/LL1F3ku98LZkUakevF44cLWQQ
         K3g2bEnbzVr/qZDyBX9CJc1mb+n9DQUvXp3natJfea82cIv9nzC7JURbbOvkgmuYm8FD
         eDnMUKLVVZd8nkqEiolSjK3FXEXsYWF96e9HMgUjeOPeqzMAXjq2f+kApwu4VmFpiISE
         ESpMVzznHjl+06g5oetyg8UE1ZbZpXyyQqX4ssWLqiouTThJos4GPBT52r3KqP6uIL6F
         RhgbjVdBMr2Cs/TaOV4GCsq1TOxwGz9kAtCP42l2D/fxdQpCwadAnvgEEuc1a6DTZFcE
         yKug==
X-Gm-Message-State: AOAM530fwT/SwSQOr1f+g2Ze3FEBV9aOne59eAA9Nc6LewJL6euZh8M+
        rJVsSJZ86YYTYeAwIH3w1s2mbPgOECbhBg==
X-Google-Smtp-Source: ABdhPJxNtliDtNt90lUm5rXiw/t5vj3f8UFlD0w0q6tbzsio1MWZjtxqqEB6Rvi4wAJM4mEvkJVImA==
X-Received: by 2002:a65:670a:0:b0:37f:f344:76c1 with SMTP id u10-20020a65670a000000b0037ff34476c1mr4741757pgf.204.1646929777077;
        Thu, 10 Mar 2022 08:29:37 -0800 (PST)
Received: from ?IPV6:2405:201:a800:4df9:5194:c9b1:2d1f:598e? ([2405:201:a800:4df9:5194:c9b1:2d1f:598e])
        by smtp.gmail.com with ESMTPSA id h7-20020a056a001a4700b004f70b86fd28sm7602138pfv.134.2022.03.10.08.29.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 08:29:36 -0800 (PST)
Message-ID: <64677295-e7fd-ba4b-ce68-fe62132ca504@gmail.com>
Date:   Thu, 10 Mar 2022 21:59:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5] userdiff: add builtin diff driver for kotlin language.
Content-Language: en-US
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org
References: <20220301070226.2477769-1-jaydeepjd.8914@gmail.com>
 <20220306111539.336475-1-jaydeepjd.8914@gmail.com>
 <8799cd42-bb05-a827-187d-33fb03565f21@kdbg.org>
 <cf8a9316-c81e-2477-a565-1c38a168fc67@gmail.com>
 <72aca675-4c65-36bf-1337-34b2d1f40bb4@kdbg.org>
From:   Jaydeep Das <jaydeepjd.8914@gmail.com>
In-Reply-To: <72aca675-4c65-36bf-1337-34b2d1f40bb4@kdbg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/9/22 00:02, Johannes Sixt wrote:
> Am 08.03.22 um 17:54 schrieb jaydeepjd.8914@gmail.com:
>> So, the final regexes are these, right?:
> 
> Not quite.
> 
>>
>>       "[a-zA-Z_][a-zA-Z0-9_]*"
>>       /* hexadecimal and binary numbers */
>>       "|0[xXbB][0-9a-fA-F_]+[lLuU]*"
>>       /* integers and floats */
>>       "|[0-9][.]?[0-9_]+([Ee][-+]?[0-9]+)?[fFlLuU]*"
> 
> This would not match 12.5 because you allow only a single digit before
> the decimal point. Perhaps
> 
> 	"|[0-9][.0-9_]*([Ee][-+]?[0-9]+)?[fFlLuU]*"
> 

The problem with this approach is that it matches `2..5` as a single token.
However in Kotlin, `..` is used to specify a range so 2..5 should be broken into
2 .. and 5.
