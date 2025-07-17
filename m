Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2901F4CBC
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 01:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752716066; cv=none; b=BixdvA2QwPD4fq7vfeEcFTi8JhiPaXLCkvYnBwcrCpwJkAshFNKGc+XZyVkKSnK214NC+UG1QLS8W6eeS8nAR5RBX9FeXBXKRBK5IXirRD4CiWiyUVJTcR8a6Kp3RJTRRcO2eIXk7UXOHJGX7nmZIIMmGhK+3pNK4zq04Cl5EAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752716066; c=relaxed/simple;
	bh=MNEc01wHJrnumrR9lZcoEJ4XhJBV8Hnn4Sjgly7Pksw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=E3r1IxQHEXTubK0LH7mSJ6FxTMRK789e7oBXDpRNmj1RQPJf/Iast1W/1LIkZ7VsgGQqy+JsGVJhEBPaIgJP2jcB/x/f5nocl3X0Uc68rebdRXxHJi1TsC5lsKWCpXqKyrcGVnxSXAjV4PT05c9N2pw+mhhadyTRa8pKalbFOW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cylo0oqj; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cylo0oqj"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45619d70c72so12778145e9.0
        for <git@vger.kernel.org>; Wed, 16 Jul 2025 18:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752716063; x=1753320863; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fO3UvX/h7yQrV8EGSGWa3dnHwGJjoy26F5KoGda28Q4=;
        b=Cylo0oqjFB1I6Ne+ULxhMQmvFCNuYIeltotTuTrnPlLK1L0iCILVNdpct6iLEtObG8
         fEW2El4OdEIJWxcO5t85fFTwBKm4TmOTyW/pBczxwveDkgjynZvpOu0YsjDveLYNowq+
         LGWkUctfmwYyKjy+QGtWljz/jlncjyaQahUb4tgxzZqUV7IL8+CJofifR9xv8pmb6pBx
         h8EM12lRegaQeiJK9HJv61WV6DVATMV4jrfdGFNZtvoK7S8s/KiQXlHB7PmoeN2i4oV7
         Ln2/yh8z7Ti8Hm92otrC/DafGe4YX8YHcmUJFA009VXHt3U20jo3V4El1XSgHA8+RrvJ
         q26g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752716063; x=1753320863;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fO3UvX/h7yQrV8EGSGWa3dnHwGJjoy26F5KoGda28Q4=;
        b=ZaRNDxlBJWfXF1zm9k1Y6O3ifasgp3jfI/YxMkePYPk0ihqoeFeDGbuOfgNFeS35O3
         uLuLvDkUm2fWDWSgbUpZVQTILD9XZql6nXk4RCO66pX5GK9IAC2DTix1pdL7cguOst5i
         AV6kz46G1ig541fheMZNdqTSasRj2UjNk7ogZhBYTKX4lk4KQerHiujKZilk/0v131bl
         bLDe9TRpVAFL+z/Qto2naZGbLCYduSP5Z2qPdvqKDt0dXDNYXNV6bpsWkJfmPIkXudCp
         5vDflxLYLqp/4F9AO1fkt8rPAhIgZKBNdg19S/eGhGivYXcUe5a2Lf1JnI3v+Wyo26q8
         o7sA==
X-Gm-Message-State: AOJu0YwuPOWcGh1mNeSkp7cX+RMCaAAH3kKYJAuSfqeXLogQc4EnczTX
	yJZtCXbfx95JfzonbabhDIeOOKBayTB1JIXDz9oMzjzXBmfSZ+iQtgcIPYGmIQ==
X-Gm-Gg: ASbGncv5ejmBHzbUg8nDpo86V9C4E9YM+eBT1iDHqj5sPUGJkJ85KVnfjsuod+bEZtC
	bw2EvJ1mhDMJGVDlJjViL//mkDHF243QgnYHLLm+tEXinRhZHUCybQywGaRP820p6PkTu4JAoYK
	PEzk89hOR1IeB3vwBuBBcZT0z6HO9dZm+IEF3AmDkLQFy3liP0mOwASEbNXjmSajmrAHY2ESf0O
	a3uLpEhfConh4chUC29d5XizoZqsvdNEAFPqV86rKC3W37N8X45iMA8sxQI50MN/ZWjKhzBaEc5
	N8vBtlzpP4GdUFhWcjgGrykBNelRHNy7kiaq29DDutthm+eZ7HijM3DA/OHv9I0+VOc9lFBu187
	zVf9fnXm8qYYHkIThNOGRiF7BXGYWYOgm1A==
