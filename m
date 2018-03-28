Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBCA11F404
	for <e@80x24.org>; Wed, 28 Mar 2018 00:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752195AbeC1AHS (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 20:07:18 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:39026 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752109AbeC1AHR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 20:07:17 -0400
Received: by mail-pg0-f67.google.com with SMTP id b9so267434pgf.6
        for <git@vger.kernel.org>; Tue, 27 Mar 2018 17:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5kPsV0mj/fStxvSff549Kh0WbFxi9QQ/ui597XrQozU=;
        b=DVDZADIOlZ6NK8VtwZ3ceHfJTLlyaXHE7c+RwhIZg4/7x09BlnkCt5dtgXPA/CaeVZ
         eYQ8mHVBQ52Spia39lvBD0Nqo6ZlLRnqogNyoPK/de24o/ljLD48vfQxY85bitFxlk6L
         RZnEYErS3i9uEgOxrm3ciNyB3/+InDTbMJnJZvOTgW9/fK47lEmUP1Vpfh3L1ZziQLpX
         a+tSTHyukFQ3M3L+RWyUVjqKV6Afv3Nkrnx7yAkGoAEYFnQBU8FiNLMA12QJ8TrWNoMe
         uot71kcBSndnrd7Q5597K6anQ+Xle/riWZLmBWtXSjscVTZpMJwkNPWato6iMI89+4k4
         iL7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5kPsV0mj/fStxvSff549Kh0WbFxi9QQ/ui597XrQozU=;
        b=pbn+H22ZVQtAYiDIbV3ka9D232PzSkB8DzPVQmm/szcmJG2O5XzIPc/tTrkeK6pZVD
         KSNUIJu+r8NlX9TwshXluJMTrAOkGulDTqQBdGbAV7lfzQbmXN9TjQ0nhtThA/tVK2E9
         87ihh2Vh9pVc4JMJCbXzDb7ZMFWTqGsZr/UD3jGwWsOo/ff83bsfgkjBa9oDhi/smrXa
         ehor0U+wb/q3JpJ0CZzEEoK2N3tFgDAv6Qx5X73RhHuxzX8NGu7839FT0bPzMdurEMYV
         ZDNu2ReHN/CguSvA3+6E4kKE1tTB9atyjimU2jz0WEEcDXbRVO9EGMEBGZn75PA0qGIl
         5z9Q==
X-Gm-Message-State: AElRT7FkFhuBPn2RU8ljfHmDyHVvRKUr6R+/yIcDfVA6lplEFMyHiYRC
        UFQ5WiFr76uzvfVPtDTq0D3ILN0i0vE=
X-Google-Smtp-Source: AIpwx4/SZv7/QIP6fBd9glvCC6ZxLzziemoB67HtE1XoKVOnzsYfc3cNTWvrFsSF0oWcJRTMvjbnHg==
X-Received: by 10.98.214.218 with SMTP id a87mr1089502pfl.124.1522195636853;
        Tue, 27 Mar 2018 17:07:16 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id 12sm5060876pfr.108.2018.03.27.17.07.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Mar 2018 17:07:15 -0700 (PDT)
Date:   Tue, 27 Mar 2018 17:07:14 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, seanwbehan@riseup.net, bmwill@google.com,
        hvoigt@hvoigt.net
Subject: Re: [PATCH 5/5] submodule: fixup nested submodules after moving the
 submodule
Message-Id: <20180327170714.81b37f84cb4c544d76f34701@google.com>
In-Reply-To: <20180327213918.77851-6-sbeller@google.com>
References: <20180327213918.77851-1-sbeller@google.com>
        <20180327213918.77851-6-sbeller@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 27 Mar 2018 14:39:18 -0700
Stefan Beller <sbeller@google.com> wrote:

> connect_work_tree_and_git_dir is used to connect a submodule worktree with
> its git directory and vice versa after events that require a reconnection
> such as moving around the working tree. As submodules can have nested
> submoduled themselves, we'd also want to fix the nested submodules when

s/submoduled/submodules

> asked to. Add an option to recurse into the nested submodules and connect
> them as well.
> 
> As submodules are identified by their name (which determines their git
> directory in relation to their superprojects git directory) internally

s/superprojects/superproject's/

> and by their path in the working tree of the superproject, we need to
> make sure that the mapping of name <-> path is kept intact. We can do
> that in the git-mv command by writing out the gitmodules file and first

s/and //

> and then force a reload of the submodule config machinery.

s/force/forcing/

> 
> Signed-off-by: Stefan Beller <sbeller@google.com>

[snip]

> +static void connect_wt_gitdir_in_nested(const char *sub_worktree,
> +					const char *sub_gitdir,
> +					struct repository *superproject)
> +{
> +	int i;
> +	struct repository subrepo;
> +	struct strbuf sub_wt = STRBUF_INIT;
> +	struct strbuf sub_gd = STRBUF_INIT;
> +	const struct submodule *sub;
> +	const char *super_worktree,
> +		   *sub_path; /* path inside the superproject */
> +
> +	/* subrepo got moved, so superproject has outdated information */
> +	submodule_free(superproject);
> +
> +	super_worktree = real_pathdup(superproject->worktree, 1);
> +
> +	sub_path = sub_worktree + strlen(super_worktree) + 1;
> +
> +	if (repo_submodule_init(&subrepo, superproject, sub_path))
> +		return;
> +
> +	repo_read_index(&subrepo);

From the name of this function and its usage in
connect_work_tree_and_git_dir(), I expected this function to just
iterate through all the files in its workdir (which it is doing in the
"for" loop below) and connect any nested submodules. Why does it need
access to its superproject? (I would think that repo_init() would be
sufficient here instead of repo_submodule_init().)

> +
> +	for (i = 0; i < subrepo.index->cache_nr; i++) {
> +		const struct cache_entry *ce = subrepo.index->cache[i];
> +
> +		if (!S_ISGITLINK(ce->ce_mode))
> +			continue;
> +
> +		while (i + 1 < subrepo.index->cache_nr &&
> +		       !strcmp(ce->name, subrepo.index->cache[i + 1]->name))
> +			/*
> +			 * Skip entries with the same name in different stages
> +			 * to make sure an entry is returned only once.
> +			 */
> +			i++;
> +
> +		sub = submodule_from_path(&subrepo, &null_oid, ce->name);
> +		if (!sub)
> +			/* submodule not checked out? */
> +			continue;
> +
> +		strbuf_reset(&sub_wt);
> +		strbuf_addf(&sub_wt, "%s/%s/.git", sub_worktree, sub->path);
> +
> +		strbuf_reset(&sub_gd);
> +		strbuf_addf(&sub_gd, "%s/modules/%s", sub_gitdir, sub->name);
> +
> +		strbuf_setlen(&sub_wt, sub_wt.len - strlen("/.git"));
> +
> +		if (is_submodule_active(&subrepo, ce->name)) {
> +			connect_work_tree_and_git_dir(sub_wt.buf, sub_gd.buf, 0);
> +			connect_wt_gitdir_in_nested(sub_wt.buf, sub_gd.buf, &subrepo);

The modifications of sub_wt and sub_gd should probably go here, since
they are not used unless this "if" block is executed.

> +void connect_work_tree_and_git_dir(const char *work_tree_,
> +				   const char *git_dir_,
> +				   int recurse_into_nested)

How is this function expected to be used? From what I see:
 - if recurse_into_nested is 0, this works regardless of whether the
   work_tree_ and git_dir_ is directly or indirectly a submodule of
   the_repository
 - if recurse_into_nested is 1, work_tree_ and git_dir_ must be directly
   a submodule of the_repository (since it is referenced directly)

This seems confusing - is this expected?
