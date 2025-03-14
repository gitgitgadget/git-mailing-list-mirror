Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0170F1C6FF2
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 08:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741941652; cv=none; b=GROVQnpTWRco8NUPSu4xCxm8UQGocmv4al+i0jXZNcDEGvPVzkK0UpzMNUCzUJYDnhK3bvg9vDpVflsdD7PA8W+qbeBOgCUf9lfaEfSYLOEZOAzmFrGTESLwUo7fYz+GYOOW5JomWIJMUnR2r1bgQInLaL99COWtgvldaQvuJCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741941652; c=relaxed/simple;
	bh=DliCAF5NorVjbdpdJV3Vu3w9dLDG3wV16azXrT+TQIc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S+wjR7Pkk3rrwcxXNRicwOUBDpFQEHFUnhUaLvUoeNQFN+ejpfV9Y2mhY+h6jOem4e2VTq/5/bjsgfuKtRGI70fOedUMWQRtUCOdh72wPh3q0afd8jvWVv0Y77wRzs4Z7e/zJEWysEzfGG93pjZJKFXzlTLvzrHsJbDYdUDoqBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTFaaYwF; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTFaaYwF"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac2bfcd2a70so246387666b.0
        for <git@vger.kernel.org>; Fri, 14 Mar 2025 01:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741941649; x=1742546449; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eoYQK/Thgs/1eGm+CzvXBx1+MbxIfNhvaj8LvD60prk=;
        b=LTFaaYwF6or40AwlPq9L5MV2mUJ57BcguIOWTgSCk08hmQiGYCzGng9ldDE0kOH7zc
         2xrygTlehOCBlkiAq3UsJUhSWvq94PPGia3F+RbwHrNAhkT1Wog7KgcE2DRnA1JwkAE9
         tXRKnnluQNYpcvV+/DGKqmvUkwOMZH32Bo9P7O+25Avr5ZFSQ+vph9VDZXf1pMCb6EFc
         DrapC72pRdL5bWVyLBx7hdmC4pg2MbncfW/JD24hzlB046seJa9uUqAEuqIB8LtSMVZ2
         azo9llcPhaUXgf35Gh9KeA+1XQTsmp+zNH56b51CvwsOwQfLIYSLDdC4eS67s7XvkJY1
         E7Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741941649; x=1742546449;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eoYQK/Thgs/1eGm+CzvXBx1+MbxIfNhvaj8LvD60prk=;
        b=C3epjeyo/WoWRh/BZ5CDPDejSLsRlP9d/S8vszq75Cov4DywND1DA9L7c/cKOvOTFH
         xuELRsUmW97AMkI3izGv4jJ0CS0NBJVIO4EHhiBtH38Em2dzlmxgD6IxaixD0/4AqeHS
         mAWTncgnYjABFRukN/LFH02Tu4yDnpOwUu70ZrbjVaTb7358RXsmhz5gpvtj9rmauPtz
         FbMHTrLIVkGQVWoMYpSbUQBIGSXEcT5Vefo3GxjRb8RXMamzRehWooLTS315PgiDDbZm
         Hvg5VWCGGPhUybxhHln2jnZAYpCFdaNQxyBJvvgPbfWUFNRqhg73saxNNtOHcBz8lU9z
         0gLw==
X-Gm-Message-State: AOJu0YwLTXvZRTfCrCPC80ol6nZDvmGlf/KPl5v3GDLlV4dwy7l+4fxu
	Qd/NHGkcWO2sK7D7OT/fLc36u8UsoK6Vu7nK8DeCrpk7VYDCd6/k6v2fjA/W
X-Gm-Gg: ASbGnctcJLpjinPw5aB6lNHTGg3wpief7x1I3XGmnoOCTGKiNufTIeUbS3E14Fd2uxH
	djoGK+sLSxT0Z/ACAuz2sfOQSHuyl4DKGKs0fWQZrYEnTqVcioCATwxV8y7hC0tF7lwJ0PT1pHR
	HThoc+lxdvr0ZIlMwPqJjgAPe8B8CNiUjTi/Bnq6xs8foIQ85rRpyTQzAX7ry3d7rzzjni9s+91
	hdnmj1Q5REXmf+sEmcR0XQQAZDlBKJB9dJUjbpNSvyJql23SW2HtQJ88TY98VVoOWjWRTPHiQLw
	PvheYFwJcg49jtjQlXMRHu7SbSDPJ8dIzNzJeiDCewlti1AWiGE=
