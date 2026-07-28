Received: from send239.i.mail.ru (send239.i.mail.ru [95.163.59.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6DB383C7D
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 15:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.163.59.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785253394; cv=none; b=trGHaKelM7jXpjGLXyDrtqDz9cimarT0TuBWubPsRI3b0YfffRqRDefez5a0KdDDkXCKYyt6DSIUfFL5MNH3Q3kbEKaPiwKCPychm7EuoozsjceE952//wJzn95Mu40YgocqnXD3E9xjmirf96B+2ZWEdbUQH1k5KSXbVVnirTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785253394; c=relaxed/simple;
	bh=NqtyVj9vOTQ6G2iopW54D1u9dTSaLtl/tnFKIN/v0+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sXIgqJaRlqhEVqXQWsIJeJgE+jNVMU7mqKL5bUjvJ9B7btr/NLsGmVBwlaY7Ft++Oylv5++dMFrGRhOLYxPlf2edscwYAg/zWjQ3AAe0fSBJq484h02N09DVnjX2q6IiQdvh0yJ9DWd9ClYWWvOa529AOnyquvOrd0qFprZyLLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=sO+d8i3u; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=FhgIffsM; arc=none smtp.client-ip=95.163.59.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="sO+d8i3u";
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="FhgIffsM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References
	:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive:X-Cloud-Ids;
	bh=BXbYwuLbaitr5a9MDJQXB5S20faXybRpRnJtqxxqqOk=; t=1785253390; x=1785343390; 
	b=sO+d8i3uLWamA81fW/d3kr+KwZln1H6co2uBxgyPu/IqonVrh6W8dY0pDj5rQzF0JVjvtLG5T3o
	WqRLgAZWkBUVim0VopDMKwJGaBfPaegt33QZ+UVjYFfX9X+JkPgj1OqaF6lKQNmv1JJJZYHDtEm/N
	nFGJWh1m9DYeFLtNe7EJQjXCDgYkcL8LPfysTDE4kbyZfqOE9kx99jSZaDwpQocYUD4xaN9sKyZkz
	tHTY10Ke/VlVZV9gpeai0zrMEefBfp27sUR1udvkYhQCmedNS5nIYs1D1sZVrbZastKfyHVpVdldY
	/5/njUiuPD2dTBHeBoVQXvPhBv7qcG/upLEA==;
Received: from [10.113.148.58] (port=57116 helo=send277.i.mail.ru)
	by exim-fallback-67c48d97fc-46b7n with esmtp (envelope-from <long76.git@mail.ru>)
	id 1wojir-00000000Ibe-0oaz
	for git@vger.kernel.org; Tue, 28 Jul 2026 18:28:01 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References
	:To:Subject:MIME-Version:Date:Message-ID:From:Sender:Reply-To:To:Cc:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=BXbYwuLbaitr5a9MDJQXB5S20faXybRpRnJtqxxqqOk=; t=1785252481; x=1785342481; 
	b=FhgIffsMEqkRGAUhqVoDeo33j270842FVvFr9WbZMlQijIg5JcJAVm4wYs35mSduSTTKLN9zNG/
	bU9RNhdevGjEHTNOXuXMH3JUNuWX/cU/wZv8K6qFdVCqXwX75rcpA7daxmAyCV6bB5oOm78IvCcb0
	/r+qinDfgWwRmch4TBA0JwKJ4S8paGKLAawqeVNUlRa1fZBB+9a4aKqKRBcZsIyBvvyOCA6Jn516t
	duGwNIcLSFpjeBkrIAkAKS0UQHwv90+kaBGcXFckxkKvX7Uc+ZAMRTHPaQHcTKDSVpS+SUZvmLV9s
	Mbt6SxODqGr5THEmya/hVT6mdwYDj0TgskcQ==;
Received: by exim-smtp-6bc4cc657b-5bznt with esmtpa (envelope-from <long76.git@mail.ru>)
	id 1wojih-000000003tZ-2Wen; Tue, 28 Jul 2026 18:27:52 +0300
Message-ID: <9ee7b916-a9ce-4300-baf4-b24d0a52fe46@mail.ru>
Date: Tue, 28 Jul 2026 18:27:51 +0300
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: REBASE_HEAD still exists after success end rebase
To: Matt Hunter <m@lfurio.us>, git@vger.kernel.org
References: <edfc868b-6be6-4871-a539-e70791db216d@mail.ru>
 <DKA3RP12A8LU.2VD89MQ7G2KLL@lfurio.us>
Content-Language: en-US
From: Long 76 <long76.git@mail.ru>
In-Reply-To: <DKA3RP12A8LU.2VD89MQ7G2KLL@lfurio.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailru-Src: smtp
X-7564579A: EEAE043A70213CC8
X-77F55803: 4F1203BC0FB41BD9C208BCBABA4BDCEA74E992CA62641EC6E69F963F4B1EC6F5182A05F5380850404C228DA9ACA6FE27376364C2308783533DE06ABAFEAF670569608B39E62FE0F4C9AE6BEE73B3A4F587940C845C9D7C7C
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7F9D3BE5B596754B8C2099A533E45F2D0395957E7521B51C2CFCAF695D4D8E9FCEA1F7E6F0F101C6759CC434672EE6371C2A783ECEC0211ADC4224003CC836476D5A39DEEDB180909611E41BBFE2FEB2BE267DD1575EE63CDECFF40451C75720F9F193CA2E806E3CF41ABE5FAE8A937650C819B32DFABC24A725E5C173C3A84C390D92131081DE748117882F4460429724CE54428C33FAD305F5C1EE8F4F765FC081CF0AE924DC023A471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F4460429728776938767073520B1593CA6EC85F86DC26CFBAC0749D213D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EE26055571C92BF10F452896749CDDA0A6D8FC6C240DEA76429C9F4D5AE37F343AA9539A8B242431040A6AB1C7CE11FEE32D01283D1ACF37BA03F1AB874ED89028C4224003CC836476E2F48590F00D11D6E2021AF6380DFAD1A18204E546F3947CB11811A4A51E3B096D1867E19FE1407959CC434672EE6371089D37D7C0E48F6C8AA50765F790063719C769067E8F2942EFF80C71ABB335746BA297DBC24807EABDAD6C7F3747799A
X-C1DE0DAB: 0D63561A33F958A5490D7E7B3AF3D5295002B1117B3ED69633025B1410DF83DD54BB1175C6E7DD943610D81D389A125CDE35189EBF2DEA28FEA14CD2CD220BB99C5DF10A05D560A9880EC71AF561E0AAD9143641EC25BB39CC2F3E6DF6689A16
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE1918E10F71CB4DF9F9677DD89D51EBB774225B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D659A35F7744BE51F939D879FEBA09F9BD4269FF4B44652333D6A6985E5BF7A12C3387E606A5CC54422CB8341EE9D5BE9A0A04BF348ADA31A601D131F03A8772E519ADA5280EB9C268748CD93680B12512CF4C41F94D744909CE06349EBF80BA53DC7F80F8B16B0B4F5BC3981EEBE9DB10F943082AE146A756F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXMZebaIdHP2ghjoIc/363UZI6Kf1ptIMVczkDsfooUjfZ8/5aioXLDU=
X-Mailru-Sender: FA56D3AF5E7ABC7464DC1CE9D819784E7F26A6C00E8045F83DE06ABAFEAF670569608B39E62FE0F4B7CBEF92542CD7C86E6763FEFA0584FA91296853BA92DB573F2CD06A13C360CFE5A15ED4F09F547DA6B405093FCEE899451FCD79C64DC368C77752E0C033A69E3453F38A29522196
X-Mras: Ok
X-Mailru-Src: fallback
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B42CD459FEF794EC2C492BBD0D7572DF240EBBA641EA382894049FFFDB7839CE9EC750E04395D27384788FFF19CE74BE960BC5A9DA48A2F6B49A13ED0C9CFA31418498557B6A1CBFE0
X-7FA49CB5: 0D63561A33F958A5840C21FCCAB5506B5002B1117B3ED69663B790108C7F9B6C4E82D2634811542802ED4CEA229C1FA827C277FBC8AE2E8B93B120FAD52BA009
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+OYcBso8Zm+oliTz8oZwnDrFsY77LZRcHyw5ht0smWrfSeTW5FiI8avd9v29gUBslpEZ9wIMwqVP4jLQVQ+dVm7x9BpDHadBV9RMjI809PraZgueHt3aoMlO/T1l3J3a7Mg==
X-Mailru-MI: 20000080020000000000000800
X-Mras: Ok

> I made a very short-lived effort to look into why this "bug" was
> happening.  I say "bug" in quotes, because I'm not even sure if it is
> even problematic behavior.

I think this is a bug because git create similar HEADs if you made merge 
or cherry-pick. I don't have problems with them.

Plus by git rebase docs on official site flag '--show-current-patch':
---
Show the current patch in an interactive rebase or when rebase is 
stopped because of conflicts. This is the equivalent of git show 
REBASE_HEAD.
---
For me it means that return patch only if rebase in progress - not 
aborted/not complete/have conflicts

> I solved my need at the time (detecting a rebase in progress) by
> checking for the existence of either of the 'rebase-merge' or
> 'rebase-apply' directories in $GIT_DIR.

Thanks for advice! I don't knew it.
