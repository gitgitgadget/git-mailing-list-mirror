Received: from sonic309-14.consmr.mail.bf2.yahoo.com (sonic309-14.consmr.mail.bf2.yahoo.com [74.6.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA5635F60C
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 21:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773696375; cv=none; b=jpm5PodX+eqbuYjFeU2rzmnV80C+LzF5AHei7q+9wT0tmdE/94VZFVBvCAXlZUg7XqYqn4rZ8WUchlXedZUKFrcwekcC3Dnic+3JjEjtMz4RwQZQcMEqFAxpSDBHCFPvWBcWckcBCXcj3VPaw8aDuLHJOvAuH3cg7E8eSEfqOZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773696375; c=relaxed/simple;
	bh=uMua8iFkyTjvsDFg50lcbGFgktE9VvsWwPstLyInddY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Message-ID:
	 Content-Type:MIME-Version; b=juBO2X9pTeN0uY1MvzCAdJoB1kOVBU3g5VUMoFJsdnm+RdC7nQ/RV9LO3okzIdjFC5/kwVSDEe8fhm61Dc0Xd03Pk4kmSTYsH0nWpReKfv9M2yPCumDNQqhXjsC92ZUGnvzB0ShSsWMoAnpNfCYlkEqsV8J0RnLsu3aS+KryUgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=aEl2w/FX; arc=none smtp.client-ip=74.6.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="aEl2w/FX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773696373; bh=uMua8iFkyTjvsDFg50lcbGFgktE9VvsWwPstLyInddY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=aEl2w/FXRLzHJ65fHtuujgw+5BeTAtwySx9IXBefUVlG8PHWos4XeVAtGwlSDedkIBtOfNjsg3SR7/mxXeQf83qdoNZqJM+7eH0D+OuTtnvHnspEOzwzQagZTlQVMsjeKmO9CrHB3V1klADPtVJXcMTRo3x2EOvaVhGYKqqI6AhWQvaru0dwNYQqfarUv2DMdBNtvp7x31OrJldJgoIS8ZvWncO8GeSEMk9Qy2qC8gCaO+Lsnfa+GYHb5aiGJQyVkyAh0KaIYJarGlctTXKg6UrWP2PWMf2qpGlrJxFlbsc1QwBlS6vonMEqxyhSe7lQfoM+sQSUczP5ZVizhaFP2w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773696373; bh=733rICT3D5jWOeT1TuFMDHw2JE/Qbqmuid8Ir8ce0ih=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=hvLAJVH1E+y5NS4gkb8GRDk+D9YOA/4dHaV+RZiOGKi+tahyb5bH5WoHWCoyjJJfyvRO/M4f27DeJ5ToloubEqabdSB+YniCvk6/js2DxHfEmVIrLWVqLNQ8MX/o1tocuZlx6bllXWE1Mk/hlEJkPtO/CSdUTYQiytI11azwnHLbI39M8IvuNlA/tkdXfCUQV0I9IZz+SUqqRpZlpzeRu7HdHgRC/hj/ng8x64md9212YdiPxONzJp0T48Me8kR3QWvXAVBnlHq5Zt9rPfzB59TR6LHee+GCq2YMBjWsviL1JuRXxf8fBDcq2k2IhTY7QVFeZudUseKSHlyw7J2F6w==
X-YMail-OSG: MogVkysVM1ko2BAyXvh0BLyKdMT6XiS5pvnWIUPMuVuwzml_o8sVzbKE0k96DYL
 XdxCKWoa0xWh7jdIkBB17Dg_UNCrBPINcvSPzd51hABJL80jcnahJOvgDFSCoNJz2NTuAUjxopdz
 zI95Ao2tbUdQFeK..4Zj0CBm6j1f7qKS4r.fOq44dte.9.6IMiUDy4sXJn9Up770C4sarNnkSL3A
 t.4CxWhOjkEcsu3Zk.lULqwMSYF1EIggKdeMzlGSt9Lo_MrEn3ozJU.Vq02diWUsooZJihg5kHXc
 9R4L9N.yUdyt8blXIH0zMJR0cdZ7W78GHUMFTVrsWNRldxpRySjZC6ZbF1DU9zK.X4Gb6eVnHfzZ
 xIhtTIHOT8yHWzlqfBDkvBolSpdoWU4Vq_wpk_yZ.LNA7l9GtBilK4CfcDhXNVvbRW0LZUx3zI8.
 kEPM3pKjJ8PU43mvidaPc4DODaBOzXNq77fOYUph_D8o_zsT47AgQQNnVmgXC0ZHYMuEjWZnTPSc
 MT9xlsLIlRw4xTP88KduNu0tdh4pB0e6PZqhENNXdYf7WyJeMwOmQdVztkCy.A4PrqZGgizMQgHM
 NADhNiz.xKgp4yNdsALJ2mlr0sP1xUmsqu_bKSu2BMPfoeCZB__djENzMG_yH2QN54d8GQM1Vs25
 DIkuyKDkzAWKopwR2q2cG5OIFA2dcvxidlJRx99fDxyN9BzgaB1TnaqEt71I9PF2TONHX3l4kdd3
 YAz.tX7EsxrYqIJcR.FQZwwLzbO1H7SJUcT_k5S.zXpaeGT0ZRpE2IvGiSC9o0srxk7.nBrxZ2bU
 P0qKIL3_grPeG2DioxPIyK61WypPfyXsn5ZjxdcHgJsZhXoIbd5QhGdPUTHvI23IvPwdqdEjd5yr
 zXVKlV9rxhQ9I7wYrkk7tuHpAin2MZAwYHaPd2Zw9p6HtPw9Tx88bNnwmxtKT5NIjkgELV.A7A4l
 D0CZq_75Qe3ISaxkLLXvAx11wzyFkGvBPZWZNTEcdi9uGaQ5etnyo22.tS1x3G9G2PDijonmGTVd
 uXeLCfxwwPyZf1so0OfeadZHJse2JvbTDpwu9LBKRV9GtxHS3dEnQhswjeq7DuUExkdo9B2QJBgi
 RrWjd7J191zaVmvVSu8585QXbqRXCi.awAQ0glGQp7O.9fIOMkQqigoheArPxvPGLmHZfwIOsT1x
 ZBTbvv4VZSubRx.HCGwD6sowu8gU_Q_35jQSaKFM5M5QGaCvi7vVhml2QyWMlcrw5FXBuci75awo
 ExztNCG7e0i2FIN7D7wVwmYgmHx1joy1yoavZZYy3x3fvlHMtNFFkRQ3KFu_u14eVXnOtvUT2me_
 KRLDPp1A8SZCRsIBXDw1R6P1KXWDQhi_QwsVSSVSuZoZpwD8iWgob7IQPoaky.Vp9JW9TuqB0Ndz
 XLOlxHlTp3_y7HOhaVCzw1uqdGU713GKpuKwh5lnvtSm.Ia_oZzFq.62oJVfHsMM5Ma8Rbc0ezN9
 Dpk7_yAW.8ZIsM7MTDb70X7whDdCUcjr3uim6GHv5RCjO11AL1gERNiC8xv3Xbnh6DyyNKEilj_z
 bK1p6E2DUqVAfoeIHco0R6Kr7KKKTtff4XCib92INref9N6jw4CHKBkCZtHwPE7psuvMpkv2fAjO
 uaUnTwr2Fn.T5qG5rXoBL01NSQdURVItIpTPVzWLETpXgTwKXuUBaV8twep0K4Bw81KdIftFOtys
 h6n1ZnfQIZSuSEuLItUxYMsP.um8YrSwsB0yxz1hhk8WBHsOpbS654sZeXmpnKaHTvC3CcQPQPzV
 Ozw0WT8sA4.LZUZIfInpvoByze1Z.wsx7m93p6VB9hoALHNhON_AUE2sUdKi2ULOjfxA.6lzvzsV
 AKZUzeuAZQ4f138MYB9Yp9J9O1YY0PzeLfyLVIWd9rQpfYhuGXxlQ.fkt0696xvP02o5olqXFfzE
 YJAockt8vypa7pKPRRPbkq213KoNotbNSmFuHB1M7vyVYLV8rWJ2eV7Lvtna8_91Wf_iFBRoqZ8S
 SHKK.91vlKVtCIjIEqxUfAETZLtLzUvqX8QFANpPhMQKZ5Vlq6H.4aZv3FxsOjQ6synOaiLHKo22
 eBU.7h1.m2aR9gKsWIggfMVRNBnzwi85lFbqQ0GQPtgSNdYaoFT_2vEgeqs9uETZ84wFVZ67QPqP
 ERtHcTaLHI3gHnO2it23NPnb2ydKFlMbxQieqYlBF63u6rkn2MDvT995.i6QoAVQBbHMSnGc8YnZ
 vHAISOcEfkBC14MfGBDPo04UK1qLXVT8TnbT7XTI_KJ3XKzUYMHIAkyMUlByc1vCCQGe98JslFuE
 e8vj4PxhbkgwUFPsfc36f_k9NsfKg9PWrZ7XoAloXqV6TF_gEISnXQHaqTHKg3jYt2HfCVNTzzIi
 a40ry1IavUMZfyvDaV5xUjK_xGpy3mQ--
X-Sonic-MF: <jerrywang183@yahoo.com>
X-Sonic-ID: 3599e753-90a1-41c5-9227-2a60d609cfc9
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.bf2.yahoo.com with HTTP; Mon, 16 Mar 2026 21:26:13 +0000
Received: by hermes--production-bf1-697f88457-j2qvt (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID dd857beec0bbdfceae4d14d9fcd3f2d0;
          Mon, 16 Mar 2026 21:05:55 +0000 (UTC)
From: Jialong Wang <jerrywang183@yahoo.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com
Subject: Re: [GSoC] Proposal draft: Improve the new git repo command
Date: Mon, 16 Mar 2026 17:05:54 -0400
In-Reply-To: <9fc1d23fbc7d46349ac01314fbfc06eb.gsoc-proposal-draft-jerrywang183@yahoo.com>
References: <9fc1d23fbc7d46349ac01314fbfc06eb.gsoc-proposal-draft-jerrywang183@yahoo.com>
Message-ID: <177369515432.95597.4924615522630208830.git-proposal-thanks@yahoo.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: WebService/1.1.25297 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Thanks for the feedback.

This is very helpful. I will revise the proposal to make the current
direction, the relationship to my microproject work, and the timeline
more concrete.

Thanks,
Jialong
