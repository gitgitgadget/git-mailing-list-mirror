Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED3218B04
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 10:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708682481; cv=none; b=im1aNpYMQ9CkvCJ6zfq8S8/K1UbdYQYLjEuuGQSx528A2c4HedXyVDpU3bf14/q2BKyRTBCBmpgeR1okDZcNWzjBftmfac1uI9ENj+okgthUugVkW78/IHGveREcsQR4saM42pMmnicx+1QomT7emFcJ7vl8Ia8CXC6KaDy/otw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708682481; c=relaxed/simple;
	bh=yzRxaL+HHK8Zu68BOpG4ssldBsb6EFGbH6VT0IItJj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EqImF2mUC5jy/zURFkcmbMRwOtz+LE2O7QBch2oxPGZXlQGOWHlMuY5IM1RkPVI/aBQDL8fyW11JPpu4kwLDxuL/ke2GKd/2W5v0Xy3/c3+Iv9vFvdCY0encYXYSbCIhlQSSWpn0shIVE/YGPNTagDdW6OVgpvWpTnYqV40vJLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHkB4rLs; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHkB4rLs"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3e75e30d36so126180666b.1
        for <git@vger.kernel.org>; Fri, 23 Feb 2024 02:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708682477; x=1709287277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PctASsrsThL9yoXZ71bHQqXE+0f5q6v2Pb/muS/pwq8=;
        b=CHkB4rLsY3+O9ETU0OrtEzCmX4nMgQc/feg3Abb4yOTVgT4yMcyzq562OsGk9NuEZE
         7lNRdZ9jmCfc2E3ByqVWmPtyVfA6sS/2xJ9g7W9htAyt1VsRUrGkaWeTnwklDdzlaYN4
         nywo4DbAA/myFAi/BekHLxOEBPRJdYjlls0NlHbYN70+YKfAovYDj69Tqu2MSz/uRVBB
         ijN0LTqunK0916IprNI8KVASUdBVDQoEcZtaiC8to5Cy00UHY0ZxHY2LrAP1yeCZF42A
         QU8U4kxhPICHVCJ8H+icAsyAjrh1UtbxEsVn+AR+M1L/X4mHoHRgtzoNiYjtVfwPuDON
         M1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708682477; x=1709287277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PctASsrsThL9yoXZ71bHQqXE+0f5q6v2Pb/muS/pwq8=;
        b=JjwSmrnFanPyClnKLtudUBfLfXir0LFbB+mAL2dV/dMiqkB9vhkLeOyrDdG77aFXRa
         2hMMe3FARLGRi6VlqE1hsFAGaq0t2/0S7HKalj1aghv4gkDX5C1bKu2l7y7G5BOSd07C
         RpLDf2bPR/MKc/fZcLP1hEYzlxFJvk93Ilu4IjNB6x0FxHkafNxsO7NOgPkz21EH2Rnd
         IU8ZeA2B00q8pknk9N7+mUZIpxeQaHETJBzIWm4MJZRFSpnjfJaoNYHF3jrJMho/sZnS
         dFNZQemnF8wGON1mk9PAI+bf4guXjx1iE8YEeNdIaS2WwSoNvgAaLQGfChoxBy4jw6K6
         lWmg==
X-Gm-Message-State: AOJu0Yy9QLoOs8ffNF6POgYFFrqK2UEdJIOYG3hEc1Bv8Y4nVf+WzXkx
	UuRG2CWWxBc4Elk9oyQT9MmJx7sRlsv8FqM2Dx0M+ptWaPrUcNgo0CzPt/awaOw=
X-Google-Smtp-Source: AGHT+IG6xMuKAW+NhbKnF8BMki8aayL5oGdCECRBBLwlk2MTQ4wzjx2GDwjJ4O34H0styKBIWBjorQ==
X-Received: by 2002:a17:906:3b0b:b0:a3e:7f80:ecac with SMTP id g11-20020a1709063b0b00b00a3e7f80ecacmr4222631ejf.12.1708682476780;
        Fri, 23 Feb 2024 02:01:16 -0800 (PST)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:660d:e728:4b64:50ff])
        by smtp.gmail.com with ESMTPSA id ha1-20020a170906a88100b00a381ca0e589sm6734917ejb.22.2024.02.23.02.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 02:01:16 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	phillip.wood123@gmail.com,
	Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v5 1/5] refs: introduce `is_pseudoref()` and `is_headref()`
