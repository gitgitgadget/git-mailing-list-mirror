Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F9E264A86
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 14:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773152157; cv=pass; b=XL3/L4ygUl0QuM3GcAxxglB5s52mSgoDiffXkTWrJoRqJWNXmM7rPl+XzaoP3lg2qi7WQ129r6oNzObqRVyn/iDXkcr0DYLh/Bjqnq2wGsTXNDpfaugAbsAOzgO70j+CMlwUOVZ/hOXDqByJzwyazQOc0TAGhgv3SbLmyiuRVtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773152157; c=relaxed/simple;
	bh=5tP9VvPEQbai26KCRLjcgc5njyPCfsmQkfvg/3giIw8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KpIoPXo7bmIqlvN8+tlNQ/crkjtiFuqvv9DJD0T5YdI4oDJ8KrZVXJihf4+43VUpdJ3nB9OJ+YlzlBhxLO0ck53RznqO7z82nwmKGzf/jcGt5xVB4q9kMNYHKWDYv8O5t4pDhE3kC0x9DwfZ/WpkV94hDwTTkZu+YCIAIZI6Vxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJaL/n2K; arc=pass smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJaL/n2K"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-56b0cc3d395so2750984e0c.3
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 07:15:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773152155; cv=none;
        d=google.com; s=arc-20240605;
        b=GL0ZRe6zAkPj3XGojLSiCYFN0AKhlQMoJNx0zNOq0MI8YKbN4h+kB6eir9jjcDHOxG
         nrpMOT5C69ydNjt4an6RPWImomAvy++KIvCAMkW1UFg2cJST1alAmGIwSg3sWcFyKAo6
         cfFUsTLNS4PmNZVH/VmRMs0tGTgNnT/sreeueu0VYnlpsi1KHbJLT3wyobah8Iy7oK88
         vY1kyJ9vsI8laipnlJBywiZqoRCL6fZNTHJH3/zfYEjr3fO7yAoo89OfOAbyWPDvqY8n
         kRuW8EkFdeKM7IORoP91G9jUzdodyeZoyyklOrhnHnKSoYDmehnBCtQsbq2+F9j7vNkW
         BHHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=XDEeRpXnneLNdBRSfS9unM8kplPH9uXP5N+6+MT/rho=;
        fh=UQNcUNL/XGs2s14RxinMK1m5ZOJjp5WzRQu5eHKVsf0=;
        b=lvl6tOib93cxyNjyugR0wiecIcJcz7jSl8WzgZlCPbdXwGKW994UlNF+qCDXXwPTuS
         5uqT/T+8nGx6iYwhCJaubVuqzIYp14IKhO7UrJQqYp9j2MN89B6tt6/X+tibEHzUi0U4
         ShDT5tyfy+SDaKv/+UDGzwV8+dxtBjhjbCNtrLa0WDfVu4rajPPR62X3F9VZCZC9+h5L
         7kjBHOEAjRmapn1Px6f8C6ce0j/8yphiCLUh7gfQkYJeiA+fnT0Os+dX58ngwB2KYBeN
         xxr7GXIDVofo1pRxeDcegazUQFaJLJDaDsoBVCeskPeKZgQOxTZCyxk4v1MtfvUYI/y1
         TQ/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773152155; x=1773756955; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=XDEeRpXnneLNdBRSfS9unM8kplPH9uXP5N+6+MT/rho=;
        b=EJaL/n2K7ipcydcYlgTYXq9Oi018OviJicfUY/ckfDGM19chsw3eGZ2MaPVd0T9BMO
         cWN5Dm97Pwq/NLTFttPcrYlEo2wkut5KtX8SqrZ1BSfjN+2rk2uNxDgMK4Sgi4TJR+ln
         kYNGhWfDvkgvyV4mVWunpgyMHNv1nLbCA1eO65RKFOaPyWiTCgmwpgaSzI82xhrgDf7o
         wCDJgEFnOzl/lhbitnCWY2Cv0oED5m4yZt1KBBXf4FXerF37v5/WAUYyhJcNW2EocNIq
         sz4WXYr0vWmCSI7S03HRbClfw0Zl6WiEItFZiDXsS/YTHJLSoSXWVxKQZ3FEFLQ9zaoG
         5Fjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773152155; x=1773756955;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XDEeRpXnneLNdBRSfS9unM8kplPH9uXP5N+6+MT/rho=;
        b=VBjMVL5SeUd5SAWjgLkBOQwnPC+8e+bBZTntFUtDb2W9FHZ0GamIV6vSQFudOZPnmd
         5TsseDXgwQMEZshLxoNJl6cORF36lPz0kcFKptMIfRNv3ciJ/A+TfXE9KFmRs6n7//So
         cg5emmbm8RgVJlIPl4SiiKVnHqUq4IFTLFpkys4Q4vaQvQzjrsp4I7XD3wcWF5SwmIvr
         jx4E5rK9eQMK7LSKkCoIJuk46JAT4yZe//I+WJ+fCNcfh5vIMGGWedfaeUiaNK8cfMFt
         AXDtZ+ZBNA8oQT97d97HD8vbVcd5YOVqwHpVkH6k6WhxCRS2K5h34shIU2lunhmXlz06
         vMTQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5Frc7QbpC4YAnEf/rAc+WpFPO8mM1XjOFy760oYz6xkOZ3kHxGqpoGA5XupmIDTFStTM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2nf2ReIDvRJGhYdhe7A3oS3w5gxzKwATNB3TL/4G9eCA6L7ky
	qeAnpfrVz7yDC3LZ0EDWCheR+RTKp7g71MTz2pep7tV0IznTVRLIIh4VMY+EHVhjnpSDgeX5XXM
	3+BG5VEoNz3eFNGXYiKTUAvLZX3lk23E=
