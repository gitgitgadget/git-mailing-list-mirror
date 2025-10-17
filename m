Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2653370F6
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 14:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760712898; cv=none; b=VL+5ZBEjJXzjFJpyxxcIUUAgAxsjh8J/fP3qUW/ugzntqpWoePnDtPyNiVFNQpt2espih7RmwtpPzKuQV4NH6mK3V34JVTH4lLq3l+ZHysWfoIJztRnLA8PSJfR6NJjYFB49evMhp2MnHFXgoIlBMKeu9kqEfqaSbVzP84AYDNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760712898; c=relaxed/simple;
	bh=JNkb7rNq0dueqUJxHN8eukgSTTpVV4G7XE8PysXmyl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XODyxgFghumS86Moj+vrQN6qyKuC0FMh1yG27BEh6YQk7dRcqPt4OQJLw5ftwzIW2BH+XUcD9IVmZOOMrGYZqZS50Lve8BN5vWrUqlGox325mfRgY8XR6SnJVkvFjL5yCCSU6PrUA6EuHMhRvm8FgBz3lGGI9Y74lFm9MmXVgUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=fnsCTNnX; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="fnsCTNnX"
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-7832691f86cso22069807b3.1
        for <git@vger.kernel.org>; Fri, 17 Oct 2025 07:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760712895; x=1761317695; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mnxeiqnTmgWBfCYXnk7IEhTIxw3khUDsPtup8iK/KGc=;
        b=fnsCTNnX9ntjByedhYpWHpnmTanlQLgAEAwMovxIB07M5fq0bCFCWYGx8DOExQjFGY
         5pPSHYMRnD4hNVWq7a0Pg1io9uT3rMpu6WvaLKj/hLmyfjkfmt4Jn1ukYH9p2fNvJMqp
         mGqOq0Hg5IstV4ZMbZOPDDPeVIzLgApTifeoRRMPydsBYakh0heVHD/ENzYa2b1odZZ9
         HPoxFdM4RlF2N4UvWWvw/b+wDGOSwBNmE4srUVm293AC60B3fWOg6qH0MdUhEwMaZe7G
         HjUd8COPdXwd7L2t8Wf7FTTP83K0dfLEqu+/We0EEvPx4q5R+VNhdZVe8gv/8bVWNiOf
         g8dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760712895; x=1761317695;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mnxeiqnTmgWBfCYXnk7IEhTIxw3khUDsPtup8iK/KGc=;
        b=kCS9Cz1eAvZX8d+2zh2Nlg0IQJpoXyJEcY9rAjMA1NsApqRUmjiVaorx+Mlji6LXLR
         qOQZnFjfTxUVZWeEoZQyTSc4JWB/AEBjfGf28xGJTcuaqQmHqPVjJR3bjvUFfnrfA94d
         6uRQCUlYFWyuGe2miWN5IBKSesJ7VtqFQ0i6nNRGt2jMi/rAquq/gpjJedaL1XBWcfJf
         LzBCPOmnmqKthhfNtogowqZCsN/Wb/fZdOaHNF9thKdcDVTt4BjZ/Co5fSgzdn8vFddG
         XXT7i7fbRI8QFk7hOetoFiuQIuP9APX0URdn2rXU+1hiktULzftXmqswkicCQklJg9Kp
         ID5g==
X-Forwarded-Encrypted: i=1; AJvYcCXoCAkceO3sJJDmSo7MdyQHHCnkhtuSnnwXsFZ6R+l08i8Y+Tdf3M1ggWqga8OQbB2jetg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/eD0RqacpLcCa1bw9zdpGAD+zmyzMBhy5RZYjRa6ni5A7Fs/I
	Kdpid5t4T7P0Hehy94Fovxr541xuiyYwbyl130XuByQLJN6t941aWEIO4A7O/qfwvHg=
