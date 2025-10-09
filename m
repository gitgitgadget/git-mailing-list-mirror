Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB51572625
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 22:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760050509; cv=none; b=g09ACwU9HQcbsuMQwmR4N+AcawuzurwAwAf/5rWZX6B1NErogy3s+zTJN8QlkWam7HSQD3/twCIHWXWO9v3asPvfFQV+dMANDWz2RdKeFFbAJShrHi86tJIhv9eMdmovIQ9fhGlLzbTEsG4XXNXhJB9xOyI0dR3sQhiFPbADfi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760050509; c=relaxed/simple;
	bh=D5J0keMyQFpX5jtfiZnRBWDysTPBq6R+HqPD0H6QBGk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=c2Vgfyk5d3aPP8L0LOE+/Ir4jaLoWr0pOVx46RuWg94qTUr18VtZY3pWFM5Arkv8At+qaPzcwEWoeJMz2E92Yv3TfY1JLVq7EucQZweI8Q37n7Pq++GuPvOXgO2bErNyc2N2cfysj3ZvXp9qSYFzTIa5tbvVQplnVVjuHELeRug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=H/GWjFFa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jbwzF6tl; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="H/GWjFFa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jbwzF6tl"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D712E14001A9;
	Thu,  9 Oct 2025 18:55:04 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Thu, 09 Oct 2025 18:55:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1760050504; x=1760136904; bh=xZPgAWZo6mJwd2Mp6P5FPxzbV7EZNNSC
	M8lAAFvmkEw=; b=H/GWjFFa1AwMTBun79vswt/kieQndbGAvpwKsmDnLYhK9GUC
	rcaQr8l1S0ZZhM9MyCO40l57LH7ms0rwZ9XETcsP3YTtSqy3sv90RGR940we29Mb
	xcKvsWR17ZEiT+s5YPNPj8hRFUNPOi0YY0o9pduCKvV8H0PSmdS35MtYLVQi04sM
	rDnn8xCvNSmc92ko6kfkn6V/HVifGvBs0LiLLkKPCHF+YeLC0z5/nZ5ZVcwSTZ7h
	mtoxH4F0lwzo9fatSAceZmgvLKk3VYauZ8xTqGVOwrG6oQVSbuk9i3mxUPciRZIM
	YOs/y4snf6sykPxqGCnlQKJYxjFsa/ywsgff7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760050504; x=
	1760136904; bh=xZPgAWZo6mJwd2Mp6P5FPxzbV7EZNNSCM8lAAFvmkEw=; b=j
	bwzF6tl0bCTv9RqpPPhePKnd89GKdQgA66LQ+TIUIN+Hy80GjOBiQUR8exSk0vGj
	JW7W8wIV8YJCqoV5OWgsp4Dgz4NokgVg3iCiG+0UkPDohKSify3lmqkKPcSCkHMm
	CQ1soBiNAzspQSHVHuvLCqm0em0zRxMdtt7Y7X6yHQyZgBvrtJJ6FG6bhsyCsX2G
	GfP6aD6Uqy/+Uv1ltCtnHz4jaFpujL5OYSRpC4vLsX7QYBQMZksqV69Oo0a7uLYt
	3VizpW1u8XCt1yvDjYwnL/Gbh845JaDu6kVd2LPWCtyQDGSBOjmPLF/9II+jDpN2
	rd4GjV+TUG/gcMPuJtLYQ==
X-ME-Sender: <xms:Rz3oaOFrcklKs_F5plHW8C_rIytXRmHPU-jOLcW8s5ktz5zg05XN9c8>
    <xme:Rz3oaKLonn_maZUxAPAQQRlFNAdTN3swCT9Pstpg4xOc9FjOM2B6HMdqB1rINXt8O
    SpHwfULO_Uf4hc_e-Or6aj2J7qTX_kCtv810I5bGCSA1e_hg6iW7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdejgeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkhhkrd
    hnrghmvgeqnecuggftrfgrthhtvghrnheptdfgkeetvddtgfdtgeeuieeuleejkeduvdeh
    tddvvdeviedtvdfhieejudevjeeknecuffhomhgrihhnpehgihhthhhusgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvges
    khhhrghughhssggrkhhkrdhnrghmvgdpnhgspghrtghpthhtohepuddupdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdho
    rhhgrdhukhdprhgtphhtthhopegrvhgrrhgrsgesghhmrghilhdrtghomhdprhgtphhtth
    hopegsvghnrdhknhhosghlvgdoghhithhhuhgssehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhlvghntggsiiesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhiuhdruggvnhhtohhnsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepmhhothhishgukeesghhmrghilhdrtghomhdprhgtph
    htthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:SD3oaNrMWGxzso9OQ9ZFukh_yrwQYoyfSPdLr9CJudtW_vqDajZgiA>
    <xmx:SD3oaLjnt8WxPprBEuL9DLz1ofah6OKHcNYGu0xjVB1pAJ4NO44q3g>
    <xmx:SD3oaHMU6Gbz0bKGVCD-PnPW0q4amrfaHb65crOYJI9kkJI_8cUdlg>
    <xmx:SD3oaNxxZaR1lmQ0MwFPqnODtpkpQLn6I1lyyCjtkH70l7Mgg9tS_g>
    <xmx:SD3oaPDhANRzIVFNmVL_hJOntCCtPend1qpm45rFb9-pSCQIYnrHYf7k>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DF8631EA0062; Thu,  9 Oct 2025 18:55:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AiL_X_pxFJps
