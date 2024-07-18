Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831A41B86FB
	for <git@vger.kernel.org>; Thu, 18 Jul 2024 10:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721299796; cv=none; b=Dp7UDnM/3Y/tTZyic9B0ncLJzFwWAJ20b+6EGN3CGHVsaOMdDoCRgNQPmsUgFofwGWp/wCbX6SSJTguBy1uvCO2xjGbuJvcqzQYXxB7LCyyTRbyRuYbRkyW/F1JvM+Jj/P3hONYHVOAbEeOTahGYw7PTNW+kD7YGdbng0tEqQcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721299796; c=relaxed/simple;
	bh=F8US49k20ZE494wdmZlCkGbM609uVL75Q6dB/yBd4Vg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WV8ttq2aFoMojSISsWuVcc2DO33JbBEz9bjWJ+zXl6oZgHUz/oamI4RX5+5TcKpuMyW+QfrMnwwLKjCfNv/Pf2HFwuAa6iMdaU25WPIGl2I4eAtxG7lqpEVwWmqVKQWlyXdpUpiN8qSMzqz7T9BFUfVJeG2k5psF/ogYtYIfaTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=gI5KWZfT; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="gI5KWZfT"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 03EDE240027
	for <git@vger.kernel.org>; Thu, 18 Jul 2024 12:49:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1721299785; bh=F8US49k20ZE494wdmZlCkGbM609uVL75Q6dB/yBd4Vg=;
	h=From:To:Subject:OpenPGP:Date:Message-ID:MIME-Version:Content-Type:
	 From;
	b=gI5KWZfTIqdwiBAelZz4IM4Frlk8hf6i/Z2dMjNo/v053o7p6kriXF9hJJSz1vjU7
	 bb9dt8k/hkOFKgdrwAa1pnTEkNhgv7hl6TG4kk6xQPOjpcSwuT4FHfRdz784mlg4O4
	 3w8f2tbiiHLTsNP8SPO7YQtuOO80ysxm5VGyvsllTISFrpr+s8ywVT8vo+4xh+mPRQ
	 0N8ATlMNU8otssRZ3TjF/iLXYA9SVxdDpML1FBVV/WVaywe4byTkV+a5aGa3E2RVR/
	 VP/K0+VHfys9b33+OaReDLB6Ql4VkHiYWopVsddd4WwoFnU2w6LCsMsf1qFlEEvju7
	 xQ2D5scmYXIZQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4WPqLw3tCbz6tlh
	for <git@vger.kernel.org>; Thu, 18 Jul 2024 12:49:44 +0200 (CEST)
From: Philip Kaludercic <philipk@posteo.net>
To: git@vger.kernel.org
Subject: Best practices for indicating what address to send patches to?
OpenPGP: id=7126E1DE2F0CE35C770BED01F2C3CC513DB89F66;
 url="https://keys.openpgp.org/vks/v1/by-fingerprint/7126E1DE2F0CE35C770BED01F2C3CC513DB89F66";
 preference=signencrypt
Date: Thu, 18 Jul 2024 10:49:44 +0000
Message-ID: <87msmfrn3r.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Hi, I was wondering if anyone had a good suggestion on how to indicate
where to send a patch to.  Ideally I'd like to have "sendemail.to"
configured on cloning, but that isn't possible IIUC.  There also doesn't
seem to be a conventional file like ".git-email" that would list where
to send a patch, without having to look it up.

Is this intentional, has it been discussed in the past or is there the
chance that it might be improved upon in the future?

-- 
	Philip Kaludercic on peregrine
