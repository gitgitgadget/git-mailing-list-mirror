Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41ADC3033CC
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 14:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773151581; cv=pass; b=pfQelw803RAGsyJoXP0rYIuSdwHNVSavIY1oWNmNw1eSsZIbupjKQfDO9NSMXqBXDm5RBNU6mdajhqpK/WOms26r1Gbomvi9V4ctZWcgP/DTCX00nivpTkrTaJxXwy2GcBZkszDpqXl/UpBFr7+vtNI9GSO4zxrIY/9gR3L32Fo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773151581; c=relaxed/simple;
	bh=HOd1MeiVPXXnbjl8VpPc3S6Q4AHTd/wOuFRza4rsTZE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=REiDRhouzrOHfz84tE3vp9ofxiWaZvkgwFTEvunL8ZIO7iwsbkSIHB2Qvwe55N6e6FVLiZbfoAJnq/XmjhgMjLCg1O1/GevZGWuuZWK7iH91pXCsxesKUo0vSwEJEiWuyZ9hETno3M7KR0JHeElYpvZAAKaq6OtV5Q6dkizMVP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BozPu7l/; arc=pass smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BozPu7l/"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-94dd06a96easo7916267241.2
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 07:06:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773151579; cv=none;
        d=google.com; s=arc-20240605;
        b=Hw1tt0QlRHqqpOj3XhKp6MdFx7S7R8tnNdx1cj0PsxwWoLIKjY+ME7ozsl2NF/qlHp
         cATr44OnbAO2Y9a+XfXslTzeuRaPs1/VQaL8kGo8WkeHFkWSQAnBTXbqTapmkHkATOKd
         0zLb/ef+ujNKrYRyCByMKBId3hN3wbKUhj7F4xGP1zdiOk4q5DtATiYKI+m1wmtx46aJ
         PypWyDb+JtqHfZdGRrWKLBOXykXYNeHoD62XThwroMfRoT8BmlIR9smr2t8sc930dK2Y
         ABasELYsRKY470YlmgkRGZffxdt9VdgKk/8johkXer9Qv9SjjZ58ZHG0joACk/hHJvhk
         5YIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=8hNrUFryOdzCsWjQZIvJqJ9e18WbalRd6Qo7oBa+pyM=;
        fh=aF7hiJsI+eJ6NnpCG8NnDCJjs0/8v/9Q7fEOA1xv3ds=;
        b=V+NP6EYxnQKwWuTc92sQo7MdUtWgvHbeSpePdO+EjQH1yDw5vGSHxNmdh2fESLLYme
         kUExT5zFOj70JOElKJgx59D6YfWKr0+wug2ZesB4aAnO4B7kTtubzzhsdnZn5fDF6c0Q
         i4nczqGqHtxwtZRxSYp9DxjTmPrYbNYtSTF3rtpRDgRHKORaSGjOelZFZLB3PdLt09wb
         oUTKKhXjRmWOy483KEtEALtaRN801nOAuW+cW99ShxPKPZI0ncupY1UclgfleEvcuFOu
         U7XLUPC6Gl24i42gWrY3AQ/Dm6/MI/9uJ/8rpQbMwlRllAqzP7vMENTlV8PX+JQmgw3I
         f3QQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773151579; x=1773756379; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8hNrUFryOdzCsWjQZIvJqJ9e18WbalRd6Qo7oBa+pyM=;
        b=BozPu7l/ECJWAJGDacICoTeUPgw/x+7STrPNkCc/MLzmIJMoI2/vG9uDmB4RjLrske
         tzYltkn1L4E3tljUvDjel+gI8aCgcFbI/AkskN2NQOreET2JFRtsVm7qjctEas7V3QMp
         kNW4X33jl4DzM3zM+vpXQoWuj0A89ZTnXAKSFByRdZsMQRDZX/iyV8ma4hPE/y8N1Bo7
         57Pd7RJ7+Ei8U6JE9yoVdh15H4mL4RWF/CLvFtUGChsziTzW6EDTdSjorh/iAHihfYff
         EPyyEPk0kZeT1JYZPD852Rlg+zxhkn2f8gbq1QuoJT6TGKA0OtqLptsZWDrhdRtvX+jD
         9cxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773151579; x=1773756379;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8hNrUFryOdzCsWjQZIvJqJ9e18WbalRd6Qo7oBa+pyM=;
        b=TURWok6ogbGQj2UzwwmawydInXwsKdYwYQ/6oKDyCHIE7WuAnX2whHYnoPFuNTj5/i
         Ypug0cJ5kmjyJXA5dxGmQZtRFTNBe74EegV1RbOm7jIW7jVXlOQrhAVDOndMWCDDDBF7
         MC1hm7uUnKbaIMW19h6o0j2oemf42eoKi7wifVUyxnB4fpylIDZnzlYWoqR4F8iFdQe7
         nSOf6gh1WhR4Jy+CrwCwwCiVvehbEaiZXGqHCDaWJPETNnktx/ZamZQh3Idtf9Mu3cjh
         Ne8Jo0HZUHGj511dpzDIxRx9QNuMpCD+MO9lyPCpStFZQdTveKsbZ7BLjEUcr8Xj7Iej
         +Dww==
