Received: from sonic312-21.consmr.mail.bf2.yahoo.com (sonic312-21.consmr.mail.bf2.yahoo.com [74.6.128.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161EE3D4101
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 20:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.128.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773953010; cv=none; b=ED6kqtPdMHyKxDNTUFvJVUovPvvxT+gHNBlKgCRZigZSKMNHQSKYPC13mwzimBxFLJ24jk7pxAoiX9Sfzou1UzTAzenH6fzxmKzJmnJp+GcMzA4JZ62C0KLq6s2N3xwK8FbUz3ENgaan88a3Bm6T/MmRsi9bysLdsp0sZHAEpvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773953010; c=relaxed/simple;
	bh=xdWlMdZcWAX2leBqnCL649EB8rnqvWVqB+l/gcKr63s=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=NsbutzZsgx/0PmILMIit4IuItGisYxhEg1Q3Ny6QbdfyWjcZxMxj23f55swZtqpT8s6rCxAzEWuIHGMB/Yq02k8aNO6lVCrCaJ9ZDh9jFM4wncJZdJY83MHB3ZvshPgX4r4bYkwwpyxL8hFKI1b0nfoWSwA/dfRYgZ/qYl27dd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=feunfLb4; arc=none smtp.client-ip=74.6.128.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="feunfLb4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773953000; bh=bWHKO4MplqWKgkXK+ijRJWj8SuvfXKXbPRmxLyPiUWI=; h=Subject:From:In-Reply-To:Date:Cc:References:To:From:Subject:Reply-To; b=feunfLb4hwjchkGEDZEH8v2ABAmDQelI00m+eDdtaJqnt936LkZzbWf/RioPZhl0JCLuArjAKJECF8yAiGq5Y+VQ0DF+Q+udq87gRyLzBKJlNn5tQg2iazIDUZxsEyLOAMd5umY7uGIzgTnpgiqK6nItksmJCUfm7JPifis87ctKTZMlFL9p5WaHzLOp9umzwj+l5VBGQEmDRfV24VmkMa9qsFp02Nbbux1s+SRIn4QzausrceTyX15s5mlzWkiRLn3MXP3Lm2+/9P+H4LDm7DZ85ViJVAeUU/iyaZ3kQNQdQ6WOW9U2bjcActb+nkaWj6GyEFiCOSnfP/lhho8Mmw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773953000; bh=nvYaAi0OTSP6WurBj0bxV8fZB1yMCkSy2rqMdtJaWs/=; h=X-Sonic-MF:Subject:From:Date:To:From:Subject; b=Y1cSNt7w6y4Yk/mFCO5McYyEo7RcMvpMH+wXCdi+JVyycXcsAcDnavxQV6WmVx/xLFkLgfXnIxANQNUY6Gx3USgmYaN9YxwzQ0pJj9JnH2beYkrx8utE7Uxq1j2B7DijLY9ahhMfemrJ535wO+8MR/97WvTbIO9Wwzn+H4DqHExXnc/rP8WtW/Wy0MkrPipQXMaHmWZiVQjYblNML5n0PevuoT2m6ImzTqBMD8Ddq7Sxxe7cM1xqGFcJQOfQ7/g3K+wkFms3+iTI89X2JU2KKuB0s4i/JT+OziS1TrKcY/Ii4tWOsVh1ZCZ+ZdQbteRtDmygr45ONZ5NiRpYkkLI0A==
X-YMail-OSG: bSBY9.YVM1kL7ZCeQ7wRQ4Y1JhwDRlIWh8LksUszAUjeF37fOp8cZfSC8fqLBjV
 F9oNBH2nl0LBq6B13_LuVC6.x0ex1zp_wSTch.os.Twb.wJo.CIpOhC95W8nlGIAC4T82cGHmIqz
 iGSWe5pivgneoXysJILtsOMrDiUpBcf0kscqPHLimuZgCT4pMV1upzGKqITBCtBsz9kjrqKJ58Xo
 sesLtaUi3ql7YBgpi2q5wPRgiPj0vDBRKXWN5AfgL75LVxomSQHMm1Tydf.Igga.7Cc5bw5Wlju1
 PPYfmubC0vx4yuMC9TWHKkYUtevqIIIIN.Lv1WpeIjLILp6Pk1vYpL3Xgy2UEyGwUq.5kAN3ytC6
 XzvuRNuwSMCNMl54U_Pn4r.S4lEcNP6YGRzz_aZbG7JGwvbwGeq8wxA8gzcD3zQqVGv5tP9YgZJu
 uahY0kpyEBHUqOQyMVoXhU0ld9CxGeHAM1Hhu9vwXv0Xdk6QXomXpR7ri528kOmWnQZu.TgQTmhC
 9u9ChAibTZ5AdH4Gsg6SqF0gGNuWnl83GjcsIbwCZc_ZAj3_2jmOKyM9mTxJFJ4BBEWphTupUDUr
 Rv1CajvTwGWbRnFmTQ9RyvAdgXc7jua0QINf.YCWnolIr04mdmi4NbQLC8kV8pEHOdr2TddXw9O6
 lOLA4BGxb9Wa08qQy59Fth35RHbCqIdl.jkHzGkSCQ.p74iGDeCLkoB6_wdHqlbyisFLlirhUj5k
 Bm6vXkS4SPsRLe5IzZMfYlCVNPEDYK65OasCufQUV4B3E32y7Tf75ejrob0zfmxnJ9H89MtSMS5a
 4L_ZqL8H1pZ2QnQbP0dOv_nhUFansol0XGt3cXCAVcOrbxGzhUKyY1NSbq1YvJH6fEjCRGNYDSj.
 ETukEIBQSfpyPyv4jdVtnvnr_n4uxUGqoV59gxjikQUPK1nzKCSgDKIoq10cr_k1oDGh_VzpBsnm
 VlHRiuq87hhXF2AhG4PXiK8VADRa2DFi_YzmdqjlNQ.j3sZEpT1KnZfuIpYeb9C0JBV3yfqonBSc
 xAJcqGU.m2uZ2zSFBC0BTAhcwtirh0D53aOSLDy.k41Mlf6jua4782nKBpUaCicYyRnZwLKB9m7R
 6Cf_7i9k98CwZp7rIkAk2BFshkYQNQ1Q4Rwi4mvFEIq_YOOwYhQOxu1lC.KfSE.4Lll6v9D_9CGZ
 Cjo7bgtRi_7w1tv1wTVWO7t3wZIWQkbXyYHoiloCUUa.eSk4kJWtugeKsyVzDUp1XrHy5ysxoiGK
 lAbtN2T2vYNZ5wvfMkHLikD_XxPiqnQ5qT_aevNQOYO6t0BB38M2U2EZJf5s8x3Dec31tgUo04yb
 KPAEGDTz_DjG.POt0vE.ih8WtCuJh6VASaplhNqA_lypsYDjOfTmcecizFL5B0.1dixNo4US29Yg
 _bHGRMsrvcyvXP5K.XfSx2..w397df8HauST5zZ1J90jLcoeCt0lVs2Zjb7uVxfBJt7GWxr3IDNM
 ziulVb0C2buToTp5oJdu1W2Tl6cV_sI5X12WraQGi3dGKuXM6KbV.bHFOheXJ0xQTyOtEw6ZKGiJ
 pbzH.UmLN358FYuR4P69yzJd7WUnDZroHzSSKUUo2dek5U7RBUm5oyD0xRqHkRIn7JADF4k1nLmd
 FHsND466fWBd0avEKubfbtwqyjO7Q9jKPk8VVNk2TojW6D1MDrpcn.qnnKItsGSQMMTKoqksdNQy
 .7PdZ7QF1EIby61QRZYqBf4SDzdWQuZMzkFrPWBZSGt5HDL6qXMKpcwlMRrxs0dm4eePREV8TpTg
 4oX4A2hn23brVhtVgfVrFeoEIfUl77hVN80vdjwXhG_R7jAQVFdzRV2AhhRMzGoMxXMSSMY86EEW
 8jcuVjou52OeA6pQvgoJuDbK5lFQCCTXhNgPMC117thziesDIzixMxvo4B.SAe2tWehI.znk6uU7
 TMua75DWFlOK0xHLNR8CaR6htXyjPfyoe6VCADH8TqXjLdrDVwimWFrYKcwQYH_D4URCnrDnhaRJ
 6klrKXoKU1zIpXDEFTh3wuLDXm3QKqhOIMYjC4M.vibmDqDExIGSEiKiM6ae9j7WYGDiqLUzcyhH
 jcma7XHWcLaWCYCm1b9HMhulfBeLXWv95dfyB_dCELyb8clFUrItqAx4aqcL6P95R6lDTXGnR5Oq
 hOYTaHg4AuN2bEUTkZg8zTnujBkGk.yZlRuwUIsdMK_NU0o.5Fl4lsG_1ebYUrtCL9teTEsgnn7d
 MY_yZxpjzOXHCYC3L0tAS9eP4vQul_K2r8w3KeEG4XkxTrFpUHwDzGJO.9M1e0BcY.d_er.TK1CP
 U9bPMtIfmePe5acdy2AuR
X-Sonic-MF: <jerrywang183@yahoo.com>
X-Sonic-ID: da87330c-1161-4ed9-80a4-02053ebdd77d
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.bf2.yahoo.com with HTTP; Thu, 19 Mar 2026 20:43:20 +0000
Received: by hermes--production-bf1-697f88457-tt4k6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 51a651fab7d49df0f7ac9b614c2c61b5;
          Thu, 19 Mar 2026 20:33:07 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH v6 0/6] repo info: add category/path keys and
 --path-format
From: Jerry Wang <jerrywang183@yahoo.com>
In-Reply-To: <20260319033641.38458-1-jayatheerthkulkarni2005@gmail.com>
Date: Thu, 19 Mar 2026 16:32:57 -0400
Cc: git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <58874877-D2F4-431E-82FD-722D8A2BC790@yahoo.com>
References: <20260318204438.40075-1-jerrywang183@yahoo.com>
 <20260319033641.38458-1-jayatheerthkulkarni2005@gmail.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
X-Mailer: Apple Mail (2.3864.500.181)

Hi Jay,

Thanks, this is very helpful.

That makes sense. I agree that checking only
repo_get_work_tree(repo) =3D=3D NULL is too weak, and the
"git -C <nonbare>/.git" case is a good example of that.

I'll keep the linked-worktree / separate-git-dir coverage patch
separate. For layout.bare, I'll first add tests to pin down the
intended semantics, then follow up with a small repo-aware fix,
likely with a repo_is_bare() helper if that turns out to be the
right shape.

Thanks,
Jialong

> On Mar 18, 2026, at 23:36, K Jayatheerth =
<jayatheerthkulkarni2005@gmail.com> wrote:
>=20
>> While reading the current `git repo info` implementation, I noticed =
that
>> `layout.bare` is still implemented via `is_bare_repository()` in
>> `builtin/repo.c`.
>>=20
>> At first I thought this might be a small repository-awareness =
cleanup,
>> since the `repo info` field callbacks already receive a `struct
>> repository *`. But after tracing it further, it seems the current
>> `is_bare_repository()` semantics are not equivalent to simply =
checking
>> whether `repo_get_work_tree(repo)` is NULL.
>=20
> Hmph, this was an idea I explored few days ago
> But I do agree the repo->worktree =3D=3D NULL method has multiple =
flaws
>=20
> For example
>=20
> test_expect_success 'layout.bare is false even when run from inside =
.git' '
> 	git init nonbare-dot-git &&
> 	echo "layout.bare=3Dfalse" >expect &&
>=20
> 	git -C nonbare-dot-git/.git repo info layout.bare >actual &&
> 	test_cmp expect actual
> '
>=20
> I cooked up a test like this and it failed
> I have since been exploring config.c and parse.c.
> specifically the if repo_config_get_bool()
>=20
> I think there are few other checks we need to do on top of
> repo->worktree to be completely sure that the given repo is in fact =
bare.
> Also instead of using repo->worktree I think we can use =
repo_get_work_tree(repo)
> Why recreate the logic when we have a getter ;)
>=20
> I am convinced that we need a helper
> repo_is_bare is a good name too.
>=20
> Thanks for exploring this :)
>=20
> Regards,
> - Jayatheerth

