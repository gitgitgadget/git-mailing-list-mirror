Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69246377AB6
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 18:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785866627; cv=none; b=Z8YiiQv9q3BhY2vM+tfE5mEmu1o9NKG11VMdiuZzvHbHXs8LJKuyISIiB38pS+QE1EhwrpOmZUoFrBIX0IxU0FLGUNtqfDjpbOKBeamiugEdNCa/QjnedvOyopEelCJJowCtDw546TeIo6VqoM7fDPgz1WRziQ5yo5/KAk6DzXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785866627; c=relaxed/simple;
	bh=Y+rKFAbVL7OpxRvEZVckprXDJ8hFEMVHs9jjGEfbV0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cW1Vp8yZHi0vGSzU5oeXPVunJ3r+vjhyAQX4mjUhvR/xt3NB/jlO9sGI7LsPToJCUkEWjx8MU4520WK+CsldVZ448R/c+g1aH0S4jzdvGmNtkar/El2Vi4wr8868v4DRM7tQt2bMIAB9lVFKIqXpEJsoF+CfNAcSmjBLcoaU6ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TsrExKO3; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TsrExKO3"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-81f64e8dfbcso2112357b3.2
        for <git@vger.kernel.org>; Tue, 04 Aug 2026 11:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785866625; x=1786471425; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3nrlX/gWdZ3WciAtjHprHFS7pYzwL9nPf48HVR2XKz0=;
        b=TsrExKO3AGeqDNA99unp/pYIOwgFThqfDlJK/s5wQDNUFJPx7dvvtTbaU3RnM0aNJs
         sSYr0oJ3ddYMgUGx0gWEb6e7Vi1p9/2QS2Ca0tuYExZ+3GQKzr/ce2lQ8lNbA5V7SjGx
         0Bp5j8ubxv7paHAM2XDZxyMg9Ug4+yevQnUa7LgKAvhH1J5Z7fV5PJK41Mh0RgNGOJjc
         pVUJqKQjDgZrB2rnJYeg3l1tUtyxbPWsFfqBbOKnc8Rn2xMbPpx/1QOci+PIvKzT/E1E
         w0kKWAkx3U7WCShdo0gO6T6/o9nbi2Pa8ef7sulFuu1IUTO37FBSHQYbBI2YFxWXBUgJ
         5yaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785866625; x=1786471425;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3nrlX/gWdZ3WciAtjHprHFS7pYzwL9nPf48HVR2XKz0=;
        b=LgVJ9D4gFwrYh8MrVTABMuxI1dSJ5ivCLANxrdROPLr6UukuCvWWYM2zu40fgUYeN+
         tUFLtUIafKP+bg1nYvcpyO7fsRbpWHadhSW+r98nq4h807TKENl3lF3RYVf9/LC2+vEq
         AZT7Hot2tN8czAN0dzx1YqiXRe7D5jSX3i79TMb1iuI4R91mKWjhMh4f0XPn8TaAIB+J
         dGPf2S1hwnadBppL0xDhbHojnEsbUwPbdxvQqqK95OWdQHU/Bx+1txNxKJUql49B3C9u
         9qjzwWWu0RNWXc6Lat5FJtW2Jpvysdzw0GMjN0NOA5oV4P0zRGFw/yjFZ4kDOlVLTYpE
         RYCw==
X-Gm-Message-State: AOJu0Yz7aQuOVgKNle00ebe3d1pbtg1KhBO7SdojIZT90JNUFXXQ6+8O
	axM6wi5RpPjIdM3H8ctyX0oE8CDnmgZVOZ34c/xq0XVaNQUBzfPL+4LvdJUDZg==
