Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1E976056
	for <git@vger.kernel.org>; Mon, 13 May 2024 20:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715631588; cv=none; b=CtJWVKrxYEKtDxX3WeTLrLx3BoNUGJON1y8ealclFhElE7rPD7opCQ2wW3LIO7RveH9hwZhz0PNvsjjRmGV+BB3duazsXeQ3kUl7B3KASZ7rn1YISFxqyaFcJIaLVNMZIH9r8cyA/K0huKpOCWyqYRK2EZJERQqgC375Ek/ACrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715631588; c=relaxed/simple;
	bh=exjJKwbORFJLBE/wHJDrXMuEFL3MggMRlP81Afi+ErE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M647vUGMAkYJog3oK5y9gLWm+B7LKQFOeYozmmCb8E3OlnKf255U17Vyqx2R7eQYSdFgdEeXtd1tYErnvV1F1cl6Q09yogX3/f2fPD2jonG9xMoiFyNpsOSGucJtjBsAgNtz7INHSy9BJWulZy5BLVeLD/SXJfUMl/FwVI5jqKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=KRvtKVdF; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="KRvtKVdF"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6f1027cf826so1043132a34.1
        for <git@vger.kernel.org>; Mon, 13 May 2024 13:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1715631586; x=1716236386; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TTpe4anGibiKOOUrZYpBeIfNBUulx4yzzy9YLlJKaGs=;
        b=KRvtKVdFeKqtaSLd3YhdBH9PcYcqkkTuQspyImhWcTaQhK56v+sbmXdjEbtGoaVzjS
         FzpU1f4OoE+WbV2IG27Ymy3CUPap7BEbBqdgqScz6httYcbBNLayxuCel/vZWJiZqWUs
         QiN2OcvUXirCAAQ1/HiCwcl0v6RN3McAGbAOug0aIaCTFC+KGm2Zd6+Xx3r/2IFzHYbH
         IDdlLvl6rWrxbhLApRjw15TWQKwla+qrHpqH1YeH+7GxJWxrNMO/OOIkAr8454Nnm96w
         tjC0ruqGvZc+33QBJi0igUFoM4dJOHNw4rpuRgK8+wq9IsbappEpVz8h/l7xPJJ2WVxh
         vj/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715631586; x=1716236386;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TTpe4anGibiKOOUrZYpBeIfNBUulx4yzzy9YLlJKaGs=;
        b=i+j77WuUwHRemWnBq828NqElXYd+Sl7YX6AUJwDUvoTnVX1lper5KyUA/8NYpGjgxk
         tDtmQ40KOMksFYmjSmuIcRAwn9O2apPjB1duWK2VT2ESKEkcQFb4oeijJSYJKoUc9vQ/
         Xe+CxulBuGxIG23AdqFVam+SA78DkWbuUoP5baD18O0NUPZSm2GckQHVK3J+Co5+Kx3N
         D75gyWdfdfkyiby06/AvKkub8UrFU8kKI5JnERDqeHrPznp40TYk7ekbe0CHZAuGzWxu
         6+9L1+ABJk5sxOTr7t/zssfpZajkQ0nvk1MWKqYhpokLzkQsLo1fAEQoXK3fWZs+nybl
         82NA==
X-Gm-Message-State: AOJu0Yy3EUUnvGn6POWWLm06UEMESSf3En4eDiEVxtIVHv9W+HOohLyb
	j310BoKTVhxDQi9PRGWPr8W8bh24woEuvFWkmN8FoNeb4rXU2HIwiXoa6j0PWnfGFbK7dzvtE47
	k
X-Google-Smtp-Source: AGHT+IGIzlnxXw6rMUh5TQH3+7Qw7BrXBwPOr6cdsFkh7hEpzbrueGYHd6CnIhJwHnvsoOciTXzKrA==
X-Received: by 2002:a05:6830:1e47:b0:6ef:9ec1:2bf8 with SMTP id 46e09a7af769-6f0e92a7e7amr12236428a34.23.1715631585802;
        Mon, 13 May 2024 13:19:45 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf2fc7e4sm490621985a.97.2024.05.13.13.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 13:19:45 -0700 (PDT)
Date: Mon, 13 May 2024 16:19:44 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 06/23] pack-bitmap-write: support storing pseudo-merge
 commits