X-Gm-Gg: ASbGnctNoUdV41iLNF9cBKw2BvgDi93xIq+TyX536BKaTBEniRvAJiTw6wz7vEHaKl5
	A1usHROASqkz3GBcrAl9e3b3o6YLDshNL+K7BLmd1xCaBEyQPiOQ55yQbaJI1YOvx8AhnZRcC+n
	NqhdAk6OfEgfh+WBzU17TbYpUzniAwrhe+BEeO0saNlOdcT/5Zl8vsdGx/hWBag2qo4jCIKzSKn
	HKgmK+/fSUb9t/2pye+9hlUk4IyWtr2ws0RU2HwMQdLd4C/UDo8yvIhcslMk/VIGjFJHzyRrARC
	Z2Hyhsr7jJr6YUxjiNAeiS8lSb/O8SuAoDV+f8Idjr7c1nka0Qx+lQdJlhTHI4WjMacoRwhQqfE
	7mn1Zj+wUi+1A1k7NARfYt1RjOoKV2mT6C7zsE35KLZkqw69RuQXInB7YWdejULddTOyLUa98se
	yaxoOEoqzx1QqtXzCEYDWZjNs9v+jRGg38Vucw32551yqdQ4rgx4V/Wk2JUf8we2eor8GfavqEL
	tc4FrtCCmEXF1heog==
X-Google-Smtp-Source: AGHT+IFM8BorSRKmrnKyD4vMPBZ2/6HrE8khYfeB0CcMXflc49np1LMJ4bUP8Uk+cqSBAubSxx2QAw==
X-Received: by 2002:a05:690c:6207:b0:783:fa30:b779 with SMTP id 00721157ae682-783fa30cc1amr8394607b3.67.1760712895250;
        Fri, 17 Oct 2025 07:54:55 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-7828cdd054esm16574367b3.4.2025.10.17.07.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 07:54:54 -0700 (PDT)
Date: Fri, 17 Oct 2025 10:54:53 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: Toon Claes <toon@iotcl.com>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] last-modified: implement faster algorithm
Message-ID: <aPJYvYs8W6LrV+0Q@nand.local>
References: <20251016-b4-toon-last-modified-faster-v1-1-85dca8a29e5c@iotcl.com>
 <aPGB/FJtjDmyNLvG@nand.local>
 <20251017063039.GA3074253@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251017063039.GA3074253@coredump.intra.peff.net>

On Fri, Oct 17, 2025 at 02:30:39AM -0400, Jeff King wrote:
> On Thu, Oct 16, 2025 at 07:38:36PM -0400, Taylor Blau wrote:
>
> > Looking through the backtrace, it looks like someone is calling
> > mark_path() with a NULL oid, like so:
> >
> >     (gdb) bt
> >     #0  __memcmp_evex_movbe ()
> >         at ../sysdeps/x86_64/multiarch/memcmp-evex-movbe.S:132
> >     #1  0x00005555555f2c32 in oideq (oid1=0x0, oid2=0x555555a5eeb0)
> >         at ./hash.h:408
> >     #2  0x00005555555f3523 in mark_path (path=0x555555a5eee8 "a", oid=0x0,
> >         data=0x7fffffffd650) at builtin/last-modified.c:179
> >
> > , which makes sense, since at the end of the main loop we call
> > mark_path() on all remaining active paths to indicate that they were
> > modified by whatever commit we just popped off the queue.
>
> Hmm, sounds like the mark_path() discussion from:
>
>   https://lore.kernel.org/git/aHmPHcNQYlhGo8JB@nand.local/
>
> coming home to roost. I'm sure you already knew that, but there's maybe
> an interesting process observation here: in pulling a battle-tested
> implementation apart into patches to be applied in chunks, we ended up
> missing a critical part of that original implementation and getting a
> bug.

Hmm. Is that what happened in this case, though?

In GitHub's version of this code, mark_path() didn't have the NULL-ness
check on 'oid' until we added the "--go-faster" mode, which is where
this patch is derived from. Looking at the original changes from
GitHub's side:

