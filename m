Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA38145324
	for <git@vger.kernel.org>; Fri,  1 Nov 2024 19:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730487647; cv=none; b=YVTejYEYRz0hJo0KtsggwoPod0XETSX86/6gGmYaa5m6uNPHi+iX0Gn6BnghmFIa98GK3GE0tixlrl61Eg+aisG8Tq1I6mJ2a0BsSxmT9FGbN659bVDa5+HJI7FGUkY8PIESKKOy7yhiAZUYh1FpA1cyT5M9dufgUmq3bivuRkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730487647; c=relaxed/simple;
	bh=sHAVVANFHhKqwz2ODhH87TxaVQIcvfR5wJv4dQU9Thk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OaKoQqpxKKMvsvUG7kYxH9sXWfmyHcHVNeo3g8T1s4JHf85Y3vAUot6TvB5i+OVmeIPnqjOlOIO10BSLplNTJmO8k2U6Z3nPoWcO5Njhofoa6Ce5++WrmVNa51m0lH8rTj3NbqXV+0XJh64y9QLV1wWaPDpmvOpqRfftnecNbdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=zgxIPS7G; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="zgxIPS7G"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6e5a5a59094so21492527b3.3
        for <git@vger.kernel.org>; Fri, 01 Nov 2024 12:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730487644; x=1731092444; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OSFNWrI5Wex963NsjRS9ZngxcbJJPb+qHMuXGCY71D8=;
        b=zgxIPS7GNPzDIgnFjpvrrMB6OkEqyP25mNZvxfsgRmKoXJsA/TTvSSkvOBFl+XSwbD
         +enU0HBUOC72TYlvfMvy8OY/CqvOYkLvXSnbseU+pfsHSLqAOVcWAjR8UtMkDmxaIS2C
         tB4ff1CpgKt5uJz+r81S7yw8nsRCGJhrYy+cZyfDpNKDJEPa2dKUrQPJdx3hQuG6CVY0
         yYagG8IwhL9IkZxm67hPDorPiBOxIZYEQTEwUEvBa3h+bcinw8nDIH+WBc0Dujy04BZt
         m//Pgtt3w85olONbtw4i0wIvnedD77KmNT398iAAt8Ql2M/hE+IribCniCQOSsf5Vf1F
         mB4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730487644; x=1731092444;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OSFNWrI5Wex963NsjRS9ZngxcbJJPb+qHMuXGCY71D8=;
        b=SkQTzItpGvedk7wFpvV7RL+zTaCHbZv2ZTBCA21GOnRJnXk69DjFtqkwndVNf2fsrG
         /cy0cJ6tdwIOp9ULZQrVNa1qQpTyotCHaHceXkLp1AqxkOgb+If1dpsv889w1bS1Neil
         v1wDK1brKH3PyPZ0m0iD8ebOHvDLW2tOJgQ520TvKjYK3fSzsQkHqFQzh7LBLmS80lEh
         /GNiJNqDLgEvsU9pirTbQklrY9nU+X1jBB4aWfbIf28/mlVj4NKCDFDEYPUOHnTg+Qr5
         utVzeEXtw4g5wCLk6pwfWclf75WrlPlP5IDr4bqp1u3fFB8GE1LLXl0i4xWeUCbscos6
         Tu6A==
X-Forwarded-Encrypted: i=1; AJvYcCVDKnw3omby5mBPFjowD3rNcCFOyYx3ffqgjrv6Ek/Ca+lOt9H2WoFhHnuUViwagvO+J7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKSu1MfhWWCJoa5D1RE3v5867O5ZWkc9ESpVEjy43pW0hv29Z/
	52f+Ef4fB2PQ+k53oJr9yAXDsRV/0z8JY8YknnQf1lu1emuVD2L/d88GXr47383rPuyJhFU/yDu
	3/TA=
X-Google-Smtp-Source: AGHT+IHzZAURWZ9nU8y/DJXx1zpE+bAb5B9HzKeUExNrpZJbMOT7TVOKggOIzamNwgLjff24iKOyaA==
X-Received: by 2002:a05:690c:64c8:b0:6e3:16da:e74 with SMTP id 00721157ae682-6ea64acace0mr57800037b3.16.1730487644335;
        Fri, 01 Nov 2024 12:00:44 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ea55c4de6csm7868367b3.77.2024.11.01.12.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 12:00:43 -0700 (PDT)
Date: Fri, 1 Nov 2024 15:00:37 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v4 8/9] config: make `packed_git_(limit|window_size)`
 non-global variables
Message-ID: <ZyUlVZTYEiIQkC3u@nand.local>
References: <cover.1730366765.git.karthik.188@gmail.com>
 <5bbdc7124d58526a7a2d7b3bdc807ddd204a6df1.1730366765.git.karthik.188@gmail.com>
 <20241101174547.GB2337295@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241101174547.GB2337295@coredump.intra.peff.net>

On Fri, Nov 01, 2024 at 01:45:47PM -0400, Jeff King wrote:
> On Thu, Oct 31, 2024 at 10:39:51AM +0100, Karthik Nayak wrote:
>
> > @@ -652,20 +688,25 @@ unsigned char *use_pack(struct packed_git *p,
> >  				break;
> >  		}
> >  		if (!win) {
> > -			size_t window_align = packed_git_window_size / 2;
> > +			struct packfile_config config = PACKFILE_CONFIG_INIT;
> > +			size_t window_align;
> >  			off_t len;
> >
> > +			repo_config(p->repo, packfile_config, &config);
> > +			window_align = config.packed_git_window_size / 2;
> > +
>
> Parsing config like this is somewhat expensive (remember we're going to
> hit your callback for every single config key in the system, user, and
> repo-level config files).
>
> And use_pack() is a relatively hot code path, as we call it any time we
> need to access bytes from a mapped pack! This "!win" conditional isn't
> quite as hot, as it only triggers when we establish a new window for a
> pack. But that still happens at least once per pack, more if we need to
> move the window around in a big pack, and lots more if we are under
> memory pressure and need to open/close windows a lot.
>
> I think we need to parse these values once and then store them somewhere
> with cheaper access. Can we grab them in prepare_repo_settings(), for
> example, which would cache them? We need a repo struct, but we have one
> (the same packed_git->repo you are using to call repo_config()).

Oh, wow, I can't believe that I missed this in my earlier reviews. Yes,
we should definitely *not* be calling an expensive function which
computes the same value every time in a hot path like 'use_pack()'.

Thanks for spotting.

Thanks,
Taylor
