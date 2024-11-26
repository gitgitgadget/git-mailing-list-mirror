Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599391CF7AF
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 10:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732618675; cv=none; b=o1F7FRS7l1TArnjvkM14+wvbXQs5CS2Dt/0RvXyjYRXEJ3pbHPn6/RqzleLfM2P/j9QuV3xEJ/M/kqW/DlIaGD3/swzsmNizyulwzn7X2R5QfKecWMA65PwIs8n9Ulmvv1N+UYz8wT9eP/LHOxWLlnW7RXSqyYTbdMDjFjQh5CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732618675; c=relaxed/simple;
	bh=d6sdkK0ux3KtPyDTPF0HKqRy1C23oH3A4/6G/7oeEfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LJ2UMRHzylzCjE5JxHrBEcdbjr8mXRdnAYAKpaj7OFptGwqmGIqvnXNhLceJQCk7OqFWCxerRhFJxY9HLrYU6+0sVmf923S7oGM5HStCygVGM7h5dJLouCm6UPrE9SMfKtzdFJKgctlX3nnFBKC7rBlpsqz9PkIvik21kvewChk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OHHAFT7L; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHHAFT7L"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53de92be287so1139851e87.1
        for <git@vger.kernel.org>; Tue, 26 Nov 2024 02:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732618672; x=1733223472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=At6YYIJXzeWa4k6EzUBy/H2J9gDE5RLV49DvTQzUKE0=;
        b=OHHAFT7Ln0iS8n6gZI8ThQCVJShwra79TVyWn+Zj0dllJoyNS1enpAtSREsgDswW9m
         xvLhq7PUdLt/XQVhSSVccFrjCU8+q6DY0NxIAxa3FguX1oZmx9DjNlYYLgjAxXLKwCcY
         3jpAVDT6etTUfnkzNa/A3TjJQCL0NAI5S5zfPVGsPmKJPIrEbJ4VHQ/yDno7WLuMy4/Z
         +ld6F1Jh06+m23ljk7zIZ8FPzvVqLZb6pZTAPmIvEm9qU4mUH3u/9ElmaxrpiHeG5IxX
         wT5JWaLYXYTQxb/ouxj3K77hAx0KHKWOT6a8iFiPrw+oRJ9DnCAPRjyIjIXAhaxMbH9l
         vvLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732618672; x=1733223472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=At6YYIJXzeWa4k6EzUBy/H2J9gDE5RLV49DvTQzUKE0=;
        b=IOjvCw89OCKnHUwy+K3Mi2tKQnI9d6XzhITnlmZ7ZfMrbT5jkVzj+YNMjBQTRG7Sog
         pFxD+wTP/G29d0jWHB5qj/+VA+0UixB0uNpcWPr1ZjynCswiaqojeapBXtH2yZ9JchVJ
         RGcDWw74fxIFtfbXhdPiuSJzQDOTxNzR9dbRMV7SBmIMvdT1lSgyS1d+VKsv1OxmVAYm
         RGHprhx92g2nM4R3nUmCE82ayPcrOF5KvWjPaekhMtfzzXlPVzOQpgfFcFlGCjSZAlwK
         jWIoDEvwpp+KMxGaameXgQd8FxaA9DcJ/lTGZB7AFm+rbAqxGOYgilhhhzXfl0fStsC1
         ui1g==
X-Gm-Message-State: AOJu0Yzj3J5rb/Xq9rzz1GTjbxbchUkM7oK2EHw5usIuGFTLgqaUz4LD
	dOw6khS9wuUWBZ+Mn4Mhrx0onzY5gjIbQ8xAi5pQisw0wtGQg7jq
X-Gm-Gg: ASbGncu8f9aB0jN1lI9FES+oHgaF4mz55wNMcj8HjO0EmrImGiJsgdScq1KVLsO0c+9
	juOdHAazUEyZ8X9aVtIOxb+Tt1cLKU3YH6nzvoAzT4B5AzOsgU72yq/MwI8c9Ilb5EPoWYaMhOd
	ekmdh4YfivDd+cPs31SKoEyhNjAlbJUshvw+iyAYfjH5P1ZyiNjnTvR15rKQulG0RD21MCzCoTI
	pj0gMJ0UZ7vgpyAhyYFRxcmsAv+5lTlgh1BqgymhnBsJkiopgJrOPLbIekXgjE=
X-Google-Smtp-Source: AGHT+IEtoWMPtwnX4pF4DJwZbku+oNfQKy3Hfec7kgcKFrILzFfOjF3YYPmIxdJvVQxZ1sRyc1UPIg==
X-Received: by 2002:a05:6512:2203:b0:53d:e592:5415 with SMTP id 2adb3069b0e04-53de5926f10mr4967247e87.34.1732618672413;
        Tue, 26 Nov 2024 02:57:52 -0800 (PST)
Received: from localhost.localdomain ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b5b8c77sm587461366b.187.2024.11.26.02.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 02:57:52 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	me@ttaylorr.com,
	peff@peff.net,
	gitster@pobox.com
Subject: [PATCH v9 10/10] packfile.c: remove unnecessary prepare_packed_git() call
Date: Tue, 26 Nov 2024 11:57:41 +0100
Message-ID: <d7f475fbd02b8ca63d05e4f44364bc5fc265f897.1732618495.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1732618495.git.karthik.188@gmail.com>
References: <cover.1732618495.git.karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Taylor Blau <me@ttaylorr.com>

In 454ea2e4d7 (treewide: use get_all_packs, 2018-08-20) we converted
existing calls to both:

  - get_packed_git(), as well as
  - the_repository->objects->packed_git

, to instead use the new get_all_packs() function.

In the instance that this commit addresses, there was a preceding call
to prepare_packed_git(), which dates all the way back to 660c889e46
(sha1_file: add for_each iterators for loose and packed objects,
2014-10-15) when its caller (for_each_packed_object()) was first
introduced.

This call could have been removed in 454ea2e4d7, since get_all_packs()
itself calls prepare_packed_git(). But the translation in 454ea2e4d7 was
(to the best of my knowledge) a find-and-replace rather than inspecting
each individual caller.

Having an extra prepare_packed_git() call here is harmless, since it
will notice that we have already set the 'packed_git_initialized' field
and the call will be a noop. So we're only talking about a few dozen CPU
cycles to set up and tear down the stack frame.

But having a lone prepare_packed_git() call immediately before a call to
get_all_packs() confused me, so let's remove it as redundant to avoid
more confusion in the future.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 packfile.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/packfile.c b/packfile.c
index 2e0e28c7de..9c4bd81a8c 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2220,7 +2220,6 @@ int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
 	int r = 0;
 	int pack_errors = 0;
 
-	prepare_packed_git(repo);
 	for (p = get_all_packs(repo); p; p = p->next) {
 		if ((flags & FOR_EACH_OBJECT_LOCAL_ONLY) && !p->pack_local)
 			continue;
-- 
2.47.0

