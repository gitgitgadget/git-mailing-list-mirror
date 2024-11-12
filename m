Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5239921A6F0
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 23:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731452622; cv=none; b=gbCBvm3BMi3z6oUl18/NXfF/KSWC0j1VtlwO/654LUkO47Jg2wkOADyvNgQqZlbDVYLq55gu7zT6+7OFpywRBSVv2bX10xXCF3juUuqZeI+R7FS0WDJ6uHm+GWXPOYqIdG3gq3qOkUtpJRAE0/ZEqOw0eNvMD1EnfMjKJ4qS5VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731452622; c=relaxed/simple;
	bh=IsXbN4+J/EPUVQ5lfDOzFL77X57qP27B7QPBSEzEKqc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iHav4OQpuP5OSS6gap4bdpYSQUZXH0MSIMw2CkRVypoF9L2JeoEUmtw44vylcDhKGjrjsFTPuL/yYaLwjRj4RxoOYxKZouJXw+4SYqdLpXn0IWT+5+bfB6JiQq3hRFbzIt3LqU2W9sFQ4Eq2mvs+HaJ4d0jtewpXEHD9dBVMmt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hHPZ37sj; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hHPZ37sj"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 4A76D11401B3;
	Tue, 12 Nov 2024 18:03:39 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Tue, 12 Nov 2024 18:03:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731452619; x=
	1731539019; bh=7tfEuJ9SqufKPl8YG5x9rLbSZJDyAy68U35QJkxGxGE=; b=h
	HPZ37sjXdshW83/YB55utQJoEivfO/5eTut4qC4ljaYdYB4hgYCS+Lm9q+TnmLEi
	uHCR8gm2JJTde4JaSV9TXTevIAUv1U8XXaVJsMiivY1fdGgqkEI85FYxadgg7/Kr
	gDdqrFo+zch9Weo7u13NTdtlcyX3Cs84exa/7z/3TO/tcNCooiW9re1Eqh3YSW1S
	/B+dONbQcSPpvMn+TIYYc1Z5vPi/xxtrg3UA550afFJneNsEIa/6g/WwRNYyJynM
	Dz33IR9g7OxZADkPKwnQ71tcOYv1QY5fmqeJENzZrds9Z1NuwLM7l9RAc7RLGDNr
	k+jXcmJwcHi3r8h7qHBZg==
X-ME-Sender: <xms:yt4zZ6sXDt2fPEkUWhTi2RRagodHPa6qdLEy04zmnaXNHeEpq9uh8A>
    <xme:yt4zZ_fR3StcpV94-_JFzUThAU0wyeRiSFu-UJb19nh40-3QecPjtBk9uJtlev-1p
    pZrVu3VWa_wSK4jjg>
X-ME-Received: <xmr:yt4zZ1yoKrEqXqWs_V5wKsznt_h6OfjK-ty_atT6sZ7JHLFRLFd959047qyY5DrsKHK1u1WdKuSyuPVrwgTnrJcbReAfBhkEuIvH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehgddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeen
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfekfeeh
    iefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjheitheskhgusghgrd
    horhhgpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohep
    phhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:yt4zZ1PDHwQehRDcLiZYJhxN7jvaLYJpvV4509tc_mWHmO5qkowq9g>
    <xmx:yt4zZ6-AypFxOw9fwix2sb7rnxj9VksyHzQeJb2ONt_r7cUCGjV9XA>
    <xmx:yt4zZ9WgEOcuApcdyWS07KsJhh8M9idhRmglyhI3ca3iJUpT1TiMoA>
    <xmx:yt4zZzdqjb_yjU9TD2G3bd1xwgzVGmsbYa4u9OzpRc_DSFVuf1iz4w>
    <xmx:y94zZ6y9rMHIOs1fWYp160OQYqrO4AiBjemAU9rvcXfFMO8t4XjrAHbA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Nov 2024 18:03:38 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,  Patrick Steinhardt
 <ps@pks.im>,
  git@vger.kernel.org,  =?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget
 <gitgitgadget@gmail.com>
Subject: Re: [PATCH v2 3/5] doc: git-diff: apply format changes to diff-format
In-Reply-To: <6c1c1ae2-f38a-4458-a9ad-2fad3e56fc32@kdbg.org> (Johannes Sixt's
	message of "Tue, 12 Nov 2024 19:51:37 +0100")
References: <pull.1769.git.1722801936.gitgitgadget@gmail.com>
	<pull.1769.v2.git.1731343985.gitgitgadget@gmail.com>
	<8fec37ee17481039998af65ce1abec753cf30897.1731343985.git.gitgitgadget@gmail.com>
	<6c1c1ae2-f38a-4458-a9ad-2fad3e56fc32@kdbg.org>
Date: Wed, 13 Nov 2024 08:03:37 +0900
Message-ID: <xmqq8qto3vhy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Johannes Sixt <j6t@kdbg.org> writes:

> Am 11.11.24 um 17:53 schrieb Jean-Noël Avila via GitGitGadget:
>> -The raw output format from "git-diff-index", "git-diff-tree",
>> -"git-diff-files" and "git diff --raw" are very similar.
>> +The raw output format from `git-diff-index`, `git-diff-tree`,
>> +`git-diff-files` and `git diff --raw` are very similar.
>
> Throughout this document we see a lot of commands with dashes `git-foo`.
> Does this have any significance, or should they be corrected to the
> dashless form `git foo`? It could even be a "while at it"-change as you
> are touching every instance anyway.

Yup, these "git-foo" are historical wart from pre Git 1.6 days.

>>  These commands all compare two sets of things; what is
>>  compared differs:
>>  
>> -git-diff-index <tree-ish>::
>> -        compares the <tree-ish> and the files on the filesystem.
>> +`git-diff-index <tree-ish>`::
>> +	compares the _<tree-ish>_ and the files on the filesystem.
>
> Now that the backtick formats the content as in the synopsis, why is it
> written _<tree-ish>_ and not `<tree-ish>` in the running text?

Perhaps that is because the body text does want to show the
placeholder in _italics_ but not as a `literal` string?
