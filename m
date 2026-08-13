Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4164C473C73
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 15:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786636131; cv=none; b=h9CApQjuMVUlPgy9A5kl/uj+ql3o94b+2/MFWAcE9zhtmsEuhGwkrsjoBhAwPNvL8mTfMOJklGFYYtXujhnBx0ZwzuuI4i7iMnZSuHaUTfy9tEpdA7GAEBeeQ9a71cZmX/dr4bORKqQU+wun/1lmlOYCftjG07l9kX4pMfN6nOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786636131; c=relaxed/simple;
	bh=cEM1YKYLj+vjKaOdduxqQcsPqFdJCZllZgcUyVp/yZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mpvUEVuVqJFGsXKxW+D8COm3803sla+4niEfkV5zRgt9lVxgapWmosrvyN8DlfPlflr3ffrf97DYbLYiM33u+kw8yQIYKLCbuhwhHUqivy4s6p+bWQwCa9uY8gN3J3vIyTCbHErpGJzE29nbP/k/LB567tpTXfTzHly4p76kgZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqIJyJJZ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqIJyJJZ"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4956242332dso625325e9.2
        for <git@vger.kernel.org>; Thu, 13 Aug 2026 08:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786636126; x=1787240926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KlUSOlZg4R9j2TcjfyGsrhpfOZS/WxbM4Fq3Xz1RXQE=;
        b=nqIJyJJZ726AIPeHqllcp728FGUC10Hpy/WBLNi3uBsdneCgMgXIH+aDymz9MU6vM0
         i4tNfkWjcByTN6hpEega7vP+A9BHKQJRvjHjisyarTRwOd/S93dZqsW5IuHR5PboKpTf
         f9lwmftthoygGD8aT9pS3yM80Y2xLWB+d14US64E3W8XRgyvNRjw2cuXJWGW/irRuM7A
         r8mti6LOBDwmamBzgqPXEjBPMJjKZVMKVUhb3Wq1NzqYJn2/lZ2IbrtUeDbsbAqm6WBy
         GrZtlJQ3AZLwayE+1XhTW/vASOVQezjLtxACbkVDIWvW62l5Q/1gA7HvZ4aOztYw6wbh
         3ASw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786636126; x=1787240926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KlUSOlZg4R9j2TcjfyGsrhpfOZS/WxbM4Fq3Xz1RXQE=;
        b=QG93rWdxThPyPNBZRTNMbLyLy5aNLkoQ+wvJH7aytamLmCHFfBjio3IeHf37CeUR+Y
         cqwmmIEieHa2ruVAKtD7VOVbhI2SBWInrN1TpE1+kf2zOp7Yvr55aWqQkf5agtcXtHh3
         fWccHpbFxCDdWS3ofSqA0cePYpAvpbreHsyDziT8cZ3bt/Hiq6drORiN2y9Vciac6db/
         TLaEDZ5U/+N5ReVrF7B585e2BXTkKBcXpzsGquojKwr+rLmR8ehsp6AA1Wm4zuD+LKIN
         TMUzoxyuPseuJ6hgL3yira9AtPtzVDhINlhXEyEewwhH8nqGfo63RyEbltGlKZADQOoQ
         NNFA==
X-Gm-Message-State: AOJu0YxhuH3G8SbYWiKk8wHmc7Ih4IJkCpGp0VY0f7QWfBcN11o/RoHM
	5JxNBArUlgmnstmAVh9N3rhaqpta6N+/4y6hp28TqdcZ+rSa1+blzdVdzPHqSw==
X-Gm-Gg: AR+sD13WEZylJHlnxEcuxGWeTtSmt5Gc9qEBhhyyryIguepSbzQgZW6LdF5v5FAcLnY
	Gg/t3aSEa8Qvm2WPVXY+FB0Q/Iz13uazewaRIz83xbaPVR141vNpk1SJE2JnQtpNZLI9tTOySly
	tEG+UlDi0hsoBT+Ef4P5Rimb87QCmlynIrp06p57ddZqR/HBNE2RAz3w/hehNi+8YIQcKucRv1+
	Duzuqlnx5vmqv/sFYy1x1lIpEIT2DTX9pVWKP+ZWkyR09vHEyFRItemqoXnfduvnqTpAGQLJlme
	FrHFOJ1KLl5B/DLDi17OpirisVIpql32f+aGO6MPyZGJiwFcud9QIya5o9yk66uhEz6a4Q76q88
	A+IKc2eMC3tyMC2nW5yl8fp/Qs3K36H5z6yYRiqkyK9fMKUgM7N2VmDcm9AqkSkE5vnguXSdpRt
	z6ytWNdXwrecq269dA3mHd0FQLoxM4Ha7DvqkTPuu4yefZnv9S0YGU67/uDs0Fna5IDbZvBT+Mo
	LC7Xx6PovqPepoTXck/CKgW29Ws5jqMh5HA1CvIkgmyoT1QRMWBq5MwRr7wUBpx+Rq1wxgjBp3M
	L2SF+l4twivJehQ=
