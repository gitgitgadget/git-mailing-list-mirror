Received: from pio-pvt-msa3.bahnhof.se (pio-pvt-msa3.bahnhof.se [79.136.2.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DED63644C3
	for <git@vger.kernel.org>; Sun,  8 Feb 2026 15:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.136.2.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770565007; cv=none; b=Yg7MfKelCGsJzJxVyK/LoV43dQ7+gHyn8kP3DLRj+ta1+32IKcWodtT3qIi38UrmN4yf7YE1AixHuRj7C4fd9hIQ1npWEOiBB2jQMu4fLLNpVX6uLT12tu8UDY+DJMkhRGNAJ+8VBBjrs9BHeKONYLBVlg1AfZGOMLOw408Tm1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770565007; c=relaxed/simple;
	bh=iLt2b76VQ4Du5uL2GmpqU4MVppjBdjNwWpLErOdda40=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=Kk+MrJ9mZSiafO5rSAeM6r2FzH9JWH9XfS+CBXNcLR5sYhB2NFb+U7QCbPNKiFfC3eEloeCwUZgbH7687u6TZ1/1TSgT7TKlKPbRtY+Jm5RZhzk/X1hsIF2ASNEDeDwzhD+4WlalKL2Tct3KmSWOnJl7XbYCeCImyr27m84Nglo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page; spf=pass smtp.mailfrom=jontes.page; dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b=oa6eUQp8; arc=none smtp.client-ip=79.136.2.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jontes.page
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b="oa6eUQp8"
Received: from localhost (localhost [127.0.0.1])
	by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 894253F6CE
	for <git@vger.kernel.org>; Sun,  8 Feb 2026 16:30:06 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Authentication-Results: pio-pvt-msa3.bahnhof.se (amavisd-new);
	dkim=pass (2048-bit key) header.d=jontes.page
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
	by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MXrUgiqZX0HT for <git@vger.kernel.org>;
	Sun,  8 Feb 2026 16:30:05 +0100 (CET)
Received: 
	by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 386C83F4C9
	for <git@vger.kernel.org>; Sun,  8 Feb 2026 16:30:05 +0100 (CET)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6AD55B1DDF
	for <git@vger.kernel.org>; Sun,  8 Feb 2026 16:29:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jontes.page; s=dkim;
	t=1770564551; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language;
	bh=6fhwYEuqOaPlWjaaIMi6BT15pePcFOkj3LQQ8jdHuFU=;
	b=oa6eUQp8aSVG5m/Z7hbLFG9DOgYlwU3EvtVsv/G4P4DhIQSnqRuiC2EzVxlDA0M6ovsmj1
	OTK8/ngb4lvarfHCWMBNbhgpjOW7f7liKdo4Rate9zI4IisbyQFHPlmNcktIqdGUg/vNwZ
	mAB7g+RTdwYUDu9O6CDuOMVizyCXYtBwoSsFv5fGknOiN+Zt7t/oaGMs2qo2X1lKabffgO
	p6Nus0ewA/nTp1TTc2Cs8mHCNnnuKXueQoifUNi4ckxjwsg1jNm0ODmpsYfU75tHsFljUT
	7LrNWZu3s5udjk6dYJQA1OX/vUv2ndMwMglldxqegfq7Qu/HALr7oXLKlVmr7Q==
Message-ID: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
Date: Sun, 8 Feb 2026 16:30:02 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jonatan Holmgren <jonatan@jontes.page>
Subject: [RFC] Support UTF-8 characters in Git alias names
Content-Language: en-US
To: git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Git developers,

I'd like to propose adding support for UTF-8 characters in Git alias 
names to better support non-English speaking users as these are 
currently restricted to [a-zA-Z0-9-] which prevents users from creating 
aliases in languages with other characters. Shell aliases do not solve 
this as the best you could do is "git-förgrena".


This would allow users to set aliases such as:

     git config alias.förgrena branch # Swedish
     git config alias.分支 branch # Chinese

etc.

The restriction comes from iskeychar() in config.c:526-529:

     static inline int iskeychar(int c)
     {
	return isalnum(c) || c == '-';
     }

The function in question validates all Git config keys, not just 
aliases. The git_config_parse_key() function (same file, 543-598) 
enforces this validation and uses tolower(), which only works for ASCII.

I think the best approach is to support UTF-8 specifically for alias.* 
variables, which would mean modifying the git_config_parse_key() fn to 
allow UTF-8 bytes and make non-ascii aliases case-sensitive to avoid 
complex locale-dependent case folding.

The main pain point would be making sure all platforms handle this 
nicely, esp since mac uses NFD and not NFC Unicode.

Before implementing this, I'd like to hear:

1. Is this a feature the project would like?
2. Is my implementation approach reasonable?
3. What concerns should be addressed in said design?
4. Any compat requirements I should be aware of?

Thank you so much for your consideration!

Jonatan Holmgren
