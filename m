Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFCE3806C1
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 12:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773147182; cv=pass; b=ALd2GrCHRKLJ2qC2U8gRzl1uNGegVUAKpIHXNkDCCs+ypUgFJoI3k6QL0hZOnpeCUAQMnJ6zYpMP4pB+0xmEGV1BCmGhZMuyRYdUOWwrRCOsz+NHYT2donnN3n9dMF5wDkHQXgT7oIhdL7t+la+bvPId3DB60AaE9qT3jmrPdUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773147182; c=relaxed/simple;
	bh=eAGs9CE+EMqOv+sgs6stkhYL1yQ86vcYWPiNW5EtUCo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fsjGxFZuhfbCEU2KsgeXrFxFHBKLIqi+hS6SjLZnbqYXD/kdo1dUu8cQcX2a5gwzCkgTaJQIAPqnE6l8y6034g5V/QcRaC2oqAqeXE5BuFYHZz+zHSoSNFhm4Ow+6KSNeREbw7eLU42OF8iPnVhDTRL9L0MD8NhvJBYPhcQ51xc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ieyra9eJ; arc=pass smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ieyra9eJ"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-94de68feaf4so7735221241.0
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 05:53:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773147180; cv=none;
        d=google.com; s=arc-20240605;
        b=IgOlNVDESGIZgv379zrSHRStvq6jQ9mTmBrHv55+PGgUwJGXQHO5rC6QptX3aFz6j1
         g4O9Pz2kx/Dy2kXkiJwhZc8giQipEIOjMiTrPMN9/dClwJ1CEhbZl/nJXnrAH5RF+IBc
         4eJhPaMNM555kRlnVYFU4vPl5P5sqi/c330AetAwFJmdjcWkqANcQmiYGEUcVLNLjOeY
         A0/apEBZbvQ3tbGxOlU2g553uL5x9d/A8XU0W33I70l2D+pTSfoHEV/Q3lmYUqpUNubT
         YOO9c5A7KIOlHv5pbFhu1FCa+JzudR3xgYhZAgbyXZUkAVZo1Klmfvut6cRvjs7ECPQi
         yaTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=HItEtHhVT0wYZQcwpm9P1h46s8OpYyQ0+UrvbZYitt8=;
        fh=EcPyrNEdaG5z4YeGajhYGebNkLB3tTGT8R0rZKg3dJI=;
        b=JtDTATSp+yMSnn2nf8jeMpUw//eVpwzRW4aHTMH2Kcg9HuA9jhjLJ9xJyAz7Ueejmr
         nsHRvSZ6dFw5mC2aZCNczC0GM+GCmRT5CZshNe505xIPSqqf4q4yJExiJ75l1jzbyJyI
         bgKSftE4ugQzZevbwZ4oLmd9tHVjcFoQLzhb2WSLxPkCYYsHbOdNgxAAaETnhzraZnq1
         Hv6/Ue+qXwAxGAg6DOnPduPP5TuQPtpEjplYRmdCouboxSimHVGVGdc41hKi/ooz/FDC
         QciiOH07IV83/IzOcBI78VL66aQbB7Dm8+l46mJ0b4SzM5zlchb24/EZzbggL/F++og/
         NWhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773147180; x=1773751980; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=HItEtHhVT0wYZQcwpm9P1h46s8OpYyQ0+UrvbZYitt8=;
        b=Ieyra9eJIZl+ODlEb0Qqe3sVUB3xrodDVuCUb3Pfox6EHTymXeuHkPrUR3VrvV6WQc
         Y3kwrOslHiEHqcO9ySbjkEhsrMG4yUli4M4mY/FvjdAWPZvJcIW4t/Q0Efyl/bzk0wd/
         DPgvgDJ//fu0AUpw0GL7c1ZahTvacQfgnkRAZ+hiDkWWgG4DQS8c7Ei/6fjiYsKq931t
         tRpvz2QVh9QMzc7PFFJS/Pgx/wBm56sCPs/PeK2GAKDcPNQ4rBLdH3HoraD+qSekf3Hj
         QUtgaTK4Sjc7LOZ0LzfR1CvK4KmIqTl3wIcifTfuFPaPYGFlDZRY7U2rt4UogajdoPif
         5eZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773147180; x=1773751980;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HItEtHhVT0wYZQcwpm9P1h46s8OpYyQ0+UrvbZYitt8=;
        b=jyca5gIYW12S4shMt8mKIlxcfapzWM8l0w0xvkvMHZPub4XCHDbrazUYEj9SyD70Jg
         HXPcOFgWvPf0yuylYo76BHh0kvN6sbAwO+m6JAd+Hnu0wcH6HVHAXafh+4zLVbtIk/z4
         iwX2FRHQb2IXTm8pd5lkEXOIV4TL4mFU1ff8agiYlUsmeXyTUe2U5oaPuoNaSzQhIE/A
         H8/Auk8Jf2t3UcW/T4laiIYVQTaM4MhiSaR+Oz7RBnxM3jgmc6hvW42hOzpQE5/GKLwR
         4LLMywf1zh74NLyU4xvMCQQdtKMpooL4OvXb8jjgV8QgCLzYlVJpKoGkoNE/+Q3firdO
         qlnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzoQ9c9W8w4Hyt4KaIjCAzgm7QSxqCFhgi2fk3SBY/NlKYGuXHKwUdrY6jgYfpV3OxVTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGa0dqMGRt87VNpGlDDWJpRDPPRGJoKcOPTpWt4NTNiWPes1ON
	i7SBw1viFv88M9wFGB3EQ97O7NyqTZV2plaj4eAiE7R2JBvrt8M8EPLb2+zELzMAixLj3wN4C4a
	CJRVAn/FgIeUi3W8ICju7JzB7p7w/ssg=
