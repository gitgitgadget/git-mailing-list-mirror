Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241B01D5CD3
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 17:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740678906; cv=none; b=EKLa3kIzHC/BO45mG9hw17ro/cp+vHvl+Wc+O30Ci4lASJizn8bF38R+pFKVcq1vT2f3k68On8vSLXcqX+YKL2GmjFruAGU0JKhTrEbufdAYnsBVw4bm8AgGq3uPkNGZCLgC3/DYpOaAlorpUayeq0OIaedqLMo03tLaD6vnZSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740678906; c=relaxed/simple;
	bh=hXC+F3GrwK7S+6x7pIgBqqNYJa6aREzus7gDS/orD0g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CBkBoqRDsuYvxiNQlQ9ABQcswESJoqonmJ2NuyoFqlaVn1w4nj6wHM+67cO+GZtjmY4cfbp68LYHhkmimc2fp71ZoP5hYVl2gXy+7deEcDvWhnYObNH1fSAE8sJ0KDqwWn1ILmoihnMQf4l5RIBVpBskV0KkhXutLCyVlzePHoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jAPoSpkd; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jAPoSpkd"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2feae68f835so1239951a91.2
        for <git@vger.kernel.org>; Thu, 27 Feb 2025 09:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740678902; x=1741283702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mq3C5Z/8Q8ZYRKIczpDNwzlvuoZe6XRld6/fqUZb1yc=;
        b=jAPoSpkd3gBer1TGT4x0pjusGoCLnOR7OVqDT3eYT+gGPquAapaiOSQSP6ePLrot7s
         Ltcr46QjTn/zXpBPtYgY1DstjGkQS719MqGWx+eZt+7SXOGLUL587XPxXPlWrRRq8kCx
         K3dC5VSID1uhKuFyCA3qOR96kM3e957EtkKDxuEXutV+t2O5oyYvew16Gv+7voWApz/8
         XHPB9mvYG+RH+Oy92ELwnNnzt3bCLW4q7ftTxEOm2eABMfW7J600SzTBJD3PomHdrPOa
         2SmHh32cE0sEhtd4SsVJrojYqEXDJIDFUp9flUvUI2/m5T3h63ZuhcEPt924dwvPtyWJ
         EYEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740678902; x=1741283702;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mq3C5Z/8Q8ZYRKIczpDNwzlvuoZe6XRld6/fqUZb1yc=;
        b=p4SkgEwyXmujexyeMsRFoDPgFrnCDLo5kHT+z0+Q65jPoOsYjdBX8ahaYliHAjyco/
         fjabXo57uiXGFCYh89w3xFkLIQNn1RD4aC6eV8Pku8yZHB6WJwuizf/7TMtne52i/q18
         04kN8eNDCRyA3a6ZE3E5oJ3pFYRNYaECEr+XZVGnE8vZI8pxti8CGmlhDxUUC3p6l+qI
         oREz9iud/0h2hGpAUsm1nuaf4+9zCkmXZlD3Uen9kd2HGb7DzU86cDhEfvTKwPPwQtnQ
         2aXTpFpP+7XIqhKYA/SjtNQouZEkNPUo/DCTBdXZiTaQnLqO9R/AloUehcS/O+93NWsv
         ANcw==
X-Gm-Message-State: AOJu0YwgO48L1VqhXRBVD39poGUtRXBO1j/sbrBqQlsqAfAPt+9fR8ww
	61R2O9pkUeKXLfDmZzHQBMGH6IThbbsdpsKCVMWHELcAoI0KVxs0OH3IeoZr
X-Gm-Gg: ASbGncviyNb3LhdX28MHmZ9m6ty0dSdyuAwjFScc7ktPo+jPgYE9R/k3ew6pD3Z6jq/
	TgSw2sxzw4/0SIXDOR9uZJZb5C6wZ/0gKG0WLKEx9zEQoGkPCiyHpgeEJlk6EWmZGM94rmuP5mX
	KABnd0qd133mixp5vl0KPODBbqcYmTeU/YmtOUvtgBwtjwbd8bly/ACS5zjmmcBtckUDMg1mG83
	B95kpbFDhG136KT33j7VPWsRsmnNIvmBMHI6xXxjBAm7Qc3Nm/j7l0hm33pxaPvxkzPc0CnhWi2
	zFPLrfsBEi91kjqYkE3kzN2g1pAU6nFtV+MTaUzbF3xCYazVLAo=
X-Google-Smtp-Source: AGHT+IG4BwobqFOl/qeCuaX6MKEOt2k3wge+Mimet6BiE++/wNzVazW3cUTdyuMfgcsPfS0GdbrMLg==
X-Received: by 2002:a17:90b:5745:b0:2ee:8430:b831 with SMTP id 98e67ed59e1d1-2febab2eaffmr378425a91.2.1740678901936;
        Thu, 27 Feb 2025 09:55:01 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fea6753137sm1977801a91.6.2025.02.27.09.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 09:55:01 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	christian.couder@gmail.com
Cc: ps@pks.im,
	shejialuo@gmail.com,
	johncai86@gmail.com,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC PATCH] config: teach `repo_config()` to allow `repo` to be NULL
Date: Thu, 27 Feb 2025 23:24:34 +0530
Message-ID: <20250227175456.1129840-1-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `repo` value can be NULL if a builtin command is run outside
any repository. The current implementation of `repo_config()` will
fail if `repo` is NULL.

If the `repo` is NULL the `repo_config()` can ignore the repository
configuration but it should read the other configuration sources like
the system-side configuration instead of failing.

Teach the `repo_config()` to allow `repo` to be NULL by calling the
`read_very_early_config()` which read config but only enumerate system
and global settings.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 config.c | 4 ++++
 config.h | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/config.c b/config.c
index 36f76fafe5..c5181fd23b 100644
--- a/config.c
+++ b/config.c
@@ -2526,6 +2526,10 @@ void repo_config_clear(struct repository *repo)
 
 void repo_config(struct repository *repo, config_fn_t fn, void *data)
 {
+	if (!repo) {
+		read_very_early_config(fn, data);
+		return;
+	}
 	git_config_check_init(repo);
 	configset_iter(repo->config, fn, data);
 }
diff --git a/config.h b/config.h
index 5c730c4f89..1e5b22dfc4 100644
--- a/config.h
+++ b/config.h
@@ -219,6 +219,9 @@ void read_very_early_config(config_fn_t cb, void *data);
  * repo-specific one; by overwriting, the higher-priority repo-specific
  * value is left at the end).
  *
+ * In cases where the repository variable is NULL, repo_config() will
+ * call read_early_config().
+ *
  * Unlike git_config_from_file(), this function respects includes.
  */
 void repo_config(struct repository *r, config_fn_t fn, void *);
-- 
2.48.1

