Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA29EAF6
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 02:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751251182; cv=none; b=XhnkJwDmW7NUfuJICUJ1bk+VFa3bCdhToFWQGw04gn/nVsD1jvqy1q/0wisMV6KI5b66CJiwF8IAUEjBazILB7IjBtIlhPDWuJ/+pgJ9OM0j8xbYOhuSPQmG1wOZVD6gLesK7uj8zdABSyEe8HO36rCzyhfDlBw99QmsFu7GNAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751251182; c=relaxed/simple;
	bh=VldVl983niK2lZ4xAo7l8EYHpCEZqkIrM5eXd6rzf1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hz0tns+m7WNp0vvdeS3C8FkVOc+Ntlk+cHfYDmml8HPUpzcwrUf610y+HsXNfZbW59Xm2gjzRIlB4h0HfFtseGWyy2A9925YxYlI0TDIMMdTjiYVtfWcpL1MGdzn0hQnAp4Lb6hXy+lOewtiCfsRL1ZPjneN2YIV7aTOGSXJkP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BAOwJ6KA; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAOwJ6KA"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-40a8013d961so1354639b6e.0
        for <git@vger.kernel.org>; Sun, 29 Jun 2025 19:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751251180; x=1751855980; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yHFDFfOCqiR4IEXF/mpWHvuCEJrRRKAZT9jCs6wlv8U=;
        b=BAOwJ6KA+v7wc5kt5NaQGxYV3YGNo+APPmEbcQu6ejZmd2st+VOZJ9VltoGu7AdXdx
         D9dwRewbUBK0UCwyTn6SU17lulhGSAbBBsZrACBmRazOTpIHfkssvPaY4ciR+WpfAzgS
         i33iN6gpnAWu4qSojvEYjTvRFcnziyeSYJBi5dX8Q9L4exapAly30PvXl128g24fMx09
         1dXKdO3X1Em/VVi//VHkoKW5zYJzdQD28cZsOxuaWL5AgPpDkksVC27vNmJ9mHX2NIZ9
         ATR1BwTckVuzOXxJEU1Zh1wAXElszsfXk1T2VtGV2yMNnrcMmP4rf6ERDLFQ8l2dH9T8
         iBHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751251180; x=1751855980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yHFDFfOCqiR4IEXF/mpWHvuCEJrRRKAZT9jCs6wlv8U=;
        b=kL/xPgfExRhsPSbgGtFCRxVNK1MMeuzG3l6fUo5HlAKB1dPhG6TGVnf5/hlSRrq1uV
         y/hK7nNM4I1wD3rE7wFth0bFZyJMqaNnU8xJpzFJls+v/oXWVfoKOf6dD0mZdOFs/+et
         qz2jCT+7zB749psq+j82KezO6RU7roSzJdmgObVkeNlmEITXVFs+9XA9/CbYXOnLxlQh
         jbiTkSqeBWeIuqxSg+78lxMmuH0ov4R3LMTSU0tVuri2krMW44ieVwmMn+SUgety9CEQ
         kbQq35vcYuVtbi2GEx4iCE1UGfVhu4GGPXexYZVAiC2Sa2o0/Jwcqan7V6VUP8qIOmQ3
         R7Qg==
X-Gm-Message-State: AOJu0YzYXQJPhc5/uEraAafq8CbAor8k6bLkHCUgfz0V9Klx9fvMQ1ow
	66PVrlU6SsXkofhXSxBzJc3ddSouTTwPM3IL4fhyXmoCJMa+outdZAcX
X-Gm-Gg: ASbGncuueQ0KDKYlZYwKPdCFdrAbS+wMu/w1XQdTG0SBfWSGNuIILzGuESf678euAVn
	FU11cnqr03TTltn3rOIbzCHgOoOEHplsFal7Y09FEMzYobNo2DzbJhi5yU/JNiYoNufK58988gE
	jyN1K1GN+0Oyt+H6UPVdA3d8AbUklgP7glyVu1P3OXY0X9570PQMTc8CGfn561mIHn3JVPXVcCu
	I6hzVM2oU23pPynWkJmfwAdBmK43LsUeUDIATeNOvno8A55SQqY7QA4PRXRLWElq/m7aNfTs4Pm
	wcez/GNlYvAeTrqoga7Ay4hWg7tx3pR33yKvczKdCA/6+t7V+GF0YEY=
