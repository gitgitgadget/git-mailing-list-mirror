Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430AD331EA5
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 22:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.230.60.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781648815; cv=none; b=bB6D20x25KXho8XWKSdMnJn4hpFYMxUM+ddfvGvR6drhe4plPKBEbXvV6/4OR9zTQAVblqQosQ6r5oUzWJ5Qde6EAvPaHx7a04l0Dy8QXm+hd60X6/IpGY2mhWkEpCS3b2rLJRQS5R6UjV/YiH/tYOxtce2l+EreTyBbJ6a4p/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781648815; c=relaxed/simple;
	bh=NPeRMb7BZvmU2Wypu4Xs2YWPoy2ZzGty32yMJPNoiZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=REabnY6pR8v9P0e5v0f2s/8ITAkNDMp+cToL3Hc0Geh/YodmDpx8eH7PnL4H4ELofCaXJLvNaHeto9Otj3+da7eyo+bhe0R2tcdiWydnTdPrZXTcvGvYMuk9K+z4By0MUe8x10h+MrISu0yUleJw2ZBGv9A0QxxnwUnfu6yOd3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us; spf=pass smtp.mailfrom=lfurio.us; dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b=j5bp/hz3; arc=none smtp.client-ip=157.230.60.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b="j5bp/hz3"
Received: by mail.normalmode.org (Postfix) with ESMTPSA id 47B49600E8;
	Tue, 16 Jun 2026 22:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1781648811; bh=NPeRMb7BZvmU2Wypu4Xs2YWPoy2ZzGty32yMJPNoiZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j5bp/hz3eLHb+szaa3GPPLJcRCLyI71Ly/nI8ksUA/j8CkKfPj9r3h041E5dBQnqG
	 FCgiPoOboItNZLfB0aJYrmEpsmVgX5id+AaBONCjrJZl8st9yX9TQhi76p4CjU6Fin
	 B8UfIlPtmuPQ1FoFy3qTsVCjLt/5qqNryn0TBA8E=
From: Matt Hunter <m@lfurio.us>
To: git@vger.kernel.org
Cc: Bence Ferdinandy <bence@ferdinandy.com>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 7/7] fetch: fixup a misaligned comment
Date: Tue, 16 Jun 2026 18:25:21 -0400
Message-ID: <20260616222606.1003521-8-m@lfurio.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616222606.1003521-1-m@lfurio.us>
References: <20260612055947.1499497-1-m@lfurio.us>
 <20260616222606.1003521-1-m@lfurio.us>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Matt Hunter <m@lfurio.us>
---
 builtin/fetch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 1375fc4e0547..d942bf6aa029 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1789,7 +1789,7 @@ static int set_head(const struct ref *remote_refs, struct remote *remote,
 		strbuf_addf(&b_head, "refs/remotes/%s/HEAD", remote->name);
 		strbuf_addf(&b_remote_head, "refs/remotes/%s/%s", remote->name, head_name);
 	}
-		/* make sure it's valid */
+	/* make sure it's valid */
 	if (!baremirror && !refs_ref_exists(refs, b_remote_head.buf)) {
 		result = 1;
 		goto cleanup;
-- 
2.54.0

