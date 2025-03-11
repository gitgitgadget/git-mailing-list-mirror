Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D8425D918
	for <git@vger.kernel.org>; Tue, 11 Mar 2025 14:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741705180; cv=none; b=HqIWs4/ieoQIInfJhm5D4TqsraLGwODdkkTscoEXWf1gu11YVZgguUUDfkYGqn/nGAGgF1ayK0JDhZhq87Qsr2/q/tnBI+8ZYVcpIc6mZKQ7dMOmx4faVw2BHwtJ7I/gqNCsK2urr5+x1080BYqExQhhFUwub3rk4ddmWRClfD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741705180; c=relaxed/simple;
	bh=VjtRRhamf4Qy7RhvsrKDKzuXzba1It2mg8FLVyOBt5A=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=C1bnkAmlHyRhBqggDGGLTZ6C/VSf72tDYEJkhFOuAxrCw1lnOkMvKb2EkLZ5UcS6IcWD+Pb4RCTdwPsxFyPiXYbOE11lbsxc26vqd4tF3AV2SR3EytBw+XEuu8VJPnPdbMb6Cv1dTy6ylixadn9ArhSCU5JJ5lFAg0dJDPwagiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VLJUHtaN; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLJUHtaN"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-abbd96bef64so903764366b.3
        for <git@vger.kernel.org>; Tue, 11 Mar 2025 07:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741705177; x=1742309977; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=52pFdxEQFO0KUzuBN5z2tX/pzl9y7ZUcQuU/yIztdqs=;
        b=VLJUHtaN1ZcWg6b9rk/3LDgWKenU0X7rXufG1fFXpIJGHciexIxMs4xcb48TN3CLFA
         bq0SgHEU0r88qaaJC+3kNsMnGw/3hmtuzU+CaQdO5enmZV7a5TVAnyvibM2Vg0V76hKG
         efpG8mm3ibCnSiLp6f3Pjt4R6ZV18GpxmZQ+Nwbh3WMatu6HF2AdO2ATl4LeLeG3yIve
         OTLcEzzEm1jIbgOcVFTUSWc2e7eZSN0B1sxtHDGdh9YJei+S2a73yQw1HrC7O0vQEL86
         dQ7SUtxmCveunXYsRb5SskNqoqiROBBoVePGo/QT/dywfFsCD7mVxkVPCgy1OSfbBjN5
         ilLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741705177; x=1742309977;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=52pFdxEQFO0KUzuBN5z2tX/pzl9y7ZUcQuU/yIztdqs=;
        b=aO2hNZZq6Jz5Zp5FlnOWSC8xj0iWvpePHqPP5bf4VSif0AFI4okr65TeK6amvt1Nns
         fKURBWSPyiUHcS6UlOXlHULyz2jdt4U0h/9vvt4oCJmswv9aVF3BKOhGNQ6x0NlkPuB8
         WDAbxsaWdJmCcF5bVYpzSP+cpwDfnbbUidvHWQMUE49y4UuRAh00u7++Z3NrRhMmFRQc
         DEoF3kp730UiGzBh7KSEjdEOCnjgsWKtD278I08Fg2dk5APenLORZl1E0Fo/nUyDu6to
         9NT8vzYhHtkDI8HKz49QCVp/EfdXfkAW2MZFARhoqbeuQyvlDl28Dt/SSs1pMdECQ4sE
         gaLQ==
X-Gm-Message-State: AOJu0YxYa7M077nTDHfE4vILNvp8T1pI8lQ7A8SJVs7evLSqs1AV6iS4
	/ZhXRIujb8sM2oO95r26aYDxrs9dvK7zlfClqMgqk18meU+M33RTOypslg==
X-Gm-Gg: ASbGncs34YtHitaCzTDbLqrYNpX2yVBdp4oKhkL6DFG5B+6hjB/b0OLu1GoqBBvQVyx
	FKMB1aPYpfod03Z9eYEhyViJxg9FfSuqIYGsuSGqS36XYj/bk0e6mqXAi9N7otXqypeKqX1W7oM
	bpbwOpFcH0m3j2aGtEiTxfzyV6j+NvnpM6NaOcbAC6JTN96jRDJDhjaVM/Q8KtBo+BFhbCKnvY2
	bx3ryEf3f2jS1B1KE5j6WVVDzgeCq10+4qlHV+yPBtIv7K9AbXMVm1uCUsPmY3JX385W9HxdEev
	iLbtxGDr+ua7di7WcBCTLOixz1oxFHPKWvH01715PSBKXA==
X-Google-Smtp-Source: AGHT+IH9qJVet7/oq0tAcRx6CvdkFwBIJiLZ/SUSsYbkarlG3KpCr07uJVWwQs+zGakXUYOQZuy+vA==
X-Received: by 2002:a17:907:c994:b0:abf:7940:dba2 with SMTP id a640c23a62f3a-ac2526d9b1dmr1632393266b.30.1741705176733;
        Tue, 11 Mar 2025 07:59:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac23948578bsm945659366b.59.2025.03.11.07.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 07:59:36 -0700 (PDT)
Message-Id: <pull.1879.git.1741705175922.gitgitgadget@gmail.com>
From: "Abhijeetsingh Meena via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 11 Mar 2025 14:59:35 +0000
Subject: [PATCH] dir.h: remove duplicate forward declaration of struct
 repository
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
Cc: Abhijeetsingh Meena <abhijeetsingh.github@gmail.com>,
    Abhijeetsingh Meena <abhijeet040403@gmail.com>

From: Abhijeetsingh Meena <abhijeet040403@gmail.com>

The `struct repository;` forward declaration appears twice in `dir.h`:
once at line 10 and again at line 46. This duplication is unnecessary
and likely unintentional.

Removing the second declaration has no impact on compilation, as verified
by a clean build.

Signed-off-by: Abhijeetsingh Meena <abhijeet040403@gmail.com>
---
    Remove duplicate forward declaration of struct repository
    
    
    Summary
    =======
    
    While exploring how Git searches for .gitignore files and manages
    ignored files, I came across dir.h. While reading through the file, I
    noticed that struct repository; was forward-declared twice. This
    duplication appears unnecessary, and removing the second declaration
    compiles cleanly.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1879%2FEthan0456%2Fcleanup%2Fdeduplicate-repo-fwd-decl-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1879/Ethan0456/cleanup/deduplicate-repo-fwd-decl-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1879

 dir.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/dir.h b/dir.h
index a3a2f00f5d9..e659c47ad77 100644
--- a/dir.h
+++ b/dir.h
@@ -43,7 +43,6 @@ struct repository;
  *
  */
 
-struct repository;
 
 struct dir_entry {
 	unsigned int len;

base-commit: ef8ce8f3d4344fd3af049c17eeba5cd20d98b69f
-- 
gitgitgadget
