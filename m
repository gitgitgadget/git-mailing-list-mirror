Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6422542EFA
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 19:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791921087; cv=none; b=kAZXItSVkddMMng5ErISd+rQBC9yF2Rpt+CtD9CmQdD3jXwha3n4so9y3AblduzMuPb+p6qapfBedXY9MaSLS5/aJvbNUm8blyRJ1HNCvySTlL8f6LBQgc4K9USEFwNK++IeG/xK+ipaZxj/G4XeXZaJhCHQFbhMxTU7JEJReNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791921087; c=relaxed/simple;
	bh=FUi5N0WooXYsFGXAjnl54yGsK595IQqN6xbFlfBbRdg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JAKrxgpJpR1YzGnT4AJCJqMhhYZtXPjEePV7PmPz3BNdm4RwR7T/D/G6jHs3su3y1plUZlqvkzmAnkPzz5knZ3h4EXWahHAqSoenSZxCcbs6IpmbvFL4rH0vMQkKdpsa4uEqlDLr7AmQdMRdKn+Sg+rpI+mP477gXX5zr56/+u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=BhjeG9fm; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="BhjeG9fm"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1791921077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DYJpjquwyxWC5PRfeRP5QiuFfQXuRdFXzNVvtjHZaX0=;
	b=BhjeG9fmMFRavqc/iXLpg0FDy/peHKf/iT5KDZrsydXJfR1xrhNFHkrXahjKPIEEKEt1nd
	W4CsIwHwOLUitOedqbVPiIozbs5Kxe03mfBH5nadszgo+PewhuLpL/kPq7gFwktESd2QXR
	P76xgOyagXcH8Asik8Dpu1i+tGXrFvkP+f8cDuWrJis9ORCGneJwDjSg+ltI9cYJHEClMx
	euY2K0g4GUpUD8o8kzqX1AE6XeIosnWKQwOmMlcK6NzWtaCVjFgv0IfyTdbNWP5nETizzK
	tbF9jSRDJKulqwn/2khtF1WKsHFJazNekuQRmDtFznKeUuxTg2PvCjWnDE+5WQ==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>
Subject: [PATCH] bash-completions: add --[no-]graph-indent
Date: Tue, 13 Oct 2026 21:50:49 +0200
Message-ID: <63106e1dec45e82c7f132a18816b2d1fffb52752.1791921033.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=808; i=mroik@delayed.space; h=from:subject:message-id; bh=FUi5N0WooXYsFGXAjnl54yGsK595IQqN6xbFlfBbRdg=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBqzouZfjTFYLEXH9+dyXnd1AHR8c/JBUmWAIMZ/ xOsHozfnZuJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCas6LmQAKCRBIeX6hnBm+ 0Z6PD/oDs4qaqFJ/v6EiroD0RL7YxoyZzVn+SmKxyfIV3o+PZ7aNtkHea7oA5OM1POHHUBYUGDs j14/8hpk0HC+kRNcDQrF7a3SwvqOvGtfc78LPmbEm1FVoGnCLhSW4dXH7cUMl0r3phoK4Pqw1eu KrmqIFFnhWdpMVKKUk7ryDGp5+uXGErwfLUNUatRle4ZX0MIo7RxZT5945X3G3zB/o92y8tV91n yvTXai1hZq8MF3ViFKf0Q1QRrgbY3rTUnDCpc1Rv1jHD/KoDr2xZOockBNzbG9fQ7ljNCrFVFPr NEO7Y5gzSel7gset2BA7SJKOBBxhzOd4uzFqApIGwxoL16W8R2z4ErdjIMdpSTj1FnB/+pPhkmC S+bO/ONypjCUpQwN8RmqM+qItSx2I049sXBxzuRVxntE+6XYFVWBh4GQPRhwxa7Ke+nRy/Sv5wJ RpZ9Jdj0CEeEAFpVIce0z6EoO+p2pV6tFJksIE0RxCWaXQLogXkk4FSx03sbeJVLsX55ylD3pCY Vr4m9J3oMxIxvgoJRJI8qNpSAOiV/v9FNOI1QjTamiZlvJGwWpqRo91PrSnQcIFnS1cYIHR+5Xn CsR1aFCxbIhjSmCwlt1mfCyg7Y4uET//mMMxDacdn1Jkl2n1f0xF0gA5gRirh2zwhVC2RM0Pzr9 sYYvyTJRxh
 T+k3g==
X-Developer-Key: i=mroik@delayed.space; a=openpgp; fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -

Add missing completion for "git log --graph-indent" and "git log
--no-graph-indent".

Signed-off-by: Mirko Faina <mroik@delayed.space>
---
 contrib/completion/git-completion.bash | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c3a49e2e22..2348a3cfb9 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2298,6 +2298,7 @@ __git_log_common_options="
 	--right-only --show-linear-break
 	--show-notes-by-default --show-pulls
 	--since-as-filter --single-worktree
+	--graph-indent --no-graph-indent
 "
 # Options that go well for log and gitk (not shortlog)
 __git_log_gitk_options="

base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
-- 
2.56.0

