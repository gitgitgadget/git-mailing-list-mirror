Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794607916;
	b=hb0Wcxu4EXAPF/19xBh1e4A9hmGgZiYbrHz81UAJ8mYTtr6PfBkCsqm15r8RGM5cRf9K
	 XXPPhWuGAyiyhorKsJbdzdx34uEOHJ00XRVG6AnAQ5vuRDfAVPNUw4OlrBZ39XZwgEUMD
	 IoiT04WntY/a4M4QI3W2XwzQWmQD2EVBhaxZWEgVq165G8/sRQFiWK+NouA34DjT2Iuvw
	 kXUZ3l/YDdU+nr9i8fh4wCbkTkwM7RMdtbQ8a5cRLBorO9hcKiRrBgj99cKKLN78dYRUS
	 BdbxU+QhGhn1uKT3yugWWAu50MppWb7IpQA9svB3IUUQc8DHMamJHfW3piD+y6DYkKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794607916;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=ucoDp+vPDu3+G2u6P6YgMi2fZZpvRZ812BuvUQpvtlM=;
	b=NhsBUD2rEUYsmvcZkm77M7dXdcvtY30ZlWCt11kVIVJCK5QjwO0fCuTT/cjuig+eBNwJ
	 Wp3HCWH2G+4hsFq6i4OgI/DVjaAMSV5LWHKLkO703EbKSCY/qBdy5IuFSK8OotquRr8F2
	 7FSEclstBw2No3oRXZrXrwcgT2Pdc9HCTaFtTWEBODemXSRAvZmDsoiK/eC+1NOFQhMxz
	 BvF4ooi15OjmV3YvuoefYuwegIPiNIXSWTuUe8yDmHvcgFjtbbGNL+I6/hyfQhgEgWytj
	 PdLBOu/iQ+vWR/7+DgR9hf7PTaMM+flow/ysIS2wFgZBdCTr0AyGVIovTrQmXIu5FMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vYcFLepU;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0F7606A33D
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 22:11:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC0F7606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vYcFLepU
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1a3c08d6928so1998983c88.0
        for <git@vger.kernel.org>; Fri, 13 Nov 2026 14:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794607915; x=1795212715; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ucoDp+vPDu3+G2u6P6YgMi2fZZpvRZ812BuvUQpvtlM=;
        b=vYcFLepUunhAaUEUYbOkp1nxIHje1uvKMOQ0IjgjA3KIyxRonssNtZvfUuBN7Q7y5k
         tc1KrQksjIU+GD9rG1nbZxCDC09n0Nj3jGMsD3F5i0zRoXabmuHoyv52mESYHNiSHSD1
         qFYuIpVk2Nm+A8tghVGGbimNh4B9gvlNun3xhM0JTw/0Wub/4TX326sEOxpDqGgGWbym
         ktV8Q2/shj0BCR5vqpFzZGMbnodRneBd9uv+a4zLKv1qsM1juJHINM+1+FMCPoPUiqwY
         z94uAVwOlyHrHGljILXxtKW0GI+w5BV0hQ4owxWF3vAu69yMjXz8BtJkKbOKafdHtDTJ
         nwpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794607915; x=1795212715;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ucoDp+vPDu3+G2u6P6YgMi2fZZpvRZ812BuvUQpvtlM=;
        b=GUkbGOO3ZMayz3tsz6Fl20OHa1MNL5i08qmEEOk7rfr7K8uDBtzE+J/xGWNZE1gOrT
         oPTLzXQIE4sX9eX3YOe6RyRN+YTGFvCnu/aEmpe6/pYdpoReAhh8D4tjFHP20zl5HbDL
         r+g9lQtqRipbR0WC3T8252wNpI1lz3FQg58xhLHWvXw7TUH+ChHIP+466TV1bxKKZKje
         TWg0+BN9pKE8RAg1+FlVDaUrDR5lOn8uagzGZbVbR3o7ax8NEL3V9E7OqLCOdq8MK6eE
         xgj9/yWie0JpYXaYKp+VEFXbiumuo/gAHD4HLPJka5f8cD7CbUa+Qvso5PBkAmra1Tf0
         5m2w==
X-Gm-Message-State: APuU4Z9rKpMkfcMQ4RhkkZqenhfgY6oTlvg+u6MfjmBcDYgBOL0scTcT
	yYqGpHAvcW1epkMHIdQ/ufGxCgbhsHN0O/fT+Q6qtlpX64VQEDRBBkOtOSSlwg==
