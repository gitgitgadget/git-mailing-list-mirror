Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3170B1F461
	for <e@80x24.org>; Mon,  2 Sep 2019 17:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfIBR6A (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Sep 2019 13:58:00 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54332 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbfIBR6A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Sep 2019 13:58:00 -0400
Received: by mail-wm1-f68.google.com with SMTP id k2so14006033wmj.4
        for <git@vger.kernel.org>; Mon, 02 Sep 2019 10:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hromhKu8LlCe9SmAL0iEqEH/aBMkqjCTr0J/OXlaGiY=;
        b=LkqKr/Zwc/2ATSxdTUzySjouUFN06NxEt5gZwJ+3nEHiUjyKpt83XPS6W/AvwE2mXG
         TQfW+SsAgKKtKQl7z+hqsA3mjpptC33VTxRhgT2/0/wyFadBVVjMh+U3qPR7MBjXJJ0f
         M/n5TDp038Q/YLLneYGFksIgXNuSn868Dc3Z0ZTCg2ivm+kI9zlEo7kcADik2niHpul6
         f8BjoBIcB06clVNXOUr1N3vOmFMkk6QnNw2+JwnB7yxdtJh26YGpQmnvQEvY5WeQa4GM
         hfAdCVfnHLmDs7AypIXALjDTwUcnZyb38BLtOTAVZZSULb+pazxB4BZNy3VzrFOcXLvh
         SOAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=hromhKu8LlCe9SmAL0iEqEH/aBMkqjCTr0J/OXlaGiY=;
        b=aY7MYV3G11ZDUOj0TMj2h9pmIZRKyKnhngbRXrokOOiSZbeDUMYBpQMErxwGThJxPb
         f5ODPQgVtMoYVs4weBVgi59uwt748FzJ6XVKiAqp/QF6JqdrxGpSemxu0NweGNukmP4b
         3kYGPJg1Bk/bHz3FeeiKdn0+HPDNpCFOi3EjnUlMPztiHI3bu2GI7eug6wrO7Nxpzn6P
         6NYHG3Z6VE2Ma95pDVqCUOjHP9kEVjf2DZUT4BAq0opth1v1R3FmxeEMtyLa65Q5DPIy
         X4VePY2kN2BRSNaObI0qsZHUlZsUDaOKy5A2SFt1RT96f3BmgHHk2JrE1K6tVjuNNDot
         Xdbg==
X-Gm-Message-State: APjAAAWAAH9STzjm9jbVeUZq5/X9w0QirAkoPqhg0x7QP2k5NVNc8KNd
        sOKIpo68BIWSGxPBXAL46vARX4Cb
X-Google-Smtp-Source: APXvYqxtmBo0cjUqbgmQ8m6lNgwAn7z81Pnrooy5iJveKXelreuVD1rfiSQ9npxF+ql+CXGi8ky7KA==
X-Received: by 2002:a05:600c:218e:: with SMTP id e14mr10127042wme.121.1567447077670;
        Mon, 02 Sep 2019 10:57:57 -0700 (PDT)
Received: from [192.168.1.70] (88-110-119-23.dynamic.dsl.as9105.com. [88.110.119.23])
        by smtp.gmail.com with ESMTPSA id k6sm53276745wrg.0.2019.09.02.10.57.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2019 10:57:57 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/1] rebase -r: let `label` generate safer labels
To:     Matt R via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Matt R <mattr94@gmail.com>
References: <pull.327.git.gitgitgadget@gmail.com>
 <4a02c38442dd8a4c0381adc8db0dce81c253da09.1567432900.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <444f3ec4-abdf-1aa9-e8a8-8b5346b939e8@gmail.com>
Date:   Mon, 2 Sep 2019 18:57:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <4a02c38442dd8a4c0381adc8db0dce81c253da09.1567432900.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Matt

This is definitely worth fixing, I've got a couple of comments below

On 02/09/2019 15:01, Matt R via GitGitGadget wrote:
> From: Matt R <mattr94@gmail.com>
> 
> The `label` todo command in interactive rebases creates temporary refs
> in the `refs/rewritten/` namespace. These refs are stored as loose refs,
> i.e. as files in `.git/refs/rewritten/`, therefore they have to conform
> with file name limitations on the current filesystem.
> 
> This poses a problem in particular on NTFS/FAT, where e.g. the colon
> character is not a valid part of a file name.

Being picking I'll point out that ':' is not a valid in refs either. 
Looking at 
https://docs.microsoft.com/en-us/windows/win32/fileio/naming-a-file I 
think only " and | are not allowed on NTFS/FAT but are valid in refs 
(see the man page for git check-ref-format for all the details). So the 
main limitation is actually what git allows in refs.

> Let's safeguard against this by replacing not only white-space
> characters by dashes, but all non-alpha-numeric ones.
> 
> However, we exempt non-ASCII UTF-8 characters from that, as it should be
> quite possible to reflect branch names such as `↯↯↯` in refs/file names.
> 
> Signed-off-by: Matthew Rogers <mattr94@gmail.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>   sequencer.c              | 12 +++++++++++-
>   t/t3430-rebase-merges.sh |  5 +++++
>   2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index 34ebf8ed94..23f4a0876a 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -4635,8 +4635,18 @@ static int make_script_with_merges(struct pretty_print_context *pp,
>   		else
>   			strbuf_addbuf(&label, &oneline);
>   
> +		/*
> +		 * Sanitize labels by replacing non-alpha-numeric characters
> +		 * (including white-space ones) by dashes, as they might be
> +		 * illegal in file names (and hence in ref names).
> +		 *
> +		 * Note that we retain non-ASCII UTF-8 characters (identified
> +		 * via the most significant bit). They should be all acceptable
> +		 * in file names. We do not validate the UTF-8 here, that's not
> +		 * the job of this function.
> +		 */
>   		for (p1 = label.buf; *p1; p1++)
> -			if (isspace(*p1))
> +			if (!(*p1 & 0x80) && !isalnum(*p1))
>   				*(char *)p1 = '-';

I'm sightly concerned that this opens the possibility for unexpected 
effects if two different labels get sanitized to the same string. I 
suspect it's unlikely to happen in practice but doing something like 
percent encoding non-alphanumeric characters would avoid the problem 
entirely.

Best Wishes

Phillip

>   		strbuf_reset(&buf);
> diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
> index 7b6c4847ad..737396f944 100755
> --- a/t/t3430-rebase-merges.sh
> +++ b/t/t3430-rebase-merges.sh
> @@ -441,4 +441,9 @@ test_expect_success '--continue after resolving conflicts after a merge' '
>   	test_path_is_missing .git/MERGE_HEAD
>   '
>   
> +test_expect_success '--rebase-merges with commit that can generate bad characters for filename' '
> +	git checkout -b colon-in-label E &&
> +	git merge -m "colon: this should work" G &&
> +	git rebase --rebase-merges --force-rebase E
> +'
>   test_done
> 
