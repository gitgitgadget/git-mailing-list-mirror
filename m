Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F01D372EC5
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 12:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781873751; cv=none; b=gT/SDn8VyIfgk4gkvfCDfKaSSmqVSRrV9DABa4vQnHm0ewud2jBbimD9RZ26bpCTndO3bnLTr/DWWXggOcGohXE1gVKsIBVz51u1Twk7ApEG6ADyWtqyreBGRqy6Lr2Q/En5hDi6Jus0d64MvRzMPZxkB6pPChXDvX0K+FApA8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781873751; c=relaxed/simple;
	bh=++QQHfXo87KSVIuivc6JhlLgWBTKgfbHoGx0P9EJCvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ja9ACMQBNIWV2OVnyhus3MmnreFLZqBCfQV4zAj9kmFvQbJdBBQMM1iXj2kbPyyBemtzb2jCUFvHIWE3zpqbeBFu6fokdv47mlvz5126oBpTAIPr9MyfPsppTysskFJZQmrtf7Huu6O95fVFODY0VGEbqhscF1hvwGhZ5JhrYDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TwhuJc19; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WrGO7Suw; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TwhuJc19";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WrGO7Suw"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 74D8B1D00091;
	Fri, 19 Jun 2026 08:55:49 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 19 Jun 2026 08:55:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1781873749; x=1781960149; bh=5Ft/LwGwGR
	TckJ92SNspvUvxCMiA5h/OqCC2glbF3kM=; b=TwhuJc19BI4mNnV0s5bOrgsumu
	4MFeizgOLvn4s0fZ4Q/FVixxgtMJLl5wExBhVQkIn0efETvTOmWglDfTxXDihivk
	giaEK6G42Fk3yrtxdUbd3LdlYsxHmhOPfzymfvzbuZONf43/I+D4bL8z/Jcjpf+i
	FsLJ2Q6cdj+Dcc2ArOjGAId1iRk7q3K6lAhl9WE5FQWUuQs0ABhTmPTIzGxdA8Qw
	IDyeO2d+2SRjIjHMdhy8vV9DAWxi4aTfpyqD6/OVXOpYDup5UzHqihcj4Polhw+0
	WRfPqdrqOJGpkQKY5K/JIEqZUxlzl0N466IYW9a8W4ymORKLt6Sw5yGQWc+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781873749; x=1781960149; bh=5Ft/LwGwGRTckJ92SNspvUvxCMiA5h/OqCC
	2glbF3kM=; b=WrGO7Suw9EX0e0ST7kdevzapJqTVpYm/2whl8QYV71jvE9e3hKG
	emPo4SVRg9bkz/MzCcoWBqnUbhIvEmtGpoV+e78Xq9h6qg7zjaM8WIirszNt7rVS
	2M4KV5holGhviWUS4WBZyErzQIs0W6yJb+WXgf4Kht99trbbzIFKbHSxXyn6XSEQ
	c5OFWj0tqwHlz4fH13IuiWCuTOXX8okq7ylCZFn28vcU2lqFl2de0lX7szZ0KuOd
	GDtsq/DhMBmkWv6+Lls/JcWXaYqoCU06khj1Syv2gBTGrrZAxHFxm6gCe9nT1Baa
	r3ze051cBqYyM8LxB0MBdjiJMPEHKhaiBfg==
X-ME-Sender: <xms:VTw1auJ3ertuknssWd1P8h1a0fcd7GYwDhHQDMHizOV383dg8gjXrg>
    <xme:VTw1atkOBA3zof9pZ-o3Xbda-dRL1kMk0fVAsmETWZSgrozqJsMl4t7a8ixJrKorN
    o4JmaHkpVt0P2DZxbhVh41adBGACkW-ZJSEGPcd7_RLPVu7EwOnRqM>
