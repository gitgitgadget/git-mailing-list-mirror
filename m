Received: from mail.luna.gl (mail.luna.gl [141.147.12.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1CB3FCB0B
	for <git@vger.kernel.org>; Fri, 29 May 2026 14:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.147.12.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780066368; cv=none; b=fUB0dHBOPLfOHHAuz/hutmfdjzG5P8cbwENkIFFK1Ww8IUBz9V9S+x8ejOYMa7wbd5gaj4bO8O51ihOnRGDtEAFp49QWP/IMDT4dZknzToReR0z8JBQNpz6MC61m/CIbDMw2JHebtFNpBm26gr1IAJWrs0dO/Esf456D+eQRGuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780066368; c=relaxed/simple;
	bh=UEpqX+rnIT8WwW59+rlP67iXp522dupqnsXlqWwjoEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fxYIvvw1GMx+9PDf3vYkyHJD+jIuBs4/9kfsjgBUzeG/4x2vlLdNRNQEtJU3K+mDCo8sc2tCq9EHPYrg7xYBrF84NpIplfwFX1hOY3uQ5vuomNVt/1x5sqTdAh/YxjPTB+uot6mrOTYY/xAjcCYwLuczxjkLqmTBVgM1PM9z38c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=luna.gl; spf=pass smtp.mailfrom=luna.gl; dkim=pass (2048-bit key) header.d=luna.gl header.i=@luna.gl header.b=UKl9CqD1; dkim=permerror (0-bit key) header.d=luna.gl header.i=@luna.gl header.b=3qk+MMbP; arc=none smtp.client-ip=141.147.12.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=luna.gl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luna.gl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=luna.gl header.i=@luna.gl header.b="UKl9CqD1";
	dkim=permerror (0-bit key) header.d=luna.gl header.i=@luna.gl header.b="3qk+MMbP"
DKIM-Signature: v=1; a=rsa-sha256; s=202405r; d=luna.gl; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1780066359; bh=pFGXiu6pEDQubsZVI4dF/yQ
	Yjhyp9NWwBWw2deFQXac=; b=UKl9CqD1828St3Z77AK6r2/n4/EsgFWkmz14KHYRwDdF7Y4TM8
	STDMpiXld6IRoPC1WILWOJwFJ9mUsOfHlczpcj33kbi9Jb6hB5ozuRc7NOkuSHhacHhNaiY6tKg
	mXyhL2mTbyj0Ii342YltVMxUbPWlUcAFYcUtZ0REN5XShfiNC7FjNvt+Zt8xNCVZfT9dhcK6E5S
	xLmlEjj8Um4DvobbVk4NHm1GMkqepbxLx23sIzG6xF4mua06dIkwahStUyK9ODy69rVAIYotBUf
	1aFNqxkLSovFxEN6gc/o4or4j/Xsm/6eMWD+t337/NgL7VGrrtu7VJMG8ywYCmmgFNA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202405e; d=luna.gl; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1780066359; bh=pFGXiu6pEDQubsZVI4dF/yQ
	Yjhyp9NWwBWw2deFQXac=; b=3qk+MMbPFo3PzQya0N+BWr92De26QQJMwNnALUOabgo3vi0VyJ
	VTMem0ax04naxiaer3c7OO5XYo3Nmtq5r0CA==;
Message-ID: <08a04d91-af90-44dd-b28f-f3d5b9e77413@luna.gl>
Date: Fri, 29 May 2026 16:52:38 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] internal date format does not accept small unix timestamps
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org
References: <fffe0ea9-baea-47cc-b354-5be4fff08983@luna.gl>
 <a8e51dda-7b1d-426e-9af9-cf856c42342d@app.fastmail.com>
Content-Language: en-US
From: Luna Schwalbe <dev@luna.gl>
In-Reply-To: <a8e51dda-7b1d-426e-9af9-cf856c42342d@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

 > Apparently you need `@` in front for small Unix Epoch values. `@0 +0000`

That is wonderful, thank you so much, I somehow did not find this small 
detail anywhere.

Maybe it could be added to Documentation/date-formats.adoc?

Luna
