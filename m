Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E493586331
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 00:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771978458; cv=none; b=EPNI4GFSp/QkbRCWo1hF7xBcGmvBRKefuyoQ2Lek1eiFPOSKzvJ+rQAImBj4LBkD8Dq9GlEMudRrbeXZ42E+iMJ+B6fXjQiNf022yzvbhB+TD7HvF06FaYcp6XVOEIMUASRB8l2AoGQCRnBNot8YKBQqLhsTA+ymDvIdadnaU+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771978458; c=relaxed/simple;
	bh=GrF/rdCMqkVLv1wDC7I5DV5Yx87B6wsWFES16qBXZIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c7A0Zl41QmRKto7HK7ObmvxofpZnw9kboorA7egOms6nDcKC7iPDfH6aQWPlAWN2Zc6aHxhrBhEo1zf7QYnAVR+eDLR0/6TT0eaee2u/eB3bqyp7dKP2+UDvtzkn3AQiFygrp/ZLyCu8+xHf1jtoFY8OvRco8jfI1V6ppxFMQWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=KItF6QCE; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="KItF6QCE"
Date: Wed, 25 Feb 2026 01:14:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1771978454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HjQ1UOW11XwWgtXRznwi1uvNmYWWrruCbEkVKcjp9aQ=;
	b=KItF6QCEKnNgakyD0FBaayonWbaBnS5ZJJ3Xp9aU/zfI+4PUGBF+1ln1KE9bggtFuwxTNH
	r01dWeU6UUOHx4q3RIev38iIRyFPgCygw/WICFz5gndXu7yy7vx0CBm8KrRD2axukMbNdR
	zsUduwwY6CQIfZJcQ/b3cCxr6EjhCaAQL4QvWK7PXqTKIammsIDGkt/cloowaoTahkj8YL
	fEeGsPYOLKH8pOfW7A4zyyv7xdPGxOkY/xY3Ne62JsBCycSn6EJtWEFr4nVcXT49A9OYD/
	Nr4is3nvzEWJtdLqlSWz3CYFl6KZLyWTE1C4Szm5GP8IPdViDV9N2kjwR8X5rw==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, 
	Mirko Faina <mroik@delayed.space>
Subject: Re: [PATCH v2 2/2] format-patch: add commitListFormat config
Message-ID: <aZ46xqCusF1av-va@exploit>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4439; i=mroik@delayed.space;
 h=from:subject:message-id; bh=GrF/rdCMqkVLv1wDC7I5DV5Yx87B6wsWFES16qBXZIY=;
 b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBpnj7C5QK4jemeUw4D/gvuHuRP0l6i8jxSSE9vi
 ek25uM9gfOJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCaZ4+wgAKCRBIeX6hnBm+
 0U08EACKo+hRUXuIk/Vo6OfT3EqWZTGbEfedru3oViqvYPislIanHKEBSgs+W4fPTeEQ22PuV5V
 h5ki1R/Y85ANH14ko6IYo+evZ1I+pVweeIltA5ZUNjo+JMz3v3XEc7VtY4CG13qlH7yzchyZrvp
 NmP0OxK+jVjR8c0kbLZs7cu6DPKB4nRwyFuTvuugNKvo4/3mnNJhZv48jKcHBeoKYtjpuDlOSpo
 NmSefC+sRgCRwu8qj2epDIFDZhXOPnsoY+6pmcyDLGPW2X8CKQxHflhk4DKjYRDJf+dhyRyZWD1
 W1lk4BuTUjpcPrsnlTvQEECgcK+yOVMeHhLPHTsdsbAi2Rq+0donuUfpA0W1GkXe7jd1cWODSNG
 dOqWilaoZqw6qtcD4szrjgYkx6bLTn9wU+dKlwQZrbTPqOpAsnl/vrMCL0mgHduvckDjJUXFTfa
 ywo3iP7uckHekoDVYtAY+ecEODi98mvvcIG+E+CL2g005laUXm3LxJHTdb06nWJH/VUhNRyXHYu
 ijoy2NNZymJWInopa9gtUPUHl62fm1wfr+u4j9eGrUoreFk9w9oyFA1aYLjgFEval9CsBcKHONk
 b6o6L2KeXqYJ0I51l1KzEnICpIIZmq7boCGvmLovDuWYZFT5d9XYQq6R/8F1W2G3nAk2qXZrCIn
 AhW3k5N0dVp+v1Q==
X-Developer-Key: i=mroik@delayed.space; a=openpgp;
 fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
References: <20260224040400.751247-1-mroik@delayed.space>
 <cover.1771925291.git.mroik@delayed.space>
 <6a0c7aecfd6dc1ee873d5e81110b723fa2d225fb.1771925291.git.mroik@delayed.space>
 <xmqqqzqaggln.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqqzqaggln.fsf@gitster.g>
