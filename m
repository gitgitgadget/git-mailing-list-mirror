Received: from fallback2.i.mail.ru (fallback2.i.mail.ru [79.137.243.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414A8199939
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 14:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738246346; cv=none; b=rFEND7OUGmnU6e6irlRhk8hc8H3R1pC937ZvaRduoRpEpXwDWVuAqGePAnlPhovVuuJyO2VndE1xx777tnVegroC/pkJjvZWEF2F5Q794Bg2DFm+GkAXw5emKbXbZPSSpnkkapvfxAINgnfJ2CrGaLO1W520nV2hIuwH2JahzPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738246346; c=relaxed/simple;
	bh=tuzMkYcQ/NQwWrZ0MQ+myv5RXf6BYnbVbzwKsqXj1Gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ucf+piFP/2tKn5uJjuZiHuUd3Oc4TElx2A33ob0W7CTSMxvxcYJwfcr/eah+iovB9vwi1dcPmw6OMDAWM4b9cKCBy7Hgzn4JVpIqOIfyCrGLMR8Y/4xub9BOsLtfxOzL4J6okymP6o3Zc4iXuqQSweTB2xguaN3pMpzkiNoAwyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bswap.ru; spf=pass smtp.mailfrom=bswap.ru; dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b=oqUUnD7J; dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b=nTdSMaHu; dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b=w7Kg6R7U; arc=none smtp.client-ip=79.137.243.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bswap.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bswap.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="oqUUnD7J";
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="nTdSMaHu";
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="w7Kg6R7U"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=Xu9r8HMUgUsvIWBEw9ZhWtkEyMnrdn+zWYDhrfhC+k0=;
	t=1738246341;x=1738336341; 
	b=oqUUnD7JtxIO9xFixWELAF5I2ScJjEksC/au5irassTsjgRxHad/Pl8BERz2J4hM+5xQA0GVMsgfSC8vgwxE0ZXvM8hR3dLibCUVsrmERhDPYUQRg37iSaNRlvu5s/y8Qr2+8BZxIpH1MaZv3imIb+7wkvyd7Sg1OFsld0v1bpA=;
Received: from [10.113.184.7] (port=55168 helo=send77.i.mail.ru)
	by fallback2.i.mail.ru with esmtp (envelope-from <kostix@bswap.ru>)
	id 1tdVHB-003GA3-09
	for git@vger.kernel.org; Thu, 30 Jan 2025 17:12:13 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru;
	s=mailru; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive:X-Cloud-Ids;
	bh=Xu9r8HMUgUsvIWBEw9ZhWtkEyMnrdn+zWYDhrfhC+k0=; t=1738246333; x=1738336333; 
	b=nTdSMaHuV5ZX8EHs69tcWRJw7ERI2lj2Ek2KIj/eQPHFNvGcY7bIFSohajHGwjSzo1g12JgtNA9
	/Ag4t8kSGcn3VD44QYRAL7DJso/t1BYz9TEonIZB/yo2V2znnp0WxhCvr/pq7rNlxkUwxu8fbKpzc
	UpKtc5xt2fzKr9RQ9fs=;
Received: from [10.113.153.212] (port=52748 helo=send172.i.mail.ru)
	by exim-fallback-797fb87cff-5f69n with esmtp (envelope-from <kostix@bswap.ru>)
	id 1tdVH2-00000000bPU-3umT
	for git@vger.kernel.org; Thu, 30 Jan 2025 17:12:05 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru;
	s=mailru; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=Xu9r8HMUgUsvIWBEw9ZhWtkEyMnrdn+zWYDhrfhC+k0=; t=1738246324; x=1738336324; 
	b=w7Kg6R7UufZL1lKUEtsXwT2yVQFGVs4lqhMMY9PYCFmcxTZkWvfvj15m74O5nSvBPIAVOFXXPxU
	pWmszGpTYWX6jy/puZ4yF+9z3LIQAhANfmk9QexNwwNKba3GykgKSGlNI5w6TTyMITLSn6xIlKCM0
	otCcLspRuINpeoe2Ne8=;
Received: by exim-smtp-5d58c69cd6-c7x6t with esmtpa (envelope-from <kostix@bswap.ru>)
	id 1tdVGt-00000000F9x-22Hp; Thu, 30 Jan 2025 17:11:56 +0300
Date: Thu, 30 Jan 2025 17:11:54 +0300
From: Konstantin Khomoutov <kostix@bswap.ru>
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Mike Weltevrede <mikeweltevrede@gmail.com>
Subject: Re: Feature idea: Git hook for pre-checkout
Message-ID: <20250130141154.gglc65fegstuzbjy@carbon>
Mail-Followup-To: git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Mike Weltevrede <mikeweltevrede@gmail.com>
References: <CAAE-bwUQ+0ERbvC=SS=-R_K4H3p2su+=Ogf7BSkyq5J4GmmRYw@mail.gmail.com>
 <Z5rhXrkbhINwFDXT@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5rhXrkbhINwFDXT@tapette.crustytoothpaste.net>
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD985D89FF3B425BBEF60198EBAA7A2E64509B496FF1DBC87B0CD62213F67905E7AAE03594B2C21549BC01D4CCAC62E93481FD1368B0EF4E406B02582ABDB060753C5C7FD16981B76AE
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7DECE8D0A5E25C0FCEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637A521848D7B067A388638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8F3151B09BE46E20506FA4C9B758132B77FC63A5E0A6CFCABCC7F00164DA146DAFE8445B8C89999728AA50765F7900637F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947C4CB6874B0BCFF0B8302FCEF25BFAB3454AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C3642883364D384F09BA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CF3D321E7403792E342EB15956EA79C166A417C69337E82CC275ECD9A6C639B01B78DA827A17800CE784355C927A450B6A731C566533BA786AA5CC5B56E945C8DA
X-C1DE0DAB: 0D63561A33F958A54CC352804C2AF9755002B1117B3ED696C5E670A30F38C7DF8D59E407A97E9958823CB91A9FED034534781492E4B8EEADB1D70E2111C441FFBDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADBF74143AD284FC7177DD89D51EBB7742DC8270968E61249B1004E42C50DC4CA955A7F0CF078B5EC49A30900B95165D3498910055B812BD9C492C86326148638250A13BF1AA26826C27F17C7B05D516B20042F0E09B6C92111D7E09C32AA3244CC1FC4B32195CCC8E77DD89D51EBB7742CF3C3CFC9E581EC1EA455F16B58544A2557BDE0DD54B35903871D1C702CBDB0A9665A0FD7AD89E8F722DFA761B3F797A
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojB5k2t8NeLmDpugBP721zpg==
X-Mailru-Sender: 641179478317D3F0421D0BEF39CFD138E5A6661DC275DD18EA62B7A476541487B9143D3C39C7CA70D537AA6D4973CF862F0A6AF357119A4D04176AAE5055CC72595A8557D9C981F4633CE835492D9647D182D770C8C7E642B4A721A3011E896F
X-Mras: Ok
X-Mailru-Src: fallback
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B4A84B4964F946E17EB1A91FC540E416C11582D74B19986F8F049FFFDB7839CE9E643586C112B81D11E30A09B53E2A5AEF22B6598BEDFC969FEDEE49E581E46C18B5FEFDBAB9BF3490
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5+wYjsrrSY/u6NqYXWMR0/V85CnFjCYTu9APdQH0PvpnP5qz8aO2mjTJzjHGC4ogvVuzB3zfVUBtENeZ6b5av1fnCBE34JUDkWdM6QxE+Ga5d8voMtmXfSrmgqWMIa0Sipuf5RTkiCWD
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4A84B4964F946E17EB1A91FC540E416C12D8BAB617684C85D049FFFDB7839CE9E643586C112B81D112A8131BFA484CC464476D5B6773D467216BFFF1A501FE2EF
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5+wYjsrrSY/u6NqYXWMR0/V85CnFjCYTu9APdQH0PvpnP5qz8aO2mjTJzjHGC4ogvVuzB3zfVUBtENeZ6b5av1fnCBE34JUDkWdM6QxE+Ga5d8voMtmXfSrlkrUOmOySqtyqHyU9iLcO
X-Mailru-MI: 20000000000000800
X-Mras: Ok

On Thu, Jan 30, 2025 at 02:18:06AM +0000, brian m. carlson wrote:

[...]
> It's also possible to use one name locally and push to another, such as with
> `git push origin my-feature:refs/features/foo`.

I would add that I, for one, have a habit of working on a detached HEAD and
then pushing the results with

  git push HEAD:refs/heads/whatever

and only creating a local branch when I think I'm going to abandon the current
work for too long (otherwise I just inspect the output of `git reflog HEAD`
to find the place where I left off and then check it out back).

I don't think it's a widely adopted approach to work with Git, so mentioning
it more for the purpose of widening the OP's view of the subject matter.

[...]

