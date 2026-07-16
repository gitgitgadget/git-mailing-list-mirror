Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73F02045AD
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 20:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784233669; cv=none; b=BtFxADWr7V7o/40Q4bT5dEN7qD8MUgKugHC6GZ3Q/beHrRctoQgYt3QwHy8ucsRs+dEGnDiHzlKZrtcbFukybUd7cfCx7i7RmU0O8JJYraFE2g4vDejjyTcajA7Z/M9c99PNunTj6eFdCfBc7JfBPNV0ZVrKWdKQqERG0IT/dEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784233669; c=relaxed/simple;
	bh=XPWVNop8CU9wrprEqVc1CiWppIycu866gG34h0L9oao=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JKFrRsojUvmvU7gXNevGOy/QiBJffdlpxyMGGZLJDrIRpZWFv416JaA/nugIphHVfJEbpbsjGajygc+HU3sdiIMYJzOFlm2SRSPDejqvzb7NuNxhOfv0WanpU5sSO8rjCYYZs01VqXLUMsSkiFg3WOuHZxzJvmDd9DV/cK5ZebE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ULOg59Qq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BwWYDvwu; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ULOg59Qq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BwWYDvwu"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id F35CAEC00A2;
	Thu, 16 Jul 2026 16:27:46 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 16 Jul 2026 16:27:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784233666; x=1784320066; bh=v+5zHBVbiW
	7tWox7Ia+2LjFbh0m3jc9zZdJFt01wuIs=; b=ULOg59QqU0AQSYRwjiRhLrHK0A
	bfJZDlHC/Nsr/tkovugXiNi1RTXCQH0nz8hJxqe9fEbatBRVt4jB6vQsDDsW80Sv
	zane/dFyDZUDPgoaXK6QNDxiEj/3ubUhwTkM/8IWB71oVwEwg6PNB8ibPImY+yqX
	RriQNN+/jPPylGMDvUBY9498aqDfmDRm4xk3D9gdekdGFzZW+ef6j/V0MXAcZTkb
	IP7loClWotOY827/ezAi1fjNOe3zqELvNrfxvCJb89ZyG1UvuhmaHcXtHiHUmukZ
	DWA96eWb5x0h0eQIvC6vvs9MnfqoU6EE9K8m8gT1ArsmarWSDRhUJg61h8VQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784233666; x=1784320066; bh=v+5zHBVbiW7tWox7Ia+2LjFbh0m3jc9zZdJ
	Ft01wuIs=; b=BwWYDvwu6r63VXzkgRS5S8R64rKwJ7eXwBYh97FHfqRh9tNO9Yn
	b9TEpFQ9p/4u2zKtYanMj9lFU2e/e3tk0LrmFsqiWG1LYW7foEVgsrIDYZg2dHLg
	dKG1r1GnK8Gu4PVeZErziTtXsYlOybY6ag+T9zsBX7zpkFB+Vi03SLLVfGDJ3RkM
	v9pDdT0KMMuWA72rraT8OcVoL2eO0wntDFANPEnoexEEipO6o6sJ3No38Ex0N+Lg
	hhZu2FK0xUDko0iEJNN0IlSJI15fOMvJpOvEXPb4Iy7xecie6xgjVq0TlZ1p75hn
	m0p+AuIXMZLdL9yXYe3/ukDNxl5zLq2OcUQ==
X-ME-Sender: <xms:wj5Zard-IxAqV8KtEX9aZFtBCoFoHeYmVgUNL17uMBxpG8jC9UFc_A>
    <xme:wj5Zajdid0QJJAyPPcQWjOC38hqiZGGKU7F7IPeVQ2BRq1BorQZNy8xKovhYjTJb9
    vLfXcQL7rJKArSd8lQvkvTaxXL9ZcvzwbDPc1g5drACQrjTMKA9>
