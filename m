Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BD8420248
	for <e@80x24.org>; Mon, 25 Feb 2019 20:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfBYUIR convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 25 Feb 2019 15:08:17 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44087 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbfBYUIR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 15:08:17 -0500
Received: by mail-qt1-f193.google.com with SMTP id d2so12073884qti.11
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 12:08:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bLdJpJ3Yc3v3gNoZPF/o+K9qIFPldVgJKF9NvZvhOoE=;
        b=Ri2O2xF1O2qSKAmDUVmtYVmnp3XpE96nj1+Zx5gBMy4n+N246Fk8rN5ShdcH5mFRiD
         0UtCnQBK8av+ierG1DsSvblQ+7YCqA1+59HkvNpdG3nBf3PBqjzLn1VFhUU+M9H1jBFp
         8E/tSMH3t5kGN1bSiSnSkyvDMUk2jxn4x61aGZEEQlu+A2b6IR4r/P+gRI8hN1p3ytvP
         83SBUZHzUpCXcVKZvFTGDgslki4jAp7MHGX9M0iVbc/kWPthgGkwRQyHy/lwdC9/ugH0
         iniNdiCHjfTBgaMxnxDWCviGgd7ICECGFOBlSy/yL+IXROO0JYR1nt0PEvUyKwpVSf2h
         t+4w==
X-Gm-Message-State: AHQUAuanf4FSr+yvzsjoRwViP/hPMo76WOtoBs2b3lUYnS/Dihf3LXO6
        8hzHOCCztSubLBtgzQztQQW1/sWxOT6kQG4BI90=
X-Google-Smtp-Source: AHgI3IYrwoqi6fwEt3y/ejkAVWYJn28/oz+54ubi9n9pz1tT9aKeGQuAtATGN+vz5HwuhqKSmfgWcv7WZB1pngikYmQ=
X-Received: by 2002:a0c:87b1:: with SMTP id 46mr15107322qvj.203.1551125296711;
 Mon, 25 Feb 2019 12:08:16 -0800 (PST)
MIME-Version: 1.0
References: <cover.1551123979.git.martin.agren@gmail.com> <e960fec4b492f3edf7bade35862333af5e8704d7.1551123979.git.martin.agren@gmail.com>
In-Reply-To: <e960fec4b492f3edf7bade35862333af5e8704d7.1551123979.git.martin.agren@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 25 Feb 2019 15:08:05 -0500
Message-ID: <CAPig+cS7BdHhLn+XjjyVa+PC040y-E4iPD=kuDtigenzSHcFKQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] Documentation/Makefile: add missing xsl dependencies
 for manpages
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 25, 2019 at 3:03 PM Martin Ågren <martin.agren@gmail.com> wrote:
> These stylesheets very rarely change, but when they do, it really helps
> if the manpages depend on them. We're casting the net a bit too wide
> here, since we'll only ever use a subset of the stylesheets, but since
> these files change so rarely, that should be ok. It's better than
> missing a dependency.
>
> Signed-off-by: Martin Ågren <martin.agren@gmail.com>
> ---
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> @@ -354,7 +354,7 @@ $(OBSOLETE_HTML): %.html : %.txto asciidoc.conf
> -%.1 %.5 %.7 : %.xml manpage-base-url.xsl
> +%.1 %.5 %.7 : %.xml manpage-base-url.xsl $(wildcard manpage*.xsl)

The wildcard expression also matches the manpage-base-url.xsl
mentioned explicitly. Did you intentionally retain the explicit one or
was that an oversight?
