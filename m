Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA0A2DA775
	for <git@vger.kernel.org>; Sat,  9 May 2026 22:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778364081; cv=none; b=DwI8oYNsAY3Tzoz0dPst1FQ+MXd2Xi4SNfB9Lvdv6bmzqTLxqSTHL4xftGI18Y4jG9AmyD/6pFWu9dNpqVwmcofD/yIeD0Dnzv8b5rCeQl2ylPLo4YIzWhHBaAgNMwOf2TI6l/H6IJxpBZ6man/ZDkaAXjHAatokXFfGmiLFzSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778364081; c=relaxed/simple;
	bh=tu+Ocp89SodPAtiuHxZn9TOLSjF8o5IcChCQ2vOLKps=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OJm6sTZ4c8+DasuAf+YHee4img9OEoGFg8Bbwz0ULm+qTg9IpaAt/5pYemAI+itJC/3CS3Y0SEmkHPs9xQWv21gSYQPHmsQYdHcKnga7XxiAc8ARk5WlxtFRqirJ0JebftFjie+FLzk0NKWwF5JPquvA64DFWxcd7r0D4GGog38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VZmpxBc/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HxRHsJiv; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VZmpxBc/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HxRHsJiv"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2D4597A005D;
	Sat,  9 May 2026 18:01:17 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Sat, 09 May 2026 18:01:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778364077; x=1778450477; bh=wwZ64Mh7ys
	mef4JZ829RBoHYzWE+c0hU+rLzEllzqWI=; b=VZmpxBc/p5FxeQ6aAXxuFhmwuV
	vjDBjO+OW5KYI8oA/hIR3eDx9VjsbQq6l1e3XpZcMpq+mHnipI1mkte0QiBoE8RC
	8isuvp27y9zW5Rhqy8ShCqG2rZjHh5W+QrxRxmFBd8J3APXCIt3t7GOGaVUA6poP
	Km9batvhYuwFaugK3mP1Z8hdL30HdiLc2UVdMvuVkozXtL7+34TE0N620WOfYTnV
	onJTtsV3wLO1xF3ce/5q8Fhi5LWp2xXVp5xrLjLB+QpCYTKECWp0RL4wPnri4y5L
	B8xpNUYDzI6CIrG9qmi6stMrTyZ/uuQO0tVdEK6PvZ5/e9bJIwKsB+OGC+Yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778364077; x=1778450477; bh=wwZ64Mh7ysmef4JZ829RBoHYzWE+c0hU+rL
	zEllzqWI=; b=HxRHsJivAMXcF6PqSuy1upknI+9wQ4L8WhpYWfRQ4fcxGzQUBGb
	Enoj6YhEet3MrYhKE0xrgBiKExa4AJv5M7Qwi/LqDg/RJTskMfmcyKVlBJI9dW/i
	g7zmQAe5+x3GzSFdYNvkH51HD9sXoD3o5wa+xM06+7w7Paq410iFa2yH3V5mgUZY
	dlK8t25KZF8rwGpaPZAptf3ZywfIlQntpOzx+GOtT8ppzxVYL9k3mfPa3bY3UxQY
	gc2vB7WVg+EyMqGtTcCAuSd83WT3TnE6WjSRRRrgS7HnSBRZvFoV0bt/71Rq4/6+
	BqXod2ZP6HoN/qCy1gDWVNTTu0Z/EtVXIjA==
X-ME-Sender: <xms:rK7_adhAisq09vCM4KAC5TAGwUqkhQ36MVdZHE4fb3dwcZanmeb-Pw>
    <xme:rK7_aZBsbu0wCe8sF1ksIoURxl9VAavLiHMbmAUDmOhxWs7kgaTokZ1t-ydleTQsv
    doc761anMf1xJHkyGqIC8x_fRx9h1J1b-v8YtHh7_TheEftghzqDQ>
