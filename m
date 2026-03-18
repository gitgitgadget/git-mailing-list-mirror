Received: from sonic307-2.consmr.mail.bf2.yahoo.com (sonic307-2.consmr.mail.bf2.yahoo.com [74.6.134.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C3D361DB6
	for <git@vger.kernel.org>; Wed, 18 Mar 2026 20:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.134.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773867299; cv=none; b=UptWxhusI5JXwiFboUdGbMUNeUf0+zxcvZxOSF2oxHoxWzlafsziOtqhTtWP6/2JJ54nqCp2aD1d55b/MNk2ug7KsJZJ+BVm3FGp2BTQD7p120dDVgfx9CaWyumOdCnGARYk+h0a46lMnnRMQ9L/Svz5mSWwsBPtZ7Xape/+3tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773867299; c=relaxed/simple;
	bh=ZnOMChA0xmzOuHV2w/ZLVqg1ujlrXiuVCZtJ/lTQbyc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SiWNwgVdwmYP9okVo0+5QSQHytziwIlgniqdF13tFtEkZ+LE1Pm0dIQUFd05idu7stARzMo3CjaPOCTgszGzCrHtLkI8cHBsl8YWlUH6Gr0IbpU4Pn3bCftyBZvGcEYier8eiUcG/zbnCtiFBtzS8KBBGiV5E3sMB7GeuXzAlZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=eBn19Ai1; arc=none smtp.client-ip=74.6.134.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="eBn19Ai1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773867291; bh=8MwEFo28fZPerHt2S415LPmwL77gS+tvCZScYb+FmL0=; h=From:To:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=eBn19Ai1VzLrJbnsuq5gcotGNXWbOLqU9tbqh1A+p3GipdBx5IVYW/ebN/U4nDzY0z7VZ7KFQowIuvZzKdmlUUvqGMVuE3hO8suUlpMsx9zZkd+8Tr1a3wOrRnhRa0A9wSCCvtI8/6y81pm9/QatNJFxZ17VLAIo/lB2kkTbEEEWjLj6LKPnxyCxsKAryM3z1E0N77kOV/Bnkca6FIB7a3sOjnlqsc/Y3EVbsunvrfnWIY7t9WUvi6VvXiQsok2NJ37/b7sZYNz1rQtWZnRCD0hJz8XSnVaMbNM2g36SNVuCdi6Ya2/L1LvrSGHYPPU6xWhcU/euYB4y1/hlHnN7rg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773867291; bh=5ctV+j0nib8XftrXGKzUQe/2xahqn8m9JGuvZg8q9eJ=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=CRC+4pdSmDkqiV6ZebdVOZBPZvMqUaroTXMaNgYekbsL79+ESMviDZ3y4UHuDvIj4Y0VAvRM4ELclv02Pm4FfxkrTPAQy41gZdCBna1R+/rXQZyg/NO7aex4TxefWlO/ow2XblygP14JgtKzWbd2/d1mJLb3DPZwy6mrv+E/No0Dc75rSxrNgT0146jdNTJlGSsUcU4vIGiZSVqJTebkfKgmUkhmeaQPOpwZImhGaQdsrcPVDKk4rZeBPzQPf/tbA+wJxV4/jdity/BQA3w0dUqGsoWPG4bUYZU8XUxx3KoPS8NHbqfCuqghV1E/RBqyllUo1Kb2R0a0h3LNdyirjg==
X-YMail-OSG: HRBxIuAVM1mWbLqeJuzXV6LsbVQfPbKJcRYtHB3s1G7YczNGXRxLEIQXeSQlXhq
 jCIsGbvCygMKFebUDN7iQF5BuXdAYV.J404wITMdUMWJiNWaf.BzJpWYp_LGburBqnkKlgqAy3dv
 _mGxbropfvNxW3aqP26di_w5G9ua9DToOf1II23bzLjh4NgQURQgVyNhEOzAfSHa.ls6Bh_tvFqS
 QS1ELzFb4Pa_XOli11PsK8PiiAhupGRR4oPdwB6TENnP_S7k5INDVmmFaxGu.GU8k0jsNe3ErIt2
 5_lWTkr9SWuFeCb3UikAuUkHz.qmBCHhA2sJ4oI.DZGOzz1vAC.Mda23DlL_88.TzAKIxAmaiKTZ
 1XuqnJnRebb9j9rEFh9He8vEff5qck1wP4ZmlDV8kDgJP8PvOzXJ9U7AqQFKMMWClUEQX0E76Ejj
 LIp0peLn30kv.k7bAvHLDjW9AYL43Ggd_mPSQcOKSNE3kCSZ4pxG20i8QowCsBmsBUCErF6Ofpl0
 kAk_rIM3c3iUbiZZ81SwcWdGSuod1x6_wjqmWQAgDa4IF1r6C4cHhFwekBJwXOteDf3sW._m6h_I
 LJNNQFYhD9G84gPIdQIzCIyT23Py4Z9li9h9DZefIx4lctS_8A9NBMOOtYTwjUNdAHedCKAPCOZb
 4zzJcnnbmi1pQ8DDZyaPGEalz8W3e91ltXDdn3ND0DgAwjaNpCC9IucQWEsqCQwpM1RalfiJBMkU
 5CoUnTeJ_QX3uM1pxx2opwVtYxNrr6SgqYQy8qK.uAJDidST9Reg6Hb3wCgsSweve_o8B2oTsYhF
 C1tZBWTj4LjrgtU1QiMHW_yuOrRZ1AYrvF5IiM6Zg_GcrETQ.FPFrLEAJ8NHvDQJp.K6HAdEL5WO
 k_Omx9lVKuCz6r4w_Rm_6cJOuSKqupbEQa.4ddtDqNg0iVc2l87Vfb8iKUbR7dQ.u5RHQKv43C8u
 SiDoILoOBXDdU4ld08P509EPF9euUtm8T7A38W_gsANo2VeSi65ZGlMP6qpt1TGzm3F3HfV4R.Rd
 wX0QW.XeoviicUv.Ah1Lb6e1dvvuEETPI.ORhnFHEe3q4gZqNZYW3UKRkmNXp5M7q8boJzYky.Zc
 h6e1u9h543Fm2gzLP73GqmRvQEXlhE6thSfw0_3h_mFkNxVFXYRP6OnneUtfzLmly.uLdcXLacvw
 M4ZL_0x0VPJSS5..Xt6heni9XW2Sxr3WgYwAB5Xvy.H6wOXAni1__KTEtrJdo5IiTcqjG4tZ9V0D
 0TCTe_LyQEC6RepuvWwKGSbKAr.TKuLm1AE2I_oJwNvTle7ScaMTKlLgG2EklIDEooMvnkgbov44
 0NgsjxSaoWGuJcigZbziL7TgD1UhrtlZankkkkuCXx52Ph0SmB3aNVIGOMOL95Fc.giEjR6B91ID
 77sjRtqd0smITQad6QtcZxWYr8UcQR_YprCQL4za8nHeskRo9L2J9F76C5V88l0ErG0AzBCyVGzD
 aNz3PSpJpxLLbWu04WFR6eGgOi_T8kFubEFD2KLxdhQug5LwAdGkOSa95uwxJfUkN2cPrZkmB4.j
 pC_1Bs4MWJYk26_oj3uDjjGdVM6tREDGxzAQrI.pnXNyZ7Sehy08x8ooTqID6o8b0ZCYH5Q60FUx
 Yp58nvtslJVHEScNMbZIMklyCdNAA9Gdrx.Hh_AXiSa3xp8IVw4D5AzNky3l201_HRbz.mbjAXpJ
 FdSa6DaRdkOapmDDL0DmkIv0VqioPtpxWnZTnQQUEEHGsyu57pwu5Q608T02S_ETDsuZZfvd3_NX
 ..JN6SnXVnLxkCLRm9AfdZgAOJyiNjXCbUwiwbZEDDxmFq0.TNE7gfJWM6i1VgH890XjtDgT6kxj
 5PkyAjGAlRhZMj8ZMLgpY1uiOdEAZ275bJhwylTNi91R4axAJasbcfc2M_e6RtGm90UzXkWfcaKq
 vqPPBOcqwAjQ_U65fmi16qDdRORieNiXGpppKgYNZmwP84wWRVjkLxsbJKIiYJ.6Ix9oB.IgVhYa
 7icmzyC_TFBxNEfsg7rcqc4sfF7_nP4eJeZIL.laeXgnp6S8MPTgVt.Niw0IfbDS33NN.coAoybZ
 gMksDDurjtnfXG5WHo0Oz0fWWL9HSmin6MfjdvBnjgIX8N44Ff9.w7R8hFh5_SG4kwdUfZ7TpuH9
 Po78gFuzrLw2uQuerRACOhcgqTYwv4ceaG9SPDdEHGSfIPw5r1nkcysRc7zBoco6P.xxy12k7XgM
 dNdxAlbmVxL4_Sgnw5k4a1jcY_V_m0auBovfBtqLhRbZXELBGLZ6PC8QMYd0_Pvz4bh04dW_2.Ku
 73iV1u3Nsob94EzQ7xg--
X-Sonic-MF: <jerrywang183@yahoo.com>
X-Sonic-ID: 35085b73-da65-44b0-b666-4fd492209902
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.bf2.yahoo.com with HTTP; Wed, 18 Mar 2026 20:54:51 +0000
Received: by hermes--production-bf1-697f88457-dc7n9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0bc89c5dde31dbeba74ecf24be3ada8a;
          Wed, 18 Mar 2026 20:44:39 +0000 (UTC)
From: Jialong Wang <jerrywang183@yahoo.com>
To: git@vger.kernel.org
Subject: Re: [PATCH v6 0/6] repo info: add category/path keys and --path-format
Date: Wed, 18 Mar 2026 16:44:38 -0400
Message-ID: <20260318204438.40075-1-jerrywang183@yahoo.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <pull.2208.v6.git.git.1772428548.gitgitgadget@gmail.com>
References: <pull.2208.v6.git.git.1772428548.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

While reading the current `git repo info` implementation, I noticed that
`layout.bare` is still implemented via `is_bare_repository()` in
`builtin/repo.c`.

At first I thought this might be a small repository-awareness cleanup,
since the `repo info` field callbacks already receive a `struct
repository *`. But after tracing it further, it seems the current
`is_bare_repository()` semantics are not equivalent to simply checking
whether `repo_get_work_tree(repo)` is NULL.

So before trying to patch this, I wanted to confirm the intended
direction:

- Should `repo info`'s `layout.bare` continue to follow the current
  `is_bare_repository()` semantics?
- Or, if `git repo info` is meant to become more explicitly
  repository-aware over time, would it make sense to introduce something
  like a `repo_is_bare(repo)` helper and use that instead?

I am asking mainly to avoid sending a misleading cleanup patch for what
may actually be a semantics question.

Thanks,
Jialong
