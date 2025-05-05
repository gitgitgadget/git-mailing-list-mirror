Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CB625C809
	for <git@vger.kernel.org>; Mon,  5 May 2025 15:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746458850; cv=none; b=K+Q0lU3/ajWf9s0D7TAF4HpDg/vF5LVH6PgQPwwdwAWLRso1JcNPN6/fO1AL4DfGFwjf+nEjJul0QjLa3VYBl/zzH1R/gh/EEoVUxpcL370KU1Xok4xNNPqcHp58xV0qPm9ohjCfLSv0Dij3FLlxy+1PkbthN7cvTcs3gLPsJYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746458850; c=relaxed/simple;
	bh=lQ+Nf87tP074YPrnh1HHzk2gcvBts4qnXL6Eh9OkFs4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=E6sCt/Em39DBoIO2nUkSplbc/m+2qX188kB8D4QucDQ5oYToie2+fYL4WcjCEvXoQj/3yigBxJBmNHzxBPQ2/gua39CTCe+EfIuL3rgk6Aw2d8TODhzwHvqQtrW4jJ/aduo4Ad+MV9fXS38DRplfpRlV31YdejoPdHWSTNa8tR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TbpFLK0e; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbpFLK0e"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43edb40f357so23012125e9.0
        for <git@vger.kernel.org>; Mon, 05 May 2025 08:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746458847; x=1747063647; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gIbUjf7ewI86VHIGiMa+3ei9pLVec9Uw3jVKwkVQtOw=;
        b=TbpFLK0eiEJ0LkRpkYJ/LaFmYXfodcH0+GstGyozGeNkKEnFpD324+cp6Sx+rMaQVu
         z3Q43i7zHWjSyxOp51VaysShrEP1Mm5sklDWywF8iaZSj7kDHrSTJH3aGhFhu+Esag/3
         W0OLAWGudD3c/gQI+z4IqmNzOU4wNtlpyyb229liVnSHlDFoBWLa/JXli9g2jfe4xgCz
         +djqWIkQVr34qPvholZljbzHtmQzL/RGChjkBNzms8V4XkLsv8etcAgTNlU38r2SB2RC
         WZodA2dmb8gQoTADXuFDj7ao7iYnZj21NTZNwF2JHz6o7/3/R+YCNeOu4QMJ6YIQbkbs
         f2oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746458847; x=1747063647;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gIbUjf7ewI86VHIGiMa+3ei9pLVec9Uw3jVKwkVQtOw=;
        b=Vrl2iSAtwdyHZQR91whlVZ/EXOb15inVCsXRT6g8ndqLdrVaUa6+pqBf29kMI/jqUk
         3sKlJZtfyffgjlPaKrTvf0WYFYKz1YGwO464VTPNrm++srclIJ9YwM0YxPClSj/4T4vq
         IahkumZmMChqKZ0UL4AgHRXPbwatUg4g+HxpZDKctagEnOuut+ujrC26Cr5gp0b21DK2
         0cO+Fx4jy2YwArzmMv9m0MxH00pXap1/9z9HQgxvyqc86uOAi77BV8KKkW286q/ULl4C
         IexCjfv2xGnZW6s4UXQAJA2+k0Fp2NxBJMEdUzsNq+9/iGBGg4fdpTYsrqvtaSFt90ei
         Ij0g==
X-Gm-Message-State: AOJu0YwXGY9gvBymmanbdCTEaxGxvKY6VI1miH8QIo2d0FsWNhD3v35Q
	YV8bfEdwknN6B4I6UdCxuX7Gu3DFlfNnpac7VV36rOzERKQFyDjGZnSWng==
X-Gm-Gg: ASbGncsdx3wCqSiUBT8cIe1xQTmOuV4fiA54epIdKGb2oj9M05WGKNeOUGyoyBDVqvF
	08jOHLTCXLsyZ4aEI1GQ1u4H9WAa0bK7tkFn5FCWuqCvgWFZGLTZHT1Vk0X1yylcAarU2sa0K1O
	GIGyjifL4G8vhKGCfdmJelUvIu+6wtbbpDdhuRtGCUnmRppNSddovZQ6GqwpRl79rrcAu1aWI0P
	qLkdjXqTTaebe8H3GJwPgTX/Xd1e4ou9OxXpeFlgrFfIllVgtnQQmG/dfICG6iT5q8Y7kiV5KyY
	u4Zf7ArF9wZoB/0YnJGqfaogUYPMPAZ4rtFt+GPmwQ==
