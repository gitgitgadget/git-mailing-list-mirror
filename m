Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D753090FE
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 07:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767684363; cv=none; b=uMvYS/u+Ug2PeL+aZHaxfxJ9/lC9QBVnUsxgxk8O9NbdvweLrAYFxKl1pOeuGhsNDEqkokHE7y6tY/bPb9jE0EMB/nIWgEbQLqjkvhJScA1gAEDyWlWTJqQ6b0pvxPa6qRMCrEfY23l77J7COysez8rdcHEld/cLP0fa+fht5/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767684363; c=relaxed/simple;
	bh=CltjbWPCK9TUFnK4VXcO6L7NZfiwkgkhThpkCG7JX/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jTTEpiH4Lvx1BGH+Rf5Pf0OPX+UMtrnZDcIQoknTmOlpFVmBBfgbpejyIF4kk6zK7bzcV+2lyHLi6vSsPTP1ssLxCPEEgj6zn8aKteSWZz9FU888UDXznySEc3TYMyHYR5xt8+snvbLN1424kMUerJJWGmqmvkH301mZM97Ia+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AjUlKD4u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F7vxZSho; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AjUlKD4u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F7vxZSho"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4EE287A00F7;
	Tue,  6 Jan 2026 02:26:00 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 06 Jan 2026 02:26:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1767684360; x=1767770760; bh=CUMpxclplL
	SIfj2/o8uGzIHqfQcdZMkmcz+9ji+j6A8=; b=AjUlKD4uDu4tfmzG5PNS47zrBO
	V4BxflMCCI7CSWzRG8uBiOYuhj6TLjrQOLZ7V4icjk0rasS06QGzu9CRUigKDuj2
	AqI05ylAjQUtxY5jpd8XsKFzPIbW/fZCyztb25O2/WMBl/bn7ghDM05s4QJWXjJ1
	CyPnartYX9/tgx/y5BydF0obbeFIf5n4yJYWWHKtuN74HYwAwTPXsnZN6kCDggsI
	BU3IVk3ja4fh1uHX1ipSdPBfY4gKYfpenFdDqynpI47/qzm4aG71E/l6RHB17x1v
	kfWJBFn4modF40ayCrjsOkXQujG3EyRAob2fRvN92nsKorBiDn5hHpvXYfzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767684360; x=1767770760; bh=CUMpxclplLSIfj2/o8uGzIHqfQcdZMkmcz+
	9ji+j6A8=; b=F7vxZSho3Yd3jR+8GiEB8Yv9p7tkUKnTo5HS6d1PduIsQ7H/AcV
	OGAwQ5CaRNPYEYJF2Lh6P2LRCUHy+jFWoncioIzlwzdlh6VmVSLpzSE/s+KaGHNE
	laFQFwaGNrp2Cox05Hly3IK2f+LTMVn5/5H65Xh3n6XUra0jnsaloZynneqgUfiq
	178sSJL4o2DwlilqYBZH06FcydaUZpEiEJSGlm24Efpzci+ZUzjCbV1vNgeI1sYQ
	aV3ZB1eVurDzDR7rvTUFskP9rBS/Re7et4+3TSbSMZp/ISqGUugCbgli5Hg1z5VP
	GcfsSszQ3qKdLEBAsJuB3ZE4k/e0Wd9lE5w==
X-ME-Sender: <xms:CLlcadxNQ3Owp15xu4VOLe_gPJBtp4YWlvZA3hraPm5v0jV9Eyhm3A>
    <xme:CLlcaVff3dzy4INcCxb9Aa8JyM2A1lpCdPHUmkfDUq30_X0p-D0H7RDfUqv8RGen_
    aUOfySjv6KKUfzj3OIzU3pFV5UAb8Ox57M67R04NrUTxbqu8CGi>
X-ME-Received: <xmr:CLlcaS4Ez0DRLalaJ4f7HjzAoKkXj_zpQsO4gFDpup6EDftHzGlrzpQPORlNYOxDdj1ZyAlangJ9gj8nmhi7qcnnLn4AAzoAAjLB533d>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdelleehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheprggrrhhonhesshgthhhrrggsrdgtohhmpdhrtghpthhtohepshhtvggrughmohhnse
    hgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpth
    htoheprhgurghmrgiiihhosehgohhoghhlvgdrtghomhdprhgtphhtthhopehphhhilhhl
    ihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvghmihhlhihshh
    grfhhfvghrsehgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhrtghpthhtoheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorh
    grrdgtohhm
