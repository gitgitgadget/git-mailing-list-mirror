Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B4A220A1E
	for <e@80x24.org>; Sun,  9 Dec 2018 10:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbeLIKpU (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Dec 2018 05:45:20 -0500
Received: from mail-lf1-f46.google.com ([209.85.167.46]:36464 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbeLIKpQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Dec 2018 05:45:16 -0500
Received: by mail-lf1-f46.google.com with SMTP id a16so5973762lfg.3
        for <git@vger.kernel.org>; Sun, 09 Dec 2018 02:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QVnD/gjRPWHGcRytVjxyUZXFYaeKWyGksZyiNARqSTA=;
        b=NZf2X5WdOqUW05ezUG8jQF7QyUDte1gKc8VRdCmhKThBJA1i6kBDctBsTqiUKeBlZT
         ZialTp6GmTtdIJ0l+jsx5egpKAzbmlE0Oxxerrzc+i8IwRvEIWJSnmAmqjqkZeTNh7XM
         FI2a24bamzvedGiWbL8zoWVnFQV4GAXYa8SXE/ka6xNANEWi2OYcngSAiEm5wpY5lIS6
         c85XdbNcxcA+ttd2GxOOMou7GuPFxmYR/MOZ735dPQIafMBXzhc8/5xOb3A0V7HkfwUY
         r2YyMFChtmvt2hNIku2Nll8D6uBcUimQixR0sQIYwXTk88MAhhpls41GvRbthO5EoLAX
         QPIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QVnD/gjRPWHGcRytVjxyUZXFYaeKWyGksZyiNARqSTA=;
        b=cpyLOQYaorVHoOl8lQzJhklL/LZkhEpgtVTYJxDUlO00FoyCiv3pOOJ28BKvjErfkh
         FbcJDkD1CWDxfHw5a6rOtu9vvcsct57zZP4XZNfWVBwkU0fUqhQUtXVSJYQZYY1CuzYS
         Fwu2HxHK66NeGYiGe2l8nZOSkImU+Jx0IkLIAWPUJdQ+uwQInnKj2ZcAZ1IuPhdqZhfl
         Z8lLz0h5dguWRrRGREpl8DUvAM1fZ/2cjQry5vj2COwN/ytygi4AWcDIFYuvcWF/Zi2b
         4On2JKwmaRwLj/PBwOWKf878qsXUSgZTzVXx/BuV/M9rqSrT0VuDPG74dTwtC9jPeRgJ
         u0pw==
X-Gm-Message-State: AA+aEWZjCLbIWLTf6lvY/wXcaYJ7aZ+BRYPhK9eZruarFD9AkuUMmqNF
        /paJfEAhepA8Fw7+Rme5FXDQ+M+T
X-Google-Smtp-Source: AFSGD/V/PE/XlyFwRoXkfm1cmpRx5djwfzgU/9nfhcwguazs88D/mOz55I1c24qRypZb7KB2Vnz8eQ==
X-Received: by 2002:ac2:41cb:: with SMTP id d11mr4870894lfi.3.1544352313978;
        Sun, 09 Dec 2018 02:45:13 -0800 (PST)
Received: from localhost.localdomain (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id s3-v6sm1564938lje.73.2018.12.09.02.45.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 02:45:13 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 12/24] backup-log: add log command
Date:   Sun,  9 Dec 2018 11:44:07 +0100
Message-Id: <20181209104419.12639-13-pclouds@gmail.com>
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

One note about the default relative mode. Since this is mostly used
after a panic moment "oops I did it again!". The user would most
likely look for latest changes of a certain path and relative dates
make it easier to spot if the change is within a time frame.

Default to --patch too because the output is pretty useless otherwise.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/backup-log.c  | 90 +++++++++++++++++++++++++++++++++++++++++++
 t/t2080-backup-log.sh | 34 ++++++++++++++++
 2 files changed, 124 insertions(+)

diff --git a/builtin/backup-log.c b/builtin/backup-log.c
index f8029e0011..2496d73ba5 100644
--- a/builtin/backup-log.c
+++ b/builtin/backup-log.c
@@ -6,11 +6,13 @@
 #include "dir.h"
 #include "object-store.h"
 #include "parse-options.h"
+#include "revision.h"
 
 static char const * const backup_log_usage[] = {
 	N_("git backup-log [--path=<path> | --id=<id>] update <path> <old-hash> <new-hash>"),
 	N_("git backup-log [--path=<path> | --id=<id>] cat [<options>] <change-id> <path>"),
 	N_("git backup-log [--path=<path> | --id=<id>] diff [<diff-options>] <change-id>"),
+	N_("git backup-log [--path=<path> | --id=<id>] log [<options>] [--] [<path>]"),
 	NULL
 };
 
@@ -213,6 +215,92 @@ static int diff(int argc, const char **argv,
 	return ret - 1;
 }
 
+struct log_options {
+	struct rev_info revs;
+	timestamp_t last_time;
+	int last_tz;
+};
+
+static void dump(struct bkl_entry *entry, struct log_options *opts)
+{
+	timestamp_t last_time = opts->last_time;
+	int last_tz = opts->last_tz;
+
+	if (entry) {
+		opts->last_time = entry->timestamp;
+		opts->last_tz = entry->tz;
+	}
+
+	if (last_time != -1 &&
+	    ((!entry && diff_queued_diff.nr) ||
+	     (entry && last_time != entry->timestamp))) {
+		printf("Change-Id: %"PRItime"\n", last_time);
+		printf("Date: %s\n", show_date(last_time, last_tz, &opts->revs.date_mode));
+		printf("\n--\n");
+		diffcore_std(&opts->revs.diffopt);
+		diff_flush(&opts->revs.diffopt);
+		printf("\n");
+	}
+}
+
+static int log_parse(struct strbuf *line, void *data)
+{
+	struct log_options *opts = data;
+	struct bkl_entry entry;
+
+	if (bkl_parse_entry(line, &entry))
+		return -1;
+
+	if (opts->revs.max_age != -1 && entry.timestamp < opts->revs.max_age)
+		return 1;
+
+	if (!match_pathspec(the_repository->index, &opts->revs.prune_data,
+			    entry.path, strlen(entry.path),
+			    0, NULL, 0))
+		return 0;
+
+	dump(&entry, opts);
+
+	queue_blk_entry_for_diff(&entry);
+
+	return 0;
+}
+
+static int log_(int argc, const char **argv,
+		const char *prefix, const char *log_path)
+{
+	struct log_options opts;
+	int ret;
+
+	memset(&opts, 0, sizeof(opts));
+	opts.last_time = -1;
+	opts.last_tz = -1;
+
+	repo_init_revisions(the_repository, &opts.revs, prefix);
+	opts.revs.date_mode.type = DATE_RELATIVE;
+	argc = setup_revisions(argc, argv, &opts.revs, NULL);
+	if (!opts.revs.diffopt.output_format) {
+		opts.revs.diffopt.output_format = DIFF_FORMAT_PATCH;
+		diff_setup_done(&opts.revs.diffopt);
+	}
+
+	setup_pager();
+	if (opts.revs.reverse) {
+		/*
+		 * Default order is reading file from the bottom. --reverse
+		 * makes it read from the top instead (i.e. forward)
+		 */
+		ret = bkl_parse_file(log_path, log_parse, &opts);
+	} else {
+		ret = bkl_parse_file_reverse(log_path, log_parse, &opts);
+	}
+	if (ret < 0)
+		die(_("failed to parse '%s'"), log_path);
+	dump(NULL, &opts);	/* flush */
+
+	return ret;
+}
+
 static char *log_id_to_path(const char *id)
 {
 	if (!strcmp(id, "index"))
@@ -256,6 +344,8 @@ int cmd_backup_log(int argc, const char **argv, const char *prefix)
 		return cat(argc, argv, prefix, log_path);
 	else if (!strcmp(argv[0], "diff"))
 		return diff(argc, argv, prefix, log_path);
+	else if (!strcmp(argv[0], "log"))
+		return log_(argc, argv, prefix, log_path);
 	else
 		die(_("unknown subcommand: %s"), argv[0]);
 
diff --git a/t/t2080-backup-log.sh b/t/t2080-backup-log.sh
index cd4288d386..3cdabc2ba2 100755
--- a/t/t2080-backup-log.sh
+++ b/t/t2080-backup-log.sh
@@ -130,4 +130,38 @@ test_expect_success 'backup-log diff' '
 	test_cmp stat.expected stat.actual
 '
 
+test_expect_success 'backup-log log' '
+	rm -f .git/index.bkl &&
+	echo first >initial.t &&
+	git add initial.t &&
+	echo second >initial.t &&
+	test_tick &&
+	git -c core.backupLog=true add initial.t &&
+	echo third >initial.t &&
+	# note, same tick!
+	git -c core.backupLog=true add initial.t &&
+	test_tick &&
+	echo forth >initial.t &&
+	git -c core.backupLog=true add initial.t &&
+	git backup-log --id=index log --stat --date=iso >actual &&
+	cat >expected <<-\EOF &&
+	Change-Id: 1112912593
+	Date: 2005-04-07 15:23:13 -0700
+	
+	--
+	 initial.t | 2 +-
+	 1 file changed, 1 insertion(+), 1 deletion(-)
+	
+	Change-Id: 1112912533
+	Date: 2005-04-07 15:22:13 -0700
+	
+	--
+	 initial.t | 2 +-
+	 initial.t | 2 +-
+	 2 files changed, 2 insertions(+), 2 deletions(-)
+	
+	EOF
+	test_cmp expected actual
+'
+
 test_done
-- 
2.20.0.rc2.486.g9832c05c3d

