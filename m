Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E56EE1F731
	for <e@80x24.org>; Wed,  7 Aug 2019 13:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388004AbfHGN5E (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Aug 2019 09:57:04 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:46377 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387976AbfHGN5E (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Aug 2019 09:57:04 -0400
Received: by mail-yw1-f66.google.com with SMTP id z197so32370732ywd.13
        for <git@vger.kernel.org>; Wed, 07 Aug 2019 06:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=olKf4NrT7vO7wHDuS4+If+mATniTz2KCzJ4lfwklKBU=;
        b=RcIZSxwr3YSxxWv6oAx0FhZ8NrwoutcmMX7W5dMHvCExwt2Abye2vuc5d4z6zSo7mY
         pGI5LT+v2YCkLYFYrkuTM9VxoNywTriWUo6a3nWwF+kkEqvRXCQ3+GfZZgLzD5wHyHpC
         OFvbkGywHVzn8wTEvNB5B1MBKyzPNNQET9ogPrfcFgQjCulqzZwe9Hjwdw7SFnlc0vSq
         aYMhpWUXVnotlrZrdFGqFHW7aM1Ndr9V56okeGWPOVyCtT/XM8J+UPWBWP279LnlpknP
         4S0Z1V5+yoz0xnRVu2m6siytLr2ET0tFPS4de6UHO+xYdH1N4XWqquaVlA7xGqx/yvEo
         nwbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=olKf4NrT7vO7wHDuS4+If+mATniTz2KCzJ4lfwklKBU=;
        b=q6mxS34pelUnJ2udiGMSrriTXdKPmmV7s+cFJC/Y35AEk8htgR/vB1sTibhMSkFNrB
         yb0+emmgRhMvgk8uFYEj39r5VZSBRdMSH/EsxW0IRx/hwk8ofMDGtO+veigJeaBnYwQt
         5otwlFeSx3EuIkLRoxV/ywD2TMkZAnl2TA+0C81XAr3LZ4wfcfOHjhePZueCuek8E9pM
         V/FTPCfsnGEyelNrWfOucbz4vRfge77w6m/yaBgzLrqsnfsHXxrBr80u22oMUCmHnzVF
         XZiqNvyhehHs+HISSf64BCyieCxUK+gCz/+JUdF3aUYL2NQHMJiXqLmy8iHO5AsmmZkH
         4OHw==
X-Gm-Message-State: APjAAAWSZEznjtpkLNVgq1G8cYesEqvbJepWST6YCDy4nKVZL3XmnUAl
        JPaIDopdKPwAlYWu51erkP6cfopZuco=
X-Google-Smtp-Source: APXvYqwLYvi5dJq9q66KuUHUgjpzbgI52sZkK2fWmz/JqT6TEEmDN9UaIoS1sfwpRjnX/otGj9gCoQ==
X-Received: by 2002:a81:5f82:: with SMTP id t124mr5849455ywb.344.1565186223813;
        Wed, 07 Aug 2019 06:57:03 -0700 (PDT)
Received: from [192.168.1.12] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id v12sm20440128ywv.15.2019.08.07.06.57.03
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 06:57:03 -0700 (PDT)
Subject: Re: [PATCH] test-dir-iterator: use path argument directly
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Daniel Ferreira <bnmvco@gmail.com>
References: <7f428974-9218-fa7c-6f3c-3c0db30a7fec@web.de>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <5d24c373-8e27-e166-3019-4812da68ebf9@gmail.com>
Date:   Wed, 7 Aug 2019 09:57:02 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <7f428974-9218-fa7c-6f3c-3c0db30a7fec@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/7/2019 7:15 AM, René Scharfe wrote:
> Avoid allocating and leaking a strbuf for holding a verbatim copy of the
> path argument and pass the latter directly to dir_iterator_begin()
> instead.
> 
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
> This test helper was added after v2.22.0 (2019-06-07) by 150791adbf
> (dir-iterator: add tests for dir-iterator API, 2019-07-10).
> 
>  t/helper/test-dir-iterator.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/t/helper/test-dir-iterator.c b/t/helper/test-dir-iterator.c
> index c7c30664da..659b6bfa81 100644
> --- a/t/helper/test-dir-iterator.c
> +++ b/t/helper/test-dir-iterator.c
> @@ -19,7 +19,6 @@ static const char *error_name(int error_number)
>   */
>  int cmd__dir_iterator(int argc, const char **argv)
>  {
> -	struct strbuf path = STRBUF_INIT;
>  	struct dir_iterator *diter;
>  	unsigned int flags = 0;
>  	int iter_status;
> @@ -36,8 +35,7 @@ int cmd__dir_iterator(int argc, const char **argv)
>  	if (!*argv || argc != 1)
>  		die("dir-iterator needs exactly one non-option argument");
> 
> -	strbuf_add(&path, *argv, strlen(*argv));
> -	diter = dir_iterator_begin(path.buf, flags);
> +	diter = dir_iterator_begin(*argv, flags);

LGTM. I had a minor brain fart regarding the type of *argv and how the
const plays in, but dir_iterator_begin takes a "const char *" so this
is safe.

Thanks,
-Stolee
