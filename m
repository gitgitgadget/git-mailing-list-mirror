Received: from fallback3.i.mail.ru (fallback3.i.mail.ru [79.137.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939062E648
	for <git@vger.kernel.org>; Wed, 13 Mar 2024 09:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710323979; cv=none; b=piSL4fgpX4RbFEra/0ZTsIfEO39lhJToUWtby5g+xSOLRLbk7SH2yTaSpGQg3fSeEqFr8cduzLbmOOOS/BuyvQUP8YGbY62BpwznfeX6+o822EPrZlYZu5l8vhBplz5XYGxEepggewAITYXXgWKKU4LVh4VAYo9h+dN15xJia5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710323979; c=relaxed/simple;
	bh=g/hggy+IRsdKqNfZAsWqf/Sps0zmhPfG+MaNW0RVTGQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=TAXTI7RbeRXdi3aMs9k9MAsAsif+qZumYOg2Nn/igP2nOuONWIyKphFVor82IHnYYs8wautdsDjgl+fBllkTDinI0vXJ7nwQOzNMJSfgMQCl1dU1PtdffEMcDPi2Qv/KyCRMoe6W6D+UuM9mMBAUl/Z5v6UmJ79CyZFeANTc4Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bswap.ru; spf=pass smtp.mailfrom=bswap.ru; dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b=dbGHeVzo; dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b=c4ot01Zn; arc=none smtp.client-ip=79.137.243.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bswap.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bswap.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="dbGHeVzo";
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="c4ot01Zn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
	h=In-Reply-To:Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=g/hggy+IRsdKqNfZAsWqf/Sps0zmhPfG+MaNW0RVTGQ=;
	t=1710323973;x=1710413973; 
	b=dbGHeVzorh4GmhVaACTc4enrKkODgjwlTSgSA/EWI2hqXcOH1D5sk0fLjhRl9HpA0Fy6qIaVLVChdLXYSn4rUnYCUVBoyvu2tYWDOEpvt+tHRPOzeWrTGMjyv+JToZbR9oZS/FXE81pZQdJ/yOfgDhZw2czEkq9a9EJImwzVfyQ=;
Received: from [10.12.4.28] (port=52036 helo=smtp52.i.mail.ru)
	by fallback3.i.mail.ru with esmtp (envelope-from <kostix@bswap.ru>)
	id 1rkLOO-001PmT-Ly
	for git@vger.kernel.org; Wed, 13 Mar 2024 12:59:25 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru;
	s=mailru; h=In-Reply-To:Content-Type:MIME-Version:Message-ID:Subject:To:From:
	Date:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:X-Cloud-Ids
	:Disposition-Notification-To; bh=g/hggy+IRsdKqNfZAsWqf/Sps0zmhPfG+MaNW0RVTGQ=
	; t=1710323964; x=1710413964; b=c4ot01ZnQtbCVdavtDT9TiPSglU4Et65BuxoyLd4avonZ
	ik7JVsj0H1vrIgDeo+dOhmoiLoOhUmGOte/HYixnjz10xC63y6lJjh1OiCdog3iLX19VadXcBjwY0
	xK48YOD7SVF2b9lzAU0dA4A7XBC2vCCDLIEGmkmLtrCYdZvU4=;
Received: by smtp52.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
	id 1rkLOF-00000002ueD-470q
	for git@vger.kernel.org; Wed, 13 Mar 2024 12:59:16 +0300
Date: Wed, 13 Mar 2024 12:59:16 +0300
From: Konstantin Khomoutov <kostix@bswap.ru>
To: git@vger.kernel.org
Subject: Re: Proposal and Validation of Git Compile
Message-ID: <20240313095916.ydcnyzhdmc6jbfms@carbon>
Mail-Followup-To: git@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABCSMAeySCkg6A1R3PUwrHyWRKMKnBH3OGnd8OtX-OpsGoOTkQ@mail.gmail.com>
 <52ot6dibj4o5mhgsmxpa5r2hkllxrwwhf2azgkvtpaopldi2pg@5etkc4r3eunm>
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD987C0EE6E7F0A597DDF776407DD463AED7AC1984F64828CE8182A05F53808504083F86AC321523A56F378A8CA21F699D6954ED03412D46485D1F230955BD73AF429BB0F96A4111E0F
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE721D130CF676D2164EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637BFD6B3F1638522B88638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8FF40606EBA4CF2F0228889BD24D40B4BFA226ADEE7305533CC7F00164DA146DAFE8445B8C89999728AA50765F790063783E00425F71A4181389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8EDCF5861DED71B2F389733CBF5DBD5E9B5C8C57E37DE458BD9DD9810294C998ED8FC6C240DEA76428AA50765F790063736EDF564B66DB9A5D81D268191BDAD3DBD4B6F7A4D31EC0BE2F48590F00D11D6D81D268191BDAD3D78DA827A17800CE71638115051EC7D63EC76A7562686271ED91E3A1F190DE8FD2E808ACE2090B5E14AD6D5ED66289B5278DA827A17800CE754F43A495B1ACFC12EB15956EA79C166A417C69337E82CC275ECD9A6C639B01B78DA827A17800CE7ACFBA275DC0B3023731C566533BA786AA5CC5B56E945C8DA
X-C1DE0DAB: 0D63561A33F958A53103E3C97230232C5002B1117B3ED6966143BA174358C96047A99E6294EE8661823CB91A9FED034534781492E4B8EEADB71243024C627CEABDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADBF74143AD284FC7177DD89D51EBB7742DC8270968E61249B1004E42C50DC4CA955A7F0CF078B5EC49A30900B95165D34C974B02B4EA30DFB62CB0A01F2ADC3385C9AA092436BEDB00CCEE2D8D6143254473C0229236375551D7E09C32AA3244C45158F5B98ED388B86B83C6DB07BF3AE37233C0E2DFAD0AEEA455F16B58544A2C99F59F2F009F0963871D1C702CBDB0A9665A0FD7AD89E8F722DFA761B3F797A
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojtv/CB9kl0S1cPxfy1ZxDiw==
X-Mailru-Sender: 641179478317D3F0421D0BEF39CFD138267628191CA8E439504BCEC120683F15F8569EAD08085E8976F9B73EB83D6B8E2F0A6AF357119A4D04176AAE5055CC72595A8557D9C981F4633CE835492D9647D182D770C8C7E642B4A721A3011E896F
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B485448333635D8AFAF2FD4A3C9FF394F50CE747836C96033F049FFFDB7839CE9E436D59F16A22D110EFB9FAEDFF639DF8178D2DD48794304745DC6BC1EB19465A
X-7FA49CB5: 0D63561A33F958A5345E21FC5C8B5CB51E06EC3D026FAC95CB04F88809B505CE8941B15DA834481FA18204E546F3947C4D3DDB508812D900F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637393CC20B86D473A4389733CBF5DBD5E9B5C8C57E37DE458BD96E472CDF7238E0725E5C173C3A84C3FAF59672226B6DF735872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojtv/CB9kl0S0JUgmKIRwfKA==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

On Tue, Mar 12, 2024 at 11:24:17PM -0400, Bhargav Vishnu wrote:

> I'm writing to propose and get a validation of one of the ideas I had for
> git tool.
[...]
> Eg: Code on a gist is copied into every repository, why not create and use
> the gist itself as it also has versioning?
[...]

In addition to what Reto said in their respective answer, you seem to confuse
Git (a version control tool) and Github - a turn-key Git hosting solution.
The thing is, the concept of "gists" does not exist in Git, and also it does
not have any real concept of a repository fork, a pull request, issue tracking
and so on.
That is, to build what you propose on your workflow picture, you'd need to
implement it in Github, not Git.

That said, I support what Reto said: Gists are merely pastebins [1] of the
21th century, and I think you perceive them as version-controlled code because
you supposedly are a relatively young person ;-) For an old fart like me,
Gists are just a sort of convenient way to share snippets of code with someone
else (say, when you're chatting on StackOverflow or elsewhere and would like
to show to your peer a bit more than a one-liner).

And if we think about making reusable pieces of code, this is ineed a solved
problem: libraries, packages and package repositories.
Not that I do not find your idea having a particular appeal - it does, - just
it's not in the domain of Git itself. A packaging system could possibly
somehow intergate with Gists (but note that that could only really sensibly
work for interpreted languages such as JS, which you seem to think of anyway),
but that's a task for that package system, not Git. For instance, Go's package
management system allows storage of the packages (in the form of the source
code) using multiple VC systems - namely, Git, Mercurial, Fossil and
Subversion, and it's semi-transparent to the users. Note that implementing
this package system did not require any support from the mentioned VC systems.
Quite possibly, say, NPM, could be made to work with Gists in the way you
envision, but it's to be discussed with NPM folks, not Git folks.

 1. https://en.wikipedia.org/wiki/Pastebin

