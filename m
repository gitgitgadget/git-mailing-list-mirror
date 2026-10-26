Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793038840;
	b=4IzLNXAaMej6GplNT33grz70K1gOnAsYzGLPrSG7t2J2Q2O9h+UFDteGqPxhWBQidW3e
	 eFn0wbvCE8GrC68WYPdEVW60IFhOCl4LmXI0NjE+OrJUhDJqdxjpaLnXMBEMvVz8g0UYX
	 khrPyqsojiox67L3OBxRI4kLGEHjXbcUPOU3uMqsjQ6NLGh1WD0PzSJJniB81TuTnI0Lt
	 eHB0Ixu3FfE4XF/K3wOOGPiQIADspKtjGkQk9z0GfBhs8tDLoSyIiKfuYivJyPP0Ti0ex
	 5n5q6Jhifk42TBD1wqiQtO6Ao1auwyFdnvVAjPeJe0LLRkV1t4pCKyuzvHEbx4tS2Xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793038840;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=2iFbstAiT6JeLdHzDW6iYmG45yZ1uL8sH8nTI/t/Ux8=;
	b=drvuHNvSiAjMSatJUaq3/jG7k/yusmSPMLjwwCWVkyZLpVYcf6Qk9VkktYJSh0CqfU6q
	 iIi63niMb6mIgEWYUQng32CJOMgxZ6KYBbJRH6a6OcpdgoiwIQy3jjqPij8TO4H+evOqS
	 +0bf3v4UrpKUlnUmzo+E6T78Qy3GXz6Qth1D0s47YaiQDJEks3GAKPGhZhESVaml2yYua
	 SKonMm2MoZ6LSMb0TDb0hw6IkrjniOWya50XC1IVqaF1zXC4619uO4YkeRgRrOMXaTHs6
	 HrhqmS70YzmCrdHh/1mIpE43uMA6EwpreUd36tQv5b0/HTgfae6X0p9EOtvgs0XDMpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=GLFJXz7X;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="HO0p51R/";
	arc=none smtp.remote-ip=103.168.172.152
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6A1606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 18:20:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A6A1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=GLFJXz7X;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=HO0p51R/
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6F8221400A0C
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 14:20:39 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 26 Oct 2026 14:20:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793038839; x=1793125239; bh=2iFbstAiT6
	JeLdHzDW6iYmG45yZ1uL8sH8nTI/t/Ux8=; b=GLFJXz7XPa8qpStjWvMeXADj1P
	cBL5Rj5lwcXmYlEKEaZREnvxKc0BcKmIh/4HWj0LQFNhmKkf6IXnzXS0vUejAcBx
	ZzG4ITI1zy0OrUkBXfw8Xq0f7fJTWusNzpaVHJEbVpoLO8eG6H2e/Tshs33Qmk2H
	bLtC8ONCXoTm9VrXiZKBFUw6gle6hHrBNuEtE0dENv8kVXPfqSilZKSamrEwiRHG
	1toSzM/fhPrbIZDzdGWFPnf+t9pBCcvRfeB3ocqrwbuSk1IKnDRiJ+SDnZZ8DHic
	fxIQQB9kLRUO7KppDkQjCosRazvnfMOuEfL1rBI4R2FSKadmQEiJ3Vnylp8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793038839; x=1793125239; bh=2iFbstAiT6JeLdHzDW6iYmG45yZ1uL8sH8n
	TI/t/Ux8=; b=HO0p51R/RPu1osJ2IiHYsWO/y+Rgh2M2XqcxoenaUTgV27wfQTC
	gAjCpcgrsA5I2cQ7FK8w11XWf4sFqPuQgz4198Yn5Si+3l8PBTc4LdgsqPAYrYFb
	YmSOc44ALzV4X1MolVSz0JowUGJ8uwCm6sCAkw9050X/yQYzn1w7lQL5MU7wKbiJ
	AD6Fma9n2z2wMVKu4emitFtpznDpC8ayPIzSToPu5frfsDhg5NF4LqQl1VeB67KH
	h/p00zU+KL9o6rqnZofqEp1uTmnQ/LOarXfbMBfy6VXe+cdAK3hL9+d9w2UEc4K3
	vg0OKcnTQZ6j6zYl0yHKlWs3rrKFKw93+pw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793038839; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:SohjSOdqG7rjluXzPGQxB1uPZ0fOhTcPSp990fz7mjRE54l
	Cf5AoPKRX/XjaPAfaI85d+Vs3g0kEcj4E+p5BgVOFTylrB7HM4UEHYXBTWkeIsIJ
	ATZBqd8iR5PmPf8pxNCqIU3fUl2KdBnAcEtx2w6dbabsWkSX77tcKpf/9XpyEh13
	JjNiVgyCORqnr2RYCzal7ItQ24eNsoGqFvIkBdUYgtJtG//sNxvKCP3Af3ASdJd/
	zp3sEffHV3gpVBnmTIaoWoOnA4bJ9qu9XOVWnLX1rRgDNQfWsnefwIUSLGn2P1vX
	ybDUg85VQUmc44m5a8s8d/Si0Tak4xAsoCLxmww==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:FJU52f/yCvNd86mTs9fY8Jp0AlHtWfwJftVk3a1AgXg=:efMIdmjsvyToDZsXEtVGCzvBbeeEYVaMPZ1o2m8u+BU=;
