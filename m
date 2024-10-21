Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0182A1FE115
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 20:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729544332; cv=none; b=VGiVah2GMsboyzGu13feZ0Jdp8MwNm5aUNWYi6U0ENtn2OP2UHvaFm6jgLZICiDex+PYtpJaYMC9MIJYaCXq6L1jpfqEv+qqR8jU+jcavyeH3eSxCBXwJzhg85XSKC5YLGah7JR5T5e8Tr2YNiUV/QR6njMb4D/ItqsysyZWUGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729544332; c=relaxed/simple;
	bh=PFzgOZhxABnjegECkhxWeWKZKqmQW8G6MahpJK92FMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NT0XHRwvb/cIuYAvCD6sE5uI+ZFISMeAX5jRWyz5Q2DiaN0zeoIBo62ZTWbJhtjfN6G0v4IavMicp/AXK3+ic5M+Qu7p7UyK1yUJ+YukHbcnZRN01SaEYzxFKP7f7iWLtRgX+SrIJTO0mO+/U3pvn3v0oQHMHu5KQoypWbzert8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=CU/RLvn8; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="CU/RLvn8"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e2903a48ef7so4709536276.2
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 13:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729544330; x=1730149130; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wkucPKKIksV4XWkNoy60iGX9nqxxHMguNsirINM5NXE=;
        b=CU/RLvn8VM2QavmykSMS03WpngMtvhKcvzmqXQ6YsruUnCWV+yuSr3UrU3wFNDYs+A
         kdkI6PDmP8PjXjqkdd0RC5UlmNGgrnXdxOs2IrSi+L83tzQThDR1u1E7dKVhvNqWBKe/
         ioSVZD6QHDsJmCYKwWZTfLPgxJJnUu07oO3rFKtuh95lfMDQ6ecFWFXcd1WGISjuPWhN
         R6ywpZecdcRq8IrG/9Kb0BQcWsiNhkV17lvKPoOVzA3SequSE607Bu3BQtsZiOvYw0GU
         UAHna3yaHzbROPNTEkf/kHemutSH2ifX4JO1miN/uGIlZnpRiowJvAPk5rw0f/qN09UX
         DADA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729544330; x=1730149130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wkucPKKIksV4XWkNoy60iGX9nqxxHMguNsirINM5NXE=;
        b=BS4Lx8hSh8T3oJzpK0xtjf+Wzyoxzsp0A31a5CBkuDZggleeupjCBIi/+R7qgEryA2
         jhTAZQfrVn57WbfCN7WpAgdpggCDyTtsKxKDQJek2qefIcVFRdDE8ibNa1g8fj70A8t9
         PE/S/4qsKbhvpZH0N08I8HyvkswaqeiYGy5StyU5gXOht8vI+Hrl77DB+MLurTSLcQUM
         V1u3Vf5oZSTN3IJ+RiGNGTfnExfw0tNSLxwJacRQSCsJ0jAxrYKd3EC3qjWB3UPVqGk/
         DMiC0XJz3pwXRHLd4EG9RxxjPh5WXPqFPOZs7Ea5bJAlEN2ZMtgvbo9eod/5b4rfLZvO
         lFRQ==
X-Gm-Message-State: AOJu0YzDGkZT3Tom7gAB/TRRjJgABzam3Gd/YkgBoOYBhVhtMKjmG2KL
	Z6EhgMxc3tv0u733tKHejY/JtlPfLZKE8+nmhpTzJujLP9DmQzE58GTuUhVZf10=
X-Google-Smtp-Source: AGHT+IG4M2zqEw/66pcYkQYlxalCUWuGaVxb2k6QYyU1SACC/tDyLOxcgaQwUkaOR7yap0q6OHJl9g==
X-Received: by 2002:a05:6902:168e:b0:e29:481d:1454 with SMTP id 3f1490d57ef6-e2e27168226mr295989276.9.1729544329830;
        Mon, 21 Oct 2024 13:58:49 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e2bdc9b2547sm840458276.27.2024.10.21.13.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 13:58:49 -0700 (PDT)
Date: Mon, 21 Oct 2024 16:58:47 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v2 11/22] trailer: fix leaking strbufs when formatting
 trailers
Message-ID: <ZxbAhyilmPR7jF39@nand.local>
References: <cover.1728624670.git.ps@pks.im>
 <cover.1729502823.git.ps@pks.im>
 <5b851453bcea945f95c3f29138e510d8448e96e6.1729502824.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5b851453bcea945f95c3f29138e510d8448e96e6.1729502824.git.ps@pks.im>

On Mon, Oct 21, 2024 at 11:28:35AM +0200, Patrick Steinhardt wrote:
> We are populating, but never releasing two string buffers in
> `format_trailers()`, causing a memory leak. Plug this leak by lifting
> those buffers outside of the loop and releasing them on function return.
> This fixes the memory leaks, but also optimizes the loop as we don't
> have to reallocate the buffers on every single iteration.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/t7513-interpret-trailers.sh |  1 +
>  trailer.c                     | 13 ++++++++-----
>  2 files changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
> index 0f7d8938d98..38d6ccaa001 100755
> --- a/t/t7513-interpret-trailers.sh
> +++ b/t/t7513-interpret-trailers.sh
> @@ -5,6 +5,7 @@
>
>  test_description='git interpret-trailers'
>
> +TEST_PASSES_SANITIZE_LEAK=true
>  . ./test-lib.sh
>
>  # When we want one trailing space at the end of each line, let's use sed
> diff --git a/trailer.c b/trailer.c
> index f1eca6d5d15..24e4e56fdf8 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -1111,16 +1111,19 @@ void format_trailers(const struct process_trailer_options *opts,
>  		     struct list_head *trailers,
>  		     struct strbuf *out)
>  {
> +	struct strbuf tok = STRBUF_INIT;
> +	struct strbuf val = STRBUF_INIT;
>  	size_t origlen = out->len;
>  	struct list_head *pos;
>  	struct trailer_item *item;
>
> +
>  	list_for_each(pos, trailers) {
>  		item = list_entry(pos, struct trailer_item, list);
>  		if (item->token) {
> -			struct strbuf tok = STRBUF_INIT;
> -			struct strbuf val = STRBUF_INIT;
> +			strbuf_reset(&tok);
>  			strbuf_addstr(&tok, item->token);
> +			strbuf_reset(&val);
>  			strbuf_addstr(&val, item->value);

I have a vague preference towards writing this as:

        strbuf_reset(&tok);
        strbuf_reset(&val);
        strbuf_addstr(&tok, item->token);
        strbuf_addstr(&val, item->value);

to make clear(er) to the reader that, OK, we are resetting both of these
buffers before using them at the beginning of the loop. To me it reads a
little clearer seeing both strbuf_reset() calls one right after the
other.

I don't feel all that strongly about it, but I also see that you have a
couple of small changes you're sitting on from Kristoffer's review, so I
figured I'd throw it out there anyway as we are expecting a new round to
address those.

Thanks,
Taylor
