Received: from steward.aerusso.net (steward.aerusso.net [208.87.133.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBFF2868BA
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 13:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.87.133.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755006461; cv=none; b=nRdX6P+mTB99hfTXEyQO8tnL/9/2DXyyQDE4sRPSSBQMJwu1Sosy0waXF/aWEWTK9IV7hwajznHWKXVg+IlyzEhvauTKgEeKfWMnAXxec0/Azmb0esPIwlzBSmS2SGGVQXwzYWlUggrcUHJQS8Ad3QBR5LEkvY5LGJtOAaKvBVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755006461; c=relaxed/simple;
	bh=JTHK4bAg1TR+3ysShitUpmpqkeEyTO9+rLpWNYZDV3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EKbfg4uDIvgQbJEe+4SO4wMJbanmQ7sZ+QmUpQHaKHR/119HcJEgME+z9KG6+mqm0w4jXsOLmCbsuP/raHmR6zyr7fRoL17byDjKPHx6uguNeYBxtzk4XTTtfq7s2wpsZrXXYaoTR0vlobr8leoZr8yO1hVu1ssdb9U00ti5nxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aerusso.net; spf=pass smtp.mailfrom=aerusso.net; dkim=pass (2048-bit key) header.d=aerusso.net header.i=@aerusso.net header.b=r1S1wyFS; arc=none smtp.client-ip=208.87.133.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aerusso.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aerusso.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aerusso.net header.i=@aerusso.net header.b="r1S1wyFS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aerusso.net; s=default;
	t=1755006057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mJ+r6JGq7mrUha46fMYAMeDydKDpTx1Ok0iOZ+rmgow=;
	b=r1S1wyFS6g2hHVsm+R8ClfFM7GHP46/hKVme7DaHE6TfMEZEmEBQ9hOX9qVuPrz5z9+c3G
	ib3MiHgKQH7TEyg3me+v7MnuLfCoyNFZSXTMleSI8HoykJS0g36BGYeMnRTRXvpFAwQuZB
	LY5lCLXrfvTq9lMu2IPAKZTTLxc+FmeOejUy8EteT/xViBPHuIrF8R0dk3X8WCFgHzk1LM
	PX9U+1B8JtzQ7msOqTMWSwnX8GccxPNrOGgVkYf3Sl2x2Jsat3Y4XHwD0sYvwO++l3tm1b
	WQYVD4zqakVqL5AFcjbrOKtfJHPvygymh7CyT8mIpWsmaKvnUHtCIX8l3PPt9w==
Message-ID: <b6179ded-abbf-4c9a-95c4-903451f7bc71@aerusso.net>
Date: Tue, 12 Aug 2025 07:40:55 -0600
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Git synthetic worktree
To: jimmy@thrasibule.mx, git@vger.kernel.org
References: <CAMqSRmCj-wcra=HE1=kv1LQU3UxhBg6zfbtO_OhWwJEqdf8gmw@mail.gmail.com>
Content-Language: en-US
From: Antonio Russo <aerusso@aerusso.net>
Autocrypt: addr=aerusso@aerusso.net; keydata=
 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
 83d/owu8
In-Reply-To: <CAMqSRmCj-wcra=HE1=kv1LQU3UxhBg6zfbtO_OhWwJEqdf8gmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-08-12 01:56, Jimmy Thrasibule wrote:
> Hi,
> 
> I'd like to create a single worktree where files from multiple Git
> repositories (or refs) coexist side-by-side (no subfolder separation),
> but each with repository still independently tracked by Git.

I've accomplished something similar to this with a gitignore-everything
policy and sparse checkout (non-cone mode, very important!).

It's janky: I use GIT_DIR and GIT_WORK_TREE to force the selection of
which git repository, and I have to use 'git add -f' everywhere.

If you need something that works today, this may be a workaround.  It
does not allow for your "default override" based on layer priority,
instead it is very file-by-file specific.

As an aside, what you are describing sounds somewhat like a use-case
for ostree, which I know very little about.

Best,
Antonio
