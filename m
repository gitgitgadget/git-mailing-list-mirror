Received: from send288.i.mail.ru (send288.i.mail.ru [95.163.59.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3620A21B9CD
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 09:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.163.59.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754387532; cv=none; b=YpIXLHL/sqyCuGy+m+rMfgPvqcMF5aaPlq6kJeeHVZq89+ippkYYyk8WLz01V2w5fRSmSxyLx1ltFv49o1Y8ey9n7ez4tKOdAl8xb1vyZj8HmdcdjsrNzgVbigUsOtfflKAkL/lr2YwPydl13BqyRm5j+utXdZsx7/ygHg0sSOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754387532; c=relaxed/simple;
	bh=LL6VBKbxtxrqTaRrvbGHOHDNCSB83RRaRTAWyDIsy08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hPu4CphG01zWFSNFX1tm3lEXiwXu1BWJ0AJ/m2mB19DBUfHWz8nAqovyGiaD9HjtcNeuhPwGIlpIO/EqFbd3QIX2biKgau8ZdsY1dMPjyINKJ+MSo/7HCYZyMmJkzXAmkAginRrXDHcSzABV5/XJ8yGQevXgyHyh6di5MZ3ECjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bswap.ru; spf=pass smtp.mailfrom=bswap.ru; dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b=eZD44hRu; dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b=qTgjyMv9; arc=none smtp.client-ip=95.163.59.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bswap.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bswap.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="eZD44hRu";
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="qTgjyMv9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru;
	s=mailru; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive:X-Cloud-Ids;
	bh=z5X3vICeOjqocOVIiwSWvskbvtp8+wTtc3HKWzL/13A=; t=1754387526; x=1754477526; 
	b=eZD44hRu0pmQIP3Y2e8XW1tHBUGOtA8vQF42J6Pu+VLRGOIga9c8lA9OC6jERC9TWpIPO1lXjbr
	hR6Spf3aB+PqcUzgFFm2FVDEkkOBgvgkpsiItz6gA8cFqhl/c8uxBbZ9j9PblBOS0M5NvKZwNAinx
	duZTagEhd7hDsEsHJ3I=;
Received: from [10.113.97.21] (port=51352 helo=send80.i.mail.ru)
	by exim-fallback-67c4d9c84-w8bfv with utf8esmtp (envelope-from <kostix@bswap.ru>)
	id 1ujE6J-00000000LaE-3ekL
	for git@vger.kernel.org; Tue, 05 Aug 2025 12:36:56 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru;
	s=mailru; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=z5X3vICeOjqocOVIiwSWvskbvtp8+wTtc3HKWzL/13A=; t=1754386615; x=1754476615; 
	b=qTgjyMv9PraSvnZYdNEA2np4nwH3CaMPSF8nvSYLN/hwK+2TpX/+bcadkF37dmavi1vTyPe246Z
	NoMzllsjQdrjQMWswq9kJZ9P2V3BCyR0aaJ/Ftm9iEr9plQLgVphpAJ19L0Ob9s743YhBuLHTNvKJ
	KBheHw9ixw+xfB173UM=;
Received: by exim-smtp-55657cf74-c25lx with utf8esmtpa (envelope-from <kostix@bswap.ru>)
	id 1ujE6A-00000000Txp-3Wxo; Tue, 05 Aug 2025 12:36:47 +0300
Date: Tue, 5 Aug 2025 12:36:46 +0300
From: Konstantin Khomoutov <kostix@bswap.ru>
To: FMorschel <git@fmorschel.dev>
Cc: git@vger.kernel.org, Konstantin Khomoutov <kostix@bswap.ru>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: Feature Request: git mv --after (new flag)
Message-ID: <d7ey5l2bcy4xzidqyq5by4mrwgziahypvnco5ilbik4y3feqhj@vspbafxowl5l>
Mail-Followup-To: FMorschel <git@fmorschel.dev>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <1fa7a8d8-3ae5-4913-b3b5-21d8f67e567d@fmorschel.dev>
 <0afc01b2-11a2-4f77-a858-7a444e8bb1d4@fmorschel.dev>
 <2f505f75-112a-4b71-bb05-ea0cb7731cd7@fmorschel.dev>
 <hi7t3qk7difgzip7syscarnf5ui5avnhmjxil4vzurwcfo7a6x@drccf7gibn72>
 <917aa62f-5f2a-40d7-8fa5-f19a14926241@fmorschel.dev>
 <ddc841ec-bc4b-4c01-a99e-9a65af3963bc@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddc841ec-bc4b-4c01-a99e-9a65af3963bc@app.fastmail.com>
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD9478038FB256C3880FB3D839CEDB18E654D256791FCB2EE0000894C459B0CD1B9F6E941E201961B81A421357250EF31ADBB4F3FB1C818EDD7BFC3571EF0B0A8FC2A808E2AF9A6ECDE
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7A8325FA649D0A450EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637AC83A81C8FD4AD23D82A6BABE6F325AC2E85FA5F3EDFCBAA7353EFBB55337566919098A35581D06D0690156E7E01CB5FA0E226A96A0C883B55A19A70D5CE6F46389733CBF5DBD5E913377AFFFEAFD269176DF2183F8FC7C0A3E989B1926288338941B15DA834481FCF19DD082D7633A0EF3E4896CB9E6436389733CBF5DBD5E9D5E8D9A59859A8B6D082881546D93491CC7F00164DA146DA6F5DAA56C3B73B237318B6A418E8EAB8D32BA5DBAC0009BE9E8FC8737B5C22492785264B78788A1276E601842F6C81A12EF20D2F80756B5FB606B96278B59C4276E601842F6C81A127C277FBC8AE2E8B377718C417CAE7783AA81AA40904B5D99C9F4D5AE37F343AD1F44FA8B9022EA23BBE47FD9DD3FB595F5C1EE8F4F765FC72CEEB2601E22B093A03B725D353964B0B7D0EA88DDEDAC722CA9DD8327EE4930A3850AC1BE2E735156CCFE7AF13BCA4B5C8C57E37DE458BEDA766A37F9254B7
X-C1DE0DAB: 0D63561A33F958A53FD5E0A38EAE5C285002B1117B3ED6968636FF790CEC83F99E040399BDE4761E823CB91A9FED034534781492E4B8EEADA79578C5CF9A9009BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADBF74143AD284FC7177DD89D51EBB7742424CF958EAFF5D571004E42C50DC4CA955A7F0CF078B5EC49A30900B95165D34F05B761BB9C2AA44B77EAA46FAA27FA7950A42AD4C3BFAA233773A651E6732CE792969C9D0A0730C1D7E09C32AA3244C74ABAA76898FB9EA77DD89D51EBB774234A34D70075D2FE8EA455F16B58544A21C197AAF4D2E47323871D1C702CBDB0A9665A0FD7AD89E8F722DFA761B3F797A
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXMZebaIdHP2ghjoIc/363UZI6Kf1ptIMVUlTLJrxaS1uWSbWzSgJr9g=
X-Mailru-Sender: 139A7956A63CACCF7216901AE3D43F14FC7BC6B9CA290628B951B70A5BD4BD8E25B0878A11ACD61C8F834780009727FCFD27B1545737DED76F53C80213D1719CB3360D9C94DE366A1CC4A9B39F20364B73395D515EC5B64A0D4ABDE8C577C2ED
X-Mras: Ok
X-Mailru-Src: fallback
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4C75C13076030B660521124F307D4EDE263DDB5C41E93D6DC049FFFDB7839CE9EA21F94FA7D756BA8D5860B03F0C582AE0675B249E733A7CD56A5845FBB5B54C51AE65B700B8AFE19
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+OYcBso8Zm+oliTz8oZwnDrFsY77LZRcHyw5ht0smWrfSeTW5FiI8avd9v29gUBslpEZ9wIMwqVP4jLQVQ+dVm7x9BpDHadBV9RMjI809PraZIRnOjZCLhOeHzC/J+EUlzA==
X-Mailru-MI: 20000000000000800
X-Mras: Ok

On Mon, Aug 04, 2025 at 06:04:05PM +0200, Kristoffer Haugsbakk wrote:

[...]
>> Wow, this seems to me a really weird design choice.
>>
>> Do you have any insight on to why is this?
> 
> https://lore.kernel.org/git/Pine.LNX.4.58.0504150753440.7211@ppc970.osdl.org/

FMorschel, when reading, consider paying close attention to the two things:

 - What Linus says about much of the code coming in in the form of the
   textual patches mailed to the various mailing lists.

 - An example describing a commit which has unified 5 different code snippets
   into one.

Basically, these bits highlight the fact that files, albeit useful and
ubiquitous on today's commodity operating systems, frame our way of thinking
of how information is tracked a bit too much ;-)

