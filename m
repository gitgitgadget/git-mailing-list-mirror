Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCB215383A
	for <git@vger.kernel.org>; Sun, 18 Aug 2024 17:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724002253; cv=none; b=pWL2LQ2uyFhzFM6B2cjUA7jMscNeg0e1YqflkrHxNr1MrtuhAleB4dINlZr/D7Huuaeb/ykVOmvsN8yjZpsiYcTIWEsTTHCXfMP9yqoHqtAbrTY0/QilWmGrpfq09Yw53gx9nM2Rr7WEW53NkMIiBRtiGHZbW3Mw9PCq2HrwZMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724002253; c=relaxed/simple;
	bh=IcNp7aX0VAO3dV8Xl/cxOJZymxuxE8cBoEd8UZMArvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AOdTi3mHj2UWrQZnsJKPgtDcBwgV1W6bYApHZA0WkrDt1zC67bMDM4LSvn7p9hM4P0KFQa0J0powBjrc37qrqL7jpZrGPusEKo9GHYuUut/ZV2jNlC0ScpNA7Rn6X2fiEvb6eOJvoijsL5+2blDDoPkAu+9M3NR33X0bbMXBPhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land; spf=pass smtp.mailfrom=howdoi.land; dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b=rA1RNtUH; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=howdoi.land
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b="rA1RNtUH"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <ask+git@howdoi.land>)
	id 1sfjjl-009faQ-ED; Sun, 18 Aug 2024 19:30:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=howdoi.land
	; s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:To:Subject:MIME-Version:Date:Message-ID;
	bh=dfbqLNa2ERuX0vRDne6Nme1pzV7J86wyGmMcTnxUvC4=; b=rA1RNtUHrN25W91p+X3wLN+s2z
	eQVx9TbJ6jdN/a/CdHerqXzqLR8++Xc5qUfRvm5HWgumjTuaso9Rpb9Pvg/NUG3JVH8YC39ttjULZ
	Q29vndZwP2jjisevYgG0iaYwfQ8PEk1RJiRSNBSjN4Fzt+8aR2SCVtDuQanbFGVm/40BG6g7KFmI5
	268sHCc5C5I2xo/bFLxGQ/O9L10lKetph62JdyPylrP8SHraxdUYyqCkuG5YGKb64yccYNRqCdwTS
	VLSPZ4le1/O30hXIXZH9hD92xx5pPJ6EFbsYWXG0PJuUynjin4m7e6ILe8yEFCz52ausSTlP+Hs01
	dsd+bDuA==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <ask+git@howdoi.land>)
	id 1sfjjk-0000ax-TP; Sun, 18 Aug 2024 19:30:41 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1204229)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1sfjji-00C1ZQ-6s; Sun, 18 Aug 2024 19:30:38 +0200
Message-ID: <fe20f819-5b8e-4cca-a094-24e5d4333aa6@howdoi.land>
Date: Sun, 18 Aug 2024 12:30:35 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression bug with latest SAFE ownership patch
To: James <purpleidea@gmail.com>, git@vger.kernel.org
References: <CADCaTgpcmMbLoKR-rWf_roWfbgWJL6HuURDxwovvKQA8syf=vw@mail.gmail.com>
Content-Language: en-US
From: Colin Stagner <ask+git@howdoi.land>
In-Reply-To: <CADCaTgpcmMbLoKR-rWf_roWfbgWJL6HuURDxwovvKQA8syf=vw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/16/24 22:15, James wrote:
> I have a git repo which is on a shared server that I trust and control. Adding a safe.directory does _not_ allow me to use this repo anymore.

> james@computer1:~/whatever$ git remote show server2

> [remote "server2"]
>      url = ssh://root@server2:/home/someoneelse/whatever/
>      fetch = +refs/heads/*:refs/remotes/server2/*

I believe that safe.directory only affects repositories hosted on the 
local filesystem—and not on SSH or HTTP(S) remotes.

I would discourage cloning a user repository with the root user, or 
running git as root if you can at all avoid it.

Since you already have root access on this system, how difficult would 
it be to add your SSH key as an authorized_key for someoneelse? Then you 
could use ssh://someoneelse@server2:/home/someoneelse/whatever/.git as 
your remote.

You could also share repositories via a simple gatekeeper or forge, like 
gitolite.

Colin

