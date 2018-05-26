Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CDAA1FD4F
	for <e@80x24.org>; Sat, 26 May 2018 12:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031515AbeEZMIw (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 May 2018 08:08:52 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:32854 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031348AbeEZMIv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 May 2018 08:08:51 -0400
Received: by mail-wr0-f193.google.com with SMTP id a15-v6so13296837wrm.0
        for <git@vger.kernel.org>; Sat, 26 May 2018 05:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=khE3gMRzmS3+7SyXj5lPNaRq7xoL0/2jk6w3oDRsZ8E=;
        b=aJa13TQAHIzJUFCzrZCVIDQ/80VBt0oqnJYv7eumXIKux00eL10T0to8okutRHTUq/
         IYqs+JkRN/Bf6X+yBTcQBYalGN4V8KEfUEH5elAM+8yK/t9U4yYGL/dfnvVT7vNQ6yHb
         zx0pAP4AVfIJSwpZQdvObA9htDvNulejKWPiDVatpefYI8h/DcwX3+pieShlbKJlpHxZ
         bRWclJgXP0MOEfcDweXSubNEr4S1egkE9LnxZGbgHBmr51qY4PhHheAYxnojoqOItQHh
         mjbGZiGCarbDb3cjJvYeCgac7jz+K5Wz51vpl8udhkqw/OtUK/LwmB6BKUAAr+gfVl7x
         EdLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=khE3gMRzmS3+7SyXj5lPNaRq7xoL0/2jk6w3oDRsZ8E=;
        b=sseplai9azpvoeIdoglRejfj5BwiZQkIWH0k5DPkIJXQ0hW+g6N6sZuxizsw39u9bd
         cOtARIcjqjwaskTIN7/CW4NBj4GiafRnbKNy6w2/0oHGMyU3TAIAbFjhVwljMAVsFc1C
         Bt4yY2wNiMXp850TpbR2F1H53P6gqCgJGfFdTf0lrOiZCJn5aNYR1BeSzxOTAsmCaZqr
         aQajguEBOlLwUESMbiUvBHcSFEcXn1sXXFpa5qjBKdyNbZWo8P4WxyOqX3yeWiNScrFO
         ABCXKRgxHFF6myUNsdKK8NqXTAkHBEbkxf2RaynH933iBE0nVQQCZJRBTlhJtXLjZyBY
         bFRQ==
X-Gm-Message-State: ALKqPwcBYzMPTu3tOzrM1lAyALxYeYMcH137yWI2h930L/RWFHcVlPU4
        o/hC78gjrqlOpSux3YY37Bo=
X-Google-Smtp-Source: ADUXVKKGCbKtmShNj2YB6Zw0IRyuz7cLGnf7ojWLdDeF31QVjUob7Uk/UhhNDC/U6JxjPQ889KzRsQ==
X-Received: by 2002:a19:f03:: with SMTP id e3-v6mr3307502lfi.145.1527336530371;
        Sat, 26 May 2018 05:08:50 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id r81-v6sm4789574lja.36.2018.05.26.05.08.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 May 2018 05:08:49 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 0/4] Fix i-t-a entries in git-diff and git-apply
Date:   Sat, 26 May 2018 14:08:42 +0200
Message-Id: <20180526120846.23663-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180513175438.32152-1-pclouds@gmail.com>
References: <20180513175438.32152-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2 first fixes a bug in --ita-invisible-in-index that accidentally
affects diffing a worktree and a tree. This caused a regression when
v1's 1/2 turned this option on by default.

Other than that, 4/4 should address Junio's comments on v1's 2/2.

Nguyễn Thái Ngọc Duy (4):
  diff: ignore --ita-[in]visible-in-index when diffing worktree-to-tree
  diff: turn --ita-invisible-in-index on by default
  t2203: add a test about "diff HEAD" case
  apply: add --intent-to-add

 Documentation/git-apply.txt | 10 +++++-
 apply.c                     | 19 +++++++----
 apply.h                     |  1 +
 builtin/diff.c              |  7 ++++
 diff-lib.c                  |  8 +++--
 t/t2203-add-intent.sh       | 64 +++++++++++++++++++++++++++++++++----
 t/t4011-diff-symlink.sh     | 10 +++---
 7 files changed, 99 insertions(+), 20 deletions(-)

-- 
2.17.0.705.g3525833791

