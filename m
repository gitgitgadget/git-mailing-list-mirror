Received: from avasout-ptp-001.plus.net (avasout-ptp-001.plus.net [84.93.230.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F941494D4
	for <git@vger.kernel.org>; Sun, 20 Oct 2024 16:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729441316; cv=none; b=sQcfvG8/QYNJfjqd9DxL+2IggDr/mXYrdHXfLpXlr6sAg9MU87Kng33pACOsiH+pjpbucEGdml3Y1137zwTvUPoCmh8j++SQ0sMkdQ0C/Ur8Wm/PFxAflpT9mBHbJwR5ZzuCQWNK0t5DguqkHJOh2C5Ts5w5DQBx2mir3rkU+6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729441316; c=relaxed/simple;
	bh=K8YFpFPwesgK9uBu5XIMdjapdZ2P0FlFJIQxBPSmxVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h2zyy9VNnv7p5Fi6bKoHVL9YDGrEd1AtFLYNGrvnhzm+goz0xdX1gccOgwEh5zRUYM3JLT9UjsRkazeZXRd9KNR5YzftlYGYym4mv1Mwx+3VtaYX+wDwu2O66tKBL4QbyIRwEklORZUCPPPmjIPs8HtW2IJjn8PQWnNrjlF5q4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=BtBPaPWA; arc=none smtp.client-ip=84.93.230.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="BtBPaPWA"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id 2YgctChIky9pX2Ygdto0LZ; Sun, 20 Oct 2024 17:21:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1729441310; bh=QLc3vRs/lTONO/8T/iJ06nN+x94+/q7wLkSBNWIY+/A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=BtBPaPWAE4j+hJYFXUX91ijeIa+nfARW5crgFzcmq9agl1goEdJR9jlJeYXd2YDBv
	 TvrQ1lVdokCULH9LC90TtEh9Vdnl0BxPUnVxv0wgHMVGAlEJbPxOSjQhT1F/MgYtBt
	 g3Wm7mwJRUDv2fJHrEEsLaUgN8MXTSr2+PywDZPIbkIwEb/2t2G6QGD4wiLbPUim39
	 U3qw+HJxfCOpZva8vVNtHIfOikEWUsoanYST49ENH80gI8F2Od90+Qs4ZRii/s+3FV
	 tc2GRyy0hTYaEPgEG/4RHiIgRL+sENfrYzYL3ZzRQ2djF8BTshwMJzH7XC8798LI1a
	 Xx0eqxuBs3H+A==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=JYgfrlKV c=1 sm=1 tr=0 ts=67152e1e
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=5UPbssxmIogluvDTz-oA:9
 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <086ff955-bcdf-4aba-b6d4-c87f6fc6a724@ramsayjones.plus.com>
Date: Sun, 20 Oct 2024 17:21:46 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] config: support remote name in includeIf.hasconfig
 condition
To: Ken Matsui <ken@kmatsui.me>, git@vger.kernel.org
Cc: Matheus Tavares <matheus.tavb@gmail.com>, Glen Choo <glencbz@gmail.com>,
 Elijah Newren <newren@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
 =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
 Victoria Dye <vdye@github.com>, Patrick Steinhardt <ps@pks.im>,
 Junio C Hamano <gitster@pobox.com>
References: <20241020152323.90543-1-ken@kmatsui.me>
 <20241020160143.92382-2-ken@kmatsui.me>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <20241020160143.92382-2-ken@kmatsui.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfFPO4+edw3LBy8T6lrVnVbofi8qHa+IiLQ0HKtLKLsW4v2z32HuA/jQZRI1sP3F1babkktTbirdc7VfIH0jZDnIUK9/0jPr8yKvItLv9hLngtJEHuW+V
 fM2BzZ+P/eP0f+Sp+kkZITRe3hzO+TPhbZTh7AT/RSPmEdrwqeMuBVnlx3Ngi5DXfgrou+RRUj0EarCP1kC7dym/HYxOxKcq70k=



On 20/10/2024 17:01, Ken Matsui wrote:
> Changes in v2:
> 
> * Updated the description based on Kristoffer's review.
> 
> -- >8 --
> 
> includeIf.hasconfig only accepts remote.*.url, making it difficult to
> apply configuration based on a specific remote, especially in projects
> with multiple remotes (e.g., GitHub and non-GitHub hosting).  This often
> leads to undesired application of multiple config files.
> 
> For example, the following configuration:
> 
>   [remote "origin"]
>     url = https://git.kernel.org/pub/scm/git/git.git
>   [remote "github"]
>     url = https://github.com/myfork/git.git
> 
>   [includeIf "hasconfig:remote.*.url:https://github.com/**"]
>     path = github.inc
>   [includeIf "hasconfig:remote.*.url:https://git.kernel.org/**"]
>     path = git.inc
> 
> would apply both github.inc and git.inc, even when only one config is
> intended for the repository.
> 
> Introduce support for specifying a remote name (e.g., origin) to enable
> more precise configuration management:
> 
>   [includeIf "hasconfig:remote.origin.url:https://github.com/**"]

s/remote.origin.url/remote.github.url/ ?

I haven't actually read the patch, so take with a pinch of salt. :)

>     path = github.inc
>   [includeIf "hasconfig:remote.origin.url:https://git.kernel.org/**"]
>     path = git.inc
> 
> This ensures that only the intended config file is applied based on the
> specific remote.
> 

ATB,
Ramsay Jones

