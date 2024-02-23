Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB23B5CDCE
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 10:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708682481; cv=none; b=HfE4S7BK+9bokZvpap5Z7JEB6bG1OTn5EGxgpHa5O1gffZY66pLk46t6IkhWieY+74u9gj+w32N2HZP9r59dhE8iEamYY684AtboVokIx2zU2JaMSMGuFUjyaampG4qD8OCrnGQQPo0ynBjDTdRwDVFH4Tl32c/SFrG14HnSv9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708682481; c=relaxed/simple;
	bh=VfltkTB10ZIBhlAE6ooGiSF5wKaiCn9vjFBaF9tYY0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C7MmQ/qRxkydNIwHpL/0cYd7xNCVoi8t0F7mi0UD5sr9KM+iNNORrldvMWDsUF/uxY09reP7zPDcD7FgKPbkhY0aNjpJbLtIvbRnBk8/oTKEprrJXeUGEklZCtFm7imgXk7UTPES5oyGhwpuMNTrBwwOjYiInWBV7MQXDWUclSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZMuo3CVT; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMuo3CVT"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-563d32ee33aso691049a12.2
        for <git@vger.kernel.org>; Fri, 23 Feb 2024 02:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708682478; x=1709287278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+imelKk34ScyPqozaBb4Uj6heZ6F/trGf/qMfVX4OiQ=;
        b=ZMuo3CVTIw1WD9ZDspw897mkE9scjndKxlLGMhtBoSt88zZdumTHbPs0/1fy7Zqu+6
         BoXUVXJ+hRo9koZnzoKUNWqsyDCCVaPsynOhIN1Ht0ExHld9lM+WV9yncB2NdO5Y2mgy
         FhH4PW80bunITNCLYtvuUZx3Pzxw+f9PQssBAvpEC80Vfsx5q9fen81lgUn0RuZ7mYzh
         VtcJjoZgQaDVwPgnTNgK9URFroVXDLHB2qttGDEfaNjA+rHZXmFHAKp0pTiR5sZtC7Xr
         /9lqXEkpH+pG9ldO3gndk0wekFqccgVy+AdIjKhTa1EL/IFN/w+itkOq+mlNrJjuvfHj
         QgcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708682478; x=1709287278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+imelKk34ScyPqozaBb4Uj6heZ6F/trGf/qMfVX4OiQ=;
        b=qYaJneFH66gXw60INlwG9P5FO2etVk0Q5o678kdarmPiaDOjdmfmUI3G3WaJrxVksg
         Nj2vOCgB4QQalnPw24wc9ghGO9XWIzv1M4rWCPZrkNXuaFm90WI6qiWMClMr+1OlsfxK
         NF1T2cYmL7JURhrTygP98w1oPn0i6b3FDk5Rq2mizYJNxakC7MtHvEWtXdwluVfXoXcn
         Fn3qemVRf35WaGLJ2ZvMOrQNZM9/tvb/f5SH8vP1kIcpayTYVZz4aH2eGN3wlPQfhTn3
         kL8S40Ts6+HxMIzumtRVI/jG6NZTogdDG+b6pjEh4m6dUwFzXexIPO+H2BjxxlMSxp08
         MfDg==
X-Gm-Message-State: AOJu0YwXO6K7bTOaURpgP/+njH5svo1GjXyvyzEDw8PZRikeYl2ySM5z
	grlfWVP5ElbdCUo56hxA/zJYvhUOfCkrFm5eMvmVvNllwqpSC8S3qYPuzPICwG0=
X-Google-Smtp-Source: AGHT+IHxbizbmK03di/Ydat9S3flOu7t0ujGtIQGSWLtoEx4d9kdchVcfv+o5/M00IRqrw10fTU/KQ==
X-Received: by 2002:a17:906:a40f:b0:a3e:e678:c2ae with SMTP id l15-20020a170906a40f00b00a3ee678c2aemr848588ejz.10.1708682477575;
        Fri, 23 Feb 2024 02:01:17 -0800 (PST)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:660d:e728:4b64:50ff])
        by smtp.gmail.com with ESMTPSA id ha1-20020a170906a88100b00a381ca0e589sm6734917ejb.22.2024.02.23.02.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 02:01:17 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	phillip.wood123@gmail.com,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5 2/5] refs: extract out `loose_fill_ref_dir_regular_file()`
