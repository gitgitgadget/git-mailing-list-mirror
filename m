Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBCC2DAFB9
	for <git@vger.kernel.org>; Wed, 26 Nov 2025 22:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764195526; cv=none; b=WsSeeaazRDmtv36XfXd4dqglRQa8YfqutHtBc7hKU4CBqUe/AG4S5XClyJkZQ1m600kwl67kJ/dtt+8T4UMco23uJVdWuXTN4gftlpiju2zTeAFvG2j2daOy6UQUiv9CS+52qEPuBD5tPJd9ZfFtqVxz5cWf+43ZTTOIcxBS3xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764195526; c=relaxed/simple;
	bh=Qdi7rHF96C1P51l10oMG9d21rcXJGzpRG/BWVXUrqJU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=DU+lw8V+H4XwbbdkzLviDzJFxmwtHSNpN/LSVZXK/PtH4+0wjhjce++l2vt7uROvzJu0thP5phw3OtNMkNbFsmELs0+1IcneyGxCLYHeNNBxyFWfH9uxyzK5uKE+a5lGwILJst1ZqPiVLVv6avq3XEkZJuIHReXZg2G1oSw3Itk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mov1/pY2; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mov1/pY2"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8b25ed53fcbso31170685a.0
        for <git@vger.kernel.org>; Wed, 26 Nov 2025 14:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764195523; x=1764800323; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bs02IhbFpjiAAnUh0i9MnUWNRPCC+qiyFbkcnVhHq1o=;
        b=mov1/pY2WDBpANY2MQTxSxvFtbPt94fTavlQ3kvKEE5PZ8XdptCGeX/jbhu0M/nZ66
         xjA1IfqIu3X6g2/Cm0EXun3ESqQqXbed2QnnBBjobTcxil4SH73wSNjtHtvkv05YEB9t
         H85PL1PcLXivIku27JpjfyGkBVv15m6jF1Bbngs5KmC87AkSuQLnKNjaaafl+DxnKmRp
         Hwcnbuz6YuKBEEhpx8kClh1cjzabDZa1siITvjn/tnmPe61dWbVZJl6GcSXWOsGrvuug
         slg6PoJ6ebgfpcJwjK1WykW2pt8UuH4Un+ky40YIHyTh0utqh29szN8ONDTMyJX8pYvW
         5T+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764195523; x=1764800323;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bs02IhbFpjiAAnUh0i9MnUWNRPCC+qiyFbkcnVhHq1o=;
        b=qPPTT+LAnEHAyw2mZP2W6egqvFTtrmOcwT2a9Se3aGM2m25Goh7RPjRjR2Tex0BoS1
         S3T1ObjA3vBT2HQbIhVWxNtag1QDuNxRj16l3tfKzIuzDmu8vPJMTW6G/GBDI+TbmunG
         K7N7LReq9m9NPfUk0yhooTrV6V9eUXrA5m4pNlvgCVJZbipMPS2c38NJ1pZwbNbTPGD+
         yuPo8sR1wxQWpgsSxzQBFcAHIeUNctzD6y+ClrDc3Su+Yn+xzcgLMQXsloNard/MRsPQ
         PLXJ8SEXh5olgTcFXQxkp6CON60QDatT5DzM1or9MUzFtnMXUi7RdNZ/RLTZRrQLrrkO
         e5ag==
X-Gm-Message-State: AOJu0YxcZXRjeLGl752JFlA1SR5rnuB1FiRnEdV8JR5CO0hlhxlR9ktJ
	zjQd+ZuQ4VGBDyd+Hb/94TOGrdWJFSJ29DcQG5ERvoF+Z7YnoCrgHgj36uWbLPjF
