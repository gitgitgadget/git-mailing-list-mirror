Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9845882D66
	for <git@vger.kernel.org>; Wed, 27 Nov 2024 17:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732729153; cv=none; b=py1HFlSZLwCq2J6MAVXXrK5+e5270w44fNpKIekP/MtCigdXbRuMtBJZC+orRY301DDGn8OfuZWuWKqLBbgtR+ktS75Lxe7z2T9iYPYLJUNLIzlpathmzl9ywVA9vRwTQvNQS+ZEUBcKWJwcS5v8vB+BLxlBAKaMh0lL2yVXytc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732729153; c=relaxed/simple;
	bh=WHsckHu8KhWtQsZToDPEPy1Ah9Y6PSqbHahWnwb0o4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SSCrHMQOQvXfDixVRN/8zGj2WuEYbj7rQzrPlcr0YR71czMtxBvzWakXLqDcLxBRvAHmlTvnunFdyTTg290mtTaesV0prLR6hKUal/ZPU2Xn2vvpyYLIO2TKnFy7pTg4ATSMRhN5hxOQq5rYm3TSFMn4FmGFgg8NocwsgXNC9oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ICD1tcUd; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICD1tcUd"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5f1ecd0d9ecso1605664eaf.1
        for <git@vger.kernel.org>; Wed, 27 Nov 2024 09:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732729150; x=1733333950; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FUo4Az13bb2P52kQ7ep6wJl/mdTOXw3gJnSMhnx/ZOo=;
        b=ICD1tcUd7qNFTB2D8c74fmr9seyQgS9oSR2uM0rpiuWd+9dX/y5FwHTs5NmeRK2xyX
         HWsdEe2epzGq5qV1lGhT+g+bA4L4mwJX0/I2uNBDpUuron9T7rTINSIevz/182BXX+hf
         Wy113f9/GxQFeuuqqJDrI9NlMLdB1jT0Umdf5Z6ptV7t7vhewsL2j+l+4tZ9aiZxXkSD
         zsmshJW5MUIGnm+nKo8pDePxXzj/4Fzb2XWb6TsJP+b34FTsES0F9cNk4iLRZlXnY3nX
         j7hCRLmntspHm8AWT7o27wcUynSpu1CtfE92mUmypJI9M3jYIgmJE1KWR6zmFyPIG65y
         uUPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732729150; x=1733333950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FUo4Az13bb2P52kQ7ep6wJl/mdTOXw3gJnSMhnx/ZOo=;
        b=B1eytPmpFubKZufy+KpIQo3f6F2P0bR9OgvjRyjSJmIBNtrkkg//6BKZtLiNGYWXtl
         NjlUPtT6xGv01DyXgk8IEEcIs+JvAGjfJwoOvtPQehXANo6/YlItsj5yAbpx1bd2susr
         fu32uOqH7gMB5oBG2GiKcIDYMSlg/sievK4AcALVUGJrl4DLhTtSw9Evz7Hs3Yc8ZVtN
         NlhEU5dlxTym2UifFt+GG3kHZolpgQaIGSoIkQj8nx9pQh08k2BAPOCGf2oW0uqbRr/O
         S7haC2B9DBuMCUEiw7a43gj6SXdfNyfbaI8+7GQEr0u7hpds5QDII3TGRa3UbYOdUZjT
         StEQ==
X-Gm-Message-State: AOJu0YxjRZYaWlenrxqsUzpYPP/S6C4FK1iowKUzRVvhKKFykgyg6Hnz
	q7zwMF3lDHarTdU+0+KqzY1z5//ubPVCzAFKK3syTHC4kOkELeOcFod/4g==
X-Gm-Gg: ASbGncsHYhXR7Cz1aEUMfC3OSeRKtO8aQ0ISaCvwMXuBbbRpDbpHljXt8Me+zbCuGOE
	Ker9z4mF654w+kRJpeJ05MU2R9eqE8wYQM4ZxxTl0zUzn8qBlVk6zOGH60MFtOpVppmnH17rGDz
	kV5+XvwVzddphzHE/5cvNeYXJoalGmbwelu5AilguiX2519YSA8J1FVZ7ANNYDFVDioe5PlA5p+
	CXIwJdFKV89HXuoJ1gh7OYm/87bH162d1VyQorzF1c=
