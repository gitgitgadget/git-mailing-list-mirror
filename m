Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26406435EF3
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 10:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787825540; cv=pass; b=TeNyF8Jxq4K/thl9WZ7zc8D6qiJrQtQGVH4L9MHxeGC1ddq7uMEjjH1dp+OPIwHMlg8FhnGkSsNAa6XXtvdpU7XgYNQcioUQW+rs9N7GQOdqJxljsx0g/P3o8ErNy0ptjwDGYTvSuPn6jqkiTTLLWunywHXcJgwAiF+GAvK3W6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787825540; c=relaxed/simple;
	bh=RCTtTmq/dQw2nryAZ+IjAKHS5Tnzrxj923HQp7CdwoE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=MvpmNMWrsSt1K3k5DIb0lYXdGdtPzuLrB4OHIe1uRWNNuVBe/vH9CZFLUo4S3Hnxb67l+J40qGLqi9D6W4NK/PTewt+lJbizhtbhuVvpBUjCbFA0DM5pqgNnjIODJlsXvZMAL2FxajeuNzSil9HicjI2e5Laq6ivFx9/zGWLZmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F9YZF+SA; arc=pass smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9YZF+SA"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-783a121c597so336316137.2
        for <git@vger.kernel.org>; Thu, 27 Aug 2026 03:12:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787825535; cv=none;
        d=google.com; s=arc-20260327;
        b=ORQccN0a3ZxZq6h28NKUKEE0JWxSfcE9TKrVJCGDGQkJTFDGqBMuJ7bc0BLP4Z4xGJ
         3reWI+hcSB/8djycw64gHWVxqMggucVbziNMWeK/Eh60GqeQn6DmpIIYm004Q2epYVVY
         WfHSbDDZ4QM6Tor8nJYfGKK5sQ9ISEDJlCvWjEa6loJMLozK2myR6xtAFAj0B5fz/39N
         mrt7e9sOjptWy+k3SrRrySpohM9EgJIvgSkZLEfdayDGXOoVe+26++4FRU0q8I7YIgtn
         FU2bAB6WCIni2Ed2aqVGNAhQqj6vZcGOVvgSV4aBsVR2BRnr5vibsfwo+/qXJMRnxwX2
         C1xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=rqYOt3oQ6BM3bq/xGM2Ps/7Z/Zq19X+v25gViaE9oF0=;
        fh=TeiXow/tZeVoz/9sgJU1Ps5tCgDV8MKQgyXGb8YmNlU=;
        b=dwMeWEgZ2ZhYJW7xdjHfSnXuKGBIEckPIHQT+2hSYhgP3x7/Oj/0Lidn+nZgxJMAHS
         N2uil/+iYeIMZMUtq/3ujhAZb8Mes7kyv09TaSN0+99MQsHWWjpOQJ/gFktKRi9Un2E+
         xOM8vMXMvm4xsgGEqSP+TINwTIhrVDhc0MKi1uAzzaWRLLGLvXwC+784B/3KeP8rrONQ
         18YJVd4HU3MTpiwUfgYX8a8wpN2eGK7rZ1UGjSf1ZmRL16HQM2CjooQu3n1dG0cI8Jop
         VJ8lYaZx55+cCccqs3fMNZtVuvWXxnhYqbYoPpblMwZzTm1duXI1P4CMY7N/65kb+tCP
         vG1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787825535; x=1788430335; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rqYOt3oQ6BM3bq/xGM2Ps/7Z/Zq19X+v25gViaE9oF0=;
        b=F9YZF+SANNfUADgHkJNlHIoIVLoqEalsTYRlbMR8xw6ZU1MkbyzIvsHgnTgyOaL6z3
         LSPqJ29660pep8Zr+vyb1peEef4G1UfGnezXWo0EMajW9tkbDYrUurYyGg9NbpI6bTOo
         tqjncUTgqJYC09y2TcnxtOEkLR1TIF73/56am09+nr0D0SKTnafBWmF+3Sq8cfZx07s+
         FyD2I3O99YmEqdSCpzQal56U3qZ25LpQiNLunFF6dAHISucB3OKIvvpZfY20ICq0W9kJ
         Bmzb97iqlzjBh9wmZUeDGNpM2NwWLRZppWjNbqilw8WPHIn1Thq7ruvaCg06zPJQnmFE
         OHFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787825535; x=1788430335;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rqYOt3oQ6BM3bq/xGM2Ps/7Z/Zq19X+v25gViaE9oF0=;
        b=WoQHp5STxGMX66q+iT3AyoOz1m919h2kByGLYwD1k2i0mTU/fWfhn2PlggUqxHStQR
         L9tgmYGHIOSdKKcqoCWyvcLwIjyFt33EwGmHxCAYpOOmyDaTvu9qYdKeSWpe3zK4aQ3Z
         JGyTdRJsDGJ2hjDOgs4lvF8hXLB9JCfyMD8/5N1YL6iN7VAz3+vtk9zA+2Wf2rV7/SbL
         BV+thu/Zp6CDLkRN1b687hloMDAe6h0AjBm0mNqIaKTxFDxgqaHOKkAg0NU9yx1hl4YO
         uZZwCpCWKHwatIxd9EY1ak/NYwi09Jh5t/lZeM6GiqkR0YuMOwhDYPKVaCIKLFOdDTms
         hgJA==