X-Google-Smtp-Source: AGHT+IEYSIe8+WuvI1BPdho/tsDcutrvBCgoYNx3dQl/+U1qKuxGch7f4i1d781kgiaVLerkmmIWAw==
X-Received: by 2002:a05:6808:23c3:b0:404:766:3129 with SMTP id 5614622812f47-40b33c33271mr8379653b6e.1.1751251180238;
        Sun, 29 Jun 2025 19:39:40 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-40b322892e3sm1507936b6e.9.2025.06.29.19.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 19:39:39 -0700 (PDT)
Date: Sun, 29 Jun 2025 21:34:12 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v5 04/17] odb: introduce parent pointers
Message-ID: <xgbzzqyfnfmjmtucnq3qd3bfqdal6vjkaap3xfspeetbs6ontk@4vclbvlreere>
References: <20250605-pks-object-store-wo-the-repository-v5-0-779d1c28774b@pks.im>
 <20250605-pks-object-store-wo-the-repository-v5-4-779d1c28774b@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605-pks-object-store-wo-the-repository-v5-4-779d1c28774b@pks.im>

On 25/06/05 08:46AM, Patrick Steinhardt wrote:
> In subsequent commits we'll get rid of our use of `the_repository` in
> "odb.c" in favor of explicitly passing in a `struct object_database` or
> a `struct odb_source`. In some cases though we'll need access to the
> repository, for example to read a config value from it, but we don't
> have a way to access the repository owning a specific object database.
> 
> Introduce parent pointers for `struct object_database` to its owning
> repository as well as for `struct odb_source` to its owning object
> database, which will allow us to adapt those use cases.

Ok so in this patch we are introducing the parent pointers and setting
them up, but not actually using them for anything yet.

> Note that this change requires us to pass through the object database to
> `link_alt_odb_entry()` so that we can set up the parent pointers for any
> source there. The callchain is adapted to pass through the object
> database accordingly.

Ok IIUC, for `link_alt_odb_entry()`, the reason we to pass `struct
object_database` instead of `struct odb_source` is because the sources
need to be set up with the pointer to the parent odb. That makes sense.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  odb.c        | 47 +++++++++++++++++++++++++++--------------------
>  odb.h        |  8 +++++++-
>  repository.c |  3 ++-
>  3 files changed, 36 insertions(+), 22 deletions(-)
> 
> diff --git a/odb.c b/odb.c
> index d1025ac182d..afb16f4c693 100644
> --- a/odb.c
> +++ b/odb.c
> @@ -135,11 +135,15 @@ static int alt_odb_usable(struct object_database *o,
>   * of the object ID, an extra slash for the first level indirection, and
>   * the terminating NUL.
>   */
> -static void read_info_alternates(struct repository *r,
> +static void read_info_alternates(struct object_database *odb,
>  				 const char *relative_base,
>  				 int depth);
> -static int link_alt_odb_entry(struct repository *r, const struct strbuf *entry,
> -	const char *relative_base, int depth, const char *normalized_objdir)
> +
> +static int link_alt_odb_entry(struct object_database *odb,
> +			      const struct strbuf *entry,
> +			      const char *relative_base,
> +			      int depth,
> +			      const char *normalized_objdir)
>  {
>  	struct odb_source *alternate;
>  	struct strbuf pathbuf = STRBUF_INIT;
> @@ -167,22 +171,23 @@ static int link_alt_odb_entry(struct repository *r, const struct strbuf *entry,
>  	while (pathbuf.len && pathbuf.buf[pathbuf.len - 1] == '/')
>  		strbuf_setlen(&pathbuf, pathbuf.len - 1);
>  
> -	if (!alt_odb_usable(r->objects, &pathbuf, normalized_objdir, &pos))
> +	if (!alt_odb_usable(odb, &pathbuf, normalized_objdir, &pos))
>  		goto error;
>  
>  	CALLOC_ARRAY(alternate, 1);
> -	/* pathbuf.buf is already in r->objects->source_by_path */
> +	alternate->odb = odb;
> +	/* pathbuf.buf is already in r->objects->alternate_by_path */

Should this comment instead say "odb->source_by_path"?

The remaining restructuring in this patch looks good.

-Justin
