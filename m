Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DBD1D5157
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 20:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732219698; cv=none; b=lxxb7QQyRXu+QPzJ1/Fd+6T/KI9b+7PgNYW0SPl15vtr9NAN5SizfzEbZ06SGCDw4AqePkte9BmF5AHbrILIsP7N+puuFmRQfWaqj5I9ItNYWSNaWLmiY2xaVbfPM3VQdHjOb+1fhTbCBJvYKLICqTgZzdQrp0+CpI9E08ZWId8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732219698; c=relaxed/simple;
	bh=Z6OGeSiRiCrSBlR8Lnis3u56TF3Z6QtYVV9ffKisA9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r2IB2bn/G2dzj9GF8WSP4P9PtLcw+kMoyeiiXdW5Kvg3e2v3gwGSZS4O5ODexebUmnqwhjvV8PSfKF+9EEyuXlrC/lum6WSVqTzZuc7Pr+jPIzniXwevECTBHrNLEPep/Zj+fz0Qfbf5YIUtkJjKUnRrfQFJArApX3R3o6N6bOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=FUugpm7j; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="FUugpm7j"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e387e50d98eso1130204276.2
        for <git@vger.kernel.org>; Thu, 21 Nov 2024 12:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1732219694; x=1732824494; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JhaaNUNYx9wcb51v8DpxXAWxR8dkVB8T+M3wOXwjylY=;
        b=FUugpm7jekbqbvdcEtbg/yMGitXqkmIo9uPf8eADXcyd66EotBVGq7v2GT/NhKYThQ
         tE3iGzxKn16Ec3r7dYdl25eWsNRZd1BmGJFQt8FqmhRjhAB6nEk2496/XMbL4hnBfDBz
         O3jP39gDMQOJj5XmpwetJMQPO68AJkiKQUJVbaHH9ZHnlxkfaa2/0Yu0u6XZR8XQQBSk
         O6n9I01vltfyl1XmtOEbXPRcHgUDomjK1OvwSvB1sXWEb5waDkePiXQsBDP3P52TBqt+
         7AkSTt5Psa7BL++pse8GnoUsMnF4S3BK9rUtQSeXu91k++a4+444ghflZ8/xiiRFzt6l
         O28Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732219695; x=1732824495;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JhaaNUNYx9wcb51v8DpxXAWxR8dkVB8T+M3wOXwjylY=;
        b=FbvsBHwfDLEdtHvC1k+U9umHAa6qsr3XU6Po2qN6YHUEhJ3yVsbvucwbt1Q8sabKIK
         c+MLV1oMTFt/djrYbo8wY7MSNhtYyml6xHEBZpM3jswLb2eQ7+Ho9qPQ5zPux5jWEJ9K
         /awVOECKWPTW6q8i7CsK6C/rWrOWpSdyAHl2qESx3pjbnkmfXx7XeHWHEGlo6ZUvX4Uq
         kke3ojOItQsWc+kEYyn92AIpshA/HA2iXxCs3EEV8BCBJw+2F9pE8G/5+yuRZR+vK9j6
         rt86H1Ohabkxnu0ePmq4AoHaQ+qoCZ/zWa0d37vtgJtSXKUa5CodsWuVIvBNzt4nCZdf
         MC8w==
X-Gm-Message-State: AOJu0YwWexCnZ6JiDvEN1hSaR9335uYRHk9m0CvJjeqXsb7s1P9s/Z/P
	MEyfbanCMqfXkt/5O/vqpW49yf62GD+XkbDo5Q8ESGlDXNqpv3/RJySH1liAE0s=
X-Gm-Gg: ASbGncs7i7bZ7taXF99IeB+/gcNT6sTVP/yU454JnElO9uCHK4Wry6RhdNTI3+xcAbU
	href6QNXr2SLWKoMTteeT2RgEGGAl/iqlsiDIvDT0IkTAW9Jb8Vqjpu6lwXXv+TnjawU9PAwZ+Q
	GgXs2UNhJMgT2CBqiveU4Wwo4rebvQ8o+/hdXe6suBPfaMLqYudQjDC3pFSRfu6N9xXcxH1br/T
	F3XVsBj6FXzPdEPKsas4iGvmQamXa2OgXQCPRqcfZSWri1znHX/qXvNOdDOm5Lp9u82mcmalPiC
	bwBrQ1hfrCy063r7wu71ig==
