Received: from cc-smtpout1.netcologne.de (cc-smtpout1.netcologne.de [89.1.8.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6575A1E32D6
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 23:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.1.8.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751327274; cv=none; b=uwhsymMeqaW39e/aoGH4335pCjVirBpmQ3JAvp8aupTI7jhsOWjaFgR/khXKI3yW5hgFy/kj5vro+VtMd1QYpjhuoXmlFq4CAd0wXoFg/xJcWXGbT4GMbsW/+K5YggDTw1e2RnJUMB7CkB/JuypJf/rQTPV/n7M7OexHNBw5cKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751327274; c=relaxed/simple;
	bh=s7tn9cGV9BgoEF8cNX94TNr7/e6xjdmC4VP34bIpWLE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vBy5uvObn89q9LLY/r+nroKoOuNqkFI0aWNTgBpUcg7l/Gp4uvyBFm4Kb76SDOVpcP18Z5nk2xSq7ZWvWfS1bq/GO7f/tW6LYKgVGfychMTL3qVLRWnhh0d/t+C071XJZnKxCKDDRCfxizuSD1SDUgp9lv7OTDxOlfJgEzWtkGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=netcologne.de; spf=pass smtp.mailfrom=netcologne.de; dkim=pass (2048-bit key) header.d=netcologne.de header.i=@netcologne.de header.b=Dj623jlD; arc=none smtp.client-ip=89.1.8.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=netcologne.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netcologne.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netcologne.de header.i=@netcologne.de header.b="Dj623jlD"
Received: from cc-smtpin1.netcologne.de (cc-smtpin1.netcologne.de [89.1.8.201])
	by cc-smtpout1.netcologne.de (Postfix) with ESMTP id DAF7712469;
	Tue,  1 Jul 2025 01:41:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=netcologne.de;
	s=nc1116a; t=1751326891;
	bh=s7tn9cGV9BgoEF8cNX94TNr7/e6xjdmC4VP34bIpWLE=;
	h=Message-ID:Subject:From:Reply-To:To:Cc:Date:In-Reply-To:
	 References:From;
	b=Dj623jlDCqw1/63yq619QgCq50UZkZ2+SfQ19uNX9o7AatbOa6GCFrUKmbVc4ss6Y
	 tPfQwOz4yjv1IIFxPoPVTmaIhuSW3MjgkeZUicccKQN99ki8AKNiw75H8GMT5rihGK
	 2/E8Sg8kOm0De6WmI0O2CZ+AixICLb+Que1JzhXASK8Jys5zQbDqlc4UA+aL9rhS9X
	 oGgHCLUQ3Ir+WdJLPNI445qcoVytoP5af6uVjtZ1nbqn9A8KtnE2TvZCZIjx7dkeL9
	 SAwzqFd3wCOg1C8XxxL6p3C9VKEa0eCe52JLi75siy3Kp0A4gCzUcszwFAignFRIWx
	 ACQQPi6j8JHmg==
Received: from montjoie3.internal.jansen-preisler.de (static-87-79-78-107.netcologne.de [87.79.78.107])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by cc-smtpin1.netcologne.de (Postfix) with ESMTPSA id 3B8CF11D65;
	Tue,  1 Jul 2025 01:41:17 +0200 (CEST)
Message-ID: <58844e006ef8000a827656450c7eef5381eaf8fe.camel@netcologne.de>
Subject: Re: Draft of Git Rev News edition 124
From: Markus Jansen und Julia-Anna Preisler <jansen-preisler@netcologne.de>
Reply-To: mja@jansen-preisler.de
To: Christian Couder <christian.couder@gmail.com>, git <git@vger.kernel.org>
Cc: "Markus Jansen <mja@jansen-preisler.de>" <mja@jansen-preisler.de>, 
 Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>,
 Kaartic Sivaraam	 <kaartic.sivaraam@gmail.com>,
 =?UTF-8?Q?=C5=A0t=C4=9Bp=C3=A1n_N=C4=9Bmec?=	 <stepnem@gmail.com>, Taylor
 Blau <me@ttaylorr.com>, Johannes Schindelin	 <Johannes.Schindelin@gmx.de>,
 =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason	 <avarab@gmail.com>,
 JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>,  Stuart MacDonald
 <SMacDonald@kaimaging.com>, Eric Sunshine <sunshine@sunshineco.com>,
 =?ISO-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>, Luca Milanesio
 <luca.milanesio@gmail.com>
Date: Tue, 01 Jul 2025 01:41:16 +0200
In-Reply-To: <CAP8UFD2hTgJu-byOE-R-nt6OYqVoBTH1JiLbHoqB_pq=H_K9yA@mail.gmail.com>
References:
	 	<CAP8UFD2hTgJu-byOE-R-nt6OYqVoBTH1JiLbHoqB_pq=H_K9yA@mail.gmail.com>
Organization: Jansen + Preisler
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NetCologne-Spam: L
X-Rspamd-Queue-Id: 3B8CF11D65
X-Spamd-Bar: /
X-Rspamd-Action: no action

Hi,

I supplied the usual tiny fixes and rephrasings with 880257a -
please scrutinize.
