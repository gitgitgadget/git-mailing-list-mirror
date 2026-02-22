Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E30CA6F
	for <git@vger.kernel.org>; Sun, 22 Feb 2026 15:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771774775; cv=none; b=e9k23CuHmVI1eFJkvEtdDchjWfYhQ67BcAepRgTGJ1GMdd0d1iPB/faDyin/jOA0TNeLGVUjND/KeCqL1angxCj04o0H6twoDyOlo5xjs45xzCOaxPq796xpRo+oOZhlhHy5WamM0y5ULvqYAHjVwaYz7cAmmV3ejbiaL/k7iiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771774775; c=relaxed/simple;
	bh=/Bbt3+iuT9YcLU9rQqTwEW68Q2FthU30Wo+VthLfgl8=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=BpR48wNT4sW0c51ABCmsoKNIxbdbeaLSYueFZfS+sdWTTq0uRraf54ktmHFsl/jBMEpn20AwGWOL++OQ9qpDlu67AmJ2GcbLvipa90hLbniAzBpGoJ9stGZjf6vvtl6rMp4P0gJPQVOIzaUt7yODbVvKMEgcJ5MttcSUKgtqoek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/GC2/dk; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/GC2/dk"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8cb3fb47559so338200885a.1
        for <git@vger.kernel.org>; Sun, 22 Feb 2026 07:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771774772; x=1772379572; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=L8PNvC0iSSC5VHyN2aVmZdPbRfBOAPnSxEK7llz4gIg=;
        b=G/GC2/dkJ9AUd8v2VI085k76YOUB9dFCj9w/Hs8g/M3wtX1PxAWo8tKe9m9fWPfZyM
         JBMJYmMaVCznYBp6ktCNCEjfK/OHCTWYxGWpbUutIb4YwdT4nnWuLcvMM9qxj29DrqFg
         eExwPXy/5D8Ha5upAjOdqJuBnj44whkH85MbBe0IvndN3OZUQQyxwOpV0sTR4swyxWr+
         hXPeeVY8AFxBzCSsMabTTa/YmaKKN0GPJNm14DECiYCK0D5H/9kp9acZQ5DTIbqjp1Sw
         xQvzesEO0Zgn5TSPMbQ14msAZI7yzN3fbOt7wA81BgcjrFRWu9fknnBE5VV8MzSmP6Ez
         itlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771774772; x=1772379572;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L8PNvC0iSSC5VHyN2aVmZdPbRfBOAPnSxEK7llz4gIg=;
        b=PcU75F38iIvIHIYc2M30pz5mgbw3A31I+h2JAxAmLNBIsuqSZfCYj1ayoCfzQ4YO1e
         1LwvP9QjGyBqL5OBhFc+PINDTzeDzkuMNiBMmb4LhO20GRIRXOf74XURq+mQ8jD3vNUZ
         95vmFsguOZMN5Hhv5T8dd6YWRKA8vAwbT0+3USU0LYof+Nak1ELbDVW/tcqSQ94FacnU
         0Hgwaoiz2FpRTqM/lLG6vvRB5Ikk3ZqXQbQH+D7kKz90WiB6viYkbFYwCI8n38XwGvay
         M58cK3/dk/mLMyCAZSpCvLQHVtkTBh+PYiBJxFuTvKwGxbX9jYit4eDg26W/hYbOiNsG
         6VUw==
X-Gm-Message-State: AOJu0YzuMMlkYLFuhXbgsrwWWnTKEzKESW/O43vdMF7FlyArue6WmOVW
	/GWWc9iJ1YWyZmQAOQmsbLaIAitFdrwic1JapSK/qu7V194qZYzUfjXEx5J/uw==
X-Gm-Gg: AZuq6aJYgiud5YrIoruAI8HDv3NGF2HyfBfyJGHu6gzX/PVmuZyTo9NSPH9+ZE9/rXq
	7fMT41I9mVU9yPWITscQuVYHoZE4gkv5wO4/SMmHddA94yPQKU8V5A+CPEcJOVz3fthYF4SgPBO
	aNxk0lGnPyy53k2gyN6zW4ioS31dm2bvPFNf2TzbUAkddVaU60RpuVVFZeHYRs/9EuVALA274Yc
	rVBqmLKDoPLB5J0fzen0YJDuuZkssRy5awF3crM096qxHaoWM9Q5UMGwMrWEA0pkiYPBzyGcTvP
	CKi6BILeHKJ5nw0E3aSysCU/J8yBu/dQk8qKVXVv13BifZmQA0a+F5x8Mrk4bi+Qmzid9YusjkP
	T24eUqFkMD4wh6q1aPMNoan4cIVcL/A2rIKA0Gh4n9Mv1T8EWLHidUZ0QJGPLvvIgbRA5Yltndq
	MHVJlPUurk378ohRylGiS5sptx8g==
X-Received: by 2002:a05:620a:1904:b0:8c7:10dc:9055 with SMTP id af79cd13be357-8cb8ca0b5e4mr718768485a.23.1771774772212;
        Sun, 22 Feb 2026 07:39:32 -0800 (PST)
Received: from [127.0.0.1] ([64.236.143.213])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d0eb010sm507637185a.32.2026.02.22.07.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 07:39:31 -0800 (PST)
Message-Id: <pull.2209.git.git.1771774770368.gitgitgadget@gmail.com>
From: "Silas via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 22 Feb 2026 15:39:30 +0000
Subject: [PATCH] Fix typo in MaintNotes regarding versioning scheme
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
Cc: Silas <silas@dyalog.com>,
    Silas <silas@dyalog.com>

From: Silas <silas@dyalog.com>

Corrected a typo in the versioning scheme description.

Signed-off-by: bear8642 <silas@dyalog.com>
---
    Fix typo in MaintNotes regarding versioning scheme

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2209%2Fbear8642%2Fpatch-1-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2209/bear8642/patch-1-v1
Pull-Request: https://github.com/git/git/pull/2209

 MaintNotes | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MaintNotes b/MaintNotes
index 12ba677c36..399d74807e 100644
--- a/MaintNotes
+++ b/MaintNotes
@@ -183,7 +183,7 @@ ready to be used in a production setting.  Every now and then, a
 "feature release" is cut from the tip of this branch.  They used to be
 named with three dotted decimal digits (e.g., "1.8.5"), but we have
 switched the versioning scheme and "feature releases" are named with
-ttwo-dotted decimal digits (e.g. "2.53"), whose tag ends with ".0"
+two-dotted decimal digits (e.g. "2.53"), whose tag ends with ".0"
 (e.g., "v2.53.0").
 
 The last such release was Git 2.53, made on Feb 2nd, 2026.  We aim to

base-commit: 0ceb40560a5cca1c98c1d1b37a1f3254fbdd2efd
-- 
gitgitgadget
