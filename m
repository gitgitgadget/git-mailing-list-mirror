Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D5516D9C2
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 19:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765913983; cv=none; b=sad6YT8dC+xd+UPZnksx80yZK8OKi+AkP0pgq6N0zxeaS94zQhjwaC6/5qGNEs4gMsES4fZQZ24/0c7wfK2wzDRK+/vJjc5uVibSfTdw5fQpyM28Izm4hqNjOXim621tFaDuDH6++rwS4qK7O/C0CHHhwWTpkADIOtcj/eklqvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765913983; c=relaxed/simple;
	bh=eE3L3Tng58TEnTEHiEiYte/iJinqxgLqbhGIoXRnZjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f0vEggqIuhbNtB98aHHit4LzlmaZtRfiyE8Cm1sFRv2dv2eytHQ0bY6xR4Vvk/QpWabtWpZ1dO6HBjOhJMdU1BeRnU1JOAw4yfg41cI99AynfZPTVDk5lY7Visv441A3VQRIUXgouaX3Zok/200d6bmdp57uQvm7Y4Cn8pPlTuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C8NShMPb; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8NShMPb"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7c75387bb27so2158491a34.1
        for <git@vger.kernel.org>; Tue, 16 Dec 2025 11:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765913981; x=1766518781; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k5eLFXoxR7S2vjpzUIBLwyGj/WZR8ZNojwtBjFdEuKE=;
        b=C8NShMPbLiDZdQP3QdvNzA3/2DfjnXP7CqKY8jZ7jez2K5iOnmn0Cz57hI3EUi/Fn2
         j29f1I/PUNoMJXVP53cQF0MsWbqan6obrhhYYZuORwkqhTN3swkc0QitUG2qa21KGAS5
         DKRk1dzLgUqmvVReVy+P70uZt6Of3+StMK6RNb5EWEsXM3L5C31RPHp6UTtFi4Q+n3Xq
         dNG+ph0UlsFEeW/RdnUt/2cm3lYUIzfSSc/Mge4Jfyd8PFZSvhH+LZY/NFmrxD4Oosaq
         d813ltBAa16Dg1Gr2RSyvwxUT99jVoZizRmSfo3z2Hz6XzTsahqF3THnaY7+/G+M3y/c
         mdSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765913981; x=1766518781;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k5eLFXoxR7S2vjpzUIBLwyGj/WZR8ZNojwtBjFdEuKE=;
        b=WYiXZq/2nvAh4sRyl3l2RwJZpCRmlMlbFWp2uKLA2wktpKxT/uM0K32lPReDd63Zoe
         s3lACdOloZikrG2a0QZkNHKLcsfEPRQjEqMcAnvTQmc3iGZ7QWc12/GGnfbnfhd7zTgV
         IyQZ6t4+HdtEyviqfnLF3oyonFpzUeBSyKGWXkEWvnYZc69lCrzzq5mxXWH57DovofY4
         mgYQtvfgtMnORhzckxQx5iWykwgm8P1M1VvbP1Bh85O+HirLIld8QorLRnJzvjg5AeVV
         hGRYLjYviYkPBVzJMr/XjqjEGHgWiJdkyAspghfkO0ajHsnbnizLZWexE8owtH5vLthK
         N8JQ==
X-Gm-Message-State: AOJu0Yw7DSAoea9Qv8alMk/Tllzfsqhgx5jO3lTbIe6qTZzCHBdIH9gg
	3OuYdyO5qCphwY+xyBkfHPP/32t8ZXs+HREcBH56Gtm9dEr45fqVhCcF
X-Gm-Gg: AY/fxX66zsRxBZXgbZ1qTOafjE6JfF3BA9nDW4a4WOPYbVjQwzDHJ7SwP7NLPL1gfiF
	zHD8lkrd6aBM+9maHoxSk7xjYIv7zRNTXuUvYRXgTlo0GzLVuWplqnA+57iUfGUmLZDJuNTXGf6
	8aT5ZhxsaE1/T8eYCUMDSa/rHQ9Vri0VkS9GuGVHuqCNiM1ViLJsCoNIHRhh8FigODXfq2xX08M
	eJs+6qChwuPpiww6oI96uBlcvAg3BvrlhdECemAAXckct1FPhcRoWvAhRJcCQWYvypL30BjhEdW
	1I9XjfosLtDzpWVi3vAvH0HDOUiOlJ3OXmb27OHAHZMp/RYIFxxeB5djkNafoaeDNutC3VtlFXc
	scOLJaB3b/y6QNVTKN1CiLoaLaonxzwaO7EpjnikCmq8e5nOjm8Q/PIv1IQeOb8W3Jvai1EcWaO
	Be/p/j
X-Google-Smtp-Source: AGHT+IEo/VUKa4QaNg0D0eiaLR62C8dWL7FBTezO/sfcUTLhNRso5A3F7S77U1nu48y39elHh1Tyeg==
X-Received: by 2002:a05:6830:43ab:b0:7c7:1c87:4f95 with SMTP id 46e09a7af769-7cae82d61b4mr7879178a34.4.1765913980759;
        Tue, 16 Dec 2025 11:39:40 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cadb2250d8sm12339486a34.13.2025.12.16.11.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 11:39:40 -0800 (PST)
Date: Tue, 16 Dec 2025 13:39:39 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, worldhello.net@gmail.com
Subject: Re: [PATCH v4 2/7] strbuf: split out logic to humanise byte values
Message-ID: <uyuorzpq6mqr2icszhzxswdyxpr3de4762yt5fynlpgmymovje@zzix54kgnwwm>
References: <20251215205639.2700270-1-jltobler@gmail.com>
 <20251216173842.3357832-1-jltobler@gmail.com>
 <20251216173842.3357832-3-jltobler@gmail.com>
 <xmqqqzsu2qxy.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqqzsu2qxy.fsf@gitster.g>

On 25/12/17 03:59AM, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > +static void strbuf_humanise(struct strbuf *buf, off_t bytes, unsigned flags)
> > +{
> > +	char *value;
> > +	const char *unit;
> > +
> > +	humanise_bytes(bytes, &value, &unit, flags);
> > +
> > +	/*
> > +	 * TRANSLATORS: The first argument is the number string. The second
> > +	 * argument is the unit prefix string (i.e. "12.34 MiB/s").
> > +	 */
> > +	strbuf_addf(buf, _("%s %s"), value, unit);
> 
> "unit prefix string"?  Prefix is something that comes before
> something else, but this one is at the end.  Simply saying a "unit
> string" would probably be a sufficient fix, perhaps?

Ya my bad, the prefix part would be just the Ki, Mi, etc. In this case
it is the whole unit string. Saying "unit string" would be correct. I
can send another version fixing this it if you would like.

Thanks for the review,
-Justin
