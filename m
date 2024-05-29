Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A781E888
	for <git@vger.kernel.org>; Wed, 29 May 2024 09:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716973745; cv=none; b=ICSZUSX0GL1r3VP7TOk/8HxfQ9OUWKuxSCEWkoROyO14v1xWiS4zUFbIiuzm4nXRAxFTYdGIdjGKMmsbUmobjS2X9wf3mRX8UQcbK7GqWtie8Shja7gUFsRVArCODs/irWLwxgv5emXlqqxCZ78TmilvReYk4bArfmsuOsKtIR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716973745; c=relaxed/simple;
	bh=TKN6AsqqSpCXtcFdHEHAYdhc5svSAIs0SP37DTlQi6I=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=s8VcaO+Ip/EUX4lGt1g/V7bZ9gtGUgdtN9E2SRScXaKElMqOlmouP4kGMaKH1bG2QjmfQnpoHjI7NhHSAlxr8gwczgHAGDrcH2FISq2wXtU7nfLZGbTdcSO+KbPwOVzP9xxO1oLdHEX6RjXMeoou8wc1HP6y6e73PQbYo9XMI3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=x58yPKEK; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="x58yPKEK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:To:Date:Message-ID:CC;
	bh=TKN6AsqqSpCXtcFdHEHAYdhc5svSAIs0SP37DTlQi6I=; b=x58yPKEKCZJPpqkjE9yIJrJSGz
	A/uCT7ajQMB0r26yE/06TKdLFY4Gc7uD6Lw/qS0SKEHWQozDgcjZVdqYfiV7AlXUgwOaoQ6HI3ndP
	yAUUkFK4YROfD/osa4Ipr0Rw26Z26pG6nROloYZYTAOdvF0iPH5EwQBSiUQkBDskE1caryFOy1cf2
	Tnp0eoPINo26bt2cxCxj1t8DbdvdqBABPCxkLV1L1sojk4KvGywrcNzbRf5iViuxe/yvX3vsFqI0r
	mCF7JG3W2TPmO5nQUc1XY4GCCrbLE7o12/8inRMOsB3KDkz1ULKZk6mOH4QU/IJK1QV5IYzm8USaD
	iXopPXR3YUTpEx++jPwSYuf+ug2ZIpGI7TOm+u3cYtkQnRx5Tn91WMTbg1Wr0YDobfh04o9GHYFnO
	1Txp+hVbGTo535a5DKcfG5ceA1USdtXlaYuGp8s5OoOiBxfX1Pv96FNYiEI4R7OMpo30G4Jhkqy3N
	gnnMg8nMohFKpjxMQolbm1t9;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1sCFIl-00Dng8-1P
	for git@vger.kernel.org;
	Wed, 29 May 2024 09:08:55 +0000
Message-ID: <715163c3-8d59-46ef-81bf-1dda10e6570c@samba.org>
Date: Wed, 29 May 2024 11:08:50 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
X-Mozilla-News-Host: news://nntp.lore.kernel.org:119
Content-Language: en-US, de-DE
To: git@vger.kernel.org
From: Stefan Metzmacher <metze@samba.org>
Subject: safe.directory wildcards
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

given the recent importance of safe.directory, it would be great to
have something like '/data/git/*' to be supported, not just a single '*'
for a server that serves a lot of public git repositories owned by different owners.

Thanks for taking care of security problem, even if the fixes sometimes
have unexpected site effects...

metze