X-Gm-Gg: ASbGncsbW31WWZdekD3v8N3e2Enz10Zt6cLKdDpzvuGwmlejnS2XjxAgfFZkAfP6ntM
	Lb8gzyJSiymEP+VSmCo+PVACeSMqDLUeaGhA3nurGdnv8vNu8TvopY3O6sKhoI3x2faxbBly1QU
	RSj8T66YtZcJA+wwamkbuxnhanq9IvnM+nICGJQLYo4IIxXKTLdxTnrDMkuE5K2PZhekpGY78ZN
	wQP7Q3ykJ+480coHfoGIpZT2tSzbjvWYIHPYy1UHQwCWXqtreSnikIsVl5ltuSU3QG56Y1tHRc8
	VgKz4g3I/nVKxgSZVZXFNIJqXt9UvTP5LVDR+z+V08OtuxBVz/YMJEh05DuQhDZzSIEAn55UZBK
	mqPxaaMI7FcCfUui5nb7lHwWmeEL1KQmxFH1hz9AQ/b2gmwR3mszI0Ox+Yd7ZGiQzmxaHJp6BsJ
	s+ypkSgC/m3NCdKNQTjSNmwg==
X-Google-Smtp-Source: AGHT+IHRYS/k+m0XEV44NU3CPeZSDEkLuQ8fl3mdpVrA+pxakMe2iQwtgnA8TSrE+LUe3Cqo6BS22Q==
X-Received: by 2002:a05:620a:460d:b0:8b0:f8c4:a5fe with SMTP id af79cd13be357-8b33d5f2646mr2685403885a.89.1764195523344;
        Wed, 26 Nov 2025 14:18:43 -0800 (PST)
Received: from [127.0.0.1] ([20.161.78.68])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b32932a652sm1489084385a.9.2025.11.26.14.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 14:18:42 -0800 (PST)
Message-Id: <156be69a7994f6978a5bae30b82ae374fe4d506a.1764195516.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2010.git.1764195516.gitgitgadget@gmail.com>
References: <pull.2010.git.1764195516.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 26 Nov 2025 22:18:34 +0000
Subject: [PATCH 3/5] scalar: remove stale config values
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
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

These config values were added in the original Scalar contribution,
d0feac4e8c (scalar: 'register' sets recommended config and starts
maintenance, 2021-12-03), but were never fully checked for validity in
the upstream Git project. At the time, Scalar was only intended for the
contrib/ directory so did not have as rigorous of an investigation.

Each config option has its own justification for removal:

* core.preloadIndex: This value is true by default, now. Removing this
  causes some changes required to the tests that checked this config
  value. Use gui.gcwarning=false instead.

* core.fscache: This config does not exist in the core Git project, but
  is instead a config option for a Git for Windows feature.

* core.multiPackIndex: This config value is now enabled by default, so
  does not need to be called out specifically. It was originally
  included to make sure the background maintenance that created
  multi-pack-indexes would result in the expected performance
  improvements.

* credential.validate: This option is not something specific to Git but
  instead an older version of Git Credential Manager for Windows. That
  software was replaced several years ago by the cross-platform Git
  Credential Manger so this option is no longer needed to help users who
  were on that older software.

* pack.useSparse=true: This value is now Git's default as of de3a864114
  (config: set pack.useSparse=true by default, 2020-03-20) so we don't
  need it set by Scalar.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 scalar.c          |  5 -----
 t/t9210-scalar.sh | 20 ++++++++++----------
 2 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/scalar.c b/scalar.c
