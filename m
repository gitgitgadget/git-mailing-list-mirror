Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC0D214A8B
	for <git@vger.kernel.org>; Fri, 19 Dec 2025 08:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766132858; cv=none; b=ecrxZ1SNng1lWcb4lTcfa1WxUyKWHlm59xOao/Lmz1v4b0eH/NT4Mv7g7Xp1zTB9LRD+DDQjkBUaiq+WZdRBoAMWwEEnSXjsTo1LE1Q4oTF57m8I7lFXCqJ/BlnUqk5svfr8F5kVbC+Ly5RaMKQ598UXdw5/wfYN0e2b9FR0MhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766132858; c=relaxed/simple;
	bh=KS5Xkk7bRjkuAacNXK8lW08Al10zu9eDJ+hh96wXxic=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TVKsZncNDr/OALHoiZVo8BowcAGFvHoCneO1gcQMw1q0rUJcU3SU54MXZzD6Q+P8+Pm2q9bGVd7ce16F+KAQNByOcjIL6eaIM9zC2453qDQ0+MKlvE4LR8umNj8thRsul5V1TghMCNtS3DGtNpwAovtdz/9dduV+CnktDeifeg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=A4sChABa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C7FFCvIW; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="A4sChABa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C7FFCvIW"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 784551400081;
	Fri, 19 Dec 2025 03:27:35 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 19 Dec 2025 03:27:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1766132855; x=1766219255; bh=w+I3oS+HYT
	r5a/cn7H+3ybNUinuvEk1SjzSVEr6cUbM=; b=A4sChABaDSVyjrkoSvM8jvQ8ks
	wnRFjiqxyt5A8i4SoI1NYHLLxuF3Iocx23fA4x1oTkHvLy9zywW4Z2SFQszVXZdU
	DL55p3tgJYA1jCCud8ODKScIl60G2hyPep6UrE+c3BtoB/UTTNxosFg/9zcuz2lk
	E/049mmJThwDNB+ZBoR2OyfkAOIdNmwmz0iTxD22GZSKbHx7A7AEs17oiC+Q4ve9
	Zkt5KAZgJpn9lXidwxniy4W0+b/BQUYmLfWHOAMCfasl2wul2UamUi/gdw/IXhz1
	204O4QncOWwDTjWDkeKqvH16R5y2r8mKR9S57Z89rbMyTbE21Cgmk3raRB/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766132855; x=1766219255; bh=w+I3oS+HYTr5a/cn7H+3ybNUinuvEk1SjzS
	VEr6cUbM=; b=C7FFCvIWY0BcP1Ctb+v/bBdQumWtQ5KkZmCHpwYrTFO8xXgA2KW
	3neUkhoaCh/LG50USvEWZvrnObTHqBARYxQGkN8aHkXxaH6knmCS100K7MeRSn2j
	0B1+M0La34HTgd1zZvfpB6wIR2Zt2x9jC+o5q/roBnPk/rfYTvfXxEuFCgT6yc/q
	USd0ZQNb8SfNDFor3C1oCsYLgHseT68PI+ZgIvfatQigDpSh0+ZIpaiTu3uYZu6z
	p5rRnQm1LfLiCjketVDBL/zy3fuRBxcOsfuToV43EMou/lLV5bkgKTNEbNFLKS/m
	i9jWLkrL73GsqO9OxvXmjkePh4frj1b6b3g==
X-ME-Sender: <xms:dwxFaft9Ko_a80OAn4zGsn0fhfrHBq3UmThfAcO5rLk86b1gCPwqQA>
    <xme:dwxFaX4dfaFB5V34AYZ3hjYEWdtiW7lm2Gve_OZb2XGIQUP5vH9wIQyHYpuwtqiI0
    L6ei-lWEczJA6SMfTK_lcxud7tfAF6nAvEvolsKhHyg23xPH4NlhiI>
X-ME-Received: <xmr:dwxFaQLLatMIH2IUPwWqfHVsDyBjivr_J4bdkIOxKsBVYNLyvm_e3RPKFiTvO1WazeqNMdGQU0CI2fk72YQ0Twg_XFbihxJsig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegjeekvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehmrghtthhhvgifhhhughhhvghsleefgeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:dwxFaX6_fsGq0hg3H1DOBfmrKF3Dx4p8oHAe4jT_D3MGTp-W_fstmw>
    <xmx:dwxFaTw4jHnDRtVtZp3Tk-fL4LjRLEDeoVFqpOBzDQCAkpen_Yy4Ag>
    <xmx:dwxFabZaG6WxE1e6a5eKKqesjY9elyRedDJjS0zZsohTnHptEDGOwQ>
    <xmx:dwxFaVQtwMGi8J4eXzwn1VfTL-zZp_zgPFFApVH_3w2i-si1hA4JtQ>
    <xmx:dwxFaT5R6X9gXdtdXSt0QUNylnLMDq_CI6tpBFLs2BEVCr8sHGuWXtGd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Dec 2025 03:27:35 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Matthew Hughes <matthewhughes934@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] maintenance: add config option for config-file
