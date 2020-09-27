Return-Path: <SRS0=TjTC=DE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48F7C4346E
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 08:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7812323976
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 08:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730474AbgI0IXg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Sep 2020 04:23:36 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:36911 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730438AbgI0IXg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Sep 2020 04:23:36 -0400
Received: by mail-ej1-f65.google.com with SMTP id nw23so4173604ejb.4
        for <git@vger.kernel.org>; Sun, 27 Sep 2020 01:23:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KlU8XF5LfEBEcLahM4OJirKqYa1huhjwSLe2c47t1kI=;
        b=FjjYOtJBXJlzzDc/rUj0G/G+Ff7uLn0Bbs03hctinlAoxlcnXSSF4MnMugbF/aoZTa
         3YsJZqhgqHfo9QUMAM3t/a97bJxuJpR6Ydhv21elSXlOQOchrml7oldzTU0uD+rc2eG3
         iZM6aVty/u5NBoslr804dgIjRZ037ucCWMnkDyyjIUaL/iHi6T/1sbhWlLLNvzI+dvuv
         wC0oo7DYVQy4/aR1sQDvLahba2fiILGT1m3PIwFD0/NDzdgGp/ZKdRAk3kO+uy2ukF3W
         +BUQ2pf21jPvTWOwRDOt84IfA31MXHoFVdp1eo98Xwcx7eQPlhkRmsE9EzF97V8PT4cw
         0sUg==
X-Gm-Message-State: AOAM531oVce0RHT0nuOQgOw8pExFmNJXmXxHSZIWrvjFmkrO/18YTEZp
        kHKY6n+DuwOlIlWY9Gz0uyEn5Stvjgnz972VUivluI9K
X-Google-Smtp-Source: ABdhPJyPlv1lCfRIZv+lzWZrOFyUK/T5w1fA1TAxk9Ay2wiXN26LibrTiG/KNrbluNRKTNPfDeOgG46EZnEub1sSCHY=
X-Received: by 2002:a17:906:552:: with SMTP id k18mr10300780eja.482.1601195014470;
 Sun, 27 Sep 2020 01:23:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200925070120.GA3669667@coredump.intra.peff.net>
 <20200925070211.GB62741@coredump.intra.peff.net> <CAPig+cTfYmNAP_65RDa_fZOyuQEH65HuLs-UYSPT0yJ=s6BftA@mail.gmail.com>
 <20200927080345.GB1286220@coredump.intra.peff.net> <20200927080846.GD1286220@coredump.intra.peff.net>
In-Reply-To: <20200927080846.GD1286220@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 27 Sep 2020 04:23:23 -0400
Message-ID: <CAPig+cT8LRdp6drcEN6bBFprTUxvDjigXtUXqS-VQmN0Nmg+Nw@mail.gmail.com>
Subject: Re: [PATCH 2/8] shortlog: refactor committer/author grouping
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 27, 2020 at 4:08 AM Jeff King <peff@peff.net> wrote:
> OK, I lied. After reading your other email, I ended up with:
>
>   --group=<type>::
>           Group commits based on `<type>`. If no `--group` option is
>           specified, the default is `author`. `<type>` is one of:
>   +
>    - `author`, commits are grouped by author
>    - `committer`, commits are grouped by committer (the same as `-c`)

Sounds good. Makes it much more clear to me.
