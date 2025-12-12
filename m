Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD102FB63D
	for <git@vger.kernel.org>; Fri, 12 Dec 2025 16:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765557994; cv=none; b=isb/cYzrwoYEz7pzejFBjK8lt3aAFZFo/9ELOOKEeHbBfl7+HTpxF5HiJ2ysqBGBrGI2GZGVJbFDQkCn/NH8OtlAzzZstktQT63a+DFq9hwiKCbyB+8G2ttKlvCynusJ9OcoJc1pjB95Z8P8gAWsFGtW2tTj8eeJhqx1KD4BLnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765557994; c=relaxed/simple;
	bh=itMESI1ctEEkRk/NVk1zqlzpmiMqGmmMb0cTKsQlM9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYjfSjxXzVZsi0nQrrufqXmpWT+wUVysPGetmaI/u9BleVSe2Z/1uKjBKrScp2gYbDOn048xCgXxarkX5SLxIOmbRENSkmV2msS8RnWvLVvTIzL2i6fFv0RhG0gaIdz+aU8jm+LMad/ZqOSW+rjLvINtt3JIMgwYwM0aGcNGHgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ASfnVTcF; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASfnVTcF"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-3e12fd71984so1033890fac.2
        for <git@vger.kernel.org>; Fri, 12 Dec 2025 08:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765557992; x=1766162792; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=022Twa6Ng9hGnd9WO1/fWl1rJGSb8H+dG6W33bkSLjw=;
        b=ASfnVTcFLmN0WPlE1uCeK955RYAHDwuNPDiPZPGQYPHuwq7mCYo0YKTsy6E5NqQSQG
         2vNulEnhpyD6t8NE+CKbt5EMPZ1/JJTOs+G9KU0TOSOnXVsFSrtrDePIc+gUaHr6M+CR
         CGhSi0YxIrwSHZlTL/SgsUfvuL+Ys7Pwe0SVwBQ5d73CaoG/aFBrNcyVkBjwE07hRwPk
         bHSwuJxMWiAAREQySoHO1mGO+x/VBrf+QcbLEv1pcF85YBedPVRL0gdLep9hYm+IrR/u
         HnjBzCjunYJWrxjUIlpQIqqRTrLwYL0QVA8WavXUmjOZaoSP0FHyTkettVYBEbUFeCS4
         UF/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765557992; x=1766162792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=022Twa6Ng9hGnd9WO1/fWl1rJGSb8H+dG6W33bkSLjw=;
        b=VajnNqTmePY9LevuYwBBbQm21aHPzNDd6yGf1hVSXHgvQjyM8gB62fMbBtm1DRPlkn
         C3kJ5D2f6rx1YYmdZ8EJr1RyXRgnP9E/iqDUpYimUOmtOBv4zFy8scP+Mu8bNtWZBE9C
         ZhqjQ/c4sKFahG2GveV+/+t7fGQgHe3F8tSzDnArBc7fjzxcVyCqe7qNBKnz5lOyULhm
         i+IKT5E60E06a/lYF9iZYPKt5O+Nfk6rEPhxiR8Snjye/uNpTRgCk0raQRqTD1MAO+0J
         R6aRjA95AQRd98qkZ01/nKOT+Qj/dfUHiR1eX+hiNaI6MIfIjxK5sqO4ZsC6VTZEnkyd
         HubQ==
X-Forwarded-Encrypted: i=1; AJvYcCX14uTmGU3lNDfIL57cDgtk+pVrMoTRuI9AI2vwMcTH4J4+VwriYp9OyWDqkYOuunWR/+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIDQKYWiEX2G2FILlgUYWOioJc4CVCvTQvkUcBeZd2Sqq5V3qD
	BP5Ktz/V6avhMgIvZoFPrbb0ekVx4tHSN9Linrvb7+RoxJ/3hMrqV5KTv9Y3/Q==
