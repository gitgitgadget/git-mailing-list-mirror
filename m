Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F861D7999
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 21:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741640558; cv=none; b=m2IJL0XwRFijUMbbQaKHCWblctOjH0k9YkyBvv3xuBmurVbzZr3jSmN/8StrDYIcHVkjgWDc9SUp2gvLdOvBElTAt6FVWkIikZ9azM34q9n2lCVtwOejHayDt1vc8f/PFSJP9NNlzJSoKlGnzZD+wWAx8ARCDSd/1oHrlpRRjrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741640558; c=relaxed/simple;
	bh=r4tfAgxM6xdEt2x1jtiy1UTY19ePkW6P03CzlkQ4j9Q=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=sarwmTCn7DPKKhGILnwPbKN2hs57hiDqHdXP0tYzfwfM3IGQPcbjvEpH8eE+qXbmC8YfmopWgNsAOcYM7fNvppZdTvYSD1UwPZ8YeTDuvAqzDlWL0JkcifpAx9jP0Zuqt+Fo7tiOsK/Us3V6JsIZRHqPpM0GdIRkFtzjLlLoYDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UadmNlv1; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UadmNlv1"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-51eb1818d4fso4984317e0c.1
        for <git@vger.kernel.org>; Mon, 10 Mar 2025 14:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741640553; x=1742245353; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4SdglTgzw74RLILvYuD0S2Ct1FXwzTXkvyDjnx5L1zE=;
        b=UadmNlv10G702hmYI2Jzge930WSzftDSoA/Ow3fQMHfaH2PEXWHsYH6MtRjC6bbwt2
         bvP8fZYbTVGGDTMwUs3HzKD7GHkfFdpfCnxn4pENcpj13bg5IRJKKlYKtvQMbmQxx/YL
         oQyauMPtubA5fn9NJMYY4LJKG2JfoCY0/CrG+gMH/uqb6uzytJdkCl80//+nFWytwgrn
         GUuqVbWzGshR/ZCM4Ux5ymZ6PWPaniSyYhZbEs0AonokmSWPXwSIMA9+3GoSWy+/6fck
         RZ+wVw/q6CsEY9ZHiODcGnH5XQDx8huZprTsYEttnbJN9FGecSb4qsQN5ohB+PCwZ9VU
         RQfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741640553; x=1742245353;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4SdglTgzw74RLILvYuD0S2Ct1FXwzTXkvyDjnx5L1zE=;
        b=TcwWKS2z08kE8LqZbPgRdd3tnnB3KHZAxHVpHXxeNRmMOnaqerA1VhzZodUm3SXa2U
         iNvGQGhbl2rIg9/m0CDNA4FYm3qZjMLvdnJv3FLpJBRYmNmgOs066AYjWcBvMP4nKOMJ
         YFcT6L7zNi2LE7pNrh+Pj13OvZTL2KfDKSmQtZrO9Z39k0CZhstTt0J5QXK5bJkL3S6Z
         5okFSSdriRpI0TRGuzrd7osfc/I3IW2QFOVXMVAyNF4ib/wfr3zoScIy/0lfP51ESy7V
         V6VGLipvP7bfyQobGxLp6rrQD5LjFrMmagcgZbnav2hReOXBcrLD3ckLW/3GeOyTZUeL
         /8eA==
X-Forwarded-Encrypted: i=1; AJvYcCUEjKzZdlECUWYb8VITZWA7N81Gr3F5w/3RwVg6+NpPHFDiPbBwqs6UUyZN6ZEjelIXncU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8R7UfqRgZXXepiq9Pl3cO/FHc/5KVSWD+kUvKRp+cO08rq5Pv
	40LvoMBQ41Nb7VTB2pywoJl+z1XJ6GKeCdN19IZgKK+DoUIHI9Q8a3MuQoCR9LcJIWRkyGj/Xmb
	sAY/WwhBgJJfMwKneku1nrH+xrJE=
X-Gm-Gg: ASbGncsVd6h9Hped7Y9v6+gX5TMvbg+WTRLnwkiqb5fNx6wzG+pHVmfS2qQHyuT8V8b
	ZVxcult/5A2qdRVMAG4ysSkbDj+ZUtW3V+vSuBT5KOYq+TVxcK34jDl7pfuvZXT2q+vRIoqsO3I
	G3+eIz+o6vcDzRgNPJJJAK6x9dPCoequlwS5jkOvIa2OfWdw2hw2gg6ENoSbVx
X-Google-Smtp-Source: AGHT+IGVPS2V6iqBNW4cmIandxImaSWwO2Cr5hmPTO2WWJYSk77ub0EiTo/zWm0Gs8FNspXUIv16JgkYKxEtV/cqb7k=
X-Received: by 2002:a05:6122:1d9f:b0:523:91e8:324c with SMTP id
 71dfb90a1353d-523e4130a63mr9404631e0c.8.1741640553242; Mon, 10 Mar 2025
 14:02:33 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 10 Mar 2025 14:02:32 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <7c219279-8151-49c0-8fc0-8abe2624aca9@gmail.com>
References: <afa6b428-3190-42ae-9eac-540c95b576fd@gmail.com> <7c219279-8151-49c0-8fc0-8abe2624aca9@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 10 Mar 2025 14:02:32 -0700
X-Gm-Features: AQ5f1JpOsubnyEoEDpNIUnS3tiojqncubzMe9RkUlcK1n0anPeyMIcoFv_grc0A
Message-ID: <CAOLa=ZS=+UGf5yQO3nVhLFJ7BgsSSxigKA3CTqEVez2zkQKyoA@mail.gmail.com>
Subject: Re: [GSoC PATCH v2] decorate: fix sign comparison warnings
To: Arnav Bhate <bhatearnav@gmail.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000080db9e0630034a43"

