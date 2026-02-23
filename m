Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB50349B1D
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 09:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771837916; cv=pass; b=dD3xspo2h068jPFJH6O+eKwj5jSoIcLCi99Od9eHfykEYbaxpzUwmuOVUBPNjj7hrR09ClJSOJmq9OCrkKHohqTRL88373Rk56keX4XCfdu6BUBaF0lWsnA4GFU6drloP9HXhQzPXcKLd9BkZsFaiCVdq5/JUm/5eiVXfevqqeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771837916; c=relaxed/simple;
	bh=PpqQv24oIUrw20Gu2yLcYo7Vc/moZhneIBTi2phvDoE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=BT75n2ql5DY0BwIoTWXkCf5wrcpIAqDwBXR7FmKu7+TVcx1rrkUuelQjGKuAN/7ZCukmu5miJX1xQDNlzsRRAPR37wPxulNRkD0GqmWoBeMLAImzg0PWxQ96kfkpyIFDE69ZsgKeIcG7ugJEZ/bq6IQw12p2UT/IQstILncGwGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mfIsr2J7; arc=pass smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfIsr2J7"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-56743b33c67so1766868e0c.2
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 01:11:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771837914; cv=none;
        d=google.com; s=arc-20240605;
        b=exuc1oV0hA2riADthciflcMDYvdXnbU7UQtHH+2hfL6/F18VWTGvpnlBIzXGkiZ44T
         cBKd1KUKoC9NFp1MjW0aRSe1v2ggYHtm0pstam8b9l1XjiVZBzUX8Bp/e/BVGfUM94Kq
         PcioP1yGVC8zey3xLjJQsjKwf9ezkaqF+6nRU9y81SuE2hDccH5f3I56nBmeTh3zmXol
         hEgX3kfhdt3dSHpfFtp+xfKst/BhIeDTBZWLZcVjF7TFV8iSxLQxzZ+Ar5RaTWSPf65I
         v/t64w4mON9dS4P/6HteNH7Kbb128nzI9YZt7HIEV9GayVYWgdV9qAFrvQ0y3lIYbG92
         0vmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=7WE7QwITT0CeIpvY92DQ0yYpuBDMmo/mmh2SvYwN934=;
        fh=V2HKcX3aT3PKcG0Pgj3cya7HLtWpzNm38irKb0zkZcY=;
        b=cIav1BTdT4gg32pG37z342YrwmMg4l/zbcJJW/pDzQkFTFXjuzzSYkoNZs+WZ98Pvu
         sVX1zIgR8qgnPL1523QiTJzTjXM34MSSKUbZK7nP+OAz90pfMNIWITi2KQWM1JoXhLpZ
         SV7KZ9tOpyU/Gl77JagCCn0lMTjD8jNru4o2Lz8542wPIPlfFgLdSlQEFLnOmowG9OY6
         U0zfxN5UAQFsJtEQUNvKKtNPsSlchzSPYAcAf8JtQSlkim9RlqWIzKClnmvK57o4gxI2
         Yeda0MfUUZw7I9xbcqbkNyj5o/9syef/IhSY56rTAlVuZIVXsLTsEPUPvdkTnmZVa9bT
         MGYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771837914; x=1772442714; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7WE7QwITT0CeIpvY92DQ0yYpuBDMmo/mmh2SvYwN934=;
        b=mfIsr2J7iHvpR3Wf4/CdxGMqhZxKXvmfR2rjxLPubmyt6JRf6g1pjAphaO9PqrvsUa
         /94AaXcU0K80stfILbnjPEYbQxdJe9oNRs04D30KbXfkODn5iJ2z0pOj1xbbAmRpzcX1
         mv8NbCNk3Z1EplLXKUDusGY14sIx9cLS5o0VVSFBFJT9zF2MjqpcZvTMUMoczHr8UDpE
         FCFj4/TBv63BOgBFHSsnbIBFm6FCVF8pA7IVAGkC8CQZ7tv2k6KvGRlTF1pa/KihNAl/
         XwgFc2pO5N/uO2foCo3ol+6d6q76s7ZEDAEnO11k4O00VsKBJReM/TC6bWzX1gUcRGXz
         RvcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771837914; x=1772442714;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7WE7QwITT0CeIpvY92DQ0yYpuBDMmo/mmh2SvYwN934=;
        b=TMS8NkFQ1+jhWpAkmS/WBG34ouPHO+zBLzrJBOXxcRF/jJ+NWrRE4tWuTj1SoT+Qnv
         wr0Yb43x3nbsmpV+w3+Jszc51eSgBYdNxd/ZarNIH/uMOuHPJeE5Ebb4xGDRouAGUY//
         VBP2ACP1f1NXfehLAV575GSvG1MGNable+anekmbJb4LfIOS0Mj9j4xdra2sHW0zsFGi
         DdYlxaQskivVWoYn5jgSueNY2rINi5lNZJAqNA+Sw6skS7ypJNylMjK0E8bZSMeWqfIB
         DP4R9gARw30F/jI4ayED+/6jUwq2t0JmFI1uHo+zAwpo3Y3J73+RSmpPpENeHg1XT3ym
         /7yg==