Date: Fri, 10 Oct 2025 00:54:36 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>, git@vger.kernel.org,
 "Phillip Wood" <phillip.wood123@gmail.com>
Cc: =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>,
 "Junio C Hamano" <gitster@pobox.com>, "Glen Choo" <glencbz@gmail.com>,
 "Karthik Nayak" <karthik.188@gmail.com>, "Denton Liu" <liu.denton@gmail.com>,
 motisd8@gmail.com, "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 "Patrick Steinhardt" <ps@pks.im>
Message-Id: <e77d07d0-c26e-4d91-9777-ebaffffd764c@app.fastmail.com>
In-Reply-To: 
 <d4a277b6b0695d86636562f4c07efae17f9249f9.1759755379.git.ben.knoble+github@gmail.com>
References: <b36d2dbf-7cf4-46cd-81bb-b502e0eed380@gmail.com>
 <d4a277b6b0695d86636562f4c07efae17f9249f9.1759755379.git.ben.knoble+github@gmail.com>
Subject: Re: [PATCH] doc: explain the impact of stash.index on --autostash options
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This follow-up patch makes sense.

=E2=80=A2 It reads like a logical continuation of the previous commit 98=
42c0c749
=E2=80=A2 The log message is clear (and with no spelling mistakes)
=E2=80=A2 The markup is correct (list continuation, links)
=E2=80=A2 `make lint-docs` passes
=E2=80=A2 `./ci/check-whitespace.sh @^` passes

On Mon, Oct 6, 2025, at 14:59, D. Ben Knoble wrote:
> With 9842c0c749 (stash: honor stash.index in apply, pop modes,
> 2025-09-21)

Curiously, since this is also the base commit, referring to =E2=80=9Cthe
previous commit=E2=80=9D would also work if this patch is indeed applied=
 on top
of that one. But maybe that contextual reference is a bad idea?

> merged in a5d4779e6e (Merge branch 'dk/stash-apply-index',
> 2025-09-29),

This is over-specified IMO. Like mentioned this patch could be applied
on top of commit 9842c0c749. Then that merge commit will not be
reachable from this resulting commit.

I also don=E2=80=99t see the point of mentioning when things were merged=
 in in
the commit message.

> we did not advertise the connection between the new config
> option stash.index and the implicit use of git-stash via --autostash
> (which may also be configured). Do so.
>
> Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
> ---
>
> This builds on dk/stash-apply-index from gitster/git and is published =
at
> https://github.com/benknoble/git/tree/stash-apply-index-doc
>
>  Documentation/config/stash.adoc | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/config/stash.adoc b/Documentation/config/st=
ash.adoc
> index e556105a15..fcb9a4a7a0 100644
> --- a/Documentation/config/stash.adoc
> +++ b/Documentation/config/stash.adoc
> @@ -2,6 +2,10 @@ stash.index::
>  	If this is set to true, `git stash apply` and `git stash pop` will
>  	behave as if `--index` was supplied. Defaults to false. See the
>  	descriptions in linkgit:git-stash[1].
> ++
> +This also affects invocations of linkgit:git-stash[1] via `--autostas=
h` from
> +commands like linkgit:git-merge[1], linkgit:git-rebase[1], and
> +linkgit:git-pull[1].

According to these

=E2=80=A2 `git grep -- --autostash`
=E2=80=A2 `git grep merge-options.adoc`

This text exhaustively covers all commands which have this option.

... which might mean that =E2=80=9Clike=E2=80=9D is an unneeded hedge? (=
it=E2=80=99s probably
not intended to be a hedge)

>
>  stash.showIncludeUntracked::
>  	If this is set to true, the `git stash show` command will show
>
> base-commit: 9842c0c7492d2858d64ef81128f7b1f0b38e326b
> --
> 2.48.1
