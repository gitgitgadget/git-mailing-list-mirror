Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793575846;
	b=0uyuGJeoo+s9t9hIeAkvcc2LhOzbEfNC4hXtEp49hzbduFfBn/SbxW8GLahPQojTjUrp
	 knsSBWBSNUflRRCnJexYHkSWyqjrU3lNbRYajC6I+4gQqSxNqWfqlVo+hZiNLtGNNXBRC
	 Shpw4CJLTCQMz8pzUcye97RDvBDCns9m3pb5iKalUOH1DeRrFnCLdpLmYc5VRnCv9OqgL
	 yMvLrhb9xjEagl4ZVB9e+ZCnjkmgbm4zPven97GgyqcvDODc6g+3BTAFuCCnloPYS1yii
	 cBkTF1ataJ/ueE5LxbTZE2RkhQQUZpoiz5T5yF4gh0SZ5xWYSmehaCuflEaK1WSkkCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793575846;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=BG3QLRFeGC4MmSvKE8vVKRpaaGdZsxCLKj8+rJxKPfQ=;
	b=L/IBJOqnKtYZsG5GG6St8kR00r8ZYbZs9Nqv+Be62TUnSql8ebgmMGhqV/ZGYEFQaKvB
	 4slzLt8pr2dBDLDM1CL2+HlsBpfH87SvWx0rOEVV6VIoDKfVcwVfiHsLTWWaW9x4j/kk7
	 UQMxgxKCbwpnDiwnIiCqhDTnYFAO2Ws7evQ0qdYQWVSc2vYPPlCoKMmwkB27Sq0VC4tWO
	 rWJdeamjCewXJqwNdzFiNOCl019fmyQ+aW6FvJuuoPszk8Bzlp5dJb+KB2GYfuXXbBVpE
	 xdPC4apsbp1usjrFPVP6/DHcxox4KXBWRkLvzhzWrMwHqWMAW/zCptjxplq2QtlzHNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=ZKJCkeEX;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="Un/H2i10";
	arc=none smtp.remote-ip=103.168.172.158
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1837606A324
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 23:30:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1837606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=ZKJCkeEX;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Un/H2i10
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D6D45140018F
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 18:30:44 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sun, 01 Nov 2026 18:30:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793575844; x=1793662244; bh=BG3QLRFeGC
	4MmSvKE8vVKRpaaGdZsxCLKj8+rJxKPfQ=; b=ZKJCkeEX4M7Znhe+bCieEjgsj7
	4YXsXwKHhfLKmbModh/KTlmVYi1Kv6NosOEMPE2rdJ5/bNTqLN0ys/U9HFpx8OhH
	Iy8OY/V12ENncWVIt/yMVFZAKwATT24c1CshO5RfBEgA3UyV9GYSNiBugdU3jruU
	0+dmDk/w8krp//GD4oxRkVwW0ml9tC1ZdJ+1z5JTLZDMG10YHFV8tTyjkH9JxJHf
	pH8Z2jhIAZxbGeovSnAqoH8NJEMfd9iec6o1JaGN0DKSRq4mRPIEP32jjr+3LEzK
	uMhwFIL2Ranrh6Xl26rb69EJDxhKKfOa+Kbmj2D+tm2jeTOYdsJ7ALEn9nlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793575844; x=1793662244; bh=BG3QLRFeGC4MmSvKE8vVKRpaaGdZsxCLKj8
	+rJxKPfQ=; b=Un/H2i10/RlS4X+vVDsOKH1D8utlx1PoYBuo6afzt6CTl4qQm8K
	Efeu3X4msSJVyIaktBvLM6/g9OUer8EqcSI+nX2JFGu7LLXk1imM6km5Cj34yNVH
	dtF56zdQDmjCgXejf+kw0DaQMlpxhD7UZyAoozOm0z55yQN1PNMLOHyyF2RHTj5Y
	40qGbX62UxwCMJRDOktsuUIgq2Eya/5GV86n9umYaz7Q+CCS2G1ZpAjsmCLSdGS7
	1w97txrMxG68QihmLtEdxfbNyTM/jbq+F+6hrk+MMHejUuV6D1rorsqwCJklzJT2
	kXyJhbmA8HgXqUpT+jlmFA37wPxEHVmaHZQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793575844; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:ERMai+KVlZhsAW1xQvkvYunIW+qSZ1MiU4n0KRAhEVzMWsj
	6Thyb066fGGWCk7WqwnvM+C02yAcjgA8BHHxyiAJpN+Lwi+t0Uu1EmADdv4visQO
	NKDy22oN2krBrqfIjtEuYzi44dbqyG75QsfyhrapFPCxQ9U4sAEKg6poWaZtZljX
	chv/Pj+kZg8kkNGOCVepxKUB+G1QuxLfZM8kt8/xdC3nCPrdUO/htDtWKruP3jVc
	Cwq1NcJ85NvrX6V6iBr8AoOm/fVk8zozwAx+nWPeqvsqr2HlsN+ulGKRp9Yk+BS8
	1gdpKoQ7zNpN/d7otQHger50laHZxg7x4DS31OQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:Y2CaEqt7ngbwXWNUQe4y+PgoCfeC0Cmpkli+dDFkyeQ=:UHA0OumW0I901IqEX0X/Y9f6PbJLlY0YFdvERGN/pdA=;
