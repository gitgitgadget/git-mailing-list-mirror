Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9487919D092
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 03:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771903956; cv=none; b=l5r4vbADMZGzvHDSUUwSCjDlk7qcXewG/CyW3aq1PiNt10menWBkborhSxodDabAI6sSCc+mh8n23tGgymrKQFifq6y7Gbi/sPy77PWvjToff90TlztdA1FU5q102X15olSPGcihCj1tjmR3fjFKhoOjuWPIk8Lhrb+o7CweY0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771903956; c=relaxed/simple;
	bh=1cd5K2eQ4DhZnWyGp3gORgK77sJIvSwqHcr0yVzqAxs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=cWIAQQHp8qjkvtwu3r5FKZsUQeFr4dbZSUm+lZeNMbvWcPmWon87uKMkjHiMOMPLit0Y5Xx5KnHyhIG5oey7YUz71mvEeSAr0blOuP99kmylkAggrj8LZ+7OzbFBAJg+n6B7EPtfg+PeHo0QlqVZAWMPoHju63QGlJ0Wl4dKIPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ab9Pk4S/; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ab9Pk4S/"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-89549b2f538so65330406d6.2
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 19:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771903954; x=1772508754; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gqDuSn4mseHUNkGequv4hp3mIx92g/adtd3n0VOZoz8=;
        b=Ab9Pk4S/TaHSwSiOi3XUh00RiXyXH3zHnlkbIM1F8AfYTb6v5odIRk/T6fJy0pW2/6
         SGoh/At94po6d6ERTWs7SK7GuaddqxV0+uRJHBPxUst57yReD++cPM/dZCp7ikVg8FW/
         YFGx0PvjEG2RNLNQHokl0CBCTg6rjxGPakND+qewJKbJ6iBRBVfXBuAlK05r34Ho+B6k
         Jaw2Ad7whg+U7+Oo2Kg74m8+z1HBzAfY7LZPFXtLESOwVKh7mUZ0lOINgs6G0WfimlH+
         6NLAE4j+SEB3pM8sYjuGwX+UuJFyIPNqLZgAdiT4lVxCqWyaxEM3psu/rjtJofyzq7m3
         cFEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771903954; x=1772508754;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gqDuSn4mseHUNkGequv4hp3mIx92g/adtd3n0VOZoz8=;
        b=qqP6/tWa3iquaDIIK9G8VzR6SrTFi4ehW7Tcg8zaGYvMyQEyPO3taNPoweEjrQ5sN3
         agxxkvLnG6wrLt/0mzZ0JkylZmj3bOrKx0Z9gd2YlW85gZp38hhEitkvYUWGQTLq1Jtr
         T2W7jNqI0myo/R0ajupUS/S4VGvII83fxu+c6OPFBtDzOxZWxkNlGv+fKt/IfNSjdwBh
         +8PqvspPVUVsi6JU1KIBFU+GrPpF2vv4SyvMUZdW/JyZkpmPcnhGvhRQovE+WoUP0qm7
         XUE8yQRnlpRaz5Ol1BkSqDOtBIyy3kGNLO4bENIJ4RlyYY9Bmrld6JPh5nVydVL8TXV8
         cW9g==
X-Gm-Message-State: AOJu0YwwSmHA0xibkgdJAwTBxp18O0vaJ/u2qrluF1at29RC61Bn+/2o
	Ghhcay8jCmD9+4mU5aq+Dl8j9zx6nwXtt+le6iaJkazH2J5E+WDkBTW3lVR7Qw==
X-Gm-Gg: ATEYQzz1lN4w+4gejMHe3PATZsbk3gF/BCk3TfsT/vVjSGQIAYLHo9rEDhKTCBsm1OV
	e6yVsDkTGImAuk7+ZrYFEzf6WdrU0LGWxmb4dUtJAPtDNEwkZNyYnjGn1cSAPvhqONuBDhEM8Dw
	fTQZudr7PBego3SpmAqKfO+6/Z1mCcHHjn6EC5XGpREsR6pr8Eox69fvB8yPVs6wYAusCzLhMQg
	lagpbZq2b4ykARgrRqKOVY2uak8CunHbFR5Uzyymi83seoGgwRzxHKzpUSiFhD+z/jnNgDqG7Oz
	92f/i1+YcZppWk3aWpf+bJH6DiXwZ/WHq6EHZab2wopuuc3bNWjsHuZQTzaCpYbbVQEJz4Uvrp4
	kfiVGOJE8EkbnkWDK+mqKMxH0wU8AR+GaiV2OwgSCaQFDwmP+rX919nMmhhwymvZV/2lcg1fngg
	rHagmxNiQEe/QuDN1S0myINDPgpg/8q39LZJM=