X-Google-Smtp-Source: AGHT+IH5nGNKHnELdVLD/+3FM2iJ+S1OGQxNsbbAH1EQjVeF2D8FcN6x9+lwFVCrbrw3YsFxYCqkcw==
X-Received: by 2002:a05:6902:2b0a:b0:e38:1dbd:5765 with SMTP id 3f1490d57ef6-e38f8c08d06mr190170276.45.1732219694470;
        Thu, 21 Nov 2024 12:08:14 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e38f601c900sm124326276.1.2024.11.21.12.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 12:08:13 -0800 (PST)
Date: Thu, 21 Nov 2024 15:08:09 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
	peff@peff.net, ps@pks.im, johncai86@gmail.com, newren@gmail.com,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 1/7] pack-objects: add --full-name-hash option
Message-ID: <Zz+TKS2O/ij6GZ1f@nand.local>
References: <pull.1823.git.1730775907.gitgitgadget@gmail.com>
 <812257e197cfe30bd0d3c68ea6ec0d062631185f.1730775907.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <812257e197cfe30bd0d3c68ea6ec0d062631185f.1730775907.git.gitgitgadget@gmail.com>

On Tue, Nov 05, 2024 at 03:05:01AM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <stolee@gmail.com>
>
> The pack_name_hash() method has not been materially changed since it was
> introduced in ce0bd64299a (pack-objects: improve path grouping
> heuristics., 2006-06-05). The intention here is to group objects by path
> name, but also attempt to group similar file types together by making
> the most-significant digits of the hash be focused on the final
> characters.
>
> Here's the crux of the implementation:
>
> 	/*
> 	 * This effectively just creates a sortable number from the
> 	 * last sixteen non-whitespace characters. Last characters
> 	 * count "most", so things that end in ".c" sort together.
> 	 */
> 	while ((c = *name++) != 0) {
> 		if (isspace(c))
> 			continue;
> 		hash = (hash >> 2) + (c << 24);
> 	}

Hah. I like that the existing implementation is small enough to fit (in
its entirety!) into the commit message!

> As the comment mentions, this only cares about the last sixteen
> non-whitespace characters. This cause some filenames to collide more
> than others. Here are some examples that I've seen while investigating
> repositories that are growing more than they should be:
>
>  * "/CHANGELOG.json" is 15 characters, and is created by the beachball
>    [1] tool. Only the final character of the parent directory can
>    differntiate different versions of this file, but also only the two

s/differntiate/differentiate ;-).

>    most-significant digits. If that character is a letter, then this is
>    always a collision. Similar issues occur with the similar
>    "/CHANGELOG.md" path, though there is more opportunity for
>    differences in the parent directory.
>
>  * Localization files frequently have common filenames but differentiate
>    via parent directories. In C#, the name "/strings.resx.lcl" is used
>    for these localization files and they will all collide in name-hash.
>
> [1] https://github.com/microsoft/beachball
>
> I've come across many other examples where some internal tool uses a
> common name across multiple directories and is causing Git to repack
> poorly due to name-hash collisions.
>
> It is clear that the existing name-hash algorithm is optimized for
> repositories with short path names, but also is optimized for packing a
> single snapshot of a repository, not a repository with many versions of
> the same file. In my testing, this has proven out where the name-hash
> algorithm does a good job of finding peer files as delta bases when
> unable to use a historical version of that exact file.

I'm not sure I entirely agree with the suggestion that the existing hash
function is only about packing repositories with short pathnames. I
think an important part of the existing implementation is that tries to
group similar files together, regardless of whether or not they appear
in the same tree.

As you have shown, this can be a problem when the fact two files that
happen to end in "CHANGELOG.json" end up in vastly different trees and
*aren't* related. I don't think that nailing all of these details in the
commit message is necessary, but I do think it's worth adjusting what
the original commit message says in terms of what the existing algorithm
is optimized for.

> However, for repositories that have many versions of most files and
> directories, it is more important that the objects that appear at the
> same path are grouped together.
>
> Create a new pack_full_name_hash() method and a new --full-name-hash
> option for 'git pack-objects' to call that method instead. Add a simple
> pass-through for 'git repack --full-name-hash' for additional testing in
> the context of a full repack, where I expect this will be most
> effective.
>
> The hash algorithm is as simple as possible to be reasonably effective:
> for each character of the path string, add a multiple of that character
> and a large prime number (chosen arbitrarily, but intended to be large
> relative to the size of a uint32_t). Then, shift the current hash value
> to the right by 5, with overlap. The addition and shift parameters are
> standard mechanisms for creating hard-to-predict behaviors in the bits
> of the resulting hash.
>
> This is not meant to be cryptographic at all, but uniformly distributed
> across the possible hash values. This creates a hash that appears
> pseudorandom. There is no ability to consider similar file types as
> being close to each other.

