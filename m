Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8054AA013
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 16:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791217204; cv=none; b=ecuUm10sq1Vp921b2T3aGbSi92oDaQybYtY++Vqh9DwDXYKjv2AWrc3nfvkoK7BvKcFkwL9Mx9HqjFGS5NhplJnrbUDJTljTPgBFNhDpnKW7SZoQCcCPbnjX+AgWsTfQJ+g08ncXUKGtwWwRfVW3R6124OKBxkdlNjMrpJ9F4Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791217204; c=relaxed/simple;
	bh=sJVW3vPzepPpYsVGmjrCXGNT7u39rz0CRuY0R+1Tb9k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dK8GkbS4bq7d34e11ehSu/KvJAmoV0yxjJr5pnke3822E0LFpnef5SebT2TCyQBeldK5CN6/WC1r96+Qs0BVBlNyoCVKMexXDFUoMVGp8zaPIw+E3DkozM0gfnXeG6WqkQHA7Xhck/4rZW03u/tWEa4Pnk8PKkVljwwCe83K/g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jBDo3C6k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XfQC7PoP; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jBDo3C6k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XfQC7PoP"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 4E218EC08EB
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 12:20:01 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 05 Oct 2026 12:20:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791217201; x=1791303601; bh=xA40CglCR2
	PL6ZrPpdHz8JGmon3A330Tyauioo17K/c=; b=jBDo3C6kTbNvJ3V6Cu48fSWfSz
	+I51OleVZRlI4tAgraY2hVR3dp1AuE5VfxOohJkcDQ9Rl0Wm1NUIVTSOT2XFO/u+
	LCFvgAjOOUaFkZyZ1EiGRalx/T/DFAq7qG3QSiX11QKhtDSIb/Y8LLs5CiDjI7FF
	ikKjo+FDJXT8iyr6mQfm0nR5rJuAHVFwbcT7mpby8R12Y6h6v8ZWwdXlyK1JDTbp
	aXlFXvox3rVfCcgjl3LpC4Oh6ZNJaFfk8W/NWBHP+nuT8jYXwcl6ssEnVbqy1e0a
	Ghj95/x85HyV5M0udnLLk+V1L40BEmuwN2q0FmrYk0F60cs13q3YnRuXJKng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791217201; x=1791303601; bh=xA40CglCR2PL6ZrPpdHz8JGmon3A330Tyau
	ioo17K/c=; b=XfQC7PoPL5q7MqzA7BXIrMPM9yo88auOchR3DQs2aK/NRMZrhoO
	gJQfFthxsfzr+hFSqB1oo35C+8YX1muXgRlmdc3bn034tLoOfi4BDPs3OqlTPZSu
	k3tJMbZDI/SDpaqb/oDXMCJEEV79qUTidXRGFdS/b+6VmYqR68zFmuefnsyLzKj8
	x9oxtNNTTA5gYn1CEsjNf7ygfVOxez02W8tHzx5dHdpbdKCRr0O8ghHLkIJpIuUz
	N3PVti66jqqUH0d4Qx7pzVymcwWm/65MaKGu/d7yB2qdJa9ZJ+BprN1czl05DgsS
	Dhk7uV+gnbaG3/bYmXVS6UBWyh0P1D4a3rA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791217201; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:b8v4q5rVHScGvq867ql1f+EM5DTfWpZ++QTG0e5dopZFZfr
	72xbviZEawnmiibkzhjdIIWC8Q4VY/Chku2/h4m1nCDAny0Uha3wDuXbrgzKZZ2/
	gFEOJJEzLnW44x8Q4TIbMDNqPPo2h0wcuBZGvH1/mJpPC41Zajj3pXHe01vdE5lF
	O7y/CJZ48aoWQ5m+JBe6FIGJ1zTMr7LamhpzBnsd74/zW6wvGVjKqZx8FPZCJWpP
	wSltDgcf3kZmubRLo4xYkwQCf46u8fROBStORXDzodufKR0A+ZaNtoRrWeY8/AoF
	3Hy4hUIpTtDaaXU1X88vWOA/bGZHCFA6qgbriag==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:k5zkaKYnKgea3E9bi449DqmPylVAEQ56J56fA5KaEZw=:sJVW3vPzepPpYsVGmjrCXGNT7u39rz0CRuY0R+1Tb9k=;
X-ME-Sender: <xms:Mc7DamxV4v5YRlXZvQWq1-ll6uHtRQM0TMiQeJe5Lrl3O8ZnXk1KZg>
    <xme:Mc7DapJN2mEN70u5fB9BSK4eOnjqkulBY2zOxlOd-bi4NEx_zttcZIQHCA5w_D3d1
    gw56b6j1tCXz5BnbJwtZ5PZg7wTq6Rd7EvuO0lVhPivcSn9UrL0>
