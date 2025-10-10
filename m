Received: from mail-106112.protonmail.ch (mail-106112.protonmail.ch [79.135.106.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B862F83DB
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 15:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760109734; cv=none; b=tUwSO/jZwDAWXyS8GcwXehhrkXHZnbSlAgee3DIy8TB25drTYd+KnB7zaU7k5LVH1gHNyEeajZUW8NJ/XoOWPxBHtxOsJuOHLwe8k+GhLBK6hLiGfFEEu4lJoLY+cODn9O1b3TVAXP6yOhdao1vEwPCnDwT2kI6mkgCtY7mc3X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760109734; c=relaxed/simple;
	bh=O5KEOzet0P6qrgRSvvnrLv0Jx0FJAKEyqkrQIinDUgI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LVswfdZr/+3IrxwHmL41oY9YLVVX0BkjiigzLN1h2ARTiIFnolrTjzCQvw2cPavOzVwqYVXTdygKkrpHdY+6pcy4YDNPxhKUg1BFnO4pyktRIav39+fSnTDHa8L8lxIePJICeWinMvFmyON2V2qPEewuk+Rn31yaeJXSGAXV5S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=decentsoftwa.re; spf=pass smtp.mailfrom=decentsoftwa.re; dkim=pass (2048-bit key) header.d=decentsoftwa.re header.i=@decentsoftwa.re header.b=Yh03n06y; arc=none smtp.client-ip=79.135.106.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=decentsoftwa.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decentsoftwa.re
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=decentsoftwa.re header.i=@decentsoftwa.re header.b="Yh03n06y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=decentsoftwa.re;
	s=protonmail3; t=1760109727; x=1760368927;
	bh=po/ghMopVA2PhokZ06E4gr+89wwI0z8m9wB3tNLmHKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Yh03n06yTKbr0yhe2N5Pn8vOTxG/iR1I5JZ0yM51z+dF5CmnOHdKX3iLLGqDJA+bt
	 KaIr9yb2GJe/mxY6qsJzn/O49KbmIW9w9tXnjvGN5OMV1hcYC9w3On7DVNy2+yk/aF
	 VHLDJVn20IWJ5TdSh9KPFXLu9HVkxIF4Jq1II5tGgNOx7iBMom+AewvCn2WLWHTHSQ
	 j3jn48bpKPAI4W8ah8NGWmNAidbmNd1pe3eZVWkvqkga4RbI74meqZHXvbUiSkoXDY
	 STnZHsjQlyIrOofMZT8Rhi4d7OSZBa4hdCe5OT8VysV/0rnF5w3iKW9Ofvg8tWz3QG
	 Ts4p9/CIVC+Iw==
X-Pm-Submission-Id: 4cjr7y19G8z2Sdl8
From: Philip Patsch <philip@decentsoftwa.re>
To: git@vger.kernel.org
Cc: Philip Patsch <philip@decentsoftwa.re>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/1] docs/git-blame: describe sourceline and resultline
Date: Fri, 10 Oct 2025 17:21:58 +0200
Message-ID: <20251010152204.815520-1-philip@decentsoftwa.re>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The manpage did not make clean what source and resultlines
refer to. This simple adjustment should remove that confusion.

Based on the question and answer on this Stackoverflow page:
https://stackoverflow.com/questions/49370690/what-is-sourceline-resultline-in-git-blame-incremental-output

I was not able to `make man` because of docbook xsl verification
issues unfortunately.

Philip Patsch (1):
  docs/git-blame: describe sourceline and resultline

 Documentation/git-blame.adoc | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

-- 
2.49.0