Message-ID: <ZkJ14LHreSas23ZV@nand.local>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1714422410.git.me@ttaylorr.com>
 <ee33a70324589a98c2239530b03cc2d7afbdfb9e.1714422410.git.me@ttaylorr.com>
 <20240513184246.GA2675586@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240513184246.GA2675586@coredump.intra.peff.net>

On Mon, May 13, 2024 at 02:42:46PM -0400, Jeff King wrote:
> On Mon, Apr 29, 2024 at 04:43:15PM -0400, Taylor Blau wrote:
>
> > diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
> > index 9bc41a9e145..fef02cd745a 100644
> > --- a/pack-bitmap-write.c
> > +++ b/pack-bitmap-write.c
> > @@ -24,7 +24,7 @@ struct bitmapped_commit {
> >  	struct ewah_bitmap *write_as;
> >  	int flags;
> >  	int xor_offset;
> > -	uint32_t commit_pos;
> > +	unsigned pseudo_merge : 1;
> >  };
>
> The addition of the bit flag here makes sense, but dropping commit_pos
> caught me by surprise. But...it looks like that flag is simply unused
> cruft even before this patch?
>
> It might be worth noting that in the commit message, or better still,
> pulling its removal out to a preparatory patch.

Hah, so this is a funny one :-).

I was following your suggestion to pull out the deletion into its own
patch[^1] and starting to dig out back-references to indicate why it was
safe to remove this field.

But the only reference to commit_pos is from 7cc8f971085 (pack-objects:
implement bitmap writing, 2013-12-21), which is the commit that added
this field in the first place. Looking at:

    $ git log -p -S commit_pos 7cc8f971085 -- pack-bitmap-write.c

doesn't really show us anything interesting, either.

But! There is an array called commit_positions, which I suspected was
for holding the values of commit_pos in the same order as they appear in
the writer.selected array.

So I think the right patch is something like this (which I'll put in the
next round of this series):

--- 8< ---
Subject: [PATCH] pack-bitmap-write.c: move commit_positions into commit_pos
 fields

In 7cc8f971085 (pack-objects: implement bitmap writing, 2013-12-21), the
bitmapped_commit struct was introduced, including the 'commit_pos'
field, which has been unused ever since its introduction more than a
decade ago.

Instead, we have used the nearby `commit_positions` array leaving the
bitmapped_commit struct with an unused 4-byte field.

We could drop the `commit_pos` field as unused, and continue to store
the values in the auxiliary array. But we could also drop the array and
store the data for each bitmapped_commit struct inside of the structure
itself, which is what this patch does.

In any spot that we previously read `commit_positions[i]`, we can now
instead read `writer.selected[i].commit_pos`. There are a few spots that
need changing as a result:

  - write_selected_commits_v1() is a simple transformation, since we're
    just reading the field. As a result, the function no longer needs an
    explicit argument to pass the commit_positions array.

  - write_lookup_table() also no longer needs the explicit
    commit_positions array passed in as an argument. But it still needs
    to sort an array of indices into the writer.selected array to read
    them in commit_pos order, so table_cmp() is adjusted accordingly.

  - bitmap_writer_finish() no longer needs to allocate, populate, and
    free the commit_positions table. Instead, we can just write the data
    directly into each struct bitmapped_commit.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap-write.c | 42 ++++++++++++++++--------------------------
 1 file changed, 16 insertions(+), 26 deletions(-)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 473a0fa0d40..26f57e48804 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -679,9 +679,7 @@ static const struct object_id *oid_access(size_t pos, const void *table)
 	return &index[pos]->oid;
 }

