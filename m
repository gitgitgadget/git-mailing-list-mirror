Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ED22EA73D
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 11:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780572263; cv=none; b=tUQi76d2QKd/ZG08kgzZNcMCNslHszvSboKSGnq7JKay1pxBRV+kwi4rsZZUMenwh2I2XdbR1R0wZWSumMt6YixCdatlhknd135ah8Jyd6JGQCHVlcbS3v4PtBpwawwh7aI4lZn+wqMGPKXN51wswD+2ymjHoIrsvt3bFE383TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780572263; c=relaxed/simple;
	bh=4xgBJuaPKsPPdTIFm8myl6ZDvcKaGSb/NF0cekmai78=;
	h=Date:From:To:Subject:Message-Id:MIME-Version:Content-Type; b=nHLJNw8/0ncdbqsiegdh/a9MHbK5NfuoQCVlX1tKZj57BlUx2v/8cFS1SwqPuKOlqhHuGCQy3wizOUIFI2mQPZOscz5wjNj05rRB5PDn5mw0OlBe5Dv+NFzaBCxUAQjlgLPZc6X86u499MagGMLMtmCLtxE0+1tQXLx48Obp2dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xenu.pl; spf=pass smtp.mailfrom=xenu.pl; dkim=pass (2048-bit key) header.d=xenu.pl header.i=@xenu.pl header.b=bkXNUSfI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WNffA31r; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xenu.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenu.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenu.pl header.i=@xenu.pl header.b="bkXNUSfI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WNffA31r"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 61FEAEC0112
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 07:24:21 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 04 Jun 2026 07:24:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenu.pl; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1780572261; x=1780658661; bh=4xgBJuaPKs
	PPdTIFm8myl6ZDvcKaGSb/NF0cekmai78=; b=bkXNUSfIIpgwDkqCBatd/Io8iS
	JqmHbD9vXVqq/LTJTbpz4WMdC5J1Psa/Xs6tlq8/zxeyNDDnGofU2gQ+b7ktiBS8
	f/fMT/o4fYhak/3Rw4q49/RE1SJcj4X3NiVebLOrMhA+9ofUwpTsuGmaRNSuzh7q
	QJFNeRFR692AaYdNaGqTd9qhgyqC0MJI8XoJdsbmf1Hs3e5aGaXFbnX9ELhFNvta
	Vi/YR/3jz/pe2O3jGANPGOPkB1/L6thPWBN5zBMVfN0m/Yd9Y32cak61hV7J7/+8
	3u0IzZsS/q6xJn1q2rjK2SuQnplzH7zvMHs12sjVCDhj2XbIgHLFmI1yc1jA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780572261; x=1780658661; bh=4xgBJuaPKsPPdTIFm8myl6ZDvcKaGSb/NF0
	cekmai78=; b=WNffA31r4I0icSxy9fTXXtLniBmwryAxFvvz85dn5fP16Z08SJf
	TMdtJ/vnpZJRN8gRK7/zqhKFa2hfVp7fmDQm0xhzW+QdUAiNDSSHVIekNNuvpsZ4
	rStlx50Xe6Ybc0HBpFcTw6gef0GWxYc0oh/5LU15m5DJMSF4yf450+FFxtdm7oHg
	s+BdQDU3IbP9i6frV+kVJlAZAg3wi6qeu3QZYSj52eHAs/OlXhk0YBTTVNLn+TuK
	W/CwJGZwloIoyhgEpz79Hfn9TCrwz1EbC6wtUXKhW0vN8aacNf5IOh3wXTm2P0LH
	YZhNV4bnpWj3q6GtPe349rJSe1Z6yzrLAiw==
X-ME-Sender: <xms:ZWAhah0r4IVJuHXzUhBScZUcCKiij36LdtTwxanBX1TmeIR7fN1UqA>
    <xme:ZWAhavB9ivIYjrBHH_s0-c5lb5Fb5NeKWALBs7dKhKaCPz3ZbA4RU8FUgsXeRyqwx
    Fs5VOyFP3wBwIV-C-tmSKag8_hPL5WZLXNt3b46gEXtIoRxEa5b_g>
