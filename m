Received: from gosford.compton.nu (gosford.compton.nu [217.169.17.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E1FF9E6
	for <git@vger.kernel.org>; Sat, 25 May 2024 10:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.17.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716632961; cv=none; b=FNl3Ik6XZrvKEeXpO1tCwfY1uYp8hvhmxpaqCirLOfmQ/exu1FUQrbTLP2w8Z8OX5SqFuS4WJAAC/FjOFyABGTtqh5GfNcC9/nNWgLdNRe/70rIfIo6giP18cWKLT7rqlf45RDaLEiSQsSnp6SgehGv9S68NjNeIuyqDYkj9MQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716632961; c=relaxed/simple;
	bh=RvmX9hX/IRdOSxLoGbrG2d12ANa0T/YrORGSk75xuoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dG2iYIcCf6A69d+eFbW0Kh3zBSQsUm0no4hlGkz/TSzcEPlVz1erWAzzzh4Ew7ZrZdQXfIJ5EatX2w4JHLsropmdHflE99cdATsLa5l6eyt++oRQoyQHNbmdFjITZR2BwHyREszyzu7UGDRo+J+T2CKdg2srjjJw4fmiuMU4u3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=compton.nu; spf=pass smtp.mailfrom=compton.nu; dkim=pass (2048-bit key) header.d=compton.nu header.i=tom@compton.nu header.b=PLltpTzv; arc=none smtp.client-ip=217.169.17.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=compton.nu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=compton.nu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=compton.nu header.i=tom@compton.nu header.b="PLltpTzv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=compton.nu;
	s=20200130; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HBno1X1e6+IzuvDqJvRt+H6titU1oYDUFrA4CtCZd+I=; i=tom@compton.nu;
	t=1716632960; x=1717842560; b=PLltpTzvQMzwTUk5g8tBDghMx4H6ParCCDLyJs3N3uQKEWx
	h3ad/zXxudEjLEZMnbHV74/CBdJIhG3/XCbORYl/jJXSrK/9rtahSh5T3/ytDl0tlfAvZqbuM4Wzp
	aqAZU9Z8eNr8LQl1uQKgxpQroq0nhxk57SVQCmEnsqkcBjOhcQC+okgv/chjbmtkVBHrvLpoSDkou
	9zjvT0xTOSKVfofxYUDr4rSKNwuLlIE41cUrpLXhg4ZzwFTtpnF/VWmbUcYJwNyYw65CHXv3GfGW3
	18wYmo2JGbwv+VipZXdOUci8+w4sKJh5jsTUNf1dLFxEeGpcTgq+dyzkfjCtvhNQ==;
Authentication-Results: gosford.compton.nu;
	iprev=pass (bericote.compton.nu) smtp.remote-ip=2001:8b0:bd:1:1881:14ff:fe46:3cc7
Received: from bericote.compton.nu ([2001:8b0:bd:1:1881:14ff:fe46:3cc7]:44904)
	by gosford.compton.nu with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <tom@compton.nu>)
	id 1sAoeH-00000009rYp-2rNE;
	Sat, 25 May 2024 11:29:17 +0100
Received: from bericote.compton.nu ([2001:8b0:bd:1:1881:14ff:fe46:3cc7]:49158)
	by bericote.compton.nu with esmtps  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.97.1)
	(envelope-from <tom@compton.nu>)
	id 1sAoeH-0000000CP3Q-2VlH;
	Sat, 25 May 2024 11:29:13 +0100
Message-ID: <1b10454e-c5ad-4ce3-a724-27306ee8824c@compton.nu>
Date: Sat, 25 May 2024 11:29:13 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] promisor-remote: add promisor.quiet configuration option
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, chriscool@tuxfamily.org, jonathantanmy@google.com
References: <20240523131926.1959245-1-tom@compton.nu>
 <20240525052946.GD1895047@coredump.intra.peff.net>
Content-Language: en-GB
From: Tom Hughes <tom@compton.nu>
In-Reply-To: <20240525052946.GD1895047@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/05/2024 06:29, Jeff King wrote:
> On Thu, May 23, 2024 at 02:19:26PM +0100, Tom Hughes wrote:
> 
>> Add a configuration optione to allow output from the promisor
>> fetching objects to be suppressed/
>>
>> This allows us to stop commands like git blame being swamped
>> with progress messages and gc notifications from the promisor
>> when used in a partial clone.
> 
> I'm not at all opposed to providing a way to suppress this, but I feel
> like in the long run, the more fundamental issue is that git-blame kicks
> off a zillion fetches as it traverses. That's not only ugly but it's
> also horribly inefficient.

This is true. One thing I found that makes things a lot more
efficient if you're using ssh as the transport is to enable
persistent multiplexing in .ssh/config with something like:

Host git.example.com
   ControlMaster auto
   ControlPath /run/user/%i/ssh/control.%C
   ControlPersist 1m
   SendEnv GIT_PROTOCOL

which avoids each fetch having to setup and authenticate a
new ssh session.

> In an ideal world we'd queue all of the blobs we need, do a single
> fetch, and then compute the blame on the result. That's probably easier
> said than done, though we have done it in other spots (e.g., for
> checkout).

That would certainly be an excellent improvement, yes.

Tom

-- 
Tom Hughes (tom@compton.nu)
http://compton.nu/

