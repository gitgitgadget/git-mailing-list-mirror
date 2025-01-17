Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4AC537FF
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 14:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737124470; cv=none; b=YcSHmDKvgS+fIkjYtop4qcY9bAP1powp3qjBbCFHCOrqDg9setgUL9sipbi5Ttysnranjc7EfatsggGVi0yOMRw4l5kuwRXB37juUTHnGvqMTfW/lOEYonKT93dwLg61BLVhucScK6OYbPF8ZQOttPKBr3eu+oBrwUz/qlCgpmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737124470; c=relaxed/simple;
	bh=f5HqYXvYObMp46UD4XkCFYDIcJOUzLQW4yuFHermzRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UAeVn9bmoPvQGFvatSrCJSvy7DbTgDgzTLw8Sb5n/KTnl6pbnQuIWYfmK/jy+In9IeeTSCELeNC5PLbPi0AmSbNheS0+madXXXjCQAWDcqlXWUaswFrHG9YwBGNu1c/p5wBuF6PiibpRPEixBlyZOpioVYwLSa1Jh3n1d9xDhwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hzM2NJm0; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzM2NJm0"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3eb8accbde3so1796204b6e.0
        for <git@vger.kernel.org>; Fri, 17 Jan 2025 06:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737124468; x=1737729268; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kOP7d/If1aQhdsyE43M+CyZxXa9SASDL4sJslrIW8zc=;
        b=hzM2NJm066mNxP6YtmM0FtSxpXNB9ch+Fm3ZESVtuxJBr2YIwwT2bXtK2CnvyTlJdl
         NUEQ173I5Jgl57pDrGF88FuLk0MZPOxRC7u60SwIokeCqnuom5PPbRdFIVbyJjzcsxir
         ku1F3jfyb7alUKhVxdBCMAau8fljxnASccBHUNj809pTctcOq6ms31wutGV0Y7KFj+I8
         ZG222CHfba23k+O0nMbDX0ziOlNogiQ5cWFAT4iOhS5PZqXdk5cRO6uyMTGSyu4laxZN
         6kDqodQk5pHMnhpOwistD9wX7nG5zs+waJMdEh5akbBb6+Q5dP4k8FjoiNKaEiV+wk8H
         8EKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737124468; x=1737729268;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kOP7d/If1aQhdsyE43M+CyZxXa9SASDL4sJslrIW8zc=;
        b=C6rGf9qOZOVAjLOWNItJ15WNpynfrWMS9uNQDLkKW0S3/ztfEcmB6Vbfgsnxnx98DL
         M8IqQ7KocSKYQz+wwc1cVHvmNFixWBHYuqAF90+sfvKmrrplaJlEmSoVRxDx4b2UR/Nf
         KlmPFoILGiwtJIlL7eXOvs7OIai/36PicK7CxWfAeAc6Nsn1YZCMhICxFZUSX0iK+0je
         WRJWWKlrrK5VHLmCZaHPby3HdFIqUKXTVNmyBPuox8BT5LFYprKTxHg8ah/9uceYS+8M
         r/J5OC8UnkhmTl6qwThdkCCSA9QxqJryVGLK00aIJTaBtN5RvOqNAz4+2dEn44dy9yd6
         A7pw==
X-Gm-Message-State: AOJu0YxRNyFNbIx1b57XhKhx/z0w2AmngP/ZPEMQlCrgTVmqyq5I2eIS
	R9R3D6Eo9fGlIqlLygbXZD3f9mk+YY4OBoSvUz9a5x0xf8EjOjpa
X-Gm-Gg: ASbGncsYtMkOj3nCPMVBKk0wE1mZgxK49KxakVErJA6uLT7PvS5spwRyuujaW3gMj4b
	2NMu7koFkTJIoMe3MhOEUZRpmSB8q5CpqvhF37WVpn0cXQaOgYlNWxg8oHgtBAIAeW539N/JcNg
	Yc+KyE6x8e2F5g/zSPO6hihwHeBinHS1oW+XG8jPWUVxi2skGvJTXFrA0QQNkh0FrR12Ycm/BY9
	0xbGMAT6YaOajQ8Mm5YnTOa/tD42RwIQcY=
