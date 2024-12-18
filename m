Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A7CF4F1
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 00:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734482233; cv=none; b=p13DB4JAb9nuekI7lkgYLGT7Knl/Z7yaqUrfnpB6uj7/20plCA4Su4UuGmcWswXa+Njzg6lZDMN8oWMwQorR8dyCMRPXqiX2LMxAs3o7lIIffYYGlPHBUOM7kPFGe5V7Rup+Uk/gz+D+DpLWAYexoQVGl1+Qeo3CwYG+OcCkXps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734482233; c=relaxed/simple;
	bh=s9gYDTLv4h+O/GUfy2Hzb5PZqiIwCVemIR5a2qvwnFE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=BQL9d5k+h2HaVjm9wcye4hxiV21o14obh5kre5ot3jXG/V89y216718a1wkoNI+8vCmFPo8/tS1q07rBW13jCECQ1cX2sSvHzqnamx7WDv/oUCln8fJyFmlgUDTQS4mqAEpW4j7iaV+aTHPt+Ph+htwv6HKrWmva2MQbsY/4HR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXZNI++f; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXZNI++f"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-435f8f29f8aso42837045e9.2
        for <git@vger.kernel.org>; Tue, 17 Dec 2024 16:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734482230; x=1735087030; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zOnc71S+sl0q3xDlrkMgwnLveaW9CVC2pE4MA+TqtrY=;
        b=nXZNI++f/S8BxAMPngOgsBDCdY249NBbSciKc4xqL2R849ucF/icBIIHJJxNRzkkxc
         wSSCSqHeV26S2wO4Sm6jQHclMsr/pEWfEa+ah6ci4EouWYKOq3tMpl/nmvPa8/5W5vGi
         D3hSt+3nSMpZIu9w1X24ewioK/ag16BpeolqrRVqjpA1gONtS9nraYO6QrsIKj64xVa3
         XJV7k+vppPOWLqd0E3txWlGIITZpyNrNTWitek1+JmgwIQdVSieCWnspi3rKkd9KJzeM
         BELlE77iSc0xFu03QISPmxT2kBWgXUISi5jpujVgcuZSrFJMUDfckppLs+y9IwBivo/V
         j17g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734482230; x=1735087030;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zOnc71S+sl0q3xDlrkMgwnLveaW9CVC2pE4MA+TqtrY=;
        b=VnP2AcwmVkj/vhzP92N0dYedkpOo4Uy/3Zsyk2UgFbIGCRUUEtoWqc9gktNqfNndOA
         UJM5O0ldUaOji90jszJ7QmUnpW17M+0UeQjWAE7hDiqP+z1WFiIYFF0yJRScfJHEFmUN
         dXaDE3V1RMamb41pzsEQHYCrEqaqiPSgy8f5GrHCT96S5lQ4GLzxPXaAqxnZqxl5irh3
         Bijz1xXgTRr7PVRcCnVbvMdg0xjPYZiJAlvlVSNkjU38RWyuHG++XqfJ9tG9lrU5ViIT
         VaiUhcvUmLaj+AuOqtUJ4agEtTefg7jgjcplJQXoHnKLZFEI4Rfh1ewb1zNN5+NYD832
         Wbmw==
X-Gm-Message-State: AOJu0YyxWMAYCnuxTlLy7oTyf+YgchNv2X7IcBfjiQR2dXoiBAAjO5N3
	bMZSZl3iIyj34Xnj94dsJ3+Oza4RO9Rx4ELHb+DLzzAa9b0zco54cpKA2g==
X-Gm-Gg: ASbGnctVoxU0udk+SnZdjV2s4aEix7SU5/pk4o6tEjQzqbM1hxlmAdC0YhhUGR/M/WE
	VCC0BtfOJSEHxLsjUZ2W2ADU40lS0IIwQB9cMWkrOd6p3Kr41wOYlhdw9QeGrdjxwogtwrT5S3w
	eGIVEFdKSt7JC7uHmXEkYfynwWuuYosdotlTZXhODsuOMekkOfeli5KUdsF71mLUfEHZWKlaDsc
	WqVn8937t1DqvyZaEYXPyn8XOwAsZq00AeD0vBlvSTDEgjBviwwwtXfjg==
X-Google-Smtp-Source: AGHT+IGoK3IW2UQg60O3CLyXR/RY5BhvTucxSezHaR2tbaoZtlCHhfmhvlZ9x1fJ0trOuHPJJPi62A==
X-Received: by 2002:a05:600c:1382:b0:434:f0df:9f6 with SMTP id 5b1f17b1804b1-43656aff40dmr2142405e9.3.1734482230266;
        Tue, 17 Dec 2024 16:37:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b1f638sm2508285e9.37.2024.12.17.16.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 16:37:09 -0800 (PST)
Message-Id: <pull.1413.v4.git.git.1734482229018.gitgitgadget@gmail.com>
In-Reply-To: <pull.1413.v3.git.git.1673189354738.gitgitgadget@gmail.com>
References: <pull.1413.v3.git.git.1673189354738.gitgitgadget@gmail.com>
From: "AreaZR via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 18 Dec 2024 00:37:08 +0000
Subject: [PATCH v4] mingw: check that the file attributes are valid before
 modifying them
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
Cc: AreaZR <gfunni234@gmail.com>,
    Seija Kijin <doremylover123@gmail.com>

From: Seija Kijin <doremylover123@gmail.com>

If the attributes are invalid, return -1
to indicate an error.

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    mingw: check that the file attributes are valid before modifying them
    
    Thanks for taking the time to contribute to Git! Please be advised that
    the Git community does not use github.com for their contributions.
    Instead, we use a mailing list (git@vger.kernel.org) for code
    submissions, code reviews, and bug reports. Nevertheless, you can use
    GitGitGadget (https://gitgitgadget.github.io/) to conveniently send your
    Pull Requests commits to our mailing list.
    
    Please read the "guidelines for contributing" linked above!

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1413%2FAreaZR%2Fset-hidden-flag-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1413/AreaZR/set-hidden-flag-v4
Pull-Request: https://github.com/git/git/pull/1413

Range-diff vs v3:

 1:  0cbe8bce617 = 1:  0fed7ade880 mingw: check that the file attributes are valid before modifying them


 compat/mingw.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index 63f36c893bf..7f52a4362fe 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -446,6 +446,11 @@ static inline int needs_hiding(const char *path)
 static int set_hidden_flag(const wchar_t *path, int set)
 {
 	DWORD original = GetFileAttributesW(path), modified;
+	if (original == INVALID_FILE_ATTRIBUTES) {
+		errno = err_win_to_posix(GetLastError());
+		return -1;
+	}
+
 	if (set)
 		modified = original | FILE_ATTRIBUTE_HIDDEN;
 	else

base-commit: 063bcebf0c917140ca0e705cbe0fdea127e90086
-- 
gitgitgadget
