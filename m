Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215453F23A6
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 11:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781092040; cv=pass; b=fxGEWwyQPIJzKMUjCbTQrH/0NXSGE8Ck3jvg9jYGpMmW0/hxrwkNEuTR33WxQ8o+MtoJttLLeR/UqQRuRDMYxir93alZT0tgpUt7xzem43CskPWIqr5lVAfAgVyYhoORjclpshgxkA2jusvi4abBMcZaQfep7MN63fDm/Zpn74o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781092040; c=relaxed/simple;
	bh=9RgWRg65wtfB/CmJ4qqQ5eaCdC/OnnwIrc/CWyjEeZk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UKlWQo1MObj1784ok8ZoLEk4GOqiJwVJxy9g1DpRnMHlHFHeWH4+ziP3xA3BkLeuiL49EBkxxTGPBQHDxORAhhI/8jeqiyn+qYlWfKtq95tMRMwc+3rOCpjhZw+vmbrSq+rnuki8bp7Qw7XuQqMz1PuHIodhGNQOAhxb/1Y0X88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TbWtNGKw; arc=pass smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbWtNGKw"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-9639d7daff3so4572382241.1
        for <git@vger.kernel.org>; Wed, 10 Jun 2026 04:47:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781092038; cv=none;
        d=google.com; s=arc-20240605;
        b=EXm6x3iVwTi32xn6nRBZXwiCpxDi5h+CZNeADkQ4nt3spFaEvde1iIPK8qMsmx+61K
         d/Z/U+H5csg8RYPQhyySdTuW8ENE00RR4Ft0VwqPnPxucp145l2fK8ddp5xJhgf8L4fT
         F3+1oTszkp3NXjCbkO+sqdZiERa690SEceI+vllgT6e7Eb0ainu14IsngRW19ayet3bT
         VYihbD5+p4/EYzSVoSl+6Qk7ZqjQszBqS70PnUs71y2l6aZahATjlwPu9f+XUxRsvtPu
         tKrAkRe/xGRpSN95/4cDRiazcXLY2deB80pcemzd8+7QhvHV5Uh2soeeuKVl914oadlM
         xnLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=83HqH62Gk6fdxUyUUqfJq63AWoOJh0eJT4/LfloLmHU=;
        fh=wOI7wIt2sTrru6JNOKbdbks6djrFhUVfFGPmpzpquX8=;
        b=DQIrAyq5Orb1uwQEAkSbe4acTs7Y3BLMjZBSJsubWA0FcJOaQOzjMoFppmqU8FwftT
         //KnHMDMdJ49LKDQ4BC0AOscSl9KUqYic+0QtbVt3CugeFcLV8Mnhs1W5clrY0JGhrcr
         XGEBX3u8ouwgPqUBW5VQzqWCL9WIcRsUi7Tpv8kWWgAfU04TMLGUliiuIL+H8D1/WP7K
         3zOpGc5PEmUiGG1pNrpMlZdoYnp8Rr0XNBQqNBm9oo3aF/iQ5GIXb1rKherPkwEaPShs
         HYz1wlWq1y0DK1oJdaveWftYWX7+oJ6RpcrDa/UdjOxhTXh0rOaaL7ZXfrDrMZppCKG5
         EcwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781092038; x=1781696838; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=83HqH62Gk6fdxUyUUqfJq63AWoOJh0eJT4/LfloLmHU=;
        b=TbWtNGKwdKOhWcvyx6YmFcEtX68CDeQLHzrJFjVYA2j0M/ZjYXdz3ycf4HZM5PKsL+
         WfVJM0bMFKPIFmdtJGRJblYqk8WVfbKoZUCFmXBCnVLy0prDwgj31WIB6xZ3szTEVAt7
         QjutaG5oYr4JWQe8HQDZb+YUKSEjuQ2/HnAkSedv5Q/cz+DP58RQicrW0X5SrLxA7ekF
         gRSQI2KwD3dANVWkOOnRSskr4iDPlsHsDuNo8iRMjBty2evs/iyJtWyog+wMTmqnjWSd
         Zyfp5/jruZh0c7frdjVpKsjwKCPpuZxqiLYFfVYYhhvljPzPj1bMH+UwGGTc0poM8jKU
         sDPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781092038; x=1781696838;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=83HqH62Gk6fdxUyUUqfJq63AWoOJh0eJT4/LfloLmHU=;
        b=Pfu4MUBoDq1nTCWMapYEN9zogSeXoSDWs0FunKVjY/pjWmvESy3YlnNun76CRQXLs2
         VSLN4JWy1RPw7BvPfgdXCBfBN/0GJY8lMBHHA5iajgtVi4vAh2UpNrVRd921kufv8hhY
         Yn1vyJEmOU/HiskQeKVKx3RgGBgv0Gxz2sKIJoNHcZE7mN1zCWc4M/fmMjQOC0ESuap4
         559yA8ISnMPJ/S9gm7AfFlU9smEVAEbnvvp1zHqny5z5owOnyWXUthCRysoNjsP/AmXN
         nrwmE324D7ErjbX4SRMNqowYrhP0jDWqjA/nhx0YyPLogSNm1sjTuidDwN0JBk47796m
         vq1A==
