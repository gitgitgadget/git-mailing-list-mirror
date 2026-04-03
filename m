Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2082C3B6C09
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 14:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775226166; cv=none; b=CdZhWZUaH4O+EJuwTM+VQGYJ1r2jXc5y24MnHW0vGLfVe/O0rLMu5KkVlLAJLH95d8vs2IeN6K3WAjRyYK4JDV+ooWXCzJ8a19L8ilhNkNGIz0cY/tBpPvnZTcmjQ0AEUnLtwtGjwq4CAvLfZzLFxVPOXwPsQjm9rCZar6TwaD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775226166; c=relaxed/simple;
	bh=o8PDzTXxuiF1hUXv6mudDSeu7knWwJPJsWNzWPfisis=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MPIuH6AoglMkrYo0BO6guIbVjiE/AarLv8b68oCWiRRJIOLy9jnikJBFw4k+xxJUEwphWoRzHUeFzrycfVagE3WfWYr+dYZV9SZqueuF/O3mep/CUekgNYaE3O08mNDZB365ygdJwjaQ/kqwCLf0MnwVxjsKIBU/hkaQl7c4Y1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=GofV8FGE; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="GofV8FGE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1775226159; x=1775830959;
	i=johannes.schindelin@gmx.de;
	bh=kdRoXAqhCwsObIkAYBdXH08I9JxbPpIFLk2g+lIiYfI=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=GofV8FGEr1yaii/akUGKhaSSxttYmmRQfB8XNz/e9jmZTU3z+Ihu1G5RRhg9eFgJ
	 1NcV3Fn4uEaFBNDx2j0OEalX3006TPMZElOQsXORZQxUtbRgYRtl7578CsgxaztB6
	 75TZSSSsK6U5gfa0/VU0gVw0io5CeOKm/zTQ8zn8eUtvVSCh/HFBqKN59XKeMfiTq
	 0/JFQG6ITXU4WRLRYj3oXGGUmu/ymHBfNR/1R30rJ3+VMe3g0OLQynl1XbBRJOHYe
	 tw63cKq6CSmIWe2ZD3cz7qPCV4J46OR/2qeUIiz903VR7QeOUhXsybsTdq6K35wlE
	 LDmXMzEh+Pl83LQotQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFbRs-1wI3bV0Kj8-00ElzB; Fri, 03
 Apr 2026 16:22:39 +0200
