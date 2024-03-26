Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC567440B
	for <git@vger.kernel.org>; Tue, 26 Mar 2024 13:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711458573; cv=none; b=klQB6zZVu8Y6f7jZVpstuOgYbbAyqa86m3B4J6L5yQfvCgHruAP2zIVgWn5rClvd9OwpuEkdSdlS0bM0Nuo1DlbmM5RIwlQ3A1QkwUmLWGw/LChSmhhOUt2Nf9gyTe6rT22DJQ/Z5vYuqOyFFLyV5PGlCXcJc3ywujq02KTKaNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711458573; c=relaxed/simple;
	bh=DubbNUQKdlz/m2hwc0qzBsOrVzz98jd57+UvAxMLqLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ggRz68s6jqDyggfHao0Uw0LLc8jFEohog8p/bxAYCbQfZgUq5L8erQnAJgD29bk/0DGn5NXvlTwS+n9YjvqrtjHHjgoGsen4RxfD2uhp8HV4c+2Z/XxrzwYsLXUMtzSCfvu1s7em5dr6j6S0dqbtVIlMI6Zh91It+K8dYcWrCyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=Pk6tMBhs; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="Pk6tMBhs"
Received: from localhost ([193.175.198.193])
	(authenticated bits=0)
	by mx10.gouders.net (8.17.1.9/8.17.1.9) with ESMTPSA id 42QD9KkX006376
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 26 Mar 2024 14:09:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1711458561; bh=DubbNUQKdlz/m2hwc0qzBsOrVzz98jd57+UvAxMLqLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Pk6tMBhsbiIwSJy8uOQRmhfveEf9jZb5FhSX2q9sk/gPkM3PObpVgfD4lTTEqH8FK
	 WWtFUsUMVKRVeYDOtJHhSuVPysLBXDEKdfVmUEQu7bYSFqP82mYVW4+PmkW14kO3/6
	 i7oulMCKjg+L27L6BCRhe9xXv/fnnBJpG9hZ4WZ4=
From: Dirk Gouders <dirk@gouders.net>
To: git@vger.kernel.org
Cc: Dirk Gouders <dirk@gouders.net>, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Kyle Lippincott <spectral@google.com>
Subject: [PATCH v4 2/5] MyFirstObjectWalk: fix misspelled "builtins/"
Date: Tue, 26 Mar 2024 14:08:37 +0100
Message-ID: <20240326130902.7111-3-dirk@gouders.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1711368498.git.dirk@gouders.net>
References: <cover.1711368498.git.dirk@gouders.net>
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