X-ME-Proxy: <xmx:CLlcaaKhxravmx3tcB0lHvvfWbj3yYLLUYFfNy6m_o3OdtnqSzkuoQ>
    <xmx:CLlcaayhcLxg5OVFk9BQpNpnU1fGaR5XAziAg6OQBgznm-flBb5Esw>
    <xmx:CLlcaSIxqpbm8S28_Dj2mYP2dbRafDoHDNvrlnLdUfnw0vomonkWXw>
    <xmx:CLlcaZWSvqWrekawxuZx3idRGTf-fQY9tXEGzMQvfRGexpuJVQS-2g>
    <xmx:CLlcaVgekWMtclvfywfvMeIWQZqGLSH4kdbWSvGilxRGwLQfRhVmsj0b>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jan 2026 02:25:58 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1521de67 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Jan 2026 07:25:57 +0000 (UTC)
Date: Tue, 6 Jan 2026 08:25:54 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Aaron Schrab <aaron@schrab.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v7 06/11] submodule--helper: add gitdir migration command
Message-ID: <aVy5Ap7wX4aW-UL4@pks.im>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251220101528.1227487-1-adrian.ratiu@collabora.com>
 <20251220101528.1227487-7-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251220101528.1227487-7-adrian.ratiu@collabora.com>

On Sat, Dec 20, 2025 at 12:15:23PM +0200, Adrian Ratiu wrote:
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index f8cae345a5..5a6436f18f 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -1266,6 +1266,63 @@ static int module_gitdir(int argc, const char **argv, const char *prefix UNUSED,
>  	return 0;
>  }
>  
> +static int module_migrate(int argc UNUSED, const char **argv UNUSED,
> +			  const char *prefix UNUSED, struct repository *repo)
> +{
> +	struct strbuf module_dir = STRBUF_INIT;
> +	DIR *dir;
> +	struct dirent *de;
> +
> +	repo_git_path_append(repo, &module_dir, "modules/");
> +
> +	dir = opendir(module_dir.buf);
> +	if (!dir)
> +		die(_("could not open '%s'"), module_dir.buf);
> +
> +	while ((de = readdir(dir))) {
> +		struct strbuf gitdir_path = STRBUF_INIT;
> +		char *key;
> +		const char *value;
> +
> +		if (is_dot_or_dotdot(de->d_name))
> +			continue;
> +
> +		strbuf_addf(&gitdir_path, "%s/%s", module_dir.buf, de->d_name);
> +		if (!is_git_directory(gitdir_path.buf)) {
> +			strbuf_release(&gitdir_path);
> +			continue;
> +		}
> +		strbuf_release(&gitdir_path);
> +
> +		key = xstrfmt("submodule.%s.gitdir", de->d_name);
> +		if (!repo_config_get_string_tmp(repo, key, &value)) {
> +			/* Already has a gitdir config, nothing to do. */
> +			free(key);
> +			continue;
> +		}
> +		free(key);
> +
> +		create_default_gitdir_config(de->d_name);
> +	}
> +
> +	closedir(dir);
> +	strbuf_release(&module_dir);
> +
> +	if (repo_config_set_gently(repo, "core.repositoryformatversion", "1"))
> +		die(_("could not set core.repositoryformatversion to 1. "
> +		      "Please enable it for migration to work, for example: "
> +		      "git config core.repositoryformatversion 1"));

We should probably be careful here to not override the repository format
version in case it's already greater than 0. We don't have version 2
yet, but if we ever do this would otherwise need to be changed.

> diff --git a/t/t7425-submodule-gitdir-path-extension.sh b/t/t7425-submodule-gitdir-path-extension.sh
> index 06ee1ff86b..6ca9f13a59 100755
> --- a/t/t7425-submodule-gitdir-path-extension.sh
> +++ b/t/t7425-submodule-gitdir-path-extension.sh
> @@ -260,4 +260,71 @@ test_expect_success '`git clone --recurse-submodules` respects init.autoSetupSub
>  	git config --global --unset init.autoSetupSubmodulePathConfig
>  '
>  
> +test_expect_success 'submodule--helper migrates legacy modules' '
> +	(
> +		cd upstream &&
> +
> +		# previous submodules exist and were not migrated yet
> +		test_must_fail git config submodule.sub1.gitdir &&
> +		test_must_fail git config submodule.sub2.gitdir &&
> +		test_path_is_dir .git/modules/sub1 &&
> +		test_path_is_dir .git/modules/sub2 &&
> +
> +		# run migration
> +		git submodule--helper migrate-gitdir-configs &&
> +
> +		# test that migration worked
> +		git config submodule.sub1.gitdir >actual &&
> +		echo ".git/modules/sub1" >expect &&
> +		test_cmp expect actual &&
> +		git config submodule.sub2.gitdir >actual &&
> +		echo ".git/modules/sub2" >expect &&
> +		test_cmp expect actual &&
> +
> +		# repository extension is enabled after migration
> +		git config extensions.submodulePathConfig > actual &&
> +		echo "true" > expect &&

Style nit: redirection operator strikes again :) Probably makes sense to
scan through all commits for this style issue.

Patrick
