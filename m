Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6413ECBD8
	for <git@vger.kernel.org>; Wed, 20 May 2026 14:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779288173; cv=none; b=IkfUVztXFVgGNXuVVaW+0kw2GMr/Ke2Bfb6O//5p7PSVcyP+IxO5vJhveI0q4DsMrEJ97K4u8lMAsHlQpAbjK7KhDWVNp16k+cK+gU8pN6nJ/VM72tqPZ0ixaAz2mUZIRX/rwfmxVun3zqbI1FDOhK4blzvbj8qZcf+q7Sf/2Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779288173; c=relaxed/simple;
	bh=eg4wpvTkD/aq2HLczlPpxJI9xzKS6YIm4LmyaoUqYdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W/tlwEEOet8h0reB1fFpEyGdYzavqpaCq7+sQJhKW0RUrzAC10njnqRjYunubO/fluWV5udUWHOxyk0en9bsGes6gBfPkvNod3GkNWj3UvHeUQsNyy6/PrYXjYolVf68ppFlHDBYWFCe+ourFZ+IaCtZzHkUDNHYImDf5SOAzkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XSDgTPOn; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSDgTPOn"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488b0046078so44078955e9.1
        for <git@vger.kernel.org>; Wed, 20 May 2026 07:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779288170; x=1779892970; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wMEAvsjPaWClnds2AKfATbRrztkb/CzEQXcuxPuwkSg=;
        b=XSDgTPOntByU2mTx+D8CiZJyGADFXcLqWe8+YGYwGIVyiHsPLkspAOWdj3fwMXqeJr
         4njJ29emr/ModW37pt7q0OIdkBnw0StFtsTcOvG8ydsMmmpBTWGxRcpiERfSt6gOiNPa
         1Oak6Nbq7NYDvRvgqmDRKHOQgPa6tYfpTsazw+HSL1JblIU0TfbYgMHaemCPwvDfGoXn
         qwEJsHFgrAf/MgLxiz+VibucH50LUHkObO0C3mA4yIpuYm2VBaj9a7mGeDpjDtZWwwdF
         64wrd0p+kUFbhcDZ2dISvj3156guKa6tUW/moiboDXcM9iyDJg0WZr6OE2i13u/9YkP/
         cuVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779288170; x=1779892970;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wMEAvsjPaWClnds2AKfATbRrztkb/CzEQXcuxPuwkSg=;
        b=NOo1rFI7Dk1LA2JjkPx8IFjH0KOxmP7QOL2t5BZcTH4Lze1cCZvtDdgrIJ7CYakfxP
         EqdhsBkVRJK6HFlQbw+5qexohVmuQLDGkBio3t/B80A54+mlu1gcHT8vK7eQic5oZeb+
         p3kf6+5yGEx9aGO6SgYOwDH4ABEovCxYKsG9Vj65jW8iBbKalZowXMvEArBthlwjYlpw
         j65E+23ogFkmTuA/2z5st1gdTdQU6dyaElpXEwDVCvdNQGUY2AaFJPHz6hh4CRnGnhIm
         5IvOgUOpQhTQa41sftxHnwWyaVU+slL8DH1xqNJ/kxuYMjM+YovE44sMneO+aSCSvAJE
         Kyqw==
X-Gm-Message-State: AOJu0Yy4LOXi2BQ7pNXXIUMIqKLi5jKOkOms5Ukyujc67iuTpLvgbbQI
	N+7GTuC90GozqPpJKHjnQmtDNyEm9HvaL5FaYSCSX1wcUMExfV68SR6JsnRD/A==
