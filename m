Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECE956B96
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 21:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710193181; cv=none; b=m+lyPFVO2s/ynDufbmPt2SMi5Pi7Uq7i9GnlVs/qoeOjISv5sbd11V6hkEZLeexWWNT59yRoRN8Wwpsp9uTD35BIAt/1i+J3hc8msYrSqcqFsP6YgsUJsWdWbqOUal9IlFkXzisvFBsR7uNpjfOalH4dqmyXp6BFgNl2sa/BaxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710193181; c=relaxed/simple;
	bh=KqhxDseAiHHPNKcsiY44JB1NrX1A2BTUWRWDEpGMqnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NpfVgur3uSqtUVPrkrVOYac5VAA68Cy64klip4EjC5ISjgvECsvk78d4xrEAMdeksIL1nw4TNCCasxWvqoaOAPG6sFfS7I2sEPKTCf5T4c7JmimZOmDv9LnQO5RdT87gfDJWDD9S3CCrUfz05pK6OMvcCx9EeRVWka0kUXFVQd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Sam James <sam@gentoo.org>
To: git@vger.kernel.org
Cc: Sam James <sam@gentoo.org>
Subject: [PATCH v3 2/2] diff: whitespace cleanup
Date: Mon, 11 Mar 2024 21:38:54 +0000
Message-ID: <20240311213928.1872437-3-sam@gentoo.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240311213928.1872437-1-sam@gentoo.org>
References: <20240311213928.1872437-1-sam@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix whitespace after 'return' and add a newline after the if block to separate
the strcasecmp logic from the rest.

Signed-off-by: Sam James <sam@gentoo.org>
---
 diff.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index a6433dec30..9a7425cae4 100644
--- a/diff.c
+++ b/diff.c
@@ -207,7 +207,8 @@ int git_config_rename(const char *var, const char *value)
 	if (!strcasecmp(value, "copies-harder"))
 		return DIFF_DETECT_COPY_HARDER;
 	if (!strcasecmp(value, "copies") || !strcasecmp(value, "copy"))
-		return  DIFF_DETECT_COPY;
+		return DIFF_DETECT_COPY;
+
 	return git_config_bool(var,value) ? DIFF_DETECT_RENAME : 0;
 }
 
-- 
2.44.0

