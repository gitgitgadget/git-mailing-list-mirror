Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B958A5665
	for <git@vger.kernel.org>; Sun, 31 Dec 2023 14:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="oevybaaB"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1704031299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RMjxwUP6cBVaRQwA0dWf1XhHw9UkIgzP2rdx4jhBQA0=;
	b=oevybaaBp/Vgtgx4y4qNwMYmnNukYFV/0pmSUcJZz53IhrpIJTbNwtJThFBnTZer6fh7ny
	7/AOgWZt2AqP/PoksaQJjJyRsIrXhmF1Ex6VQAACAC9ohX2tppteegiZCg1MDw9j9dqpJ7
	Zrvfwd2NKmFoe0ySp3boqyGssGTAZvV18oeCla5CqQLoF/YJ3EYzOFfa3RmQ3BIUZRCQ4r
	6Yitj2UezHqVpunuSrLlN7Atfst2qmkDilQKQHRRfrdhi6HURlV29xG39gxopg90PQQWUX
	I30CCfqbzPdmLCIRsFJqFci4fDOBUEautMe9G95LE0w0iWI5P7kJXavLZXXfFg==
Date: Sun, 31 Dec 2023 15:01:39 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Konstantin Tokarev <annulen@yandex.ru>
Cc: Stefan Haller <lists@haller-berlin.de>, git@vger.kernel.org
Subject: Re: Concurrent fetch commands
In-Reply-To: <20231231165042.1d934927@RedEyes>
References: <c11ca0b3-aaf4-4a8d-80a1-3832954aa7aa@haller-berlin.de>
 <20231231165042.1d934927@RedEyes>
Message-ID: <867b0189119ebb9eb5ac64426aef558b@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2023-12-31 14:50, Konstantin Tokarev wrote:
> В Sun, 31 Dec 2023 14:30:05 +0100
> Stefan Haller <lists@haller-berlin.de> пишет:
> 
>> Currently, git doesn't seem to be very good at handling two concurrent
>> invocations of git fetch (or git fetch and git pull). This is a
>> problem because it is common for git clients to run git fetch
>> periodically in the background.
> 
> I think it's a really weird idea which makes a disservice both to human
> git users and git servers. IMO clients doing this should be fixed to
> avoid such behavior, at least by default.

Could you, please, elaborate a bit on the resulting disservice?  
Regarding fixing the clients, IDE users often expect such automatic 
updating to be performed in the background, so I'm afraid there's not 
much wiggle room there.