X-Spamd-Bar: --

On Tue, Feb 24, 2026 at 10:07:48AM -0800, Junio C Hamano wrote:
> In this project, asterisk sticks to the variable, not the type,
> i.e.,
> 
> 	char *fmt_cover_letter_commit_list;
> 
> I think you got this point right in the previous patch.

Yes, that was not intentional, must've been a typo.

> > @@ -1052,6 +1054,19 @@ static int git_format_config(const char *var, const char *value,
> >  		cfg->config_cover_letter = git_config_bool(var, value) ? COVER_ON : COVER_OFF;
> >  		return 0;
> >  	}
> > +	if (!strcmp(var, "format.commitlistformat")) {
> > +		struct strbuf tmp = STRBUF_INIT;
> > +		strbuf_init(&tmp, 0);
> > +		strbuf_addstr(&tmp, "log:");
> > +		if (value)
> > +			strbuf_addstr(&tmp, value);
> > +		else
> > +			strbuf_addstr(&tmp, "%s");
> > +
> > +		git_config_string(&cfg->fmt_cover_letter_commit_list, var, tmp.buf);
> 
> What if /etc/gitconfig has "[format] commitListFormat = shortlog",
> ~/.gitconfig has a different setting, and then .git/config has yet
> another setting?  Woudln't cfg->fmt_cover_letter_commit_list at this
> point have a copy of the value read from the previous configuration
> file?  Without first freeing it, wouldn't we leak the previous value?
> 
>     $ git grep -C2 git_config_string\(
> 
> gives plenty of precedence, like this one.
> 
> builtin/commit.c-	if (!strcmp(k, "commit.cleanup")) {
> builtin/commit.c-		FREE_AND_NULL(cleanup_config);
> builtin/commit.c:		return git_config_string(&cleanup_config, k, v);
> builtin/commit.c-	}
> builtin/commit.c-	if (!strcmp(k, "commit.gpgsign")) {

Will do.

> > +		strbuf_release(&tmp);
> > +		return 0;
> > +	}
> >  	if (!strcmp(var, "format.outputdirectory")) {
> >  		FREE_AND_NULL(cfg->config_output_directory);
> >  		return git_config_string(&cfg->config_output_directory, var, value);
> > @@ -2318,6 +2333,13 @@ int cmd_format_patch(int argc,
> >  		goto done;
> >  	total = list.nr;
> >  
> > +	if (cover_letter_fmt && (strcmp(cover_letter_fmt, "shortlog") && strncmp(cover_letter_fmt, "log:", 4))) {
> 
> Overly long line.

Will fix.

> What if it turns out that the --cover-letter option is not given
> (and we are dealing with a single-patch topic, so auto setting has
> decided that there is no need for cover letter)?  Shouldn't we
> continue ignoring the typo on a setting that we are not going to use
> anyway?

Yes, a check on cover_letter should fix this.

> Stepping back a bit, even if we do not validate the format *here*,
> shouldn't the code that does use cover_letter_fmt later in the
> control flow *already* be checking the validity of the format and
> complaining?  If that happens early enough, perhaps we do not want
> to have an extra "early check and die" here.

That is true, and initially I did not introduce a check here, but
make_cover_letter() is called after the cover letter file has already
been created. Failing before format-patch could create a file or print
anything on screeen seemed more clean to me, that's the only reason
there's a check there.

> By the way, the usual technique used in this codebase when handing
> configuration and command line option is to these in this order:
> 
>  * Initialize a variable to the built-in hardcoded default (e.g.,
>    "shortlog") upon variable declaration.
> 
>  * Let repo_config() call overwrite that same variable.  This is the
>    typical implementation of "if there is no configuration, we use
>    the hardcoded default, but the configured value can override it".
> 
>  * Then parse_options() overwrites that same variable.
> 
> But because we read configuration into a separarte variable (i.e.,
> members of cfg structure), this function cannot literally follow the
> usual pattern.  But the pattern we instead can follow is this:
> 
> 	/* initiailize to NULL */
> 	char *cover_letter_fmt = NULL;
> 
>         /* read configuration */
>         repo_config(... &cfg);
> 
> 	/* cover_letter_fmt will point at command line arg */
> 	parse_options(...);
> 
>         /* NULL if no command line argument */
> 	if (!cover_letter_fmt) {
> 		/* perhaps configuration has one */
>         	cover_letter_fmt = cfg.fmt_cover_letter_commit_list;
> 
>                 /* otherwise, use hardcoded default */
>                 if (!cover_letter_fmt)
>                 	cover_letter_fmt = "shortlog";
> 	}

Will rewrite to follow this config flow.
