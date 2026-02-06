Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3B7168BD
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 21:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770413266; cv=none; b=fxT6NV22wpJLG2K62/rAhgFtDqS0+274RSf66tN73fzrKBgIMmRYu6PTnMafT9JvNGyZOEOdB4BAOHqhcrIIWOy0yMSSq+pYrMViwSp5PPLwkBWlVfpJDgfledohWJHInU4FqQ4X1tbo0Ouo7YBzpY6yQV1ZG+NHfC/5+yzVxrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770413266; c=relaxed/simple;
	bh=aDmPgkthyLurvqCXpQ6+jMI+LofBuawLLvvQlUoA34M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TPIEtGclK0SKGw07cWpD5Hy68CWTS9hXzeMbTZnWc/H3+EIT2fFeV0mA53TCNRONmwWNhJHHqDkpvzXE0V4OY4gGpg5nu8G3JMB2xi+NUI7QMob9SSAzBdz3lGv6LYEdFYHjh0J0v3ODS6kvRk8zF7NmPbOvmVsU7Rj7aFfmRTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PQTeOV+O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d5cpFR1R; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PQTeOV+O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d5cpFR1R"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 827FE1400086;
	Fri,  6 Feb 2026 16:27:45 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 06 Feb 2026 16:27:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770413265; x=1770499665; bh=k5QZCGQXFG
	/Rp14qZJPZHrbb/MzaDCgXsO1MKfeP/Uk=; b=PQTeOV+OtLd6RKmYK7PBnMJ92u
	8Hrs6Wai1U/SSMJmPS6sCON+tgpqmMgG+To/XiC9E86FapT2pyLXiG+9+unz+HA3
	fmRt3gT9FWLbqAntL6325xU+F45kIqNpNgv1CkkHKgOSZk2Hf5TUVVTuwMtBkTUY
	pv0AAXWF3KB880CIVRGQf/iDbyqgsIiPNB8a5McvxCNz+mkMBY4RhapcBiGmmXxl
	MDceveAIyFCGFMGLbbpH3cTiflVyUbWnK1qMT6NeGVss1WftA3foJF2MrUNPbfd6
	O8I3v91rDIE3EGI+XHAwFY+oNL5LrlDlGj3970JfjDPSHyPENhV2+KJszQKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770413265; x=1770499665; bh=k5QZCGQXFG/Rp14qZJPZHrbb/MzaDCgXsO1
	MKfeP/Uk=; b=d5cpFR1R68lY7vyz8CPsc6AEDc8iG7GGlrpqkz4clISpqDHZT4v
	hygtoCPCuNqJ1JjSa27TxY9jdMGyrPtHJTuM3RvYFipf4ZxnAqvoyYs2Q9LVqNTC
	TVNrj3cW6umQeTbIZHCawdhzzrcfX/pNKc6y7qcn61+KlrI0ofZAtNZnNPI9bxml
	pOjVqLchM7q/pV1bV2mICaB9U6OFfWuxJtHue/5t9KOd5QXVarntID1d2M9yugZx
	9n+cSE+SbE0qu9gl4zeUaE3yXjZHARWxIrMNCVJEsclDco5wwHe8oXN33LvEHHW2
	E0gQtDMSXJuuzqHsdCwUvEkPJR3FNBhVCpg==
X-ME-Sender: <xms:0VyGaaB35dW3oIN6qHkOPpHXQu1ErprLKgYz06UcROquTryEwwdcrg>
    <xme:0VyGab-mf_WTeICePsb2LMMD38-nK_wxpcf2WF3-nzBuWMGPF6f6_Xq59_ei68sbu
    0OjG_wpag8zMb1nFsVRPe4FbjokBqgftHZI1L6k6dmQDXNdLlC0kz0>
X-ME-Received: <xmr:0VyGaa-hu8VySIQymABECRePrpiSb5on68jgWhCQWU27r6TE9kCHIayQEYSl9RL7dzeHxju0OGx1S7PRx09HkUX3FktWvCKdqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeelvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:0VyGaSeVRXwC3W0q52ux51iIr6Xh2_UP7fDgXu1aA_NezRgEyA-MFQ>
    <xmx:0VyGaTEH9yljjwzxpIOd9O36bOFWNaCIwF-bzY188bMvi62XetgcyA>
    <xmx:0VyGaQeXYfiZkMaeFMNVqakshn9QMBZbatCads_nC7Xut-8xSAWmqw>
    <xmx:0VyGadGhhCnxsnAy2ep51-KVYj0HPfFdDiWzSmFBH-yA2yH1nmuvpQ>
    <xmx:0VyGaenzQoMtQMY0ej_ozmtUmb-B6T5nngwyEHN3NHUGzCaVykT4-gb3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Feb 2026 16:27:44 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH RFC] graph: implement git-log(1) --untangle
In-Reply-To: <20260206-toon-log-graph-no-merge-base-v1-1-a6f983991a1d@iotcl.com>
	(Toon Claes's message of "Fri, 06 Feb 2026 19:49:18 +0100")
References: <20260206-toon-log-graph-no-merge-base-v1-1-a6f983991a1d@iotcl.com>
Date: Fri, 06 Feb 2026 13:27:43 -0800
Message-ID: <xmqqv7g9d0kw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> I would argue the problem here are not the merge commits, but it's the
> way this is displayed.

I am curious, as anybody else who has read this message up to this
point, how your --untangle option improves the same section of the
history you drew above (which I did not include).

> There are still some bugs in this implementation. And a bunch of memory
> leaks. Also am I not sold on the name `--untangle`. It sounds catchy,
> but it's name isn't very meaningful for most users. I've been thinking
> about `--ignore-merge-base` or `disconnect-merge-base`, but I'm open to
> better suggestions. That's why I'm submitting this as a RFC. Before I
> continue work on this, I'm curious if the project is open to such
> contribution? And if so, which direction it should go?

In any case, I am very happy to see another person who is not afraid
of our C codebase to have looked at this part of the system (I have
a long-standing pet peeve, unrelated to this issue, in this area).

>  struct column {
> +	/*
> +	 * When only_first_merge_base is set this column might be ignoring it's
> +         * merge-base, store it here.
> +	 */
> +	struct commit_list *ignored_merge_bases;
>  	/*
>  	 * The parent commit of this column.
>  	 */
