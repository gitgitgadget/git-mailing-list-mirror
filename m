Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF6B1741D7
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 13:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711372785; cv=none; b=i0JEerld8EnjNhZL8WIBXGzP75SZwJhjqMiST2SqGeKMe3d7G/DcSrqceCoXosd1e1f+JOQiD+rtV8cR/yzCCfS31epZdPL73PQJmTkQtVcSTCwmcyhP5VUI2RGMC2VL154eOKk4/0iX6HyLKIB5RcHL+7spCl+TYn/GCGPTyCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711372785; c=relaxed/simple;
	bh=DubbNUQKdlz/m2hwc0qzBsOrVzz98jd57+UvAxMLqLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fTA00ga/hbN7P/xViiSmunbTyhOHQfm7rttnQoTTZyYCpruSh7wOIEzkaEB4n7nQ2CCy+kqnC1qLUxpWVj+DU/9lzh+FnjdlMR46P4n0MY5GkRM9K5S4DSXwGZ+F5N3OwzrUTFS5iIRnQPJSAl1v7evB7h+o9fsmjxypfu6phV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=bpUoRjiM; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="bpUoRjiM"
Received: from localhost (ip-109-42-177-242.web.vodafone.de [109.42.177.242])
	(authenticated bits=0)
	by mx10.gouders.net (8.17.1.9/8.17.1.9) with ESMTPSA id 42PDJUxv003615
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 25 Mar 2024 14:19:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1711372770; bh=DubbNUQKdlz/m2hwc0qzBsOrVzz98jd57+UvAxMLqLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bpUoRjiMKrx0VV6nm06jY0cxJpAIXzUT20nTb4rkRVc0vkH/w2gu+pwekB42Hwl2c
	 7fUm5toyhh2upI5L9yegeIzfoifrhLRJ2YsVdxbV/CT6tYsBj0k1uJY9yq0YPwBz4r
	 6Xq5lR8yqFjD8VskB4KEJBBlJkbxJdukvW/01oCA=
From: Dirk Gouders <dirk@gouders.net>
To: git@vger.kernel.org
Cc: Dirk Gouders <dirk@gouders.net>, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Kyle Lippincott <spectral@google.com>
Subject: [PATCH v3 2/5] MyFirstObjectWalk: fix misspelled "builtins/"
Date: Mon, 25 Mar 2024 13:33:33 +0100
Message-ID: <3122ae247263fb65d5900c67f7955d68de7f874c.1711368499.git.dirk@gouders.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1711368498.git.dirk@gouders.net>
References: <cover.1710840596.git.dirk@gouders.net> <cover.1711368498.git.dirk@gouders.net>
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