X-Forwarded-Encrypted: i=1; AHgh+RpYZeweAG9wo4i6Gbrn1Bpt1NKVSixUUxTr7nJdBANgjPPPVJHpfviSlEFry0X8XTKJrik=@vger.kernel.org
X-Gm-Message-State: AFuF++noQpip+zZqeMrTnxMteAMzoQfjmfWLZP9XV9a5ZNqRzYNVDY4q
	jSQX6PBM4ZvtBu9nYYlxzTCWJcdxiAntybOLN/9wi5nkUdXhL1sJB5XTLh7MXIBADI0Jdv8zjPl
	Jvr3Uy3Jl6A6f5/t+1sZ3lPtHlCqzC+iI/0ZC
X-Gm-Gg: AR+sD123Yxo6/XggQIkfQ2l0nO5wcE9uO4TCBv2Q4DtYCZUAU2/Ytf4ElXWXhh7RnPq
	iWyUkCz8rxN7PBWx1/5n0JB/2vbinXLYMYedn4RVp8RFC7nxMyRa4VFwx0PnYWk5rAYDYW5qATZ
	R6mJnzugqIjcSchSgthOV7cfEEnf/i0yR28lFvCIPNFp31MeCLuc2vkzAZtCiUTRHpll49gshhd
	vTnxJKGYFqvBx4BP8TUoURy1yEQskDjxq7iPhAgfBGLQ1AaD1qdOKuWmpZo0nsnphJCqW42QZJW
	fATrCFujg54vfFe2bG0hVXn7Nnm5q4V17JBQ/KGLcgKSkoMU1ePOm5o44F8eaII+x49x2gZyThs
	ohfYpVNBTlOBkpTuqmOt/7qZefwApx2DN7Is9c9pQ2FWg
X-Received: by 2002:a05:6102:8558:20b0:784:b9ec:913d with SMTP id
 ada2fe7eead31-784b9ecc9b5mr514276137.8.1787825534673; Thu, 27 Aug 2026
 03:12:14 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Aug 2026 06:12:13 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Aug 2026 06:12:13 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260825-pks-odb-source-fsck-v1-4-b756de0bf24f@pks.im>
References: <20260825-pks-odb-source-fsck-v1-0-b756de0bf24f@pks.im> <20260825-pks-odb-source-fsck-v1-4-b756de0bf24f@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 27 Aug 2026 06:12:13 -0400
X-Gm-Features: AcwNN1Vx_svUXmGqd14qbvTzpxZDznGCl9tw-4uJ6a1GUhbKLnPRPBku5yMfZ08
Message-ID: <CAOLa=ZThFKpbmifU-zScXqiT1QSQqCTppHWbgSqmpRft8K+0XQ@mail.gmail.com>
Subject: Re: [PATCH 04/10] builtin/fsck: don't check alternates with "--no-full"
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000ea4629065a049134"

--000000000000ea4629065a049134
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> According to git-fsck(1), the "--full" option behaves in the following
> way:
>
>   Check not just objects in GIT_OBJECT_DIRECTORY ($GIT_DIR/objects), but
>   also the ones found in alternate object pools listed in
>   GIT_ALTERNATE_OBJECT_DIRECTORIES or $GIT_DIR/objects/info/alternates,
>   and in packed Git archives found in $GIT_DIR/objects/pack and
>   corresponding pack subdirectories in alternate object pools.
>
> So ultimately, it is supposed to control two things: (1) whether we only
> check the main object directory, and (2) whether we check packfiles.
>
> In its current state though, the flag only controls whether we check
> packfiles or not, and if so we verify packfiles of all attached sources.
> But we also have checks for loose objects in git-fsck(1), and here we
> unconditionally check them in all sources.
>

