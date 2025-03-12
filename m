Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A851CAA80
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 21:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741813271; cv=none; b=WIcWEjGnC6BVmUaYvImBVbatD9YL47N/aKEWwihYTY8Tt++pnwBtQA6JJYQDk/tKYg8A7Q4YFeTJIcryWK8b5RowPS7xTZ+OSi5Q26AaulI5n4611xBM4H3hqFphhA4asdHv7giXOEAXxBr0DyWRRyMaPFKrblPuG4/4X8d3KI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741813271; c=relaxed/simple;
	bh=NS2QOfVHdgS6AJcMbyudWyaCCCtRNlYvVwYnQsU+yWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kfGpgKltSNqlCVOzSFk9VfroHRe1YsFMKouEYlDesJ4X8UXlD952PLH2nrcaHpHr4tbFwXtqFVpcRXbqfjdUwgf5slD78qCuibiHNnYDjK9wqba258lRsiqSFoX5mltvz32ypYXAPD0HmpwqCLqMgsAzOWyw/03lCzfqN0LMUwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=eeBRLEtE; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="eeBRLEtE"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e461015fbd4so268250276.2
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 14:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741813268; x=1742418068; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OmoTTXB6wfaPEv6zO/zRq6t6WYweKcVPttwFaAkkTdo=;
        b=eeBRLEtEqdYos1+9Bztinjwlym57gFQYEUZYi3PCFDWSoWm+mdmfzN3Yva/bfMsLfB
         GJkVWRxpbl6h4Wwbd1wy+5AaNKhZIx2y9psTZAVoRNqYKI4OH2js8lv87VppL/P5l7dt
         awItegw3Q6zA0m/NZF8OCBS2A6xjW5uRBHaa5rTNSVnRE7bqje3mAZ6BgY0ILIRfm7a1
         CsklT9SmooZn76AsJhNkYl6HvAelKc8hjzFj5okHh6yVbqTRDEkKhCs4T3KnUh5ZWlZN
         khg0t8IcpvA4QW3fS5pSt/6blNFYVqS4h+vNNgg2OL71kSx03cB0cqtLfdLd+HILsMlf
         CDLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741813268; x=1742418068;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OmoTTXB6wfaPEv6zO/zRq6t6WYweKcVPttwFaAkkTdo=;
        b=ptm8Xe3SsgQbk8GvsCeWFZkowyPiYpKOxtMUWTPMOA3FDFDzc6xkugQ5KSGdSmGPtM
         uOy18pS6lhhczJVTU++N/K6YSnDhL371qxDf8hmxgTzdw0sbL5VyfHroAVrS9ObvwWl/
         0V3Hw+zHJpugnPbfjImL34NiOY0F4LLmp7oYv7JyDIdpMtMV7uctgxxh1fe3oaFpxeLk
         tFrbXW+ojoLvEcha+o+OqOqtwG1TsuOBKjAS1WcBJfktv6SZqJDOkT+d5gQcVGoKpkG1
         Y8f40OPaEMfPtblw6047/ieEqu7+AtPHsZ4l2DMIrNbHGdQd8VXYZ9AqR3aM5JfPjW6s
         fafw==
X-Gm-Message-State: AOJu0YzXZY91hy9QL1mupf4a4n+voOX0nIEX6L4yQQ/CJmDflgluASq+
	mKGobphrNOJPioUICM0cbAarAVkzKW5NtY2rpPNWewtQr91WPn+4lXPuCYbzaiU=
X-Gm-Gg: ASbGnct2o2m9hPVrC9UWqjzPzhWGcv9sxnEBNaxfHV7MMx8u8K/+hpvgR7HCYoUEnBn
	XXGfEhn+wQf/F00sofl/E2twlpTiu4Du53lrpgC0S0HgZo195lND0KOAmnRhvjK6O81j0PNOfJZ
	s5eo8Z60HBdl2mo57vodiButGBKXFMt+LSdRVfj6+fzTK+jwLuCIlw6XsCopU2JWWAPw/wjA8uL
	1I2rEZpbk8pfdRFQT5LtSLsEbpSVNbY5YmMqooNm2DSFDAqK6invpnjWqjbySupBMOHObExhxp7
	qaz/5w2DNLuepuz9cAGvNwpoVXgLUQSD4t9x02wKDqlhUmTR97LwegjxQcVXz6I954Wi8HKma1F
	YQHqe1OqL1JKbDS02AGuv1wv7JWM=
