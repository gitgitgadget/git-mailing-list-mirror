Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C73DC20A1E
	for <e@80x24.org>; Sun,  9 Dec 2018 10:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbeLIKpQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Dec 2018 05:45:16 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33471 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbeLIKpP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Dec 2018 05:45:15 -0500
Received: by mail-lf1-f67.google.com with SMTP id i26so5975446lfc.0
        for <git@vger.kernel.org>; Sun, 09 Dec 2018 02:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=01DDxSmmPnshldu6Fq3bIwI459V7Jtgwf4Qquv7MkAw=;
        b=sB1FtGt8bdIeLartiTIZh0aVkO0xzD3nWuMKlvAt0nqixlk9ZXWUFeaVZFeIw/htBH
         /yQ/o6Q/O5+aSfH9mOY4n177IEo9gUpzo2Ito08T6dHD2l8nuZk4JtftUaIF0MoUTxg1
         Lpb+PANHCax4gdhWBWDd5mgWwgbCXUNOvhAyHs2khWqt3DQI6OF7FLLr/hVb30MR/5p1
         O7LNt6qb7bo8e7BMGrIYt70dGLz/6g+ILiZhLnByFVtllKz4GTyAroawbjooR65mj8ZX
         GBAXj1cXqo6rdwpIxl+msi1jS+590f9YljPCujLWZe699JQmAQiRzNHUfb2VYIEF7HBX
         6dNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=01DDxSmmPnshldu6Fq3bIwI459V7Jtgwf4Qquv7MkAw=;
        b=YFKpGn4YW9hZ2sf/ELOADvqFTcmMr3uSvMHimMRpthkGn8ydn5J5d25Sm5fxZzaw0t
         C6qABfb1ccqnLGPEMiiiyEVlHdXn63dkfcLe/Vzq7gVaEA/Uruqo9M2LOwz9nBnr2gk6
         jU3ZgbM1KCsxFRglprk3oUotHzBGAJCmIiC5QhXqOuVtYyDRjnmLc4sSOyMur9mvIs7h
         0zUidz/c/X9bJyVwv+x448jAxEpKcs8o+T4ntGuVgRsJmvxwwvU0b+wnA+E1vClghegi
         /J3dr6y0sU+s7B/ndqVCSCj0NXqwloMcyCq0iwVOPpknMIeaOCdaGYYqJPUl68aZ636A
         g1KA==
X-Gm-Message-State: AA+aEWY89QbuDeoT6D0UgnipUVJrjsNAyech+BNknqP9NKQ3ID8r9CMS
        /vrGuExCHqJOsk/LowaAB76ew4y7
X-Google-Smtp-Source: AFSGD/Wg96oecry6kEHYUfjBoHy9r9o7jUjwij/8+ESydTevkig4ZeWQ3QpR5J0QXb9KGZDGNVh+Lw==
X-Received: by 2002:a19:ced3:: with SMTP id e202mr4635240lfg.13.1544352311920;
        Sun, 09 Dec 2018 02:45:11 -0800 (PST)
Received: from localhost.localdomain (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id s3-v6sm1564938lje.73.2018.12.09.02.45.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 02:45:11 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 10/24] backup-log: add cat command
Date:   Sun,  9 Dec 2018 11:44:05 +0100
Message-Id: <20181209104419.12639-11-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.rc2.486.g9832c05c3d
In-Reply-To: <20181209104419.12639-1-pclouds@gmail.com>
References: <20181209104419.12639-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This command introduces a new concept, "change id". This is similar to
"n" in reflog sha-1 extended syntax @{n}. I'm trying to group changes of
the same second together, and this timestamp becomes "change id", so
you view roughly a snapshot of changes. Of course it's not 100%
accurate. But it works most of the time and it keeps log update low.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/backup-log.c  | 83 +++++++++++++++++++++++++++++++++++++++++++
 t/t2080-backup-log.sh | 17 +++++++++
 2 files changed, 100 insertions(+)

diff --git a/builtin/backup-log.c b/builtin/backup-log.c
index 75a02c8878..b370ff9d27 100644
--- a/builtin/backup-log.c
+++ b/builtin/backup-log.c
@@ -1,10 +1,13 @@
 #include "cache.h"
 #include "builtin.h"
 #include "backup-log.h"
