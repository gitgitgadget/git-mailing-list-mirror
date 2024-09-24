Received: from fallback22.i.mail.ru (fallback22.i.mail.ru [79.137.243.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5722023DE
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 15:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727190445; cv=none; b=MV95NjNofXFydzduSfc95uyWQFc0ozAGfew244h2kR65U3cdeBzjk3aeWadlR584iGq/nvkLdJIC10QW0WqpYnkhooLFMs7dvABpyTBow4i2ycQmDO7ewlrwZQm0BWSvcv0zs0R9f5t12u2tCbBSm1ISFPEjrX6gva2N4P5fHC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727190445; c=relaxed/simple;
	bh=UpchHWYyAMVZcW8/GpgCPSqISKi584luTeoSXz4vu4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NLDG8C/GJ0jcqyh9O+WFGOzujtkOWJU14YvPqy0+JZol7ah8bg4EWVDww8Iyo8OMJ/KDCTiY22PgotoJeWu5Mk+yZBapI7Oqsl3EeGthsylvcub0eQS6Z+9zF1RhxY6VmD0itAdhnGJrKZcvmk7KtpE9qRw1l93wGR6Cfbao8O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bswap.ru; spf=pass smtp.mailfrom=bswap.ru; dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b=r33FpkKM; dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b=db6BJstr; arc=none smtp.client-ip=79.137.243.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bswap.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bswap.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="r33FpkKM";
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="db6BJstr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=/vox540iM2T1Nc10TakddXjVb7nkpYxQm0yPBkULKtA=;
	t=1727190440;x=1727280440; 
	b=r33FpkKM6xxJhbSnhJmiolOfz7baKRRK0qOW89zYoirSV1dxf+Hlz35xd1GV92KIy0JYOlaE8WjDATvrf7JRiBchrqsUt3T6s887KwhEksS9sxWzcF+Scm7wHBD29xxm9w71RZorqaT3ww/BGFDfXv7wedUTCxDN7wFd4EoD82c=;
Received: from [10.12.4.5] (port=33828 helo=smtp31.i.mail.ru)
	by fallback22.i.mail.ru with esmtp (envelope-from <kostix@bswap.ru>)
	id 1st6PP-00FnIE-RU
	for git@vger.kernel.org; Tue, 24 Sep 2024 17:20:56 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru;
	s=mailru; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=/vox540iM2T1Nc10TakddXjVb7nkpYxQm0yPBkULKtA=; t=1727187655; x=1727277655; 
	b=db6BJstrsG3vl8zzX1/t/GE/SmRSDzR1MFG9gx4quObDNR45IdTpZiJus/0EFe2Uk5lXz3we/ou
	YK8fPPQDPMPvlWeXb69phNhCbj2hkW41v5IWvgus3whDUmiN9yJ5n9uXA2liIxKBUUHc9w+hJNO2M
	ngc04SnMgGzcXpXna48=;
Received: by smtp31.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
	id 1st6PG-00000002SOs-490J; Tue, 24 Sep 2024 17:20:47 +0300
Date: Tue, 24 Sep 2024 17:20:46 +0300
From: Konstantin Khomoutov <kostix@bswap.ru>
To: Krishna Vivek Vitta <kvitta@microsoft.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git clone failure
Message-ID: <20240924142046.6wkhwnfd5vp5wh3y@carbon>
Mail-Followup-To: Krishna Vivek Vitta <kvitta@microsoft.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
References: <SI2P153MB071833367C62DD94C96CF1F7D46F2@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SI2P153MB071833367C62DD94C96CF1F7D46F2@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD968D81A599CAF0ABB4BC9CF30C36938C9DD6F5139EAB5B156182A05F53808504094DBCF2826EFF87DF378A8CA21F699D63484AC5D780DD367ECBEE71F5DB76FAC3E51E86926A75756
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE70043D879A87EF1BCEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637B3D52627AD81B52CEA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38B043BF0FB74779F36895AF38002A46AE6C28259034C20D6122D7E5507C79EDA9AA471835C12D1D9774AD6D5ED66289B5259CC434672EE6371117882F4460429724CE54428C33FAD30A8DF7F3B2552694AC26CFBAC0749D213D2E47CDBA5A9658378DA827A17800CE77A825AB47F0FC8649FA2833FD35BB23DF004C90652538430302FCEF25BFAB3454AD6D5ED66289B5278DA827A17800CE76F7D1A8C7E90C721D32BA5DBAC0009BE395957E7521B51C2330BD67F2E7D9AF1090A508E0FED6299176DF2183F8FC7C0207D9C0C136568F0CD04E86FAF290E2DB606B96278B59C421DD303D21008E29813377AFFFEAFD269176DF2183F8FC7C0C70DDB8F70474A6A68655334FD4449CB33AC447995A7AD185E1C53F199C2BB95D5E8D9A59859A8B6B0CB1F27BAEB05A8089D37D7C0E48F6C5571747095F342E88FB05168BE4CE3AF
X-C1DE0DAB: 0D63561A33F958A5532E2ACB60FD56085002B1117B3ED696E214045DD0AA262472305013E4AE841E823CB91A9FED034534781492E4B8EEAD21D4E6D365FE45D1BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADBF74143AD284FC7177DD89D51EBB7742DC8270968E61249B1004E42C50DC4CA955A7F0CF078B5EC49A30900B95165D349BD6FB698A487E7E6FE43A200311B4B5F4A1701320799859EF9253E483804D579115287C6773B5BB1D7E09C32AA3244CFE8A9FA9FF6100D086B83C6DB07BF3AEC73F8B4A05B22A1EEA455F16B58544A2E30DDF7C44BCB90D3871D1C702CBDB0A9665A0FD7AD89E8F722DFA761B3F797A
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojamSMdo1tbG8iWDceqmG7Sw==
X-Mailru-Sender: 641179478317D3F0421D0BEF39CFD138A99CE53F7366D3AE91CF6C6A8F7D6EF6181E637B5C3901D806F365114516B2B62F0A6AF357119A4D04176AAE5055CC72595A8557D9C981F4633CE835492D9647D182D770C8C7E642B4A721A3011E896F
X-Mras: Ok
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B414E2BB1FC3DCCE2F9FB006BFDF93B86C99711E96F15ACF5F049FFFDB7839CE9EF2D76237B8270AB355C1B631C30B6A42BE35011AFE73FAC9FF1223046EA3BD0B
X-7FA49CB5: 0D63561A33F958A57D9458A89BA2BC58EB61F73854EA227312E1ED363887C6C08941B15DA834481FA18204E546F3947CF8BD4E506CFA3D88F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F79006379BABF3D50D9A3D87389733CBF5DBD5E9B5C8C57E37DE458BD96E472CDF7238E0725E5C173C3A84C3AE03C408E24EC37035872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojamSMdo1tbG9IxGWvxmUgFQ==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

On Mon, Sep 23, 2024 at 10:47:08AM +0000, Krishna Vivek Vitta wrote:

> We've seen multiple reports of git repositories failing to clone / getting
> corrupted in p9 file system. The mount points under this file system are
> marked for FANOTIFY to intercept file system events
> 
> When we remove the marking on these mount points, git clone succeeds.
> 
> Following is the error message:
[...]
> fatal: unknown error occurred while reading the configuration files
> 
> Any reason why it is failing?
[...]

Are you able to build Git from the source?

As you can see in config.c, the error is reported in repo_read_config in the
case the function config_with_options, it calls, fails. Since it's not
expected to fail - except for some weird reasons, - you're probably dealing
with such a reason, and so you'd probably need to debug it yourself because I
hardly beleive it's easily possible for someone else to recreate your specific
setup. The debugging might be a simple "printf-style" one - that is, navigate
the call chain of these configuration-reading functions, stick calls to
printf() in places where some nested function returns a value indicating an
error exit, build, run, and see which of these printf() calls pinpoints the
failure. You will probably trace this to call to some C-library I/O function.

