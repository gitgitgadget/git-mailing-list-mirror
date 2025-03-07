Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3C233DF
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 23:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741390575; cv=none; b=mCtOQGpMnrNoQuKnlrEtIHEKr8dONSZBvr78Hfi08VVBBWyskQ8hNwdRDyH+qgiexxzHDrx50UtqSlxNk593BluE08lS1fpgFUP0T3nfiyYWgx+0tAbHM1KpKHmWb4COzT4dh7ORscCYFjJEl0CQwThv2ke2hu2LjuVMd89OT8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741390575; c=relaxed/simple;
	bh=uW5bRQB4XXi6+E31aohFFA1T+pUDf31lBRQLmOnjdyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BwukbG3Cks4t3nZazO8/WMG32aE87ZJx34Uc8LfOiO13z9dt2NvCawjradLvX6gMdPbdaiGuYJEMY9lLgDTQK7CQjkRml3BjWNIyjjgjVpx1iVvanFX8yswdQFWLqHfa94ApBxBjarEKufVzJAAvgeVedeZtW0yZhn9RCBE3pyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aX7Fk2Im; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aX7Fk2Im"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22409077c06so19400405ad.1
        for <git@vger.kernel.org>; Fri, 07 Mar 2025 15:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741390573; x=1741995373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iK1MudTOOC0VXfUy+3wi28IDwRwjOzctrPukWuJ73aE=;
        b=aX7Fk2ImlqOgU1oY5Yt5LKbaSlr0qe3xmnjIyNXH4uxwRZT+jOrlwtafeZ95svuoVh
         sWgMQ3j5JPu4UdW+lX0slgdPXFIK4LvdL3qs7V5/1Lragezmn5vBje4SSZVF5YLWt54x
         cZH4WsuEhEhKGLLaKLNMQrbQ8AHrKMiqDdte/B2KPqoamxAZmpGxYHiZX6iSB92WZO4I
         85vFya6kyi2k7moD4twlouY3GQMRpwCqlapLkgSRvDkZzh8eu7ylpsMt78on8m40x3Ak
         R5GKPNdKbhQ9IAnnFPp7KwL2Acj5ku/MldCRmysY2btldlotqavKQBy4OOWH5ShCLK0C
         10Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741390573; x=1741995373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iK1MudTOOC0VXfUy+3wi28IDwRwjOzctrPukWuJ73aE=;
        b=cXh1gQ/tODM1uPAuCEGPm6b/VrDg3KJqCRaYZxYXbXwGZrkGAa83iSdmYB2P8AVupu
         sgsAooeqjrreIdKp+r9uDt5LY1vk2tZsCSQmZ4ORsbnEExFaozk1Ku+w/BKVde5s4wQt
         w0inb1NoYCffaQN96/8IpK/+lgqPcU5I6ZjYD/PTVv+jd1aXq7senrEHDWmyg758aeoP
         qQ+zP5hSPRNsSPvCkFYb4fA9GVgGqfjxjzn9Z6n9SuJcrfXBlsiRS6beSurTIMQtxCBD
         iZ64uKpU6Drz/GKMe6FvCCGktBEkMa7qFbwcSrjSpF+kP3Up6QABPNGrUhQD9IiHKfHk
         ptDA==
X-Gm-Message-State: AOJu0YyumK0X/EywhhBp8/KIQ4/5fl9QCXB82JAFM2QvhyTHL00edQW8
	5ytRYy0eAjl/OKuKyVoUFLtvoDOtsQ9+ynwgIgE/Sr/BWpeYqpFqogBNYS6x
X-Gm-Gg: ASbGncv7/evcvBdOzkuSxWVogpA1Xmo3fGY0ah0d0HhQQ+9vqtFCnRTxXkRKg2eDzZB
	KELnxFaMzlq8i88S/XsdTEmgMmjtm2UolQ3b/5kKqyg9tqNdLTqG36bpybWcbH4dUaH6RO2sMP3
	MayGtBgxjti79SIi9x8KgVb/DT8PsS+GTG1WTnZAg2cnd2KC8l9sCtE6fWlx7chhUK7X/gFDhE3
	jy7Tqo8mg+PWA5CG7cl4+FufQcmmiUTPsuEhhB0tRz45Un8zeRLKVaJ87hBj9N73CFQ1Mbkd7+s
	0YGxswpeTHMxuVYKYn2RhnRJ6mlWbThCyVAe+Qi1c/r2CzEne/tOhErAzBtSyVTk+FjUBA==
X-Google-Smtp-Source: AGHT+IH5+9EkV1w5gHg3d39f59ONzbZ4gu0o7GYI1kgDJdGEJ7fr+vvSO9dRhBhnWERJ0NS838GZug==
X-Received: by 2002:a05:6a00:928b:b0:731:737c:3224 with SMTP id d2e1a72fcca58-736aaa1e02emr7356755b3a.10.1741390572772;
        Fri, 07 Mar 2025 15:36:12 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736bcb8de04sm423880b3a.154.2025.03.07.15.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 15:36:12 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	christian.couder@gmail.com
Cc: gitster@pobox.com,
	johncai86@gmail.com,
	me@ttaylorr.com,
	ps@pks.im,
	shejialuo@gmail.com,
	phillip.wood123@gmail.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 7/8] builtin/for-each-ref: stop using `the_repository`
Date: Sat,  8 Mar 2025 05:05:06 +0530
Message-ID: <20250307233543.1721552-8-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307233543.1721552-1-usmanakinyemi202@gmail.com>
References: <20250306143629.1267358-1-usmanakinyemi202@gmail.com>
 <20250307233543.1721552-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the_repository global variable in favor of the repository
argument that gets passed in "builtin/for-each-ref.c".

When `-h` is passed to the command outside a Git repository, the
`run_builtin()` will call the `cmd_for_each_ref()` function with `repo`
set to NULL and then early in the function, `parse_options()` call will
give the options help and exit.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 builtin/for-each-ref.c  | 5 ++---
 t/t6300-for-each-ref.sh | 7 +++++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 8085ebd8fe..3d2207ec77 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "commit.h"
 #include "config.h"
@@ -20,7 +19,7 @@ static char const * const for_each_ref_usage[] = {
 int cmd_for_each_ref(int argc,
 		     const char **argv,
 		     const char *prefix,
-		     struct repository *repo UNUSED)
+		     struct repository *repo)
 {
 	struct ref_sorting *sorting;
 	struct string_list sorting_options = STRING_LIST_INIT_DUP;
@@ -63,7 +62,7 @@ int cmd_for_each_ref(int argc,
 
 	format.format = "%(objectname) %(objecttype)\t%(refname)";
 
-	git_config(git_default_config, NULL);
+	repo_config(repo, git_default_config, NULL);
 
 	/* Set default (refname) sorting */
 	string_list_append(&sorting_options, "refname");
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index a5c7794385..9b4f4306c4 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -292,6 +292,13 @@ test_expect_success 'Check invalid atoms names are errors' '
 	test_must_fail git for-each-ref --format="%(INVALID)" refs/heads
 '
 
+test_expect_success 'for-each-ref does not crash with -h' '
+	test_expect_code 129 git for-each-ref -h >usage &&
+	test_grep "[Uu]sage: git for-each-ref " usage &&
+	test_expect_code 129 nongit git for-each-ref -h >usage &&
+	test_grep "[Uu]sage: git for-each-ref " usage
+'
+
 test_expect_success 'Check format specifiers are ignored in naming date atoms' '
 	git for-each-ref --format="%(authordate)" refs/heads &&
 	git for-each-ref --format="%(authordate:default) %(authordate)" refs/heads &&
-- 
2.48.1