I think you hint at this in the series' cover letter, but I suspect that
this pseduorandom behavior hurts in some small number of cases and that
the full-name hash idea isn't a pure win, e.g., when we really do want
to delta two paths that both end in CHAGNELOG.json despite being in
different parts of the tree.

You have some tables here below that demonstrate a significant
improvement with the full-name hash in use, which I think is good worth
keeping in my own opinion. It may be worth updating those to include the
new examples you highlighted in your revised cover letter as well.

> In a later change, a test-tool will be added so the effectiveness of
> this hash can be demonstrated directly.
>
> For now, let's consider how effective this mechanism is when repacking a
> repository with and without the --full-name-hash option. Specifically,

Is this repository publicly available? If so, it may be worth mentioning
here.

> let's use 'git repack -adf [--full-name-hash]' as our test.
>
> On the Git repository, we do not expect much difference. All path names
> are short. This is backed by our results:
>
> | Stage                 | Pack Size | Repack Time |
> |-----------------------|-----------|-------------|
> | After clone           | 260 MB    | N/A         |
> | Standard Repack       | 127MB     | 106s        |
> | With --full-name-hash | 126 MB    | 99s         |

Ahh. Here's a great example of it helping to a smaller extent. Thanks
for including this as part of demonstrating the full picture (both the
benefits and drawbacks).

> This example demonstrates how there is some natural overhead coming from
> the cloned copy because the server is hosting many forks and has not
> optimized for exactly this set of reachable objects. But the full repack
> has similar characteristics with and without --full-name-hash.

Good.

> However, we can test this in a repository that uses one of the
> problematic naming conventions above. The fluentui [2] repo uses
> beachball to generate CHANGELOG.json and CHANGELOG.md files, and these
> files have very poor delta characteristics when comparing against
> versions across parent directories.
>
> | Stage                 | Pack Size | Repack Time |
> |-----------------------|-----------|-------------|
> | After clone           | 694 MB    | N/A         |
> | Standard Repack       | 438 MB    | 728s        |
> | With --full-name-hash | 168 MB    | 142s        |
>
> [2] https://github.com/microsoft/fluentui
>
> In this example, we see significant gains in the compressed packfile
> size as well as the time taken to compute the packfile.

Amazing!

> Using a collection of repositories that use the beachball tool, I was
> able to make similar comparisions with dramatic results. While the
> fluentui repo is public, the others are private so cannot be shared for
> reproduction. The results are so significant that I find it important to
> share here:
>
> | Repo     | Standard Repack | With --full-name-hash |
> |----------|-----------------|-----------------------|
> | fluentui |         438 MB  |               168 MB  |
> | Repo B   |       6,255 MB  |               829 MB  |
> | Repo C   |      37,737 MB  |             7,125 MB  |
> | Repo D   |     130,049 MB  |             6,190 MB  |
>
> Future changes could include making --full-name-hash implied by a config
> value or even implied by default during a full repack.
>
> It is important to point out that the name hash value is stored in the
> .bitmap file format, so we must disable the --full-name-hash option when
> bitmaps are being read or written. Later, the bitmap format could be
> updated to be aware of the name hash version so deltas can be quickly
> computed across the bitmapped/not-bitmapped boundary.

Agreed.

> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>  Documentation/git-pack-objects.txt |  3 ++-
>  builtin/pack-objects.c             | 25 ++++++++++++++++++++-----
>  builtin/repack.c                   |  5 +++++
>  pack-objects.h                     | 21 +++++++++++++++++++++
>  t/t5300-pack-object.sh             | 15 +++++++++++++++
>  5 files changed, 63 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
> index e32404c6aae..93861d9f85b 100644
> --- a/Documentation/git-pack-objects.txt
> +++ b/Documentation/git-pack-objects.txt
> @@ -15,7 +15,8 @@ SYNOPSIS
>  	[--revs [--unpacked | --all]] [--keep-pack=<pack-name>]
>  	[--cruft] [--cruft-expiration=<time>]
>  	[--stdout [--filter=<filter-spec>] | <base-name>]
> -	[--shallow] [--keep-true-parents] [--[no-]sparse] < <object-list>
> +	[--shallow] [--keep-true-parents] [--[no-]sparse]
> +	[--full-name-hash] < <object-list>

OK, I see that --full-name-hash is now listed in the synopsis, but I
don't see a corresponding description of what the option does later on
in this file. I took a look through the remaining patches in this series
and couldn't find any further changes to git-pack-objects(1) either.

