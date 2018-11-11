Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0FA41F87F
	for <e@80x24.org>; Sun, 11 Nov 2018 06:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbeKKQK7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Nov 2018 11:10:59 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:47031 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbeKKQK6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Nov 2018 11:10:58 -0500
Received: by mail-ot1-f66.google.com with SMTP id w25so4533531otm.13
        for <git@vger.kernel.org>; Sat, 10 Nov 2018 22:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dle/TW6DhgtBpPyGtMvUvHpq4r6OeTZX9pV+XBu/SUc=;
        b=Z0y3VDo5PJQ+7Wc7+IlHAlHxbpKfBa8QuZS/nruHpGIioxYceoYoyQfXnvtyh0m2/U
         FacW/I6bZA5b4lGQkXIErkrwI/609JfoSVPNjRfYu7BbBIBb8pedZ60UtmHFljt1gRpQ
         Ex29LLKFDkZjZL7BYdFFwNeTCI88t9+id95Vx8tcXZHN9a27yFZLy/6L1Rh0xEXdR36X
         csNgIYaNrffq5rqSM7Tgdp0wgi9MJOpVR5RleTzx0DIGDfBj5EsRPZDi2T77n3IJYNqW
         Y+/wDRQvS9VhoPMtjzs3MC2rblI62tEu8xtnAF+3kZcKRkrxAhpWqum/MkXM3S8+Jr/O
         lhkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dle/TW6DhgtBpPyGtMvUvHpq4r6OeTZX9pV+XBu/SUc=;
        b=Q+2ucOJI3lunY64Nhv75MhosQn9wjlvhFRuG8R+5v7F6/ywVfFsyUeZ1BCiOh//MkU
         PWNI+FUJ2DKD5/wasCCxZKCL2Hnqjkro8PJgM8siY4tYxgjQAh19KF6ffBd3VVnF+/EA
         8n2+/HqpdTPB7p0WUV/HKw1ynkmh0C/1b+LdysGT4R4wWmY4U0QXcPWly9lF4oB2e0fR
         7jn2NOdFCvdXl/1lokUxofr0irlojS7pavgjuj+lsr1L7E9wu86NSxXjDeq3ChZ5DE2G
         HZjKidoV2WnIqK7V41YXe97deNUj1hrYUjJvvN9LxuNznZi97Y+27ZwTaBNgqxiQoYDD
         fGXQ==
X-Gm-Message-State: AGRZ1gI1eVLqcuzqPVB8xieq1iMvAvYN/H9fERrfpML3suI4tV0XXxg3
        s0xZumI6NQlOOX+16hxenaDkgi8b
X-Google-Smtp-Source: AJdET5fHxwvyOo3YXuF2fZ4ODu8AiVzBPdiCndHOlCi0uO55Yb9jbG6cwBGttOhNABsfm5R8L/W1iQ==
X-Received: by 2002:a9d:738a:: with SMTP id j10mr9494838otk.188.1541917400060;
        Sat, 10 Nov 2018 22:23:20 -0800 (PST)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id f34sm1286855otb.25.2018.11.10.22.23.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 10 Nov 2018 22:23:19 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     larsxschneider@gmail.com, sandals@crustytoothpaste.net,
        peff@peff.net, me@ttaylorr.com, jrnieder@gmail.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH 01/10] git-fast-import.txt: fix documentation for --quiet option
Date:   Sat, 10 Nov 2018 22:23:03 -0800
Message-Id: <20181111062312.16342-2-newren@gmail.com>
X-Mailer: git-send-email 2.19.1.866.g82735bcbde
In-Reply-To: <20181111062312.16342-1-newren@gmail.com>
References: <CABPp-BEefqYADr8SVvh6uFWkp96PDv7qfKK1c9O1WUnPy3wqrw@mail.gmail.com>
 <20181111062312.16342-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-fast-import.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index e81117d27f..7ab97745a6 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -40,9 +40,10 @@ OPTIONS
 	not contain the old commit).
 
 --quiet::
-	Disable all non-fatal output, making fast-import silent when it
-	is successful.  This option disables the output shown by
-	--stats.
+	Disable the output shown by --stats, making fast-import usually
+	be silent when it is successful.  However, if the import stream
+	has directives intended to show user output (e.g. `progress`
+	directives), the corresponding messages will still be shown.
 
 --stats::
 	Display some basic statistics about the objects fast-import has
-- 
2.19.1.866.g82735bcbde

