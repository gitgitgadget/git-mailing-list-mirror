Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5D3299A8E
	for <git@vger.kernel.org>; Thu, 15 May 2025 12:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747313146; cv=none; b=Zx0z3M2i5MWhu2TtjKMO5pdVUczkxpHDCS56w6Dxk2XLtjHE0wC49Z0mArQcjAu0BBy4fyiJzEGpNlrlAz8UYLKKP55eYe9InHXktklkh5PGwYd5C4uRerqPg5BGtvR3TfLvKptoQGsy2LR3y1a0JY3KNMqQ9D1WwMkaVEejOm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747313146; c=relaxed/simple;
	bh=va9Tz8KTSRvGgq/lkRM3r4l6FD42E0QsI04PCdx6Y9U=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=QUbIGmWD7nnFh5XRcKa7GpAUUSeqdkItSGc+3nRc98t/71hidk9+yoWbeI6T4jEe8O6Yylp69e7S9XiCKX2CtnULbPeaEGfZ5iMBcm2QOeT6MVCLot+0bS4nRrTymGY5uIfFo1PF7dqzuJ2TnhCcns7R/pBzyeO7HlNSgokwCuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VcAjGA2t; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VcAjGA2t"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a0b135d18eso498196f8f.2
        for <git@vger.kernel.org>; Thu, 15 May 2025 05:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747313142; x=1747917942; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9jBaDJPmzGQjOvHsXeS9UYYO7z7CrijbSH/0rFnO+ug=;
        b=VcAjGA2t10089Z8KcF+qMNvKqT1wRQAD6jKxbyFj9aNxums8U8CrZ2PaSbUO7PDGeg
         XoNhqDpZa8yE4nNLaLKf+sWs14wVjhLCe5xU19P9MRl3ci9aYLRXIM8QemHN9Fc8VKHi
         q4f55QSuxaKVEQ5/tpsOHo1z7i4Ho+RnbbSNlo2MYzyIwVZncbEySyxIKoUj4CEBMfhy
         zZzrCWe08oIZN+F8yflV0Z6zEphEqtOKz2a0nVPGPHGSEJOx4DRbTYI6j78NbMl7z7D1
         3Jp7p+6swFMQVWPdJdpfAcMFpRPM3siSaugh3hBAw8/8sXvruMySbuZZ0YNNJuB+XOOX
         oD6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747313142; x=1747917942;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9jBaDJPmzGQjOvHsXeS9UYYO7z7CrijbSH/0rFnO+ug=;
        b=WkqDia6JxP38n6oatfUs4PuhaJCN8HCNxvDFL1mMzZ5VDiWeQekpF9Y6jDrLSxqF+T
         X7gM5wgdgPAl9V92j1Ab9F3/Q8/V6Ni+WN+LRATOCOcZX0xkslNxww4/dM326zwsPG0t
         R+Bff8aRPjg01LbYf2wRbQXsvuyD1RqplfOwLT52+UKGZDp7q+482Amk2ujzmSbyjyAE
         8Jje8zKb1SP/zrq7KOMJml8DUSZPpYMvE6+eu0wUrc9XvckuT1yyf3I1XlFBo5spbGAn
         upv2AtrTmUUPl//L6fs0fL9bWYk/Ew9LET1ScVlj9uO9eHYn7ZrJ5RBCDNJkWpz9inVI
         Pwrw==
X-Gm-Message-State: AOJu0YwJ07vRDjrJ/J5Myvf2MyuGUZ8V5TNxudX+Iikl3KXV3txRMd6t
	0EISzTknMkNte8DykCx4Vfn9R0oNGbIEwL0UisD6KAV5tVcLIuBaT3CfDQ==
X-Gm-Gg: ASbGncs/hlDc+Nq5fzuQJYDj6Q5hil7ebZG/F3uNclfSpseudPCQ0IMrmTVgJE2ECk1
	ZGFnMq551aC0OWivopK82MjUJd63mW8fybl14JMG3UkS3SVUsmtUYQ6hEMnauyue9j4OSTBt+gi
	zAV+x5h6dfOUBY2PCfAO08/jaNlM/EwehNwggl8oKFqZ6Om/ohKQv0ly7Od9Jd9LsayqBjKBHSV
	mCCItBtMUgbVPWQlaKrC2HsUq4jGrlyzCGtjlOZrKp9JyoL08nQBmzOmAHdTJSdRyvApim/5eh+
	Cfc6I0X9XbKYxpJY2rbgviYmgC3uGbQappApRWWY8Mn77mO7hvTa
X-Google-Smtp-Source: AGHT+IHaE1eIBRRBiiQw15vcE/xNdjh+haIB9sJ2Mvq+wj/4CCHcR+tsLlqrVr1ZUVIvLBhRhtAWBw==
X-Received: by 2002:a5d:5846:0:b0:3a1:f72a:8948 with SMTP id ffacd0b85a97d-3a35372316emr2413517f8f.9.1747313142276;
        Thu, 15 May 2025 05:45:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58ecaf5sm22240813f8f.29.2025.05.15.05.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 05:45:41 -0700 (PDT)
Message-Id: <604e67ee64167efd5282b9efabbcb6e72eeaf5e6.1747313140.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1890.git.1747313139.gitgitgadget@gmail.com>
References: <pull.1890.git.1747313139.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 15 May 2025 12:45:26 +0000
Subject: [PATCH 01/14] revision: defensive programming
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

On the off chance that `lookup_decoration()` cannot find anything, let
`leave_one_treesame_to_parent()` return gracefully instead of crashing.

Pointed out by CodeQL.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 revision.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/revision.c b/revision.c
index c4390f0938cb..59eae4eb8ba8 100644
--- a/revision.c
+++ b/revision.c
@@ -3359,6 +3359,9 @@ static int leave_one_treesame_to_parent(struct rev_info *revs, struct commit *co
 	struct commit_list *p;
 	unsigned n;
 
+	if (!ts)
+		return 0;
+
 	for (p = commit->parents, n = 0; p; p = p->next, n++) {
 		if (ts->treesame[n]) {
 			if (p->item->object.flags & TMP_MARK) {
-- 
gitgitgadget

