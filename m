Received: from mail.archlinux.org (mail.archlinux.org [95.216.189.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE5454723
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 12:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.216.189.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770986851; cv=none; b=J59ww2GhRFeVXKeyTsuQChZNokS+Ved+2sPCc5aUSsar4ItrTHQR8zM06cDxWncj2GRQPSHeqQ+niC7elqp9Yl32ZbbvT+mB5sSDxqkvG+9WkYQ6ZmyLQsPPPLw/xZ9IoF/KzGi8xbkCvATPkf80+zhfk/1U84gEDnYU7fTEMn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770986851; c=relaxed/simple;
	bh=UYhlyVLJH8RaVsttSPPbp7jCspwonSVgzLQnhHjn2t4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GG+bmxupgS5me2IzHJ4K1X1tJ/pFbRM0i4+75xu6N7R5iQM4i/h5SkbyeBTKfJm0o7fR5ApaiBAxHSu6EqigHtLbuuuMzKm8/Oq7ywnXSvugkxUNXAx0wSIM98VQ58+tWYgXd1pDMsYHUGCmSlohv3NLL3ABPo1+3B0OJm7vP98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=archlinux.org; spf=pass smtp.mailfrom=archlinux.org; dkim=pass (4096-bit key) header.d=archlinux.org header.i=@archlinux.org header.b=nsIN/RTL; dkim=permerror (0-bit key) header.d=archlinux.org header.i=@archlinux.org header.b=LE9ooFSU; arc=none smtp.client-ip=95.216.189.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=archlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archlinux.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="nsIN/RTL";
	dkim=permerror (0-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="LE9ooFSU"
From: George Hu <integral@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-rsa; t=1770986846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zS6ajGwdLMUDRAd5JCoSrIqtcz2lqX4xwy/pa+NqtCg=;
	b=nsIN/RTL9V+BlTspu/B2hxup18fJig95heBjyWL2RkeoTKItuEegkW3NnKV8nrXj0H8Q53
	0aAs3au4GaflEJNSLJwFmjMIpmjar+xdIv6y6m/6w/s+LPuSbVNF+CB6h2FgUqR8XRz/Al
	V52Qg1pJPvvPLjVALBXWLCNfbw9Cy+BMFC7/Dl7tKDe1cSL3Eglvw029X2D+r7fWHcFHam
	h3RPnlgSuw/QTD3VUDVAZs3iZUe1NCBM7wACnPHLVqPNF9JnLtUjMKUjBBt9pNFpBTcd5P
	OISh8Vhv1nB0O/K2hDX1f857hwoz0qYMUVdwLDJ97uY/Xna1b1oBRxOKBTKm2jKsLO2Q98
	0JvxXdExA3K7pRUzdtQVUs4hNp9CNZYK7z0NwbifKPuB3CUo4Ff8ihE0Bt5u4rAnem/YgA
	WjMYy8SrtdIwwSEx4QlbE/J9iQhIALtVRNV+cfLn+y1u1yB3FQ2Unwq8MdyaZrqYy/fNmB
	vtFN0UO/8U4kReCbTcUOzuHW9MSDAc07B2b1F1DnwxVo6R81zR26VPpJFLeDnHTI4oUted
	QFBIHdSGyqvqJDfHJGj8ap5unCSTgjByU1U+/3cs+BT7b0es/gUS248yVQ/vKdiu7cEYjS
	owCisEAf+cu7T9K8j0Mw995g6/nWFWxqjetJnA9CsiThATHPTpxlg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-ed25519; t=1770986846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zS6ajGwdLMUDRAd5JCoSrIqtcz2lqX4xwy/pa+NqtCg=;
	b=LE9ooFSUnAwsNfpavBZBB+47A4xTn9MbDQt0OYO/ya2fwgweRJ8ZtnUb6jU69FVctUoeKH
	IqL4CagCd1MSnhDw==
Authentication-Results: mail.archlinux.org;
	auth=pass smtp.auth=integral smtp.mailfrom=integral@archlinux.org
To: git@vger.kernel.org
Cc: George Hu <integral@archlinux.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] copy.c: use `sendfile()` for in-kernel file copying on Linux
Date: Fri, 13 Feb 2026 20:46:56 +0800
Message-ID: <20260213124656.218396-1-integral@archlinux.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `sendfile()` system call copies data between one file descriptor
and another within the kernel, which is more efficient than the
combination of `read()` and `write()`.

Signed-off-by: George Hu <integral@archlinux.org>
---
 copy.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/copy.c b/copy.c
index b668209b6c..d4b7cde764 100644
--- a/copy.c
+++ b/copy.c
@@ -7,8 +7,23 @@
 #include "strbuf.h"
 #include "abspath.h"
 
+#ifdef __linux__
+# include <sys/sendfile.h>
+#endif
+
 int copy_fd(int ifd, int ofd)
 {
+#ifdef __linux__
+	struct stat ifd_st;
+	size_t ifd_len;
+	ssize_t ret = 0;
+
+	fstat(ifd, &ifd_st);
+	ifd_len = ifd_st.st_size;
+
+	while (ifd_len && (ret = sendfile(ofd, ifd, NULL, ifd_len)) > 0)
+		ifd_len -= (size_t)ret;
+#else
 	while (1) {
 		char buffer[8192];
 		ssize_t len = xread(ifd, buffer, sizeof(buffer));
@@ -19,6 +34,8 @@ int copy_fd(int ifd, int ofd)
 		if (write_in_full(ofd, buffer, len) < 0)
 			return COPY_WRITE_ERROR;
 	}
+#endif
+
 	return 0;
 }
 
-- 
2.53.0