X-Forwarded-Encrypted: i=1; AJvYcCWwTljVoKRYTtZR8HVCNt7AS+WXsZdZxSDIAotoC9+z6PZCqCsr1zS5WRtluU0QgzdxAqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGrIDU4Xea3UCRgPbWCKwWRmpLfE4/+io8eKz0SVzumV5Vz/LL
	wdKNw4HNc4XCSMSF0yBOT3f6MfwjB5Y7otTTHZnyO3HZa6gjO7M7jwqsrOrYUmtVr14pFDewHNB
	0qzcyCLWk+iRQcL5uO/rYtWbvN15FJHQ=
X-Gm-Gg: ATEYQzzLSGRheUkZ/vQDxrD9efRO80wnNEeQPF5KZplBkjIlh2TJuTEigjcc4M3kZpf
	RaDU8bO+fwjb1chiTZ9EtX1vcMFE+AqAslkl++Ibh06Psf/kqT5DDKFUBnrsKvmsgpqEXqd++2q
	MNaRj8iTjwZaBM5C77waEtNUymfzvmQuwIwJA4tzaSv4p6Xd6MisXOy370cualcdp/6oe+73AXV
	VG+Dx6UC4J0u3uzy0dS2AimAUMTCwazL3oiHuSqHb8vDg61nBLfAekrcrIEaXB1/OVTuMIa2UjE
	34Fj7+ppzvBgwD3A4fd3I1ktcbQERU2ZoApZ9dFY
X-Received: by 2002:a05:6102:38cf:b0:5f5:76ed:f1db with SMTP id
 ada2fe7eead31-5ffe5b7d7bamr6442365137.0.1773151579116; Tue, 10 Mar 2026
 07:06:19 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 10 Mar 2026 07:06:17 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 10 Mar 2026 07:06:17 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <SY0P300MB0801E98F538F5320E7B663F0CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
References: <SY0P300MB08013E35DCA8FC31B0662125CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB0801C6F21C2D8F49892DF8E7CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB0801E98F538F5320E7B663F0CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 10 Mar 2026 07:06:17 -0700
X-Gm-Features: AaiRm50Ak2Buj5XBGB4ZoQRfQhDeUSkGwYt3vJ2yMqaVHZWraaFcbhJ5UdwoXkQ
Message-ID: <CAOLa=ZS=2msGg5d-6-LgVD6XSduYze46iWcT2X_dJDd=6AOOkA@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] help: move tty check for autocorrection to autocorrect.c
To: Jiamu Sun <39@barroit.sh>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="00000000000001b1f5064cac063b"

--00000000000001b1f5064cac063b
Content-Type: text/plain; charset="UTF-8"