X-Gm-Gg: AYBFou1bQMhtfEyI4sZ0sMArmzc/DQRoC9ZNWjWhyrWVv45kNFv8kmaEmbWzNIK5UEs
	3/ptJfsGTYPJKPHWoIUnnqmK9b7Q/0BoBMyh4LR+jdZktFk95BWI34TT3NLDYHhfDkngfugorsx
	CVxuRRgB5mpxcM60cFItDAfCMBv0Qwdh2fDahWRY74uXV19IrIADfJQbKE4SiKT+B3sScMumq3i
	F7rQ8YaqZo1B0R5NdOVfsyRkGrXlsve0xmSA6qsbx027B/eDzetuCWiHzXhvrcQSknXHwaltJsQ
	WD1OByrDXFcO6IdzZkzhvptcQeF3XMcmWZqI4Dz2srboV6HQz4dZfs9Gyd0I1Kk958hdzL9wUnb
	26fsY+AWIG+6PZnwR5Tp929g8IlUNt2mS07t2HDRebudrtPOGT45NZon7pBSZKB7hkzLB6c/xWj
	2e2w7WMOoEhTCXxoYC4exWZcwzNAv7HTH48h7wFExx8LvNu7XKxszTM2yZ4zW7WFqxRm2Ee+ri8
	BoMskXV3PZLI2cqBSY6knCI8Ysmd8DKONeubSELUfnz7dl7vGFDOvh6eBvlrLrec3Z9ASdtd4L5
	ukzornXlyo5LZ3+F9WrSo7ZGotq+AXR26jmRE7L4+cWJmEPaSplKsYiS
X-Received: by 2002:a05:7022:7e09:b0:191:3c:aae7 with SMTP id a92af1059eb24-1b5030cd992mr4307324c88.26.1794607914885;
        Fri, 13 Nov 2026 14:11:54 -0800 (PST)
Received: from [127.0.0.1] ([172.184.174.120])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50316d9c2sm8943360c88.7.2026.11.13.14.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 14:11:54 -0800 (PST)
Message-Id: <4488a1534ebe7def72055ab5530d4f03177fbe52.1794607911.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2314.git.1794607911.gitgitgadget@gmail.com>
References: <pull.2314.git.1794607911.gitgitgadget@gmail.com>
From: "Adithya Chakilam via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 13 Nov 2026 22:11:50 +0000
Subject: [PATCH 1/2] repack: add --filter-to-loose to write filtered-out
 objects as loose objects
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
Cc: Martin Fick <mfick@nvidia.com>,
    Christian Couder <christian.couder@gmail.com>,
    Adithya Chakilam <achakilam@nvidia.com>,
    Adithya Chakilam <achakilam@nvidia.com>

From: Adithya Chakilam <achakilam@nvidia.com>

Some external object stores (like key-value) manage and retrieve git
objects individually. Although repack's --filter-to option can separate
objects from the main object store, it writes them into packs. Using
those objects individually then requires an additional unpacking step.

Add --filter-to-loose=<dir> to write filtered-out objects directly as
loose objects into <dir>, treating it as an object directory. Stream
the filtered pack into unpack-objects instead of writing an intermediate
pack file to disk.

The filtered pack is built with --stdin-packs, so this initially handles
only objects already stored in packs. Loose objects in the source
repository are left in place.

Signed-off-by: Adithya Chakilam <achakilam@nvidia.com>
---
 Documentation/git-repack.adoc |  10 ++-
 builtin/repack.c              |  21 ++++--
 repack-filtered.c             |  44 +++++++++++-
 repack.h                      |   1 +
 t/t7700-repack.sh             | 130 ++++++++++++++++++++++++++++++++++
 5 files changed, 199 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-repack.adoc b/Documentation/git-repack.adoc
index a1f9e64f66..df1390154f 100644
--- a/Documentation/git-repack.adoc
+++ b/Documentation/git-repack.adoc
@@ -12,7 +12,7 @@ SYNOPSIS
 'git repack' [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m]
 	[--window=<n>] [--depth=<n>] [--threads=<n>] [--keep-pack=<pack-name>]
 	[--write-midx[=<mode>]] [--name-hash-version=<n>] [--path-walk]
-	[--filter=<filter-spec>] [--drop-filtered [--dry-run]]
+	[--filter=<filter-spec> [--filter-to-loose=<dir>]] [--drop-filtered [--dry-run]]
 
 DESCRIPTION
 -----------
@@ -183,6 +183,14 @@ depth is 4095.
 	`objects` and `objects/info/alternates` sections of
 	linkgit:gitrepository-layout[5].
 
