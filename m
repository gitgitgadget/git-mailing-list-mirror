Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C373D1CC5
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 06:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780986050; cv=pass; b=FQ7tMeRpKwJc6MxBAY09ZCruvf/T8OfW1f3/jMovhEfQd6FHUQNlbkw+P+rC9JlVQcmEwGUUX8eVKvZ8lvCNc5JeypNZ2vivxkE4Fa1NiRORw++yTJPnj2DIOGXZXmCRm5WdWMsQEYZzrQi22FBBwJZ96NCHnyrkodX7FxtSti0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780986050; c=relaxed/simple;
	bh=n6Qb5SdDRIHKwV7eil77AWQiGn3QeYh0AdMjdKzgcsA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uuE/RkOc41aefLHVTRG9wrLRzg4ZkbMWWFN45Yfd7TxTok7ZcDFoYo5fnomjCkkJeAmKdps49TBIedp3V3PbiCRT8c8dnJhBfHWz2yMhHeih+bDjHyc+p8nfSwWf1GGMThL6U8uyH/IDkchyB13zplVB10gIy7cV24xpNh/H7z8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBYPl1B2; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBYPl1B2"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-68ced97b6eeso6895414a12.0
        for <git@vger.kernel.org>; Mon, 08 Jun 2026 23:20:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780986048; cv=none;
        d=google.com; s=arc-20240605;
        b=lQBmgxvHmrF5+B6x3jeMmH0wVzkfgWlGVdwqLKMkkfU1xhZ60jdmX4bBfcpRfyuyn7
         aX/wHX74+p6/yQgN8Q/U9/CUfAps/EO030k4QntkiP6r9HekDKyB1PFbntCIASvpmKqw
         oLzhWkpIz0SUnABvazYNWUWKOlSkdAe3NOa6pKcQseKxocisLTiMkoMEq0Yf3AQKobBy
         +KHlEFZDNNddA1PsOs6EVS+D7DoNkY32xlBy2he54ken2yYqcYJ0K90hL1nXSDA6MCfZ
         N0aTVdN+1neGlHlj6y51WKKGBRDyf31J6IcsvSzJKgXx2ofaL4p+7ocNkwNOHJgcGNzf
         viEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=M23lQI63m6SAYdU7/MpiXHRAVU07A/kktcdehrV81UE=;
        fh=lUxqd10OoDiBUsb0u3tuoyTgChE3PKZGT/O5cUYiLHU=;
        b=VkcUJNYtYgnRMLOCxUT9p0Z0MKwf74mu9SVkEZPk0Q0eHS0TuQbisuwvNKoAJfXJPa
         1rAdPDqXH6L5p5ElAGhOUg1JjO1boSVwE5S+OfMalscLyp0q3KiUomoNqQNL7Ip1+MXO
         jhORNvbRHHBByfhJcAnGb6TuH+BhRwHaucmV95lKv78fog1VUMdGyBptoH9U0q6t6ohq
         vOI0m1Ffvq4HVgXLkUgvbtd6/hznbp5CpLKdTVFFtVzy4afh41MwywIEKf9kvYBEx2sm
         Ak5R7MAZHd88m1LqyABS3LqSymxcvAhdTQ8ABpKkSPzeHSRAtCfX4AeJCYkeol4zJOOZ
         z3Xg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780986048; x=1781590848; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M23lQI63m6SAYdU7/MpiXHRAVU07A/kktcdehrV81UE=;
        b=KBYPl1B290BzmBtBuPl6mRKq0rxiJ1PkX7HUVEqCPJ3WLiYGhDhLjzJ2XExtdgHjM3
         63qk/f1asN/jgQ1ymi2uSwnnjJKXewhbf9d26GZNwa+3jqECbSS3nZYOt1gV9Lp+spbu
         f1K5/2Rjdg+VcEwPRt71ra9cIcHw0F9XcfTdKoSje2PqPCfdjdDD50h/aOpXG+0IReQv
         bBA2JwGOSFqv/2aZ3uUYik/KgJPDT1Gwd488LMJzHRDNn7dCPMlnmototP7XQMFI5PoT
         8QlsYSeWTpYIfsnENBbDRseNCPJTrECbkxJ4ckNTON1qdc64dNTaz/NmhVJcxIGkTUYv
         hyug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780986048; x=1781590848;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M23lQI63m6SAYdU7/MpiXHRAVU07A/kktcdehrV81UE=;
        b=cbfHNzbGa+VDu+Wr31jIdziXVmBUti6UgJDRJs0iig6FdegB1Gd8RBAhk+Fz+R9IvB
         ieiME6CC+DfGi0+yO7pSk6sc5GoKdZmKjRnbTJfOqwTaj0aF47PHK3CHhIbt99V72C6P
         3M0G3VoxZWnGkkY5kksdiKb4ZswViHY2jk87gY8Ea+Vzj8O01IrDmrEQax8cvgWUKIVS
         5D7XlMMFuHQqg/1upvMEZmjo46+UvgyRLK8jvGFtomKREiu5Lx8GdxB9JLO9lrpS6r/t
         gkjEgJFW3teeusL9mdVqNhBHWDLb83dxbdPMGreRURmpAew/wVXkootP+O8e5Xk2z3aF
         IcNw==