Date: Fri, 3 Apr 2026 16:22:37 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH 11/17] t5509: specify bare repository path explicitly
In-Reply-To: <xmqq341dozxc.fsf@gitster.g>
Message-ID: <f43a7add-6a0c-2368-1b4c-655dfa6361e7@gmx.de>
References: <pull.2076.git.1775140403.gitgitgadget@gmail.com> <f6fc807af627701bf7f9ea413c7714e9bc01aea4.1775140403.git.gitgitgadget@gmail.com> <xmqq341dozxc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:tAbhaabWmV8TeaPy3R0DEh0V0CgvFNP9LtsO5UaS6JdtTews+dR
 Bf9wvd6OwkfF/pz1bi6rcTdOlBARSfsl9lrb4rubAme2gUsYK/03IoTlOAI17WkRp9omCD/
 lCegcOt9I3F0bDk698I0aTPYfxTkcmpwF/8T6E7vHBQ4Z5xqHsZw+FFfvZsOYcFOR17Djdw
 VWzGfnZnfj1+TsjUPq/PQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:F9ZwB0GrUlw=;MAvQHo6kSBKyTFc9x4+dPcMwdkc
 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
 WciRochZgqJJ76EqzYZE3VJxsujtj5Vwul3C7kaNip8msbNsdiloNxQcx2pUk2I3Th/oCslpu
 YP2b5PK2r8ItyZuUsMe/+NHjgWEp05F3mXjQqRwrZxY+VUruvsfj+SaEhTqEm2Zkq8Fm4/9GJ
 01xb3XTGFO8z6nrhJhjqMpNzYExr03+cI63ATh+fVRyyYDgQvXJxsFjliKKgcRT/JGc+mpHhp
 1NU9D4fBhAc18sxKcxdHR63gF/MC1qqv85AeTNodiFgwTn0ORV/xONJAoth4R3I5JtZTxtM87
 zsUHp0tmVHB1JGz5wgDVjqRwEKtqeo5Axo+TguQLwc0rsoAq9jyrrZAjg+J+/qHrE5BAln6vh
 G81Mi10DFsqYSsmCxEAy3meIUZBQ1M1BytY1oYu+W+8DB3x5pyitb+zEimOEySS1nRsFsPWHz
 +pzGFqdoAmOM7JxNJsmpXDiLR3/KvlT6UNkrJwKSIJW/dO7M5oc67Pe7OUoV0JQaj1UpFiVM+
 y8Mz2LcEgbSwhMZNeZ0msmMD7Iw/cvf16VpMGwhhGCkNBegadicKAmQragXWRsL8Me2D32rnL
 qF2yJbO2S1DOuUdk5HjYWuLBjL8UuugN/RV46D602NaBY/9W8I2pFVSY7ZXzi9/aKMYKY40gl
 X5aUdewxinSkkJl2r3tcRgI+1dYIsYfdRhGPEKqyCrtwUJh0xpjVc6n6VAllSNQvW3Y5omWru
 Zc7sdwlIXSpY4IvLFphVYmm8W+DIcWuJziGVc3fYYSPzYC22ZnmdKmrbqzBT4Sg2/Y/1etwTZ
 ppwTj79FBCJ5my+WGW36egFTwbYH1zh63TeLUq7EJPXtWZPtw+A/6/UzV+2pBZGi0OlzzR98R
 TJWJ6ltu4Y4RV4EYyJaSQ5zbHUmULHg6k+TOBt0r5DH0cqHdOcs97rR0gkTl5ghuCV/dR98z4
 ZyoQW9i5iKyzDfaXINVe2oq77uDRykZZOttScZ+ZBOuZwo0xJrHBdKD0MbafIo3iz9Pcl826l
 LwjCL+Dtb+FsoZPQFp0QjJcFx2LHQd7UZMO58s/djERJYoE174smPGEtolI3/BCHWvXmCfgJT
 Own82TNyLwIl2EQphXSU4pAacQvIaQRLHls/Q+2EXMoaGVtmDtZT5I0H8ILIM0Rp+4dTPkeOc
 1C+vvqZgbvJFNppwaGw6/3M7EthBibyh23MnidDtsf6DLQl12RS4qEoQ+X8K2ZaBTd4vJ5e0A
 EI6oeTfFOhbWZEuRWXZvcREOqhRTuhyiyA+F4IS8VUZhD3jef8+biuHsRtKGeLzNcVXvACsgG
 NyBNPRlw2d2e9xU+osR1P7sV+NQBktf76qGNr4a8ldZvyf3OmdOHk7ksZEGoZIVbEt+3VHAH/
 fUxcOCPK4OvUYzMavpj5jzg1XNJlXbgH1Sz/sDxYztVDNLx72+UTIB/ycHWq+5IqJXnGmgw3s
 oyzSN0kx835jZlFrHdi5T1gxasYpBTMgWahsc/dNNOlSogRmY3LPYCELYjGKumBzhVFAqCMJU
 KXHmI5wOhTY9/9ve/mwtogUvomZ0qBjWpdAH6dpirOpipxlONUvgENPpyxDM7y11RAq6L+iLw
 4/occ6QCM6+CXY3AmDScMA6OSjDBQ+11viw9a5EkKBeGSAOeHxgTwRhAevc+g1aftsz0fctFM
 nfYnbYu+VQMpIV1QIhakiYdfMSsM0JaqpKwpQsTD7eM6DgigymNlYNlwyoiOvAiCP/zZ3DO4S
 LDak0o+3t61kSimGYQprF/pcQW/f3w5bvjHMvQlDU6P6UikTIk2FwA21HQLnoYOfE9O90+g6F
 vjr2MhLNvSfe0gDTk5xgDK3FJLf3gsBOknJuqhgTHWN8dwikYcW3SAGuOBYwQQh32bAZq18Uq
 7GIaiVz/5suqu83ZV7dkO1oJAtwh5711GBinpZARuisE9jE66ZFe6WU5zAl4J3BmZtzQ4L5fE
 crCwlpcFrwcOZrZ7usMRn1kae/tECtA0oRfJ18AcFCy6mO9p0vQ1YLvn9/eOxcpekLSk8fcAt
 whgXH//CjvCUcdGSpzf8WYPnHPmqjxzguN6VizXpAeje6Qml3HKbJ2OQX+ubVw4WGI84m6epB
 A2GUJlSNhFmL4ipQIEy0/Rgwsbjw7TiQU6kIClaWT3cK7OPi9JvhoQgssLx0eyASrtQ7lvP5f
 3XiWNTrSt53bUm7HY2+CgJexbcDe3PCPn5xWhbrHcQLTY4LviVnX3ZpH/QvqjGv3EPU5fw0ty
 Fs9aqQ2D44s/iWAOwP4kUx0yZpoixM37qYyG81K1+7x5gQnZq2+8m8rkMP7b5u91p2qWeN2yS
 pA0SfUFT79xxvMBcpqhYvo9u/n1Y4w7k+YpwedduEFAofAQCTOGwNS6Z79QPeOcr+cJD1aPIq
 qUlzo8zvZDN7Io9lBtccMhBqbeMcgrSzvPUTpUDONEcHiIbMwwrS2jwW9jnsc3pNHpccmwSn1
 nPYRUhD6xAvgLI/4zyC1SeUZs+EGpeabUGFDAzywJqKCJTpZb1D+jm4a23WuWNXkn3b4ifmpo
 q9H5oZMx7eJja4WJ+CNGMmT67Igj/gK8346OavUoNVyiOZRIMRmcfMITgbnmTSbC1PA//LUE+
 fW5Igz22tnPWWN7V+8TcBn/ZhTpNmrMIu8pRRKNzLNaw5FJMqfBpZ22zSm5j1c9qVcwo9+aQ+
 977jc/JB6NQTLoCKU+coGZldGEyPsDdy4wKJN7GFWnMg0qlNhjCKo/67f+wi5IBssghWvxuIZ
 F3+II+LMNmwONqeLLHO9Ckc0bBVZCf6R75NsMB9uTY4N9rlzDHrex6DcqpwJI7WUNpPAJSgxJ
 LGqSg6CHZejpbubEz94+ho7PxHlJH8zv0g49DFIxF0mQ9NztV5k+C0lDmPAkAymmn5P1YzAcm
 IFMhDYc/lIZDuXsBMccRV78zTbsIMJuWA==
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Fri, 3 Apr 2026, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>=20
> >  test_expect_success 'hide namespaced refs with transfer.hideRefs' '
> >  	GIT_NAMESPACE=3Dnamespace \
> > -		git -C pushee -c transfer.hideRefs=3Drefs/tags \
> > -		ls-remote "ext::git %s ." >actual &&
> > +		git --git-dir=3Dpushee -c transfer.hideRefs=3Drefs/tags \
> > +		ls-remote "ext::git %s pushee" >actual &&
>=20
> Hmph.  The command being ls-remote (which does not care what state
> your working tree files are), the above may work, but rewriting=20
> "-C there" with "--git-dir=3Dthere" changes the semantics of the
> program, no?  A more conservative rewrite that would preserve what
> the original wanted to test would be to ...
>=20
> 	(
> 		cd pushee &&
> 		git --git-dir=3D. -c ... ls-remote ...
> 	)
>=20
> ... do this instead, I think.

