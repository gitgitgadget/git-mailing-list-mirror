Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B6DC19F2C
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 15:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbiHBPnR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 11:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiHBPnP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 11:43:15 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D2EB79
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 08:43:13 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id m2so7044831pls.4
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 08:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bQwyXsGt7ARGRfjilxBbdAwv0Q+TtVpknlhH6W7yVus=;
        b=X9/yh2WafcxPbfPQsE6Ncyip+IytzmisKXDAQy8c7doASqMObLFUK8LZVC3mXwlYAe
         bO6w/Ulr29R+LGqke5EucQq8CeOMRtehsXbgAwu3KL7L/TVX0COr6TLenArVosUtXzpE
         F8dAnoRuRJHqF1VIURJ0k5+xuYZpvyv39Qj/mlP8+k3ANEfNEo0YVHLuRkslKr/JQr8G
         uDDCr8Br476HysXuC7nLzA7sMVL5sLwgDliXcY7eyZz7VTIvbUtBd8j1gyJSn/UmfRn9
         nl3f6qP7+gl+WZ9KmK9ZmXEr7P4WA6mIx6HYv1uSu4+zKauR1K4S7d/Nx3igXmYSxA7s
         gmEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bQwyXsGt7ARGRfjilxBbdAwv0Q+TtVpknlhH6W7yVus=;
        b=qihbzuFW7SBjsjbojeIIzlqhDesBrHG9O34LXx5qYiDmwhjOn7s8jAs2hC/g0hJoHq
         ZWfmuaG7cTXcWXvlylXLnrpdKafg4f0j9DEclFmfaqcvPfiMiJTBbk/jrrJQ0QpwhT1a
         i04lJ4nqxXdxwGBQgyaXZ/7MjXMc49Cx9pCiYHP6lq6g+EvpkZ0zy9H2aU2ynXo6psi6
         yWXTM2403cv/r6e46rQtHDWzi24pLuvg6FSz6c4oGDXZlZMm//dgdkt+Y6FW+CNRtTpV
         UE0SzOqF/AkN/Ug/gnuUzpwvP/WaOSL2kywDZBCvEOruJNppQWBCmeLLtzYgmqZ0gBN7
         fiRA==
X-Gm-Message-State: ACgBeo0gqS91/QZiUeWhDPh6OGB37KokOND2kVnaKA2nNA+b2mO/q9w3
        /o1Zo48BHPkX8htr83T0xVGq
X-Google-Smtp-Source: AA6agR5J7ys2bHzGzYjp7irO7yMYm7mdaZi1L2SlVbrWQxmSn0vwl1/0//qzyXT8UXW6ALAovD+Ltg==
X-Received: by 2002:a17:90a:62ca:b0:1f2:ef43:72a1 with SMTP id k10-20020a17090a62ca00b001f2ef4372a1mr51103pjs.217.1659454992936;
        Tue, 02 Aug 2022 08:43:12 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id m13-20020a65530d000000b0041a67913d5bsm9392762pgq.71.2022.08.02.08.43.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 08:43:12 -0700 (PDT)
Message-ID: <760ebe95-552f-c0d7-18c3-f19671fdd192@github.com>
Date:   Tue, 2 Aug 2022 08:43:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH 4/7] builtin/bugreport.c: add directory to archiver more
 gently
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com,
        johannes.schindelin@gmx.de
References: <pull.1310.git.1659388498.gitgitgadget@gmail.com>
 <4bc290fbf43e0193aae288b79249014d899ea34a.1659388498.git.gitgitgadget@gmail.com>
 <xmqqles7mwnc.fsf@gitster.g>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <xmqqles7mwnc.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>>  	int at_root = !*path;
>> -	DIR *dir = opendir(at_root ? "." : path);
>> +	DIR *dir;
>>  	struct dirent *e;
>>  	struct strbuf buf = STRBUF_INIT;
>>  	size_t len;
>>  	int res = 0;
>>  
>> +	if (!file_exists(at_root ? "." : path)) {
>> +		warning(_("directory '%s' does not exist, will not be archived"), path);
>> +		return 0;
>> +	}
>> +
>> +	dir = opendir(at_root ? "." : path);
>>  	if (!dir)
>>  		return error_errno(_("could not open directory '%s'"), path);
> 
> I am not sure if TOCTTOU is how we want to be more gentle.  Do we
> rather want to do something like this
> 
> 	dir = opendir(...);
> 	if (!dir) {
> 		if (errno == ENOENT) {
> 			warning(_("not archiving missing directory '%s'", path);
> 		        return 0;
> 		}
>                 return error_errno(_("cannot open directory '%s'"), path);
> 	}
> 
> or am I missing something subtle?
> 

The "gentleness" was meant to be a reference only to the error -> warning
change, the TOCTTOU change was just a miss by me. I'll fix it in the next
version, thanks!

> Thanks.
> 
>> diff --git a/t/t0091-bugreport.sh b/t/t0091-bugreport.sh
>> index 3cf983aa67f..e9db89ef2c8 100755
>> --- a/t/t0091-bugreport.sh
>> +++ b/t/t0091-bugreport.sh
>> @@ -78,7 +78,7 @@ test_expect_success 'indicates populated hooks' '
>>  	test_cmp expect actual
>>  '
>>  
>> -test_expect_failure UNZIP '--diagnose creates diagnostics zip archive' '
>> +test_expect_success UNZIP '--diagnose creates diagnostics zip archive' '
>>  	test_when_finished rm -rf report &&
>>  
>>  	git bugreport --diagnose -o report -s test >out &&
>> @@ -98,4 +98,13 @@ test_expect_failure UNZIP '--diagnose creates diagnostics zip archive' '
>>  	grep "^Total: [0-9][0-9]*" out
>>  '
>>  
>> +test_expect_success '--diagnose warns when archived dir does not exist' '
>> +	test_when_finished rm -rf report &&
>> +
>> +	# Remove logs - not guaranteed to exist
>> +	rm -rf .git/logs &&
>> +	git bugreport --diagnose -o report -s test 2>err &&
>> +	grep "directory .\.git/logs. does not exist, will not be archived" err
>> +'
>> +
>>  test_done

