Received: from avasout-peh-002.plus.net (avasout-peh-002.plus.net [212.159.14.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11BE323E
	for <git@vger.kernel.org>; Sun, 21 Sep 2025 01:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758417436; cv=none; b=YMIVX10p5m0dUsjqUOkHupzIDhJF9CtxpTgbGAMdYcge4O0fZ2hqc+1bjZvBSnjNnOMBwB1pO75KWixKa4rMYKHe6pMbgTmXYY74wsCxuR1vay2URxZWEbb1OdfbwmjsHE1PAD3DvTJvqZ8kPOQyB2YHgvVDm88f/4hbRagqVtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758417436; c=relaxed/simple;
	bh=njGOUDg3EdcDEP8y+q8h+YFaY3GxZiNWB+6F57d6qgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OOdfzH7fx02pO+l8RjEujAgoS/8/J1Gc2dNFrweXXcuWhsoXobQClVLl48N2R7N+vxpBxeUAQgS8GY+0GG9scevL3wBq32foebZWOps4tKBp0JDCXLEl/2E7LCIqEAXXkg9K9v/n7r0wJ3jk2eUv/7Kvk0cE9HCX0kzkE7bBI1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=EUStpGHT; arc=none smtp.client-ip=212.159.14.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="EUStpGHT"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id 08eQvej1FYrrN08eSviUTT; Sun, 21 Sep 2025 02:14:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1758417244; bh=GfQm9ehNgPkgKDlgCQLfy/ITBZ202/I8LN/vkfbyEZw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=EUStpGHTgEELIIPCAkMdg+6zxOaBgfbvbVdww71ucFhGDrecCKZDl1CnPHKjnPr6d
	 YuOJUBdxgSY8nAnNzSORQ+sodpxR2/O2GJkg1PKaafJLQc0HHWlNFOmNKrgBnLUQo+
	 qlBY4uuJx2/LoYnlnvHZXwJ3mE5cqRvOIVZXoN+bzRW0LR8jymeIYqHMAmKPZEsczQ
	 UZNlNxM9qQMn+Jgq1yFcrpi+NDzHl3SOSHUG1v65S99wGDnMrfY9EEYL7LwU2okIxS
	 CnYik/PrG5if1nUMYoN4uXkF5O8fdB5SxbtgXKWTvRheXp+vy26q+eOheraKCheKmM
	 wqH2D72Lhh7Kw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=ELSl0EZC c=1 sm=1 tr=0 ts=68cf515c
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=ei4SEBeUAAAA:8 a=VwQbUJbxAAAA:8 a=EBOSESyhAAAA:8
 a=pGLkceISAAAA:8 a=ybZZDoGAAAAA:8 a=kKjDrA_SOqDN6jKR7DMA:9 a=QEXdDO2ut3YA:10
 a=8zIOOLb7Ym0NljyPXbuS:22 a=yJM6EZoI5SlJf8ks9Ge_:22 a=0RhZnL1DYvcuLYC8JZ5M:22
X-AUTH: ramsayjones@:2500
Message-ID: <0104ae22-e5cb-41c9-af8c-4d9b0035c219@ramsayjones.plus.com>
Date: Sun, 21 Sep 2025 02:14:02 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/18] make: add -fPIE flag
To: Junio C Hamano <gitster@pobox.com>, Collin Funk <collin.funk1@gmail.com>
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,
 Eric Sunshine <sunshine@sunshineco.com>, Patrick Steinhardt <ps@pks.im>,
 Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
 <pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com>
 <7082e32c5975d2aaa277eddae7497eba0f2131e0.1758071798.git.gitgitgadget@gmail.com>
 <CAPig+cRGtMX9bQhb+7g5aXRVjpLKY-qDdQP95f9TmbY8j_BweQ@mail.gmail.com>
 <CAH=ZcbAOBnEVfyNy_4hdpe_dvsqDxsKVTcvurJz_iUWiqOzG3g@mail.gmail.com>
 <xmqq5xde435i.fsf@gitster.g>
 <CAH=ZcbDvwbCdnpeNv6vp=+Zy1h8RpG125ZCQNUzNOc5qLi8gNg@mail.gmail.com>
 <xmqqa52qypo8.fsf@gitster.g> <87plbmyox4.fsf@gmail.com>
 <xmqq1po1ysxk.fsf@gitster.g>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <xmqq1po1ysxk.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfKq6bQZNXyyTRpRP3nHo5oA5TYHAwq7e0gymv92rqO9DWu7KlnxZW3LpDl3GjklylN0xYCVdz0mSao3rNPL3DCkuhBfqlLrzeBe3aZG2tIFSCm3ayf53
 k1+KTa+RGPP9v1nMbzhuTFtHoP3axLodGMe+iNPD4pWHc+JwoBFvcq0/fSs3V0BBULdsHFn//FnzzvPsrEBBtW2b9yUSskXUt8Q=



On 20/09/2025 17:44, Junio C Hamano wrote:
> Collin Funk <collin.funk1@gmail.com> writes:
> 
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Ezekiel Newren <ezekielnewren@gmail.com> writes:
[snip]
>> Not too familiar with Rust, but looks like the answer is here [1].
>> Specificially, this part:
>>
>>     pic - fully relocatable position independent code, machine
>>     instructions need to use relative addressing modes. Equivalent to
>>     the "uppercase" -fPIC or -fPIE options in other compilers, depending
>>     on the produced crate types. This is the default model for majority
>>     of supported targets.
>>
>> Collin
>>
>> [1] https://doc.rust-lang.org/rustc/codegen-options/index.html#relocation-model
> 
> Well, thanks for joining the conversation, but that much I think is
> already shared by those who are involved in this thread.
> 
> The background was that Ezekiel did not have to do anything special
> as far as he knows to get things compiled in a relocatable way with
> meson based build, and with make based build, (which I know has
> never used nor required any PIE-ness) he of course needs to add it
> in a way that is portable across platforms and compilers we care
> about if we wanted to have PIE objects.
> 
> And the question was what, if anything, does meson do specially to
> do so in a portable way to enable PIE.  We'd want to see if it meets
> our needs (it could be that Ezekiel is getting lucky and meson based
> build covered the platform+compiler combinations that he happened to
> be working with) and if so mimick that on the Makefile side.


Yes, meson defaults the compiler flags to -fPIC (see e.g. near the end
of the original cover letter of say [1]). You can change the compiler
flags that meson uses (can't remember off-hand how you do that, but it
is documented), you can even set -fPIE, or remove -fPIC etc,.  ;)

So, I don't know why rust (seems to) require -fPIC/-fPIE to be able to
link to libgit.a; maybe we need to add some flags to rustc to _not_ use
the equivalent of -fPIC/-fPIE. (I haven't looked, but I will note that
the GNU nm program complains about the rust built library!)


[1] https://lore.kernel.org/git/20250416231835.2492562-1-ramsay@ramsayjones.plus.com/


ATB,
Ramsay Jones



