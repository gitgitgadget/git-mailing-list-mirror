Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4CA4C9F
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 22:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737584261; cv=none; b=D6pOVVsCpr5/ODYJUTdvh6zd2dbmDvG8lzpoSZN15CeIR25ocEA5XeZ9UCu/HAcfUbo+b018UUALcGmnry6axIX0ZqmmK1TN/HRCTPLfHijlULGf3FzBrCpurZCWcSmH3FaGk7WfvKylY+ZX3Ph30x12jlx6O0SWGOlrcSfs47o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737584261; c=relaxed/simple;
	bh=g9R0l1maM/Yi299oyuy0O06Hga+n7ETCAqxlCUncW7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LfqQ29JjRKVcIBa4qPGnHRpVlmW59QOpbQfVFfGHs0vSE2rB3BNjEli8ynBiS/ePBiRZ5mPd9ykClDPWpl0BZyb5idKjyWRvAbODWSMlGmcO/yukeeNfS4tzhtsUgEVGLcDkby6gVEbk5pN5Q34fau8iI+ZOk7zMrZr1ik7g6jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=VAGCk84L; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="VAGCk84L"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e53537d8feeso421836276.0
        for <git@vger.kernel.org>; Wed, 22 Jan 2025 14:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1737584258; x=1738189058; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Zko8D6YEayADzWdqtkCxeTGXXhYAycUl+h789+l7Vo=;
        b=VAGCk84L+oK8ZbFARsC72Rw2Qt6ZCQ1sSYNoYEOfs0brt54SofV9n7rCUI6KBVFZ1r
         V3AWjXFr5X4iGIhMfUODMk3p077YN6m+fh3+clj1CDFYw/IV2Y5u2o+8I/64UYNYn0At
         pvs0Cw3hWmR1H9CKRQ1eNE+AM9vDNLuGFJuJQPc+csfybCrHy/gIisY6fGX5DwQ6VKVK
         ZTh+A3E22qrN8TR9zkpEeyn8K1cNKE3JcrzsNQpAwUj2VqXJ5F5JIO5JpObiyRYptVwI
         Tg8VDd/MFuofbSl4tn9V412XnFSsqXxQYBNDZQuqyky6S/k1K/KqBqSmXuXh5laQtwlf
         FCLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737584258; x=1738189058;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Zko8D6YEayADzWdqtkCxeTGXXhYAycUl+h789+l7Vo=;
        b=V2eaSkFst78VJwatA1YYZS67XCJWhTjog+JyD6NuvAfkLrFIfjeSJ4rvuswd50AE+B
         mI28ScrQy7YHXLuD+x5LP5yDROTzL/DbKvU+jFvxDiCzAJW0XV1V7Y23o7SEiYSOGq35
         Ayr8Mmj69jSfGtlB6tHiNW8iwQ+p8MzbXCPN7sCCV0CGniDDCcQgKM79PrkGGdCRlDur
         HrWNaJcXcexu7wKDrLIuyqRg+XiAtCEfiPTRpcGo1UBtd0QJ3dI7tCexHJbBrd9YgTju
         7Cq8vTcTk1mSgxcIB/vz0c2oz89qxEGGXTLnzvWaipze4YO/6FziSrwzG+tpncyZiZmg
         RaLA==
X-Gm-Message-State: AOJu0YyBP50TIOklMsUNqz3+xZQIBxyjMiHnuzWgPC0SZ4zZyURH8oGg
	tjyoghZ+HbG1tjiKbq3y9B5QV93kEuwrw5FMdFrqyQp6CKdcYj6RU8loV3iNc4U=
X-Gm-Gg: ASbGncswQA9y83MIqpHyChexIA0IVue5vwxoirqq0JFx9UG7PzaCS+ROJurgPShRmbL
	KEIdhxfC8n6vRg9RuYy4xCr9OFn8mO01h/w3kuUFyYa+Ub++Lfsiks+QmQlylAgP/9aiaVGNscJ
	daCZhF7LNkflEzrODOX2Zlhjb4Xm9yVZCG7efBstjyAVAcEtnrd7v4njYdOmm8YpZ2xIhkVnXau
	qW3hh+wFyiBzG/1hG60PuMMGuPd6IdBp9lwDzEkQv7MKYVtR2PHKRss9kf+40QF1w3F6NVjCCRk
	f4co2zH04ioL4GlxbqacQ4WbroJGI0Zrmg9iiKb85g==
