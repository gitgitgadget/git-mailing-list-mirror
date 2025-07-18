Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12AE137E
	for <git@vger.kernel.org>; Fri, 18 Jul 2025 00:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752796961; cv=none; b=t2kOsESuKszhshFN53HbSYSUa26zqxFfym5k8od7kS+Xl2UAQHiyBxyb25svEwEyox3kPmtaDn4/SROb4Jqj2DDFgpxC9l1YUJBm2Nk3ToRSNlS4vYZmUpkv8Y10/gDNPufH/Z8VzhXbHpgEfe8mvdglHIpHQoAFTdWBl+bcYx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752796961; c=relaxed/simple;
	bh=kP63jeFDCb8ZGF0NFA38K5bG7MRRrs2xkNG4Ol6nEb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QOzPIEBZS3sfh+xMde0/r1MdJvX/RZNnS5ebbUWNcC0ltZBNKAe2AujE+1bTOo9pg62f0nFAD6oV1KdDoxmugvel+zYSwMjmcTTAF6xKVm6UkY6Pm2VNU1yRbE+Y5n+iVbyiyIgF2QKMdHJEhe7y7sUvZBWP86BUxyBl2Hrqu/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=piPU1cne; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="piPU1cne"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e8bc571ce7aso1577969276.0
        for <git@vger.kernel.org>; Thu, 17 Jul 2025 17:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1752796959; x=1753401759; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zrwjdiMbLoHVnQ0iBZJatkrMGp0xOnCrRAU4Gd/tGX4=;
        b=piPU1cnejdKaj7zzUVNHZsBbrXt88kSqwesw2Ao9WheQnfuY6jteIm3tVaB1Vv0Nvk
         QyjVulrxm9Q1wuYK6LlhgKkRITQTyHLvxbnrG3u8SUsyd/PahKy/mQZpBn1wdfABRnnQ
         11DR8WnrfBbdUrU4qI/bmAxAaEdTH5kBsJlkE921ccPXLB3gV72VQWnQkdKdY6hpMW2+
         0lb+QkTEBzCByfgKqSq10sfQGPrSPaT0C+9u+juhsu0kIivY0oaDCiGMHHwEOCcQWfSB
         8THNdsf9t415yE3WBxjy2vjPOrpJcSHNDgBiK9O79gwFl/GWBtnrB/5z6V3RRDDXXwaQ
         DjJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752796959; x=1753401759;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zrwjdiMbLoHVnQ0iBZJatkrMGp0xOnCrRAU4Gd/tGX4=;
        b=T42BCvAmHXTmHcd9t4T1iDcOd7dXonoiF1HGRE+ZX5lzMt2W00zDm7c3rECzf2Oapn
         sIG23bYsSyrbBOmtEROt7Wvj9pGZ6jharuEJV+txKkdR4gUDZ7cI2sxqJnSjzZTZmWBq
         OqZj7cJ5o0YBnT3l8EZf0CXQTnyJwRpazOkARQnp/HU4gg96cJ1+ipC4GSb9t4PyLg9b
         vcZtq0EpUat1FlYJqIy6QbNk4YoZiXBTFA0XOFFNm1Q+EykmI+na7zrqciTnqt3VbcQS
         uCpHJfnM9nz6IP9HESuY7/QUZSoIbs74AmSKChZ0ao8Z+6v6nTKzlw7hTCWqmhMlMU+E
         EeWw==
X-Gm-Message-State: AOJu0YyWEY1NV6aX5CtBZajfJlQlu2Jk+QW1n1kMn6YlRviZpg4321iO
	0hf51HvuWqxDEaghD2E1WeFmnUXmIiMlnWGzh/vFpA8/suR1Da7Rk8d4E4CGL6ctraE=
