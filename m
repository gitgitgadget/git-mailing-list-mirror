Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEA8287515
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 21:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758059573; cv=none; b=iM0m+0HcJPAS1pu1LOY4Zd6esbU9c5bjD0xEp3AYagW9myTb2RCmnZQ4PMocTimtXS2cDbsSo5E47vOF59d6ZdeUhrbN9/8VzhFp/0jy1l3ND91C7RlRhpAVqrB2JMqXU2ia8YRLbW1oEbAamTS6VFphxWLvsRz98YvaEwZY5x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758059573; c=relaxed/simple;
	bh=0kADzIa063whXCndYuy5tnedUB2xZeKCWZTpQHf/GqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aUHXOZ9jOqPpWzhmi0J0h9myKdDkRroAxZjKWwPOnlmvw0TIGEj+g/Z6QtokljKiyQpGQIFHwNF29pJm/SPMNRY2byft4fwxOHIgxE7/z7g3YxrqCre5Mhyl3XfqMbyBUJig43i6h4mMvfLYv6RUFMWL190IKvMbD9vsnqOEof8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ODdH1o5d; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODdH1o5d"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-32a9c1d2b95so3479266fac.0
        for <git@vger.kernel.org>; Tue, 16 Sep 2025 14:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758059571; x=1758664371; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ylhqEc+ETu2NyvyrP43X1lX4RVQXZJ0+aXF1thLy0aE=;
        b=ODdH1o5doDkxA+XwpThCgcERgm6XcICaaqxsArqjX8wwvf0NBtKHqMAOeiOTV5KMin
         wvb27E75pvfImm1u4byIV7CYTEoGxH8bFVvffsR62apu+q/hH3hZqYzAHH8I5TkgK3qO
         /BjGIZUHseLIh9mWH0dCOFMpD4vs/7kjwpOIbrKOTY34AazcSJtBknV7ubbMLhaY8jz+
         mnzJWERdAeiJEOVZDYxIhGNTciVYSwwVGVN1bIMLazySfRlVmIsfd8BTL+BXcyaQOsuu
         Ticj7BDVtMD6daje9ByXR4T5+zlUdE5rNnoGtDe/0cW8QYYFFHHIwDWFU+UZkU48Te+I
         nC/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758059571; x=1758664371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ylhqEc+ETu2NyvyrP43X1lX4RVQXZJ0+aXF1thLy0aE=;
        b=vyuXxKj9puMRJPFDfxgwxQPsOES9ZtQcfaj7ngp2saTmPnaozgJEFphDKFZ6FasuXm
         eg183+LmrbUuTIojhCZWS5y+1lGgt3W/Ojgr8cc+vxCegg81e+HOQLba+2HM7BE2ikzO
         Fe3VD2VywVcgZM60szkerJzvlkHafc4TUaiQE+3VZ/AQ/zRLBzTpJ2Gw7kjYFMYnqVfP
         0KibFjv6AAAC1IkNF6YXh1FkFIbODNTnyCGrAHyI+Vkhb141nR79fi+1C/ConxiFlW1h
         MtQQBTcxGqZuPxmC5f2nSOlLX+uapuUxzHFIbohvfDvs+Tddit5p4L2uO1a+hbZ5l811
         2OBg==
X-Gm-Message-State: AOJu0YzV2EZ07y645f6BQ/l34w+Fw5kDQwlxlwrZFwGqbJ0zU/HxGArO
	RjJDO2moG6MN3BCqMU92In6q2ZJmssAfEZMZ3hjZFu7mLH9wm05KKAPg
X-Gm-Gg: ASbGncsvTqT+QeRPxoHIVOrSYMKmNL0DXyZWAYJDe9S1lw5aPwiGJm7wZ3clXXImOF2
	i2oG6odkC3LBeENeEuGYNPzaC2VlIrg/9/zWVOVKlkVXCnYISeKtSL0dUdU+oIkB4W5XYvjDVYw
	m8iDYuKs6MCjLOWp26/xxuyLpv1b8HlemuZsrqJ9lKJ4fNQI3nBY4cDFHetrznqs1YmIRq0WYfh
	dPwxHjE0sNpu+sFSE6pTfVvXuxbSw/OYvMqIA+jdnqhvkX1Wkb93O+2WslbsWV1IrfyBljAaJQC
	yAII8hsQIqfPnMqehoI9T79Npv7eASXzikLBUPDdGHB59gGKfgT/gNtwrLxoF7vB2j+Pnoo5wdt
	6IwLwB0bIMKNZLwWT
