Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62309C433F5
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 20:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbiCKU6Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 15:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiCKU6W (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 15:58:22 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DB520B14C
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 12:57:09 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id s15so8351863qtk.10
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 12:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=iTq8t+DCCAHL9/dA+qC+HqpjVgQaqkbrUzk271MDu1M=;
        b=idBp/PCIBEL6WlA5qL1mZU4w0kOpUbZ8nXzlt0IOmeWMI2TvvIo81ddAVc+qOyMkMm
         NXQ3xUCspL2khXZZQqe1ZFiKudObWvda5Ra02JFwkjaVG//QfyY9KstLkjZh8xK8eAEw
         sdPG0APNhlMumHN+SS7ug9AJCqSKBWMu8FiuqU/plq3OD+UpKJYJG8wcRMawEqdlNhxP
         R12M79aHNoiTve502cx1lNoj+Qh4U26h/1vQ8RDuNfN6RYd6n0/MYFBXSaNTC0gjfNZj
         wexwTW6sMJg0XeqOpNthSoU7gHG9wa/pGEeAEbgUiCk5c4J53gU3HBcaxUsRUSW03HAq
         viyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iTq8t+DCCAHL9/dA+qC+HqpjVgQaqkbrUzk271MDu1M=;
        b=2Z14q8oKeNwQFo7Ld6rmXSEscJghS/409CIF5V0/tw4UZKBirR9KSeu7CGkf3ogfcQ
         2Iwu4paOnCzv0SYMrb9C7vu4DeMVXDeqlbQ2bbtsQ72LvFkT/Kd1fsADJCeXD3tt0Nbf
         NcIqRD4pv04bjgpd6MfiMW71EWT1ksskaguT8PS6aJXuBfvt3917yULV9VryDtjDst4U
         H2WwmGsjLzRgvPFDIQMzZoHq0iWTCoZmnWv5VrGvaKNVflEG9t28i33tw35XZis/Yn5A
         XVYVyYcFQ6I6VrKtnWi4NDp+DCL8KQQXerpVHKGD6tehBvCocLQXcoKDSH+D64eKnyav
         jbnQ==
X-Gm-Message-State: AOAM530Z3wfSq7k6SBRm5nBamONKE/9AhuTlgj+attpe2ZFTc8fG6msh
        luTeIg1x88gszejTOyOP2h2u
X-Google-Smtp-Source: ABdhPJyEk9exzh3XSuKfCNhoqpmvgRmUz1OaRhofkGIoMx4Zu4aWy2Ixm/CjqwaIt/buLoLjc79zbA==
X-Received: by 2002:ac8:5d49:0:b0:2df:f50f:f4eb with SMTP id g9-20020ac85d49000000b002dff50ff4ebmr10082990qtx.202.1647032202585;
        Fri, 11 Mar 2022 12:56:42 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id l19-20020a05622a051300b002dff3437923sm6263827qtx.11.2022.03.11.12.56.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Mar 2022 12:56:42 -0800 (PST)
Message-ID: <dd9413da-1b8c-2adf-c471-e5fd4230375c@github.com>
Date:   Fri, 11 Mar 2022 15:56:41 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH 1/1] Documentation/git-sparse-checkout.txt: add an
 OPTIONS section
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org
Cc:     vdye@github.com, newren@gmail.com, bagasdotme@gmail.com
References: <20220311132141.1817-1-shaoxuan.yuan02@gmail.com>
 <20220311132141.1817-2-shaoxuan.yuan02@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20220311132141.1817-2-shaoxuan.yuan02@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/11/2022 8:21 AM, Shaoxuan Yuan wrote:
> Add an OPTIONS section to the manual and move the descriptions about
> these options from COMMANDS to the section.

This is a good goal.

> +OPTIONS
> +-------

However, there are a few issues with the current approach. First, I
believe it would be better to start with COMMANDS, then OPTIONS.

To be fair, we are not consistent here. These commands use OPTIONS
and then COMMANDS:

* git-commit-graph.txt
* git-remote.txt
* git-revert.txt

These use [SUB]COMMANDS and then OPTIONS:

* git-maintenance.txt
* git-notes.txt
* git-p4.txt
* git-stash.txt
* git-submodule.txt
* git-worktree.txt

My preference would be OPTIONS second (and we can clean up the
other docs as #leftoverbits). In particular, I noticed that
the SYNOPSIS for git-maintenance.txt is out of date.	

> +'--[no-]cone'::
> +	Use with ['set'|'reapply'].
> +	Specify using cone mode or not. The default is to use cone mode.
>  +
>  By default, the input list is considered a list of directories, matching
>  the output of `git ls-tree -d --name-only`.  This includes interpreting

The other issue is that this context is detailing information about
the 'set' command and the input it takes. You'll want to make sure
the information is properly grouped.

> @@ -78,6 +59,11 @@ with the `--sparse-index` option, and will likely be incompatible with
>  other new features as they are added.  See the "Non-cone Problems"
>  section below and the "Sparse Checkout" section of
>  linkgit:git-read-tree[1] for more details.
> +
> +'--[no-]sparse-index'::
> +	Use with ['set'|'reapply'].

I do like these clear indicators of which commands allow this
option. I wonder if it should instead be

	Use with the `set` and `reapply` commands.

Thanks,
-Stolee
