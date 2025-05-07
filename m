Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34441531DB
	for <git@vger.kernel.org>; Wed,  7 May 2025 01:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746582643; cv=none; b=X43vrkq7Qhew4MKoAlYJXbAnEDdmh1VRMQg+kgvU2d9q+eK6+IJRkEfgnJEZwUjgHilu9ODXPbtfOCzf/RE5xH0xSii2hTdi1PJJfbSFfKCPrVG6IU47KxPj3Jqb7rCBgdEw2WtICM/4T1kdHoooxGhE4AcEwE7c9AQ/sVGSxKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746582643; c=relaxed/simple;
	bh=lQ+Nf87tP074YPrnh1HHzk2gcvBts4qnXL6Eh9OkFs4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=heVwvMnMmuQHAWe4N7tbzWXX8MlAfdht6IcAOzlx+F6QuW5P1b+bCmYuPs5Ktx1GevroeYjtz8k1HUira0QwuC5B7fEW1xMJcRn+OnCw7W+Wxz3P4lr2OviDvT2hh5LAPTgdMOho4Vb5m/E0xJ+gupe5k7Nn9g0MQLScd9rQDCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kduZrbUS; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kduZrbUS"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so42482945e9.1
        for <git@vger.kernel.org>; Tue, 06 May 2025 18:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746582640; x=1747187440; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gIbUjf7ewI86VHIGiMa+3ei9pLVec9Uw3jVKwkVQtOw=;
        b=kduZrbUSvZGira0O1oE3Bj6qG3ZQKnWjR4UOTJGmDtiyP18X5T2kPlK+cINIBo9FUY
         1D6QapsZPPp4HnGjBPgGwfIXE4fnN78QXHKW0+CFxcC1Wk0teAQYlcFLWRTNDGntJ/gd
         UzqCrhSywfSEJuitXMbDYDZHzXt2W/msuVsdsy30b/erTFEYYklwSEmA1aI+L3RdqL00
         BPM/irfcyAyUl3z/E3Ad2bBn67Kkx4y4AFSC4quv6VMFrI6z1NgwoouNv3fhsbBCELG0
         YdW0+66O2sIpLXWDzYm4W19rd4RWVzDn+LnKHSiyChco9nEfddnsCkxsfCvqpQGeNJtC
         99cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746582640; x=1747187440;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gIbUjf7ewI86VHIGiMa+3ei9pLVec9Uw3jVKwkVQtOw=;
        b=p/ux4W1z/aAT2IrfVsJj0Ba399+yT4djbExgQ7LME+grplekigGeEhnXmJBPqWQlPP
         m+j/Xz+teOJAImbJikmxklxgLOXNT/ts70LKiNRk/h1iLd4U3dQGkx0r5QESZlgNjE0H
         ww3ngPRtLqQGjn9GhUW24ls9rpPbljtQVS6Qx+6/ZERpIFT3rU0MBocSXQvZ/Vd6Ac6z
         ozoMEeEvubY5qGDCetibSIZi7BcNd19onDPKU0Kpi5VweoUGtSc/63sur7pTkOomSBLE
         DOhZaGBdlF+MUHNGbrMFm/r+wjjr1E+Qkjb4e8tvUVDU4i3xwtrYJvjZQnIUPNK1kFLP
         AvGw==
X-Gm-Message-State: AOJu0YxMFC4wqnrbH8WmIKoPcUcmK/rn3iLEU39QJfE4tVMfpbXuKlZ0
	CYHRhpYpAZA/8qTBmwerWvmQ9t7ccOo9XkE88UYiTsmjKxEPDuFb1xeCzA==
X-Gm-Gg: ASbGnctJUATSzkKfSwuNmplJS474/slrzHszMqVy0MWqv+VaFe+S7RGCDJvqHCFy8Fe
	RhuPSL4l4OAVP1xr/iPc0eFkc6cCU1wA14j9PXcRAkssg1D6jsJiH5ijY7eg4nQfhE16RBylmVu
	CBsdib7xFYxuLVo5oW91skagCEW+q6JyeziLfGPoJ8RCmNeOzg6syjCXK4cMhyG2UQMuF7OMWEi
	T51zEXhTsJxtesIxO2ujx26/j/RnDmj/ATgnrtuwdw7CZ0KPhLxu6j0YESXEUOg30pe56N6Pvor
	yOeNnXioM9XMZco54NB2lxTp+9vwnZ6YHHoGNKiTlA==
X-Google-Smtp-Source: AGHT+IHS3l8Glb7sm/tlIezN0VriVAXK0ZRxdyCmWKd11I6NwrrVbRZzxOnKSzynNMf6Vn3VWf+lQQ==
X-Received: by 2002:a05:600c:3d17:b0:43d:2313:7b4a with SMTP id 5b1f17b1804b1-441d44bc533mr9738035e9.3.1746582639509;
        Tue, 06 May 2025 18:50:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099b0ffcasm15346079f8f.74.2025.05.06.18.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 18:50:38 -0700 (PDT)
Message-Id: <f3a3cfe3ef1404a98ee8113e98a25fd19cec3215.1746582637.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1913.v3.git.1746582637.gitgitgadget@gmail.com>
References: <pull.1913.v2.git.1746458844.gitgitgadget@gmail.com>
	<pull.1913.v3.git.1746582637.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 07 May 2025 01:50:34 +0000
Subject: [PATCH v3 1/4] scalar: customize register_dir()'s behavior
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