X-Google-Smtp-Source: AGHT+IERIHzBpirSdC2cQ9XjBk6MwIiLrzvfxKUx7OJMmBvgP88VXKiKXdPlnQQMv0gX2DwFGwZAhQ==
X-Received: by 2002:a05:6871:e7c3:b0:332:b1d9:7689 with SMTP id 586e51a60fabf-335c004474dmr1817fac.41.1758059571152;
        Tue, 16 Sep 2025 14:52:51 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-32d32d5653fsm5221676fac.7.2025.09.16.14.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 14:52:50 -0700 (PDT)
Date: Tue, 16 Sep 2025 16:52:50 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, joe.drew@indexexchange.com, peff@peff.net, 
	ps@pks.im, gitster@pobox.com
Subject: Re: [PATCH v3 3/4] refs/files: handle F/D conflicts in
 case-insensitive FS
Message-ID: <bp4vpyje3ehlq2uezjmkuk5qdigi6fo73sh7eyoofvxxbau7go@oksetdbbtqz7>
References: <20250913-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v3-0-195569740b57@gmail.com>
 <20250913-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v3-3-195569740b57@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250913-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v3-3-195569740b57@gmail.com>

On 25/09/13 10:54PM, Karthik Nayak wrote:
> When using the files-backend on case-insensitive filesystems, there is
> possibility of hitting F/D conflicts when creating references within a
> single transaction, such as:
> 
>   - 'refs/heads/foo'
>   - 'refs/heads/Foo/bar'
> 
> Ideally such conflicts are caught in `refs_verify_refnames_available()`
> which is responsible for checking F/D conflicts within a given
> transaction. This utility function is shared across the reference
> backends. As such, it doesn't consider the issues of using a
> case-insensitive file system, which only affects the files-backend.
> 
> While one solution would be to make the function aware of such issues,
> this feels like leaking implementation details of file-backend specific
> issues into the utility function. So opt for the more simpler option, of
> lowercasing all references sent to this function when on a
> case-insensitive filesystem and operating on the files-backend.
> 
> To do this, simply use a `struct strbuf` to convert the refname to a
> lower case and append it to the list of refnames to be checked. Since we

s/a lower case/lowercase/

> use a `struct strbuf` and the memory is cleared right after, make sure
> that the string list duplicates all provided string.
> 
> Without this change, the user would simply be left with a repository
> with '.lock' files which were created in the 'prepare' phase of the
> transaction, as the 'commit' phase would simply abort and not do the
> necessary cleanup.

So IIUC, this also isn't related to the batched updates change and is
just an existing issue caused by case-insensitive filesystems and F/D
conflicts. With this change, we now properly detect F/D conflicts in
these situations and thus are able to cleanup lockfiles that would
previously be left behind.

> Reported-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  refs/files-backend.c | 19 +++++++++++++++++--
>  t/t5510-fetch.sh     | 20 ++++++++++++++++++++
>  2 files changed, 37 insertions(+), 2 deletions(-)
> 
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 69e50a16db..817b56f4ce 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -905,8 +905,23 @@ static enum ref_transaction_error lock_raw_ref(struct files_ref_store *refs,
>  		 * If the ref did not exist and we are creating it, we have to
>  		 * make sure there is no existing packed ref that conflicts
>  		 * with refname. This check is deferred so that we can batch it.
> +		 *
> +		 * For case-insensitive filesystems, we should also check for F/D
> +		 * conflicts between 'foo' and 'Foo/bar'. So let's lowercase
> +		 * the refname.
>  		 */
> -		item = string_list_append(refnames_to_check, refname);
> +		if (ignore_case) {
> +			struct strbuf lower = STRBUF_INIT;
> +
> +			strbuf_addstr(&lower, refname);
> +			strbuf_tolower(&lower);
> +
> +			item = string_list_append_nodup(refnames_to_check,
> +							strbuf_detach(&lower, NULL));

For case-insensitive file-systems, we instead append a lowercased
version of the reference name which gets used to check for F/D
conflicts. Makes sense.

> +		} else {
> +			item = string_list_append(refnames_to_check, refname);
> +		}
> +

-Justin