It would be indeed more conservative, and it even results in less changes
when done in a more elegant fashion, by appending `--git-dir=3D.` after th=
e
`-C pushee`, as the patches "t2400: explicitly specify bare repo for `git
worktree add`" and "t2406: use `--git-dir=3D.` for bare repository worktre=
e
repair" already do. That will not only result in vastly less changed lines
(and hence less cognitive load on any reviewer), but also avoid the
proposed subshell. I'll go with `--git-dir=3D.`, then.

Ciao,
Johannes

>=20
> >  	printf "$commit1\trefs/heads/main\n" >expected &&
> >  	test_cmp expected actual
> >  '
> > @@ -97,8 +97,8 @@ test_expect_success 'hide namespaced refs with trans=
fer.hideRefs' '
> >  test_expect_success 'check that transfer.hideRefs does not match unst=
ripped refs' '
> >  	git -C pushee pack-refs --all &&
> >  	GIT_NAMESPACE=3Dnamespace \
> > -		git -C pushee -c transfer.hideRefs=3Drefs/namespaces/namespace/refs=
/tags \
> > -		ls-remote "ext::git %s ." >actual &&
> > +		git --git-dir=3Dpushee -c transfer.hideRefs=3Drefs/namespaces/names=
pace/refs/tags \
> > +		ls-remote "ext::git %s pushee" >actual &&
> >  	printf "$commit1\trefs/heads/main\n" >expected &&
> >  	printf "$commit0\trefs/tags/0\n" >>expected &&
> >  	printf "$commit1\trefs/tags/1\n" >>expected &&
> > @@ -107,8 +107,8 @@ test_expect_success 'check that transfer.hideRefs =
does not match unstripped refs
> > =20
> >  test_expect_success 'hide full refs with transfer.hideRefs' '
> >  	GIT_NAMESPACE=3Dnamespace \
> > -		git -C pushee -c transfer.hideRefs=3D"^refs/namespaces/namespace/re=
fs/tags" \
> > -		ls-remote "ext::git %s ." >actual &&
> > +		git --git-dir=3Dpushee -c transfer.hideRefs=3D"^refs/namespaces/nam=
espace/refs/tags" \
> > +		ls-remote "ext::git %s pushee" >actual &&
> >  	printf "$commit1\trefs/heads/main\n" >expected &&
> >  	test_cmp expected actual
> >  '
>=20
>=20
