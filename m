Received: from send147.i.mail.ru (send147.i.mail.ru [89.221.237.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD26393DE0
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 05:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.221.237.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789016758; cv=none; b=P354lwdm+qwjMGXu3XnHMfG6aOm+jgtCBm9BJam+SLBunoOY1izKhtlPDptIjI3S6vEmztXnEWalWY5loLfv0JY7bCSahKoLO+Tq4kmgV/jOeeISWxFtWmqXCAzV9EstHxMBEsDijeOX5pDKDPhECdeD4ZL81jqFNnOIItxSR8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789016758; c=relaxed/simple;
	bh=Fwtk3r32z3Wycn0jjAk5Ilbi0f+nfPUX6hOtsRlcMbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TlNcRFZ56/y03eZ9m/TSBaq7SheIkAyBSmxZlSr1KgLDctDw2DUF3NboO24+1ZivDgO8Az9gqrpjw0SgCw2tEoR2rTFFcGhrn85u5fBsl+094ZkSOz3KnnGVrDjD7a/T/Bmc0/gzaQ7PUxP7aogfuJkaorUSoF64EsNMNNW1DBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=wfltpJoz; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=f3DMz+gN; arc=none smtp.client-ip=89.221.237.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="wfltpJoz";
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="f3DMz+gN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive:X-Cloud-Ids;
	bh=Fwtk3r32z3Wycn0jjAk5Ilbi0f+nfPUX6hOtsRlcMbI=; t=1789016754; x=1789106754; 
	b=wfltpJozKSSiYpsbAzsERwnzHe/ZXDvZQhpLKoNwpn7nAcAVVXvRQ+s0rvXJY+zVH9VhT9txuBB
	ew2ifG+8kSTVKRUvdzFEvmOM/8IuR0kCny6XSmXtWEA0Q0xrqai4zpx+hVP2Cut5ph7uoMRqW6ZdE
	nUS/NNb4ySs0lhtcpbMsleulOEeQVlcf7E0HnGhg3j1O3Wni4viXNNGsg05ToS1b8615PxiAEcpAN
	zbGoT5Adjx7Zh/V3eXcX2eSkHQMchWp9698M6lRXUM9QJlBLlov7A9/1HTacbY0iGaEl+4mC0VD11
	HXS71BxXTsxurH8BL6tsbt8lVOC8io4nsaAA==;
Received: from [10.113.133.241] (port=42090 helo=send104.i.mail.ru)
	by exim-fallback-679568fb9b-mh82v with esmtp (envelope-from <ub4nal@mail.ru>)
	id 1x4Wj5-00000000KBh-1nZP; Thu, 10 Sep 2026 07:49:31 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=Fwtk3r32z3Wycn0jjAk5Ilbi0f+nfPUX6hOtsRlcMbI=; t=1789015771; x=1789105771; 
	b=f3DMz+gNhwDHCAqu2eyL6TDZpemj8HtkvakFYsadyRekDIGkQ/uN1X9SoGMmqrLYqCMKjzgXjGA
	BC2uvBkwWnDovcaI6fVSDn788QW4xUFlThUTCghVu6e9EvQRH6TSr+7x4A0vGZPhIqsFCySaU3J76
	ibmdEiMUOPaLymVnrxR6vGQ+m4hWsGBROx4BoneUI39164vMI2ZiKKXZZL1GjASu3tj7dfF3uoQI5
	rFcy5x2+/FeZZA9WWFnRE1zICwvJBgmekGMj/A5MOQc3FJwsMsPe+XXEtHg+Rv4DAEeDAeMH0DHpt
	bkQrDOzVwxFk66ZD/jwCNap5JtjdkqqWPHeQ==;
Received: by exim-smtp-569b45c49c-dx6ms with esmtpa (envelope-from <ub4nal@mail.ru>)
	id 1x4Whm-00000000Fvt-2mWM; Thu, 10 Sep 2026 07:48:11 +0300
Received: from vatem (localhost.localdomain [127.0.0.1])
	by vatem.localdomain (Postfix) with ESMTP id 06A459F60D;
	Thu, 10 Sep 2026 07:43:08 +0300 (MSK)
From: Vsevolod Myalitsin <ub4nal@mail.ru>
To: peff@peff.net
Cc: ben.knoble@gmail.org,
	git@vger.kernel.org,
	gitster@pobox.me,
	ub4nal@mail.ru
Subject: Re: [PATCH v3] advice: use global config for default branch name
Date: Thu, 10 Sep 2026 07:43:07 +0300
Message-ID: <20260910044307.95376-1-ub4nal@mail.ru>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260909224603.GA195381@coredump.intra.peff.net>
References: <20260909224603.GA195381@coredump.intra.peff.net>
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
X-77F55803: 4F1203BC0FB41BD95F11291660A1073BCB3B94452D678D35545782B303732F03182A05F538085040FCF0D35E3591344B3DE06ABAFEAF6705AD6C35190495027B749E5C4E1FF9740C4C0C6A52ECAB1499
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE743AE26858062A689EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637AC83A81C8FD4AD23D82A6BABE6F325AC2E85FA5F3EDFCBAA7353EFBB55337566A08549CA5D9647613A342A4F63E37DA598AE3AECF4A54D943CAA3C2757A3B68B8EEF46B7454FC60B9742502CCDD46D0D9E541A154B51D14BF6B57BC7E64490618DEB871D839B73339E8FC8737B5C2249957A4DEDD2346B42CC7F00164DA146DAFE8445B8C89999729449624AB7ADAF37F6B57BC7E64490611E7FA7ABCAF51C92176DF2183F8FC7C0ECC8AC47CD0EDEFF8941B15DA834481F9449624AB7ADAF37BA3038C0950A5D3613377AFFFEAFD269176DF2183F8FC7C07D08B698D69CD5617B076A6E789B0E97A8DF7F3B2552694AD5FFEEA1DED7F25D49FD398EE364050F9647ADFADE5905B11133410A2FE6C23AB3661434B16C20ACC84D3B47A649675FE827F84554CEF5019E625A9149C048EE9ECD01F8117BC8BEE2021AF6380DFAD18AA50765F790063735872C767BF85DA227C277FBC8AE2E8B14D78865373AD42775ECD9A6C639B01B4E70A05D1297E1BBCB5012B2E24CD356
X-C1DE0DAB: 0D63561A33F958A52B953438A781989F5002B1117B3ED696D4C2DB20570EF47D1BDDAE3D1EA49BEA823CB91A9FED034534781492E4B8EEAD09122B91796FF21FBDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE1918E10F71CB4DF9F96AB70F9BE574AE9C625B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D65924F3B34688269FA525313561AEB5542BD70388B13F89909D749562FD84FDDD97381AAD4D6A05F39CB8341EE9D5BE9A0AAAAFCE81DD2B9830AFC2223F3B497BC938AB11A9BDDEEAD7C7CEAA0681F5848F4C41F94D744909CEFACD6B4B6D928230F8CCC96A59B602D5CC2E138FFB4ACBED
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXOcIETfglQORZ0zpDET4Zrk3igikrdHlWEemFktTMvWOsl0Q2O/NArY=
X-Mailru-Sender: 288943BA7BCC8BBA065C24D5D0D78BBD79CFCEEC49ABE3973DE06ABAFEAF6705AD6C35190495027BA165F1893FAC5C75730F10A35ECD6C905A92E71CC7C3152D8DFEC3831B33C4D004BC3E28E37B34A4E9BE5789416A142FC25A2993B28EC86D9FF92CA8FAC60DF8EAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-Mailru-Src: fallback
X-7564579A: 78E4E2B564C1792B
X-77F55803: 6242723A09DB00B4B9BFAEC4A56250D1B872770CF5EF48563F7DBF5C007E4FB2049FFFDB7839CE9E0464E60879317AFE84F811A7C04C9951A45174583929B460DA591A516CF0B8462D022DBBDB1B0BEF
X-7FA49CB5: 0D63561A33F958A56EFBD8471CE735065002B1117B3ED6963BE9338D672ECDEE984B9450E8916CCD02ED4CEA229C1FA827C277FBC8AE2E8B54F520D093A0DF28
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+OYcBso8Zm+oliTz8oZwnDrFsY77LZRcHyw5ht0smWrfSeTW5FiI8avd9v29gUBslpLaIlvAR6h4id02YH9mgeCTAyYoNlVO8a/mge5WbOvyyhiYhUIl8wWs=
X-Mailru-MI: 20000080020000000000000800
X-Mras: Ok

> Any config can work at any scope. These are really just recommendations on where the user might want to write a value.

Looking at it from that perspective, this seems obvious to me now. I'll reuse the existing CONFIG_SCOPE enum and treat CONFIG_SCOPE_UNKNOWN as the default location.

> TBH, I am not really sure what the criteria are for suggesting one advice option as --global or not.

The motivation for this patch was that "advice.defaultBranchName" currently suggests:

"git config set advice.defaultBranchName false"

Without an explicit scope, this writes to the local ".git/config". After the repository has been initialized, that particular scenario won't occur again in that repository. However, when the user initializes a new repository, the advice will appear again, which may make them wonder why they ran the command in the first place.

Therefore, I think "defaultBranchName" should suggest using the global scope.

> I'd think most of them are about squelching advice that the user already knows about, and thus they would go into --global.

I agree that this may apply to many of the advice messages. For this patch, though, I'm specifically addressing "defaultBranchName", where the global scope seems appropriate for the reason above.

> I didn't really follow the earlier discussion that led up to this patch, though.

The original motivation was specifically the behavior of "defaultBranchName" after initializing a new repository, which is why I considered a global scope recommendation here.

Vsevolod
