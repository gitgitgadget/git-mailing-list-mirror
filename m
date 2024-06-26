Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2514181D0E
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 12:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719405283; cv=none; b=U1aUqSbFYAAT4+xntW3g87w/gXudCWMieED0yy2CxNOgC+CFtZBXicPzGPdsysZT+d0zANhLrgD6oiWvBy2135b6+hgEXTJxPNb9R2jAzbMTG8u2WuCeulX2AEJZiZ8iuNa/tPvguFC78D2mHqCdp91QFnTZV4WszB4rBbuyzKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719405283; c=relaxed/simple;
	bh=QYGFCzpAaxOqnuQPnfExWRRmcAhVY9dcmwpTM3nuZmw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QcTVOxS71acLkW0Sq9e4ZKuGrwZExm+0vGz5w2yfXz2LHwAl/gfTCF5qTJyCcaa9NpMYEgolUSXoHqe2ja+zKB7GYHoEd3YbvNcMZ6c9eZbNoTeZjEdnk5ODTVyh0uFMYQpQAAVHnylZCGdLqXOfZ54WCdN2G0M/e+v/JXSEEYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/RypuHm; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/RypuHm"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f9a617f88cso2835415ad.2
        for <git@vger.kernel.org>; Wed, 26 Jun 2024 05:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719405281; x=1720010081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+NNI4N/zLkzxtQoBpl9OBReuq+2lO3qKPxQtgAZRtCI=;
        b=E/RypuHmGYc9Pb4TAT8iJtSv1XNYo8AHsVf+0upsXuVZQsFZZJk/U0EWHuXckaOZ3b
         rs3NLPXkVIOy+R19qIO7gWyCV+bRBGuZHJJ4wjw36DkCVCMgac+HbwFkYwpSmGLyTlzP
         ZnhbJ2WdujdCQmhra3gFFUtLvxbVeaBgEqGhebojwdeHZLmLq2KninZ6xy+cWLf7dmnS
         K6t0ymDaPNbME4RFj1qZM6QUa22hPMzRpfCTsPwHxEvOuDe4WyUHULNUos2Mq4rm92l8
         Isuk4FIT9OWsnOy7o60plYy/32Z0hL8hmu67PVfAQ6BoAhDZU/0WH5gNQ8uduEe1SbC4
         0pyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719405281; x=1720010081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+NNI4N/zLkzxtQoBpl9OBReuq+2lO3qKPxQtgAZRtCI=;
        b=WLzr4xdIoh6P7p8NXWh6SXu9ovOmEWKqQpCMYfQ2hoqz9RNNxLXbS47e9ImsViaYW/
         tMy5KZGWsmC8n51qIlsm8MUIigt6AIYBLM9erY6YM/WKqV+IZY7qu/PfkKC4mlvtc1WQ
         bOVcM6f47LQ1RArWYKo0ZM/N6qGUeiVOHq+PqEc9VbXVczUwjcLSD1VzZieYBN0BNOR0
         QM95+gb9pwJ1SkGCLYUg80V68E9kkoUBGMlaxvdtS6Cnude62nWYhS/MisvIIKXxxSdX
         P9Q845zlQKAMoOz4PI42uoAv4wt8yWxjl209VrggWX/gZYCW5ebB6Bu+DQ8BYliGEl0A
         abCA==
X-Gm-Message-State: AOJu0YzJCC3ZytxgrblkGEDgvov7s56Z18+VucN0/iet2PAJTVA7BIHl
	vavTH83EXWqskHWeVH5XaQGkHNm+E5ldWOqXr575fEsA/07/ncxBOUKLwEAt+6Y=
X-Google-Smtp-Source: AGHT+IH//lJoaBbfAxszy153dczcPw8N+tsSBvYy15pUCn6BrynBlyBRjs+n+twPvOA/PSsfCT80Dg==
X-Received: by 2002:a17:902:d4d0:b0:1f7:1a37:d0b5 with SMTP id d9443c01a7336-1fa09e70800mr133046175ad.4.1719405280716;
        Wed, 26 Jun 2024 05:34:40 -0700 (PDT)
Received: from TTPL-LNV-0102.. ([2409:40c2:205a:5198:708d:222f:b6ff:a843])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb7cf885sm98626335ad.224.2024.06.26.05.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 05:34:40 -0700 (PDT)
From: Abhijeet Sonar <abhijeet.nkt@gmail.com>
To: git@vger.kernel.org
Cc: Abhijeet Sonar <abhijeet.nkt@gmail.com>,
	Paul Millar <paul.millar@desy.de>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH v6] describe: refresh the index when 'broken' flag is used
