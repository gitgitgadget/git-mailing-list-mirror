Received: from send77.i.mail.ru (send77.i.mail.ru [89.221.237.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C28D330328
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 20:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.221.237.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788984338; cv=none; b=Y27cUcRVcqFbs2Suntmtpml+EGDyIlrpHm1TmtkKsOyu9FITdap1ZOJ6naEx6CobsgkHA9+aruAi63zuEnKp2OhSrbRmV4KpxtY0qQfRs6Z/umlSS5q+45DKfvRi3iPujS4Xc1cLqUliUobBpr8bBt4YDmqbNHFB/qiyzdV6enc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788984338; c=relaxed/simple;
	bh=5VQI4MctUe4ugmId+iTfsAvV7fqQbd0wXIofS9dOMBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GWoVK0BqDYF0Ti5E0CniEGc471ilbrzK0UhWituAy69J7OsEJBzsGM3RdEdapF1fZeIUKuiApHoFw6mIIcwYD9bcaAG+6uDRAe8Ypift0sy+lxdjyuEfCUza3J4lA77yjpWL1YlGoQ5WoNGB4XAHbBED2JXCUQRU8LJ7NWPIlAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=m0coK3eN; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=iZ/wmeam; arc=none smtp.client-ip=89.221.237.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="m0coK3eN";
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="iZ/wmeam"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive:X-Cloud-Ids;
	bh=5VQI4MctUe4ugmId+iTfsAvV7fqQbd0wXIofS9dOMBA=; t=1788984334; x=1789074334; 
	b=m0coK3eNLW/T5OypPHVPESpUKnkHSMAAP3k/ItPUTH3M2ALmNqXY8QJheUuifZhI93cgkdTY2YM
	8ySBAuV6+Kn732r3H16gw8C2L2d6CcjehctgTyTtsuw1ceFSkCE/eNXiFjao+jPvpUETTswZBWPuI
	DIZt5GSxafVODaoLhwMkcXbN4T9RYeSDOdUNK8z7/QYV2iwkv8CgmTCtD1znA5pR8Nh5bcRN5XsH0
	4BGX2IVNSky4TxslGbQ3ACsNFSVG/KtTSnqXjYDC42Af7OjCgQJuzKfSuLtPLr2j2Vg/pWT/d4wZ4
	S3F3QY0g4YydXTCwpaGkNsapm819TNJPymQA==;
Received: from [10.113.185.107] (port=53356 helo=send82.i.mail.ru)
	by exim-fallback-679568fb9b-dlnnr with esmtp (envelope-from <ub4nal@mail.ru>)
	id 1x4OJK-000000007Wz-1vGc
	for git@vger.kernel.org; Wed, 09 Sep 2026 22:50:22 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=5VQI4MctUe4ugmId+iTfsAvV7fqQbd0wXIofS9dOMBA=; t=1788983422; x=1789073422; 
	b=iZ/wmeam4fLoNDK3zc1J1G4b1ySxCpB21WkBY2/9/o0KhJF6IySKvgP+xCWwe/NZS0u6Gte67tF
	RD13HT8I1TK+ThVldfMfoJTQN73YWXyeyYAcITcG/gZKA7FJtjvMECYCPVHJuDOhw/DKTktc8ccox
	dmyWrjsOm52NchUogOdC2kdnMUSnWOl+V+NFOPwbObKUzhyvn0VdY79ht6/owbY/GkaIsvzJ/I6fT
	w+Gh1eroOgT6Y6MMyMOQJJMczJRyn2kbvdD2f3r69TX8QXmhkR1HKoeQuQkn9BOeLdHPu5oEGffzz
	Me3dgUCtSTD4DUqd9HLP4bgot4JXzfUoaI/A==;
Received: by exim-smtp-569b45c49c-q8h55 with esmtpa (envelope-from <ub4nal@mail.ru>)
	id 1x4OJB-00000000IPi-04oq; Wed, 09 Sep 2026 22:50:13 +0300
Received: from vatem (localhost.localdomain [127.0.0.1])
	by vatem.localdomain (Postfix) with ESMTP id 3FB6C9F60D;
	Sun, 29 Aug 2027 03:59:02 +0300 (MSK)
From: Vsevolod Myalitsin <ub4nal@mail.ru>
To: gitster@pobox.com
Cc: ben.knoble@gmail.com,
	git@vger.kernel.org,
	peff@peff.net,
	ub4nal@mail.ru
Subject: Re: [PATCH] advice: use global config for default branch name
Date: Sun, 29 Aug 2027 03:59:01 +0300
Message-ID: <20270829005902.91081-1-ub4nal@mail.ru>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <xmqqv78eqmw8.fsf@gitster.g>
References: <xmqqv78eqmw8.fsf@gitster.g>
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
X-77F55803: 4F1203BC0FB41BD9E52C9190B278547F0B48A76431D3C9AE768270A0848FC195182A05F5380850404C228DA9ACA6FE27E846032630768E753DE06ABAFEAF670571E167AF869B65665F1A170EF30AB460BE3CD06344D71D5D
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE79145AB6E9E75F07EEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637AC83A81C8FD4AD23D82A6BABE6F325AC2E85FA5F3EDFCBAA7353EFBB55337566A08549CA5D96476179ACB4CF03B9F2802FEC3A38806BF73BC56F9E2BA0AD71868EEF46B7454FC60B9742502CCDD46D0DEB7D890E3377C531F6B57BC7E64490618DEB871D839B73339E8FC8737B5C2249B0E9FD5D4288160ECC7F00164DA146DAFE8445B8C89999729449624AB7ADAF37F6B57BC7E64490611E7FA7ABCAF51C92176DF2183F8FC7C08794E14F7ADDB10D8941B15DA834481F9449624AB7ADAF37BA3038C0950A5D3613377AFFFEAFD269176DF2183F8FC7C00B97EE868906737B7B076A6E789B0E97A8DF7F3B2552694AD5FFEEA1DED7F25D49FD398EE364050F140C956E756FBB7A4D0DA9BD313A0613B3661434B16C20ACC84D3B47A649675FE827F84554CEF5019E625A9149C048EE9ECD01F8117BC8BEE2021AF6380DFAD18AA50765F790063735872C767BF85DA227C277FBC8AE2E8B4E2B4AF5766D187375ECD9A6C639B01B4E70A05D1297E1BBCB5012B2E24CD356
X-C1DE0DAB: 0D63561A33F958A5D46C2A30B6872C1D5002B1117B3ED696169898BEF1A8F1B147A99E6294EE86613610D81D389A125CDE35189EBF2DEA28FEA14CD2CD220BB99C5DF10A05D560A9880EC71AF561E0AAD9143641EC25BB39ADA76E87B1B5EE23
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE1918E10F71CB4DF9F96AB70F9BE574AE9C625B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D659457955F9FC2B003BACA90BA804641477120F8759A3599BF703606FAEE52D9957022014227FC2ADB0B8341EE9D5BE9A0A68D8B848EA9ECFC2D080BCB354A7D961E3404BE20A256DDF9350E1BD188BD56E4C41F94D744909CEFACD6B4B6D928230F8CCC96A59B602D5CC2E138FFB4ACBED
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXOcIETfglQORZ0zpDET4Zrk3igikrdHlWP5iPbgT8D+V3KofJT2Itw4=
X-Mailru-Sender: 288943BA7BCC8BBA065C24D5D0D78BBD5275786A997FCDB13DE06ABAFEAF670571E167AF869B6566A165F1893FAC5C75730F10A35ECD6C905A92E71CC7C3152D8DFEC3831B33C4D004BC3E28E37B34A4E9BE5789416A142FC25A2993B28EC86D9FF92CA8FAC60DF8EAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-Mailru-Src: fallback
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4B9BFAEC4A56250D1B872770CF5EF48562718311DB4F31C56049FFFDB7839CE9E0464E60879317AFEBC73789D8FA5B368679F4CEA4B73015DDC89ACFDAD1A96D11EC636F0DD995805
X-7FA49CB5: 0D63561A33F958A5AEB280BA612090C05002B1117B3ED696AC192E8D38B797BC393D891B5189421702ED4CEA229C1FA827C277FBC8AE2E8B51710B38F27ED36F
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+OYcBso8Zm+oliTz8oZwnDrFsY77LZRcHyw5ht0smWrfSeTW5FiI8avd9v29gUBslpLaIlvAR6h4id02YH9mgeCTAyYoNlVO8a5rszphlXEJ8qNZQmpxiOJg=
X-Mailru-MI: 20000080020000000000000800
X-Mras: Ok

Hi,

I've sent v3 with the suggested changes.

In particular, v3 uses NULL for advise() calls that are not associated with an advice_setting entry, as suggested by Peff.

Please continue the discussion based on v3.

Thanks,
Vsevolod
