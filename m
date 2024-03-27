Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA4947F54
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 11:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711538585; cv=none; b=MDMrCTefL8zAs66eMPhLaZfnEe/JPt9C5dSi9j3vtpl6Eoj7r1EE24xeE+vl8+wDEq1iCjAFAibwAhUEG5+LBetSStjipgZYU9bFmStATm9EFAvee3HASy9pwCgCvwq8xXyyUL/ItPqA//sDInNHGUJ4+rJleChXU1tyuOXhEKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711538585; c=relaxed/simple;
	bh=DubbNUQKdlz/m2hwc0qzBsOrVzz98jd57+UvAxMLqLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UbFdocGLp7z8XXgBEM7Z6WvqoYR6ZWEXtHm7EooLpCBoVu+YQDIj2Dzr6TVews7PtoRvp5xhoTvaYoGlUmRGlFtv2vyB5j2QeDN2sajAOtBabAkPg9v568B6fMccw7iUSyE/f/Q8RpdtiYbh1LMJc130Azde0WNnGyL8RTblMvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=hr8QkW4c; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="hr8QkW4c"
Received: from localhost ([193.175.198.193])
	(authenticated bits=0)
	by mx10.gouders.net (8.17.1.9/8.17.1.9) with ESMTPSA id 42RBMqNr003299
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 27 Mar 2024 12:22:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1711538572; bh=DubbNUQKdlz/m2hwc0qzBsOrVzz98jd57+UvAxMLqLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hr8QkW4c2nRxY8BwXTcxppdXzzK6/s+5avCVB/X0G/2BMskTExCIdHMSmu2HtO8oA
	 6mm8DyBxtsCuFxrzzohByZtyOTSTexua1uM8CmXgrZzH7poaS80AlKz/QVYI5Hkxgr
	 5dRAqZWUlTg8lcy67M/fh6cdC4p8X5QogZ2LiGJI=
From: Dirk Gouders <dirk@gouders.net>
To: git@vger.kernel.org
Cc: Dirk Gouders <dirk@gouders.net>, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Kyle Lippincott <spectral@google.com>
Subject: [PATCH v5 2/5] MyFirstObjectWalk: fix misspelled "builtins/"
Date: Wed, 27 Mar 2024 12:22:13 +0100
Message-ID: <99284db8c18b4b53765126e04f6f7248058ac1b4.1711537370.git.dirk@gouders.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1711537370.git.dirk@gouders.net>
References: <20240326130902.7111-1-dirk@gouders.net> <cover.1711537370.git.dirk@gouders.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pack-objects.c resides in builtin/ (not builtins/).

Fix the misspelled directory name.

Signed-off-by: Dirk Gouders <dirk@gouders.net>
---
 Documentation/MyFirstObjectWalk.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/MyFirstObjectWalk.txt b/Documentation/MyFirstObjectWalk.txt
index cceac2df95..c33d22ae99 100644
--- a/Documentation/MyFirstObjectWalk.txt
+++ b/Documentation/MyFirstObjectWalk.txt
@@ -525,7 +525,7 @@ about each one.
 
 We can base our work on an example. `git pack-objects` prepares all kinds of
 objects for packing into a bitmap or packfile. The work we are interested in
-resides in `builtins/pack-objects.c:get_object_list()`; examination of that
+resides in `builtin/pack-objects.c:get_object_list()`; examination of that
 function shows that the all-object walk is being performed by
 `traverse_commit_list()` or `traverse_commit_list_filtered()`. Those two
 functions reside in `list-objects.c`; examining the source shows that, despite
-- 
2.43.0

