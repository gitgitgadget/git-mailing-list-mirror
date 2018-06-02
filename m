Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBC321F42D
	for <e@80x24.org>; Sat,  2 Jun 2018 04:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751507AbeFBEdF (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Jun 2018 00:33:05 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:43272 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751433AbeFBEcz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jun 2018 00:32:55 -0400
Received: by mail-lf0-f66.google.com with SMTP id n15-v6so302392lfn.10
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 21:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GTY+gI/EK4OvbypclxfLqJ7c9PKny+If9e8H6tTQPtM=;
        b=evfKv1FlmRVb2uZZd9ELugw3ouI1kW70ajIWrQ+mwEOBeFLjQuOT6BYbdCLxu4pLPv
         Zmcw5oJhbwJ76/1K/lNkKKXmvdgr3T4jCBALAZfaacqf2lnRC8pPugKimbFvtj/hSh66
         SNT3m+1+AISGcv/n3+3etFdSPcRcw6AjlIp5tWJPPkxfA6Guc6BV4WnQyTEKv6D5v3OM
         0INfBHRd2tAqBVIspGTVtprZrhLTxpcmit+UHHDdF9qMMATLupgaW0ZOL+357L7vGog7
         AMrAmPX+73YKfR4WGRR4FkdyQlV+Xgkv8tM6So2OwXRJEAsKrdAq4CzDcuWYL8kKdXYf
         5+kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GTY+gI/EK4OvbypclxfLqJ7c9PKny+If9e8H6tTQPtM=;
        b=eMmhXMhkyGnwcFSwnvv6RX/Dlxx6EVYudcNkz9wUnJnYotzhmN7vn1Ndsc5yhQ5LVf
         dppQwSX6cfYdvuyEuNYVZYGrK7cRpJMqPK3TIxltyAJett+tMte9sJih34lheT+9fotp
         akpFsHxCcbHNuUWIgemHa5d+X7QdrPlTeLq17DHIl0a7+bEPAxed4+u61zebjnB3HdZ8
         +vl7M6AHIOhXWOeYGEJnGCQ17oqZp85IE6//DW4kOkFLppx6zn2U7BY7flZzJ+2cVmzJ
         LPbEQOFkGTEKm2DBuuboq/d2UOyU/tiNq9SvtK+fwMovXzlI8oGv3QxRzTvuFKhihxE1
         3YQg==
X-Gm-Message-State: ALKqPwf0+WlkXOeKLafyLdrC0/m5i6/etLukqD3hrtrY0ZeHPES+lWcq
        UtRCHnkl+mscKA5N/D40qAQ7yg==
X-Google-Smtp-Source: ADUXVKK3+MXgnyorNKky0/qKa8WiHBPkQt7hLMwIi/VUNSV7EPiX3+hWhFGiHVAen7NsdZEf8gkwcw==
X-Received: by 2002:a19:f71a:: with SMTP id z26-v6mr7693599lfe.137.1527913972788;
        Fri, 01 Jun 2018 21:32:52 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o11-v6sm644776lji.0.2018.06.01.21.32.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Jun 2018 21:32:51 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 04/22] builtin/grep.c: mark strings for translation and no full stops
Date:   Sat,  2 Jun 2018 06:32:23 +0200
Message-Id: <20180602043241.9941-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.309.g77c7720784
In-Reply-To: <20180602043241.9941-1-pclouds@gmail.com>
References: <20180602043241.9941-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/grep.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index ee753a403e..58f941e951 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -489,7 +489,7 @@ static int grep_cache(struct grep_opt *opt, struct repository *repo,
 	}
 
 	if (repo_read_index(repo) < 0)
-		die("index file corrupt");
+		die(_("index file corrupt"));
 
 	for (nr = 0; nr < repo->index->cache_nr; nr++) {
 		const struct cache_entry *ce = repo->index->cache[nr];
@@ -959,7 +959,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	}
 
 	if (!opt.pattern_list)
-		die(_("no pattern given."));
+		die(_("no pattern given"));
 
 	/*
 	 * We have to find "--" in a separate pass, because its presence
@@ -1085,19 +1085,19 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	}
 
 	if (recurse_submodules && (!use_index || untracked))
-		die(_("option not supported with --recurse-submodules."));
+		die(_("option not supported with --recurse-submodules"));
 
 	if (!show_in_pager && !opt.status_only)
 		setup_pager();
 
 	if (!use_index && (untracked || cached))
-		die(_("--cached or --untracked cannot be used with --no-index."));
+		die(_("--cached or --untracked cannot be used with --no-index"));
 
 	if (!use_index || untracked) {
 		int use_exclude = (opt_exclude < 0) ? use_index : !!opt_exclude;
 		hit = grep_directory(&opt, &pathspec, use_exclude, use_index);
 	} else if (0 <= opt_exclude) {
-		die(_("--[no-]exclude-standard cannot be used for tracked contents."));
+		die(_("--[no-]exclude-standard cannot be used for tracked contents"));
 	} else if (!list.nr) {
 		if (!cached)
 			setup_work_tree();
@@ -1105,7 +1105,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		hit = grep_cache(&opt, the_repository, &pathspec, cached);
 	} else {
 		if (cached)
-			die(_("both --cached and trees are given."));
+			die(_("both --cached and trees are given"));
 
 		hit = grep_objects(&opt, &pathspec, &list);
 	}
-- 
2.18.0.rc0.309.g77c7720784