X-Forwarded-Encrypted: i=1; AFNElJ+j0Vd4VfcnA+0g35q1pQSlz3v5u1YtXa3SlwY3GKUlIBxq1XXMUxloj3zxxhOHfJGunf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDt37T36yswknZgw9h8zJ6DEy2LWng11In3LJVorwHHxM+eSlt
	MM6TCzdq4dSQqOAfwa29Dl0iQtw1dAOQpLC2DzdO9NaISlweer2wi+oQniVRJ/PsNUEa199g0IS
	VqYFLcGDk6mYd1Sopztsot76PmmOBik8=
X-Gm-Gg: Acq92OEQ+pef9aJqvxl6dOhVYHVwC9Y4ZztYOsAwgfWHiriM51U6nWb3XP2TilrDiII
	uo8LOfHWHMIL+6EX4J+oxTH0pEfHT6JfAyTh6XnxOBQGOVbE9t8xkMHkvNFImjGjcsoM8hp+lJ9
	/JSicvjQQMClZAGdA2dUi6vQZDy8pSj++pHlLmFS5KBxF8O9hc9qSLRo+cgME4C/0zJTlU3Liz2
	sdA+I34jt1rzE7E4Sb0124eJWy66gLPh9DnqRMT45Lc4FiImroGteTx8CsdsUcyvot4NT3LfOcX
	Yek/vPs0XJe2mml2awFYCvS0pQI/76zP/Ujjte+gjCzkPiAjvnySMd6ItVfu7Gvtc/PPcud0Oqq
	+l0MjAf4=
X-Received: by 2002:a05:6102:3f49:b0:62f:5908:648a with SMTP id
 ada2fe7eead31-6fefe3bbc85mr14745135137.28.1781092037620; Wed, 10 Jun 2026
 04:47:17 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 10 Jun 2026 07:47:17 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 10 Jun 2026 07:47:17 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260608-ref-filter-memoized-contains-v2-2-e72720344a7c@gmail.com>
References: <20260608-ref-filter-memoized-contains-v2-0-e72720344a7c@gmail.com>
 <20260608-ref-filter-memoized-contains-v2-2-e72720344a7c@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 10 Jun 2026 07:47:17 -0400
X-Gm-Features: AVVi8Cc7ZBe_tkf8f9oEmTjOzXfvM0tIrAHGVInfed9hWYy8X3tpfPHVu32By1Q
Message-ID: <CAOLa=ZRFSuGrqFXhTuQ7Dk5GCQQGHom++78xwONoiNdt1h_gWQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ref-filter: memoize --contains with generations
To: Tamir Duberstein <tamird@gmail.com>, git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>, 
	Derrick Stolee <stolee@gmail.com>, Elijah Newren <newren@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000003716db0653e4ce6e"

--0000000000003716db0653e4ce6e
Content-Type: text/plain; charset="UTF-8"

Tamir Duberstein <tamird@gmail.com> writes:

> git branch and git for-each-ref call repo_is_descendant_of() for
> each candidate selected by --contains or --no-contains. Each call
> starts a new graph walk, so refs with shared history repeatedly
> traverse the same commits.
>
> ffc4b8012d (tag: speed up --contains calculation, 2011-06-11)
> introduced a depth-first walk for git tag that caches positive and
> negative answers across candidates. ee2bd06b0f (ref-filter: implement
> '--contains' option, 2015-07-07) preserved both implementations when
> ref-filter learned --contains.
>
> The memoized walk is not always faster. Without generation numbers,
> a negative check can walk to the root even when the breadth-first
> merge-base walk finds a nearby divergence. With generation numbers,
> the depth-first walk can stop below the oldest target while still
> reusing answers across candidates.
>
> Keep the existing memoized selection for git tag. Select it for other
> ref-filter callers when generation numbers are enabled, and retain
> the breadth-first walk otherwise.
>
> When generation numbers are unavailable, repo_is_descendant_of() can
> return -1 if ancestry cannot be read. The ref-filter Boolean interface
> treated that error as a match. Check it and exit instead. The memoized
> path already dies on the same parse failure, so both selected paths now
> fail rather than return a result.
>
> Add p1500 cases for up to 8,192 packed refs along one first-parent
> history and for sibling refs near the tip with generation numbers
> forced off.
>
> On a checkout with 62,174 remote-tracking refs and generation numbers
> enabled, I ran:
>
>     hyperfine --warmup 0 --runs 3 \
>         --command-name parent \
>         '"$parent" branch -r --contains c78ae85f3ce7e >/dev/null' \
>         --command-name this-commit \
>         '"$this" branch -r --contains c78ae85f3ce7e >/dev/null'
>
> The results were:
>
>              parent       this commit
>   elapsed    104.365 s     467.7 ms
>   user        93.702 s     220.2 ms
>   system       0.723 s     182.7 ms
>
> The wall-time standard deviations were 11.356 seconds and 133.8
> milliseconds, respectively. Separate runs without redirection produced
> the same output with SHA-256
> 2466f6e2b72aa16b1a2126eddb81c8a1b2764ee251204ac034c191a925aa896f.
>
> Both revisions were built with the default -O2 flags using Apple
> clang 21.0.0 on macOS 26.5. The machine was a MacBook Pro (Mac16,6)
> with a 16-core Apple M4 Max (12 performance and four efficiency
> cores) and 128 GB RAM.
>
> Link: https://lore.kernel.org/git/1445163904-24611-1-git-send-email-Karthik.188@gmail.com/
> Link: https://lore.kernel.org/r/20230324191009.GA536967@coredump.intra.peff.net
> Link: https://lore.kernel.org/git/20260527070510.3510836-1-krka@spotify.com/
> Link: https://lore.kernel.org/r/20260608223430.GA340696@coredump.intra.peff.net
> Suggested-by: Jeff King <peff@peff.net>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  commit-reach.c                 | 13 +++++++++--
>  commit-reach.h                 |  7 ++++++
>  t/perf/p1500-graph-walks.sh    | 49 +++++++++++++++++++++++++++++++++++++++++-
>  t/t6301-for-each-ref-errors.sh | 22 +++++++++++++++++++
>  4 files changed, 88 insertions(+), 3 deletions(-)
>
> diff --git a/commit-reach.c b/commit-reach.c
> index 65b618959b..83a48004ef 100644
> --- a/commit-reach.c
> +++ b/commit-reach.c
> @@ -821,9 +821,18 @@ static enum contains_result contains_tag_algo(struct commit *candidate,
>  int commit_contains(struct ref_filter *filter, struct commit *commit,
>  		    struct commit_list *list, struct contains_cache *cache)
>  {
> -	if (filter->with_commit_tag_algo)
> +	int result;
> +
> +	if (!list)
> +		return 1;
> +	if (filter->with_commit_tag_algo ||
> +	    generation_numbers_enabled(the_repository))

What's stopping us from dropping `filter->with_commit_tag_algo`
completely and then doing?

  if (generation_numbers_enabled(the_repository))
     return contains_algo(commit, list, cache) == CONTAINS_YES;
  return repo_is_descendant_of(the_repository, commit, list);

[snip]

--0000000000003716db0653e4ce6e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d417122cfa58133e_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1vcFRzSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNjhqREFDV01Lcml4a2F3cTd2UXRRNlF1bENxYUw0cAo2U0dCSzhMZk4w
ai9tUktleDNiSXAzZk5LYWs5dnRHWC9ybXlLUFVJY3ovOUt5aXZhTHlpM21najF4U2xwVGExCmc2
M0laMm9CTFVFb0IvWjNvWWJZQTUweEFSdzhRTXpqMXdaNisyMkxLeXNvZFZuUHRNRUtPYUE3aVFI
d0FrNzgKTUR2QmJoMG1qUHp2N2pHVFhQZDg4cld0REl4TElOeDduVThmZm4wRmJlOXlHazVkYUE1
aHVnbFFFQTY2WDZoRApqdjdRaWlQNDNSNVZNeUJQRzl4Z1dqMFVKM3BtQklsTzZtcWprQXhDZW83
T1B5NkhLTUhPMnliN3dCNFVxUkJYCllRL1NtanlzVWJqc2NMaDVRZXhFTmkzN0tPZHkyT3NDZ3Z4
MHU3YnJIOGNFbTEzODl2cTQwNEZoR3ltcEVhUHkKRU4xaUxFWEdhYmp5ZnErb3BORFd1ZFlIam5U
U1Zlc25uWkpmRzVzSDFQaEhTNFZsODJyaDVvb2VjeEllQUYrdgp2QVNJYi9WMktiMEJQdk00VjVn
ZGREek5Sc3lIV3RKaVNZamxxNkxhVWlQV1d2cS9sbThBNkhNUE1sR3NPQlBmCm5sRUpTRFNPelh0
SksxSm1nTW9DWlVXN3dqUndZc25MY0crMGF3OD0KPWFHclgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000003716db0653e4ce6e--
