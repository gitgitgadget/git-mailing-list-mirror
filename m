Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795500774;
	b=oPCqJmmVBbk4N1jlF0zFtk5vrXPSB+QnC1uL2S8wWj4ZzFppd39dyS4UP6XNh4E3vJA6
	 j4bHioKO/ufUcxW4Dqyg5gtMfULrjikOXENJXEusZRUFVN2QBKjzK5cEiHYyFdmm8jjwc
	 eLR5yczgyVWUMe7ltng4mNzRAKTfd9u0J2qsOdBgGznRfRRtUkJY9NzP+yKzLTF0gzA2J
	 PAk57aF/G24AdRLLbtpT6NsJh5k5+PNn/abYlesM/2QrhDnVBN0iNwjf/hvGIMkgH+pOv
	 1d3+J2yI6EoBJB1da0VoZmWOLwaemfZEWm84YFcnIN/zM/AQKdTz8nAoq15LvEWC0cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795500774;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=2v9CvTmLko/WVBJ9HLCzJuloO44vQ+fisyrMYLZf5VU=;
	b=jgbHPcNcEklI550S408GGKm0ecvfwZqPknhyuP0+ojxChKX2vnjJK+qxHWOHUzzygAyM
	 /VoDrfWlvDWGfTHEAz3VpvjiDCGg9putgyKsrR+ft2IpM4587rRWSgB7BZj9nOwI/ZXam
	 a1/sd5OerGu9fWv3K1P52dpZzAIArVUgnYdLjtvMg4JIq8YupQ9qEyqfQXYl+6opzCGIZ
	 HtpKblB5yqpQK0ihKU6hxe3b2Y4bqMjSN5huzhrTkLHZLwqfVHvKPUlLxvPznm4ppwKFF
	 J160l+e+VW3CY6nXrZgIvmpZS5eBud/+HfVlq1dYxr1BlD3ZvbvVsTGa0Nw0o3jIVhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TE5jxBdG;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E37F606A333
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 06:12:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E37F606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TE5jxBdG
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3ae6b4c669fso4180985a91.0
        for <git@vger.kernel.org>; Mon, 23 Nov 2026 22:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795500770; x=1796105570; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2v9CvTmLko/WVBJ9HLCzJuloO44vQ+fisyrMYLZf5VU=;
        b=TE5jxBdGTmWYjdrDv3ThIJPv2fccFvuChRYfOKQIho6GuYIpQuPC2dBOyR/yGQKRTd
         EkBK7/Rb7oDD8UmX2Oe4eRINdNT+raq8ETkZh9g7gCVWkSfFS0DZeT9umJ7Ek8iiim8A
         cS9hL0yKQiWTbK/R/3pc2vQ3jg4oIh9rxzONSr2Q8LIDnIhc6MIz0CeAZ7lXERCm4GOJ
         SO+AifMZcpRik62M62j+NmeWF87hEiFxZiEOjgvdZkItUH1crauKeqJRdHKBn+39lORd
         0+M3JUe38+1xoyo+IPvGkl20mI72ASq3OOP11Sl0OyKEgWm8qy0/KBihZtWM2Y//6nv4
         ec5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795500770; x=1796105570;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2v9CvTmLko/WVBJ9HLCzJuloO44vQ+fisyrMYLZf5VU=;
        b=qWKO0/rQalXqbfee7GFXVrYJiG/EEdrJnkYYEJGxxOAgIIpbKgAq11IMuhWyh8rV/U
         cY5VH/C+EAoVppbm/JBUlYWLiXwh4vSnCz1r/0+fZ9ZJz5DDDTRodAXhIar7CT3Ymh2V
         usMh2nLDGxO/DK43rL2rO9dOEmVW/x8Nb1jt5VIuz2NLCY4uaFl10teKjjwJvpOGrhge
         LeFZED+CMJMADuclTr8bxhlz02aj06BbLwC1fA/M4wpUEh25RrDDXaFSLb/opQwjfqoQ
         CpiuiLPfiIFY6wWlUSKHSsmCPQygFfO4gySAfCmDSLAyJfjQeZTmfo/AXZ2FVJCCzWgS
         haCg==
X-Gm-Message-State: APuU4Z+ib9fgzrkcO/HTGXl5ARbvRmZZd2WelWRAyiPFXKlSLrApHBRz
	0lJFGGnGlDI1uqTNvTY8g+AVF0v5CYVE84pP/ymdKgSTfs1kmxBsb9jYMCv+uQ==
