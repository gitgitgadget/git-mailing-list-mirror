Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C82E26A089
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 23:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742945544; cv=none; b=nK5c+l//0JTvxT1fjYXeXPAqCvLHpLL3H4HTV8c/zAHNmnA0vBZ6x0HouRNl0O4Dp4Zhx5O3feBwLK/QavkMjCWPHOI9noxKq8Gws8qNUFuYkbvud5GCzi1SvWUR0kz2qVDWeVj+226kjhm5A2F2asdyl3djYEVtMZZCu76V0Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742945544; c=relaxed/simple;
	bh=1E2MIPGvJpZILgeR+y80nHde8v/+QmHjrMnRhTe5LRw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rpnk4y6ng3nrkEYmikih4omTqP1iRppDIWBLMOxWY0qVcI6zBxvS/vWzVEqZpjn3AryOSDf15oR3bHAQLRr8BXTNSTWTjBhqPe5pn4kyXJVDAQ0I+cSCNAWdELkGzqEfBN7NrYf2KNqrsVu3l9bOeyIDnP9klcdJc4K3Pdf+lnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=femsx/J/; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="femsx/J/"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cf848528aso51925645e9.2
        for <git@vger.kernel.org>; Tue, 25 Mar 2025 16:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742945540; x=1743550340; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zyKGogoHxgJZ9S+q2w13V3Jagh0709TpjxDMNF9xpPQ=;
        b=femsx/J/fvA2JY1LMMndY02ObA8hHDHcW+SKMiuyvScPiVqUhJA7mmsI7NfMWve4Vn
         eMxoKk5QRWJ+owsJfCZeQK9ey5lkpPvhO6ra0irDmKi1mLW+nfaf0uyODZRQe66R5fw3
         xYM3lWORIITs63fHLVYyki9tbmzMiQHqmHDB/fJbXBxSEMwN7v+OyxCCESvNz5kjRe9R
         g55LWpuAtBwAkV9acIU6MgNKXMb51iI068/OGmzDwZSunMvRuTinix4bAkLfMCCmXMxr
         dah894xHeYcqjI/6L8MUwhu34pcmcwzND7/JYZs50ocHTJRgdhEA2IDjRMdu1GK9PhMs
         pfyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742945540; x=1743550340;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zyKGogoHxgJZ9S+q2w13V3Jagh0709TpjxDMNF9xpPQ=;
        b=jwcih0EHMJ3PeeOKxegex1BmAwxuYK0vbvhTFQIfldM6I20TPTVxojx3A84YhYBYwR
         vBD+mGvV7/VqaYs/vBEX84LFOTZXkiJdumNh89g6CbdzEd2DGb8oX8nmkAB2PHsKa07e
         FiNynJeTH+/6zjOZPgLRXdP24XsUmcNtyZYBmqs3ytrmJJor6kBPawzOqIRy+piZoRJS
         06ruQW3e5linA40/ngcABo6xbNKSZQyxE/6flDAuT+ZJ2qA56tjpYq1r0xzgY6cZPKps
         0lViZZ2CFOnlypyDxkLnfeglaksKREgfvnl+Ul5U/lItjlO3Qmoa5Q5t29ewH1nISs/2
         EBOQ==
X-Gm-Message-State: AOJu0Yw2NQeFWfEiR+x+wnX5YyxQkMT+IglOoUp04e5Bq8pmBTO/NXE5
	8Ysl3zD5C0QgEbErr6R7RUgzcfhnj7Ah4RHdoAkZcbLy01bN4ZpjHhlKrQ==
X-Gm-Gg: ASbGncsRqXSVMklwj8p441yHf5lQuKLsEQ8GeUHsBSi8vujahOTD/R9cVwfyy+MSG3i
	+X2R6o0/TL5VFiX4WH2vIgVzLAnTSXBiBqjs/TD/Tfd+xUcXdqMX0In5ejJkAyw0FZbopWLgXiO
	qPy24CYEb+6a2WPjOF0U2toikVpxCttjJ9A+eahL/dZaGvD4VUS7LT123mglERUA4rWKYVx77hv
	bOeHRA3p7QEz7JzYg2JppkDhGTVTebgJ4Eusi8FSLOml6JByavJqEcgwTGdoIr1iiuvNmoO5KB6
	Gk9sA+uN8FVHq38Za9PNETbvbRM86HqYivCtc5Xeqh8nuEIgD9F9M9b0
X-Google-Smtp-Source: AGHT+IFHedwi5rTetGV49irT3VXDQmCCgSAMIB4LtZPFT/cK1ApbkhUSJKIRIZ0rJO+dUZS52rgSjA==
X-Received: by 2002:a05:600c:3b1f:b0:43b:c284:5bc2 with SMTP id 5b1f17b1804b1-43d7836b764mr9330725e9.0.1742945540486;
        Tue, 25 Mar 2025 16:32:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fd9ec84sm161860285e9.26.2025.03.25.16.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 16:32:20 -0700 (PDT)
Message-Id: <7239078413f6a223105939af1b56e79b9d302f1f.1742945534.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1889.v2.git.1742945534.gitgitgadget@gmail.com>
References: <pull.1889.git.1742889711.gitgitgadget@gmail.com>
	<pull.1889.v2.git.1742945534.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 25 Mar 2025 23:32:09 +0000
Subject: [PATCH v2 05/10] xdiff: avoid using the comma operator unnecessarily
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Philip Oakley <philipoakley@iee.email>,
    Patrick Steinhardt <ps@pks.im>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Karthik Nayak <karthik.188@gmail.com>,
    Jeff King <peff@peff.net>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The comma operator is a somewhat obscure C feature that is often used by
mistake and can even cause unintentional code flow. While the code in
this patch used the comma operator intentionally (to avoid curly
brackets around two statements, each, that want to be guarded by a
condition), it is better to surround it with curly brackets and to use a
semicolon instead.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 xdiff/xdiffi.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 8889b8b62a1..5a96e36dfbe 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -211,8 +211,10 @@ static long xdl_split(unsigned long const *ha1, long off1, long lim1,
 			for (d = fmax; d >= fmin; d -= 2) {
 				i1 = XDL_MIN(kvdf[d], lim1);
 				i2 = i1 - d;
-				if (lim2 < i2)
-					i1 = lim2 + d, i2 = lim2;
+				if (lim2 < i2) {
+					i1 = lim2 + d;
+					i2 = lim2;
+				}
 				if (fbest < i1 + i2) {
 					fbest = i1 + i2;
 					fbest1 = i1;
@@ -223,8 +225,10 @@ static long xdl_split(unsigned long const *ha1, long off1, long lim1,
 			for (d = bmax; d >= bmin; d -= 2) {
 				i1 = XDL_MAX(off1, kvdb[d]);
 				i2 = i1 - d;
-				if (i2 < off2)
-					i1 = off2 + d, i2 = off2;
+				if (i2 < off2) {
+					i1 = off2 + d;
+					i2 = off2;
+				}
 				if (i1 + i2 < bbest) {
 					bbest = i1 + i2;
 					bbest1 = i1;
-- 
gitgitgadget

