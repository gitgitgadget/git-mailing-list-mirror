Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EFC3DCD97
	for <git@vger.kernel.org>; Sat, 18 Jul 2026 16:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784391557; cv=none; b=FmIfDJd/tuxKSXmWYPO9O1VOT6mq/wpjAco5a/5UxD3PG2mJHzWy/aqpL4rBplFtExBeRY3TxE+y9ar9zZGVW1Po5xX/WQ4hQwj7/SwaD+I+awXo/9vFe1RnPYZxyV/rps4oxup1sugup43BcFUtvkzifazpuV2MzeTfw5o6uMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784391557; c=relaxed/simple;
	bh=RcvFvdYBqJwnq36sIXGLJ1BpXNl0RG0po8dvKennqmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qZfxJlf+EtZH/OxC7964WkK0LjLB5j+aelExJrPwkE8hYZ22niUpz9TEtw61EtXk7/GFVWlnQ7sK3PbJk2Bi8cQKS5elk7Ge64vSRr7DXtU7ZI3BKWrBg9pKGzffp5tywEfGU+Xaga5qG5KFbyUFGF9N0i3K+/dAgCxJ9bCKPK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp.bon.at (unknown [192.168.181.102])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4h2X610WxBz7RsQq
	for <git@vger.kernel.org>; Sat, 18 Jul 2026 18:19:05 +0200 (CEST)
Received: from [192.168.1.102] (213-147-165-249.nat.highway.webapn.at [213.147.165.249])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4h2X5q4KrFzRnlV;
	Sat, 18 Jul 2026 18:18:55 +0200 (CEST)
Message-ID: <b79a479b-d279-4ac9-a368-6eb8edfed937@kdbg.org>
Date: Sat, 18 Jul 2026 18:18:54 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] bisect: add --auto-reset to leave when done
Content-Language: en-US
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
References: <pull.2335.git.git.1784180159.gitgitgadget@gmail.com>
 <pull.2335.v2.git.git.1784312854.gitgitgadget@gmail.com>
 <5b3704fbd4129e6bf742fe9b38998d5c952c6f21.1784312854.git.gitgitgadget@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <5b3704fbd4129e6bf742fe9b38998d5c952c6f21.1784312854.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 17.07.26 um 20:27 schrieb Harald Nordgren via GitGitGadget:
> From: Harald Nordgren <haraldnordgren@gmail.com>
> 
> When a bisection finishes, "git bisect" reports the first bad commit
> but leaves the session active until "git bisect reset" is run by hand.
> 
> Add an "--auto-reset[=<where>]" option, accepted by both "git bisect
> start" and "git bisect run", that resets as soon as the first bad commit
> is found. The "original" value returns to the commit checked out before
> "git bisect start", while "found" leaves the first bad commit checked
> out; omitting the value defaults to "original".

IMHO, --auto-reset is too generic and doesn't give a clue what is
automatic about it. How about --reset-when-found?

-- Hannes

