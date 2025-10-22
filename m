Received: from send77.i.mail.ru (send77.i.mail.ru [89.221.237.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F0B312810
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 09:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.221.237.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761125412; cv=none; b=eo60dlk18zC2sgd/goHjhzzfBpnJ9ygcCTE1Y5u6K6sbZ9hJ0jpGgpxF8D0K5KGrP4F6T7B9PeF6W35uoSFw1A/vum9BCKc9+xCyWFnEiKCMM2VYRjSYdLcj4suKvkhpXcaaWZnh7NI68lUr7yFbd+Tkq8BDLZ+BVK5pPvRS01E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761125412; c=relaxed/simple;
	bh=7P4R94wghYlx4nfKS9DQKnhl44fngqWY7Dk9Rst+448=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T2CIUX7zllZPQJdJsSwNOqbbncjwgoxy2RYvUvRYv6JdnrXlhm1KqfnF6Wr2g5JiG/HSfdkaTNT8zGII9aFRUkFuyqsYm0TUk8j7LyPFVWHApdQ5guvVVuvVQURCVnMApnceUPIm8qzG4R7GAdTlzekCHdSn91kEfkfPuwEuzyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bswap.ru; spf=pass smtp.mailfrom=bswap.ru; dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b=rT77DbUM; dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b=l+r+a3kD; arc=none smtp.client-ip=89.221.237.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bswap.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bswap.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="rT77DbUM";
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="l+r+a3kD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru;
	s=mailru; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive:X-Cloud-Ids;
	bh=7P4R94wghYlx4nfKS9DQKnhl44fngqWY7Dk9Rst+448=; t=1761125409; x=1761215409; 
	b=rT77DbUMv/kienJToVe5In+kSMR/QjkZQxopge9CxOTM+ePHS95S+e2uTxVVjjeeLxB09jKZ9mm
	VHNtb8k1pjQXqE1VaTleBgsPcK2g4WN1VK959teXaQeaaFF7Xelm0WlsnPHAT1chgU37CJ8dpBA+E
	sKXcmsNtFIYZcrX+S1k=;
Received: from [10.113.185.6] (port=57622 helo=send34.i.mail.ru)
	by exim-fallback-786786785f-l8sjm with utf8esmtp (envelope-from <kostix@bswap.ru>)
	id 1vBUvp-00000000LW9-3D5B
	for git@vger.kernel.org; Wed, 22 Oct 2025 12:14:57 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru;
	s=mailru; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=7P4R94wghYlx4nfKS9DQKnhl44fngqWY7Dk9Rst+448=; t=1761124497; x=1761214497; 
	b=l+r+a3kDPh7AnvK6cRhDOANSdg3cK5mNrPhHD/mx9KHt87XoJ3tLC4NTska7l6cx+fjNkbSk8ZA
	Bpm917/QNwmVlr5mQmarM/EFgROZWBy8LmnyQPqJyRagEgQflrTuDyuI3EYu+OiB+cSIJYfqptMXy
	HgQlJ+ywuyfexwRGMaw=;
Received: by exim-smtp-d7d76ccc5-bq85s with utf8esmtpa (envelope-from <kostix@bswap.ru>)
	id 1vBUvh-0000000014C-1gSv; Wed, 22 Oct 2025 12:14:49 +0300
Date: Wed, 22 Oct 2025 12:14:48 +0300
From: Konstantin Khomoutov <kostix@bswap.ru>
To: Dennis Putnam <dap1@bellsouth.net>
Cc: git@vger.kernel.org
Subject: Re: Migrating Repository without Network
Message-ID: <yfg4ow3ndckqr6zvrbvldbynv2jgaf5ip76phusdtiwelnz4e2@5e5hct2uujo5>
Mail-Followup-To: Dennis Putnam <dap1@bellsouth.net>, git@vger.kernel.org
References: <94497aac-c61a-4b17-9e4c-8ca9b966829c.ref@bellsouth.net>
 <94497aac-c61a-4b17-9e4c-8ca9b966829c@bellsouth.net>
 <6tygbwc6ifpuo3xylsmsveufqyroazy35u4lyblnvuls3l7n3u@d4ail3s6vtoa>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6tygbwc6ifpuo3xylsmsveufqyroazy35u4lyblnvuls3l7n3u@d4ail3s6vtoa>
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD96DC212D1D15EACC4F9CD34631F54A65B867C424D8496E4E9182A05F538085040B7C76868C56FB8F63DE06ABAFEAF67059BC534E3107A5F3564B64E86B455E7E93D433D207E322D29
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7922E451CE6E839B1EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637AC83A81C8FD4AD23D82A6BABE6F325AC2E85FA5F3EDFCBAA7353EFBB553375663B3451C29F32F7024264BA483245C1568C51342FE67BCD08DAD5DF75643C7DB7389733CBF5DBD5E913377AFFFEAFD269176DF2183F8FC7C0DCF4F0DC832992758941B15DA834481FCF19DD082D7633A0EF3E4896CB9E6436389733CBF5DBD5E9D5E8D9A59859A8B6A70DDFFB3186CBC5CC7F00164DA146DA6F5DAA56C3B73B237318B6A418E8EAB8D32BA5DBAC0009BE9E8FC8737B5C22493C6898C3C2F22CEE76E601842F6C81A12EF20D2F80756B5FB606B96278B59C4276E601842F6C81A127C277FBC8AE2E8BF5CE31487DA1EA653AA81AA40904B5D99C9F4D5AE37F343AD1F44FA8B9022EA23BBE47FD9DD3FB595F5C1EE8F4F765FC2EE5AD8F952D28FBE2021AF6380DFAD18AA50765F790063735872C767BF85DA227C277FBC8AE2E8B81DF583BEE9BDE68EFF80C71ABB335746BA297DBC24807EABDAD6C7F3747799A
X-C1DE0DAB: 0D63561A33F958A59C64E104FB1BE0535002B1117B3ED6962B8E271DBD7304C5CA7E60A991436CA2823CB91A9FED034534781492E4B8EEAD003C2D46C52F18F2BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADBF74143AD284FC7177DD89D51EBB7742DC8270968E61249B1004E42C50DC4CA955A7F0CF078B5EC49A30900B95165D34F3735C80F9F4B96D29C56B81BFD3CC68693862C3B769D78AA4A993471146642986F50F5E26157C331D7E09C32AA3244CF3DAAE77FFA1C01A77DD89D51EBB77420520AB21A4F59333EA455F16B58544A2E30DDF7C44BCB90D3871D1C702CBDB0A9665A0FD7AD89E8F722DFA761B3F797A
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXMZebaIdHP2ghjoIc/363UZI6Kf1ptIMVRN2q9QiacRudJIIlqMOLD8=
X-Mailru-Sender: 641179478317D3F0421D0BEF39CFD138B1BEB8C133C0F8FFE693A2F4CD4B1000A3879232E78013B4046F975FE800A98E2F0A6AF357119A4D04176AAE5055CC72595A8557D9C981F4633CE835492D9647D182D770C8C7E642B4A721A3011E896F
X-Mras: Ok
X-Mailru-Src: fallback
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B472A7E348C1D2C180B9498435790190EF1E56B3064448B8B5049FFFDB7839CE9E4424884F11F28FC7F731063707CD16F650BD6C1622FA2E402D78C0B43D96B479EB419727A61A4325
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+OYcBso8Zm+oliTz8oZwnDrFsY77LZRcHyw5ht0smWrfSeTW5FiI8avd9v29gUBslpEZ9wIMwqVP4jLQVQ+dVm7x9BpDHadBV9RMjI809PraZKarWkPl9QxrYN6pD1ROGdg==
X-Mailru-MI: 20000000000000800
X-Mras: Ok

On Wed, Oct 22, 2025 at 12:04:15PM +0300, Konstantin Khomoutov wrote:

[...]
> In either case, it will be possible to fetch all the data from the repo
> saved on the flash drive: it might be not exactly obvious but all Git
> commands which fetch data - such as "clone", "fetch" etc - do understand
> "plain" pathnames such as /the/path/to/the/repo and URLs with the special
> scheme "file://" - such as file:///the/path/to/the/repo, allowing them to
> work with on-disk repos available locally such as on a mounted flash drive.

...it should be noted, though, that "normal" and "bare" repository have
different schemes of storing branches available in them, and it might affect
the approach you will need to employ to fetch really *all* the data to form a
new repo.

It's hardly possible to dive further in this topic because we have next to
zero knowledge about your setup - including whether that repo is bare and is
accessed from the outside, or normal and merely shared between the users
physically logged into the server and so on. I mean, it may so happen that all
you will need to do is to copy the repo to a flash drive and then copy it
again to the new server, possibly fix filesystem permissions on it so that
they match the ones the old repo has, and call it a day. In case you will need
more advanced help, you'll need to provide more details on your situation.

