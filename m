Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EBE25179A
	for <git@vger.kernel.org>; Thu, 26 Jun 2025 21:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750972976; cv=none; b=by2+eubjKO9EeRsSP1ofHIn/it9pf3EUd8tf/GZbN00q2F+uVaVzQHMvmQB9oZSTUPZFhC8h61cp4J4KnLa/q4rRVJvuwBIhWA5LopUd1u5sLf2QjVz2viL9VxPS4s4hbEnltrPdald0dNkmiCpUcPrbQN8j9Cm6SLPGXEk9Ta8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750972976; c=relaxed/simple;
	bh=CXd7wR2p+zMe8YdVZnslHiZOjEy9oAEDHs8QMyMiwgY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s3ogGybhYmsndYJhWgSMB3MDJCWhgJkNvd//tq+LXozIZdDZ15YPcKs8X90heSjs/K8unEKNVWBQttUcfJuyuo3axRSi9TpxMd8O4d9m0nWyGmy59OsxTbvj3jQYgMSd4gImszDkW4MYyuKyTjeqky78VRf70gLmr8sxTzSCm04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b22vZt5r; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b22vZt5r"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-234fcadde3eso22639025ad.0
        for <git@vger.kernel.org>; Thu, 26 Jun 2025 14:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750972974; x=1751577774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GcPEl6ODidUS7QsRJ5hqKOmxPfITap7V9AdzIyXijD4=;
        b=b22vZt5r8eU/zi1GKgG69bMBqebkSwmhTa2Rs1o4znaPJiz0kjJzLDdcu1egxEHqz5
         5miAorz74/R0wakiF9gn23m3bOCBR+xK0L0Mfz4LgdD4KV4I2fYd+ajjPwhxs5nN4/Lr
         E4XmyLOAnS69twJ+xg7jntt2LB0JAwzumB8K70F7ZoxlsKoWMiOWNrH2I/IPwl0EsiC2
         7axjw16j/xfeYDOHgTaBCGfWi4ydG36ichMP04KRkpkE8BQJH0EvLXPipBdW+3d14YGa
         qAvWML3kLT4lj9YZ58FZvG4PNyEFHCcwczuYQlHx4Q2rwFIFnSRiGc5flEWmJnViwp8X
         uTuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750972974; x=1751577774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GcPEl6ODidUS7QsRJ5hqKOmxPfITap7V9AdzIyXijD4=;
        b=hsZ6kmeATOQV7blFN3L3fSHg2mpXoP73OmiSfBWM9ZuGpNdGBNR30T5u+V9GwTZ3ik
         JXCrBJ9SkNuJ5VouwACJSKecxuoyMUF+ToJNCpytw8MaeOG2Sk60E6518KXWhXDS3paj
         csOfpwyFmUNzEWdXLk4OhQzuT2e3lMUNzCMZchnanW2eg5ry94987UZoFIk8UnLIoHs+
         oU4y2SSdMEXUstnVBkJ8D3eGtS5nhRaNegAMQllWyv2RoGJS0i+CyXoUASGQ6B/KP5kH
         w9KpSnspLPTbGy+DNcnrRWMscRGadbDCfO0HSFWXlWKwXxoXk3eUnWtURWn9JXcUiWWg
         WuhQ==
X-Gm-Message-State: AOJu0YzbZ9EQzcQsnWRFfjfV37DvKCJfqsCb4S7PC1ak3xMv7naLdlDr
	9wLilk3hbCJsBzt/1F7i7KiSgQR0qwxLiMk4yot/WK/74n8Y27x7L9UBqMqqdg==
X-Gm-Gg: ASbGncvLitO6NDM7r058wfxqioqvmLDS4l12ZocmQJ21Vz8oJXEWt+E97n5R1dKuyhr
	6iHlM1K2yW/Fvydgq16boAMF5fDbXHMpbL/edMy8cJ6iI0QgZy6zIhlOiw7PDMs3+LcFtCyMn46
	uonmssX+zS6JsIRQYXq9QePxYGEcPyFXrIKuKcLdiJyE8fmBjc5wbg1og5fJLhJViX12FrdepEy
	YKoFKDswjaEl2WyCbVE+8Vyil6TVFfTPoMG1hEZS+Rf47vCuU9/SMgXdg5ql8bErgKHtyX4m/3W
	9H499dRPwCoP6XzIYpV69Xj2yKsnJ5m2qFdq4/EYYnIKz+QSVjdsoRuzGzWnmEEmTqX7ZJYnvfE
	HFfV2D4lIYf1A54QX
X-Google-Smtp-Source: AGHT+IGWDLRIH/uvUOjTqgY31jvwm+niLYZO+u/xfwOaOQqXGp0wxV8CBBEwZQEUbfmXVIuaTX7BqA==
X-Received: by 2002:a17:903:1a24:b0:234:a139:1216 with SMTP id d9443c01a7336-23ac4683782mr11675365ad.44.1750972973717;
        Thu, 26 Jun 2025 14:22:53 -0700 (PDT)
Received: from localhost.localdomain ([2601:640:8e80:3680:3061:f32d:ab3f:87dd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb2e1bc3sm311995ad.28.2025.06.26.14.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 14:22:53 -0700 (PDT)
From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
To: git@vger.kernel.org
Cc: chris.torek@gmail.com,
	gitster@pobox.com,
	phillip.wood123@gmail.com,
	=?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
Subject: [RFC PATCH 1/2] run-command: add a pipe() write end to childs
Date: Thu, 26 Jun 2025 14:22:33 -0700
Message-Id: <20250626212234.88570-2-carenas@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250626212234.88570-1-carenas@gmail.com>
References: <20250626182432.87523-1-carenas@gmail.com>
 <20250626212234.88570-1-carenas@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Instruct the child to close the read side of a pipe provided by
the parent for notification that would be used in a future patch.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 run-command.c | 3 +++
 run-command.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/run-command.c b/run-command.c
index 8833b23367..0156d3a01d 100644
--- a/run-command.c
+++ b/run-command.c
@@ -796,6 +796,9 @@ int start_command(struct child_process *cmd)
 		set_error_routine(child_error_fn);
 		set_warn_routine(child_warn_fn);
 
+		if (cmd->parent_ipc_in != -1)
+			close(cmd->parent_ipc_in);
+
 		close(notify_pipe[0]);
 		set_cloexec(notify_pipe[1]);
 		child_notifier = notify_pipe[1];
diff --git a/run-command.h b/run-command.h
index 0df25e445f..d731b400b9 100644
--- a/run-command.h
+++ b/run-command.h
@@ -81,6 +81,7 @@ struct child_process {
 	const char *trace2_child_class;
 	const char *trace2_hook_name;
 
+	int parent_ipc_in;
 	/*
 	 * Using .in, .out, .err:
 	 * - Specify 0 for no redirections. No new file descriptor is allocated.
@@ -147,6 +148,7 @@ struct child_process {
 #define CHILD_PROCESS_INIT { \
 	.args = STRVEC_INIT, \
 	.env = STRVEC_INIT, \
+	.parent_ipc_in = -1, \
 }
 
 /**
-- 
2.39.5 (Apple Git-154)

