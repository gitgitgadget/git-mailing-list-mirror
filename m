Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C703858ABC
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 18:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722970046; cv=none; b=tlX0Jy6si5uqUNvwFue7YItXGZyy9D9LPZEE/o9srVTKEgCm6Vzzlu0CfwVkeLLDxPCQmQkGLW+I5SUd+rkTHfY6nZuw5AgphfKkCLVIkU+yJJ1XkfB41a/CMTx41V+VkjOE9y/xRw1hB58xZnO3hiK7s75Ghajlbq0k7XGC0NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722970046; c=relaxed/simple;
	bh=bY2shP0imMIv4llsZK/FhbFIHt1T79+RtyKnIHsE8kM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YtlyK+HvWaWAajFzS7rK/VdQexPMQS5JIrWFnZN/nGuG5o8JXKuzc/NRXsJZsCPWYuHe+qlz1LWZEmo317mpYtBgrnKXlbF2G5F4QgsrXc4G3a/Q9vixJ7qW0LnOiCzKO2/Y6VkIrWXt9vMsP0BQ8Mlt84LqVk/S5smDO47PMW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbeQ0ncg; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbeQ0ncg"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5d5c8c1006eso614806eaf.3
        for <git@vger.kernel.org>; Tue, 06 Aug 2024 11:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722970044; x=1723574844; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IPIYIuImoRASoffh54U7eZ30Zpg7V4Nni/W7I2h3uh8=;
        b=cbeQ0ncga2TSOan3EUovuvhRE8mTGLM19fWSB+utAkAOLcZesF5jhzRxCNpyriCGWP
         X/HJ8OUEHBBFS1z9icdXZ+ShWWks5Gr48vtlF1jE3ViENSRY0Z5j6Hodor22d+dx42AB
         9Syaw2hl9GCEdi79ZgZMVq76My/NzTNrS5Oy4rBW6Fwy289th2wufwfKYI/JAyZX9zqv
         xW6oo83gW1xvchtYoOWYo76V3wplYUn6K6Le7HDXZbQBCFv+CghdmvIimgBZhF5CsQ5x
         7CQNyhv+Cttzt1FoUsOgPcwbV2GZqkR0BEi4QqeIAAt7GmxKCGzneI9AsrmIGO9B+9Vp
         LsLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722970044; x=1723574844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IPIYIuImoRASoffh54U7eZ30Zpg7V4Nni/W7I2h3uh8=;
        b=MfDjMtiGmR0yxO2FxIqlCZ+7mGdWopgfDepuHxhZXI+2io+nF9cFn6+0W4fx6fNc38
         uxbZe3qOreAiy4K9g4nrXWfyv8LYhdSOW/UUhaUun1XcFeAUSV0eqgQYQUZ2lw7JeCuw
         SZ/c/A1u9sHknRfh/rez5XyG34gcvScJ55fGTRiQbRSu3k96Ea9dxkZyawG/BSMBorou
         0Ni2LPg9G90qAul/gDaTJLm/nxMHfjK+cEs6VbHei00PmsDlOHLh+a/F+Iqwkb6MoAiD
         L9aF5yFmWq/wMQpoiqkLV9C21m2daCDdwebHc86GV5euq0i3vFYSVNPcxS046qapWweU
         Ibtw==
X-Gm-Message-State: AOJu0YzJ/3RW1tWUXC0MQD6YW3f5kHnfxO1ZanZ4Yfy49JP9820AuJul
	7h/ubBrBZsSDIVTwpmzx+lV533+cQuJpK0iFztTSiv2cT8xYJbYC
X-Google-Smtp-Source: AGHT+IH/C6bpQCVkB1iTpfVVtj6RPdsQyprSGlafZLGHs12uMz5vYlcy4p1tLpLZosKDtiyV7sef9g==
X-Received: by 2002:a05:6820:2294:b0:5c4:396e:4217 with SMTP id 006d021491bc7-5d645608c6amr18907063eaf.0.1722970043698;
        Tue, 06 Aug 2024 11:47:23 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70a3a768e12sm4025671a34.65.2024.08.06.11.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 11:47:23 -0700 (PDT)
Date: Tue, 6 Aug 2024 13:46:35 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 9/9] reftable/stack: handle locked tables during
 auto-compaction
Message-ID: <sct3bl7ztqwyym3wqh3jvz7vefr5gk4mf6dhsaasdihszcnnlf@s23uyyiwwbu3>
References: <cover.1722435214.git.ps@pks.im>
 <cover.1722862822.git.ps@pks.im>
 <1ef560feb1906c160ad7c81a30e9bd4fc92d2eca.1722862822.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ef560feb1906c160ad7c81a30e9bd4fc92d2eca.1722862822.git.ps@pks.im>

