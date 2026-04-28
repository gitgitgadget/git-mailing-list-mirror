Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034501A6822
	for <git@vger.kernel.org>; Tue, 28 Apr 2026 04:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777349132; cv=none; b=DOHyorXb0f8mwKOKqzBBxzc/Zt4i/X9zn+nQr72e6l6nrS/UnkcDxi0dSzSDLYefufLGPaU6EuCW29fpvOeknbQZ7XV0ijgGWWjYpFWZo+9j8feFh8G73Ye9IHpWkBxn6ZVB6bOwBbdPgI267fYSL2rBRWf1cjqamCU+nLSQSDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777349132; c=relaxed/simple;
	bh=SrAp0loLnAzm9u5hPBEkDWaamFFFRF38Xx+Ub2fbaaw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=FuxaES2uVgqWO+T1sMluxjzU6zFOZb11rfRPByufo9QwRRq4xxxK8G2wNJEHp9Iuef1NKp/DHeZH1QG5UKb72CotK4K+3whl24wCC9Q7Vyf8EZe+6RzeK2uoPcocKUG9GKd3OxnbD23Mtw4UCLffcyGuZr4iV9APcuvkgOx/RGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b1HYoJzj; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1HYoJzj"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2c156c4a9efso15025969eec.1
        for <git@vger.kernel.org>; Mon, 27 Apr 2026 21:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777349130; x=1777953930; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vlqkWpw9RfJm46sPVtm2GbsuNeqr0c2CSqvwe1OmCzo=;
        b=b1HYoJzjbLZBZbKuXFxg2Mw0ZZsKJ45IkQvmGJt4jmc539EJrRymlr9s9MQ2rJPUSY
         VS6LuMGeuiIOL1AUl8dsve0rbXHy3sSRBOGjunxdywD05goC2BAyTXeM+YKn+QJIqSjK
         MIhsgzbsdD3lv8huKp/b94zSjILreYfUDn7pfS6EoXCqIs3Jyo5xxHdCHUKhUTmjsXrE
         zaGGAzm9YMT8LQUPGdMxSyhwzpZJ0DQtw4OBDi/getAS6vS76grzpFJFjDMR2UnZS20z
         nAl3Lw8IwmDiIWN7fmCSWhHyxA8q+vd8zugJk6cskzaxwwgRuMNHsqP6gwrAvk2TlsX5
         5qpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777349130; x=1777953930;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vlqkWpw9RfJm46sPVtm2GbsuNeqr0c2CSqvwe1OmCzo=;
        b=hwFz5HpU9HvzqvyjV0lGPF1LAt5qX13F2y/3XhgkzsAvhJbS44wAoTLf5dv7CU+HsM
         iFPNzLXTL2I+CYMEz4Uol3S5auNdFSkIg32PXp0FMQMu7rs5vDSWiTRVjT5ThHfXNeC1
         qgopNhJ9fZ1OJjMvH0WelRH2zNRaMCbkjs1xNvgC34F2P225H9kz4jg6BM20d9V0nsdc
         u8C3kJxfjlyJxtUM81bNP4VQ77Nzx8F5NWK4xTB4gRDuHPjaRyP39eIHKS//nMF7FRpL
         CbuKmCZlFyPlCZ0a7CLrzrzj76wHVJgATCMZOCoGRNFsHffT0XteedebJw5oIlq/Tz7B
         F2rw==
X-Gm-Message-State: AOJu0YxV6dYDZEp7idzyHpwiGLpmW4seXSS0I32TBADlBR2d74C5kpuc
	l9bQ3OWN0eieZBhXyBaohtOoRW4YLnuVttpdv0Iy16O/rN5Vt4zOWLUaeYXG2Q==
X-Gm-Gg: AeBDievVKsxgn/5FEqTgNci5Zl2BoHOJBryvl9vtnj2sTYvWVDw4aMeqHI3Wy2Vw/rx
	uiGGznGj79qKkJ7GpScEJrn36o/dHUs8a7Ok4tLMbrEzeut7pI2ENO0FFoP/eBiR+mb9BNxOwxx
	1EUcUXKtSEyYlhIbKLCTgbT+e6YyVQ6eyBk76eK46MLZkFpz5dDs4Ht59tQ7/U+XMQrL95vabqz
	Dne1J+Eefs2HaItHTq2Iw0c4UsLK00uH9D+kIf1uhFeVVRBYSlbgOegcvuB2ifJR9gwwiWaARxX
	/1VsnkHa2WFPa01ovkXYxTJd6FnpnZpeuf3SJo4R+4lkFggH2TPPcQFuJK3y0NIhhiAOVZ4Mzf8
	HZNrm49wJyskgSuYYafDRGsh4LB09b2LF54KEhWTyObS2KpCSw4/WvYMDGkNu6g3uexTNs5Y6zn
	j7rfc+N/Xjr7AY3hxGYJ5jhWVlpqFZyCnFULR+
X-Received: by 2002:a05:7300:dc85:b0:2c9:ee15:a0f1 with SMTP id 5a478bee46e88-2ed0a19a655mr684209eec.27.1777349129523;
        Mon, 27 Apr 2026 21:05:29 -0700 (PDT)
Received: from [127.0.0.1] ([128.24.167.68])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed0a13ebe6sm1234430eec.30.2026.04.27.21.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 21:05:29 -0700 (PDT)
Message-Id: <9633eb62c620c7935f4e0aa87cae8808a6128c26.1777349126.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2094.git.1777349126.gitgitgadget@gmail.com>
References: <pull.2094.git.1777349126.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 28 Apr 2026 04:05:24 +0000
Subject: [PATCH 1/3] revision: move -L setup before output_format-to-diff
 derivation
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
Cc: Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

The line_level_traverse block sets a default DIFF_FORMAT_PATCH when
no output format has been explicitly requested.  This default must
be visible to the "Did the user ask for any diff output?" check
that derives revs->diff from revs->diffopt.output_format.

Currently the -L block runs after that derivation, so revs->diff
stays 0 when no explicit format is given.  This does not matter yet
because log_tree_commit() short-circuits into line_log_print()
before consulting revs->diff, but the next commit will route -L
through the normal log_tree_diff() path, which checks revs->diff.

Move the block above the derivation so the default DIFF_FORMAT_PATCH
is in place when revs->diff is computed.  No behavior change on its
own.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 revision.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/revision.c b/revision.c
index 599b3a66c3..4a8e24bc38 100644
--- a/revision.c
+++ b/revision.c
@@ -3112,6 +3112,14 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 		object_context_release(&oc);
 	}
 
+	if (revs->line_level_traverse) {
+		if (want_ancestry(revs))
+			revs->limited = 1;
+		revs->topo_order = 1;
+		if (!revs->diffopt.output_format)
+			revs->diffopt.output_format = DIFF_FORMAT_PATCH;
+	}
+
 	/* Did the user ask for any diff output? Run the diff! */
 	if (revs->diffopt.output_format & ~DIFF_FORMAT_NO_OUTPUT)
 		revs->diff = 1;
@@ -3125,14 +3133,6 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	if (revs->diffopt.objfind)
 		revs->simplify_history = 0;
 
-	if (revs->line_level_traverse) {
-		if (want_ancestry(revs))
-			revs->limited = 1;
-		revs->topo_order = 1;
-		if (!revs->diffopt.output_format)
-			revs->diffopt.output_format = DIFF_FORMAT_PATCH;
-	}
-
 	if (revs->topo_order && !generation_numbers_enabled(the_repository))
 		revs->limited = 1;
 
-- 
gitgitgadget