X-Google-Smtp-Source: AGHT+IFWsSPPdVFW60ZCnsOttE3OJYiWxXU3mFbhC7ppcfSmiQBULvRz6g+iYTdkOlTVqqSZb1gkFA==
X-Received: by 2002:a05:600c:339a:b0:456:18e:eb7f with SMTP id 5b1f17b1804b1-4563451f523mr7437765e9.3.1752716062775;
        Wed, 16 Jul 2025 18:34:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc1f70sm19144871f8f.27.2025.07.16.18.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 18:34:22 -0700 (PDT)
Message-Id: <0b1a2895b9018fe15a931a097ca18fed8d9c7676.1752716054.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1941.v2.git.1752716054.gitgitgadget@gmail.com>
References: <pull.1941.git.1751973594.gitgitgadget@gmail.com>
	<pull.1941.v2.git.1752716054.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 17 Jul 2025 01:34:13 +0000
Subject: [PATCH v2 7/8] t: expand tests around sparse merges and clean
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
    newren@gmail.com,
    Patrick Steinhardt <ps@pks.im>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

With the current implementation of 'git sparse-checkout clean', we
notice that a file that was in a conflicted state does not get cleaned
up because of some internal details around the SKIP_WORKTREE bit.

This test is documenting the current behavior before we update it in the
following change.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 t/t1091-sparse-checkout-builtin.sh | 56 ++++++++++++++++++------------
 1 file changed, 34 insertions(+), 22 deletions(-)

diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 9a89b902c3f5..116ad7c9a20e 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -1128,35 +1128,47 @@ test_expect_success 'clean with staged sparse change' '
 	test_path_exists repo/folder2
 '
 
-test_expect_success 'clean with merge conflict status' '
-	git clone repo clean-merge &&
+test_expect_success 'sparse-checkout operations with merge conflicts' '
+	git clone repo merge &&
 
-	echo dirty >clean-merge/deep/deeper2/a &&
-	touch clean-merge/folder2/extra &&
+	(
+		cd merge &&
+		mkdir -p folder1/even/more/dirs &&
+		echo base >folder1/even/more/dirs/file &&
+		git add folder1 &&
+		git commit -m "base" &&
 
-	cat >input <<-EOF &&
-	0 $ZERO_OID	folder1/a
-	100644 $(git -C clean-merge rev-parse HEAD:folder1/a) 1	folder1/a
-	EOF
-	git -C clean-merge update-index --index-info <input &&
+		git checkout -b right&&
+		echo right >folder1/even/more/dirs/file &&
+		git commit -a -m "right" &&
 
-	git -C clean-merge sparse-checkout set deep/deeper1 &&
+		git checkout -b left HEAD~1 &&
+		echo left >folder1/even/more/dirs/file &&
+		git commit -a -m "left" &&
 
-	test_must_fail git -C clean-merge sparse-checkout clean -f 2>err &&
-	grep "failed to convert index to a sparse index" err &&
+		git checkout -b merge &&
+		git sparse-checkout set deep/deeper1 &&
 
-	mkdir -p clean-merge/folder1/ &&
-	echo merged >clean-merge/folder1/a &&
-	git -C clean-merge add --sparse folder1/a &&
+		test_must_fail git merge -m "will-conflict" right &&
 
-	# deletes folder2/ but leaves staged change in folder1
-	# and dirty change in deep/deeper2/
-	cat >expect <<-\EOF &&
-	Removing folder2/
-	EOF
+		test_must_fail git sparse-checkout clean -f 2>err &&
+		grep "failed to convert index to a sparse index" err &&
 
-	git -C clean-merge sparse-checkout clean -f >out &&
-	test_cmp expect out
+		echo merged >folder1/even/more/dirs/file &&
+		git add --sparse folder1 &&
+		git merge --continue &&
+
+		test_path_exists folder1/even/more/dirs/file &&
+
+		# clean does not remove the file, because the
+		# SKIP_WORKTREE bit was not cleared by the merge command.
+		git sparse-checkout clean -f >out &&
+		test_line_count = 0 out &&
+		test_path_exists folder1/even/more/dirs/file &&
+
+		git sparse-checkout reapply &&
+		test_path_is_missing folder1
+	)
 '
 
 test_done
-- 
gitgitgadget

