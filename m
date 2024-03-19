Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B8A7E583
	for <git@vger.kernel.org>; Tue, 19 Mar 2024 11:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710847458; cv=none; b=iMy4ykndej7GhzQ7izvV9GxGlspWi+T/QbWm9yE6KdiK0Akizqxl+XBE7aHFd9oiNqWotIxQjKG4HQzzgSMDohIG72XXxOdo5iRWu6fC4PIeZOlhp+XZPs2fvV+OtoLuJtZpfXeHws9f1LmGiiEf//L4/zgH7N6qh9kRLgpXIe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710847458; c=relaxed/simple;
	bh=DubbNUQKdlz/m2hwc0qzBsOrVzz98jd57+UvAxMLqLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RqFbveFh3EZLB3Jdmth0D62mxms+09rG/4pwTQ/SW36ZpzSiJ1sxYSaWCWbKqdZBe1LKDuF0QDpW63AuqOJBWYgjso1GgwzmPhaldb224JHP13BtFC5xtk/Jm4UnjtxoXEf6KshF8Yr8l1wTGqiHpJ18avFnvjdcZiXghjwl48w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=MQCP33U5; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="MQCP33U5"
Received: from localhost ([193.175.198.193])
	(authenticated bits=0)
	by mx10.gouders.net (8.17.1.9/8.17.1.9) with ESMTPSA id 42JBO7JW017018
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 19 Mar 2024 12:24:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1710847448; bh=DubbNUQKdlz/m2hwc0qzBsOrVzz98jd57+UvAxMLqLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MQCP33U5deIuoTuTOONaIqBRVScXRRj57ZFKGNehUFp69yt86nVfImRg+sudAtMg3
	 vmJqcJ7fttDkbmBVcmAgPCxI/f0z0J8qcHjzQBJwhfIuOr3MotwbGWpd6m3gsnN+ML
	 exwopcr9zWtFncs8XESvkf6HyvHdjwDb/PYGkKy0=
From: Dirk Gouders <dirk@gouders.net>
To: git@vger.kernel.org
Cc: Dirk Gouders <dirk@gouders.net>, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: [PATCH v2 2/5] MyFirstObjectWalk: fix misspelled "builtins/"
Date: Tue, 19 Mar 2024 12:23:12 +0100
Message-ID: <ab0b820df7ea2bd15f6c4abdfd0964f931b86791.1710840596.git.dirk@gouders.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1710840596.git.dirk@gouders.net>
References: <cover.1710840596.git.dirk@gouders.net>
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

