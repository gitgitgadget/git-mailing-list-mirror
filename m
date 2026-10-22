Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792676479;
	b=BW3wKDiTSBnxvNNMfcgdbyFORH4wD7V0p6piPYRenerZMdFH+WzIASjFtpeeBKQv8uVj
	 XX12tszoy/vLGhHZ7d3JKwhyaKN7zHa1UGS2JOgLpz0ZIXXAh+hKJqoK43tGd3JJmUhzU
	 xTuOwmEsQhWKXqxS1h15Yw/YQ9MAKRKRHHwlaQkXxB0c/CfboV59jmrrV/gEx0MXWoaGC
	 xP3+tdUqHznDCxUIyFoNwMQE9Esnxvx2YhFiaqDkAtabF2lH166XW4DThV64HVKRwPSNQ
	 ss1HepqI57DyMm0k3ynCnEdZx+FiIdchtzNrns6a72dW7blX07afy8gNRTWCFp6RcWw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792676479;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type;
	bh=PH6jaKyienXOuqCXnCy6Kzm2NS67BhGEA83ECbSemCM=;
	b=mJpFBRIvnXdIfTjOnXd6EhiVuKBrVGeA3GimEb+BY6MeDn2laihajjSRoDKafTRzFiAF
	 fRLXgvK63G2njD8spDa5IrIOCYmTLoip+QBNsWM4mUwbDSoW5NV+VAbs+5pPOAjlEorE5
	 AwwZMhXk1UmiWNu1lUMeWmCEXUrrNHOynnRFZDQsSADlFi7ONiyH3/20XtNgG30h6Bcf0
	 FMk894hW/M14NJGp2QJpicJ0yzQ1IMZdnpiJwX2zMyIdHKFKytfc3YGrf9F3rKr6Ni3DN
	 gBNwPg/1vGeiGlnmjhnm2ccJ71GtUzyN+6Tfyqa/bRj/R7jlewoDqI0KOsq56BnBD5Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=adrian.ratiu@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=ZWPrR3NC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.11
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com [165.173.180.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87E7606A31F
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 13:41:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D87E7606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=ZWPrR3NC
ARC-Seal: i=1; a=rsa-sha256; t=1792676467; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gbvBHM6hjAjH9AUVqDXKitl0/clGRKalVkOgNFH0WR0BKEq+1S4XDo1JbgwzTXXBVbtCuWndhB72eA8p/Q4/8Qq8tYdNnRe1tU35r18G7hEtreLzfdlOqc/tdomP1bMHhAnHuRdqVpDN59SlAk6QHTi+TWU8bwM6NL3E13PJKNY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1792676467; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=PH6jaKyienXOuqCXnCy6Kzm2NS67BhGEA83ECbSemCM=; 
	b=UleFXbFfzw9Tr0j44/94TmoBg/mhwjIpFyc26mkZiMHFpR+LeCP4nO2vjMl9DSi3L3nCWcxP7Dp0xEh37nAQmBImqk6b5khC7BkdxxaLnFwClYGTlzNwGW1QAJTVrv73euQW8GQyR66KG3+ZiFnbxrwvqHZP4rdOm1GKMCgJ2sU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792676467;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=PH6jaKyienXOuqCXnCy6Kzm2NS67BhGEA83ECbSemCM=;
	b=ZWPrR3NCztOo5pElLcIX2nveT6+nD4cKjAKpIwK7x1eWrfagjtEuMGJLTqjzSnSs
	IrmmKiG24XrU2IqHZDc7QKZ7lnVx5VhBWUvYP+rlGTx3kP8F8uvMuJCFp/h122fiSuO
	mMVv1FtnmqR/LDzujZ5WEYJ/5RApBAeV9sgod1fY=
Received: by smtp.zohomail.com with SMTPS id 1792676463703542.3314697449159;
	Thu, 22 Oct 2026 06:41:03 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Thomas Bachem via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Emily Shaffer
 <nasamuffin@google.com>, Thomas Bachem <mail@thomasbachem.com>
Subject: Re: [PATCH 1/2] hook: honor hook.<event>.enabled for the hookdir hook
In-Reply-To: <xmqqbj8nosq1.fsf@gitster.g>
References: <pull.2272.git.1792520353.gitgitgadget@gmail.com>
 <1a7d060fae0decbe7dda63ec4ab57e32e0205df0.1792520353.git.gitgitgadget@gmail.com>
 <xmqqzew8us4s.fsf@gitster.g> <877bjc2im5.fsf@collabora.com>
 <xmqqbj8nosq1.fsf@gitster.g>
Date: Thu, 22 Oct 2026 16:40:59 +0300
Message-ID: <874ied3las.fsf@collabora.com>
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

On Wed, 21 Oct 2026, Junio C Hamano <gitster@pobox.com> wrote:
> Adrian Ratiu <adrian.ratiu@collabora.com> writes:
>> However, having said that, I don't have a strong opinion and am ok
>> either way, so if others think it's a good idea, we could accept this
>> patch instead of fixing the doc. :)
>
> I am undecided if we should treat it as a backward incompatible
> change or if we should just label this change as a "bugfix".
>
> The additional documentation in question said
>
>     hook.<event>.enabled::
>        Switch to enable or disable all hooks for the `<event>` hook event.
>        When set to `false`, no hooks fire for that event, regardless of any
>        per-hook `hook.<friendly-name>.enabled` settings. Defaults to `true`.
>        See linkgit:git-hook[1].
>
> which talks about "hook.<friendly-name>.enabled" setting, hinting
> that this is also about the hooks that can be controlled by that
> other setting, which was added by 1ecce722cd (hook: allow disabling
> config hooks, 2026-02-19), which added "diable" specifically for
> "config hooks", and the documentation from that addition says:
>
>     hook.<friendly-name>.enabled::
> 	Whether the hook `hook.<name>` is enabled. Defaults to `true`.
> 	Set to `false` to disable the hook without removing its
> 	configuration. This is particularly useful when a hook is defined
> 	in a system or global config file and needs to be disabled for a
> 	specific repository. See linkgit:git-hook[1].
>
> mentioning "removing its configuration", and "defined in ... config
> file", to me, it is very clear that this configuration variable is
> only about the hooks defined in the configuration system.
>
> Which tempts me to say that the change being discussed is a backward
> incompatible breakage, rather than a bugfix.
>
> But casual end-users would of course do not know how the feature
> evolved, and may not read the documentation of the feature they use
> carefully enough.  So I dunno.  Perhaps changing the behaviour at
> the same time updating the documentation to make it clear these
> cover all kinds of hooks, not just the configuration-defined ones,
> may be sufficient.

Agreed, let's keep it simple.

@Thomas, can you please send a v2 to update the documentation to make it
clear that disabling the hook event disables both the config-defined
hooks and the hookdir hooks for that event?

Just a short mention like you specified in hook.h, to avoid any
ambiguity.

Many thanks,
Adrian
