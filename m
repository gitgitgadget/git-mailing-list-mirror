Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2357367B72
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 09:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.230.60.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781862520; cv=none; b=nkCoAebw1l+813lKwAd0d1F3LDFoBJKCTaRm3BsKLxoVJSnWtmywruD3A+wabqpCHK9+/5ns/HT4FUK3/jZpi99TUYTHs6TTjPyxCp5o0j0jEmmgets9yRkVUgzo1GplcmV19njNVn2f5sl+QAIMXxnuw6ir5h3ErR1+BBLwcYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781862520; c=relaxed/simple;
	bh=y77ZdHOhZS3tXxUqCsHNFP/r0nZruOAYHSr9na4zX3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gBBo+X0Quwt+b/oB08w/gFE5yQ5pmsWFy21IV0rPQ+mck+F9xhoDgEn9YWCnvFy/uPvp8PdmF6fg72KYznuTQDAZVMv2Rlek26ZYDEDUL/OF1slqwN64h3VYaQaB2zV+0tYSIsk8am7kMup9XnOjg9Dd4XcJ7/thKH5ybu0yc0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us; spf=pass smtp.mailfrom=lfurio.us; dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b=e5lm/7W4; arc=none smtp.client-ip=157.230.60.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b="e5lm/7W4"
Received: by mail.normalmode.org (Postfix) with ESMTPSA id 8637A600DE;
	Fri, 19 Jun 2026 09:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1781862514; bh=y77ZdHOhZS3tXxUqCsHNFP/r0nZruOAYHSr9na4zX3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e5lm/7W4ltyWr7qLpQ6ZiXbcxjCXZt82MEt4GdI7mK3h9S/8/btUHlMuy0X7WfhOL
	 B+MdY1NxtSnKhdfoC6tHXEL60PtGI1FrkLwjpoIDCHxn6NjL/2MkwCKNfMujj/+Iw1
	 WQj8X9Lxone/gcBxBgcufhQHOGn7/5YEpgGK+LNY=
From: Matt Hunter <m@lfurio.us>
To: git@vger.kernel.org
Cc: Bence Ferdinandy <bence@ferdinandy.com>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 8/8] fetch: fixup a misaligned comment
Date: Fri, 19 Jun 2026 05:44:27 -0400
Message-ID: <20260619094751.2996804-9-m@lfurio.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619094751.2996804-1-m@lfurio.us>
References: <20260612055947.1499497-1-m@lfurio.us>
 <20260619094751.2996804-1-m@lfurio.us>
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
index 3c8210d1776f..25ab8803a819 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1793,7 +1793,7 @@ static int set_head(const struct ref *remote_refs, struct remote *remote,
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