X-Forwarded-Encrypted: i=1; AJvYcCXhngji7ttC9ugEtMCvxWyLumYVSyNq7nyLpf/NfmkVcLLqDcZXtkaUdUbcXY7skHLGwf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YygEW/1LkRDQK8voco5EP/TVnRETDP3bW0hHd/yVOFOBDzpQ9ul
	i3K4Wl5AmUltxdi2bVCL9Q2sTxYQeyVBG8r3+gsJoHWicZ2LKWOjOD6xtEBHhmftpTrvidocWwc
	2GBZDzC1qwZQcaaNIUMvGehH7DgGFI+o=
X-Gm-Gg: AZuq6aJdjj7mo0+8kOwQ8zZdxMKYCKmMHAFfsO2ldtlhkqvyCv1j1/is1gCpNYtLfdL
	OXd8nr5c3AvToLypgPhMBd2qKu5HLHpIFOUOAYHazdHiiH5KxyTWvPsuIIuJODOonSvVp6IwBQE
	xF/PgAHRSH32vKWvzJ8dJMacMBhKD/T9TbVJiWNvdh+8WBnEOoqQ12ncaO01wWamCQP7sZEKsHC
	yu6TK5QL1mtJtjQkK+VhwCE+hrQm4IpAxN3lPiMsnXSCeu9+xU756BDETZSf3TMxnqQHSy5LI1F
	k1kshJhAQS/9ZbbVFcI1wRUOGZXrpVr9qGzd0/PU
X-Received: by 2002:a05:6122:8cb:b0:566:3c22:c131 with SMTP id
 71dfb90a1353d-568e487b594mr2783573e0c.10.1771837914637; Mon, 23 Feb 2026
 01:11:54 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 23 Feb 2026 04:11:52 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 23 Feb 2026 04:11:52 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260220-pks-refs-for-each-unification-v1-11-17170bd99de1@pks.im>
References: <20260220-pks-refs-for-each-unification-v1-0-17170bd99de1@pks.im> <20260220-pks-refs-for-each-unification-v1-11-17170bd99de1@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 23 Feb 2026 04:11:52 -0500
X-Gm-Features: AaiRm502JPvtuYCr_MSl-BYx14B5JAU8W0mnt3tXyJZbuBsdfeRQ2Y0XAs77vBA
Message-ID: <CAOLa=ZRXbQEyw5-RvZrXTYMnRQr47=JuiUP3Ps4LGQPspo8gPQ@mail.gmail.com>
Subject: Re: [PATCH 11/17] refs: replace `refs_for_each_ref_in()`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000008081d9064b7a2965"

