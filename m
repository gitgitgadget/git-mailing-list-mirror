Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DD340BCD2
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 16:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781196754; cv=none; b=nKpHCHFMei+idvbAeGyWdVSVgS9Wa0ZFVh/5tGnKozuj/DEbTQvCnhpccaFXuVHmcnBfxbdNFaJJU0gBZR0cHU9SNWAqpwfN0JD+j8z5gN+0DJ9LsoEj9+TLpPRYHDLJGNeFmDczIPydHEUs2l4YYHpwukGNbnUv3Cr82QIIxr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781196754; c=relaxed/simple;
	bh=I97BhSUfj1QwCdqOOEQSTxTzD2O0yX8B4jUCQXae3Z8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SiafuQr3MM4I6PLhcmBrOW4woAmycwVJf00R6z8j84uZdqufj2eHeX9ssQOYgwZdrOpigkMdRBzPsOJGf0PQ30Djxuz58bQ8LFKAELz/oWgUBgr2IWZ0HhSLPeKcXNtYu4cGyZPd2eRz9qqy9D+6ItRLTB8VJYZgL95gcm47Kv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QrmPaxhC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gsvvnQxL; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QrmPaxhC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gsvvnQxL"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 551D214000D4;
	Thu, 11 Jun 2026 12:52:32 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Thu, 11 Jun 2026 12:52:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781196752; x=1781283152; bh=LfenCdKaPn
	1EVFGiOkc7mwn6KdMMd3h4m99QsoQfpzU=; b=QrmPaxhC3WThybD3vSMl231TTR
	1yBNxid4fdF+cTkIL6RS0J17foD5HvBfHtYwxoWO8HBv2W1HBhlFKeL5cEqW22Rt
	tikKgIJpK3OoRbWCJJ8ZVvEb7YMr+wsEos5oYwlzJuCWOKbIPrRVDC1QrO4BoUy5
	IsqJP6zWlmygbGR1Zx6bvbrnWFEsqMkPqJdkIG14+Y1RCo8ZsS+VSdvlRm9lfrPT
	CPJtNQ2szNVoKHSrB+pwZxGM/jFvAa3z4IFgu8a/PXjE8WXxbmkLNbuAuUkQ/B5J
	ZQth/XzuiE6xUfpYS9Jy3Y45+gjWgqeDHOkgFflk5oXuSiVfx/eJiXpGDC7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781196752; x=1781283152; bh=LfenCdKaPn1EVFGiOkc7mwn6KdMMd3h4m99
	QsoQfpzU=; b=gsvvnQxLFDpOiWIIN7Ntw+7AHHuwR50ndd32d12cAww9DiKgIad
	xpo0yZ1jJiSlS6aH32WDzxSpu9z/q+T5hneWRNIuZ/dBIwuq5P9BHJw8UuYXsoiF
	25kerPd4c6ip6PNImIplda3j/T3z11xVC7hiGB+FWESHcWh9TS/MSsroA9eIAz8r
	5akOChKvDh8mpvvuQ1EDG3wejDN3T0XAcTTur1d1hwXS5PGdqKtJd9OAZKywh1zH
	xTzzWHvlaqOTatkAu6QygjiBS2R6PidxezyxM5jQ27x2Px/5Akj4gTwRTWVMcSs+
	9CeCbYe4xQbYmfQt4oODxiLSEWVY8Typmuw==
X-ME-Sender: <xms:0OcqarHBLTp35JrxNqJaJepMg6zGccZaEdqSaz_F_0VedBjb1jAekA>
    <xme:0OcqavU-21GYWlwL3LQT7UHEqq977ImVtL944xUY7bs-k2GaN8yJ8n8GPLlZeW0Bu
    _IASWCgYTIgkmMYJ1RuZLaA7hWxFShNb3lV-CI9lagEsPK_EqN-Rw>