X-Gm-Gg: ASbGncvrO8o4/HUFEixkM+/kFWOt/mJ7Mwxbakxz9XeEaKJkG/m19zDz0AomdoeLNsh
	Yj50HhroytSZLymb4BwexEms5w0qszBv36SAqMZh0ePe6DObCbMszl7lXgk9UbXMtscZEOg/+MZ
	aNqiHVl0hEb1VIG3PvhJB3Wu611duWN8/94MLCVX6HaqApNJWiOQky9BXNipMnfpdn5XEPh05Ay
	Ra43N3B20MAfgcvrCUyZqSux1fzP5rGV6jsjdCXEmhA62fmFXdB96zm0Gganii0y7Cg0OWQwm/O
	FdiJGtGw0sdeV5BYtY8iGr/p0ukUnYHQlIJv3fZdNB2S12WGp6JdaQ6Vu+2zK4cU3eQkWm+Ahxv
	W0MRJczw2yp8P9aHbhZ725vjxO7Vvy+E+5FPPAbgIVxe+Stdz1AG4qJAuk+VHTxOtX/bLck3kPY
	IhySvN
X-Google-Smtp-Source: AGHT+IEUI0tjRrbhlQw9T1EPMXyS6Jz/1MC+DtYlVlx0g4QfQl0h6jy1ovLH1O77NQby/MCGDpEMgQ==
X-Received: by 2002:a05:6902:986:b0:e8d:7bb8:7a9e with SMTP id 3f1490d57ef6-e8d7bb888afmr655737276.9.1752796958651;
        Thu, 17 Jul 2025 17:02:38 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e8d7ce0dc87sm51979276.33.2025.07.17.17.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 17:02:38 -0700 (PDT)
Date: Thu, 17 Jul 2025 20:02:37 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v5 1/6] last-modified: new subcommand to show when files
 were last modified
Message-ID: <aHmPHcNQYlhGo8JB@nand.local>
References: <20250630-toon-new-blame-tree-v3-0-3516025dc3bc@iotcl.com>
 <20250716133518.1788126-1-toon@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250716133518.1788126-1-toon@iotcl.com>

On Wed, Jul 16, 2025 at 03:35:13PM +0200, Toon Claes wrote:
>  11 files changed, 549 insertions(+)
>  create mode 100644 Documentation/git-last-modified.adoc
>  create mode 100644 builtin/last-modified.c
>  create mode 100755 t/t8020-last-modified.sh

I'm admittedly not entirely sure what the best way to review this patch
is given its size and my previous exposure to (similar) code.

From what I can tell, this does not include the optimizations that
Stolee and I worked on back in 2020-ish. Those would be nice to have,
but they are somewhat complex and I think more easily reviewed as an
incremental change on top rather than as part of the initial version.

As I mentioned in my response to your the cover letter, I would be more
than happy to help you with an effort to introduce those optimizations
on top.

> diff --git a/builtin/last-modified.c b/builtin/last-modified.c
> new file mode 100644
> index 0000000000..63993bc1c9
> --- /dev/null
> +++ b/builtin/last-modified.c
> @@ -0,0 +1,289 @@
> +#include "git-compat-util.h"
> +#include "builtin.h"
> +#include "commit.h"
> +#include "config.h"
> +#include "diff.h"
> +#include "diffcore.h"
> +#include "hashmap.h"
> +#include "hex.h"
> +#include "log-tree.h"
> +#include "object-name.h"
> +#include "object.h"
> +#include "parse-options.h"
> +#include "quote.h"
> +#include "repository.h"
> +#include "revision.h"
> +
> +struct last_modified_entry {
> +	struct hashmap_entry hashent;
> +	struct object_id oid;
> +	const char path[FLEX_ARRAY];
> +};

As a general comment on this patch, I am a little sad to see that many
of the implementation details have been moved back into the builtin
itself and not in their own last-modified.ch file(s).

Apologies if this was already discussed earlier in the thread and I
simply missed it, but can you comment on why the last-modified internals
were moved into the builtin?

Even in the earliest version of 'blame-tree' that I could find (from
26999d045b (add blame-tree command, 2012-10-20) in my fork) many of the
internals were written in blame-tree.c instead of builtin/blame-tree.c.

