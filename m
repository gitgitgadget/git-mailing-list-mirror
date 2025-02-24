Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A371FCFD9
	for <git@vger.kernel.org>; Mon, 24 Feb 2025 19:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740425259; cv=none; b=Z+ZL3p39U35IZpOHEfsZMIm93qjHI6OJ8MqnAXos56Xqr9MwVAXSZM+UD4bKIU5yYeILywFyt+ZkSueqe16jmnHGLtlMGvK5KhT9K94cGRO4TPLN911ACZ0frkUaSEIdcMNQySlAWpDgrVQ+Si0zCZL4AAu4tr3ES6L2WS/nAcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740425259; c=relaxed/simple;
	bh=kGtiyvPUg+ITFvCT5u30AzmXmKm+MNYdp6ZXHiZJ648=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=avgIKXkZrksz8quyBizeSMCd3O08QTAVKuF8a5xBiRmW4hXCOOIi+GEPzHZg6ikYgVgEh2BS0HsNabyMN0Z/3Inqq5jUJnVd/QtaKij7Ja+oAVJCloFn4PCFR2YBzTmcgzET11gDHbsZq3oqml4Hpm2LZQ7c2WjuW8/0e7NU7oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QpIfBMgx; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QpIfBMgx"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6e65baef2edso42686276d6.2
        for <git@vger.kernel.org>; Mon, 24 Feb 2025 11:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740425256; x=1741030056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=vKge9sgFgIeeN2CSHYR+pVtJK4wDZVcrUMDsG4wvqjA=;
        b=QpIfBMgxBov0xLLqzGSD2mvEbzipmHFIfE8de4JBer4oDf+kSIq8HAT828cPDaS7KC
         0wDABw2tA5T/q/+/EN8hmAl1aYdg6jGTNFWL6EBuaRea9b3DUX6ueV2QPJirtMfn6aPD
         8C5Dd5oJHGyaRmkXBH0bawlWJfV+G/2LzuP+ZGIctogeTbJvYEcsPIGpnD1XRC1DDKqC
         BFsUXMGMcFX56rD79qDxYeOa50vtZtJmCNsszE8k0U5zt7u0XgB5ZNw6mfZzgmfkPaUC
         CD5EgRKgwcRRV5Q3xulxTxjHQoPmU72I/eejSfowBMHthK/4GEt1f4Z6MsiiKX0sMlcx
         FXtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740425256; x=1741030056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vKge9sgFgIeeN2CSHYR+pVtJK4wDZVcrUMDsG4wvqjA=;
        b=dGRbMgmBS4elExFS3EybI/G8mJI2u4x1hygQxlLLfSEesL4vann2X74Z75CdDFoBU8
         fwSWPJhiKwANQdT4ZME83XfHgLxnnX+DUvXTlV5+tYS2GSEPjuXJBooemv/eHolKFUcd
         v2vSYVxnQqnm6QKXpR5EAWFuPKntBHiK/nT5VHJ/+/GLxCV96pn9aSrBUv9hbn/ZrXpU
         mN/68uAjoc9KCTyXxXGjzcXojiO8O/JOSGBppSrPALfxZkHAxX8KhvKbR2zLzeReidT6
         uxfmboXsZ6/+Tk350j8wTPidjfFYGxe2FGQTDY8bAN5TeMAyitolbkx8lsOqgXs4d6iv
         HBhw==
X-Gm-Message-State: AOJu0YzmskE4wZZk8G9aZlf0qUiQ9pbUrWkYXHlRfptaaqv4NEBq3KJP
	ioab5tNOu8/Few55h0wpycDOUymir/MaiVw7Um0hHr8zEsQXVHMd8FeXzDVs
X-Gm-Gg: ASbGncvsYIUmGEdj+cnQ+rfqLpwrLw4C3toFpnwEY50SmXu2P5O3MMR4bw/iyQ4VZEo
	OphfcDqZVqxf/yNohsSqd9yoB6+78nQncJ6UoFVd+hyTenWP7lzVVUAaTAnytL4eutE0i86qzdx
	uXo0fSI5x8CI6ulDBz9ae4jdBad0lIb+ECNkGPD0BtO2FrHavB7QxhzxEfkYeYw6bKBkd6GVE6U
	+VMUbrUTcuch5LefotrcuSEQhzr/9BIIiJhB6Afh59Fly9b2hIk9wXAiH/180K/8hO5NH3OxedC
	jMkYlg2V5dGELb4MW7xRYZJr3TDXAIFiUIyrWn29O5gG5x4Y2XTy5KYJ0m5mmJUc4cep
X-Google-Smtp-Source: AGHT+IFaROiajuEZXek32uWNzsZZggnPGloUMk5O1Sw3mh6e+of1W6FZr+gVfvYRou2uanIDG7gxYQ==
X-Received: by 2002:a05:6214:2b08:b0:6e4:6ef7:b5fc with SMTP id 6a1803df08f44-6e6ae7f7ef2mr188071816d6.14.1740425256330;
        Mon, 24 Feb 2025 11:27:36 -0800 (PST)
Received: from localhost.localdomain ([2601:5c1:8380:760:9189:fe1d:4a1d:36da])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e87b1569a2sm400506d6.84.2025.02.24.11.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 11:27:36 -0800 (PST)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH] t/aggregate-results: fix paste(1) invocation
Date: Mon, 24 Feb 2025 14:26:02 -0500
Message-ID: <20250224192724.7625-1-ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When running `make test`, when missing prereqs the following is emitted:

    make aggregate-results
    usage: paste [-s] [-d delimiters] file ...
    fixed   1
    success 30066
    failed  0
    broken  218
    total   31274

POSIX says that `paste` requires a file operand; stdin was clearly
intended by 49da404070 (test-lib: show missing prereq summary,
2021-11-20). Use it.

Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---

The test results are from a real run but on an as-yet-unpublished commit. Not
sure if worth keeping that part of the message, so feel free to only keep the
"make" and "usage" lines when applying?

 t/aggregate-results.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/aggregate-results.sh b/t/aggregate-results.sh
index 6e3bcc4aec..6cb0ff11de 100755
--- a/t/aggregate-results.sh
+++ b/t/aggregate-results.sh
@@ -44,7 +44,7 @@
 		tr -s "," "\n" |
 		grep -v '^$' |
 		sort -u |
-		paste -s -d ' ')
+		paste -s -d ' ' -)
 	if test -n "$unique_missing_prereq"
 	then
 		printf "\nmissing prereq: $unique_missing_prereq\n\n"
-- 
2.48.1

