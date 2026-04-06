Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A69301460
	for <git@vger.kernel.org>; Mon,  6 Apr 2026 15:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775488526; cv=none; b=CKckCm5g+vC10ymxqijp2+iMrMF1o5y9v0UqrRX6UiYttHbqcQRWeFjlNtGvIPaK4ZjI7KWRFwkTBOmnWcc4lmJfFlltpkwSb2GbMIBG7FautpB3hSRyEZJCL7S19canTH5Pj+lqHjiVxqCRGTEYFhk07D0vvMuhO5qUnAck8KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775488526; c=relaxed/simple;
	bh=nrlr0XMImZMRVrPfb3WQXLMokTvUZeGPrUAl8RgyXP0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vib40vNOFN1clsMQaM+f9f2uL2luOOX5lj0eYtqT+ySNQIGsunEqW0/XuOBAwP4jsmBJVHd/82dbwCpcKEvF61sL2ZKgIYmsXAhbYeDK3ZceLvjd4ywyC+VtRb//3sq9w2HDnJTPNGwoJB6T9NZ6xurbP2dM1VVwtczDPOEN714=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qtUMy3Yi; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qtUMy3Yi"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8c6f21c2d81so364192385a.2
        for <git@vger.kernel.org>; Mon, 06 Apr 2026 08:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775488525; x=1776093325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R5GZut//GhYZ4bxcJN/dycKJedtunfbmpY0XQyGVGdc=;
        b=qtUMy3Yi3Z9oOU1JKo3Cp8wOoL1byUh1TNcVHsRNRlwa7LM48BU/YH/xFB2WlpkRJE
         JaNRVocuH/yVC3jbrVsxLl7Kin5Cr7gL2VUAk7lLni43xzmhh5Jr1+Kwc8KtO+/u4nak
         uiGQzFGygx2kgpCCGh7IoyxVGeIVLc8oThHij11v2QnDTmhYssd9pISQMwWTulkJZzlj
         nfVG/X8JRpc8y4pYizJUOf6HSncnMlQDePB5vqQoWHi81ePmQSYXrJrMjlLfJBYAbrI5
         AH8XgkczeevkVJ3uGvZTlSpdrLe8VdFGv3hDGs5D1dxucbOOyqXepoSAz3COTBbCh4KE
         0Tww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775488525; x=1776093325;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R5GZut//GhYZ4bxcJN/dycKJedtunfbmpY0XQyGVGdc=;
        b=oVCLnYcpH0Gg2c+tCjgu0XmlEJ/kzeG1nSpmg5HHIoYNI7KUev+JaXr5EeyglT35Oh
         PB1VzQgQTKadgflkHvp8XBHzJqXl6LElCLk8EHXh+mR8Sf6/uyvUKCiobp37qFD+I6s0
         NfbOJ/51qM/jRFE3oZXsPv6ufz5hwBm8ReviKfTTN4viu+mLfBdluZm/tX0GDtsWBXnq
         h2eWh0yRysVM3P9LlvJ/jPKfmexOEBdSmhrjKZY/9xwYX0HdwQybtGBZZAhuieb/QqLl
         +JCbNJBaVnWVHpAiqzuJT4GSx49j1ROKWCrvixZyIvzSZnF77p0GfWB8nNIucv5R6FJk
         UFSw==
X-Gm-Message-State: AOJu0YzBJq8A54B+cN8yo0EIR4gOCJW7PfG3lLlRMswvWpByuRKyMYd8
	BPA+Dr4SMRLjUAEjBZY/60MezY0H/JHtKZUk1UaQJZYDDzoxd3o9/Z+Jy5t1RM85Hu8=
X-Gm-Gg: AeBDiesJrfs4E21fmfNFF7Er8168LASoEqHH3npFNc+fqvVaLuNYZJwBIzVxNOzwosZ
	BD+3RSUluVyby7Xr4xfij/pUNxMw11JGR0SSgtWbNnO/jC5tVoTazheh/vkvy30kpROtdtvLHUV
	G2QODIa2jIpNCtKaZdSHlbiVt/Fu8KSIzOoIp/63Na0dOghs7hbC4/Q2ReDPIx/oKGNYF73SDdb
	sm6hULgy9hZYV43pJhZy+c8msWxew0MTaqru/El63jK/kVbvdxLg4lAwrzLhjfx/Mx7o4ktohxv
	HohMEAdTFv9ihpLmrhkSwQP1vcgsAKR2g+9aaxfQZ6MsrtPTecBgzJWbD/KbF6nPqP3hEkmC+jx
	IkjbLMgVyBhSdzM6WbOyqlAP4CdrJIm18X8EMybCsH+FUtFc5VxkchuUpZVlU8iroC1/dQC7BNI
	bpOOJivpvrJLfrmrNHDZQgNsGhEMTUlsRVTV2/7YXdpJnb3g==
X-Received: by 2002:a05:620a:1a11:b0:8cf:c75d:29fa with SMTP id af79cd13be357-8d41b8dee1bmr1913846385a.11.1775488519846;
        Mon, 06 Apr 2026 08:15:19 -0700 (PDT)
Received: from st-davidlin1 ([70.54.98.79])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d2a8067c73sm1029986485a.24.2026.04.06.08.15.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 06 Apr 2026 08:15:19 -0700 (PDT)
From: David Lin <davidzylin@gmail.com>
X-Google-Original-From: David Lin <davidlin@stripe.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	David Lin <davidlin@stripe.com>
Subject: [PATCH] cache-tree: fix inverted object existence check in cache_tree_fully_valid
Date: Mon,  6 Apr 2026 11:14:56 -0400
Message-ID: <20260406151456.63620-1-davidlin@stripe.com>
X-Mailer: git-send-email 2.52.0.ge17bebe515.stripe
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cache_tree_fully_valid() is supposed to return 0 (not valid) when a
tree object is missing from the object database. The condition
currently returns 0 when odb_has_object() succeeds, which is the
opposite of what is intended: the cache tree should be considered
invalid when the object does not exist.

Add the missing negation so the function correctly invalidates cache
tree nodes whose objects are absent.

Signed-off-by: David Lin <davidlin@stripe.com>
---
 cache-tree.c          | 2 +-
 t/t0090-cache-tree.sh | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/cache-tree.c b/cache-tree.c
index 60bcc07c3b..9fe057355c 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -238,7 +238,7 @@ int cache_tree_fully_valid(struct cache_tree *it)
 	if (!it)
 		return 0;
 	if (it->entry_count < 0 ||
-	    odb_has_object(the_repository->objects, &it->oid,
+	    !odb_has_object(the_repository->objects, &it->oid,
 			   HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
 		return 0;
 	for (i = 0; i < it->subtree_nr; i++) {
diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
index d901588294..2c6b7a0899 100755
--- a/t/t0090-cache-tree.sh
+++ b/t/t0090-cache-tree.sh
@@ -278,4 +278,12 @@ test_expect_success 'switching trees does not invalidate shared index' '
 	)
 '
 
+test_expect_success 'cache-tree is used by write-tree when valid' '
+	test_commit use-valid &&
+
+	# write-tree with a valid cache-tree should skip cache_tree_update
+	GIT_TRACE2_PERF="$(pwd)/trace.output" git write-tree &&
+	! grep region_enter.*cache_tree.*update trace.output
+'
+
 test_done

base-commit: 2855562ca6a9c6b0e7bc780b050c1e83c9fcfbd0
-- 
2.52.0.ge17bebe515.stripe

