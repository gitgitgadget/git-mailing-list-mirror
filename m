Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF3C20CCDB
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 20:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742330412; cv=none; b=VqTwu/AlA5vUWjztYDxg2peNoWl8BVNtER2VogQf140XVb7v5nzoOaAAPgweOE5y3RV5/0Q0Vyxf2NgDyCh+86McG8z4b+FpBnpIX0Wjde5xuitytTAH1lZ/RrlNktETvSfAF9kTRJhSznOwTGGZpr8/aY1b1KgtzCpKInNGNjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742330412; c=relaxed/simple;
	bh=6gimmcIujpuctTo9nXTc/2aSj/IFmUzwJxSmkH+FaHg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tfiS91baLMnRNqfm5VS/Fo4Hw2rlRBxgBqUOsMJSSJtcX4PrOd5NVlnZoUjKBzoofUwhpHKs4/P93MANY2gDg/TizWBJId0vBs7R6myE5HI84tvOswzMfi+pUK87YADFX38EER0mpN25wcgmIUr2sSE1zz7R2YRJxpbLzKwl/gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PVM8AjkJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vVYFcJmB; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PVM8AjkJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vVYFcJmB"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id C71EB13833BF;
	Tue, 18 Mar 2025 16:40:09 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 18 Mar 2025 16:40:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1742330409; x=1742416809; bh=Sly5vUWg3E
	SHj6GCjj7yW+NlcajkB82G9t0HscWy+fw=; b=PVM8AjkJjiJLSIWIGDMFGXqDCV
	KV2I99whYoz+JkZcUyY51W2XF/P2u1bohoqmkYmGW6/z1W6IAj0H9I9+Vguczu5b
	sGIl9+s9IUdBP4w0KJA7NJibw9uCZldLq9dJPOtPbhMTgeZnaB0/Gn6uLx+hNHu6
	mAMuv8vRlgNVZNBtipfVXBXhDm0UAF0IaVUX9E20B5w65LnT1CztU9n6C/aNkgZx
	pEiOJZEmQau6/7U45CpdA+0MiEOz8f4z0A01mf+tLk9fvG6Me4CCYU18lMC+Jm58
	UjmuF+v1WPdOsASMWsxBuGbpQd4BoTaiypkaNdoLxZ0fIm0jURK0rvBzarQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742330409; x=1742416809; bh=Sly5vUWg3ESHj6GCjj7yW+NlcajkB82G9t0
	HscWy+fw=; b=vVYFcJmBOHEEUKl8BqcQ8TZhe78FEdFSwppKjyxCva4iMxSZQEL
	bDTNQ2RSNoVnntRfcZ5cin9P2EayPMyOimiVbrcRsC9MLKzE6vuJx+RD37LAgQGY
	Q9QOKEkQ8jHopoKRrjJ5Jw90vx9j9OZoKzOC4tHkDyYDJEK/4DoYEHMYegbVANra
	rdIzsmHIc6E4kWAgTcqoKrnD/L1nNATMRu5GP1HqEImfgprpjbUAwELjCMu/DyJ0
	J76SviPcYtX/FBLdfC8ZQEEzq8jLGEYjS10k3dn+EzRjyfnBHs7IKQHmxYEgFuHC
	dyFoAQ6OnZBNzfeetTEzBrlDdLHqarQ5TjQ==
X-ME-Sender: <xms:KdrZZ5Ea7LGt3l4wxikLPSyTLkL8Bh8EPCIaLvImrH1kzQ_Gdr3tXQ>
    <xme:KdrZZ-WxB2UtboGK22sdB3r8I60Rx80R6S519OyMn5mmf8ILRP71hdcMB5K1EbEcj
    N6BtKf-ML9FmQ9GjA>
X-ME-Received: <xmr:KdrZZ7LUlnq--IBrkAKlHiyJF90jNOGryenfgXInHrt7BvUktO2MSweeqY-mpJRsQ0hFxlu6Z31RY1rJGVtI_2zvBheyp_nWizptobw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeefgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepffeiteeujeevfeehuddvjeduffeijeeg
    fefhtddvkeefjeejhedtgeefgfeijedtnecuffhomhgrihhnpehgihhthhhusgdrtghomh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpsh
    esphhkshdrihhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:KdrZZ_HnS2orUzGXYI-d4fUMZmZjPggQym0L3ROqez5lO2l9YKsMIA>
    <xmx:KdrZZ_ULJIEgBqmWJA7H2WP5eV4z2WO8nTV5nkv9Z7jiI-9gRA2Qdw>
    <xmx:KdrZZ6PR2VtfN6Hkk9NJ9sAwHDhG49K29xKkwF9GChZVfaO7ZnluBw>
    <xmx:KdrZZ-1F-NwtwlDFhcXW0MEahpnO5vwsKRGg5t5A3J-sKECWaZe1ag>
    <xmx:KdrZZ1emSnMQdHr4c8nDC1qSCXo3nZoz5CUyVdNeuSxHTyzOscdweYvx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Mar 2025 16:40:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH] install meson for Documentation job
In-Reply-To: <CAOLa=ZRODjYfDXQ8m+hDosV7RBGDWeehzSvsR-+-HCmbS+tAcQ@mail.gmail.com>
	(Karthik Nayak's message of "Tue, 18 Mar 2025 16:19:31 +0000")
References: <xmqqv7sbfra0.fsf@gitster.g>
	<20250314184130.GA578421@coredump.intra.peff.net>
	<xmqqy0x7cg9h.fsf@gitster.g> <xmqqmsdi49h8.fsf_-_@gitster.g>
	<CAOLa=ZRODjYfDXQ8m+hDosV7RBGDWeehzSvsR-+-HCmbS+tAcQ@mail.gmail.com>
Date: Tue, 18 Mar 2025 13:40:07 -0700
Message-ID: <xmqqiko613a0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> Weird. From the looks of
> https://github.com/git/git/actions/runs/13867157977/job/38808418127, it
> seems like the '$distro' variable in 'ci/install-dependencies.sh' is not
> being correctly initialized. We can see this in the logs of the CI:
>
>   CI setup via install-dependencies.sh
>     + set -e
>     + export TERM=dumb
>     + export MAKEFLAGS=
>     + test true = true
>     + CI_TYPE=github-actions
>     + CI_BRANCH=refs/heads/seen
>     + CI_COMMIT=d5389e37e21d864f40f4167280db799ffe8983c2
>     + echo Linux
>     + tr A-Z a-z
>     + CI_OS_NAME=linux
>     + test macos != linux
>     + CI_REPO_SLUG=git/git
>     + CI_JOB_ID=13867157977
>     + CC=gcc
>     + DONT_SKIP_TAGS=t
>     + cache_dir=/home/runner/none
>     + GIT_TEST_OPTS=--github-workflow-markup
>     + JOBS=10
>     + echo
>     + tr : -
>     + distro=
>     ...

Nice digging.

> So in 'ci/lib.sh' we set `distro=$(echo "$CI_JOB_IMAGE" | tr : -)`. So
> this means the distro is based on '$CI_JOB_IMAGE' env variable.
>
> From '.github/workflows/main.yml' we can see that this is not set for
> the 'Documentation' job. I'm not sure why this the way it is though. I
> didn't look into the history.
