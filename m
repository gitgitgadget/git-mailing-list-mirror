Received: from fallback17.i.mail.ru (fallback17.i.mail.ru [79.137.243.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA591ABEB0
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 19:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732215946; cv=none; b=vDdog0L/DQdJltRa3zJBDk1Hf3Ng5X/9aibo0e1OdBJk9dpjO0UgWl88WpXE/2a55X+wOxPB8+2xjyH2YQon6mUfysBtYYPXtJ37yKLJG2fVRDCApcMmqtxLLL8/Q71lrjFTrZG9g8nNcjPv5Nz/kSR0orIvW4pIKSfdfRw9C+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732215946; c=relaxed/simple;
	bh=HYWxaFLKkJz+ckmNB6KYYKuzVlEr+AqqWioYStV7MQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vb3/bVpNiXTGmMwKL8IUpTNOXDZGOksyTgOYuVoQpt8HGoaSTdkV+AwHdOgPQ02MEYi25pKRgtgDFplw+plmNGXfBK0oTGpkAL90pKk4hhWDLdoVDjRGZDf/pX3KODPggRxnFJuEoa/9zXtrVPA7FzksDLxizoryAvrMnmPGjiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bswap.ru; spf=pass smtp.mailfrom=bswap.ru; dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b=e8nKKLi6; dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b=yF1TiGjW; arc=none smtp.client-ip=79.137.243.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bswap.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bswap.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="e8nKKLi6";
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="yF1TiGjW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
	h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=oKLPLYiOmdjn4Dde04w8//w8zhp//om7QSlck0Lw+K8=;
	t=1732215940;x=1732305940; 
	b=e8nKKLi6XFLSi1MqYlb7v9nxGv6zEUnCI+VJtdPQMa1NbLtIpSVDiv/REBSklHIDuINYUZg4Xg2lN67+9ws/NQZEMpXv32i+OMBG7uFFtUx8fAT4yNR4zVeE1gM2IF8BkHKhByOBu6Af39rQaO1Mm2Gn3FHuBPiVgux0seQ/vCI=;
Received: from [10.113.61.153] (port=56932 helo=send277.i.mail.ru)
	by fallback17.i.mail.ru with esmtp (envelope-from <kostix@bswap.ru>)
	id 1tECUd-00CX2j-Nr
	for git@vger.kernel.org; Thu, 21 Nov 2024 22:05:31 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru;
	s=mailru; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:To:Cc:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=oKLPLYiOmdjn4Dde04w8//w8zhp//om7QSlck0Lw+K8=; t=1732215931; x=1732305931; 
	b=yF1TiGjWCm1gq63WX8YbpSAnD229Q6TBNWadqzm0O4okibvo0SY6EleCZBz5CQxagJhT1/mwarf
	NKZWiGdH3wSAuY62rvGNOYLHW9I/y0R8gcsr4D9cSQeFKsEDYJRXV23vibib9+yD/teTlplwEd7Od
	qyB1kHt9G+MoOYSjnHM=;
Received: by exim-smtp-77649746c4-4wmzr with esmtpa (envelope-from <kostix@bswap.ru>)
	id 1tECUV-00000000HwE-2Fi1; Thu, 21 Nov 2024 22:05:23 +0300
Date: Thu, 21 Nov 2024 22:05:22 +0300
From: Konstantin Khomoutov <kostix@bswap.ru>
To: Luis Heredia <luis.heredia@tool.es>
Cc: git@vger.kernel.org
Subject: Re: Git problem in windows server
Message-ID: <20241121190522.6s63bsvhxm3w5f5b@carbon>
Mail-Followup-To: Luis Heredia <luis.heredia@tool.es>, git@vger.kernel.org
References: <e020539e-b66b-4d4d-80da-9f51d4b66683@tool.es>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e020539e-b66b-4d4d-80da-9f51d4b66683@tool.es>
X-Mailru-Src: smtp
X-7564579A: EEAE043A70213CC8
X-77F55803: 4F1203BC0FB41BD96786BF697653C0A3722A362934A6E2D9538D8D4029F99785182A05F5380850404C228DA9ACA6FE27EF6CE1B2036D200F3DE06ABAFEAF67052C264D4C60DBBAC2B455B75AB3303440128E90E6EA85A331
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE71BDE6A359BD5B800EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006376A27C8034CCD05E58638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D87E9F57D95C3F09B2E31576F6DA319A51CA9E7C675D4468F6CC7F00164DA146DAFE8445B8C89999728AA50765F79006375FFD5C25497261569FA2833FD35BB23D2EF20D2F80756B5F868A13BD56FB6657A471835C12D1D977725E5C173C3A84C362968DCAA3E4B45B117882F4460429728AD0CFFFB425014E868A13BD56FB6657D81D268191BDAD3DC09775C1D3CA48CF3AFBBA56C05A32E5BA3038C0950A5D36C8A9BA7A39EFB766D91E3A1F190DE8FDBA3038C0950A5D36D5E8D9A59859A8B637D475550F2A941776E601842F6C81A1F004C906525384303E02D724532EE2C3F43C7A68FF6260569E8FC8737B5C2249EC8D19AE6D49635B68655334FD4449CB9ECD01F8117BC8BEAAAE862A0553A39223F8577A6DFFEA7C3B6C7E47A292E8D043847C11F186F3C59DAA53EE0834AAEE
X-C1DE0DAB: 0D63561A33F958A5ACC31725FBDFBEF35002B1117B3ED696172BC25D7EEB715CF09842853758E9E5823CB91A9FED034534781492E4B8EEAD17AEC49845D0B908
X-C8649E89: 1C3962B70DF3F0ADBF74143AD284FC7177DD89D51EBB7742DC8270968E61249B1004E42C50DC4CA955A7F0CF078B5EC49A30900B95165D34DFB7A809FB5370878444C84E0A6677C2B539174622653B718E24E3A62F6EE4784A01E522A4AD4FA41D7E09C32AA3244C54C7C0A48F9DE38877DD89D51EBB77425FE51D23F552DCC2EA455F16B58544A2E30DDF7C44BCB90D3871D1C702CBDB0A9665A0FD7AD89E8F722DFA761B3F797A
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojB5M2t/ETq/1egHAk9iNoCQ==
X-Mailru-Sender: 641179478317D3F0421D0BEF39CFD138F2E9C61B36592E08D85FDC519B8364601F9FD93DE3FDEF6250BAB90ECA0B9D0D2F0A6AF357119A4D04176AAE5055CC72595A8557D9C981F4633CE835492D9647D182D770C8C7E642B4A721A3011E896F
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B44E72EF7427BD9C080D0A779F075BA1D367B7D1FDBB3DEE88049FFFDB7839CE9E5E96FB227CD3D6DA2949176145F2B7651C3BE937FA6B0CFBBB282C9B680464DF
X-7FA49CB5: 0D63561A33F958A580584474F416A717CE7CA4B2329DACA502CC9E05B9B5A4168941B15DA834481FA18204E546F3947CE3786DD2C77EBDAAF6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F790063738CA231DD84B2BC5389733CBF5DBD5E9B5C8C57E37DE458BD96E472CDF7238E0725E5C173C3A84C3045DD857D6FE754135872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-87b9d050: 1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojB5M2t/ETq/2NcCorrChUyg==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

On Thu, Nov 21, 2024 at 11:24:42AM +0100, Luis Heredia wrote:

[...]
> The problem is when i try to clone in my windows 10 local machine (cmd git
> clone - v ssh://user@serverIp:port/gitServer/git.git c:/temp) i always
> receive the error "fatal: ´´/gitServer/git.git''  does not appear to be a
> git repository".

Does it work if you call

  git clone ssh://user@serverIp:port/c/gitServer/git.git

or may be

  git clone ssh://user@serverIp:port/c:/gitServer/git.git

?

Basically the problem appears to be in that the Git process spawned remotely
in the SSH session set up by your local Git process, is given the path
component of the repository URL, which is "/gitServer/git.git" in your case.
Obviously, this path is not correct on Windows filesystems.