X-Google-Smtp-Source: AGHT+IE3oKcLcj/i65G89VI7tmQD/9zujtSIZjP3XLUXWMKpbf9Ge9ftNgmOiz9P47NwXPQuCghEvw==
X-Received: by 2002:a17:907:2d92:b0:abf:6b14:6d00 with SMTP id a640c23a62f3a-ac3301e1e64mr166279866b.5.1741941649087;
        Fri, 14 Mar 2025 01:40:49 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:f2db:c900:a4aa:e466])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314858edcsm191081866b.85.2025.03.14.01.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 01:40:48 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 14 Mar 2025 09:40:34 +0100
Subject: [PATCH v3 1/2] reflog: improve error for when reflog is not found
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-493-add-command-to-purge-reflog-entries-v3-1-c24e23a6146d@gmail.com>
References: <20250314-493-add-command-to-purge-reflog-entries-v3-0-c24e23a6146d@gmail.com>
In-Reply-To: <20250314-493-add-command-to-purge-reflog-entries-v3-0-c24e23a6146d@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, kristofferhaugsbakk@fastmail.com, gitster@pobox.com, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1662; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=DliCAF5NorVjbdpdJV3Vu3w9dLDG3wV16azXrT+TQIc=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGfT649M86HaCUkTb84NxeBDIUZxy8oYLcTDB
 rn+V5mTYNcmW4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJn0+uPAAoJED7VnySO
 Rox/UHUL/idlLMq+0MnCJ26W2CJhl7Yarmykyxi9v/WdiSRZ0xceMm/B92qsj/JxOPl1CIy2BFi
 42bqBZBIoZhGpUgUh0YeqRili11gHEYRYaKUdTuQZqhM7KjqCLfxKeQ/xXXL6WzsB4sB7Vve9mJ
 V7Rfl7oFwfK2giCIkLflledOTyihXaA0t8Am+r+LcT3nFyEW9XvfYfCHSUJRZwi1C80YJU66Q6I
 Ll3yEAxkfGy6us7KR+E43KCxQEwP64pBAjjIMN3m63kfKhHE8BkEVtfYzgG9PTcSft+3lwTMsPz
 46GQT0q8xL2ZBayknbRbMnGZ+bjgM5PqaYVDxdrhkV022XYtTrakPr45OkDGy/TUNnEQbQGuPf5
 T/G0C6MjRoP6fPyeF8hB2B+XcTuSOnjpUrADyLsmq7PEc4z+smzH9dCfqgawDjrxMLY+bcbCX2s
 gHPTGsJXxwyjPxiKmBzIVgsBqnvle+tkJqWKpn2BhOIhCJjzgsG3pR38BqyE128LpSmgmHOWdZ5
 rE=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The 'git reflog expire' prints the error message '<ref> points nowhere!'
when used with a non-existent ref. This message is a bit confusing and
vague. Modify the message to be more clear and direct.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/reflog.c  | 2 +-
 t/t1410-reflog.sh | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 95f264989b..762719315e 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -383,7 +383,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix,
 		struct expire_reflog_policy_cb cb = { .cmd = cmd };
 
 		if (!repo_dwim_log(the_repository, argv[i], strlen(argv[i]), NULL, &ref)) {
-			status |= error(_("%s points nowhere!"), argv[i]);
+			status |= error(_("reflog could not be found: '%s'"), argv[i]);
 			continue;
 		}
 		set_reflog_expiry_param(&cb.cmd, ref);
diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index 388fdf9ae5..1f7249be76 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -315,9 +315,9 @@ test_expect_success 'git reflog expire unknown reference' '
 	test_config gc.reflogexpireunreachable never &&
 
 	test_must_fail git reflog expire main@{123} 2>stderr &&
-	test_grep "points nowhere" stderr &&
+	test_grep "error: reflog could not be found: ${SQ}main@{123}${SQ}" stderr &&
 	test_must_fail git reflog expire does-not-exist 2>stderr &&
-	test_grep "points nowhere" stderr
+	test_grep "error: reflog could not be found: ${SQ}does-not-exist${SQ}" stderr
 '
 
 test_expect_success 'checkout should not delete log for packed ref' '

-- 
2.48.1

