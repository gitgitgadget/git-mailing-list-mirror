Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47FEC7EE22
	for <git@archiver.kernel.org>; Wed, 10 May 2023 07:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236429AbjEJHKu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 03:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236439AbjEJHKp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 03:10:45 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DD2421D
        for <git@vger.kernel.org>; Wed, 10 May 2023 00:10:44 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1aaf4334a67so38980115ad.1
        for <git@vger.kernel.org>; Wed, 10 May 2023 00:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683702644; x=1686294644;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EVR9EDCoAUfzw0eQV9p2CO5IhMmiD2kOX6LrAWk7mHk=;
        b=PsIhlGus0uNtETa3ZhkaIx2+Sxg0l88gB6pZSe1zICFM1zJCyT2G5xrKPxK5hmnGDz
         GdhlkI5D5W6/6EkiKwR46Fu8NQGlfqUSkc4L35gRn3HJ/HFdQWVxNaGIyZzKSe4aEIaz
         1d493pxuoO3/6kPj30W4U+rpCEQUWY3v64NwFAtJf8X4fb5Q5zvoZrqHnN6TOcbbmAkj
         Loe6pG3T/KGprmOj0uQr/zp4VQTkp7hgg6ZoBqbEX/lJ5CyABQRat/lNHoJLq7R6Vtq9
         i/Af9BDQZBiy/ApkDkTl6YDDjccUYvuQmplJNmroJGs9Suw7kxJcmGTdA5xHfGrqzx8E
         WGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683702644; x=1686294644;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EVR9EDCoAUfzw0eQV9p2CO5IhMmiD2kOX6LrAWk7mHk=;
        b=KvGCLPSKAJA3eutp35JZyUaP+Lc9Zr6ttoOfq5lM05vLfYD5V+yTXpyiSlZxIQNNYK
         wPSSQ1So7ZzvrgIpuCST1D+piedcg59if2GXROTwJT1ZVux3g4FK9Z7CSR5aKOvJC/kL
         YOiPIUDHaZ7n3WgpvDd8JMsVk6yU9RqnKUTGjJdGPTa7AvT1iU5GkIqOcEM5ZSaJIiFs
         d9Hv0rjMF26ByTZwloYzcvRjtA4DUv6C0fo8LP7YviLuGMZFCY7+81faFbLyBMXwoKZ/
         9/qCoDPGoo+/arK0suXmc6kmUTVejhvciTySL5hC5ensfsweSuSQ2Yg1uu2cWI1yu4Ft
         PXiA==
X-Gm-Message-State: AC+VfDwB7+JMEEgAcDV0ddGk5MjFPCY9IHKhBfnSBbDvz4UbUk8Vqawo
        MoCvgLwVZ3+RBG2KvJlbAe1B1nDc5IU=
X-Google-Smtp-Source: ACHHUZ7ZH+cw7GCxYKk1MqSXfhNsh7mHeVIVT8E6YZtt6nSumPLRhnqbs4DnKc/B3n2Snp9GjYPwEBBdWmQ=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a17:902:c115:b0:1a6:d9db:9382 with SMTP id
 21-20020a170902c11500b001a6d9db9382mr5660786pli.11.1683702644373; Wed, 10 May
 2023 00:10:44 -0700 (PDT)
Date:   Wed, 10 May 2023 00:10:43 -0700
In-Reply-To: <xmqqsfc6mwok.fsf@gitster.g>
Mime-Version: 1.0
References: <pull.1506.git.git.1683566870.gitgitgadget@gmail.com>
 <1ac58b0b07c21fe4494f5fbe5d4b0f9bc1a49ac0.1683566870.git.gitgitgadget@gmail.com>
 <xmqqsfc6mwok.fsf@gitster.g>
Message-ID: <owlyednomzkc.fsf@fine.c.googlers.com>
Subject: Re: [PATCH 09/11] doc: trailer.<token>.command: emphasize deprecation
From:   Linus Arver <linusa@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

>> From: Linus Arver <linusa@google.com>

>> This puts the deprecation notice up front, instead of leaving it to the
>> next paragraph.

> Shouldn't the opening text of the next paragraph be tweaked in the
> same commit to avoid duplication?

Good call; will do in v2.


>> Signed-off-by: Linus Arver <linusa@google.com>
>> ---
>>   Documentation/git-interpret-trailers.txt | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)

>> diff --git a/Documentation/git-interpret-trailers.txt  
>> b/Documentation/git-interpret-trailers.txt
>> index 5ca758e363f..c9b82ceba34 100644
>> --- a/Documentation/git-interpret-trailers.txt
>> +++ b/Documentation/git-interpret-trailers.txt
>> @@ -234,7 +234,7 @@ trailer.<token>.ifmissing::
>>   	that option for trailers with the specified <token>.

>>   trailer.<token>.command::
>> -	This option behaves in the
>> +	Deprecated in favor of 'trailer.<token>.cmd'. This option behaves in  
>> the
>>   	same way as 'trailer.<token>.cmd', except that it doesn't pass  
>> anything as
>>   	argument to the specified command. Instead the first occurrence of  
>> substring
>>   	$ARG is replaced by the <value> from the trailer. See the
