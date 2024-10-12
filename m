Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45E37E76D
	for <git@vger.kernel.org>; Sat, 12 Oct 2024 04:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728707874; cv=none; b=SZTZF1NiWeoqGj54kev6AGRsvueM3h+ERaGUTalSY9VDwoDca+byn03OIoDVdUwVE5GPFuIyAhfwc/EiRQOOcRa+oovN67scy7rs1V/PQQMlgf8h9kubFfc+rFPHyvdNgZoQ6kPWddsRZeG2WXc33v7Tn4B4L+hECYq+BB21+W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728707874; c=relaxed/simple;
	bh=X95jfjZy5a768s/71Dp8Ow0RXQzhy5uf88F8cSoBgWA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=tLGe3IFWh3eQZ5MxQ6tTHDE9c1MLpYGyE0Pc95yv9Z1ljjIj0q21g/JXNticIgT8ONQyC9NozXourqK5GYTBhVBvh3QkhV34r7lxocalhTLl3TQ63sLMfokS7K3i+trU5dZ0t3uq6QknEidISUhPJFiWhmOGVC7t9TzFLTzsrQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YjGUW+0V; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjGUW+0V"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a99f1fd20c4so9256166b.0
        for <git@vger.kernel.org>; Fri, 11 Oct 2024 21:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728707870; x=1729312670; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2RAA9EhAuPuJVUIH+x4ZgeM3kZpErL+qYNf2DDuGcP8=;
        b=YjGUW+0VHlI/zNkoa0IdNT7y9qhK2v1QXCbNRXJXoKt/IR239+bTR5KhSKlxIvY7Ks
         uRSdWKsP0mWNo1CBtENCW2jgshfW1JZyUBeUJVw18nvWQfsFI800edGsBi9jP3Jzepwc
         EooLb39EgaUBw7H6kUqq3nC1uitD/MdI2w5peFyHMzI0kpEl8mfcFDssyncn9lm4NlMc
         0RhndBHkXphYYg3vy+HuM+6S6Z+k4iNV7KmQ4quzRVdKG9HkB5iiPARnB+a21uO4QO2q
         YNv24ZHWiIdYmxxtsMC+qPUe9Gcey9+l1M/gfksW4sBoYGmtvrEX/sJ9V5MSflAoyPsp
         mVyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728707870; x=1729312670;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2RAA9EhAuPuJVUIH+x4ZgeM3kZpErL+qYNf2DDuGcP8=;
        b=fyEw3tjOFG7clR8Dz97BxKz4a6UISJ0x7Q2wPIjOc+hHcVsCc5Zjm1NrhbMhWriUKb
         meCCpnYEfGh7KSgbup3s3PBRq8GANTbMtpPh/zZvikS+Fb9yOGwFV36d69zXYSZpRAev
         9YEMJibOWOMDiGRpD+wLajszZQpM+xa0r2zvE1nua4T6in+oLzJ447EUcRhk/qBYzP0O
         TxmbxxGlgoqfbEdfKY8Te5MQA/bAeCxfM5QJfNGBE+6/PCIofDp8mZ/mQHXkAkIxQa4r
         Npmcimyga9YKMzYyqG8t8htBZEsDbS6sjKczzxhm99/xIRZvvUGRNu6QQv2NZhKIX7Vs
         vn1Q==
X-Gm-Message-State: AOJu0YymCPt15ZVaqY+0gwdh3vcRrXZjWGyJB1y75ZRDhU0zPfabgYjF
	9suubfmkxipKBoNIvOaOglGuWO/Llkkpuytdwc8zbhFuXTv8U2bR5YXZHA==
X-Google-Smtp-Source: AGHT+IH1qOXrS07E6pk8ELda4ePHQT8yYhIkycgdFYwLUedRg/mvpGrlwbhFuTEOC2klEij3xHzorQ==
X-Received: by 2002:a17:907:9811:b0:a99:89ea:593e with SMTP id a640c23a62f3a-a99b93aafb3mr443089866b.13.1728707870234;
        Fri, 11 Oct 2024 21:37:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99dfb3539fsm66759266b.134.2024.10.11.21.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 21:37:49 -0700 (PDT)
Message-Id: <8d2fa3af7964dacd09d454de4325b1d5eb7a5c3d.1728707867.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1809.v2.git.1728707867.gitgitgadget@gmail.com>
References: <pull.1809.git.1728370892696.gitgitgadget@gmail.com>
	<pull.1809.v2.git.1728707867.gitgitgadget@gmail.com>
From: "Abhijeetsingh Meena via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 12 Oct 2024 04:37:47 +0000
Subject: [PATCH v2 2/2] blame: introduce --override-ignore-revs to bypass
 ignore revisions list
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
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Abhijeetsingh Meena <abhijeetsingh.github@gmail.com>,
    Abhijeetsingh Meena <abhijeet040403@gmail.com>