To reiterate,

without '--full': Check local loose + alternate loose. No packed objects

with '--full': Check local loose + alternate loose. local packed +
alternates packed.

And we want to only do local loose in the latter. Makes sense.

>
> The flag is arguably conflating two unrelated concerns with one another,
> and it really should be split up into two flags: one that controls how
> thorough we want to check individual sources, and one that controls
> which sources we want to check in the first place. So ideally, we would
> have:
>
>   - "--include-alternates": check all sources, not only the local one.
>
>   - "--include-optimized-objects": check not only loose objects, but
>     also those that have been packed. Note that we explicitly don't say
>     "--include-packed-objects" here to be more backend-agnostic.
>
>   - "--full": implies both of the above flags.
>
> This feels out of scope for this series though. So for now, simply fix
> the code by honoring locality of the sources for loose objects.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/fsck.c  | 3 ++-
>  t/t1450-fsck.sh | 5 +++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index 5132ff0f15..3f6056535f 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -1047,7 +1047,8 @@ int cmd_fsck(int argc,
>  				    mark_object_for_connectivity, repo, 0);
>  	} else {
>  		for (source = repo->objects->sources; source; source = source->next)
> -			fsck_source(repo, source);
> +			if (check_full || source->local)
> +				fsck_source(repo, source);
>

So we check the local bit and only fsck that source. Looks good.

>  		if (check_full) {
>  			struct packed_git *p;
> diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
> index 77cd96de78..1b4074304c 100755
> --- a/t/t1450-fsck.sh
> +++ b/t/t1450-fsck.sh
> @@ -844,6 +844,11 @@ test_expect_success 'alternate objects are correctly blamed' '
>  	echo "../../alt.git/objects" >.git/objects/info/alternates &&
>  	mkdir alt.git/objects/$(dirname $path) &&
>  	>alt.git/objects/$(dirname $path)/$(basename $path) &&
> +
> +	# Without "--full", only the local object source is checked.
> +	git fsck --no-full >out 2>&1 &&
> +	test_must_be_empty out &&
> +
>  	test_must_fail git fsck >out 2>&1 &&
>  	test_grep alt.git out
>  '
>
> --
> 2.55.0.822.g20453c30eb.dirty

--000000000000ea4629065a049134
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 3cebf58b1e966091_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xUURYd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md00wQy8wUUQvV0w1YVNRUDloY0ZjR0xKdzR3Wm5tdwpHalBkZ1dEMnha
S1pGc2thYzU0YXIwemFiNkliTWV0eXg3ZjJkVFAwVTJIR1ZUc3duZjhFcWhvTGpEdERPWUlMCitL
dk4vQ0Nzb0pzL09Nak5zb0VTQk1qSUNPWnBPNkZvemJGY040Z3RUb2h3T0cvelRIWGFjRWd6VFo3
T3M2WVkKMnVSamV4eE5zUTllUGNyLzFINUVvRVljYkhaMFZiODZPc05yR3VmLzFRazd1aHh6Mmdo
bVVLclF4NWR4L09xUQpCcEx0UUdqMGJIN3NFcm1BRmxaMGZLRzdaYkVIbXpmTGV2dGFGUUxIQlBH
Y09jN2FjK1RtTGN5RmJMcFdLYnB6CmVQeUFBeTF2aHZ4ODVYOUZORVQyR0IzandQZTFvVWJrZ3JW
aFlzTlpROXNYMFY5MjVSVWlIZVRtazZ5YVNxOTIKUzFINXlaYU8zb3hvbWI5K05vWUd5WmhoOFpJ
SzAyMlJHUVZPOGZSa0V4RHlNeHIzVWRnN2hmM3VwYWhKN3VOcgpIcDJ6U2w1dHVzdEszc0YrbUNP
V3NZT0lTRHI3eXNrY2hVV2RrQVJmZHBkM0xmaVMyNmUxZ0hVdGRROC9nQkw4CmdEWVY2eU4razRo
ZlBNc0R1UkNXaWU0bVlpSnFhTFZnZGJES3BKUT0KPWlhU3QKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000ea4629065a049134--
