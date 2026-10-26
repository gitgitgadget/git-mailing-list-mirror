Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793005626;
	b=ZWhiYBSK/IUkApWkp5nZ0hlprKeY7LRvY4oM8tPRr9ptGs4S09FIlOWpjAbFKAl/Us6l
	 YbjtEUr3hYXQibEk+5jGHT/tQW2OmvgBZxBFpHE26R7loGPtGggmqUEfAA18FpWiF6x5Z
	 a7Gf5FIMiScL7kfCJQVVXgdK2oOZKYNqT0hKlSB6r6wx/6CuQZTY+oip8EeIvswd6oiTo
	 ItQ4Lm2MA8J+sIRTdmggtKeNv2xJX0v/XAUUdxJxraZ3K536d5dtlddPBt5DqSf/UJeVX
	 zbVe7Rnwgy3V3h3sacC0rju5J7N/kje05hX2xIyqBrCkHhT1hF3rYbFRTXKuvXXbNsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793005626;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=JDL3hXrxiyYT7g7r/FBmNwS1zM1Uj5hccHKVyhjiIx0=;
	b=u6VzHt1tPgZxeMtfp7wt6cvL216MZTTBKSGV2E16y5ZQUdGtJ1hRz/feOsM5ndTpsmJo
	 xuPLBLefrHLW7CVKUY0oEu43F83UHYV/novbcD3JVXK49Zdt3q6wvC1J4CMG7TIINcHAK
	 3yzt0iUi/RBCsdxcqevJDwoiGn8THD5uU+Ko4n+fAoPBjH0h/V1puBH0cJiF194OW5cg+
	 zFsaRjFfNivozyc+giLVM6xcXz2bwXAuzmrAlFEKyYxw6Xnl2qidMTXSAQ5jcpLjsYK5r
	 ONvkN8KyxO3os/pfAYYEwioFM/MXNohM8+gW2nxskMmY7ujMZwEI43BOTxFbxgttQRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PbH71ENL;
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CB0606A325
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 09:07:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2CB0606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PbH71ENL
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cd60c5da24cso1474275a12.0
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 02:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793005625; x=1793610425; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JDL3hXrxiyYT7g7r/FBmNwS1zM1Uj5hccHKVyhjiIx0=;
        b=PbH71ENLczR0Q9MUOMobBqt0wOhr4aSuJi/XjU3TuBL3YOptB5v2+un3DaKW/Jnqje
         8z6idZjhSXjgozRF/1LKgVgKW7iFMONZ2pERWW2oHypJIU9MFlunH2kt7YOW1QDTTLfi
         Co8EIpd3ULoLCdDwTV7rhHS5nyrdZwjkzp4KfRtF6KhVGuoEdN5shEroyfgtzinON/FX
         I9cM2uFereqAs4dYOl8w8BF668+h7NWXYdAQJDFH7MmQfdi2T2JUFdOF6wWJa8dx2x9/
         1bF98yJW/6U0XTfLw6CwXfk3AzLduyKZwguR46pQcH5zgERLmYk5uFEs1TuTPtxh1p7s
         fWxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793005625; x=1793610425;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JDL3hXrxiyYT7g7r/FBmNwS1zM1Uj5hccHKVyhjiIx0=;
        b=E/t3DxC0vDejNijILC379SRzNNW1+mT7cArU4f1sIc1TdkariAZRs8SNw1finbNiKX
         vWcHNt/Agy0mZz7tZ039sWqe6DhU/bcjG6ghci+hKkuTR9j9hEGLd9NAAu4jv16zfHGf
         nMjmwIWUVbUdSmNUFLJQYBGycD65pZv1fxtKCDJJHeaGpURimNdw7daNp22ELpCosAo1
         OftCdoM2sCrmCkghorhWVp684oTB17QzyJQJ2c5qoqdyIS8c384Xh6zehCMJQFbMvab5
         Z8MgzPffjNUvJX0W/Paj0dXKHrl8Z3MuMyIq9IFcgqV93AKXtc2Zdk2Snr1ldIr4MPRJ
         yLsA==
