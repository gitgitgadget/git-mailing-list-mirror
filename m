Received: from fallback2.i.mail.ru (fallback2.i.mail.ru [79.137.243.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A6C80027
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 16:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720455888; cv=none; b=firr4M0KH8lnI6OvDveiJqsnHKb+BezVGUysZ/h8VRDGI2MrFPnnK1gqjCU62KyuwjTHwtutzzklSdlaFUgUDFxBsmujGXRoibm5v1iGSDb+iqtP+rSOl6QO/uv2B/52DrEkKtwfa/y6LFxWSp4xNfQxcXtgeRbKF2JdoNM3o4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720455888; c=relaxed/simple;
	bh=ttTsZZL6NyY//KqX8c/ELLQo/woiHTn3+xHEZdaKySQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p+ziMJmakps13rABHfHEcXxurPT3fqtY4pQ+KLvhnrw24uCJnuyrlu+JQse+LYlClgvYbFFc8BcQGs9sUxXHsczBqUdwVlNbuXOWtNUEmbKgZXmSvPs0Quq7+aLF/jE8hoi2DWJChWxW+NODGxO8+7cNBzM2wHfvmpg3LsBXfgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bswap.ru; spf=pass smtp.mailfrom=bswap.ru; dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b=nCliylCw; dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b=I2c76ruo; arc=none smtp.client-ip=79.137.243.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bswap.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bswap.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="nCliylCw";
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="I2c76ruo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=UYJbkKtvfOMUajethEtMY8JxwVJSB6WL61K0VuOiYrQ=;
	t=1720455883;x=1720545883; 
	b=nCliylCw2sk4IRVK/9MoPBo6pjEWSULGVx/HGuLGG8zuCl7ZgDancggoYZm1MaACyFyokvbFAn55lX/54eONWFHhb7hCeHFT4KQKwF5IRhk20CTfKISQHnJQWJGtQnVHvrmA4LPMuFDupvPHdgQ61YIXLG05uP9wM4wDfB7mSr4=;
Received: from [10.12.4.23] (port=33688 helo=smtp49.i.mail.ru)
	by fallback2.i.mail.ru with esmtp (envelope-from <kostix@bswap.ru>)
	id 1sQqYA-00GqOe-M2
	for git@vger.kernel.org; Mon, 08 Jul 2024 18:45:11 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru;
	s=mailru; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=UYJbkKtvfOMUajethEtMY8JxwVJSB6WL61K0VuOiYrQ=; t=1720453510; x=1720543510; 
	b=I2c76ruo5/xBQkS+RsnxZAWYFj9x5L7Zp8I1hRsoMabYSVajCVn+Jkw9Gh5/bixKMwKMSKq/QiM
	srO294Z/B2FIpF0p/LCuPSg6NZnGKXWQp7STpU+aOVGYkg78LA8HfnL5RmBytiV1G4BNWwykqaqZP
	sTpo8hx5Vqqx0dYUB5k=;
Received: by exim-smtp-6ccc45cc7c-stttf with esmtpa (envelope-from <kostix@bswap.ru>)
	id 1sQqXx-00000000KQU-3WlC; Mon, 08 Jul 2024 18:44:58 +0300
Date: Mon, 8 Jul 2024 18:44:57 +0300
From: Konstantin Khomoutov <kostix@bswap.ru>
To: ellie <el@horse64.org>
Cc: rsbecker@nexbridge.com, git@vger.kernel.org
Subject: Re: With big repos and slower connections, git clone can be hard to
 work with
Message-ID: <20240708154457.jpt2aa5orzxy6kqh@carbon>
Mail-Followup-To: ellie <el@horse64.org>, rsbecker@nexbridge.com,
	git@vger.kernel.org
References: <20240708143239.vq47dg7mgh33hykf@carbon>
 <2e10070f-2720-4d70-aa15-d4c008cc57bf@horse64.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e10070f-2720-4d70-aa15-d4c008cc57bf@horse64.org>
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD91AFB032D31068B0BF5197D7FA2DDF2C528FE831051E13707CD62213F67905E7A85DFFE3EF12E3BA2467E0AF6781A1FAE18163C91075B2C772DC6BBA2608E75A1660823B2EEFD31DC
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE71BDE6A359BD5B800EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637FF37B1FF54E2C7C48638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D84E605563A24D9BF04BBC948534253DDF897703288BAD9C52CC7F00164DA146DAFE8445B8C89999728AA50765F7900637CAEE156C82D3D7D9389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC81D471462564A2E19F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947C67F1C1C3ABB44F3AAD7EC71F1DB884274AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C3FA79E84ED94DD554BA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CF3D321E7403792E342EB15956EA79C166A417C69337E82CC275ECD9A6C639B01B78DA827A17800CE7BB1D8AFE8C29F51C731C566533BA786AA5CC5B56E945C8DA
X-C1DE0DAB: 0D63561A33F958A5F5F3DBF04F8670B75002B1117B3ED696C89BE0F4F74EF25E30C8F815570A3530823CB91A9FED034534781492E4B8EEAD5DF1C2DF01CE7211BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADBF74143AD284FC7177DD89D51EBB7742424CF958EAFF5D571004E42C50DC4CA955A7F0CF078B5EC49A30900B95165D340CB2836B82369449AA2E220778BE8753AE47075DDAFB0D17868B79840CF587FEAA4015BFDFC6DA9C1D7E09C32AA3244CC7E84B00B244EA5E77DD89D51EBB77423DBF3CC02F61D6ADEA455F16B58544A2557BDE0DD54B35903871D1C702CBDB0A9665A0FD7AD89E8F722DFA761B3F797A
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojmLqsEm9OWA7CSJeY+ZImFw==
X-Mailru-Sender: 641179478317D3F0421D0BEF39CFD138089DEF6AAE07DCD6BC5A20191D90C84F6A6CEE3ED3A7016006A01E13019A1B252F0A6AF357119A4D04176AAE5055CC72595A8557D9C981F4633CE835492D9647D182D770C8C7E642B4A721A3011E896F
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B49EE4DAAFE034007AC2C4F99DC9EFCB53AB8B427C0B4092C3049FFFDB7839CE9E0089B5866B8777F8200F60132F1FF3CC74A86503AAF015093350903AC6BF4C88
X-7FA49CB5: 0D63561A33F958A53EB16FF2BD7CA8858F01BF39ABBE28F48F7A5CB9C1AC98588941B15DA834481FA18204E546F3947CDB8A315C1FF4794D117882F4460429724CE54428C33FAD30A8DF7F3B2552694AC26CFBAC0749D213D2E47CDBA5A9658378DA827A17800CE7ECC8AC47CD0EDEFF8941B15DA834481F9449624AB7ADAF3735872C767BF85DA227C277FBC8AE2E8BE355FB2A6EFF69C575ECD9A6C639B01B4E70A05D1297E1BBCB5012B2E24CD356
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojmLqsEm9OWA6pFy7RbjAkKw==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

On Mon, Jul 08, 2024 at 05:14:33PM +0200, ellie wrote:

[...]
> > > error: RPC failed; curl 92 HTTP/2 stream 5 was not closed cleanly: CANCEL
> > > (err 8)
> > [...]
> > > It seems extremely unlikely to me to be possibly an ISP issue, for which I
> > > already listed the reasons. An additional one is HTTPS downloads from github
> > > outside of git, e.g. from zip archives, for way larger files work fine as
> > > well.
> > [...]
> > What if you explicitly disable HTTP/2 when cloning?
[...]
> Thanks for the idea! I tested it:
> 
> $  git -c http.version=HTTP/1.1 clone https://github.com/maliit/keyboard

Over there at SO people are trying all sorts of black magic to combat a
problem which manifests itself in a way very similar to yours [1]. I'm not
sure anything from there could be of help but maybe worth trying anyway as you
can override any (or almost any) Git's configuration setting using that "-c"
command-line option, so basically test round-trips should not be painstakingly
long.

[...]
> fetch-pack: unexpected disconnect while reading sideband packet
[...]
> Sadly, it seems like the error is only slightly different.

I actually find it interesting that in each case a sideband packet is
mentioned. But quite possibly it's a red herring anyway.

 1. https://stackoverflow.com/questions/66366582

