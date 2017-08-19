Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B1CA208CD
	for <e@80x24.org>; Sat, 19 Aug 2017 05:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750917AbdHSFhz (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Aug 2017 01:37:55 -0400
Received: from mout.web.de ([217.72.192.78]:49371 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750788AbdHSFhy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Aug 2017 01:37:54 -0400
Received: from [192.168.178.36] ([91.20.52.82]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MSrl3-1e7vKu2mBB-00RrJS; Sat, 19
 Aug 2017 07:32:41 +0200
Subject: [PATCH 3/4] archive: don't queue excluded directories
To:     git@vger.kernel.org
Cc:     David Adam <zanchey@ucc.gu.uwa.edu.au>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <alpine.DEB.2.11.1708131240360.15538@motsugo.ucc.gu.uwa.edu.au>
 <ae893c19-652d-1c8f-50ba-1242b95be84e@web.de>
 <887652a4-3f03-e2dd-2c68-cff4f7194898@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <781919c3-1656-46e1-5fb6-87494e2a449a@web.de>
Date:   Sat, 19 Aug 2017 07:32:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <887652a4-3f03-e2dd-2c68-cff4f7194898@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:sDNUYWOU5syERe24WPvbXTbD2SJLY5Vni9WHngJ5qzsY3mh0IY+
 sMG/aEV7g3qCjcdjD7Bsqse/LyowLARUNrBd+EnyfsPZEpWt1rXaEW1rpkiatNcY/S7+5BI
 J9nvOFcQqVGZJb6MqWLc8EY+96fv4lEVzlrNi3ewjbs2JkGmntounGWLmZv3dLNpC4M80Rq
 2ew+3y65ZdmPtcJC6b//g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uppiCmMe0VI=:qWwurkXD9EpG+mpVImRcb8
 3A9hGh8sziROuBZDm+87E9aVo9TkRaLsVk5xCeDzEh8e2+9IzBoKOC1GFincpmY4lCgSG7Hk8
 nFjnc1FrmLvgpo+LYVH4pvrJ9uFfmer1vr06TtgxGhlBh5HMdDmWERn2cwPiVyGbRvUzq345G
 6ZEVKn6cDuKREASMNOLljBll6nnEnUxO586itGpTdvwuLWEOujkP4m6XIxZERooncv/IVUE3d
 D5ew5tDe4IAjbisJTLTUIazzNK2TK30v2zFKrZMtxnrPSb51qs6dixE2aL7y+y7kzrUC2PN0G
 4d+E8O1bnoBcXrQMegYtTeitu9TT7/fUrgA4Fnf5bxFFB+WaMRF0kMecGao8xJ5ZiF6F7e3JQ
 qLUjManIC5RixbQNMrXzudDmqc4LGydV52FovQkiL6s5M9ZK1O9J/eyFekkWdmAkIvd5VwKyN
 dxmsXfa6mW6cg2ASLcutgTlsYR6x26CmH/OJhdfaHMoq8eS/cn/jZGBGrWMsPIP0aFEfSm/sX
 lwiMy0Sf2SAwu5xBKA0xykzoWFhOYnEFQkTLarb/NoyPFz9LvTU/USCAuport9rq7pBi9Hdkf
 E6kqWR0DA78N3EgMwneBtladquW/ur8Q3Um97gp0O2eaZo/B9bGuDQvVzOdiab8N2QGEkk9pf
 vQWsEcS9e55ssSIutTO/pjDRVUetClkDloivUiY/JeBZOJNnHcE7sKKB9HxnRmpqb4qJNgxJA
 ISIoizuERaDydXey/75MPzomHoHvolCwAJxBY8KF29Iv0XBlWLvIEXuLcTlzOvxGrajtB1tGo
 2jOMEj2HlCM6n5vAWBUeTmMWCEKnX8Htm2P/I7VAWV6M+R5f6Y=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reject directories with the attribute export-ignore already while
queuing them.  This prevents read_tree_recursive() from descending into
them and this avoids write_archive_entry() rejecting them later on,
which queue_or_write_archive_entry() is not prepared for.

Borrow the existing strbuf to build the full path to avoid string
copies and extra allocations; just make sure we restore the original
value before moving on.

Keep checking any other attributes in write_archive_entry() as before,
but avoid checking them twice.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 archive.c               | 32 +++++++++++++++++++++++++-------
 t/t5001-archive-attr.sh |  4 ++--
 2 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/archive.c b/archive.c
index 8e5f632912..1ab8d3a1d7 100644
--- a/archive.c
+++ b/archive.c
@@ -121,17 +121,21 @@ static int check_attr_export_subst(const struct attr_check *check)
 	return check && ATTR_TRUE(check->items[1].value);
 }
 
+static int should_queue_directories(const struct archiver_args *args)
+{
+	return args->pathspec.has_wildcard;
+}
+
 static int write_archive_entry(const unsigned char *sha1, const char *base,
 		int baselen, const char *filename, unsigned mode, int stage,
 		void *context)
 {
 	static struct strbuf path = STRBUF_INIT;
-	const struct attr_check *check;
 	struct archiver_context *c = context;
 	struct archiver_args *args = c->args;
 	write_archive_entry_fn_t write_entry = c->write_entry;
-	const char *path_without_prefix;
 	int err;
+	const char *path_without_prefix;
 
 	args->convert = 0;
 	strbuf_reset(&path);
@@ -143,10 +147,13 @@ static int write_archive_entry(const unsigned char *sha1, const char *base,
 		strbuf_addch(&path, '/');
 	path_without_prefix = path.buf + args->baselen;
 
-	check = get_archive_attrs(path_without_prefix);
-	if (check_attr_export_ignore(check))
-		return 0;
-	args->convert = check_attr_export_subst(check);
+	if (!S_ISDIR(mode) || !should_queue_directories(args)) {
+		const struct attr_check *check;
+		check = get_archive_attrs(path_without_prefix);
+		if (check_attr_export_ignore(check))
+			return 0;
+		args->convert = check_attr_export_subst(check);
+	}
 
 	if (S_ISDIR(mode) || S_ISGITLINK(mode)) {
 		if (args->verbose)
@@ -219,6 +226,17 @@ static int queue_or_write_archive_entry(const unsigned char *sha1,
 	}
 
 	if (S_ISDIR(mode)) {
+		size_t baselen = base->len;
+		const struct attr_check *check;
+
+		/* Borrow base, but restore its original value when done. */
+		strbuf_addstr(base, filename);
+		strbuf_addch(base, '/');
+		check = get_archive_attrs(base->buf);
+		strbuf_setlen(base, baselen);
+
+		if (check_attr_export_ignore(check))
+			return 0;
 		queue_directory(sha1, base, filename,
 				mode, stage, c);
 		return READ_TREE_RECURSIVE;
@@ -272,7 +290,7 @@ int write_archive_entries(struct archiver_args *args,
 	}
 
 	err = read_tree_recursive(args->tree, "", 0, 0, &args->pathspec,
-				  args->pathspec.has_wildcard ?
+				  should_queue_directories(args) ?
 				  queue_or_write_archive_entry :
 				  write_archive_entry_buf,
 				  &context);
diff --git a/t/t5001-archive-attr.sh b/t/t5001-archive-attr.sh
index 063622bc71..897f6f06d5 100755
--- a/t/t5001-archive-attr.sh
+++ b/t/t5001-archive-attr.sh
@@ -76,7 +76,7 @@ test_expect_exists	archive-pathspec/ignored-by-worktree
 test_expect_missing	archive-pathspec/excluded-by-pathspec.d failure
 test_expect_missing	archive-pathspec/excluded-by-pathspec.d/file
 
-test_expect_failure 'git archive with wildcard pathspec' '
+test_expect_success 'git archive with wildcard pathspec' '
 	git archive HEAD ":!excluded-by-p*" >archive-pathspec-wildcard.tar &&
 	extract_tar_to_dir archive-pathspec-wildcard
 '
@@ -85,7 +85,7 @@ test_expect_missing	archive-pathspec-wildcard/ignored
 test_expect_missing	archive-pathspec-wildcard/ignored-by-tree
 test_expect_missing	archive-pathspec-wildcard/ignored-by-tree.d
 test_expect_missing	archive-pathspec-wildcard/ignored-by-tree.d/file
-test_expect_exists	archive-pathspec-wildcard/ignored-by-worktree failure
+test_expect_exists	archive-pathspec-wildcard/ignored-by-worktree
 test_expect_missing	archive-pathspec-wildcard/excluded-by-pathspec.d
 test_expect_missing	archive-pathspec-wildcard/excluded-by-pathspec.d/file
 
-- 
2.14.1
