Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E73E2580EE
	for <git@vger.kernel.org>; Fri, 12 Dec 2025 15:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765552534; cv=none; b=pD6eUezgUhclB2D2o6hCglQkyZ0JZ1w0DLhoNyIi6dggsKFJYnajknO0mU8e8Q4dHHBEfXFiSh86E3InCDQ38P6wqt8i/e/zmk/BBCzMnLlWmA6z6+Oac21MxFTDGVdlcwYSJfQninJuYxrQvU26ZtarqKkR3PgkhKfGHKtghs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765552534; c=relaxed/simple;
	bh=UrjtDdIAdUla8MpnFW+cN7qhFw3RA3md0ZZZH/g1Lm4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=cEYDwD0vgCz6HNULNxCuNho7MCkQ/JpaFQ2HwGzwsPxk3oUnOgKmdGzbDCAEyEuetF8C4ErqSWXkvZXfsRsa+XqedM8C06vo+yk8war97OhJau/WKTAlzYSNU33S8WccV7CGm3WD7jvUPpZoObtDIFRhDB0TtqwcyLlgCEpOlaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0IG/WyL; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0IG/WyL"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7bb710d1d1dso1816505b3a.1
        for <git@vger.kernel.org>; Fri, 12 Dec 2025 07:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765552532; x=1766157332; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qKegBShAPoHnYsRBIHKLX32o9FVxE+P6G7+/pdhLSHo=;
        b=O0IG/WyLCgoA5xupaokhvRWbCC13fS1fKUxu8zsT+JtIOBplT8BTrYdtTmUStGtyr0
         GaEY5E4RZrhwgAiPtJnOOayOU3DJpjpGB43GZPB/bZBPmEvWE3xC3PLjHZ0QiQaSEE+6
         62qyvATOpSKH9UhYTgQBHnWwGCgL3Q6SWNmSkzqmHoVrkmr98iw2Rr8txp754MN3gRPs
         eVJeiRGqAPHKnmDG1JdagIjSy3H0wzymtzUpHYACKgA/kQQSAMrdYG6j/knXFUN0qncG
         DvPAZrh9ZkzrbhGrPsdHL/T7ff2qP8MjOL80BWdk35AWqrHYhYX07RPKQ5IBfw0U90Ox
         xkug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765552532; x=1766157332;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qKegBShAPoHnYsRBIHKLX32o9FVxE+P6G7+/pdhLSHo=;
        b=V9HOvX6SkkqnAAnpMOZl7ZlkJhowaeflVzcLpbgfy0qbGCpp0JgOG83Yfa+9HQEXuf
         d3rzZmsZni7pTFEzlOTbKi79Buyt0sq/MMt7bjhto7YG1QaprqBsod1LG8RuDWX2TGIp
         35i3ZpuQajFrv7qsCfh5DGAY3YIR8XO9nbAxPi2BInrsFu12JwgncqiFoHbGcFGbAFyx
         31cPKuY9Z6NxjJzBIFfpUkPKp9BjKPWwMsC7s01+PBtRsYM072dRH/BvJVAMhAofCHcl
         hmpi+GO1ZYhMEi4VsUp8c3Ye5BtTouLweGriiJgr/6QJ4VNZCFiyJf8omZJorvi+t0Hi
         +TBQ==
X-Gm-Message-State: AOJu0Yy/gQdsTf74S9HqorRQgITx3bYb9Y65uQ/4s+ZAhd3ufU8gQuGR
	lNJt29xf07ayGJo56W17gApW6a82/4w8st7Ztt77ggMGlxLBzIjhXUIiGululw==
X-Gm-Gg: AY/fxX5t5dXty2sUc8uQglOQ3lKbO8zK4M8fk+jI7STvVSqW2l9OT4CjWEkIcEPypx4
	9Akzr3b6P/+lmwycAglCgkIDhYzhOVL/YdhuzJMvdQ6AHpNA813IV4nV8QvV0C7KH/dfSJCN8IW
	TdMonC+5/zJhvzsfEo5OElslyNpFsSL6pClHCQONoFPq4pQeoANOZIWuJ4Wwd2u4FC4gmnOU3KP
	YFH6CNX3kq99wbTZK8eBwaUhmKJ4cKGtBEFJg0a8Hgscfyz9JndJhejfXiJAQ/Bat2ZxJ3RwxrW
	3zenIS5fj11hZDqFAQDDOQjdfzewttcJ4eweVRI3mmK74tC+4oB19DM5ms9xC9Mouc1EfRuazYn
	Dp7/dsGCOTCshR9fwj6UcKP6XtE3vnvp1ypOsE/ClegcmgpTKWBr+ZpAQe+unyHJbGWj9damPgn
	c27S5GHJNTN98xWirGopV3FUke
X-Google-Smtp-Source: AGHT+IHfOSaP+pfaUM3CR1q1+B7a24M4CXs5qbZw5Gjk1PVg6nHETCwD5USpNBWcF8QuhkJpmySY8Q==
X-Received: by 2002:a05:7022:f509:b0:119:e56b:c752 with SMTP id a92af1059eb24-11f34c2600bmr1373781c88.23.1765552531819;
        Fri, 12 Dec 2025 07:15:31 -0800 (PST)
