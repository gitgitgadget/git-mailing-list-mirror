Received: from dd36226.kasserver.com (dd36226.kasserver.com [85.13.153.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B489A15EBC
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 13:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=haller-berlin.de header.i=@haller-berlin.de header.b="duv+Q5bT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=haller-berlin.de;
	s=kas202308231025; t=1704979732;
	bh=axdrwLDXT4PqdsTZ+FLOIxfj4AwZ04V963QLD9VCb48=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=duv+Q5bTGQo520ZX9DFzkM/VDqnhsC4bc8MIMP9q5zgSyxY8FzWZS9w/SGDlqTvbs
	 ssBOrKxUU9XOSvHl/xLA2dGrsXbXjscwjNMDHvHLlhX1Wi0PgKVbOaGqWRcBb5aOMB
	 xQj/IRV3ColFVVVWvPkOFfr9AqIRsBmew4sj1D02tCEhbBaYxCHKRvq56aX68hDptU
	 LG4VlkCpvBawj1pf72wLcxcLCEuj61k0qMu3lLwUWHliy60HDaGWVvIJgQOtc2+f9R
	 0hIupYSMHonHrynxN9jKssWWBblFe+2zNFUZ8AADvNffLyTmKQ+eWDNMHhsaVVQRKq
	 RjbcXxYX+20ug==
Received: from [192.168.42.22] (6-48-142-46.pool.kielnet.net [46.142.48.6])
	by dd36226.kasserver.com (Postfix) with ESMTPSA id 64E323C0448;
	Thu, 11 Jan 2024 14:28:52 +0100 (CET)
Message-ID: <c8ad96bc-0180-42f4-b559-20b475098eca@haller-berlin.de>
Date: Thu, 11 Jan 2024 14:28:51 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Storing private config files in .git directory?
Content-Language: de-DE, en-US
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <8e344dee-f84e-4a2c-835a-406ee72d129b@haller-berlin.de>
 <xmqq34v7lmb3.fsf@gitster.g> <20240110110842.GD16674@coredump.intra.peff.net>
From: Stefan Haller <lists@haller-berlin.de>
In-Reply-To: <20240110110842.GD16674@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: /

On 10.01.24 12:08, Jeff King wrote:
> On Mon, Jan 08, 2024 at 10:20:00AM -0800, Junio C Hamano wrote:
> 
>> An obvious alternative is to have .lazygit directory next to .git directory
>> which would give you a bigger separation, which can cut both ways.
> 
> Just to spell out one of those ways: unlike ".git", we will happily
> check out ".lazygit" from an untrusted remote repository. That may be a
> feature if you want to be able to share project-specific config, or it
> might be a terrible security vulnerability if lazygit config files can
> trigger arbitrary code execution.

Unless you don't version it and add it to .gitignore instead, which (I
suppose) is what most people do with their .vscode/settings.json, for
example.

-Stefan
