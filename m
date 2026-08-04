Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7750045519B
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 10:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785837874; cv=none; b=rkDreU+cBTd+rFkprapMmLbaoU//I2CBxon1hR7I/Jp1vQXmYAbjTm1AuXzYdj7/BRFEiyvzo/AdQDl/SANdPddOJg0yIqiWKY6hAChh6xwfSb8+oZUR8YWRIMp9APPAane/2qoN2Lkpvcoa81w/4lq0HyqazJ/ETrNEKne5BgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785837874; c=relaxed/simple;
	bh=MPRpVIx5DK/hbZj+mXmbZQBsKmzK8vyDEoV/jVpbAes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T8+94N5/ARKVgGyBtwN+MgR5drjXl8hWnJN33bjmk8cmFbK0OT+vhZYp1tSS9Ahuh3e7pXTtL3CkuEErgyCgenyamUYD9LurUn54XYITcFBOqro+mrhx9CcKf3VrO4q745Ihgni8qjuV+otsXH0YGXBOb1XgRZ3qEsKuqdrF6Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KVt1qW16; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVt1qW16"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4980dc26022so20564785e9.1
        for <git@vger.kernel.org>; Tue, 04 Aug 2026 03:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785837871; x=1786442671; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6/PH99Gk3rYaZwPIMTEY6jbKXHm42CXp7wqs2lgsFCk=;
        b=KVt1qW16fj2RMaOZ52Te4prxHqLa+wd73e6P3rZLySw9Yxtg+Tz6xFRC86Mkh3hh8n
         M08jXDfs/rrQ8HTKDqkADaQ5hhnlcs9uyWxxkjRJO9o31TB3EJdhHfh2DU+Jb65CMuwg
         /OkntK98U4Osa6T+8aD9toLa2oBzJzxpQBsf/luEYzaBZgZdlYCLXVcM5c5pmzg/W0eV
         uqzjTv20VO1iyfzBEZEcrLuM1+LxWqxFDaAIEE0v93K0NpT40cpUIsSGG7n3Vr3JXyKT
         8fW3qM1mLHojDkjl3Z+YcHRDaq82AnmXwqSG4zeEvVuuUz8BNUANBoh+WJsZeMpsSkwZ
         zv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785837871; x=1786442671;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6/PH99Gk3rYaZwPIMTEY6jbKXHm42CXp7wqs2lgsFCk=;
        b=ZFenENyswS8S5hayRQ3JOBsKHRjovAOU8yQR5Mlf7opSnhSwiMmcBpd48WPQToX+Np
         I3oPTqMi4bROuAVME8YJpfqFhO1w4SMrVT+0TkRYhfRPCrxQJYet9hbiz388JbfykdHn
         DHbEDV81sT6fUkbMA4IsbZTpldpKhzEChCzC6BDt7ci6g1PWAza/Sty04opNUOzjKa35
         ub9/+c1K0GCYUuxcvfkbVG1es4+T7/wekd+zgqJNHuHz0spo6xp2tE4FXLnU/oW3bG73
         PWz7wl6EQQnP4DYw3bXTdT4c/AhUZVQxxXF5t1cGwk+KmxtO0EBo5iyaU+XzNu6GeQYY
         LPCw==
X-Gm-Message-State: AOJu0YzbNqWgZLBCjeOjh4fMvAA+O/l7tqF8b2FGijEvUmkrjVlAFNC4
	0reZAbnNkS+CsrP9ZAzfMKr5p4M+nEloyf5aWz2/4hGACRswVtavjkCR+988ag==
X-Gm-Gg: AR+sD12Ehia2PZeLnhBUlfzREBNqbr8WZMxz3K4h+uSbtZ8RGh0esW24x8lUf+cYEQf
	BsVDvXUuMt5owwG/bfSI0Mp67jSqTviSnJUqACuzq96EF1ldj/pzMvY4W/hYL2S6+XDjt8DQs+S
	PcjmYAVSydqfCQZm3WW4Fy1opCj/ubV338ldQN8Y+hyJqAfVl13GVIUtWex6PJo7WVQCm0tUjgv
	X8G4dGNrBjjrtyhOaq9dC7J90o0tT38FNL5iRmod/g/k4apBMXR3Bjlfc6Tj1gT3MPo/k1xHsMk
	886yGgku6norYyJITRgPOD1lO4x5ZCsO7CpqetCMAFIx4AXK10oBs8SG/a4QKrjaBc35C4oAJym
	R8e7eJpYZhF7Q90IjHhki24tSH1UjX5jmH//YAUe46UZ13aagO5ruWDh/yAkZ05it+aQAUHhv38
	mJnNvNTku9PGVZzFw2+LQoQFUBX0Ygckl8TKngDRztLtKUUdJAWS4lFFAtK5Rfjftyiiz7lsIyI
	gHA+zSV85gMI54wXDIVq/PZD0zzRWSrdvmmBQpbJchE3JXy/2zvOY1COpSBun7qNFElkMfm1fFI
