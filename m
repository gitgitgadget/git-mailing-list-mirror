Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC4F2556F
	for <git@vger.kernel.org>; Mon, 23 Sep 2024 18:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.18.0.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727117543; cv=none; b=J3RPG/t1BBpGv4rUU3763NqNqmnh/hIEUhpn08ByWXbnmq/ZaMmZz5DgTgXc3cowunKVllYKU7AXQZ5fHu1XjHNZx7ZkDJmt7XkQGZLkS4ZQXaD5uqzKRNDmtLQmgPiHfl7LEkVObuoUy78lzA2HadkgwSu5ZJ31+brB2d2+5x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727117543; c=relaxed/simple;
	bh=6Hp2XObymcmBaqCQi+ZhFhE3IAYW+MVDghAQqd83U2M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kAfuftOHm5rie9UIETqeUvip3WQQROYSWw8scJoSY8w4Kn364HkW+be1sBQaw6ipvCUY+6Me1jpe1rrwd+pA2f8/XchXFL7w3aESxazvUdXzliNlaFjNm1qnXO3qJGEVjJVyqpnIrb9KqXgbLchNtLY+Qxx14JqsBfjjrPohSiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=nefkom.net; arc=none smtp.client-ip=212.18.0.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nefkom.net
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4XCBgn6dydz1qsNn;
	Mon, 23 Sep 2024 20:42:45 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 4XCBgn66y2z1qqlS;
	Mon, 23 Sep 2024 20:42:45 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id sau6qvkwWaYj; Mon, 23 Sep 2024 20:42:45 +0200 (CEST)
X-Auth-Info: 5QN1ew/phNYbqu+vb3VR4mbjJXhEFf5zWA43xMI84cknkSNVkyY7uRdckSmP1cid
Received: from igel.home (aftr-62-216-205-106.dynamic.mnet-online.de [62.216.205.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Mon, 23 Sep 2024 20:42:45 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id E1E4A2C1989; Mon, 23 Sep 2024 20:42:44 +0200 (CEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: email@mateuszwielgos.com
Cc: =?utf-8?B?6Z+p5Luw?= <hanyang.tony@bytedance.com>,  git@vger.kernel.org
Subject: Re: [External] Using Git as a Database
In-Reply-To: <0D0BB87D-9BF0-48BA-8F2D-83F8D326ECEC@mateuszwielgos.com>
	(email@mateuszwielgos.com's message of "Mon, 23 Sep 2024 07:32:53
	-0500")
References: <4B2B1EC7-6B08-4B57-A50F-702C031C2792@mateuszwielgos.com>
	<CAG1j3zEg47RLYrVfJQi7WubgcdtbK2RWFBtj5rd8NtkPyXU5Rg@mail.gmail.com>
	<0D0BB87D-9BF0-48BA-8F2D-83F8D326ECEC@mateuszwielgos.com>
X-Yow: Where's SANDY DUNCAN?
Date: Mon, 23 Sep 2024 20:42:44 +0200
Message-ID: <87r09aus7v.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Sep 23 2024, email@mateuszwielgos.com wrote:

> Thank you for your reply, Han. The problem that I have with ‘—allow-empty’ is that the resulting commit is not associated with any particular file. I tried ‘git commit —allow-empty myfile.txt’ but the file argument is effectively ignored. ‘git log myfile.txt’ does not show the empty commit.

Since the git model is snapshot based, there is no way around that,
apart from putting the reference in the commit message which you can
search with git log --grep=myfile.txt.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
