Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B8B233D9E
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 20:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753303013; cv=none; b=mv4V1wglOP4WiuEwE8W6zC301EbtR2AEPg0vFE9xHK3lrga5CnQ3jhXpDiGEJeL+fp0gBJOSWA302PtZ6d8Qrfh434u9WFjH/ku3YrWCaHbUwC1TMeO521Flz/zP89ekdbhVSa3RVb7gj4AnONRPnl8T3rdaHEFZxBjS452QKLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753303013; c=relaxed/simple;
	bh=W9hl5LWjRZv9Jbx/hhef0VtN/4dmCyrcw/gfKWtgqEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WIJhajdQpGT7Q3MtP6P8sE8usX3/8cDlTmV4pJxbEdH2yFbN6UMq9twXRP5TVlJVfvERpgX2BbuInCBMiagLPl26NRfbPbQz6Df1RZzInfvV3OR6ZKqfAykk2FXKaEnJH5W8AlxwDazMQ20+q9DorDFu7zHUzZVPVqTxijPXJh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DdTKYE4a; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DdTKYE4a"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-301fb587dfeso176800fac.3
        for <git@vger.kernel.org>; Wed, 23 Jul 2025 13:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753303011; x=1753907811; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AXKyUq9m/IuUtBz1Zny9lT/YWeDWlgh+EFMZNgXKy4Y=;
        b=DdTKYE4adnhWKbWvZXERv9DzdNeNSnvdj6P+2LYDgsOrNSqZrKHbNg27ewNs6fU+tT
         9jk0yAk7EXIjalzqe69v4zAchshyvYjm0Qyc2NgapY8UCYr6a4Hs1LdU3LhlI7FRk32M
         6dwhO5I6sNyN1GjB7JpJiEoTxktp0uTQZ002zmcQwKaJNyITgBU1BbBiUs025fKcOaqw
         z3E1TTxSHwQjojydbukASthwXq+nxGSrR7NTQz5oyCl+S4WC78QlUXuG2hTxNonLmK3t
         m4hv8ihRk3e9IZOpubf4tlAm68tm5w/qV89GZUEj0sG5dlBpEDk8I9le8sUSBRAiJ3tB
         AJlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753303011; x=1753907811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AXKyUq9m/IuUtBz1Zny9lT/YWeDWlgh+EFMZNgXKy4Y=;
        b=ZG8lT0KaubXeim//peDDpxO58+UKMoknEP157jDlUpkL/RVXLUn9CRpZhB9fgebk44
         LHO7a3qv0APEXpo1wNUxQiD7GBhO/0rcTeXY8e7SEErMBxVa+s51UWdky+Sg0ddy9Ycv
         Tx6xfXlwI2OrdiItZ5h8mX8P0Fn5Z0jJmAP3YMGH4ddhScfb5CLZqGCFuQKRXW4ltVEj
         9OOe5/jDRRlS5shh6S9Iv/FvONnyd3aKbwGGwq1ty194LGAsyqlPO0tMudAIUoMbLgWd
         Vhywtx00XsVXL3tueYZrNj2He/n+OJKdIhHstVbL6mClUl2fvf30nN1c5OgajhkCBFDn
         9BJQ==
X-Gm-Message-State: AOJu0Yx0XGE+Iqm8lY21vOcVXbumrPB1FMwwIvxnpNj4hgm0CaFYh14h
	oP2anjqOU5ErKBS3sulDTkYTZvQA03fejpdQYDOqLZfDvMSEGrq0sULo
X-Gm-Gg: ASbGncvp5pc3t93NohGVDHt8tVVwcKvjC9BZ6msb5MAk197eqwHjPtsGYSWii1orCmW
	y32bbHESdT3mf52ADMUZ1L2yAkz1cf/aBYk1Cur1IjYKS7r9hHo2uX0KwZCZnlBUK71HgWlravo
	SixwSEcxAUsuCQ8pprYhGIeAR94uSILYa1n/WDfItJIOEvy73/9sa9RbxRJiXnHwzjpiTHIDecH
	N+POnZzSk4827ArwHEeudZkLsnWQu8jLVnVtgAYRJFRiUrTIVdhTofkis3PydNptG6ejdgPgeeA
	u7gEW8aoE+9lkL8bUP09GpqkkX420mthp2bU33Q2qj8d5RSCdbzy5IOn7vub4nftyx2tFzwgg3O
	ySMTVxQQERjPE+K0=
X-Google-Smtp-Source: AGHT+IG7RghCz3V6OwaDc0Ou40ahdIrXdIu1cqxHBiuFz7kmI6OIXCf+EOcSPQGaZiajIraO2bhrLQ==
X-Received: by 2002:a05:6870:d24b:b0:2d5:4d2d:9525 with SMTP id 586e51a60fabf-306c6eb6eb6mr3129511fac.8.1753303011297;
        Wed, 23 Jul 2025 13:36:51 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-306e1ec042esm40715fac.23.2025.07.23.13.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 13:36:50 -0700 (PDT)
Date: Wed, 23 Jul 2025 15:31:01 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 7/8] refs: stop unsetting REF_HAVE_OLD for log-only
 updates
Message-ID: <j52ugdtik25i6dqgqafchvy5an3o7qbdfeavtqg6bcr2ouxvyv@qwtqzf7xk4hi>
References: <20250722-pks-reflog-append-v1-0-183e5949de16@pks.im>
 <20250722-pks-reflog-append-v1-7-183e5949de16@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722-pks-reflog-append-v1-7-183e5949de16@pks.im>

On 25/07/22 01:20PM, Patrick Steinhardt wrote:
> The `REF_HAVE_OLD` flag indicates whether a given ref update has its old
> object ID set. If so, the value of that field is used to verify whteher

s/whteher/whether/

> the current state of the reference matches this expected state. It is
> thus an important part of mitigating races with a concurrent process
> that updates the same set of references.
> 
> When writing reflogs though we explicitly unset that flag. This is a
> sensible thing to do: the old state of reflog entry updates may not
> necessarily match the current on-disk state of its accompanying ref, but
> it's only intended to signal what old object ID we want to write into
> the new reflog entry. For example when migrating refs we end up writing
> many reflog entries for a single reference, and most likely those reflog
> entries will have many different old object IDs.
> 
> But unsetting this flag also removes a useful signal, namely that the
> caller _did_ provide an old object ID for a given reflog entry. This
> signal is useful to determine whether we have to resolve the refname
> manually to figure out the current state, or whether we should just go
> with what the caller has provided.
> 
> This actually causes real issues when migrating reflogs, as we don't
> know to actually use the caller-provided old object ID when writing
> those entries. Instead, reflog entries simply end up with the all-zero
> object ID.

Ok, if I'm understanding this correctly, the `REF_HAVE_OLD` flag is also
required to actually record a provided old OID in the reflog entry. If it
is not set, a NUL OID is recorded instead.

> Stop unsetting the flag so that we can use it as this described signal,
> which we'll do in a subsequent commit. Skip checking the old object ID
> for log-only updates so that we don't expect it to match the current
> on-disk state.

Just to clarify, when migrating reflogs, are these operations always
marked with `REF_LOG_ONLY`? The comment for that flag states:

  Used as a flag in ref_update::flags when we want to log a ref
  update but not actually perform it.  This is used when a symbolic ref
  update is split up.                                           

I might be misunderstanding this though.

-Justin