X-Forwarded-Encrypted: i=1; AFNElJ/kEM/UokIOkcvvbwcZbIIWBxufLX0tShbm8qipNfEPfWQPlGhNcYnOvC8ioavpNZ0a/1E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+52wk1GBqQQ4QKTdb0+c2A4JotliGtcvwQPR5FdHIUR/hJ8o3
	PTZ1YR92prtrnwzzE9rakl04FfBL21YiHLmXvRRDy4yigAIQPo9z1mJ9Xbzak4kwVZ1S7DmjbZa
	WYRnepmk4o/pjvGL3884Gbr0pzAyOgt8=
X-Gm-Gg: Acq92OEzHumqRiL97GkJBJdg6WTs6pfu4T1MEAtXCoiOezYyoIFo7M1cekX6gqIL+ng
	nGMExAQL0cK6APFivoH1Np4iv4xFIVIkVjhGDS9i45QeXgJpaEsJvdSXNUp5umFJY5TNgot9IDB
	q65amaV31zObfYYTc738XrFHyj6gtYbgshQz5jsNeX2m4c6fBjYxfeGThGbeU3q9dip9vqfIPEw
	fwBnBm9QZvRy9JY/CwxGOQ1rEj0c0O6dpixxFAiU+CyjrOiylYq85vwdit6MA4I14/Hj06cIXag
	KiyQSVU5r1sp+ZHKu1L+Qdcygq60afHsU0u1t77AieXB3PIKGH/LaajHu89hw5XWzCL0DLVQRvG
	sKkoiyMIMmayvye4tZGM7ui82eiG0BMI=
X-Received: by 2002:a05:6402:5251:b0:686:9c15:3121 with SMTP id
 4fb4d7f45d1cf-68fa504626bmr9677400a12.12.1780986047578; Mon, 08 Jun 2026
 23:20:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221190451.12536-1-eric.peijian@gmail.com>
 <20260608-ps-eric-work-rebase-v12-0-5338b766e658@gmail.com> <20260608-ps-eric-work-rebase-v12-2-5338b766e658@gmail.com>
In-Reply-To: <20260608-ps-eric-work-rebase-v12-2-5338b766e658@gmail.com>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Tue, 9 Jun 2026 11:50:20 +0530
X-Gm-Features: AVVi8CeJTFgFG6rifrvvEdAm2XYnfAJFApEFUaO5O3KHvcixyBMt_lnm53pBzqU
Message-ID: <CA+J6zkST0Hs-X-2csfnfri4UVdK-yBDdQALkBcRK62a88aZ15Q@mail.gmail.com>
Subject: Re: [PATCH GSoC RFC v12 02/12] git-compat-util: add strtoul_ul() with
 error handling
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: eric.peijian@gmail.com, calvinwan@google.com, chriscool@tuxfamily.org, 
	git@vger.kernel.org, jltobler@gmail.com, jonathantanmy@google.com, 
	karthik.188@gmail.com, toon@iotcl.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Jun 2026 at 15:44, Pablo Sabater <pabloosabaterr@gmail.com> wrote:
>
> From: Eric Ju <eric.peijian@gmail.com>
>
> We already have strtoul_ui() and similar functions that provide proper
> error handling using strtoul from the standard library. However,
> there isn't currently a variant that returns an unsigned long.
>
> This variant is needed in a subsequent commit.
>
> Add  strtoul_ul() to address this gap, enabling the

Nit: extra space here. Also, this could be conciser. Maybe something like:

"This variant is needed in a subsequent commit to enable returning an
unsigned long with proper error handling."

> return of an unsigned long with proper error handling.
>
> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
> ---
>  git-compat-util.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 8809776407..4bf569f35c 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -975,6 +975,26 @@ static inline int strtoul_ui(char const *s, int base, unsigned int *result)
>         return 0;
>  }
>
> +/*
> + * Convert a string to an unsigned long using the standard library's strtoul,
> + * with additional error handling to ensure robustness.
> + */
> +static inline int strtoul_ul(char const *s, int base, unsigned long *result)
> +{
> +       unsigned long ul;
> +       char *p;
> +
> +       errno = 0;
> +       /* negative values would be accepted by strtoul */
> +       if (strchr(s, '-'))
> +               return -1;
> +       ul = strtoul(s, &p, base);
> +       if (errno || *p || p == s)
> +               return -1;
> +       *result = ul;
> +       return 0;
> +}
> +
>  static inline int strtol_i(char const *s, int base, int *result)
>  {
>         long ul;
>
> --
> 2.54.0