index 75fd292be7..fb595fab3a 100644
--- a/scalar.c
+++ b/scalar.c
@@ -129,9 +129,6 @@ static int set_recommended_config(int reconfigure)
 	struct scalar_config config[] = {
 		/* Required */
 		{ "am.keepCR", "true", 1 },
-		{ "core.FSCache", "true", 1 },
-		{ "core.multiPackIndex", "true", 1 },
-		{ "core.preloadIndex", "true", 1 },
 #ifndef WIN32
 		{ "core.untrackedCache", "true", 1 },
 #else
@@ -151,7 +148,6 @@ static int set_recommended_config(int reconfigure)
 #endif
 		{ "core.logAllRefUpdates", "true", 1 },
 		{ "credential.https://dev.azure.com.useHttpPath", "true", 1 },
-		{ "credential.validate", "false", 1 }, /* GCM4W-only */
 		{ "gc.auto", "0", 1 },
 		{ "gui.GCWarning", "false", 1 },
 		{ "index.skipHash", "true", 1 },
@@ -160,7 +156,6 @@ static int set_recommended_config(int reconfigure)
 		{ "merge.stat", "false", 1 },
 		{ "merge.renames", "true", 1 },
 		{ "pack.useBitmaps", "false", 1 },
-		{ "pack.useSparse", "true", 1 },
 		{ "receive.autoGC", "false", 1 },
 		{ "feature.manyFiles", "false", 1 },
 		{ "feature.experimental", "false", 1 },
diff --git a/t/t9210-scalar.sh b/t/t9210-scalar.sh
index 91d5964b73..63224d2062 100755
--- a/t/t9210-scalar.sh
+++ b/t/t9210-scalar.sh
@@ -202,15 +202,15 @@ test_expect_success 'scalar clone --no-... opts' '
 test_expect_success 'scalar reconfigure' '
 	git init one/src &&
 	scalar register one &&
-	git -C one/src config core.preloadIndex false &&
+	git -C one/src config unset gui.gcwarning &&
 	scalar reconfigure one &&
-	test true = "$(git -C one/src config core.preloadIndex)" &&
-	git -C one/src config core.preloadIndex false &&
+	test false = "$(git -C one/src config gui.gcwarning)" &&
+	git -C one/src config unset gui.gcwarning &&
 	rm one/src/cron.txt &&
 	GIT_TRACE2_EVENT="$(pwd)/reconfigure" scalar reconfigure -a &&
 	test_path_is_file one/src/cron.txt &&
-	test true = "$(git -C one/src config core.preloadIndex)" &&
-	test_grep "preloadIndex = true # set by scalar" one/src/.git/config &&
+	test false = "$(git -C one/src config gui.gcwarning)" &&
+	test_grep "GCWarning = false # set by scalar" one/src/.git/config &&
 	test_grep "excludeDecoration = refs/prefetch/\* # set by scalar" one/src/.git/config &&
 
 	test_subcommand git maintenance start <reconfigure &&
@@ -234,14 +234,14 @@ test_expect_success 'scalar reconfigure --all with includeIf.onbranch' '
 		git init $num/src &&
 		scalar register $num/src &&
 		git -C $num/src config includeif."onbranch:foo".path something &&
-		git -C $num/src config core.preloadIndex false || return 1
+		git -C $num/src config unset gui.gcwarning || return 1
 	done &&
 
 	scalar reconfigure --all &&
 
 	for num in $repos
 	do
-		test true = "$(git -C $num/src config core.preloadIndex)" || return 1
+		test false = "$(git -C $num/src config gui.gcwarning)" || return 1
 	done
 '
 
@@ -257,7 +257,7 @@ test_expect_success 'scalar reconfigure --all with detached HEADs' '
 		rm -rf $num/src &&
 		git init $num/src &&
 		scalar register $num/src &&
-		git -C $num/src config core.preloadIndex false &&
+		git -C $num/src config unset gui.gcwarning &&
 		test_commit -C $num/src initial &&
 		git -C $num/src switch --detach HEAD || return 1
 	done &&
@@ -266,7 +266,7 @@ test_expect_success 'scalar reconfigure --all with detached HEADs' '
 
 	for num in $repos
 	do
-		test true = "$(git -C $num/src config core.preloadIndex)" || return 1
+		test false = "$(git -C $num/src config gui.gcwarning)" || return 1
 	done
 '
 
@@ -298,7 +298,7 @@ test_expect_success 'scalar supports -c/-C' '
 	git init sub &&
 	scalar -C sub -c status.aheadBehind=bogus register &&
 	test -z "$(git -C sub config --local status.aheadBehind)" &&
-	test true = "$(git -C sub config core.preloadIndex)"
+	test false = "$(git -C sub config gui.gcwarning)"
 '
 
 test_expect_success '`scalar [...] <dir>` errors out when dir is missing' '
-- 
gitgitgadget