X-Received: by 2002:a05:600c:4f87:b0:499:8191:62c7 with SMTP id 5b1f17b1804b1-499821d7e83mr78880305e9.18.1786636126214;
        Thu, 13 Aug 2026 08:48:46 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([2001:863:5c0:e90b:439b:8502:172e:8dcf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499821217acsm60633555e9.2.2026.08.13.08.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 08:48:45 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 3/5] setup: add 'allow_dot' arg to path_allowlist_apply()
Date: Thu, 13 Aug 2026 17:47:46 +0200
Message-ID: <20260813154748.2378747-4-christian.couder@gmail.com>
X-Mailer: git-send-email 2.55.0.547.gbb97bea608.dirty
In-Reply-To: <20260807135511.1818458-1-christian.couder@gmail.com>
References: <20260807135511.1818458-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A previous commit created path_allowlist_apply() with the goal of later
reusing that function. But when it will be reused in a following commit
this function will need to reject non-absolute paths including those
with a single dot that are currently accepted.

To prepare for reusing path_allowlist_apply(), let's add a
`bool allow_dot` argument to it, and let's export this function.

While at it let's document it properly in "setup.h".

Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 setup.c |  9 +++++----
 setup.h | 28 ++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/setup.c b/setup.c
index 39dfa1cc5f..a09e697e3a 100644
--- a/setup.c
+++ b/setup.c
@@ -1339,8 +1339,9 @@ static int canonicalize_ceiling_entry(struct string_list_item *item,
 	}
 }
 
-static void path_allowlist_apply(const char *key, const char *value,
-				 const char *target_path, int *is_match)
+void path_allowlist_apply(const char *key, const char *value,
+			  const char *target_path, int *is_match,
+			  bool allow_dot)
 {
 	char *allowed = NULL;
 	char *normalized = NULL;
@@ -1366,7 +1367,7 @@ static void path_allowlist_apply(const char *key, const char *value,
 	 * OK", which is slightly tighter than "*" that allows
 	 * discovery.
 	 */
-	if (!is_absolute_path(allowed) && strcmp(allowed, ".")) {
+	if (!is_absolute_path(allowed) && (!allow_dot || strcmp(allowed, "."))) {
 		warning(_("%s '%s' not absolute"), key, allowed);
 		goto end;
 	}
@@ -1410,7 +1411,7 @@ static int safe_directory_cb(const char *key, const char *value,
 	if (strcmp(key, "safe.directory"))
 		return 0;
 
-	path_allowlist_apply(key, value, data->path, &data->is_safe);
+	path_allowlist_apply(key, value, data->path, &data->is_safe, true);
 
 	return 0;
 }
diff --git a/setup.h b/setup.h
index 654f10e059..d4f8af5457 100644
--- a/setup.h
+++ b/setup.h
@@ -304,4 +304,32 @@ struct startup_info {
 extern struct startup_info *startup_info;
 extern const char *tmp_original_cwd;
 
+/*
+ * Apply the path allowlist in 'value' against 'target_path' setting
+ * '*is_match' accordingly.
+ *
+ * `value` is the value of a multi-valued config variable named `key`
+ * that holds an allowlist of paths. `target_path` is the (normalized)
+ * path being tested. `*is_match` is updated in place:
+ *
+ *   - an empty value resets it to 0 (so a later, more specific config
+ *     scope can clear entries from a broader one),
+ *   - "*" sets it to 1 (allow everything),
+ *   - "<path>" sets it to 1 if <path> equals `target_path`,
+ *   - "<path>" + "/" + "*" sets it to 1 if <path> is a leading
+ *     directory of `target_path`,
+ *   - any other (unmatching) value leaves `*is_match` unchanged.
+ *
+ * Non-absolute values are rejected with a warning, except "." when
+ * `allow_dot` is set (used by 'safe.directory' to mean "the top level
+ * of the current repository").
+ *
+ * Callers are expected to invoke this once per config value,
+ * typically from a protected-config callback, so that untrusted
+ * repository config cannot influence the decision.
+ */
+void path_allowlist_apply(const char *key, const char *value,
+			  const char *target_path, int *is_match,
+			  bool allow_dot);
+
 #endif /* SETUP_H */
-- 
2.55.0.565.gc116661202

