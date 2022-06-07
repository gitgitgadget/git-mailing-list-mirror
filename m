Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1BAC433EF
	for <git@archiver.kernel.org>; Tue,  7 Jun 2022 10:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240446AbiFGKZO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 06:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240981AbiFGKZG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 06:25:06 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A1F5DE41
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 03:25:04 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id u8so19151062wrm.13
        for <git@vger.kernel.org>; Tue, 07 Jun 2022 03:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FmAo+RBuAgHNJRfuFthsraSF+1RLIZJ4GmOEBW9kzDU=;
        b=Y94xfflqJAuTwRSdmRhi9cjN/FTleKXioCQ9MLknSZnz6lR7WMdfizj049xc+qFZ7e
         v9XEAdVZ+psAHZ9Fl42i7qPqamVaQR9+FaJyc9T5j9P/7hMjGY5dtuFq7idbU6wseyD+
         wn1OxlNHnUoD7l234PSIZwJTo8nSK2d88/wI2l+Kqec0mzowj4QkBz1ytv+2gAYZ/5S9
         TeCoSu+emMdmoKYl/L1/yXY+4Rezfs3a2OtLJzbxKrW/vKFNo4ZoOunLTHVlSuD1oKv8
         KLwRsAe8RLvKfqu/lfFDRFO2BMXoohxlG8pd1yn6AOwzsUNcFrbYEQkvdMZrJ+r5XqRh
         PTPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FmAo+RBuAgHNJRfuFthsraSF+1RLIZJ4GmOEBW9kzDU=;
        b=nNrAaX0iT8LXtr8utJ1fH+gBlcOZKT2qlK+Y+1iR7EPQ3zKgbvKuiNSzCTCN5vNd+N
         QAdq6MKZcR+JXZwI87iNc9hvyYEA3fNeK5MITf5a25qilv2Jn87mIZusss2zklIqMgsq
         Uz8Ziue8bB+2cIfyb1R8eQfULAbhaOTeYCpDp/kuHSK2b0qWLqVXqbZHoYxKafkzrEc0
         92JYOm3zlzNYyBvnpuSPHPQP1F6Ry4ks7sWfhvj8VqhsX/2gc/j8w5cUzC7EZZpVkYgW
         YEZAbg3frUSbYAclcc8aUXq8Zhl6xdd9Aw54BjEb2XKiHQU7lHRgRhBy5Pz2TxqbnzQ+
         ppEg==
X-Gm-Message-State: AOAM532yay1uQSnr+NPcJLsgk4aLWtlU121D9TFiPntehQLGlJbIWna8
        uwtMPvcnpL00K33vdG58LEs=
X-Google-Smtp-Source: ABdhPJwDy+Ve2lDkXFQ+mCKQeqh6Pw39ETBfgozakyFlTtddvcMff1SDh4q108lRLIgatoKrI4YZdg==
X-Received: by 2002:a5d:64c1:0:b0:20f:d995:f896 with SMTP id f1-20020a5d64c1000000b0020fd995f896mr26201400wri.180.1654597503317;
        Tue, 07 Jun 2022 03:25:03 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.192])
        by smtp.gmail.com with ESMTPSA id z13-20020adfe54d000000b002103cfd2fbasm18592900wrm.65.2022.06.07.03.25.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 03:25:02 -0700 (PDT)
Message-ID: <c9a5369a-8c87-0ee8-bed7-16b2cd58717b@gmail.com>
Date:   Tue, 7 Jun 2022 11:25:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/4] rebase: add --update-refs option
Content-Language: en-GB-large
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1247.git.1654263472.gitgitgadget@gmail.com>
 <23fa663886405596370e5fc95f679ef299f0725c.1654263472.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <23fa663886405596370e5fc95f679ef299f0725c.1654263472.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee

Just a couple of minor comments.

On 03/06/2022 14:37, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
> [...]
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 262fb01aec0..866554fc978 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -609,6 +609,13 @@ provided. Otherwise an explicit `--no-reschedule-failed-exec` at the
>   start would be overridden by the presence of
>   `rebase.rescheduleFailedExec=true` configuration.
>   
> +--update-refs::
> +--no-update-refs::
> +	Automatically force-update any branches that point to commits that
> +	are being rebased. Any branches that are checked out in a worktree
> +	or point to a `squash! ...` or `fixup! ...` commit are not updated
> +	in this way.
> +
>   INCOMPATIBLE OPTIONS
>   --------------------

We should add --update-refs to the list of options that are incompatible 
with --apply.

> diff --git a/sequencer.c b/sequencer.c
> index 8c3ed3532ac..d6151af9849 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -35,6 +35,8 @@
>   #include "commit-reach.h"
>   #include "rebase-interactive.h"
>   #include "reset.h"
> +#include "branch.h"
> +#include "log-tree.h"
>   
>   #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
>   
> @@ -5603,10 +5605,104 @@ static int skip_unnecessary_picks(struct repository *r,
>   	return 0;
>   }
>   
> +struct todo_add_branch_context {
> +	struct todo_list new_list;

Rather than using a struct todo_list I think it would be simpler overall 
to add
	struct todo_list_item *item;
	size_t nr, alloc;

instead, as I found it confusing that we were (correctly) using the 
strbuf of the old list when adding the update-ref line to the new list.

> +	struct strbuf *buf;
> +	struct commit *commit;
> +};
> [...]
> +	for (i = 0; i < todo_list->nr; ) {
> +		struct todo_item *item = &todo_list->items[i];
> +
> +		do {
> +			/* insert ith item into new list */
> +			ALLOC_GROW(ctx.new_list.items,
> +				   ctx.new_list.nr + 1,
> +				   ctx.new_list.alloc);
> +
> +			memcpy(&ctx.new_list.items[ctx.new_list.nr++],
> +			       &todo_list->items[i],
> +			       sizeof(struct todo_item));

May be
	ctx.new_list.items[ctx.new_list.nr++] = todo_list->items[i++];
would be clearer

Best Wishes

Phillip
