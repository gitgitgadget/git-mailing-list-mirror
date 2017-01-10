Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6755A20756
	for <e@80x24.org>; Tue, 10 Jan 2017 16:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938260AbdAJQwC (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 11:52:02 -0500
Received: from mail-it0-f41.google.com ([209.85.214.41]:36527 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935411AbdAJQwB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 11:52:01 -0500
Received: by mail-it0-f41.google.com with SMTP id c7so45206326itd.1
        for <git@vger.kernel.org>; Tue, 10 Jan 2017 08:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1sXJbTD6GO0NCYasKmuQrlvACCenbbiB4Km4MKRq86s=;
        b=FaEG6hifFpOlZyYJbF77wY6pkzdYkYkb80K46KOFCrz89gbNihaUamTV2JNMF8qtLs
         xVfjCca1KX4f1I16r5OFKIacB1H9qsG0h/q7DAR/nCPKz0A3U+OHGKW8ydFH+/hPoOr4
         Oq0GRw0gHnE+xHx3q20iQa1DIE/NRPSPcJBI4Ps5fE99UNzdbfLxGNcdJkLD/yINHyF4
         tgUqoLLrAK2iUDlvFsEXvbtY3d7dp79XtZCitFSHR9S4pJLCUXr8TWJ60pGioSq/WlLD
         uXJqUU1ZN/EsNqjbdoM75Ze8sHqjOxTNUVs45YZ4X6q9OdqAoASyTIFJaNeJnjnEgyFa
         4jew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1sXJbTD6GO0NCYasKmuQrlvACCenbbiB4Km4MKRq86s=;
        b=ahMp8j64CAKdUajk+mXtRhPL53pxEIA0I7bncQASGge/9nIuDVtgwpuDF/AHesdRFP
         xGsaxtYhZZxRJNnnYHeEka/MVwldzECV1yMMcBOVN63Wx5OOs2DHK5K7Z4Ahkd4/S3Eg
         WccccVyf3Mooqtin2PNF8gXn8Oykjt3oM9caLxK4s+/7yCUnAs85AsS/rXFH56nNuAYp
         a5G9LjGZRdUPZ19eMi23CmfKEPOKJLKVnraWZ/9IORWB2KjvzJYBmSh1VgRspYLQpnIz
         70hRUWv1QLJu/kx314BtMc83cdt/rOVphpV4C2CQdNU0kc87jDUasoShVm6kuy4jVozX
         5SzQ==
X-Gm-Message-State: AIkVDXJLa3G7RSKJ2ki6sGCEY1pHD6ZTiGOChNg3C6t0X5oxtnyBifT6i+k/nkthtWwNdSDjJ3Mb9/zHJvov4Nkj
X-Received: by 10.36.88.143 with SMTP id f137mr3821836itb.116.1484067120808;
 Tue, 10 Jan 2017 08:52:00 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Tue, 10 Jan 2017 08:52:00 -0800 (PST)
In-Reply-To: <20170110112524.12870-3-pclouds@gmail.com>
References: <20170110112524.12870-1-pclouds@gmail.com> <20170110112524.12870-3-pclouds@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 10 Jan 2017 08:52:00 -0800
Message-ID: <CAGZ79kZe_EG8YhpPtBwPqrR+yPjp2rQbqkAvUX6zeVNXg58NqQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] config: --worktree for manipulating per-worktree
 config file
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Max Kirillov <max@max630.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> +               if (repository_format_worktree_config)
> +                       given_config_source.file = git_pathdup("config.worktree");
> +               else if (worktrees[0] && worktrees[1]) {
> +                       die("BUG: migration is not supported yet");
> +               } else
> +                       given_config_source.file = git_pathdup("config");

nit: inconsistent use uf braces for single statements here.
I mean the braces are needed in the BUG case, as otherwise we'd
have a dangling else, but then you could put the brace in the else case as well.
This nit doesn't warrant a reroll on its own.

> +               free_worktrees(worktrees);
> +       } else if (given_config_source.file) {
>                 if (!is_absolute_path(given_config_source.file) && prefix)
>                         given_config_source.file =
>                                 xstrdup(prefix_filename(prefix,
> --
> 2.8.2.524.g6ff3d78
>