X-Gm-Gg: ATEYQzzqzSQtsGj1C+m5qZTJIA/XVxjTXK8PYiuLFNSQllMCp42aaDJwmU9xPbJ3XbE
	zFFdr7fMzbkzdGNJhfTjrfNQAILIUVXw9tbF8jY0iG6CkX2Aa8YgThFbvyHgFQ3W6M+OanQiEn2
	kZb439qD/CytPpzvNKufi81AMb7qSp1wblQKvgecIZbZviMzQdTewIugfAQiMCmA8Asvpg/y8aS
	PmjmaxRFWuolzWqJpoZBYOjNw8/YDWEGg+AFH1iuHIB/S+aC/yU3d1P0pbt3pf9+Ncg3LXKbEFB
	W/jwbqS25h0LQ39lKnkCKudVcYHJFfIMhvE2YAQ44w==
X-Received: by 2002:a05:6102:2914:b0:5ff:e58d:4df4 with SMTP id
 ada2fe7eead31-5ffe5fd67b3mr5860675137.17.1773147179619; Tue, 10 Mar 2026
 05:52:59 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 10 Mar 2026 05:52:58 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 10 Mar 2026 05:52:58 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <SY0P300MB08017404C417D02058423130CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
References: <SY0P300MB08013E35DCA8FC31B0662125CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB0801C6F21C2D8F49892DF8E7CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB08017404C417D02058423130CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 10 Mar 2026 05:52:58 -0700
X-Gm-Features: AaiRm523UJIRjeKZv_iWRPVGVFl86CWno6EUOeaHBBLFKXweI6f21aHkXVrYl58
Message-ID: <CAOLa=ZQypadiSnU1hqHBUzzayGvvvv0z-X+-vNJRFgREmdB+qg@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] help: make autocorrect handling reusable
To: Jiamu Sun <39@barroit.sh>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="000000000000c6eee8064caaffa1"

--000000000000c6eee8064caaffa1
Content-Type: text/plain; charset="UTF-8"

Jiamu Sun <39@barroit.sh> writes:

> Move config parsing and prompt/delay handling into autocorrect.c and
> expose them in autocorrect.h. This makes autocorrect reusable regardless
> of which target links against it.
>
> Signed-off-by: Jiamu Sun <39@barroit.sh>
> ---
> This patch moves autocorrect handling out of help.c as a preparatory
> step for subcommand autocorrection.
>
> This is necessary because help.c uses load_builtin_commands(), which is
> provided by git.o. Executables that do not link against git.o, such as
> git-daemon, will hit a link error if they use symbols defined in help.o.
> A simple and clean fix is to make the relevant functions independent of
> help.c and move them to a dedicated file.
>
> Changes in v3:
>   - Split patch so diffs don't get hidden by code movement
>
>  Makefile      |  1 +
>  autocorrect.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  autocorrect.h | 16 ++++++++++++
>  help.c        | 64 +++------------------------------------------
>  4 files changed, 93 insertions(+), 60 deletions(-)
>  create mode 100644 autocorrect.c
>  create mode 100644 autocorrect.h
>

This should also be added to meson.build.

[snip]