X-Google-Smtp-Source: AGHT+IH2bQNWz3Js4ps9nVDOx0oYxFpMZeTQNoMReNZpm13MucPZVsDEyXanQEV6ej+nx1aaBT1ZBg==
X-Received: by 2002:a05:6902:2ec2:b0:e63:6758:6a00 with SMTP id 3f1490d57ef6-e63c5c4f3aemr4516255276.3.1741813268373;
        Wed, 12 Mar 2025 14:01:08 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e63b54ace28sm1152589276.34.2025.03.12.14.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 14:01:08 -0700 (PDT)
Date: Wed, 12 Mar 2025 17:01:07 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
	johannes.schindelin@gmx.de, johncai86@gmail.com,
	jonathantanmy@google.com, karthik.188@gmail.com,
	kristofferhaugsbakk@fastmail.com, newren@gmail.com, peff@peff.net,
	ps@pks.im, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 01/13] pack-objects: extract should_attempt_deltas()
Message-ID: <Z9H2E9hEWgaS9NnP@nand.local>
References: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
 <a2ed1f2d4e3946c563f934fcaf149050d50f255f.1741571455.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a2ed1f2d4e3946c563f934fcaf149050d50f255f.1741571455.git.gitgitgadget@gmail.com>

On Mon, Mar 10, 2025 at 01:50:43AM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <stolee@gmail.com>
>
> This will be helpful in a future change, which will reuse this logic.
>
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>  builtin/pack-objects.c | 53 +++++++++++++++++++++++-------------------
>  1 file changed, 29 insertions(+), 24 deletions(-)
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 58a9b161262..1d0992a8dac 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -3196,6 +3196,33 @@ static int add_ref_tag(const char *tag UNUSED, const char *referent UNUSED, cons
>  	return 0;
>  }
>
> +static int should_attempt_deltas(struct object_entry *entry)
> +{
> +	if (DELTA(entry))
> +		return 0;
> +
> +	if (!entry->type_valid ||
> +	    oe_size_less_than(&to_pack, entry, 50))
> +		return 0;
> +
> +	if (entry->no_try_delta)
> +		return 0;
> +
> +	if (!entry->preferred_base) {
> +		if (oe_type(entry) < 0)
> +			die(_("unable to get type of object %s"),
> +				oid_to_hex(&entry->idx.oid));
> +	} else if (oe_type(entry) < 0) {
> +		/*
> +		 * This object is not found, but we
> +		 * don't have to include it anyway.
> +		 */
> +		return 0;
> +	}
> +
> +	return 1;
> +}
> +
>  static void prepare_pack(int window, int depth)
>  {
>  	struct object_entry **delta_list;
> @@ -3226,33 +3253,11 @@ static void prepare_pack(int window, int depth)
>  	for (i = 0; i < to_pack.nr_objects; i++) {
>  		struct object_entry *entry = to_pack.objects + i;
>
> -		if (DELTA(entry))
> -			/* This happens if we decided to reuse existing
> -			 * delta from a pack.  "reuse_delta &&" is implied.
> -			 */

It looks like this comment went away when this part of prepare_pack()
was extracted into should_attempt_deltas().

> -			continue;
> -
> -		if (!entry->type_valid ||
> -		    oe_size_less_than(&to_pack, entry, 50))
> +		if (!should_attempt_deltas(entry))
>  			continue;
>
> -		if (entry->no_try_delta)
> -			continue;
> -
> -		if (!entry->preferred_base) {
> +		if (!entry->preferred_base)
>  			nr_deltas++;

Makes sense; should_attempt_deltas() doesn't itself change nr_deltas, so
we want to do it ourselves here. Looking good!

Thanks,
Taylor
