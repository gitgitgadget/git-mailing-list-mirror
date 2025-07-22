Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89952D1F69
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 08:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753171964; cv=none; b=C4YjfQw6po06O4D88dV/PoNZcU8yzKBRMflhfYImS6bbss4EgNpZhtdD2wUqQnYz2U1czccSI4y+0WprD69ETyyktFWFLo9eNVDMm6/PnsYRM9bWvcKExCDYwEKvSLlTy7ROYRpSp6Qmg88a6uzB8zJ46hF23+l+3BQ/jDOGrN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753171964; c=relaxed/simple;
	bh=xjJmEa3uAOuL1/1nAVqGPaawaLnAtL2M3U3jtPQuOXA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IlUFAjT4diuvrgVnDldYX/HNA/e7WUZmVvYHBdUagVIfM9L1k+LrsFSpr8La3z9MzNc2jHnGS0kcH+CYUqlp0CmL7I9B90r1VEEDLkAGxg1BiaBivxZzGS1jRCXOz6FGfcppWIJalgHGhpdCN4HUTFoDEbdAJsHfJ55Noy37mJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RP89n9dF; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RP89n9dF"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3122368d7c4so4335989a91.1
        for <git@vger.kernel.org>; Tue, 22 Jul 2025 01:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753171962; x=1753776762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQ+QYMrJNrmDoPmzHhDMhJ/+TV/3wEW3YD9ECWHPQc4=;
        b=RP89n9dFOpw2SJdDOnZzfDobzTizGY3tjhSTMUOK+5A+WC7WN2Ud8Mvvbd5TuGf/T/
         H+da/sXH1mz4Fa073xlI9WpZ/vHFmCszCqXnZNPqKlIlGovHDBwKHIcBskKmF3kSrJnU
         RByu9uNdF5lf7b0f65e6Z9yRVr1+x3wD3TgPgeFkSD/f/zYFVDmFloHW+dQO8tWa5mOA
         d7ZEiGnnZgBduO06EVU7RgjDVYgINiR4sfODk48luDRNLiHTBP0itSqR7d6/a42E1+qP
         xc/hUFaciB1w8aix/AzG15jabbSspODiOYNtBaMPSHBzztwyAV3RZfw2yujn0RY5+JrD
         jDdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753171962; x=1753776762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UQ+QYMrJNrmDoPmzHhDMhJ/+TV/3wEW3YD9ECWHPQc4=;
        b=najJoMEivPfa94x20kJdwP1QtVuVoshUYgXae8VMlX6krm1xSan9eT6Yvp8nLVKH9T
         edlelZTyv3v2AcBJ6kdqDE3jUYx8KMvQaP1nnu0Xxoo2FjiBxYZecSr7WZz1VytMu/Fx
         VBH+90gEwsLqt0ZJW/jZvj4QOhaweuw3JfnPBQyazNValA4PrFbi7BvLh7PycomWAdKw
         bdLuZ+x8bZplhzTJljmsXSxN2XR0UrSXWXkFjuA27W/ZiNVdXKKJ7ppJINFyqAaqNm9o
         p8m6fomlzmwIRR2+SAkVgaLLL7652YMHHQOabrI0l0zuqpskpc0pCT3URzcoSj14duNc
         7T+g==
X-Gm-Message-State: AOJu0YzyGcq/wN3YfYi4lQYh7fglSV6bO4itTD9l7D95+mz4vBoAa/SO
	imeynwj6c5wiu6N80lVw4A4qdwGVTlbSyBiMkxCIGCuFmyp8E2fAUULrlWLBxDB+
X-Gm-Gg: ASbGncu7hleU4UKHFGhP4dIfQam7+oV51DnCgFAmT1tjx2oPVd7sPs4o2JSdSKvhVD+
	EbXBzuO06lFkaVTKl6rt9l8HYVlGRW+Gp0pbN6NLYVU9+WQLJcKC//N8k3VzrphABcJM4Lm0gA6
	GUupk//UoE+t6+HaNFJuXK/HReZ4pQpjgpVoEZaQvQMmImnKYmeG1dltVYNvKRXspXx6qdWCGIp
	AAEiqgoTn4GTj/WAECNFm8P9oxt4SlPUkioHIYk7jRlgIQ9w+8kNsmfidgVVIAEmtS5A+VZcm6o
	rLY5e3HucBbuUUOva72psmsQARHJcGv7Jf5ZXJ3D2JM3MiKCRk6L11BgcDsZgPufbQMkruKo9Ql
	CC2v13telgglkawZv193wE9NAaN6JSXUYq9UKDij3NH1v
X-Google-Smtp-Source: AGHT+IFrMScvxXHG/EGAhgFHOdqO3BYlsg2yhvRxNeWFwdC1DPOZkt85mKHA2lErhRJG+w0EzH7CKw==
X-Received: by 2002:a17:90b:3f8d:b0:316:d69d:49fb with SMTP id 98e67ed59e1d1-31c9e70915amr38564633a91.14.1753171961658;
        Tue, 22 Jul 2025 01:12:41 -0700 (PDT)
Received: from localhost.localdomain ([211.37.148.227])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9f1b8f89sm11584538a91.9.2025.07.22.01.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 01:12:41 -0700 (PDT)
From: Hoyoung Lee <lhywkd22@gmail.com>
To: git@vger.kernel.org
Cc: Hoyoung Lee <lhywkd22@gmail.com>
Subject: [PATCH v2 2/4] builtin/archive: close file descriptor on dup2() failure
Date: Tue, 22 Jul 2025 08:12:17 +0000
Message-Id: <20250722081219.1086866-3-lhywkd22@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722081219.1086866-1-lhywkd22@gmail.com>
References: <20250722081219.1086866-1-lhywkd22@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In create_output_file(), the file descriptor returned by xopen()
was not closed if dup2() failed. This leads to a potential resource
leak. Ensure the file descriptor is closed regardless of whether
dup2() succeeds or fails.

Signed-off-by: Hoyoung Lee <lhywkd22@gmail.com>
---
 builtin/archive.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/archive.c b/builtin/archive.c
index 13ea7308c8..c919a39f90 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -14,6 +14,7 @@ static void create_output_file(const char *output_file)
 	int output_fd = xopen(output_file, O_CREAT | O_WRONLY | O_TRUNC, 0666);
 	if (output_fd != 1) {
 		if (dup2(output_fd, 1) < 0)
+			close(output_fd);
 			die_errno(_("could not redirect output"));
 		else
 			close(output_fd);
-- 
2.34.1

