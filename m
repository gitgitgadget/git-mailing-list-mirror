Received: from send215.i.mail.ru (send215.i.mail.ru [95.163.59.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DE32D2394
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 06:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.163.59.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788936582; cv=none; b=VGdoToBHDxA1xN375NIFKDoqj+mhUId1Ki2QM7tcreCc1SQBvHSqrUYCpjR91QgmOSNFhy03JBw5OZ2ut2sGAek2dnAcfaxAtZhiRx7vARKHKBjl7HwjHNjrJbtSOz3z1JgQUVvxrWANX6y+XFNkR3Nyj74n2E4QwYhljZHnudA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788936582; c=relaxed/simple;
	bh=Xu8QNJY6Scpo7mKqybjQwkgHYBUU4hx92eC7eji8ick=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XDnqL4yoQtMOBsyLDvClMd7cTnvzA6deliNPnTKMcJ9Fnr9Qx8woTIqDfLqk1fPPs+Gyf3dsYnmMokZQEGseQgg8pemnMprsbJ18s0CmejeE7eRfCP9iWBvCuHSQ59pZaExvQxhaYm/YW9PM0La5PNqrhc7IvWbvBJ9P8sCNw9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=Uj5U7RjS; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=gLLTGJIz; arc=none smtp.client-ip=95.163.59.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="Uj5U7RjS";
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="gLLTGJIz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References
	:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive:X-Cloud-Ids;
	bh=8Ufo03tdTmVCquR8gTGt4YfeFC6HjRUrzPpZd/713o0=; t=1788936577; x=1789026577; 
	b=Uj5U7RjSNGBXRmsJ0wFtfklpNW8UW+Agg+fcAkUeM1khzC6It3TVtZUY0uSLeWI0NFWFrzaHkIU
	UvYQbYNC9caTCPO25oeRYYAV9bESqYPspSAGvQZeSZyRs1pkz62lKIy2UM03bRQnvrQLhGG7hvVIf
	cUhQxxW2ZBNF30+elec7Md7y2kPRLike9k/lj8reKTihew5AAml27QUSaDjv2/AOkSqdEwQ0V1DmD
	1jclawvQJzrkeS30LSblJg4SL8OslskuqG/WpUhs5jCIHmm2clm8Zda+vlGQ02YUkcMAyfDb76IBz
	A5ykFWFBMoySPYQoRLbUyvuTrDP8r1vDLJxg==;
Received: from [10.113.155.6] (port=36970 helo=send196.i.mail.ru)
	by exim-fallback-679568fb9b-d4jwf with esmtp (envelope-from <ub4nal@mail.ru>)
	id 1x4C7b-000000000uv-1JgK
	for git@vger.kernel.org; Wed, 09 Sep 2026 09:49:27 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References
	:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Sender:Reply-To:To:Cc:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=8Ufo03tdTmVCquR8gTGt4YfeFC6HjRUrzPpZd/713o0=; t=1788936567; x=1789026567; 
	b=gLLTGJIz7V+890kaWFyVFByudaX71kZwMsQDtvBzveCNzVXppjYj65YfIMLDIp/GDcln69ulZT1
	fQuqIcYGdT/9RLv2UX48ekC493axqQRZ+aRldc0GBX/pt7ljLzL0XBGMPGuHWm2pCFEP0/jyYoJRj
	Mr7dpTLd8ggzwonqE4uYoCAwz51O3oQQxSYW6coh74QZIRPRIGO6xKoauKyK1bZ7k/zhfqwDfCToj
	fKBvrRm8z/aF8HGMZXx6gnobNF3hfaExyYOwQv9BDkbmVojSyAEH12Ur51bm66N4Z77kE+4h820WL
	fYRiGsFQPOAV3AJzGeuFQSmJSubb1sT6B73w==;
Received: by exim-smtp-569b45c49c-dbdmk with esmtpa (envelope-from <ub4nal@mail.ru>)
	id 1x4C7S-000000001ez-3NVg; Wed, 09 Sep 2026 09:49:19 +0300
Message-ID: <9b4f43d7-ba77-4859-8efe-facdec6ec5aa@mail.ru>
Date: Wed, 9 Sep 2026 09:49:17 +0300
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] advice: use global config for default branch name
To: Junio C Hamano <gitster@pobox.com>
Cc: ben.knoble@gmail.com, git@vger.kernel.org
References: <xmqqik4fyaav.fsf@gitster.g>
 <20260908213840.37833-1-ub4nal@mail.ru> <xmqqik4fwoz5.fsf@gitster.g>
Content-Language: en-US, ru, ru-RU
From: R4NC <ub4nal@mail.ru>
In-Reply-To: <xmqqik4fwoz5.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD978AFEFB3096932CF3E8A7903A83A543A37AF60AE29A9A2E2182A05F538085040C6438206E1078C683DE06ABAFEAF6705B7CEE0F16D5C2A93D8E75C27BCEEBEA87F2EA087B10D9051
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE73F94C36969B178B8EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637FE9EFE935CD7C6AE8638F802B75D45FF914D58D5BE9E6BC1A93B80C6DEB9DEE97C6FB206A91F05B25835260EEA734FE22E070BE324C7D3C4665183EB577A8E1FBB0A4F435E46E6718B35066C979671628AA50765F7900637889750A55773577B389733CBF5DBD5E913377AFFFEAFD269176DF2183F8FC7C0C26CFBAC0749D213D2E47CDBA5A96583BD4B6F7A4D31EC0BC014FD901B82EE079FA2833FD35BB23D27C277FBC8AE2E8BEA77C8EAE1CE44B0A471835C12D1D977C4224003CC836476EB9C4185024447017B076A6E789B0E975F5C1EE8F4F765FC6B8187AFAF8FBFD93AA81AA40904B5D9CF19DD082D7633A0C84D3B47A649675F3AA81AA40904B5D98AA50765F790063755005259B6E2CF39D81D268191BDAD3D3666184CF4C3C14F3FC91FA280E0CE3D1A620F70A64A45A98AA50765F79006372E808ACE2090B5E1725E5C173C3A84C3C5EA940A35A165FF2DBA43225CD8A89F680B5A81FBA2CF5035872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-C1DE0DAB: 0D63561A33F958A5D1185BD1282710FF5002B1117B3ED6961481D14EF1E9B67C466072E6821086B3823CB91A9FED034534781492E4B8EEADB05233B9BC4759D3
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE1918E10F71CB4DF9F96AB70F9BE574AE9C625B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D659996CB089B3F228C5125F1F2632865FA1EFFC83F2C840B86D03A44E8254BE4436C5B54BB125A80E93B8341EE9D5BE9A0A8B99B19A8FAC6EFE702033FE0DB3480CFCAAD2DE3FA500C16536EB022892E5344C41F94D744909CEFACD6B4B6D928230F8CCC96A59B602D5CC2E138FFB4ACBED
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXOcIETfglQORZ0zpDET4Zrk3igikrdHlWHu/EWFB9alYOphDQ8QPJMA=
X-Mailru-Sender: 288943BA7BCC8BBA2C509D5366AED3E55E0C2A2E119F5C4800C2CDE4AB6CFA7BBE4D924AAF92A76ACE7C75156624650D3B7E521F6A5800A996940349D467AF430D26F6DE3BAD3FFE4DFFA654C60F801316CD019DBEDFC45331DC91172AC7F52EF91D4A7208CD43CE3DDE9B364B0DF289AE208404248635DF
X-Mras: Ok
X-Mailru-Src: fallback
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4C775F1C6D245C3DB385775A58E73958739D30664CD57D72768F3CF0E9FE49B692B87AF122C1BAA09D162C5DCDA2700BAF794ACB896530E82D87413062FE5ECF8B6F1AFB5BD9396D5
X-7FA49CB5: 0D63561A33F958A57CAC5552D17B6E135002B1117B3ED69663D44C5022DAC261DF65068396D3048702ED4CEA229C1FA827C277FBC8AE2E8B54F520D093A0DF28
X-87b9d050: 1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+OYcBso8Zm+oliTz8oZwnDrFsY77LZRcHyw5ht0smWrfSeTW5FiI8avd9v29gUBslpLaIlvAR6h4id02YH9mgeCTAyYoNlVO8a5rszphlXEJ84CxuelJGH/c=
X-Mailru-MI: 20000080020000000000000800
X-Mras: Ok

 > One minor glitch is that there is an ad-hoc vadvise() call in
 > advise() that is not tied to any particular entry in the
 > advise_setting[] table.

I agree that we should use a separate "advice_setting" structure for this.

 > I think we'd need to give a name to the advice_setting struct type,
 > instanciate an ad-hoc instance on stack, and pass it down the callchain.

I agree. However, "advise()" originally passed "0" for 
"display_instructions",
while "advise_if_enabled()" passed the negation of "level". With the new 
interface,
we need a non-zero value for the ad-hoc setting to suppress the 
instructions.
Using "ADVICE_LEVEL_ENABLED" or "ADVICE_LEVEL_DISABLED" would be a hack.


I suggest adding a dedicated "ADVICE_LEVEL_UNKNOWN" value to "enum 
advice_level" for this case.
