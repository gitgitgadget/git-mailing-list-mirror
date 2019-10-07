Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4F251F4BE
	for <e@80x24.org>; Mon,  7 Oct 2019 17:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbfJGRIr (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 13:08:47 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42057 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728079AbfJGRIr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 13:08:47 -0400
Received: by mail-qk1-f194.google.com with SMTP id f16so13304704qkl.9
        for <git@vger.kernel.org>; Mon, 07 Oct 2019 10:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cIQ55ql7B+SAwg9q6ohqjgQ6j5nC9UiSnABrGzv0Ufw=;
        b=QW1SZ6da8Rmt10gTFdnWr8sO1VktMYNmbgeLQ4iTaSVFhFRl6luhqfUY0yt/jvy1z1
         CtPGyXqeb5iOlKAmhBq3cB31ztQGYTY17twdgp/XuuHccVI8xWsaz2UTmIddC33CL5Mf
         w0yjfohcF4P6f+tBB03wmC7ixTpzQWl24312MAFjC8PiLQIZmUUJpLCLj3tmBjT5bb9F
         QEvwYZVMOyoh9xmHL1FzeXQhVlB8Tyakr17XzyqAJGtUMab1veKAPLn/wNLrFwO2Bvbo
         fG4RwTkveN1zAdrtZMnwIa+ra7oFCybUtSZx3B9W/9q3usVfhV+B722fzfh3K511vEyh
         +/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cIQ55ql7B+SAwg9q6ohqjgQ6j5nC9UiSnABrGzv0Ufw=;
        b=KpcQ/xTRgjF3L12cv7f6UJZwcQwQoz1tY4/7dbgGDwxSjNXV7uSbY9bkEFDNEeopeH
         E399uG6TZLgachk/pPZe2Xm83QE1duLF/EMsU324IvsvdX02YUHhqQ2iIWW4xj9pY5rr
         beZp3MtkPd19mKCpPiWSmTJV2+FWCwnaqNxga3YY99RBrYAXrCleQXQBlMPfzZd/cbKO
         qe9iEjksQ4t5Brj4ZonEV7eGxk+7kDZVGfHY692ehTfJKxuo7HEzda061XZajCFNmA1L
         KyErhLlAwaSvViFFii8ickpoiaZrdRNw8oYHOzAtfffOGlRm8KWafNwiQuuUjCpRsgR4
         Q7/w==
X-Gm-Message-State: APjAAAUvbM/MM84BgrjWeOCH0I5x9Gj72tFHhAFU0a3gMqgemHbTzZ4t
        g7LdPbfANikafKGDSQJdvhQ=
X-Google-Smtp-Source: APXvYqxnA3sPbpzznNg2BIZ3nV+GKp4ntiqP24EEP7XH0E10I5KFsI3NVMRHYhG0WoPrBUzZrGrUAg==
X-Received: by 2002:a37:a2cd:: with SMTP id l196mr24569750qke.357.1570468126633;
        Mon, 07 Oct 2019 10:08:46 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13f:c177:5f7a:7cbd:dae2? ([2001:4898:a800:1012:72ac:5f7a:7cbd:dae2])
        by smtp.gmail.com with ESMTPSA id z20sm8755195qtu.91.2019.10.07.10.08.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 10:08:45 -0700 (PDT)
Subject: Re: [PATCH v3 1/1] quote: handle numm and empty strings in
 sq_quote_buf_pretty
To:     Garima Singh via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     garimasigit@gmail.com, jeffhost@microsoft.com, stolee@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>
References: <pull.314.v2.git.gitgitgadget@gmail.com>
 <pull.314.v3.git.gitgitgadget@gmail.com>
 <399fe02cb155770fc2d937607014677874075458.1570465059.git.gitgitgadget@gmail.com>
From:   Garima Singh <garimasigit@gmail.com>
Message-ID: <4bebb9e2-2afa-2c4a-78b4-3c4a9f399a0e@gmail.com>
Date:   Mon, 7 Oct 2019 13:08:44 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <399fe02cb155770fc2d937607014677874075458.1570465059.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I just noticed the typo in the commit message in my latest update.
Sorry about that. 
Junio, would you be willing to fix it up whenever you queue the patch?
Or would you like me to send another update. 

Thanks
Garima G Singh

On 10/7/2019 12:17 PM, Garima Singh via GitGitGadget wrote:
> From: Garima Singh <garima.singh@microsoft.com>
> 
> The sq_quote_buf_pretty() function does not emit anything
> when the incoming string is empty, but the function is to
> accumulate command line arguments, properly quoted as
> necessary, and the right way to add an argument that is an
> empty string is to show it quoted, i.e. ''. We warn the caller
> with the BUG macro is they pass in a NULL.
> 
> Reported by: Junio Hamano <gitster@pobox.com>
> Signed-off-by: Garima Singh <garima.singh@microsoft.com>
> ---
>  quote.c          | 10 ++++++++++
>  t/t0014-alias.sh |  7 +++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/quote.c b/quote.c
> index 7f2aa6faa4..f31ebf6c43 100644
> --- a/quote.c
> +++ b/quote.c
> @@ -48,6 +48,16 @@ void sq_quote_buf_pretty(struct strbuf *dst, const char *src)
>  	static const char ok_punct[] = "+,-./:=@_^";
>  	const char *p;
>  
> +	/* In case of null tokens, warn the user of the BUG in their call. */
> +	if (!src) 
> +		BUG("Cannot append a NULL token to the buffer");
> +	
> +	/* Avoid dropping a zero-length token by adding '' */
> +	if (!*src) {
> +		strbuf_addstr(dst, "''");
> +		return;
> +	}
> +
>  	for (p = src; *p; p++) {
>  		if (!isalpha(*p) && !isdigit(*p) && !strchr(ok_punct, *p)) {
>  			sq_quote_buf(dst, src);
> diff --git a/t/t0014-alias.sh b/t/t0014-alias.sh
> index a070e645d7..ae316aa6fd 100755
> --- a/t/t0014-alias.sh
> +++ b/t/t0014-alias.sh
> @@ -37,4 +37,11 @@ test_expect_success 'looping aliases - internal execution' '
>  #	test_i18ngrep "^fatal: alias loop detected: expansion of" output
>  #'
>  
> +test_expect_success 'run-command parses empty args properly, using sq_quote_buf_pretty' '
> +    GIT_TRACE=1 git frotz a "" b " " c 2>&1 |
> +    sed -ne "/run_command:/s/.*trace: run_command: //p" >actual &&
> +    echo "git-frotz a '\'''\'' b '\'' '\'' c" >expect &&
> +    test_cmp expect actual
> +'
> +
>  test_done
> 
