Received: from fallback1.i.mail.ru (fallback1.i.mail.ru [79.137.243.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F721DA31D
	for <git@vger.kernel.org>; Wed, 14 May 2025 11:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747221974; cv=none; b=Gcdqn83jXo6sHeAqhKCBKQu8u8vp47pRVB0WUfWPtasZDsCymGamWbSOdWbvdh5pdHxTLUIHWKoFCsPWRtiQpHH0NIQtfVP/uH8R1YquT5/Cv/N/Ui3MFJgTzKeCAdAFlDCGqNNzozkHtmLFOQeb9tTE3Y8fIHDkgF7doEvEhvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747221974; c=relaxed/simple;
	bh=4dWLfQ4GwIi0WMhvhKqslwHqwr9Q+nGFQICFpJMWlvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AJ9GfCFzwkKdrbsySyU9Vk1V6zhlj4wfw+acZy4bjEErO1XsXbBHu0DOa9QRxVQrHDs98yyIRdsan2w3ds9pz4q/Jz5vAnzAEV/vZQgXz95TENrHtLjdyKFCubkzQw3KJ/n5hchm5Ak6/88c2cTaJ24Of0m4u9zGqLFxBN1Bzvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bswap.ru; spf=pass smtp.mailfrom=bswap.ru; dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b=nyrclTsb; dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b=w3PuGQR9; dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b=oyTsIo6R; arc=none smtp.client-ip=79.137.243.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bswap.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bswap.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="nyrclTsb";
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="w3PuGQR9";
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="oyTsIo6R"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
	h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=4dWLfQ4GwIi0WMhvhKqslwHqwr9Q+nGFQICFpJMWlvA=;
	t=1747221968;x=1747311968; 
	b=nyrclTsbrdHpV1ik1hTyOxdXoawEujhJ7tgxmC7CSHxgTEXY+YT/VyFEtK1dum0XGHJ2it2/CjJlV34HAkEGrDx+byXnnyOeCQrL67CMx4WNX2wBRmzPUVmRYQxBZx+5w7UeJUMgQx54eCUAsRzMeDQAR1xLEZxzG4AjSJmvax4=;
Received: from [10.113.6.238] (port=46266 helo=send100.i.mail.ru)
	by fallback1.i.mail.ru with esmtp (envelope-from <kostix@bswap.ru>)
	id 1uF9Sr-009d0i-5u
	for git@vger.kernel.org; Wed, 14 May 2025 13:35:53 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru;
	s=mailru; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive:X-Cloud-Ids;
	bh=4dWLfQ4GwIi0WMhvhKqslwHqwr9Q+nGFQICFpJMWlvA=; t=1747218953; x=1747308953; 
	b=w3PuGQR9dBQ3DeJDI5qPE27LpYWYk6nj08cu1w4tUcYfxyb5u5ye//8U+kcQVI+kGkZBqLaQ9f2
	Tivma9TBiFg8IQMkPQ9aP9Z8uLyLJHsNkykuvZkIn2mP0yNJ6jIrYvU1gsNFwPnGQYhixg7iFTHHT
	XTduuKRBCA/gupRKLtA=;
Received: from [10.113.197.21] (port=57702 helo=send242.i.mail.ru)
	by exim-fallback-599f6d4865-m6hlq with esmtp (envelope-from <kostix@bswap.ru>)
	id 1uF9Sj-00000000Le5-0G9P
	for git@vger.kernel.org; Wed, 14 May 2025 13:35:45 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru;
	s=mailru; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:To:Cc:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=4dWLfQ4GwIi0WMhvhKqslwHqwr9Q+nGFQICFpJMWlvA=; t=1747218945; x=1747308945; 
	b=oyTsIo6RywHNuAR/WX9QFMpkaV/wlFCiewAl+yFvgNgzyEPnp0LRAKBri3pcE951O96h+wBHkc1
	yUec7XkmXuIaCOrlmLMx4aJBp/ACvzzzioWJfPZ7gjX67UnttMkv8z1T4Vn8TNQS3nc96i2Wt9MeC
	jcBwFuQal1ju5qhr4Gg=;
Received: by exim-smtp-6c9b7b7598-z6bcv with esmtpa (envelope-from <kostix@bswap.ru>)
	id 1uF9SZ-000000001jG-3Xet; Wed, 14 May 2025 13:35:36 +0300
Date: Wed, 14 May 2025 13:35:34 +0300
From: Konstantin Khomoutov <kostix@bswap.ru>
To: =?utf-8?B?6Zai6Kmp56mO?= VANESSA <VanessaKuang@cathayholdings.com.tw>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	=?utf-8?B?5by156eA56mO?= KITTY <kittychang@cathayholdings.com.tw>
Subject: Re: [External] Re: Get support
Message-ID: <20250514103534.hogdmvvqzxkhpuki@carbon>
Mail-Followup-To: =?utf-8?B?6Zai6Kmp56mO?= VANESSA <VanessaKuang@cathayholdings.com.tw>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	=?utf-8?B?5by156eA56mO?= KITTY <kittychang@cathayholdings.com.tw>
References: <1744786449-14024-mlmmj-0f30ebef@vger.kernel.org>
 <202504160735.53G7ZjeU083840@365mse01.symphox.net>
 <dc58a9ce-3d02-bb52-bfe1-7427333d6128@gmx.de>
 <202505140148.54E1m51Z028606@365mse02.symphox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202505140148.54E1m51Z028606@365mse02.symphox.net>
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9F7319ED2C58FD6221EF51451AB9682B70E74037EB7BE3006182A05F538085040FF7AAD82E13F63A73DE06ABAFEAF6705BC3F58937801C9E85A161C0F6F569FDBF06A99D732682DD8
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE749E89BD568380EECC2099A533E45F2D0395957E7521B51C2CFCAF695D4D8E9FCEA1F7E6F0F101C6759CC434672EE6371C2A783ECEC0211ADC4224003CC836476D5A39DEEDB180909611E41BBFE2FEB2B8787B117BF392CC3D6449A8380C97F57F5465595DAD9058F3C32CC600A13A9EB9FA2833FD35BB23D9E625A9149C048EE33AC447995A7AD18F04B652EEC242312D2E47CDBA5A96583BD4B6F7A4D31EC0BC014FD901B82EE079FA2833FD35BB23D27C277FBC8AE2E8B8C7ADC89C2F0B2A5A471835C12D1D977C4224003CC836476EB9C4185024447017B076A6E789B0E975F5C1EE8F4F765FC75B7A1B89F33CEE13AA81AA40904B5D9CF19DD082D7633A0C84D3B47A649675F3AA81AA40904B5D98AA50765F79006374831FD27DAE3AC17D81D268191BDAD3D3666184CF4C3C14F3FC91FA280E0CE3D1A620F70A64A45A98AA50765F7900637A451E1E29F2EDBED6D1867E19FE1407978DA827A17800CE7FCEEFFE83360B3FE2DBA43225CD8A89FD2A95C73FD1EFF4557739F23D657EF2BB5C8C57E37DE458BEDA766A37F9254B7
X-C1DE0DAB: 0D63561A33F958A5B42B7E4896B85D405002B1117B3ED696FB2F75E34EE44BC819AC5B239BAD4335823CB91A9FED034534781492E4B8EEAD37F46C620FF2CAEEBDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADBF74143AD284FC7177DD89D51EBB7742DC8270968E61249B1004E42C50DC4CA955A7F0CF078B5EC49A30900B95165D3463DBE2ADA183F62F1868AC89DE9B5236A44C0753FD80C0BC69DD9E06C570288ADA9B3A44776374471D7E09C32AA3244CF527A1B9D744111477DD89D51EBB774298C6DFD876D3B7B0EA455F16B58544A21C197AAF4D2E47323871D1C702CBDB0A9665A0FD7AD89E8F722DFA761B3F797A
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXMZebaIdHP2ghjoIc/363UZI6Kf1ptIMVT0GoR8ZYDe7sTHbWlLh+TI=
X-Mailru-Sender: 139A7956A63CACCF7216901AE3D43F14DCFF7CBB5B7CCDB6B951B70A5BD4BD8E22B16FAFC42B9CFAFB69FB06705AFC99FD27B1545737DED76F53C80213D1719CB3360D9C94DE366A1CC4A9B39F20364B73395D515EC5B64A0D4ABDE8C577C2ED
X-Mras: Ok
X-Mailru-Src: fallback
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B487FBEC70FF4ABE636DA1D614FB4F4B5D0DD02B88C0133752049FFFDB7839CE9E435885B129E9360CE9168BB3DA7F78421EA5B82787716AE5B3D36B5EF3B9C4DB21164515FD2A1C3B
X-87b9d050: 1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+OYcBso8Zm+oliTz8oZwnDrFsY77LZRcHyw5ht0smWrfSeTW5FiI8avd9v29gUBslpEZ9wIMwqVP4jLQVQ+dVm7x9BpDHadBV9RMjI809PraZFPhXGAnw71LXVDAHWlwDOw==
X-Mras: Ok
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B487FBEC70FF4ABE636DA1D614FB4F4B5D751ECDB8215F2B68049FFFDB7839CE9E435885B129E9360C6C17005B0814E8FF601A7B48E128386CC8A4EF704DE7CC0A
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+OYcBso8Zm+oliTz8oZwnDrFsY77LZRcHyw5ht0smWrfSeTW5FiI8avd9v29gUBslpEZ9wIMwqVP4jLQVQ+dVm7x9BpDHadBV9RMjI809PraZFPhXGAnw71L3VmZQh0A0eg==
X-Mailru-MI: 20000000000000800
X-Mras: Ok

On Wed, May 14, 2025 at 01:47:57AM +0000, 関詩穎 VANESSA wrote:

> What does the "..." at the end of the command
> "git -c http.sslbackend=schannel clone ..." refer to?

That merely stands for "the rest of your original command".
In other words, the proposition is to add that "-c" command-line option
and the indicated argument to it _in front_ of the command name itself -
"clone" - and the rest of the parameters you pass to the command,
that is, any other options and the URL you pass to the command when it fails.

This thing is called an ellipsis [1], and Johannes used it for intentional
omission of text which is not relevant.

 1. https://en.wikipedia.org/wiki/Ellipsis

