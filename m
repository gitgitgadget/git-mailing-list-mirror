Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4068C1494DB
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 20:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729542802; cv=none; b=NZsMUKhysscA35fY+F+5Td/f+fI7x9cfDB6X1TQm1Wj2rPBbyN7nnT82YVz4KeelvR10N++IMPcFzL4Z7/DLsCM1WqozYF5FId5I381L/XLgW4IY9DdQMwSjfjjjFmzYIOOUadlwoQNZb4j9SiY6fZj5JsZQjTq0iuEK8gu6AQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729542802; c=relaxed/simple;
	bh=1XKQw2fiQlhK/9jyiLh7DQO9Wu3omq2AQ40XDEDBTG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gvkiCTHb7LvLqkj8bQzdaxCsCX61ZAn26wgGeaZ9KM6VtVmebaEguTsbzZoz/u2Pist02meAh6989AKiwFMPkPGkLcLXOI/l72wxILhLQG4o+bkpaSn8btBZpkgFwgLIA2JI9pJIVuARHrf5XKNVV8xJ9MAlIHtJnRJkUq2fQaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=CLhyXST2; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="CLhyXST2"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6e2772f7df9so40989367b3.2
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 13:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729542798; x=1730147598; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YQsFlclPN5m4gQMflivil6Ck2H6+Smdm4bbR+XA0GXc=;
        b=CLhyXST2eR4E2C3xIwEE03k7OrJCiuM9pN1ctFnp8EF8HUPOMGAM9q2hriLbDVGqLY
         JU9DVqFxo03D4xLPWC0Te8zrqYEK3uDcYU0DixAK6ZSTW8O5dWvFWMvNuq4ueEXUbx+8
         isH21VKaxZIXpaunPazT0KcwHVfY1NAxso8GSz5aEP+pqgQR6otW+8VEvGtymAA9KTCI
         i482B1qSCZzbQaX1eYKxXeZMaBVaUiuBY5BZep82v/YpXlkPVfYt73WMmYPaXh67lCcB
         ryfPzTj9TJcoF/FPAbp3CVtr0P5sP+FmYQ7QpZRUVp4mUutWv8Ehpzr0irBosSS7yIdv
         JbCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729542798; x=1730147598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQsFlclPN5m4gQMflivil6Ck2H6+Smdm4bbR+XA0GXc=;
        b=il0W4gMzIPzRIvRj02CO88Qi4xqjl+dZ83G0WW9AJqdWLHVFwt2bH3J9iRTcJ+NEy2
         7H/lmc2mP2SxBbzQk1015uFPYwzTvIfclGSlJWvyj6D2x67bXBRJmCAIZ3gmWRMvW9+q
         EFMvqwW1HIoHz3Sz7OsoD6UxrI1JmOQIrw49txSDLBTIBz51OgOJDiBrKBj9QoLURZZp
         pIHWbIGT43wbUWaX3nSEONu8ddD2cSc8QxtWC9+xeI9WOriQm7gxCmsterz6iGpYYT8u
         FspitFAAit0Ced9bb64iKiWAvPKz9sUOLD8mKA9A/ZB2KOrfQODc1mfQCVYCKol4tQ/b
         R+LQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAkfq7uXGzQWvFcs+s+pZ8JK3sWFSnjMAqBS08spik5J2PoPNxnEU+QFLYdT4NHXjiQI0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2mvc9qe8fdFwVH3h8iFX/8Pas82T0ym7MUsiaSo8oONsfiYvW
	WszEYA7rUmx2U4QivX7GyjMHePpjfQuS+U7Ybl5V7GLchAmKTtX/4g9E73NY8P0=
X-Google-Smtp-Source: AGHT+IGlP4pgsTywAbJ746A3c5CrC4/gs2v0s/mHIMRBvtmmUvuJ9MJpBTenqhYxT/5Jr9r5vJgciA==
X-Received: by 2002:a05:690c:360c:b0:6db:d7c9:c97b with SMTP id 00721157ae682-6e7d82d4463mr3032597b3.40.1729542798192;
        Mon, 21 Oct 2024 13:33:18 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f59f5c26sm8160437b3.16.2024.10.21.13.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 13:33:17 -0700 (PDT)
Date: Mon, 21 Oct 2024 16:33:15 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: fox <fox.gbr@townlong-yak.com>, Eric Sunshine <sunshine@sunshineco.com>,
	git@vger.kernel.org
