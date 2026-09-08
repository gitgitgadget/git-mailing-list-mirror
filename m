Received: from send175.i.mail.ru (send175.i.mail.ru [95.163.59.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B764228504F
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 16:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.163.59.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788883210; cv=none; b=tRpEDmoh6kpp/EJVgmc1tFMimLVvxSz98v6XDjqniwXm+55ZdMdWkSaRXN5Wk7HGxqDvr7OiQfqj2RhST/JvXswwlA3xX0N8zbrsWZA3ad5Naxr1nkzgSxo3d01in42QnudujCmBEVfZ0KnKF3219tLXa3zMwX0W7Mt0qm4OJaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788883210; c=relaxed/simple;
	bh=oEocdfuhAr51g/GJ1bgrQheKTzME1vXxx4XLES3u4vs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vp20RqKf0hEjStu5gXDRT0LtUhjvVPidmFMasYC+DuGMTCV8uFNWB4QJ4tdkO9OKJTnOwoWWJ3hqnmtZjPlvsF9/VtAyz1Ps2zKPZ2rWIfypwV7N/RoNV5OXh0jzH3C98WPfTGNbIjkINBqetVofylqf4JpE1ld9JfsBTrGoyro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=iF3E3c/r; arc=none smtp.client-ip=95.163.59.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="iF3E3c/r"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References
	:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Sender:Reply-To:To:Cc:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=oEocdfuhAr51g/GJ1bgrQheKTzME1vXxx4XLES3u4vs=; t=1788883206; x=1788973206; 
	b=iF3E3c/rt2jUmb2kA4BBM7OLQ/QeushJ6gyu4xO2R6mml2OpWJ1xcmoJd/yrYoGq3xwweTrbi3D
	2z9VzoA4zg0gSweh/74teFmDegY50fjxAL+dkil4Ultq7CJZWQwnLIdh3N6g1lUcV04q6wEu70wo9
	cq2xdTyJ744Zi5WEYHL3HLOpUtLJIsq/86ILbDadsG7YC2XmSYPLtigNM/EKqQ8/xhh3EffA3ksYe
	fp7vFVg+1A0r7gUoG0rJ3bLv1MfLZ+zOLumKjrwTzZcfa68M7Pny4x+HU9D5ZLJNAZvI+twanIit3
	QlA6cF1lquEK9Tzwp3RiEA1CHKV8Ghgl6Gfw==;
Received: by exim-smtp-6d4cb84b5f-fvx8f with esmtpa (envelope-from <ub4nal@mail.ru>)
	id 1x3yEm-000000004nR-0WsW; Tue, 08 Sep 2026 18:59:56 +0300
Message-ID: <7a77ce52-b7d4-4818-9b9b-052d5922db2f@mail.ru>
Date: Tue, 8 Sep 2026 22:56:05 +0300
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] advice: use global config for default branch name
To: Ben Knoble <ben.knoble@gmail.com>
Cc: git@vger.kernel.org
References: <20260908185653.34702-1-ub4nal@mail.ru>
 <7D54AA3C-0724-4C8A-9CB8-64150CD3A051@gmail.com>
Content-Language: en-US, ru, ru-RU
From: R4NC <ub4nal@mail.ru>
In-Reply-To: <7D54AA3C-0724-4C8A-9CB8-64150CD3A051@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: exim-smtp-6d4cb84b5f-fvx8f; auth=pass smtp.auth=ub4nal@mail.ru smtp.mailfrom=ub4nal@mail.ru
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: 78E4E2B564C1792B
X-77F55803: 4F1203BC0FB41BD95DFF9E80284F3C70CCD346DD139A4DBD80A62299F1DFCA68182A05F53808504068897DEE3C57EFC83DE06ABAFEAF6705D1710E2C61368DFB8CD3F24A9B236ADAB51ED77CA72DA256
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE77E216A0E97507353EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006376A27C8034CCD05E58638F802B75D45FF914D58D5BE9E6BC1A93B80C6DEB9DEE97C6FB206A91F05B2875DA5E2921F71952E070BE324C7D3C424D7AE4325F48B40BB0A4F435E46E6718B35066C979671628AA50765F7900637B0AEEAD3B54690CB389733CBF5DBD5E913377AFFFEAFD269176DF2183F8FC7C0EF2A066DDA19BA868941B15DA834481FCF19DD082D7633A0EF3E4896CB9E6436389733CBF5DBD5E9D5E8D9A59859A8B6D6FBC3EC642A93BBCC7F00164DA146DA6F5DAA56C3B73B237318B6A418E8EAB8D32BA5DBAC0009BE9E8FC8737B5C2249EC0BC6DB5D5D7B8B3AA81AA40904B5D9CF19DD082D7633A0C84D3B47A649675F3AA81AA40904B5D98AA50765F7900637F6DB9CFA2D28648BEC76A7562686271ED91E3A1F190DE8FD2E808ACE2090B5E14AD6D5ED66289B5259CC434672EE63711DD303D21008E298D5E8D9A59859A8B6B372FE9A2E580EFC725E5C173C3A84C395B9C3A3180B059335872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-C1DE0DAB: 0D63561A33F958A5D383DCDF7488D1315002B1117B3ED696D2F7F8E1CF686AFF1A1B8FE1FED62FE8823CB91A9FED034534781492E4B8EEADB05233B9BC4759D3
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE1918E10F71CB4DF9F96AB70F9BE574AE9C625B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D6593383889E408DE0B760E33BB27A218A9226CC0A377AF79B19E2682DE61223CFC389CEF97D1BD2EAD5B8341EE9D5BE9A0ACCAE503655261E7B677647AFCD5EE83AA719A6C28D89C86C8CD93680B12512CF4C41F94D744909CEFACD6B4B6D928230F8CCC96A59B602D5CC2E138FFB4ACBED
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXOcIETfglQORZ0zpDET4Zrk3igikrdHlWG5Pw7ST4DZfl/VZul3y37o=
X-Mailru-Sender: 288943BA7BCC8BBA065C24D5D0D78BBDC511E7B36B4B2A703DE06ABAFEAF6705D1710E2C61368DFBA165F1893FAC5C75730F10A35ECD6C905A92E71CC7C3152D8DFEC3831B33C4D004BC3E28E37B34A4E9BE5789416A142FC25A2993B28EC86D9FF92CA8FAC60DF8EAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok

> That also seems good to me. I think I prefer it.
>
> PS it is normal here to bottom-post and quote at least the
> relevant parts of the message to which you reply 😉


Thank you for the review and for the formatting advice.
I will send v2 of the patch with the global_hint field added as suggested.
By the way, is my reply formatting correct this time?