X-ME-Received: <xmr:0OcqaiL6r8J6AWLK9kjxLvosEhJWO0TM7gV8jQ76HH2XphighkOVY-muWae1mX_HVl1Ed9DICECalK-G-nZ0VNv4djJdogCF86D_>
X-ME-Proxy-Cause: dmFkZTFL32veJ5XdFWz0DAt8kNwnyR1dBXz9e839Aaa1a+7MPSfumQyPTprWd3PN092R05
    yK27nU4bRR/sDxhh8flliWqciUQJNux/MtwTarNQZImjJpCWUZ07lijt3xUK00mrblSN3Y
    cTYeO3X6/yjbJvNF6xWoGe6myp2h6PAYhvpaNkDOv51FEkuCIojJXZ6HPGBWA3AvRbN3mE
    y7HZJ2ogfz3qrTHZuoX/tMnUAQUON5DLD7tYUGYB9GfqHoJidm9WgyFPm/bqf6ENBAxpJR
    VLAw8eKG/4Kxo9JWlPExZHm7cMd10ULNzsQa/EM3KkQp8hm6NVkRd6OqvPIZ3FkvcMw7XH
    qp3bKGxHRg9WZtXhlzbio2GuTrhQQ5finB3uaBS3qgtKgOkBQX+T1AJ3qbpjfDTb1qyQsp
    fDsPMUtsOVo8hlM7IXghErcqZb8Ev31QtDfBaNDW1AhJV0Fw08zA1SuyQ+bpaPZqXRnvad
    Iulo/abfsNmgA7YiBptDR4k2HULYJqeD8LnHgGgHjpH96//OSqUvxSo3wvN/yvo6jlT+UM
    TU93zXJWbTKTtIloWhBMvOQgsss3IHCTQ7B17uxJN36yU7bCet4wizxg7tKyLApo+iG7i+
    3FzocXfxD+E+vw613k8UtUaX6pN1HDAEVWlUMCIfMVD3/vnmzEPPOdp1IgtA
X-ME-Proxy: <xmx:0Ocqan8aIOyYMNwXkLcQf_12FgJOZ_x1Qv4B2jwIz7pso3fCnmpXDQ>
    <xmx:0OcqatKXzp3IH3hbLtGBGhJfbzK4sq58gY-Yzq9PXbSDHLQwKeF_Ug>
    <xmx:0Ocqakmeiy2rS0fmB6RHW8bY6BdzGpzBsvBU-biscO5vvcL5UeCvpg>
    <xmx:0OcqapMO35XKkHdHaq2nrsA5FpSMca_V6zx1BzbwOL453auwbtFjJg>
    <xmx:0Ocqaownj91-7RlXr6UVmHz9PmE5-eHev_3tdNQrrx1qcPK4nsom2hgH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 12:52:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH 4/6] SubmittingPatches: document Based-on-patch-by trailer
In-Reply-To: <Based-on-patch-by.8f7@msgid.xyz>
	(kristofferhaugsbakk@fastmail.com's message of "Thu, 11 Jun 2026
	00:22:47 +0200")
References: <CV_SubPatches_trailers.8f3@msgid.xyz>
	<Based-on-patch-by.8f7@msgid.xyz>
Date: Thu, 11 Jun 2026 09:52:30 -0700
Message-ID: <xmqqse6tnho1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kristofferhaugsbakk@fastmail.com writes:

> +. `Based-on-patch-by:` can be used when someone else authored parts of
> +  the patch that you are submitting. This might be relevant if someone
> +  sent a patch to the mailing list without a commit message or a
> +  `Signed-off-by:` and you have picked it up.

Hmph, this seems to encourage pick up material that come outside of
the usual DCO process, which should not be the intention of this
document.

Unless the changes are trivial enough to not be copyrightable, it
may be better to say "... if someone submitted a preliminary patch or
a detailed code snippet with their sign-off", plus encourage asking
the original author to sign-off if it initially came without, or
something like that?

>  . `Helped-by:` is used to credit someone who suggested ideas for
>    changes without providing the precise changes in patch form.
>  . `Mentored-by:` is used to credit someone with helping develop a