Date: Fri, 23 Feb 2024 11:01:08 +0100
Message-ID: <20240223100112.44127-2-karthik.188@gmail.com>
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

Introduce two new functions `is_pseudoref()` and `is_headref()`. This
provides the necessary functionality for us to add pseudorefs and HEAD
to the loose ref cache in the files backend, allowing us to build
tooling to print these refs.

The `is_pseudoref()` function internally calls `is_pseudoref_syntax()`
but adds onto it by also checking to ensure that the pseudoref either
ends with a "_HEAD" suffix or matches a list of exceptions. After which
we also parse the contents of the pseudoref to ensure that it conforms
to the ref format.

We cannot directly add the new syntax checks to `is_pseudoref_syntax()`
because the function is also used by `is_current_worktree_ref()` and
making it stricter to match only known pseudorefs might have unintended
consequences due to files like 'BISECT_START' which isn't a pseudoref
but sometimes contains object ID.

Keeping this in mind, we leave `is_pseudoref_syntax()` as is and create
`is_pseudoref()` which is stricter. Ideally we'd want to move the new
syntax checks to `is_pseudoref_syntax()` but a prerequisite for this
would be to actually remove the exception list by converting those
pseudorefs to also contain a '_HEAD' suffix and perhaps move bisect
related files like 'BISECT_START' to a new directory similar to the
'rebase-merge' directory.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c | 41 +++++++++++++++++++++++++++++++++++++++++
 refs.h |  3 +++
 2 files changed, 44 insertions(+)

diff --git a/refs.c b/refs.c
index fff343c256..3546d90831 100644
--- a/refs.c
+++ b/refs.c
@@ -860,6 +860,47 @@ static int is_pseudoref_syntax(const char *refname)
 	return 1;
 }
 
+int is_pseudoref(struct ref_store *refs, const char *refname)
+{
+	static const char *const irregular_pseudorefs[] = {
+		"AUTO_MERGE",
+		"BISECT_EXPECTED_REV",
+		"NOTES_MERGE_PARTIAL",
+		"NOTES_MERGE_REF",
+		"MERGE_AUTOSTASH",
+	};
+	struct object_id oid;
+	size_t i;
+
+	if (!is_pseudoref_syntax(refname))
+		return 0;
+
+	if (ends_with(refname, "_HEAD")) {
+		refs_resolve_ref_unsafe(refs, refname,
+					RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
+					&oid, NULL);
+		return !is_null_oid(&oid);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(irregular_pseudorefs); i++)
+		if (!strcmp(refname, irregular_pseudorefs[i])) {
+			refs_resolve_ref_unsafe(refs, refname,
+						RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
+						&oid, NULL);
+			return !is_null_oid(&oid);
+		}
+
+	return 0;
+}
+
+int is_headref(struct ref_store *refs, const char *refname)
+{
+	if (!strcmp(refname, "HEAD"))
+		return refs_ref_exists(refs, refname);
+
+	return 0;
+}
+
 static int is_current_worktree_ref(const char *ref) {
 	return is_pseudoref_syntax(ref) || is_per_worktree_ref(ref);
 }
diff --git a/refs.h b/refs.h
index 303c5fac4d..f66cdd731c 100644
--- a/refs.h
+++ b/refs.h
@@ -1023,4 +1023,7 @@ extern struct ref_namespace_info ref_namespace[NAMESPACE__COUNT];
  */
 void update_ref_namespace(enum ref_namespace namespace, char *ref);
 
+int is_pseudoref(struct ref_store *refs, const char *refname);
+int is_headref(struct ref_store *refs, const char *refname);
+
 #endif /* REFS_H */
-- 
2.43.GIT

