Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1775327A44E
	for <git@vger.kernel.org>; Fri, 16 May 2025 18:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747419152; cv=none; b=NwsCKQJ1CUMKl+gXl59yQz5LaSdhY9WgNPAXClaBoQoKref8iK+KNSxsfc02TxooPpRD10E4eFfAhjfgeVsPQENHaCIw2RxfJtt8EIiDdoYz1/hIJZnv3xYjH+vNl+mnHzeqP7TZqGFMdILbyXCPoMo+XI1nbXD7sF19t6BT4ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747419152; c=relaxed/simple;
	bh=HrRbglbw4z7mqG0ill5qd7FSnyB1/K4up1AIrw2+wKM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=E641kUvylbphRcoR7SxKDoOLbZP++B87cEIcD1PNP+wbsQIbVVM9zmCbqONZ3F8ywVTBfKS8BthJBsVfksf50a+DK2wl3w++GFRHIhIpdBEaSvnc0QWDx1Gp09SdgSIOz+ZFHMEhDkUvnwFKdM8FmYwylhc7wEbPmozwr4ogkLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkdOMEFz; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkdOMEFz"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a363d15c64so375429f8f.3
        for <git@vger.kernel.org>; Fri, 16 May 2025 11:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747419148; x=1748023948; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCVt59wqTizhEjqN9CGd/aBsDvypmlAsO7O/nWNVYHE=;
        b=dkdOMEFzLjQQ6DHbJabFaTWTD6vAXDNngEA17uZr7oQjwNxBXm9bEr1OKdK7jzhfcG
         isa7m8QyXXvHKIEK7RabcKU2EhnJHRVdYA2SGSevyME9vNVE90D/A0NKKi/4mw4Oncni
         E5R9yyoI69eHP05NhuFsVgxUAiB6YGpaJ/VJlg3FwbOknGO+K8EpOlFuSrx5if3BNWLW
         YiUTgy5ZR+hYAKNgVqWAJFu/GOtepCOIGeBtK2uEpkQYIvuCm9CasDISR1tLYl52r4ZM
         9F1kk3XrFZ18Q/w8auOjYvvWiH7HPgYQDyZRF0gRde+OrzbWmxMuXi7Wh8SpbR2f4rbz
         IR8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747419148; x=1748023948;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mCVt59wqTizhEjqN9CGd/aBsDvypmlAsO7O/nWNVYHE=;
        b=b2IT62YPh7TM8iaYUBl6eLX7GGmSsuXRGfkAhllm+yWrsJawMqZvfeMsCjP7+ul5nA
         daZFQTydRy6JQT0UOSAqRLKJsiSP4GQVHU9J0aCrtRSc9kfg/Q2hdqYexcg7Aqe7NF6G
         WPSTC8EGdF2Dh9vIDw1LpG/EAt9Ya6IRm+7wrW9EO/4NSF9HmEaAal4gUb5Gi4IahoPz
         vHIplf4BrZ6FWsV6p7IQn3rb7wh7sN2hc95uI2/XQTlqnVY9pM9PYtWQmO9i7/D2rLJ+
         VT0emNHQIgR8aw3fBFbp76T4UDcoHbXkFOdgOyEUenMO1frZlBZ80XRPDuTVWE/RBZZM
         TAPA==
X-Gm-Message-State: AOJu0YyWPjIQV0riOVF9bztmNX8CBTqMSQP+7OrBAqEmfIrjFeogiE15
	sNFL71MYILijx38xwlbKDphY678krUmFaVs4vuyL9ijyF+lBX4k36e3GeIcEOg==
X-Gm-Gg: ASbGncvn1zWBMa1E05ICVyIfUWA8LebQniRKRbcFLmNJuwsb5X24halQgTFL2wA2jt5
	MByG0z/V3Tp3L/DqlVUcMQgWUf6Xu4AvSrq/U5zFV1eDNW395vGWezN3ZFs+xlSRe4lMpwfEK1r
	cT3SuUVQE1gNEV8vPaLu+eElQqztWv91/J3DDJ10TkMo3is5sxHVBV+Ozy6AXJM3iue0RUaH9CQ
	UcB7/DUADAFyUH9h2iytFjHeB0WL9xNGipNR+HnGJkaQDxtpqe48VmEEccfy0V8K37uxydkt3K0
	RcTw4pL02dXgy4n1z7IVaYf1szuSU8kGpqLGQZgYiIxo1mWNEwNa