X-Gm-Gg: AY/fxX7VxdkF5QuxirG1Jspj78jQJlR/wEo4wdL/z6CK8tgWb+MtGzUxr+3OsRiPxXZ
	jDdwfPNZxSjq1VA0y/SysXRhtRFxPrmhCeFGJzZurZQl4tU9jtMZ4uYqMVsNtsq73BeKcy0ZhW8
	y0QBROVyN2pZd/PQBhULFa2w4IEWcrh6m1B9lsEP7f20l4Bp1ctX6GwjaCym512sWyI8bQYvgG/
	Xjjb0ikTWn+9OEF3BtgrDiAL0YsgzJZJwMLTDR9o/KTjGgadUx/08Y91+EDzyhCYyIIEXYGShv/
	5Wy2aG4okex1GawoupluI5meetPcfnzH+L1QIS9GVn7XvZSMW/jJqonSgf2DQb78UbpamX84fag
	elP4KqcNDs5zg4f3D1+7idFEOokG8InGKBLyh8IJw1iM3vp01pqiYApfmh72ifMPmEkvryudkOS
	wYkP7TfuVuCVmibmE=
X-Google-Smtp-Source: AGHT+IGMk7PUB+RMwCuGGtzEUM2RP/BZ109bSGSWGUGycrVoLwh2Xz7dOiqqQMFroyqa4JQnZXNL6w==
X-Received: by 2002:a05:6820:1c89:b0:659:9a49:9008 with SMTP id 006d021491bc7-65b45257edcmr1240894eaf.53.1765557992126;
        Fri, 12 Dec 2025 08:46:32 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65b360ef040sm3121626eaf.13.2025.12.12.08.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 08:46:31 -0800 (PST)
Date: Fri, 12 Dec 2025 10:46:28 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 2/6] builtin/repo: humanise count values in structure
 output
Message-ID: <epw5bctnxs7gpcg733qqtf2jxmsknntuylbqxt3xngs5zj7htn@zltxezklckge>
References: <20251209225820.2861276-1-jltobler@gmail.com>
 <20251209225820.2861276-3-jltobler@gmail.com>
 <aTkS_kBlNsnbPyP5@pks.im>
 <kf7vavs5yetooe6u2ygttzfriul4u5ywdnhtyksh2pbar4mpfz@orlg7ppajd7s>
 <xmqq1pl1hgj4.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1pl1hgj4.fsf@gitster.g>

On 25/12/11 11:57AM, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > On 25/12/10 07:28AM, Patrick Steinhardt wrote:
> >> On Tue, Dec 09, 2025 at 04:58:16PM -0600, Justin Tobler wrote:
> >> > diff --git a/builtin/repo.c b/builtin/repo.c
> >> > index a69699857a..8fb728b3a5 100644
> >> > --- a/builtin/repo.c
> >> > +++ b/builtin/repo.c
> >> > @@ -266,6 +275,10 @@ static void stats_table_addf(struct stats_table *table, const char *format, ...)
> >> >  	va_end(ap);
> >> >  }
> >> >  
> >> > +static const char *unit_k = "k";
> >> > +static const char *unit_M = "M";
> >> > +static const char *unit_G = "G";
> >> > +
> >> >  static void stats_table_count_addf(struct stats_table *table, size_t value,
> >> >  				   const char *format, ...)
> >> >  {
> >> 
> >> I would assume that these units should be translatable.
> >
> > Ya, you are right. I'll make units translatable in the next version.
> 
> Whatever you do, please first consider reusing existing
> "human-readable numbers" helpers, like strbuf_humanise_bytes() used
> by the progress.c for showing throughput, before rolling your own
> variant like the above.

Ya, I originally looked into using strbuf_humanise_bytes(), but went a
different direction due do how I wanted to align the values and unit
prefixes in the table output. In the next version though, I'm trying to
split out and reuse some of the same logic to avoid the duplication.

-Justin