+--filter-to-loose=<dir>::
+	Like `--filter-to`, but treat `<dir>` as an object directory
+	and write the filtered out objects there as loose objects
+	instead of as a pack. Cannot be combined with `--filter-to`
+	or `--max-pack-size`. Objects already present in `<dir>` are
+	not rewritten. All objects are written before any existing
+	pack is removed.
+
 --drop-filtered::
 	Delete the local objects that match the `--filter` specification
 	instead of keeping them in a separate packfile, reclaiming the
diff --git a/builtin/repack.c b/builtin/repack.c
index 21835453c6..140a992f1b 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -41,7 +41,7 @@ static const char *const git_repack_usage[] = {
 	N_("git repack [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m]\n"
 	   "[--window=<n>] [--depth=<n>] [--threads=<n>] [--keep-pack=<pack-name>]\n"
 	   "[--write-midx[=<mode>]] [--name-hash-version=<n>] [--path-walk]\n"
-	   "[--filter=<filter-spec>] [--drop-filtered [--dry-run]]"),
+	   "[--filter=<filter-spec> [--filter-to-loose=<dir>]] [--drop-filtered [--dry-run]]"),
 	NULL
 };
 
@@ -182,6 +182,7 @@ int cmd_repack(int argc,
 	const char *cruft_expiration = NULL;
 	const char *expire_to = NULL;
 	const char *filter_to = NULL;
+	const char *filter_to_loose = NULL;
 	const char *opt_window = NULL;
 	const char *opt_window_memory = NULL;
 	const char *opt_depth = NULL;
@@ -257,6 +258,8 @@ int cmd_repack(int argc,
 			   N_("pack prefix to store a pack containing pruned objects")),
 		OPT_STRING(0, "filter-to", &filter_to, N_("dir"),
 			   N_("pack prefix to store a pack containing filtered out objects")),
+		OPT_STRING(0, "filter-to-loose", &filter_to_loose, N_("dir"),
+			   N_("object directory to write filtered out objects into as loose objects")),
 		OPT_BOOL(0, "drop-filtered", &drop_filtered,
 				N_("delete filtered out objects (requires --filter)")),
 		OPT_BOOL(0, "dry-run", &dry_run,
@@ -282,8 +285,16 @@ int cmd_repack(int argc,
 	po_args.depth = xstrdup_or_null(opt_depth);
 	po_args.threads = xstrdup_or_null(opt_threads);
 
-	die_for_incompatible_opt2(drop_filtered, "--drop-filtered",
-		!!filter_to, "--filter-to");
+	die_for_incompatible_opt3(drop_filtered, "--drop-filtered",
+			!!filter_to, "--filter-to",
+			!!filter_to_loose, "--filter-to-loose");
+	die_for_incompatible_opt2(!!filter_to, "--filter-to",
+			!!filter_to_loose, "--filter-to-loose");
+	die_for_incompatible_opt2(!!filter_to_loose, "--filter-to-loose",
+			!!po_args.max_pack_size, "--max-pack-size");
+
+	if (filter_to_loose)
+		filter_to = filter_to_loose;
 
 	if (dry_run && !drop_filtered)
 		die(_("--dry-run only takes effect with --drop-filtered"));
@@ -553,7 +564,8 @@ int cmd_repack(int argc,
 		strvec_pushf(&cmd.args, "--filter=%s",
 			     expand_list_objects_filter_spec(&po_args.filter_options));
 	else if (filter_to)
-		die(_("option '%s' can only be used along with '%s'"), "--filter-to", "--filter");
+		die(_("option '%s' can only be used along with '%s'"),
+		    filter_to_loose ? "--filter-to-loose" : "--filter-to", "--filter");
 
 	if (geometry.split_factor)
 		cmd.in = -1;
@@ -698,6 +710,7 @@ int cmd_repack(int argc,
 		struct write_pack_opts opts = {
 			.po_args = &po_args,
 			.destination = filter_to,
+			.loose = !!filter_to_loose,
 			.packdir = packdir,
 			.packtmp = packtmp,
 		};
diff --git a/repack-filtered.c b/repack-filtered.c
index 869b9fc6e3..51c9dfeb13 100644
--- a/repack-filtered.c
+++ b/repack-filtered.c
@@ -9,19 +9,40 @@
 #include "list-objects-filter.h"
 #include "odb.h"
 #include "promisor-remote.h"
+#include "sigchain.h"
+
+static void start_unpack_objects(struct child_process *unpack,
+				 const char *objdir)
+{
+	strvec_push(&unpack->args, "unpack-objects");
+	strvec_push(&unpack->args, "-q");
+	strvec_pushf(&unpack->env, "GIT_OBJECT_DIRECTORY=%s", objdir);
+	strvec_push(&unpack->env, "GIT_ALTERNATE_OBJECT_DIRECTORIES");
+	unpack->git_cmd = 1;
+	unpack->in = -1;
+	if (start_command(unpack))
+		die(_("could not start unpack-objects for '%s'"), objdir);
+}
 
 int write_filtered_pack(const struct write_pack_opts *opts,
 			struct existing_packs *existing,
 			struct string_list *names)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
+	struct child_process unpack = CHILD_PROCESS_INIT;
 	struct string_list_item *item;
 	FILE *in;
 	int ret;
 	const char *caret;
 	const char *pack_prefix = write_pack_opts_pack_prefix(opts);
 
-	prepare_pack_objects(&cmd, opts->po_args, opts->destination);
+	if (opts->loose) {
+		sigchain_push(SIGPIPE, SIG_IGN);
+		start_unpack_objects(&unpack, opts->destination);
+		prepare_pack_objects(&cmd, opts->po_args, "--stdout");
+	} else {
+		prepare_pack_objects(&cmd, opts->po_args, opts->destination);
+	}
 
 	strvec_push(&cmd.args, "--stdin-packs");
 
@@ -29,10 +50,18 @@ int write_filtered_pack(const struct write_pack_opts *opts,
 		strvec_pushf(&cmd.args, "--keep-pack=%s", item->string);
 
 	cmd.in = -1;
+	if (opts->loose)
+		cmd.out = unpack.in;
 
 	ret = start_command(&cmd);
-	if (ret)
+	if (ret) {
+		if (opts->loose) {
+			close(unpack.in);
+			finish_command(&unpack);
+			sigchain_pop(SIGPIPE);
+		}
 		return ret;
+	}
 
 	/*
 	 * Here 'names' contains only the pack(s) that were just
@@ -52,6 +81,17 @@ int write_filtered_pack(const struct write_pack_opts *opts,
 		fprintf(in, "%s%s.pack\n", caret, item->string);
 	fclose(in);
 
+	if (opts->loose) {
+		ret = finish_command(&cmd);
+		if (finish_command(&unpack))
+			ret = -1;
+		sigchain_pop(SIGPIPE);
+		if (ret)
+			ret = error(_("failed to write filtered out objects to '%s'"),
+				    opts->destination);
+		return ret;
+	}
+
 	return finish_pack_objects_cmd(existing->repo->hash_algo, opts, &cmd,
 				       names);
 }
diff --git a/repack.h b/repack.h
index 61e554e4ed..d5528745ec 100644
--- a/repack.h
+++ b/repack.h
@@ -41,6 +41,7 @@ void repack_remove_redundant_pack(struct repository *repo, const char *dir_name,
 struct write_pack_opts {
 	struct pack_objects_args *po_args;
 	const char *destination;
+	bool loose;
 	const char *packdir;
 	const char *packtmp;
 };
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index f0a390e3c6..5aa4b698f1 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -489,6 +489,136 @@ test_expect_success '--filter-to stores filtered out objects' '
 	test "$blob_content" = "content1"
 '
 
+test_expect_success '--filter-to-loose writes filtered out objects loose' '
+	rm -rf loose-work loose-src.git loose-dst.git &&
+	git init --bare loose-dst.git &&
+	git init loose-work &&
+	test_commit -C loose-work base file1 content1 &&
+	git clone --bare loose-work loose-src.git &&
+	git -C loose-src.git repack -a -d &&
+
+	blob=$(git -C loose-src.git rev-parse HEAD:file1) &&
+	git -C loose-src.git -c repack.writebitmaps=false repack -a -d \
+		--filter=blob:none --filter-to-loose=../loose-dst.git/objects &&
+
+	test_path_is_file loose-dst.git/objects/$(test_oid_to_path $blob) &&
+	find loose-dst.git/objects/pack -name "*.pack" >actual-packs &&
+	test_must_be_empty actual-packs &&
+	test_must_fail git -C loose-src.git cat-file -e $blob &&
+
+	echo $(pwd)/loose-dst.git/objects >loose-src.git/objects/info/alternates &&
+	echo content1 >expect &&
+	git -C loose-src.git cat-file blob $blob >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--filter-to-loose writes objects that also exist in the source' '
+	rm -rf loose-work loose-src.git loose-dst.git &&
+	git init --bare loose-dst.git &&
+	git init loose-work &&
+	test_commit -C loose-work base file1 content1 &&
+	git clone --bare loose-work loose-src.git &&
+	git -C loose-src.git repack -a -d &&
+
+	blob=$(git -C loose-src.git rev-parse HEAD:file1) &&
+	git -C loose-src.git -c repack.writebitmaps=false repack -a -d \
+		--filter=blob:none --filter-to-loose=../loose-dst.git/objects &&
+
+	test_path_is_file loose-dst.git/objects/$(test_oid_to_path $blob)
+'
+
+# Create loose-work/loose-src.git/loose-dst.git; $big is a 2k blob on
+# refs/heads/big in loose-src.git, packed unless $1 is "loose".
+setup_loose_src () {
+	rm -rf loose-work loose-src.git loose-dst.git &&
+	git init --bare loose-dst.git &&
+	git init loose-work &&
+	test_commit -C loose-work base small small &&
+	git clone --bare loose-work loose-src.git &&
+
+	big=$(test-tool genrandom big 2k | git -C loose-src.git hash-object -w --stdin) &&
+	tree=$(printf "100644 blob %s\tbig\n" $big | git -C loose-src.git mktree) &&
+	commit=$(git -C loose-src.git commit-tree -m big $tree) &&
+	git -C loose-src.git update-ref refs/heads/big $commit &&
+
+	if test "$1" != loose
+	then
+		git -C loose-src.git repack -a -d
+	fi
+}
+
+test_expect_success '--filter-to-loose failure to write leaves the source intact' '
+	setup_loose_src &&
+	>not-a-dir &&
+
+	ls loose-src.git/objects/pack/*.pack >packs-before &&
+	test_must_fail git -C loose-src.git -c repack.writebitmaps=false \
+		repack -a -d --filter=blob:limit=1k \
+		--filter-to-loose=../not-a-dir &&
+
+	ls loose-src.git/objects/pack/*.pack >packs-after &&
+	test_cmp packs-before packs-after &&
+
+	find loose-src.git/objects/pack -name ".tmp-*" >tmp-leftovers &&
+	test_must_be_empty tmp-leftovers &&
+	git -C loose-src.git cat-file -e $big
+'
+
+test_expect_success '--filter-to-loose does not move objects from kept packs' '
+	setup_loose_src &&
+
+	for p in loose-src.git/objects/pack/pack-*.pack
+	do
+		>${p%.pack}.keep || return 1
+	done &&
+
+	git -C loose-src.git -c repack.writebitmaps=false repack -a -d \
+		--filter=blob:limit=1k --filter-to-loose=../loose-dst.git/objects &&
+
+	test_path_is_missing loose-dst.git/objects/$(test_oid_to_path $big) &&
+	git -C loose-src.git cat-file -e $big
+'
+
+test_expect_success '--filter-to-loose leaves unreachable objects in cruft packs alone' '
+	setup_loose_src loose &&
+	git -C loose-src.git update-ref -d refs/heads/big &&
+	git -C loose-src.git repack --cruft -d &&
+
+	git -C loose-src.git -c repack.writebitmaps=false repack -a -d --cruft \
+		--filter=blob:limit=1k --filter-to-loose=../loose-dst.git/objects &&
+
+	test_path_is_missing loose-dst.git/objects/$(test_oid_to_path $big) &&
+	git -C loose-src.git cat-file -e $big
+'
+
+test_expect_success '--filter-to-loose output survives gc and prune of the source' '
+	setup_loose_src &&
+
+	git -C loose-src.git -c repack.writebitmaps=false repack -a -d \
+		--filter=blob:limit=1k --filter-to-loose=../loose-dst.git/objects &&
+
+	echo $(pwd)/loose-dst.git/objects >loose-src.git/objects/info/alternates &&
+	git -C loose-src.git gc --prune=now &&
+	git -C loose-src.git prune --expire=now &&
+
+	git -C loose-src.git fsck &&
+	git -C loose-src.git cat-file -e $big &&
+	test_path_is_file loose-dst.git/objects/$(test_oid_to_path $big)
+'
+
+test_expect_success '--filter-to-loose requires --filter, rejects --filter-to and --max-pack-size' '
+	test_must_fail git -C bare.git repack -a --filter-to-loose=../x 2>err &&
+	test_grep "can only be used along with" err &&
+
+	test_must_fail git -C bare.git repack -a --filter=blob:none \
+		--filter-to=../y --filter-to-loose=../x 2>err &&
+	test_grep "cannot be used together" err &&
+
+	test_must_fail git -C bare.git repack -a --filter=blob:none \
+		--filter-to-loose=../x --max-pack-size=1M 2>err &&
+	test_grep "cannot be used together" err
+'
+
 test_expect_success '--filter works with --max-pack-size' '
 	rm -rf filtered.git &&
 	git init --bare filtered.git &&
-- 
gitgitgadget