On 24/08/05 03:08PM, Patrick Steinhardt wrote:
> When compacting tables, it may happen that we want to compact a set of
> tables which are already locked by a concurrent process that compacts
> them. In the case where we wanted to perform a full compaction of all
> tables it is sensible to bail out in this case, as we cannot fulfill the
> requested action.
> 
> But when performing auto-compaction it isn't necessarily in our best
> interest of us to abort the whole operation. For example, due to the
> geometric compacting schema that we use, it may be that process A takes
> a lot of time to compact the bulk of all tables whereas process B
> appends a bunch of new tables to the stack. B would in this case also
> notice that it has to compact the tables that process A is compacting
> already and thus also try to compact the same range, probably including
> the new tables it has appended. But because those tables are locked
> already, it will fail and thus abort the complete auto-compaction. The
> consequence is that the stack will grow longer and longer while A isn't
> yet done with compaction, which will lead to a growing performance
> impact.

With this change, a concurrent compaction may create tables that violate
the geometric sequence post-compaction, but is already possible because
compaction doesn't take into account newly appended tables. It makes
sense to compact available tables to minimize performance impact.

> Instead of aborting auto-compaction altogether, let's gracefully handle
> this situation by instead compacting tables which aren't locked. To do
> so, instead of locking from the beginning of the slice-to-be-compacted,
> we start locking tables from the end of the slice. Once we hit the first
> table that is locked already, we abort. If we succeded to lock two or
> more tables, then we simply reduce the slice of tables that we're about
> to compact to those which we managed to lock.
> 
> This ensures that we can at least make some progress for compaction in
> said scenario. It also helps in other scenarios, like for example when a
> process died and left a stale lockfile behind. In such a case we can at
> least ensure some compaction on a best-effort basis.

At first I wondered best-effort compaction could further mask a stale
lockfile issue, but auto-compaction already attempted compaction gently
and did not report issues to begin with. So this is just a win. :)

> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  reftable/stack.c           | 59 +++++++++++++++++++++++++++++++-------
>  reftable/stack_test.c      | 12 ++++----
>  t/t0610-reftable-basics.sh | 21 +++++++++-----
>  3 files changed, 70 insertions(+), 22 deletions(-)
> 
> diff --git a/reftable/stack.c b/reftable/stack.c
> index 51eb4470c7..b0721640e4 100644
> --- a/reftable/stack.c
> +++ b/reftable/stack.c
> @@ -999,6 +999,15 @@ static int stack_write_compact(struct reftable_stack *st,
>  	return err;
>  }
>  
> +enum stack_compact_range_flags {
> +	/*
> +	 * Perform a best-effort compaction. That is, even if we cannot lock
> +	 * all tables in the specified range, we will try to compact the
> +	 * remaining slice.
> +	 */
> +	STACK_COMPACT_RANGE_BEST_EFFORT = (1 << 0),
> +};
> +
>  /*
>   * Compact all tables in the range `[first, last)` into a single new table.
>   *
> @@ -1010,7 +1019,8 @@ static int stack_write_compact(struct reftable_stack *st,
>   */
>  static int stack_compact_range(struct reftable_stack *st,
>  			       size_t first, size_t last,
> -			       struct reftable_log_expiry_config *expiry)
> +			       struct reftable_log_expiry_config *expiry,
> +			       unsigned int flags)
>  {
>  	struct strbuf tables_list_buf = STRBUF_INIT;
>  	struct strbuf new_table_name = STRBUF_INIT;
> @@ -1052,19 +1062,47 @@ static int stack_compact_range(struct reftable_stack *st,
>  	/*
>  	 * Lock all tables in the user-provided range. This is the slice of our
>  	 * stack which we'll compact.
> +	 *
> +	 * Note that we lock tables in reverse order from last to first. The
> +	 * intent behind this is to allow a newer process to perform best
> +	 * effort compaction of tables that it has added in the case where an
> +	 * older process is still busy compacting tables which are preexisting
> +	 * from the point of view of the newer process.
>  	 */

Now that concurrent compaction of discrete table segments is possible,
locking the tables in reverse order allows a compaction process to
immediately mark the ending table of the segment and thus avoids
unnecessary competition between other concurrent compaction processes.

>  	REFTABLE_CALLOC_ARRAY(table_locks, last - first + 1);
> -	for (i = first; i <= last; i++) {
> -		stack_filename(&table_name, st, reader_name(st->readers[i]));
> +	for (i = last + 1; i > first; i--) {
> +		stack_filename(&table_name, st, reader_name(st->readers[i - 1]));

I might be missing something, but why not set `i = last` and `i >=
first`? It looks like everywhere we reference `i` we subtract one
anyways. Since `last` is already at the starting index, it seems it
would be a bit more straightforward.

>  
>  		err = hold_lock_file_for_update(&table_locks[nlocks],
>  						table_name.buf, LOCK_NO_DEREF);
>  		if (err < 0) {
> -			if (errno == EEXIST)
> +			/*
> +			 * When the table is locked already we may do a
> +			 * best-effort compaction and compact only the tables
> +			 * that we have managed to lock so far. This of course
> +			 * requires that we have been able to lock at least two
> +			 * tables, otherwise there would be nothing to compact.
> +			 * In that case, we return a lock error to our caller.
> +			 */
> +			if (errno == EEXIST && last - (i - 1) >= 2 &&
> +			    flags & STACK_COMPACT_RANGE_BEST_EFFORT) {
> +				err = 0;
> +				/*
> +				 * The subtraction is to offset the index, the
> +				 * addition is to only compact up to the table
> +				 * of the preceding iteration. They obviously
> +				 * cancel each other out, but that may be
> +				 * non-obvious when it was omitted.
> +				 */
> +				first = (i - 1) + 1;

I think we could solve potential confusion here by changing how `i` is
initially set also.

> +				break;
> +			} else if (errno == EEXIST) {
>  				err = REFTABLE_LOCK_ERROR;
> -			else
> +				goto done;
> +			} else {
>  				err = REFTABLE_IO_ERROR;
> -			goto done;
> +				goto done;
> +			}
>  		}
>  
>  		/*
> @@ -1308,9 +1346,10 @@ static int stack_compact_range(struct reftable_stack *st,
>  
>  static int stack_compact_range_stats(struct reftable_stack *st,
>  				     size_t first, size_t last,
> -				     struct reftable_log_expiry_config *config)
> +				     struct reftable_log_expiry_config *config,
> +				     unsigned int flags)
>  {
> -	int err = stack_compact_range(st, first, last, config);
> +	int err = stack_compact_range(st, first, last, config, flags);
>  	if (err == REFTABLE_LOCK_ERROR)
>  		st->stats.failures++;
>  	return err;
> @@ -1320,7 +1359,7 @@ int reftable_stack_compact_all(struct reftable_stack *st,
>  			       struct reftable_log_expiry_config *config)
>  {
>  	size_t last = st->merged->stack_len ? st->merged->stack_len - 1 : 0;
> -	return stack_compact_range_stats(st, 0, last, config);
> +	return stack_compact_range_stats(st, 0, last, config, 0);
>  }
>  
>  static int segment_size(struct segment *s)
> @@ -1427,7 +1466,7 @@ int reftable_stack_auto_compact(struct reftable_stack *st)
>  	reftable_free(sizes);
>  	if (segment_size(&seg) > 0)
>  		return stack_compact_range_stats(st, seg.start, seg.end - 1,
> -						 NULL);
> +						 NULL, STACK_COMPACT_RANGE_BEST_EFFORT);
>  
>  	return 0;
>  }
> diff --git a/reftable/stack_test.c b/reftable/stack_test.c
> index 2b1eb83934..733cf6113e 100644
> --- a/reftable/stack_test.c
> +++ b/reftable/stack_test.c
> @@ -913,13 +913,15 @@ static void test_reftable_stack_auto_compaction_with_locked_tables(void)
>  	write_file_buf(buf.buf, "", 0);
>  
>  	/*
> -	 * Ideally, we'd handle the situation where any of the tables is locked
> -	 * gracefully. We don't (yet) do this though and thus fail.
> +	 * When parts of the stack are locked, then auto-compaction does a best
> +	 * effort compaction of those tables which aren't locked. So while this
> +	 * would in theory compact all tables, due to the preexisting lock we
> +	 * only compact the newest two tables.
>  	 */
>  	err = reftable_stack_auto_compact(st);
> -	EXPECT(err == REFTABLE_LOCK_ERROR);
> -	EXPECT(st->stats.failures == 1);
> -	EXPECT(st->merged->stack_len == 5);
> +	EXPECT_ERR(err);
> +	EXPECT(st->stats.failures == 0);
> +	EXPECT(st->merged->stack_len == 4);
>  
>  	reftable_stack_destroy(st);
>  	strbuf_release(&buf);
> diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
> index b06c46999d..37510c2b2a 100755
> --- a/t/t0610-reftable-basics.sh
> +++ b/t/t0610-reftable-basics.sh
> @@ -478,19 +478,26 @@ test_expect_success "$command: auto compaction" '
>  
>  		test_oid blob17_2 | git hash-object -w --stdin &&
>  
> -		# Lock all tables write some refs. Auto-compaction will be
> -		# unable to compact tables and thus fails gracefully, leaving
> -		# the stack in a sub-optimal state.
> -		ls .git/reftable/*.ref |
> +		# Lock all tables, write some refs. Auto-compaction will be
> +		# unable to compact tables and thus fails gracefully,
> +		# compacting only those tables which are not locked.
> +		ls .git/reftable/*.ref | sort |
>  		while read table
>  		do
> -			touch "$table.lock" || exit 1
> +			touch "$table.lock" &&
> +			basename "$table" >>tables.expect || exit 1
>  		done &&
> +		test_line_count = 2 .git/reftable/tables.list &&
>  		git branch B &&
>  		git branch C &&
> -		rm .git/reftable/*.lock &&
> -		test_line_count = 4 .git/reftable/tables.list &&
>  
> +		# The new tables are auto-compacted, but the locked tables are
> +		# left intact.
> +		test_line_count = 3 .git/reftable/tables.list &&
> +		head -n 2 .git/reftable/tables.list >tables.head &&
> +		test_cmp tables.expect tables.head &&
> +
> +		rm .git/reftable/*.lock &&
>  		git $command --auto &&
>  		test_line_count = 1 .git/reftable/tables.list
>  	)
> -- 
> 2.46.0.dirty
> 
