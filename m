Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A3801F404
	for <e@80x24.org>; Tue, 27 Feb 2018 23:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752438AbeB0XYs (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 18:24:48 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:41810 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752428AbeB0XYr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 18:24:47 -0500
Received: by mail-wr0-f196.google.com with SMTP id f14so491511wre.8
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 15:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=vQpmjJkpe6t0v7N5yF+UNTjrN01dzv+IJiZV1BMMLLo=;
        b=tI2KKURJqeMtjLr652jiXI/ZSnI/O7y0YNWvYS4d9YMR18l+JgucBARxzhGgTed98G
         JxctIt74kryPJV/8X1aWyezx7nVYYmBfqtRTK3MbODEnKX65TOvTdNS04ksh6ahdV3o2
         9BH5Ygo23LHW6BirsOkZ32sG+5jVrEEch+JuBG0ZI4aIfXcqbZmQgbqqK4ptCSW3S8Wy
         m0gq6EJ9IGATtP5cySgIDS/yr9DgISoA3l4IFDiPj9vgAJ0KoDsXh8xkJzLhAO7qAW/X
         tXmH2fCnrT+JrRchmAo2f11QtPZ05mi3WFdONio6z7K0H6FcNbAPWmwJyyyfRk1sMq9f
         yASQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=vQpmjJkpe6t0v7N5yF+UNTjrN01dzv+IJiZV1BMMLLo=;
        b=cQJIaPavBXVa80uFbQGFKk50ko11TcLpiUhPzDZPl7lgI9tb+pKXYDHXva8UDIBllc
         qW3/K1YCrQBJXhKDQcH3PCuvEYRAj4cHFqjVN0gbw5t7mSkNAzlhfU8DJrVuYkXUNXeO
         ATAuaOVxdmKmP/7orE8llawbuqkg+MFobJ4CSt7lGyimwfYRdydP2Bxh+vGfUh2oXTnA
         HbC5+LRm3kJAopp/bVaCttUvDL3Tp3L0WjfEpTTryDghIUuGiRly3gDAxPWgyqAbUVzg
         7HXwfZBISE0gYahkLmq4DhE4JVEs+9ER0WTGoulrlcQ7cgwS8gjYUgOXZkDjAbxPr3/F
         gq1g==
X-Gm-Message-State: APf1xPDmbls2f/B0hiH8SuF0OTc00eHrrZH9XC8Ivw36Ny8kvSLP1Wqb
        Omfza1EjNojs8uE4tEbMcMY=
X-Google-Smtp-Source: AH8x225dAYiOnPNnG2eM5+6DN7pvqk2lSBt/YcfACs1QA0YTeareBGMvrulPrfgxot9vsivl5OihRQ==
X-Received: by 10.223.202.18 with SMTP id o18mr15239568wrh.4.1519773885725;
        Tue, 27 Feb 2018 15:24:45 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v63sm690265wrc.69.2018.02.27.15.24.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Feb 2018 15:24:44 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 0/2] diff: add --compact-summary (aka nd/diff-stat-with-summary)
References: <20180224140509.25061-1-pclouds@gmail.com>
        <20180224140959.25402-1-pclouds@gmail.com>
Date:   Tue, 27 Feb 2018 15:24:44 -0800
In-Reply-To: <20180224140959.25402-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Sat, 24 Feb 2018 21:09:57 +0700")
Message-ID: <xmqqa7vunhhf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> ... and v5 fixes the commit message of 2/2 where in v4 it still
> mentions --stat-with-summary instead of --compact-summary. Sorry.
>
> Nguyễn Thái Ngọc Duy (2):
>   diff.c: refactor pprint_rename() to use strbuf
>   diff: add --compact-summary

Thanks, will queue.  I guess we all run out of paints of different
colours, and it's a good time to go incremental by merging the topic
to 'next'.

>
>  Documentation/diff-options.txt                |  8 ++
>  diff.c                                        | 96 ++++++++++++-------
>  diff.h                                        |  1 +
>  t/t4013-diff-various.sh                       |  5 +
>  ...ty_--root_--stat_--compact-summary_initial | 12 +++
>  ...-R_--root_--stat_--compact-summary_initial | 12 +++
>  ...tree_--stat_--compact-summary_initial_mode |  4 +
>  ...e_-R_--stat_--compact-summary_initial_mode |  4 +
>  8 files changed, 109 insertions(+), 33 deletions(-)
>  create mode 100644 t/t4013/diff.diff-tree_--pretty_--root_--stat_--compact-summary_initial
>  create mode 100644 t/t4013/diff.diff-tree_--pretty_-R_--root_--stat_--compact-summary_initial
>  create mode 100644 t/t4013/diff.diff-tree_--stat_--compact-summary_initial_mode
>  create mode 100644 t/t4013/diff.diff-tree_-R_--stat_--compact-summary_initial_mode