X-ME-Sender: <xms:pMvnag--DK9S8L4K3MAdoo6v2JlS5qDsLNiwICP5woanGhY9T9H5Ug>
    <xme:pMvnavlML062hcYANzsTs4Eaj6YGXe0M57m_wzWdDBiw7XpINziTWWFQ9BbyuaJIs
    m9cA_p6NqzjLDB6I5jmylgKOhzXFP-muBT6NgdZ262Qo5gzRJJ3MA>
X-ME-Received: <xmr:pMvnauUO6k8f54rDUzbZIQta9UNmkv33uuGVUdAbZZSV-ns4g_VvdH_aF0xmZnozqZ7evc2OBvsnmSpdCNbbseaFkCsejbVbFpbB>
X-ME-Proxy-Cause: dmFkZTFgEQ7A1dMfb3SQijpeJUdi+Pqs1SvoB/C7ir5OiBN1WbGOxhblhP+39C51YjxbUL
    YYYtUB/QpgUSOhtvJ71w6LMnRJRu++adHPxA62bIxe8rQQ7bW41vz2ScTQKwSbRAcM/yGq
    pHxj6qDX7wxwBh0bo30hexaimiXFgr+UH81Uc/fFlLzWdy7g93S5lzUqZqbyjtBKWSmZuZ
    7eyakr39B75cOL3MFnA2xUN7aERsvBdUOKSdQRBkPwoLfmtrDfRRe9RxK7gGq9AblYZv5o
    K9dl4NYkxF/RCpx1G4A0TPGN6F9TfMckfhX0QX+C2EYLLGyeYhzSrdQJuYZI+h1EaU4jLq
    Gnp4U/zKYAMSaDZy8xrnn5poPJqZPBHEkqR2ymCcqO5JZoqy7DeQxTOBpQD59ERF9bmo6V
    xNo20emLU4yKyBQrMM7sb5J13aRtmwH9TXWUW+gPyOWT+kixzj91IE6lWhsKzdJF70sCsC
    j+tnOPPOvtSsH1a2O95vfEMJa0jg081a3WqOzy+UnSjHwWgwLBJL6cfjhOsOAO51RsK3Rq
    Y3SmXSKdrCH0CXIul4gQRgqNCTsSU7nnAju8QEBJ4OjwB0j8sKxaQ4/5TJiE8tyKk6UKyT
    51eQsTWvF3+wPdiAPPBaJoGxwD3LA2YaZkJQNL0gN49lkp/sohGLPQv4QXrw
X-ME-Proxy: <xmx:pMvnasE_xyaV0fZ5NL-DB34VaiHKQ2zH-Fqcx24XIr7AiZGDXa5gbQ>
    <xmx:pMvnaidIH99bBa-L9DRAQl64fSLW2UK-xCLWbZGP6rQDgd9DHZNxRQ>
    <xmx:pMvnalIcFXWkO36yVERP5rdSnP9Umu2FLRZCbxo09N8lN_cCAHCqaQ>
    <xmx:pMvnavECQF-KeJEgN5rYmf3X2k9sgb2vM6suFjmY9_0OGqb7DVyodQ>
    <xmx:pMvnajV9KXFqod7gW_DsEr0HeeDFQMSPdp0Lbq2xRuFqzAs7wI-o8mmr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Nov 2026 18:30:43 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com,  lucasseikioshiro@gmail.com,  K Jayatheerth
 <jayatheerthkulkarni2005@gmail.com>
Subject: Re: [GSoC Patch v7 0/8] add more path keys to git repo info
In-Reply-To: <20260927114420.59724-1-jayatheerthkulkarni2005@gmail.com>
	(K. Jayatheerth's message of "Sun, 27 Sep 2026 17:14:12 +0530")
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
	<20260927114420.59724-1-jayatheerthkulkarni2005@gmail.com>
Date: Sun, 01 Nov 2026 15:30:42 -0800
Message-ID: <xmqqld7cuo2l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:

> Series adds keys to git repo info.
>
> Keys output paths of repository components:
> * path.toplevel: repository tree.
> * path.superproject-root: superproject tree from submodules.
> * path.hooks: repository hooks.
> * path.index: repository index.
> * path.grafts: repository grafts.
> * path.git-prefix: prefix offset.
> * path.cdup: relative path to top level from subdirectory.
>
> Keys support suffixes for format.
> Commits contain documentation and tests.
>
> fix a superproject bug where it now takes repo parameter
> instead of just depending on cwd.
>
> changes since v6:
> * The superproject bug fix is now a commit of its own.
> * The dead code in index is removed, we simply rely on the helper itself
>   and not write any new conditions.
> * cdup now works even when the worktree is outside the current working directory.

This unfortunately has seen no interest and no review since it was
posted for a full month.

Unless we see some volunteers to give it a final review in a few
weeks, I will discard the topic out of my tree, as 'seen' has been
crowded with topics that have been collecting dust without getting
many reviews.

