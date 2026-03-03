Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C803943D4F4
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 17:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772557930; cv=none; b=b5bY+f5DfXYvil7d2ac0y7NoeUS5mV4fwv4PprZR+0+xXxk50PEi1LWGF0TKJhu17OTQyjUSwb7LEJqNb18Crlf0Ptd4e2DmmUuKnC0JR8aXFKOqASp9MuKGluAHJ41ZFY5xoqWZk3/Xvl8Uk8fE0lgHkRROEnkOo/I21XPaPek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772557930; c=relaxed/simple;
	bh=WBjp9gYBe+hy3bhhxFfohAhxfHwf6ClPi5WLYdeZvDs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ukUgBH5VmW9u89MpftesU7gs0YYluahZrrB/YfATOifiGvtzL3sJaoH4QN0dzaJj2/e88FQNsu8n30ju3W25FbqgTGiEpHQHmJM1SNgw8WNegJTaUOnakmynzdQpJXbMCxozbBbJmPXZFHt5qjH/BefGbq9Dm3EU/MVPW9GcV3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DdqKCCH5; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DdqKCCH5"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2bdecd00ebdso72242eec.0
        for <git@vger.kernel.org>; Tue, 03 Mar 2026 09:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772557927; x=1773162727; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lb4DLkrQ/OJiKw+TiCM+BxDWktnVtPL4ubf4CW0vdZ0=;
        b=DdqKCCH5A2YSYQF6BRKeU0OreWhbyDf/zHIaUBnWMR43X5djWEmHm+/LweE8emAuS2
         WaqKBAs+q6MLi+8pCAbNqIVxddmaFfobHmpo1jeiw1fK6bPyld/mmNhZqob4z6iSGnKR
         jsLA822XFwWiVGQ19uW5OTCIw7PwhttujRcapAsoQ3tWOrvGPb3COxae8g1fHKQ2+UEp
         cTmruAb9vM/07vh7litcNTLpZeEqIA9cXTNkBi23NylBc5RRwpiSJxyyAOatohKp4kZ7
         id+UPXHO/hdlXcnrBxnNYtApu4+wyfQM1uzBSOEE3kYMd+f5am8N7Ijsr3wSHiXdo9ll
         SZlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772557927; x=1773162727;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lb4DLkrQ/OJiKw+TiCM+BxDWktnVtPL4ubf4CW0vdZ0=;
        b=tG3GMrnQ4ZJHT5XM0Q1E4bdVcoQOHX1IxnLjvJ83VR3V3YohU9K0SOWfODUkvvStgX
         tF4LqihEYuAlx/FBHPNnj8sr8Td5xeKkssXNDzucjLt2e3JjFhFYysWhCWERjGm9y48b
         uJGY7t9S3oK1vxVAPga96BFAu8hK//pK4Q30fK1jyKvgYEpOCvzq2OuCibKZD5zJ3Cf/
         5XGaaQO1IxZrfvqKSyM8C3/Qwyz/eimAVO472hFQKXZFhqOinFZKx2Xc5+3Npwck4+cb
         vnRWavA6cCKQyhMm56N2woP2vVdszAsLodJSQwSdbmEl7UrbiAb4cZKifPP79DtoJoxX
         FEvg==
X-Gm-Message-State: AOJu0YxJpz5ZlajFi4jx7M2SMi4lnML2IMdtx6RpdWCDHCTOgrXg2Q1g
	9o545pzaCmuSysPA90mlWO+VN5rgXHfbbBdYl84BfFS6xXP6aR/l0phCc/8Nuw==
X-Gm-Gg: ATEYQzxZBQ/Etol9RJrZuzZapVhU5RZOZMtIaPNPYFJYFkq5pOJwUtL6TpgayJGguGG
	MQFdYxATcTxiaF+Jjp7qggppDOChA+cBzKYnpi3giO84XgHf/wfptzQg7m+Tn44t8KefNhL3K7W
	DEu7GJ2hn51d/T3WQbmalnbd77a7c9DpfrtnkN++ad8FlvqH/XA+OWr2xvrlBw9OcMpHnNQm5IR
	W0/pkTDVgY5wcQqRPLEm7ubSfEKNMHaV7HWeioFEawzv0fZl/QwAztx7tJ7Yq/SGqoXeFiJQCQV
	+Nflk4WTLAD9ifGUil1rUaRd7NZLUzJBNN+TB2n3/YlsOdFb/CpODMYx2sUI2XeM1dIrv9VqwLP
	JwgMq2hveJANdepCd5aMeQsFb+cHswsih1XJo/7qlHjhU3zR7uWc2Ralu78UpjbWyj5QbWXZdd+
	PKu5D3QGaxWKO/TLz3a3b1CTCY
X-Received: by 2002:a05:693c:290c:b0:2ba:a1a5:b5b1 with SMTP id 5a478bee46e88-2bde1c0e7e2mr6514552eec.7.1772557927175;
        Tue, 03 Mar 2026 09:12:07 -0800 (PST)
Received: from [127.0.0.1] ([68.220.62.148])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdd1f48c77sm15010321eec.26.2026.03.03.09.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 09:12:06 -0800 (PST)
Message-Id: <pull.2220.v2.git.git.1772557925670.gitgitgadget@gmail.com>
In-Reply-To: <pull.2220.git.git.1772479907062.gitgitgadget@gmail.com>
References: <pull.2220.git.git.1772479907062.gitgitgadget@gmail.com>
From: "Omri Sarig via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 03 Mar 2026 17:12:05 +0000
Subject: [PATCH v2] doc: add information regarding external commands
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
Cc: Omri Sarig <omri.sarig13@gmail.com>,
    Omri Sarig <omri.sarig13@gmail.com>

From: Omri Sarig <omri.sarig13@gmail.com>

Git supports running external commands in the user's PATH as if they
were built-in commands (see execv_dashed_external in git.c).

This feature was not fully documented in Git's user-facing
documentation.
This commit adds a short documentation of this feature, making it easier
for users to discover and use.

Signed-off-by: Omri Sarig <omri.sarig13@gmail.com>
---
    doc: Add information regarding external commands

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2220%2Fomrisarig13%2Fexternal-commands-documentation-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2220/omrisarig13/external-commands-documentation-v2
Pull-Request: https://github.com/git/git/pull/2220

Range-diff vs v1:

 1:  b7e2b586c1 < -:  ---------- doc: add information regarding external commands
 -:  ---------- > 1:  02841b66ea doc: add information regarding external commands


 Documentation/git.adoc | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/git.adoc b/Documentation/git.adoc
index ce099e78b8..8bb3cb53f5 100644
--- a/Documentation/git.adoc
+++ b/Documentation/git.adoc
@@ -487,6 +487,13 @@ System
 	`$HOMEDRIVE$HOMEPATH` if both `$HOMEDRIVE` and `$HOMEPATH` exist;
 	otherwise `$USERPROFILE` if `$USERPROFILE` exists.
 
+`PATH`::
+	When a user runs 'git <command>' that is not part of the core Git programs
+	(installed in GIT_EXEC_PATH), 'git-<command>' that is runnable by the user
+	in a directory on `$PATH` is invoked. Argument passed after the command
+    name are passed as-is to the runnable program. These commands precedes
+	alias expansion.
+
 The Git Repository
 ~~~~~~~~~~~~~~~~~~
 These environment variables apply to 'all' core Git commands. Nb: it

base-commit: 2cc71917514657b93014134350864f4849edfc83
-- 
gitgitgadget
