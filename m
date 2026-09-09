Received: from send123.i.mail.ru (send123.i.mail.ru [89.221.237.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CE15A5123
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 21:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.221.237.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788989535; cv=none; b=TVifhsEyXDNuw4ylwrx4B3vzGANmYmg4+ybvXJ5iO0nX5pm7nDj71960k9nWvVy73ozVT0NhczyBVqqgHkDIjNp6pvZ84RfyacpvhzK7BqhpkfK0FRDytvKnIjuj+i9HFAgGxHzclnbK6edya62aI2lXzMkO2zwEuEm3sgc3oWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788989535; c=relaxed/simple;
	bh=xiOBFGdGc9gkDqIAQKhM+QomovBoYxOlMSl89K3Kw28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BTBIPMBuRGnCSX7QqrntDZL8gxi6hLroS9Cads8v9vPWRSF4yDV+1Tzy503yRpS9nyArFdD42Tm+dD7XlBsPTe3J1DOqcMermgSY+LiUEK2E+sIWphUmlB5PdiRQ8VyzQ0e8Xz7bb9zkOrL32tF+2n98Oiuds62dMg/Q1exo5XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=wh8q39S+; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=brfMV/hP; arc=none smtp.client-ip=89.221.237.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="wh8q39S+";
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="brfMV/hP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive:X-Cloud-Ids;
	bh=xiOBFGdGc9gkDqIAQKhM+QomovBoYxOlMSl89K3Kw28=; t=1788989521; x=1789079521; 
	b=wh8q39S+Q9V9Wh+/2fm5C+3sTqCEnJqJfUVPvkFRDApOm7G36DRfhxnWb2e8ThHueh6gAl4Yh2g
	/7CC9PlNJ4KM1TFbktFw5ulrJT5u4AgLK4jD9pxeg5Y1Gd2cT45/VKkiWDIP2xHXQx/tVkq3WOv11
	J3UfiXoJoVm53RAGbR/wyP7g1wi6C0wbBBMO8uUHWERz7U2kGSNt99jsJQNEL7kg+YBvzKxy0W8/b
	Im8mm6KzddJ2kWRwCXJVhmp3RoUVSYrRNtBMWngbgRQcRPkbaNZCLD5YR9yWYHKGaBuPmRNuqg5fe
	k5JauRaAVsB7lBtEQ75LLTwiQb0d6pYroPqA==;
Received: from [10.113.69.63] (port=40438 helo=send59.i.mail.ru)
	by exim-fallback-679568fb9b-dnmm5 with esmtp (envelope-from <ub4nal@mail.ru>)
	id 1x4Ptc-00000000Glb-2cYV; Thu, 10 Sep 2026 00:31:56 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=xiOBFGdGc9gkDqIAQKhM+QomovBoYxOlMSl89K3Kw28=; t=1788989516; x=1789079516; 
	b=brfMV/hP9uQ4vtvBNpweB0la0C3cfafN7ToMGF5RsCkzs8zjeySqfju/n/J9vn/5/gZAm+whK4g
	B3lYUF/4ozb18NCGCOy49MzkdEsIzs4Mx5tXQZmB42EZWNYhXi3mCzXB92tz4xnumHkKM7SdOFCM7
	JxN7U0b3Ry4X2jlh0lFtNssY2g+jLMm3jGRxZFPRC+ea5dbSY4fRSp8b193dyxBs/CUONgaUbcBn1
	19nzeR9KV2xTbPgafsrTBEHmWPlY998l2uVW4OjJ8+TwfVnPIOYc76hykA7dERHaWOF/FFLJ2EpM0
	Z3cocfJh4NBmEnLCzqoST1oS1IejuGN9XaZw==;
Received: by exim-smtp-569b45c49c-gw69m with esmtpa (envelope-from <ub4nal@mail.ru>)
	id 1x4PsJ-00000000MR4-3lvf; Thu, 10 Sep 2026 00:30:36 +0300
Received: from vatem (localhost.localdomain [127.0.0.1])
	by vatem.localdomain (Postfix) with ESMTP id 0D0B69F60D;
	Thu, 10 Sep 2026 00:30:35 +0300 (MSK)
From: Vsevolod Myalitsin <ub4nal@mail.ru>
To: gitster@pobox.com
Cc: ben.knoble@gmail.org,
	git@vger.kernel.org,
	gitster@pobox.me,
	peff@peff.net,
	ub4nal@mail.ru
Subject: Re: [PATCH v3] advice: use global config for default branch name
Date: Thu, 10 Sep 2026 00:30:34 +0300
Message-ID: <20260909213034.94554-1-ub4nal@mail.ru>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <xmqqse3ip2s5.fsf@gitster.g>
References: <xmqqse3ip2s5.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD9E52C9190B278547F3E9EC0952131F526FBC1A4C679E9DA31182A05F5380850404C228DA9ACA6FE2778C2D9E0CA1F7E7A3DE06ABAFEAF67059F5019DFB38281689D003CC41355E53ACE4EC1BF0D3C05BC
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7EB05B7739F1E6D56EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637FE9EFE935CD7C6AE8638F802B75D45FF914D58D5BE9E6BC1A93B80C6DEB9DEE97C6FB206A91F05B297B0C510D9E10E142E070BE324C7D3C4A4EBA5A3DD6013B4BB0A4F435E46E6718B35066C979671628AA50765F7900637F3DB775AA22245C5389733CBF5DBD5E913377AFFFEAFD269176DF2183F8FC7C078FCF50C7EAF9C588941B15DA834481FCF19DD082D7633A0EF3E4896CB9E6436389733CBF5DBD5E9D5E8D9A59859A8B6F459A8243F1D1D44CC7F00164DA146DA6F5DAA56C3B73B237318B6A418E8EAB8D32BA5DBAC0009BE9E8FC8737B5C2249F62E2DC5BE1D6F2C76E601842F6C81A12EF20D2F80756B5FB606B96278B59C4276E601842F6C81A127C277FBC8AE2E8B9221B9F450D853153AA81AA40904B5D99C9F4D5AE37F343AD1F44FA8B9022EA23BBE47FD9DD3FB595F5C1EE8F4F765FC72CEEB2601E22B093A03B725D353964B0B7D0EA88DDEDAC722CA9DD8327EE4931B544F03EFBC4D57843AE0F20224B8D0C4224003CC83647689D4C264860C145E
X-C1DE0DAB: 0D63561A33F958A5C9DC6E6678DCA5CA5002B1117B3ED6965928360CC427125F3D2BBC1EF78EDEBE3610D81D389A125CDE35189EBF2DEA28FEA14CD2CD220BB99C5DF10A05D560A9880EC71AF561E0AAD9143641EC25BB3994F91582EA3F52AE
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE1918E10F71CB4DF9F96AB70F9BE574AE9C625B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D65951FC2C2DBA055F465B00157912ACC71CB600FD1303AA06345539BAFA43B60C2DCE607B49791F86CCB8341EE9D5BE9A0AE616A6EA23895E811BF076141C9294932311DC9F308FE15C9350E1BD188BD56E4C41F94D744909CEFACD6B4B6D928230F8CCC96A59B602D5CC2E138FFB4ACBED
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXOcIETfglQORZ0zpDET4Zrk3igikrdHlWCqwvZIR4uDPl/VZul3y37o=
X-Mailru-Sender: 288943BA7BCC8BBA065C24D5D0D78BBDA15B94BB264543C43DE06ABAFEAF67059F5019DFB3828168A165F1893FAC5C75730F10A35ECD6C905A92E71CC7C3152D8DFEC3831B33C4D004BC3E28E37B34A4E9BE5789416A142FC25A2993B28EC86D9FF92CA8FAC60DF8EAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-Mailru-Src: fallback
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B4B9BFAEC4A56250D1B872770CF5EF4856BE19BCC43F585EBF049FFFDB7839CE9E0464E60879317AFE1153D0329CFE1AF4190D7E8B1A914B0FCD2B62B20046057A4CD9D026A772D369
X-7FA49CB5: 0D63561A33F958A5510D969DE04354315002B1117B3ED69690CDA69C630436D14BE7A2D7F647BB5802ED4CEA229C1FA827C277FBC8AE2E8B527E4F99C2373B40
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+OYcBso8Zm+oliTz8oZwnDrFsY77LZRcHyw5ht0smWrfSeTW5FiI8avd9v29gUBslpLaIlvAR6h4id02YH9mgeCTAyYoNlVO8a5rszphlXEJ83c+roItVkNg=
X-Mailru-MI: 20000080020000000000000800
X-Mras: Ok

Hi Junio,

Thanks for the review.

> """Use this new mechanism to suggest setting advice.defaultBranchName
> in per-user configuration, not in per-repository configuration, as
> it is way too late once a repository is initialized.""" or something
> along that line is missing here.

Agreed. I'll add this motivation to the commit message.

> The change to narrow the interface into vadvise() needs to be
> described in the proposed log message.

I'll describe this change in the appropriate commit message.

> Ideally, this would be a three-patch series. API change to
> vadvise() would come first, and then the introduction of advice
> scope mechanism, and finally making defaultBranchName a global
> scope variable.

Agreed. I'll split the changes into three patches in this order.

I have one question about how the series should be organized. Since the
three patches will have different purposes, should each patch have its
own subject and commit message describing the changes introduced by that
patch? Or should they share a common subject/theme, with the individual
changes described in the respective commit messages?

> Style. In our codebase, switch and case are indented to the same
tabstop.

I'll fix the indentation.

> Other than that, the end shape looks good to me.

Thanks!

Vsevolod