X-Gm-Message-State: AFq9FYK7zJjCSJPco3E0fn627BH26pqw+VOP6s79AfDM3PMWO15gaWH3
	H8mZ36jQdmgCcoMSEW/5rDhTwSMrGETCcEANLHJoF8rNx1buszuV2AQq+KGIoQZ+
X-Gm-Gg: AYBFou2lCsAy0Um2rF4DiQJiNbVymn5caL9+lZzs3wdqDf9E10402ciDYyEe3xuelJq
	ODzsUrLqVd2tYzE5etKjAqkvoF0ccH+vvcjuxgBDHJ0WxPTqNverw584cHiKIMSO1LUrBsw4tF9
	wMH0Ik4jCjJO28iHfCgKJ3oo5CZrBkvCO8Ee0W2hY0QSiMRX9el906aH3MescYKtmk9CKrF/lIP
	AgQkc88nThcl6VChBw9ZgOcVT6ZcAighoJJjv1ZpsolVnLzQI0KDe4fIOvI3xrtzTytZhB6flZD
	nEt+8QEq1DXLthfkeP/NPe10UnJwOUgT9xh3wRkYr+jn527BAPCvEHlpQEtHtEbypphxANAke6s
	Y4d6dHRaVPVh+L9aE7OSLI+7xP7g0pNw/iFkiptIjL8oZlY7Fd3COHPBlmgUHCAjsWMRvP3IPTz
	AbbojRiEAvFI4IDIJIbjCcAk2g8z5lzJL/8Hn5eATMF/2I1bSpLU3CJScDVI/gpU6mLoF+4VwJi
	53TvjwbGeVy7/AZa0M69X/qg6lm/aXawh1F+H6zu86wNgk1lnpR8Nyn
X-Received: by 2002:a17:90a:4485:b0:3ac:97e3:7389 with SMTP id 98e67ed59e1d1-3adeafd6493mr3865742a91.44.1793005624894;
        Mon, 26 Oct 2026 02:07:04 -0700 (PDT)
Received: from [127.0.0.1] ([20.168.94.86])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebacbf5fsm7823040a91.6.2026.10.26.02.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 02:07:04 -0700 (PDT)
Message-Id: <91ffbdf4fa9beb215f92819c4c6d0ad2640a0c71.1793005620.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2219.v4.git.1793005620.gitgitgadget@gmail.com>
References: <pull.2219.git.1789385483.gitgitgadget@gmail.com>
	<pull.2219.v4.git.1793005620.gitgitgadget@gmail.com>
From: "Qin ShiCheng via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 26 Oct 2026 09:06:59 +0000
Subject: [PATCH v4 2/3] pack-objects: add --ignore-pack-keep-from
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Taylor Blau <ttaylorr@openai.com>,
    Junio C Hamano <gitster@pobox.com>,
    Justin Tobler <jltobler@gmail.com>,
    qeesung <qeesung@live.com>,
    Qin ShiCheng <qeesung@live.com>

From: Qin ShiCheng <qeesung@live.com>

repack decides which packs to delete before it runs pack-objects, but
pack-objects looks for ".keep" files on its own when it opens the
packs. A ".keep" that appears in between, for example from a push or
fetch whose index-pack wrote a pack identical to an existing one, makes
pack-objects treat as kept a pack that repack is about to delete. Its
objects are then left out of the new pack, or not loosened, or not
kept as unreachable, and they are gone once repack deletes the pack.

Not all of that goes through "--honor-pack-keep": loosening objects
for "--unpack-unreachable", and collecting them for
"--keep-unreachable" and "--cruft", skip packs with a ".keep" file
regardless of it.

Let the caller name such packs. "--ignore-pack-keep-from=<file>" reads
names of local packs, one per line, given and matched as for
"--keep-pack", and treats them as if they had no ".keep" file. All of
the above go by p->pack_keep, which is read from the disk once, when a
pack is first seen, so clearing it for the named packs before anything
looks at it covers every one of them. Other packs, including any that
show up later, keep whatever their ".keep" files say.

