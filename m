Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83DE1C14
	for <git@vger.kernel.org>; Sun, 23 Jun 2024 09:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719134043; cv=none; b=LZRBRtkV7Zib7du2faBpx2tclF8Dq5UDO/IRULLTCg1dl/9wpwV/ylh9uwQdX24UqZdRJyQJmIW4dZgcsaZ1+XtswI1hBsXR0qiTUumJxW+bL1xd++Ig1Ugj1f/APSVTckCGMgEQn5Fwbt9fndcaZVWPnq7J/mTWcn6Kb2DE1YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719134043; c=relaxed/simple;
	bh=Qwdxw4N+9qNPiIkjTfFFBKwVIA/mgaNabTkYHy9oxGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DcmhnFpLUqwJfiz2r1HMuXYZXCkJKOg70ZGPqztX9ZtZZ7J1jK9M/gjECWZFPIS0AgYDVUqbUvSsuspNC8kEp/26AcpVlGZ6IEP8CDjnoBbtSIjHQE8iC0S6OAXR4jEgaukjcPUT88UQmB7zJbghCixcZ6Sp/O80Hmdm3ZZ31yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.105] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4W6QPt0BxZzRpKd;
	Sun, 23 Jun 2024 11:13:53 +0200 (CEST)
Message-ID: <506e1f16-ac02-496c-a9dc-414726c1c37f@kdbg.org>
Date: Sun, 23 Jun 2024 11:13:53 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix default font scaling
To: Serhii Tereshchenko <serg.partizan@gmail.com>
Cc: git@vger.kernel.org
References: <20240615085345.47278-1-serg.partizan@gmail.com>
 <5dd4de8a-255a-4f03-b4d8-fc160b3178e1@kdbg.org>
 <Q1B6FS.FVKOG950Y3UN@gmail.com>
 <abee589d-5bad-4376-ba91-3bd611936983@kdbg.org>
 <N75EFS.1X38FZPYSV94@gmail.com>
 <0c845460-c211-48e6-af93-a0b483817420@kdbg.org>
 <3M5FFS.HXL15VW2HPOG1@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <3M5FFS.HXL15VW2HPOG1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 21.06.24 um 09:18 schrieb Serhii Tereshchenko:
> Thanks! I tried booting into Fedora/37 with the same Tk version, and it
> indeed does not have this scaling problem.
> 
> Then, I downgraded packages on Arch to 8.6.12 and 8.6.13 - also no problem.
> 
> The only version affected is 8.6.14.
> 
> That's probably a bug in Tk (and there's quite a few reported, mostly
> about "tk scaling" https://core.tcl-lang.org/tk/info/1de3a48312, we
> don't use it explicitly in git-gui but on my system it is set to 1.3)

What is the best course of action now? Since this change does not make
things any different for me on Linux+KDE, I am inclined to pick up this
patch with a modified commit message and code comment that clearly state
that this is a work-around for a bug in Tk introduced in 8.6.14. This
would help users who upgrade from an earlier version of Tk, because it
does not look like a fix of Tk is in the works (or that the issue is
regarded as a regression by Tk people at all).

Suggestions?

-- Hannes

