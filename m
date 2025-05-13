Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF24645
	for <git@vger.kernel.org>; Tue, 13 May 2025 17:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747157262; cv=none; b=kkGWC5iURGDDsjWrmT4J5JNOatnNlaBEc2oO54X4ykx33vLp//cqJCsdEKuOosOkfrDiCmGhh9jdLLkpm4ZcRFhO/JTn1iw0oCecLrcZVtAPJ+IjZlJBNoo11iUotJDhTvmV372XeNoT2KducJJoYq/lwxDSg/45oz8AL0Qi83M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747157262; c=relaxed/simple;
	bh=SFUnYrxul/JNw2xbwe5lEAvw/bc+Xf47Di01aOxhMJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=C3XxkXlfskHPEVxBvl4oPq7AEJ3ai9UHFsiFClKn+2BOXb56kRjDz5V3pzX8B7hZSXLhc8mX3ZEs5Gq6F3mGNpYpLTHGEX3yD3IDk62y3cz0CCXIbLQ409qIZn98BQfEvMy2sSBwM8wB9FD1ym0CAFVF7L+HLbizg/CTVCtHaME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4Zxk1v25C6zRq26;
	Tue, 13 May 2025 19:27:31 +0200 (CEST)
Message-ID: <fc923099-52ca-4f0d-8490-c5768a098444@kdbg.org>
Date: Tue, 13 May 2025 19:27:30 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: "POSIXLY_CORRECT" - "msgfmt: msgfmt: --tcl requires a "-l locale"
 specification"
To: Nathan Royce <nroycea+kernel@gmail.com>
References: <CALaQ_hp2dgPS5HYpYPzztCS52SCnR9vF2ovAHZOBPpS8MRLSrA@mail.gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
In-Reply-To: <CALaQ_hp2dgPS5HYpYPzztCS52SCnR9vF2ovAHZOBPpS8MRLSrA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 13.05.25 um 10:17 schrieb Nathan Royce:
> Order matters with POSIX. Arguments come before source/target.
> 
> Success: `msgfmt --statistics --tcl -l bg -d po/ po/bg.po`
> vs
> Fail: `msgfmt --statistics --tcl po/bg.po -l bg -d po/`
> 
> build/gitk-git
> make[1]: *** [Makefile:76: po/bg.msg] Error 1
> make: *** [Makefile:2466: all] Error 2

Thanks for the report. How did you get this report? Which OS and version?

-- Hannes

