Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6065E207E12
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 11:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742299163; cv=none; b=DTY+GLrjsEPjWb2IXuZr+B+b5MkgqrpxwKu8LLXHXKiPeB+4VNgEqjoBj0umQc/GITX+2/NOvrZi2x/dzlaNejenjxZ1G3g5iSjRXSvbNk9SiLmSrgXBMlt+vRYgUdYvH9jTPuxTivWzYuuoa4ZhXLUYOReIGhRpyTLRP9m6dZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742299163; c=relaxed/simple;
	bh=woOoairnn3V7YUBFIsN9goJ7MaLPKg/0DbHSrav+ITw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GKOtuDRzwVOtsCaQmzpQrmHKFl/AOjWH9sLQlCnDrWNDdIGfQz17bhCJb6o6RlEp5WT6YR+92ZHMHRJSMahrlYgXXIpnAbX/Op1WCGici8knxt4IeMxshrPYiNfbEYrNDWUz5VvQWNkh1jeogl1k5G7LgE34yMDw8Dwg+XUl4mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XhwbTUxf; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhwbTUxf"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-225e3002dffso56898845ad.1
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 04:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742299161; x=1742903961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5qsH/l+jtisR3hlPMI2mnPlbMuso0oQLu6ZqtpCkH5E=;
        b=XhwbTUxfpgHpjPzMwwx8iCw/gW6qt/5naszPpcu7CLhL/3dGbYJ9FFqrhgKs058Jpm
         ++G56K9Wc8xBimapnNNcMIzaZrzUgfcRKvQpkIA56GE01HdCyS2hkW5z0XmrDODOJmSG
         KlYFq0l868oC03X6HlZQW47OMx4pJlFykWV0GQ31YcrRNeZ02iLVAZal23ZqX1j5lSe3
         W2U2OZfaaKld/pWtfnB8+fFzcbYcMN+tR5By1KsYmdv8wzBGIpj+oL6UBiMxwQYG+1f8
         P9zwPCvrmIjb+3sM9W7ZTzXbDgb4ap4hePzt6ndB73N9wGowmSj9hlvNN12XleWZbB2q
         kk6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742299161; x=1742903961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5qsH/l+jtisR3hlPMI2mnPlbMuso0oQLu6ZqtpCkH5E=;
        b=ktIMstyFZIuLMGJet8p8xGY3O3GLZwD0rVqLhvsGTz/KuZhEH2PjyVtPb0qCOyfrZH
         tUIOCkqHA+RjbeHYyxKc9CingxQnH8pskaGjzr5dtgtIXYD50IGac2azb7DkB8yUNXZV
         KUYwLTaP+VrJIxXsrdros6gkEaS8MgAJK+mFu0nqGWWIrMZDB+i0poLP9sa8o2hH3twO
         /3PWaOYQ5O3srO0M6wrf5mEe5JKBi+a1HvL17yXHQxgJ2f1vbBbHIrpyFQRgYJI5Z5xe
         jqNr14sELXHOBmtaBJE4rL8GA60sMNZukHzoe5vDlWxsZtmBdGu8kRD5AOuiXJOw4VYR
         7cXQ==
X-Gm-Message-State: AOJu0YxMPFPcpuR3wu1+u03M5Xbj4MkGduEdHxGhVrUCNiobPc7pr5m0
	Sci5lK2fOiZnysuC3c/EsUB86gXFFOpHvoD4tBwMETCy30d38O44bFtlxf5s
X-Gm-Gg: ASbGncuwdccHUhBOKgT+Ze1paOPtplwkyHlvLDyhZZrf3tDAh6/GRosUqMGr4R7xMfb
	9/H2NXsHM9zSYlO2JEjptecc5Cesn1uKA4t7SREFAUlGCJahgLSIDGM5u9HaBqV1b+TT2+58mnH
	o8YQ9Xu5kFSX0C1PBi18b+v7T1iSrZl8V0VP0iu/NUhqoFkpL8NLLj2Bv//sjD++SI4B2c5qw73
	VhNYEstavXhGYMycohTZNA1eKGQUcmnC6RZgvfAX1DUZ2urVcverIP3n6s1w4/GuHbNQ0EanswV
	ZSRHtWqCS3HQ8/WVtx5OwWHxOcc9Nyk1k3SiG2ftcBbVuufbEha49bGuqOKiEJGeU49VDQ==
X-Google-Smtp-Source: AGHT+IFihrZmPMxiU3Y85cpWWXBZjcfq/hVAu3R54g8peZErJ6ML9Fm7xLD/uv+tJ9F4r+DqBMDJ4w==
X-Received: by 2002:a17:902:e884:b0:224:249f:9723 with SMTP id d9443c01a7336-2262c6241bbmr34244305ad.51.1742299161226;
        Tue, 18 Mar 2025 04:59:21 -0700 (PDT)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bc012bsm92101605ad.205.2025.03.18.04.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 04:59:20 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	christian.couder@gmail.com
Cc: gitster@pobox.com,
	johncai86@gmail.com,
	me@ttaylorr.com,
	phillip.wood123@gmail.com,
	ps@pks.im,
	shejialuo@gmail.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/9] config: teach repo_config to allow `repo` to be NULL
Date: Tue, 18 Mar 2025 17:28:53 +0530
Message-ID: <20250318115912.2978992-2-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250318115912.2978992-1-usmanakinyemi202@gmail.com>
References: <20250318115912.2978992-1-usmanakinyemi202@gmail.com>
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

This will be useful in the following commits.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 config.c | 4 ++++
 config.h | 9 +++++++++
 2 files changed, 13 insertions(+)

diff --git a/config.c b/config.c
index 658569af08..e127afaa8f 100644
--- a/config.c
+++ b/config.c
@@ -2521,6 +2521,10 @@ void repo_config_clear(struct repository *repo)
 
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
index 5c730c4f89..29a0277483 100644
--- a/config.h
+++ b/config.h
@@ -219,6 +219,15 @@ void read_very_early_config(config_fn_t cb, void *data);
  * repo-specific one; by overwriting, the higher-priority repo-specific
  * value is left at the end).
  *
+ * In cases where the repository variable is NULL, repo_config() will
+ * skip the per-repository config but retain system and global configs
+ * by calling read_very_early_config() which also ignores one-time
+ * overrides like "git -c var=val". This is to support handling "git foo -h"
+ * (which lets git.c:run_builtin() to pass NULL and have the cmd_foo()
+ * call repo_config() before calling parse_options() to notice "-h", give
+ * help and exit) for a command that ordinarily require a repository
+ * so this limitation may be OK (but if needed you are welcome to fix it).
+ *
  * Unlike git_config_from_file(), this function respects includes.
  */
 void repo_config(struct repository *r, config_fn_t fn, void *);
-- 
2.48.1

