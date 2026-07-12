Received: from send147.i.mail.ru (send147.i.mail.ru [89.221.237.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF433655D4
	for <git@vger.kernel.org>; Sun, 12 Jul 2026 18:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.221.237.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783880599; cv=none; b=J8lBB+hupfLU9PiqCbqXzTpq5PwHMsyJC1g0VzvaDpnZV6AxT1yx8f4F7T3+AGfSFHPNB2lCoZbhWhMPhb4Wh12E9GowgHsMddk5A6nNtYf9ozPCy6m8CGZ+t4HZPj3iD+oOSz5QWSX8sKadk1nG3HAMHBcouuHNa/duJacYm7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783880599; c=relaxed/simple;
	bh=eOnycYucV2hSrGVZhZpP0eE/Bf8/AKmh7xBpQE4jp9I=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=ceZIwL+HhP67RpcWyIJtvdsOey+8aUN1FqVLs9ZTNzM9PIwME8Ia+9m92fxfAjVQqZuWidSZAZh2Bw2Kc6/w6l8UUIWr4DRM2hNfzT7Wo5Ju1siwxKoUBMrBwMUp+1Dp/vYdz8sm1wMaDBYYdDv0Xn3FObmgPePgDmP641zr+g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=QcStNt15; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=k4V6J2tX; arc=none smtp.client-ip=89.221.237.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="QcStNt15";
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="k4V6J2tX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	Message-ID:To:From:Date:Sender:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive:X-Cloud-Ids;
	bh=eOnycYucV2hSrGVZhZpP0eE/Bf8/AKmh7xBpQE4jp9I=; t=1783880594; x=1783970594; 
	b=QcStNt15J5GugB4OW7ZaBoPdJJur+kkcTmz2J169RGMIxQiy6uGq00vDM+Rq7gkoYv9MkW9uSSD
	pSjgNJNJ5deps73MCXO7EZ4XuJHk5Xl/39jwZYXu+hIFUN+aMHSKyIdben2ytOTAc9d5t0lttK4mw
	9XvHOld2+cZdUhCLk7OeZCVz38IDxxF1k2rzpTyrD2bd1U/2IiuqAUn9WEPAVUouaNE6k7arjpqBi
	1eDxeBuVrz5pfRlV0h/YcNzlpLLGgwmyqGvLt/s8kuhutJWeavb2FBNoF3t3dT7MB+uE9ZS6YQbxM
	0Yrh1SrU63+TwEXVj22PYq5/2IJVDt8UbCrg==;
Received: from [10.113.207.208] (port=55420 helo=send195.i.mail.ru)
	by exim-fallback-7c89cdcb84-fwlgb with esmtp (envelope-from <lmybizexplore@mail.ru>)
	id 1wiyax-0000000017h-41qK
	for git@vger.kernel.org; Sun, 12 Jul 2026 21:08:04 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	Message-ID:To:From:Date:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=eOnycYucV2hSrGVZhZpP0eE/Bf8/AKmh7xBpQE4jp9I=; t=1783879683; x=1783969683; 
	b=k4V6J2tXSwQSESOCc/8KKxb9+7ozfQJz7pIgmISFRKs+WZeTlc0XtMczlAMvUmij/eyVpJ/aaP4
	x3e+4hud8afzHH5pMd9zBjRDgbaEjRN9P08UnbuStTcd7UPFUb2m7rjMSAgbeenaVZNPDdNVii201
	VtltV7MTuhZUOA5aKF9odzNvZtBH/G9wFj13EeYD7ui+1HqmEOb7FBbrViaodLd8MVWL+0IGKWLGd
	Vgt9XZD7c+0UEEdEqHds++K3FUvXgWCJZgjGoGYk1rrhL6Ig/xw2J5hFfEC4+Iqlf5pnFsVtKYcWG
	TTtgBTafXvNc9qPHTD23XelGRObyaPvPfaNA==;
Received: by exim-smtp-77575cb4cb-v6bj5 with esmtpa (envelope-from <lmybizexplore@mail.ru>)
	id 1wiyao-00000000RG6-3Huu
	for git@vger.kernel.org; Sun, 12 Jul 2026 21:07:55 +0300
Date: Mon, 13 Jul 2026 02:07:51 +0800 (CST)
From: lmybizexplore@mail.ru
To: git@vger.kernel.org
Message-ID: <1930746005.63.1783879671188@rocky9>
Subject: Provide a free license for git-digestif; just add a link in the
 README
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD96CA1B9A22B2C1679F2982119F68FFE40C3AFCE34130582FD00894C459B0CD1B92232D9C345F6874503AAE3001806DF10CD9864B9C8166D38350D9CE83AA25DA3E1C7414A75FA687D
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE721B3E54BB37EA0B4EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F790063716A4A39B750036BB8638F802B75D45FF914D58D5BE9E6BC1A93B80C6DEB9DEE97C6FB206A91F05B2C1DD545E1256144F2E070BE324C7D3C4721D470758340B4FBB0A4F435E46E6718B35066C979671628AA50765F79006370277CA7F994D7EF5389733CBF5DBD5E913377AFFFEAFD269176DF2183F8FC7C05A64D9A1E9CA65708941B15DA834481FCF19DD082D7633A0EF3E4896CB9E6436389733CBF5DBD5E9D5E8D9A59859A8B6A70DDFFB3186CBC5CC7F00164DA146DA6F5DAA56C3B73B237318B6A418E8EAB8D32BA5DBAC0009BE9E8FC8737B5C2249531A55D58DCEA3EC76E601842F6C81A12EF20D2F80756B5FB606B96278B59C4276E601842F6C81A127C277FBC8AE2E8B8BB5D02FD165DE013AA81AA40904B5D99C9F4D5AE37F343AD1F44FA8B9022EA23BBE47FD9DD3FB595F5C1EE8F4F765FC72CEEB2601E22B093A03B725D353964B0B7D0EA88DDEDAC722CA9DD8327EE493C1DE5D12A4F17E62B17145F0B7815491C4224003CC83647689D4C264860C145E
X-C1DE0DAB: 0D63561A33F958A5E971C113E7BE9BDA5002B1117B3ED696813CC25128E63987C81EEE05487B0209823CB91A9FED034534781492E4B8EEADE14026A7C64A50DCC79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE1918E10F71CB4DF9F9677DD89D51EBB774225B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D65900F96429B2E56BF1341B58994DD799214FEA56EA8BEF54AC9F482488F41BE2B719843D93AE7B0E22B8341EE9D5BE9A0A1F5F94AA649EF2CE74197E89C5738EDD09F2E9446673A64F52EE4E5D9E54FDA44C41F94D744909CE0572427D3F1A632A8B464BA81E5371C4528094344F5D571A37E69C174A41D00C
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXMZebaIdHP2ghjoIc/363UZI6Kf1ptIMVQ2xbpK5Vic+3nYQ6n4CfSg=
X-Mailru-Sender: 9C17D10B238D8B9B47E7CFD794F4B943E9DD7B85CBF85575B951B70A5BD4BD8E763D7DFD26D916C3114698FBA59F30EEA59D6BEC59BFDCDD3DCCF50608321A3F9B3666A30D01B465016C7DB71B48C40BF8BDA277DCE1E2E86B952FAA15F080A467AFE9CA6190D88F287DB6D8621EF7B9C77752E0C033A69E3453F38A29522196
X-Mras: Ok
X-Mailru-Src: fallback
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B424E95952352771B357573BD49B7D38DE1C8CF2B7FAC1C13B049FFFDB7839CE9EE733F854F48983C863EA1D16DFE5A0DDE2DC61A385A1E562713D14B56E4A20065A325820AB35847A
X-7FA49CB5: 0D63561A33F958A5F3801053E9A3D2545002B1117B3ED696AB2F81D7FEB15AACDF65068396D3048702ED4CEA229C1FA827C277FBC8AE2E8B54F520D093A0DF28
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+OYcBso8Zm+oliTz8oZwnDrFsY77LZRcHyw5ht0smWrfSeTW5FiI8avd9v29gUBslpEZ9wIMwqVP4jLQVQ+dVm7x9BpDHadBV9RMjI809PraZIj7+JDW3S6/Q4DnZDE3CSQ==
X-Mailru-MI: 20000080020000000000000800
X-Mras: Ok

The target organization maintains an open-source project named git-digestif on GitHub, providing digest services for Git developers. We are Weifang Leimingyun Network Technology Co., Ltd. Our team specializes in AI research and development. We have just won the second prize in the National Artificial Intelligence Competition for 2025. Our core product is an AI-based customer acquisition robot that enables automated search across the internet and human-like communication. I would like to provide you with a licensed version of this tool for free. In exchange, all you need to do is add a hyperlink in the README of the git-digestif project. I was wondering if you would be open to this collaboration model of replacing software licenses with README links?