Jiamu Sun <39@barroit.sh> writes:

> TTY checking is the autocorrect config parser's responsibility. It must
> ensure the parsed value is correct and reliable. Thus, move the check to
> autocorr_resolve_config().
>
> Signed-off-by: Jiamu Sun <39@barroit.sh>
> ---
> In parse_autocorrect() I kept the if/else if cascade. In my opinion,
> this is not a style change. It's a control-flow clarification, because
> those returns describe different states of the mode. Chaining them
> together is better than leaving them discrete.
>
> Also, I dropped the float cast in the delay calculation, which is
> redundant.
>
>  autocorrect.c | 50 +++++++++++++++++++++++++++++---------------------
>  autocorrect.h | 20 ++++++++++++++------
>  help.c        | 17 ++++++-----------
>  3 files changed, 49 insertions(+), 38 deletions(-)
>
> diff --git a/autocorrect.c b/autocorrect.c
> index 1037f032019b..50d7f116d85d 100644
> --- a/autocorrect.c
> +++ b/autocorrect.c
> @@ -6,7 +6,7 @@
>  #include "prompt.h"
>  #include "gettext.h"
>
> -static int parse_autocorrect(const char *value)
> +static enum autocorr_mode parse_autocorrect(const char *value)
>  {
>  	switch (git_parse_maybe_bool_text(value)) {
>  		case 1:
> @@ -19,41 +19,49 @@ static int parse_autocorrect(const char *value)
>
>  	if (!strcmp(value, "prompt"))
>  		return AUTOCORRECT_PROMPT;
> -	if (!strcmp(value, "never"))
> +	else if (!strcmp(value, "never"))
>  		return AUTOCORRECT_NEVER;
> -	if (!strcmp(value, "immediate"))
> +	else if (!strcmp(value, "immediate"))
>  		return AUTOCORRECT_IMMEDIATELY;
> -	if (!strcmp(value, "show"))
> +	else if (!strcmp(value, "show"))
>  		return AUTOCORRECT_SHOW;
> -
> -	return 0;
> +	else
> +		return AUTOCORRECT_DELAY;
>  }
>

Okay so since we introduce an enum we use that here.

>  void autocorr_resolve_config(const char *var, const char *value,
>  			     const struct config_context *ctx, void *data)
>  {
> -	int *out = data;
> +	struct autocorr *conf = data;
> +
> +	if (strcmp(var, "help.autocorrect"))
> +		return;
> +
> +	conf->mode = parse_autocorrect(value);
>
> -	if (!strcmp(var, "help.autocorrect")) {
> -		int v = parse_autocorrect(value);
> +	/*
> +	 * Disable autocorrection prompt in a non-interactive session.
> +	 */
> +	if (conf->mode == AUTOCORRECT_PROMPT && (!isatty(0) || !isatty(2)))
> +		conf->mode = AUTOCORRECT_NEVER;
>
> -		if (!v) {
> -			v = git_config_int(var, value, ctx->kvi);
> -			if (v < 0 || v == 1)
> -				v = AUTOCORRECT_IMMEDIATELY;
> -		}
> +	if (conf->mode == AUTOCORRECT_DELAY) {
> +		conf->delay = git_config_int(var, value, ctx->kvi);
>
> -		*out = v;
> +		if (!conf->delay)
> +			conf->mode = AUTOCORRECT_SHOW;
> +		else if (conf->delay <= 1)
> +			conf->mode = AUTOCORRECT_IMMEDIATELY;
>  	}
>  }
>
> -void autocorr_confirm(int autocorrect, const char *assumed)
> +void autocorr_confirm(struct autocorr *conf, const char *assumed)
>  {
> -	if (autocorrect == AUTOCORRECT_IMMEDIATELY) {
> +	if (conf->mode == AUTOCORRECT_IMMEDIATELY) {
>  		fprintf_ln(stderr,
>  			   _("Continuing under the assumption that you meant '%s'."),
>  			   assumed);
> -	} else if (autocorrect == AUTOCORRECT_PROMPT) {
> +	} else if (conf->mode == AUTOCORRECT_PROMPT) {
>  		char *answer;
>  		struct strbuf msg = STRBUF_INIT;
>
> @@ -63,10 +71,10 @@ void autocorr_confirm(int autocorrect, const char *assumed)
>
>  		if (!(starts_with(answer, "y") || starts_with(answer, "Y")))
>  			exit(1);
> -	} else {
> +	} else if (conf->mode == AUTOCORRECT_DELAY) {
>  		fprintf_ln(stderr,
>  			   _("Continuing in %0.1f seconds, assuming that you meant '%s'."),
> -			   (float)autocorrect / 10.0, assumed);
> -		sleep_millisec(autocorrect * 100);
> +			   conf->delay / 10.0, assumed);
> +		sleep_millisec(conf->delay * 100);
>  	}
>  }
> diff --git a/autocorrect.h b/autocorrect.h
> index 45609990c77e..ce4a68379f2f 100644
> --- a/autocorrect.h
> +++ b/autocorrect.h
> @@ -1,16 +1,24 @@
>  #ifndef AUTOCORRECT_H
>  #define AUTOCORRECT_H
>
> -#define AUTOCORRECT_SHOW (-4)
> -#define AUTOCORRECT_PROMPT (-3)
> -#define AUTOCORRECT_NEVER (-2)
> -#define AUTOCORRECT_IMMEDIATELY (-1)
> -
>  struct config_context;
>
> +enum autocorr_mode {
> +	AUTOCORRECT_SHOW,
> +	AUTOCORRECT_NEVER,
> +	AUTOCORRECT_PROMPT,
> +	AUTOCORRECT_IMMEDIATELY,
> +	AUTOCORRECT_DELAY,
> +};
> +
> +struct autocorr {
> +	enum autocorr_mode mode;
> +	int delay;
> +};
> +

I would say the naming doesn't indicate what it is used for. How about
'autocorrect_config'?

[snip]

--00000000000001b1f5064cac063b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: c0d327ad13a156b0_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1td0pWY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM0tsREFDRjlSTnVMNDFjSzdxY0pmT3R2Z2dvWENSTApyajJPZUtoREJJ
d29MYkxldkVYVHh3eG1sTVkzcHdSVjhvTENrUy9Wc0o2SW9rRzhMU2JuWHJiVjdtZUxxbXlyCnJF
T1Z0eFYyQTlpYmFxR1Y4YSszejduWHZDUXg5YTNWdjFVZk00RzZCSHJhNlR5V21XdFBXOElHUThX
MGp1eEkKcEtCSzJnYmhmMUZNWGR3eXBQTDhxNmVxZCtKcE1nN3JmdkFtQWJKZjRlSEptWkgxaE00
SWdZa1lyMmJMa1dEdAprVEk4OTJnR05MY1l3SDRNcWhXSHd1RmpoMUhwSGRINy9aNlJWWVJTZFN2
OUYvVHhMMHNoQTA4M2ZwWndXSXBYCnVMZDcxL21qKy9BSldnc2VLY3NseTBTcWsyYW44OFhyYm5M
ci9WQU5YckxXc09OdFpvMzQrS1ZHZUZPMmllWGMKemFWUVVWYTl4L24wYTRJYUR2OFBRVDZONllK
NEYyUnRWTG9sSXJpUWMzRzR5RG5SVWVwU09rRmN6WVl0ZFpjWApZWnk5ckRlWU1nTERjcCtFd1NF
M1FBcnlZcld5MkVsY3JmcHpkeWJqeU1TWTVSVWhWRmNMdjZEOWQzNncxTldnCjljVXFaZWdSWXRX
RXhkNldwaVB2NFdCRDJ6VThaRGo0R1F5c2JrVT0KPWpQMGEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000001b1f5064cac063b--