X-ME-Received: <xmr:ZWAhaniqf2dqHEg2RBEB2qL_W-hMmLllMTjmP0WDlYeNOwcXc4flvcXaGyLuRHBIkf9P5ARfum7e6GPZEw15q3iVeETWZ0y0TuK3_OKVbBMa8w>
X-ME-Proxy-Cause: dmFkZTETk33MSnNyq3l0yEZfCc0d2VJpDiVp1TuM1MS9YQqKGgJkf7MWAwpX2mgT/Fdgkh
    ZTbDrOig6usP9zsZ5To2hLdrfIaLHDS9OVIKsPvb4ykqxz/qqDdquW9olJLrunfq8pW5KD
    mTejH8YcnA0EoYZYTkFm6WI271HsLBu3o1C1arzMGm7zf15WNyLqSrTnUlMy6OxI5d44DN
    lQdi42XO9B7VApUox96KvnvO1odNz5KmMrxDOJlz6BEPa7NdeBfhgjFwlp8icC9yLablBL
    mMjLRk97FyS7VjiPusDQUNGAHt3pa05s87GjKqqJ6tkWXbkY821miv0vAJF7AUDE0xn8YU
    BHKFvu1Q/ju5dpc4LAG6A1DxmmmkqPwjA14C4QuEY7Gk8qhKUzAXlGMHdyN/9/I422FadE
    H2tYCvXq8o3dezfauw8xtGhjcaEQIb0bF84RPB9KneDZpCl3e2Z/XCujbuzHy3xh94owNW
    tFedQfNp3H3ljLsGxjGeEHOEk5gQi8eCFI6VWM6Iyf3Pl/B7Fu9nDJgFZGhxev3xsdqB7Y
    2VoA/2gJjG/zcaZXUJH5vSy9UIwVkn8ezPs+aBGCBzgNbmMvXNE9puFx+HvEKIpHVstQF1
    l27LLnIzgXoRU/Y5CsXlPPjKOp0tTiW5tfPlnMDCheHtrBfPFNzq4qFTkTEg
X-ME-Proxy: <xmx:ZWAhaj_mmGMSto3RISDHJSrkb_Q6qwp_x-XnNocPxlSEtGrRkZTyfQ>
    <xmx:ZWAhaj-YL0x6p0JYP8_jHCL2UGq2vOv03X75em_d43P4apUwd9zqIw>
    <xmx:ZWAhasBZy_AqyGN3psJmEbrACerVw6b3wXzh8LqqNNbkBWlNQ7CdcQ>
    <xmx:ZWAhajzANoUBNp0FlHNZ8CehVsdGJAg8dnUj_AIQFYxaAzo4z8iL8Q>
    <xmx:ZWAhanFDH9LrsMlOO3HFoTvAL9E7Z5XAcqUq5AhOOlnhCGD_G5b4pVtm>
Feedback-ID: icfe843d7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 4 Jun 2026 07:24:20 -0400 (EDT)
Date: Thu, 04 Jun 2026 13:24:20 +0200
From: Tomasz Konojacki <me@xenu.pl>
To: git@vger.kernel.org
Subject: Is it intended behaviour that 'git gc' ignores the 'commitGraph.changedPaths' setting?
Message-Id: <20260604132419.F2FA.5C4F47F8@xenu.pl>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.82.01 [en]

Hi,

It seems that 'git gc' (and also 'fetch' with 'fetch.writeCommitGraph'
enabled) ignore the 'commitGraph.changedPaths' setting.

See the output below, the commands are being executed on a repo that
doesn't have a commit-graph generated:

$ git --version
git version 2.54.0

$ git config --global --get-all commitGraph.changedPaths
true

$ git gc
Enumerating objects: 674076, done.
Counting objects: 100% (674076/674076), done.
Delta compression using up to 16 threads
Compressing objects: 100% (137084/137084), done.
Writing objects: 100% (674076/674076), done.
Total 674076 (delta 524292), reused 673941 (delta 524158), pack-reused 0 (from 0)
Enumerating cruft objects: 6160, done.
Traversing cruft objects: 12279, done.
Counting objects: 100% (6160/6160), done.
Delta compression using up to 16 threads
Compressing objects: 100% (1802/1802), done.
Writing objects: 100% (6160/6160), done.
Total 6160 (delta 4314), reused 6160 (delta 4314), pack-reused 0 (from 0)
Expanding reachable commits in commit graph: 131458, done.

$ git commit-graph write
Expanding reachable commits in commit graph: 132865, done.
Computing commit changed paths Bloom filters: 100% (132865/132865), done.

As you can see, 'gc' didn't create changed paths bloom filters, only a
direct call to 'commit-graph write' did.

Is this intended behaviour? It's very surprising to me.

Also, is there a way to make 'gc' and 'fetch' generate changed path
bloom filters?

Thanks,
Tomasz


