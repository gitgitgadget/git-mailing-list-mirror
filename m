Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF2CC8CA
	for <git@vger.kernel.org>; Mon,  1 Jan 2024 15:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kircheis.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kircheis.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kircheis.it header.i=@kircheis.it header.b="AWdJ8PC+"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4T3gNr4DQXz9sX0
	for <git@vger.kernel.org>; Mon,  1 Jan 2024 16:47:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kircheis.it; s=MBO0001;
	t=1704124076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qlgY4uvB6AXQeLPoP78rW0u5IRec2Cw+FnHNi/yI/ko=;
	b=AWdJ8PC+ho9ikFYLgwSAfa4IHodME9aFZCL8GZrGc9soyNf4jy8qqku9h7GJFPRqQLLrIc
	RcKVILeMJwugEVzWoQY+bCT0dDIIj9LKqVTvdLHkSUn+dPnRVHKdMKaggF5ZwQgzmmqyR8
	9/YVRqYaCoWPHEkSY2A8Pw+OS/8+H3kO8aoJnmIDJb0yv7N8gjDa9h211wMwnNlHxwHxoP
	GACKV28nWZfDXfm7fJauuBED23p+9ITDQf0ZB5O8ErsD3+dJRgz4aLldeJtJwYauOo4rOY
	sVkBBwMPwgBx0/tyApuEHDruaNLHapH8+8Bgk6Bdxzj7AC1uaxA37sTpM64S6Q==
Message-ID: <4525f59f-d4d1-405a-89d0-fa51f1f8f877@kircheis.it>
Date: Mon, 1 Jan 2024 16:47:55 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Concurrent fetch commands
References: <c11ca0b3-aaf4-4a8d-80a1-3832954aa7aa@haller-berlin.de>
 <20231231165042.1d934927@RedEyes>
 <55620f4f-80f9-4e9a-8947-dce5d2a5113d@haller-berlin.de>
From: Federico Kircheis <federico@kircheis.it>
To: git@vger.kernel.org
In-Reply-To: <55620f4f-80f9-4e9a-8947-dce5d2a5113d@haller-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4T3gNr4DQXz9sX0

On 01/01/2024 12.23, Stefan Haller wrote:
> On 31.12.23 14:50, Konstantin Tokarev wrote:
>> В Sun, 31 Dec 2023 14:30:05 +0100
>> Stefan Haller <lists@haller-berlin.de> пишет:
>>
>>> ... it is common for git clients to run git fetch
>>> periodically in the background.
>>
>> I think it's a really weird idea which makes a disservice both to human
>> git users and git servers. IMO clients doing this should be fixed to
>> avoid such behavior, at least by default.
> 
> I disagree pretty strongly. Users expect this, and I do find it very
> convenient myself.
> 

Especially when working with git worktree.
