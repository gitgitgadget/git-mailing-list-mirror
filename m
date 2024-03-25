Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A955A115
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 20:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711398900; cv=none; b=RizB8gtFO6YRikZ/jhm7nznn2F4+++cnPznpYfmSnsdWOgf4R3hqgPPAOa7OhqnplLGnPa/Q6pBQ1AtVj/bzz5VPZNpNz50CsBmPrUzdZfHpUIhfiA9Z7LnEdq3bNcnTFIZbixFUy4mu7cMLLkwdfAhng7/aeyHYLWbUf8m2XAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711398900; c=relaxed/simple;
	bh=mzZU8cIUqeLEaegNZ0lY8+hh9jqHn5xx7dkz9qQXMGU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dI0RUxQsIVYcLnkG+hWJy0lAtmK0FY92OAAvOet7hMTl03iY3YacdrE4mNwhTxDViyNYQEcqSsmp84g/ceGMrqh3XiuisxUPf8g63DoxmZP7V0nXqoT+GC68i2ztu+qg41tzf5Zjnadv8VL8NmzMiKrbOZUXPM/pcGe6CxV5m2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=xmJVTEeW; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="xmJVTEeW"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1711398896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eNiSAz2UR50a1eX+8C0RgcGd50WUCt0CW1PuTBgOe/s=;
	b=xmJVTEeWckuvqGQD5bozFUaeAup930JOeDlLzOJ6wZgUVsGwuvm6UoAm5sR7GUprszyHjZ
	Lc8b/7LdAlgKj0gIcEe6fTQqWO+u52Xmc/GDG6OlolPE36S9MU676+cgXolF9yDuoJqPeA
	nyVX53HH1LRVp0wqIFNuhRJqhUgFX9hs49yOniqs+GCx5ZLjb2igukne9lNmu3UqWV67qs
	oSVu0yJ/sySwkTdImL39adTv14jFBC9tCldYz7GAfgvAu8UFDMyUezQH1XRxK0rNU5Ej4L
	Tr59WGBM4SUl6EgFvmtlLdz8B9Jd16Ji933B3R+J2a1QUNA6+fIPvGfXUEe3fQ==
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	sunshine@sunshineco.com,
	jn.avila@free.fr
Subject: [PATCH v3 0/3] Assorted improvements salvaged from an earlier series
Date: Mon, 25 Mar 2024 21:34:50 +0100
Message-Id: <cover.1711398665.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

This series contains patches salvaged from my earlier series, [1] for
which it has been concluded to be not acceptable for merging, because of
possible issues with various git scripts. [2]

Changes introduced to the patches are described separately in each patch.

Link to v1: https://lore.kernel.org/git/cover.1710968761.git.dsimic@manjaro.org/T/#u
Link to v2: https://lore.kernel.org/git/cover.1711302588.git.dsimic@manjaro.org/T/#u

[1] https://lore.kernel.org/git/cover.1710781235.git.dsimic@manjaro.org/T/#u
[2] https://lore.kernel.org/git/d8475579f014a90b27efaf6207bc6fb0@manjaro.org/

Dragan Simic (3):
  grep: perform some minor code and comment cleanups
  grep docs: describe --recurse-submodules further and improve
    formatting a bit
  grep docs: describe --no-index further and improve formatting a bit

 Documentation/config/grep.txt |  2 +-
 Documentation/git-grep.txt    | 36 +++++++++++++++++++++--------------
 builtin/grep.c                | 21 ++++++++------------
 3 files changed, 31 insertions(+), 28 deletions(-)