X-ME-Received: <xmr:Mc7DagrGTo34jHfw7BYJhel8xnUTyjSczoTawrSUlcqIeh1VsUBukxmF58uDY-x9QelcsVPO0lBMAGOA_CkAZ9X63H-4XxpdjKau>
X-ME-Proxy-Cause: dmFkZTE8bhLVRGC1Zq3uLr0/Z9cB9A0/60sD/1BVZ8rYMH4nbRqbSWbPLzrhzzSj+7AZ5X
    WS24o0wOPar8V103nB3pr3/ValF53y5eQf/9vgNHhJdV1Vac76wd/r4Wrvgkq9SONFRjkq
    xVMZgyuDoF3PwQsZI2OYDI76IhQp1m+q0H+E8vLYkDAfKBJ+WnZByTuULsorJo0RA600Jz
    HDol0LUXPbBDJhk3BISBdtcuyBjFFQQuRVGxkzNk9Cq/k/5KevelgBOoq4I6IPZ+bxMELf
    tW2srt4sswtitl79aPe/gG4liohIv/glvYewUMligmEWpgIs2cK6JbCkA0bz98b0YNSAeW
    7lfrbD0S0AvVhi7EfyNK6mYaehvVyRdNKcT7FX3ls6Nb0L4NrAWuaBTJF6Vlej8nG1NBvD
    qooVl8mkk5xg/9XOqYrB9Vm4RjRovqFWr9cQDe3HXWwQ1ztOR7TG5dqrR2tyhuAzBSNHE7
    xPyiGHloQfkw4cW65LtWxkeuJENGu2hpzzcGyTm+Q0c15DeJxqzGsf4jYkiQzpLU3wZDqa
    4f6OQthMjKCbCBPveV/1kQ2+H3HXHCiwTFMAN3r+ArMbFtX0VpbeAzgxiH40cTRlQ2w28N
    b9DneQpmlZd2FlFUsquX4TtSFBYzBTNrFza2YvgA2dI9yuoEuW/ROiF1liow
X-ME-Proxy: <xmx:Mc7DaoJ4ULNEK8IRM0egZIQlX8dUvDlCiK1E9bl-o3uPgiT4OR0GCA>
    <xmx:Mc7DalTYda5ELwX0ou-QF86D8DZgOsdWuczrTL0gfGOulhoqcIl1bA>
    <xmx:Mc7Danvt9HHBceJmR9fbatko-UEmtfrNeqgvBO8HX1IAuChrGWjCrw>
    <xmx:Mc7DambnQoDPvzomsIyOgLx7WyLQkCeo47-QVCN3HIGqhpUXerlIpw>
    <xmx:Mc7DaobuNyDf9XVnArz-VNBx9he5AABCqat-YGRSPVGv55ZzqLlRUhHk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Oct 2026 12:20:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Johannes Sixt
 <j6t@kdbg.org>
Subject: Re: [PATCH v2 2/2] merge: remember conflict labels
In-Reply-To: <18bdf7df49dde2c8e7f73f3b46c656abb6b26293.1791206658.git.phillip.wood@dunelm.org.uk>
	(Phillip Wood's message of "Mon, 5 Oct 2026 14:24:49 +0100")
References: <cover.1790761727.git.phillip.wood@dunelm.org.uk>
	<cover.1791206658.git.phillip.wood@dunelm.org.uk>
	<18bdf7df49dde2c8e7f73f3b46c656abb6b26293.1791206658.git.phillip.wood@dunelm.org.uk>
Date: Mon, 05 Oct 2026 09:19:59 -0700
Message-ID: <xmqqld8cktlc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> @@ -128,6 +128,7 @@ int validate_branchname(const char *name, struct strbuf *ref);
>  int validate_new_branchname(const char *name, struct strbuf *ref, int force);
>  
>  #define REMOVE_BRANCH_STATE_VERBOSE (1u << 0)
> +#define REMOVE_BRANCH_STATE_PRESERVE_CONFLICT_LABELS (1u << 1)

Not complaining and I have no improvement suggestions, but this
phrasing made me imagine that we would be passing this flag bit
in code paths where we want to write the extra file out.

But that does not match the reality.  merge_switch_to_result() calls
write_merge_labels() unconditionally.  The bit controls if the file
written survives the clean-up after the operation.

> @@ -946,7 +957,8 @@ static void report_tracking(struct branch_info *new_branch_info)
>  
>  static void update_refs_for_switch(const struct checkout_opts *opts,
>  				   struct branch_info *old_branch_info,
> -				   struct branch_info *new_branch_info)
> +				   struct branch_info *new_branch_info,
> +				   bool merge_conflicts)
>  {
>  	struct strbuf msg = STRBUF_INIT;
>  	const char *old_desc, *reflog_msg;
> @@ -1048,6 +1060,8 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
>  	}
>  	if (!opts->quiet)
>  		flags |= REMOVE_BRANCH_STATE_VERBOSE;
> +	if (merge_conflicts)
> +		flags |= REMOVE_BRANCH_STATE_PRESERVE_CONFLICT_LABELS;

