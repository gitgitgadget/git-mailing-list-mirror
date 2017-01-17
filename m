Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEABB20756
	for <e@80x24.org>; Wed, 18 Jan 2017 00:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751129AbdARAa6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 19:30:58 -0500
Received: from mail-pg0-f52.google.com ([74.125.83.52]:36204 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751051AbdARAa5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 19:30:57 -0500
Received: by mail-pg0-f52.google.com with SMTP id t6so23379341pgt.3
        for <git@vger.kernel.org>; Tue, 17 Jan 2017 16:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J9J0KcKBzjOHfU4HvjU62D0wzvHCmOc65l3vRMUOOd8=;
        b=ezq3NTn/XVH86thfZsG71hNEaVCv2HXP/2LM1Is7WpgJP4rOAgmCsgztvt13TY6NF7
         58TKnMlpDrex0Sql6uinJZ0yrUz4YyfpbarEoaJwccAqROElQwf1+gj+YRX9WVqoHxGs
         5IY3/xxIJzPIDlsfBY5+IuoaX1ebwOplWya4MRMGFif68BWkvlXVUthZPyklvuezOKyP
         k3mStXBQmCfrVfKHS0ODEgZF9Ef41Dmz9FOvRe/l6KTPxraAd4T5tL4EiTARC9TtnY82
         /7KI7YWh5RXKB10gPFmuMOQ4/GbpIJhhb7H6/D3bfJ3HWq1Bid3PNZOQgX0RXhM5yA7p
         157w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J9J0KcKBzjOHfU4HvjU62D0wzvHCmOc65l3vRMUOOd8=;
        b=X634PzR/0zEqHddVeEolc1Fmx585OX9lqTWxRacQqnueqszwklQKwcCRc8diO3kh1O
         aHcdea0mAC4P52gyKzF5UDpM+vzUeFg9lHM4Ep8ztCx3mlhaqPEc8YlJaHoIqM34JE5y
         oXWcBsvq3ZsNx1xosyoTz+17utX/gsOUmWC+bhtddip544k0mHzc9lAWLj31KPMPs+5o
         4Qb/Cp5+tTbfYaAJVFiqqNWkfY0cy6BQj2IREiPSlB64W2b/RdPi1op0bpKstc0zT2vK
         M4iOkAFW7/geTyLiHC+zKj3eEJxSVXbDozYbHqcpzrgohAic7NLb8bMi9aTElS4uBUA+
         JAPA==
X-Gm-Message-State: AIkVDXJi0WWEByhPagj4cyq68BY7zfNmJW8yNyM6xF3AIhVEo3SKpAX53uyZc0QUo5hsfnhn
X-Received: by 10.98.49.198 with SMTP id x189mr308244pfx.20.1484696110526;
        Tue, 17 Jan 2017 15:35:10 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:871:ca27:8566:e7e])
        by smtp.gmail.com with ESMTPSA id 89sm58215518pfi.70.2017.01.17.15.35.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 17 Jan 2017 15:35:10 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 4/4] documentation: retire unfinished documentation
Date:   Tue, 17 Jan 2017 15:35:03 -0800
Message-Id: <20170117233503.27137-5-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.299.g762782ba8a
In-Reply-To: <20170117233503.27137-1-sbeller@google.com>
References: <20170117233503.27137-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When looking for documentation for a specific function, you may be tempted
to run

  git -C Documentation grep index_name_pos

only to find the file technical/api-in-core-index.txt, which doesn't
help for understanding the given function. It would be better to not find
these functions in the documentation, such that people directly dive into
the code instead.

In the previous patches we have documented
* index_name_pos()
* remove_index_entry_at()
* add_[file_]to_index()
in cache.h

We already have documentation for:
* add_index_entry()
* read_index()

Which leaves us with a TODO for:
* cache -> the_index macros
* refresh_index()
* discard_index()
* ie_match_stat() and ie_modified(); how they are different and when to
  use which.
* write_index() that was renamed to write_locked_index
* cache_tree_invalidate_path()
* cache_tree_update()

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/technical/api-in-core-index.txt | 21 ---------------------
 1 file changed, 21 deletions(-)
 delete mode 100644 Documentation/technical/api-in-core-index.txt

diff --git a/Documentation/technical/api-in-core-index.txt b/Documentation/technical/api-in-core-index.txt
deleted file mode 100644
index adbdbf5d75..0000000000
--- a/Documentation/technical/api-in-core-index.txt
+++ /dev/null
@@ -1,21 +0,0 @@
-in-core index API
-=================
-
-Talk about <read-cache.c> and <cache-tree.c>, things like:
-
-* cache -> the_index macros
-* read_index()
-* write_index()
-* ie_match_stat() and ie_modified(); how they are different and when to
-  use which.
-* index_name_pos()
-* remove_index_entry_at()
-* remove_file_from_index()
-* add_file_to_index()
-* add_index_entry()
-* refresh_index()
-* discard_index()
-* cache_tree_invalidate_path()
-* cache_tree_update()
-
-(JC, Linus)
-- 
2.11.0.299.g762782ba8a

