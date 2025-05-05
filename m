Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF9B19067C
	for <git@vger.kernel.org>; Mon,  5 May 2025 15:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746458852; cv=none; b=AFBr6bxPv9k2EMTXa70cnDx0mSO5y4Q46bTo4+espoEZAuLcqkzOkWtcqfGEgEaDfJRPMNZpcTEftVWVDD3ezyhrlb7jOqax2QcQl9BS1rlt7R9i/gAwUJoNrYanoaB46OWftDPiYRZCjJPqyzd3Mw3+AIiEERz5r8JeR9Slrfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746458852; c=relaxed/simple;
	bh=6ZnmN18q3Y1mvbjPP8HF5PqB0HljVXgprM8m7u4Tj/w=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CbB1fj3/qyTKgd5Vnzky1p9QbX7FvrEfDlVfqekdSXO6wjNmUglfOmb4CRQrj2ujFb4oAwu7lz9NZRGqTHnICLil+8Ial5GbMeNPiPIbzPdCYaxJpE3Qzh20S5YwPXbCzVuUI0NH00mWzSwFMgmQY4Oht8WGg36kGfdhsvBrOvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BliCV0Xd; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BliCV0Xd"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cf628cb14so39013315e9.1
        for <git@vger.kernel.org>; Mon, 05 May 2025 08:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746458848; x=1747063648; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fwqk2iQYeNDakTWQy9JkdYTlz5c+hwsuldRW0e+Mlz4=;
        b=BliCV0XduZl5j6ot/TdGWYwyrNz1zUqOmX8p9W1HkGlZFeB+o0M55Y0gzEadjc9Zk6
         k2ReMGeHGmxhjyQWrkqRC+cVHhtgqFun29Nh5AE/b2arAoCGx0SM1U40shFmxctp1NMT
         ERI+6X6RAtT0oft+9EhfEGwiYUvbbLy+XJV5579BHS1a569q+mT7epF37fxw9xdpOVON
         Pz89DQApNZci8v9T3m/MIMj4PC3unzFzevQvU83UAMcwObLD25eBgytCVgqhWT456JLJ
         1ELF6Z7ZcaXAqIWb87lVNpGkrNQqXlVSq316P7W1dYD+1vrk2t6U23kjAqTcLgGwZG/n
         2raQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746458848; x=1747063648;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fwqk2iQYeNDakTWQy9JkdYTlz5c+hwsuldRW0e+Mlz4=;
        b=dVh4aC/yhgGK1jsfCQI/0o/9+0vfkA9/Lf5kGn/PexGt5Yp0JP3Y7WT9PYRJKDris3
         359oRt4WcV3k+/p3Q514u3IEWjWa5IZ2jL9RP3M0eSEgE9GrftGwNGFsBtJCtKoyd1U7
         1N9NTkiZcXcd5bcHHJPKoW2w/jV4zlINJuO7xtHG7HQkdOroagidTXoAXWsF53f8pomj
         mN0bM2vMcJkTC55z+Yzov+x4NmPVdNOJA8PdAYZPir04/ziSl/Oipuz7GS2o0JAFLnUl
         JdhKEUEAfhILw6nmqvtogOpLy/gR4sTvDPYgfKEOU2n9PDDo4yOV4lqXYpXNJjPZ8HME
         KEow==
X-Gm-Message-State: AOJu0YzOgN/hVz+B5KKCON9707hKHYD+dVo2YzF4P5arrK++cdW3oSo3
	yUard+que+aVZzed6jJ3FZXzGGD2Iv4ye5T7OeR7yrgn3UKGbaLOnr3ffA==
X-Gm-Gg: ASbGnctBSr9gZCy4Wk8BeFZTZXex2Rgg3OyzgsJmBChs4kSPp8efUlgOv1W17SAmbuO
	XH/iZ3RJZ2kf9Fpyas5KpIr3ysysiXwtLLkSqs3rmZ1+j3w5GnKJ3wnjzaw8aNTAreDgCaRLvrr
	99rnxgq6LJyXg4eYlKKRBL2p0QiFwD93JGaAq/MU/rpzxmiEXpJt4qDiU6V1+YTJKMfRBBF6aB7
	Iuk/ugBU86piqfUJVLj57hUQeWeZrbjYunBH4b3GJUmsPrOoyWWSJ7ybTD2lse9dnzDR7FQDAWj
	02ZDgUdQ69e1CABIa1pGmNWCN3turnmg5gYNapU36a0j5Eb6kg67
X-Google-Smtp-Source: AGHT+IGjVikTGsu9lhFfx+47XzwKSBpvW8MLqgKfwFrHylHyfe+zKO86qcAz6j88DzXH0pGMuiDJ5Q==
X-Received: by 2002:a05:600c:28d:b0:440:69f5:f179 with SMTP id 5b1f17b1804b1-441b72be411mr122929585e9.7.1746458848006;
        Mon, 05 May 2025 08:27:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b89cc50esm140294835e9.8.2025.05.05.08.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 08:27:27 -0700 (PDT)
