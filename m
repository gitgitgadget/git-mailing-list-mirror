Received: from fallback25.i.mail.ru (fallback25.i.mail.ru [79.137.243.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6BA81745
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 15:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720451660; cv=none; b=ibuCsIHrxz/U+YGtzSJE9Coqoi13PNo5ct+RLQZpTgrnPbD6OAB8xpTz4X7SRcKXzmOpfcRO3zUexLhSVrZt3AYn55oCUW8blIC7lu9JAyx999Q+4h/feP8r3FF0InbGJjs0DHU/zgz9zZKmL+xvRcaQHvZYsHByEO2W8/890TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720451660; c=relaxed/simple;
	bh=iPeWUq1gULRq9TMtr2D+SMl0DbQlaOcmzdd7a/seeWE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=gNScCBTA7RITU0Wr7WeqouXbWbI/27WLMMdMHb8hYT3jUqhNcJEdy/DYQYBX0tCA5u7VYkSJqdd/N2emU+6swOX6E1Zv5wa92MI8yrK0/CjDuzakUhZCXaHVlr8gbFXHbkh06InQinxMZwDm98xesxksTws4RLhIA6Pc/za/S+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bswap.ru; spf=pass smtp.mailfrom=bswap.ru; dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b=nx0Lw4aU; dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b=j8fZRYLF; arc=none smtp.client-ip=79.137.243.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bswap.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bswap.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="nx0Lw4aU";
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="j8fZRYLF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
	h=In-Reply-To:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=FlcHSMh7xJZFgdxFAWt/sXcqCMj4yyqZGnf6Y0arFYA=;
	t=1720451654;x=1720541654; 
	b=nx0Lw4aU/0zQukVaM5n5SxqXJnQZB9wCbux+1fn6K5nf4cHgnigsm0XOhvfD+j5qj4mvMsSjXC9UEaPUNqRGTj+uo7qFbH+6FrU6Kb3gtyriiSLAqHDUBf7P/R9IsQvhiNWAtdGKUmWbRP50babTDIWm9zQAodKESnJKn0heNDo=;
Received: from [10.12.4.1] (port=48528 helo=smtp3.i.mail.ru)
	by fallback25.i.mail.ru with esmtp (envelope-from <kostix@bswap.ru>)
	id 1sQpQB-0063Sp-9Q
	for git@vger.kernel.org; Mon, 08 Jul 2024 17:32:51 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru;
	s=mailru; h=In-Reply-To:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:X-Cloud-Ids
	:Disposition-Notification-To; bh=FlcHSMh7xJZFgdxFAWt/sXcqCMj4yyqZGnf6Y0arFYA=
	; t=1720449171; x=1720539171; b=j8fZRYLF2KaY0dXT1ycRPqKA0lHe2NKe7ho/gjDqXYo71
	z8XN/KOLL7YUeQgKdKVBoCPzS8LNHGn1zt9VvSrhk1trBsWDm4sf+E/+K85BF1ssut6dmcw6DII1o
	cPOUUTkIBUg3bheDBemEHSJOCsYYfy7ZIfJZDsKC0K+AHNXx0=;
Received: by exim-smtp-6ccc45cc7c-lwv59 with esmtpa (envelope-from <kostix@bswap.ru>)
	id 1sQpQ0-000000008j0-0D84; Mon, 08 Jul 2024 17:32:40 +0300
Date: Mon, 8 Jul 2024 17:32:39 +0300
From: Konstantin Khomoutov <kostix@bswap.ru>
To: ellie <el@horse64.org>
Cc: rsbecker@nexbridge.com, git@vger.kernel.org
Subject: Re: With big repos and slower connections, git clone can be hard to
 work with
Message-ID: <20240708143239.vq47dg7mgh33hykf@carbon>
Mail-Followup-To: ellie <el@horse64.org>, rsbecker@nexbridge.com,
	git@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15bb8955-8ef6-4d83-b10c-e8593f65790c@horse64.org>
 <793a0c16-c2e5-4fbb-9e97-297c096fe42f@horse64.org>
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD945859FC18BF19E8B31994885DB4B2CBC392F6A0336A1E1AE182A05F5380850404E777233BB0C637F3DE06ABAFEAF6705056DCE5C0B5592E8AD47A6355F3A7067206BCEC6F5B8A356
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE789066434B85BF7C7EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006377E85B0EC44E8FD73EA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38B043BF0FB74779F36E7F77AF4255900A301D241175C8CDBF681057C43CC3B95FEA471835C12D1D9774AD6D5ED66289B5278DA827A17800CE77A825AB47F0FC8649FA2833FD35BB23D2EF20D2F80756B5F868A13BD56FB6657A471835C12D1D977725E5C173C3A84C3ED8438A78DFE0A9E117882F4460429728AD0CFFFB425014E868A13BD56FB6657D81D268191BDAD3DC09775C1D3CA48CFAF85C6C0B8857967BA3038C0950A5D36C8A9BA7A39EFB766D91E3A1F190DE8FDBA3038C0950A5D36D5E8D9A59859A8B6AA40404AEA1257B376E601842F6C81A1F004C906525384303E02D724532EE2C3F43C7A68FF6260569E8FC8737B5C22494854413538E1713FE827F84554CEF50127C277FBC8AE2E8B8C7ADC89C2F0B2A5AAAE862A0553A39223F8577A6DFFEA7CB23BE56FCC6FEFED43847C11F186F3C59DAA53EE0834AAEE
X-C1DE0DAB: 0D63561A33F958A5AF0F8FDF2016D03A5002B1117B3ED69672C2CD3B85E7A2F1E41E333F9D1358D5823CB91A9FED034534781492E4B8EEADAE4FDBF11360AC9BBDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADBF74143AD284FC7177DD89D51EBB7742DC8270968E61249B1004E42C50DC4CA955A7F0CF078B5EC49A30900B95165D3480A9008907CB2FD03D5A095B00F2E975C255BDD9C787F23EC4C26CDF18687308D18BDAC89A8E422E1D7E09C32AA3244CB678ECA0D8FC8A8777DD89D51EBB7742533ADCEC35D276E3EA455F16B58544A2557BDE0DD54B35903871D1C702CBDB0A9665A0FD7AD89E8F722DFA761B3F797A
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojmLqsEm9OWA7vPgmk+CEmeA==
X-Mailru-Sender: 641179478317D3F0421D0BEF39CFD13837BF80228060E6E4F6A6F50B1491C035D909DAD557470564091DED475A21ADD32F0A6AF357119A4D04176AAE5055CC72595A8557D9C981F4633CE835492D9647D182D770C8C7E642B4A721A3011E896F
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B49EE4DAAFE034007AC2C4F99DC9EFCB535E13703852D35E7F049FFFDB7839CE9E0089B5866B8777F87D31CAFA331ECFDFA113E27DB5ECB5784ED69D251C7B72BA
X-7FA49CB5: 0D63561A33F958A549147315AEB68B1455B72AC9FB87C8AFCBA3E76DB2D4AD918941B15DA834481FA18204E546F3947CE3786DD2C77EBDAAF6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F790063738CA231DD84B2BC5389733CBF5DBD5E9B5C8C57E37DE458BD96E472CDF7238E0725E5C173C3A84C30B8B320EE581A76035872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojmLqsEm9OWA5POiAqRx+/xA==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

On Mon, Jul 08, 2024 at 04:28:25AM +0200, ellie wrote:

[...]
> error: RPC failed; curl 92 HTTP/2 stream 5 was not closed cleanly: CANCEL
> (err 8)
[...]
> It seems extremely unlikely to me to be possibly an ISP issue, for which I
> already listed the reasons. An additional one is HTTPS downloads from github
> outside of git, e.g. from zip archives, for way larger files work fine as
> well.
[...]

What if you explicitly disable HTTP/2 when cloning?

  git -c http.version=HTTP/1.1 clone ...

should probably do this.

