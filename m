Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 561A11F453
	for <e@80x24.org>; Wed, 23 Jan 2019 18:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfAWS5Z (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 13:57:25 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33702 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfAWS5Y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 13:57:24 -0500
Received: by mail-wr1-f68.google.com with SMTP id p7so3809070wru.0
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 10:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=e7Zva2HGPHAMqItfmOCxJ4ExL7za/dYVvOID12deblk=;
        b=Is2XE6/HrHeEvm42s2BiVyR+hRhD9jzt0dwWNROXXR/dIHoCjZFR8OboIs1q3d0ktq
         4AP7TUE3aMq0i78Bmn/pyIv9Sf1Nkq8OjVIkDkX54AJvpTpsZwpeT3Rau6rNJoMwjHQa
         tsUfyhczbRZDsbk09hHtM5tNMD90lCuGdrfId8YhvztMd80Xb+4HPErcoXA9FMyVHVt+
         xenjMLp3SYmHvoTAMEYXYOUQLB//kMxNGWLAXnR8LImRJHpEHHsiiGu2njvHMijJ4z1G
         tPGqyx6UFcr5ZryuHqbdUYk+qpbFzPLaoC57CdV2AtSKI6biRGhCqlb6XdRKjh4O2qfP
         Ofvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=e7Zva2HGPHAMqItfmOCxJ4ExL7za/dYVvOID12deblk=;
        b=Suj1+sOj6PoeKUYrTPKI9H94uPnl8JEtKE0jGJUW4sp6SrdWvh9lhd3NmGnJHDfpA7
         sUtULWjTfaQ9iBRP5lIA99biDeE6v7Bk7ijZHeOLCpUOxi0h1HnD3z9wtqTS6c0z2boo
         zvdjVO123ZwnFOPxLEKPZDTG1UpCkPK1eHyXMKPpizsluGtJ8LOGNPfd4Z4vCyBzEXC5
         mGaFMLreAiN28Z2iILfl/YEmN3kolETNdLfU68YPAKBxM5Z60I0rxhpc/nAnGi3YZvIE
         O00b6mwjNnsOyJVFB0C52N0PEvJomtX8XuLPjm5QeqqbxZuHp7zvNoU4NcU7I9dBGO0I
         l79w==
X-Gm-Message-State: AJcUukf+30XJ/zKjky1bLEe7cT5pGEgcYhgri608Q8cyKw23m/DteLl5
        BtVBSIb/do76GBXShUdf/hG5tEJA
X-Google-Smtp-Source: ALg8bN7vVvtm6xilb0mqnAT3zfyHW3LzrnpXTEtfwce04IWuFj7c1GvoAGBpdjc5i+D1ozV2o0ZqKg==
X-Received: by 2002:adf:cd0e:: with SMTP id w14mr4137052wrm.218.1548269842330;
        Wed, 23 Jan 2019 10:57:22 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id k128sm76337519wmd.37.2019.01.23.10.57.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 10:57:20 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     nbelakovski@gmail.com
Cc:     git@vger.kernel.org, peff@peff.net, rafa.almas@gmail.com,
        avarab@gmail.com
Subject: Re: [PATCH v6 1/3] ref-filter: add worktreepath atom
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
        <20190122232301.95971-1-nbelakovski@gmail.com>
        <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
        <20190122232301.95971-2-nbelakovski@gmail.com>
Date:   Wed, 23 Jan 2019 10:57:19 -0800
In-Reply-To: <20190122232301.95971-2-nbelakovski@gmail.com> (nbelakovski's
        message of "Tue, 22 Jan 2019 15:22:59 -0800")
Message-ID: <xmqq36pjcicw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

nbelakovski@gmail.com writes:

> From: Nickolai Belakovski <nbelakovski@gmail.com>
>
> Add an atom providing the path of the linked worktree where this ref is
> checked out, if it is checked out in any linked worktrees, and empty
> string otherwise.
> ---

Missing sign-off?

> +static int ref_to_worktree_map_cmpfnc(const void *unused_lookupdata, const void *existing_hashmap_entry_to_test,
> +				   const void *key, const void *keydata_aka_refname)
> +{
> +	const struct ref_to_worktree_entry *e = existing_hashmap_entry_to_test;
> +	const struct ref_to_worktree_entry *k = key;
> +	return strcmp(e->wt->head_ref, keydata_aka_refname ? keydata_aka_refname : k->wt->head_ref);

Overlong line.

> +}


> +
> +static struct hashmap ref_to_worktree_map;
> +static struct worktree **worktrees = NULL;

No need to initialize static vars to 0/NULL.

> @@ -438,6 +456,34 @@ static int head_atom_parser(const struct ref_format *format, struct used_atom *a
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
> +
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

It is kind of interesting that a function for parsing an "atom" in
"format" does not look at none of its arguments at all ;-)  The fact
that "%(worktreepath)" atom got noticed by verify_ref_format() alone
is of interest for this function.

The helper iterates over all worktrees, registers them in a hashmap
ref_to_worktree_map, indexed by the head reference.

OK.

> +static char *get_worktree_path(const struct used_atom *atom, const struct ref_array_item *ref)
> +{
> +	struct strbuf val = STRBUF_INIT;
> +	struct hashmap_entry entry;
> +	struct ref_to_worktree_entry *lookup_result;
> +
> +	hashmap_entry_init(&entry, strhash(ref->refname));
> +	lookup_result = hashmap_get(&ref_to_worktree_map, &entry, ref->refname);
> +
> +	if (lookup_result)
> +		strbuf_addstr(&val, lookup_result->wt->path);
> +
> +	return strbuf_detach(&val, NULL);
> +}

We do not need a strbuf to do the above, do we?

	hashmap_entry_init(...);
	lookup_result = hashmap_get(...);
	if (lookup_result)
		return xstrdup(lookup_result->wt->path);
	else
		return xstrdup("");

or something like that, perhaps?

> @@ -1562,6 +1624,13 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
>  
>  		if (starts_with(name, "refname"))
>  			refname = get_refname(atom, ref);
> +		else if (starts_with(name, "worktreepath")) {
> +			if (ref->kind == FILTER_REFS_BRANCHES)
> +				v->s = get_worktree_path(atom, ref);
> +			else
> +				v->s = xstrdup("");
> +			continue;
> +		}

I am wondering if get_worktree_path() being called should be the
triggering event for lazy initialization worktree_atom_parser() is
doing in this patch, instead of verify_ref_format() seeing the
"%(worktreepath)" atom.  Is there any codepath that wants to make
sure the lazy initialization is done without/before populate_value()
sees a use of the "%(worktreepath)" atom?  If so, such a plan would
not work, but otherwise, we can do the following:

 - rename worktree_atom_parser() to lazy_init_worktrees() or
   something, and remove all of its unused parameters.

 - remove parser callback for "worktreepath" from valid_atom[].

 - call lazy_inti_worktrees() at the beginning of
   get_worktree_path().

Hmm?
