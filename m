Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3AE2AD2C
	for <git@vger.kernel.org>; Fri, 17 Apr 2026 04:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776401441; cv=none; b=rwdoIyRfTXIvm9oCv0nhxtgHLNsEoP5xFLH8yaXp1lqLYia69worj8wJI9GbWNo7RnJrzA0xoy13llkkdeDQXJfFqRpWaLNP1P4YnqCce5o0IlrLjVkAu3PsfKHQwkn4rxU0pFgvwBQ5hdmxpepPD0qLgw78y3AXsN3J13Clvaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776401441; c=relaxed/simple;
	bh=23R4gWOVKkDzdo+vhhMMDIA0Jzn8aSXW8+vPgaXqkqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JaR0FxV3jA316lTcIsUGCYfKna/sNyk8LfYas7omi6JGankeGwhoBlc+yDTyPt5reWlMsW8q0ZNn6S5EK2KLZeUTqevjU5+hFEmZ/0a6yqbmW7bOLmj5sifibIPUX/e4ZVOyUUQDMLY0p96W9jGK0QPbSpojKTIIimhECnl033I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land; spf=pass smtp.mailfrom=howdoi.land; dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b=pgMO6kf1; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=howdoi.land
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b="pgMO6kf1"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <ask+git@howdoi.land>)
	id 1wDbA2-005Pe5-Ux; Fri, 17 Apr 2026 06:50:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=howdoi.land
	; s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=14WkgPKfXXHtMB4Is9ep1ksTCH0RNrB3/G/b7SMG6a0=; b=pgMO6kf1HONoGo6RguhWNaEUHl
	Rlocjx5lyw1pARGQTDCvR5WRwK0hcL26RaClpqysBHireGnICBxPOB/Jo2CDfyOzK1hlQ0sv71EDb
	vxbVZ+rHskYJHHugr5CMxtF/W9/zZdmFqTWySqTaSyJqJ1fIfLuEc6x+K0KTIen8RiZS2Ud/V/evX
	ri4nuxr4P471dQxhtIty+CHBhEtw7slVixijGXIwiQeQnBdOhdb6BU3U0fyAPI/S0pSAFpp6lritU
	4S481EKLH/MY2FAHZ7FaWQE4JEw/Zw/lFrgt/7eTqQcDpPXFVpgmRX8q1kkv0l7mMQ5uyY3Pze/k3
	YCUPxDfg==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <ask+git@howdoi.land>)
	id 1wDbA2-0001cP-5w; Fri, 17 Apr 2026 06:50:34 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1204229)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1wDb9r-002jlR-Mb; Fri, 17 Apr 2026 06:50:23 +0200
Message-ID: <a1a07433-224e-4477-ae8a-3875fa98faf8@howdoi.land>
Date: Thu, 16 Apr 2026 23:50:21 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] contrib/subtree: reduce recursion during split
To: Ian Jackson <ijackson@chiark.greenend.org.uk>
Cc: git@vger.kernel.org, Christian Heusel <christian@heusel.eu>,
 george@mail.dietrich.pub, Christian Hesse <list@eworm.de>,
 Phillip Wood <phillip.wood@dunelm.org.uk>, Junio C Hamano <gitster@pobox.com>
References: <20260215201748.889866-1-ask+git@howdoi.land>
 <20260305-cs-subtree-split-recursion-v2-0-7266be870ba9@howdoi.land>
 <27104.58166.993109.63505@chiark.greenend.org.uk>
Content-Language: en-US
From: Colin Stagner <ask+git@howdoi.land>
In-Reply-To: <27104.58166.993109.63505@chiark.greenend.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/16/26 08:25, Ian Jackson wrote:

> FTR Debian supports multiple options for /bin/sh.  The shell in
> question, with the limit that's troubling us, is dash.

Correct, I experience this behavior in dash.

> Why not run the script under bash in non-POSIX mode instead?  I think
> that would sidestep the problem. 

Our coding guidelines favor POSIX constructs over non-POSIX constructs, 
including for shell scripts [1]. POSIX helps us stay portable.

I'm not convinced that adding more shell interpreters to the mix would 
be a net win in terms of stability or consistency. This patch series 
addresses issues that arise from different implementations of sh. Adding 
bash vs sh to the mix will probably just make more bugs.


> If it had been me I would probably have used Rust and libgit2.

git-subtree has been around since 2009, so you would have first needed 
to invent Rust. :-) That said, a native Rust version of 
git-subtree-split would be much faster and easier to read.


Thanks for looking at this,

Colin

[1]: https://git-scm.com/docs/CodingGuidelines

