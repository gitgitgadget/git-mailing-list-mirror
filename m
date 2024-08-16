Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42A56F30D
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 03:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723778793; cv=none; b=fh8SIiCfgGbxOxt0QZJx8Io2YH1tZxvA0Dr2/OfAQByY/PlcuKDC6Evbd5Kcb0xjEe8zH/gxHYiKMToY+/3jT5IoWDQFlLO8ydx8t6T5BYlHpTDuq/vHafajRIQk93RnhRTFgsxCuy79hf2wxK/Xck1363bF3jMQH0TMcwgtDY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723778793; c=relaxed/simple;
	bh=TSD4qJKuPgro+dFMNsA2P2ECFcrqxIUp7limXEfL/Fs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cEKx/lOeiZ0Rsp+AzkIvcStZ/u/BgDhmgcPJh8MjcBqhOHmtblyhg9X+QCmPRwWPLwG3Rlop0mo3dcnagmfXBY977/yiEbfX5ggExpjRnXSM3O7ceHWXOuONOSDeQ2AgI2RQs3hcPyX/SlLqCroyVLZdTLLsVEwwgo5OpSlvUR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ex2KOmzz; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ex2KOmzz"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-70945a007f0so957668a34.2
        for <git@vger.kernel.org>; Thu, 15 Aug 2024 20:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723778790; x=1724383590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8pjNsnHK9E0ysaKGnA0Yv9Pzf6/BaOkogJi++E+ZhIo=;
        b=Ex2KOmzz8R8Um25SYDrzokeaonHOAV+TD6Wf5Zkoqzy31ViH8B6mmPwUUjdk+y6Tuh
         ex3rhyCc3AzP3MC5vaKTsxJ7VPdz6xmObWXD2SfeeJYdiFvSsLKrQ1qIJB4Iw5n4aMLi
         vx3mq+D4yFf8eoW3fnOqihlnIz72tr1Y53/k0oIeUg09wyRzl1NfRaM0dzHwzm06Gb4H
         Ju8fFYJQ8fby2l9stYJURqj3VN1surmFif9Kpm/ihbA87bjp2/7RewHAW4f1m7AgduMD
         pPr4jBec6Ve1zih9bl3Abz+G/QGh5dTiCe//5h1UAJtC0XxeobQ/Mrh57Q5/59fONGPx
         SJcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723778790; x=1724383590;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8pjNsnHK9E0ysaKGnA0Yv9Pzf6/BaOkogJi++E+ZhIo=;
        b=g5YKn5+X5S5NHhkPd6GGNxr1ozDf63RGml13lApEArkzHT8494NEgTJOGpBPU+y77W
         UbRB2dZVzmxMg+Xg9VuxYOJx8+w0A0UUAGtRAMchzLg7i5uJ4Zxnda+dlXaLgH/6qM8l
         vZe0D4OzhN7oMDIX5B3UDSMQjB392ThWkt8jboEj3gm0HunNffQ0jzoRkPPRHh3Flc+s
         KeTanitp2bydzOJYeArJdDdCz1pyvR+uxk5V047ZPt51zK78kNOZzLSTINGri6maCX9+
         Gfae1cbzM5mQFwcB8lknjBeJznAFoHkROVgqCA2hdkizXPDd43/P3F14wnLOPr2LItEh
         A88Q==
X-Gm-Message-State: AOJu0Yx2YaF8xdRtU+VkhndohUsmhAkpquD2dO0d4M5pfeMImMJBcAFJ
	8QVFu+5ky1a7OburmMY18aPrNXWf9ghBkGM0JC5/clQ+oJG9vASWUPiPemOm
X-Google-Smtp-Source: AGHT+IE5N7BDxAOGdmWGkYI2yy6zpd/6kNkSuABx4P6wPw+eJe/kbvWLdUn9XdCbzbCkjavF9d5toQ==
X-Received: by 2002:a05:6358:7244:b0:1ac:efb0:fb2d with SMTP id e5c5f4694b2df-1b393116c70mr213466855d.4.1723778789781;
        Thu, 15 Aug 2024 20:26:29 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.116.48])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127add68a3sm1723393b3a.7.2024.08.15.20.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 20:26:29 -0700 (PDT)
From: Matheus Tavares <matheus.tavb@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	johannes.schindelin@gmx.de,
	newren@gmail.com,
	Rodrigo Siqueira <siqueirajordao@riseup.net>
Subject: [PATCH] rebase -x: don't print "Executing:" msgs with --quiet
Date: Fri, 16 Aug 2024 00:26:19 -0300
Message-ID: <767ea219e3365303535c8b5f0d8eadb28b5e872e.1723778779.git.matheus.tavb@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`rebase --exec` doesn't obey --quiet and end up printing a few messages
about the cmd being executed:

  git rebase HEAD~3 --quiet --exec "printf foo >/dev/null"
  Executing: printf foo >/dev/null
  Executing: printf foo >/dev/null
  Executing: printf foo >/dev/null

Let's fix that.

Suggested-by: Rodrigo Siqueira <siqueirajordao@riseup.net>
Signed-off-by: Matheus Tavares <matheus.tavb@gmail.com>
---
 sequencer.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 0291920f0b..d5824b41c1 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3793,12 +3793,14 @@ static int error_failed_squash(struct repository *r,
 	return error_with_patch(r, commit, subject, subject_len, opts, 1, 0);
 }
 
-static int do_exec(struct repository *r, const char *command_line)
+static int do_exec(struct repository *r, const char *command_line, int quiet)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	int dirty, status;
 
-	fprintf(stderr, _("Executing: %s\n"), command_line);
+	if (!quiet) {
+		fprintf(stderr, _("Executing: %s\n"), command_line);
+	}
 	cmd.use_shell = 1;
 	strvec_push(&cmd.args, command_line);
 	strvec_push(&cmd.env, "GIT_CHERRY_PICK_HELP");
@@ -5013,7 +5015,7 @@ static int pick_commits(struct repository *r,
 			if (!opts->verbose)
 				term_clear_line();
 			*end_of_arg = '\0';
-			res = do_exec(r, arg);
+			res = do_exec(r, arg, opts->quiet);
 			*end_of_arg = saved;
 
 			if (res) {
-- 
2.46.0

