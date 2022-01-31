Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DC0C4332F
	for <git@archiver.kernel.org>; Mon, 31 Jan 2022 11:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348507AbiAaLDm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jan 2022 06:03:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358551AbiAaLB4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jan 2022 06:01:56 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9441CC061341
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 03:00:12 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id n12-20020a05600c3b8c00b0034eb13edb8eso7278010wms.0
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 03:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=y7brflZHpT9Udm6kOKng3+3tqyC/0THS6kfrnCkYIc4=;
        b=RVZd41+OfZlIlRrKbPZyEwrst+pLrEoTAXJYvB7a2r+su9YGdd/8Crxb7t8x7QnQOe
         EAXzHwUsA0VYWN3xmV+MMZLaZW0pNxTMWTfZ7sU0LMsL26loWWpCCRcxjN83Zfi0M9XU
         IU/xCB+IbbdozfHWRUmJ8qsI9X9nXwGPkoAMgJKXMoJeHGHHsL7HEQ9ZvimqT775GKkp
         mTs0fVvjpHQIUpE/+O8mytc+TIB/nnDR562pQqmKGsvbBrtRpy6n8gnn5IhzYoP9EmKD
         f8O1g6WluO8rjgAFaEbg13fYydITsvCoV6v5aquMbHuY12cIkBJV+PozK43C5Xw05Yo6
         ZWew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=y7brflZHpT9Udm6kOKng3+3tqyC/0THS6kfrnCkYIc4=;
        b=GD3JR2VCuFxIqyxz47ccd4lHtO7ubAnCGOr2/PG5IsRC1YnbHoiWKlzrHmP5x6ETnF
         UVnM3xdBnCNRHiSYCtazan9nF1NgJykFDVzExoCu9tsoRfIzBGTrIsh0q2ZAsT68Re5k
         nRAHY2zHwEQuCWcRm4x17lTN+w8xsHXfpz8iPW3hMf/YqWalmaU7aVuZFpD4GWTJ/tiz
         8CPK074UDMBwThPEd7zIJAkoHat+WOULjH1IYesTsnFcPefpugxgyoAGSPbt+wKIrMvT
         ctoRJmy2Wv/p15Iv5SfYpuuENwXm3NUasFzwSQqNFr73TJHJK5hT+NgUdZ38Dgkudc/d
         HHwA==
X-Gm-Message-State: AOAM533lYuah4pusLx42VSDXmCNZgXOUXUBBHAce4lvz0wtjTFEsoh9K
        YWPF0lixGmWkLLbPDQc/sfo=
X-Google-Smtp-Source: ABdhPJzK6ySGBDoy7X+Sa8BJu5AuMNQPU5BcFT3+k46/cJDNKCVlTQ5hfxyvbQLqUXFsT5VqVTnYOg==
X-Received: by 2002:a7b:c84f:: with SMTP id c15mr26337955wml.181.1643626811087;
        Mon, 31 Jan 2022 03:00:11 -0800 (PST)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id h6sm8874269wmq.26.2022.01.31.03.00.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 03:00:10 -0800 (PST)
Message-ID: <3a12de6d-48f6-b1c1-4fca-655c0db648c7@gmail.com>
Date:   Mon, 31 Jan 2022 11:00:09 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 4/4] i18n: transfer variables into placeholders in
 command synopsis
Content-Language: en-US
To:     =?UTF-8?Q?Jean-No=c3=abl_Avila_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?Jean-No=c3=abl_Avila?= <jn.avila@free.fr>
References: <pull.1123.v2.git.1643408643.gitgitgadget@gmail.com>
 <pull.1123.v3.git.1643580113.gitgitgadget@gmail.com>
 <b8e80e178eeb2fccd9e10d783c7cf4b5f4cc80e4.1643580113.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <b8e80e178eeb2fccd9e10d783c7cf4b5f4cc80e4.1643580113.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30/01/2022 22:01, Jean-Noël Avila via GitGitGadget wrote:
> From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
> 
> This applies the style guide for documentation.

I don't really understand the title of this patch. Should 'transfer' be 
'transform'? All the changes look fine but seem to be two sorts of 
changes mixed together
  - adding '<>' around arguments where they are missing
  - converting plurals followed by '...' into singulars followed by '...'

Best Wishes

Phillip

> Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
> ---
>   builtin/fast-export.c | 2 +-
>   builtin/reflog.c      | 4 ++--
>   builtin/rev-list.c    | 2 +-
>   3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> index 9f1c730e587..510139e9b54 100644
> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> @@ -26,7 +26,7 @@
>   #include "commit-slab.h"
>   
>   static const char *fast_export_usage[] = {
> -	N_("git fast-export [rev-list-opts]"),
> +	N_("git fast-export [<rev-list-opts>]"),
>   	NULL
>   };
>   
> diff --git a/builtin/reflog.c b/builtin/reflog.c
> index ee5ee8d8cf6..343a10d371b 100644
> --- a/builtin/reflog.c
> +++ b/builtin/reflog.c
> @@ -17,10 +17,10 @@ static const char reflog_expire_usage[] =
>   N_("git reflog expire [--expire=<time>] "
>      "[--expire-unreachable=<time>] "
>      "[--rewrite] [--updateref] [--stale-fix] [--dry-run | -n] "
> -   "[--verbose] [--all] <refs>...");
> +   "[--verbose] [--all] <ref>...");
>   static const char reflog_delete_usage[] =
>   N_("git reflog delete [--rewrite] [--updateref] "
> -   "[--dry-run | -n] [--verbose] <refs>...");
> +   "[--dry-run | -n] [--verbose] <ref>...");
>   static const char reflog_exists_usage[] =
>   N_("git reflog exists <ref>");
>   
> diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> index 777558e9b06..38528c7f156 100644
> --- a/builtin/rev-list.c
> +++ b/builtin/rev-list.c
> @@ -20,7 +20,7 @@
>   #include "packfile.h"
>   
>   static const char rev_list_usage[] =
> -"git rev-list [OPTION] <commit-id>... [ -- paths... ]\n"
> +"git rev-list [<options>] <commit-id>... [-- <path>...]\n"
>   "  limiting output:\n"
>   "    --max-count=<n>\n"
>   "    --max-age=<epoch>\n"