Date: Wed, 26 Jun 2024 18:04:14 +0530
Message-ID: <20240626123421.286655-1-abhijeet.nkt@gmail.com>
X-Mailer: git-send-email 2.45.2.606.g9005149a4a.dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When describe is run with 'dirty' flag, we refresh the index
to make sure it is in sync with the filesystem before
determining if the working tree is dirty.  However, this is
not done for the codepath where the 'broken' flag is used.

This causes `git describe --broken --dirty` to false
positively report the worktree being dirty if a file has
different stat info than what is recorded in the index.
Running `git update-index -q --refresh` to refresh the index
before running diff-index fixes the problem.

Also add tests to deliberately update stat info of a
file before running describe to verify it behaves correctly.

Reported-by: Paul Millar <paul.millar@desy.de>
Suggested-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Phillip Wood <phillip.wood123@gmail.com>
Helped-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: Abhijeet Sonar <abhijeet.nkt@gmail.com>
---
 builtin/describe.c  | 11 +++++++++++
 t/t6120-describe.sh | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/builtin/describe.c b/builtin/describe.c
index e5287eddf2..7cb9d50b36 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -53,6 +53,10 @@ static const char *diff_index_args[] = {
 	"diff-index", "--quiet", "HEAD", "--", NULL
 };
 
+static const char *update_index_args[] = {
+	"update-index", "--unmerged", "-q", "--refresh", NULL
+};
+
 struct commit_name {
 	struct hashmap_entry entry;
 	struct object_id peeled;
@@ -645,6 +649,13 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 	if (argc == 0) {
 		if (broken) {
 			struct child_process cp = CHILD_PROCESS_INIT;
+			strvec_pushv(&cp.args, update_index_args);
+			cp.git_cmd = 1;
+			cp.no_stdin = 1;
+			cp.no_stdout = 1;
+			if (run_command(&cp))
+				child_process_clear(&cp);
+
 			strvec_pushv(&cp.args, diff_index_args);
 			cp.git_cmd = 1;
 			cp.no_stdin = 1;
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index e78315d23d..f8591a5b2a 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -671,4 +671,40 @@ test_expect_success 'setup misleading taggerdates' '
 
 check_describe newer-tag-older-commit~1 --contains unique-file~2
 
+test_expect_success 'describe --dirty with a file with changed stat' '
+	git init stat-dirty &&
+	(
+		cd stat-dirty &&
+
+		echo A >file &&
+		git add file &&
+		git commit -m A &&
+		git tag A -a -m A &&
+
+		cat file >file.new &&
+		mv file.new file &&
+		git describe --dirty >actual &&
+		echo "A" >expected &&
+		test_cmp expected actual
+	)
+'
+
+test_expect_success 'describe --dirty --broken with a file with changed stat' '
+	git init stat-dirty-broken &&
+	(
+		cd stat-dirty-broken &&
+
+		echo A >file &&
+		git add file &&
+		git commit -m A &&
+		git tag A -a -m A &&
+
+		cat file >file.new &&
+		mv file.new file &&
+		git describe --dirty --broken >actual &&
+		echo "A" >expected &&
+		test_cmp expected actual
+	)
+'
+
 test_done

Range-diff against v5:
1:  52f590b70f ! 1:  c8010b1533 describe: refresh the index when 'broken' flag is used
    @@ Commit message
         Suggested-by: Junio C Hamano <gitster@pobox.com>
         Helped-by: Junio C Hamano <gitster@pobox.com>
         Helped-by: Phillip Wood <phillip.wood123@gmail.com>
    +    Helped-by: Karthik Nayak <karthik.188@gmail.com>
         Signed-off-by: Abhijeet Sonar <abhijeet.nkt@gmail.com>
     
      ## builtin/describe.c ##
    @@ t/t6120-describe.sh: test_expect_success 'setup misleading taggerdates' '
     +		mv file.new file &&
     +		git describe --dirty >actual &&
     +		echo "A" >expected &&
    -+		test_cmp expected actual &&
    ++		test_cmp expected actual
    ++	)
    ++'
    ++
    ++test_expect_success 'describe --dirty --broken with a file with changed stat' '
    ++	git init stat-dirty-broken &&
    ++	(
    ++		cd stat-dirty-broken &&
    ++
    ++		echo A >file &&
    ++		git add file &&
    ++		git commit -m A &&
    ++		git tag A -a -m A &&
     +
     +		cat file >file.new &&
     +		mv file.new file &&
-- 
2.45.2.606.g9005149a4a.dirty