X-ME-Sender: <xms:95nfaj3AUnLAyQTu87bXtWbIkaWLWtQ08ya2VmvAWdEEyDqrVFGRsg>
    <xme:95nfapFoXYeb5W09Yced0nsQkFvDGHakx0F3IiYP66J-0RsjO6OR62PoAGlmLVDoT
    SuJd2MvkVOyKXCYqAt4MOMUtUgYk33ua6YBEWAN06sd4WqtCKEYLN4>
X-ME-Received: <xmr:95nfao7ZTSDFhMEO7sDdo1C-LqzmqQDd3kxSjsQQUPcWsueS3UI___uFnh2q9vp_q3pOSwh89gpw3bw2rfSTbQXTnK4znKPXqWK9>
X-ME-Proxy-Cause: dmFkZTF6tqX3bi8slLmhQEZEObSUVdNNCS2rref+BmfLV8noWM3i6A39REouZavNbJou/v
    +xrtLyIJqjc0H7fA7qU/QUiCiZIt1plhNPwQGTyuGZToUtNRW+bSWPcEuU+ViW25hXvvas
    pyhb66qHR1VKRNhlny9ivee2U+MFHgWGAEoa84zuRSMxjTswUJ4b1PIqdpcM+v3+8rPR6o
    4GokRrr9rAGjjjFDJ/+auAGhrS0YFpWV/hxMn2OCYyBYGllyXtMnh+HZxjsdTwXymqeDbm
    96qK2DaNcCEjg8hDVmZJ1fTvoe1RQwRcAPozckkI01TSNMpTbLorUVL1JIra+FeSC+Cmkd
    E0b5+mra7sQnKkhVsRR81O8zNZT1nyh56t+wz1Sq7sI8biz/TsaMG+6EgDuRJZ1Y25GPca
    Nw77XAbvpFCa8XO46ZI855BLjbYE3zV03ahRHbE6yAyhl6L1MNmnMZASJWZyPPZySZrEh1
    259wbL3WXXi5Pv8av1fz2Zsle46uLpgMrA6MlHA/o8jrmM3L611+Lxk543l9x7CdgGLjAr
    yEAK0AVLl9cUD/+p2ajE0gpqiUtKcGZZgU5lGBiPoF/N8jhuioy8cvO3gZju0lOdUy3bUr
    qju4hFsNqzzfDfmetn1sScqtV4ne6EQYFvZSIR4Og3x6QgBYrEO9Xs/74zjw
X-ME-Proxy: <xmx:95nfantDoz4QiasW7Ks9v-g33OtVoKlBuOgvqXf0MFlGUbLjQO598g>
    <xmx:95nfah5zyeb8m56s5oxOdskdnhLwI4NXiGOIEQ-yHSz1R0KSnk8HVw>
    <xmx:95nfaqVFcbMsx2Z-rxQBsXD-INDkDvCeLKrVdnzMe7uwN0TXMBF9XA>
    <xmx:95nfar_40_3sZbc2da91BD1zB9oGztkYnm1-Dwozwd9LB3GT_bZvjA>
    <xmx:95nfakY93YY5rqSF8Lwnqvfq8uwVfmQ42Srq4w6rGA245YSvpzu5LScn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 14:20:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <ttaylorr@openai.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2] ci: pin actions in the main workflow to full commit IDs
In-Reply-To: <67057c2277e38a675ffbe0206bf249c24efdd6b6.1793038091.git.ttaylorr@openai.com>
	(Taylor Blau's message of "Mon, 26 Oct 2026 13:08:30 -0500")
References: <a178dde02a80324d4cb52781d542ee575cbb68a1.1792773333.git.ttaylorr@openai.com>
	<67057c2277e38a675ffbe0206bf249c24efdd6b6.1793038091.git.ttaylorr@openai.com>
Date: Mon, 26 Oct 2026 11:20:37 -0700
Message-ID: <xmqq7bj4qq6i.fsf@gitster.g>
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

Taylor Blau <ttaylorr@openai.com> writes:

> Our main CI workflow refers to actions by version tags. These tags can
> move, changing the action code we run without any change to our
> repository. If an attacker gains access to an action's repository,
> they can move an existing tag to a malicious revision and have our
> workflow pick it up automatically.
>
> Pin these actions to full commit IDs so that moving a tag cannot
> substitute a different action revision. Updating the actions will
> require an explicit change to our workflow, including when picking up
> bug fixes and security fixes within a major version.
>
> Retain the version names in comments to keep the references readable
> and make future updates easier to review.
>
> Signed-off-by: Taylor Blau <ttaylorr@openai.com>
> ---
>  .github/workflows/main.yml | 64 +++++++++++++++++++-------------------
>  1 file changed, 32 insertions(+), 32 deletions(-)

With these changes, the proposal no longer appears to bend the
public version to suit a single employee's environment.  We might
even want to strengthen the reasoning by adding "becoming the
de facto security standard", borrowing from Ben Knoble's comment in
the previous round.

Thanks.  Queued.