The names come from a file because there can be more of them than fit
on a command line (on Windows, the whole command line is limited to
32767 characters), and the standard input is already taken in every
mode repack uses.

Signed-off-by: Qin ShiCheng <qeesung@live.com>
---
 Documentation/git-pack-objects.adoc | 12 ++++++++++
 builtin/pack-objects.c              | 37 +++++++++++++++++++++++++++++
 t/t7700-repack.sh                   | 37 +++++++++++++++++++++++++++++
 3 files changed, 86 insertions(+)

diff --git a/Documentation/git-pack-objects.adoc b/Documentation/git-pack-objects.adoc
index ccad938c5b..43fb206ef0 100644
--- a/Documentation/git-pack-objects.adoc
+++ b/Documentation/git-pack-objects.adoc
@@ -13,6 +13,7 @@ SYNOPSIS
 		   [--no-reuse-delta] [--delta-base-offset] [--non-empty]
 		   [--local] [--incremental] [--window=<n>] [--depth=<n>]
 		   [--revs [--unpacked | --all]] [--keep-pack=<pack-name>]
+		   [--ignore-pack-keep-from=<file>]
 		   [--cruft] [--cruft-expiration=<time>]
 		   [--stdout [--filter=<filter-spec>] | <base-name>]
 		   [--shallow] [--keep-true-parents] [--[no-]sparse]
@@ -193,6 +194,17 @@ depth is 4095.
 	leading directory (e.g. `pack-123.pack`). The option could be
 	specified multiple times to keep multiple packs.
 
+--ignore-pack-keep-from=<file>::
+	Read names of local packs from `<file>`, one per line in the
+	same form as for `--keep-pack`, and treat them as if they had
+	no .keep file, both for `--honor-pack-keep` and when deciding
+	which objects to loosen or keep with `--unpack-unreachable`,
+	`--keep-unreachable` and `--cruft`.
+	This is for callers like linkgit:git-repack[1] that are about
+	to delete those packs: a .keep file that appears on one of them
+	after the caller decided to delete it must not cause its objects
+	to be left out.
+
 --incremental::
 	This flag causes an object already in a pack to be ignored
 	even if it would have otherwise been packed.
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 5160e76842..f63baa7273 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -194,6 +194,7 @@ static const char *const pack_usage[] = {
 	   "                 [--no-reuse-delta] [--delta-base-offset] [--non-empty]\n"
 	   "                 [--local] [--incremental] [--window=<n>] [--depth=<n>]\n"
 	   "                 [--revs [--unpacked | --all]] [--keep-pack=<pack-name>]\n"
+	   "                 [--ignore-pack-keep-from=<file>]\n"
 	   "                 [--cruft] [--cruft-expiration=<time>]\n"
 	   "                 [--stdout [--filter=<filter-spec>] | <base-name>]\n"
 	   "                 [--shallow] [--keep-true-parents] [--[no-]sparse]\n"
@@ -5005,6 +5006,36 @@ static void get_object_list(struct rev_info *revs, struct strvec *argv)
 	oid_array_clear(&recent_objects);
 }
 
