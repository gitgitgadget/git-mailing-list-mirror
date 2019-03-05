Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 879FF20248
	for <e@80x24.org>; Tue,  5 Mar 2019 12:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbfCEMI6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 07:08:58 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42335 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfCEMI6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 07:08:58 -0500
Received: by mail-pg1-f194.google.com with SMTP id b2so5498488pgl.9
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 04:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rosw+fnajiGRuBzEWCYWUtpKOh3sZwyKA0/SAgQTFIs=;
        b=Btw1iAEIziKIMBjTLxkcOlwAIUUR6MXbxNxNn8mLtXHSLB3lOYbzS//6I3HndQb7ym
         1lbC7R921NGK2ifFvdN3cNeVq/oS2VPf3edzQXE1Ptd9wy84iy2NjTpB30aMPsJELrEG
         60MbRxUIiIp4oKC8m5bsptG4rtse2Jg687ifirM0yoqygZnJjW1zX3TTYZzVrUrVexEU
         WzP58cOxD7XnifsNQ1nJr3s0IaMbKizd/MP0h+9jPcEIueRjqp3Qopto0hDEseZLhv+y
         O9NcASHaPxSBtzGblNAdxnJd+u0jqXyvZMj6WnPPCJ+v3/gnVrer5ORg/MEoNzuRN013
         dGsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rosw+fnajiGRuBzEWCYWUtpKOh3sZwyKA0/SAgQTFIs=;
        b=DEniQNT3qzSXMuBLwTfVA6T75gqW7VBQnPa69FkteRkcnGClA9rkaohAW2Iu6cBLsR
         fhTdeobNX3z3pTGmQJd7TqrxaIP4XCTtg9UAeiFoWPgN4DOzsU0y0S9flBRaGbO89j8D
         fgpyXhpYRa2Om9lS5r1rQwU3yJ2MXao0zAMB7us6gcocgaTR1WAxANUE9G1MnDaAGFT0
         06LtpbHQ233gEba0PgDGwSRHeDfB1Sq0tLiTHZu3og6KTOTxg1M/YnIfLO1dLfv4xobX
         wFLcMlojFrxDjpHfIOmX6FDWLIkD4enTctNJXstSFWpCDsvFqlmCdQGq6kZFmL7n+hE6
         X7hg==
X-Gm-Message-State: APjAAAXyCIgxVqmDf8ie4n6hWzP3hoPipe5TfkH3ukxGSvi23iJRlG+b
        jyanOY5E5eIpy6x+puC1X5w=
X-Google-Smtp-Source: APXvYqxeXs+LUJEggW09gEjwP4TagXHDErQcijawnHz4Mb+VuiNhkZOZ70VoybUuE0Z3HO0bunJD1w==
X-Received: by 2002:a63:4a4d:: with SMTP id j13mr1127250pgl.16.1551787737275;
        Tue, 05 Mar 2019 04:08:57 -0800 (PST)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id n15sm19012361pgc.92.2019.03.05.04.08.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 04:08:56 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 05 Mar 2019 19:08:51 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, hi-angel@yandex.ru, peff@peff.net,
        ramsay@ramsayjones.plus.com, sunshine@sunshineco.com,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v4 2/2] worktree add: sanitize worktree names
Date:   Tue,  5 Mar 2019 19:08:34 +0700
Message-Id: <20190305120834.7284-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc1.337.gdf7f8d0522
In-Reply-To: <20190305120834.7284-1-pclouds@gmail.com>
References: <20190226105851.32273-1-pclouds@gmail.com>
 <20190305120834.7284-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Worktree names are based on $(basename $GIT_WORK_TREE). They aren't
significant until 3a3b9d8cde (refs: new ref types to make per-worktree
refs visible to all worktrees - 2018-10-21), where worktree name could
be part of a refname and must follow refname rules.

Update 'worktree add' code to remove special characters to follow these
rules. In the future the user will be able to specify the worktree name
by themselves if they're not happy with this dumb character
substitution.