From: Abhijeetsingh Meena <abhijeet040403@gmail.com>

The git blame command can ignore a list of revisions specified either
through the --ignore-revs-file option or the blame.ignoreRevsFile
configuration. This feature is useful for excluding irrelevant
commits, such as formatting changes or large refactors, from blame
annotations.

However, users may encounter cases where they need to
temporarily override these configurations to inspect all commits,
even those excluded by the ignore list. Currently, there is no
simple way to bypass all ignore revisions settings in one go.

This patch introduces the --override-ignore-revs option (or -O),
which allows users to easily bypass the --ignore-revs-file
option, --ignore-rev option and the blame.ignoreRevsFile
configuration. When this option is used, git blame will completely
disregard all configured ignore revisions lists.

The motivation behind this feature is to provide users with more
flexibility when dealing with large codebases that rely on
.git-blame-ignore-revs files for shared configurations, while
still allowing them to disable the ignore list when necessary
for troubleshooting or deeper inspections.

Signed-off-by: Abhijeetsingh Meena <abhijeet040403@gmail.com>
---
 builtin/blame.c                       |  8 +++++++-
 t/t8016-blame-override-ignore-revs.sh | 25 +++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 1 deletion(-)
 create mode 100755 t/t8016-blame-override-ignore-revs.sh

diff --git a/builtin/blame.c b/builtin/blame.c
index 1eddabaf60f..956520edcd9 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -69,6 +69,7 @@ static int coloring_mode;
 static struct string_list ignore_revs_file_list = STRING_LIST_INIT_DUP;
 static int mark_unblamable_lines;
 static int mark_ignored_lines;
+static int override_ignore_revs = 0;
 
 static struct date_mode blame_date_mode = { DATE_ISO8601 };
 static size_t blame_date_width;
@@ -901,6 +902,7 @@ int cmd_blame(int argc,
 		OPT_BIT('w', NULL, &xdl_opts, N_("ignore whitespace differences"), XDF_IGNORE_WHITESPACE),
 		OPT_STRING_LIST(0, "ignore-rev", &ignore_rev_list, N_("rev"), N_("ignore <rev> when blaming")),
 		OPT_STRING_LIST(0, "ignore-revs-file", &ignore_revs_file_list, N_("file"), N_("ignore revisions from <file>")),
+		OPT_BOOL('O', "override-ignore-revs", &override_ignore_revs, N_("override all configurations that exclude revisions")),
 		OPT_BIT(0, "color-lines", &output_option, N_("color redundant metadata from previous line differently"), OUTPUT_COLOR_LINE),
 		OPT_BIT(0, "color-by-age", &output_option, N_("color lines by age"), OUTPUT_SHOW_AGE_WITH_COLOR),
 		OPT_BIT(0, "minimal", &xdl_opts, N_("spend extra cycles to find better match"), XDF_NEED_MINIMAL),
@@ -1119,7 +1121,11 @@ parse_done:
 	sb.reverse = reverse;
 	sb.repo = the_repository;
 	sb.path = path;
-	build_ignorelist(&sb, &ignore_revs_file_list, &ignore_rev_list);
+
+	if (!override_ignore_revs) {
+		build_ignorelist(&sb, &ignore_revs_file_list, &ignore_rev_list);
+	}
+
 	string_list_clear(&ignore_revs_file_list, 0);
 	string_list_clear(&ignore_rev_list, 0);
 	setup_scoreboard(&sb, &o);
diff --git a/t/t8016-blame-override-ignore-revs.sh b/t/t8016-blame-override-ignore-revs.sh
new file mode 100755
index 00000000000..b5899729f8e
--- /dev/null
+++ b/t/t8016-blame-override-ignore-revs.sh
@@ -0,0 +1,25 @@
+#!/bin/sh
+
+test_description='default revisions to ignore when blaming'
+
+TEST_PASSES_SANITIZE_LEAK=true
+. ./test-lib.sh
+
+test_expect_success 'blame: override-ignore-revs' '
+    test_commit first-commit hello.txt hello &&
+
+    echo world >>hello.txt &&
+    test_commit second-commit hello.txt &&
+
+    sed "1s/hello/hi/" <hello.txt > hello.txt.tmp &&
+    mv hello.txt.tmp hello.txt &&
+    test_commit third-commit hello.txt &&
+
+    git blame hello.txt >expect &&
+    git rev-parse HEAD >.git-blame-ignore-revs &&
+    git blame -O hello.txt >actual &&
+
+    test_cmp expect actual
+'
+
+test_done
-- 
gitgitgadget