X-ME-Received: <xmr:rK7_aSGnN7D2JzPHoCCtpvFlpjIESZ6eOkuErk8ux0kbNgEU5QB4KNp3uRtbWUGCvWH8Y7GfmWCLmunsFf2eSS2i1_q_WgGg2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudegfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehmmhhonhhtrghlsghosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:rK7_aRLdZZF7WhqNGFO-rake4zurQpNhewmLiSl49IcYMZGS5myHPg>
    <xmx:rK7_aWmC1oKOLAmAWEr7cn7Fmv1jMlNqXCk94bI8cN_loCCHDX4rxQ>
    <xmx:rK7_aZQq4gPUOXr_4L0AVNUZmQl9BVE_Uy3t1NWfYCD3Bl0lIWSnJw>
    <xmx:rK7_aYIs6Pkgrwu8Uj-VE10wIhSiOAWBY_1r06jBgn-rT_4t-wL9KQ>
    <xmx:ra7_aZmgheCVZU1LV-ud0PZMjivDUk8kW-wm0bd_gnW7eVjWihLZaYUA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 May 2026 18:01:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Michael Montalbo <mmontalbo@gmail.com>
Subject: Re: [PATCH 4/4] parse-options: clarify PARSE_OPT_NONEG does not
 reject negative numbers
In-Reply-To: <05ff821e6ffec02a3bfc5aef542592de6a7add76.1778022144.git.gitgitgadget@gmail.com>
	(Michael Montalbo via GitGitGadget's message of "Tue, 05 May 2026
	23:02:24 +0000")
References: <pull.2105.git.1778022144.gitgitgadget@gmail.com>
	<05ff821e6ffec02a3bfc5aef542592de6a7add76.1778022144.git.gitgitgadget@gmail.com>
Date: Sun, 10 May 2026 07:01:15 +0900
Message-ID: <xmqq8q9sb5uc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Michael Montalbo <mmontalbo@gmail.com>
>
> The name "NONEG" can be misread as "no negative [values]" when it
> actually means "no [boolean] negation" (the --no-* form).
>
> When --inter-hunk-context and -U/--unified were converted from a
> custom parser to OPT_INTEGER_F with PARSE_OPT_NONEG in d473e2e0e8
> and 16ed6c97cc, the implicit rejection of negative values (via
> isdigit() in the old opt_arg() parser) was silently lost. The
> previous commits in this series fix the resulting bugs.

I do not think _NONEG has anything to do with the bug.  It was
purely to reject --no-unified and --no-inter-hunk-context.

And there was no change to remove PARSE_OPT_NONEG from anywhere and
use OPT_UNSIGNED instead to fix any of the bugs fixed in this
series, ...

>
> Add a clarifying note to the flag documentation.
>
> Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
> ---
>  parse-options.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/parse-options.h b/parse-options.h
> index 706de9729f..c0a3a3dcae 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -116,7 +116,10 @@ typedef int parse_opt_subcommand_fn(int argc, const char **argv,
>   *   mask of parse_opt_option_flags.
>   *   PARSE_OPT_OPTARG: says that the argument is optional (not for BOOLEANs)
>   *   PARSE_OPT_NOARG: says that this option does not take an argument
> - *   PARSE_OPT_NONEG: says that this option cannot be negated
> + *   PARSE_OPT_NONEG: says that this option cannot be negated (i.e.
> + *                   prevents --no-<option> boolean form). Does not reject
> + *                   negative numeric values like --option=-1. Use
> + *                   OPT_UNSIGNED for options that must be non-negative.

... I do not think the two additional sentences are warranted.  Stop
at clarifying what negated _means_ (i.e., rejects "--no-<option>"),
without adding what negated does _not_ mean.


>   *   PARSE_OPT_HIDDEN: this option is skipped in the default usage, and
>   *                     shown only in the full usage.
>   *   PARSE_OPT_LASTARG_DEFAULT: says that this option will take the default