X-Received: by 2002:a05:600c:35c1:b0:499:484a:81d0 with SMTP id 5b1f17b1804b1-499484a820emr128144875e9.9.1785837870556;
        Tue, 04 Aug 2026 03:04:30 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49949fec7cdsm72456045e9.13.2026.08.04.03.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 03:04:29 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Justin Tobler <jltobler@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 09/12] fast-import: use struct option for usage string
Date: Tue,  4 Aug 2026 12:03:52 +0200
Message-ID: <20260804100355.1299498-10-christian.couder@gmail.com>
X-Mailer: git-send-email 2.55.0.492.g44bba30fd7.dirty
In-Reply-To: <20260804100355.1299498-1-christian.couder@gmail.com>
References: <20260716165517.433849-1-christian.couder@gmail.com>
 <20260804100355.1299498-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently `git fast-import -h` shows the following on a single line:

  usage : git fast-import [--date-format=<f>] [--max-pack-size=<n>] \
                          [--big-file-threshold=<n>] [--depth=<n>] \
                          [--active-branches=<n>] \
                          [--export-marks=<marks.file>]

This output has a number of issues like:

  - It's missing a lot of options.
  - It's not consistent with the SYNOPSIS section of the doc.
  - With `--help-all` instead of `-h` additional hidden options should
    be shown, but that's not the case.
  - It's not standard style anymore.
  - Most other Git commands show additional lines for most of the
    options they support.

Also while most commands use the parse-options API to handle their
options, "builtin/fast-import.c" still doesn't use it.

Let's improve on that by using the parse-options API to display the
options when `-h` and `--help-all` are used.

While at it, let's make the SYNOPSIS section of
"Documentation/git-fast-import.adoc" consistent with the new usage
string.

This deliberately leaves it to future work to also use the
parse-options API to actually parse the options.

Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 Documentation/git-fast-import.adoc |  2 +-
 builtin/fast-import.c              | 83 +++++++++++++++++++++++++++---
 t/t0450/adoc-help-mismatches       |  1 -
 3 files changed, 78 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-fast-import.adoc b/Documentation/git-fast-import.adoc
index d68bc52b7e..7c5900e048 100644
--- a/Documentation/git-fast-import.adoc
+++ b/Documentation/git-fast-import.adoc
@@ -9,7 +9,7 @@ git-fast-import - Backend for fast Git data importers
 SYNOPSIS
 --------
 [verse]
-frontend | 'git fast-import' [<options>]
+'git fast-import' [<options>]
 
 DESCRIPTION
 -----------
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 926afde954..bf72adf62b 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -30,6 +30,7 @@
 #include "khash.h"
 #include "date.h"
 #include "gpg-interface.h"
+#include "parse-options.h"
 
 #define PACK_ID_BITS 16
 #define MAX_PACK_ID ((1<<PACK_ID_BITS)-1)
@@ -277,16 +278,18 @@ struct fast_import_state {
 	const char *prefix;
 	int seen_data_command;
 	int allow_unsafe_features;
+	struct option *option;
 };
 
 static void fast_import_state_init(struct fast_import_state *state,
 				   int argc, const char **argv,
-				   const char *prefix)
+				   const char *prefix, struct option *option)
 {
 	memset(state, 0, sizeof(*state));
 	state->argc = argc;
 	state->argv = argv;
 	state->prefix = prefix;
+	state->option = option;
 }
 
 static void parse_argv(struct fast_import_state *state);
@@ -3935,8 +3938,10 @@ static void git_pack_config(void)
 	repo_config(the_repository, git_default_config, NULL);
 }
 
-static const char fast_import_usage[] =
-"git fast-import [--date-format=<f>] [--max-pack-size=<n>] [--big-file-threshold=<n>] [--depth=<n>] [--active-branches=<n>] [--export-marks=<marks.file>]";
+static const char *const fast_import_usage[] = {
+	N_("git fast-import [<options>]"),
+	NULL
+};
 
 static void parse_argv(struct fast_import_state *state)
 {
@@ -3965,7 +3970,7 @@ static void parse_argv(struct fast_import_state *state)
 		die(_("unknown option --%s"), a);
 	}
 	if (i != state->argc)
-		usage(fast_import_usage);
+		usage_with_options(fast_import_usage, state->option);
 
 	state->seen_data_command = 1;
 	if (import_marks_file)
