Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E9ED20357
	for <e@80x24.org>; Mon, 10 Jul 2017 21:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754696AbdGJV4V (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 17:56:21 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34097 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754550AbdGJV4U (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 17:56:20 -0400
Received: by mail-lf0-f68.google.com with SMTP id g21so12303024lfk.1
        for <git@vger.kernel.org>; Mon, 10 Jul 2017 14:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jJ5leaKB7cs8a8XxH0WcUojL9HqnuMKdVmdun++NPlk=;
        b=u0TZxnwnjc/fX7oTHdmIX9+FrlbzydCRWm651xYTfDJSsDZ9i9boR7MoZUNrD00gI1
         fBRQgQZ7xzdlaCLopgge4LStA+pDAXqLgHkcKOq11AftfhcDINI3JPTko7q+R/JJOiKC
         ZB/t8M6YaEBGod/zKEds/JiV5R9MXGJ9mD12SE4kP2JnxeLZnSSceANtJlsBpj+RIjP/
         Vu499ea+xQ/ABMW7Z0+KwzB6KFMMDZrUTn0Y0AwxFOVw7yhYEaFyIS9t7/+ys37CItW5
         Ap5Vu1f4V5ZSw6r5shEy8FfLHWQTq6kE+5fZXRg+Y9BYYFF3c8AmOtvAVd9XLwV7QG3Q
         CR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jJ5leaKB7cs8a8XxH0WcUojL9HqnuMKdVmdun++NPlk=;
        b=JoeGJaQtT4sqPAchVRJSeCdGa5bDsMttgo7VB7KBKyQAVLKQDgGiCJe0chDl/X5LoQ
         ra71XmiiCcauSa0FFvYVtngWAkhd1GkM1xHQWXxSTI6zTRVq9WJXc7izCKjA5j3wNUu+
         8hz9rd9XqoFu+FoSJZpm/2TYM3H7l0njJpBAX6T+EAHQdlVnhGZCu5KQOOq8bqDfGzsM
         5/tOMVvMK4Qy1h/IReeyYPwRyPWSzVy/HHr9oIa6KkGj+RHzfxFiqqCSh3bVzNmv09IE
         EpnHtwjztHZ17Qf1439HzWEp0S5pJVEqwd8M+42NY2oGWRNePvP5n9aZ4vMkMjn8QQGe
         xmKA==
X-Gm-Message-State: AIVw110hKvLuKsUYGyUN9MrT6Lg7sS19a8O0Ls5anoCMdOoMBt3uTap4
        iXcyYTuvMDk12xKq9hE=
X-Received: by 10.25.32.21 with SMTP id g21mr2163087lfg.183.1499723778846;
        Mon, 10 Jul 2017 14:56:18 -0700 (PDT)
Received: from localhost.localdomain (78-66-223-92-no2204.tbcn.telia.com. [78.66.223.92])
        by smtp.gmail.com with ESMTPSA id x13sm2617077ljd.64.2017.07.10.14.56.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Jul 2017 14:56:18 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Brandon Williams <bmwill@google.com>
Subject: [PATCH 1/7] api-builtin.txt: document SUPPORT_SUPER_PREFIX
Date:   Mon, 10 Jul 2017 23:55:14 +0200
Message-Id: <1b08c5f568028645325367d6d6b97b9da17894ff.1499723297.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.13.2.653.gfb5159d
In-Reply-To: <cover.1499723297.git.martin.agren@gmail.com>
References: <cover.1499723297.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 74866d75 ("git: make super-prefix option", 2016-10-07) introduced
SUPPORT_SUPER_PREFIX as a builtin flag without documenting it in
api-builtin.txt. The next patch will add another flag, so document
SUPPORT_SUPER_PREFIX, thereby bringing the documentation up to date with
the available flags.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/technical/api-builtin.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/technical/api-builtin.txt b/Documentation/technical/api-builtin.txt
index 22a39b929..60f442822 100644
--- a/Documentation/technical/api-builtin.txt
+++ b/Documentation/technical/api-builtin.txt
@@ -42,6 +42,10 @@ where options is the bitwise-or of:
 	on bare repositories.
 	This only makes sense when `RUN_SETUP` is also set.
 
+`SUPPORT_SUPER_PREFIX`::
+
+	The builtin supports --super-prefix.
+
 . Add `builtin/foo.o` to `BUILTIN_OBJS` in `Makefile`.
 
 Additionally, if `foo` is a new command, there are 3 more things to do:
-- 
2.13.2.653.gfb5159d

