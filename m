Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C573A21638D
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 09:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783590164; cv=none; b=oGZuVU+z0LzCzrfLjtJOEcFl0xTZQK2OsVG8A9qZQeuFul4YmIQzigA/mLM+cfNIqY6uKFnp78MRAwxoyz4WQqDGPrrL/Yu+UXQ0/Ee0HxybKEF4EF/pXzSideWOdX8VExFRqRVtl/MOk7IwjjGc+tvNeeBJNz6B/Y9+tBbtclw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783590164; c=relaxed/simple;
	bh=UqalL05URYmAOvl/p+Gaqm4cCOqgxV4yCB0nasYGJ3Y=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=NPuhoVWYGUgffoWi7HiRwFsx7b9c5fjkbU/R57Q3OZeM+UW3wfqAvuLzCVT8wwrrNRa9oN6DmgKwXvBLKPjowiIwZRuKDskgqLnPAqGYSsqv/6goRP9uSp65DMj55gI/RdUe/u3xlUdp1HrHDk7lwgFcHzY66yeS+FD+luX9Sls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GqzWXsn+; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GqzWXsn+"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-92ed19f4d60so45334385a.0
        for <git@vger.kernel.org>; Thu, 09 Jul 2026 02:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783590162; x=1784194962; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=a5eWBmiC1mAbY5f3P9iuefmqtIRV01BwfLsyEJtoebg=;
        b=GqzWXsn+wlKUMN1OKVZJC1DwTkajbRF4+JbJ/OXr1ztcL8zEKhuDU6fNHwF56KtSwE
         yMVQIFCRNFeFugWsW8d2kwoytrnQsNx/nMepqMRjK+1SDIqA2MAFd0c+Ij/6t1Hiowwo
         xkhKfmw91UPuFjSwxuvIzYahoeT88dP37yY0nn8qAcoQW5wo4/LdTR4MeBRF2QCW4/Va
         zT3HbsebJYeZgXPbGJ0+ft/CU7lnisSkQF6btTnAtUzH0wvU8Jj7ij1zR2WdDpr64j/3
         qFCK/HjrFP3IgJDigiMakGoZrtj7cTTueUgFIsxZAx+fBdnGW5RBkkrHktrSz8wGtyxx
         P00A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783590162; x=1784194962;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a5eWBmiC1mAbY5f3P9iuefmqtIRV01BwfLsyEJtoebg=;
        b=EgyWhem62DsMyeKc8qWZnMUtEoakVS8PJnOjEq8QcdqWrJd4LR0YOWDvNkbQxCjMOV
         vTWK5VBd0v8RTIvqBZHWzksUtge5W0Ib+c9aHbVDKGST9SrMmOKJtWsP3yzF9/9kS59O
         +SfqG6VOcaiiSIoxx41MVq6XJJR7qiy3lwWf8zRABxHMixKphZANS9U+xyK8xVRLcSF0
         QV5drCNerRs/op2B4nz7bH0bpBGyAtDVAnRsmURIZVYvH5wPESfP8TEB6ZpAbiDKaNST
         xmFcop6PSmwYH1/RDYSv6fUn3OWK+qMrPif1e2d2KkzOTIm6v94lHTM/t6PyuqdxjtiA
         HOKw==
X-Gm-Message-State: AOJu0Yzz8bjPvdNL65XKBSHFnx52RYmCWbZrxqK7dNJ05Qko/FIF3OD+
	pnnzJgaKe3v4ttn20gwpWwYp8wkTeNcsRQke0v3Crm+2lxqSTz2aeN/vI7zP0jyJ
X-Gm-Gg: AfdE7clB2nfc2QbbkVYYbGA84Rl9UJhdOBwBLq0AwU+TuqyulHC+Rd5jGdxbJR0mTSg
	vTkbwgWyGnOPS7Je8oo/GFxnupeRbFU4Woo4XAQwSHNU7qiG3YBQRkPlZgTOSbBBgmibre/q49n
	VbOVWVHc0lISFIqyUA3/6BL4OvkULrb6piWNYsm41UCHKGQofLMHJ7RX+q5X1xrACGxomLKzdPV
	6BdhqduythD7l3R07ZI5VkgS+uit79pRhjdr0mzQIsOwUewzsO9ogidJFYQcIj1FTe1RjJeePXX
	LPo7O0od7TcdNMdnEgGAj5NW8+KyahUu2WxViVMRlOj9k5aXdaUhml5dyWPWms3FGqr4BhOpRol
	h9dHigZbiMUW3MgnE6IZiDTAjbSA+xNx1vCkC0xBJvu4sNkXHY0Dnhyn7kAu5q1wvgZ8DU7kc8N
	7qa3awTMYMXt5M
X-Received: by 2002:a05:620a:1721:b0:92e:c0ac:aeb8 with SMTP id af79cd13be357-92edac5fcb4mr200379285a.42.1783590161790;
        Thu, 09 Jul 2026 02:42:41 -0700 (PDT)
Received: from [127.0.0.1] ([20.84.47.35])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90c926basm1582229685a.22.2026.07.09.02.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 02:42:41 -0700 (PDT)
Message-Id: <df00334f8b8cb85a928e1ca22aa12dd6b87fb154.1783590159.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2174.git.1783590159.gitgitgadget@gmail.com>
References: <pull.2174.git.1783590159.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 09 Jul 2026 09:42:28 +0000
Subject: [PATCH 01/11] diffcore-break: guard against NULLed queue entries in
 merge loop
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The outer loop in `diffcore_merge_broken()` sets `q->queue[j]` to NULL
when it merges a broken pair back together, and has a NULL check to skip
such entries on subsequent iterations. The inner loop, however, lacks
this guard: when it scans forward looking for a matching peer, it can
encounter a slot that was NULLed by a previous outer-loop iteration and
dereference it unconditionally.

In practice this requires at least two broken pairs whose peers
both survive rename/copy detection and appear later in the queue,
which is rare but not impossible.

Add the same `if (!pp) continue` guard to the inner loop.

Pointed out by Coverity.

Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 diffcore-break.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/diffcore-break.c b/diffcore-break.c
index 17b5ad1fed..b5bcc956cc 100644
--- a/diffcore-break.c
+++ b/diffcore-break.c
@@ -289,6 +289,8 @@ void diffcore_merge_broken(void)
 			 */
 			for (j = i + 1; j < q->nr; j++) {
 				struct diff_filepair *pp = q->queue[j];
+				if (!pp)
+					continue;
 				if (pp->broken_pair &&
 				    !strcmp(pp->one->path, pp->two->path) &&
 				    !strcmp(p->one->path, pp->two->path)) {
-- 
gitgitgadget