X-Gm-Gg: Acq92OEfI/7lbrKT37gTWrn0PaJ1s2EE6yTaxlgAJzsxBWed2XzcdPci5Gmjus5sdfN
	IK2kDfydGdcWZRp/rjfdNi+F/Lxt6h0rjbt5VIUR9QJ2t0Cf62N8Yl6CrViWvXSEbw5nmk51afZ
	oIgnmBMUWxQHuj3Wnm5MmLieScXp2pIXwJVVVN51oqFoEv+Ivv3+ej83qpqjOPEBaNpzozRlTNr
	LUwYqxrted/Ia5T9OpDNac2aOOfbZA6t43H2L6uOHo0KD2FcLKhLWlkDMtxLjoKnejA8V1geFYQ
	br4iQeG34dynKSlO0cd+CShX0HKonTLEuGkS2sR6t8cFiqneU612qGsxuCEjGGGrkPlYJAZipdC
	8ddu6RZSj+BmNYIOwpob3tDaf/w0CMnK4NrlIK5HItzFLhCAaObYnm1Kr+aKiHORVYSw+jvUntv
	7uJnphTwiWF69uV8s86ZVYYiM1Ojd1YO78Uw/X0+XEfTc6e/LFd91YvVI=
X-Received: by 2002:a5d:5885:0:b0:43c:f7e5:817b with SMTP id ffacd0b85a97d-45e5c5cc2b5mr39521724f8f.19.1779288169869;
        Wed, 20 May 2026 07:42:49 -0700 (PDT)
Received: from localhost (92-249-246-170.pool.digikabel.hu. [92.249.246.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe13b4sm54925827f8f.28.2026.05.20.07.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 07:42:49 -0700 (PDT)
Date: Wed, 20 May 2026 16:42:37 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 4/8] pack-bitmap: consolidate `find_object_pos()` success
 path
Message-ID: <ag3IXa3lKLmQC1tD@szeder.dev>
References: <cover.1779207127.git.me@ttaylorr.com>
 <c9a560660949c53575a9b1e81160d25212a1f484.1779207127.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c9a560660949c53575a9b1e81160d25212a1f484.1779207127.git.me@ttaylorr.com>

On Tue, May 19, 2026 at 12:12:44PM -0400, Taylor Blau wrote:
> Both sides of `find_object_pos()` report success in the same way by
> setting the optional `found` out-parameter and return the resolved
> bitmap position.
> 
> Prepare for adding more bookkeeping around object-position lookups by
> storing the result in a local `pos` variable and sharing the success

This 'pos' variable will only be declared in the next commit,
resulting in an error building this commit:

  pack-bitmap-write.c: In function ‘find_object_pos’:
  pack-bitmap-write.c:227:17: error: ‘pos’ undeclared (first use in this function)
    227 |                 pos = oe_in_pack_pos(writer->to_pack, entry) + base_objects;
        |                 ^~~
  pack-bitmap-write.c:227:17: note: each undeclared identifier is reported only once for each function it appears in
  make: *** [Makefile:2917: pack-bitmap-write.o] Error 1

> return path between the packlist and MIDX cases.
> 
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  pack-bitmap-write.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
> index 651ad467469..6483fdc7daf 100644
> --- a/pack-bitmap-write.c
> +++ b/pack-bitmap-write.c
> @@ -224,23 +224,22 @@ static uint32_t find_object_pos(struct bitmap_writer *writer,
>  		if (writer->midx)
>  			base_objects = writer->midx->num_objects +
>  				writer->midx->num_objects_in_base;
> -
> -		if (found)
> -			*found = 1;
> -		return oe_in_pack_pos(writer->to_pack, entry) + base_objects;
> +		pos = oe_in_pack_pos(writer->to_pack, entry) + base_objects;
>  	} else if (writer->midx) {
> -		uint32_t at, pos;
> +		uint32_t at;
>  
>  		if (!bsearch_midx(oid, writer->midx, &at))
>  			goto missing;
>  		if (midx_to_pack_pos(writer->midx, at, &pos) < 0)
>  			goto missing;
> -
> -		if (found)
> -			*found = 1;
> -		return pos;
> +	} else {
> +		goto missing;
>  	}
>  
> +	if (found)
> +		*found = 1;
> +	return pos;
> +
>  missing:
>  	if (found)
>  		*found = 0;
> -- 
> 2.54.0.rc1.84.g30ce254312c
> 