X-Received: by 2002:a05:6214:1c4d:b0:895:1d73:1fc0 with SMTP id 6a1803df08f44-89979d4d81bmr171397546d6.38.1771903954007;
        Mon, 23 Feb 2026 19:32:34 -0800 (PST)
Received: from [127.0.0.1] ([20.97.198.241])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997e62f453sm86029096d6.36.2026.02.23.19.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 19:32:33 -0800 (PST)
Message-Id: <a47f9e9386badd83f0f5820f33f5eed68ca5fd82.1771903950.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2056.git.1771903950.gitgitgadget@gmail.com>
References: <pull.2056.git.1771903950.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 24 Feb 2026 03:32:30 +0000
Subject: [PATCH 2/2] for-each-repo: work correctly in a worktree
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
    fastcat@gmail.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

When run in a worktree, the GIT_DIR directory is set in a different way
than in a typical repository. Show this by updating t0068 to include a
worktree and add a test that runs from that worktree. This requires
moving the repo.key config into a global config instead of the base test
repository's local config (demonstrating that it worked with
non-worktree Git repositories).

The fix is simple: unset the environment variable before looping over
the repos.

Reported-by: Matthew Gabeler-Lee <fastcat@gmail.com>
Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/for-each-repo.c  |  4 ++++
 t/t0068-for-each-repo.sh | 22 +++++++++++++++++-----
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/builtin/for-each-repo.c b/builtin/for-each-repo.c
index 478ccf1287..f39b085d7d 100644
--- a/builtin/for-each-repo.c
+++ b/builtin/for-each-repo.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "config.h"
+#include "environment.h"
 #include "gettext.h"
 #include "parse-options.h"
 #include "path.h"
@@ -60,6 +61,9 @@ int cmd_for_each_repo(int argc,
 	else if (err)
 		return 0;
 
+	/* Be sure to not pass GIT_DIR to children. */
+	unsetenv(GIT_DIR_ENVIRONMENT);
+
 	for (size_t i = 0; i < values->nr; i++) {
 		int ret = run_command_on_repo(values->items[i].string, argc, argv);
 		if (ret) {
diff --git a/t/t0068-for-each-repo.sh b/t/t0068-for-each-repo.sh
index f2f3e50031..00b72dcac1 100755
--- a/t/t0068-for-each-repo.sh
+++ b/t/t0068-for-each-repo.sh
@@ -7,12 +7,13 @@ test_description='git for-each-repo builtin'
 test_expect_success 'run based on configured value' '
 	git init one &&
 	git init two &&
-	git init three &&
+	git -C two worktree add --orphan ../three &&
 	git init ~/four &&
 	git -C two commit --allow-empty -m "DID NOT RUN" &&
-	git config run.key "$TRASH_DIRECTORY/one" &&
-	git config --add run.key "$TRASH_DIRECTORY/three" &&
-	git config --add run.key "~/four" &&
+	git config --global run.key "$TRASH_DIRECTORY/one" &&
+	git config --global --add run.key "$TRASH_DIRECTORY/three" &&
+	git config --global --add run.key "~/four" &&
+
 	git for-each-repo --config=run.key commit --allow-empty -m "ran" &&
 	git -C one log -1 --pretty=format:%s >message &&
 	grep ran message &&
@@ -22,6 +23,7 @@ test_expect_success 'run based on configured value' '
 	grep ran message &&
 	git -C ~/four log -1 --pretty=format:%s >message &&
 	grep ran message &&
+
 	git for-each-repo --config=run.key -- commit --allow-empty -m "ran again" &&
 	git -C one log -1 --pretty=format:%s >message &&
 	grep again message &&
@@ -30,7 +32,17 @@ test_expect_success 'run based on configured value' '
 	git -C three log -1 --pretty=format:%s >message &&
 	grep again message &&
 	git -C ~/four log -1 --pretty=format:%s >message &&
-	grep again message
+	grep again message &&
+
+	git -C three for-each-repo --config=run.key -- commit --allow-empty -m "ran from worktree" &&
+	git -C one log -1 --pretty=format:%s >message &&
+	grep worktree message &&
+	git -C two log -1 --pretty=format:%s >message &&
+	! grep worktree message &&
+	git -C three log -1 --pretty=format:%s >message &&
+	grep worktree message &&
+	git -C ~/four log -1 --pretty=format:%s >message &&
+	grep worktree message
 '
 
 test_expect_success 'do nothing on empty config' '
-- 
gitgitgadget