--00000000000080db9e0630034a43
Content-Type: text/plain; charset="UTF-8"

Arnav Bhate <bhatearnav@gmail.com> writes:

> There are multiple instances where ints have been initialized with
> values of unsigned ints, and where negative values don't mean anything.
> When such ints are compared with unsigned ints, it causes sign comparison
> warnings.
>
> Also, some of these are used just as stand-ins for their initial
> values, never being modified, thus obscuring the specific conditions
> under which certain operations happen.
>
> Replace int with unsigned int for 2 variables, and replace the
> intermediate variables with their initial values for 2 other variables.

Nit: worthwhile to mention that we also remove the
`DISABLE_SIGN_COMPARE_WARNINGS` macro as a result of this change.

>
> Signed-off-by: Arnav Bhate <bhatearnav@gmail.com>
> ---
>  decorate.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/decorate.c b/decorate.c
> index e161e13772..9f24925263 100644
> --- a/decorate.c
> +++ b/decorate.c
> @@ -3,8 +3,6 @@
>   * data.
>   */
>
> -#define DISABLE_SIGN_COMPARE_WARNINGS
> -
>  #include "git-compat-util.h"
>  #include "object.h"
>  #include "decorate.h"
> @@ -16,9 +14,8 @@ static unsigned int hash_obj(const struct object *obj, unsigned int n)
>
>  static void *insert_decoration(struct decoration *n, const struct object *base, void *decoration)
>  {
> -	int size = n->size;
>  	struct decoration_entry *entries = n->entries;
> -	unsigned int j = hash_obj(base, size);
> +	unsigned int j = hash_obj(base, n->size);
>
>  	while (entries[j].base) {
>  		if (entries[j].base == base) {
> @@ -26,7 +23,7 @@ static void *insert_decoration(struct decoration *n, const struct object *base,
>  			entries[j].decoration = decoration;
>  			return old;
>  		}
> -		if (++j >= size)
> +		if (++j >= n->size)
>  			j = 0;
>  	}
>  	entries[j].base = base;
> @@ -37,8 +34,8 @@ static void *insert_decoration(struct decoration *n, const struct object *base,
>
>  static void grow_decoration(struct decoration *n)
>  {
> -	int i;
> -	int old_size = n->size;
> +	unsigned int i;
> +	unsigned int old_size = n->size;
>  	struct decoration_entry *old_entries = n->entries;
>

I was wondering why we don't use `n->size` like the previous hunk. Seems
like its because `n->size` is modified right after.

Looking into the code, perhaps this code could be moved to using
ALLOW_GROW. But that is totally outside this patch.

>  	n->size = (old_size + 1000) * 3 / 2;
> @@ -59,9 +56,7 @@ static void grow_decoration(struct decoration *n)
>  void *add_decoration(struct decoration *n, const struct object *obj,
>  		void *decoration)
>  {
> -	int nr = n->nr + 1;
> -
> -	if (nr > n->size * 2 / 3)
> +	if ((n->nr + 1) > n->size * 2 / 3)
>  		grow_decoration(n);
>  	return insert_decoration(n, obj, decoration);
>  }
> --
> 2.48.1

The patch looks good!

Thanks

--00000000000080db9e0630034a43
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 5a82273c7e53e5ed_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mUFUyRVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md2E1Qy93TUR2ZGJST09uZWoyOEFOMVhCYTJtNnlWRApiLzRhbE01TWpX
Wkp6TUxBUklaOW9NbnJXT0pzUm41VDZKMnpwdUlFS3pMOGRzSU5rUVc1UGdkcDhtd2M5a2JsCnBB
akh0dFBxN1lFcS9Kd1ZNZVk0aXpISXM1L0puckc4THNIOUpFN0c4aGVsL2ZYWlJsdnJGblM3ZHZ3
ZWlucTYKTzc4SUE4aHZKQ2pRMXpLM2Vmb2VUUDMyQmFPa0NUaUNVZ0czcDNUR09mQi9CbS9vSGZx
bnFNU2R4eUF2KzZWQQovZzl3UWtqVUFDTGJ6bE5WL3F3MGVWc3d3eFhjSjgvTGZSY2Yxc3VrWEtj
SkpYU1p1UWlQOENzWTc2alpQUFowCksxMkhvK1oycmNUK1Evd1VCdXdSWFZTMkhJWHVjeHgrcnVB
c1Z0YVBtVjByZlBFMG5nRXc2S1pDZC9lZjJiTGcKL0xLVTVYNm1kNFdOamF2eStXRkRZNFFaVDlB
YVFNaHhIRzl3ZW0zaDQ5eHdzcXlzVld4VVNVcjY3U0hsVkRMVApOYTVtZm1kQVdXa1NmcFlhSzdL
c1ZybE0xczlaakpPUG1qeGUwMmZYZ09aSXY4aVVHaWJ1VTVJS0krYUNHRnRXCkdPOUw2eGZFNmpK
RE5qd0VyL2J6ZVFycGJnUVFEUTBxU0JPa0NjZz0KPTdJeVgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000080db9e0630034a43--
