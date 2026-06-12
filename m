Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE5C3955CB
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 06:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.230.60.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781244017; cv=none; b=VE245lu6BQmLap+lxdAHzLlTcBh69YQIhJQxSB4cedtRmcYv+Ofh0Ahn763TMSjtmWjMjubjgxUe5m52zE8I+HW800u0d0i5zTBnaMGb4a5pOLxzoyWE79TGFUf8X2g9n9RiVm8O0cOdJ2CgUJ8S7QMRW/XMF3gBBfkDrqftUZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781244017; c=relaxed/simple;
	bh=bx9hUVnkwgA8amr0OEnp8HSTDa2JIb9GX9H3PYPZ1cU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=flqv9pQ59LtobJ9JBOtjXfiNnXv5d7G2wYxjhbCx2rrJQUPgtfrquvOU6O3P+l52TTdjuWaq7j1QT9V2ZB/a89iwv6iTkUuMps3lXZA/8G0XGGUPAH78ow7zbH3qg8JWNWpOVrmMHILxT9egypZR9tVNhPplgpGZPXm3yYA5gz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us; spf=pass smtp.mailfrom=lfurio.us; dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b=MDshMIn2; arc=none smtp.client-ip=157.230.60.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b="MDshMIn2"
Received: by mail.normalmode.org (Postfix) with ESMTPSA id 2B88760272
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 06:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1781244015; bh=bx9hUVnkwgA8amr0OEnp8HSTDa2JIb9GX9H3PYPZ1cU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=MDshMIn2RTj/ErCYF5OI0kFqgLH/llnsUjaTxSs8mJ4C3OrA/W+8r/r/2Sx7WJuLI
	 FyMJ6nUjNmNYeA8OOo66BQAVnkI9Z/TpNoC1dztAbFYNOtCbiHGqoWTMeecIV3Es0J
	 DPiNk6XEdv47HLJ+T/qzB/BHUUJl1F9R51QP+aKk=
From: Matt Hunter <m@lfurio.us>
To: git@vger.kernel.org
Subject: [PATCH 7/7] fetch: fixup a misaligned comment
Date: Fri, 12 Jun 2026 01:55:43 -0400
Message-ID: <20260612055947.1499497-8-m@lfurio.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612055947.1499497-1-m@lfurio.us>
References: <DJ19CI50W6UH.17QLIBNTXBWXU@lfurio.us>
 <20260612055947.1499497-1-m@lfurio.us>
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
index a21bb82274d4..911ac8a47221 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1792,7 +1792,7 @@ static int set_head(const struct ref *remote_refs, struct remote *remote,
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

