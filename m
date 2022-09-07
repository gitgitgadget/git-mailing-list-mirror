Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DFBC54EE9
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 18:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbiIGSJL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 14:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbiIGSJJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 14:09:09 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F28357E27
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 11:09:08 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id h1so9231151wmd.3
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 11:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=VYrar97CMPZqrKKecjjgRqiEvsAIs/dnQsvbzR2d4Nw=;
        b=OFfrPbZFlBYqQVRm935jZ5XgixViVytOd5IdDb01x2juQcfaKw2I/Y07tqLbtdQb56
         Kc5A+FIYXKwno9d2iT3YVbShw3M8543GHgcUtXx1U4kWPtj75JJrAadmSTrQNpS2b24f
         Xxi6ooTUeEU0VwZgvRR49tnuPNyuMhpGv7CvoyBOA/f/dkdPzdsexXzMeGVpc+dJ/qBo
         pi09fGBQAmvLJnH5m6e5ihJlQoLEYyZNNPeSI7jL7QNMbXeRCOGX5TQ3QMTEtX5qRpXx
         XLR2TEuH+M5UeuK1V/GrsIlvmtppiMeITqLU60dO1hGbQ47z2t1sCybReXxEz/KQ1BAi
         2vSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=VYrar97CMPZqrKKecjjgRqiEvsAIs/dnQsvbzR2d4Nw=;
        b=3s8RKJHSu6K5GXv8viW/3Eqzsg0cezNHzHj1Id7BuhVj1z7XB/blL7dOuF2CLDfoem
         sMVn4RxGtsvGZsCaSUJBVEX9+KmXpytdivgvrIBh2AF5uzwDPuw8T6MvMQ6RNdN4k6cc
         u+lsHXri5qNC+vP6PBatWyb05dHpxNkcSyvRHRAh0ZIyqXZa/l+ew6ztSA8QN2+Bmfkv
         d4cXDE81a9mXOImzn0aZMWodKKx7IGIkMFbzB1k1UOMVyELSuIiumE6HljtbV6sFSYvU
         EHWgFlmOPkYqjlk4soD0dWsObqOFEooq/HTyXm7lKZCkDAAhvsxyS6y1yVmnIx4LI4Y1
         oTlQ==
X-Gm-Message-State: ACgBeo2gFbFdCcbW0wsRVGmXXO0VJSn+g/O+i2pUskLnlekVMcrbr4G0
        pPJEJdNHoXdYNd6cya5gtEP3ef/C9BpCzw==
X-Google-Smtp-Source: AA6agR6Kka+8AH/AGgkGW2WuQt2zCDIczrewSWSUTyQ92Mq6fSq6fwEQ0WDluR9z481701x7eywoPA==
X-Received: by 2002:a05:600c:1e88:b0:3a6:2ca3:f7f2 with SMTP id be8-20020a05600c1e8800b003a62ca3f7f2mr18082122wmb.7.1662574146675;
        Wed, 07 Sep 2022 11:09:06 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.144])
        by smtp.googlemail.com with ESMTPSA id d11-20020adfe84b000000b0021f131de6aesm18278900wrn.34.2022.09.07.11.09.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 11:09:06 -0700 (PDT)
Message-ID: <4d750ff2-9df5-504f-9972-59b082000db0@gmail.com>
Date:   Wed, 7 Sep 2022 19:09:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 2/2] format-patch: warn if commit msg contains a patch
 delimiter
To:     Matheus Tavares <matheus.bernardino@usp.br>, git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, l.s.r@web.de
References: <cover.1662559356.git.matheus.bernardino@usp.br>
 <a2c4514aa03657f3b1d822efe3dd630713287ee6.1662559356.git.matheus.bernardino@usp.br>
Content-Language: en-US
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <a2c4514aa03657f3b1d822efe3dd630713287ee6.1662559356.git.matheus.bernardino@usp.br>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Matheus

On 07/09/2022 15:44, Matheus Tavares wrote:
> When applying a patch, `git am` looks for special delimiter strings
> (such as "---") to know where the message ends and the actual diff
> starts. If one of these strings appears in the commit message itself,
> `am` might get confused and fail to apply the patch properly. This has
> already caused inconveniences in the past [1][2]. To help avoid such
> problem, let's make `git format-patch` warn on commit messages
> containing one of the said strings.

Thanks for working on this, having a warning for this is a useful 
addition. If the user embeds a diff in their commit message then they 
will receive three warnings

warning: commit message has a patch delimiter: 'diff --git a/file b/file'
warning: commit message has a patch delimiter: '--- file'
warning: git am might fail to apply this patch. Consider indenting the 
offending lines.

I guess it's helpful to show all the lines that are considered 
delimiters but it gets quite noisy.


> diff --git a/pretty.c b/pretty.c
> index 6d819103fb..913d974b3a 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -2107,6 +2108,14 @@ void pp_remainder(struct pretty_print_context *pp,
>   		if (!linelen)
>   			break;
>   
> +		if (pp->check_in_body_patch_breaks &&
> +		    (patchbreak(line, linelen) || is_scissors_line(line, linelen))) {
> +			warning(_("commit message has a patch delimiter: '%.*s'"),
> +				line[linelen - 1] == '\n' ? linelen - 1 : linelen,
> +				line);
> +			found_delimiter = 1;
> +		}
> +
>   		if (is_blank_line(line, &linelen)) {
>   			if (first)
>   				continue;
> @@ -2133,6 +2142,11 @@ void pp_remainder(struct pretty_print_context *pp,
>   		}
>   		strbuf_addch(sb, '\n');
>   	}
> +
> +	if (found_delimiter) {
> +		warning(_("git am might fail to apply this patch. "
> +			  "Consider indenting the offending lines."));

The message says the patch might fail to apply, but isn't it guaranteed 
to fail?

> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index fbec8ad2ef..4bbf1156e9 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -2329,4 +2329,30 @@ test_expect_success 'interdiff: solo-patch' '
>   	test_cmp expect actual
>   '
>   
> +test_expect_success 'warn if commit message contains patch delimiter' '
> +	>delim &&
> +	git add delim &&
> +	cat >msg <<-\EOF &&
> +	title
> +
> +	---
> +	EOF
> +	git commit -F msg &&
> +	git format-patch -1 2>stderr &&
> +	grep "warning: commit message has a patch delimiter" stderr

I think it would be worth checking for the second message as well in the 
tests.


Best Wishes

Phillip

