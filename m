Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793902739;
	b=0T+zAgi2PjrUVNfwr1Gbj+jtqL7wYg/G1bfo5hgrS4DJQHtkkKh2Yap5G2Ox65dT9o/6
	 jM990KCocYraw80qulp8S5cH5kMrHQIj/p9SiSlXRY/erso2Dhf5ZfULtEcNOSjosGq9N
	 dTlgSEH2i5DRcBSZn89hh+AVdahU5WKpOH1uti+7EisAp6uKMxl/+ymkXaFlC9Xp5m8fS
	 eBerZFcSijS9f2JMXQ6T1PSES0NTJoQRh0SNWRthMU5xSpLcJK+VXhezXvFVmmEFS4mYR
	 ZDWdQ4Jck277qzEXAYJNDCvIpaptx5Jq7u5mG1m9wV13eHKnEtJ2RGWK/ANhCOdlgJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793902739;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=ZpMwwksQXDWXJgL2rz3262tRKXYzSWUu4DSIDTPidGE=;
	b=XrenGTj35Syr/hdXNYoRkxKF44/IrDbKfasIVwPDiKfvX53PaDOPHubyBN1l8IvCYX1V
	 FvEshOnHVHwozERxhbOdF/L6W++BxBHa1Qx0tMDkGESmdiIYe0ARxeGf3tUEqogz5D9UA
	 uf1fqStEOwPVae/dz126dRkGjHV9UBfIRlwl0LwZhjlQXmcj4uKfrG8+ROVQrD5nrWxJH
	 M/xLhe0xUgb5auSsTxUrewybYm9kmUcJkYa4rPOu7yGvzmP7ekOkKXpBHOwTbnJcOyiVj
	 sonTYnbtH2XaVUiS5CIEe4kxDVZHjdebOC0M/5KsZLg9iyBO8pT6KayXEiOcfRw+2Ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Ewdesrti;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=GjAMRDBD;
	arc=none smtp.remote-ip=103.168.172.154
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E2A606A326
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 18:18:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94E2A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Ewdesrti;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=GjAMRDBD
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D81ED14000EE
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 13:18:57 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 05 Nov 2026 13:18:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793902737; x=1793989137; bh=ZpMwwksQXD
	WXJgL2rz3262tRKXYzSWUu4DSIDTPidGE=; b=EwdesrtieDZCD+OHE//VwOFpsB
	4Kf9QU9UO2hAxId0SZVVL1M5iyGEEwRRAx3WqH2LfAeBWjkxREvpuj7+0Jkw0kZR
	2WOp984kckyOS945b7FEzykiNor9MmZo5BY8dSIKqKxwGfEKMSG3PZNArOnlMdos
	IvKWN8K65edR4m9U/Qh9cHJLhEeYLKPmfJgjImo6iELHg2v3joPATUex+uH48mw7
	QwjtXLK3lxyIBI3qIVotuhF0AoJBVHNE7DcvlEWb2n1c52Cq++IQTuHf6KNZtNU/
	d/CUM7msJJaXkDpwSilRP7eYD498m2bH3+bGvFiImx9AO9mIQ17h/iIeYwkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793902737; x=1793989137; bh=ZpMwwksQXDWXJgL2rz3262tRKXYzSWUu4DS
	IDTPidGE=; b=GjAMRDBDp6D7XY12v/oVtzfvh1tC93YauYGVgTSDtPEZIroU4cg
	ff4qvyDhVC/DzTUX7S+pJYPZVF4CEUUuzccWcs9J82U0jNd3ngg/Bgh2c1ULjNLn
	j8K5FLW17gX6re1p+EAzsHywYmuqmz7XVm2SFbL0UaJaQHZtODTXun7JrTdNWTAM
	kNELmvuMhNtOr0QPSfU+E6Ssd25mXAqZipZzLPkVXTs63NJS8HgUTFIVWAGNZp3s
	H5EG2rAWTo/yHleVnsgxm4fNUlw+l5Y6kXEdO6UQ3VJfiC+L9S9mShBk69IKzIkH
	VakEXzmpcSbP/FzTl3RW08eVftgwnO/IupQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793902737; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:hurNFTG51+OKzvgjlg1BpXxI+SvqEavY7xGBjncSq6K6E+g
	3PwSyXqliCULoGskcvd1+APz2XSPHgW5gfACjo3KgAaex3r/PctZp1VgsDn+kta+
	19WyuWBFRAR8txpIJCUmv+dLi7IuiHYTLUYheAX3B7mQziUU3N1fioKBLTqtshs0
	ObVjvbGnQYzWV7QmhfGpPgoMpL5f4c7FLke9k1mstG6l3hSHyF9W/57Nje9TEQ8b
	ehO95S38CuvaNutZZLC6kIE+thjWgiBLHaSIqrvtFM6gf1wo4CnFZVbpQwp3Aiwx
	v0+vh9lB2q3wupLttGAuC/2jioGIn6oAVuiPrmw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:19fvuQFDme3+q19QMC/1f0owyKsLuUyNzHDe/bHQsIw=:Nh8NjYqyL+9wsD5VarhkTzMdg88dJRYPRPAIzK9EE0w=;
X-ME-Sender: <xms:kcjsauDg_xi2pa6woZJUI0SxW89V-18NJmVr4dH_Yquhb1i77GM6eA>
    <xme:kcjsavblqDJSfXcqAaBBEF8M-c03jH-Mkwwsk0KyANLNhhhYRRQkm0a9K7T7Rv_2x
    X9R9gsL9y7wjCh_Ukk5iGs7Tw9-jEQOPaE9pYAOeICkCmIHsHR8OQM>