-static void write_selected_commits_v1(struct hashfile *f,
-				      uint32_t *commit_positions,
-				      off_t *offsets)
+static void write_selected_commits_v1(struct hashfile *f, off_t *offsets)
 {
 	int i;

@@ -691,7 +689,7 @@ static void write_selected_commits_v1(struct hashfile *f,
 		if (offsets)
 			offsets[i] = hashfile_total(f);

-		hashwrite_be32(f, commit_positions[i]);
+		hashwrite_be32(f, stored->commit_pos);
 		hashwrite_u8(f, stored->xor_offset);
 		hashwrite_u8(f, stored->flags);

@@ -699,23 +697,20 @@ static void write_selected_commits_v1(struct hashfile *f,
 	}
 }

-static int table_cmp(const void *_va, const void *_vb, void *_data)
+static int table_cmp(const void *_va, const void *_vb)
 {
-	uint32_t *commit_positions = _data;
-	uint32_t a = commit_positions[*(uint32_t *)_va];
-	uint32_t b = commit_positions[*(uint32_t *)_vb];
+	struct bitmapped_commit *a = &writer.selected[*(uint32_t *)_va];
+	struct bitmapped_commit *b = &writer.selected[*(uint32_t *)_vb];

-	if (a > b)
+	if (a->commit_pos < b->commit_pos)
+		return -1;
+	else if (a->commit_pos > b->commit_pos)
 		return 1;
-	else if (a < b)
-		return -1;

 	return 0;
 }

-static void write_lookup_table(struct hashfile *f,
-			       uint32_t *commit_positions,
-			       off_t *offsets)
+static void write_lookup_table(struct hashfile *f, off_t *offsets)
 {
 	uint32_t i;
 	uint32_t *table, *table_inv;
@@ -731,7 +726,7 @@ static void write_lookup_table(struct hashfile *f,
 	 * bitmap corresponds to j'th bitmapped commit (among the selected
 	 * commits) in lex order of OIDs.
 	 */
-	QSORT_S(table, writer.selected_nr, table_cmp, commit_positions);
+	QSORT(table, writer.selected_nr, table_cmp);

 	/* table_inv helps us discover that relationship (i'th bitmap
 	 * to j'th commit by j = table_inv[i])
@@ -762,7 +757,7 @@ static void write_lookup_table(struct hashfile *f,
 			xor_row = 0xffffffff;
 		}

-		hashwrite_be32(f, commit_positions[table[i]]);
+		hashwrite_be32(f, writer.selected[table[i]].commit_pos);
 		hashwrite_be64(f, (uint64_t)offsets[table[i]]);
 		hashwrite_be32(f, xor_row);
 	}
@@ -798,7 +793,6 @@ void bitmap_writer_finish(struct pack_idx_entry **index,
 	static uint16_t flags = BITMAP_OPT_FULL_DAG;
 	struct strbuf tmp_file = STRBUF_INIT;
 	struct hashfile *f;
-	uint32_t *commit_positions = NULL;
 	off_t *offsets = NULL;
 	uint32_t i;

@@ -823,22 +817,19 @@ void bitmap_writer_finish(struct pack_idx_entry **index,
 	if (options & BITMAP_OPT_LOOKUP_TABLE)
 		CALLOC_ARRAY(offsets, index_nr);

-	ALLOC_ARRAY(commit_positions, writer.selected_nr);
-
 	for (i = 0; i < writer.selected_nr; i++) {
 		struct bitmapped_commit *stored = &writer.selected[i];
-		int commit_pos = oid_pos(&stored->commit->object.oid, index, index_nr, oid_access);
+		stored->commit_pos = oid_pos(&stored->commit->object.oid, index,
+					     index_nr, oid_access);

-		if (commit_pos < 0)
+		if (stored->commit_pos < 0)
 			BUG(_("trying to write commit not in index"));
-
-		commit_positions[i] = commit_pos;
 	}

-	write_selected_commits_v1(f, commit_positions, offsets);
+	write_selected_commits_v1(f, offsets);

 	if (options & BITMAP_OPT_LOOKUP_TABLE)
-		write_lookup_table(f, commit_positions, offsets);
+		write_lookup_table(f, offsets);

 	if (options & BITMAP_OPT_HASH_CACHE)
 		write_hash_cache(f, index, index_nr);
@@ -853,6 +844,5 @@ void bitmap_writer_finish(struct pack_idx_entry **index,
 		die_errno("unable to rename temporary bitmap file to '%s'", filename);

 	strbuf_release(&tmp_file);
-	free(commit_positions);
 	free(offsets);
 }

--
2.45.0.57.gee4186f79f3

--- >8 ---

> > +static inline int bitmap_writer_selected_nr(void)
> > +{
> > +	return writer.selected_nr - writer.pseudo_merges_nr;
> > +}
>
> OK, so now most spots should use this new function instead of looking at
> writer.selected_nr directly. But if anybody accidentally uses the old
> field directly, it is presumably disastrous. Is it worth renaming it to
> make sure we caught all references?

We only need to check within this file, since the bitmap_writer
structure definition is defined within the pack-bitmap-writer.c
compilation unit.

I took a careful look through the file, and am confident that we touched
all of the spots that needed attention.

Thanks,
Taylor

[^1]: If memory serves, that was my original intention when writing this
  series for the first time, but I must have forgotten when I was
  actually splitting out the individual patches and staged the removal
  alongside the rest of this change.
