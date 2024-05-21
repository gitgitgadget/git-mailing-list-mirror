Received: from fallback18.i.mail.ru (fallback18.i.mail.ru [79.137.243.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442982D045
	for <git@vger.kernel.org>; Tue, 21 May 2024 16:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716310130; cv=none; b=EvIQfFSwLFp7VHX1uSPH6DdNM1aoS79lAlU4nrmdch1qmygl0RsLj3B6SQbjjbiisa0KoqT0MwOHro1QFYdSJR65PqSF2wpc0am9yRgZFfiDu3Ohv5x1AplHOl/uaMA7nDRq1Dnm+xMatVc8ti+/augNE4Og1rt0Dsg9mUHyuSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716310130; c=relaxed/simple;
	bh=7VEaG9UeydE4Od+NzCkq4YINprzULdP8/JKXJqJT3v0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aT30a58CtQH7C88nP3bKHm70ppgdJsHp1n5LtLgDbvQrwdXX0NvAv1+Ei7XVZ06ubbdNrp9Hy7JTXqMKfDjq2d20lQD1dstK/6i0o//griUc4Zdj1xbsjhRYI/EcsNqRTozI04UW3KFk2ofLQslgmkpNsUq5/iS1UDEQGM1fvEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bswap.ru; spf=pass smtp.mailfrom=bswap.ru; dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b=a1b8Zpfm; dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b=mr4M0/Nr; arc=none smtp.client-ip=79.137.243.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bswap.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bswap.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="a1b8Zpfm";
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="mr4M0/Nr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=H8kJuvV1ksVqBI3lJiLjdHcUfQXEuOzK7PuMCQOzyJE=;
	t=1716310125;x=1716400125; 
	b=a1b8ZpfmXeRl3KIUgjB5hQ2AkSeIMaKlqguhBWijmLgWh6xSn5nJrRCLG9ndPmwZ01ahcKWppzW/WoYryOXUQ5fSxficU27MJ2tTIBopa8e6fnK3Gg4d2spEi0gNjsz17uhC8jyEXCR1x2PbHSEDOOlHPNE4wquDl9eARwDoAbM=;
Received: from [10.12.4.33] (port=55436 helo=smtp58.i.mail.ru)
	by fallback18.i.mail.ru with esmtp (envelope-from <kostix@bswap.ru>)
	id 1s9Rv9-00Gn6U-Pe
	for git@vger.kernel.org; Tue, 21 May 2024 19:01:00 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru;
	s=mailru; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=H8kJuvV1ksVqBI3lJiLjdHcUfQXEuOzK7PuMCQOzyJE=; t=1716307259; x=1716397259; 
	b=mr4M0/NrdT2ETZ6ddlUOD/c37K1UKHsgIbn5vwLQevzGIniN3b1wpnowozp6PHvz8SEVkQYgWXE
	ukbc+n8uT3hHBrOKfBocTcDL7u+dOFZVbf1dFCo7Rd0r4xI14ErSe7elmYqm/b4TE/JmOOOVAOAmV
	OIv6rkH/zayzz7Xe50k=;
Received: by smtp58.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
	id 1s9Rv0-0000000EYnR-1qCv; Tue, 21 May 2024 19:00:51 +0300
Date: Tue, 21 May 2024 19:00:49 +0300
From: Konstantin Khomoutov <kostix@bswap.ru>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Konstantin Khomoutov <kostix@bswap.ru>, git@vger.kernel.org
Subject: Re: Embedding Git Command Line
Message-ID: <20240521160049.jiqpr2prvprryuuw@carbon>
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
References: <36B52407-B52F-4394-8DF2-F2DF3D3F0504.ref@yahoo.co.uk>
 <36B52407-B52F-4394-8DF2-F2DF3D3F0504@yahoo.co.uk>
 <20240516181738.g7iw6rfqvjfucoiw@carbon>
 <224aff4c-facc-76cd-94c1-8b40f18c0d40@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <224aff4c-facc-76cd-94c1-8b40f18c0d40@gmx.de>
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD99EF2330544E8CB05F916ADB9B7CD72D37EDB3DC5EB5269D2182A05F5380850404DFD542C930BC39D03ED270C30F246C5CB9523E18481617DC4FB64B8AFB780B7C72A02DE8EF075F6
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7F9D3BE5B596754B8C2099A533E45F2D0395957E7521B51C2CFCAF695D4D8E9FCEA1F7E6F0F101C6778DA827A17800CE78CB87876C5D626D4EA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38B043BF0FB74779F36B806150F91F50514FA6161E72F69679CF26E5830706B19D5A471835C12D1D9774AD6D5ED66289B5278DA827A17800CE71AE4D56B06699BBC9FA2833FD35BB23D2EF20D2F80756B5F868A13BD56FB6657A471835C12D1D977725E5C173C3A84C317B107DEF921CE79117882F4460429728AD0CFFFB425014E868A13BD56FB6657D81D268191BDAD3DC09775C1D3CA48CFFA79E84ED94DD554BA3038C0950A5D36C8A9BA7A39EFB766D91E3A1F190DE8FDBA3038C0950A5D36D5E8D9A59859A8B6ABBCFCC36A29397A76E601842F6C81A1F004C906525384303E02D724532EE2C3F43C7A68FF6260569E8FC8737B5C2249957A4DEDD2346B42E827F84554CEF50127C277FBC8AE2E8B2EE5AD8F952D28FBAAAE862A0553A39223F8577A6DFFEA7CA35FE21102777C0943847C11F186F3C59DAA53EE0834AAEE
X-C1DE0DAB: 0D63561A33F958A54AAB7049F9BED0F15002B1117B3ED6960148EBDED47AAB47CA7E60A991436CA2823CB91A9FED034534781492E4B8EEADF5E532225D4D775BBDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADBF74143AD284FC7177DD89D51EBB7742DC8270968E61249B1004E42C50DC4CA955A7F0CF078B5EC49A30900B95165D343C45ADCD169245FA317E0C950BEE74CED56556BF658C2F685CA673E2586E9743F082CAA422A0CFFB1D7E09C32AA3244CA6A699ADD10216F6B58A6D757C7509E29BD2D207EBFB84C5EA455F16B58544A2557BDE0DD54B35903871D1C702CBDB0A9665A0FD7AD89E8F722DFA761B3F797A
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioji7oPwb/+WNDgLqBLta+qsA==
X-Mailru-Sender: 641179478317D3F0421D0BEF39CFD138ABA056042F92E5F2F6A6F50B1491C0350F6843A0A626296E740203C9F5F0A0EB2F0A6AF357119A4D04176AAE5055CC72595A8557D9C981F4633CE835492D9647D182D770C8C7E642B4A721A3011E896F
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4931842D42803ABA65168690DA48341397516D912D5AD252C049FFFDB7839CE9E5285DA703F7275953BF32F20BF7870BB05EFFEC59587D031E7E07E48BD082EF8
X-7FA49CB5: 0D63561A33F958A5DE9C6622B01CD012D0340E72D0A824D17443F8051FF50B708941B15DA834481FA18204E546F3947CA816C540FC8EEC30F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637C17F2030349B6B04389733CBF5DBD5E9B5C8C57E37DE458BD96E472CDF7238E0725E5C173C3A84C39D7D3120FB43BDE335872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioji7oPwb/+WNAu7rXJIZ/HZg==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

On Sat, May 18, 2024 at 09:50:00PM +0200, Johannes Schindelin wrote:

[...]
>> On the other hand, if it's not a shrink-wrap product but rather something
>> enterprise-y (kind of software usually installed by a dedicated technician -
>> as opposed to being downloaded and click-through installing by a layperson),
>> you might just use what Git for Windows ships, I suppose.
> 
> Git for Windows offers MinGit (for full details, see
> https://github.com/git-for-windows/git/wiki/MinGit), which is a subset of
> Git for Windows intended to be bundled by 3rd-party applications. That's
> what Visual Studio and GitHub Desktop do.

I've read that page and a couple related (describing MSYS[2] vs MinGW stuff
and the like) - pretty impressive. Thanks for the heads-up!

