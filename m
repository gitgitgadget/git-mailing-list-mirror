Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8BD2F41
	for <git@vger.kernel.org>; Sun, 12 May 2024 03:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715483664; cv=none; b=ffTP27c0Tx8vB5Yi/nZShTgm03Nxib0grHADz9BMKiY0vib60YVAGSvMJQFRpmxP+fnkZNOPRRzSI2d6IKLLAGAa2u0wujJChRFWwSuDKFzsOMt5xPTh/itGIkfN1fg0jtfsv7MAiFX4NA2bEr48aGmA/92cN0fUJna3/LJ2eoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715483664; c=relaxed/simple;
	bh=4sDw+e0zLF1Xj/lBUMnztSv9ofOGUh+Dvst68E/dV2I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VvwOCSkeTclbmxbAeq0QiCsfx68zpjgT2pNLN+BpDKcMvvrJcAMobUbwBbtQIkekGe3tITTvtnFhmf6tbWcZNi4KL9o7TvQNemLU90f9n/C8sj2AcULhiRL3DG29dqOP8S2RtKcHtu58WALMvuMsk+pHMMYcqzfbFMMOIUBpdQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MQi+S0mJ; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MQi+S0mJ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715483654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xR6wcuD7OqYvR4koptnFZlHWvmSwQmJmP5EeDsIrBeI=;
	b=MQi+S0mJmymRdDr1zIZtINtifAuoDb1dmGS5iSJYD67s+bZPCxX+QORHmA8C/0wfg4iar+
	VTBuvYaLyWaMyXNAg/UuqZLZ3IoGZgz9I69mEndxAMhdqtltn88mDHoWZV2tr4ZOd8zhsb
	4qH5MCVG4wk3ePiNA/+1LA0WG25IIVY=
From: Dov Murik <dov.murik@linux.dev>
To: git@vger.kernel.org
Cc: Dov Murik <dov.murik@linux.dev>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Arver <linus@ucla.edu>,
	Linus Arver <linusarver@gmail.com>
Subject: [PATCH v2] documentation: git-update-index: add --show-index-version to synopsis
Date: Sat, 11 May 2024 23:14:00 -0400
Message-Id: <20240512031400.28416-1-dov.murik@linux.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In 606e088d5d (update-index: add --show-index-version, 2023-09-12), we
added the new '--show-index-version' option to 'git-update-index' and
documented it, but forgot to add it to the synopsis section.

Add '--show-index-version' to the synopsis of 'git-update-index'.

Signed-off-by: Dov Murik <dov.murik@linux.dev>
---
Range-diff against v1:
1:  da0359eef3 ! 1:  1de0c0d221 documentation: git-update-index: add --show-index-version to synopsis
    @@ Metadata
      ## Commit message ##
         documentation: git-update-index: add --show-index-version to synopsis
     
    -    Fixes: 606e088d5d9a ("update-index: add --show-index-version")
    +    In 606e088d5d (update-index: add --show-index-version, 2023-09-12), we
    +    added the new '--show-index-version' option to 'git-update-index' and
    +    documented it, but forgot to add it to the synopsis section.
    +
    +    Add '--show-index-version' to the synopsis of 'git-update-index'.
    +
         Signed-off-by: Dov Murik <dov.murik@linux.dev>
     
      ## Documentation/git-update-index.txt ##

 Documentation/git-update-index.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 8c47890a6a..7128aed540 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -25,6 +25,7 @@ SYNOPSIS
 	     [--really-refresh] [--unresolve] [--again | -g]
 	     [--info-only] [--index-info]
 	     [-z] [--stdin] [--index-version <n>]
+	     [--show-index-version]
 	     [--verbose]
 	     [--] [<file>...]
 

base-commit: 3402c0e53fb798cb471dd6562eb5c938885b7295
-- 
2.39.3 (Apple Git-146)

