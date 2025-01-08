Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31D01FE457
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 16:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736354206; cv=none; b=SqayHsfncvS6gtDsJUGjl4RkV3AHx/H8ZkGgHbk6ZqJf/u2ngPhMfc7iDDxxDsAWE5nyX+BFc6NP57sZGEJ3LZThBm44pqKkUzsxOf0+oD//JEZKCH6eAclzVUqr73hPm3MsvzMp3LrMkqH2HAfOENCz4yjKqE9OzKzKrTufAps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736354206; c=relaxed/simple;
	bh=QZ23uqYC7HVOXAru931btuzGJUMAXa0N6Bvad8s6si4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PXJC8f2PM+3rfb82H3V+4JiD/d/mqxQN44g+RNJr0tL7hC18BWE3pEaihiNPhaKK86f412xop2kMb1aaALXWP/WBKXlrDdu1Ce6443Z95++kh6e8npjFQUAjwV3jA40b1S0iFnffMHc3hF4RQ5gmg30X4MaodZ05r/fnbJdOKF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=Ew+jwH9g; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="Ew+jwH9g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1736354195; x=1736958995; i=l.s.r@web.de;
	bh=uzJ3iF4dvqeIYavxWjI9+KsJoDsOZLQoTR1YhydwFzg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Ew+jwH9gLlOyoUOl9s6Sp5r5LzCnHf5HlX9XS7cy7fCH6ustgQ+AZb0EgYFIqG3X
	 IEcR0ujzCbWJtOYA12CbwsBIH8zt1Djl3kGoGZqQJpt6LLSZpVuwY/rp+gT140Npy
	 46hCP7xCK7lvGCjFnkCD2Ieg0sFVk5bf3VrTIR89/nHhIy8FSe2n/Hokgz+FLXl2e
	 uzKO94H3zPXPHAW9ImI2JCD8qpot/N8b1kNnpoaY68/SMzA0eOSbI4TRFDHS9zQEy
	 d2BSpudA7beiUX6hcVpDWLfYuMyzsIqt8n5KTGXrmPNE5ZdhWUzNhNs7N8JAdevgn
	 H0ILwaofhCcztCAAHg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.20.45]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MNfUF-1t7AZE1bS7-00IxU9; Wed, 08
 Jan 2025 17:36:35 +0100
Message-ID: <e842ea8c-4ead-49d0-a48b-0d5f8c4e7c0c@web.de>
Date: Wed, 8 Jan 2025 17:36:34 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] t-reftable-basics: allow for `malloc` to be `#define`d
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1848.git.1736352005578.gitgitgadget@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <pull.1848.git.1736352005578.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BX5jRIGiugFKcRkgY7pWiDGfEU3p6NZq8unDlBWu6QQSoqW3zFY
 lNB0pJKJ2Zw8b7x/LDBryMvdkj/WOzTEP0hNmVJ1+oLzr6RCbkOYiLETswuiuQXRf7cqY3E
 OWQuMap0X71sLxD/lj+tNPQ2FsbvT8LB16kETdpUoufi5DSxp6ersEVURpui+t/sSzvGh65
 tmQEkhQOOOay7kWpRRyWQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:topdbQJLF+I=;oWU1ZSzlUEqTehXY8SJy8E0StIL
 52yWf1oarWc6SJAjmxqTsqbRixIzdZJxMRV4PMy3hEj8eDhXZtGICmGCgkA1PNeFn05fPDNUL
 p3++4HkgeB4Z2obK+PvpplYoIOTOPaDO/EyQZ/yly/zZFIgAxj6qWUcS9w2lSUhs+4lgMlfLg
 aBPLzLmq4nHJ68Tq4uXZKuhGFiQWpFL7TPyeOAIPPDIi1aZKwmK/i9wa9za5BbR9GhnLq8OpF
 k+hVq/cTqYI6uIP8Yk8nfLh7dvg27J/YfNWXeCxi3P7dzft6GafOipLPv7nPL3N87r7IvJIw0
 /sl9TaSQVZIct+NjDlmX09Z25UfVULm5wLnlFI4xgw+ZAHRgwV0TBUa4GB16RT46NhQ02xons
 yr6id75pupxjf3fCyYXOFE3oX6k8XqOLs+HJN1+IZZp9IJJqPoeErn+BNVoEXDCegcsTfbYEE
 Imi3nGEvKo7fibW885DzeWbBNlOERIvZ0ucbWqIKDZdJpUOtwcb4Czu+FD5SgjGIi8POTrB5L
 TQxxR3SRZrw7tcAHWOlqSEsCHH3B7R58OZWIAajjDG/o4LINxnkpG+SuyujLA4/RkwepMF4rt
 4Nq20DJPle82TMOISFgFsdbCaGMr770eCP9TNZiFPBexHJ1TNt+DCmm/+lPLX9N/n7xbm5bxT
 uuOaDhgpUTvWNdC2ee/67ObXvuZibLTtP75QVCGSAI1PpK80AE+Yi1py55AZc6+wonKL7frhj
 Z/JzAMy4Z0tbOlAiFZ6SaHdE+hTvRwj1/3raG4lnEywPJhTP5aNbMvlwEkge40ZnG1lEK+amD
 2MkMfI+txU+h0JvI+l1PilBAUBDrqnveYWUmsxe0k27AaTgquruQQLEVa8yVNcHEWM5QnoIkK
 cX6EvvkJikBdWefD4Ccrn3/oExumjOv28+hOFHtS6g5ByY4sIJVPT0+Tj/mwHb6ctscVWaXtg
 CIgxvpngyl/woAM9GhhS/IJ+sKZZn4QGtd5BOX8tpseGsjlf6F0mR+p8NES1ghqbWrvS4DlHZ
 Mu0/613b//uiv+TMNyorpHwPEsPu7VnkqC7UiojJOKY27+Hmc8oJqSlKFqd3Wp3gZpXda3ja+
 aRzZZP1NSZQJpD+ezU6HUDw/rEgLilPpRiEBLIflBGgXQFDlCN4Q==

