Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 208B92021E
	for <e@80x24.org>; Wed, 16 Nov 2016 00:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752609AbcKPACl (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 19:02:41 -0500
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35943 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751741AbcKPACj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 19:02:39 -0500
Received: by mail-pf0-f181.google.com with SMTP id 189so38819102pfz.3
        for <git@vger.kernel.org>; Tue, 15 Nov 2016 16:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y+bX2bInhc6WWi6Y2fh0ffWd4NKHlmvlEgDLtRIPW5E=;
        b=eqn03iXbfhm/hceIYnJPM4WoDjGOyZk+0YifGAHzpLM9y3dTsaBhU/pErlWQT9fPwj
         9kFUB/YIuutYx2vg7yh5h4TByZQAKisV9yt9JCsonJG7dJKKjO0RGeq4BlRuW7XwwEUf
         H+B83nzvWkpxD89X8QWE+QtFULSRUbnm6VtQ8Ngrwr61CPR4gZazW7P+yvoZIl7a4My7
         FlBmEF4HiuRjCzSTh+FCawWCklLQ9028tnGRw5UPHaQ9x42wTTbHJ7yzX85OzLW/kMLJ
         eofKcQFoeI5/TEbxkt3cL+voh51ac1qR+gQPeRyHOXoVGi74jktFMDxmojjy+/CICsmP
         lbgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y+bX2bInhc6WWi6Y2fh0ffWd4NKHlmvlEgDLtRIPW5E=;
        b=jS1WXpMUPwHs+PZ1jcR3wQuozK5nk3ggNjibJNPMSd6I44NV0YzCKRLet5iILTMWwP
         YnYgsvF8FJ0jBUtYPtFIIGQGUUKL6pA2Y7eaqj4hL16uEI6dgU1zcEUxt06Ee/C1njtK
         LmVsWcv/O+jnul/v6BmTMAwbFAB15o5H/vg4fgPEttj28UfyULuNzeos5pwTMZzzjjXJ
         zaIzq+OH9SZ8Gsuds49uCkHGO3togyksq12yWBCiptDWylpNNULs4rJ6TbSEUlHk5aA7
         t01bbpY3l/zkpMyth+isj91wPNH+I0encTThkO/ZClL/rdOEvnRKQ7mRUX9YeyT2tfvd
         dbjQ==
X-Gm-Message-State: ABUngvdjoPKYGpEw/QFis63bblJdMic/0c/ACW3nNNMHMYLTQBsfdH6gwzPPM3qxCEJnCnal
X-Received: by 10.98.204.72 with SMTP id a69mr342910pfg.76.1479254558904;
        Tue, 15 Nov 2016 16:02:38 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:f0a8:aad3:5a98:9829])
        by smtp.gmail.com with ESMTPSA id r2sm46498046pfi.67.2016.11.15.16.02.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 15 Nov 2016 16:02:37 -0800 (PST)
Date:   Tue, 15 Nov 2016 16:02:36 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com,
        mogulguy10@gmail.com, David.Turner@twosigma.com
Subject: Re: [PATCH 09/16] update submodules: add scheduling to update
 submodules
Message-ID: <20161116000236.GF66382@google.com>
References: <20161115230651.23953-1-sbeller@google.com>
 <20161115230651.23953-10-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161115230651.23953-10-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/15, Stefan Beller wrote:
> +static int update_submodule(const char *path, const struct object_id *oid,
> +			    int force, int is_new)
> +{
> +	const char *git_dir;
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +	const struct submodule *sub = submodule_from_path(null_sha1, path);
> +
> +	if (!sub || !sub->name)
> +		return -1;
> +
> +	git_dir = resolve_gitdir(git_common_path("modules/%s", sub->name));
> +
> +	if (!git_dir)
> +		return -1;
> +
> +	if (is_new)
> +		connect_work_tree_and_git_dir(path, git_dir);

> +
> +	/* update index via `read-tree --reset sha1` */
> +	argv_array_pushl(&cp.args, "read-tree",
> +				   force ? "--reset" : "-m",
> +				   "-u", sha1_to_hex(oid->hash), NULL);
> +	prepare_submodule_repo_env(&cp.env_array);
> +	cp.git_cmd = 1;
> +	cp.no_stdin = 1;
> +	cp.dir = path;
> +	if (run_command(&cp)) {
> +		warning(_("reading the index in submodule '%s' failed"), path);
> +		child_process_clear(&cp);
> +		return -1;
> +	}
> +
> +	/* write index to working dir */
> +	child_process_clear(&cp);
> +	child_process_init(&cp);
> +	argv_array_pushl(&cp.args, "checkout-index", "-a", NULL);
> +	cp.git_cmd = 1;
> +	cp.no_stdin = 1;
> +	cp.dir = path;
> +	if (force)
> +		argv_array_push(&cp.args, "-f");
> +
> +	if (run_command(&cp)) {
> +		warning(_("populating the working directory in submodule '%s' failed"), path);
> +		child_process_clear(&cp);
> +		return -1;
> +	}
> +
> +	/* get the HEAD right */
> +	child_process_clear(&cp);
> +	child_process_init(&cp);
> +	argv_array_pushl(&cp.args, "checkout", "--recurse-submodules", NULL);
> +	cp.git_cmd = 1;
> +	cp.no_stdin = 1;
> +	cp.dir = path;
> +	if (force)
> +		argv_array_push(&cp.args, "-f");
> +	argv_array_push(&cp.args, sha1_to_hex(oid->hash));
> +
> +	if (run_command(&cp)) {
> +		warning(_("setting the HEAD in submodule '%s' failed"), path);
> +		child_process_clear(&cp);
> +		return -1;
> +	}
> +
> +	child_process_clear(&cp);
> +	return 0;
> +}

If run command is successful then it handles the clearing of the child
process struct, correct?  Is there a negative to having all the explicit
clears when the child was successful?

> +
>  int depopulate_submodule(const char *path)
>  {
>  	int ret = 0;
> @@ -1336,3 +1405,51 @@ void prepare_submodule_repo_env(struct argv_array *out)
>  	}
>  	argv_array_push(out, "GIT_DIR=.git");
>  }
> +
> +struct scheduled_submodules_update_type {
> +	const char *path;
> +	const struct object_id *oid;
> +	/*
> +	 * Do we need to perform a complete checkout or just incremental
> +	 * update?
> +	 */
> +	unsigned is_new:1;
> +} *scheduled_submodules;
> +#define SCHEDULED_SUBMODULES_INIT {NULL, NULL}

I may not know enough about these types of initializors but that Init
macro only has 2 entries while there are three entries in the struct
itself.

> +
> +int scheduled_submodules_nr, scheduled_submodules_alloc;

Should these globals be static since they should be scoped to only this
file?

> +
> +void schedule_submodule_for_update(const struct cache_entry *ce, int is_new)
> +{
> +	struct scheduled_submodules_update_type *ssu;
> +	ALLOC_GROW(scheduled_submodules,
> +		   scheduled_submodules_nr + 1,
> +		   scheduled_submodules_alloc);
> +	ssu = &scheduled_submodules[scheduled_submodules_nr++];
> +	ssu->path = ce->name;
> +	ssu->oid = &ce->oid;
> +	ssu->is_new = !!is_new;
> +}
> +
> +int update_submodules(int force)
> +{
> +	int i;
> +	gitmodules_config();
> +
> +	/*
> +	 * NEEDSWORK: As submodule updates can potentially take some
> +	 * time each and they do not overlap (i.e. no d/f conflicts;
> +	 * this can be parallelized using the run_commands.h API.
> +	 */
> +	for (i = 0; i < scheduled_submodules_nr; i++) {
> +		struct scheduled_submodules_update_type *ssu =
> +			&scheduled_submodules[i];
> +
> +		if (submodule_is_interesting(ssu->path, null_sha1))
> +			update_submodule(ssu->path, ssu->oid,
> +					 force, ssu->is_new);
> +	}
> +
> +	scheduled_submodules_nr = 0;
> +	return 0;
> +}

nit: organization wise it makes more sense to me to have the
'update_submodule' helper function be located more closely to the
'update_submodules' function.

-- 
Brandon Williams
