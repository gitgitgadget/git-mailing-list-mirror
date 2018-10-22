Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D08FE1F453
	for <e@80x24.org>; Mon, 22 Oct 2018 14:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbeJVXFM (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Oct 2018 19:05:12 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:55027 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728295AbeJVXFM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Oct 2018 19:05:12 -0400
Received: by mail-it1-f194.google.com with SMTP id l191-v6so12114673ita.4
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 07:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=asuu+ksxeE49+Hv3CStDj6twSwI122dhRtegZLV0LLk=;
        b=HeKs7lkhi6YOZ9y33DlvJvoth6eergob7Yt/p42DBOSp/ohWbnYfgMBcjTsUjZXqbM
         ZCLBOc6PDFGeu9Llo/tW9YHxx1L3EbZrFEiPuVwpMIW7fND8e0jV13LIth/TRkylIWyn
         qVovwqK5Ip5wLDp14FGFJdXRwY4IeCihIeuSACzfacplrbn+spKWCmlQneTftMCm+x7Z
         Z6SiOG1nrWpkZAkwoencnMO5l4y39xLPRWmtR8sKIcM0G9ftkRzJFq0KFpyhf6gtI3vS
         r/YVN4NID1UQnpcQ0avdTEN8s+/bnJ6kdHCZjmMxSu6aZRQkOXDpbLWnKScE29fatE6S
         9K9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=asuu+ksxeE49+Hv3CStDj6twSwI122dhRtegZLV0LLk=;
        b=Q2KzuCS4IdbgXdHShMkjHVEzN2IvQaBsSsQ18ORH/00DnClzstJx2+3YB5M3nidYG0
         AULZFyXDCVyeWmUwT5STZS4h9JDlr9S2HifZuYLHLZI1xJgnfYSh2DGA/3Gu0Luy9X2u
         IQKetJ6msp6FXwC17Y/tQGPKq1f+XDg7WObpU28HtMl/Z3UGF/lbJmj857o3R30rnMGT
         qenAwV7hjfOlW4jxOvAjOo+T2sh/sZ2VOyc2qheJ0CiKevnjEWGvUV2tpneobrJcNrZ6
         kN0ZnknqPTu4mmqocaQJh1sT+cmFz2wnSC89fv54CK2rz2jwud4WJi6PpElSxqBzWXHU
         TrBA==
X-Gm-Message-State: ABuFfog9e8TKvSwDDUCGOC0X3oBBCEeNk4eIgESuOJXApfuHKsQgObIf
        daDvk47L51naWHjZ+3SQqGEROk0Coih4/AAGUS4=
X-Google-Smtp-Source: ACcGV61wMrOXTb2iMrB7fDX/A/sA1uVH5mbZjZKF61kFkkeZxTB0U1JlSrb1qomgFJlbjPDRQ+NsXA9fqQV3k2HvYwc=
X-Received: by 2002:a24:cd02:: with SMTP id l2-v6mr10152878itg.70.1540219580656;
 Mon, 22 Oct 2018 07:46:20 -0700 (PDT)
MIME-Version: 1.0
References: <20181017164021.15204-1-peartben@gmail.com> <20181022131828.21348-1-peartben@gmail.com>
 <20181022131828.21348-3-peartben@gmail.com>
In-Reply-To: <20181022131828.21348-3-peartben@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 22 Oct 2018 16:45:53 +0200
Message-ID: <CACsJy8Dcf8OknyMaSZxOaib54jLSSt71XXjTZD3UjgnH6J7QFA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] reset: add new reset.quiet config setting
To:     Ben Peart <peartben@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 22, 2018 at 3:38 PM Ben Peart <peartben@gmail.com> wrote:
>
> From: Ben Peart <benpeart@microsoft.com>
>
> Add a reset.quiet config setting that sets the default value of the --quiet
> flag when running the reset command.  This enables users to change the
> default behavior to take advantage of the performance advantages of
> avoiding the scan for unstaged changes after reset.  Defaults to false.
>
> Signed-off-by: Ben Peart <benpeart@microsoft.com>
> ---
>  Documentation/config.txt    | 3 +++
>  Documentation/git-reset.txt | 4 +++-
>  builtin/reset.c             | 1 +
>  3 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index f6f4c21a54..a2d1b8b116 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2728,6 +2728,9 @@ rerere.enabled::
>         `$GIT_DIR`, e.g. if "rerere" was previously used in the
>         repository.
>
> +reset.quiet::
> +       When set to true, 'git reset' will default to the '--quiet' option.
> +

With 'nd/config-split' topic moving pretty much all config keys out of
config.txt, you probably want to do the same for this series: add this
in a new file called Documentation/reset-config.txt then include the
file here like the sendemail one below.

>  include::sendemail-config.txt[]
>
>  sequence.editor::
-- 
Duy
