Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D801C205ABF
	for <git@vger.kernel.org>; Sat, 15 Mar 2025 18:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742062513; cv=none; b=WWuYIRCUK3rnTDrTVMJmhasSSLXMrjAQDmWfAHIqVmJzyB8QQRG5jjXIfgljZ+sF82cIO0V+aWrfH6084syKL3c3a8AjYfeYbG1stK9Pmte1/NmqoqKiwHk9oWCge0ZfeW1AX1a6ECWvPsLAUEWI31Mi53Mn+yTobBvim4U7Y7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742062513; c=relaxed/simple;
	bh=BZ7v3CiCe1pQKm1wDOYJEE5i+BloSFIuT8r5/SD+6Tw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eJwhwP+bKSM5wUwc9l00ZtwsxRA1PlA1JgWIgZHJb4Bpz0idA4k4FE0QAvzn0wZ8cW4ksVkAqTpWeOWpKYS99Djn9JxQyLAoQwvFrGri1I3RLE1gQPEE9xI2GiUeAhz0jxTpjiZr364mmzp3jYfzlbRVU7dF3g5Pn2zBVk3FjxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VNo6N84d; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNo6N84d"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2239c066347so63363265ad.2
        for <git@vger.kernel.org>; Sat, 15 Mar 2025 11:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742062510; x=1742667310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BmgkXkEZniPj79suYJtGLUq5s6NQnAS/51nMbFSNRyE=;
        b=VNo6N84dCUI5aq3Uo+80rvMbqD8ZMRzMgCUhVNI0YQtbz9A4fSeNvPi/PcHQaOldFt
         g6pQrV8ibUW/sLRzVbGRhqmizIZBZeDZ8sAoZYtol+ogF+zvFAqThfSrL6ICcc0uhnQ0
         JYPK4AftbqBwkT4nx2ayRGfIxfPmTiNLsd6izX12/3P4/YChv9n8GodJVnHwqlcUTUZy
         a6X8Z9zrnsJGtvfqDttok+xgltBh76BR6q60jvofiAgg9h7XRjjL/BF9P8bGOiJy7ltb
         e5T1ceHt4HGny5jrKixQd/HyA5G1Li6PVbBnT1IQOuhFbYYz4fSdDFqNJKpJHvyPyoDn
         xleA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742062510; x=1742667310;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BmgkXkEZniPj79suYJtGLUq5s6NQnAS/51nMbFSNRyE=;
        b=JS0A9IwER2GGt/VWZofdI8vuUj0jlKMjbBbPQ3MDFPmxTVB6S6GYLVMaWzzZYBa4dD
         3d2+ijVsNeUIPEoVoWXBuXhodi3fJJ/L39gyZIZOheDwpdII/JKpWULh2G44ngZHqPXF
         ECfGtMtF0rMxBpEwRtC6PILPhVRf25a8Jg5EL0bwsxrHl5Lpx2KzvY1EJ8zMqF38i8tW
         LFA2MKeBgthMyzf4aa/W08TjyXOYDEbQVP63A5xWZIsZoTsJVLFpoqeOQi8SvSAPqYQl
         E1xqx1Tg9ITdvBbgKl3SwpCo12QPywT8vTf330ULSaxr7NP+9tDIlKa3pBxYOT3U68UH
         oBag==
X-Gm-Message-State: AOJu0Yw8eELJiF2QA4yL64tUg1gXAgXJ9sF9k4OTPVHyHgcmshqa1NWl
	S2EgHKjYAou8poyr3Gb+tEWpI6J08uOzGuwGY81NtHTLbtrzR+zxzivH0XfS
X-Gm-Gg: ASbGnculuVP9wLSNSlD59Gcu2sixhBJhoDlTAEbzf+DpWnMNQAD4q8Ki9+u7qsbNyNU
	asrcCISFeHHhSgOWbfMLe1JsSm6SJxoOfQZDP+yevVToO3vFGBZoqsE64rAA1m/R5YLnNF5LAjp
	nrerZlhxduud40rBLtYqZjXI5MeD3BqpeSehmt4md6XiSFwStpVhFEtyhJV76pnPbgWHgFqBbsD
	w1nnRH5j9v++8RzjNSW8vTY5ca8m2Ndo8WZAIyOnTFSA/oBB3Aw3PGLOLteIfxlha8gSjDTeMjk
	E/b4tW655OxQYT6lhtkzjP8215czVl/Cp9IgglpDRsSKiSQYrnCLhODelBjO524gOVa9Vy/S3l+
	xkt9Wjr/VFqyXxA==
X-Google-Smtp-Source: AGHT+IENF5Yb/i4WqtFVyjYtGZgjBaRkDWfjSZf3MSBf9YfarLDvw37SjsX4oWNsKTgDg1OYteKQKg==
X-Received: by 2002:a17:902:e808:b0:224:2657:2c04 with SMTP id d9443c01a7336-225e0a285f2mr76734735ad.4.1742062510118;
        Sat, 15 Mar 2025 11:15:10 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c005:b018:5841:514c:af52:5598])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd4e0dsm47269775ad.221.2025.03.15.11.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 11:15:09 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: ben.knoble@gmail.com,
	K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Subject: [GSOC][PATCH 1/3] Remove outdated mentoring mailing list reference and clarify tutorial prerequisites
Date: Sat, 15 Mar 2025 23:45:02 +0530
Message-ID: <20250315181504.65069-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/MyFirstContribution.adoc | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index afcf4b46c1..f7e510e6c1 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
@@ -13,6 +13,7 @@ the Git tree, sending it for review, and making changes based on comments.
 
 This tutorial assumes you're already fairly familiar with using Git to manage
 source code.  The Git workflow steps will largely remain unexplained.
+This tutorial also assumes you know/understand C programming language in a good capacity.
 
 [[related-reading]]
 === Related Reading
@@ -40,13 +41,6 @@ the list by sending an email to <git+subscribe@vger.kernel.org>
 The https://lore.kernel.org/git[archive] of this mailing list is
 available to view in a browser.
 
-==== https://groups.google.com/forum/#!forum/git-mentoring[git-mentoring@googlegroups.com]
-
-This mailing list is targeted to new contributors and was created as a place to
-post questions and receive answers outside of the public eye of the main list.
-Veteran contributors who are especially interested in helping mentor newcomers
-are present on the list. In order to avoid search indexers, group membership is
-required to view messages; anyone can join and no approval is required.
 
 ==== https://web.libera.chat/#git-devel[#git-devel] on Libera Chat
 
-- 
2.48.1

