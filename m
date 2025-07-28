Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BED81F1517
	for <git@vger.kernel.org>; Mon, 28 Jul 2025 15:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753715333; cv=none; b=dVEQXKI6uQWNMmTIHHvfGHz5SZKp/ndAc6EMlEctfvNhZahUuLJ+9uZHDZFBCGEfZ0/VQJaw6IUcF2UF0Wb9E8CkGGKBGv67Qauzd5aO54QakAiCARf541LJ37brUk10RbUYK8dGyBjfmX9PfOWWkUgcy5OL/9O73+rzLKoZYjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753715333; c=relaxed/simple;
	bh=QaJO07CU3pTtWBK+EOEEcijTP9lxi1EmOT9l1mKUXCk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dgQv2tGJ4V4x/cT5QHLoEgCaAL+XiNNRs2SCcZaODzBAZiyQzsBtxHf1QSqfU/Xvo1lGJ1zCAKAg3lkPCfqKL8kg7i5l+22w9mKt8egaJbIXWSM+QV/vFIqgjOejzgIrggojdTiv+SThXGV/EGitTTDzLmQ/48vGcnJzHUr5BnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dh7UjW1c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KHs4KkBh; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dh7UjW1c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KHs4KkBh"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 8D244EC11FD;
	Mon, 28 Jul 2025 11:08:50 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Mon, 28 Jul 2025 11:08:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753715330;
	 x=1753801730; bh=bHukwYvX46XsjRhnsa5pMW5wkIckGvSJwq+ELlzazeo=; b=
	dh7UjW1cXX5GikLVcBqbcxLQKDtr5BVOmHyRY9RMMbj8PoG31t1MZ51gkcduB9s/
	aV/DhrkN8woKfJwTncjwFPRIpgzRmcO4VvtSb8iBjm7cRLZV3zXoK/z8R7O+2246
	Pv74b1/r5PetjK5k7/3F7a3lG95yos6brQTCQ5qrg8W0+T3XX1Qj4k5u29G1HtKN
	QdRNOIg8m4BkBQfEiLP9mbN+78OlvkepVGvQ3LSiWCRT9EMTkrPjh7M818X/dxGM
	5jwvWHCdm2bTvkXREIZ3F4XfZf1OPxMhNe/D9Ng9IJ4+AnK+mNZb9Dqb4pl/fIy3
	momCB/eNbxrTqWDRqoY1gA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1753715330; x=
	1753801730; bh=bHukwYvX46XsjRhnsa5pMW5wkIckGvSJwq+ELlzazeo=; b=K
	Hs4KkBhPdn29PwUMO93oaTpADS4bi6Df4PZ86xE4eh4N3/CkqWhL5LzdrhciL+cm
	Liftg1BfmaBdd91HRSLrAk1+dHSEP0Fn1YVfS7EAlKWowGrtTUWh7LLJltwFZUcE
	Au1H726FyvrUkxMR2CSP0xRAwfPdeXa7gsQZ1bVm2of3PX5CiPn01tZJRnp8oULN
	X0Lh9Idicouh/k0gBEM78EN0KVkm+cdxrG+3EH3+XeU7cVuiLT3RB6DmV+mvmTJX
	bzYvWjoKnm6b4KwLpCwUtRCCfCYKctk6MRJMHtwjrMeasOqfY6BHShzPoE/3CXRp
	OFig6kGulpv9MtkAHIKIw==
X-ME-Sender: <xms:gpKHaIqln9lAEOn41WaFI6Jpk3i_XJ5zC7XW0rmZmCL7cj2_h-QZdA>
    <xme:gpKHaLk1ePIQWvlyRyzX8p5vVPPxdBF_DH9TUP2CVKD7bPJyLdzFLwCC_zGF84KZY
    7r-gLvX_5Mfi-xRcw>
