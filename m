Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDD53DEFFE
	for <git@vger.kernel.org>; Mon,  4 May 2026 15:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777907616; cv=none; b=XmDmHYIMQwPXCgLdbW+szwbms5dlmhyFMf8RvkEHxYPiysy0xCpSYg8FhxSftFOOzVNlGgnVmfh5NR30uMYqnK+MJJNJFDUnI4vO6BHYgl9KieL2hQfz++D0b6lN+9NTo4GdUGBEl66/pQRPJnGXMe6CLsJsygx769R4A7DdDeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777907616; c=relaxed/simple;
	bh=BFPFJznAHitID4S0LzKMu7zyMWzcfL9bORgTcAoAlHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qh7JUcSXIvWteKQXeztNCKBiNeUdOwF+nkAj/ZF6EN+UbCyLnM0ljjM7YHSVz4v97e6NHeHp6myAaL27bmxTUdXlfNyrSG2AT4DMqbpL/TdBb6S3VrvSCBIgjO+8P35pjpuRWv/hC8MkXzg66LfylQe0jdhKXTZmV6PdoMvBlhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=swbZl8sY; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="swbZl8sY"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8a4b8c3a30bso44371336d6.3
        for <git@vger.kernel.org>; Mon, 04 May 2026 08:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777907614; x=1778512414; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BFPFJznAHitID4S0LzKMu7zyMWzcfL9bORgTcAoAlHA=;
        b=swbZl8sYBRBre0HkSuXQIAu642M+S3EDZwt+pztphssdGIfUmIQzdvesL7WdO9luae
         gSeKVxQF4cJGikwQTYM6La15suWUsTfkh+nz6L6tmIBUJuSFAXRV35FQZ0sEv9NpAvnk
         o+L5BiybHuWXf2DtTvhE3tuHLWzIF5sRHZSkYPU1IOkSmR1EBsa/mEmrZ3GHSrvU8OTw
         04R19vPJb672HznoPCmmfrbPtdIR0zImLLqWQkWYDri2MvnwI/BZy4FQUbbx651vcInn
         FmnkbfafrEiLoVo53ytfYHPJYVxx3R+1FTSzfKto/3ROWLikgcr0nq7CEw9CgK6EvIIg
         avHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777907614; x=1778512414;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BFPFJznAHitID4S0LzKMu7zyMWzcfL9bORgTcAoAlHA=;
        b=hw2iq0VxC6hNYp7yeWVzHgwcpqFb1A4+pZxXzb6R9s9H/pm2PA7Ag1RCxP9J1sPHq2
         5M69S7OBlAbcuVScuLTBEgk/UFYWq+MwhdTpM/aJtlybq38ztsqvwmx2eI1pbYu6mdHp
         VkR+GLPnAYH/3hm1CqSBvifQ8YQ1bM6pUbSZphdZMgaB+pet03XAsvDU6of2WBbCaped
         KPsn4VgV4Vr7LvGq22CmCurrHPimAgs3sfrIKkkTiqUpYoxLIxVa6ccZysoLitAvQaQz
         lsuuoRuemQ8R39ehuwmafxu/NEbiOiDpSpXA+klV3K4IRW0fGzQckcSu4f1f18Pfmby4
         4E5A==
X-Gm-Message-State: AOJu0Yza/RTVEMJxu7R5YFqACeCM98+N7awQHUZZ7fEPQEqWmeLOl3TT
	6cXUvFwgxtxeANXn2Vuu2qG/EJmN/1vHuk6Ddp4vnnpi4PoLNgOfLSPx
X-Gm-Gg: AeBDiev3k/fHNQxQNY4q/1BorpkAe5nUMsXpHUglmhuyfBLZr7Uv7kdFQFFg1rlMehw
	NOU24U5oYcW0y32Z3xCGwocsbGOyABQE1PRG2cmSF9EW8fOabIRwr8u35QV8bTkU7TN4jKlcVtO
	5n5RpQt7/ugPgYMgThWHSSXuii52wHBp54m/zZSpzZyQOdip1KDnt4hHlXNQ2UMwVFq4GVrAUJZ
	FtA9Dh7YfeY6YyABs8R138sqmRFGb92LtcXvQB9srOzIWBxb/gfnVQq+Hn/RNK4zMV15pabrrou
	5HhFzAwiefPZT81IZ2ojQ3yixrcdnbanmQbtQkiZlnThPDAbmHbIKWEkkJr5uUr6BIvIvTgtNKE
	rSBY/bif+6xF+1Zcf3TZyKkuIuVuluwQkZGbJwbPuV0It2UjrlH1q9ekALu7DOHlJ0Zj2NJLGsS
	ilAhO9LdJ7/2eFdiBKYyD/MzmeBEUnanUE4x/eMHF4by2b
