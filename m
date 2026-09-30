Received: from mail-ua2-f43.google.com (mail-ua2-f43.google.com [74.125.226.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2D74915B9
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 11:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.226.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790768830; cv=pass; b=iBFLhZB/3XCBAR+PidfqQd9tH6RFI65V1IxglNBkbDKifl+V57TUAFaT9vJPuwPYk8cJwZpFzAGUs9B1MOUbTNb4xnpDLqo2hiutOlUXpfb0SY92D8P2AbmN4kqqHgW14Je5MvCyGuxCjcTv/IxKI760PfuP4qsUcef3MSe5CsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790768830; c=relaxed/simple;
	bh=X+V2xQhwkusL6cTBeiiLTPvO6JOMqW9wv2h2g35aW7g=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jodMYFsTKF17MgPVBXCMoizWiMvW5rfDW/DrNoGk1laeom+nyorB8dy9MZNyZtviQzqI4XgeHTKu4msqoVBzK4b189kn+46fKt5J8h0nxJFHILjG6xLwRUTXevruQOLqh5zz87E51PvfX4KHd/XxJlOEdEt+aNOw7hHUDsDNlwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OXnEun7E; arc=pass smtp.client-ip=74.125.226.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXnEun7E"
Received: by mail-ua2-f43.google.com with SMTP id a1e0cc1a2514c-988c446fa9dso435915241.3
        for <git@vger.kernel.org>; Wed, 30 Sep 2026 04:47:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790768825; cv=none;
        d=google.com; s=arc-20260327;
        b=MSFfCPx74zMQVr3lr3el3vZUxfO3nBeRjnMReKOlFMiRb2ZxCGgf6Ef0wxwuGC0uX9
         +19lANtMIMCa3HIR9RvDCPriBNQbpyN+3hBi62r8+IaUJMv8fKV5A8SeN1Kn5+3i0CT1
         tjuhfExY4+ItrJN66uFNFDzUAFdfD2nhL8CBG8yhNEzzybvbj7yoMxMJ43o3JcsmXYlR
         IybtAjUEdapbSJAzWga+knMhP6Jwc2KfSY94F5m6tIw9Yf37g5iHZJ7WNd3f+oNgdnkj
         4fjarg4VICZpbqE4PLED4B4kujexohfL0mZquxEpkKLi67QUX2/plVj+qDGcvpijF+4n
         tWrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=NKSlMAlMPOj/iXAFale8cik9ZukLvkk9htI3r/xJM2U=;
        fh=qHrGj+CLAb61EKe8BtzFdapg+yCfir2rU15+JWAR9ss=;
        b=IIkQDSldhUf/22uuebxa73XA137t+qf+xan0cKz3IA1EwzpqjPPgovCt97R4fUltEp
         ZvKV8ALr6ZCAFNQ3SEQm/ZDPqbzc6hNcNMd4zI2hYEYvb1vg6l6Jw8g6GFb08i1GPFXd
         o6t9ZsYXN8p4Dtj5YWLv2DvLL0lbaK3rPD+Re2DpV80x8gYTmISnkaxQ9M5r0BR342Ip
         EMuR3N0B6DZbFsjBksX8+d9pt3BhBTkYUm5cEt9mulbKRfEeyA/JVL9jyxMCzmJc4bzy
         G+FvP4fZuaH+sMSp4ibHxeiImynb5I9LVmpyTf2IC8+W29OytwNVkQkPIGKA8LIvSrsA
         +FCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790768825; x=1791373625; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NKSlMAlMPOj/iXAFale8cik9ZukLvkk9htI3r/xJM2U=;
        b=OXnEun7Ei2RiIEBxawHgp6+NeRJs/ELOf5+dj7+xVSlrcyN4R3ZRonyBKCtpajp/v3
         XymQ6Aff0aa2tzZGgo/eaWFT2YKpx90I7hT4sB+Osae2Sywt6xgIwczNSrQ8nmdZQ8mP
         3P04u+DcXQ5Lx64EneDp7+6TGBTUxYb843TNw1sH5I9x07YYt7t7YelpWkm9xxxMMtja
         pMj3mnAHu0xVV511BfbogsmaeF/QitHm+JAQaM8egb0ToN935Z78uJgKmrdNyc2XtCfO
         yoRDYodzbstJbjyPVHtpRMV5BQo2IdlZzqsohuirYBrOH5TRE6K665d8RA8KOU1yoFxj
         ZdRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790768825; x=1791373625;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NKSlMAlMPOj/iXAFale8cik9ZukLvkk9htI3r/xJM2U=;
        b=1fIAlOqe0VitLBeyWAWQ0ZEycAXRBcfVG2I9jzG77/ipv838EMneI/56X994Wd4Yy1
         6IaGJ1ULnZXnfSaFX68G1d/nCK21nqTcXBvOB8JF5SpKjzuvs5zAUvfis1Kk3Kj+dJJs
         8/a17EeD2AJ1MrvRGI9KxK14SjJWfl+D5vemTBVTcLshC/ofJNbsq7TnqzEO+yWNhZtm
         Go79IPEcJDrm29fhoudJuE6RUihx05ODrIdWJte3XHGuvURh4KNjjc0/oYGoS/LmZzdn
         MDbkFbObVwR/B16uYlfNOID0eqOAg6DCgGppTS3ehGQL3PJejNXnVWfQwZq9EnoACF9r
         GZRA==
X-Forwarded-Encrypted: i=1; AKwUvBwNYNbkY0kCS2BU2+R5BNeuw4GLuApT5+IfHEo0M07+NFLlc7JUsrNIToZ/hGDSHfIFbj4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLlz3y5v4nvVYLXgOP+ChNOsfzoZZMgkQ32FvhhCQ6BrEt9eHhV
	7mponexr2QfuSvkHIxw61L/x+s1uh1C2LVy73iOCMGEwzjGaSMp6QqDa7hAPRZhW86Ne6qfNWHR
	4YVJ/mkl8PAO42fFEiQeOxdQBaFre3oWFIQ==
X-Gm-Gg: AYBFou17sJsNfjuVWtRZYbuu0J8B2PboyaaXO3JFNh0kKZ3gFMNaP3AwBouTBtRSAVL
	qyBlCCyFzL6gIBoDFvN+/LcayeU1GNpLZG0PW3MbLC7y+UVwhHaI4V3LFUgEUfOAAXiiSKGURJg
	P3SoWDmJRKsLNI2eNphnm/DNHg8mLM8ibEssrwDLy++8bMHYzo6n2FMz47lS8dqFuFQ5YQ9mIzs
	+T89RCCdGKTUt2W4MHWKIRrtty5zjPl8SHn60N+nr/6UMOblN4EwI9+EXoWNiyXn4+/3u5WU5dX
	efdQfihUEgkyua+obdozuQyzCd107hD/A1J53i206K/V+JgJzjZ1DV1FwRPtjBYXqy7zpNukkXg
	rlVm/zbhJ90LrAggc001giG3gATzNmkHJIhIP0pF/IVgh0w==
X-Received: by 2002:a05:6102:5122:b0:7a6:d11b:16ea with SMTP id
 ada2fe7eead31-7be726b8973mr154422137.6.1790768825484; Wed, 30 Sep 2026
 04:47:05 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 30 Sep 2026 04:47:02 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 30 Sep 2026 04:47:02 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260929-pks-reftables-fix-timezone-format-v1-1-3df105a95ed1@pks.im>
References: <20260929-pks-reftables-fix-timezone-format-v1-0-3df105a95ed1@pks.im>
 <20260929-pks-reftables-fix-timezone-format-v1-1-3df105a95ed1@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 30 Sep 2026 04:47:02 -0700
X-Gm-Features: AclHuK_kNhv3p9lyhC2M7zpMn0DfWLKJsJpN_O5CpDoXQ90qKXo1WGzx1aYPENU
Message-ID: <CAOLa=ZQRDVL2Djh4du1zWGg_ABZTyzaWDYYb0PDg3EXAfpn7bA@mail.gmail.com>
Subject: Re: [PATCH 1/3] date: add helpers to convert between "+HHMM"
 timezones and minutes
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Josh McKinney <git-bugs@lists.joshka.net>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="000000000000b7ea76065cb1db70"

--000000000000b7ea76065cb1db70
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The timezones that we store in commits as part of the identity
> information are encoded in "[+-]HHMM", for example "-0700" for UTC-7.
> Internally we typically pass around this timezone either as string or as
> a parsed integer (-700).
>
> Some sites want to convert between this format and minutes or vice
> versa, and that conversion is performed ad-hoc. We're about to introduce
> another site though that wants to have access to this logic, and having
> it cluttered across our codebase is a bit awkward.
>
> Introduce two new helpers `tz_to_minutes()` and `minutes_to_tz()` that
> perform the conversion for us and convert call sites to use them.
>
> Note that we used to perform a dance in `gm_time_t()` where we first
> convert `tz` into a positive value, then calculate the minutes, and
> finally turn the minutes into a negative value again. This dance is
> performed because it is implementation-defined in C89 whether the
> division on negative values truncates towards zero or not [1]:
>
>   If either operand is negative, whether the result of the / operator is
>   the largest integer less than the algebraic quotient or the smallest
>   integer greater than the algebraic quotient is implementation-defined,
>   as is the sign of the result of the % operator.
>
> So under C89, `-130 / 100` could legitimately result in -1 or -2, and
> `-130 % 100` could result in either -30 or 70. For us though, the result
> that we want is the first one (-1 and -30), which is called truncation
> toward zero.
>

We divide by '100' because we represent "-0700" as '-700' in integer. So
we need to separate out the 'HH' from 'MM'. Okay.

> This part of the C language has changed in C99, where this edge case is
> now well-defined to always truncate towards zero [2]:
>
>   When integers are divided, the result of the / operator is the
>   algebraic quotient with any fractional part discarded.90) If the
>   quotient a/b is representable, the expression (a/b)*b + a%b shall
>   equal a.
>
>   90) This is often called ''truncation toward zero''.
>
> So in theory it's unlikely that we still need this logic. In practice
> though it feels safer to just retain it as we don't require a fully
> C99-compliant compiler in Git.
>
> [1]: https://port70.net/~nsz/c/c89/c89-draft.html#3.3.5
> [2]: https://port70.net/~nsz/c/c99/n1256.html#6.5.5p6
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  apply.c  |  3 ++-
>  date.c   | 25 +++++++++++++++++--------
>  date.h   |  9 +++++++++
>  strbuf.c |  3 +--
>  4 files changed, 29 insertions(+), 11 deletions(-)
>
> diff --git a/apply.c b/apply.c
> index f00b7ba4d3..367271b8ac 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -14,6 +14,7 @@
>  #include "abspath.h"
>  #include "base85.h"
>  #include "config.h"
> +#include "date.h"
>  #include "odb.h"
>  #include "delta.h"
>  #include "diff.h"
> @@ -851,7 +852,7 @@ static int has_epoch_timestamp(const char *nameline)
>  	if (*colon == ':')
>  		zoneoffset = zoneoffset * 60 + strtol(colon + 1, NULL, 10);
>  	else
> -		zoneoffset = (zoneoffset / 100) * 60 + (zoneoffset % 100);
> +		zoneoffset = tz_to_minutes(zoneoffset);
>  	if (timestamp[m[3].rm_so] == '-')
>  		zoneoffset = -zoneoffset;
>
> diff --git a/date.c b/date.c
> index 014065b419..63ea9dbc76 100644
> --- a/date.c
> +++ b/date.c
> @@ -45,13 +45,23 @@ static const char *weekday_names[] = {
>  	"Sundays", "Mondays", "Tuesdays", "Wednesdays", "Thursdays", "Fridays", "Saturdays"
>  };
>
> -static time_t gm_time_t(timestamp_t time, int tz)
> +int tz_to_minutes(int tz)
>  {
> -	int minutes;
> +	int minutes = tz < 0 ? -tz : tz;

This is the part which we could skip as we're C99 compliant, but keeping
to be on the safe side.

> +	minutes = (minutes / 100) * 60 + (minutes % 100);
> +	return tz < 0 ? -minutes : minutes;
> +}
>
> -	minutes = tz < 0 ? -tz : tz;
> -	minutes = (minutes / 100)*60 + (minutes % 100);
> -	minutes = tz < 0 ? -minutes : minutes;
> +int minutes_to_tz(int minutes)
> +{
> +	int tz = minutes < 0 ? -minutes : minutes;
> +	tz = (tz / 60) * 100 + (tz % 60);
> +	return minutes < 0 ? -tz : tz;
> +}
> +
> +static time_t gm_time_t(timestamp_t time, int tz)
> +{
> +	int minutes = tz_to_minutes(tz);
>
>  	if (minutes > 0) {
>  		if (unsigned_add_overflows(time, minutes * 60))
> @@ -103,8 +113,7 @@ static int local_time_tzoffset(time_t t, struct tm *tm)
>  		offset = t_local - t;
>  	}
>  	offset /= 60; /* in minutes */
> -	offset = (offset % 60) + ((offset / 60) * 100);
> -	return offset * eastwest;
> +	return minutes_to_tz(offset * eastwest);

While mathematically it's the same, but shouldn't this have been
`minutes_to_tz(offset) * eastwest`?

>  }
>
>  /*
> @@ -862,7 +871,7 @@ static int match_object_header_date(const char *date, timestamp_t *timestamp, in
>  	ofs = strtol(date, &end, 10);
>  	if ((*end != '\0' && (*end != '\n')) || end != date + 4)
>  		return -1;
> -	ofs = (ofs / 100) * 60 + (ofs % 100);
> +	ofs = tz_to_minutes(ofs);
>  	if (date[-1] == '-')
>  		ofs = -ofs;
>  	*timestamp = stamp;
> diff --git a/date.h b/date.h
> index 0747864fd7..816df5b833 100644
> --- a/date.h
> +++ b/date.h
> @@ -70,4 +70,13 @@ void datestamp(struct strbuf *out);
>  timestamp_t approxidate_careful(const char *, int *);
>  int date_overflows(timestamp_t date);
>  time_t tm_to_time_t(const struct tm *tm);
> +
> +/**
> + * Convert between the "[+-]HHMM" timezone format and minutes. This format is
> + * used for example as part of commit headers and reflogs. For example, the
> + * timezone -0100 is converted to -60 minutes.
> + */
> +int tz_to_minutes(int tz);
> +int minutes_to_tz(int minutes);
> +
>  #endif
> diff --git a/strbuf.c b/strbuf.c
> index 44955669e8..c3baa47b3f 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -1023,8 +1023,7 @@ void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm,
>  		else if (skip_prefix(fmt, "s", &fmt))
>  			strbuf_addf(&munged_fmt, "%"PRItime,
>  				    (timestamp_t)tm_to_time_t(tm) -
> -				    3600 * (tz_offset / 100) -
> -				    60 * (tz_offset % 100));
> +				    60 * tz_to_minutes(tz_offset));
>  		else if (skip_prefix(fmt, "z", &fmt))
>  			strbuf_addf(&munged_fmt, "%+05d", tz_offset);
>  		else if (suppress_tz_name && skip_prefix(fmt, "Z", &fmt))
>
> --
> 2.56.0.rc2.329.gd58861e689.dirty

