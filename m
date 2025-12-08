Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5B0238C33
	for <git@vger.kernel.org>; Mon,  8 Dec 2025 22:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765233473; cv=none; b=Z0J9XMR66vo9eq46rmy3Jp43I5/P4sFw9IaNgLtPsg/k9eeQSfcA4xeQbWPSFrUWo64EGdwtE+kOy5FAVwK1EsZm0yL+75nygym1wNUJCy6oeL4pNG3wjLRmvAj1pc26UK+euT5HnffG6SUF3PNSSLJKmtJNmQ2Tu5ShX37OQHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765233473; c=relaxed/simple;
	bh=NRKrwEWAyuVDmsc8tUopWaU6UgPJVFkm3qrbU6qbCYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Brf9QdLFUL0dNQ0HivcGOTSWbwtzKprzGI+n/aEKoiddIZ2OP8uula8/XrfecIviHR25t9AKGxxTqxML0aX0wNk3ZqM8xKDY4qZtnMJ+x0Ae749UicJ/kNerVXGmB1Qq3ycjhykuzKRSupM1B+eVgWhy2b9fwXSs9EnDNbVi3lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OVC83AJ6; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVC83AJ6"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7c6cc44ff62so4205701a34.3
        for <git@vger.kernel.org>; Mon, 08 Dec 2025 14:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765233471; x=1765838271; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CR3+XieTG2kX2zEA+6qcRJUnag+3+w7RO0HBpS1c2lk=;
        b=OVC83AJ6XPuMYfQtesFrEQiyTrTZ6UErcDjrWcmyD+eED2v5pvSk5M54g+PqCT90/B
         sR0CcEibzeOMODx8n1z19Nv+F3iTsEPMxTY8s/JRyQ3ExUV0aXr45KSh5fKuDpwyEweV
         sOK/N7sxJCfrSkyH5khCimgsNFo4FMt66ZUbB98OPftfCRwNugUEkBboxcEUH21oPsRl
         2WfIfn7cB/ULb8jSauuGi6SFz4bgqT17E119NKk8lCfH2vxF4jP16OiQ9NmINyRTafC9
         C5FuiN1TQ27YA+goW9g7PDfi+J46fhkSbTRFGOtTRqPz1X7wig7hSDO57JXUb29/deo5
         8iqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765233471; x=1765838271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CR3+XieTG2kX2zEA+6qcRJUnag+3+w7RO0HBpS1c2lk=;
        b=hgVyauBMT8aWj4TQu9AN4HvtKAYs6IOVKZddSxpXhxJjqXzq43fj0wNjz14F3DXiTg
         dbW6fab06KAIaRUFpcapO1p51zYyTOmAhgWu+/Hske9yvydVl466QqWX5gMnbCn85Xwd
         VnvZo11NOW2sDPx6YIDfTgzjRuXtddAZRCgvxMQfOq43LWkdBTlN40s4fXgsIc4ki4l3
         DS3cEferhJo7qBJtrKaDf5b36rlM0vOBUPq5mI3fxe13N4vs9ySFpRA9DgiALsZz1zTR
         zwnWAxef9VMsjB3t8K8iEynbkcKp54xviYraw0FeMPjcbgUXMSFOHCnyhoE6g1wNSPAj
         Inmg==
X-Gm-Message-State: AOJu0YwTNVssN2lv7dMGhnHNqH7VbITDWQ4raW042cEPT50rGvdRRjD5
	mI2xhizXJ9cEB9mGJPXYuxRh+rGiOd93YN4R8+3l4VyXZ92NC1kXCBMnadYLPg==
X-Gm-Gg: ASbGncukg/CVfsRhIbyADVJubg9rGg2gDup6meBGCc6X0XFp2N7VqXd4K8d47SQgP3K
	+IPRjHGnhjBebUkCsHD/B9o+Dfovxbms+eWRk9dLExpNfNMHBgAorVUTjjgSXrMItjI61WOm49n
	7piXKBA9c0eVQ6I7ce2f9pWFrxGvVvP1BWArelt7v/Rd2SGu3cz7c4RTJSJGvmDj5e3DlnykTqA
	zbDySu9/jJGwXHbYxQGG8im/TvdtevFCJzJ3ymejuiWD6ld0Yu/y1UOGDzZvMdcCLsll2tIkQyZ
	YuEpfmKeYCQSqF9okrWM2OwyOvaMCbzeZ0rRsyaMuVDqlQ0uJ8umaIap4z6YUNXTDyiG3n12V4Z
	sRoBYWPCYOdkUtZVwBrv39SJgENcCijav9l8FRSJDLOnR8wiUSeGpMNt+SRSxjGq5l/OgChTxTR
	ySNiPW
X-Google-Smtp-Source: AGHT+IHEBoYe6N8Bd+ULiCZe/ddUk8kShMfajPez2wBXq9E1W8mvC9V5ssXrB+paNw3/IN5zuXVpVw==
X-Received: by 2002:a05:6830:3112:b0:7c7:586c:846c with SMTP id 46e09a7af769-7c9707fddf9mr5437064a34.19.1765233471261;
        Mon, 08 Dec 2025 14:37:51 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c95a91d96bsm10918476a34.8.2025.12.08.14.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 14:37:50 -0800 (PST)
