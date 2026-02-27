Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347D6221DB5
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 13:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772198312; cv=none; b=nnAHRGBG46rl+rFG3RgH9laLdUN/nLeFyYD8l4xE0lVDaxSTaJRPPnBcWZHCHG631aLfXhhk44dYHLO8mZNTwWs2CrPBpRtsbQRu/ePh+0/g4UIoN3wiQz2bgLLCjb33XESvoi1vRQEA/3BB0Hu3RLibkwxf1O2mqnSxr/ZXOjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772198312; c=relaxed/simple;
	bh=U9OAGfoupywIOqpyDFrjIah/pgeMwmr00HCnvcL3cgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dYORm+QV3NIySvViYg6zLuw9nnr9omwdDMUBopfLH8Nw1mMP18/FgrdzVbTEqRnou1K6K+xWvPS5Z8/oBEQK75v2QTSOmL9Qtjrj1FvrQr5+CzentGUqBGz5d+L/J68oTvjLaRzxUO6pBButo9oGnB5+wXS2RW8MAoZ/KhlqX/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=K2J9Y/T7; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="K2J9Y/T7"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1772198308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TcFhMmnIW8Iv1WELAdiMoHKOFTP4UJ8Qz7ung1oYw8U=;
	b=K2J9Y/T784yGPSChygZLyHQP363uVRoFf2TUb5Orvqko34pF2CgsQMcpTXduy06f2PrXxc
	pOGGWa+vzIohsByMyz/jF6ESc07Xz5PsZ7tOcFNZ1xfl4JG0J175ALrdSpi2eMVu/UAVQy
	e31SXfUVTknZxBp+e4l3tTCtVJwNB6FuI7PTDTngVuqxyczeEmp8pu703w9xDeEKi1VFcn
	f57Z6Jys9N4nf/b9C/nQP85i5n/dTbd6lxdxjhmV43ynC/xvSvwMmDqScZH8opiD36yk2j
	2y4KUxNILr6N5Lo1hHRbNHA4MVs7D8lKjNn6p8LJLgcYKet6uK6iCVXD2Rd/Dg==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mroik <mroik@delayed.space>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v4 0/4] format-patch: add cover-letter-format option
Date: Fri, 27 Feb 2026 14:18:08 +0100
Message-ID: <cover.1772196510.git.mroik@delayed.space>
In-Reply-To: <cover.1772156996.git.mroik@delayed.space>
References: <cover.1772156996.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -----

From: Mroik <mroik@delayed.space>

I've fixed the example in patch number 3

[1/4] pretty.c: add %(count) and %(total) placeholders (Mirko Faina)
[2/4] format-patch: move cover letter summary generation (Mirko Faina)
[3/4] format-patch: add ability to use alt cover format (Mirko Faina)
[4/4] format-patch: add commitListFormat config (Mirko Faina)

 builtin/log.c           |  94 +++++++++++++++++++++++++++++++------
 pretty.c                |  15 ++++++
 t/t4014-format-patch.sh | 101 ++++++++++++++++++++++++++++++++++++++++
 t/t9902-completion.sh   |   1 +
 4 files changed, 197 insertions(+), 14 deletions(-)

-- 
2.53.0.4.gf9ee8e2400