> diff --git a/autocorrect.h b/autocorrect.h
> new file mode 100644
> index 000000000000..45609990c77e
> --- /dev/null
> +++ b/autocorrect.h
> @@ -0,0 +1,16 @@
> +#ifndef AUTOCORRECT_H
> +#define AUTOCORRECT_H
> +
> +#define AUTOCORRECT_SHOW (-4)
> +#define AUTOCORRECT_PROMPT (-3)
> +#define AUTOCORRECT_NEVER (-2)
> +#define AUTOCORRECT_IMMEDIATELY (-1)
> +
> +struct config_context;
> +
> +void autocorr_resolve_config(const char *var, const char *value,
> +			     const struct config_context *ctx, void *data);
> +
> +void autocorr_confirm(int autocorr, const char *assumed);
> +

Why not use s/autocorr/autocorrect/ ? Also would be nice to add some
documentation about each of the functions here.

[snip]

Also got this from running `git-clang-format` on this commit. Generally
applying changes while moving code makes it harder to review. But here
the changes are small enough that we could get away with it. I'll leave
it to you.

diff --git a/autocorrect.c b/autocorrect.c
index 1037f03201..87351fd08f 100644
--- a/autocorrect.c
+++ b/autocorrect.c
@@ -9,12 +9,12 @@
 static int parse_autocorrect(const char *value)
 {
 	switch (git_parse_maybe_bool_text(value)) {
-		case 1:
-			return AUTOCORRECT_IMMEDIATELY;
-		case 0:
-			return AUTOCORRECT_SHOW;
-		default: /* other random text */
-			break;
+	case 1:
+		return AUTOCORRECT_IMMEDIATELY;
+	case 0:
+		return AUTOCORRECT_SHOW;
+	default: /* other random text */
+		break;
 	}

 	if (!strcmp(value, "prompt"))
diff --git a/autocorrect.h b/autocorrect.h
index 45609990c7..38f1e73131 100644
--- a/autocorrect.h
+++ b/autocorrect.h
@@ -1,9 +1,9 @@
 #ifndef AUTOCORRECT_H
 #define AUTOCORRECT_H

-#define AUTOCORRECT_SHOW (-4)
-#define AUTOCORRECT_PROMPT (-3)
-#define AUTOCORRECT_NEVER (-2)
+#define AUTOCORRECT_SHOW	(-4)
+#define AUTOCORRECT_PROMPT	(-3)
+#define AUTOCORRECT_NEVER	(-2)
 #define AUTOCORRECT_IMMEDIATELY (-1)

 struct config_context;

--000000000000c6eee8064caaffa1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 952fa51122a9d309_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1td0ZDZ1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNzRGREFDYm1HVDBsMDVuRmtFMTF2NEVSUFRSaUhicAp1QlNxOUFPVTVD
T3hOTTQ4ZUNtcklQT3FLK0JVUG9abWh2dEdYME5DZ3F2Q0dmNmVUVTFKVHZZTTAwYVI0ZHpwCk1S
WEQ3bmxUVmJtM2R1bm5xckx4WHlBVnFLbEFaWWJNS2dYSkVDZGtxTHpBdnlVazJGZjV2cFFiU202
SURTTGMKOHppRHVPUll4S2V6T0VtSmx2WVRqa0dxdkJkZlFuMGc3ZlFxRTZuTWtBbnlqQUxHNDJV
R1NWNW1kR3d3eUg3WQpDcmpobVIyNkZXVDJEaVpOT1hFWjVXYll6aUdKQ3FVYjRETHpoQWxXZXJB
RmVkdHVFMzZaQS9GbHNMKzI3VXBXCm1qRkpXaTlhd3ZTZVUrY0FhNmIySjM0emRCUmpJTFU2SG5m
M1liMjhZcGlKV2RNbyt1L1lFZTZkdUg5WXR0bloKemtDMEIwaGltSGpYU2QxUTFkUFdZQm8vZDR1
ZFg3c2VtUFdCS3dnVHIzVEttNzQ2Q3ZNbUlQNTk3V0NLQTA1bApZT0xhbDV5di8rSWdVVy9jcE5t
Vm4xakJEbVlyNnMxMkNRekoreEF0c092QmpSeEd5cHZncGZJQ3JJdkVDeWZ4CldvVStMMGxkWVIz
dVVpV040alVFdnJtWjZ4ZzdMKzJTc29xaXBWcz0KPVRlNEIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000c6eee8064caaffa1--