Message-Id: <e52b1282d93b795d077f169573487dca06b83bbe.1746458844.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1913.v2.git.1746458844.gitgitgadget@gmail.com>
References: <pull.1913.git.1746008680.gitgitgadget@gmail.com>
	<pull.1913.v2.git.1746458844.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 05 May 2025 15:27:23 +0000
Subject: [PATCH v2 3/4] scalar clone: add --no-maintenance option
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
Cc: gitster@pobox.com,
    johannes.schindelin@gmx.de,
    Patrick Steinhardt <ps@pks.im>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

When creating a new enlistment via 'scalar clone', the default is to set
up situations that work for most user scenarios. Background maintenance
is one of those highly-recommended options for most users.

However, when using 'scalar clone' to create an enlistment in a
different situation, such as prepping a VM image, it may be valuable to
disable background maintenance so the manual maintenance steps do not
get blocked by concurrent background maintenance activities.

Add a new --no-maintenance option to 'scalar clone'.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/scalar.adoc |  7 ++++++-
 scalar.c                  |  9 ++++++---
 t/t9211-scalar-clone.sh   | 11 ++++++++++-
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/Documentation/scalar.adoc b/Documentation/scalar.adoc
index b2b244a86499..7753df3b4352 100644
--- a/Documentation/scalar.adoc
+++ b/Documentation/scalar.adoc
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 scalar clone [--single-branch] [--branch <main-branch>] [--full-clone]
-	[--[no-]src] <url> [<enlistment>]
+	[--[no-]src] [--[no-]tags] [--[no-]maintenance] <url> [<enlistment>]
 scalar list
 scalar register [--[no-]maintenance] [<enlistment>]
 scalar unregister [<enlistment>]
@@ -97,6 +97,11 @@ cloning. If the HEAD at the remote did not point at any branch when
 	A sparse-checkout is initialized by default. This behavior can be
 	turned off via `--full-clone`.
 
+--[no-]maintenance::
+	By default, `scalar clone` configures the enlistment to use Git's
+	background maintenance feature. Use the `--no-maintenance` to skip
+	this configuration.
+
 List
 ~~~~
 
diff --git a/scalar.c b/scalar.c
index da0c46bc96cc..dd6e1447e086 100644
--- a/scalar.c
+++ b/scalar.c
@@ -426,7 +426,7 @@ static int cmd_clone(int argc, const char **argv)
 	const char *branch = NULL;
 	char *branch_to_free = NULL;
 	int full_clone = 0, single_branch = 0, show_progress = isatty(2);
-	int src = 1, tags = 1;
+	int src = 1, tags = 1, maintenance = 1;
 	struct option clone_options[] = {
 		OPT_STRING('b', "branch", &branch, N_("<branch>"),
 			   N_("branch to checkout after clone")),
@@ -439,11 +439,13 @@ static int cmd_clone(int argc, const char **argv)
 			 N_("create repository within 'src' directory")),
 		OPT_BOOL(0, "tags", &tags,
 			 N_("specify if tags should be fetched during clone")),
+		OPT_BOOL(0, "maintenance", &maintenance,
+			 N_("specify if background maintenance should be enabled")),
 		OPT_END(),
 	};
 	const char * const clone_usage[] = {
 		N_("scalar clone [--single-branch] [--branch <main-branch>] [--full-clone]\n"
-		   "\t[--[no-]src] [--[no-]tags] <url> [<enlistment>]"),
+		   "\t[--[no-]src] [--[no-]tags] [--[no-]maintenance] <url> [<enlistment>]"),
 		NULL
 	};
 	const char *url;
@@ -565,7 +567,8 @@ static int cmd_clone(int argc, const char **argv)
 	if (res)
 		goto cleanup;
 
-	res = register_dir(1);
+	/* If --no-maintenance, then skip maintenance command entirely. */
+	res = register_dir(maintenance);
 
 cleanup:
 	free(branch_to_free);
diff --git a/t/t9211-scalar-clone.sh b/t/t9211-scalar-clone.sh
index 01f71910f533..bfbf22a46218 100755
--- a/t/t9211-scalar-clone.sh
+++ b/t/t9211-scalar-clone.sh
@@ -177,7 +177,16 @@ test_expect_success 'progress without tty' '
 test_expect_success 'scalar clone warns when background maintenance fails' '
 	GIT_TEST_MAINT_SCHEDULER="crontab:false,launchctl:false,schtasks:false" \
 		scalar clone "file://$(pwd)/to-clone" maint-fail 2>err &&
-	grep "could not turn on maintenance" err
+	grep "could not toggle maintenance" err
+'
+
+test_expect_success 'scalar clone --no-maintenance' '
+	GIT_TEST_MAINT_SCHEDULER="crontab:false,launchctl:false,schtasks:false" \
+	GIT_TRACE2_EVENT="$(pwd)/no-maint.event" \
+	GIT_TRACE2_EVENT_DEPTH=100 \
+		scalar clone --no-maintenance "file://$(pwd)/to-clone" no-maint 2>err &&
+	! grep "could not toggle maintenance" err &&
+	test_subcommand ! git maintenance unregister --force <no-maint.event
 '
 
 test_expect_success '`scalar clone --no-src`' '
-- 
gitgitgadget