> +static int last_modified_entry_hashcmp(const void *unused UNUSED,
> +				       const struct hashmap_entry *hent1,
> +				       const struct hashmap_entry *hent2,
> +				       const void *path)
> +{
> +	const struct last_modified_entry *ent1 =
> +		container_of(hent1, const struct last_modified_entry, hashent);
> +	const struct last_modified_entry *ent2 =
> +		container_of(hent2, const struct last_modified_entry, hashent);
> +	return strcmp(ent1->path, path ? path : ent2->path);
> +}
> +
> +struct last_modified {
> +	struct hashmap paths;
> +	struct rev_info rev;
> +	int recursive, tree_in_recursive;

Can we either make these two part of a bitfield, or at least declare
them separately?

> +};
> +
> +static void last_modified_release(struct last_modified *lm)
> +{
> +	hashmap_clear_and_free(&lm->paths, struct last_modified_entry, hashent);
> +	release_revisions(&lm->rev);
> +}
> +
> +typedef void (*last_modified_callback)(const char *path,
> +				       const struct commit *commit, void *data);
> +
> +struct last_modified_callback_data {
> +	struct commit *commit;
> +	struct hashmap *paths;
> +
> +	last_modified_callback callback;
> +	void *callback_data;
> +};

I can't quite tell what the purpose of this struct is in conjunction
with the last_modified_callback type above.

The last_modified_callback type makes sense as a generic callback
function that callers can pass to get <path, commit> pairs, along with
an arbitrary "data" pointer.

But then you define a last_modified_callback_data struct that, which
made me think that it would be used as the data type passed to the
callback. In other words, given the existence of this struct, I would
have expected the function pointer above to be defined like:

    typedef void (*last_modified_callback)(const char *path,
                                           const struct commit *commit,
                                           struct last_modified_callback_data *data);

But the fact that the _data struct contains a last_modified_callback
function pointer gives us a hint at what's going on here. It seems like
last_modified_callback_data is used to store some bookkeeping
information and dispatch calls to the "callback" function pointer.

I think that the fact the struct's name ends with "_data" is what is
confusing to me. I think this would be a little clearer if you renamed
this "struct last_modified_callback" and the function pointer to
"last_modified_callback_fn" or similar.

(The irony is not lost on me that these comments would be applicable to
GitHub's version of this code, too :-s).

> +static int populate_paths_from_revs(struct last_modified *lm)
> +{
> +	int num_interesting = 0;
> +	struct diff_options diffopt;
> +
> +	memcpy(&diffopt, &lm->rev.diffopt, sizeof(diffopt));
> +	copy_pathspec(&diffopt.pathspec, &lm->rev.diffopt.pathspec);
> +	/*
> +	 * Use a callback to populate the paths from revs
> +	 */
> +	diffopt.output_format = DIFF_FORMAT_CALLBACK;
> +	diffopt.format_callback = add_path_from_diff;
> +	diffopt.format_callback_data = lm;
> +
> +	for (size_t i = 0; i < lm->rev.pending.nr; i++) {
> +		struct object_array_entry *obj = lm->rev.pending.objects + i;
> +
> +		if (obj->item->flags & UNINTERESTING)
> +			continue;
> +
> +		if (num_interesting++)
> +			return error(_("can only get last-modified one tree at a time"));

This error text is a little difficult to parse, but I'm not sure that I
have a great suggestion for improving it. The equivalent from GitHub's
fork is "can only blame one tree at a time", and I think the difficulty
in parsing is that "last-modified" isn't a verb.

> +static void mark_path(const char *path, const struct object_id *oid,
> +		      struct last_modified_callback_data *data)
> +{
> +	struct last_modified_entry *ent;
> +
> +	/* Is it even a path that we are interested in? */
> +	ent = hashmap_get_entry_from_hash(data->paths, strhash(path), path,
> +					  struct last_modified_entry, hashent);
> +	if (!ent)
> +		return;
> +
> +	/*
> +	 * Is it arriving at a version of interest, or is it from a side branch
> +	 * which did not contribute to the final state?
> +	 */
> +	if (!oideq(oid, &ent->oid))
> +		return;

GitHub's fork writes this as "if (oid && !oideq(oid, &ent->oid))", but
the commit that introduces the "oid &&" portion of that expression
doesn't provide us with any clues as to why the change was necessary.

Since you have spent more time with these patches than I have recently,
perhaps you can help shed some light on what's going on here?

The rest of the code roughly matches my memory of the early versions of
this command.

Thanks,
Taylor
