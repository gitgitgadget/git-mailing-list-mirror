Received: from send123.i.mail.ru (send123.i.mail.ru [89.221.237.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EFE3AEF4A
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 21:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.221.237.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788989034; cv=none; b=rYDAZw4MfeeX8y3jmSTJGlHvajMBbmOgQ9zXV81mNGqpBWOxwv+n9XFY1h9BUZv1beW7VwEPMQuDVMIzKtb375YfsyxAqQvbFix840i8v/ni9Q05X7r4H0Jvt8MuX0RrUhFmT6+HpFswaTZBOx/C9gn3QFtrJHHZPdjD8YDvdBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788989034; c=relaxed/simple;
	bh=T1n2bUj7ulaGkkaArxH1oloI1H+W8QwX1+PYGywqbeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CMIOb0qX92SbtvMSPdSK0m9qW1CekWnnXJuU9rq0OMv6+n+9r/+PixvfIPlW3pugF54WY08hEiskQ0s4iSWIXtoqZ+BGDa+gtPjRf7RQ/nw93PomzfJr7KwO4d5tyiZ0OZiLa1W1OAGJGC20RQFsPn/JHzUP88Pa25I+SmhTlAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=wi9SiIDV; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=MsjsOY0n; arc=none smtp.client-ip=89.221.237.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="wi9SiIDV";
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="MsjsOY0n"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive:X-Cloud-Ids;
	bh=T1n2bUj7ulaGkkaArxH1oloI1H+W8QwX1+PYGywqbeI=; t=1788989027; x=1789079027; 
	b=wi9SiIDVO7kk515SF8BeMB2l7UQkAM9hHnZfTrxdO6N8Mr6MSixszCK6adM/ypJ381F/cX0m+ch
	h+QIQjtFUqcGYehjT15pEQPiKjvxVU+AkN0G/1G8pcB66Dt9faycV66O8j91dU3ojpZo6kUMufd1h
	ePVBGoCQYZHzuJTF6IEqxFUj5i9DozADaouzsBpKRCUk4Px+b8uE8uMuXOc9r5WIXwckgT6PAaP4k
	vqbW88EaoJZDcEAnX273bhoKldVAJZ4z4oHhuYRloBVQX8LcNluMGHXt8I7qTbyM3U7XbAhCv7dMJ
	tQSTQ0NxmH1qyKBwok6U/xC4ChK2cCQtGnJQ==;
Received: from [10.113.166.82] (port=60948 helo=send279.i.mail.ru)
	by exim-fallback-679568fb9b-6hcqf with esmtp (envelope-from <ub4nal@mail.ru>)
	id 1x4PlY-000000002Rn-2F6W; Thu, 10 Sep 2026 00:23:36 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=T1n2bUj7ulaGkkaArxH1oloI1H+W8QwX1+PYGywqbeI=; t=1788989016; x=1789079016; 
	b=MsjsOY0n1gSfdc46kCYaRZm30GputBRCI+dpTsZwlsQR7IspwHVLUylXlJz20M/+EidKtRK8kfi
	XrHccVOnttThQjqQXYotYFZZmAs23uT3Vj4DAx3HKPeXxx6lLHRPUQvGrpZKyS5mvP37aEbMVHDDR
	z/ZZI70DWIIimYFMCSeqeHiH3DCy3I/14YwDQyyPJXGhc2zzdu2UhMWigxaTCbulEXxprgcztsEO0
	HtQKS4/8ZNbF/+vqM3WytuZQu2ME50mPsJK8DE4ueNg2UTbuY+B/NLd2WwTXkJJ97YG5kfZmJtFsh
	qeOVnRisWn4isw+co8uRc7Djkzez5weHSwqw==;
Received: by exim-smtp-569b45c49c-dx6ms with esmtpa (envelope-from <ub4nal@mail.ru>)
	id 1x4PkF-00000000CnA-2GSH; Thu, 10 Sep 2026 00:22:15 +0300
Received: from vatem (localhost.localdomain [127.0.0.1])
	by vatem.localdomain (Postfix) with ESMTP id A576F9F60D;
	Thu, 10 Sep 2026 00:22:14 +0300 (MSK)
From: Vsevolod Myalitsin <ub4nal@mail.ru>
To: peff@peff.net
Cc: ben.knoble@gmail.org,
	git@vger.kernel.org,
	gitster@pobox.me,
	ub4nal@mail.ru
Subject: Re: [PATCH v3] advice: use global config for default branch name
Date: Thu, 10 Sep 2026 00:22:13 +0300
Message-ID: <20260909212214.94151-1-ub4nal@mail.ru>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260909202718.GA183838@coredump.intra.peff.net>
References: <20260909202718.GA183838@coredump.intra.peff.net>
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
X-77F55803: 4F1203BC0FB41BD95F11291660A1073B7AF24265EE4178F06C30090CCB8B5916182A05F538085040F09BD892627A36C23DE06ABAFEAF6705328DA95FC7C722248E55A79494CDB7631B6A14438A2A01BA
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE737AE489DBC023F2AEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637AC83A81C8FD4AD23D82A6BABE6F325AC2E85FA5F3EDFCBAA7353EFBB55337566A08549CA5D9647612A3E7CA06891A44149548FF917567A8EE6815AB6D6CAB0C28EEF46B7454FC60B9742502CCDD46D0D21E93C0F2A571C7BF6B57BC7E64490618DEB871D839B73339E8FC8737B5C2249D52CD31C43BF465FCC7F00164DA146DAFE8445B8C89999729449624AB7ADAF37F6B57BC7E64490611E7FA7ABCAF51C92176DF2183F8FC7C0DCF4F0DC832992758941B15DA834481F9449624AB7ADAF37BA3038C0950A5D3613377AFFFEAFD269176DF2183F8FC7C0AB900635900CC50B7B076A6E789B0E97A8DF7F3B2552694AD5FFEEA1DED7F25D49FD398EE364050F140C956E756FBB7A2AE38A8E97BAFFB1B3661434B16C20ACC84D3B47A649675FE827F84554CEF5019E625A9149C048EE9ECD01F8117BC8BEE2021AF6380DFAD18AA50765F790063735872C767BF85DA227C277FBC8AE2E8BE79BD65E82DB1F1375ECD9A6C639B01B4E70A05D1297E1BBCB5012B2E24CD356
X-C1DE0DAB: 0D63561A33F958A54A25A0807EAE91325002B1117B3ED69647B25D186AB5BEDBC638DF663A625AFA823CB91A9FED034534781492E4B8EEADB05233B9BC4759D3
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE1918E10F71CB4DF9F96AB70F9BE574AE9C625B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D6593869AEA2EEEE2CD143719ECC9DBD06B68BB64F79990201D5DFF704566DA72C30287A12062ECA0241B8341EE9D5BE9A0AD996F9D4BE63E3581DC031AF1905D572A3283778B113BAF1C7CEAA0681F5848F4C41F94D744909CEFACD6B4B6D928230F8CCC96A59B602D5CC2E138FFB4ACBED
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXOcIETfglQORZ0zpDET4Zrk3igikrdHlWDHl7IIjf+i9m5/lFOSIJYM=
X-Mailru-Sender: 288943BA7BCC8BBA065C24D5D0D78BBD635AC34BAA0932893DE06ABAFEAF6705328DA95FC7C72224A165F1893FAC5C75730F10A35ECD6C905A92E71CC7C3152D8DFEC3831B33C4D004BC3E28E37B34A4E9BE5789416A142FC25A2993B28EC86D9FF92CA8FAC60DF8EAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-Mailru-Src: fallback
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4B9BFAEC4A56250D1B872770CF5EF4856E9212B95432B34C1049FFFDB7839CE9E0464E60879317AFED6200BC55453B628193029B791F7EC825FA8ADA6BE7A453E1FAFC9A4143D2E0E
X-7FA49CB5: 0D63561A33F958A5EDECA941BA4594115002B1117B3ED696FA616C36901DC332BB5A64B5EE0D2EE302ED4CEA229C1FA827C277FBC8AE2E8B54F520D093A0DF28
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+OYcBso8Zm+oliTz8oZwnDrFsY77LZRcHyw5ht0smWrfSeTW5FiI8avd9v29gUBslpLaIlvAR6h4id02YH9mgeCTAyYoNlVO8a5rszphlXEJ8/l8huXDSReM=
X-Mailru-MI: 20000080020000000000000800
X-Mras: Ok

Hi Peff,

> Translators will need to update their message translations, and I wonder
> if seeing this "set%s" in isolation might be confusing.

I agree that using a single placeholder for the whole command is clearer for translators. I'll use this approach.

> But really it is an enum, and if we are going to use "==" we should
> probably spell out the whole name rather than 0, like:

if (setting && setting->level == ADVICE_LEVEL_NONE)

I simply forgot to include this change in the patch. I'll change it to use ADVICE_LEVEL_NONE.

> I had somehow hoped we could reuse the existing CONFIG_SCOPE enum
> without having to redeclare it ourselves.

One concern about reusing enum config_scope: since CONFIG_SCOPE_UNKNOWN is 0, all existing advice_setting entries without an explicitly specified scope_hint would default to CONFIG_SCOPE_UNKNOWN rather than CONFIG_SCOPE_LOCAL.

I believe this is incorrect, since the existing behavior is local scope by default. However, if you consider CONFIG_SCOPE_UNKNOWN appropriate here and it satisfies the intended requirements, I have no objection to using the existing enum.

Thanks,
Vsevolod
