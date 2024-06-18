Received: from fallback20.i.mail.ru (fallback20.i.mail.ru [79.137.243.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957C913A400
	for <git@vger.kernel.org>; Tue, 18 Jun 2024 14:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718722680; cv=none; b=B7X3I3NrJLDXwon9y/ket4u3ETKmfl93WLTyk+8zFV/p8GjiVX2KQ4Ils0hAfS8s2hrSMf9ni3ftx5H1Isoh9zfdTCxIfXobraSUBHC9iUD65C6X9+oqN7aJQ9ngGPUryhDbH/hnJLRKduQ67LU2PxRQUVD5FZ++Lu4R8jOf7OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718722680; c=relaxed/simple;
	bh=KSdY8LmTozQKxUFEIiWaTlNHxKz2Pka83n0tZPheqtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C6D+oqGff+2oEHp8Gd6Uo70FJAa+2ezEHTI/Hv0iBIkz4VbsCq40bisCs1Kh7Ctisuf3dxIu+/gY1MtyvzxL17XBvmD7HdejEGATspRm/Xj4fBYegAps56+/FIrSmDE5nYnvW4PVo0GKuITUi21G6lDI8qje2lfQgDCla+qA4Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bswap.ru; spf=pass smtp.mailfrom=bswap.ru; dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b=prMku1u/; dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b=v4W8Wz53; arc=none smtp.client-ip=79.137.243.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bswap.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bswap.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="prMku1u/";
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="v4W8Wz53"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=DSufsdmvUCW0fnci3zycR0k56rFrgBBYgrnKDFVhFSY=;
	t=1718722674;x=1718812674; 
	b=prMku1u/JGRyxvujnqwu+agvzAP3RcWadgOJ6ttopmjrlMiDRu+3oirXCAR4tYz5dvviv7m/dd/A5kLylcBk2545UjrysE0ImPmdQY4B0xjxPCpK8HUIsXqdgbNZijR4+b5fXpyASsRwgfBkzyrsTLrRxr+c84QTOmPGMbcEyj0=;
Received: from [10.12.4.24] (port=50810 helo=smtp48.i.mail.ru)
	by fallback20.i.mail.ru with esmtp (envelope-from <kostix@bswap.ru>)
	id 1sJaHF-000zmz-Dh
	for git@vger.kernel.org; Tue, 18 Jun 2024 17:57:41 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru;
	s=mailru; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=DSufsdmvUCW0fnci3zycR0k56rFrgBBYgrnKDFVhFSY=; t=1718722661; x=1718812661; 
	b=v4W8Wz5392ov0VDP7ernPXeea/es00DMEEvpKdS7zoK63f0LuTLSr5dLI9DddHLrbzgd0AA1j5o
	Zc6QypkS2ESv7kEdACmBoE2C7nwKa+571e520fOTk8KRqUdXNqc4F/gFQ4NkvGfM0j6vVrJdFQ4cB
	tlSAKpsv/ESjOWL/QFo=;
Received: by exim-smtp-5945d77fd4-kx98s with esmtpa (envelope-from <kostix@bswap.ru>)
	id 1sJaH4-00000000HA6-0JRF; Tue, 18 Jun 2024 17:57:30 +0300
Date: Tue, 18 Jun 2024 17:57:29 +0300
From: Konstantin Khomoutov <kostix@bswap.ru>
To: "ELFORD, Richard (NHS SOUTH, CENTRAL AND WEST COMMISSIONING SUPPORT UNIT)" <richard.elford@nhs.net>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: Multi Factor Authentication for GIT software
Message-ID: <20240618145729.47d34yxe7gw36jyn@carbon>
Mail-Followup-To: "ELFORD, Richard (NHS SOUTH, CENTRAL AND WEST COMMISSIONING SUPPORT UNIT)" <richard.elford@nhs.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>
References: <CWXP265MB3013B13F4BC4D7574E6E86E281CE2@CWXP265MB3013.GBRP265.PROD.OUTLOOK.COM>
 <20240618-grinning-kagu-of-examination-bb4e1f@meerkat>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618-grinning-kagu-of-examination-bb4e1f@meerkat>
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD9EB52AADBDB11C14982957B08BD0A66E0E12BEBAABD023054182A05F5380850403AF88F34A54087713DE06ABAFEAF6705C3B2DAC8F4A886A77F061DB90022DDC446CE9711DA951506
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7444CB0504BAF4550EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F790063745476ED688D943148638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D81EAB61BDB27ADDA6D51576F6487E0ADDD28408363784A8A1CC7F00164DA146DAFE8445B8C89999728AA50765F790063783E00425F71A4181389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC81D471462564A2E19F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947CAD74539164518AE5C0837EA9F3D197644AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C38C3FA5C133757E88BA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CFED8438A78DFE0A9E1DD303D21008E298D5E8D9A59859A8B64854413538E1713F75ECD9A6C639B01B78DA827A17800CE71B8D961A28FB0488731C566533BA786AA5CC5B56E945C8DA
X-C1DE0DAB: 0D63561A33F958A5FA60CC069229C49A5002B1117B3ED696A38CDCD0D1F8690BED71F038FC046993823CB91A9FED034534781492E4B8EEADA79578C5CF9A9009BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADBF74143AD284FC7177DD89D51EBB7742DC8270968E61249B1004E42C50DC4CA955A7F0CF078B5EC49A30900B95165D3490011A262ADAEDFE91983764AEFD2554BF6B27979C5510C0C6F9655FF4372A28B0AF87C7D9CFC4171D7E09C32AA3244C75B933BBD9657B0E77DD89D51EBB77421EA07A3FE0C9D8DDEA455F16B58544A2557BDE0DD54B35903871D1C702CBDB0A9665A0FD7AD89E8F722DFA761B3F797A
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojJvJpr60SBvJFStDRs5scmQ==
X-Mailru-Sender: 641179478317D3F0421D0BEF39CFD138ACC19B6405198AC71356DD24693B53BCA742130DF286CDFCE94C66DEFE19830C2F0A6AF357119A4D04176AAE5055CC72595A8557D9C981F4633CE835492D9647D182D770C8C7E642B4A721A3011E896F
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B48BD2CE4D659F6DFA12F12A86912CDE58500F29A7524D7ECD049FFFDB7839CE9E322940641E2FED8507C605B02EE67000CACB5852BA04E09C1E054E3AADB92985
X-7FA49CB5: 0D63561A33F958A51EA01C7EE3BF6C61B8AC0D1D4B5F431A804AAE0F491B4E6F8941B15DA834481FA18204E546F3947CD56D36E97F3F038CF6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F79006370A2DD59B67EFEE27389733CBF5DBD5E9B5C8C57E37DE458BD96E472CDF7238E0725E5C173C3A84C363D77626233CE5AB35872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojJvJpr60SBvKkE+MM/Bbwhg==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

On Tue, Jun 18, 2024 at 09:41:05AM -0400, Konstantin Ryabitsev wrote:

> On Tue, Jun 18, 2024 at 12:19:19PM GMT, ELFORD, Richard (NHS SOUTH, CENTRAL
> AND WEST COMMISSIONING SUPPORT UNIT) wrote:
[...]
> > I am writing to enquire about multi factor authentication on cloud hosted
> > software.
> > protect sensitive data, we are seeking information related to the NHS
> > England Multi-Factor Authentication (MFA) Policy with regards to software
> > products which we have from your company.
> 
> There is no company, so this questionnaire is not relevant. Git is an
> open-source project without any one particular entity "owning" it.

Richard, I'd like to make a remark. May be - just may be - you're confusing
Git and Github or GitLab. Git is a free and open source (F/OSS) piece of
software, while Github and GitLab (and a plethora of others) are Git hosting
solutions which host Git repositories "in the cloud". They use Git but have
no other relation to it.

So you might want to first check with your IT personnel to make it absolutely
sure what really is the issue to discuss: Git-based solutions maintained by
NHS itself or Git-based solutions provided by 3rd parties. In the latter case,
the questions like yours should probably be directed to these parties.