X-Received: by 2002:a05:6214:5294:b0:8ac:a92f:cd05 with SMTP id 6a1803df08f44-8b6697d80d2mr166518306d6.48.1777907614463;
        Mon, 04 May 2026 08:13:34 -0700 (PDT)
Received: from ?IPV6:2600:4040:264b:4100::59a? ([2600:4040:264b:4100::59a])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53d0702aasm127835826d6.43.2026.05.04.08.13.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 08:13:34 -0700 (PDT)
Message-ID: <7d5cf952-badb-4071-a0eb-af9443fa8b5b@gmail.com>
Date: Mon, 4 May 2026 11:13:33 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] git-gui: handle missing worktree and separated
 gitdir
To: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org, Shroom Moo <egg_mushroomcow@foxmail.com>
References: <tencent_AEE968E8E785907BA55A383977C8968ED406@qq.com>
 <tencent_8A236D9D4A8D8CCA7DAA083157AA8543700A@qq.com>
 <3b0b37ed-1a5d-4fe1-b2b4-7db67a62a06d@gmail.com>
 <77219c75-7968-413f-a642-0446145c8023@kdbg.org>
 <a1a7237c-ffed-4a7a-ae58-55769aaa4453@gmail.com>
 <93e1c61f-e58b-4a0c-8ece-7a8d945fa900@gmail.com>
 <73b99b54-1d39-45c1-bd06-26ac1008fddb@kdbg.org>
Content-Language: en-US
From: Mark Levedahl <mlevedahl@gmail.com>
In-Reply-To: <73b99b54-1d39-45c1-bd06-26ac1008fddb@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/3/26 4:53 AM, Johannes Sixt wrote:
> I would not call the use of --is-bar-repository instead of
> --is-inside-git-dir an error, just a choice that has been made. In
> particular, when the startup directory is named '.git' and is not marked
> as bare, then its parent directory can very reasonably be taken as its
> worktree. (That's how things worked before --show-toplevel was used.) If
> the check is for --is-inside-git-dir, this treatment would be ruled out
> early.
>
Whether being in a gitdir is ok, or a worktree required, is of fundamental importance and
is not explicitly checked now. This is my issue. (Whether the repo is bare, or embedded in
a worktree, is relevant only when automatically fixing a user error.)
> But perhaps there is a simpler solution: Let's present an error if
> --show-toplevel fails except in the case where the startup directory is
> named '.git' (and is a valid Git repository) and is not bare (then the
> worktree is the parent). I insist in this exception, because this
> use-case was considered important in the past (87cd09f43e56 "git-gui:
> work from the .git dir", 2010-01-23).
>
> -- Hannes
>

This would not fix gitk's blame / browse from a gitdir, and I don't really see a one or
two line fix as being adequate.

git-gui sets GIT_WORK_TREE and GIT_DIR at startup. GIT_DIR passes my simple tests, but
mishandles GIT_WORK_TREE.

I expect these two invocations to be equivalent, both starting git-gui in the worktree
'/some/path':

    GIT_WORK_TREE=/some/path git gui
    git -C /some/path gui

But, the GIT_WORK_TREE approach:
    works as I expect ONLY when the current directory is a valid worktree
    when started from a gitdir, uses that gitdir in conjunction with the requested worktree
    when started from an uncontrolled directory, shows the repository picker.

The git -C approach is indifferent to the current directory, of course.

GIT_WORK_TREE enters much too late in the process, and rather should handled first:
    if GIT_WORK_TREE is in the environment, cd to that first. Throw an error if that
directory is not a valid worktree.

I don't actually understand the use case of defining GIT_DIR or GIT_WORK_TREE to git gui,
and I wonder what other bugs are lurking... maybe the better approach is to just abort if
GIT_DIR or GIT_WORK_TREE are defined?

Mark
