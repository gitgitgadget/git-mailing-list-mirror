Received: from ra.horus-it.com (ra.horus-it.com [65.108.3.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F471EEEA
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 15:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.3.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709827043; cv=none; b=jaR97JWXIKNku2l4KKsbWA+dNmeDR2ihIy/EZ3ZNNiOIiTO6K2lD6Dpq9tOfAGJf+6k2UCwfh/GJpXPMeCp9iJ1t3NkcyBdFseh7GkwBVsFAYIZsXAdowQYN7FVTGFc+1wdMiOv/9Quvy5+bJZNiNopWpY1ZHmYuJL6kl2iCuFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709827043; c=relaxed/simple;
	bh=cGHOuFKqY0uOfYPhKPunMRwmRW34tN8QwIM6IG9pi6Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z2BsBW0RthZ5RiyOPohQLENMfkchqxTBsNK6UUKrgLUy3vJY3k2lb9IeW5GEytO+cByBogRF5FbtQhu1F0T+EanZH0NiDMuSgPX8AazyN0cJZupVohZWI7ZScffPA3d8oEtmvvNIqgc/sA8Uoi7xbAAZK/uYfu8bM/tdWZ5gIF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seichter.de; spf=pass smtp.mailfrom=seichter.de; dkim=pass (2048-bit key) header.d=seichter.de header.i=@seichter.de header.b=fxRU5fHh; arc=none smtp.client-ip=65.108.3.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seichter.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seichter.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seichter.de header.i=@seichter.de header.b="fxRU5fHh"
Received: from localhost (localhost [127.0.0.1])
	by ra.horus-it.com (Postfix) with ESMTP id E1DABBE0031;
	Thu,  7 Mar 2024 16:57:16 +0100 (CET)
X-Virus-Scanned: at horus-it.com
Received: from ra (ra.horus-it.com [IPv6:2a01:4f9:6a:528d::a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	by ra.horus-it.com (Postfix) with ESMTPS id BEC37BE002F;
	Thu,  7 Mar 2024 16:57:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seichter.de; s=k23;
	t=1709827036; bh=cGHOuFKqY0uOfYPhKPunMRwmRW34tN8QwIM6IG9pi6Y=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type;
	b=fxRU5fHhlSqktIfBzQtOyN2KYg6tNgB99t8svvxOLZsdK1ZhhVBsBdeFtEW+fI6WQ
	 V+iWuFtPP7CgtkNdB77osbGou0QHTwzHO244oDs8ZSnsflqYhuJaZazNm5if8+DHv0
	 jFdbrEVzwR6r7xYzcgbT+2SimQegjY2Jmq0QsbWfV8UELudt2VrAoOzYLxnCmN0eCk
	 8FKOE0cTshGDnR7u+1eKozhhkdOmFgaryb2QOHGJXcV9gqrwpDGncEpnI0c0LtpOgm
	 K/EiN1rvJxC51bayJrlPnAuYsW9z0Jjes8tNP9VsidUHVWyrAtwDabKVTIadq6HVn7
	 k2ExIEGmOmskw==
From: Ralph Seichter <github@seichter.de>
To: rsbecker@nexbridge.com, 'Ralph Seichter' <github@seichter.de>, 'Junio C
 Hamano' <gitster@pobox.com>
Cc: gitgitgadget@gmail.com, git@vger.kernel.org
Subject: RE: [PATCH] Allow git-config to append a comment
In-Reply-To: <09c501da70a5$bd2f4f40$378dedc0$@nexbridge.com>
References: <pull.1681.git.1709532018372.gitgitgadget@gmail.com>
 <xmqqttljtkn4.fsf@gitster.g>
 <2560952c-4495-4a71-9497-aa40032e1d2b@seichter.de>
 <xmqqplw6nsuz.fsf@gitster.g>
 <098101da7096$cd773d40$6865b7c0$@nexbridge.com>
 <87h6higj1a.fsf@ra.horus-it.com>
 <09c501da70a5$bd2f4f40$378dedc0$@nexbridge.com>
Date: Thu, 07 Mar 2024 16:57:16 +0100
Message-ID: <87wmqevxur.fsf@ra.horus-it.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

* rsbecker@nexbridge.com:

> My purpose is just to highlight, for the purpose of reviewing the
> change, that there may be unintended impacts, that's all.

I see. Have you perhaps spotted a flaw in the patch which might cause
problems? If so, I'd like to address it.

> With git config moving comments around, responsibility shifts to git -
> a.k.a., unintended consequences.

It is important to note that my implementation does not engage in
"moving comments around" at all. It merely supports adding comment
suffixes to config lines *while they are created by git-config*. No
after-the-fact comment manipulation is done. There are no multiline
comments involved either, which I should have mentioned from the get-go.
The limited scope of my proposal is deliberate, and aimed at avoiding
possible problems based on the design alone.

-Ralph
