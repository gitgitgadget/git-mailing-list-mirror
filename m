Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C85429D267
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 02:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773370745; cv=none; b=XGIiFZWVwmNtQHFUDZbXAdeRvErcZ6xtyg7xQa5xmEP20YhiHT4usC3XpmnA5wbYQhJWXlqRY+2R2Z01rOm/rcKV/7gz2HYBetFiE7e6AeH33QjqPMK99d9WRDXUkEwAReNPkSOfvtGz8TQ5M1HNwzzYHbPwn8MJK49qVL80HyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773370745; c=relaxed/simple;
	bh=o+HZ1mAdgS+5LsRYVC5OcATKqACkU7eltgYLCT1jKsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dalWTwfxsmYtaddyeSXtvhVgN5TgyBUaH6k51k0y83k7vz4WLVcrtjkav52H+qCmT99t+AZUPfDEWaZam1qnZ84YNHZv/Kkmd3yLojG2EGNor/jMzfld+oRtXKm/X6VCNWBLH0cUuLAhzhZRVhyxxBqE1n23mE6X4fADJNl22q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ar/wdRl2; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ar/wdRl2"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2adff872068so8275365ad.1
        for <git@vger.kernel.org>; Thu, 12 Mar 2026 19:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773370743; x=1773975543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+2DM8X9R/IkYkZLWozt0mYj7ku4widtjQc1K+pZxBU=;
        b=Ar/wdRl2LsTnllWub8eCDNp6oifSuEesrlkTL8kh15wp9/1QN/Z4Qae1jlSBfyADnR
         ydErtzKkJDOeYP8nBO9lNZntMpoYt9l416ryPFtSTt2CPap8SgpUHU/4lxIeKPHGdrTo
         GEBLxlKwKDces6VyX1rg3NLOrmuNNPKefTAQEMQBVv8cKov2XVCQbmkgkFYUvnqkX8RM
         D9CxBs62TSMXhy/mnMeTSwl9cSvNwr989VnbKSVnzkGRYEGGPJ2hLm7WdOzwE5c1QG74
         gkPeVhl0vBp/wwGVEfMLhGd9hxIgcCV4p0gkgHh8z0vBiJa8pgZTCcELL/gyizjvQoNR
         9GYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773370743; x=1773975543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h+2DM8X9R/IkYkZLWozt0mYj7ku4widtjQc1K+pZxBU=;
        b=nzfovfNDQkefTOh9fMj49WpVGnKQR09KFdCuTAoueHJu5ud42wrMA2clsVcu2y+uES
         3S5brFEMQSLC+sM7bzQhxxJTN3eO6WwrG8dEjdvFrzovEmOP62p6ye2aXDtm6AQ8NBhn
         jS38lguGBmj7/BtbbJdi/q+gHoeRB2gsr0HYTKmQ48StOT4pd1itb/s9UPw9Bf+LoL0u
         p6Tpch73dakTl3hU0vv329lV+xDWR2DipOCb59mKzg513zTtAC6G361CE4LBbirVlEZH
         DzT78cX3GYX1Y2v3dngYU/9I2O6hs2fXfxyIi5itqnCWdqFckOMfpsjQDLRT8C27H/H+
         tXQg==
X-Gm-Message-State: AOJu0Yy5ftEr2ju78NosOS6kImZxjy0zB0Zuh8amfWu/gskaGzzNED9H
	CNZ3eFal77s3BIfyLX3Jcd+x9W2aXRbHDiH3z3PfDK8Tjp4Ooi5QyBHxhDx4B8+gJRk=
X-Gm-Gg: ATEYQzzGP+45iCP3/NihCfoeULzRCNQdz9wofo/helEn52ACYP7micKjZiUgBpHNg4u
	wLsxQw6Tlv4ZMq0He2KLL8Z7kpuSCXPQogGjKxDvYtWvtLYWPmfuwyTloxviW5gOC/QL6YZWauh
	TNY71CHH8pEM7LJqt7+5o9o1zEXYZ/Mzn2+oxfH21C8qTdq43B/tp/oW0yOeyReIVdjsZ+zzCMV
	hOasZXkDXD9Dzbg1Pe7uFC91ME3GZN188j6faPwlRRYie7/7ugiYkgWOtEfAGJCjCqJCUBzOHKY
	Y+yHSuT982sj5v+TLuFGCqkNiStll9d3R3txVKTo06xLXtp9pwgZlJab5fqO9z8TaO+nYhnqlbe
	npv+Nd1mZERwz3v+5j7LfyOB8Ual/tULxO/5rIvJmFsbxAQN6Drc7jAVsl2M6gt/Kjd+0dPZr2P
	OVFAe/nC1PM11quWRuIT0lqsMkvSSrCTkstIKfAm55mrqewNV4rw9A7L7DBgGVjCKpASoX7AKgQ
	MAR
X-Received: by 2002:a17:903:2ec7:b0:2ae:c67c:3b05 with SMTP id d9443c01a7336-2aeca8ec2b6mr14594985ad.10.1773370743013;
        Thu, 12 Mar 2026 19:59:03 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:c0ee:598f:20ee:2768:9705:3a24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece7ee3ecsm5582135ad.42.2026.03.12.19.58.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 12 Mar 2026 19:59:02 -0700 (PDT)
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	sunshine@sunshineco.com,
	peff@peff.net,
	pushkarkumarsingh1970@gmail.com,
	christian.couder@gmail.com,
	karthik.188@gmail.com,
	r.siddharth.shrimali@gmail.com
Subject: [PATCH v2] t0410: modernize delete_object helper
Date: Fri, 13 Mar 2026 08:28:52 +0530
Message-ID: <20260313025852.30010-1-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260312125030.7799-1-r.siddharth.shrimali@gmail.com>
References: <20260312125030.7799-1-r.siddharth.shrimali@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The delete_object helper currently relies on a manual sed command to
calculate object paths. This works, but it's a bit brittle and forces
us to maintain shell logic that Git's own test suite can already
handle more elegantly.

Switch to 'test_oid_to_path' to let Git handle the path logic. This
makes the helper hash independent, which is much cleaner than manual
string manipulation. While at it, use 'local' to declare helper-specific
variables and quote them to follow Git's coding style. This prevents
them from leaking into global shell scope and avoids potential naming
conflicts with other parts of the test suite.

Helped-by: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
---
Thanks to Pushkar for initially testing the patch locally and suggesting
improvements. Thanks also to Jeff, Eric, and Junio for the technical 
feedback regarding 'local' variables and the redundancy of 
'test_path_is_file'.

Changes in v2:
- Added 'local' to variables and ensured they are properly quoted.
- Removed 'test_path_is_file' as 'rm' provides sufficient error reporting.

 t/t0410-partial-clone.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 2a5bdbeeb8..d36d1c3a5f 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -11,7 +11,10 @@ test_description='partial clone'
 GIT_TEST_COMMIT_GRAPH=0
 
 delete_object () {
-	rm $1/.git/objects/$(echo $2 | sed -e 's|^..|&/|')
+	local repo=$1
+	local obj=$2
+	local path="$repo/.git/objects/$(test_oid_to_path "$obj")" &&
+	rm "$path"
 }
 
 pack_as_from_promisor () {
-- 
2.51.2

