Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E542246BB4
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 16:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758643383; cv=none; b=mLOkyXicPBBEREK6/t3VxQR5/E9u8ZdZcWQlPtcN76Bw1kEcM6q6QMj1f63OoHiZLHk4Me0TgN62LmSkoJfzWa4iT2uoH+iTK5PN4TtQYrqBic978znt8111EQywT47OjHKgqMbc/flL3/mZZ9bXqCfrcMEU7YxgP56iyGk+gb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758643383; c=relaxed/simple;
	bh=hn2hYmhfwaOmhaWo3x68ddVFazYqpqEmO8pkEOYVkoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zt1TdKihAXpK81NPxIt1jywXm4v5pZB19031OFwhuM0cAMRKgC/Rp7qehS6CZoK/0vv2r8u8XT6sKwUkJj/pql2LtYV2w/zgSuaKvtfzwJcaEFWVIwCjj2cxyowGKN9lWTDrr19lw/K1mlBCZDETb0VR2mIURQWabwzsQHumjxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BCWqQEKT; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCWqQEKT"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-30cce5be7d0so2626428fac.0
        for <git@vger.kernel.org>; Tue, 23 Sep 2025 09:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758643380; x=1759248180; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FpOG3UN++0Bw52/0MdcUbZ2PLeCkVHUudBzZvekSb7Y=;
        b=BCWqQEKTeiKlFPA3ObKCDGxyWaYLyWxAEC8LtuT5DDhmJPQh4fhX6Es5CuDfzoogVD
         isdtYr640b0asyuKbk/Zpbqej6aAztqCbeCJXNtR5+jXuXgHpg5mg4SvqSrVFk/KX49h
         +2iYctLfRe1IVdoC1NwmGfi3NNq9prPIc9bdt1TWiofDHigohSgw++w8S+50CS0velQA
         nxX/rBrLwY0ArVZuoO1aTPdmdbZoSa6ZoCTGbToCxZaQMY0wVbd+MxQA588h39FhEqow
         5R6WhtazwIj0DYAQnfqWgHDLFGzDo2LsoEtUDuhMy11yZ63FmGHhYESXEchixXZ2Y9Di
         GH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758643380; x=1759248180;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FpOG3UN++0Bw52/0MdcUbZ2PLeCkVHUudBzZvekSb7Y=;
        b=fy4VN8/dCkrISi75JMza+lgjOouFyIKX9SKe1eeuSFqM6z+pkNd3HKDNyMSQu67z4z
         PjG3OBG7bCfRIwrr9+HJ3NIv2vpL1oMZCe6FEEPZsWhIlu+DnP6mX6379674460pcTsu
         NiWk9+EDa534mi5oXvQ8zKsde/4s+546x7l1B+FYV/GdWax/hE0exo5r5K+J2XsxHu/y
         IQCpcRpHtlwgoBSoq+ZqW4hQY1ymCUqojlAuIQE3EqswjfeWVLoSDmLiu6g6cfRqCVNg
         JnLgsuXDE2r90vWppyqnGoZcOGdLMOMUcHrpajkQoxg27nvRCUum+VEcSbGoDmd/yXRv
         vByg==
X-Gm-Message-State: AOJu0Yxw0/R23rAMPxI6Ioj36gNcX/VIS0NOu2p8986ra98EXZ0OstoG
	ztLnmp7MTIfWA80E2jZcxq12GxPuMAbXiM7bMO4E76Z2NVQw+Iu5TewS
X-Gm-Gg: ASbGncvOSKrMRiu1wa3qJRmpA75M7VkXMm7KuxuhUFpi9WzeZBxJcOa8xIsFBKaAa7W
	3IjMDLJ26ci7WCpYc2KasHpU7t3cG9yA4S1TDE9IQTDvK9OWfjSmpg/cTl2NgdgBikSwVZHnCdc
	++igRM94LLPcWuPT2FYbFn5BUX59h9XSiE8Q09CNrRS09WovVqxundGy+/mrU2vIufjAs5cBJlx
	hLeNU6raegr1zxYTulnyV4ZAhQLlPZKvcAUbExsiAE65mfS7QodycdXXJP8FoZrtUz0DhnjdUue
	amPP3IcyzJzUpNqD1iZr6EMaSz/jv5jA7yMlZDiD60jQVd68+sbvdUXjAywJO418LBev1zfWCZg
	mpM8jKrUZk3gLE4s/
X-Google-Smtp-Source: AGHT+IEe+l032ZP2zuKJ0L9JgBnQTOgBsFGXE1iB/lJvZYo12IH+X7KhJxB+y6qOqUk1CCEHpPbTig==
X-Received: by 2002:a05:6871:88e:b0:34c:2933:5fdf with SMTP id 586e51a60fabf-34c7983a5d2mr2109227fac.14.1758643380218;
        Tue, 23 Sep 2025 09:03:00 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-7691c44ef20sm7175510a34.17.2025.09.23.09.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 09:02:59 -0700 (PDT)
Date: Tue, 23 Sep 2025 11:02:58 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/4] builtin/repo: add nul format for stats
Message-ID: <xa3araqtucuf4mwm3bll2moq2tlnkyq7hw6dsyma53g7xpv7tj@nu3of2vy6geo>
References: <20250923025700.3046260-1-jltobler@gmail.com>
 <20250923025700.3046260-5-jltobler@gmail.com>
 <CAOLa=ZSyXFAE+=ApxscikcmYjtz2-EzrOdORZn3KfiU5Rg_RgA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZSyXFAE+=ApxscikcmYjtz2-EzrOdORZn3KfiU5Rg_RgA@mail.gmail.com>

On 25/09/23 11:41AM, Karthik Nayak wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> > -static void stats_print(struct stats *stats)
> > +static void stats_print(struct stats *stats, int nul_delim)
> >  {
> >
> 
> Nit: we can use 'bool' variable types now.

It was suggested elsewhere to just pass the delimiter character here
directly instead. I will probably do that. :)

-Justin