X-Google-Smtp-Source: AGHT+IHMQ4ancRnR8Ky+uAtXcihhvgpU4z6kI9OtSs3oTnHqnOofMWKZQxdIEm3w7gGKPH99InjOAQ==
X-Received: by 2002:a05:6000:2012:b0:3a3:5b88:fb2a with SMTP id ffacd0b85a97d-3a35c808a9cmr4789284f8f.7.1747419147929;
        Fri, 16 May 2025 11:12:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca62204sm3535494f8f.42.2025.05.16.11.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 11:12:27 -0700 (PDT)
Message-Id: <7f9e6a077bc43aae55b2eb9ae5b4b10385cef11f.1747419124.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1819.v3.git.1747419124.gitgitgadget@gmail.com>
References: <pull.1819.v2.git.1742829769.gitgitgadget@gmail.com>
	<pull.1819.v3.git.1747419124.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 16 May 2025 18:11:57 +0000
Subject: [PATCH v3 07/13] repack: add --path-walk option
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
    gitster@pobox.com,
    johannes.schindelin@gmx.de,
    johncai86@gmail.com,
    jonathantanmy@google.com,
    karthik.188@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    me@ttaylorr.com,
    newren@gmail.com,
    peff@peff.net,
    ps@pks.im,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Since 'git pack-objects' supports a --path-walk option, allow passing it
through in 'git repack'. This presents interesting testing opportunities for
comparing the different repacking strategies against each other.

Add the --path-walk option to the performance tests in p5313.

For the microsoft/fluentui repo [1] checked out at a specific commit [2],
the --path-walk tests in p5313 look like this:

Test                                                     this tree
-------------------------------------------------------------------------
5313.18: thin pack with --path-walk                      0.08(0.06+0.02)
5313.19: thin pack size with --path-walk                           18.4K
5313.20: big pack with --path-walk                       2.10(7.80+0.26)
5313.21: big pack size with --path-walk                            19.8M
5313.22: shallow fetch pack with --path-walk             1.62(3.38+0.17)
5313.23: shallow pack size with --path-walk                        33.6M
5313.24: repack with --path-walk                         81.29(96.08+0.71)
5313.25: repack size with --path-walk                             142.5M

[1] https://github.com/microsoft/fluentui
[2] e70848ebac1cd720875bccaa3026f4a9ed700e08

Along with the earlier tests in p5313, I'll instead reformat the
comparison as follows:

Repack Method    Pack Size       Time
---------------------------------------
Hash v1             439.4M      87.24s
Hash v2             161.7M      21.51s
Path Walk           142.5M      81.29s

There are a few things to notice here:

 1. The benefits of --name-hash-version=2 over --name-hash-version=1 are
    significant, but --path-walk still compresses better than that
    option.

 2. The --path-walk command is still using --name-hash-version=1 for the
    second pass of delta computation, using the increased name hash
    collisions as a potential method for opportunistic compression on
    top of the path-focused compression.

 3. The --path-walk algorithm is currently sequential and does not use
    multiple threads for delta compression. Threading will be
    implemented in a future change so the computation time will improve
    to better compete in this metric.

There are small benefits in size for my copy of the Git repository:

Repack Method    Pack Size       Time
---------------------------------------
Hash v1             248.8M      30.44s
Hash v2             249.0M      30.15s
Path Walk           213.2M     142.50s

As well as in the nodejs/node repository [3]:

Repack Method    Pack Size       Time
---------------------------------------
Hash v1             739.9M      71.18s
Hash v2             764.6M      67.82s
Path Walk           698.1M     208.10s

[3] https://github.com/nodejs/node

This benefit also repeats in my copy of the Linux kernel repository:

Repack Method    Pack Size       Time
---------------------------------------
Hash v1               2.5G     554.41s
Hash v2               2.5G     549.62s
Path Walk             2.2G    1562.36s

It is important to see that even when the repository shape does not have
many name-hash collisions, there is a slight space boost to be found
using this method.

