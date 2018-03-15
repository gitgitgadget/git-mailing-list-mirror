Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64CD31F404
	for <e@80x24.org>; Thu, 15 Mar 2018 22:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932676AbeCOWu1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 18:50:27 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:42957 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932622AbeCOWu0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 18:50:26 -0400
Received: by mail-vk0-f67.google.com with SMTP id y127so5238891vky.9
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 15:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tJqYaniGkZSj5jERmbZ4wIQjDs39NzZ+ruFx5VoAk6k=;
        b=He9Fz8QyIin6M4aHIBQ10EZF/icr8dvf/ybXekSfDAynDzvyxUXS8olljjwghwhscz
         jDgUMktVD5Y2TBEj7VCqa+T6bAk5B0yZh3s/5/VDvIuOv7uI8yLlvoHcxzC0uMGYdkIA
         IfiOoQ77Pxlanh6V3aA2iF0sjfkucF/cS2I1utMx/XN5blf8Vy9oU26VcW920dH0c4Ut
         qMpUI0WJJ4L3yzftbggo/yEtbHORS+c8rETH9CFUfi7VV/r+mE6PPoChCj8fHq+z+qCd
         eDEYi+oJZUSw0PT4eYOs5UspeMEe+Z8vZlQUbvV7dKftPaDVl52Son5wmMYX+EvlWGKn
         2G4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tJqYaniGkZSj5jERmbZ4wIQjDs39NzZ+ruFx5VoAk6k=;
        b=HDM/gBL8GlNRhh5J5OfKJr9K7jMcz0vz+sfzvoTibO1RAez5tCHPbmmYoOlwa7D30c
         2ITk604QVZNT4QRYJqksYUv7OpZO1vRG6pJJ5WxqQRttvEIRNvd/mclr2jht9I7O4WG8
         xhyBENQ99J7H3Pc4kXi0P73Cg25w2VQpCLNHaKntJGr+srl5tWvgE9nmt1uT8nhReLJV
         ArO8e0Jy9qgVBBOJUElLIFvLmJFn6fBuB3oVvOsZ0oTx18bOK+n16tWGFllS1Al1e++O
         KrIP6m3GRMhDlv8t2AOQYRp4eCnXetcvaNMMkbGs8Uo84RqJMpYXoQdzGsaRgMyJCV0B
         Uc2g==
X-Gm-Message-State: AElRT7GHC6n4lusMKNV8lXAsr63QRWYXjR0T43bTOk6x/0ILZ6lYQhUt
        KxFXR1Lo5J4vcZAU+n3OIXtawKchY0Da+13WDSU=
X-Google-Smtp-Source: AG47ELvwzTu8IftmZ3CfzHLtcub2Q2XcT9xJyDh+R6gAw3yC4auUnqWYGq3iMA2pwOV/BbcqbGFqmzj6OWhCafYSnps=
X-Received: by 10.31.171.5 with SMTP id u5mr7948846vke.120.1521154225969; Thu,
 15 Mar 2018 15:50:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.59.233 with HTTP; Thu, 15 Mar 2018 15:50:25 -0700 (PDT)
In-Reply-To: <20180314192736.70602-13-dstolee@microsoft.com>
References: <1519698787-190494-1-git-send-email-dstolee@microsoft.com>
 <20180314192736.70602-1-dstolee@microsoft.com> <20180314192736.70602-13-dstolee@microsoft.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Thu, 15 Mar 2018 23:50:25 +0100
Message-ID: <CAM0VKjmwJYe01XBFeZaea=bzi+a_11MBvmqQN8GRWqZe8OTW7g@mail.gmail.com>
Subject: Re: [PATCH v6 12/14] commit-graph: read only from specific pack-indexes
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        git@jeffhostetler.com, Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 14, 2018 at 8:27 PM, Derrick Stolee <stolee@gmail.com> wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
>
> Teach git-commit-graph to inspect the objects only in a certain list
> of pack-indexes within the given pack directory. This allows updating
> the commit graph iteratively.

This commit message, and indeed the code itself talk about pack
indexes ...

> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/git-commit-graph.txt | 11 ++++++++++-
>  builtin/commit-graph.c             | 33 ++++++++++++++++++++++++++++++---
>  commit-graph.c                     | 26 ++++++++++++++++++++++++--
>  commit-graph.h                     |  4 +++-
>  packfile.c                         |  4 ++--
>  packfile.h                         |  2 ++
>  t/t5318-commit-graph.sh            | 10 ++++++++++
>  7 files changed, 81 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
> index 51cb038f3d..b945510f0f 100644
> --- a/Documentation/git-commit-graph.txt
> +++ b/Documentation/git-commit-graph.txt
> @@ -32,7 +32,9 @@ COMMANDS
>  'write'::
>
>  Write a commit graph file based on the commits found in packfiles.
> -Includes all commits from the existing commit graph file.
> ++
> +With the `--stdin-packs` option, generate the new commit graph by
> +walking objects only in the specified packfiles.

... but this piece of documentation ...

> +               OPT_BOOL(0, "stdin-packs", &opts.stdin_packs,
> +                       N_("scan packfiles listed by stdin for commits")),

... and this help text, and even the name of the option talk about
packfiles.