Date: Mon, 8 Dec 2025 16:37:47 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/8] odb: refactor parsing of alternates to be
 self-contained
Message-ID: <yjpy5yitklzq5pyvrmpsd7wq3i55e53vhkt3f34bjguwbewqbz@rctteyqvvm7t>
References: <20251208-b4-pks-odb-alternates-via-source-v1-0-e7ebb8b18c03@pks.im>
 <20251208-b4-pks-odb-alternates-via-source-v1-1-e7ebb8b18c03@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208-b4-pks-odb-alternates-via-source-v1-1-e7ebb8b18c03@pks.im>

On 25/12/08 09:04AM, Patrick Steinhardt wrote:
> Parsing of the alternates file and environment variable is currently
> split up across multiple different functions and is entangled with
> `link_alt_odb_entries()`, which is responsible for linking the parsed
> object database sources. This results in two downsides:
> 
>   - We have mutual recursion between parsing alternates and linking them
>     into the object database. This is because we also parse alternates
>     that the newly added sources may have.
> 
>   - We mix up the actual logic to parse the data and to link them into
>     place.
> 
> Refactor the logic so that parsing of the alternates file is entirely
> self-contained. Note that this doesn't yet fix the above two issues, but
> it is a necessary step to get there.

Looking at the existing code, parse_alt_odb_entry() only reads a single
entry at a time and relies on link_alt_odb_entries() to call it in a
look to get all alternate entries. I agree that handling alternates
parsing on a single file in one place is a bit nicer.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  odb.c | 70 ++++++++++++++++++++++++++++++++++++++-----------------------------
>  1 file changed, 40 insertions(+), 30 deletions(-)
> 
> diff --git a/odb.c b/odb.c
> index dc8f292f3d..9785f62cb6 100644
> --- a/odb.c
> +++ b/odb.c
> @@ -216,39 +216,50 @@ static struct odb_source *link_alt_odb_entry(struct object_database *odb,
>  	return alternate;
>  }
>  
> -static const char *parse_alt_odb_entry(const char *string,
> -				       int sep,
> -				       struct strbuf *out)
> +static void parse_alternates(const char *string,
> +			     int sep,
> +			     struct strvec *out)
>  {
> -	const char *end;
> +	struct strbuf buf = STRBUF_INIT;
>  
> -	strbuf_reset(out);
> +	while (*string) {
> +		const char *end;
> +
> +		strbuf_reset(&buf);
> +
> +		if (*string == '#') {
> +			/* comment; consume up to next separator */
> +			end = strchrnul(string, sep);
> +		} else if (*string == '"' && !unquote_c_style(&buf, string, &end)) {
> +			/*
> +			 * quoted path; unquote_c_style has copied the
> +			 * data for us and set "end". Broken quoting (e.g.,
> +			 * an entry that doesn't end with a quote) falls
> +			 * back to the unquoted case below.
> +			 */
> +		} else {
> +			/* normal, unquoted path */
> +			end = strchrnul(string, sep);
> +			strbuf_add(&buf, string, end - string);
> +		}
>  
> -	if (*string == '#') {
> -		/* comment; consume up to next separator */
> -		end = strchrnul(string, sep);
> -	} else if (*string == '"' && !unquote_c_style(out, string, &end)) {
> -		/*
> -		 * quoted path; unquote_c_style has copied the
> -		 * data for us and set "end". Broken quoting (e.g.,
> -		 * an entry that doesn't end with a quote) falls
> -		 * back to the unquoted case below.
> -		 */
> -	} else {
> -		/* normal, unquoted path */
> -		end = strchrnul(string, sep);
> -		strbuf_add(out, string, end - string);
> +		if (*end)
> +			end++;
> +		string = end;
> +
> +		if (!buf.len)
> +			continue;
> +
> +		strvec_push(out, buf.buf);

We parse entries in the exact same way as before, but now we read all
entries into a strvec up front. Nice.

>  	}
>  
> -	if (*end)
> -		end++;
> -	return end;
> +	strbuf_release(&buf);
>  }
>  
>  static void link_alt_odb_entries(struct object_database *odb, const char *alt,
>  				 int sep, const char *relative_base, int depth)
>  {
> -	struct strbuf dir = STRBUF_INIT;
> +	struct strvec alternates = STRVEC_INIT;
>  
>  	if (!alt || !*alt)
>  		return;
> @@ -259,13 +270,12 @@ static void link_alt_odb_entries(struct object_database *odb, const char *alt,
>  		return;
>  	}
>  
> -	while (*alt) {
> -		alt = parse_alt_odb_entry(alt, sep, &dir);
> -		if (!dir.len)
> -			continue;
> -		link_alt_odb_entry(odb, dir.buf, relative_base, depth);
> -	}
> -	strbuf_release(&dir);
> +	parse_alternates(alt, sep, &alternates);
> +
> +	for (size_t i = 0; i < alternates.nr; i++)
> +		link_alt_odb_entry(odb, alternates.v[i], relative_base, depth);

Now with this impletation we parse alternate entries up front and then
iterate through each of them to link. Linking may still result in
recursive alternate parsing if further alternates file are defined.

Looks good so far.

-Justin
