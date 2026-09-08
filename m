Received: from send146.i.mail.ru (send146.i.mail.ru [89.221.237.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353E3560AC2
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 14:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.221.237.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788879562; cv=none; b=k4meeLgiyzHLc/HKc4hK4u+0MIikttZjuzvdsuzZXT9LuEcuCXIwEbI/xIkXOrKvXvy9iJ+N0Favz/oZPsetrnqwdB6/P6JRAzO1ROaoDe2l3hSTJTxnHP8C0sAiDtr2R2FwsIVnLmcx3ue2TnDNv8J76zOt7ACsrssEppAQeig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788879562; c=relaxed/simple;
	bh=XPSL6Qs5Me0YIVcCPA90LnJbagAQVvgto5CihBEIIPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N7Y3Mm3/+0g7TeOdPcn7T5HsnigkfAN4gEcULlg3RFuRC8WfvQiCsZQoPHLx738ymgW6dt31ZArrrNb/G2PjioB35z+7xjGJvxVSb+J0YgKHqoKQqX6SiTFn3iTmhOyarF5qBC4/5Td5PAAfDtWOnj5TjqtQjx2AL/ozqHPlpAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=d5rbH0UL; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=KcRkFw4r; arc=none smtp.client-ip=89.221.237.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="d5rbH0UL";
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="KcRkFw4r"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive:X-Cloud-Ids;
	bh=3yqBxrG5D6FNYODURsknC7qgOo/mYpuIcSlMNjbcbqw=; t=1788879542; x=1788969542; 
	b=d5rbH0ULx3aueNeX9+tYpnczCil9WokJowFW0TjXMeUd7iwq4ynCMbofn2p486R870o+uhxaU3Q
	x3jxvB/Os80Un8MyBHMS/L5/Pd6PFBd489POWh4BkrOQa327r37iagw9/RryGNMuCepmDG1JOZe+V
	F1XZrDJf2Q7vw9UgfZDUo1g5dPGIgWeeFEw3Y82VNJy+sMY5A+8USoYM4ZjVIxvIY5drUM/N3lpEr
	uvOEgMhSZBfEZixXjPHNQmwmMBK8SYPp+7TXK6BV74ZoseYpI8xxDRnlgvUg9UZVofObHexkH/fcM
	YBfNongV2rvbi2hrCIp8PBu/gVqZOGgg49CQ==;
Received: from [10.113.54.84] (port=49946 helo=send127.i.mail.ru)
	by exim-fallback-679568fb9b-x8b6q with esmtp (envelope-from <ub4nal@mail.ru>)
	id 1x3x37-000000003xE-0aWp
	for git@vger.kernel.org; Tue, 08 Sep 2026 17:43:49 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=3yqBxrG5D6FNYODURsknC7qgOo/mYpuIcSlMNjbcbqw=; t=1788878629; x=1788968629; 
	b=KcRkFw4rtWSmBBaEnRE/r1jHy+P0KtF7iMj1UcujSqHRA340kYbE9dKj20Mn4NJpZFqSYEW7Lhj
	y5uOegeud5UhIK1fyD1z2TJcWhRI/K6/f/UDBCWr65MtYNUwxdwloq+lfdZXl7sG/51UoXvNUg4jZ
	WjHfzJUH+zytUFakpz3oA80BjNwmXfka0OO0CqsSur18bxOoJki9/c0mTk6iYYiHZqtA0M2ErwSCi
	I+ib6cS1FKSDC4XijFqXXnNE6ru/81FqOvlS9CP+hN/aB7w49SPpErTorDalDJkNkNxI9Iio1OTuh
	bYIQmazLdW9mapaPLUdmiTezvX6s/BPIjW+w==;
Received: by exim-smtp-569b45c49c-q7xwg with esmtpa (envelope-from <ub4nal@mail.ru>)
	id 1x3x2x-00000000KLP-3nCB; Tue, 08 Sep 2026 17:43:40 +0300
Received: from vatem (localhost.localdomain [127.0.0.1])
	by vatem.localdomain (Postfix) with ESMTP id 20C709F60D;
	Tue,  8 Sep 2026 21:56:54 +0300 (MSK)
From: Vsevolod Myalitsin <ub4nal@mail.ru>
To: ben.knoble@gmail.com
Cc: git@vger.kernel.org,
	ub4nal@mail.ru
Subject: [PATCH] advice: use global config for default branch name
Date: Tue,  8 Sep 2026 21:56:52 +0300
Message-ID: <20260908185653.34702-1-ub4nal@mail.ru>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <90671DEB-7A41-47DA-B865-AB963AEC11D1@gmail.com>
References: <90671DEB-7A41-47DA-B865-AB963AEC11D1@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: 78E4E2B564C1792B
X-77F55803: 4F1203BC0FB41BD91BA70916A571E71FE21F1A6AFFE43A014CDD982F972E0AB3182A05F538085040E12BA7F62BDBA6F33DE06ABAFEAF6705F50017B865728801C23B2EE2932AAA6B0A58214F65DFC571
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7FEAC828D2BF6EC3CEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637AC83A81C8FD4AD23D82A6BABE6F325AC2E85FA5F3EDFCBAA7353EFBB5533756682FC6F8CF4E8B7271C79A5CB3F8727B30FE8B4BC318AA5988EB95A9D32CD17A98EEF46B7454FC60B9742502CCDD46D0D874EE23814B0CD5BF6B57BC7E64490618DEB871D839B73339E8FC8737B5C2249BAA8CD687FCDB2EBCC7F00164DA146DAFE8445B8C89999729449624AB7ADAF37F6B57BC7E64490611E7FA7ABCAF51C92176DF2183F8FC7C07734D68A6916D8318941B15DA834481F9449624AB7ADAF37BA3038C0950A5D3613377AFFFEAFD269176DF2183F8FC7C0EE22D061DCDCC2FC7B076A6E789B0E97A8DF7F3B2552694AD5FFEEA1DED7F25D49FD398EE364050FB28585415E75ADA9269E641683F5DD3FB3661434B16C20ACC84D3B47A649675FE827F84554CEF5019E625A9149C048EE9ECD01F8117BC8BEE2021AF6380DFAD18AA50765F790063735872C767BF85DA227C277FBC8AE2E8BE9D2F02AC1970E4575ECD9A6C639B01B4E70A05D1297E1BBCB5012B2E24CD356
X-C1DE0DAB: 0D63561A33F958A5993B3F9FAE8B1ED75002B1117B3ED6964E53F3F29D4ADCC0406406D89DD9EB8A823CB91A9FED034534781492E4B8EEADA3FB0D9844EF8EC5C79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE1918E10F71CB4DF9F9677DD89D51EBB774225B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D6591C3491C67CFDE42F492164B68B83CC6AFD6EE4E440CD7D1E4EEC7F145EF79033FCF855452EB223D6B8341EE9D5BE9A0A05CD3CC52AF5F0195B460D670C54626A77E6624DD3E9A3276536EB022892E5344C41F94D744909CEFACD6B4B6D928230F8CCC96A59B602D5CC2E138FFB4ACBED
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXOcIETfglQORZ0zpDET4ZrlAo0bq3TDyw6dS7By1zzJx6C8VmW8r1Hk=
X-Mailru-Sender: 288943BA7BCC8BBA065C24D5D0D78BBD9667CAC08BFC4BFD3DE06ABAFEAF6705F50017B865728801A165F1893FAC5C75730F10A35ECD6C905A92E71CC7C3152D8DFEC3831B33C4D004BC3E28E37B34A4E9BE5789416A142FC25A2993B28EC86D9FF92CA8FAC60DF8EAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-Mailru-Src: fallback
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4C6F4A01E7934A2008BB6C5049C2F2A1F128A48790C36EB04049FFFDB7839CE9E656977AF4D7889C92F6ADE82CF78210979DD060A094FA0CB4AFDAC4B08D5C4D247E1CF2962BFF63E
X-7FA49CB5: 0D63561A33F958A512DD010A7758E9375002B1117B3ED696008F30A15880FCDDA744AD9922FCBB6E02ED4CEA229C1FA827C277FBC8AE2E8B54F520D093A0DF28
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+OYcBso8Zm+oliTz8oZwnDrFsY77LZRcHyw5ht0smWrfSeTW5FiI8avd9v29gUBslpLaIlvAR6h4id02YH9mgeCTAyYoNlVO8a1SpzZpj/QBfAUjbEn3QGK8=
X-Mailru-MI: 20000080020000000000000800
X-Mras: Ok


I considered using an "is_global(key)" helper, but I think adding a field to "advice_setting" is cleaner.

The change is quite small:

 struct advice_setting {
     const char *key;
+    int global_hint;
     enum advice_level level;
 };

Then the scope is specified directly for the relevant advice:

	-[ADVICE_DEFAULT_BRANCH_NAME] = { "defaultBranchName" },
	+[ADVICE_DEFAULT_BRANCH_NAME] = { "defaultBranchName", 1 },

And used when building the hint:

	 static void vadvise(const char *advice, int display_instructions,
	-                    const char *key, va_list params)
	+                    const char *key, int global, va_list params)
	 {
	     ...
 
	     if (display_instructions)
	-        strbuf_addf(&buf, turn_off_instructions, key);
	+        strbuf_addf(&buf, turn_off_instructions,
	+                    global ? "--global" : "", key);
	 }

This keeps the information about the intended config scope in "advice_setting", rather than making "vadvise()" depend on specific advice keys.
