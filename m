Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 868F71F404
	for <e@80x24.org>; Sun, 25 Mar 2018 16:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753553AbeCYQjj (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 12:39:39 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:50495 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750832AbeCYQji (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 12:39:38 -0400
Received: by mail-wm0-f49.google.com with SMTP id i75so11260049wmf.0
        for <git@vger.kernel.org>; Sun, 25 Mar 2018 09:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MbLRBRzRuBKdB0geRE1gpsgUt0XOTAZhfywbc9kyGpk=;
        b=MpWE7mKUpZyAp4aq0jHqzt8G8b0prPl7nj/Vknb/EIVX0/9dFaMDDU8SDS01HuVs5k
         O4kd5MkSZN7ARSYGy1OGaDu15Ne6+tnelj2m0dsp8kCSog2+hQKO0bG5w7n+pl5w7csS
         Oe5J0aNcczcq11AISad5uMBF96ChHGu+i7ACHB8vvw+Qn4f09Ix10Jp80eTFf/gtYiiD
         wNQDY/R33IVyA5m/7QQVY0Acrd2yT5J29wJvWzAlWIY4oSq6927bZ65RhcxyLyLf6HEF
         M/FoEvNb3/vE1rVes8QUj1QqGg+aiRPzH9wUcOZ4zoiP7UJK7U/5Z+dFqKNktJq2/e9A
         W70g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MbLRBRzRuBKdB0geRE1gpsgUt0XOTAZhfywbc9kyGpk=;
        b=cvmbSz903CzWzMzYkPYaiz8ZkzvEDNVHMgR0hTDIsYv6XRkaaXBgFoF2jMvK7kz490
         F6AvTgiyB25wwhYzv7XP2pWzxPxIyCE3iP0cWL+4vx7kfpc9H7AxhUXGWu0AVE1Tjbc5
         1BCj8MUc8rI6mVunpKaNJtmzb/cKxQ+9ZXc/7MnZ4hW9gmVDDxW2wpi7GjO5tU21jUBk
         29C7+tJgpbG1EMtOml7U45fLZgos3+/xG6NQFOZPtTudvJO7H94AFcn4qYeW8LzwcAby
         eyZ2Z7HStJRYb5k9ZgG7Rthach+QaHQQMJTFEuQdOB9GMbKOmgOPExfF+BgEjR9cAA9A
         c0hA==
X-Gm-Message-State: AElRT7Hvl1Zu2YQbi2OOEzQtO5FUq/SlarqdPvXAD4LzQztadD6mHODE
        G12Ccbp+K2PHbhEK8S6OjpjBFZ0J
X-Google-Smtp-Source: AG47ELvRK40ie5cAhDPOSDc5eNZj8iRIvyKF7nns4m6dio18yPf7CLj391F6Kt9RH4kavFzmC7P/sQ==
X-Received: by 10.28.215.67 with SMTP id o64mr13163473wmg.159.1521995977238;
        Sun, 25 Mar 2018 09:39:37 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id p21sm1241585wmc.5.2018.03.25.09.39.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Mar 2018 09:39:36 -0700 (PDT)
Date:   Sun, 25 Mar 2018 17:43:00 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Joel Teichroeb <joel@teichroeb.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/4] stash: convert apply to builtin
Message-ID: <20180325164300.GA10909@hank>
References: <20180324173707.17699-1-joel@teichroeb.net>
 <20180324173707.17699-2-joel@teichroeb.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180324173707.17699-2-joel@teichroeb.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/24, Joel Teichroeb wrote:
> ---

Missing sign-off?  I saw it's missing in the other patches as well. 

> [...]
> +static int do_apply_stash(const char *prefix, struct stash_info *info, int index)
> +{
> +	struct merge_options o;
> +	struct object_id c_tree;
> +	struct object_id index_tree;
> +	const struct object_id *bases[1];
> +	int bases_count = 1;
> +	struct commit *result;
> +	int ret;
> +	int has_index = index;
> +
> +	read_cache_preload(NULL);
> +	if (refresh_cache(REFRESH_QUIET))
> +		return -1;
> +
> +	if (write_cache_as_tree(c_tree.hash, 0, NULL) || reset_tree(c_tree, 0, 0))
> +		return error(_("Cannot apply a stash in the middle of a merge"));
> +
> +	if (index) {
> +		if (!oidcmp(&info->b_tree, &info->i_tree) || !oidcmp(&c_tree, &info->i_tree)) {
> +			has_index = 0;
> +		} else {
> +			struct child_process cp = CHILD_PROCESS_INIT;
> +			struct strbuf out = STRBUF_INIT;
> +			struct argv_array args = ARGV_ARRAY_INIT;
> +			cp.git_cmd = 1;
> +			argv_array_pushl(&cp.args, "diff-tree", "--binary", NULL);
> +			argv_array_pushf(&cp.args, "%s^2^..%s^2", sha1_to_hex(info->w_commit.hash), sha1_to_hex(info->w_commit.hash));
> +			if (pipe_command(&cp, NULL, 0, &out, 0, NULL, 0))
> +				return -1;
> +
> +			child_process_init(&cp);
> +			cp.git_cmd = 1;
> +			argv_array_pushl(&cp.args, "apply", "--cached", NULL);
> +			if (pipe_command(&cp, out.buf, out.len, NULL, 0, NULL, 0))
> +				return -1;
> +
> +			strbuf_release(&out);
> +			discard_cache();
> +			read_cache();
> +			if (write_cache_as_tree(index_tree.hash, 0, NULL))
> +				return -1;
> +
> +			argv_array_push(&args, "reset");
> +			cmd_reset(args.argc, args.argv, prefix);
> +		}
> +	}
> +
> +	if (info->has_u) {
> +		struct child_process cp = CHILD_PROCESS_INIT;
> +		struct child_process cp2 = CHILD_PROCESS_INIT;
> +		int res;
> +
> +		cp.git_cmd = 1;
> +		argv_array_push(&cp.args, "read-tree");
> +		argv_array_push(&cp.args, sha1_to_hex(info->u_tree.hash));
> +		argv_array_pushf(&cp.env_array, "GIT_INDEX_FILE=%s", stash_index_path);
> +
> +		cp2.git_cmd = 1;
> +		argv_array_pushl(&cp2.args, "checkout-index", "--all", NULL);
> +		argv_array_pushf(&cp2.env_array, "GIT_INDEX_FILE=%s", stash_index_path);
> +
> +		res = run_command(&cp) || run_command(&cp2);
> +		remove_path(stash_index_path);
> +		if (res)
> +			return error(_("Could not restore untracked files from stash"));

A minor change in behaviour here is that we are removing the temporary
index file unconditionally here, while we would previously only remove
it if both 'read-tree' and 'checkout-index' would succeed.

I don't think that's a bad thing, we probably don't want users to try
and use that index file in any way, and I doubt that's part of anyones
workflow, so I think cleaning it up makes sense.

> +	}
> +
> +	init_merge_options(&o);
> +
> +	o.branch1 = "Updated upstream";
> +	o.branch2 = "Stashed changes";
> +
> +	if (!hashcmp(info->b_tree.hash, c_tree.hash))
> +		o.branch1 = "Version stash was based on";
> +
> +	if (quiet)
> +		o.verbosity = 0;
> +
> +	if (o.verbosity >= 3)
> +		printf_ln(_("Merging %s with %s"), o.branch1, o.branch2);
> +
> +	bases[0] = &info->b_tree;
> +
> +	ret = merge_recursive_generic(&o, &c_tree, &info->w_tree, bases_count, bases, &result);
> +	if (ret != 0) {
> +		struct argv_array args = ARGV_ARRAY_INIT;
> +		argv_array_push(&args, "rerere");
> +		cmd_rerere(args.argc, args.argv, prefix);
> +		if (index)
> +			printf_ln(_("Index was not unstashed."));

Minor nit:  I think the above should be 'fprintf_ln(stderr, ...)' to
match what we currently have.

> +
> +		return ret;
> +	}
> +
> [...]
