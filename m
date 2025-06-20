Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9905E28FD
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 14:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.18.0.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750429893; cv=none; b=Sk0JsVhjVaCgEX8D954/qdZR7plpvcmqWaU9LT74SBclIxZYmMSqMyerAuDXXl3B96W+ib3sugwcosNlbKAyw3bwUJMe7pyLPPGeVdUmzgJ9cU+5FZDb8p5CTvm9PKEGKWMWEMop//WP8G+5sx0qj6ncDUOyrh6zV4Fm/kmeisI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750429893; c=relaxed/simple;
	bh=X34VkTdqUSdQvGIQsbL28pWEU/PUPbKLOxgUVGlc+qA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gd+6PN8kosXxavCOrDFOt2R15CIaemkR1geLBSAZDAhrcz+tRtIk+y+Xc6dwnq94yPnozaiI0BrMyWeLrNmdKYZrJaYyhtnAqURuLM04tnM+/o+2gd1LHV9B7FYOlHCssDWXUsLJDCsPcb2AAU5qENvr/noM5e2pJGLoX2cxbDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=nefkom.net; arc=none smtp.client-ip=212.18.0.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nefkom.net
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4bP07J51R2z1r4qC;
	Fri, 20 Jun 2025 16:22:52 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 4bP07J4NY3z1qqlW;
	Fri, 20 Jun 2025 16:22:52 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id owbazokDTTi0; Fri, 20 Jun 2025 16:22:43 +0200 (CEST)
X-Auth-Info: cj71oy0BXa/nUax6TwnaNIlxm+/HRpzr3rlOwDSjckti7s/IKDhpbPWGspu/Am6O
Received: from igel.home (aftr-82-135-83-91.dynamic.mnet-online.de [82.135.83.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Fri, 20 Jun 2025 16:22:43 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 104242C21FA; Fri, 20 Jun 2025 16:22:43 +0200 (CEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Maxim Cournoyer <maxim@guixotic.coop>,  git@vger.kernel.org
Subject: Re: [PATCH] contrib: Honor symbolic port in git-credential-netrc.
In-Reply-To: <xmqqmsa27cdn.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	20 Jun 2025 06:48:04 -0700")
References: <20250620041239.27839-1-maxim@guixotic.coop>
	<xmqqmsa27cdn.fsf@gitster.g>
Date: Fri, 20 Jun 2025 16:22:43 +0200
Message-ID: <87pleyijbg.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Jun 20 2025, Junio C Hamano wrote:

> Do we know symbolic port names are always limited to alnums?  Or on
> some systems some byte values in the fringe, like "_" or "-", are
> also allowed?

Valid service names are documented in RFC6335.  Specifically it allows
hyphens, but not underscores.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
