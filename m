Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C704357D0F
	for <git@vger.kernel.org>; Fri,  5 Jun 2026 17:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780680415; cv=none; b=LlbYm2/LOZo4ZjenR08a4J0eHqiim3tgLyqYUYhT7Y79QarrByH6OhySCrrWuauqsIfuKGnuqAVLtQyHPkFXdTbz0KDqWQhoKnzlL03sUCUWZfxrDqnC2A1D68Tvk8hDCCj0XfEY7BOlB+K5U9yHtuuRs5wxUkMSqfMFWa/98sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780680415; c=relaxed/simple;
	bh=y2uBZKIlLl3WdI0s6PFexxqVaJ80X0S4UX+wq9q8tvY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=YmsolZKzt/ia00XXM+z2g/NBz/1mt7coPOQUlc1xNtoCm95DyxAGzAL5FZg3rZkQfQ36PPhcec2by6WfyoeYsQ+kfdnn/mS8fdpLgaTqai3ZAEiSLs2Kjt3b+fPQdBXRKDIPOSt3vk2quo4lI+V24d3O+ifVu0wiTuypzzxGKNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=eXmJGeQD; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="eXmJGeQD"
Received: from localhost.intra.ispras.ru (unknown [10.10.3.121])
	by mail.ispras.ru (Postfix) with ESMTP id 0DE2545F79B7
	for <git@vger.kernel.org>; Fri,  5 Jun 2026 17:26:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 0DE2545F79B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1780680404;
	bh=uoJaCSx+kSgGtQWkVwJtbjBR45F4nclMSI3vgLxIUw4=;
	h=From:To:Subject:Date:From;
	b=eXmJGeQD8DbhH7ZfDQzn9Kjh+Z8HzOcSTu4P0qcVxGkov1QbT939p5ueXTNZ3D1ij
	 HNyQHLVPwlva2OABs7pMBugtA9VAcwp4vMU5rqOUBTE23SaK9M7gG0SnHBq8dV1yHw
	 DzbfoWmaTeqv7pJEopq8yOhVeGtWy2CnfsXrn60E=
From: Alexander Monakov <amonakov@ispras.ru>
To: git@vger.kernel.org
Subject: [PATCH] doc: fix typo in GIT_ALTERNATE_OBJECT_DIRECTORIES
Date: Fri,  5 Jun 2026 20:26:43 +0300
Message-ID: <20260605172643.8796-1-amonakov@ispras.ru>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

One file accidentally spelled GIT_ALTERNATE_OBJECT_DIRECTORIES with
REPOSITORIES instead of DIRECTORIES. Fix the typo.

Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
---
 Documentation/technical/hash-function-transition.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/technical/hash-function-transition.adoc b/Documentation/technical/hash-function-transition.adoc
index 2359d7d106..241d2f763d 100644
--- a/Documentation/technical/hash-function-transition.adoc
+++ b/Documentation/technical/hash-function-transition.adoc
@@ -545,7 +545,7 @@ Alternates
 ~~~~~~~~~~
 For the same reason, a SHA-256 repository cannot borrow objects from a
 SHA-1 repository using objects/info/alternates or
-$GIT_ALTERNATE_OBJECT_REPOSITORIES.
+$GIT_ALTERNATE_OBJECT_DIRECTORIES.
 
 git notes
 ~~~~~~~~~
-- 
2.49.1

