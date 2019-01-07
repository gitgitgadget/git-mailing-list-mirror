Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6245D1F803
	for <e@80x24.org>; Mon,  7 Jan 2019 18:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbfAGSUn (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 13:20:43 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33632 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728539AbfAGSUn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 13:20:43 -0500
Received: by mail-wr1-f65.google.com with SMTP id c14so1483835wrr.0
        for <git@vger.kernel.org>; Mon, 07 Jan 2019 10:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Q70qgLoeL2FjK+OH9N79UP18lu68ZgV4DBch3v6w73Q=;
        b=HHzAQdu3VHEjPTsKREW0/onaTQsJEFg3AP35W9mTphPGIISOdDgWPWQDB6rMFTeJSr
         VOtWJE8mbFxY5VZ2nlPN+3m4LOeYLZzHOR6ClusUrupbdRVRhl/QD7zKJBOVUiDL80BN
         2NlXqS5bPcH75/FsdpB0+aNiN/2r0X3dNyWiJkRBjr+Bdq2e88bJr8dGR1iONXqLY6J3
         Fg3Q5kacdvP3qxxr/pOAotWdJ9K2IeycrTv4uW/ADJtYLYDudqRbkmLW+wZi2qU0MURF
         a4Ip7Lz3CyJ11Bx+zlXPn7u+WQI242XRrqr2iitIjfzhLex8fMZ5oNP2cbcBvUnt83ng
         7iBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Q70qgLoeL2FjK+OH9N79UP18lu68ZgV4DBch3v6w73Q=;
        b=rl5IUZoBIHUzCqoO+1x/C/xv4PZyZxXwR2bDx1obFu6YFsPsIm0oXHxoEERW6LDK0P
         o3o5/KafCHj9JKY/6+VNSYZw+n8MnQvVZ/AVmMbRxZgfVycwCs+6ty8omcoauVMsKrYi
         ytKsXXipwwsXmUhnOvk3iG9jD4TFTcP3Z7UB+GCHny5T7V3eeQCs9W1wz5IzmT7pQauT
         UUtU5oEchNjX+aLc7y2tOST7UqeNuxjZHBlBbSQN2TXsqBVSS/MzVudBf9XanRKvwZiC
         35gZYodqVrn5DeQCs8gUTCvq0L7dpUlOP/pzqgRBKeJH3TJ8YOgRZCmRVXFmwUyER/+3
         OlCA==
X-Gm-Message-State: AJcUukef3cwc3KsZOr5LFudap1AhDzVhaaKwhWB+FG/5D7qS3raQgFcW
        UQKRiN5u7Wgmc99kLoAPd5SRNiIf
X-Google-Smtp-Source: ALg8bN63lmoiqBjM6deDLQI7x3RZ9vdqQNW739Dzo+Ihc6WH0UgOZM+lB8yvEb/jtfjfGLgyfZ6R+g==
X-Received: by 2002:a5d:6aca:: with SMTP id u10mr50889114wrw.310.1546885240420;
        Mon, 07 Jan 2019 10:20:40 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 67sm78220998wra.37.2019.01.07.10.20.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 10:20:39 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     nbelakovski@gmail.com
Cc:     git@vger.kernel.org, peff@peff.net, rafa.almas@gmail.com,
        avarab@gmail.com
Subject: Re: [PATCH v5 1/3] ref-filter: add worktreepath atom
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
        <20190106002619.54741-1-nbelakovski@gmail.com>
        <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
        <20190106002619.54741-2-nbelakovski@gmail.com>
Date:   Mon, 07 Jan 2019 10:20:39 -0800
In-Reply-To: <20190106002619.54741-2-nbelakovski@gmail.com> (nbelakovski's
        message of "Sat, 5 Jan 2019 16:26:17 -0800")
Message-ID: <xmqq5zv09vns.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

nbelakovski@gmail.com writes:

> +static struct hashmap ref_to_worktree_map;
> +static struct worktree **worktrees = NULL;
> +
>  /*
>   * An atom is a valid field atom listed below, possibly prefixed with
>   * a "*" to denote deref_tag().
> @@ -420,6 +438,34 @@ static int head_atom_parser(const struct ref_format *format, struct used_atom *a
>  	return 0;
>  }
>  
> +static int worktree_atom_parser(const struct ref_format *format,
> +				struct used_atom *atom,
> +				const char *arg,
> +				struct strbuf *unused_err)
> +{
> +	int i;
> +
> +	if (worktrees)
> +		return 0;

OK, so verify_ref_format() etc. will trigger this to be called via
valid_atom[].parser when "%(worktreepath)" is seen in the user
format, and then this grabs all the worktrees and record their paths
in the hashmap.  This if() statement makes sure that it happens only
once.

> +	worktrees = get_worktrees(0);
> +
> +	hashmap_init(&ref_to_worktree_map, ref_to_worktree_map_cmpfnc, NULL, 0);
> +
> +	for (i = 0; worktrees[i]; i++) {
> +		if (worktrees[i]->head_ref) {
> +			struct ref_to_worktree_entry *entry;
> +			entry = xmalloc(sizeof(*entry));
> +			entry->wt = worktrees[i];
> +			hashmap_entry_init(entry, strhash(worktrees[i]->head_ref));
> +
> +			hashmap_add(&ref_to_worktree_map, entry);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static struct {
>  	const char *name;
>  	info_source source;
> @@ -461,6 +507,7 @@ static struct {
>  	{ "flag", SOURCE_NONE },
>  	{ "HEAD", SOURCE_NONE, FIELD_STR, head_atom_parser },
>  	{ "color", SOURCE_NONE, FIELD_STR, color_atom_parser },
> +	{ "worktreepath", SOURCE_NONE, FIELD_STR, worktree_atom_parser },
>  	{ "align", SOURCE_NONE, FIELD_STR, align_atom_parser },
>  	{ "end", SOURCE_NONE },
>  	{ "if", SOURCE_NONE, FIELD_STR, if_atom_parser },
> @@ -1500,6 +1547,21 @@ static int get_object(struct ref_array_item *ref, int deref, struct object **obj
>  	return 0;
>  }
>  
> +static char *get_worktree_path(const struct used_atom *atom, const struct ref_array_item *ref)
> +{
> +	struct strbuf val = STRBUF_INIT;
> +	struct hashmap_entry entry;
> +	struct ref_to_worktree_entry *lookup_result;

And then this will be called from populate_value() for each of the
ref.  It looks up the worktree that has checked out this branch, if
any, from the hashmap, and yields the path to it.

When seeing a tag or note ref, by definition that's not something we
can have checked out in any worktree.  I wonder if it is worth to
optimize further by omitting this lookup when ref is not a local
branch?

IOW, with a typical number of worktrees and refs, how costly would ...

> +	hashmap_entry_init(&entry, strhash(ref->refname));
> +	lookup_result = hashmap_get(&ref_to_worktree_map, &entry, ref->refname);

... this sequence of calls be.

> +
> +	if (lookup_result)
> +		strbuf_addstr(&val, lookup_result->wt->path);
> +
> +	return strbuf_detach(&val, NULL);
> +}
> +
>  /*
>   * Parse the object referred by ref, and grab needed value.
>   */
> @@ -1537,6 +1599,10 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
>  
>  		if (starts_with(name, "refname"))
>  			refname = get_refname(atom, ref);
> +		else if (starts_with(name, "worktreepath")) {
> +			v->s = get_worktree_path(atom, ref);
> +			continue;
> +		}
>  		else if (starts_with(name, "symref"))
>  			refname = get_symref(atom, ref);
>  		else if (starts_with(name, "upstream")) {
> @@ -2020,6 +2086,11 @@ void ref_array_clear(struct ref_array *array)
>  		free_array_item(array->items[i]);
>  	FREE_AND_NULL(array->items);
>  	array->nr = array->alloc = 0;
> +	if (worktrees)
> +	{

Have this opening brace at the end of the previous line, i.e.

	if (worktrees) {

> +		hashmap_free(&ref_to_worktree_map, 1);
> +		free_worktrees(worktrees);
> +	}
>  }

What's the point of ref_array_clear()?  What does the caller of this
function really want?  Is it merely to release the resources
consumed?  If so, then this is good enough, but then the existing
calls to FREE_AND_NULL() for releasing resources in the function is
overkill.

Or is it envisioned that we are preparing a clean slate so that
another call, possibly after the external environment changed, can
be made into this machinery (i.e. imagine we lift ref-filter.c code
and link it to a long running service process; after serving one
for-each-ref request, a new worktree or a new branch may get
created, and then we may get another for-each-ref request)?  If that
is the case, then the added code breaks that hope, as it leaves a
dangling pointer in the worktrees variable.

>  static void do_merge_filter(struct ref_filter_cbdata *ref_cbdata)
> diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
> index fc067ed672..87e0222ea1 100755
> --- a/t/t6302-for-each-ref-filter.sh
> +++ b/t/t6302-for-each-ref-filter.sh
> @@ -441,4 +441,19 @@ test_expect_success '--merged is incompatible with --no-merged' '
>  	test_must_fail git for-each-ref --merged HEAD --no-merged HEAD
>  '
>  
> +test_expect_success '"add" a worktree' '
> +	mkdir worktree_dir &&
> +	git worktree add -b master_worktree worktree_dir master
> +'
> +
> +test_expect_success 'validate worktree atom' '
> +	cat >expect <<-EOF &&
> +	master: $(pwd)
> +	master_worktree: $(pwd)/worktree_dir
> +	side: not checked out
> +	EOF
> +	git for-each-ref --format="%(refname:short): %(if)%(worktreepath)%(then)%(worktreepath)%(else)not checked out%(end)" refs/heads/ >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done