Reported-by: Konstantin Kharlamov <hi-angel@yandex.ru>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/worktree.c      |  7 ++++++-
 refs.c                  | 36 ++++++++++++++++++++++++++++++++++++
 refs.h                  |  1 +
 t/t2025-worktree-add.sh |  5 +++++
 4 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 3f9907fcc9..ca63dd3df6 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -275,6 +275,7 @@ static int add_worktree(const char *path, const char *refname,
 	struct strbuf symref = STRBUF_INIT;
 	struct commit *commit = NULL;
 	int is_branch = 0;
+	struct strbuf sb_name = STRBUF_INIT;
 
 	validate_worktree_add(path, opts);
 
@@ -290,7 +291,10 @@ static int add_worktree(const char *path, const char *refname,
 		die(_("invalid reference: %s"), refname);
 
 	name = worktree_basename(path, &len);
-	git_path_buf(&sb_repo, "worktrees/%.*s", (int)(path + len - name), name);
+	strbuf_add(&sb_name, name, path + len - name);
+	sanitize_worktree_refname(&sb_name);
+	name = sb_name.buf;
+	git_path_buf(&sb_repo, "worktrees/%s", name);
 	len = sb_repo.len;
 	if (safe_create_leading_directories_const(sb_repo.buf))
 		die_errno(_("could not create leading directories of '%s'"),
@@ -415,6 +419,7 @@ static int add_worktree(const char *path, const char *refname,
 	strbuf_release(&symref);
 	strbuf_release(&sb_repo);
 	strbuf_release(&sb_git);
+	strbuf_release(&sb_name);
 	return ret;
 }
 
diff --git a/refs.c b/refs.c
index 70c55ea1b6..a23a84e431 100644
--- a/refs.c
+++ b/refs.c
@@ -163,6 +163,42 @@ static int check_refname_component(const char *refname, int *flags)
 	return cp - refname;
 }
 
+void sanitize_worktree_refname(struct strbuf *name)
+{
+	int flags = 0, i, max_tries;
+	const char *cp;
+	enum refname_check_code ret;
+
+	/*
+	 * name->len should be enough because we should never need to
+	 * substitute any position more than once, but let's just add
+	 * a couple more to be on the safe side.
+	 */
+	max_tries = name->len + 10;
+	for (i = 0; i < max_tries; i++) {
+		ret = do_check_refname_component(name->buf, &flags, &cp);
+		switch (ret) {
+		case refname_ok:
+			strbuf_setlen(name, cp - name->buf);
+			return;
+
+		case refname_component_has_zero_length:
+			strbuf_addstr(name, "worktree");
+			return;
+
+		case refname_contains_dotdot:
+		case refname_contains_atopen:
+		case refname_has_badchar:
+		case refname_contains_wildcard:
+		case refname_ends_with_dotlock:
+		case refname_starts_with_dot:
+			*(char *)cp = '-';
+			break;
+		}
+	}
+	BUG("stuck in infinite loop! buf = %s", name->buf);
+}
+
 int check_refname_format(const char *refname, int flags)
 {
 	int component_len, component_count = 0;
diff --git a/refs.h b/refs.h
index 308fa1f03b..3b65b8d27a 100644
--- a/refs.h
+++ b/refs.h
@@ -459,6 +459,7 @@ int for_each_reflog(each_ref_fn fn, void *cb_data);
  * repeated slashes are accepted.
  */
 int check_refname_format(const char *refname, int flags);
+void sanitize_worktree_refname(struct strbuf *name);
 
 const char *prettify_refname(const char *refname);
 
diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index 286bba35d8..6e2b90c84f 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -570,4 +570,9 @@ test_expect_success '"add" an existing locked but missing worktree' '
 	git worktree add --force --force --detach gnoo
 '
 
+test_expect_success FUNNYNAMES 'sanitize generated worktree name' '
+	git worktree add --detach ".  weird*..?.lock.lock" &&
+	test -d .git/worktrees/---weird--.-.lock-lock
+'
+
 test_done
-- 
2.21.0.rc1.337.gdf7f8d0522

