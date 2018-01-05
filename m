Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43A0B1F428
	for <e@80x24.org>; Fri,  5 Jan 2018 20:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751937AbeAEUDM (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 15:03:12 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:45931 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751814AbeAEUDK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 15:03:10 -0500
Received: by mail-pl0-f67.google.com with SMTP id o2so3629343plk.12
        for <git@vger.kernel.org>; Fri, 05 Jan 2018 12:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4GjaLG+HTK1TUJ2qWkEEpX5y1aqzL7JhF4f9qefb+5g=;
        b=aIhdfiUBqnoTkvoJuDDet6iYyhjQhSRsxpVh5GEv453MeXZZOKe5oNjPyxLDb9SG3Z
         f1qRZ9yQBjwbjU+qKGwjnTpSbntw0ajlHjNuHHRNLxpDx2oNeopOnpL4mXm9ZVXfgVNi
         5dnCq1CED0aQVFFhWj0f+xI+yXFGIQTgFMd3rxoe9wdONXYKBGLe4xCu/p2DMUfWqbtI
         6XEHIpkPR+gqkKR+etsFTUQJyXG7rd7xpRJFfd1TD1eflbBCtSmPpew94mxcCi25JghB
         QUSZ7Zz3lO8qY9WRa85xURGQ3eXslGKq9ToSx9pSjKjUP67pz6ewe4izYfKtwIruZg70
         qBJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4GjaLG+HTK1TUJ2qWkEEpX5y1aqzL7JhF4f9qefb+5g=;
        b=dhuiPyGywCnfcY6yQF4/V0JC+Ca9djy5SKt1Ov0wHO1LEyOu6gugHSyf8KnGffAJ+5
         QGxeKrUymR3rN+X4hWRsZVpQHBQv/BGg+KmPEvEL0JE4uaQV/ShRSuJyUm6bSOEzjC2c
         A8xqYFxTTvhQwmmvJy3BliiIg8OxWyql2NL4W8T6xcrUNvE1kDb3+LUAfiuRTPe7gWlt
         zEDiUMKWLyxbVX5Nw/Y86W1Q8CXQXGD1lV+RSZcjf0O5ckA/04rOh8HE1bfdsurgagxP
         4RFiLghNnjKTsCCJeWG/6HTTLo7IEmikmovkhFjWmVevjsm/aQJecL9U6IYVY27Z0cvI
         135w==
X-Gm-Message-State: AKGB3mL0JkYJm7GaIh9ZP3ofM8v8GyL0fk/V8LfzzYSw7ElN0vBKBwof
        UZN5U3TGBrUOUJFuT5W4qeX1SiQCxsM=
X-Google-Smtp-Source: ACJfBot7nNjb+LPBKU5WtsX5CKab3Ld2Mm7nKP++Sdzx71BmwEQ+A6hJhPyzzpLciBoKVrBKmU+YQg==
X-Received: by 10.84.215.142 with SMTP id l14mr4187094pli.441.1515182590106;
        Fri, 05 Jan 2018 12:03:10 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id j2sm12735209pgn.47.2018.01.05.12.03.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Jan 2018 12:03:09 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 1/4] t/lib-submodule-update.sh: clarify test
Date:   Fri,  5 Jan 2018 12:03:01 -0800
Message-Id: <20180105200304.34173-2-sbeller@google.com>
X-Mailer: git-send-email 2.16.0.rc0.223.g4a4ac83678-goog
In-Reply-To: <20180105200304.34173-1-sbeller@google.com>
References: <xmqqo9mahdll.fsf@gitster.mtv.corp.google.com>
 <20180105200304.34173-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Keep the local branch name as the upstream branch name to avoid confusion.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/lib-submodule-update.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 38dadd2c29..d7699046f6 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -664,8 +664,8 @@ test_submodule_recursing_with_args_common() {
 			cd submodule_update &&
 			git -C sub1 checkout -b keep_branch &&
 			git -C sub1 rev-parse HEAD >expect &&
-			git branch -t check-keep origin/modify_sub1 &&
-			$command check-keep &&
+			git branch -t modify_sub1 origin/modify_sub1 &&
+			$command modify_sub1 &&
 			test_superproject_content origin/modify_sub1 &&
 			test_submodule_content sub1 origin/modify_sub1 &&
 			git -C sub1 rev-parse keep_branch >actual &&
-- 
2.16.0.rc0.223.g4a4ac83678-goog