X-Google-Smtp-Source: AGHT+IFcKwvF640sTcY5YVfM/xeJzLlc3ivPq8pQnqBi3EfEHViErzPxX79R1FdCapm0HZ2NN7I9aQ==
X-Received: by 2002:a05:6820:1e12:b0:5ba:ec8b:44b5 with SMTP id 006d021491bc7-5f20a1db85cmr3648908eaf.3.1732729150582;
        Wed, 27 Nov 2024 09:39:10 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5f1fe4c1aa5sm1234455eaf.22.2024.11.27.09.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 09:39:09 -0800 (PST)
Date: Wed, 27 Nov 2024 11:37:12 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 3/4] fetch-pack: split out fsck config parsing
Message-ID: <lqlchznj3gkvne3zqquz2elky36ubgh7y4n7m7wem5o3tad4bd@bvyjficofawj>
References: <20241121204119.1440773-1-jltobler@gmail.com>
 <20241127005707.319881-1-jltobler@gmail.com>
 <20241127005707.319881-4-jltobler@gmail.com>
 <Z0ax0_SDtinH6zCY@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0ax0_SDtinH6zCY@pks.im>

On 24/11/27 06:44AM, Patrick Steinhardt wrote:
> On Tue, Nov 26, 2024 at 06:57:06PM -0600, Justin Tobler wrote:
> > diff --git a/fetch-pack.c b/fetch-pack.c
> > index fe1fb3c1b7..e7d4f6e6e2 100644
> > --- a/fetch-pack.c
> > +++ b/fetch-pack.c
> > @@ -1877,14 +1877,24 @@ static int fetch_pack_config_cb(const char *var, const char *value,
> >  		if (!value)
> >  			return config_error_nonbool(var);
> >  		if (is_valid_msg_type(msg_id, value))
> > -			strbuf_addf(&fsck_msg_types, "%c%s=%s",
> > -				fsck_msg_types.len ? ',' : '=', msg_id, value);
> > +			strbuf_addf(msg_types, "%c%s=%s",
> > +				msg_types->len ? ',' : '=', msg_id, value);
> >  		else
> >  			warning("Skipping unknown msg id '%s'", msg_id);
> >  		return 0;
> >  	}
> >  
> > -	return git_default_config(var, value, ctx, cb);
> > +	return -1;
> > +}
> > +
> > +static int fetch_pack_config_cb(const char *var, const char *value,
> > +				const struct config_context *ctx, void *cb)
> > +{
> > +	int ret = fetch_pack_fsck_config(var, value, &fsck_msg_types);
> > +	if (ret < 0)
> > +		return git_default_config(var, value, ctx, cb);
> > +
> > +	return ret;
> >  }
> >  
> >  static void fetch_pack_config(void)
> 
> Okay, this now reads a lot nicer. But I'm sceptical whether we should
> return -1 for the case where the value wasn't handled because we now
> cannot discern the case where the function returns an error from the
> case where it simply didn't handle the value.
> 
> In fact, we cannot even use positive values right now as far as I can
> see:
> 
>   - We return 0 on success.
> 
>   - We return 1 in case `git_config_pathname()` indicates an error.
> 
>   - We return -1 when there is no value with "fetch.fsck.".
> 
> I'd propose to have a look at whether the positive return value from the
> second case is actually used anywhere. If not, we can refactor this case
> so that we always return negative on errors. And then we could further
> adapt the function to return positive in case it didn't handle the
> value.

The `fetch_pack_fsck_config()` function is only used through callback
functions for `git_config()`. The `config_fn_t` callback is expected to
return 0 for success, or -1 if the variable could not be parsed
properly. Taking a look at `configset_iter()`, in practice any return
value >= 0 is treated as success.

This means that because the `git_config_pathname()` errors in
`fetch_pack_fsck_config()` return 1, an error is printed, but the
operation is able to proceed.

  # Skip list is missing path value.
  $ git -c fetch.fsck.skipList fetch
  error: missing value for 'fetch.fsck.skiplist'
  <fetch continues...>

This skip list flag behavior is consistent across other fsck operations.
Changing it here to return -1 would make config parsing more strict and
result in a missing skip list path causing the whole operation to die.

Since returning 1 is treated as a success anyway, we could change it to
return 0. This would result in functionally the same behavior and free
up `fetch_pack_fsck_config()` to return 1 to indicate that there is no
value with "fetch.fsck.". This would allow us to properly differentiate
between the "didn't handle the value" and error cases.

I'll send another version making this change and add some comments to
document the behavior.

-Justin