The rest looks good.

--000000000000b7ea76065cb1db70
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 515ce232aa6fbde7_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xODlyVVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK0x6REFDZTk4MElOcTBQbVBDVUNoZHpreFhZZjBuMgp6STg2YXJqcm1J
NHpDNDZzY0ZGTm5aQmJQRGpXK1pQUVlCd0JGd2VtM1RQdnVyYU9ma1NnTnh2UzhMUCtheC95CnhC
bjFES0xGMXhTMUljOVJ0VU1BRU9KdUh6OTNWMGNrQXZ4blA4UiszemhWN21YenBML0VDK1FiekEy
cE01YXIKcnFONnB0ekU4Sm1ONkVsb2MyY3ZFbEJsc1k2STlNeURHeWJyZnc5a3NnVndXYldPS2do
L2RxbnQ3VHBibUFiKwp0akZwRDZqeVVvMFFKbEdWcE1iVFhuV2lwcHYrRFFUMjd3d0pwQ0VGT2h3
RFg4UnBwMGE3YVJzV205OXNFVVM3CmpMdjJzYTFhUHQ4QWRReldlYnlFK1JweFlXR2ZUcjVJZGs1
dm0wdVZvaGduTXN4MUh5RHhCdXYzbnNjSGNOdC8KbFNhRm4vcDJKVnYzNWhHWnBvM2d0cEcxdVRQ
dXJpM2YrUEZVbUZTSmQxYkVIb3VqcFpiUERNdy9oTW1OVGU2cQpRSUJ1c3RtOUlYb1R0YzhFY1Bq
U0tMR09GK2ZFQk03U2dKQ0cxcFNvOWxyZFZaWDNnSkZBZjl4bkhCNGRsbXpsCnBFdHBHOCtwbHV6
Zm04VzZOTDUxN0F3YldBY1BlOHRFT3ZyaGZlOD0KPTVyakcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000b7ea76065cb1db70--