X-Google-Smtp-Source: AGHT+IHrMrmBnievOLXUlewMv0jkY5q3y7lTk5qLGHjg0zPeCnF4mvqWZpF76Ukju1VQKV2ele2Bxg==
X-Received: by 2002:a05:6808:23c1:b0:3eb:64a8:837c with SMTP id 5614622812f47-3f095a5fafcmr6464706b6e.6.1737124467861;
        Fri, 17 Jan 2025 06:34:27 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with UTF8SMTPSA id 006d021491bc7-5fa35f2a534sm755804eaf.24.2025.01.17.06.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 06:34:26 -0800 (PST)
Date: Fri, 17 Jan 2025 22:35:43 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 06/10] packed-backend: add "packed-refs" entry
 consistency check
Message-ID: <Z4pqv2JMNgIgFgG0@ArchLinux>
References: <Z3qNUizvHJLgMx1y@ArchLinux>
 <Z3qOB2_zrDHOh-Gx@ArchLinux>
 <Z4kQV4Nve632rJ3s@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4kQV4Nve632rJ3s@pks.im>

On Thu, Jan 16, 2025 at 02:57:43PM +0100, Patrick Steinhardt wrote:
> On Sun, Jan 05, 2025 at 09:49:59PM +0800, shejialuo wrote:
> > diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> > index f6142a4402..6e521a9f87 100644
> > --- a/refs/packed-backend.c
> > +++ b/refs/packed-backend.c
> > @@ -1822,7 +1822,96 @@ static int packed_fsck_ref_header(struct fsck_options *o, const char *start, con
> >  	return 0;
> >  }
> >  
> > +static int packed_fsck_ref_peeled_line(struct fsck_options *o,
> > +				       struct ref_store *ref_store, int line_number,
> > +				       const char *start, const char *eol)
> > +{
> > +	struct strbuf peeled_entry = STRBUF_INIT;
> > +	struct fsck_ref_report report = { 0 };
> > +	struct object_id peeled;
> > +	const char *p;
> > +	int ret = 0;
> > +
> > +	strbuf_addf(&peeled_entry, "packed-refs line %d", line_number);
> > +	report.path = peeled_entry.buf;
> > +
> > +	start++;
> > +	if (parse_oid_hex_algop(start, &peeled, &p, ref_store->repo->hash_algo)) {
> > +		ret |= fsck_report_ref(o, &report,
> > +				       FSCK_MSG_BAD_PACKED_REF_ENTRY,
> > +				       "'%.*s' has invalid peeled oid",
> > +				       (int)(eol - start), start);
> > +		goto cleanup;
> > +	}
> > +
> > +	if (p != eol) {
> > +		ret |= fsck_report_ref(o, &report,
> > +				       FSCK_MSG_BAD_PACKED_REF_ENTRY,
> > +				       "has trailing garbage after peeled oid '%.*s'",
> > +				       (int)(eol - p), p);
> > +		goto cleanup;
> > +	}
> > +
> > +cleanup:
> > +	strbuf_release(&peeled_entry);
> > +	return ret;
> > +}
> > +
> > +static int packed_fsck_ref_main_line(struct fsck_options *o,
> > +				     struct ref_store *ref_store, int line_number,
> > +				     const char *start, const char *eol)
> > +{
> > +	struct strbuf packed_entry = STRBUF_INIT;
> > +	struct fsck_ref_report report = { 0 };
> > +	struct strbuf refname = STRBUF_INIT;
> 
> It feels quite inefficient to create a separate buffer for every
> invocation of this function, as there can be many million refs in a
> repo. Might be something to avoid by passing in a scratch buffer.
> 

I see. I will improve this in the next version.

Thanks,
Jialuo
