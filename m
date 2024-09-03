Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06131CF7C7
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 19:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725393177; cv=none; b=daOWqSGjOVZMrC4eopvVhwcWrtwrvZYXwn5giXBXZQp8SoKs43ICbS70CI5KQDkUuzm+12PQEGdvyz8lDLPid726oNOwzN6TGejhPesZhTdjKVOk7ePnHVdvEmCYLilMHtr96QYJzqDKx8RxcvRBXJiTlaHASmyQdidhXz2Vv8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725393177; c=relaxed/simple;
	bh=ZkLzDQJBvsTICOfHk/xRuWJgiwHYt+RIF9VUoPKgwIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UDWm+GynSpgocAqjLzNukqWADj3xwqi+VJwluIHfu1ydKVa1V+lBZl6QmFQyI0ZnXJECo7jQq7I7q3q88y6tL9Chx7S+gVTNscbMbgbSbCL8jn75jtY6qQrmwNfQt9n1MVGaFqpc4+yaBK9y/yvNZFPuNwWoc3fg6s2gACtt/sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=KOZDNwLr; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="KOZDNwLr"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-456768fb0a6so32964041cf.1
        for <git@vger.kernel.org>; Tue, 03 Sep 2024 12:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1725393175; x=1725997975; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UJxksiCfx6UYG93EDXcFEsuYlohnPYfndD15ZPpM5PU=;
        b=KOZDNwLrOUek5tpul9vevFOr5naPsH5v9FxpY97bUZVlz4n9wu38ez+et6MZ/kjKm6
         l3nBgEKSCbK2qnvyvk44hFB1ZZ1WmLs/ibKQrH+va493yiU2h5qFSZDdRTwAoMqiWZgW
         GxhKIUi1yiNibTyhFo52eC0dnCm/egm9UW9au7j+nurxTrGXB58RbNjnxeHHd366aJ/p
         kN0wUfCHVAgEcEIUgFp3zjJ5Iam65bEKseVowCvPQofblNo+8THyDrFofxK0rBjqSRN4
         2KG4piKMnMayTsBIjnb7DzXEklPxX7MH345xablF1WAeHkNWkUCOZLuyXk6nUkhSM5Jg
         cT2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725393175; x=1725997975;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJxksiCfx6UYG93EDXcFEsuYlohnPYfndD15ZPpM5PU=;
        b=NXXp1z/88+BxT22BB5FaIaamx+y3laijx2owjhmWXJ/XHxZVKq98R9/UTJ4qpO7YwO
         YTvjgeK1i2sRUxM0v9Ujgx9LeuCWT1gm/+gcR2UmA+Mxoq134cbSX0NBE22dEjSWu316
         0cKUXqWKZELy+UTZUT7RC0QIJv9x91Lr8KhrZlcmxiXYLf6KGe18NXdOcSJXQCmxoTdB
         TlOeWfeqDFdjoT68JIPw0660dm3EiZ0Xo1kqA+71qPc7iuy1lxIfCRwOze0SyBQ01ukL
         ytzJOVFfS1E4eiPOuqt7aXL7LY4DVqHCMQND+EuSY1USaEVCEZEWBPXSfLbHWHbdN3eh
         6q6w==
X-Forwarded-Encrypted: i=1; AJvYcCV1fuRXT5Y4IRIxUqi58B0l9mTEQMn3n6SiHhqR73ptEbVY8zT4lq0x8ySv07MeDRCr4tU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGu+vx+kP5N4HI7830T4XyI19ofXWUV3O0Gi/Lhk0k2Nzpj2ZW
	q81vhIV9L6eRq8qaCIrjxCcAp7YvRJOAADQhEYfu7+/86sDu8sw7maCuubAP6xM=
X-Google-Smtp-Source: AGHT+IESXui6O3hjzC1NmmAC6Aw4jgyBz4VvAvzPPWtQqQiPTYNhlCEPC6e/YQxt27jzwfWT5gbGOg==
X-Received: by 2002:a05:622a:a0b:b0:447:ee02:220 with SMTP id d75a77b69052e-457e2db98dcmr60364471cf.30.1725393174745;
        Tue, 03 Sep 2024 12:52:54 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45682ced1c3sm53202271cf.54.2024.09.03.12.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 12:52:54 -0700 (PDT)
Date: Tue, 3 Sep 2024 15:52:53 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/4] hash.h: scaffolding for _fast hashing variants
Message-ID: <ZtdpFWtWae2r4Lj4@nand.local>
References: <cover.1725206584.git.me@ttaylorr.com>
 <6ac6f934c32bdc600cdb8d2a08d4aa390c1f2994.1725206584.git.me@ttaylorr.com>
 <ZtXAhP69zu7cDnsA@tanuki>
 <xmqqh6awlkac.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh6awlkac.fsf@gitster.g>

On Tue, Sep 03, 2024 at 10:27:39AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>
> > While the property we care about in the context of this patch series
> > indeed is that the second hash is faster, I think the more important
> > property is that it's insecure. If I were seeing two APIs, one labelled
> > fast and one labelled slow, I would of course pick the fast one. So I
> > wonder whether we should rename things accordingly so that developers
> > aren't intrigued to pick the fast one without thinking, and also to have
> > a more useful signal that stands out to reviewers.
>
> I do not think this topic is going in the direction it set out to,
> but if we are to resurrect it by
>
>  (1) first to ensure that we won't overwrite existing on-disk files
>      and other things as needed to safely swap the tail sum to a
>      cryptographically insecure hash function;

I discussed this with brian in the sub-thread where I am talking to
them, but I think this is already the case. The pack is read in
index-pack and the checksum is verified without using the _fast hash
functions, so we would detect:

  - either half of a colliding pair of objects, when reading individual
    objects' contents to determine their SHA-1s, or

  - a colliding pack checksum, when computing the whole pack's checksum
    (which also does not use the _fast variants of these functions), and

  - a mismatched pack checksum, when verifying the pack's checksum
    against the one stored in the pack.

>  (2) devise a transition plan to use a hash function that computes a
>      value that is different from SHA-1 (or SHA-256 for that
>      matter); and
>
>  (3) pick a hash function that computes a lot faster but is insecure
>      and transition to it.

So I do not think that either of these two steps are necessary.

Thanks,
Taylor
