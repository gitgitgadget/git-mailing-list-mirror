Received: from send101.i.mail.ru (send101.i.mail.ru [89.221.237.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87E12F8E9E
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 17:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.221.237.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788889853; cv=none; b=WRCxgtjXncAtWMDswjHlceBiRtIwUwzpTf7sw5BPFMpkOtCwf8Mld2LliiESOI1UApw46ljSqj8SDwUrWnHl3cnoc/KZl6y6R0AtsIcvVabHALdpX7zTnEgiwsf5DdEAQ85VgJmBOexv+L94V8H6jT5kN1Xa1Nw5IoZfAsd9bC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788889853; c=relaxed/simple;
	bh=xNOf0L6FhudkwLQIYl5Jked1RAMKpOG5OUH3IsH/R8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WD5k/ZJKVQjk26cqCLH9wK0PuObfa8Fqb3dIldTZ0wVu0XoAWW3RmeEj4ofXTO4kW1ThB+YJSNe9CkFEndjUCy+9oynE1EguAgIBoOM2WqiQO7xQi21ThrA0q/z6j4sntPxu7g6y5VVg61MV2UxSe8rcQ1IbdHWYDNK9f8RehLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=VVpeQrmM; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=LaLo3iVk; arc=none smtp.client-ip=89.221.237.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="VVpeQrmM";
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="LaLo3iVk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive:X-Cloud-Ids;
	bh=jkgX+YwRGZGyqRC3VEppoyEivTcLS5+5uN+NtLQqSt8=; t=1788889849; x=1788979849; 
	b=VVpeQrmMUXs7LUCCnD3N5993sNFIZi4MvE6TlwqM6S3eVF9gvXwpea2vHR10zgD0a1vhPYuq5dr
	dxq1AkmhI6+n80bo4I9OWab1e3jqst1mJ4JTa8oViT2b23Tt/oNwDiKRX2cLkMoS0K0oy448w9ISW
	hTi0R1UxWgDQ2MDw6BdsmM5x28nPiDmYOBBh0jGx6vgH/BnisqGporH4NmLK1DMdMxCmils7oFzOX
	cGvbnTMpVnXFs8zCDuTgavJ78gCR/efisaxZLRNGE4cj1wtrTTPD5Uyl1XlVRd3zZVPyLWp42f0Ka
	QORyr8kU5eaTqGxnksgIWf+X+ykZC1drJC7g==;
Received: from [10.113.139.104] (port=51578 helo=send217.i.mail.ru)
	by exim-fallback-679568fb9b-58wq2 with esmtp (envelope-from <ub4nal@mail.ru>)
	id 1x3zjO-00000000IeK-1KmY
	for git@vger.kernel.org; Tue, 08 Sep 2026 20:35:38 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=jkgX+YwRGZGyqRC3VEppoyEivTcLS5+5uN+NtLQqSt8=; t=1788888938; x=1788978938; 
	b=LaLo3iVkDTAyRD85PxekLp1y337J2eBr5QabF39di99Wut/3ygeb7nvq23t3seu9uueePfopXAe
	npyGf04mU3p6Obk9dlHXTlhAFZotBLE45SUSWBo6kQ9vu27Mc0cJU+2q/cfN/cO/qE70CJgKOWnyG
	PQuhE0GthcdGa8QzJhV7YjVEPOV8GmY6miKK8lHKtms/TJaCFKOGlCbJxcBabXIL3bHnau6kvQXf1
	anGd23RwbWlGUC4TgbQxFH0y8N7YnlagJnJSitqVaOGxB4ZCS/WOvIa0hldr7m3vQ6cxmbhRqkt7b
	npNrQgRdZMeNvnNaj6dRKQz0c9C6WVBd6sCA==;
Received: by exim-smtp-569b45c49c-vlj65 with esmtpa (envelope-from <ub4nal@mail.ru>)
	id 1x3zjF-00000000Ewz-1ZNW; Tue, 08 Sep 2026 20:35:29 +0300
Received: from vatem (localhost.localdomain [127.0.0.1])
	by vatem.localdomain (Postfix) with ESMTP id 6F1969F60D;
	Wed,  9 Sep 2026 00:38:41 +0300 (MSK)
From: Vsevolod Myalitsin <ub4nal@mail.ru>
To: gitster@pobox.com
Cc: ben.knoble@gmail.com,
	git@vger.kernel.org,
	ub4nal@mail.ru
Subject: [PATCH] advice: use global config for default branch name
Date: Wed,  9 Sep 2026 00:38:39 +0300
Message-ID: <20260908213840.37833-1-ub4nal@mail.ru>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <xmqqik4fyaav.fsf@gitster.g>
References: <xmqqik4fyaav.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD978AFEFB3096932CFF700118563EFB2E2663B32B513788A1F182A05F538085040B655ED71D35116183DE06ABAFEAF6705768BAD06321D5713BD9860E3BCD0116F76BFA05F37B44EAE
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7956F10FFCC7409BAEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637AC83A81C8FD4AD23D82A6BABE6F325AC2E85FA5F3EDFCBAA7353EFBB5533756682FC6F8CF4E8B72783DD76F024139A4A6F338C699368A6256D893ECA4802A44E8EEF46B7454FC60B9742502CCDD46D0D251EFD5447B32ED6F6B57BC7E64490618DEB871D839B73339E8FC8737B5C2249D6FBC3EC642A93BBCC7F00164DA146DAFE8445B8C89999729449624AB7ADAF37F6B57BC7E64490611E7FA7ABCAF51C92176DF2183F8FC7C06030C3405640F6718941B15DA834481F9449624AB7ADAF37BA3038C0950A5D3613377AFFFEAFD269176DF2183F8FC7C08FA19D15F4E81F177B076A6E789B0E97A8DF7F3B2552694AD5FFEEA1DED7F25D49FD398EE364050F9647ADFADE5905B14D0DA9BD313A0613B3661434B16C20ACC84D3B47A649675FE827F84554CEF5019E625A9149C048EE9ECD01F8117BC8BEE2021AF6380DFAD18AA50765F790063735872C767BF85DA227C277FBC8AE2E8BF06FF5FC0997E3F8EFF80C71ABB335746BA297DBC24807EABDAD6C7F3747799A
X-C1DE0DAB: 0D63561A33F958A576B473C6667A247B5002B1117B3ED6968F861C56B52318361A1B8FE1FED62FE8823CB91A9FED034534781492E4B8EEADA3FB0D9844EF8EC5C79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE1918E10F71CB4DF9F96AB70F9BE574AE9C625B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D659770A4579CB446F12895CF6AED37C73BF21B854C01CC63AF399876723662AA5C7E02657AF0C8BE53CB8341EE9D5BE9A0A207E0E5F1257F6E3FCCAFFF43493B75DD7C2E7B5C3270BF5C7CEAA0681F5848F4C41F94D744909CEFACD6B4B6D928230F8CCC96A59B602D5CC2E138FFB4ACBED
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXOcIETfglQORZ0zpDET4Zrk3igikrdHlWMOZOnz/qg6dOphDQ8QPJMA=
X-Mailru-Sender: 288943BA7BCC8BBA065C24D5D0D78BBDD3A220D1F22B08083DE06ABAFEAF6705768BAD06321D5713A165F1893FAC5C75730F10A35ECD6C905A92E71CC7C3152D8DFEC3831B33C4D004BC3E28E37B34A4E9BE5789416A142FC25A2993B28EC86D9FF92CA8FAC60DF8EAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-Mailru-Src: fallback
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B4C775F1C6D245C3DB5007E8F23A2D14378981866A8E92ADE968F3CF0E9FE49B6969BD46589B4184D1C0CB12FD92B9ADD56A774EE24C31C8B0CE06F7EA77EAB5FA42EB6A82DDE83E16
X-7FA49CB5: 0D63561A33F958A5DDB0ED1202FB5AC45002B1117B3ED696AC001A8855828E9000EDBF7D0CBF301602ED4CEA229C1FA827C277FBC8AE2E8B54F520D093A0DF28
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+OYcBso8Zm+oliTz8oZwnDrFsY77LZRcHyw5ht0smWrfSeTW5FiI8avd9v29gUBslpLaIlvAR6h4id02YH9mgeCTAyYoNlVO8a1SpzZpj/QBfln/xsq3LHs8=
X-Mailru-MI: 20000080020000000000000800
X-Mras: Ok

Hi Junio,

> Should it only about "global vs local"?  I am wondering if we ever
> want to suggest "system".  In any case, these three things are
> called "scope" in "git config --help", so perhaps rename the new
> member to "config_scope" or "scope_hint" or something?

Agreed. I will rename "global_hint" to "scope_hint" so that the field
describes the configuration scope rather than just the global case.

> Have you considered going in the other direction to narrow the
> interface instead of widening?  Instead of passing .level and .key
> separately from the caller to this function, I wonder if it makes
> it more future-proof to pass &advice_setting[type].

Yes, I agree that passing the "advice_setting" itself is cleaner and
more future-proof. I will change "vadvise()" to take a pointer to the
corresponding "advice_setting" instead.

Unfortunately, I did not notice your message in time and had already
sent v2. I will implement these changes in v3.

Thanks for the suggestions.

Best,
Vsevolod R4NC