X-ME-Received: <xmr:gpKHaI0z6KZYPn14j9XwMGmuI26oHQXPnEi-wbaFzbuTbCVJiIqjv1BM2XSdn0USHnZfIxtZI7sUetM0yRD3BwHX_oqwBGyWWsna0zU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelvdeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekofdttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepteeiheeugfeigedutefhuedvkeehhedvvedtkeeggfffuefggfeklefgtdei
    udegnecuffhomhgrihhnpehhthhtphdqphhushhhihhnihhtqdgusghinhhsthgrfigvsg
    drshhhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    ghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpe
    hsmhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepuhhsmhgrnhgrkhhinhihvghmihdvtddvsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegt
    hhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtoheptghhrhhish
    htihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgr
    hihlohhrrhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:gpKHaIQvaaOoNHWZNJLn3sz4dpgarDOOds33sSwKZsTWTdhvJUZKAA>
    <xmx:gpKHaBzR4TpOQa-9aRSf23fVzvw3SOmL8sWE7YHBWUYOzEQOByMyGg>
    <xmx:gpKHaICBmISgBcN6F6Y7-8zxLvKFPumBR0iQ3eGY6Snkc2dN3-AhjQ>
    <xmx:gpKHaNED_A3pvxCNVAxZdOhiPqteVX-HwXxazaaKa1K5ZfeCzawXpg>
    <xmx:gpKHaFWMRPHmyyxsyesIVMgelYar6vc1M2sg8-TwiItl-avGw-rYh-bc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Jul 2025 11:08:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>,  git@vger.kernel.org,
  chriscool@tuxfamily.org,  christian.couder@gmail.com,  me@ttaylorr.com,
  ps@pks.im
Subject: Re: [PATCH v4 1/2] t/t1517: automate `git subcmd -h` tests outside
 a repository
In-Reply-To: <CALnO6CCN0HUXJVYmvAJO3EoQQZzHVjE0P=g+AUc9c5Ti0Rcm2w@mail.gmail.com>
	(D. Ben Knoble's message of "Sat, 26 Jul 2025 10:34:37 -0400")
References: <xmqqcya63cqx.fsf@gitster.g>
	<20250721115519.140361-1-usmanakinyemi202@gmail.com>
	<20250721115519.140361-2-usmanakinyemi202@gmail.com>
	<CALnO6CCN0HUXJVYmvAJO3EoQQZzHVjE0P=g+AUc9c5Ti0Rcm2w@mail.gmail.com>
Date: Mon, 28 Jul 2025 08:08:48 -0700
Message-ID: <xmqqzfcoxshr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

>> +for cmd in $(git --list-cmds=main)
>> +do
>> +       cmd=${cmd%.*} # strip .sh, .perl, etc.
>> +       case "$cmd" in
>> +       archimport | cvsexportcommit | cvsimport | cvsserver | daemon | \
>> +       difftool--helper | filter-branch | fsck-objects | get-tar-commit-id | \
>> +       http-backend | http-fetch | http-push | init-db | instaweb.sh | \
>> +       merge-octopus | merge-one-file | merge-resolve | mergetool | \
>> +       mktag | p4 | p4.py | pickaxe | quiltimport | remote-ftp | remote-ftps | \
>
> Hm—if we strip the suffix with ${cmd%.*}, do we need a p4.py
> pattern too?  Actually, at first I wondered why we need to strip
> the suffix at all. My local Git produces only unsuffixed commands.
> ...
> bin-wrappers/git produces both p4 and p4.py; request-pull and
> request-pull.sh; and several others. So I think stripping is probably
> right, just drop the .py pattern.

Ahh, OK, I didn't realize that bin-wrappers gets into the picture.
So you're right.  Fixing the bin-wrappers may be necessary, but
dropping the extra ones is certainly a good idea.

>> +       test_$expect_outcome "'git $cmd -h' outside a repository" '
>> +               test_expect_code 129 nongit git $cmd -h >usage &&
>> +               echo "Hello" &&
>
> Woops! While basing some work on this branch, I spotted this "echo"—I
> assume it's leftover and didn't mean to be included here?

;-)
