Received: from fallback21.i.mail.ru (fallback21.i.mail.ru [79.137.243.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29994688
	for <git@vger.kernel.org>; Thu, 16 May 2024 18:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715885037; cv=none; b=Ubklq0pl5gVpKMRXBqX0YfKXRANAhA//ZhJpW1HFBD3rO6gdcYcm4zVTGP3Og7gBeK4GTMvXte+n5/Dt7c/s4EIoO0nDhOVgws3zvL/4xTkPQlpI1NF3fpjitpmrOVI2Slgc3BXABLhCmkiupg9940TXZ5YoD4RZVYQKeI699+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715885037; c=relaxed/simple;
	bh=c3cVQ+K6rnZcW3iWMBXGZkRzf8pHq7XD39ffysljRjU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCAYuKIqms2CUp6/yqXARikmQpzPTY3GW3v/peALtTk81typYOeCuBSQ0DqKd5kp9fnZG5dLlp+Ixs3bxrSJMcvEXRqKBZW6m7EaYrCJszwZn1vElJshOsvAS4CmIUiddUa9EisSfpJ45FCZmCGhUab8a8kSTXQNIQvTHaskbcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bswap.ru; spf=pass smtp.mailfrom=bswap.ru; dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b=gSlx1akf; dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b=tyLeFLKy; arc=none smtp.client-ip=79.137.243.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bswap.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bswap.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="gSlx1akf";
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="tyLeFLKy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
	h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=2MhmG6h70xI4SKivwsAXG+l4H13oERoqbbEfQDT0xOg=;
	t=1715885031;x=1715975031; 
	b=gSlx1akfz0QNfPBk8n9KkE0zQNfXR8n0Cf/nwGw8jwBCvVFAZKbYdBSklHEZQb+r8OXbZQc3pLEjiwNls3PebMLdYew40dEgr225uZXvl1u+63UtoVa6+jIkqoX8/cU57bsTg7vFZLMs7b6QTpzuRzWjy6z07HM5vimOy5XJZNc=;
Received: from [10.12.4.17] (port=56190 helo=smtp46.i.mail.ru)
	by fallback21.i.mail.ru with esmtp (envelope-from <kostix@bswap.ru>)
	id 1s7ffn-000H3e-Ey
	for git@vger.kernel.org; Thu, 16 May 2024 21:17:47 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru;
	s=mailru; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:Message-ID:Subject:To:From:Date:From:Sender:Reply-To:To:Cc:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=2MhmG6h70xI4SKivwsAXG+l4H13oERoqbbEfQDT0xOg=; t=1715883467; x=1715973467; 
	b=tyLeFLKyNWfrLRDO0r4uA4zdHcjtMaEqxzIQOhNUrPtpfVgY6WGzLPKj0VojV7qxg/YdzANBNMt
	+Y3hVzG2fc0vAvgqDgf/gVZjQ2eWp2/dpFZKH24NuDsad57r8+XpgwiJGGxTdRTZ2djum/u7bL7b5
	q8RjPFl7cfI4a4yuQhI=;
Received: by smtp46.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
	id 1s7ffe-00000007nHT-3ngE
	for git@vger.kernel.org; Thu, 16 May 2024 21:17:39 +0300
Date: Thu, 16 May 2024 21:17:38 +0300
From: Konstantin Khomoutov <kostix@bswap.ru>
To: git@vger.kernel.org
Subject: Re: Embedding Git Command Line
Message-ID: <20240516181738.g7iw6rfqvjfucoiw@carbon>
Mail-Followup-To: git@vger.kernel.org
References: <36B52407-B52F-4394-8DF2-F2DF3D3F0504.ref@yahoo.co.uk>
 <36B52407-B52F-4394-8DF2-F2DF3D3F0504@yahoo.co.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <36B52407-B52F-4394-8DF2-F2DF3D3F0504@yahoo.co.uk>
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD947734D04B312854445FAC0FEC63D855E661E44A1BC590D6B00894C459B0CD1B933A7885B9C2995CE2AD38A6D6FD013F3E1B1202C3A9E22CAD6351DB6549CE9BCDEB93F7F06BD0150
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE706EA9E10470DC775EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006371005780D56A98C20EA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38B043BF0FB74779F365AD1DD10D12C3993FBD7706373A873B0F75566D84448EA59A471835C12D1D9774AD6D5ED66289B5278DA827A17800CE7328B01A8D746D8839FA2833FD35BB23D2EF20D2F80756B5F868A13BD56FB6657A471835C12D1D977725E5C173C3A84C317B107DEF921CE79117882F4460429728AD0CFFFB425014E868A13BD56FB6657D81D268191BDAD3DC09775C1D3CA48CF1BD1948763FFC2C2BA3038C0950A5D36C8A9BA7A39EFB766D91E3A1F190DE8FDBA3038C0950A5D36D5E8D9A59859A8B60B49535A5146D2F676E601842F6C81A1F004C906525384303E02D724532EE2C3F43C7A68FF6260569E8FC8737B5C2249D082881546D93491E827F84554CEF50127C277FBC8AE2E8BF1175FABE1C0F9B6AAAE862A0553A39223F8577A6DFFEA7C24C67D5DB94550AF43847C11F186F3C59DAA53EE0834AAEE
X-87b9d050: 1
X-C1DE0DAB: 0D63561A33F958A54648FE16454B82165002B1117B3ED69639A4C2637C210F90E772F934B9BCD185823CB91A9FED034534781492E4B8EEADAE4FDBF11360AC9BBDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADBF74143AD284FC7177DD89D51EBB7742DC8270968E61249B1004E42C50DC4CA955A7F0CF078B5EC49A30900B95165D349C39CCCDAABCB54B42C086EF73BC1C5D79482EBB758670A2FD9AFF95BC38F1DF72E589C83FD645FD1D7E09C32AA3244C5C875042931641F80091A80DA37A96F34B4B5ECF0025E746EA455F16B58544A2C99F59F2F009F0963871D1C702CBDB0A9665A0FD7AD89E8F722DFA761B3F797A
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojyXdl6hFIhSjZtdSlpTGRMw==
X-Mailru-Sender: 7E479B994E4F3A2CB1CAA90EF936DBE2E6ABAA48AF84926BB951B70A5BD4BD8E7CBE2B77F32682DEE29C3C9F99C12D6FFD27B1545737DED76F53C80213D1719CB3360D9C94DE366A1CC4A9B39F20364B73395D515EC5B64A0D4ABDE8C577C2ED
X-Mras: Ok
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B4B24B1BD4AE50310860474D588B03DF94E5E738E645CA3D17049FFFDB7839CE9E03842A044FCD220C81D420A4642814623AF35E6CD47C5675BAE3583FFDFB41AD
X-7FA49CB5: 0D63561A33F958A50864E2110EAF0C61ABE17D52BFF9A8A042D202DCF43D16DD8941B15DA834481FA18204E546F3947C4B6F6234D9065C97F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637CBDA538BD653CEDD389733CBF5DBD5E9B5C8C57E37DE458BD96E472CDF7238E0725E5C173C3A84C322E8CC72813B2B8435872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojyXdl6hFIhSgxvD06Hy1zPQ==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

On Thu, May 16, 2024 at 01:04:35PM +0100, Kevin Gale wrote:

> We are looking to embed version control features into our commercially
> licensed proprietary product.
> 
> We haven’t made a decision on which technology yet but Git would be a
> popular choice.
[...]

While only tangentially related, I'd point out that if your product is going
to actually _bundle_ Git, then be prepared that it has quite a hefty set
of dependencies, so unless you're going to rely on the target OS to provide
them (which is, as I understand it, a no-go on Windows) you might be required
to invest considerable effort into that endaevor.

On the other hand, if it's not a shrink-wrap product but rather something
enterprise-y (kind of software usually installed by a dedicated technician -
as opposed to being downloaded and click-through installing by a layperson),
you might just use what Git for Windows ships, I suppose.