In-Reply-To: <20251218184751.31209-2-matthewhughes934@gmail.com> (Matthew
	Hughes's message of "Thu, 18 Dec 2025 18:48:19 +0000")
References: <20251218184751.31209-1-matthewhughes934@gmail.com>
	<20251218184751.31209-2-matthewhughes934@gmail.com>
Date: Fri, 19 Dec 2025 17:27:33 +0900
Message-ID: <xmqqike2x4ei.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Matthew Hughes <matthewhughes934@gmail.com> writes:

> This is to allow splitting out this configuration from the global config
> file, e.g.:

I cannot guess what "this" refers to in this sentence.

>     # in ~/.config/git/config
>     [include]
>         path = maintenance.config
>     [maintenance]
>         # use a separate files for reads/writes from
>         # 'git maintenance {un,}register'
>         configFile = ~/.config/git/maintenance.config
>
>     # in ~/.config/git/maintenance.config
>     [maintenance]
>         repo = /path/to/some/repo
>         repo = /path/to/another/repo

You are burdening your readers too heavily.  After reading the above
three times and then trying to guess what you are trying to do for
several minutes, what I am guessing is:

 * maintenance.configFile specifies an additional file to which
   maintenance.repo configuration items are written out when "git
   maintenance register/unregister" works.  

 * "git config" is not affected, so "git config set --global
   --append maintenance.repo foo" would still write into the
   per-user configuration file.

 * Also, the general config API does not pay maintenance.configFile
   at all, so setting it does not affect "git config list", for
   example.

 * You'd need an extra "[include] path = maintenance.config" in the
   configuration file because of the previous point.

Am I following you well so far?  Giving an explanation on your
_intent_, along with the sample configuration, would help your
readers, and I would expect something with a similar degree of
detail as above in the log message.

> My motivation for this is that I track my global config in git, so I'd
> like to avoid changes in there that depend on specific repos/workflows
> that I'm working with.

I am not sure if singling out "maintenance" is the right approach to
solve that issue.  If we had a mechanism to have two per-user
configuration file, where one is read-only (as far as Git is
concerned) which is covered/overlayed with a separate read-write
file, not just "maintenance register/unregister" but all other
things that writes into "git config" would use that overlayed file
without touching the base configuration that is read-only.  Wouldn't
that be closer to what you want?

> Signed-off-by: Matthew Hughes <matthewhughes934@gmail.com>
> ---
>  builtin/gc.c           |  8 ++++++++
>  t/t7900-maintenance.sh | 13 +++++++++++++
>  2 files changed, 21 insertions(+)

> diff --git a/builtin/gc.c b/builtin/gc.c
> index 92c6e7b954..257cceecf6 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -2124,6 +2124,10 @@ static int maintenance_register(int argc, const char **argv, const char *prefix,
>  		usage_with_options(builtin_maintenance_register_usage,
>  				   options);
>  
> +	if (config_file == NULL) {
> +		repo_config_get_pathname(the_repository, "maintenance.configFile", &config_file);
> +	}

 * Comparison with 0 or NULL should be spelled "if (!config_file)"
   (meaning, 'is NULL') or "if (config_file)" (meaning, 'not NULL'),
   in this project.

 * This project omits {} around a single statement block.

 * The function call is overly long. wrap to comfortably fit on
   80-column terminal after getting quoted in an e-mail review twice
   or so, which means ~72 columns is the practical width limit.

	repo_config_get_pathname(the_repository,
        			"maintenance.configFile", &config_file);

> +test_expect_success 'register and unregister config from maintenance.configFile' '
> +	test_when_finished git config --global --unset-all maintenance.configFile &&
> +
> +	git config set --global maintenance.configFile ./maintenance.config &&
> +	git maintenance register &&
> +	pwd >>expect &&

Readers would wonder "To what existing contents is this being
appended?  Do we have something that we care?"  If not, do not use
">>" to mislead them.

Would the output of the pwd command match what "maintenance
register" writes into the file even on Windows?  We often see
breakage between $(pwd) and $PWD and I can never get this right
without looking at past discussions.

> +	git config get --file ./maintenance.config maintenance.repo >actual &&
> +	test_cmp expect actual &&

For this particular case, would it be sufficient to ask

    git config get --all --no-includes --file maintenance.config \
	maintenance.repo

    git config get --all --no-includes --file ./git/config \
	maintenance.repo

and see if the former gives output and the latter does not, or
something?

Making sure the maintenance.repo file gets written is good, but for
your purpose, it is equally if not more important that the base
configuration file is not affected, no?

> +	git maintenance unregister &&
> +	test_must_be_empty ./maintenance.config

Ditto.

> +'
> +
>  test_expect_success 'register with no value for maintenance.repo' '
>  	cp .git/config .git/config.orig &&
>  	test_when_finished mv .git/config.orig .git/config &&
