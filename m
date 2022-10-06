Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13947C433FE
	for <git@archiver.kernel.org>; Thu,  6 Oct 2022 16:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbiJFQOP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 12:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiJFQON (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 12:14:13 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD44CACA2E
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 09:14:12 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id 67so2444388pfz.12
        for <git@vger.kernel.org>; Thu, 06 Oct 2022 09:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hztEnYiZBsn+SrkWz5DnQSB1NakjzXnuFTx1NFUe+fk=;
        b=Rfvq+uDdLPRXGfo6jQqimkn/MpO1Esnk6EmKnbPDZGJ0VBC1jxXv4hLiRNN9qDi/xX
         Xb1e+2nMQg1jvifvYvPV0W3qisvPEZnmWU7Sk3Ra+Vqv0d6V9s0odtFbyJ8GHXRrN0Gv
         mkal5ilzEp31CWigaTY+/9tdw8tLqqCv4ztFCuVAv5ol8Bbk8na479GsyiK3uQUf3HAT
         a6OwTZQo3HdQuYAjawtIn+4F8pfYqMsICT0+C11oGdRiuJSu9E/LAluw4Q8MzQgxAO1u
         EOyAAJ9IzdRWVp0FV2Gr0p9FSqpf+UiYgJcufp1QB3k8o115hi1O5k7Jyf9zWx0UBp83
         a6Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hztEnYiZBsn+SrkWz5DnQSB1NakjzXnuFTx1NFUe+fk=;
        b=up5orsIOQFI3LExEbzGvHyI2w4MhO5K2BeXTxsooCN7Vuu+4vKq9y10krp3GWG60cz
         0m4mYUNGt0isoZmx6SAgm5U2T4hzooLcOiGcL74+mtPJUW5I5E5bkdCxq55tiLiW0lE5
         S5ewXJQKG9z4Lz895RDEWwWGIugipSfBdarpfOLAKs8mHWLaT3RE3EJsY1k+j/6lESap
         4vVf95WVbo01rvmSthLtSlyuZ5fcDbGzDq0L3NCE0SWu75H9G1ZbXDx+9QsA89SzN8Hi
         j8eVwgvUZxZTgLfHp8i1yiRfF0aezyNpjrC9AaN7cgFV9Gb1yqsK8MKKao1Ybhzdeei+
         ZRCw==
X-Gm-Message-State: ACrzQf0JcZVvJTNmJuLENHpmQdVUHrC0BKw6N1tSasQXYhKiwbyiVk42
        CTS4E6KjvjSI2+LmVKulHNLt
X-Google-Smtp-Source: AMsMyM79XW/C4Ikuzna+EugLf31aHh0quHNVdqpOMlycX7JyuIJlAMO3P5uTOb0SZ+8qYfuEhS+wxA==
X-Received: by 2002:a63:4721:0:b0:440:2960:407 with SMTP id u33-20020a634721000000b0044029600407mr487139pga.621.1665072852174;
        Thu, 06 Oct 2022 09:14:12 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id l8-20020a170903244800b0017f5c7d3931sm7502079pls.282.2022.10.06.09.14.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 09:14:11 -0700 (PDT)
Message-ID: <44d2f602-a299-3bd0-1624-cfdddb6dcda7@github.com>
Date:   Thu, 6 Oct 2022 09:14:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH 2/2] removed else statement
Content-Language: en-US
To:     dsal3389 via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     dsal3389 <dsal3389@gmail.com>
References: <pull.1355.git.git.1665056747.gitgitgadget@gmail.com>
 <c107ad9f6ff2d5e00134eb1348f24737774edbac.1665056747.git.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <c107ad9f6ff2d5e00134eb1348f24737774edbac.1665056747.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

dsal3389 via GitGitGadget wrote:
> From: dsal3389 <dsal3389@gmail.com>
> 
> there is no need for the else statement if we can do it more
> elegantly with a signle if statement we no "else"

Similar recommendations on the commit message as in the previous patch [1]:

- title should be prefixed with 'git.c:'
- title & message should use the imperative mood (e.g. "remove else
  statement" instead of "removed else statement")
- please fix typos
    - s/there/There
    - s/signle/single
    - s/we/with(?)

[1] https://lore.kernel.org/git/66d1bcaf-64c8-13c2-ba7a-98715de3617b@github.com/

> 
> Signed-off-by: Daniel Sonbolian <dsal3389@gmail.com>
> ---
>  git.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/git.c b/git.c
> index da411c53822..340ec8bcb31 100644
> --- a/git.c
> +++ b/git.c
> @@ -894,12 +894,8 @@ int cmd_main(int argc, const char **argv)
>  	argv++;
>  	argc--;
>  	handle_options(&argv, &argc, NULL);
> -	if (argc > 0) {
> -		if (!strcmp("--version", argv[0]) || !strcmp("-v", argv[0]))
> -			argv[0] = "version";
> -		else if (!strcmp("--help", argv[0]) || !strcmp("-h", argv[0]))
> -			argv[0] = "help";
> -	} else {
> +
> +	if (argc <= 0) {

nit: argc is always >= 0 [2], so a more appropriate condition would be:

    if (!argc)

There are lots of examples of that '!argc' conditional in Git, but none of
the 'argc <= 0' pattern, so it's probably best to match convention here.

Otherwise, the rest of this diff looks good.

[2] https://www.open-std.org/jtc1/sc22/wg14/www/docs/n1256.pdf, §5.1.2.2.1 #2

>  		/* The user didn't specify a command; give them help */
>  		commit_pager_choice();
>  		printf(_("usage: %s\n\n"), git_usage_string);
> @@ -907,6 +903,12 @@ int cmd_main(int argc, const char **argv)
>  		printf("\n%s\n", _(git_more_info_string));
>  		exit(1);
>  	}
> +
> +	if (!strcmp("--version", argv[0]) || !strcmp("-v", argv[0]))
> +		argv[0] = "version";
> +	else if (!strcmp("--help", argv[0]) || !strcmp("-h", argv[0]))
> +		argv[0] = "help";
> +
>  	cmd = argv[0];
>  
>  	/*

