Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995351E573F
	for <git@vger.kernel.org>; Tue, 11 Mar 2025 23:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741735679; cv=none; b=M0vsqtIFCcAXSDnjglult5QkK/g/RFd4whqxvJaXP1rX8URlN14Mhn1q1ivC+09jC5TIZlDlwokPI1fOBTGt9KT3LtO2zyVn6Vj9SdoDOytbaghgOXbMAS9de8CoGX7xVlyo0cCTLLrMRNSxm0fTNR+cC0vC169XHMUFHBcHgv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741735679; c=relaxed/simple;
	bh=fi6+UprRyG6bOedyqN/GfX8QIl57k6jv1LGkZdtVbAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jbu5+ptMyfqsW9RVdjEIAz1J44tutkqXl94Dhbqi0NE6WzDgYmPysqc/h6G8D49gTmG03t0VYmwouv9v+vQlxzc1j0lhw7L8/RvbyfrFGBHRpOb/VqX9SqNr1KqIoLl4Bx8csaFDBAV5aXD+2bJr6kP1UCtn8R1lqI1i4wSQyBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dszXVnKy; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dszXVnKy"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5fe944b3fa0so2786538eaf.0
        for <git@vger.kernel.org>; Tue, 11 Mar 2025 16:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741735675; x=1742340475; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SusSQ0ylXqQqnSinnQtrlvLoK2FOu9l5J1o2MsWObsQ=;
        b=dszXVnKyHYl2nIe7yIcyCgKCP7VGWp3CXscNUwrgcM6GmR7++ZofzEjBPzWBAM0J2d
         QVhnD0uuElk+/LuKK/rn1K9HjTQzAMZDKJfqWX3raXItK7Ky9wF5HXyNCUNwNh4fjqXD
         V2G21uyeJEzn7SY02M7ucKIbpsp2LFiDckEsTwJC+4af0hi5c48OaiA1WsxdaPAz3G1M
         ZAGICNAgs+lpz8rRnA9zHBUOCE2eJsh7sx0eTkxQsqdEFFZPJVlIKXrCWFokFlfmj4e+
         6oz0KAupqTiDaVccbBDy8bv8GsekNzdkyj4u4gNGDZ4bFhKzduCLdSzrCTXh2gSQlTZU
         fiFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741735675; x=1742340475;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SusSQ0ylXqQqnSinnQtrlvLoK2FOu9l5J1o2MsWObsQ=;
        b=xHwGZIFcMkYgXD6u8LaG+J0iZsbUYW0W9b9Wtw7Ft3jgPrGxCpILEiTIaz8rnl51rp
         8hbPym00iiHSP9wZd314f2HJeXVkRpBEPD4KuI/bZKtlLp8o5k+zjn9k8kae7PmSe+IF
         H9pajuJuMTTYfCjruf3uP0PFgnjHnUE4+JqyKTGVKiltGB4YUujm09qQHeo75KJyOBRw
         g5T6IhC8G4wQ4zOwKLd9/aHSgfF91dMfDYy43XNhQSNcc1IdDnw57q3hKPrLMsSIw0GA
         DAc0vH+CrolQ03d3m3tL/Nf9AOW6ZQARkJQIx1h0O2rBcMBbQ9iuuWPpUGKa1UZQclzO
         ydfQ==
X-Gm-Message-State: AOJu0YxIvIiOWnx6LJB+fsBG9OGornfma5nWIVPup9lsG+4w0RL8CqQ2
	Daq6a3Sn7HS56uGtskoTOegmXx+k8vVIC4WD80X8xprd6EvHzEDk
X-Gm-Gg: ASbGncuEa/4y1bQ+PaButrmEWrQf+avV6bl9UAOmMlqaaNOFzI4acb+TYSXGNkFiQ7h
	HtBBa6zWIPTPckxqzlmbyBFQdOKHNgl0zo/JUXX4v1NJe7B1LqhO+4J4e6tBjvD+W4uVcrfHu68
	6+T+3rnbzK+qJnyP92X4gRqEN04IrsbTbEE95g5wSLeZssAbGHwEB8eAL9TEGTOH/dC6wQLHNQh
	AxgipP3jStD+cXUX/zi2xSrds+fAkmumvELixmvitHvMePxG8GPBv14zbc+z0lS0ZCt3eVYKAHm
	FIosSZvrEl5zG5GTD1imN/Laxd1Ta7/CKd30KA==
X-Google-Smtp-Source: AGHT+IHBZLA9a9Yta/+MfUG3IGzS2Kkd/VaikHTbVjZSAVW17BE0MSOm82W6IWF72SFdMKSkHj6Dsg==
X-Received: by 2002:a05:6830:6d12:b0:72a:e8b:a849 with SMTP id 46e09a7af769-72b9b538fd8mr3477079a34.27.1741735675529;
        Tue, 11 Mar 2025 16:27:55 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-72b6ed7db80sm1650111a34.16.2025.03.11.16.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 16:27:55 -0700 (PDT)
Date: Tue, 11 Mar 2025 18:24:28 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, christian.couder@gmail.com
Subject: Re: [PATCH 0/4] rev-list: introduce NUL-delimited output mode
Message-ID: <72x6ku4jylvsnqjapqlfidq6m4yvpzu5gzpweg47phzgjg35fg@laabmtehkes4>
References: <20250310192829.661692-1-jltobler@gmail.com>
 <xmqq34fk7hb7.fsf@gitster.g>
 <xmqqfrjk61bb.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfrjk61bb.fsf@gitster.g>

On 25/03/10 02:08PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > As this topic is designing essentially a new and machine parseable
> > format, we could even unify all three formats into one.  For example,
> > the format could be like this:
> >
> > 	<oid> NUL [<attr>=<value> NUL]...
> >
> > where
> 
> (0) "rev-list" that gives only a sequence of "<oid>" for commit-ish,
>     as well as "rev-list --boundary", would fall out as a natural
>     consequence.  Bog-standard "list of commits" would see a
>     sequence of "<oid> NUL", while a boundary object would see
>     "<oid> NUL boundary=yes NUL".

I had not considered handling the `--boundary` option. It looks like
boundary objects are printed as part of `show_commit()`, so I can adapt
the handling and do something similar to missing objects:

    $ git rev-list -z --boundary <rev>
    <oid> NUL boundary=yes NUL

This would remain consistent with the unified format.

-Justin
