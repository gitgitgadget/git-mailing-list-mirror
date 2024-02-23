Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D27D26B
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 03:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708658320; cv=none; b=W0F6gpp3oVnulv3Bi5D8niz3NFKCuoNvUC9xxMD9VZ/C4HmDC9ZTFgzhZXrnNNz9wNOvwTDKdv7gC71Ir+ShtEd3RMbtS9A9+CucoGPx0iaLlVpEB7oonIU8AsU+6rpOBXYu7MIVwfHfjQEDXCl9UF76SEEgeeUa8k8fz95DhB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708658320; c=relaxed/simple;
	bh=89YU0+PdNITDh+80ewZPlvSxBw/G6dgqRHGSTQpT9LI=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=VCVYSGfg+PqyXEcUc9lfMu2bjPRpRYE3EGKYpZdbepSpy4dglVcy7o63u4oJesx3ILTZqN9YUbpfnxwCDi6aRLQHnfisemI13WI3R4rh37zM7clYzspMkGUY7cRhfIITGaaf1O7t+RDlzpaTHEp7ksXwBz2oXHa4DUH9KoOKG/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W1gWKDZ5; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1gWKDZ5"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4129015c31eso2843785e9.2
        for <git@vger.kernel.org>; Thu, 22 Feb 2024 19:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708658317; x=1709263117; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQ7D8m7FRmDmzSp4UQ4i0bLa6tugBVKmqCDi28v96ow=;
        b=W1gWKDZ5DhZ90ZT4N/UI5nvx8kO+Kt1qU1GrMOuAdL3TBT19Nfy2Hi1py8XGs4OVuk
         3KzftkZGPvxgXMdlnettgVQxFUs7j+1A8jIyfrRt6ostfOZV7gUomlbxvAbzsydvG7Ur
         SxERzTHKrDycwocH7Ay1H0aGcXGOGF/3Whs4NAaPhPWpE+09Sk9gHWZxXTQPsL5rBOPZ
         QA1c1xb7u8VHHuKsP9dnhbDIwVUCbCZK8KpKdYMVGACZ0lnozaoDbBZY2G1p4Vfuyb3O
         3twVbGMq7BPScJJx4ftcSNx+V/wBot0FBkmBR3NziTKupBhvXYljg1MITMS/4HbAtI3w
         /xtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708658317; x=1709263117;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YQ7D8m7FRmDmzSp4UQ4i0bLa6tugBVKmqCDi28v96ow=;
        b=kpO236RHap2zyJDmphXJnMW1XuVW5Q5KZjqIQ+2nqtjlT/expWIAiq1kTEAR4+miyN
         xTDP3Sh6+ysBEuFBitghBotCYLA02EFDOurF3lKBp1sF48isBxxV3sSJMjunW5HSpyk6
         2/NxwKP5VK+Uy4hKiS1iCtW5oeHApv+1294YUASz12DsGpX3RSw5dY+mVyWEOUm6B0AF
         aKIa810JKS546v4EK2tkLpK2z5Z35lIRogFV4+6AU8lUqmGvyDpUeTzkrB1OCupq8esK
         lIMeBKay0RK2kiIukUjtflQ1OoqdjnkyrKQXgSCZdAlU9d5uYjScQPVfcEKyf4LXGRVU
         427w==
X-Gm-Message-State: AOJu0Yy6iRmuf1o4I+Hj5pg8BwccovpOBLaFGwYNilO+nLAYwQxj2/2j
	M1fg0zgiyBzh2ZwzpeBZCNZasaapPk3oS7Mg7gM3H+sV94Dc8GhrTnme/c+v
X-Google-Smtp-Source: AGHT+IEMLtIIpWgBLTgpazGpozheaGdJx8iqUTZsD1CBepKAF/2IYgkc4iyvjnJNVu3sdP6SwTc+aw==
X-Received: by 2002:a05:600c:2e43:b0:412:8f5c:cd08 with SMTP id q3-20020a05600c2e4300b004128f5ccd08mr339640wmf.22.1708658316849;
        Thu, 22 Feb 2024 19:18:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c23-20020a7bc857000000b004128f1ace2asm579478wml.19.2024.02.22.19.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 19:18:36 -0800 (PST)
Message-ID: <3a20065dbf80eabfc62c0bdebc16df0b5a4c7b02.1708658300.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
References: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
	<pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
From: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 23 Feb 2024 03:18:19 +0000
Subject: [PATCH v2 15/16] fsmonitor: refactor bit invalidation in refresh
 callback
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Jeff Hostetler <git@jeffhostetler.com>,
    Jeff Hostetler <jeffhostetler@github.com>,
    Jeff Hostetler <jeffhostetler@github.com>

From: Jeff Hostetler <jeffhostetler@github.com>

Refactor code in the fsmonitor_refresh_callback() call chain dealing
with invalidating the CE_FSMONITOR_VALID bit and add a trace message.

During the refresh, we clear the CE_FSMONITOR_VALID bit in response to
data from the FSMonitor daemon (so that a later phase will lstat() and
verify the true state of the file).

Create a new function to clear the bit and add some unique tracing for
it to help debug edge cases.

This is similar to the existing `mark_fsmonitor_invalid()` function,
but we don't need the extra stuff that it does.

Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
---
 fsmonitor.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index ac638a61c00..0667a8c297c 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -187,6 +187,20 @@ static int query_fsmonitor_hook(struct repository *r,
 static size_t handle_path_with_trailing_slash(
 	struct index_state *istate, const char *name, int pos);
 
+/*
+ * Invalidate the FSM bit on this CE.  This is like mark_fsmonitor_invalid()
+ * but we've already handled the untracked-cache and I want a different
+ * trace message.
+ */
+static void invalidate_ce_fsm(struct cache_entry *ce)
+{
+	if (ce->ce_flags & CE_FSMONITOR_VALID)
+		trace_printf_key(&trace_fsmonitor,
+				 "fsmonitor_refresh_callback INV: '%s'",
+				 ce->name);
+	ce->ce_flags &= ~CE_FSMONITOR_VALID;
+}
+
 /*
  * Use the name-hash to do a case-insensitive cache-entry lookup with
  * the pathname and invalidate the cache-entry.
@@ -224,7 +238,7 @@ static size_t handle_using_name_hash_icase(
 
 	untracked_cache_invalidate_trimmed_path(istate, ce->name, 0);
 
-	ce->ce_flags &= ~CE_FSMONITOR_VALID;
+	invalidate_ce_fsm(ce);
 	return 1;
 }
 
@@ -316,7 +330,7 @@ static size_t handle_path_without_trailing_slash(
 		 * cache-entry with the same pathname, nor for a cone
 		 * at that directory. (That is, assume no D/F conflicts.)
 		 */
-		istate->cache[pos]->ce_flags &= ~CE_FSMONITOR_VALID;
+		invalidate_ce_fsm(istate->cache[pos]);
 		return 1;
 	} else {
 		size_t nr_in_cone;
@@ -394,7 +408,7 @@ static size_t handle_path_with_trailing_slash(
 	for (i = pos; i < istate->cache_nr; i++) {
 		if (!starts_with(istate->cache[i]->name, name))
 			break;
-		istate->cache[i]->ce_flags &= ~CE_FSMONITOR_VALID;
+		invalidate_ce_fsm(istate->cache[i]);
 		nr_in_cone++;
 	}
 
-- 
gitgitgadget

