Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7AD9C32789
	for <git@archiver.kernel.org>; Tue, 23 Aug 2022 18:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233882AbiHWSQn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Aug 2022 14:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233698AbiHWSQN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2022 14:16:13 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2BC2656D
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 09:31:23 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id r1-20020a056830418100b0063938f634feso2921216otu.8
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 09:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=7pOWeRteO/ERB8Md5QtmCZDR0tUnHCp+eseMUR9r5wU=;
        b=aifPte9eiwYWe2tA25YU4iQREqkLWaVGh9oG1NGMr1gCsNXrcYRiTjiE7qQ2xgIwEQ
         Q6Pu37OUsWlMRWboArv61zr+ymWetDltxtj8Z6yLHJ0Qk+dXEHYTUT+B22nXa/r5TQrn
         cT/6qRSQfmNj9rcnx2izD77J3aqjsdTi/Cc1e2bfQXKmF5zCa0cD8tRuFGxGuKtHOunl
         y7gl4TZdIdHQdY2xwap63Ak7H2gL3Vo/S5Brro1X1AuSO4eK6QrpAcvfBnU/h/UQZNca
         7ej6Xu666oHR1YSexnsDgZDxSnQqrA7UP0QuMJyizqBtJEx+MtkK4rSjbutPuIBqMRLB
         G3GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=7pOWeRteO/ERB8Md5QtmCZDR0tUnHCp+eseMUR9r5wU=;
        b=Fr5dhdQJus492Og+yvuugHkzh/hIEwcroL1TUfSQVKrBUItJ0rqdNSZBXBXJflOu0e
         6HBBTcSkGxkG98zYlR0KBJSrcWq1ZaPZXLWjlGpYq1VRy81v+qRShAjYJWJSMsjv5PDw
         Ixq2v7w6Qhz8rqqHb0xiTsOOHkKtcbSwUaSmwQxZ3HduYQBv1tIlRw4ar7zdwkZuymM3
         xRP5DyEf/A54rfEb/HX79IseJoHMzjzIgJIBRJuYEauKAv3lCm4X3q7v79WqmYHczE+s
         SNw+YgZZiKvQmbnXA7C3qII45N9NjcREc6DR0LOXtpMKIC7KSsU6mFvj9/nWzHIldfyp
         G0Nw==
X-Gm-Message-State: ACgBeo0cipgp1cFynja8VniJm7+83h5pRgkzCuhc2538wSkIy5ossFPC
        wnCDHFZRxTT1aDRmOzXdRhdb
X-Google-Smtp-Source: AA6agR6pHeXTgpG3jjsKXDTUIRprRkNo85BK1GfzHqJEP2G+qfhLNgHq9dGv1Cc4UT1sBWlDxPGIow==
X-Received: by 2002:a9d:6c81:0:b0:639:1e16:35ae with SMTP id c1-20020a9d6c81000000b006391e1635aemr5430690otr.364.1661272282882;
        Tue, 23 Aug 2022 09:31:22 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:f1b9:9fd8:f860:8737? ([2600:1700:e72:80a0:f1b9:9fd8:f860:8737])
        by smtp.gmail.com with ESMTPSA id x6-20020a4a2a46000000b0044528e04cdasm3246001oox.23.2022.08.23.09.31.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 09:31:22 -0700 (PDT)
Message-ID: <c6731744-143a-5007-5186-f64852ad1123@github.com>
Date:   Tue, 23 Aug 2022 12:31:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 3/7] bundle-uri: create "key=value" line parsing
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=c3=86var_Arnfj=c3=b6r=c3=b0_Bjarmason_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com
References: <pull.1333.git.1661181174.gitgitgadget@gmail.com>
 <49c4f88b6fd804f0bd5c62d523b45431846f4cee.1661181174.git.gitgitgadget@gmail.com>
 <xmqqo7wccckm.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqo7wccckm.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/22/2022 3:17 PM, Junio C Hamano wrote:
> "Ævar Arnfjörð Bjarmason via GitGitGadget"  <gitgitgadget@gmail.com>
> writes:
> 
>> +/**
>> + * General API for {transport,connect}.c etc.
>> + */
>> +int bundle_uri_parse_line(struct bundle_list *list, const char *line)
>> +{
>> +	int result;
>> +	const char *equals;
>> +	struct strbuf key = STRBUF_INIT;
>> +
>> +	if (!strlen(line))
>> +		return error(_("bundle-uri: got an empty line"));
>> +
>> +	equals = strchr(line, '=');
>> +
>> +	if (!equals)
>> +		return error(_("bundle-uri: line is not of the form 'key=value'"));
>> +	if (line == equals || !*(equals + 1))
>> +		return error(_("bundle-uri: line has empty key or value"));
> 
> The suggestions implied by my asking fall strictly into the "it does
> not have to exist here at this step and we can later extend it", but
> for something whose equivalent can be stored in our configuration
> file, it is curious why we _insist_ to refuse an empty string as the
> value.
> 
> I do not miss the "key alone without even '=' means 'true'"
> convention, personally, so insisting to have '=' is OK, but the
> inability to have an empty string as a value looks a bit disturbing.

I'd be happy to switch this to allow an empty value.
 
> This depends on how the helper gets called, but most likely the
> caller has a single line of pkt-line that it GAVE us to process, so
> it sounds a bit wasteful to insist that "line" to be const to us and
> force us to use a separate strbuf, instead of just stuffing NUL at
> where we found '=' and pass the two halves to bundle_list_update().

I can look into using a non-const buffer.

Thanks,
-Stolee

