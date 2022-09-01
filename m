Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51E6ECAAD1
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 16:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbiIAQD2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 12:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232420AbiIAQD1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 12:03:27 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FAEB8F954
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 09:03:26 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v16so20248993wrm.8
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 09:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=SE+SSSHTXO21Fgk0FrruIawM8m3ZPgDG0ueC1BKEGas=;
        b=VZN3uZUBhDWi1JIprgZnLQJ7F7rcogM0jKX0nMW4QiUUI0M048XkL2JMeAKO6d7SFn
         ZFpKU8ncps1E7KAyZYKi/qIcGG6dUB52+/50RMCfYyMB3W1pjEMTriCeOixbZqUBH422
         JglT97He4YcXvNekFloplgWHnM/JZxlvoPdmeeiGZi9Vqw14NHNYmW2EUgzMVm2LgXy/
         oELbBmpmZTrFPOt9aVSy0ugwPWI9xwZ6HWKzbttBHAAogxSiXwTwcUb8MROQv51Zrd6n
         vbGAmnfYLLLUycqVhN6oBWYveDmJIOgEYhRge/wSVwWLfTccleKQlEvHZNi5lbmAVnK9
         YY0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=SE+SSSHTXO21Fgk0FrruIawM8m3ZPgDG0ueC1BKEGas=;
        b=ct+YYmN8UsyPHuo2qIlTtosb03qj3x8j/F179a5FsMG+FNdNuO34YGjd5R+deDmFbR
         ZnIP3Ew416dQuq01rwCz0itpY2sDbo6ebs5aXc+g6Qujrgr5PyfBJ7bDk7zZKjUD8L8n
         S9e7Cl0nynnOD6GSHYTLaM/C8jUQ0K5qPiQ4jlubwpnqiefW0YIthqp/10jDChfwIexV
         OeX0MLq1JLBkw2fWK0T/mwzk1MfdTyQe1BvcmOdRfmfn+4YiuiOhqDWbvsaEXmVhxLon
         D4nDxjgaTHODeI0i43Ux9XH/pYHnHmWY2Vo2PSg6CG9dvDzoCBryD8TVKh0Y5PRIufhZ
         drKA==
X-Gm-Message-State: ACgBeo23bqpr1aUK7rXTu9q/PaIGRIufALii8epYeQYLcSWPYPxX/HhE
        ar2RkOKvmFhs3Rhp50MelYI=
X-Google-Smtp-Source: AA6agR6KDyx1dY4b05a5O76Yoj37cDviVne2xLI7HqFZZbq4C/VUwwngV6ykyY24RhMRzgl0J8B8jA==
X-Received: by 2002:adf:9d91:0:b0:226:d001:6e27 with SMTP id p17-20020adf9d91000000b00226d0016e27mr14607200wre.366.1662048204875;
        Thu, 01 Sep 2022 09:03:24 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id z14-20020adfd0ce000000b002253fd19a6asm17765950wrh.18.2022.09.01.09.03.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 09:03:24 -0700 (PDT)
Message-ID: <a560ecb1-2049-7844-758f-4bd44b61eea7@gmail.com>
Date:   Thu, 1 Sep 2022 17:03:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 2/3] add -p: gracefully handle unparseable hunk headers
 in colored diffs
Content-Language: en-US
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1336.v4.git.1661977877.gitgitgadget@gmail.com>
 <pull.1336.v5.git.1662046939.gitgitgadget@gmail.com>
 <93d0e3b4d2a3dec5588c6e41d69313385356aa8f.1662046939.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <93d0e3b4d2a3dec5588c6e41d69313385356aa8f.1662046939.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

On 01/09/2022 16:42, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> In
> https://lore.kernel.org/git/ecf6f5be-22ca-299f-a8f1-bda38e5ca246@gmail.com,
> Phillipe Blain reported that the built-in `git add -p` command fails
> when asked to use [`diff-so-fancy`][diff-so-fancy] to colorize the diff.
> 
> The reason is that this tool produces colored diffs with a hunk header
> that does not contain any parseable `@@ ... @@` line range information,
> and therefore we cannot detect any part in that header that comes after
> the line range.
> 
> As proposed by Phillip Wood, let's take that for a clear indicator that
> we should show the hunk headers verbatim. This is what the Perl version
> of the interactive `add` command did, too.
> 
> [diff-so-fancy]: https://github.com/so-fancy/diff-so-fancy
> 
> Reported-by: Philippe Blain <levraiphilippeblain@gmail.com>
> Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

> @@ -659,6 +659,15 @@ static void render_hunk(struct add_p_state *s, struct hunk *hunk,
>   		if (!colored) {
>   			p = s->plain.buf + header->extra_start;
>   			len = header->extra_end - header->extra_start;
> +		} else if (header->suppress_colored_line_range) {
> +			strbuf_add(out,
> +				   s->colored.buf + header->colored_extra_start,
> +				   header->colored_extra_end -
> +				   header->colored_extra_start);
> +
> +			strbuf_add(out, s->colored.buf + hunk->colored_start,
> +				   hunk->colored_end - hunk->colored_start);
> +			return;

Having an extra branch for this that returns early makes it easy to see 
what is being printed when we cannot parse the hunk header.

> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index 8a594700f7b..a94e7c53c8a 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -767,6 +767,16 @@ test_expect_success 'detect bogus diffFilter output' '
>   	grep "mismatched output" output
>   '
>   
> +test_expect_success 'handle iffy colored hunk headers' '
> +	git reset --hard &&
> +
> +	echo content >test &&
> +	printf n >n &&
> +	force_color git -c interactive.diffFilter="sed s/.*@@.*/XX/" \
> +		add -p >output 2>&1 <n &&
> +	grep "^XX$" output

We check that the hunk header line from filtered diff was reproduced 
verbatim

This all looks good to me

Best Wishes

Phillip