Received: from [127.0.0.1] ([172.182.212.53])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f2e1bb2f4sm17984814c88.3.2025.12.12.07.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 07:15:31 -0800 (PST)
Message-Id: <7a2f919d7c610ce7c9e93682884212ebee34d9b5.1765552528.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2010.v3.git.1765552528.gitgitgadget@gmail.com>
References: <pull.2010.v2.git.1764607847.gitgitgadget@gmail.com>
	<pull.2010.v3.git.1765552528.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 12 Dec 2025 15:15:24 +0000
Subject: [PATCH v3 1/5] scalar: annotate config file with "set by scalar"
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
    ps@pks.im,
    atthewhughes934@gmail.com,
    johannes.schindelin@gmx.de,
    Matthew Hughes <matthewhughes934@gmail.com>,
    Henrique Ferreiro <hferreiro@igalia.com>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

A repo may have config options set by 'scalar clone' or 'scalar
register' and then updated by 'scalar reconfigure'. It can be helpful to
point out which of those options were set by the latest scalar
recommendations.

Add "# set by scalar" to the end of each config option to assist users
in identifying why these config options were set in their repo. Use a new
helper method to simplify the two callsites.

Co-authored-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 scalar.c          | 24 +++++++++++++++++-------
 t/t9210-scalar.sh |  3 +++
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/scalar.c b/scalar.c
index f754311627..1c7bd1a8f8 100644
--- a/scalar.c
+++ b/scalar.c
@@ -19,6 +19,7 @@
 #include "help.h"
 #include "setup.h"
 #include "trace2.h"
+#include "path.h"
 
 static void setup_enlistment_directory(int argc, const char **argv,
 				       const char * const *usagestr,
@@ -95,7 +96,17 @@ struct scalar_config {
 	int overwrite_on_reconfigure;
 };
 
-static int set_scalar_config(const struct scalar_config *config, int reconfigure)
+static int set_scalar_config(const char *key, const char *value)
+{
+	char *file = repo_git_path(the_repository, "config");
+	int res = repo_config_set_multivar_in_file_gently(the_repository, file,
+							  key, value, NULL,
+							  " # set by scalar", 0);
+	free(file);
+	return res;
+}
+
+static int set_config_if_missing(const struct scalar_config *config, int reconfigure)
 {
 	char *value = NULL;
 	int res;
@@ -103,7 +114,7 @@ static int set_scalar_config(const struct scalar_config *config, int reconfigure
 	if ((reconfigure && config->overwrite_on_reconfigure) ||
 	    repo_config_get_string(the_repository, config->key, &value)) {
 		trace2_data_string("scalar", the_repository, config->key, "created");
-		res = repo_config_set_gently(the_repository, config->key, config->value);
+		res = set_scalar_config(config->key, config->value);
 	} else {
 		trace2_data_string("scalar", the_repository, config->key, "exists");
 		res = 0;
@@ -178,14 +189,14 @@ static int set_recommended_config(int reconfigure)
 	char *value;
 
 	for (i = 0; config[i].key; i++) {
-		if (set_scalar_config(config + i, reconfigure))
+		if (set_config_if_missing(config + i, reconfigure))
 			return error(_("could not configure %s=%s"),
 				     config[i].key, config[i].value);
 	}
 
 	if (have_fsmonitor_support()) {
 		struct scalar_config fsmonitor = { "core.fsmonitor", "true" };
-		if (set_scalar_config(&fsmonitor, reconfigure))
+		if (set_config_if_missing(&fsmonitor, reconfigure))
 			return error(_("could not configure %s=%s"),
 				     fsmonitor.key, fsmonitor.value);
 	}
@@ -197,9 +208,8 @@ static int set_recommended_config(int reconfigure)
 	if (repo_config_get_string(the_repository, "log.excludeDecoration", &value)) {
 		trace2_data_string("scalar", the_repository,
 				   "log.excludeDecoration", "created");
-		if (repo_config_set_multivar_gently(the_repository, "log.excludeDecoration",
-						    "refs/prefetch/*",
-						    CONFIG_REGEX_NONE, 0))
+		if (set_scalar_config("log.excludeDecoration",
+					    "refs/prefetch/*"))
 			return error(_("could not configure "
 				       "log.excludeDecoration"));
 	} else {
diff --git a/t/t9210-scalar.sh b/t/t9210-scalar.sh
index bd6f0c40d2..43c210a23d 100755
--- a/t/t9210-scalar.sh
+++ b/t/t9210-scalar.sh
@@ -210,6 +210,9 @@ test_expect_success 'scalar reconfigure' '
 	GIT_TRACE2_EVENT="$(pwd)/reconfigure" scalar reconfigure -a &&
 	test_path_is_file one/src/cron.txt &&
 	test true = "$(git -C one/src config core.preloadIndex)" &&
+	test_grep "preloadIndex = true # set by scalar" one/src/.git/config &&
+	test_grep "excludeDecoration = refs/prefetch/\* # set by scalar" one/src/.git/config &&
+
 	test_subcommand git maintenance start <reconfigure &&
 	test_subcommand ! git maintenance unregister --force <reconfigure &&
 
-- 
gitgitgadget

