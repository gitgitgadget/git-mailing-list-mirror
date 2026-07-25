Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAF02EA47C
	for <git@vger.kernel.org>; Sat, 25 Jul 2026 11:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784978954; cv=none; b=dOI8Lz+4iOV+wE2Ns9E4AN5aZLIOidxoYPaPpinSQa+Jxe6/MX9JbmJwxRLZD1zQaDc4RiIlj/v/7Bkeby1i/wiG0dLieSRs93/imw8dYumQLo8jEqu+NmMBQGux9YIGavkVlcLOjAuk4MXzdSeSDTWDGdLwJhV0goR/D4jM1wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784978954; c=relaxed/simple;
	bh=dSfLQOQb6Dv98yRNUnOMBy8qM7O6ZLcOwcDSqoMhxj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gmgE3YgkbqP43axrOMCcXgsb/ITH9DCxl/RLzCgLOn0/5aP+/uV8vT6+sOu95BjW/Q4Gsk1WbNTJSxONbawExzaNmpMAVKfs6yvPgkRg88GpNDe1xCwellem0YVQDw4o2yNwV2dD+EPn8apLrGX5HNKl0UhSovPpaRtMAF25zb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=oEu9MnLT; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="oEu9MnLT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1784978948; x=1785583748; i=l.s.r@web.de;
	bh=mGKrQOKE+mKDv8yWB2RLYxoErGq4lVVamlpddW9JXAM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=oEu9MnLThGne3EcouHhPdLeSjEABAcjepzCsmr/9egd5FO1OxCg6iqjOpjSRjOOi
	 DuFtv1AtnwtBU7jzunqXQr2Dtt4duG3MS0fmSYkm6pwyrMB4nK24yRy8pNfAEbx+n
	 qbGHSAheMg1sstVLfrHpSarIPDOnOx8WQGcvKI4AFpaY6J13vSXq2vdupMolDWot/
	 p7p0GwXJFs3J39FMllefJkrVsuDFNPLd6WUctTliU8GfMwsomKy78c42XjYIEIeQF
	 VPpRbzeJxeBZTyy3fUNlnaYHygtRYtpzZAhImaOSBjdZ29jMNb5pvHecZ09Gc+aLf
	 SKVs/3M+F7ETQ6cdvQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mmymz-1xDbWd3FId-00cu9y; Sat, 25
 Jul 2026 13:29:08 +0200
Message-ID: <81b0d8a0-5c65-4b42-ad75-2b818f0bb66a@web.de>
Date: Sat, 25 Jul 2026 13:29:08 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/10] test-lib-functions: improve diagnostic output
 for trace2 data assertions
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Elijah Newren <newren@gmail.com>,
 Kristofer Karlsson <krka@spotify.com>, =?UTF-8?Q?SZEDER_G=C3=A1bor?=
 <szeder.dev@gmail.com>
References: <pull.2149.v5.git.1782923832.gitgitgadget@gmail.com>
 <pull.2149.v6.git.1783776466.gitgitgadget@gmail.com>
 <d0ee6d062ef60e2d9e4572ed2dd4d0968e1e29c3.1783776466.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <d0ee6d062ef60e2d9e4572ed2dd4d0968e1e29c3.1783776466.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XyBTITxi8YxUZ2K2M9LgIcGH44patUthceFiY8lRN5AqO7ABvxl
 zGL9zdVWbYexINgw01j6I4h0g1uAI9qmzBoZ2UJY4qiQfFKLXXLhVvwwfKvOnBxWF1YvG3y
 vkdEgGpze4WaYP5cd7dQBnetZ78QtjDyA2838gcGvTNi5SFZRmGjb+sjf5tsD469qKMxXGS
 YuZ4a00EHIuzEV/RPJ86g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9RgpSiC42JI=;NIbD+6U2lgkd3hMIWyMQ67V+Tpz
 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

On 7/11/26 3:27 PM, Kristofer Karlsson via GitGitGadget wrote:
>=20
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 809c662124..3521efe5d7 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -1996,6 +1996,42 @@ test_trace2_data () {
>  	grep -e '"category":"'"$1"'","key":"'"$2"'","value":"'"$3"'"'
>  }
> =20
> +# Check that the given trace2 data event has the expected value and
> +# appears exactly once.  Produces a diagnostic on failure.
> +#
> +#	test_trace2_data_singular <category> <key> <value> [<label>]
> +test_trace2_data_singular () {
> +	local category=3D"$1" key=3D"$2" expect_val=3D"$3"
> +	local label_suffix=3D"${4:+ [$4]}"
> +	local kv_pattern=3D'"category":"'"$category"'","key":"'"$key"'","value=
":"\([^"]*\)"'
> +	local actual
> +
> +	actual=3D$(sed -n "s|.*${kv_pattern}.*|\1|p") &&
> +
> +	if test -z "$actual"
> +	then
> +		echo >&4 "error: trace2 data '$category/$key'$label_suffix not found"
> +		return 1
> +	fi &&
> +
> +	case "$actual" in
> +	*"
> +"*)

Nit: You could use $LF here instead of this two-line string.

Ren=C3=A9

