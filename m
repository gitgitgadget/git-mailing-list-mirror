Received: from postout1.mail.lrz.de (postout1.mail.lrz.de [129.187.255.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E8C2AE74
	for <git@vger.kernel.org>; Sun, 27 Apr 2025 21:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.187.255.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745790280; cv=none; b=V98aw6Dg1uLmFhzvQgA8wqiKKQuDRhRfBbzdxst5Ob4viXtTZkiP3zm1oITsM3/RoeyxWWOWdd/LQoxdNeA6y35WbasEPO368zUPRnKw38hgicqsMzzhU32yO9rfo4uiZAELVd8tApM3rQho5P57ootnASdfu2ko1XPa0mzu/ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745790280; c=relaxed/simple;
	bh=M5VINi5ITkm+68Oi2YI7QU3/gGpYX+hHox/1LICTUW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u1FbRy8cqMHGhI6tkRgTaonGebZh19O/XMPJ8+c7CIiv+A7GJmm/H9K/PCLjLevrST49UKApJ5oDYaoCLGLm1dYq46OJJp6X6W0sPrTj4J3obCv55wWni2+bXH3yo45RDqXlRFGI690PZh/WJUDgEaYfM2r9apSYJEDNfFIssoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=campus.lmu.de; spf=pass smtp.mailfrom=campus.lmu.de; dkim=pass (2048-bit key) header.d=lmu.de header.i=@campus.lmu.de header.b=SKeb10z1; arc=none smtp.client-ip=129.187.255.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=campus.lmu.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=campus.lmu.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lmu.de header.i=@campus.lmu.de header.b="SKeb10z1"
Received: from lxmhs51.srv.lrz.de (localhost [127.0.0.1])
	by postout1.mail.lrz.de (Postfix) with ESMTP id 4Zm0Tg1ZQnzyTc;
	Sun, 27 Apr 2025 23:44:23 +0200 (CEST)
Authentication-Results: postout.lrz.de (amavis); dkim=pass (2048-bit key)
 reason="pass (just generated, assumed good)" header.d=lmu.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmu.de; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=lm-postout21; i=@campus.lmu.de; t=1745790262; bh=M5VINi5ITkm+
	68Oi2YI7QU3/gGpYX+hHox/1LICTUW0=; b=SKeb10z16BFPjyBNJc07AZZzC37z
	j38TSZRnVbFSmi5a4+1ufMuTkrbeGCTIc38wykOIQN61QgEFTOTl9OkeRvVRSJyp
	6mkUJtuaIwPZ6IbFTRNJF60krcGjXj7PR+ZSE7PvSxbhfUxZ44Dc4rVfYiiYrixq
	ArET3lfJ2/oF0tdYEPPJ2p4DIMeEQ0zTmDhCy5PTyCCrcnetCTzDrHrqVylWa3/T
	hl6Lz2u6zN3VMSOEC/S+lOjktCQ7rAVGqRNjv0DdP647Sjli0Sw4frUezdDnBC9x
	wmK+XKhgNpy2/2AI39ntNHis7glE3n1w2VW90pPtXzRqmaVF2z4P0vXtIg==
X-Virus-Scanned: by amavisd-new at lrz.de in lxmhs51.srv.lrz.de
X-Spam-Flag: NO
X-Spam-Score: -2.878
X-Spam-Level:
Received: from postout1.mail.lrz.de ([127.0.0.1])
 by lxmhs51.srv.lrz.de (lxmhs51.srv.lrz.de [127.0.0.1]) (amavis, port 20024)
 with LMTP id ey1oZuhMkooo; Sun, 27 Apr 2025 23:44:22 +0200 (CEST)
Received: from [IPV6:2003:ed:2f4e:a578:279e:ff22:4f78:ac2b] (p200300ed2f4ea578279eff224f78ac2b.dip0.t-ipconnect.de [IPv6:2003:ed:2f4e:a578:279e:ff22:4f78:ac2b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by postout1.mail.lrz.de (Postfix) with ESMTPSA id 4Zm0Tf2CZczyTW;
	Sun, 27 Apr 2025 23:44:22 +0200 (CEST)
Message-ID: <f3140b32-5a25-448b-a99c-1604f6237cb8@campus.lmu.de>
Date: Sun, 27 Apr 2025 23:44:21 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xdiff: disable cleanup_records heuristic with --minimal
To: phillip.wood@dunelm.org.uk, Niels Glodny <n.glodny@campus.lmu.de>,
 git@vger.kernel.org
Cc: johannes.schindelin@gmx.de, peff@peff.net
References: <20250425155951.1227700-1-n.glodny@campus.lmu.de>
 <23078e29-8f1f-4eb3-be71-7ef419252bab@gmail.com>
Content-Language: en-US
From: Niels Glodny <n.glodny@campus.lmu.de>
In-Reply-To: <23078e29-8f1f-4eb3-be71-7ef419252bab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Phillip,

thank you for your detailed comments.

> Have you got any numbers for the performance change?

I have been using "git log -p -3000 --minimal > /dev/null", as in p4000-diff-algorithms.sh. With this patch, I get

  Time (mean ± σ):      2.363 s ±  0.023 s (25 runs)

Without this patch, I get

  Time (mean ± σ):      2.362 s ±  0.035 s  (25 runs)

So the difference is well within the margin of error. It doesn't look like it has any measurable impact on performance.

> I think the premise of this patch is sound, I've left a couple of comments below as I think we can simplify the code changes.

Thanks a lot! I'll apply your suggestions and send a revised version shortly.

Regards,

Niels



