Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 166EA1F463
	for <e@80x24.org>; Tue, 10 Sep 2019 06:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403869AbfIJGjh (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Sep 2019 02:39:37 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:36054 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728269AbfIJGjg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Sep 2019 02:39:36 -0400
Received: by mail-wr1-f44.google.com with SMTP id y19so17649302wrd.3
        for <git@vger.kernel.org>; Mon, 09 Sep 2019 23:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=wfoFzx1a51tedysaOJOS8L9vZEmEuBJGqUNovpXxJkw=;
        b=jbQ5PP/BM7qhEfrz3c3uEjB7SeqhGCZ8r+wLYxDzKglQV/Mn03zpSTvD2exTWD/3hS
         Ivjl6s1802jdTz9+W6fpmOxu/RLPuMoURXt7WAJ20NFLtfmDJD5GJ/x8ntiSNvRjbOGP
         aP4tAbNOspi9P0TC1ocbnF7q8eioJaBijZ/B4XsBlqgSXdnfGoFs5NeF3eM1z/yDA6T/
         wjzepFjcgiZ4lV0KfFuvlQ0wrnF0j+6su1nmaoFzZXr5nUmegn2xS3tnbE957aQYF82b
         BThJ/EM9IedeGjakTCw+zN+j+IJYpE85CZzum7T/KTWLkp6aPmIjfrd5V5VDQJno2OzF
         RpPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wfoFzx1a51tedysaOJOS8L9vZEmEuBJGqUNovpXxJkw=;
        b=nrKxxruUY2qIO3LkC/V3S4iMTxzaKjYThn+EcFOtcKl/t2UhJ3JmR9i/OllW9YUuV7
         Evp2O+uwLwKAJcO3VwmRpyhkFA+KpJPgHi6uVe6CCK45uIkA15Z/wDhN1lG6Nct0/2AO
         53p6e+/dqox14Viaed8L399W7+94EKMaQWywNUjsYEj7PLlvn3nqVgYa+5/Sdlgg39D4
         O+I41dHKQMvdNZOwzHknfnnUl7vUTU11YJxGXfeKdHo/Fy1166JRkRlTo8ty4U1nreqy
         vQM8QYUfI2oh3xBUOjzpPt1bSOexE4gEajL6K8ief94ojiykvEtPGJtRMB7DKe6ltI+H
         fMEQ==
X-Gm-Message-State: APjAAAWx0GnRHgLkbOrUukigaiCPBO0C74UlK/rUlMKeG8VX2fRlznNk
        pvryJ5IUyQY7EAM5OtUrj8iFbg3u
X-Google-Smtp-Source: APXvYqxKeQrTUoXOlOY2UNyU1KQtn+ULGpcxG+0jytnWMnGpV2ir9do+tfcNZMsGYtipoS4l7lFtrg==
X-Received: by 2002:a05:6000:1187:: with SMTP id g7mr23847217wrx.192.1568097574786;
        Mon, 09 Sep 2019 23:39:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g24sm26050645wrb.35.2019.09.09.23.39.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Sep 2019 23:39:34 -0700 (PDT)
Date:   Mon, 09 Sep 2019 23:39:34 -0700 (PDT)
X-Google-Original-Date: Tue, 10 Sep 2019 06:39:32 GMT
Message-Id: <pull.335.git.gitgitgadget@gmail.com>
From:   "Dominic Winkler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Fix perl error "unescaped left brace in regex" for paranoid update hook
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A literal "{" should now be escaped in a pattern starting from perl versions
>= v5.26. In perl v5.22, using a literal { in a regular expression was
deprecated, and will emit a warning if it isn't escaped: {. In v5.26, this
won't just warn, it'll cause a syntax error.

(see https://metacpan.org/pod/release/RJBS/perl-5.22.0/pod/perldelta.pod)

Signed-off-by: Dominic Winkler d.winkler@flexarts.at [d.winkler@flexarts.at]

Dominic Winkler (1):
  Fix perl error "unescaped left brace in regex" for paranoid update
    hook

 contrib/hooks/update-paranoid | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)


base-commit: 5fa0f5238b0cd46cfe7f6fa76c3f526ea98148d9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-335%2Fflexarts%2Fmaint-update-paranoid-perlv5.26-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-335/flexarts/maint-update-paranoid-perlv5.26-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/335
-- 
gitgitgadget
