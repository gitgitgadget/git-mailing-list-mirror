Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46B6158D8F
	for <git@vger.kernel.org>; Tue, 17 Sep 2024 09:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726564603; cv=none; b=DAq7szWW98optn/BExivf9wc3POj8tvVcgtslxFzmhatSMSsXULE+wHIzRfHtHrgm3h1r5IYad2pHd1ydSmPC7snPSqqnUD/aw2qLMXlrGHamZOYoXLk69nhlZfexdO2+EXaRRLUUDk8DwFFtoU4bx4wmZZASq2OOit3fZyWiqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726564603; c=relaxed/simple;
	bh=v+rDp0u4hMUi+aJbLhQfq7w2ISgWPfftF9m1dfjqL3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/blPcbqnDvArQifX62WiP9bLyS9+HeoDimU4UyGxrbaSVQDWDRe6+OLdLeKSlLDfBVi/K0Pz2UdzM35bKbOFpskQCZJYMUxBNfdBm4mU+IYweLsbmRmdC345h+lMbjJcz5ifRekkrfM5GpDJNv2bL1oPfL9ydPIJDqF3jp+W+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=0Z2qXiqw; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="0Z2qXiqw"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-82cd869453eso126083039f.0
        for <git@vger.kernel.org>; Tue, 17 Sep 2024 02:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1726564601; x=1727169401; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h3CkDk2aFcOK43qirSIgh2cHYYpQxHWZE5lwudar9NE=;
        b=0Z2qXiqwyXwSAlyIVXO7kWLYcQTDPppHdt6YrIZJq/h4wfBgI57GLFeIQK6g3eSyYq
         NnWMJ3XWjSbydc8AZbJFrZsTm/4Wt6DoBlSaJ8aRLUi/dtXWem8dARk2vuOs7tLO821I
         gMJshp23uzLZv2dibILFOzCJxpyocvv9fElB0jFXnNSaAuozvHS7GAGUyU2BiH2Qd8Sg
         vKPch7MUMg4h8E+36tXKLHx6FtLGGZCf1NVn7rAOG11gVg/OqroKIMhLgMe8j/LW1U4R
         TCZq5kpkCTCPa6P1yf47v0zHL+8256jXjNmj54ZrOLde3Wedg1mCXST+W9wV//TBhFEk
         IwoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726564601; x=1727169401;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h3CkDk2aFcOK43qirSIgh2cHYYpQxHWZE5lwudar9NE=;
        b=hIZSatA8hAH5OkQtyKlJ3XHHpu19mqM0kTzJBErHoIiBdNedGCVZCY/eU9oFqsRPtP
         AW3jZYhxkm89KGXf+AfqsAtJeSOJtORei+0M04wEHyCg8akzGEO/ADUkH3vC+f1qnQbk
         /egADjGxWk7hlX0oL/8gpnW3v8Mb1YwDbiSMQHjVOsG3wrY7VeycjRzgTNHBjkb5FFHQ
         urbsr9mxyac3By21vwo/nFidVZQ5eqr1bOtETiL/t24u/Kj1W7fr66BQnfWtfB/2SLZ4
         hymw+msEFHxA2uv3b1sLpmWJy1kwbZHsJC4pt1ENntFL5P07rLtqpb4aLn02f+ooTVNG
         QXVg==
X-Gm-Message-State: AOJu0YymsJ52J+NFjOpb85pKd+Mt+HgugRUTEern3H8/Ssh4L0qgREkg
	NU7s3TiMofNSDtAN8ZrHxLlwNy6SC0P2DBEOTssDix8q48dwP71IjupllsrZMxc=
X-Google-Smtp-Source: AGHT+IFisov4RykV0rDv/x8ZVVBMzMxYHqVowTt3G9VvTCgVuVU+SsEo/jw/SDwboliVPIlp9kZPNg==
X-Received: by 2002:a05:6e02:156c:b0:3a0:8e92:ecd1 with SMTP id e9e14a558f8ab-3a08e92ee9fmr112370845ab.2.1726564600666;
        Tue, 17 Sep 2024 02:16:40 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d3a9441105sm400138173.3.2024.09.17.02.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 02:16:40 -0700 (PDT)
Date: Tue, 17 Sep 2024 05:16:36 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 2/6] builtin/receive-pack: fix exclude patterns when
 announcing refs
Message-ID: <ZulI9Ha44ZwFPoiC@nand.local>
References: <cover.1725881266.git.ps@pks.im>
 <cover.1726476401.git.ps@pks.im>
 <3dc6ae936c88d3105bc82daab3edd805c9b5c63b.1726476401.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3dc6ae936c88d3105bc82daab3edd805c9b5c63b.1726476401.git.ps@pks.im>

On Mon, Sep 16, 2024 at 10:50:05AM +0200, Patrick Steinhardt wrote:
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 3f35140e489..478c62ca836 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -339,12 +339,26 @@ static void show_one_alternate_ref(const struct object_id *oid,
>  static void write_head_info(void)
>  {
>  	static struct oidset seen = OIDSET_INIT;
> +	struct strvec excludes_vector = STRVEC_INIT;
> +	const char **exclude_patterns;
> +
> +	/*
> +	 * We need access to the reference names both with and without their
> +	 * namespace and thus cannot use `refs_for_each_namespaced_ref()`. We
> +	 * thus have to adapt exclude patterns to carry the namespace prefix
> +	 * ourselves.
> +	 */
> +	exclude_patterns = get_namespaced_exclude_patterns(
> +		hidden_refs_to_excludes(&hidden_refs),
> +		get_git_namespace(), &excludes_vector);

OK, so here we use the result of calling hidden_refs_to_excludes() as
the first argument to your new get_namespaced_exclude_patterns().

But I think that in this case when the caller specifies a pattern with
'^', we still do not exclude any references in the backend, since
hidden_refs_to_excludes() will return NULL when there is >1 pattern with
'^' as the first character.

I don't think that this results in broken behavior, since the callback
to the refs API will still be expected to filter out references that it
doesn't want.

>  	refs_for_each_fullref_in(get_main_ref_store(the_repository), "",
> -				 hidden_refs_to_excludes(&hidden_refs),
> -				 show_ref_cb, &seen);
> +				 exclude_patterns, show_ref_cb, &seen);
>  	for_each_alternate_ref(show_one_alternate_ref, &seen);

Thanks,
Taylor