X-Gm-Gg: AZFdTZe74gb+7x63Rv9VTt2HSqLikK2zCTySlqUOuhIja/Thw90/9Y3hfSF0NJiLJsU
	r2r7QODqdixpipNGHs4RGXhJVn90mQ3uaS2TMfxQczm3o1GLtlNUPMEiPOkNLj6sK6muUn6cuB6
	UIYZ3wKegeEPs6p1BEs6jUK2urfcno+XKXvmdrYTDrE8MpTDJfxg7TxRSENmTMShD0TsG901yes
	Oe/6kl9kuYAqcas9SGe9wQVEnC2IHMxqDLZOaGWDWgrXHm+f7mpO77Tru5CU5RXV/L9LvLJ23Nt
	WmF4Fii2090pKffB0fX3AWc4IilF3EvnTRfejny+juX31hPx3wBLeGxqF2i/IAW5poC5vGnUlVU
	mrjNaHQEM2rq0QXa6yifSCKhU7aC4oiX3eS8Y64Jw/4pkHCqKgFFqCCiPVT9BqtlzG3Cm3FeJ9c
	ckZyZx8JcZuVYDGXMKqkEdCRJR2apu0MAV2lfP1YZsr23g9lo2JwozRffDIyk3zhCYMAq/6QYz3
	xqFTVcfVXYsiW+IzL7raF2+BHPsdYh2NbYZtEZhjwHaAFIijjlr+w7F+AJ7nKTl/y8L40O7XPN9
	Ovo+qLYekw1R9/0RK8frVwZtWfTd0Q==
X-Received: by 2002:a17:90b:5350:b0:3b3:b414:9aaf with SMTP id 98e67ed59e1d1-3b41c93b4admr8037539a91.27.1795500770452;
        Mon, 23 Nov 2026 22:12:50 -0800 (PST)
Received: from [127.0.0.1] ([57.154.4.118])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad8e93asm21177035a91.11.2026.11.23.22.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 22:12:49 -0800 (PST)
Message-Id: <6641abfa4980df3254378569579da2993467f06f.1795500766.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2219.v5.git.1795500766.gitgitgadget@gmail.com>
References: <pull.2219.git.1789385483.gitgitgadget@gmail.com>
	<pull.2219.v5.git.1795500766.gitgitgadget@gmail.com>
From: "Qin ShiCheng via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 24 Nov 2026 06:12:45 +0000
Subject: [PATCH v5 2/3] pack-objects: add --ignore-pack-keep-from
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
index 4b60a581a3..c2416a6f14 100644
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
@@ -195,6 +196,17 @@ depth is 4095.
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
index c198cd18ab..18e0ecb170 100644
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
@@ -5056,6 +5057,36 @@ static void get_object_list(struct rev_info *revs, struct strvec *argv)
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
@@ -5189,6 +5220,7 @@ int cmd_pack_objects(int argc,
 	int rev_list_index = 0;
 	enum stdin_packs_mode stdin_packs = STDIN_PACKS_MODE_NONE;
 	struct string_list keep_pack_list = STRING_LIST_INIT_NODUP;
+	char *ignore_pack_keep_from = NULL;
 	struct list_objects_filter_options filter_options =
 		LIST_OBJECTS_FILTER_INIT;
 	struct repo_config_values *cfg = repo_config_values(the_repository);
@@ -5273,6 +5305,8 @@ int cmd_pack_objects(int argc,
 			 N_("ignore packs that have companion .keep file")),
 		OPT_STRING_LIST(0, "keep-pack", &keep_pack_list, N_("name"),
 				N_("ignore this pack")),
+		OPT_FILENAME(0, "ignore-pack-keep-from", &ignore_pack_keep_from,
+			     N_("ignore .keep files of the packs named in <file>")),
 		OPT_INTEGER(0, "compression", &cfg->pack_compression_level,
 			    N_("pack compression level")),
 		OPT_BOOL(0, "keep-true-parents", &grafts_keep_true_parents,
@@ -5500,6 +5534,8 @@ int cmd_pack_objects(int argc,
 	if (progress && all_progress_implied)
 		progress = 2;
 
+	if (ignore_pack_keep_from)
+		ignore_pack_keep_from_file(ignore_pack_keep_from);
 	add_extra_kept_packs(&keep_pack_list);
 	if (ignore_packed_keep_on_disk) {
 		struct packed_git *p;
@@ -5594,6 +5630,7 @@ cleanup:
 	clear_packing_data(&to_pack);
 	list_objects_filter_release(&filter_options);
 	string_list_clear(&keep_pack_list, 0);
+	free(ignore_pack_keep_from);
 	strvec_clear(&rp);
 
 	return 0;
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 338f622614..8a6b014c30 100755
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