Am 08.01.25 um 17:00 schrieb Johannes Schindelin via GitGitGadget:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> As indicated by the `#undef malloc` line in `reftable/basics.h`, it is
> quite common to use allocators other than the default one by defining
> `malloc` constants and friends.
>
> This pattern is used e.g. in Git for Windows, which uses the powerful
> and performant `mimalloc` allocator.
>
> Furthermore, in `reftable/basics.c` this `#undef malloc` is
> _specifically_ disabled by virtue of defining the
> `REFTABLE_ALLOW_BANNED_ALLOCATORS` constant before including
> `reftable/basic.h`, to ensure that such a custom allocator is also used
> in the reftable code.
>
> However, in 8db127d43f5b (reftable: avoid leaks on realloc error,
> 2024-12-28) and in 2cca185e8517 (reftable: fix allocation count on
> realloc error, 2024-12-28), `reftable_set_alloc()` function calls were
> introduced that pass `malloc`, `realloc` and `free` function pointers as
> parameters _after_ `reftable/basics.h` ensured that they were no longer
> `#define`d. This would override the custom allocator and re-set it to
> the default allocator provided by, say, libc or MSVCRT.
>
> This causes problems because those calls happen after the initial
> allocator has already been used to initialize an array, which is
> subsequently resized using the overridden default `realloc()` allocator.
>
> You cannot mix and match allocators like that, which leads to a
> `STATUS_HEAP_CORRUPTION` (C0000374) on Windows, and when running this
> unit test through shell and/or `prove` (which only support 7-bit status
> codes), it surfaces as exit code 127.
>
> It is actually unnecessary to use those function pointers to
> `malloc`/`realloc`/`free`, though: The `reftable` code goes out of its
> way to fall back to the initial allocator when passing `NULL` parameters
> instead. So let's do that instead of causing heap corruptions.

Ugh.  That makes a lot of sense.  Sorry for the trouble! :-/

>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     t-reftable-basics: allow for malloc to be #defined
>
>     This is a fix for one of the many issues that force me to delay Git =
for
>     Windows v2.48.0-rc2 until I can increase my confidence via thorough
>     testing.
>
>     The patch is based on rs/reftable-realloc-errors. Sadly, the patch f=
ails
>     the PR build
>     [https://github.com/gitgitgadget/git/actions/runs/12672507500/job/35=
316720255],
>     but then the base branch fails in the same way
>     [https://github.com/gitgitgadget/git/actions/runs/12533205564/job/34=
952668803].
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1848%2=
Fdscho%2Freftable-tests-should-allow-malloc-to-be-defined-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1848/dsch=
o/reftable-tests-should-allow-malloc-to-be-defined-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1848
>
>  t/unit-tests/t-reftable-basics.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/t/unit-tests/t-reftable-basics.c b/t/unit-tests/t-reftable-=
basics.c
> index 990dc1a2445..1d640b280f9 100644
> --- a/t/unit-tests/t-reftable-basics.c
> +++ b/t/unit-tests/t-reftable-basics.c
> @@ -157,13 +157,13 @@ int cmd_main(int argc UNUSED, const char *argv[] U=
NUSED)
>
>  		old_alloc =3D alloc;
>  		old_arr =3D arr;
> -		reftable_set_alloc(malloc, realloc_stub, free);
> +		reftable_set_alloc(NULL, realloc_stub, NULL);
>  		check(REFTABLE_ALLOC_GROW(arr, old_alloc + 1, alloc));
>  		check(arr =3D=3D old_arr);
>  		check_uint(alloc, =3D=3D, old_alloc);
>
>  		old_alloc =3D alloc;
> -		reftable_set_alloc(malloc, realloc, free);
> +		reftable_set_alloc(NULL, NULL, NULL);
>  		check(!REFTABLE_ALLOC_GROW(arr, old_alloc + 1, alloc));
>  		check(arr !=3D NULL);
>  		check_uint(alloc, >, old_alloc);
> @@ -188,11 +188,11 @@ int cmd_main(int argc UNUSED, const char *argv[] U=
NUSED)
>  		arr[alloc - 1] =3D 42;
>
>  		old_alloc =3D alloc;
> -		reftable_set_alloc(malloc, realloc_stub, free);
> +		reftable_set_alloc(NULL, realloc_stub, NULL);
>  		REFTABLE_ALLOC_GROW_OR_NULL(arr, old_alloc + 1, alloc);
>  		check(arr =3D=3D NULL);
>  		check_uint(alloc, =3D=3D, 0);
> -		reftable_set_alloc(malloc, realloc, free);
> +		reftable_set_alloc(NULL, NULL, NULL);

Using NULL also captures the intent to set the default allocator better.

>
>  		reftable_free(arr);
>  	}
>
> base-commit: 1e781209284eb5952e153339f45bf0c1555e78bb

