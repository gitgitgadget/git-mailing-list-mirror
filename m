Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99499C4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 17:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7589760F0F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 17:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237610AbhHCRBu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 13:01:50 -0400
Received: from mail-ej1-f53.google.com ([209.85.218.53]:33437 "EHLO
        mail-ej1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237657AbhHCRA5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 13:00:57 -0400
Received: by mail-ej1-f53.google.com with SMTP id hs10so28718468ejc.0
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 10:00:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E5FBFNyhY/wweHBTGhgOGL/6OXAxT5aUs3ae3GRvanQ=;
        b=kMQydk1lVOOEtmfVFFfmOs5sK7+F4KV1O+10RDJy9JRPSVOF3BhrS/mYZ7CxdZ5Z9n
         8N/RFJ2eqNtUC976Tkns/9tc0S0O8Tnzfyylp+Li8drk4cAWyXr1CGU7YH7/zFzxP4Tg
         Mq3UX7gpfTEPns0tsXGxWYh6uyI86u0y2MExpbzkUg7tsLl3GA5X1gapvDhKwRUF75wy
         K/FMiFHMltVgh3VY6M20U5JgHmbVUKUjIksNQJZlzQ3rljervE0U/gS5l7OnGL2yclpy
         1JOIin30JO6gTUR/Y6eys3RQRL4d5R0ZpANSxS//FD/ohOq+Ox5xVlSVxYj0XFuGaP3j
         qXYQ==
X-Gm-Message-State: AOAM531BhgD8UwAac5q7WIynFrpWivDJnJGTzjNE5B4JkrSpaUAWpEax
        mfSo+/4GZc6kmj3lNS+J0W26itd0USnQyw8DrSg=
X-Google-Smtp-Source: ABdhPJx/KTx26KgtQrerOpQVSPAjSXuucFanGOwLi7GEEPINfjtvlY+3ZwqD2bkWdigqPBz3mxzSKNXJwk7LY6n8BUo=
X-Received: by 2002:a17:906:c834:: with SMTP id dd20mr21741278ejb.371.1628010045700;
 Tue, 03 Aug 2021 10:00:45 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1059.git.git.1628004920.gitgitgadget@gmail.com> <6116f4750fd228b96ee293033f867a964b87eb5f.1628004920.git.gitgitgadget@gmail.com>
In-Reply-To: <6116f4750fd228b96ee293033f867a964b87eb5f.1628004920.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 3 Aug 2021 13:00:34 -0400
Message-ID: <CAPig+cRrSnrD4jnOOrbqZUbvkxKi0oLH51L0dxC+m9nzDnmf4w@mail.gmail.com>
Subject: Re: [PATCH 06/10] merge-strategies.txt: avoid giving special
 preference to patience algorithm
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 3, 2021 at 11:35 AM Elijah Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> We already have diff-algorithm that explains why there are special diff
> algorithms, so we do not need to re-explain patience.  patience exists
> as its own toplevel option for historical reasons, but there's no reason
> to give it special preference or document it again and suggest it's more
> important than other diff algorithms, so just refer to it as a
> deprecated shorthand for `diff-algorithm=patience`.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
> diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strategies.txt
> @@ -37,11 +37,7 @@ theirs;;
>  patience;;
> -       With this option, 'merge-recursive' spends a little extra time
> -       to avoid mismerges that sometimes occur due to unimportant
> -       matching lines (e.g., braces from distinct functions).  Use
> -       this when the branches to be merged have diverged wildly.
> -       See also linkgit:git-diff[1] `--patience`.
> +       Deprecated shorthand for diff-algorithm=patience.

Probably want to wrap backticks around `diff-algorithm=patience`. The
rest of this file seems to be pretty consistent about it. Indeed, the
existing deprecation in this file does so:

    rename-threshold=<n>;;
        Deprecated synonym for `find-renames=<n>`.

Maybe also s/shorthand/synonym/ for consistency with the existing
deprecation notice.