X-Gm-Gg: ATEYQzzGd88C8PpyPE1nJI9f89Ps3qkKz9G3QcNDW9dOPKjjW3YW1SYND/2Ae+k4uAk
	OIb35bte7qmzdtPydPB8UnHA7LAXvEJ6jvsiiN/jvBVVyA9fl+I3bnSWZy6hMJpOEqY0cn3+3XN
	cT2saG7P3W8KZTIP4hfDAkNUStBORnBhVM0mZh9ya9TS0Z88DVqyQ1LGADzWiqM1qxX+O9m5+s/
	9HA3PDFrmOFBEbosf6vDVyc2uwHKJO56N7FywYu9VENRiBQsggFt3Uw9NllcfW6kkimIdOkF8BJ
	AA6NLLO5JFbK2HW0ue8xbVZC8Vs4EACtU8Wdgd/i
X-Received: by 2002:a05:6122:29ce:b0:56a:f3f9:7e38 with SMTP id
 71dfb90a1353d-56b07d130aamr6507738e0c.3.1773152155151; Tue, 10 Mar 2026
 07:15:55 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 10 Mar 2026 07:15:53 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 10 Mar 2026 07:15:52 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <SY0P300MB08013A8A073C935934E1B4D7CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
References: <SY0P300MB08013E35DCA8FC31B0662125CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB0801C6F21C2D8F49892DF8E7CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB08013A8A073C935934E1B4D7CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 10 Mar 2026 07:15:52 -0700
X-Gm-Features: AaiRm52upNnbEa3_81flCXpWj6wXQYX4PnF1ZakUKEUc7U6QAoP4jQdb198g3e4
Message-ID: <CAOLa=ZSLRa1Jb4y=eu_jFeTH4id8CG1jjRGV9=1FKYat2JpQng@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] autocorrect: provide config resolution API
To: Jiamu Sun <39@barroit.sh>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="000000000000574718064cac289b"

--000000000000574718064cac289b
Content-Type: text/plain; charset="UTF-8"

Jiamu Sun <39@barroit.sh> writes:

> Add autocorr_resolve(). This resolves and populates the correct values
> for autocorrect config.
>
> Make autocorrect config callback internal. The API is meant to provide
> a high-level way to retrieve the config. Allowing access to the config
> callback from outside violates that intent.
>
> Additionally, in some cases, without access to the config callback, two
> config iterations cannot be merged into one, which can hurt performance.
> This is fine, as the code path that calls autocorr_resolve() is cold.
>
> Signed-off-by: Jiamu Sun <39@barroit.sh>
> ---
>  autocorrect.c | 15 ++++++++++++---
>  autocorrect.h |  5 +----
>  help.c        | 37 +++++++++++++++----------------------
>  3 files changed, 28 insertions(+), 29 deletions(-)
>
> diff --git a/autocorrect.c b/autocorrect.c
> index 9c4b691fb003..63fa331ef5e2 100644
> --- a/autocorrect.c
> +++ b/autocorrect.c
> @@ -1,3 +1,5 @@
> +#define USE_THE_REPOSITORY_VARIABLE
> +
>  #include "git-compat-util.h"
>  #include "autocorrect.h"
>  #include "config.h"
> @@ -29,13 +31,13 @@ static enum autocorr_mode parse_autocorrect(const char *value)
>  		return AUTOCORRECT_DELAY;
>  }
>
> -void autocorr_resolve_config(const char *var, const char *value,
> -			     const struct config_context *ctx, void *data)
> +static int resolve_autocorr(const char *var, const char *value,
> +			    const struct config_context *ctx, void *data)

So we made this an internal, the return type was changed as
`read_early_config()` expects that. Okay

[snip]

The rest of the code makes sense too

--000000000000574718064cac289b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b52c6a7e78e60167_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1td0o1Y1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1menVIREFDSWxtMXFxMld1QXc2djFYeTRTM1JmTjMvNQpiUEd2Sk01cm9q
Q08vY2VHeUcyYmY2N2pYay9LM0FIS0M2WWlNQ1VENHg0bm1qdTFOMENYU1gwVjVYUVYyMkM4ClhE
QldjTnRBU3c3cklOdDAzK2YybVE5MkFidU9XOVVNRmRkb2VGZEJlZTdkVFJkb3FtNGsrWWZSQklN
a3BLS3QKdUxVQ0NBSlp3RWhndEF1SHdXMzNiaC9JTkJCaTlISC9COXRscHJLNklRNVpzVmE1TkRm
enlSaWQwalZYaWJ1MApBTEJzVEFnZFZDRWpMT1NvSExiRWpMcjR6UUdqR0xXaGZRcUZIcm1vQzht
eXFUZmpkdzlMVVlWNnpSZ1NvK0RqCm0vN3F0ODlINmxFa3M0SFBXWHlzeEowVURNd3BsTHVVRGZI
Z0lKa3c0emE1V2I0L3BhOUpoSG41U3phTmU5MDkKTDlpbWxtOFY2WW9CZm0wd2Z0aVU1YUJBQkZ6
aDI4QVY5VWFMSmtRTE9HdEZCbnN4WkE5dFdFN093cnE2Uk5GZgpVclk3YmhmN1lmeWhEYVVmQ2NS
OWxQYTF1R3djSjZYRmtSL0hGMEhHME5QZnVjSjBFYU1mUE9lRFlrQkovdm1KCjRTb2tPakRrcWFy
alRULzBja21yTEVvclhvQ2lCdmhWVEtYWDgxQT0KPWhoSUwKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000574718064cac289b--
