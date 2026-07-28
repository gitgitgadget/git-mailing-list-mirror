Received: from send170.i.mail.ru (send170.i.mail.ru [95.163.59.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A1C456DFC
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 15:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.163.59.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785253458; cv=none; b=CnFah6I0Ug4GV2e3xVYAkxX0ddN4hDznEMz7UZXg8v9SFXUhMzEdvOYvn5rhySmLf64ZBkRSrQL13C6qqtGm1ehV9EKi5OXC5SIrgx6o2F62d6ZT4EHwKylCgf+h9xczzqiPx81y+unZCqxB+YBzlHLp8pjPwwEeiUYiIN0pgIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785253458; c=relaxed/simple;
	bh=keZP27gzJvFDg1wi7SGVdynTpu7UzSXzhBgq5JYlzGY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=R7pvU5KD44zDNWwOTbhrXSW1JRmDqCiux+agyuljwCUIeDaW+XQm3xuNco5Ow3k1Qvu9uPqcOvmVXXr2FUoBnTxr4erDAM2a5YOr/xngOKmBP4G3uuPvILuYiTJ0cLY/1hn8cQUf1QI9UaPspR33fbNt581r8J3kwBnq59O9e88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=WOJpt8hX; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=MC4DW5YE; arc=none smtp.client-ip=95.163.59.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="WOJpt8hX";
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="MC4DW5YE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:To:
	From:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive:X-Cloud-Ids;
	bh=luu2zDF1zIR0CdyldQXAoKiEqobddgn/qusEzxfTiC0=; t=1785253455; x=1785343455; 
	b=WOJpt8hXI4YDrMUFIDzoOfqPL6n+FrP670NFNyWqbVzv4VuiO4eNB19oCwqhwxLQvtYowtDYNQi
	Nwp1a1FEk1ly/ZonqhG1xxCmehkqBJ4ZEnb6u47gqrw4uIy4lLfPKpIEqU1uen9zopsWXfCCNXeeI
	x2LEjZd6rd16mWafVNes4daclBnCijKbqyhUk0MySylcH+tRoMx4CugN1gMK97ZAdOsW25S5P1kGT
	BTHk5zOMczT9LWFUK/AhpOwLg/YkGhOysOLBQcZA5zyqL9tfhvhtEVvdrg0IqP2zDxx6IKlVZrmVI
	c5KQtRbS+kYgWrawgSd0rJDb2n1pqUQWlY+g==;
Received: from [10.113.18.215] (port=50744 helo=send37.i.mail.ru)
	by exim-fallback-67c48d97fc-c4lwr with esmtp (envelope-from <long76.git@mail.ru>)
	id 1wojjs-000000009Ko-3MCj
	for git@vger.kernel.org; Tue, 28 Jul 2026 18:29:05 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:To:
	From:Subject:MIME-Version:Date:Message-ID:From:Sender:Reply-To:To:Cc:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=luu2zDF1zIR0CdyldQXAoKiEqobddgn/qusEzxfTiC0=; t=1785252544; x=1785342544; 
	b=MC4DW5YEtDhVsczktX5/gNLR6SnOXACiiLFkfn2qn48vyaJgi8+f/6odifG/kX3neh8/NtHNaUA
	UpD9CyKdYnSwb7rdheCrFNn0ipUvvRtD4pCrbFIm5LKW6yAz3QaAKkQf7ln8C2sOEfuJ3pIqZwrCZ
	FzgTyzLpUrI4UOwGTMcSICOOFxDE+O3BLmT9KhjOyNu5fxCwTb0KW4miD4trnc8zgJdB+y5GfFtOk
	vbPG7C+2H+RuuplMudvDEdkW4Iq79wSOjfQ3Z3twGQCKvRxKrNt2ySqW8ZD1N71CAXcDNagHNypSH
	/bbTyu0zBxmaGwN2VnE/e0OGkfAqfzPHRVqA==;
Received: by exim-smtp-6bc4cc657b-ddd7c with esmtpa (envelope-from <long76.git@mail.ru>)
	id 1wojjj-000000003B0-3zRl; Tue, 28 Jul 2026 18:28:56 +0300
Message-ID: <b3ec5eac-a177-4991-8edc-36ce5992dad2@mail.ru>
Date: Tue, 28 Jul 2026 18:28:55 +0300
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: REBASE_HEAD still exists after success end rebase
From: Long 76 <long76.git@mail.ru>
To: Matt Hunter <m@lfurio.us>, git@vger.kernel.org, phillip.wood@dunelm.org.uk
References: <edfc868b-6be6-4871-a539-e70791db216d@mail.ru>
 <DKA3RP12A8LU.2VD89MQ7G2KLL@lfurio.us>
 <9ee7b916-a9ce-4300-baf4-b24d0a52fe46@mail.ru>
Content-Language: en-US
In-Reply-To: <9ee7b916-a9ce-4300-baf4-b24d0a52fe46@mail.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD999EC7E29E32078B0E87D26D5D4D3469A37D306C28DB22336182A05F5380850402E0B3425611EFC093DE06ABAFEAF670598C32A035B9C88D6C9AE6BEE73B3A4F55872F0C4753F95D2
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE716FAD50E497B9C14EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637AC83A81C8FD4AD23D82A6BABE6F325AC2E85FA5F3EDFCBAA7353EFBB553375666E0AFCC7CBCEC7C7D7B6C56B8D84D0D1E53E209DA1FD640CCA7FAC370D7F1B7B8EEF46B7454FC60B9742502CCDD46D0D2FFDA4F57982C5F4F6B57BC7E64490618DEB871D839B73339E8FC8737B5C224908988D4D34163C9DCC7F00164DA146DAFE8445B8C89999729449624AB7ADAF37F6B57BC7E64490611E7FA7ABCAF51C92176DF2183F8FC7C02A2C2731A565D81B8941B15DA834481F9449624AB7ADAF37BA3038C0950A5D3613377AFFFEAFD269176DF2183F8FC7C040FEA8D7F28272697B076A6E789B0E97A8DF7F3B2552694AD5FFEEA1DED7F25D49FD398EE364050F26055571C92BF10F452896749CDDA0A6B3661434B16C20ACC84D3B47A649675FE827F84554CEF5019E625A9149C048EE9ECD01F8117BC8BEE2021AF6380DFAD18AA50765F790063735872C767BF85DA227C277FBC8AE2E8BFBCBFC5051A70ADB75ECD9A6C639B01B4E70A05D1297E1BBCB5012B2E24CD356
X-C1DE0DAB: 0D63561A33F958A521273140BA653CD05002B1117B3ED696522D43315B5CFF5BD57BAD45EC4C5DE1823CB91A9FED034534781492E4B8EEAD85CCBA673D36D1A4BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE1918E10F71CB4DF9F96AB70F9BE574AE9C625B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D659C155AD360680812C310FFFB4258B05E968A3FB6024825D508CD43FCF42D91F3A7BF7BC7F2C35F04EB8341EE9D5BE9A0AE7D8EAFA6E132C4031616FB9C592A5040F8B83E85039FACF6536EB022892E5344C41F94D744909CE06349EBF80BA53DC7F80F8B16B0B4F5BC3981EEBE9DB10F943082AE146A756F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXMZebaIdHP2ghjoIc/363UZI6Kf1ptIMVczkDsfooUjfO261hvgSRik=
X-Mailru-Sender: FA56D3AF5E7ABC7464DC1CE9D819784EA85CE5491858B1333DE06ABAFEAF670598C32A035B9C88D6B7CBEF92542CD7C86E6763FEFA0584FA91296853BA92DB573F2CD06A13C360CFE5A15ED4F09F547DA6B405093FCEE899451FCD79C64DC368C77752E0C033A69E3453F38A29522196
X-Mras: Ok
X-Mailru-Src: fallback
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B42CD459FEF794EC2C492BBD0D7572DF2445AEDE09B62EC3B1049FFFDB7839CE9EC750E04395D273842FF6C062570EF0D5BBD0893F6E162E036E42E004001AE341601E1CEE31C3EEEB
X-7FA49CB5: 0D63561A33F958A5BCCE5704092F41195002B1117B3ED6960849FC0DA8CBA0934565145407275D2102ED4CEA229C1FA827C277FBC8AE2E8B54F520D093A0DF28
X-B7AD71C0: 6FEFE4C63DFE2D851629A3278334FCEC2AD323669803AD9FE6E38E9349F0B96630D0092E3DE3DA7F6E0C20BFA971ED82
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+OYcBso8Zm+oliTz8oZwnDrFsY77LZRcHyw5ht0smWrfSeTW5FiI8avd9v29gUBslpEZ9wIMwqVP4jLQVQ+dVm7x9BpDHadBV9RMjI809PraZcy7CYgo9o5vXVDAHWlwDOw==
X-Mailru-MI: 20000080020001000000000800
X-Mras: Ok

+ phillip.wood@dunelm.org.uk

28.07.2026 18:27, Long 76 пишет:
>> I made a very short-lived effort to look into why this "bug" was
>> happening.  I say "bug" in quotes, because I'm not even sure if it is
>> even problematic behavior.
> 
> I think this is a bug because git create similar HEADs if you made merge 
> or cherry-pick. I don't have problems with them.
> 
> Plus by git rebase docs on official site flag '--show-current-patch':
> ---
> Show the current patch in an interactive rebase or when rebase is 
> stopped because of conflicts. This is the equivalent of git show 
> REBASE_HEAD.
> ---
> For me it means that return patch only if rebase in progress - not 
> aborted/not complete/have conflicts
> 
>> I solved my need at the time (detecting a rebase in progress) by
>> checking for the existence of either of the 'rebase-merge' or
>> 'rebase-apply' directories in $GIT_DIR.
> 
> Thanks for advice! I don't knew it.