X-ME-Received: <xmr:VTw1asFQm0LdFPC67izE00aeXiqXKimSaZ2jYisBL_bVKzt95nwvp52vjWPx5h3NRaG6bV5gxx8xs5yr5_boMiQCpm_qCo5VPp7DKQJNBZM>
X-ME-Proxy-Cause: dmFkZTEWZ2zi8aAtyCihksvc3dLVZsfYgap2WQ0FKQv6BmQZEjpZDM9Rq9QNw3hv8Mp6BM
    0U3IpIED6upoczLgV+FtlGdNdxLgRPKyroyxhbBaK/7rD34cjkhKX2MGE/6gFYgO7udt0P
    /OoBw6qe17Kxcg+CmhAg/Ns/9n29JI7asmlXpKcXhC9RWM+fsz6vEQkPC2T3noQbg+S2LH
    95UHtL/76J0vfUHblNd/r9Q5k+YHP80APw7ZDzl/IV2jTVFBHyw2VgamfUhhZCpv76uViX
    8zqPLdZAUiaN4PcjTa0mOBYg+SGOzGtaPFwMwI5XWiZ3q598dQSF3CGDz1MpWqDcZw5gcF
    sIJF1pdWqcm4vBHySJ2Jii46DCTO/TvPkJWFSynLTNO8DLVdSoVeTMDcNKwGiK0CxORDRN
    6g7A2WFQ8zyqpNWJsubNZSjGGG4kLOd7TMn4NUJw99pTxzUHT+ImB/w/0SzePmD7+bjk9S
    f1P4o8JSp2PEGI5hyo5sddxbtugw1lTxHsYjsVpjXitwPxEn1qg4L+QsCkw4ez3dHvaDB8
    5V3MuNwMqVkCQb2HtngoNwPQVHH62fZu2JOq5Ji3V0J4VK1PSFcpVOrzvHCn9MvU2TH7MI
    NQv6WYKNoTwjUNyB4UM5QoxgPD5A5p0v2ikuB+SZ60XUzSANsV4VJrrDrmeg
X-ME-Proxy: <xmx:VTw1atFLZZ8ixeCSQR7xZPWwHGgYOvHKCIzEX4Fl0my6nHjU_ym04Q>
    <xmx:VTw1apOJTG3tVEZPdTbRQQp_N0gWvafjszzN7RRn1SnrhWwail6CRw>
    <xmx:VTw1asEmRqWaxj-ZIDcKi-PufD5ujpOOLNFPdFEdZVA47AkiMLLvQg>
    <xmx:VTw1agPwbusYHUGFCQi6uMyfW-Gd8naCOdDlzZbUtX689uwnz288gg>
    <xmx:VTw1arBst0xg_jYPVsYmSCk8TLxgihNelRPphJ-9vOQgHFVVkj7MLAvz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Jun 2026 08:55:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a96a70f7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 19 Jun 2026 12:55:46 +0000 (UTC)
Date: Fri, 19 Jun 2026 14:55:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v3 3/4] history: add squash subcommand to fold a range
Message-ID: <ajU8T2JFJTdk1hr2@pks.im>
References: <pull.2337.v2.git.git.1781512625.gitgitgadget@gmail.com>
 <pull.2337.v3.git.git.1781810226.gitgitgadget@gmail.com>
 <66b2f49fb427c7328136b2d440dc7461b97fb4e0.1781810227.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66b2f49fb427c7328136b2d440dc7461b97fb4e0.1781810227.git.gitgitgadget@gmail.com>