--- 8< ---
diff --git a/blame-tree.c b/blame-tree.c
--- a/blame-tree.c
+++ b/blame-tree.c
@@ -119,28 +142,38 @@
 static void mark_path(const char *path, const struct object_id *oid,
 		      struct blame_tree_callback_data *data)
 {
 	struct blame_tree_entry *ent;
+	struct commit_active_paths *active;

 	/* Is it even a path that we are interested in? */
 	ent = hashmap_get_entry_from_hash(data->paths, strhash(path), path,
 					  struct blame_tree_entry, hashent);
 	if (!ent)
 		return;

 	/* Have we already blamed a commit? */
 	if (ent->commit)
 		return;
+
+	/* Are we inactive on the current commit? */
+	if (data->go_faster) {
+		active = active_paths_at(&active_paths, data->commit);
+		if (active && active->active &&
+		    !active->active[ent->diff_idx])
+			return;
+	}
+
 	/*
 	 * Is it arriving at a version of interest, or is it from a side branch
 	 * which did not contribute to the final state?
 	 */
-	if (oidcmp(oid, &ent->oid))
+	if (oid && oidcmp(oid, &ent->oid))
 		return;

 	ent->commit = data->commit;
 	data->num_interesting--;
 	if (data->callback)
 		data->callback(path, data->commit, data->callback_data);
 	hashmap_remove(data->paths, &ent->hashent, path);
 }
--- >8 ---

, where the above was generated with:

    $ git log -1 --oneline 0603f6d9c3c040c914c1412fab972252c4a765c4 \
        -L:mark_path:blame-tree.c

(in this case, 0603f6d9c3 is the hash of the commit that originally
introduced these changes on the GitHub side).

So I don't think that it's the case that we somehow missed this portion
of the changes when pulling the series apart, but rather that the check
was added later on, and not correctly pulled into the version that was
submitted here.

I was wondering if perhaps I had made an error when pulling these
patches out of GitHub's fork, but even in my b0ae8b3cc0 (blame-tree:
introduce '--go-faster' mode, 2025-03-27) from my fork, you can see the
same diff in mark_path() as above.

> It's not like we didn't know that was a risk, of course, and the payoff
> was getting a fresh look at the patches (to improve them and maybe even
> fix latent bugs). So it's probably something to just live with. But I
> wonder if/how we could mitigate that risk. When I reorganize patches in
> a tricky way locally, I often eyeball the diff of the end states
> (whatever mess I had originally, versus the result of the "clean"
> version), and that might have shown the omission here.
>
> I'm not sure if that would have helped here or not. The "end state" of
> the battle-tested version is really GitHub's internal fork. But maybe
> your original patches extracted from that (tb/blame-tree in your fork, I
> think) applied on top of the same base point (e.g., the current tip of
> master) might be an interesting comparison? Or maybe not. The earlier
> rounds have may have had other adjustments which introduce a bunch of
> noise.

I share your feeling here in genreal, but I think in this particular
case the patches were pulled out correctly (at least with respect to the
changes here in mark_path()), and that check was simply dropped or not
properly carried over when the patch we're discussing here was written.

> > Nice, I am glad to see that we are using a bitmap here rather than the
> > hacky 'char *' that we had originally written. I seem to remember that
> > there was a tiny slow-down when using bitmaps, but can't find the
> > discussion anymore. (It wasn't in the internal PR that I originally
> > opened, and I no longer can read messages that far back in history.)
> >
> > It might be worth benchmarking here to see if using a 'char *' is
> > faster. Of course, that's 8x worse in terms of memory usage, but not a
> > huge deal given both the magnitude and typical number of directory
> > elements (you'd need 1024^2 entries in a single tree to occupy even a
> > single MiB of heap).
>
> I doubt the memory usage matters too much. We throw away each bitmap
> after we finish processing its associated commit, so our max memory is
> really the size of the bitmap/char array times the size of the queue (so
> effectively the width of the history graph). So yeah, I too would be
> curious if the performance is actually better with chars.
>
> I also wonder how often we pass an unchanged bitmap to our parents
> (e.g., for the common case that a commit has a single parent, and does
> not touch any of the active paths, the active set will be the same for
> both). There's probably an easy-ish optimization to avoid allocating a
> new bitmap, and to just transfer ownership via pointer.

Funny enough, while we don't have this optimization in the original
version of this code, we did handle being TREESAME at the root tree as a
special case in the original blame-tree.c code. Toon dropped that change
here which I commented on earlier, but that would be a good opportunity
to optimize this case.

