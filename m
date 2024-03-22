Received: from fallback24.i.mail.ru (fallback24.i.mail.ru [79.137.243.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8D420B27
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 10:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711102339; cv=none; b=lbW4pKnHxB8qf2VDjbYQakLprZ+Ex3j8GAQaYt1mP+suR7ChK4aeKmOePd2iitGHQ58JRwqGaTj4YdZrma10zi6KMDisji1wN/Ms9F/6qREuwOj5Aa8ddUFrTCErfGhfJFAu2HuZauGCIo+UqV/UwuT2zDfQAbokRaqzTxhMuFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711102339; c=relaxed/simple;
	bh=SrJZy+iif5akoZGldw7DVnqI4wk3EDtJwQEMF4Qf/hk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=REdNjGKhbtyOoZF0xk0X5t4ro8V+G0BRcDxGPujDn3oSItxvVd3xwHq1hZsjS80dXMbNlI5jBmhBfcg+BKwo5qzLSskY4I1kYyieE3tzJvdYdzLjQuWQJyy6zvtmjJu5h/ea4b18j3O8h/iuVxyrhke8F2h+aOi12Q949r3qvvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bswap.ru; spf=pass smtp.mailfrom=bswap.ru; dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b=KLewzkp2; dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b=I/Beh6sz; arc=none smtp.client-ip=79.137.243.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bswap.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bswap.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="KLewzkp2";
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="I/Beh6sz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
	h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=nLJXoNOgfNqVPK5L+YOGTNYakzkcivFoDawjG2DJFeg=;
	t=1711102333;x=1711192333; 
	b=KLewzkp2dpCWoj4OYAuGCUxDrIYHuuDMZfq31zXy6l/G4KrUSOaikeddV+2G55mw13d9DET5+shH1Hbb8cbRu7Z2qrOZD0fDuVk2N5/JVATOUQnvvJaAiaOfsaLWCyfU4KugZZ9NeGZLEIgYYpAKEwHonlgVa1kCAd1eib4oang=;
Received: from [10.12.4.27] (port=47686 helo=smtp53.i.mail.ru)
	by fallback24.i.mail.ru with esmtp (envelope-from <kostix@bswap.ru>)
	id 1rnbdo-00CGsI-Ps
	for git@vger.kernel.org; Fri, 22 Mar 2024 12:56:49 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru;
	s=mailru; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:Message-ID:Subject:To:From:Date:From:Sender:Reply-To:To:Cc:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=nLJXoNOgfNqVPK5L+YOGTNYakzkcivFoDawjG2DJFeg=; t=1711101408; x=1711191408; 
	b=I/Beh6sz66sApA9ZwOkiYHhiKlZYXNzKlUhWA0+oI77xNxrc7q+jXfJbRZ4B+9Lq9ynhnISKwmQ
	UDfNRE99yVswbSROKZAkBo61H9MJK9VdnL6bTS2WdB8qCLVsZ1tT4UMrjQf3wf96/+yTu2N1CF6OE
	oxMnOao/c9jkAop2kQg=;
Received: by smtp53.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
	id 1rnbdg-0000000BMT6-3TwN
	for git@vger.kernel.org; Fri, 22 Mar 2024 12:56:41 +0300
Date: Fri, 22 Mar 2024 12:56:40 +0300
From: Konstantin Khomoutov <kostix@bswap.ru>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Merge selected files or folders
Message-ID: <20240322095640.saas2lxwmitrwoki@carbon>
Mail-Followup-To: "git@vger.kernel.org" <git@vger.kernel.org>
References: <PA4PR07MB7406FAC1F8C00E29979FCFF59E322@PA4PR07MB7406.eurprd07.prod.outlook.com>
 <xmqqbk778oeb.fsf@gitster.g>
 <87bk76fvvr.fsf@osv.gnss.ru>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bk76fvvr.fsf@osv.gnss.ru>
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD92CB91DAA594FB6BF71C75EE959EE1452DBF074630DF9CF42182A05F53808504093F0212A33F21D6E33594132A326AF8B1D9A802C9B31990CF85ECC65286B90F42E7580F92AFCEA56
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7B114C2C2C20B7E62EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006370CE92FB8C11ED3D88638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D87380FFCF46149E274D6C9ED0FA4C8852AADE8858A4B5A0D3CC7F00164DA146DAFE8445B8C89999728AA50765F7900637F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947CAD74539164518AE52D242C3BD2E3F4C64AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C3E6DA32D78056113CBA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CF4964A708C60C975A1DD303D21008E298D5E8D9A59859A8B6B372FE9A2E580EFC725E5C173C3A84C384C61F09AF66B0A435872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-C1DE0DAB: 0D63561A33F958A5F934ADB770E7B7D45002B1117B3ED69609E002FD9C48FE5B69995D676B7B4CBE823CB91A9FED034534781492E4B8EEADDFC043C56F70D752BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADBF74143AD284FC7177DD89D51EBB7742DC8270968E61249B1004E42C50DC4CA955A7F0CF078B5EC49A30900B95165D34DFB7A809FB53708791E2A54BC0C4E0ED175459180DE41B3BEA51CE6A385CCA1822749464E1DC99A31D7E09C32AA3244C045127B56285D93D7B0DC8E7D22A103A7437F84B4910BE97EA455F16B58544A2C99F59F2F009F0963871D1C702CBDB0A9665A0FD7AD89E8F722DFA761B3F797A
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojxpsVEd/A9aMgq6BeCLkW5w==
X-Mailru-Sender: 641179478317D3F0421D0BEF39CFD13810E748B4D5E639AAEDE2FBCE1621770A3393A3A5366729C58F6884B617354F462F0A6AF357119A4D04176AAE5055CC72595A8557D9C981F4633CE835492D9647D182D770C8C7E642B4A721A3011E896F
X-Mras: Ok
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B4A873E06F0BBE0AC5367C9BC2A173244A26C966925485BC1368F3CF0E9FE49B699BEC566A3D0078C7D4200E8DC1BF45446D4D3BC618A5DF621D24493E29A6ED3D
X-7FA49CB5: 0D63561A33F958A5FDC2A3CCF6D21E461E57FB4B9104B2EEE9D0DA57551CE7078941B15DA834481FA18204E546F3947CA85A14DF5F041C99F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637876557C5A8D58DD0389733CBF5DBD5E9B5C8C57E37DE458BD96E472CDF7238E0725E5C173C3A84C384C61F09AF66B0A435872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojxpsVEd/A9aO4YW9BMBUWHg==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

On Fri, Mar 22, 2024 at 12:39:36PM +0300, Sergey Organov wrote:

>>> I'd like to merge only certain files, or folders, from another
>>> branch.  What command or options should I be looking at to get
>>> this done?
>>
>> If you are using the verb "merge" in the way Git uses, then there is
>> *no* option to do so and that is very much deliberate, as allowing
>> such a operation will break your history.
> 
> No, it won't break history. The merge commit *content* does not break
> *history* in any way. Path-limiting makes perfect sense when one is
> about to create merge commit content and knows in advance the exact set
> of paths the changes from which are to be included (or ignored).

This reminded me of the "disaster no. 2" in the rant, arguably famous at the
time [1], in particular: 

| One user of Tortoise Git would do a pull, have a merge conflict, resolve the
| merge conflict, and then look carefully at his list of files to be committed
| back when he was committing the results. There were lots of files there, and
| he knew that the merge conflict only involved a couple of files. For his
| commit, he unchecked all the other files changes that he was not involved
| in, committed the results and pushed the commit.

My understanding is that the OP actually wanted to create a similar situation
consciously. It's quite possible that they intend to never merge the results
back into "the main line" but anyway.

The point is, the feature you're advocating is bound to be abused exactly
through this "this is my stuff, and there is the stuff I do not care about"
attitude.

Having said that, I do not oppose these features (not that my opinion should
have any weight; I'm just making things clear) as in the end the only workable
solution to have decent quality of a project's content is "gatekeeping" the
changes by the review process.

 1. https://randyfay.com/content/avoiding-git-disasters-gory-story

