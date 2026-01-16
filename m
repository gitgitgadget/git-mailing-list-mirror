Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C6F337B84
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 16:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768581173; cv=none; b=MG8dV6TT7jCknKjFAYTgEWh174ecwy52yfr96Vhx8OM7dKaz8SbryBeUX2u+VvWUTfd6OGbI+5KlRofOHKuCnxPWuUQC8QzPQUYc6cJWhb9mov5e0/RDlgLC6HFMzI1QKDw98zNH8EPDMIzeoHjTFdTjG+xlYR/U9PK/zz4Gl+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768581173; c=relaxed/simple;
	bh=MO9MHBhPi2PxnIB49avM7fl+b/FrU6HXtjKOJpXSi7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bcVH3Szw5Np5rrQvrpqQJaXNY/+6UXB5fnJvNkfBoHpN4QOrmN7O2KZ4cJ1vZrn8vHRpehhpF1VWRSim4ZTXQnS+eY1I6A+wpG3Z47uv2ni37hcORgWzIn+SdrriOJa7wmqtgx2jkIYHduj3zMUkQPvE1LGnguOKxu0MHzCs5GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VACoUVgw; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VACoUVgw"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b872cf905d3so370580966b.2
        for <git@vger.kernel.org>; Fri, 16 Jan 2026 08:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768581171; x=1769185971; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cMbph+eZCfi9ETmn70AG/RB7fJbD3okmXtf/owpBnnQ=;
        b=VACoUVgwyhyWWstlAh8hWW6LuIeTROpb8VkHsDoUnJX7WWYL+A+2GDAdIrihFoGIGq
         PKK0nz9Sb+mh5nNH0vw/8IGKYOnLwQNVyIw13Lmvj7huB2IBiNQGnSAxqIGWW3DbVgCu
         H27sDUMt6X6XThkRmxKca4Vk8F3kMiJu/ii6ZxfpSgFOhYkkjGRaQrtK/+ptBe1qY8vu
         EXn40KRsDWa8MWRhEjz3VRZ2FQWm+T+vBnguxleo7Eeix403ONNxfD18MrqgMoC1ao9B
         5uFdlo3scTY6lTnxX/aY9JgnGZxRrsE5X5e0gvwB7U5zkRRRJiFH+Pnwimkn2Wa6QqWT
         yF2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768581171; x=1769185971;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cMbph+eZCfi9ETmn70AG/RB7fJbD3okmXtf/owpBnnQ=;
        b=GcH6gqOUT8NxtIWU+i9DwAsOZ0VHTi3MHHRd/A6tuIGKW3fjrvUw5vcjGeXwKlrVpK
         gKdc/XYUDgnAs+yH9KhJ4Hhw+BXDvv+plvC1PQwkW6b6C+lEvtzZHu3OJl1+7aEuF3h1
         +0tmNfhW9R4puf3rtl5B76Eez5YU/3yBcz7gUEq6/A+ovXu7RsY3LnDSfyIOz+zuBHVy
         11bRsEQRZbKChlbs9XxOdQNZaLceSUvDSpTpfWGOcA7x6haB7+oC6DsR59HMcJoeVlqP
         nbkJHru6x9hoRs7WoR8IVUGd3tUnt3RR16V2L8B/jFBale2iwGKBpPjmNEzawoUmY9Dj
         W8Lg==
X-Forwarded-Encrypted: i=1; AJvYcCWb7k+RTm7rwatHb9mflglyLnwZeJEMfTfyVFFtHxwS9Cp9W3X6e6+MILLiMX25jKK2XQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRrSmvQ3fDw01/JhgZhb3oibcrAUKuCAoITrpdir/EfMx4ZOIE
	R7A8jumjplveFiqkf65Z4R+r3wX5piXzWQkw/XQ0lqZEz3hyQPaB1l8F
X-Gm-Gg: AY/fxX64s8Rd39dDEnx4xPaK0i7UdKogDFM5k12un4YXPTXXL0XoqFhekkKlJ0NB1yZ
	//YI3hNtHiEQSDcu3iom5f/HysThm/m5SGQDAPoKtqkSPqUJCg0rLxZBUUrQ3sN9rChv8DkqYDN
	ywfzu/QDI6LRH8s0JKL7mFFKA6cKrCtHD8MxehkKCXQWMmr8fhLvlRfLZejORnraE3NQBB1+vlR
	NZqZJPkjGJCJpIJgZmBQ6BqBSY5crIU0wwg9yQ1ak/AwuVhVp2OdgUzqLM07Tn1ZQbGKrI9gS36
	T2Df6Rjd7NvnOq+fjlDLuQ+w2gZxwd4XDOumtacS3B1ermQmeAnu2zS82M8Hsp29iCMEDRKBkGv
	RHlCp6Sud2cfN45ldSSpHDDTa+QWlewzDeNMtzG6pzG/1KESPFncle6TzWbpN2OyyWibwyr9f4N
	kgmks0UIV/HiAa1ix1XOrz36tWBd/YXgKqZ/sesWrc7S1Ma+ZOAIhDEyLM6ghH61kGC4G64K0Uw
	oZFTebJt6lCNNVfuFr4Aw==
X-Received: by 2002:a17:906:f5a3:b0:b87:1ffc:bf9b with SMTP id a640c23a62f3a-b87968aa44bmr275716666b.3.1768581170476;
        Fri, 16 Jan 2026 08:32:50 -0800 (PST)
Received: from localhost (20014C4D24DD3900A135D2EE9B3C72E7.dsl.pool.telekom.hu. [2001:4c4d:24dd:3900:a135:d2ee:9b3c:72e7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b879513e84csm290701666b.5.2026.01.16.08.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 08:32:50 -0800 (PST)
Date: Fri, 16 Jan 2026 17:32:49 +0100
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
	Sergey Organov <sorganov@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Matthias Beyer <mail@beyermatthias.de>
Subject: Re: [PATCH v11 0/8] Introduce git-history(1) command for easy
 history editing
Message-ID: <aWpoMcgwsfRCCrr4@szeder.dev>
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
 <20260113-b4-pks-history-builtin-v11-0-e74ebfa2652d@pks.im>
 <CABPp-BFbUEGqNAeUtUghLd3oKcZiD88P04AYuTtY4T01F1rzdQ@mail.gmail.com>
 <xmqqy0lxa8i6.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqy0lxa8i6.fsf@gitster.g>

On Fri, Jan 16, 2026 at 07:21:21AM -0800, Junio C Hamano wrote:
> Elijah Newren <newren@gmail.com> writes:
> 
> > On Tue, Jan 13, 2026 at 1:54 AM Patrick Steinhardt <ps@pks.im> wrote:
> > [...]
> >> Changes in v11:
> >>   - Fix overly clever `BUG()` condition.
> >>   - Drop the `struct replay_result::merge_conflict` field.
> >>   - Return a positive value from `replay_revisions()` in case there was
> >>     a conflict.
> >>   - Improve a commit message.
> >>   - Fix check for whether `setup_revisions_from_strvec()` was
> >>     successful.
> >>   - Link to v10: https://lore.kernel.org/r/20260112-b4-pks-history-builtin-v10-0-e3c6aa5b4cec@pks.im
> >
> > This version looks good to merge down.
> 
> Thanks.

FWIW, I think it's far from ready to be merged.

