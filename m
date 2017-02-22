Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD180201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 14:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932673AbdBVOGQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 09:06:16 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:32824 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932670AbdBVOGO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 09:06:14 -0500
Received: by mail-pg0-f66.google.com with SMTP id 5so554286pgj.0
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 06:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L4jbASHG1w0yco0FlRipxjfzUUqgRJ/K/YPkqsLaQxk=;
        b=RTGBDqPDMQPtxJy/QUmY5dJAaT4ee5CCgzpXgQWd6rp1L7x3Er6gamBo+KE5YuJNU9
         bpg+xDc7CpbM1H5hXq0t8ugTQBa4CMYf7BrTw8yUL5pey3WHfzXpyrv9JIyYZZjiTgdw
         7deUULbHTvquFqoh1jJ5/p9PExpHKnFVO3uidRuFqv/dSzIOZxBg+XcNgwC4TJtSo/OS
         HL/XzGUCcovm3Wm3SpNClcNDXrLFsrF1nKW90AYBY8x26NbyXlQ7yCwPz8Q/6Y9nibTL
         Zlq+pQHUytRl83zgSOY3t7ZoRaFG7zGO3/t7t5YeqbANf/S1iY0iaObDldxWXUY8R2aK
         2K1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L4jbASHG1w0yco0FlRipxjfzUUqgRJ/K/YPkqsLaQxk=;
        b=OCHtfbw45o62xC+0EshFrT83Xi5DsBuIuz3HQ+eermOB9wWLYFn3uFIMf5FKKeqZhV
         FOTqKrpUGNPTltCP0hUE3He59188WBstXWWtIeLEuU0VmWP1wlF30cDEKn8fPsUZd7LQ
         OVHjpK1MY4p0IoCPjD5yjxhynL5boK/AuJ7BJMs/7NR58MeTIS1PNOAZxLwoegiQhJWU
         PR3OxS9mF5Eh5Y/2oV+TGPCXUJ0p2JqEZnXP0Cc7oxlX4TUxJp3hPihzpKuHWiZOmV1T
         YW37oaG4DdbMbo9sAueU/7xD5qp1AHPKBW02YIWnxWEDsDYZB0QbzVS0NZmG8LQeDw1P
         gU1w==
X-Gm-Message-State: AMke39lOLKq+PHUYXBQA5s93js4qRrkahqUWxY5QjijJA1vMgyD/WVwBmBR4QCn75v/QKg==
X-Received: by 10.99.115.71 with SMTP id d7mr42109775pgn.56.1487772368312;
        Wed, 22 Feb 2017 06:06:08 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id w16sm4126239pgc.15.2017.02.22.06.06.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Feb 2017 06:06:07 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 22 Feb 2017 21:06:00 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v5 05/24] files-backend: move "logs/" out of TMP_RENAMED_LOG
Date:   Wed, 22 Feb 2017 21:04:31 +0700
Message-Id: <20170222140450.30886-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170222140450.30886-1-pclouds@gmail.com>
References: <20170218133303.3682-1-pclouds@gmail.com>
 <20170222140450.30886-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes reflog path building consistent, always in the form of

    strbuf_git_path(sb, "logs/%s", refname);

It reduces the mental workload a bit in the next patch when that
function call is converted.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs/files-backend.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 435db1293..69946b0de 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2513,7 +2513,7 @@ static int files_delete_refs(struct ref_store *ref_store,
  * IOW, to avoid cross device rename errors, the temporary renamed log must
  * live into logs/refs.
  */
-#define TMP_RENAMED_LOG  "logs/refs/.tmp-renamed-log"
+#define TMP_RENAMED_LOG  "refs/.tmp-renamed-log"
 
 struct rename_cb {
 	const char *tmp_renamed_log;
@@ -2549,7 +2549,7 @@ static int rename_tmp_log(const char *newrefname)
 	int ret;
 
 	strbuf_git_path(&path, "logs/%s", newrefname);
-	strbuf_git_path(&tmp, TMP_RENAMED_LOG);
+	strbuf_git_path(&tmp, "logs/%s", TMP_RENAMED_LOG);
 	cb.tmp_renamed_log = tmp.buf;
 	ret = raceproof_create_file(path.buf, rename_tmp_log_callback, &cb);
 	if (ret) {
@@ -2626,12 +2626,12 @@ static int files_rename_ref(struct ref_store *ref_store,
 		return 1;
 
 	strbuf_git_path(&sb_oldref, "logs/%s", oldrefname);
-	strbuf_git_path(&tmp_renamed_log, TMP_RENAMED_LOG);
+	strbuf_git_path(&tmp_renamed_log, "logs/%s", TMP_RENAMED_LOG);
 	ret = log && rename(sb_oldref.buf, tmp_renamed_log.buf);
 	strbuf_release(&sb_oldref);
 	strbuf_release(&tmp_renamed_log);
 	if (ret)
-		return error("unable to move logfile logs/%s to "TMP_RENAMED_LOG": %s",
+		return error("unable to move logfile logs/%s to logs/"TMP_RENAMED_LOG": %s",
 			oldrefname, strerror(errno));
 
 	if (delete_ref(oldrefname, orig_sha1, REF_NODEREF)) {
@@ -2714,10 +2714,10 @@ static int files_rename_ref(struct ref_store *ref_store,
 	if (logmoved && rename(sb_newref.buf, sb_oldref.buf))
 		error("unable to restore logfile %s from %s: %s",
 			oldrefname, newrefname, strerror(errno));
-	strbuf_git_path(&tmp_renamed_log, TMP_RENAMED_LOG);
+	strbuf_git_path(&tmp_renamed_log, "logs/%s", TMP_RENAMED_LOG);
 	if (!logmoved && log &&
 	    rename(tmp_renamed_log.buf, sb_oldref.buf))
-		error("unable to restore logfile %s from "TMP_RENAMED_LOG": %s",
+		error("unable to restore logfile %s from logs/"TMP_RENAMED_LOG": %s",
 			oldrefname, strerror(errno));
 	strbuf_release(&sb_newref);
 	strbuf_release(&sb_oldref);
-- 
2.11.0.157.gd943d85