+#include "dir.h"
+#include "object-store.h"
 #include "parse-options.h"
 
 static char const * const backup_log_usage[] = {
 	N_("git backup-log [--path=<path> | --id=<id>] update <path> <old-hash> <new-hash>"),
+	N_("git backup-log [--path=<path> | --id=<id>] cat [<options>] <change-id> <path>"),
 	NULL
 };
 
@@ -34,6 +37,84 @@ static int update(int argc, const char **argv,
 	return ret;
 }
 
+struct cat_options {
+	timestamp_t id;
+	char *path;
+	int before;
+	int show_hash;
+};
+
+static int cat_parse(struct strbuf *line, void *data)
+{
+	struct cat_options *opts = data;
+	struct bkl_entry entry;
+	struct object_id *oid;
+	void *buf;
+	unsigned long size;
+	enum object_type type;
+
+	if (bkl_parse_entry(line, &entry))
+		return -1;
+
+	if (entry.timestamp < opts->id)
+		return 2;
+
+	if (entry.timestamp != opts->id ||
+	    fspathcmp(entry.path, opts->path))
+		return 0;
+
+	if (opts->before)
+		oid = &entry.old_oid;
+	else
+		oid = &entry.new_oid;
+
+	if (opts->show_hash) {
+		puts(oid_to_hex(oid));
+		return 1;
+	}
+
+	if (is_null_oid(oid))
+		return 1;	/* treat null oid like empty blob */
+
+	buf = read_object_file(oid, &type, &size);
+	if (!buf)
+		die(_("object not found: %s"), oid_to_hex(oid));
+	if (type != OBJ_BLOB)
+		die(_("not a blob: %s"), oid_to_hex(oid));
+
+	write_in_full(1, buf, size);
+	free(buf);
+
+	return 1;
+}
+
+static int cat(int argc, const char **argv,
+		const char *prefix, const char *log_path)
+{
+	struct cat_options opts;
+	struct option options[] = {
+		OPT_BOOL(0, "before", &opts.before, N_("select the version before the update")),
+		OPT_BOOL(0, "hash", &opts.show_hash, N_("show the hash instead of the content")),
+		OPT_END()
+	};
+	char *end = NULL;
+	int ret;
+
+	memset(&opts, 0, sizeof(opts));
+	argc = parse_options(argc, argv, prefix, options, backup_log_usage, 0);
+	if (argc != 2)
+		usage_with_options(backup_log_usage, options);
+	opts.id = strtol(argv[0], &end, 10);
+	if (!end || *end)
+		die(_("not a valid change id: %s"), argv[0]);
+	opts.path = prefix_path(prefix, prefix ? strlen(prefix) : 0, argv[1]);
+	setup_pager();
+	ret = bkl_parse_file_reverse(log_path, cat_parse, &opts);
+	if (ret < 0)
+		die(_("failed to parse '%s'"), log_path);
+	return ret - 1;
+}
+
 static char *log_id_to_path(const char *id)
 {
 	if (!strcmp(id, "index"))
@@ -73,6 +154,8 @@ int cmd_backup_log(int argc, const char **argv, const char *prefix)
 
 	if (!strcmp(argv[0], "update"))
 		return update(argc, argv, prefix, log_path);
+	else if (!strcmp(argv[0], "cat"))
+		return cat(argc, argv, prefix, log_path);
 	else
 		die(_("unknown subcommand: %s"), argv[0]);
 
diff --git a/t/t2080-backup-log.sh b/t/t2080-backup-log.sh
index 8d1c8c5935..9c004c9727 100755
--- a/t/t2080-backup-log.sh
+++ b/t/t2080-backup-log.sh
@@ -88,4 +88,21 @@ test_expect_success 'apply --cached writes backup log' '
 	test_cmp expected .git/index.bkl
 '
 
+test_expect_success 'backup-log cat' '
+	OLD=$(git rev-parse :./initial.t) &&
+	echo update >>initial.t &&
+	test_tick &&
+	git -c core.backupLog=true add initial.t &&
+	NEW=$(git rev-parse :./initial.t) &&
+	git backup-log --id=index cat --before --hash $test_tick initial.t >actual &&
+	echo $OLD >expected &&
+	test_cmp expected actual &&
+	git backup-log --id=index cat --hash $test_tick initial.t >actual &&
+	echo $NEW >expected &&
+	test_cmp expected actual &&
+	git backup-log --id=index cat $test_tick initial.t >actual &&
+	git cat-file blob $NEW >expected &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.20.0.rc2.486.g9832c05c3d

