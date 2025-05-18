Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FD720297C
	for <git@vger.kernel.org>; Sun, 18 May 2025 07:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747553692; cv=none; b=SpBQ19ThfDJ1PN043CIW0hkoVbOn/V7EKZTIo5RpGxYfeQlFWIDsWyG1RUHlMv/SNbV9LDhYUqJspNWZciZsiVYfvQhnp12p00BTdJ2iG2bsJ5Ada/CSKbQEt3ue9P9E1as8XVnSBkyLHGC7wbhY+67ua6b022tCgRDybA+pNHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747553692; c=relaxed/simple;
	bh=uc8jvo71wJ6T/di2Zhi1KXD4nBzo0nr0FaTxPIVlieo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lKdLxg1ZAhubJoQZhY9RrXK5y05TVnZUurltWTM4Ahxywbcjruv3TxJcnFd9m9b1Y40RDll2J+u1E0IROm9p//30zK9cDIZr2k3aC0iwCKhdvBmc6fmdnajoq6D5eYngrqj7nE9KXAsf+PNiSxP4uxnXPW68k0k0rNPVIFwT90o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=adyk59Dq; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adyk59Dq"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2302d90c7f7so43787185ad.3
        for <git@vger.kernel.org>; Sun, 18 May 2025 00:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747553690; x=1748158490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6VvU/u9woi4obNyQvvteoZrePFEOoO1fNnsT9mP8MPI=;
        b=adyk59DqDYldfAfmDLP+r/p//94ro75eNLixawmwAb0d8bXD28W62ylVyz6cOrWPse
         ksqciga/bcCCmkaJ7mQA0v0n63eZ5jdOCh4x3PaFHE3Gef/YPpFAmHOcKz/uxGFWGsZk
         mxHWHOISSZEzsyxxr7mDAJm4kz41A9udIg3JyOLQYzJ93K1zKv4YySwCM8aslJkp5fuI
         eSX6Rub8cKU/XvVgx+ndwzR1XGiXh3YCOVS0qkfHubGUBwzxiim5o10mKexRTTUVH3hO
         0gWPpAWIhJJSoq7Ow3kBDZinc97kIXug0KiFuc24A4E7GloDVXWSaHp1KgYPJMwnM7RS
         L0tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747553690; x=1748158490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6VvU/u9woi4obNyQvvteoZrePFEOoO1fNnsT9mP8MPI=;
        b=pjR+YcjuCcGILDh1YNOxKopnS2lp4fjGFeits70Qw7HrkkbH4vtec9sUi4XmwZqgBD
         rKywr0p1BcKMDuC7bJJh2V2fx1JDkWZklxz6Nv0zs5PQcS1WNjZy6LKgH7zd5f92pog6
         FxveKmNyV6qXhfM5J3aOBo8xNHlSXUxliAWfOHnas/6/l475yYONrG6q/kZNAolhXL0W
         72OpMWc3Q0u3VSWJaerks50Y/oD2armyfP9WMZpOoRDwTT8gqOtZJk9ndDEwT6EAxMMU
         H4HxlDa9mGRQQU2fMvRYDoDqEqJzbVRHJSouPEKBbYSqVCrGWz6xVDwqVhklWl4tu3XR
         SC9w==
X-Gm-Message-State: AOJu0YxL3wdRI/gIR4P+OYnwJH+6kBZI/fKERNNufZJKGvBnW5uS7mAJ
	bssqUZznSuLl02ny9rNrKnHkubmIgho3PQS2X5JKOgMgB0UN/Fve2mSP
X-Gm-Gg: ASbGncuJNrp8VZ70O3S0xpzF2b2hunwwt6J9zGNzNY/0mBSb5OgCCNQYgKXZxVi+4MH
	CZi0oR77yAc6au0+7Khm6zS35w5y2YDl1/2gmwY3wSEMt1efIN1B/bxRlEyT7lCURdBMSfxnap1
	9dEPRzS4UtZa5bz6H7VSNEZBA7r89znlSL71YfjwcJcuAD0ie0LAW+b/sI4vUTdRmkncK741pKH
	BCi1mxEfQqOA6WfGgVzQj6zi/xY8yNLzBZqQsWZJEoUBIL9oPVtw4//g3bxhopcrMuAcdTTyg37
	nnwGt5HRgwWaAD6FafYVccgb62xGCV1FoBZqQiesd9OHRDCc07ftbprrc3Zc7O1dcU3HbJsl+pG
	1HQ==
X-Google-Smtp-Source: AGHT+IE2/w49qOvJJg682uu/mtGJGlARS9ZaJemKucMcfXHJz0hWxAAyR/0pgXxoTmj0I3+AZM/pjg==
X-Received: by 2002:a17:903:19c4:b0:220:e655:d77 with SMTP id d9443c01a7336-231d452d0e3mr130447095ad.36.1747553690619;
        Sun, 18 May 2025 00:34:50 -0700 (PDT)
Received: from fedora.. ([2405:201:c005:b018:6a51:b86d:8d8d:758])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ed897asm39847715ad.250.2025.05.18.00.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 May 2025 00:34:50 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	jayatheerthkulkarni2005@gmail.com,
	nasamuffin@google.com
Subject: [PATCH v3 1/3] docs: remove unused mentoring mailing list reference
Date: Sun, 18 May 2025 13:04:40 +0530
Message-ID: <20250518073442.72666-2-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <20250518073442.72666-1-jayatheerthkulkarni2005@gmail.com>
References: <xmqqa57bqdxt.fsf@gitster.g>
 <20250518073442.72666-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The git-mentoring group was initially created to help newcomers
with their development itches. However, in practice,
most of their questions were already being addressed
directly on the mailing list, and contributors consistently
received helpful responses there.

Remove the mentoring group details from the Documentation.

Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/MyFirstContribution.adoc | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index ca1d688c9b..ef190d8748 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
@@ -40,14 +40,6 @@ the list by sending an email to <git+subscribe@vger.kernel.org>
 The https://lore.kernel.org/git[archive] of this mailing list is
 available to view in a browser.
 
-==== https://groups.google.com/forum/#!forum/git-mentoring[git-mentoring@googlegroups.com]
-
-This mailing list is targeted to new contributors and was created as a place to
-post questions and receive answers outside of the public eye of the main list.
-Veteran contributors who are especially interested in helping mentor newcomers
-are present on the list. In order to avoid search indexers, group membership is
-required to view messages; anyone can join and no approval is required.
-
 ==== https://web.libera.chat/#git-devel[#git-devel] on Libera Chat
 
 This IRC channel is for conversations between Git contributors. If someone is
-- 
2.49.GIT