X-Google-Smtp-Source: AGHT+IG+1gH/1IW4VVRYGm5uE+VhAjmQ9qiaNYwzoNgzMppwij7WgTmH4UqPzalc4vOGl3Rf784jTA==
X-Received: by 2002:a05:600c:8711:b0:440:66c5:26f4 with SMTP id 5b1f17b1804b1-441c1cc3991mr73299725e9.1.1746458846422;
        Mon, 05 May 2025 08:27:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2aed5e8sm181715055e9.16.2025.05.05.08.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 08:27:26 -0700 (PDT)
Message-Id: <f3a3cfe3ef1404a98ee8113e98a25fd19cec3215.1746458844.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1913.v2.git.1746458844.gitgitgadget@gmail.com>
References: <pull.1913.git.1746008680.gitgitgadget@gmail.com>
	<pull.1913.v2.git.1746458844.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 05 May 2025 15:27:21 +0000
Subject: [PATCH v2 1/4] scalar: customize register_dir()'s behavior
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

In advance of adding a --[no-]maintenance option to several 'scalar'
subcommands, extend the register_dir() method to include an option for
how it should handle background maintenance.

It's important that we understand the context of toggle_maintenance()
that will enable _or disable_ maintenance depending on its input value.
Add a doc comment with this information.

Similarly, update register_dir() to either enable maintenance or leave
it alone.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 scalar.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/scalar.c b/scalar.c
index d359f08bb8e2..b20b063471a6 100644
--- a/scalar.c
+++ b/scalar.c
@@ -209,6 +209,12 @@ static int set_recommended_config(int reconfigure)
 	return 0;
 }
 
+/**
+ * Enable or disable the maintenance mode for the current repository:
+ *
+ * * If 'enable' is nonzero, run 'git maintenance start'.
+ * * If 'enable' is zero, run 'git maintenance unregister --force'.
+ */
 static int toggle_maintenance(int enable)
 {
 	return run_git("maintenance",
@@ -259,7 +265,15 @@ static int stop_fsmonitor_daemon(void)
 	return 0;
 }
 
-static int register_dir(void)
+/**
+ * Register the current directory as a Scalar enlistment, and set the
+ * recommended configuration.
+ *
+ * * If 'maintenance' is non-zero, then enable background maintenance.
+ * * If 'maintenance' is zero, then leave background maintenance as it is
+ *   currently configured.
+ */
+static int register_dir(int maintenance)
 {
 	if (add_or_remove_enlistment(1))
 		return error(_("could not add enlistment"));
@@ -267,8 +281,9 @@ static int register_dir(void)
 	if (set_recommended_config(0))
 		return error(_("could not set recommended config"));
 
-	if (toggle_maintenance(1))
-		warning(_("could not turn on maintenance"));
+	if (maintenance &&
+	    toggle_maintenance(maintenance))
+		warning(_("could not toggle maintenance"));
 
 	if (have_fsmonitor_support() && start_fsmonitor_daemon()) {
 		return error(_("could not start the FSMonitor daemon"));
@@ -550,7 +565,7 @@ static int cmd_clone(int argc, const char **argv)
 	if (res)
 		goto cleanup;
 
-	res = register_dir();
+	res = register_dir(1);
 
 cleanup:
 	free(branch_to_free);
@@ -610,7 +625,7 @@ static int cmd_register(int argc, const char **argv)
 
 	setup_enlistment_directory(argc, argv, usage, options, NULL);
 
-	return register_dir();
+	return register_dir(1);
 }
 
 static int get_scalar_repos(const char *key, const char *value,
@@ -803,13 +818,13 @@ static int cmd_run(int argc, const char **argv)
 	strbuf_release(&buf);
 
 	if (i == 0)
-		return register_dir();
+		return register_dir(1);
 
 	if (i > 0)
 		return run_git("maintenance", "run",
 			       "--task", tasks[i].task, NULL);
 
-	if (register_dir())
+	if (register_dir(1))
 		return -1;
 	for (i = 1; tasks[i].arg; i++)
 		if (run_git("maintenance", "run",
-- 
gitgitgadget

