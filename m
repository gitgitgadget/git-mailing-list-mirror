Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37A891F516
	for <e@80x24.org>; Mon, 25 Jun 2018 19:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934912AbeFYTQB (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 15:16:01 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36102 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933030AbeFYTP6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 15:15:58 -0400
Received: by mail-wr0-f193.google.com with SMTP id f16-v6so14789658wrm.3
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 12:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=x129DJx/900g6kvgJ6LgSp4wUitI8SSLDev7oar/jiU=;
        b=jV+j9ieTI+vXVK5F0j7E7RKx7LDbBXdq/bCaMvvyz3BU4tXCFM3As0mVAo2SCUmgBF
         GRMMCW28UBBvBgUY7/qoGSqI4Lb3CeYPXPXfNcPZDjd3diNb2RUdg3+J/79F0ORn6kEC
         mtvq7JGzKn0S1GtAIjHH3sWiYTfkohtmoMjHvKx/5V0NoFEPI8IWkxBUUjbIAZ+LdJVA
         lCTdbU/TXUYQr3tEUF6IxaVXZfl+tDWu302EecpYS3h52WYaXtLBnbqq6lbuswP2nMB9
         u7j7LYXjZzYf2Z+1uSsjDe4O9T5gExQ3oXgFr/2/xbMUFkmtzhse4molXDJqk1//u6VO
         Ljvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=x129DJx/900g6kvgJ6LgSp4wUitI8SSLDev7oar/jiU=;
        b=qWy37rCqf0iEvotQ0JS0dRwLxa3qksf4umnXU9ECBa2l709BIS/MC9LDCfHR0XP0SD
         EL+vDzqzGOWxekWwTwbPkgQKFFp2HoRdugKw7tPa4LXk5L7lG68cvv1SvG2Vh1VT+xmq
         ks6RNcUGyos2ltp0B3I9HDVUoyYToznr6p3t1r0PX7tRDo//WUwSGHBUkqy4jaDXtTnR
         Tso2Jigg3PhaQ3Hcv4uik8GUC/WFl0D25w+VaiLs6xhzHJtPmwjkZijQDCxt7eQ0aZAg
         etp80lCfMF+GB2W3Vn5W7kSqzvG7duTdT7xC41xph0WZNtEMlncYMFsdQ5IHRAIv9K9G
         aNAQ==
X-Gm-Message-State: APt69E1UvMjBTPTtCzFeawPw6MEvG3DeCMmRSmVf8Gajfa9NFi5aELBo
        tZHnVD97gyjtnfriprIkUI0=
X-Google-Smtp-Source: ADUXVKJ5c0lg/nFS4/eepqvbiNc5mqOlYy0xddgcIa8LvmJWlRxJKtL3EJ5s/hPpTPtvgAYOaO5TTg==
X-Received: by 2002:adf:86e9:: with SMTP id 38-v6mr12142184wry.232.1529954156140;
        Mon, 25 Jun 2018 12:15:56 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w67-v6sm3486wmw.0.2018.06.25.12.15.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 12:15:55 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com, pclouds@gmail.com,
        avarab@gmail.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 03/24] multi-pack-index: add builtin
References: <20180607140338.32440-1-dstolee@microsoft.com>
        <20180625143434.89044-1-dstolee@microsoft.com>
        <20180625143434.89044-4-dstolee@microsoft.com>
Date:   Mon, 25 Jun 2018 12:15:54 -0700
In-Reply-To: <20180625143434.89044-4-dstolee@microsoft.com> (Derrick Stolee's
        message of "Mon, 25 Jun 2018 10:34:13 -0400")
Message-ID: <xmqqr2kuoexh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> This new 'git multi-pack-index' builtin will be the plumbing access
> for writing, reading, and checking multi-pack-index files. The
> initial implementation is a no-op.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  .gitignore                             |  3 +-
>  Documentation/git-multi-pack-index.txt | 36 ++++++++++++++++++++++++
>  Makefile                               |  1 +
>  builtin.h                              |  1 +
>  builtin/multi-pack-index.c             | 38 ++++++++++++++++++++++++++
>  command-list.txt                       |  1 +
>  git.c                                  |  1 +
>  7 files changed, 80 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/git-multi-pack-index.txt
>  create mode 100644 builtin/multi-pack-index.c
>
> diff --git a/.gitignore b/.gitignore
> index 388cc4beee..25633bc515 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -99,8 +99,9 @@
>  /git-mergetool--lib
>  /git-mktag
>  /git-mktree
> -/git-name-rev
> +/git-multi-pack-index
>  /git-mv
> +/git-name-rev

Nice attention to the detail (even though the patch as an
incremental change gets distracting, the result is better
and future changes to the file will read cleaner).

> diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git-multi-pack-index.txt
> new file mode 100644
> index 0000000000..9877f9c441
> --- /dev/null
> +++ b/Documentation/git-multi-pack-index.txt
> @@ -0,0 +1,36 @@
> +git-multi-pack-index(1)
> +======================
> +
> +NAME
> +----
> +git-multi-pack-index - Write and verify multi-pack-indexes
> +
> +
> +SYNOPSIS
> +--------
> +[verse]
> +'git multi-pack-index' [--object-dir <dir>]
> +
> +DESCRIPTION
> +-----------
> +Write or verify a multi-pack-index (MIDX) file.
> +
> +OPTIONS
> +-------
> +
> +--object-dir <dir>::
> +	Use given directory for the location of Git objects. We check
> +	<dir>/packs/multi-pack-index for the current MIDX file, and
> +	<dir>/packs for the pack-files to index.

Do we want to `quote` these constant strings?

> diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
> new file mode 100644
> index 0000000000..f101873525
> --- /dev/null
> +++ b/builtin/multi-pack-index.c
> @@ -0,0 +1,38 @@
> +#include "builtin.h"
> +#include "cache.h"
> +#include "config.h"
> +#include "parse-options.h"
> +
> +static char const * const builtin_multi_pack_index_usage[] ={

ERROR: spaces required around that '=' (ctx:WxV)
#112: FILE: builtin/multi-pack-index.c:6:
+static char const * const builtin_multi_pack_index_usage[] ={
                                                            ^

