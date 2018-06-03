Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9CBC1F403
	for <e@80x24.org>; Sun,  3 Jun 2018 14:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751315AbeFCO3Y (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 10:29:24 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51225 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751228AbeFCO3X (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 10:29:23 -0400
Received: by mail-wm0-f68.google.com with SMTP id r15-v6so10808553wmc.1
        for <git@vger.kernel.org>; Sun, 03 Jun 2018 07:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/rNxL4Pil4tzfixyczGOUpC9q2qHIq+vVD+3+BzTEo8=;
        b=kpZ/O9HZYte4zLLBEyFt9MEvo26JxLxsSo5s2Oo5YFPvMfATr0JZzMlBryh7oPEuDR
         UoTT+cfL/WLWEx7zAuawrkLzUfyrBwcdxvwsvi8mah6PkNMJ07Xz4Bv3slXzbIsrBehf
         nq8z64LSfw7W8G+XcpaFaj6H7RKY0gMf/dv5nSW5QiSuYPC94ZRXHDb91rqtt27foM51
         rXdfLTUNWjJeEh97mLcJX7i2u4yy9KkNT+gQ0R2f31x/HWhlTIQvG74iFpTAIGQEHPqJ
         MlG3lnYIOSWLllgYc45pLrJ5jWjOfdtW+2PFT06sG43bc9UjYgwqjy4bGZrq+7BvJZ/I
         92QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/rNxL4Pil4tzfixyczGOUpC9q2qHIq+vVD+3+BzTEo8=;
        b=eajLPUb26DBQBSXEoZpl4R6nrAKDyFzUp9JZ1RsLL2pr7T4EeNUMkGHfxULoBW25HQ
         QhMd9C8Vkda3ifYYPf/WdlXZCCVg2pSVVLFvYLO81xtFt/KThtjFOCLljDTe0GF8tsno
         oDkF9pII0tYNUYeOYsghcIcgn+uReKmNgi+Rx66udEC8rOUjxIQrNnhSx9TnrqjsWQsz
         N/XCtidrMkLFEkqxss8DV92bMYlmiZpAWCAYhUFoETVP+9imaDgqLJKau4HyaLG35QWt
         AGoLk1aR9M8/TPEwP1Z70zf+Gp60Tx9iqH86VYPmXxKfmy6Fpm5DYwc3CopjiKZffbkh
         KkAg==
X-Gm-Message-State: ALKqPwfsCHNDOMiKKqTdNIV+54n6qCRw9s9aKl3KNu3GgvHGxh8xKruD
        YNfqTxDUF/jp5WdAFjHTAhs=
X-Google-Smtp-Source: ADUXVKKbz+AeaejqtvNjjbCcrG2ytLe8O/olAWjW5nP5+nb8iqErgO+vchuGAH4quOEnB1hdtbCDfQ==
X-Received: by 2002:a1c:f415:: with SMTP id z21-v6mr6598479wma.80.1528036162039;
        Sun, 03 Jun 2018 07:29:22 -0700 (PDT)
Received: from localhost.localdomain (x590e56c9.dyn.telefonica.de. [89.14.86.201])
        by smtp.gmail.com with ESMTPSA id r11-v6sm3237132wrn.34.2018.06.03.07.29.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 03 Jun 2018 07:29:21 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] sha1-file.c: Correct $GITDIR to $GIT_DIR
Date:   Sun,  3 Jun 2018 16:29:10 +0200
Message-Id: <20180603142910.6211-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.207.ga6211da864
In-Reply-To: <alpine.LFD.2.21.1806030820180.14575@localhost.localdomain>
References: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Could you please add "in a comment" to the end of the subject line?
So it will be immediately clear to future readers of 'git log
--oneline' that this is not a bugfix.

> Fix single misspelling of $GITDIR to correct $GIT_DIR.
> 
> Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
> 
> ---
> 
> only occurrence in entire code base that i ran across, so i figured
> might as well fix it.
> 
> diff --git a/sha1-file.c b/sha1-file.c
> index 555e780f4..695e5c627 100644
> --- a/sha1-file.c
> +++ b/sha1-file.c
> @@ -610,7 +610,7 @@ void add_to_alternates_memory(const char *reference)
>  /*
>   * Compute the exact path an alternate is at and returns it. In case of
>   * error NULL is returned and the human readable error is added to `err`
> - * `path` may be relative and should point to $GITDIR.
> + * `path` may be relative and should point to $GIT_DIR.
>   * `err` must not be null.
>   */
>  char *compute_alternate_path(const char *path, struct strbuf *err)
