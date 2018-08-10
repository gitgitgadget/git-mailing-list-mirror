Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C35761F404
	for <e@80x24.org>; Fri, 10 Aug 2018 16:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbeHJTNU (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 15:13:20 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33299 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727687AbeHJTNU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 15:13:20 -0400
Received: by mail-wm0-f66.google.com with SMTP id r24-v6so1935899wmh.0
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 09:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=KzOyzmf8l3IOF8TUdSWUw/7Jw538iK43+4rTyYGJ5pU=;
        b=WT2hi9SgM4kC/exDJnL+QnCDCTNhDkACJDnSotwtj8W5HmHkEX04MT+/MpBbWl6lyv
         JwiBJZm0Pw95DmwCYve+F9lKdoennoY73O27dwLWENbGvmquf6WD90gonsB57ldvNtLl
         crOr48vgyjPtJtAN1/OPFDAoYX5lnMl3ENJCncX5elkgSl7xkzMzPfpN2BiG5B9A5igU
         XElckASybNRpkiC+mstB/canAB/zAr89HDFrSiCUIUcbmgjVplioWxs/yGLsEvun8Okb
         jUB/ScndEPFZE3tmfXTuxtB2ZvLnHHwWqUAu9/vMJ0lx+TvOU51gDrz1YPiwwjXA72Aq
         BMgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=KzOyzmf8l3IOF8TUdSWUw/7Jw538iK43+4rTyYGJ5pU=;
        b=t59gMTPHMXvx3olxVlaLnxtlD+qMFCJ2kYg5NYyfbHusKdF3vj4Gi0vNKrX4CRvbb9
         1JKBU65cRj+dPjWzzN8kVpPhHrauBQqIIB5aYMVBP1nqwzG/5295FKZcLA6RTDSJ2ApH
         j6YjO7amZnkH141dSUl72hiMxi82gga9YvnBoZ2GRZsuo1kh6bh6H4Ao6y4QHRTTyAPv
         sRARcvN0doVqJtKGCIqiJQuFO1HTRxy5vLAMNytZjhVfLIU5GYgKPwmuduZTxRLjwJNz
         75/G9oX04qeZKNicwMw/d7aS/GHFApJcdc8hW21TTS2sECFe/o6VPALi6c0or2UPKhkX
         2dQA==
X-Gm-Message-State: AOUpUlEfZnXqQlINeMMaXxnuSjkrFI6jDrpbRkZjWrsZMHtRwteJtTDw
        /bmCitVyIa3aLGXiU28GarI=
X-Google-Smtp-Source: AA+uWPyv9pYGIVRbTLsIXjv1fXw+TJmsWTzKDBCLto1AcFD091UndhYoQW992e+PNVqoqGnGwCm33g==
X-Received: by 2002:a1c:ec86:: with SMTP id h6-v6mr2047255wmi.53.1533919361998;
        Fri, 10 Aug 2018 09:42:41 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id g2-v6sm2564049wme.20.2018.08.10.09.42.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 Aug 2018 09:42:40 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@jeffhostetler.com, git@vger.kernel.org, newren@gmail.com,
        pawelparuzel95@gmail.com, peff@peff.net,
        sandals@crustytoothpaste.net, tboegi@web.de
Subject: Re: [PATCH v3 1/1] clone: report duplicate entries on case-insensitive filesystems
References: <20180807190110.16216-1-pclouds@gmail.com>
        <20180810153608.30051-1-pclouds@gmail.com>
        <20180810153608.30051-2-pclouds@gmail.com>
Date:   Fri, 10 Aug 2018 09:42:40 -0700
In-Reply-To: <20180810153608.30051-2-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Fri, 10 Aug 2018 17:36:08 +0200")
Message-ID: <xmqqmutu896n.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> +static void mark_duplicate_entries(const struct checkout *state,
> +				   struct cache_entry *ce, struct stat *st)
> +{
> +	int i;
> +	int *count = state->nr_duplicates;
> +
> +	if (!count)
> +		BUG("state->nr_duplicates must not be NULL");
> +
> +	ce->ce_flags |= CE_MATCHED;
> +	(*count)++;

We tried to check out ce and found out that the path is already
occupied, whose stat data is in st.  We increment (*count)++ to
signal the fact that ce itself had trouble.

> +#if !defined(GIT_WINDOWS_NATIVE) /* inode is always zero on Windows */
> +	for (i = 0; i < state->istate->cache_nr; i++) {

Do we want to count up all the way?  IOW, don't we want to stop when
we see the ce itself?

> +		struct cache_entry *dup = state->istate->cache[i];
> +
> +		if (dup->ce_flags & (CE_MATCHED | CE_VALID | CE_SKIP_WORKTREE))
> +			continue;
> +
> +		if (ce_uptodate(dup) &&
> +		    dup->ce_stat_data.sd_ino == st->st_ino) {
> +			dup->ce_flags |= CE_MATCHED;

Is checking ce_uptodate(dup) done to check that the 'dup' is a
freshly checked out entry?  I'd like to understand why it is
necessary, especially beause you know you only call this function in
the o->clone codepath, so everything ought to be fresh.

I agree that the check you have above is sufficient on inum capable
systems.  I also suspect that Windows folks, if they really wish to
report which other path(s) are colliding with ce, would want to
replace this whole loop with a platform specific helper function,
not just the condition in the above "if" statement [*1*], so what we
see here should be sufficient for now.

	Side note #1.  It is sufficient for inum capable systems to
	look at 'dup' and 'st' to cheaply identify collision, but it
	may be more efficient for other systems to look at ce and
	the previous entries of the index, which allows them to use
	platform specific API that knows case-folding and other
	pathname munging specifics.  Going that way lets them
	minimally emulate 'struct stat', which may be expensive to
	fill.

> +			(*count)++;

And then we increment (*count)++ for this _other_ one that
collided with ce.

> +			break;

And we leave the loop.  There may be somebody else that collided
when 'dup' was checked out, making this triple collision, but in
such a case, we won't be coming this far in this loop (i.e.  we
would have continued on this 'dup' as it is marked as CE_MATCHED),
so there is no reason to continue looking for further collision with
'ce' here.  So nr_duplicates kept track by these (*count)++ will
indicate number of paths involved in any collision correctly, I
think.

Makes sense.

> +		}
> +	}
> +#endif
> +}
> +
>  /*
>   * Write the contents from ce out to the working tree.
>   *
> @@ -455,6 +484,9 @@ int checkout_entry(struct cache_entry *ce,
>  			return -1;
>  		}
>  
> +		if (state->clone)
> +			mark_duplicate_entries(state, ce, &st);
> +
>  		/*
>  		 * We unlink the old file, to get the new one with the
>  		 * right permissions (including umask, which is nasty
> diff --git a/unpack-trees.c b/unpack-trees.c
> index f9efee0836..d4fece913c 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -344,12 +344,20 @@ static int check_updates(struct unpack_trees_options *o)
>  	struct index_state *index = &o->result;
>  	struct checkout state = CHECKOUT_INIT;
>  	int i;
> +	int nr_duplicates = 0;
>  
>  	state.force = 1;
>  	state.quiet = 1;
>  	state.refresh_cache = 1;
>  	state.istate = index;
>  
> +	if (o->clone) {
> +		state.clone = 1;
> +		state.nr_duplicates = &nr_duplicates;
> +		for (i = 0; i < index->cache_nr; i++)
> +			index->cache[i]->ce_flags &= ~CE_MATCHED;
> +	}
> +
>  	progress = get_progress(o);
>  
>  	if (o->update)
> @@ -414,6 +422,20 @@ static int check_updates(struct unpack_trees_options *o)
>  	errs |= finish_delayed_checkout(&state);
>  	if (o->update)
>  		git_attr_set_direction(GIT_ATTR_CHECKIN, NULL);
> +
> +	if (o->clone && state.nr_duplicates) {

Does state.nr_duplicates have to be a pointer to int?  I am
wondering if state.clone bit is sufficient to protect codepaths that
needs to spend cycles to keep track of that number, in which case we
can do without local variable nr_duplicates here, and the set-up
code in the previous hunk not to store the pointer to it in
state.nr_duplicates (instead, that field itself can become an int).

> +		warning(_("the following paths have collided and only one from the same\n"
> +			  "colliding group is in the working tree:\n"));

As we are not grouping (and do not particularly see the need to
group), perhaps we can do without mentioning group in the warning?
e.g.

	some of the following may have been checked out incorrectly
	due to limitation of the filesystem like case insensitivity.


> +		for (i = 0; i < index->cache_nr; i++) {
> +			struct cache_entry *ce = index->cache[i];
> +
> +			if (!(ce->ce_flags & CE_MATCHED))
> +				continue;
> +			fprintf(stderr, "  '%s'\n", ce->name);
> +			ce->ce_flags &= ~CE_MATCHED;
> +		}
> +	}
