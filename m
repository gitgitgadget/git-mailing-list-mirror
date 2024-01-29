Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63E354FBB
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 11:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706528136; cv=none; b=J845Wf9RxnVHNkNyTLXNCJVg21sdW14ZwK956JnUYKnFcStbjNjl+6lyt4/LEB7vVRQGo0DthSavyV4IwimdJ91CFIf7nv9eQGiNZL71PusB0zw3wrlJEoPNS/ZpFHFlaTkqiPGF9DTqq9glDzzU80eaOmF9M/A91RP5BiSgWe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706528136; c=relaxed/simple;
	bh=xLRzHVxAb6yE48U+yCsGxkaSKBAxWnHRv+3oV+3kC2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pWB+nlpN7RKKQhp5iwtrvJ7iOGeY1p8rMVjGqAFdE8E/yDbhqMQz3gVAtE83vW/vsv/VPCDKKqOx1iXbs2ZOi8vSiJiwd0JXq233sJ8nWvBNyv/MdafKw5+ib0sFhsyBD95xArb1xvE8xVmDlz40YJM+lL9ZHdI5c7h7zk536H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W72Jmr8l; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W72Jmr8l"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a349ed467d9so273214566b.1
        for <git@vger.kernel.org>; Mon, 29 Jan 2024 03:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706528132; x=1707132932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0QdqheKohmNqkn6q3r847fLESw/iqNJvvwGo0uDUC7k=;
        b=W72Jmr8lvG49WncCKTlSTLqX1CIZAKYjqWhPSdc7nqVSpKoLVgJOLpJH9W9+YaK6On
         UNh4HYqqIdDAyTdc691zy7P2R70YT3UnQV2UEG9wBYSemlXTFu9COPin+o2Yv19//wDk
         sks7CzRJXyT8jIfQ2cfVPvuMKw5K1Fki2qGrWETzCYVvofTfrB9RewEu01OKxYc4f8bu
         scj34P+uKMESLvvtfMv/xMAz25duey8srnyk6IkVcObldGjpasBwK+ZQ93iiYF68G+1E
         +nSchLYjubPxmoo9nv0D1I7cmRBnF0vlrVrB322vYRpPtVIGI/nCMGZAD2bO1gnF102W
         rhjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706528132; x=1707132932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0QdqheKohmNqkn6q3r847fLESw/iqNJvvwGo0uDUC7k=;
        b=xO+auvtePxwC6qqiLcpe5vgGLJ7P8wXWp5zu01oLXuHy7xGYdYriv/ST+8cMTZw38v
         qREAmoow1dRTSP6TiPhsLZIEjUPFvKal1VJFQLYrstfItOi5NeGlhttwQsdXKTpF0mMT
         QuUnEGSgisk13ldH1aRyrxhITDrZS1yJyyBqeekmMNqHreOFok1iMpryVzQk40bhQiPP
         HRfs4JXLDFAE1uxVTTLy75R0q2EXS4z6QzdgTN5QxPLekFcCoMq67vhxiPyZV7JeLF2j
         UGmrrnuRrMsuS1xCcv9y34X5JTihnY2nL5duipNMqKM6poDfXhPQdM12o3iN4NqCokhG
         GRaA==
X-Gm-Message-State: AOJu0Yx+1DcTZCdSXbAIBDWLzpzWVD8MhkK+JRHn8fPCpwn9ATWTSDX+
	YSilVxKy0nMtrV0whIuNnJh65Z+noRcOMg6d4trdiR4ijSqH/vrHpKcOAXoD
X-Google-Smtp-Source: AGHT+IG6aNL+BREbZaI41O/8NiX5vYJztTOr2+HkfWnWnCFYGwJ5J7MpZjEphLmxBI8qlKhlYYx54Q==
X-Received: by 2002:a17:906:17d6:b0:a35:6767:855c with SMTP id u22-20020a17090617d600b00a356767855cmr2856549eje.7.1706528132361;
        Mon, 29 Jan 2024 03:35:32 -0800 (PST)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:74c1:f49b:306a:744b])
        by smtp.gmail.com with ESMTPSA id y9-20020a170906070900b00a35a3e2b90asm1370325ejb.149.2024.01.29.03.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 03:35:32 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	phillip.wood123@gmail.com,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 1/4] refs: introduce `is_pseudoref()` and `is_headref()`
Date: Mon, 29 Jan 2024 12:35:24 +0100
Message-ID: <20240129113527.607022-2-karthik.188@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129113527.607022-1-karthik.188@gmail.com>
References: <20240119142705.139374-1-karthik.188@gmail.com>
 <20240129113527.607022-1-karthik.188@gmail.com>
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

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c | 39 +++++++++++++++++++++++++++++++++++++++
 refs.h |  3 +++
 2 files changed, 42 insertions(+)

diff --git a/refs.c b/refs.c
index 20e8f1ff1f..559f5aeea8 100644
--- a/refs.c
+++ b/refs.c
@@ -859,6 +859,45 @@ static int is_pseudoref_syntax(const char *refname)
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
+		 read_ref_full(refname, RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
+		      &oid, NULL);
+		 return !is_null_oid(&oid);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(irregular_pseudorefs); i++)
+		if (!strcmp(refname, irregular_pseudorefs[i])) {
+			read_ref_full(refname, RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
+						  &oid, NULL);
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
index 11b3b6ccea..46b8085d63 100644
--- a/refs.h
+++ b/refs.h
@@ -1021,4 +1021,7 @@ extern struct ref_namespace_info ref_namespace[NAMESPACE__COUNT];
  */
 void update_ref_namespace(enum ref_namespace namespace, char *ref);
 
+int is_pseudoref(struct ref_store *refs, const char *refname);
+int is_headref(struct ref_store *refs, const char *refname);
+
 #endif /* REFS_H */
-- 
2.43.GIT