X-Gm-Gg: AR+sD13TQ5LNRUAmIa+nUiD59mYkl1Kd2J62YoDnlEWQisZBJ7qWe6mEs0O83fGIZmr
	Pq253EmzQSykm4AGspUK8E/G/mIaOzxbT049A38/Jg/TzdHq8ZrDetRohgy2OH8tktvtyiUgBM6
	YNcOCgV6ieqm8DC0QUDzro8mmAVK6B3MidwnffzKyg6f+WJRIpjyj6Red4EjnyVWGKbETEy2Ut0
	s7iG5P0lU3pHC1MIdFl0A40i2dkpOSB8QsvSVIlDfseAm0tuCnhJh+u5JpgVTLvnlB4Za7YGIj2
	AGklgPydC+rebWzZ2Ywa9H9sD9E823mo2MYS5nN5mJNkhK8ZNltGptzAjiFHJS6D7KkznmJ7G4o
	AR1CiJovd4gtqt6x5otIWz5DzM2zO1OnNXrgqQXNVnDBSXuxSVPUnA+8uyPdKH+RukYGDBXLjLw
	LaMIhofAmbyDHPlPV6h9rX6d5i6TBUCBNtCCqAIhjVTPQya1/tv7U25Q==
X-Received: by 2002:a05:690c:3a0:b0:81e:5f38:b20e with SMTP id 00721157ae682-8201f0bd386mr2258247b3.6.1785866625291;
        Tue, 04 Aug 2026 11:03:45 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8201447eb4fsm8690787b3.36.2026.08.04.11.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 11:03:44 -0700 (PDT)
Date: Tue, 4 Aug 2026 13:03:41 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/7] odb/streaming: support streaming arbitrary object
 types
Message-ID: <anInniMjCtU9Qae7@denethor>
References: <20260804-pks-odb-stream-unification-v1-0-86d70e82345e@pks.im>
 <20260804-pks-odb-stream-unification-v1-3-86d70e82345e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804-pks-odb-stream-unification-v1-3-86d70e82345e@pks.im>

On 26/08/04 09:25AM, Patrick Steinhardt wrote:
> The object database supports the ability to write object streams into
> it. This functionality is used when we encounter a blob that is larger
> than "core.bigFileThreshold" so that we don't have to soak large files
> into memory.
> 
> As we only ever write large files, the infrastructure doesn't support
> specifying any other object type than "blob". This limitation is quite
> artificial though: there is no reason why we shouldn't support writing
> arbitrary large objects with a stream. While it's very unlikely that we
> encounter a huge object other than a blob, users are known to be
> creative and sometimes like to inflict pain on themselves by creating
> commits or trees that are huge.
> 
> Extend the infrastructure to support streaming arbitrary object types.
> For now we don't use this functionality anywhere, but it brings us a bit
> closer to unify `struct odb_read_stream` and `struct odb_write_stream`.

Very happy to see this change. :)

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/unpack-objects.c      |  1 +
>  object-file.c                 | 31 +++++++++++++++----------------
>  odb/source-inmemory.c         |  2 +-
>  odb/source-loose.c            |  2 +-
>  odb/streaming.c               |  3 ++-
>  odb/streaming.h               |  3 ++-
>  t/unit-tests/u-odb-inmemory.c |  7 +++++--
>  7 files changed, 27 insertions(+), 22 deletions(-)

Just FYI, there is also a comment in "odb/transaction.h" for the
`write_object_stream` callback that is also now outdated due to this
change. We may want to update that too.

[snip]
> @@ -953,7 +953,7 @@ int index_fd(struct index_state *istate, struct object_id *oid,
>  				 type, path, flags);
>  	} else {
>  		struct odb_write_stream stream;
> -		odb_write_stream_from_fd(&stream, fd, xsize_t(st->st_size));
> +		odb_write_stream_from_fd(&stream, fd, xsize_t(st->st_size), OBJ_BLOB);

We still only target large blobs for streaming here, but the underlying
infrastructure is now generic which is nice.

[snip]
> diff --git a/odb/streaming.h b/odb/streaming.h
> index 5e8e6e532e..3c8ed55129 100644
> --- a/odb/streaming.h
> +++ b/odb/streaming.h
> @@ -56,6 +56,7 @@ struct odb_write_stream {
>  	ssize_t (*read)(struct odb_write_stream *, unsigned char *, size_t);
>  	void *data;
>  	size_t size;
> +	enum object_type type;

We now store the object type in the stream itself. Similar to size
information, the type information is always known in advance when
creating the object stream.

The rest of this patch is just updating call sites accordingly. Looks
good.

-Justin
