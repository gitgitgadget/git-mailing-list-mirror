Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C58A1EE011
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 13:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729259587; cv=none; b=B/SzWhPM95PKIrqwd36o75J9AB4ipqza3h7utbIfkZQ7vF7d0HTsSbvNh+EJAbezF8b/wf1WGUKj86odQy26PFmSHXXRAKciIvguLGg3SElkgCDlGMmTNv5ysC3urrjRqxUyMUCE3X5OVJo/1satLoe83fJindwizPRZY66KUGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729259587; c=relaxed/simple;
	bh=QamYZshUYCF4fo9d0iGB5cp3N4yG0prh7XF4xXdyUIM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=mAsui4SaD/skhlKrD9ADBG9MeBJ2iOnO/IEXq791u16FNjqjnhqzE+h6X2mxgs6CFYvFz4Hj819gFskCcsyaCmWcflGOm8DAhTKLspxa7/BLtagV9Ci/TPS6IUak+LaQpomHEiHllXHVCevdfEXbM6YSAz1XUFp20N/ONIUDO/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H5ab7KaE; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5ab7KaE"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a99c0beaaa2so343657066b.1
        for <git@vger.kernel.org>; Fri, 18 Oct 2024 06:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729259583; x=1729864383; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=677FCLAGKiIsR+QZtuh2A7GO7cGaurA3sfCqVHYjR5E=;
        b=H5ab7KaEn58mUjojUyr4R72O4vbyabVbC33HfOL0pdfvMwxa0M+DYmC3x6lZYzmU64
         ZecZJcN3qskVU5NoL4pIm4tppTYUXRz0Fv8Wso/SYf1bNOTP1Ebd79SJYt+2H1GXsbLq
         z6B6C8K0o1CI9A8lggsFK+TRZDWHyLCCkFhwSPLNsPZlinQ5rTo5vqotrgQ3BlwaGdH8
         FCpIzM0+7Bc+FNKmLouXVvEta4rRakKDXUGnp44nFkQqs/4zbwBj3ohbqqsiinmTfCbU
         iL78/fdElrTs62VSvN23yQYsYxXx7+3XlfDeiVhkPIJUdnGL9YhwkRutZDoZAO+t+ovc
         HNPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729259583; x=1729864383;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=677FCLAGKiIsR+QZtuh2A7GO7cGaurA3sfCqVHYjR5E=;
        b=eaSJIqf2ubB7rTg0dhqV7PsdGgDblzm5XEeFSdu7fCkMBsMzF+XrSrfItzHtcg3m/e
         Z4WnKVHv2CaI1YvroUAdFh7BUZQjdNccBMKZfp3gAqa98wMDUs5OQY0QujUzTzNDKOZY
         EDnP6SJA9MYop3QVwl5YQFf5U/m0fM09sX78Vul3WtrKBSTou5tV2jF/3awalP4eFz3H
         SblSbP1DopeYFnZI+CxGyQoyTzF7P9Kwad9a2LO4sicRjPUna2uN5HwCGNWncJKXoKv4
         URoqknFFsA6w8TrS790fxkO3w0KnZZrLFFxn1LPErqDWdpdnn6JkNn7ebAOebDGSAcWF
         vEJA==
X-Gm-Message-State: AOJu0YxwmChNnOuYD74fMmCiNtpTchaR4poqDJVRJrXBHu2ql/Fu8mFr
	VIaTs+n/SRF23k+E9jPJWrxH/nThpAHaRaI+xq2czgOnIJvtOwCxZma95w==
X-Google-Smtp-Source: AGHT+IGw/WxhoaESLefBInD88sZlh8hWPrZ9fyyyyhht7SzCIwHRQN3g+6yJVMascncuqIvu5PgEWQ==
X-Received: by 2002:a17:906:d54c:b0:a9a:129a:1862 with SMTP id a640c23a62f3a-a9a69ce1a52mr267987066b.60.1729259582775;
        Fri, 18 Oct 2024 06:53:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a68a8dbcasm100247166b.8.2024.10.18.06.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 06:53:02 -0700 (PDT)
Message-Id: <5d58c150efbed1a10e90dba10e18f8641d11a70f.1729259580.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1810.v2.git.git.1729259580.gitgitgadget@gmail.com>
References: <pull.1810.git.git.1728774574.gitgitgadget@gmail.com>
	<pull.1810.v2.git.git.1729259580.gitgitgadget@gmail.com>
From: "Usman Akinyemi via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 18 Oct 2024 13:52:59 +0000
Subject: [PATCH v2 2/3] merge: replace atoi() with strtol_i() for marker size
 validation
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
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>

From: Usman Akinyemi <usmanakinyemi202@gmail.com>

Replaced atoi() with strtol_i() for parsing conflict-marker-size to
improve error handling. Invalid values, such as those containing letters
now trigger a clear error message.
Updated the test to verify invalid input handling.

Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 merge-ll.c            | 6 ++++--
 t/t6406-merge-attr.sh | 7 +++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/merge-ll.c b/merge-ll.c
index 8e63071922b..52870226816 100644
--- a/merge-ll.c
+++ b/merge-ll.c
@@ -427,7 +427,8 @@ enum ll_merge_result ll_merge(mmbuffer_t *result_buf,
 	git_check_attr(istate, path, check);
 	ll_driver_name = check->items[0].value;
 	if (check->items[1].value) {
-		marker_size = atoi(check->items[1].value);
+		if (strtol_i(check->items[1].value, 10, &marker_size))
+			die("invalid marker-size '%s', expecting an integer", check->items[1].value);
 		if (marker_size <= 0)
 			marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
 	}
@@ -454,7 +455,8 @@ int ll_merge_marker_size(struct index_state *istate, const char *path)
 		check = attr_check_initl("conflict-marker-size", NULL);
 	git_check_attr(istate, path, check);
 	if (check->items[0].value) {
-		marker_size = atoi(check->items[0].value);
+		if (strtol_i(check->items[0].value, 10, &marker_size))
+			die("invalid marker-size '%s', expecting an integer", check->items[0].value);
 		if (marker_size <= 0)
 			marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
 	}
diff --git a/t/t6406-merge-attr.sh b/t/t6406-merge-attr.sh
index 9bf95249347..1299b30aeb1 100755
--- a/t/t6406-merge-attr.sh
+++ b/t/t6406-merge-attr.sh
@@ -118,6 +118,13 @@ test_expect_success 'retry the merge with longer context' '
 	grep "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<" actual
 '
 
+test_expect_success 'invalid conflict-marker-size 3a' '
+    echo "text conflict-marker-size=3a" >>.gitattributes &&
+    test_must_fail git checkout -m text 2>actual_error &&
+    test_write_lines "fatal: invalid marker-size '\''3a'\'', expecting an integer" >expected &&
+    test_cmp actual_error expected
+'
+
 test_expect_success 'custom merge backend' '
 
 	echo "* merge=union" >.gitattributes &&
-- 
gitgitgadget

