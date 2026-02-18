Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2DC34405F
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 19:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771443625; cv=none; b=BY8Km0QUHv0bRwIQN7pHAWXOzZ9EQ8dppWIIZnK+sk+OVc03R+eucK4YP9nCL5PbmPideZuHXFIyjRDj9BdSIqzjPd1Iyx7SWC1vAAUpomvYDJ7S3u+xJzx9cKOIe/EMA8peRgxcWT3S4Yf77TBGeKDjwYixahvIxj3jC6nPSEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771443625; c=relaxed/simple;
	bh=p79E6VpEeOiUcYx/s7o4AtipsaHhGnSvzRR+nFSCszM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pluwy+V3BYumIMj5y25HmizIZXLAyvhIBKnzM6ZDzLtRpxKQvU2e2T7AyyEwo9TOPU6g2uuIESylj2TNxTKp7M3DIoMma1/hUTkbtWJ5rpmRhtLspg6Iy4vZr02UCjH9YdWwT71wbHtYo5GjdebMjz9Of6PbHQqkPld1n6rWOQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/vVgw96; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/vVgw96"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-45efd53148eso71588b6e.0
        for <git@vger.kernel.org>; Wed, 18 Feb 2026 11:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771443622; x=1772048422; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tZq/FtgQfWBDghNXIV6jpfhgMIHiEJpuI1pTy1/RgqI=;
        b=j/vVgw96xghKl8mtvjyf6rO4hNk2MkBOKmpA861GjBQQKaxc5WUjI+JWah6aNFWS/I
         YUsdffsNakwgK1ifS1Os6fHngHzwMekUdkm8yapUx7by44aOMaBbQ21OeshX6gxg0GtR
         r6aHor8wgsnXn3w4fNjVTcEJPIe2dE7uSDaDSZC+X4sPzmeQqyhMrvuZ8KHggbpfDYUI
         E7UcYEsQGfJwRQ+uWdUSlJt5iFQJh1wYwprCf/0L21PK8+NDxcWZqPyrw0HNVHG5/JWk
         trLBjRxdueIaPviyqSodD8CsNubC9+qRWv1s1hg9mDIdSFWWx3H32DiUKQAxjUm1xNj1
         Qdaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771443622; x=1772048422;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tZq/FtgQfWBDghNXIV6jpfhgMIHiEJpuI1pTy1/RgqI=;
        b=gRI8aCyoDBeYyjAXAoKH0uqnOKLJOkI9aSUa1cd1APngY2qXC2pssqc6f6v00nuB1F
         lMko2wyS21q6A5sS4ymaZD+YlyNHlLdGRY62YrwOqU9Qx2oz3eEWd/QphFt62rTAdTcr
         S7g4UeJ/AA7CXyGmz0ZXPe/5lRi8qyx1YFuR94hQh8/D7jCZ6OSyHzIX6cG1+z6RBn5D
         izB/cI1T7oAgyFDRoshsRo+llX10tCOQUHLxdxSEHQCuaQCcVG7Ipy0ZH5XkEJQXOCjW
         3bSYv8VK1LGKayeJDQtMh9kc/wzgrJ6F0hzmxxvGSCCEvLsQ+F1vj1wjWw6KC54IAEsG
         bhwQ==
X-Gm-Message-State: AOJu0YysoNXtQxWreL2hsJ44/4WcOm+ebRHLspKthtLDRzSE1GI4x+9s
	rbtwgFv0YCVfvjpxdIvpO57Rrox+jxOdGETWF1Hs3e0hnZiwE112Ch/c
X-Gm-Gg: AZuq6aIKyNdgFIg/RwjZugD7DZQsy8Hgb3waC2tKL+L9HRJTahyzR6m0fT1lYreBvJO
	ZuM1EAacAPNvXR9jL/oO+yXHHfHTNiLOPXiM0remf8sasejAOm2BIu9PyxhKE9mm1FZWMVUcF/L
	erkXvlfvdMXV7aOp4b5ndhQABXdoyLM7ner/LvxQcej85x6ytrHgsbmHeUVMB3J4IkzNS1L62AN
	fPLqXdZ5gwUfB9eNxclpzhLikhD4oFtx7vyBCk+V0J+ZYvAPHTb/PO8pOV4/7Tuk39Qt5O1rZ0G
	yf8thdBC7oiCndMeA/gj02FBQBiS6bV5ny06UXVkqP/pA/8uqtpZ7I1R+zAUdeOSDhk5x1XUVLl
	R5Scw0XmmNd9wMdsMpoXgF5hDHP6JA4NxACtCsw3F1+VCfVdVSpUJHbIZjCL3dvNGCmWUVQzPHu
	OSjIP5R6zOSPyU1+X1
X-Received: by 2002:a05:6820:2009:b0:66a:9d34:6cc0 with SMTP id 006d021491bc7-6785989b327mr7748704eaf.27.1771443622553;
        Wed, 18 Feb 2026 11:40:22 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40eaef220cesm20696205fac.9.2026.02.18.11.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 11:40:22 -0800 (PST)
Date: Wed, 18 Feb 2026 13:40:21 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/5] builtin/repo: update stats for each object
Message-ID: <aZYUwjSEAcGRSXNa@denethor>
References: <20260203221758.1164434-1-jltobler@gmail.com>
 <20260203221758.1164434-2-jltobler@gmail.com>
 <xmqqzf5pqwtm.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzf5pqwtm.fsf@gitster.g>

On 26/02/03 02:36PM, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > +		switch (type) {
> > +		case OBJ_TAG:
> > +			stats->type_counts.tags++;
> > +			stats->inflated_sizes.tags += inflated;
> > +			stats->disk_sizes.tags += disk;
> > +			break;
> > +		case OBJ_COMMIT:
> > +			stats->type_counts.commits++;
> > +			stats->inflated_sizes.commits += inflated;
> > +			stats->disk_sizes.commits += disk;
> > +			break;
> > +		case OBJ_TREE:
> > +			stats->type_counts.trees++;
> > +			stats->inflated_sizes.trees += inflated;
> > +			stats->disk_sizes.trees += disk;
> > +			break;
> > +		case OBJ_BLOB:
> > +			stats->type_counts.blobs++;
> > +			stats->inflated_sizes.blobs += inflated;
> > +			stats->disk_sizes.blobs += disk;
> > +			break;
> > +		default:
> > +			BUG("invalid object type");
> > +		}
> >  	}
> 
> The repetition above makes me wonder if it might be a better
> organization to have
> 
>     struct object_stat {       
>         struct type_stat {
>             size_t count;
>             size_t inflated_size;
>             size_t disk_size;
> 	} tag, commit, tree, blob;
> 	... possibly other members ...
>     } *stats;
> 
> or even
> 
>     struct object_stat {       
>         struct type_stat {
>             size_t count;
>             size_t inflated_size;
>             size_t disk_size;
> 	} t[4];
> 	... possibly other members ...
>     };
> 
> and have this part of the code be
> 
> 	struct type_stat *t;
> 
> 	if (OBJ_COMMIT <= type && type <= OBJ_TAG)
> 		t = stats->t[type - 1];
> 	else
> 		BUG("invalid object type");
> 
> 	t->count++;
> 	t->inflated_size += inflated;
> 	t->disk_size += disk;
> 
> but that is probably only because I am looking at this part of the
> code.  Other parts of the code may have good reasons to have the
> structure nested the other way around like you have.

Good suggestion. Some of the info added in the following commits is
object specific and will need to be handled accordinly, but we could
probably still benefit by structuring the data a bit better. Will
explore in the next version.

-Justin
