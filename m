Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=157.230.60.252
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792834144;
	b=FUTLwla9M+48yKizUNssT73GYOhH65pU9C3V7DMKrAtjGCbuPTH/+Di3hcA2F9LCn2RD
	 Zga3AcrHVMlqzVhjX8Hkxn+o0waC63MjbP/4bb7XbHkkVoY08ReWkdDhAhP0N2z06yhma
	 oNoTBUYji4BOlNHWfk0yn1Wkar2Sw8iQv3P/bIvL6RO+5sxW9F7rXiXsRrGO5Jm8o2xfZ
	 2fSswL86F5xkoGlGdQXiuyla3ifcgRo0ANjoSRgsjOEpj8HqR57BZcpiILT1WFGiTkoLz
	 CmqxZ/fZRoqnOresOZzoREv3orIJ0vSfcS515BX9ikL+iBFwuubbbzHk5/NpiqMHf5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792834144;
	h=DMARC-Filter:DKIM-Signature:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:To:From:
	 Subject:Cc:X-Mailer:References:In-Reply-To;
	bh=ZTzK6ifbbTfqr5YetgylOUfD8nyXA9yjraIsuzKJrr8=;
	b=xF4Ww//NR8onOqajXu68Wnq+lTiMovReIcWQKcVe4w5Yx7Rkh/KZMG/OWI5bCgbzMcjK
	 cDmfsqxHCuIYf/N9gRJSEfdzIzwGGXWEpqtmAuZj0d5FqHRYG2hTse//B3zYj5DltrJoE
	 6BQyMsYu0mox+qLPCysbszxfcf6K2NB8ugTNyhU9/GGOQEZ3T8MBVD59qMbwerNNKv7cG
	 EUD3w0zb1MzJpI/JHaEEc2/09mRWrK4aDu7M6SCg5C8wc+MkPauHYEnUPyoiHAv2dcrBB
	 dXUgdk6DMil9yPEchj3kCYkzg2OdyLMTrXwlV6csv4zJke7kjOcDqvxt+Mo3HeDfo0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lfurio.us;
	spf=pass smtp.mailfrom=lfurio.us;
	dkim=pass header.d=lfurio.us header.i=@lfurio.us header.a=rsa-sha256 header.s=default header.b="g/kgEYhN";
	arc=none smtp.remote-ip=157.230.60.252
Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3B0606A31B
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 09:29:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF3B0606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lfurio.us header.i=@lfurio.us header.a=rsa-sha256 header.s=default header.b=g/kgEYhN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1792834142; bh=XPnU94aMWRgTWTq59djOZ8B6PNYqWBye7Rme4hm78t4=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=g/kgEYhN2vkhdQCjXruVieT1hSMy6eKhvlO2dw+hlsEiLATN+/7qqn85TZ3gDoBct
	 O+h4TNUlTvmmHfkoUSfk5Qe+cw7D8f5Rj5HhzYxIkbvctohuOxtBNk4B2oaRk+mKHs
	 mm3b2lae9cWTsnJ2LkeMVw9Hy5qpWJxMxHYqqTF8=
Received: by mail.normalmode.org (Postfix) with ESMTPSA id 7C4FA615DD;
	Sat, 24 Oct 2026 09:29:02 +0000 (UTC)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 24 Oct 2026 05:28:46 -0400
Message-Id: <DMCYNNPMFVMA.S74D9Y3OQ9QE@lfurio.us>
To: "Colin Hinton" <colinlewishinton@gmail.com>, <git@vger.kernel.org>
From: "Matt Hunter" <m@lfurio.us>
Subject: Re: [PATCH v2] remote.c: defer remote.<name>.followRemoteHEAD
 validation
Cc: <gitster@pobox.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20261018235508.848-1-colinlewishinton@gmail.com>
 <20261023185007.21642-1-colinlewishinton@gmail.com>
In-Reply-To: <20261023185007.21642-1-colinlewishinton@gmail.com>

On Fri Oct 23, 2026 at 2:50 PM EDT, Colin Hinton wrote:
> Continuing from 86129fd (fetch.c: defer fetch.followRemoteHEAD
> validation), apply the same treatment to
> remote.<name>.followRemoteHEAD, which is still validated in
> handle_config(). That emits a warning for any command that loads the
> remote configuration, such as "git push" or "git remote -v", even
> though only "git fetch" ever consults the value.
>
> Store the raw string in struct remote instead, and resolve it lazily
> in do_fetch() through the get_follow_remote_head() helper introduced
> by 86129fd. This replaces the parsed follow_remote_head and
> no_warn_branch members, and the NEEDSWORK comment left behind by
> 86129fd is removed. "git remote set-head" now compares against the
> raw string to decide whether to rewrite "always" to "warn".
>
> Moved enum follow_remote_head_settings to builtin/fetch.c as it is no
> longer referenced in remote.
>
> Messages for an unrecognized or missing value name the full variable
> name prefix, as the helper now serves both the fetch-level and
> the remote-level setting.
>
> Signed-off-by: Colin Hinton <colinlewishinton@gmail.com>
> ---
>  Documentation/config/remote.adoc |  4 +--
>  builtin/fetch.c                  | 45 +++++++++++++++++++++-----------
>  builtin/remote.c                 |  3 ++-
>  remote.c                         | 28 +++-----------------
>  remote.h                         | 13 ++-------
>  t/t5510-fetch.sh                 | 18 +++++++++++++
>  6 files changed, 58 insertions(+), 53 deletions(-)

Besides Junio's whitespace notes, I have no additional comments.  Looks
good.

Thanks
