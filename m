Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158BF367F25
	for <git@vger.kernel.org>; Sun,  5 Jul 2026 08:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783239888; cv=none; b=BKkzfBPmmn3qQjUhT+edirKVRtWM3+lvD4V0A5B+CslbkDlvEG0U5A2izmW3Ilur9ihRD89dsreoTL6rbf0QVw7F4+c5Gvia0E7VodGY8DwrMi/mbE91fi42+GwPq1Nwmlpl8sLDHAWIO7KFJCfImqI0LAOpiHBccWkLgbGibL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783239888; c=relaxed/simple;
	bh=VoISBO7MYxn4FS9y2Ce5pmRnEXSk+8zgeMUIR1hCeTQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=tWBPd81aOJFmmpZLqZqR5HvAxQYwsv3bLhJQpZBWilveRyU3PSDKnuq4H65RPjurH7+Ej1vwtbST5xVcTSEreqmakjAzYQa3V4+jYJsOejYcHg0dcGGr2qIYMUX9+qMPRFAxHSfzHgLKH31LPZWE90wVNK2gRWvQ0DNEYY98Wmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/+APoz4; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/+APoz4"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-92b21f65b60so179968085a.1
        for <git@vger.kernel.org>; Sun, 05 Jul 2026 01:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783239886; x=1783844686; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0MjcMI7oVG65IHJLtZG8wB8KbPAhMW+yUfO7+0MW/gw=;
        b=a/+APoz43o/AH06XmYdG4QpSuU+PrNJronsBHOAzw8fprQHtKKm/tBq5gLGwQrBNR9
         pgwfvtqcFjwHyQOsxmESpIvciP3qOSFc1yIu5VYhK0tCRjmnzKq3JFNferWUzHbsNX9u
         +0TvRdvYpfLLjzva/2+5BwKu0uzMkVN0s7B4dSZRfIUYKydAwv2tIBuZBi8KNEc9bgVG
         cU3GYupjVWAbZetIDbSQRY8ZKSSIBI7iYyQ4h3+Jxfs13xKP4a9CrvU9SmpE9P0NKa1T
         yzZBXq1rlhpU2rZq0Uv5bMrScjikyBJKS0JYRfa13ZjympWR8TwWuwsBGAJlsqFoTM9O
         /RBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783239886; x=1783844686;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0MjcMI7oVG65IHJLtZG8wB8KbPAhMW+yUfO7+0MW/gw=;
        b=KBUc+T1LNQTmoPL8ulkbsj3+gvg19Y05Sbldrz6AMHMfPaAkTVikt4NYedgEz/UK51
         wgfcsN6iQEOUWExdlZWmvHcZpXIWMhsDrVuj20PK1OvAVMSw/ibr5U7jLKfnHIJzgpiL
         RMBs5PDYGwiDnpJNfePQdcokHmrY6CoNLrgKto1X+C6atNS0JFzU7oIIjKWZ/jqBlTSU
         cCgfu/lBgm4d8e5x2KnUwpN/jheBPHN49EA4fb2ISxbcuAUEPFHXWf1yLWLarDHkl6la
         Ox8PEmlD9oGpKB5m9pQtieX0laI2TvVXoORTvCYzKixYaOzs/ecMmL7TVvccANQ+yS/Y
         QaWA==
X-Gm-Message-State: AOJu0YwSt/ECWI/RIQug4pn1Ax/OIXdKPHNtDLbnMHmExiDoqfWJWTNx
	DooGaadS7HJ1U2MpCWE10n74dBaKMv1hBHoW5L6ZGHMurugF8fK/o7QsAku6lA==
X-Gm-Gg: AfdE7ckAxFLghWr5fGYrVaGZS9TFYvC+T304/ayT5om5LTbHHS2ASue8Dl2ZrpkugxX
	xuY+kOWFjKjVxkCSaocQs0gEsqwDE7Jdn2/miQEF89EI2zNggmP8TAnHwCv9SnK22v5ypyH4BHq
	iWYxUig5yG0O0DTBthFEfiwyTQq1Xjry3IHhlecRlcNH2jALU9KH9nV19ABMRMx5s9wkukDwVA1
	O8sHiYzLiNvYCMNW72mOJ4MGFKrFRqiqB1Zr7I42UR4O9WbH/97+bwjXkLgjiqgSDVkGy9zQQsg
	EXbqPy66sgw7iOBnFAd1gdXw2/UMrep8j9Q9nTU3MAbXYvoEIJat18ItYOl5Tn0QDWxQu2ANq70
	KOUOYC937+7HiIM45607uOfZ/9DIoGS1eR8PzbuDlbpVMpqf/iD7QzFwZumzxqldVRhocjf1seE
	Mf13ym9gI4JY4DmlYXuCS2Bt9vHyCc
X-Received: by 2002:a05:620a:a505:b0:92e:9cc7:fa68 with SMTP id af79cd13be357-92e9cc80362mr638180185a.30.1783239885995;
        Sun, 05 Jul 2026 01:24:45 -0700 (PDT)
Received: from [127.0.0.1] ([135.237.130.145])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90cbd6c9sm631336385a.33.2026.07.05.01.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 01:24:44 -0700 (PDT)
Message-Id: <5397ea785c6da50e977598a35d03af82cb2a5e4d.1783239870.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2163.v2.git.1783239870.gitgitgadget@gmail.com>
References: <pull.2163.git.1782889472.gitgitgadget@gmail.com>
	<pull.2163.v2.git.1783239870.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 05 Jul 2026 08:24:24 +0000
Subject: [PATCH v2 07/12] submodule: fix cwd leak in
 `get_superproject_working_tree()`
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

`get_superproject_working_tree()` allocates cwd via `xgetcwd()` at the
top of the function, but two early-return paths (when not inside a work
tree, and when strbuf_realpath for "../" fails) return 0 without freeing
it.

Redirect these early returns through a cleanup label that frees cwd
before returning.

Pointed out by Coverity.

Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 submodule.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/submodule.c b/submodule.c
index fd91201a92..92dfb0fc2d 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2627,13 +2627,12 @@ int get_superproject_working_tree(struct strbuf *buf)
 		 * We might have a superproject, but it is harder
 		 * to determine.
 		 */
-		return 0;
+		goto out;
 
 	if (!strbuf_realpath(&one_up, "../", 0))
-		return 0;
+		goto out;
 
 	subpath = relative_path(cwd, one_up.buf, &sb);
-	strbuf_release(&one_up);
 
 	prepare_submodule_repo_env(&cp.env);
 	strvec_pop(&cp.env);
@@ -2678,20 +2677,22 @@ int get_superproject_working_tree(struct strbuf *buf)
 		ret = 1;
 		free(super_wt);
 	}
-	free(cwd);
-	strbuf_release(&sb);
 
 	code = finish_command(&cp);
 
 	if (code == 128)
 		/* '../' is not a git repository */
-		return 0;
-	if (code == 0 && len == 0)
+		ret = 0;
+	else if (code == 0 && len == 0)
 		/* There is an unrelated git repository at '../' */
-		return 0;
-	if (code)
+		ret = 0;
+	else if (code)
 		die(_("ls-tree returned unexpected return code %d"), code);
 
+out:
+	strbuf_release(&sb);
+	strbuf_release(&one_up);
+	free(cwd);
 	return ret;
 }
 
-- 
gitgitgadget

