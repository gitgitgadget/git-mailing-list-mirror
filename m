Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 259C81F453
	for <e@80x24.org>; Tue, 30 Oct 2018 18:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbeJaDVK (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 23:21:10 -0400
Received: from mail-pl1-f181.google.com ([209.85.214.181]:32965 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbeJaDVK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 23:21:10 -0400
Received: by mail-pl1-f181.google.com with SMTP id x6-v6so5975424pln.0
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 11:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=1n4AIjvaxvMl31JqLxh4rJDMSPPO8O4WEzFJeRWOs6Y=;
        b=VkSnXVHKpT/ZiwAM5VdFAnchDaFhmCu5/fuqoL2GDq4/iCHHiBQTp1B+FHNbbrpX7o
         2Iq+XH3l6hR8olrHfxTUNrI0wNaIPV3pkjUse/NHbeKQrUiKaw1i64txa61SD+IFTtWJ
         Ebu6Y5Zlg1N+vibKQnqy4DrD4/EGvvuirGXuNWx5Wkm9whIsDagKAtpcL/RU5foxOKhH
         JQd7O/1JfF0dd4Dvjza7b6Uq205002AQ7c0qCaGGP7wo/nUZS88l6f7AQn3PGvo6EbuM
         uHoWeovZ7/CZ5zxUzhl/yPvhBtJ5jLcz93zsB7SIqUL7hIvYJ/J5bnMdsftl2+3qZA8h
         f35w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1n4AIjvaxvMl31JqLxh4rJDMSPPO8O4WEzFJeRWOs6Y=;
        b=dBOiU2Dryxb1xLlvZbaLoF0cm4zYhQR7adDttHEMC2Xic8xkgmrYJLDv6gTR6SLsyT
         O/D4jt7Baab+kRTQcBNpFxdswSXlhEel1dJwElqX3pq5+aES3cL9BAhwVM90EciOVert
         /kyXg7D/r4q20hFJtnDNSnx1yBSq6wQWQYasCzgDkGa+dNkXt3VLeeU8dcQwnJ5WgD75
         sqGnoYcBvkustYE6PagHXUPktyrr5Jd+RqzVi/tCfTKqNpmJoVidgs96XLmuvgtYN+yX
         bLXzrA+8vDi8PGkGyAjyW1vZesaVBaw+sJsGtdGVr9z49fF9J+nUlkH999BEqXhWkgYx
         0Jvg==
X-Gm-Message-State: AGRZ1gJI1cRGjBIumN7rw+DSx1LgMy5krRCF5wHDyWYHteHvAfErKjDc
        lCLAnKVBNFdylXK6FN/AEbtOBjZc
X-Google-Smtp-Source: AJdET5ci22QIAH2RjW8N1dFwX1UsF06z3/QhJDTJ0UzmS7oV6N2JGNdLJ9chK0uRitCG7eQr+RkWiQ==
X-Received: by 2002:a17:902:3103:: with SMTP id w3-v6mr4238666plb.51.1540923995883;
        Tue, 30 Oct 2018 11:26:35 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id 86-v6sm16759597pft.184.2018.10.30.11.26.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 11:26:34 -0700 (PDT)
Date:   Tue, 30 Oct 2018 11:26:34 -0700 (PDT)
X-Google-Original-Date: Tue, 30 Oct 2018 18:26:32 GMT
Message-Id: <pull.59.git.gitgitgadget@gmail.com>
From:   "Chris. Webster via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] DiffHighlight.pm: Use correct /dev/null for UNIX and Windows
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

Use File::Spec->devnull() for output redirection to avoid messages when
Windows version of Perl is first in path. The message 'The system cannot
find the path specified.' is displayed each time git is run to get colors.

chris (1):
  Use correct /dev/null for UNIX and Windows

 contrib/diff-highlight/DiffHighlight.pm | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)


base-commit: c670b1f876521c9f7cd40184bf7ed05aad843433
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-59%2Fwebstech%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-59/webstech/master-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/59
-- 
gitgitgadget
