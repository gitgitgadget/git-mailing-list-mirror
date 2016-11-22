Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 491411FF30
	for <e@80x24.org>; Tue, 22 Nov 2016 10:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932644AbcKVKKw (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 05:10:52 -0500
Received: from mail-yw0-f194.google.com ([209.85.161.194]:35582 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932234AbcKVKKu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 05:10:50 -0500
Received: by mail-yw0-f194.google.com with SMTP id b66so1388771ywh.2
        for <git@vger.kernel.org>; Tue, 22 Nov 2016 02:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HITV2BDlYV8vnZOvza0c+gOfWulJuPVKsbua+tZ6oLM=;
        b=wKaZ3dFuOeMS+N4KNQSQnf1VE6Q8cYe6HTlhwDtmtNtiPCJ4py4bnELEL0h745OcMF
         gxD3vAPtxdIvuqfG9DGprBIWiBkYHtPMgWIMLmyJaDO0Qtm3y3ZeRPY2FwaVvKOnYnJF
         TS/tPGFDRqwYBo66xHC6Sy4AxhXAWM5CLf3ebNhpUSK+YniSh9N9D55UERK7TieraeId
         8g6Oz224cp7H7vk8ndvWhOHd0f3Vxx65KuSz2XCXZth0F2/a5rd8s3Xm0CmVjk/RzJ//
         35HeJQh/sbnWl0p8gBUpuobvXxKpsvoB2DI1nDW/vxhY3VjuNdsrpGaj1sdb3wxLQkLC
         ignw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HITV2BDlYV8vnZOvza0c+gOfWulJuPVKsbua+tZ6oLM=;
        b=jqMSGj4loxU3HQlEjgWL8s5PRjju3apcSw993YCLVeHA4WbufSb/i0ALX0zK2Dn+mb
         cabgAjkFJROFSLSDqAmtuUYhk4SY18A331YDZD/4ecas+jzWrpzgY4v2ydeOvhItFC+w
         HrKmTqf8jBtstZSiemmeGjjv1S5z6mz/nFFnSD8+LlzuxDpMFml0btQuNDOk6+GJFoPT
         686EsMV2gQrvidUCeZvtVcRukGNvDiiffe20/7gmwde0SPJNE9ZvDB8Z2MShdfHowglE
         zmtTqVa1E82066gHYJsp1vb4Ld4h8O9MdXXIz1kj7O/zMUOIDTTzFH2pivp9j9H5K2Gg
         TfLw==
X-Gm-Message-State: AKaTC018iW5vpQu6pRdJMmTRNdbPUfUB9vo6POGKoeLGBWkQNUBrUla0pz1WMbLauxe7Su8RE4XT2kCJDc9MFg==
X-Received: by 10.129.153.14 with SMTP id q14mr18738927ywg.191.1479809449810;
 Tue, 22 Nov 2016 02:10:49 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.211.7 with HTTP; Tue, 22 Nov 2016 02:10:19 -0800 (PST)
In-Reply-To: <5567548295222401fab10d3f2901c1787afbfd07.1479737858.git.johannes.schindelin@gmx.de>
References: <cover.1479737858.git.johannes.schindelin@gmx.de> <5567548295222401fab10d3f2901c1787afbfd07.1479737858.git.johannes.schindelin@gmx.de>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 22 Nov 2016 17:10:19 +0700
Message-ID: <CACsJy8D5oBR+vo2B+Ro2Q4SX0CG3jME4Gfs1_6AohccmpNvD0A@mail.gmail.com>
Subject: Re: [PATCH 2/3] stripspace: respect repository config
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Taufiq Hoven <taufiq.hoven@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 21, 2016 at 9:18 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> When eff80a9 (Allow custom "comment char", 2013-01-16) taught the
> `stripspace` command to respect the config setting `core.commentChar`,
> it forgot that this variable may be defined in .git/config.
>
> So when rebasing interactively with a commentChar defined in the current
> repository's config, the help text at the bottom of the edit script
> potentially used an incorrect comment character. This was not only
> funny-looking, but also resulted in tons of warnings like this one:
>
>         Warning: the command isn't recognized in the following line
>          - #
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/stripspace.c  | 4 +++-
>  t/t0030-stripspace.sh | 2 +-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/stripspace.c b/builtin/stripspace.c
> index 15e716e..1e62a00 100644
> --- a/builtin/stripspace.c
> +++ b/builtin/stripspace.c
> @@ -44,8 +44,10 @@ int cmd_stripspace(int argc, const char **argv, const char *prefix)
>         if (argc)
>                 usage_with_options(stripspace_usage, options);
>
> -       if (mode == STRIP_COMMENTS || mode == COMMENT_LINES)
> +       if (mode == STRIP_COMMENTS || mode == COMMENT_LINES) {
> +               setup_git_directory_gently(NULL);
>                 git_config(git_default_config, NULL);
> +       }

This conditional config file reading is a trap for similar bugs to
happen again. Is there any reason we should not just mark the command
RUN_SETUP_GENTLY in git.c and call git_config() here unconditionally?

>
>         if (strbuf_read(&buf, 0, 1024) < 0)
>                 die_errno("could not read the input");
-- 
Duy
