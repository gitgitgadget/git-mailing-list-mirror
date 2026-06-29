Received: from leopard.cherry.relay.mailchannels.net (leopard.cherry.relay.mailchannels.net [23.83.223.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969AC40D59F
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 17:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.223.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782753592; cv=none; b=YJSq7TyG+h6kMFAuzNWIzImeNZyGk0bDCBepVAlbu9W51HHs4MrSU2kRhm69tr5AT6BtJMzS9BM4sOqSeCXR9Rhcbf/BEoWu1uJ4fPb2/atX2+0wN+kgoFDXd+/8bl5j7SPy5DATCVIEXscI9iLDqFatHttSc4uZdj0snDt/pMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782753592; c=relaxed/simple;
	bh=9dul5liuXtmnRjbXe5KK1T1jbI25GPyG2vB6YW1xl0s=;
	h=MIME-Version:From:Message-ID:Subject:To:Content-Type:Date; b=GHOY20bFrV6IzBgrJrG6o1m8u4r5agw/ZwXllVX6dIH8oI9n0k00ToQ7eJVQ8dtUCzCS1MWEgHgfymbyGQa8hVrcjix6UCKUXSh7FupMqdNzkq2QgqZwKWsYsEixc2hiOi9+lFyfEbcNrrKDG2i6GFZlidLO4gXoHZC3vqJiYEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pixellogicit.com; spf=pass smtp.mailfrom=pixellogicit.com; dkim=pass (2048-bit key) header.d=pixellogicit.com header.i=@pixellogicit.com header.b=pLhYanrW; arc=none smtp.client-ip=23.83.223.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pixellogicit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pixellogicit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pixellogicit.com header.i=@pixellogicit.com header.b="pLhYanrW"
X-Sender-Id: hostingeremail|x-authuser|masonorantes@pixellogicit.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id BE3D34E2B3B
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 17:01:33 +0000 (UTC)
Received: from de-fra-smtpout9.hostinger.io (trex-green-1.trex.outbound.svc.cluster.local [100.99.149.99])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id 002594E2CD8
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 17:01:32 +0000 (UTC)
X-Sender-Id: hostingeremail|x-authuser|masonorantes@pixellogicit.com
X-MC-Relay: Good
X-MailChannels-SenderId:
 hostingeremail|x-authuser|masonorantes@pixellogicit.com
X-MailChannels-Auth-Id: hostingeremail
X-Grain-Whispering: 38c044604a037707_1782752493544_3149934127
X-MC-Loop-Signature: 1782752493544:2454534330
X-MC-Ingress-Time: 1782752493543
Received: from de-fra-smtpout9.hostinger.io (de-fra-smtpout9.hostinger.io
 [148.222.55.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.149.99 (trex/7.1.5);
	Mon, 29 Jun 2026 17:01:33 +0000
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(Authenticated sender: masonorantes@pixellogicit.com)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4gpsxl0klGz461t
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 17:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pixellogicit.com;
	s=hostingermail1; t=1782752491;
	h=from:from:sender:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:mime-version:mime-version:
	 content-type:content-type; bh=9dul5liuXtmnRjbXe5KK1T1jbI25GPyG2vB6YW1xl0s=;
	b=pLhYanrWjfallYUXvfCM0a3WyV8XIQrxO7pERcW4LoPIojupHo7gI/Fu+8j5rVI4LeN96d
	2aZE5BmPx08Jx8KWtVmGSdw5ROsJwemJ/91cqi0MjkkBTaL5ztmjAockBVrUvFKr36kjVy
	KZREXJLZ1PD057hu30C5CgwHyKKE30bIqfJSjMbLMNM+DFC1n9xqeTlVlVepVsqfgLqV9V
	W2oK3bEX38+MGxltDVrERnbtRx2xaxumZKHv8ej7dCH+IxFqniwWOgB12krI0Lw2lMeYAp
	VYg619ye94xA925HSt1/J36Vzxmgl0WmL4RLfUJqNbqChXo64HSMZNhHKSthag==
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-30edfd9cff9so294715eec.1
        for <git@vger.kernel.org>; Mon, 29 Jun 2026 10:01:31 -0700 (PDT)
X-Gm-Message-State: AOJu0YzpB/yDidjsCOfKJxVfSVgkpXiHFhbYFTnYtT+6ebQAsUKsA5T1
	aUU7mm1aDeugG26IgJWlEY/RVn0IbXY0U+xoLZcG5NRuPhg3EB/dOLefgBrp5NRFX93BHpcwkFs
	02bZo+QoBaX+176xU/aHroJcR0/n6jcY=
X-Received: by 2002:a05:7300:7247:b0:30c:9ca4:5cb6 with SMTP id
 5a478bee46e88-30ee1410ee3mr170777eec.23.1782752489573; Mon, 29 Jun 2026
 10:01:29 -0700 (PDT)
Received: from 623230945122 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 29 Jun 2026 13:01:28 -0400
Received: from 623230945122 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 29 Jun 2026 13:01:28 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: Mason Orantes <masonorantes@pixellogicit.com>
From: Mason Orantes <masonorantes@pixellogicit.com>
X-Google-Sender-Auth: usj9KuU0HGSCVR3M8o81e2yBsQk
X-Gmail-Original-Message-ID: <CAHY0mW9CxeoawXywyY4NfF_qU0b+dWC=osAyMDR0BkyZPi6=vg@mail.gmail.com>
X-Gm-Features: AVVi8CdRaevein8GAANFHe8ZoJGoMFRHDxBpC_9lnFR87mLzG3-06OsbG_D818o
Message-ID: <CAHY0mW9CxeoawXywyY4NfF_qU0b+dWC=osAyMDR0BkyZPi6=vg@mail.gmail.com>
Subject: Open to a DR60+ link exchange?
To: git@vger.kernel.org, git-security@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 29 Jun 2026 17:01:31 +0000 (UTC)
X-CM-Envelope: MS4xfHtc8en3CQHyKkV3Bwmn/M3j7y9s/R5zIc7Ngpy+9ffm+LIF21mc0rknbSEIZeKJs+ynJAcGOxt1R1BymzPhwXXx9TMYflKvu8ggP9Iwo18t57k/eW8C 67vHhRlmHoT5Q9bEX3w5gEJkDuKJ/C3Xlfy0Ze2Dsbe99B8Ff0TCl/237NRr2lI8t9CPU74nJYJmRHpr6P9Ne3FiDuKg2adVXrc=
X-CM-Analysis: v=2.4 cv=etGNzZpX c=1 sm=1 tr=0 ts=6a42a4eb a=OQjSmAgzJ/FmyrhlIZfhsw==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=GKY82XzfFvwA:10 a=anyJmfQTAAAA:8 a=mZI7VovuWjq3Zp1NXvsA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=SZTY6sEu2y6f4AhIkycU:22 a=BYL-pX1xYmNgx-yrYO5N:22
X-AuthUser: masonorantes@pixellogicit.com

Hi Team,

Hope you're doing well.

I wanted to ask if you're open to a direct link exchange.

I have access to DR60+ websites where I can place a relevant
contextual link for you. In exchange, I'd like a relevant link from
your site.

There is no fee involved. The only requirement is that both links
should be niche-relevant and placed naturally inside useful content.

If this works for you, I can share my domain list for review.

git-scm.com

Best,
Mason Orantes
Pixel Logic IT