@@ -3980,9 +3985,75 @@ int cmd_fast_import(int argc,
 {
 	struct fast_import_state state;
 
-	show_usage_if_asked(argc, argv, fast_import_usage);
+	unsigned long pack_size_limit, big_file_threshold;
+	char *edges, *signed_commits, *signed_tags, *date_format;
+	char *import_marks_if_exists, *submodules_from, *submodules_to;
 
-	fast_import_state_init(&state, argc, argv, prefix);
+	/*
+	 * NEEDSWORK: For now this is used only to render
+	 * `-h`/`--help-all` usage messages. The actual parsing is
+	 * done by parse_one_option()/parse_one_feature().
+	 */
+	struct option fast_import_options[] = {
+		OPT_GROUP(N_("Common")),
+		OPT_STRING_F(0, "date-format", &date_format, N_("fmt"),
+			   N_("format of the commit/tag dates"), PARSE_OPT_NONEG),
+		OPT_BOOL_F(0, "stats", &show_stats,
+			   N_("display some basic statistics (objects, packfiles and memory)"),
+			   PARSE_OPT_NONEG),
+		OPT_BOOL_F(0, "quiet", &quiet,
+			   N_("disable the output shown by --stats"), PARSE_OPT_NONEG),
+		OPT_BOOL_F(0, "force", &force_update,
+			   N_("force updating modified existing branches"), PARSE_OPT_NONEG),
+		OPT_BOOL_F(0, "done", &require_explicit_termination,
+			   N_("require a terminating 'done' command"), PARSE_OPT_NONEG),
+		OPT_UNSIGNED(0, "max-pack-size", &pack_size_limit,
+			     N_("maximum size of each output pack file")),
+		OPT_UNSIGNED(0, "big-file-threshold", &big_file_threshold,
+			     N_("maximum size of a blob that will be deltified")),
+		OPT_UNSIGNED(0, "depth", &max_depth,
+			     N_("maximum delta depth")),
+		OPT_UNSIGNED(0, "active-branches", &max_active_branches,
+			     N_("maximum number of branches to maintain active")),
+		OPT_GROUP(N_("Marks")),
+		OPT_STRING_F(0, "import-marks", &import_marks_file, N_("file"),
+			     N_("import marks from <file>"), PARSE_OPT_NONEG),
+		OPT_STRING_F(0, "import-marks-if-exists", &import_marks_if_exists, N_("file"),
+			     N_("import marks from <file> if it exists"), PARSE_OPT_NONEG),
+		OPT_STRING_F(0, "export-marks", &export_marks_file, N_("file"),
+			     N_("dump marks to <file>"), PARSE_OPT_NONEG),
+		OPT_BOOL(0, "relative-marks", &relative_marks_paths,
+			 N_("are --(import|export)-marks= paths relative to '.git/info/fast-import'?")),
+		OPT_GROUP(N_("Submodule rewrite")),
+		OPT_STRING_F(0, "rewrite-submodules-from", &submodules_from, N_("name:filename"),
+			     N_("rewrite object IDs for submodule <name> from <filename>"),
+			     PARSE_OPT_NONEG),
+		OPT_STRING_F(0, "rewrite-submodules-to", &submodules_to, N_("name:filename"),
+			     N_("rewrite object IDs for submodule <name> to <filename>"),
+			     PARSE_OPT_NONEG),
+		OPT_GROUP(N_("Signing")),
+		OPT_STRING_F(0, "signed-commits", &signed_commits, N_("mode"),
+			     N_("how to handle signed commits"),
+			     PARSE_OPT_NONEG),
+		OPT_STRING_F(0, "signed-tags", &signed_tags, N_("mode"),
+			     N_("how to handle signed tags"),
+			     PARSE_OPT_NONEG),
+		OPT_HIDDEN_GROUP(N_("Advanced")),
+		OPT_BOOL_F(0, "allow-unsafe-features", &state.allow_unsafe_features,
+			   N_("allow unsafe mark commands from the stream"),
+			   PARSE_OPT_HIDDEN | PARSE_OPT_NONEG),
+		OPT_STRING_F(0, "export-pack-edges", &edges, N_("file"),
+			     N_("dump edge commits to <file>"),
+			     PARSE_OPT_HIDDEN | PARSE_OPT_NONEG),
+		OPT_INTEGER_F(0, "cat-blob-fd", &cat_blob_fd,
+			    N_("write some responses to <fd> instead of stdout"),
+			      PARSE_OPT_HIDDEN | PARSE_OPT_NONEG),
+		OPT_END()
+	};
+
+	show_usage_with_options_if_asked(argc, argv, fast_import_usage, fast_import_options);
+
+	fast_import_state_init(&state, argc, argv, prefix, fast_import_options);
 
 	reset_pack_idx_option(&pack_idx_opts);
 	git_pack_config();
diff --git a/t/t0450/adoc-help-mismatches b/t/t0450/adoc-help-mismatches
index c4a55ff4e3..baf3b1d809 100644
--- a/t/t0450/adoc-help-mismatches
+++ b/t/t0450/adoc-help-mismatches
@@ -12,7 +12,6 @@ column
 credential
 credential-cache
 credential-store
-fast-import
 fetch-pack
 fmt-merge-msg
 format-patch
-- 
2.55.0.492.g44bba30fd7.dirty

