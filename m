Received: from fallback1.i.mail.ru (fallback1.i.mail.ru [79.137.243.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E5374BF0
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 10:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712225357; cv=none; b=FM39kpnpmOoTOBbx78vvzmAMin20jyhPr81ZRzB05u1EHBufXsjBMjv4vFF2rhPWTs5I/4LAack/ZsTg7j2JO30PBq35r6jyNI72EogKEXuG5qaxQ/69Sk4ULMmx4A98/pf5g1lBMIUXYQ0+eQmovBGgbcYqBoA1DSTQ6/5o75c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712225357; c=relaxed/simple;
	bh=Z+OS8Y+3gL2AQpCZHh5KS4V4Y9T5gZ2Y3yvChwqCIPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZMD3yLwZzyfMFMQs7oS1xFgDZm41JwzzaLWnIDPtxWfb7KtbsI9x3pISvP8J8myySDsWBRgxY8uECLG+6gT+Xe0YwdtO65E4Bpu+WJFuWbEx8KaQdD4MW4PfDGNIPIzhTCYHalC/3hvm+jcKi6uD7BneGMsdtPW4Mr8XkCncqNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bswap.ru; spf=pass smtp.mailfrom=bswap.ru; dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b=UWrtBr1o; dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b=N8MPxt3z; arc=none smtp.client-ip=79.137.243.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bswap.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bswap.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="UWrtBr1o";
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="N8MPxt3z"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=Z+OS8Y+3gL2AQpCZHh5KS4V4Y9T5gZ2Y3yvChwqCIPQ=;
	t=1712225352;x=1712315352; 
	b=UWrtBr1ogVDb2d/9eZO7HbdqVbFh+0Zs0A4fOFIOQNwAmt1Fzb01BvtVOaxv5ZvsLtmH0MCCzwoRkfOdBDbBD1f6wnCLa7GXw7CTCpsjupeimPc1j8FwmKXHzDgRtf/n1ZzfVMZv+Qx17F76O9FlDDkj9w1PGn+nKQTeQ6+qH3k=;
Received: from [10.12.4.25] (port=36512 helo=smtp54.i.mail.ru)
	by fallback1.i.mail.ru with esmtp (envelope-from <kostix@bswap.ru>)
	id 1rsK1o-002lMj-1n
	for git@vger.kernel.org; Thu, 04 Apr 2024 13:09:04 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru;
	s=mailru; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=Z+OS8Y+3gL2AQpCZHh5KS4V4Y9T5gZ2Y3yvChwqCIPQ=; t=1712225344; x=1712315344; 
	b=N8MPxt3zU3BwkdPYWjCDSOGAWh+u4/xdnsGUd0jaxB7Z0XOqjBd1e2rafxn3nmzvKw+MBBmTD5p
	5qT425J9+O5Q21WTeA3qNRJUVyxHiAHicr7dXznKzarxmQaJLcsUFn1cgWQdQbeFHlnzUB66b4S1w
	ntYE2RWN1WLUN/wcBaM=;
Received: by smtp54.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
	id 1rsK1f-00000003B8D-0GjL; Thu, 04 Apr 2024 13:08:55 +0300
Date: Thu, 4 Apr 2024 13:08:54 +0300
From: Konstantin Khomoutov <kostix@bswap.ru>
To: Simon Phai <simonphaikm@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Git Server
Message-ID: <20240404100854.5vfozqo7iiyyshoc@carbon>
Mail-Followup-To: Simon Phai <simonphaikm@gmail.com>, git@vger.kernel.org
References: <CACArJ22jCTArv=U-XW61P8x6sa0rrXYupQvh_txdSk6vAG7p6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACArJ22jCTArv=U-XW61P8x6sa0rrXYupQvh_txdSk6vAG7p6Q@mail.gmail.com>
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD96441E77B1D9F2D07B7608C0BC8DC6439BEDBD305538C2AAC182A05F53808504045CFF1AE7D84EEE8A6D5EE0DB6E1EC8D6CA2F7948B6F26F8E8EA99AE536C2E783F3893D600F53C02
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE721B3E54BB37EA0B4EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637FE9EFE935CD7C6AE8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8A98B76F9A730A71C49386BAA5EC5F9A0D1074BE5BFC4DCBACC7F00164DA146DAFE8445B8C89999728AA50765F79006375FFD5C25497261569FA2833FD35BB23D2EF20D2F80756B5F868A13BD56FB6657A471835C12D1D977725E5C173C3A84C327ED053E960B195E117882F4460429728AD0CFFFB425014E868A13BD56FB6657D81D268191BDAD3DC09775C1D3CA48CFEAD86A1CE980672ABA3038C0950A5D36C8A9BA7A39EFB766D91E3A1F190DE8FDBA3038C0950A5D36D5E8D9A59859A8B643752FF16CD8C67A76E601842F6C81A1F004C906525384303E02D724532EE2C3F43C7A68FF6260569E8FC8737B5C224952D31B9D28593E51E827F84554CEF50127C277FBC8AE2E8BA83251EDC214901ED5E8D9A59859A8B615F38A1EB2280F99089D37D7C0E48F6C5571747095F342E88FB05168BE4CE3AF
X-C1DE0DAB: 0D63561A33F958A5BD3CB3EFBAEF2DDE5002B1117B3ED69625983821A1488B49A9DAB4B68AE4D22F823CB91A9FED034534781492E4B8EEAD17AEC49845D0B908
X-C8649E89: 1C3962B70DF3F0ADBF74143AD284FC7177DD89D51EBB7742DC8270968E61249B1004E42C50DC4CA955A7F0CF078B5EC49A30900B95165D34F8A2DF183797A6A8D645A4D357E666C75E634F0217E327484841FB19242A7AA6A3DF9D38BA7BF4D41D7E09C32AA3244C0992E522D335F8D5921CC9A31F9C4781AC21A0A14839F14DEA455F16B58544A2E30DDF7C44BCB90D3871D1C702CBDB0A9665A0FD7AD89E8F722DFA761B3F797A
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojXDAMXEVBmzvFxhoBN141hg==
X-Mailru-Sender: 641179478317D3F0421D0BEF39CFD138FFFF09CA3E488C779B464708D7791FD7344D7D8FCADDC94327A43C4902F321C32F0A6AF357119A4D04176AAE5055CC72595A8557D9C981F4633CE835492D9647D182D770C8C7E642B4A721A3011E896F
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B467E2E30B39A63A163668BDD6ECD6F0FE5797AE62FB9DA2A7049FFFDB7839CE9E4CCB16265D9FF7C7A7F4FF7EA408941E974504BCFD60054DFF7AB3D8EA78F0D8
X-7FA49CB5: 0D63561A33F958A588051ABD55EBE6F891297C08DD5AF322697D792764A3D5A28941B15DA834481FA18204E546F3947CDA7BFA4571439BB2F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F79006372255A60090D554F4389733CBF5DBD5E9B5C8C57E37DE458BD96E472CDF7238E0725E5C173C3A84C37952320C71F5F86735872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojXDAMXEVBmzuc6DBIUuvlgg==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

On Thu, Apr 04, 2024 at 05:54:44PM +0800, Simon Phai wrote:

> I want to host my own git server, may I understand the server OS can
> it be windows?

Yes.

But note that there exist quite many ways to "host a Git server", so you
should maybe explore what's already there and specify your requirements more
precisely.

In the simplest form (if we forget about just running git-daemon in a console
window - providing unprotected R/O access to a given repository), you either
set up Git to be accessible via an SSH server or via a web server (IIS works).