X-Google-Smtp-Source: AGHT+IGG/Aujok6QagEnHWlx2SNeZdixfk/OuIzWnz5nfC5ZQQ91lQpnqZau/HLfek0iIgizPyf8/Q==
X-Received: by 2002:a05:690c:6806:b0:6f5:3bb1:7b7f with SMTP id 00721157ae682-6f6eb90d548mr202199257b3.26.1737584258308;
        Wed, 22 Jan 2025 14:17:38 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f6e66f7b28sm22039917b3.112.2025.01.22.14.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 14:17:37 -0800 (PST)
Date: Wed, 22 Jan 2025 17:17:36 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
	peff@peff.net, ps@pks.im, johncai86@gmail.com, newren@gmail.com,
	jonathantanmy@google.com, karthik nayak <karthik.188@gmail.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 2/8] pack-objects: add --name-hash-version option
Message-ID: <Z5FugEXhdKjhwcnP@nand.local>
References: <pull.1823.v2.git.1733181682.gitgitgadget@gmail.com>
 <pull.1823.v3.git.1734715194.gitgitgadget@gmail.com>
 <d035e3e59f42c75760e8dd6fe8ed6dff12bc8b9a.1734715194.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d035e3e59f42c75760e8dd6fe8ed6dff12bc8b9a.1734715194.git.gitgitgadget@gmail.com>

