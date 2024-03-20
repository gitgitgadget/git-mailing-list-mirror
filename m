Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B31885295
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 21:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710968936; cv=none; b=WiNPWQNp7Dy/v6mwY/q6/ZCybMgDib1wF5R+HOuGhGM3w5r3dXjrDWR5VVXJGY9bV0ZbFPjewwsDufcvExYFT1AVvgF4fahFvhN4qhiNUI8mmIvpWYBW6CvYLJnakG2cIwjywYdHJtG8OgU3BPPR0LvW2Z8amiYI/7YcmRuQiZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710968936; c=relaxed/simple;
	bh=CKtyFJSSCXo9JlcLJVhOHOdOK17UMdGAGeZXwNCkP3c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cbULPBAi86bAbPIN5xf2bVD/VhZ6Epjv/ZlJ4rmDLOh/gvmLrNPlBIxcgLI7axxQoqLPrzFxTrx2lvN6vBNmhR/Pgzzh1q/RKaPxgAFCP7hBT2cYtj8yWThkFvl0QgtEwqHMufWDIvGaWrvsibE8Bg2buqEQ+boso5hIZTHjUCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=NSkXnuJQ; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="NSkXnuJQ"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710968931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7ZKxs5PEuNt3va+Z+t1c31K08req6Q2CPbPpbFBD1Oo=;
	b=NSkXnuJQPorjQqkVAt6/Q0G/dhsp4YssCSsazVdpZH6AKya6oaE9wb+X14R3E2Yq0+ScW6
	ldjSQOOjF8cC/SWJtEJIbAR7JG+wMA8xCAjvqkXTsU+LEtN/MNeaJ5kibixkHylPR5ECgk
	24KDb2RRjxC2MSEa1ILMdJYb4qUFn+T04OY2AAQF3MTQkTdnc0YHWiyX9nM45+5Eut75/t
	W4fw0MUBX78jVaOdRHmx2OfBj32eHVE5URiaAM5hej3UxuoEHxg9k4hzKtwB61DCiD8iJA
	XCt4vXBdqjvKSKa1DGBMwncXO47/w3KM36VNjEAB9BlA3xUYs33K1BQUnqEpuQ==
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	sunshine@sunshineco.com
Subject: [PATCH 0/3] Assorted improvements salvaged from an earlier series
Date: Wed, 20 Mar 2024 22:08:43 +0100
Message-Id: <cover.1710968761.git.dsimic@manjaro.org>
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

