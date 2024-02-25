Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F8C2F52
	for <git@vger.kernel.org>; Sun, 25 Feb 2024 12:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708864540; cv=none; b=oFY7H3FCEEt9eBLaENjzXKUN8Y3eaCjFyB1rf2BivWOQuG2Pn8gTjCfUkOdGbR1FoOhq6+xd+OO/r3ODcGURMIyAwc2xWtMot4UxSsCFG7cqgc9UDyuSsfeC0wIzl0kvTalCkuvRXBGxv/BCfS80YqETuIXzuV4K1caO13cpypA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708864540; c=relaxed/simple;
	bh=rTu3jjE7L7ML4YKW+k4SalIVjhJsKR3Edpe4sbA+G8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RhBLYNiT6FHw+C3psR+dba9tpkJtjPJBwJ6wW7NxnIfiWXseyMbxY6pp7A74hugWZOCsq7fjRptAT8iJ+tW6FT9ByeMJXuZ5IcPKZRccGMdRvejY0btwoM5nNNExC0vMyrXaIZ84/cMvMfVM1iCAQWJXu/gLNOIFw8mdkrjOGwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=HJEXToFd; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="HJEXToFd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1708864528; x=1709469328; i=tboegi@web.de;
	bh=rTu3jjE7L7ML4YKW+k4SalIVjhJsKR3Edpe4sbA+G8o=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:
	 In-Reply-To;
	b=HJEXToFdfyaRizmWPI6G7qectipjKyn/N5TLW1FaWTYxsjQ4RMCWPOSRR9zBPULN
	 BVnqqhgbvgknAQy1zDV8D1lJI6LYOP1QHD4JHjkPKYtuw9JXSpcTTDmIWwJbiNj1+
	 H+guAbHc4FZVie3vSOBMRqZ65VfzaqI/z6Wkn5jXPfAeLpgJFnNrH3oKPvAAwkeKE
	 4QEc/w8CQedkkN+cUQ+EvY4BYeuMfo0cxM3IxrCowOzFNi15C8OHWsLrJzWQvfNg+
	 1D9tv1hFBCxX/fPRwS8s7nAD3Dfjv0eulylQ9Evq+rle9nombxpjPQ+2hM6pHtbRC
	 vVLrr/IelXAYh6in3Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([195.198.253.159]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MZjIb-1rRJRv1167-00Wv79; Sun, 25
 Feb 2024 13:35:28 +0100
Date: Sun, 25 Feb 2024 13:35:27 +0100
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Jeff Hostetler <git@jeffhostetler.com>,
	Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH v2 07/16] dir: create
 untracked_cache_invalidate_trimmed_path()
