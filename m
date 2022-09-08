Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A7CC38145
	for <git@archiver.kernel.org>; Thu,  8 Sep 2022 17:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbiIHRKl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Sep 2022 13:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbiIHRKj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2022 13:10:39 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212488A7EE
        for <git@vger.kernel.org>; Thu,  8 Sep 2022 10:10:39 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id v15so9592325iln.6
        for <git@vger.kernel.org>; Thu, 08 Sep 2022 10:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=gT7TMdwCnuphaU9+2uomy34OYbcQKPfsqUp7hsuVWhk=;
        b=B4zqRPcgmHQKzHofAbfPryrxj8CKxUXU1ZWLcnjxT1Xb6vUYW2f3K/4Hl04sKtBANV
         1r0iKGzl/26xX172kepU1gPUZrxHc7suhyXhG7dXroHf1AoJ2SqnKWS3szfWJhJOIeai
         EbIXY9LZXOCqvfTwlJvkNxvgwzBtw1RutYLSyvztTd5zbmFzPRFECkFDGShuXSR2mIL4
         rDx06XyLywiZdilnycvE9J1WP28299omtulqYEKKQuILVK11GWRo77j+bVxqcupI09ej
         1tEBDt4A6qZMetBouGbeXwqnVCR9n+5EQP9pfhXR1GpGzS2MiNz/HJsI9LUjUAf4yAMv
         wxaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=gT7TMdwCnuphaU9+2uomy34OYbcQKPfsqUp7hsuVWhk=;
        b=djdH9Q78xtCFDQblwLOTGH9oSzGLXZjeu+EZ12uYBhbs/sJWorPKSulGDKepTHc3Ol
         dQZjPfaogoDvrKetZuqk4btZv9Dw1Q5Of/5m1MNmgz0/PKn4VhxoCtSKqmPel1pkG2u0
         NIjLDChFCgeU1Df3fdaYJSFvHBxzPjjowhDsVklDJ/aeccHrDDR2h877GbFChCzV++iZ
         ioX2tFoziiTff6we0vfihNpjXYfFukNZcVoUetAhLW9MjS9SGw8MEQr4LxcUuKStrl6p
         i/kRdjt1Z0YOkKhVzgCRn00zuwc0iXs8R1bB5RPndsoGw01qHdYpWQxeLPk2YL/5Rzi5
         ZOmg==
X-Gm-Message-State: ACgBeo123W7pLztd3vSkKqsIGSWtuFce1OufynpyPP2Y6LAUjLJCrUrE
        3naWSMRwwaQ6pE/QyJ8x3VqSgxE0VXBe
X-Google-Smtp-Source: AA6agR4TF9x4NZwLhAhDdQppmas8DKXa3XdzrQXre4Hhoh4tJWsfiU9qaR6qJ9RXzwqV7RL15cdrFw==
X-Received: by 2002:a92:d307:0:b0:2ea:f008:162e with SMTP id x7-20020a92d307000000b002eaf008162emr2385592ila.65.1662657038396;
        Thu, 08 Sep 2022 10:10:38 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id u63-20020a022342000000b00349fb9b1abesm8553955jau.106.2022.09.08.10.10.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 10:10:38 -0700 (PDT)
Message-ID: <c6e4fd5f-b85e-2108-3212-21604e6db986@github.com>
Date:   Thu, 8 Sep 2022 13:10:36 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 7/7] bundle-uri: fetch a list of bundles
Content-Language: en-US
To:     Teng Long <dyroneteng@gmail.com>, gitgitgadget@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        me@ttaylorr.com, mjcheetham@outlook.com, newren@gmail.com,
        steadmon@google.com, tenglong.tl@alibaba-inc.com
References: <7b45c06cc9e0294311d9f00d40eb1fa4f8f146f9.1661181174.git.gitgitgadget@gmail.com>
 <20220905125050.83312-1-tenglong.tl@alibaba-inc.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20220905125050.83312-1-tenglong.tl@alibaba-inc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/5/2022 8:50 AM, Teng Long wrote:
> 
> Derrick Stolee <derrickstolee@github.com> writes:
> 
>>  int fetch_bundle_uri(struct repository *r, const char *uri)
>>  {
>> -	return fetch_bundle_uri_internal(r, uri, 0);
>> +	int result;
>> +	struct bundle_list list;
>> +	struct remote_bundle_info bundle = {
>> +		.uri = xstrdup(uri),
>> +		.id = xstrdup("<root>"),
> 
> Very readable code, thank you very much.
> 
> I'm a little curious why we use the "<root>" as the init value of
> ".id"?

In this case, we need a valid ID to initialize the bundle list (since
it will add the remote_bundle_info to the hash set), but it is
considered the info "above" all other lists. We could also specify an
empty string here, but we just can't use NULL.

Thanks,
-Stolee
