Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214C5190477
	for <git@vger.kernel.org>; Mon, 23 Dec 2024 21:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.18.0.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734988576; cv=none; b=nrapDFaVVq/tbL+TCEsmcD/5O+ubxrxFBulse5YXKDti9qTWzcWkQfOWFUaeQbKyqLL1OQp4farl4IhAUhuXa0XKVUg5O7liSYQyUylw1e0mVYY/n/bNyE8Z/TnRzOM3Yb37HhQ32x9jU+jsWuC09XGVRLL3DwqSIoOl/KIrUu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734988576; c=relaxed/simple;
	bh=GjMmmh9VuSA0CLVyAx8v7mdiUZUZ9qqfb043WFSZY5c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sWiVoJT7VSOyTvPnVo3Ju+V9wiq7tg2k5VVIFxNxORA1Ts7SewelAyG9Mmd7G/KnEZ+c7tNpbiX4EVAH/8XaIcrgoOc54qyNL33Cmwh5rIHII5PbBQPnJnpheIz1sk02PttMA4GzCedv2m/DN9LD57UQp2564yyXYwmwiZSh1xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=nefkom.net; arc=none smtp.client-ip=212.18.0.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nefkom.net
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4YH9cq3Fnxz1qsP5;
	Mon, 23 Dec 2024 22:09:15 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 4YH9cq2qz9z1qqlS;
	Mon, 23 Dec 2024 22:09:15 +0100 (CET)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id 7O4vsVUh_AmY; Mon, 23 Dec 2024 22:09:14 +0100 (CET)
X-Auth-Info: eXHGy4OYqln/7vQbM+lim6zPuE1eMBUbs5/wzGLeLJGN6xVorE2CM69sWGzSZj/L
Received: from igel.home (aftr-82-135-83-21.dynamic.mnet-online.de [82.135.83.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Mon, 23 Dec 2024 22:09:14 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
	id 7D8192C19AD; Mon, 23 Dec 2024 22:09:14 +0100 (CET)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Alejandro Colomar <alx@kernel.org>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
  git@vger.kernel.org
Subject: Re: git-log --format missing trailing newline character
In-Reply-To: <5aib7c6x5m6e4muutjuoqp3f4lvpeh3hz5qkwpayi2usm7b6yi@af2oucx5j4w5>
	(Alejandro Colomar's message of "Mon, 23 Dec 2024 21:49:40 +0100")
References: <cw7vyas4yw2q4lqiskbvil7mpkx5l5qilj25vnqzkrp5nuezrx@d6tsavm3ajzw>
	<d813a3dd-68c2-4cbe-92a0-cfd1ece77e9b@app.fastmail.com>
	<5aib7c6x5m6e4muutjuoqp3f4lvpeh3hz5qkwpayi2usm7b6yi@af2oucx5j4w5>
X-Yow: Will this never-ending series of PLEASURABLE EVENTS never cease?
Date: Mon, 23 Dec 2024 22:09:14 +0100
Message-ID: <8734ieyumd.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Dez 23 2024, Alejandro Colomar wrote:

> Anyway, it feels awkward that git-log(1) skips the last newline whith
> --format=format.  Should that be fixed?

If you want terminator semantics, use tformat: instead of format:.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