>  DESCRIPTION
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 08007142671..85595dfcd88 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -266,6 +266,14 @@ struct configured_exclusion {
>  static struct oidmap configured_exclusions;
>
>  static struct oidset excluded_by_config;
> +static int use_full_name_hash;
> +
> +static inline uint32_t pack_name_hash_fn(const char *name)
> +{
> +	if (use_full_name_hash)
> +		return pack_full_name_hash(name);
> +	return pack_name_hash(name);
> +}
>
>  /*
>   * stats
> @@ -1698,7 +1706,7 @@ static int add_object_entry(const struct object_id *oid, enum object_type type,
>  		return 0;
>  	}
>
> -	create_object_entry(oid, type, pack_name_hash(name),
> +	create_object_entry(oid, type, pack_name_hash_fn(name),
>  			    exclude, name && no_try_delta(name),
>  			    found_pack, found_offset);
>  	return 1;
> @@ -1912,7 +1920,7 @@ static void add_preferred_base_object(const char *name)
>  {
>  	struct pbase_tree *it;
>  	size_t cmplen;
> -	unsigned hash = pack_name_hash(name);
> +	unsigned hash = pack_name_hash_fn(name);
>
>  	if (!num_preferred_base || check_pbase_path(hash))
>  		return;
> @@ -3422,7 +3430,7 @@ static void show_object_pack_hint(struct object *object, const char *name,
>  	 * here using a now in order to perhaps improve the delta selection
>  	 * process.
>  	 */
> -	oe->hash = pack_name_hash(name);
> +	oe->hash = pack_name_hash_fn(name);
>  	oe->no_try_delta = name && no_try_delta(name);
>
>  	stdin_packs_hints_nr++;
> @@ -3572,7 +3580,7 @@ static void add_cruft_object_entry(const struct object_id *oid, enum object_type
>  	entry = packlist_find(&to_pack, oid);
>  	if (entry) {
>  		if (name) {
> -			entry->hash = pack_name_hash(name);
> +			entry->hash = pack_name_hash_fn(name);
>  			entry->no_try_delta = no_try_delta(name);
>  		}
>  	} else {
> @@ -3595,7 +3603,7 @@ static void add_cruft_object_entry(const struct object_id *oid, enum object_type
>  			return;
>  		}
>
> -		entry = create_object_entry(oid, type, pack_name_hash(name),
> +		entry = create_object_entry(oid, type, pack_name_hash_fn(name),
>  					    0, name && no_try_delta(name),
>  					    pack, offset);
>  	}
> @@ -4429,6 +4437,8 @@ int cmd_pack_objects(int argc,
>  		OPT_STRING_LIST(0, "uri-protocol", &uri_protocols,
>  				N_("protocol"),
>  				N_("exclude any configured uploadpack.blobpackfileuri with this protocol")),
> +		OPT_BOOL(0, "full-name-hash", &use_full_name_hash,
> +			 N_("optimize delta compression across identical path names over time")),
>  		OPT_END(),
>  	};
>
> @@ -4576,6 +4586,11 @@ int cmd_pack_objects(int argc,
>  	if (pack_to_stdout || !rev_list_all)
>  		write_bitmap_index = 0;
>
> +	if (write_bitmap_index && use_full_name_hash) {
> +		warning(_("currently, the --full-name-hash option is incompatible with --write-bitmap-index"));
> +		use_full_name_hash = 0;
> +	}
> +

Good, we determine this early on in the command, so we don't risk
computing different hash functions within the same process.

I wonder if it's worth guarding against mixing the hash functions within
the pack_name_hash() and pack_full_name_hash() functions themselves. I'm
thinking something like:

    static inline uint32_t pack_name_hash(const char *name)
    {
        if (use_full_name_hash)
            BUG("called pack_name_hash() with --full-name-hash")
        /* ... */
    }

and the inverse in pack_full_name_hash(). I don't think it's strictly
necessary, but it would be a nice guard against someone calling, e.g.,
pack_full_name_hash() directly instead of pack_name_hash_fn().

The other small thought I had here is that we should use the convenience
function die_for_incompatible_opt3() here, since it uses an existing
translation string for pairs of incompatible options.

(As an aside, though that function is actually implemented in the
_opt4() variant, and it knows how to handle a pair, trio, and quartet of
mutually incompatible options, there is no die_for_incompatible_opt2()
function. It may be worth adding one here since I'm sure there are other
spots which would benefit from such a function).

> diff --git a/builtin/repack.c b/builtin/repack.c
> index d6bb37e84ae..ab2a2e46b20 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c

I'm surprised to see the new option plumbed into repack in this commit.
I would have thought that it'd appear in the subsequent commit instead.
The implementation below looks good, I just imagined it would be placed
in the next commit instead of this one.

The remaining parts of this change look good to me.

Thanks,
Taylor