Subject: Re: Bug report: v2.47.0 cannot fetch version 1 pack indexes
Message-ID: <Zxa6ixwP2aOJdfmL@nand.local>
References: <BA07EFA0-0793-420D-BED9-ACD7CEBE0112@townlong-yak.com>
 <20241020012455.GA599236@coredump.intra.peff.net>
 <20241020024022.GA615104@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241020024022.GA615104@coredump.intra.peff.net>

On Sat, Oct 19, 2024 at 10:40:22PM -0400, Jeff King wrote:
> diff --git a/http.c b/http.c
> index d59e59f66b..6df032e40f 100644
> --- a/http.c
> +++ b/http.c
> @@ -19,6 +19,7 @@
>  #include "string-list.h"
>  #include "object-file.h"
>  #include "object-store-ll.h"
> +#include "tempfile.h"
>
>  static struct trace_key trace_curl = TRACE_KEY_INIT(CURL);
>  static int trace_curl_data = 1;
> @@ -2388,8 +2389,24 @@ static char *fetch_pack_index(unsigned char *hash, const char *base_url)
>  	strbuf_addf(&buf, "objects/pack/pack-%s.idx", hash_to_hex(hash));
>  	url = strbuf_detach(&buf, NULL);
>
> -	strbuf_addf(&buf, "%s.temp", sha1_pack_index_name(hash));
> -	tmp = strbuf_detach(&buf, NULL);
> +	/*
> +	 * Don't put this into packs/, since it's just temporary and we don't
> +	 * want to confuse it with our local .idx files.  We'll generate our
> +	 * own index if we choose to download the matching packfile.
> +	 *
> +	 * It's tempting to use xmks_tempfile() here, but it's important that
> +	 * the file not exist, otherwise http_get_file() complains. So we
> +	 * create a filename that should be unique, and then just register it
> +	 * as a tempfile so that it will get cleaned up on exit.
> +	 *
> +	 * Arguably it would be better to hold on to the tempfile handle so
> +	 * that we can remove it as soon as we download the pack and generate
> +	 * the real index, but that might need more surgery.
> +	 */
> +	tmp = xstrfmt("%s/tmp_pack_%s.idx",
> +		      repo_get_object_directory(the_repository),
> +		      hash_to_hex(hash));
> +	register_tempfile(tmp);

Makes perfect sense, and the comment above here is much appreciated.

I thought about trying to use some intermediate state of the strbuf here
to avoid an extra xstrfmt() call, but couldn't come up with anything I
didn't think was awkward.

>  	if (http_get_file(url, tmp, NULL) != HTTP_OK) {
>  		error("Unable to get pack index %s", url);
> @@ -2427,10 +2444,8 @@ static int fetch_and_setup_pack_index(struct packed_git **packs_head,
>  	}
>
>  	ret = verify_pack_index(new_pack);
> -	if (!ret) {
> +	if (!ret)
>  		close_pack_index(new_pack);
> -		ret = finalize_object_file(tmp_idx, sha1_pack_index_name(sha1));

And here's where we stop calling finalize_object_file(). Good.

> -	}
>  	free(tmp_idx);
>  	if (ret)
>  		return -1;
> diff --git a/packfile.c b/packfile.c
> index df4ba67719..16d3bcf7f7 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -237,13 +237,22 @@ static struct packed_git *alloc_packed_git(int extra)
>  	return p;
>  }
>
> +static char *pack_path_from_idx(const char *idx_path)
> +{
> +	size_t len;
> +	if (!strip_suffix(idx_path, ".idx", &len))
> +		BUG("idx path does not end in .idx: %s", idx_path);
> +	return xstrfmt("%.*s.pack", (int)len, idx_path);
> +}
> +
>  struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path)
>  {
> -	const char *path = sha1_pack_name(sha1);
> +	char *path = pack_path_from_idx(idx_path);

Huh. I would have thought we have such a helper function already. I
guess we probably do, but that it's also defined statically because it's
so easy to write.

In any case, this looks like the right thing to do here. It would be
nice to have a corresponding test here, since unlike the other
finalize_object_file() changes, this one can be provoked
deterministically.

Would you mind submitting this as a bona-fide patch, which I can then
pick up and start merging down?

In any event, I appreciate you figuring out what was going on here and
outlining a couple of paths forward.

Thanks,
Taylor