Message-ID: <20240225123527.GB1952@tb-raspi4>
References: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
 <pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
 <99c0d3e0742c1a7e0f7608707402a772ec112716.1708658300.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99c0d3e0742c1a7e0f7608707402a772ec112716.1708658300.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:nmDQ2Bq4OcsvcHf3FMG+jy/jFBaqJya9DA7KgkdfWhduWH0cSq0
 8H8iOnMZgQk5Z6Tge4dQcQw8x2dYFgRWgXHNWSEuiItGk9FrQQ/US+axE0i2DJRPwC+gOq7
 xwq0wMeKdOHVorWG6184dhhYv3KZO6ZTFh/EReEYMHudG4s4xMGybtcrJqoq51ElsPMo0E2
 JN3cNh/euyJpfhOCjIz3A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4opB7PhJapY=;2i4HkT7vmqlBGKrl4NUluhpmFzM
 U1iJIzTeP8+tiUXu5sMxKzQaL7TIWahL09atBHMvLxzp3Yt8jnSMpZvWFfILl+HXJwtDklcWe
 RTJoFQ8r0d0OvCwoUs0r/MQQRHIIPQ/v6gYM5p79QzSQbdmkwZlwob4tRi/EyAul6ljSPGXqC
 4920gXmRnlO/dbBkhqMzogu4M95oi9+VKUVrlkeh9W9xkyPXUqVolGE4nDXbDWut9kgMqUSpn
 wzte+IVmyPH6XpYyP4W/mneJv1cg+E3KQQZUHXqZlHeOCC4E2aAIGHVYQdHRl4YMw45V+86Sw
 SF7ppnQq7syRZ521o9RKjCqSPoL0vNlkohaiAHQu3QtV7ogALvSdnp1EJA7SP/ltMVNS+bYaa
 VKKW8YPCIvpfDBrvpOgy2ByKTtOEjfQZBpbpFibAgaUO5xj/lTp7df2A+I4zDxPB3tFqyltX7
 2zHanX+UazTjCA2gmt8xBuCQc/ugl8XCEmvMVJwYGxhdLDNkTC6aMyHhONf4autLjbOxXWmAD
 QkljbhYyLs13LLS0tXgOmnpObby2N04Df1sdWTY0/Sy6h4hvlOx0Nst71/ecfl6y5QFOXtRcH
 3CqwqPGgCr9uNAuqcpud0JxaUdP6L+vZGJMydxe6+SASrR8glPYYVn8MwQvVE+rC0J3NsrcJt
 nghlD+Dni5EW3yVkmhH09QzocqXwtiMfGu1BLnil2MnDElrJqn8QmWKeLInfWgLN7woM2RUK9
 jJ1dMyjuWUwOv7eJDQOweJmurBAFtFgyE5ljq4E8fXuPALeQ4/KSBTmxecIU9RL/0aHrDW1uq
 wo9bHH8xwzlT9dhlFOjgBpINrV9nP4sul4l0SIfGa9iUs=
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 03:18:11AM +0000, Jeff Hostetler via GitGitGadget =
wrote:
> From: Jeff Hostetler <jeffhostetler@github.com>
>
> Create a wrapper function for untracked_cache_invalidate_path()
> that silently trims a trailing slash, if present, before calling
> the wrapped function.
>
> The untracked cache expects to be called with a pathname that
> does not contain a trailing slash.  This can make it inconvenient
> for callers that have a directory path.  Lets hide this complexity.
>
> This will be used by a later commit in the FSMonitor code which
> may receive directory pathnames from an FSEvent.
>
> Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
> ---
>  dir.c | 20 ++++++++++++++++++++
>  dir.h |  7 +++++++
>  2 files changed, 27 insertions(+)
>
> diff --git a/dir.c b/dir.c
> index ac699542302..1157f3e43fa 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -3918,6 +3918,26 @@ void untracked_cache_invalidate_path(struct index=
_state *istate,
>  				 path, strlen(path));
>  }
>
> +void untracked_cache_invalidate_trimmed_path(struct index_state *istate=
,
> +					     const char *path,
> +					     int safe_path)
> +{
> +	size_t len =3D strlen(path);
> +
> +	if (!len)
> +		return; /* should not happen */

Should a BUG() be used ? Or bug(), for the record:
Please see Documentation/technical/api-error-handling.txt
> +
> +	if (path[len - 1] !=3D '/') {
> +		untracked_cache_invalidate_path(istate, path, safe_path);
> +	} else {
> +		struct strbuf tmp =3D STRBUF_INIT;
> +
> +		strbuf_add(&tmp, path, len - 1);
> +		untracked_cache_invalidate_path(istate, tmp.buf, safe_path);
> +		strbuf_release(&tmp);
> +	}
> +}
> +
>  void untracked_cache_remove_from_index(struct index_state *istate,
>  				       const char *path)
>  {
> diff --git a/dir.h b/dir.h
> index 98aa85fcc0e..45a7b9ec5f2 100644
> --- a/dir.h
> +++ b/dir.h
> @@ -576,6 +576,13 @@ int cmp_dir_entry(const void *p1, const void *p2);
>  int check_dir_entry_contains(const struct dir_entry *out, const struct =
dir_entry *in);
>
>  void untracked_cache_invalidate_path(struct index_state *, const char *=
, int safe_path);
> +/*
> + * Invalidate the untracked-cache for this path, but first strip
> + * off a trailing slash, if present.
> + */
> +void untracked_cache_invalidate_trimmed_path(struct index_state *,
> +					     const char *path,
> +					     int safe_path);
>  void untracked_cache_remove_from_index(struct index_state *, const char=
 *);
>  void untracked_cache_add_to_index(struct index_state *, const char *);
>
> --
> gitgitgadget
>
>
