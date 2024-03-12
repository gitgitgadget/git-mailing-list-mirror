Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6891556B92
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 15:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710258966; cv=none; b=QpMcYiYleXc8aUFuq1YnoluHUeIrTJ4u0UDDiFMuO7T00TRacGoOLsqUQGXEG+M2VMTKMMaYxsL00At+kIjdDR99IPUHyflDYcJxvmdHfOayiZoPWAdjvrM7zPDUzYeRi4n/R/Dl+SxcY1u4AJDGnqGqDKNmsEKqc0/BvmHKRuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710258966; c=relaxed/simple;
	bh=eNWrirxvu3jA6b8MCWDTyLwYdDtmheJhpooTPJJSt1o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H2974Gu8koHfo4BjFTMAkWoJRC7x/B9T27+yIOQqbwJ0d6EW+TPbwkerlUIbPbC5PyDtnyJOon0734Xd/TAthxR+ke7dk1WY80rxLVkclEhSxlrPhdQiK3YXs7wJYsrvvRqjxsTthi6YmOng0kJdyeQWCOJH1lkHBxR8cEADfGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=xzSQFWBx; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="xzSQFWBx"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710258954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lobP4CmDkrzFapu9h/FgMpZvSNNutPZumbxvv5j6Yqo=;
	b=xzSQFWBxaRx6lKQp6Yz3//S1NGCx1RjebJW1ipV4J8eUfMbNFxsK136uqZr4ZM99uDRGll
	lGcmykJKM2PnJfgP37D2wJOX9DIKmA9W1HZyJs0d2TX8bnZIiA9Wvw+NJOomtV0sPk5B3U
	sgID7mbIpz6Unp/YwJuLPU0ljUQw4CvBp9BF3fdtTQqYZ55ezekDOWpN3r4ZHdyISqu/0V
	HulcAb2cVH/ogN0rixEE08HHNsT+fzped7Vxk7J/SkCeZSpGyg82ScevK6V/TDuS5VPQ2M
	CdacxfA1Mtv3saEwppp4QJIGv5sfmFqqDgNFDTHwzYvqXvxjuGpQtxUp5SgWAg==
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	rsbecker@nexbridge.com,
	github@seichter.de
Subject: [PATCH 0/3] Improve the documentation and test coverage for whitespace and comments
Date: Tue, 12 Mar 2024 16:55:43 +0100
Message-Id: <cover.1710258538.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Following up a recent discussion, [1] this small series addresses some
inaccuracy spotted in the git-config(1) documentation, performs some more
improvements and small cleanups, and adds a couple of automated tests for
improved whitespace and comment coverage.

[1] https://lore.kernel.org/git/pull.1681.v2.git.1709824540636.gitgitgadget@gmail.com/T/#m6372f6b5f2a26f7b1a6297241f5cbfa7a29f4fe5

Dragan Simic (3):
  config.txt: describe whitespace characters further and more accurately
  config.txt: perform some minor reformatting
  t1300: add tests for internal whitespace and inline comments

 Documentation/config.txt | 29 ++++++++++++++++-------------
 t/t1300-config.sh        | 20 ++++++++++++++++++++
 2 files changed, 36 insertions(+), 13 deletions(-)