On Fri, Dec 20, 2024 at 05:19:48PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <stolee@gmail.com>
>
> The previous change introduced a new pack_name_hash_v2() function that
> intends to satisfy much of the hash locality features of the existing
> pack_name_hash() function while also distinguishing paths with similar
> final components of their paths.
>
> This change adds a new --name-hash-version option for 'git pack-objects'
> to allow users to select their preferred function version. This use of
> an integer version allows for future expansion and a direct way to later
> store a name hash version in the .bitmap format.
>
> For now, let's consider how effective this mechanism is when repacking a
> repository with different name hash versions. Specifically, we will
> execute 'git pack-objects' the same way a 'git repack -adf' process
> would, except we include --name-hash-version=<n> for testing.
>
> On the Git repository, we do not expect much difference. All path names
> are short. This is backed by our results:
>
> | Stage                 | Pack Size | Repack Time |
> |-----------------------|-----------|-------------|
> | After clone           | 260 MB    | N/A         |
> | --name-hash-version=1 | 127 MB    | 129s        |
> | --name-hash-version=2 | 127 MB    | 112s        |
>
> This example demonstrates how there is some natural overhead coming from
> the cloned copy because the server is hosting many forks and has not
> optimized for exactly this set of reachable objects. But the full repack
> has similar characteristics for both versions.
>
> Let's consider some repositories that are hitting too many collisions
> with version 1. First, let's explore the kinds of paths that are
> commonly causing these collisions:
>
>  * "/CHANGELOG.json" is 15 characters, and is created by the beachball
>    [1] tool. Only the final character of the parent directory can
>    differentiate different versions of this file, but also only the two
>    most-significant digits. If that character is a letter, then this is
>    always a collision. Similar issues occur with the similar
>    "/CHANGELOG.md" path, though there is more opportunity for
>    differences In the parent directory.
>
>  * Localization files frequently have common filenames but
>    differentiates via parent directories. In C#, the name
>    "/strings.resx.lcl" is used for these localization files and they
>    will all collide in name-hash.
>
> [1] https://github.com/microsoft/beachball
>
> I've come across many other examples where some internal tool uses a
> common name across multiple directories and is causing Git to repack
> poorly due to name-hash collisions.
>
> One open-source example is the fluentui [2] repo, which  uses beachball
> to generate CHANGELOG.json and CHANGELOG.md files, and these files have
> very poor delta characteristics when comparing against versions across
> parent directories.
>
> | Stage                 | Pack Size | Repack Time |
> |-----------------------|-----------|-------------|
> | After clone           | 694 MB    | N/A         |
> | --name-hash-version=1 | 438 MB    | 728s        |
> | --name-hash-version=2 | 168 MB    | 142s        |
>
> [2] https://github.com/microsoft/fluentui
>
> In this example, we see significant gains in the compressed packfile
> size as well as the time taken to compute the packfile.
>
> Using a collection of repositories that use the beachball tool, I was
> able to make similar comparisions with dramatic results. While the
> fluentui repo is public, the others are private so cannot be shared for
> reproduction. The results are so significant that I find it important to
> share here:
>
> | Repo     | --name-hash-version=1 | --name-hash-version=2 |
> |----------|-----------------------|-----------------------|
> | fluentui |               440 MB  |               161 MB  |
> | Repo B   |             6,248 MB  |               856 MB  |
> | Repo C   |            37,278 MB  |             6,755 MB  |
> | Repo D   |           131,204 MB  |             7,463 MB  |
>
> Future changes could include making --name-hash-version implied by a config
> value or even implied by default during a full repack.
>
> It is important to point out that the name hash value is stored in the
> .bitmap file format, so we must force --name-hash-version=1 when bitmaps
> are being read or written. Later, the bitmap format could be updated to
> be aware of the name hash version so deltas can be quickly computed
> across the bitmapped/not-bitmapped boundary.
>
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>  Documentation/git-pack-objects.txt | 32 ++++++++++++++++++-
>  builtin/pack-objects.c             | 49 +++++++++++++++++++++++++++---
>  t/t5300-pack-object.sh             | 31 +++++++++++++++++++
>  3 files changed, 106 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
> index e32404c6aae..7f69ae4855f 100644
> --- a/Documentation/git-pack-objects.txt
> +++ b/Documentation/git-pack-objects.txt
> @@ -15,7 +15,8 @@ SYNOPSIS
>  	[--revs [--unpacked | --all]] [--keep-pack=<pack-name>]
>  	[--cruft] [--cruft-expiration=<time>]
>  	[--stdout [--filter=<filter-spec>] | <base-name>]
> -	[--shallow] [--keep-true-parents] [--[no-]sparse] < <object-list>
> +	[--shallow] [--keep-true-parents] [--[no-]sparse]
> +	[--name-hash-version=<n>] < <object-list>
>
>
>  DESCRIPTION
> @@ -345,6 +346,35 @@ raise an error.
>  	Restrict delta matches based on "islands". See DELTA ISLANDS
>  	below.
>
> +--name-hash-version=<n>::
> +	While performing delta compression, Git groups objects that may be
> +	similar based on heuristics using the path to that object. While
> +	grouping objects by an exact path match is good for paths with
> +	many versions, there are benefits for finding delta pairs across
> +	different full paths. Git collects objects by type and then by a
> +	"name hash" of the path and then by size, hoping to group objects
> +	that will compress well together.
> ++
> +The default name hash version is `1`, which prioritizes hash locality by
> +considering the final bytes of the path as providing the maximum magnitude
> +to the hash function. This version excels at distinguishing short paths
> +and finding renames across directories. However, the hash function depends
> +primarily on the final 16 bytes of the path. If there are many paths in
> +the repo that have the same final 16 bytes and differ only by parent
> +directory, then this name-hash may lead to too many collisions and cause
> +poor results. At the moment, this version is required when writing
> +reachability bitmap files with `--write-bitmap-index`.
> ++
> +The name hash version `2` has similar locality features as version `1`,
> +except it considers each path component separately and overlays the hashes
> +with a shift. This still prioritizes the final bytes of the path, but also
> +"salts" the lower bits of the hash using the parent directory names. This
> +method allows for some of the locality benefits of version `1` while
> +breaking most of the collisions from a similarly-named file appearing in
> +many different directories. At the moment, this version is not allowed
> +when writing reachability bitmap files with `--write-bitmap-index` and it
> +will be automatically changed to version `1`.
> +
>
>  DELTA ISLANDS
>  -------------
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 08007142671..90ea19417bc 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -266,6 +266,28 @@ struct configured_exclusion {
>  static struct oidmap configured_exclusions;
>
>  static struct oidset excluded_by_config;
> +static int name_hash_version = 1;
> +
> +static void validate_name_hash_version(void)
> +{
> +	if (name_hash_version < 1 || name_hash_version > 2)
> +		die(_("invalid --name-hash-version option: %d"), name_hash_version);
> +}
> +
> +static inline uint32_t pack_name_hash_fn(const char *name)
> +{
> +	switch (name_hash_version)
> +	{

This is definitely a nitpick, but the opening curly brace should appear
on the preceding line. I don't think our CodingGuidelines explicitly say
this. But in my head the convention is that only function bodies have
their enclosing braces on their own line, as opposed to:

    static inline uint32_t pack_name_hash_fn(const char *name) {

> +	case 1:
> +		return pack_name_hash(name);
> +
> +	case 2:
> +		return pack_name_hash_v2((const unsigned char *)name);
> +
> +	default:
> +		BUG("invalid name-hash version: %d", name_hash_version);
> +	}
> +}

Otherwise this function looks very reasonable.

> @@ -4576,6 +4609,12 @@ int cmd_pack_objects(int argc,
>  	if (pack_to_stdout || !rev_list_all)
>  		write_bitmap_index = 0;
>
> +	validate_name_hash_version();
> +	if (write_bitmap_index && name_hash_version != 1) {
> +		warning(_("currently, --write-bitmap-index requires --name-hash-version=1"));
> +		name_hash_version = 1;
> +	}
> +

Hmm. validate_name_hash_version() is its own function, which seems good,
but then we do further validation on it here. I wonder if we should
either move the latter step into validate_name_hash_version(), which
would require us to pass a pointer to name_hash_version, or assign it
the return value of validate_name_hash_version() (assuming it were
changed to return the appropriate type instead of void).

I think that we are probably pretty far into bike-shedding territory,
but figured I'd share as it jumped out to me while reviewing.

>  	if (use_delta_islands)
>  		strvec_push(&rp, "--topo-order");
>
> diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
> index 3b9dae331a5..4270eabe8b7 100755
> --- a/t/t5300-pack-object.sh
> +++ b/t/t5300-pack-object.sh
> @@ -674,4 +674,35 @@ do
>  	'
>  done
>
> +test_expect_success 'valid and invalid --name-hash-versions' '
> +	# Valid values are hard to verify other than "do not fail".
> +	# Performance tests will be more valuable to validate these versions.
> +	for value in 1 2
> +	do
> +		git pack-objects base --all --name-hash-version=$value || return 1
> +	done &&
> +
> +	# Invalid values have clear post-conditions.
> +	for value in -1 0 3
> +	do
> +		test_must_fail git pack-objects base --all --name-hash-version=$value 2>err &&
> +		test_grep "invalid --name-hash-version option" err || return 1
> +	done
> +'

Looks great, and thanks for handling a few nonsensical values in the
latter loop.

> +# The following test is not necessarily a permanent choice, but since we do not
> +# have a "name hash version" bit in the .bitmap file format, we cannot write the
> +# hash values into the .bitmap file without risking breakage later.
> +#
> +# TODO: Make these compatible in the future and replace this test with the
> +# expected behavior when both are specified.
> +test_expect_success '--name-hash-version=2 and --write-bitmap-index are incompatible' '
> +	git pack-objects base --all --name-hash-version=2 --write-bitmap-index 2>err &&
> +	test_grep "currently, --write-bitmap-index requires --name-hash-version=1" err &&
> +
> +	# --stdout option silently removes --write-bitmap-index
> +	git pack-objects --stdout --all --name-hash-version=2 --write-bitmap-index >out 2>err &&
> +	! test_grep "currently, --write-bitmap-index requires --name-hash-version=1" err
> +'

This is grea, too, I appreciate having the reminder here for the future
(and it'll feel so satisfying to change/remove this test when the time
comes) ;-).

Thanks,
Taylor
