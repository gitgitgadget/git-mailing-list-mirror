Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9E0156C2
	for <git@vger.kernel.org>; Sun, 24 Mar 2024 17:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711302686; cv=none; b=RYVmjM6Uk3wKyyqoCcQDD/2NSkWP0z3xBlp50s7747UQveokDS+JBi8I56H3EPW4QzgawO8Bg278Tlca1YZItAM1wgg22Wz5QaGeT7dpvcKCfuz8HPp2nuriSaCOUWhLlVTVLrZvyVIiab/Kgxm09bC7zqj58pn3BbJVHwBUkt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711302686; c=relaxed/simple;
	bh=dNVZZ1pykcYFEZt0/ZqKU6VBFABdDWO3ZRxkmm2kc+o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tLXVPvAQLxR4pOY6Np0F2+X+9NlCkbxQpH9CTZlj2n60Dgqtq/5RrUf1lvGJW+p8Y8fRP2BEI0TdnYZV9Sep9uhjWj0Ii5QZ42QUZw3JMG9/DPAtF/YrMU9ndZNLsFGeJ3JYAGozrvPZb6I2g84+9VulZRTy6nMp/uiRyWNX9zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=uJaJNcuI; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="uJaJNcuI"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1711302676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zj1RYMGF8Lx+Z2FQIbvcyj3ldKCVGVikwFO6yOD/4LM=;
	b=uJaJNcuIVjEcZ1qydvX2cRQOdbH/CSZGztlbNyruG0FUJYWw3mzXNvQakEddzOI1qtHXQ9
	jQtrhaEg0IpujWL9O/j2XMeZKzItq56AXyBCte/lHcg995jFgBAb3/zh2ole6ICMOJexxm
	kGrrQ3T3Xd/jeFwIdZmDnBurDi/xXhW+tSXTrOMWKlNI+d/n0jSrgbylKdj3BjBzTB94g+
	P655LSv6gpUadm6HNhH5RJfq0cUTHr3c6YceFvrbECLpyJbn8ko5V0Xjf0R08eyKk3nPH4
	16wGjuf8Ez7SWzbYgEmELJrGRgVu7sOensVOzEIFvlOiYIOXxICZft3jg9oDmw==
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	sunshine@sunshineco.com,
	jn.avila@free.fr
Subject: [PATCH v2 0/3] Assorted improvements salvaged from an earlier series
Date: Sun, 24 Mar 2024 18:51:10 +0100
Message-Id: <cover.1711302588.git.dsimic@manjaro.org>
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