As this repacking strategy was released in Git for Windows 2.47.0, some
users have reported cases where the --path-walk compression is slightly
worse than the --name-hash-version=2 option. In those cases, it may be
beneficial to combine the two options. However, there has not been a
released version of Git that has both options and I don't have access to
these repos for testing.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/git-repack.adoc |  5 ++++-
 builtin/repack.c              |  7 ++++++-
 t/perf/p5313-pack-objects.sh  | 18 ++++++++----------
 3 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-repack.adoc b/Documentation/git-repack.adoc
index 5852a5c97368..aa1bc081e50a 100644
--- a/Documentation/git-repack.adoc
+++ b/Documentation/git-repack.adoc
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git repack' [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m]
 	[--window=<n>] [--depth=<n>] [--threads=<n>] [--keep-pack=<pack-name>]
-	[--write-midx] [--name-hash-version=<n>]
+	[--write-midx] [--name-hash-version=<n>] [--path-walk]
 
 DESCRIPTION
 -----------
@@ -255,6 +255,9 @@ linkgit:git-multi-pack-index[1]).
 	Provide this argument to the underlying `git pack-objects` process.
 	See linkgit:git-pack-objects[1] for full details.
 
+--path-walk::
+	Pass the `--path-walk` option to the underlying `git pack-objects`
+	process. See linkgit:git-pack-objects[1] for full details.
 
 CONFIGURATION
 -------------
diff --git a/builtin/repack.c b/builtin/repack.c
index 75e3752353a2..d7f798280c0e 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -43,7 +43,7 @@ static char *packdir, *packtmp_name, *packtmp;
 static const char *const git_repack_usage[] = {
 	N_("git repack [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m]\n"
 	   "[--window=<n>] [--depth=<n>] [--threads=<n>] [--keep-pack=<pack-name>]\n"
-	   "[--write-midx] [--name-hash-version=<n>]"),
+	   "[--write-midx] [--name-hash-version=<n>] [--path-walk]"),
 	NULL
 };
 
@@ -63,6 +63,7 @@ struct pack_objects_args {
 	int quiet;
 	int local;
 	int name_hash_version;
+	int path_walk;
 	struct list_objects_filter_options filter_options;
 };
 
@@ -313,6 +314,8 @@ static void prepare_pack_objects(struct child_process *cmd,
 		strvec_pushf(&cmd->args, "--no-reuse-object");
 	if (args->name_hash_version)
 		strvec_pushf(&cmd->args, "--name-hash-version=%d", args->name_hash_version);
+	if (args->path_walk)
+		strvec_pushf(&cmd->args, "--path-walk");
 	if (args->local)
 		strvec_push(&cmd->args,  "--local");
 	if (args->quiet)
@@ -1212,6 +1215,8 @@ int cmd_repack(int argc,
 				N_("pass --no-reuse-object to git-pack-objects")),
 		OPT_INTEGER(0, "name-hash-version", &po_args.name_hash_version,
 				N_("specify the name hash version to use for grouping similar objects by path")),
+		OPT_BOOL(0, "path-walk", &po_args.path_walk,
+				N_("pass --path-walk to git-pack-objects")),
 		OPT_NEGBIT('n', NULL, &run_update_server_info,
 				N_("do not run git-update-server-info"), 1),
 		OPT__QUIET(&po_args.quiet, N_("be quiet")),
diff --git a/t/perf/p5313-pack-objects.sh b/t/perf/p5313-pack-objects.sh
index cd6dd3abb710..98748b0e203a 100755
--- a/t/perf/p5313-pack-objects.sh
+++ b/t/perf/p5313-pack-objects.sh
@@ -55,23 +55,21 @@ test_all_with_args () {
 	test_size "shallow pack size with $parameter" '
 		test_file_size out
 	'
-}
-
-for version in 1 2
-do
-	export version
-
-	test_all_with_args --name-hash-version=$version
 
-	test_perf "repack with --name-hash-version=$version" '
-		git repack -adf --name-hash-version=$version
+	test_perf "repack with $parameter" '
+		git repack -adf $parameter
 	'
 
-	test_size "repack size with --name-hash-version=$version" '
+	test_size "repack size with $parameter" '
 		gitdir=$(git rev-parse --git-dir) &&
 		pack=$(ls $gitdir/objects/pack/pack-*.pack) &&
 		test_file_size "$pack"
 	'
+}
+
+for version in 1 2
+do
+	test_all_with_args --name-hash-version=$version
 done
 
 test_all_with_args --path-walk
-- 
gitgitgadget

