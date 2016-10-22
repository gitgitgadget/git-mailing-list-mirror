Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0554120986
	for <e@80x24.org>; Sat, 22 Oct 2016 23:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965089AbcJVXdb (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Oct 2016 19:33:31 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:38191 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964952AbcJVXdW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2016 19:33:22 -0400
Received: by mail-it0-f53.google.com with SMTP id 66so74098074itl.1
        for <git@vger.kernel.org>; Sat, 22 Oct 2016 16:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2qguvQNHoNKZL5tobJUwn3gWntp9sFGhKNsKC4V+fdA=;
        b=ouAPOUVpDjcYpEQ2BX74O104tk5N0I/BZfbmsiPWSv1vGmYBfxAmvgOvUiyFnsLMPS
         GO3otFMnh0WTvtpOUZu96Bmk8iHBNn5swyE5OjhjlCiLDJnR5MDddVoT/rqsgHwMZ6iK
         vc4Q3mdKFwUt374EB3h70BuRXJ7hW4d4PTh31+msYEid0FPEVRUCKarpoJyhKifdv9DK
         b4uz2KzE7nfjvnZWCZy6+/jlanOD5Txbs67WMv6RZ5IVC7zEsexG8i43bRA//eTfQjZH
         qGDCym0IBYdw2cPfJt+L6sXqQhKzSxq1ZxPjRWqfUxDE3uP9ffhzztMhzLy4vZixi13J
         Avdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2qguvQNHoNKZL5tobJUwn3gWntp9sFGhKNsKC4V+fdA=;
        b=bDNsC4x/XR/RJ/elwJ5TclEOCn8xWQtElOT9onAYbVne80fUL1jsFMQpvwO1Z7L+Du
         v4IyFKqBczeAzQ+An8BJOBKPCMTVCCbTsoUBKByvK0f0PA9pj+MkDXodwn3uJS+djrwc
         6pLznrQYVRNpniBvPF8gwYeN3MmO+IiSp3JheEM5LYpGjX4qlQx3q760CjVROyvTXwJ9
         ySNMRAnMXgVmX3QUMvj8QwbquZ4CL3jp+JFG4uDaJXjaCNfta0R4I+FqXS3BZfo/0x6P
         6Alyy70CaQS+p6zjBQmKsTYQvFD+Px0wFkd8UMsXGA/L4phGo3QBQnqcvbGeAQ0XS4ar
         Hhdw==
X-Gm-Message-State: ABUngvf68VGHT3PehOpSddlVyqtXD6l+1/Ao1gOFeq9zfJ/U7Suv4jqx5kPVI8fjB2O6uPNB
X-Received: by 10.36.228.1 with SMTP id o1mr4235702ith.97.1477179201941;
        Sat, 22 Oct 2016 16:33:21 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:4ca0:b1d9:cc22:1c7b])
        by smtp.gmail.com with ESMTPSA id f96sm4570843ioj.15.2016.10.22.16.33.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 22 Oct 2016 16:33:21 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 26/36] attr: make git_check_attr_counted static
Date:   Sat, 22 Oct 2016 16:32:15 -0700
Message-Id: <20161022233225.8883-27-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.508.g6572022
In-Reply-To: <20161022233225.8883-1-sbeller@google.com>
References: <20161022233225.8883-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's not used outside the attr code, so let's keep it private.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 attr.c | 4 ++--
 attr.h | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/attr.c b/attr.c
index 0f08ee6..881bdfa 100644
--- a/attr.c
+++ b/attr.c
@@ -892,8 +892,8 @@ void git_attr_set_direction(enum git_attr_direction new, struct index_state *ist
 	use_index = istate;
 }
 
-int git_check_attr_counted(const char *path, int pathlen,
-			   struct git_attr_check *check)
+static int git_check_attr_counted(const char *path, int pathlen,
+				  struct git_attr_check *check)
 {
 	check->finalized = 1;
 	return git_check_attrs(path, pathlen, check);
diff --git a/attr.h b/attr.h
index 40abc16..06ac93b 100644
--- a/attr.h
+++ b/attr.h
@@ -44,7 +44,6 @@ struct git_attr_check {
 
 extern struct git_attr_check *git_attr_check_initl(const char *, ...);
 extern int git_check_attr(const char *path, struct git_attr_check *);
-extern int git_check_attr_counted(const char *, int, struct git_attr_check *);
 
 extern struct git_attr_check *git_attr_check_alloc(void);
 extern struct git_attr_check_elem *git_attr_check_append(struct git_attr_check *, const struct git_attr *);
-- 
2.10.1.508.g6572022

