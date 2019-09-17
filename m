Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F6F71F463
	for <e@80x24.org>; Tue, 17 Sep 2019 16:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730545AbfIQQfa (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Sep 2019 12:35:30 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:32858 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfIQQf3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Sep 2019 12:35:29 -0400
Received: by mail-pl1-f193.google.com with SMTP id t11so1779541plo.0
        for <git@vger.kernel.org>; Tue, 17 Sep 2019 09:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e5M0BrMwX+MMcMx4dd9+eEsV4oPx5UvSOkSmcQK7tQo=;
        b=BkCX9kZ8nnilaHPCdQKThpa3uonzf0TmxIsR/eiEU57oQ1dFnsNpFwXno9tfsbhXzB
         sWqd+CKkmL7V6ydN9zK6I95yOC75+3qARgaThyg/jL/oQmx1iqYBftVgDq5pF8b02hF3
         p7ZXGXLdKDIUp0lQuFtKZVwcbxNeP1CbozXq4Y6UDZGgKGE3oqtsv+AVtlFaiPmRMtoD
         Sn5uo1m4zZb9r8Z69CM09MTxYGG3Odl6wCYVKmXl7n1eO7fNcrqWnCsRjzlGO0DuI5YP
         NEIK7zj9AUWgnigVIIEBwRzJiQi7kCjMT34RFlKlKjpmXdjWQHxK038PGd89WyceuKil
         YP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e5M0BrMwX+MMcMx4dd9+eEsV4oPx5UvSOkSmcQK7tQo=;
        b=sL8Y4tqCtcOpiR3i7kgYTdOPL+YdWb/SoYHCcsBcAfsiuMgMxQhz0jymVtYSTUUx10
         GjRH0OcuGyHin/Fk+VImdtbLFPciIBG2ow77II/6WkLTywu5JHZsq2Y1l3a2P7A4ct+/
         Yp8jZ2eIAzM5W4NDoln81C+HtxN9p5BxehYkM4VEmz0zT1Pgt889msabVv6dYlUmTgVK
         h37fhPHMBjCBjXwV6Pa7t+gufEPG7iOttNO2zXYjIpeG6ngbeIR+mg76gg5dznF2H2Jk
         NCIS3zcKZrRWAHdqQANRwwNn78EhibeUuJNeYCoj7do7dy+Q8PJfaiAzfUxW0UlvfuZY
         3nZw==
X-Gm-Message-State: APjAAAU4nHt58vcaMlhXNfyS+ZAhHwMpDMNdaSNpxMc3gv16GOdUxEHG
        8R+UkZDKq4dP0U9s5z9MYCHBMDOI4ek=
X-Google-Smtp-Source: APXvYqyKzyvSJ5+YUw0vIFGg9shy3A4Kf9qnKYRryzslec/JfDyEhawcyBrpRFzNTqfWRObYkJI/tA==
X-Received: by 2002:a17:902:690c:: with SMTP id j12mr4749477plk.132.1568738127410;
        Tue, 17 Sep 2019 09:35:27 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id s5sm3202452pfe.52.2019.09.17.09.35.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Sep 2019 09:35:26 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 12/12] clean: fix theoretical path corruption
Date:   Tue, 17 Sep 2019 09:35:04 -0700
Message-Id: <20190917163504.14566-13-newren@gmail.com>
X-Mailer: git-send-email 2.22.1.17.g6e632477f7
In-Reply-To: <20190917163504.14566-1-newren@gmail.com>
References: <20190912221240.18057-1-newren@gmail.com>
 <20190917163504.14566-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

cmd_clean() had the following code structure:

    struct strbuf abs_path = STRBUF_INIT;
    for_each_string_list_item(item, &del_list) {
        strbuf_addstr(&abs_path, prefix);
        strbuf_addstr(&abs_path, item->string);
        PROCESS(&abs_path);
        strbuf_reset(&abs_path);
    }

where I've elided a bunch of unnecessary details and PROCESS(&abs_path)
represents a big chunk of code rather than an actual function call.  One
piece of PROCESS was:

    if (lstat(abs_path.buf, &st))
        continue;

which would cause the strbuf_reset() to be missed -- meaning that the
next path to be handled would have two paths concatenated.  This path
used to use die_errno() instead of continue prior to commit 396049e5fb62
("git-clean: refactor git-clean into two phases", 2013-06-25), but my
understanding of how correct_untracked_entries() works is that it will
prevent both dir/ and dir/file from being in the list to clean so this
should be dead code and the die_errno() should be safe.  But I hesitate
to remove it since I am not certain.

However, we can fix both this bug and possible similar future bugs by
simply moving the strbuf_reset(&abs_path) to the beginning of the loop.
It'll result in N calls to strbuf_reset() instead of N-1, but that's a
small price to pay to avoid sneaky bugs like this.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/clean.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 6030842f3a..4cf2399f59 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -1018,6 +1018,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	for_each_string_list_item(item, &del_list) {
 		struct stat st;
 
+		strbuf_reset(&abs_path);
 		if (prefix)
 			strbuf_addstr(&abs_path, prefix);
 
@@ -1051,7 +1052,6 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 				printf(dry_run ? _(msg_would_remove) : _(msg_remove), qname);
 			}
 		}
-		strbuf_reset(&abs_path);
 	}
 
 	strbuf_release(&abs_path);
-- 
2.22.1.17.g6e632477f7.dirty

