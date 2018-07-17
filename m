Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C97391F597
	for <e@80x24.org>; Tue, 17 Jul 2018 16:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729702AbeGQRNy (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 13:13:54 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:51502 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729668AbeGQRNy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 13:13:54 -0400
Received: by mail-it0-f65.google.com with SMTP id h2-v6so68076itj.1
        for <git@vger.kernel.org>; Tue, 17 Jul 2018 09:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n7m76hOdwjUAJYdVsxTKqUXxMZ+kOd1a40eOT7IAcQQ=;
        b=rsB803C+45C47NAgqaiphzD6oyASnyOXdQmkzcmniyhbp2KN0osAIWUq3ZLyzG97xq
         rlVj2N66yBc2nH1xaKRVPkUDrWRmn8gFdr4epGu6Bk2GR3cbCu9BstT/SbaR4IQS6B0k
         wgjbFQbq2EbghbmNJ7aRSCJV9LG2wd28S+cxxeGzvcUeV0QV3P56/J9YtX9AmXrsIfdn
         sCVeMdorOmdrRX7CEcseRySrg9FWVM4pG2Lxs/DvQeR2sWaiwKgO3rUqyUVkNTDSbXge
         60rZJigooRCSKmrKLWi2jTkh/xpLXifE6T2U1V0TnfVWOR2a8ExbRz7J7o/Ffp2WBU63
         xwyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n7m76hOdwjUAJYdVsxTKqUXxMZ+kOd1a40eOT7IAcQQ=;
        b=Ug/E5frA5vLMLLcX3WmZ6DO/g62/31P3RZBHCg95jQ7LnCP1ktHiJTKuBOH44WPUm9
         KWeAQWC22pVsBj3Sg8sDAmt4QKWPheAPOaNr65d1zMkCs8MwVSt2M8swu8/EGbRlQ4oQ
         g2SmdP3nvJqFsmmLqVw/Bmf450EV6kdya/AKnaLyGRVtgQHKQjS12L/PUgBocASWcOSh
         KeNXdcNNcSaFF0r+LT/LfxhtgenojM4VEXDk6PzkykeSIdmLqVCbkkdHC2KHJP3547hQ
         GBalf75v0cMWEtxtHfy/crA5CGzD4KCbNKWTlO/qyMyTQHX35Jpt/4TdXfckb9EiiadP
         DsVg==
X-Gm-Message-State: AOUpUlGZuAlTaXSUdcydohVLvjbZ8OUpAf9aEEuf3ruyBEp84ls8AwMt
        LZP7KtdFsOgXpadY2/8Fz4A9l1KPyatoNXLa4Ig=
X-Google-Smtp-Source: AAOMgpfjl/32Q36/JD7i/ZYNPq48UC+qjiwTO7iNRxfjnKTDRAOGlT+fKKZm0WAWdTzHYA0vhL4CP6ZVxsbm0Md8jB0=
X-Received: by 2002:a24:b101:: with SMTP id o1-v6mr2156749itf.121.1531845624958;
 Tue, 17 Jul 2018 09:40:24 -0700 (PDT)
MIME-Version: 1.0
References: <pull.9.git.gitgitgadget@gmail.com> <b4e01a963fd16f50d12c1f67c6e64bec8b1e9673.1531513093.git.gitgitgadget@gmail.com>
In-Reply-To: <b4e01a963fd16f50d12c1f67c6e64bec8b1e9673.1531513093.git.gitgitgadget@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 17 Jul 2018 18:39:58 +0200
Message-ID: <CACsJy8Ce0kXTCzLf6jFq1QjY4Q4QePfk1JbgGUr-kQqQDCc7mA@mail.gmail.com>
Subject: Re: [PATCH 2/2] repack -ad: prune the list of shallow commits
To:     gitgitgadget@gmail.com
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 13, 2018 at 10:19 PM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> While it is true that we never add unreachable commits into pack files
> intentionally (as `git repack`'s documentation states), we must not
> forget that a `git fetch --prune` (or even a `git fetch` when a ref was
> force-pushed in the meantime) can make a commit unreachable that was
> reachable before.
>
> Therefore it is not safe to assume that a `git repack -adlf` will keep
> unreachable commits alone (under the assumption that they had not been
> packed in the first place).
>
> This is particularly important to keep in mind when looking at the
> `.git/shallow` file: if any commits listed in that file become
> unreachable, it is not a problem, but if they go missing, it *is* a
> problem. One symptom of this problem is that a deepening fetch may now
> fail with
>
>         fatal: error in object: unshallow <commit-hash>
>

Could you elaborate a bit more? I don't quite see the connection
between the reachability in the first two paragraphs and .git/shallow
in the third one. I'm guessing we drop objects in between because
"they go missing"? Where? How does prune_shallow() in prune.c play any
role in this (if it does)?
-- 
Duy