+/*
+ * Treat the local packs named in "path" as if they had no ".keep" file.
+ * The names are matched like those given with --keep-pack. This has to
+ * happen before anything looks at p->pack_keep, which is read from the
+ * disk only once, when the pack is first seen.
+ */
+static void ignore_pack_keep_from_file(const char *path)
+{
+	struct string_list names = STRING_LIST_INIT_DUP;
+	struct strbuf buf = STRBUF_INIT;
+	struct packed_git *p;
+	FILE *fp = xfopen(path, "r");
+
+	names.cmp = fspathcmp;
+	while (strbuf_getline(&buf, fp) != EOF)
+		string_list_append(&names, buf.buf);
+	if (ferror(fp))
+		die_errno(_("could not read '%s'"), path);
+	fclose(fp);
+	string_list_sort(&names);
+
+	repo_for_each_pack(the_repository, p)
+		if (p->pack_local &&
+		    string_list_has_string(&names, pack_basename(p)))
+			p->pack_keep = 0;
+
+	string_list_clear(&names, 0);
+	strbuf_release(&buf);
+}
+
 static void add_extra_kept_packs(const struct string_list *names)
 {
 	struct packed_git *p;
@@ -5138,6 +5169,7 @@ int cmd_pack_objects(int argc,
 	int rev_list_index = 0;
 	enum stdin_packs_mode stdin_packs = STDIN_PACKS_MODE_NONE;
 	struct string_list keep_pack_list = STRING_LIST_INIT_NODUP;
+	char *ignore_pack_keep_from = NULL;
 	struct list_objects_filter_options filter_options =
 		LIST_OBJECTS_FILTER_INIT;
 	struct repo_config_values *cfg = repo_config_values(the_repository);
@@ -5222,6 +5254,8 @@ int cmd_pack_objects(int argc,
 			 N_("ignore packs that have companion .keep file")),
 		OPT_STRING_LIST(0, "keep-pack", &keep_pack_list, N_("name"),
 				N_("ignore this pack")),
+		OPT_FILENAME(0, "ignore-pack-keep-from", &ignore_pack_keep_from,
+			     N_("ignore .keep files of the packs named in <file>")),
 		OPT_INTEGER(0, "compression", &cfg->pack_compression_level,
 			    N_("pack compression level")),
 		OPT_BOOL(0, "keep-true-parents", &grafts_keep_true_parents,
@@ -5449,6 +5483,8 @@ int cmd_pack_objects(int argc,
 	if (progress && all_progress_implied)
 		progress = 2;
 
+	if (ignore_pack_keep_from)
+		ignore_pack_keep_from_file(ignore_pack_keep_from);
 	add_extra_kept_packs(&keep_pack_list);
 	if (ignore_packed_keep_on_disk) {
 		struct packed_git *p;
@@ -5543,6 +5579,7 @@ cleanup:
 	clear_packing_data(&to_pack);
 	list_objects_filter_release(&filter_options);
 	string_list_clear(&keep_pack_list, 0);
+	free(ignore_pack_keep_from);
 	strvec_clear(&rp);
 
 	return 0;
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index f0a390e3c6..00fe259767 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -211,6 +211,43 @@ test_expect_success 'objects made unreachable by grafts only are kept' '
 	git cat-file -t $H1
 '
 
+test_expect_success 'pack-objects --ignore-pack-keep-from' '
+	test_when_finished "rm -fr ignore-keep" &&
+	git init ignore-keep &&
+	(
+		cd ignore-keep &&
+		test_commit base &&
+		unreachable=$(git commit-tree -m unreachable HEAD^{tree}) &&
+
+		git rev-list --objects --all $unreachable >objects &&
+		P=$(git pack-objects .git/objects/pack/pack <objects) &&
+		test_commit kept &&
+		git rev-list --objects base..kept >objects &&
+		K=$(git pack-objects .git/objects/pack/pack <objects) &&
+		git prune-packed &&
+		>.git/objects/pack/pack-$P.keep &&
+		>.git/objects/pack/pack-$K.keep &&
+		echo pack-$P.pack >ignore &&
+
+		# Both packs have a .keep file, but only P is named in
+		# "ignore": its reachable objects are packed and the others
+		# are loosened, while K is left alone.
+		git pack-objects --honor-pack-keep --all --reflog \
+			--indexed-objects --unpack-unreachable \
+			--ignore-pack-keep-from=ignore \
+			.git/objects/pack/pack </dev/null &&
+		test-tool find-pack --check-count 2 base &&
+		test-tool find-pack --check-count 1 kept &&
+		test_path_is_file .git/objects/$(test_oid_to_path $unreachable)
+	)
+'
+
+test_expect_success 'pack-objects --ignore-pack-keep-from with a missing file' '
+	test_must_fail git pack-objects --stdout \
+		--ignore-pack-keep-from=does-not-exist </dev/null 2>err &&
+	test_grep "could not open .does-not-exist. for reading" err
+'
+
 test_expect_success 'repack --keep-pack' '
 	test_create_repo keep-pack &&
 	(
-- 
gitgitgadget

