Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4142E1F597
	for <e@80x24.org>; Sun, 22 Jul 2018 05:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbeGVGou (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jul 2018 02:44:50 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:45193 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbeGVGou (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jul 2018 02:44:50 -0400
Received: by mail-yb0-f195.google.com with SMTP id h127-v6so6126476ybg.12
        for <git@vger.kernel.org>; Sat, 21 Jul 2018 22:49:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=je5UDRh6gsbLEdbgepS/Sy5pjWlhJ6jc4ckw9whalsM=;
        b=lUZ+oMPnxt3tZVuMu7lGB1WoVEQwgyAViDhWI31b0MHpOUANv6Jq7ZpyLBEY3iSEey
         4N0Vs972/lBemjKTHMDC7cUvaLkWbtQ0tnLM+LLUMB/OyDMXUjgiCn6KikvUlVvwFKR6
         2OdOfwx1jqGyxuxNepIHoIG+4GV4M84f6OGpoqCuwuWAxym+NZ/UFgBEg7zGme4VLejJ
         EwYT0bho4v8G/43CsjkWroq0MXCXZOHfRrxv2zJ/gskyO6FKaKYT9mNeloTr5HljZy6Z
         /0DxU5OvuT4gQtaRvftaePTdkzeRUJYBJHohWKSGDViHUgijJ7P8o6D5+ASczZ19MJpM
         5xxg==
X-Gm-Message-State: AOUpUlGB2Y4RJnKaBe5oFamn3g3g9SLs5ZWi2P+OHlm9rqCjq6xaTh+w
        3UmyAOcSjY0Ec9J9QZCWXnXxVtvgQX/buU6Wd/Y=
X-Google-Smtp-Source: AAOMgpcq+7DL81cUJbsle83OFANMciHnDsarQ7W0snZIVaMi1xIjStVlz4M+I4J/KDO46AfMpXB0bv7rSitzVemdI4c=
X-Received: by 2002:a25:d38f:: with SMTP id e137-v6mr4068864ybf.287.1532238563274;
 Sat, 21 Jul 2018 22:49:23 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1.v3.git.gitgitgadget@gmail.com> <pull.1.v4.git.gitgitgadget@gmail.com>
 <9b3632324f93afdab7273df7a7dc119e14a261a1.1532210683.git.gitgitgadget@gmail.com>
In-Reply-To: <9b3632324f93afdab7273df7a7dc119e14a261a1.1532210683.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 22 Jul 2018 01:49:11 -0400
Message-ID: <CAPig+cQ6H1ys6MrZ3qV_93WCQxz0mxnQJMm23XRTrDh1WHHnGg@mail.gmail.com>
Subject: Re: [PATCH v4 18/21] completion: support `git range-diff`
To:     gitgitgadget@gmail.com
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 21, 2018 at 6:05 PM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Tab completion of `git range-diff` is very convenient, especially
> given that the revision arguments to specify the commit ranges to
> compare are typically more complex than, say, what is normally passed
> to `git log`.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> @@ -1976,6 +1976,20 @@ _git_push ()
> +_git_range_diff ()
> +{
> +  case "$cur" in
> +  --*)
> +          __gitcomp "
> +               --creation-factor= --dual-color
> +                  $__git_diff_common_options
> +                  "

This is indented with a mix of spaces and tabs.

    Applying: completion: support `git range-diff`
    .git/rebase-apply/patch:18: space before tab in indent.
                --creation-factor= --dual-color
    warning: 1 line adds whitespace errors.
    Applying: range-diff: make --dual-color the default mode
    .git/rebase-apply/patch:105: space before tab in indent.
                --creation-factor= --no-dual-color
    warning: 1 line adds whitespace errors.

Other parts of this script seem to use tabs for indentation.
