Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42D856B6A
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 21:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710193436; cv=none; b=hRIWioK6M2pz32A1g8vzL3n2wfe7CHhalkN0rzL4MX18Cicjv8eEnrkCpcJMiViaN7aNhyh5fzPt5YR6DSb2WwItpUFJkNKFB95wMWQs4WSS2uPaGIefS/dHk/YLuxFLsdTs7/O+oAiyt8Rz/byJ/tmir9WdRdqGlmkmge93Dig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710193436; c=relaxed/simple;
	bh=vZvETYmXsOAMuco3uVpIFqLFcZcsfl9WjftLTUym3nY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QJyb2DUy8ntf0s1R4gYxCQgTTfg4ICLEM/KeboRSO+fHgPJyEq/k6cf/5WHSWZaSJKugDB/AbbIvYPHKKgNeskevqZORU3VnTki3B8CT9upg+rhfcVyJeBQU659hFaK7K+tgw1OBEHAR7VdSTbzeT96UlwuyC7Vx/7m3MH65/9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=Q/fOfDWz; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="Q/fOfDWz"
Received: from localhost (ip-109-42-178-223.web.vodafone.de [109.42.178.223])
	(authenticated bits=0)
	by mx10.gouders.net (8.17.1.9/8.17.1.9) with ESMTPSA id 42BLhh38031969
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 22:43:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1710193424; bh=vZvETYmXsOAMuco3uVpIFqLFcZcsfl9WjftLTUym3nY=;
	h=From:To:Subject:Date;
	b=Q/fOfDWzgIIWUG8vYlACMVG2jrg6I953z8rkZKq2+JSu3WMQ5SrwDlf8RJlDixTm5
	 ecRgkK/M3GlzkEt2SKZXUOgfE1ZT3cTM9PKsBxy5AqLRhUR9bhoYQyr4BF4fpEjgUO
	 Eq6rJQkDmA9KDIYVTdXQgjljCfIobe/xbHFYrHT0=
From: Dirk Gouders <dirk@gouders.net>
To: git@vger.kernel.org
Subject: [PATCH 0/5] Fixes for Documentation/MyFirstObjectWalk.txt
Date: Mon, 11 Mar 2024 22:36:13 +0100
Message-ID: <cover.1710192973.git.dirk@gouders.net>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

This series contains fixes for some problems in
Documentation/MyFirstObjectWalk.txt that I noticed while working
through that document.

All patches except [4/5] fix real errors that cause comilation
failures or don't produce the wanted output.
With the fix in [3/5] I'm rather uncertain if it is correct and I
would like to ask for special attention, here.

For this first round I send separate patches in the hope that
simplifies reviews and also, because the reasons for those problems
differ.  Finally, those patches could be merged into one should this be
more appropriate.

Dirk Gouders (5):
  MyFirstObjectWalk: use additional arg in config_fn_t
  MyFirstObjectWalk: fix misspelled "builtins/"
  MyFirstObjectWalk: fix filtered object walk
  MyFirstObjectWalk: fix description for counting omitted objects
  MyFirstObjectWalk: add stderr to pipe processing

 Documentation/MyFirstObjectWalk.txt | 36 ++++++++++++++++-------------
 1 file changed, 20 insertions(+), 16 deletions(-)

-- 
2.43.0