X-ME-Received: <xmr:wj5ZamwXCpHBQvRyMAGYYrVyKYRlUBu7wEf7fRKba0_ybSADZC1a40GnvW3HuZxqHPvOb2THzphKrxsohTjBrdPuYcz1G3EOLVzK-Z8>
X-ME-Proxy-Cause: dmFkZTERffS6eR1GMn+JpBnh1jqn7GvCcEFQOfyCnzo5eL7YbTDaZu27umrULcizlVRl1V
    2In721mSNoW66HsFkO6JRh/9lwrOklhAFNL+eDMz6asW2RAS06XOgWzhBh4grME4HpR7je
    dRAVd1H3iTrZAUuKFubG957BsYTko+/nDjbhDKCAsk0SohEreovINUXztmXwGIbDKPzI6Y
    nYKK7mtGhrfJI60r90LIZ/rJpBzB1/98rNQ4kVULrtkANWgmEyjcBzeT7VHQJF1Ut+eHPR
    smSMSoKkaoF4w7Kr9/YA+km55UZNeH8IHHJqaYJk9amXeRc62WSSCfbgdUuAOKXeKMURnj
    CP/qlZLXTkT2v1b4ND2gqqHvYQ07qVgPZiB0ECkt4Yw4nfHFb1d7TlkpufL9aeKsiiYiTI
    MG9WwvUg6IFcaalKXTwcRFkn5ABofU7nRYLZjZ/cclJ5jpGm77eVD0jlSYCqkywmn0Xi8w
    bgCJVpEF1b9lyTAc7pxvSepQRMu6wLYrQAGnYeKNdJ5TA5MmttlwLGNlrbljzso61LFW+t
    auQtutM8HeLWXmwcREgPwqbHrQtFweLgEYBv9n1EVzUm4xbqHSg2MYqmP9C5akxbb3YVqi
    1eRB0kagb81p5EOUhMnbelfJ2ZcnLMw0Hf3JiOxvADDSgFMT+FqUq8+SjzrQ
X-ME-Proxy: <xmx:wj5Zai9vlqAoI-ZH_bUy5xs_k8YXisZp3WE4WMY-iHSs0OBUSpB-jQ>
    <xmx:wj5Zamhl-hACX0aR71VQlTtKdiVsMJ5Rl93IUrnz1--eRF_86KAVoQ>
    <xmx:wj5ZahH95S-kET_lmx-yao-PCOd2E8CtAqmmPjl5PapSUZy1C9oCKg>
    <xmx:wj5Zat9h0IPIZTuMCR2h0WAK4E1dMP52KGnVsGhF6jQzkLFXjuykMA>
    <xmx:wj5ZaopG9eB1HUkoY78vmTSgz65uKVTdtz6H8qSqEQLV79Q65axyoBuu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 16:27:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org,  ps@pks.im,  Christian Couder
 <christian.couder@gmail.com>,  Ayush Chandekar <ayu.chandekar@gmail.com>,
  Olamide Caleb Bello <belkid98@gmail.com>
Subject: Re: [PATCH v6 4/4] environment: move has_symlinks into
 repo_config_values
In-Reply-To: <20260716084941.1101918-5-cat@malon.dev> (Tian Yuchen's message
	of "Thu, 16 Jul 2026 16:49:41 +0800")
References: <20260715035501.48271-1-cat@malon.dev>
	<20260716084941.1101918-1-cat@malon.dev>
	<20260716084941.1101918-5-cat@malon.dev>
Date: Thu, 16 Jul 2026 13:27:45 -0700
Message-ID: <xmqq33xifzni.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <cat@malon.dev> writes:

> Move the global 'has_symlinks' configuration into the
> repository-specific 'repo_config_values' struct.
>
> To ensure code readability, the getter function
> 'repo_has_symlinks()' has been introduced. Callers access
> this configuration by passing in 'repo' when possible,
> and explicitly fall back to 'the_repository' the rest
> of the time.
>
> Note:
> To support platform-specific overrides (MinGW) before
> repository initialization, the 'platform_has_symlinks()'
> macro is introduced in git-compat-util.h. Platforms can
> override this in their respective headers.

This shouldn't be a mere "Note:" but should be treated as an
integral part of the implementation details.

    Move the global variable 'has_symlinks' into the
    'repo_config_values struct.

    Introduce 'repo_has_symlinks()' getter for readability,
    and 'platform_has_symlinks()' macro to allow platform
    specific customization, primarily to help MinGW.

may be sufficient.

The changes to compat/ looked reasonable to me.

Thanks.