On Thu, Jun 18, 2026 at 07:17:05PM +0000, Harald Nordgren via GitGitGadget wrote:
> diff --git a/builtin/history.c b/builtin/history.c
> index 305bde3102..9d9416870f 100644
> --- a/builtin/history.c
> +++ b/builtin/history.c
> @@ -973,6 +975,156 @@ out:
>  	return ret;
>  }
>  
> +/*
> + * Resolve a "<base>..<tip>" revision range into the base commit just outside
> + * the range (which becomes the parent of the squashed commit), the oldest
> + * commit contained in the range (whose message the squash reuses), and the
> + * range tip (whose tree becomes the result). A merge inside the range is fine,
> + * but the range must have a single base and must not reach a root commit.
> + */
> +static int resolve_squash_range(struct repository *repo,
> +				const char *range,
> +				struct commit **base_out,
> +				struct commit **oldest_out,
> +				struct commit **tip_out)
> +{
> +	struct rev_info revs;
> +	struct commit *commit, *base = NULL, *oldest = NULL, *tip = NULL;
> +	struct strvec args = STRVEC_INIT;
> +	int ret;
> +
> +	repo_init_revisions(repo, &revs, NULL);
> +	strvec_push(&args, "ignored");
> +	strvec_push(&args, "--reverse");
> +	strvec_push(&args, "--topo-order");
> +	strvec_push(&args, "--boundary");
> +	strvec_push(&args, range);

We don't have any kind of input verification for "range". So in theory,
the user could pass whatever string here, and this may or may not work.

Also, should we use "--ancestry-path" with the first commit of the range
here? Otherwise we may incldue commits that aren't descendants of A in a
range "A..B". If not I wonder whether we might see multiple boundaries
even though we would be able to resolve the boundary unambiguously in
some cases.

> +	setup_revisions_from_strvec(&args, &revs, NULL);
> +	if (args.nr != 1) {
> +		ret = error(_("'%s' does not name a revision range"), range);
> +		goto out;
> +	}
> +
> +	if (prepare_revision_walk(&revs) < 0) {
> +		ret = error(_("error preparing revisions"));
> +		goto out;
> +	}
> +
> +	while ((commit = get_revision(&revs))) {
> +		if (commit->object.flags & BOUNDARY) {
> +			if (base) {
> +				ret = error(_("range '%s' has more than one base; "
> +					      "cannot squash"), range);
> +				goto out;
> +			}
> +			base = commit;
> +			continue;
> +		}
> +		if (!oldest)
> +			oldest = commit;
> +		tip = commit;
> +	}

Hmm. I really wonder whether we should also restrict merges. It might be
somewhat obvious that intermediate merge commits should just be
discarded. But is that equally obvious for HEAD and the base commit?

> +	if (!oldest) {
> +		ret = error(_("the range '%s' is empty"), range);
> +		goto out;
> +	}
> +
> +	if (!base) {
> +		ret = error(_("cannot squash the root commit"));
> +		goto out;
> +	}

In theory we can by squashing onto an empty tree. But it's fine to not
care about this edge case, we can still address it at a later point in
time if we ever feel the need to.

> +	*base_out = base;
> +	*oldest_out = oldest;
> +	*tip_out = tip;
> +	ret = 0;
> +
> +out:
> +	reset_revision_walk();
> +	release_revisions(&revs);
> +	strvec_clear(&args);
> +	return ret;
> +}
> +
> +static int cmd_history_squash(int argc,
> +			      const char **argv,
> +			      const char *prefix,
> +			      struct repository *repo)
> +{
> +	const char * const usage[] = {
> +		GIT_HISTORY_SQUASH_USAGE,
> +		NULL,
> +	};
> +	enum ref_action action = REF_ACTION_DEFAULT;
> +	enum commit_tree_flags flags = 0;
> +	int dry_run = 0;
> +	struct option options[] = {
> +		OPT_CALLBACK_F(0, "update-refs", &action, "(branches|head)",
> +			       N_("control which refs should be updated"),
> +			       PARSE_OPT_NONEG, parse_ref_action),
> +		OPT_BOOL('n', "dry-run", &dry_run,
> +			 N_("perform a dry-run without updating any refs")),
> +		OPT_BIT(0, "reedit-message", &flags,
> +			N_("open an editor to modify the commit message"),
> +			COMMIT_TREE_EDIT_MESSAGE),
> +		OPT_END(),
> +	};
> +	struct strbuf reflog_msg = STRBUF_INIT;
> +	struct commit *base, *oldest, *tip, *rewritten;
> +	const struct object_id *base_tree_oid, *tip_tree_oid;
> +	struct commit_list *parents = NULL;
> +	struct rev_info revs = { 0 };
> +	int ret;
> +
> +	argc = parse_options(argc, argv, prefix, options, usage, 0);
> +	if (argc != 1) {
> +		ret = error(_("command expects a single revision range"));
> +		goto out;
> +	}
> +	repo_config(repo, git_default_config, NULL);
> +
> +	if (action == REF_ACTION_DEFAULT)
> +		action = REF_ACTION_BRANCHES;
> +
> +	ret = resolve_squash_range(repo, argv[0], &base, &oldest, &tip);
> +	if (ret < 0)
> +		goto out;
> +
> +	ret = setup_revwalk(repo, action, tip, &revs);
> +	if (ret < 0)
> +		goto out;

Oh, you already use `setup_revwalk()` here. Wouldn't that keep us from
accepting merge commits?

Patrick