Date: Fri, 23 Feb 2024 11:01:09 +0100
Message-ID: <20240223100112.44127-3-karthik.188@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240223100112.44127-1-karthik.188@gmail.com>
References: <20240119142705.139374-1-karthik.188@gmail.com>
 <20240223100112.44127-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extract out the code for adding a single file to the loose ref dir as
`loose_fill_ref_dir_regular_file()` from `loose_fill_ref_dir()` in
`refs/files-backend.c`.

This allows us to use this function independently in the following
commits where we add code to also add pseudorefs to the ref dir.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs/files-backend.c | 62 +++++++++++++++++++++++---------------------
 1 file changed, 33 insertions(+), 29 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 75dcc21ecb..65128821a8 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -229,6 +229,38 @@ static void add_per_worktree_entries_to_dir(struct ref_dir *dir, const char *dir
 	}
 }
 
+static void loose_fill_ref_dir_regular_file(struct files_ref_store *refs,
+					    const char *refname,
+					    struct ref_dir *dir)
+{
+	struct object_id oid;
+	int flag;
+
+	if (!refs_resolve_ref_unsafe(&refs->base, refname, RESOLVE_REF_READING,
+				     &oid, &flag)) {
+		oidclr(&oid);
+		flag |= REF_ISBROKEN;
+	} else if (is_null_oid(&oid)) {
+		/*
+		 * It is so astronomically unlikely
+		 * that null_oid is the OID of an
+		 * actual object that we consider its
+		 * appearance in a loose reference
+		 * file to be repo corruption
+		 * (probably due to a software bug).
+		 */
+		flag |= REF_ISBROKEN;
+	}
+
+	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
+		if (!refname_is_safe(refname))
+			die("loose refname is dangerous: %s", refname);
+		oidclr(&oid);
+		flag |= REF_BAD_NAME | REF_ISBROKEN;
+	}
+	add_entry_to_dir(dir, create_ref_entry(refname, &oid, flag));
+}
+
 /*
  * Read the loose references from the namespace dirname into dir
  * (without recursing).  dirname must end with '/'.  dir must be the
@@ -257,8 +289,6 @@ static void loose_fill_ref_dir(struct ref_store *ref_store,
 	strbuf_add(&refname, dirname, dirnamelen);
 
 	while ((de = readdir(d)) != NULL) {
-		struct object_id oid;
-		int flag;
 		unsigned char dtype;
 
 		if (de->d_name[0] == '.')
@@ -274,33 +304,7 @@ static void loose_fill_ref_dir(struct ref_store *ref_store,
 					 create_dir_entry(dir->cache, refname.buf,
 							  refname.len));
 		} else if (dtype == DT_REG) {
-			if (!refs_resolve_ref_unsafe(&refs->base,
-						     refname.buf,
-						     RESOLVE_REF_READING,
-						     &oid, &flag)) {
-				oidclr(&oid);
-				flag |= REF_ISBROKEN;
-			} else if (is_null_oid(&oid)) {
-				/*
-				 * It is so astronomically unlikely
-				 * that null_oid is the OID of an
-				 * actual object that we consider its
-				 * appearance in a loose reference
-				 * file to be repo corruption
-				 * (probably due to a software bug).
-				 */
-				flag |= REF_ISBROKEN;
-			}
-
-			if (check_refname_format(refname.buf,
-						 REFNAME_ALLOW_ONELEVEL)) {
-				if (!refname_is_safe(refname.buf))
-					die("loose refname is dangerous: %s", refname.buf);
-				oidclr(&oid);
-				flag |= REF_BAD_NAME | REF_ISBROKEN;
-			}
-			add_entry_to_dir(dir,
-					 create_ref_entry(refname.buf, &oid, flag));
+			loose_fill_ref_dir_regular_file(refs, refname.buf, dir);
 		}
 		strbuf_setlen(&refname, dirnamelen);
 	}
-- 
2.43.GIT