I don't think we ever bothered to measure how often we were able to just
pass all active path(s) up to the parent, probably because the original
code didn't actually use the optimization you're talking about here, and
instead did:

    if (!diff_queued_diff.nr) {
        for (i = 0; i < bt->all_paths_nr; i++) {
            if (active_c->active[i])
                pass_to_parent(active_c, active_p, i);
        }

        if (!(parent->object.flags & PARENT1)) {
            parent->object.flags |= PARENT1;
            prio_queue_put(queue, parent);

            ret = 1;
            goto cleanup;
        }
    }

, so that case was just handled specially, but not optimized. But I
don't know that you can just pass the bitmap up directly, since the
parent may already have some bits set if we reached it along some
different path.

I thought that we had to AND NOT out the bits in lm->scratch here, but
those are only set for non-TREESAME paths, so lm->scratch is going to be
all zeros in that case.

I think you could reasonably do something like the following on top of
Toon's patch, though:

--- 8< ---
diff --git a/builtin/last-modified.c b/builtin/last-modified.c
index 40e520ba18..1a9ab3b2b0 100644
--- a/builtin/last-modified.c
+++ b/builtin/last-modified.c
@@ -303,6 +303,18 @@ static void process_parent(struct last_modified *lm,
 		diffcore_std(&lm->rev.diffopt);
 	}

+	if (!diff_queued_diff.nr) {
+		bitmap_or(active_p, active_c);
+		for (i = 0; i < active_c->word_alloc; i++)
+			active_c->words[i] = 0;
+
+		if (!(parent->object.flags & PARENT1)) {
+			parent->object.flags |= PARENT1;
+			prio_queue_put(queue, parent);
+		}
+		goto cleanup;
+	}
+
 	/*
 	 * Otherwise, test each path for TREESAME-ness against the parent. If
 	 * a path is TREESAME, pass it on to this parent.
@@ -330,6 +342,7 @@ static void process_parent(struct last_modified *lm,
 		prio_queue_put(queue, parent);
 	}

+cleanup:
 	memset(lm->scratch->words, 0x0, lm->scratch->word_alloc);
 	diff_queued_diff.nr = 0;
 	diff_queue_clear(&diff_queued_diff);
--- >8 ---

> > Likewise, I wonder if we should have elemtype here be just 'struct
> > bitmap'. Unfortunately I don't think the EWAH code has a function like:
> >
> >     void bitmap_init(struct bitmap *);
> >
> > and only has ones that allocate for us. So we may consider adding one,
> > or creating a dummy bitmap and copying its contents, or otherwise.
>
> I thought that, too, though it does change the max memory use a bit.
> Right now we are storing one pointer per commit (the "struct bitmap *")
> and that is true whether we have processed the commit or not (it is
> populated while the commit is in the queue, and then NULL after). If we
> stored the struct directly, that's twice as many bytes (the eword_t
> pointer, plus a size_t), and it's per commit.

Mmm, good point. I wrote this thinking that the commit_slab was going to
end up a little gross under this patch, with the slab itself having type
'struct bitmap ***', but I agree with everything you wrote here.

> PS I tried building tb/blame-tree from your repo because I was poking at
>    how some of it worked (having forgotten everything I ever knew about
>    it by this point). It does work, but needs this:
>
> diff --git a/blame-tree.c b/blame-tree.c
> index 6addac7b0b..2448f2caf4 100644
> --- a/blame-tree.c
> +++ b/blame-tree.c
> @@ -800,7 +800,6 @@ static int process_parent(struct blame_tree *bt,
>  		int k = diff2idx(bt, fp->two->path);
>  		if (0 <= k && active_c->active[k])
>  			scratch[k] = 1;
> -		diff_free_filepair(fp);
>  	}
>  	for (i = 0; i < bt->all_paths_nr; i++) {
>  		if (active_c->active[i] && !scratch[i])
>
>   on top, since otherwise we try to double-free the filepairs. I'd guess
>   it is a victim of rebasing across a5aecb2cdc (diff: improve lifecycle
>   management of diff queues, 2024-09-30), which swapped out
>   DIFF_QUEUE_CLEAR(), which left freeing the responsibility of the
>   caller, for diff_queue_clear() which handles that itself.

Ah, good catch. When I pulled those patches out a while ago, I think I
wrote something like, "this should more or less work, but doesn't, and
I'll leave it as an exercise to the reader to figure out why ;-)."

Thanks,
Taylor