--0000000000008081d9064b7a2965
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Replace calls to `refs_for_each_ref_in()` with the newly introduced
> `refs_for_each_ref_ext()` function.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  bisect.c                  |  8 ++++++--
>  builtin/rev-parse.c       | 13 +++++++++----
>  pack-bitmap.c             | 13 +++++++------
>  refs.c                    | 34 ++++++++++++++++++----------------
>  refs.h                    |  2 --
>  t/helper/test-ref-store.c |  7 +++++--
>  6 files changed, 45 insertions(+), 32 deletions(-)
>
> diff --git a/bisect.c b/bisect.c
> index 2bdad4ee42..296836c154 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -473,8 +473,12 @@ static int register_ref(const struct reference *ref, void *cb_data UNUSED)
>
>  static int read_bisect_refs(void)
>  {
> -	return refs_for_each_ref_in(get_main_ref_store(the_repository),
> -				    "refs/bisect/", register_ref, NULL);
> +	struct refs_for_each_ref_options opts = {
> +		.prefix = "refs/bisect/",
> +		.trim_prefix = strlen("refs/bisect/"),
> +	};
> +	return refs_for_each_ref_ext(get_main_ref_store(the_repository),
> +				     register_ref, NULL, &opts);
>  }
>
>  static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> index 9032cc6327..02703f2fb8 100644
> --- a/builtin/rev-parse.c
> +++ b/builtin/rev-parse.c
> @@ -613,13 +613,18 @@ static int opt_with_value(const char *arg, const char *opt, const char **value)
>
>  static void handle_ref_opt(const char *pattern, const char *prefix)
>  {
> -	if (pattern)
> +	if (pattern) {
>  		refs_for_each_glob_ref_in(get_main_ref_store(the_repository),
>  					  show_reference, pattern, prefix,
>  					  NULL);
> -	else
> -		refs_for_each_ref_in(get_main_ref_store(the_repository),
> -				     prefix, show_reference, NULL);
> +	} else {
> +		struct refs_for_each_ref_options opts = {
> +			.prefix = prefix,
> +			.trim_prefix = strlen(prefix),

Tangent: I wonder if it makes sense to make `trim_prefix` a bool and
then internally trim strlen(prefix). Is there a usecase where
`.trim_prefix != strlen(prefix)`?

> +		};
> +		refs_for_each_ref_ext(get_main_ref_store(the_repository),
> +				      show_reference, NULL, &opts);
> +	}
>  	clear_ref_exclusions(&ref_excludes);
>  }
>

[snip]

--0000000000008081d9064b7a2965
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: f8a9a4c894217122_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tY0dkY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mKzN6Qy80LzJmeVBSNmliTGdYNitOcFZyQi9KUEx3WQo3ZDU5bmc1bVRm
elBFOVYwQ1hqZjNOdGszWXBZbnh2eHRNZytKdi9tejRhSkJSUldRL2dCNVRhbURnZkNLSCtoCm1h
ZHlmVUV5azhpU0FGcVlJOEphR3JZNG9ON25yR2NzcGtQb1MrQ1VyazQwdjV6VWJQdW9LcVQzV1Ex
cFpXcDEKNGVzUi9OU0lmdzNFaitTbjJMUmVvdmZ2WUxDdWdBeTlYMmkwaVlRZjV2MU0yNWNDYjBh
bWMyR2Y5TnFxYkFuQQpLN2QzeUlyMHBSSjFMa1l0WlhscHlHUVRwRkNVM0laTXFyYnhaaWV0YmYz
bGp1elNIQU96UWRobVpER2F4ajRlClpPWXRJWENkSmJGK3RoT040UlREMitjZmU2am1NdWp0aVI5
Ri80azRKL2ppS2ozR3luQkg4RHBweUdJL3ZQa1YKcWFTeDN4Nkd3RnIyaEErWVlVKzUwTmgxRGlL
dGoxUHJ0UHBSRys5NjlLczVxT29sUFVzVnFQSWkwVDRVSzc5MwpINEEraGtzNnhFQWMwM2phTkgr
Z1JtUStNZ2Yxbnk3WkhYa3oxc3F6dm9qY2poTnJkOWd3SDhpWHE2NTVnYVpLClVHN0pMeEJIeGFM
Vkh5ZXNDSWpoOGNIZTJxR0VxQnJHbnBpenh1MD0KPVBUZVQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000008081d9064b7a2965--