X-ME-Received: <xmr:kcjsap6AX0b600Hab8Ii9h8VAC53UvMdbRYlsJqmjlrFtu0YYPeXSoVAtRJF1upnIyLRy-iZt5ugMd8jXWw4yrkYdiA6jJhg0fKa>
X-ME-Proxy-Cause: dmFkZTEXdSKi8a4MFiK/RDnRkvdmx3/5mXPE7qIk7sBD0FV8R4B7BixuZhekieUEFd8fhl
    JnIoT5Etp6Fz1u3kSg4bF2SIRjR3bVXqopGpJRT4ojoboduthWpubHXz8GiJEUAsVChb9E
    CwEN+JQ+BcihJKfM74PPXTOQkkdrfreF6ivtHvNYIpj2h5rlbK/jZ4RqK1vuPWaRS8MEjm
    ZPXWZCD+BlgzwmoBNjZDrF7t+B7XLx2TmpHT0mti6HxxkTghwDGWmLMWkx0fCDXBOio8zL
    veAM6c3UZq+VufP+nCbh+GTldp+j4wIzt2Qd6zWGEl3zHm9TxVvCxRx2ECvtR58A5HQ9c8
    9y30OWF0DNp9HWObP+03u39HAU0/Emt7VOHRv2oVikflIOT3mxJKgFA0MD3hJXpQu+G3dk
    EMcGz94MZUGRLNRspstn9K7i6uKyBcGGXTb3woD9RMvVrb6wR3w0qr0tbha3hVVbgcyLLc
    WDmzayBndCYE2igclKywLY/ipKeTN0xIWktZPNIlCf/bGxKc6imqgoFal6hBhpNMc/Omee
    kI8b8CCthUBOzQ7ADobx3qkHt/MGHHR2zw26U90yv0ZRerH8RMSusnG1OhnG+o9QPhJAyp
    1pvahiOtz5qm0LSrDn3q8MdKcqF48r9uvHfdU8BdJGjg/OyK2ZAtqhUmb+Eg
X-ME-Proxy: <xmx:kcjsaobhgN8usj3bmM6XOArzLpetmYU-thcQGB5NIFkXbjsohsbaOQ>
    <xmx:kcjsaggnHEWP8ENwRg33vFvMKp-fz1DUtdmPnAewtGMSQMXKq5GYgw>
    <xmx:kcjsah8oaqeShkzaSY7I9NF06gODwXC8C4HA-HO62K9lWpb91nyVvg>
    <xmx:kcjsajo3DN3oqDreRITclsVX9Rfvp6ElOg5N454Cf2EiZ_3WbE8iGw>
    <xmx:kcjsajonsI46RgGlbgeSpKijfY7gwHhYQ3nz77MH_ZigQKXo7Q6ngTfI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Nov 2026 13:18:57 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Julia
 Evans <julia@jvns.ca>
Subject: Re: [PATCH v2] doc: git-diff: rewrite EXAMPLES section
In-Reply-To: <xmqq33tfxm2k.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	05 Nov 2026 08:46:59 -0800")
References: <pull.2293.git.1793720007182.gitgitgadget@gmail.com>
	<pull.2293.v2.git.1793893217889.gitgitgadget@gmail.com>
	<xmqq33tfxm2k.fsf@gitster.g>
Date: Thu, 05 Nov 2026 10:18:56 -0800
Message-ID: <xmqqse1fuoof.fsf@gitster.g>
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

Junio C Hamano <gitster@pobox.com> writes:

> "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>>      +-git diff [<options>] --cached [--merge-base] [<commit>] [--] [<path>...]
>>      ++git diff [<options>] --staged [--merge-base] [<commit>] [--] [<path>...]
>
> This goes against what you said earlier, which was
>
>> - Mention both `git diff --staged` and `git diff --cached`, because
>>   "staged" is the term the Git user interface uses and several users
>>   said they find it easier to understand. Add an entry for --staged
>>   saying that it's a synonym. Like with `git switch`, and `git checkout`
>>   it's useful to leave the older version for folks who are used to using
>>   `git diff --cached` since we've seen that many people who are used to
>>   using a command don't see any value in changing how they use it.
>
> Perhaps (--cached|--staged) or have two lines (i.e., turn the range
> diff into
>
>>      + git diff [<options>] --cached [--merge-base] [<commit>] [--] [<path>...]
>>      ++git diff [<options>] --staged [--merge-base] [<commit>] [--] [<path>...]
>
> or something).

Clarification.

The point is that there is a difference between giving wider
exposure to "--staged" as an accepted synonym and swapping offical
option with the synonym, let alone deprecating "--cached".

You may have heard from several users that they like the word
"staged", but I am sure there are more than several thousand users
who have been using Git since before the synonym was introduced.

>>      +@@ Documentation/git-diff.adoc: files on disk.
>>      + 	do not give _<commit>_, it defaults to `HEAD`.
>>      + 	If `HEAD` does not exist (e.g. unborn branches) and
>>      + 	_<commit>_ is not given, it shows all staged changes.
>>      +-	`--staged` is a synonym of `--cached`.
>>      ++	`--cached` is a synonym of `--staged`.
>
> And this is the other way around.
>
> Other than that, the rest, including the resurrection of AUTO_MERGE,
> looked OK.
