Received: from sdaoden.eu (sdaoden.eu [217.144.132.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35948190462
	for <git@vger.kernel.org>; Sat, 27 Jun 2026 15:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.144.132.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782575359; cv=none; b=grO1ayJQ6yGR6AkLNI02n03JmOfCOTT+Qxi1iP/rC5Wssj7ZXtW0wzoTwjFtVMXnq7NQm4FMcrQ4wvMAGT1lfvzZkgPHzSYzMZYvGK4S1naAevPb9JUCrSPnp1wPHgH3LOZ5GFFxHvfRdQlHnSVslIWgbhbBX9/BItw0xMfBfVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782575359; c=relaxed/simple;
	bh=FqWU6m0Ur5idYJYtECoAnsLrOzcZSNicR58oio/+Ba4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=bEB2h7bhSnd4ZgEbHdjh2Z06qtlcwwSvEuRvs03DKEOJKr0lYf9arwMuCOXGk6bwPV75F3BYXfE72V5TGXvzhYwY+Nz8bLjmNsh+w2/QzHzBVPw55CTJsyE9gOrreZpEGoA3iAE6WwlF6Ic2nDbU81K958JMLBfAke2twqecmFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdaoden.eu; spf=pass smtp.mailfrom=sdaoden.eu; dkim=pass (2048-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b=PPyVA6W0; arc=none smtp.client-ip=217.144.132.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdaoden.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sdaoden.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b="PPyVA6W0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sdaoden.eu;
 s=citron; t=1782574762; x=1783241428; h=date:author:from:to:cc:subject:
  message-id:mail-followup-to:openpgp:blahblahblah:author:from:subject:date:
  to:cc:resent-author:resent-date:resent-from:resent-sender:resent-to:
  resent-cc:resent-reply-to:resent-message-id:in-reply-to:references:
  mime-version:content-type:content-transfer-encoding:content-disposition:
  content-id:content-description:message-id:mail-followup-to:openpgp:
  blahblahblah; bh=s6PzuNflxPGYwt9HfQUZhPzLYb0JWHFR1BxGTpW15OM=;
 b=PPyVA6W0kGKfFH9Mpv7RkreHMMC4Yl5U5vkAkn2xYl5L9rbbpv6ywsred9mRjRHaEpJbvnNY
  auutjeBIv7dBGLj8L778i1MasYWUpO9IltAbODPpNePTQ+P3u/Eh20+p+mv8TZDDqdUitRee6t
  dPcfg4zlQSxglJzF7yJMbo9smtqlGmecAooEEkJpP2/dJ/RR4SPffXWw5yDHMJE6H9FkY/FcDC
  8wAXSmWqkPcwkLaNkHZPvKlKN4xjbuYiAfVJe0cEdSQ7CLDq8pKwytRZ/dfbdLE0dOZ5k6tx4s
  SVA8S+FlAoaO7lr+9VB4j5tUWyPtBsOBJC19pxM1TCdsD0tQ==
Date: Sat, 27 Jun 2026 17:39:21 +0200
Author: Steffen Nurpmeso <steffen@sdaoden.eu>
From: Steffen Nurpmeso <steffen@sdaoden.eu>
To: git@vger.kernel.org
Cc: Steffen Nurpmeso <steffen@sdaoden.eu>
Subject: 2.54.0: fyi: endless loop at 100% CPU
Message-ID: <20260627153921.4ONZp5qm@steffen%sdaoden.eu>
Mail-Followup-To: git@vger.kernel.org,
 Steffen Nurpmeso <steffen@sdaoden.eu>
User-Agent: s-nail v14.10.0-alpha-44-g9d85ccf596
OpenPGP: id=EE19E1C1F2F7054F8D3954D8308964B51883A0DD;
 url=https://ftp.sdaoden.eu/steffen.asc; preference=signencrypt
BlahBlahBlah: Any stupid boy can crush a beetle. But all the professors in
 the world can make no bugs.
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>

Hello, for your possible interest.

I have no idea and i am not looking either, but my scripted update
of tracked repos stuck, and i can a hundred percent reproduce an
endless loop that consumes hundred percent CPU by doing

  git ls-remote https://gitlab.xiph.org/xiph/opus.git

I had updated expat, but that did not change a thing.
My gut feeling said that this should not end up like that.

Ciao, and thank you!, of yourse (15 years git now!!)

--steffen
|
|Der Kragenbaer,                The moon bear,
|der holt sich munter           he cheerfully and one by one
|einen nach dem anderen runter  wa.ks himself off
|(By Robert Gernhardt)
