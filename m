Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED113D1A97
	for <git@vger.kernel.org>; Fri, 29 May 2026 16:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780071788; cv=none; b=Tzw5EPge/5hJUdoMB5hBJcVEqIlXunLVqH72tfVlSbXwT8VaHPDzebKQPll9WPxlK2vgUZEqLWSUfxmPv1oUxGKowFRByoO932Apg31jhggRA9ko7rvXgFxwxlOYZkvMUWaSf1FcHqdTxzFW9Ic801WKGenFl8y+TWOjHCQhMJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780071788; c=relaxed/simple;
	bh=obrdRzXBM5v5ly8rE3U22VNMVhvZQU4L00/7vUWwy1M=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:Cc:
	 In-Reply-To:Content-Type; b=erL0o2/ob1iu9L/U3WnZCrnFQvTHx5APf2cqaLbKeigN7llRNR1fBS4OTE4TxQeQfs3jrsc25QKO7J408aJhooSMCOJaI8TCP37S9O9AVLhEFoGT30tv/cfEA5f6mJSXWhe//fIYWIPLmpnK1I3YA4gF/ucR2vMWZNNNXHx3syg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=opperschaap.net; spf=pass smtp.mailfrom=opperschaap.net; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=opperschaap.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opperschaap.net
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gRpYc3m8qz9tp5;
	Fri, 29 May 2026 18:23:00 +0200 (CEST)
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of wesleys@opperschaap.net designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=wesleys@opperschaap.net
Message-ID: <cdf6b0b1-9211-4b8e-a81c-7d5f2888cd34@opperschaap.net>
Date: Fri, 29 May 2026 12:22:57 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: git hook question
From: Wesley <wesleys@opperschaap.net>
To: Jeff King <peff@peff.net>
References: <cc9fda14-d8e8-4982-9a3d-9aa816c0b90c@opperschaap.net>
 <20260529052141.GA1099450@coredump.intra.peff.net>
 <c5527d8c-9147-4355-a07d-153d3977108e@opperschaap.net>
Content-Language: en-US
Cc: Git maillinglist <git@vger.kernel.org>
In-Reply-To: <c5527d8c-9147-4355-a07d-153d3977108e@opperschaap.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4gRpYc3m8qz9tp5

On 5/29/26 12:11, Wesley Schwengle wrote:

>> Git will paste together the shell command:
>>
>>    npm run test # "$@"
> 
> That doesn't work on my side:
> 
> $ cat ~/.config/git/js.config && git config --get hook.npm-test.command 
> && GIT_TRACE=1 git poh
> [hook "npm-test"]
>    event = pre-push
>    command = npm run test #
>    enabled = true
> npm run test

It does work with:
`command = npm run test "#"'

Small oversight.

Cheers,
Wesley

-- 
Wesley

Why not both?