OK.

>  	remove_branch_state(the_repository, flags);
>  	strbuf_release(&msg);
>  	if (!opts->quiet &&
> @@ -1262,7 +1276,9 @@ static int switch_branches(const struct checkout_opts *opts,
>  
>  	if (autostash_res == STASH_APPLY_CONFLICT && !opts->quiet)
>  		fputc('\n', stderr);
> -	update_refs_for_switch(opts, &old_branch_info, new_branch_info);
> +
> +	update_refs_for_switch(opts, &old_branch_info, new_branch_info,
> +			       autostash_res == STASH_APPLY_CONFLICT);

OK, so here we assume STASH_APPLY_CONFLICT result means we called
write_merge_labels() and left the file.  If not, we did not call it
and the file should not be there.

But then can't we just unconditionally leave the file, instead of
not removing what we wouldn't have created?

> diff --git a/builtin/commit.c b/builtin/commit.c
> index 205fbd57e3..c374d5e0d5 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1977,6 +1977,7 @@ int cmd_commit(int argc,
>  
>  	sequencer_post_commit_cleanup(the_repository, 0);
>  	unlink(git_path_merge_head(the_repository));
> +	unlink(git_path_merge_labels(the_repository));
>  	unlink(git_path_merge_msg(the_repository));
>  	unlink(git_path_merge_mode(the_repository));
>  	unlink(git_path_squash_msg(the_repository));

Here we clean it up unconditionally after we are about to
successfully finish "git commit".

> @@ -4969,6 +4973,13 @@ void merge_switch_to_result(struct merge_options *opt,
>  			return;
>  		}
>  		trace2_region_leave("merge", "write_auto_merge", opt->repo);
> +
> +		trace2_region_enter("merge", "write_merge_labels", opt->repo);
> +		opt->priv = result->priv;
> +		write_merge_labels(opt->repo, opt->priv->labels[0], opt->priv->labels[1],
> +				   opt->priv->labels[2]);
> +		opt->priv = NULL;
> +		trace2_region_leave("merge", "write_merge_labels", opt->repo);
>  	}
>  	if (display_update_msgs)
>  		merge_display_update_messages(opt, /* detailed */ 0, result);


> @@ -5234,6 +5245,14 @@ static void move_opt_priv_to_result_priv(struct merge_options *opt,
>  	 * to move it.
>  	 */
>  	assert(opt->priv && !result->priv);
> +	if (!result->clean) {
> +		opt->priv->labels[0] =
> +			mem_pool_strdup(&opt->priv->pool, opt->ancestor);
> +		opt->priv->labels[1] =
> +			mem_pool_strdup(&opt->priv->pool, opt->branch1);
> +		opt->priv->labels[2] =
> +			mem_pool_strdup(&opt->priv->pool, opt->branch2);
> +	}

OK, merge_switch_to_result() is the only thing that consumes these,
and it will never happen after we call merge_finalize() where we
destroy the mempool, so this allocation should be safe.

> +static char *parse_merge_label_line(struct strbuf *buf, FILE *fp)
> +{
> +	if (strbuf_getline(buf, fp) == EOF)
> +		return NULL;
> +
> +	return xmemdupz(buf->buf, buf->len);
> +}

Wouldn't strbuf_detach() be more intuitive?

> +int read_merge_labels(struct repository *r,
> +		      char **pbase, char** pours, char** ptheirs)

Be consistent.  Asterisk sticks to variables, not types.

> +{
> +	struct strbuf buf = STRBUF_INIT;
> +	char *base = NULL, *ours = NULL, *theirs = NULL;
> +	int ret = -1;
> +	FILE *fp = fopen(git_path_merge_labels(r), "r");
> +
> +	if (!fp)
> +		return -1;
> +
> +	base = parse_merge_label_line(&buf, fp);
> +	if (!base)
> +		goto out;
> +
> +	ours = parse_merge_label_line(&buf, fp);
> +	if (!ours)
> +		goto out;
> +
> +	theirs = parse_merge_label_line(&buf, fp);
> +	if (!theirs)
> +		goto out;

The repetitions are a bit annoying, but it does not get much better:

	int i;
	char bot[3] = {0}; /* base, ours, theirs */

	for (i = 0; i < ARRAY_SIZE(bot); i++)
        	if (!(bot[i] = parse_merge_label_line(&buf, fp)))
			goto out;

so I am OK with what was posted.

It may be helpful to future developers to leave a comment that we
deliberately ignore cruft after these three lines in the file and
why, instead of diagnosing it as an error.

> +	ret = 0;
> +	*pbase = base;
> +	*pours = ours;
> +	*ptheirs = theirs;
> +out:
> +	if (ret) {
> +		free(base);
> +		free(ours);
> +		free(theirs);
> +	}
> +	fclose(fp);
> +	strbuf_release(&buf);
> +
> +	return ret;
> +}
