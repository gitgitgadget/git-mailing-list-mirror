Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39E55A4DE
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 07:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708414953; cv=none; b=QsORM4IFazQLB+7aqQAPWXWh8dlStJOVp5/KYoFufZoRuP9OnbJlZmVg2F2GOXENpBuK1c66cc9HTmQVZKdTXHAYaPfkVsySvF6ItcoT/rNO6nNvpgcxZEwt7ZaDwT2mpoB7fS1Dy29i6D+k5xKKHuIQddm8Oy/9W41ezJ3tpmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708414953; c=relaxed/simple;
	bh=72VsNvcfMnUtcYLffKcmrrX5Bi0V/sEA9AZh7GpN0hA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iq9hQphVSepxzSoGxbQg/YyuZXV+nh+RdZiPM/UtAMpiElqR8hJJK6muE3rBHrbqJXHy4rquwf/ytNh6vwJCxKEeXEFuK932hFgC/6+Z2TEsD0OUJllNWKBExaP5ILwybaDjq5UnxL2aWRAcbr0oXLpgWXNV+ZWA+YUAQMyJfOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TwYb5dFH; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TwYb5dFH"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-564d780d55fso72510a12.3
        for <git@vger.kernel.org>; Mon, 19 Feb 2024 23:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708414950; x=1709019750; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DwHySQccz2J03HsMnamw66EkLmUPrar31NbSD1ezo0s=;
        b=TwYb5dFHjSLClna19oCaroaLc/89PGCWUSmcHkMMVK9IyDs55FyOMKFZPuiCfaptr/
         Y2bHTCkVFyGsIEhyYv3zs1vheIUBOm6a+DXY4xEuZu5TLhGryRfn/fj4YP71zeN4KYjq
         Wufu3bmmQHTheJO6UH9IS4WYer+DbzgcVYW4E6f/d66OoDvnP/3vuhDU4HQa29MbncI+
         kj20IRwtV0pLTHOWeNBEb7obqlk2rDo/XSQ18c3mcU09IMq1RJXvzSVizeiToeNn9qxy
         IQg1sRab0Oez5J4v1NmTjTCpCSqbK2Gjxh3lq9r5NDH9gtHXd3ywJAMkEb21KX52jOUA
         oHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708414950; x=1709019750;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DwHySQccz2J03HsMnamw66EkLmUPrar31NbSD1ezo0s=;
        b=WkWy1ir0b5Jpn9QrMrXWVsYBuf9qkKOwvVqCOO+sVTAAY7pxA7pYYY/4eqzOty/dyF
         kp+iJn27cjDsB27F5iEvZLCyGEJYm8Rt1GC+15xTJPiM9rSjkXGg3y7wD1AE2Dyo6cLJ
         5VEvUesCFU5DgNSE7s7b2JQBshpyucknyV2yMQLyyEvzz8fceuNkQyczzvZVqA269i1p
         IfTUkBiQPADmEjkproG5WOjP222MpB/+4ECV1RlGpl8yt8RPZBKvZr559rn/oxSUpjbJ
         N6J64FBORzBnEK3uUNHUukx6XfePdUKPTBnnXNqNGAehTuwvHHRUH9K4QeTpBA00zZ2z
         Uz8Q==
X-Gm-Message-State: AOJu0Yyxxl+micR1oB2Ma7bfAmQEHBf/k8L3Mhl7Es84imw3kp8RcWHH
	WZXpE0S8KCMwECpnoetUvmt86trgKW6OSHSGDY1IwdTYhMygqf93puzp+ba1DQvWR37f5mHxWAk
	sgIA1Mf43XvM73GMzUXKtDEqeiFU=
X-Google-Smtp-Source: AGHT+IFWF00uwUMmljsR49MhlAs9VXymIgQTvng68GEIgDwJ0Hu8viJL5Cjc68SoZTqw21lJyKQxYgA96cCZAvSdRjg=
X-Received: by 2002:a05:6402:1655:b0:564:9019:d9b1 with SMTP id
 s21-20020a056402165500b005649019d9b1mr1870346edx.40.1708414949820; Mon, 19
 Feb 2024 23:42:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205204932.16653-1-maarten.bosmans@vortech.nl>
 <20240218195938.6253-1-maarten.bosmans@vortech.nl> <20240218195938.6253-6-maarten.bosmans@vortech.nl>
 <20240220021220.GC2713741@coredump.intra.peff.net>
In-Reply-To: <20240220021220.GC2713741@coredump.intra.peff.net>
From: Maarten Bosmans <mkbosmans@gmail.com>
Date: Tue, 20 Feb 2024 08:42:13 +0100
Message-ID: <CA+CvcKQyXu5JzhTnfQ7W2uaJNk_aP-2bh0HqP3npsfwUJn0Cew@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] notes: use strbuf_attach to take ownership of the
 object contents
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Op di 20 feb 2024 om 03:12 schreef Jeff King <peff@peff.net>:
>
> On Sun, Feb 18, 2024 at 08:59:38PM +0100, Maarten Bosmans wrote:
>
> > @@ -705,12 +703,11 @@ static int append_edit(int argc, const char **argv, const char *prefix)
> >               if (!prev_buf)
> >                       die(_("unable to read %s"), oid_to_hex(note));
> >               if (size)
> > -                     strbuf_add(&buf, prev_buf, size);
> > +                     strbuf_attach(&buf, prev_buf, size, size + 1);
> >               if (d.buf.len && size)
> >                       append_separator(&buf);
> >               strbuf_insert(&d.buf, 0, buf.buf, buf.len);
> >
> > -             free(prev_buf);
> >               strbuf_release(&buf);
> >       }
>
> Is it possible for "size" to be 0, but prev_buf to be non-NULL? I assume
> it is so if the previous note is the empty object (and anyway, we'd have
> died earlier if prev_buf was NULL). In that case your patch introduces a
> leak (we do not attach prev_buf to buf, but we no longer free prev_buf).

You are right. I think the `if (size)` is not needed and removing it
would remove the potential for a leak.

> I'm a little skeptical that this is actually increasing the speed of the
> command in a measurable way, though. It's one allocation/copy, right
> next to a big old strbuf_insert() that is going to splice into an
> existing array.

Yeah, I was doubting this patch a bit too. The simple idiom of
starting with an empty strbuf and appending strings to it seems pretty
nice and clear, so may be there's value in leaving it at that.
The speed increase is not measurable of course. I was simply operating
in full on lets-eliminate-all-sources-of-overhead mode while profiling
the notes show code.

I'll drop the patch, in order to keep focus in this series.

Maarten
