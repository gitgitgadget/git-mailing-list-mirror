Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD34235348
	for <git@vger.kernel.org>; Wed, 21 May 2025 08:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747816052; cv=none; b=QJYcrOI1eHIEVx7nn1rUHQulAjKpu347X4eP2HDcefD1cM9vsiQsmNULlnoMuM9140COpSeuP9Be58lObd3hNlSNLIyPGesoYr5FZocA8bhE7lyYTWX31yNqJ8h19Y0gtALxAfBb7dxQo+NBywRRmG3NdwLY9PdJL8PU5g0K04g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747816052; c=relaxed/simple;
	bh=1QRJScSIT5pGI9T+zNIJ7NBaS8BxfmsPklxYKIVoVGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PmZl3tD6TXhpC4fTlUzaVbFMhD3EKW9uHtPoOyZbDnEvPA0gO+9PZTgKEhrhiX0BF7rvTx5eeLfNc+BkJIhk8yiHWzP/0FVjfxJerIj3xzvqO3PLf3om8NrplfebCzlf4WBEV2ZVxq1R0ATObEi49BA+5H/PruZs8U5V6pcKf0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PervypCZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RVkoJ2NJ; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PervypCZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RVkoJ2NJ"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3BEDD114016C;
	Wed, 21 May 2025 04:27:29 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 21 May 2025 04:27:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1747816049; x=1747902449; bh=y6KgSY/GEG
	QNYLDev5BEh/XjLIz/wHAKf6PfO5ghsE8=; b=PervypCZrkm1eZpHLtnvcPlUqn
	bUxbSkvrEu2cFNmgdYrB8i+DyWaYqZ5X4nVge2GgIGmti3fzxd/Yut73oYqP9W68
	5X3Hpr+ZjqEMKo5ty98k9KpPc9yrwjzdK4x2aEoIlahXkF6BOPpRMr91Bwh3T7yG
	K6xAGQoBeOkmfgoF/IzkCSAZKFbn1z9KwrCY9mlLsp/UV81ZW/3C3HEkzSg33UOL
	mckqduhqWjnhD3riEJSZppBPHmv4J6oPBV3YD721Mil3GQGNTl5jS11vms2tZb1Z
	MUiWiQrn/iHGAicrpVd2IwhkxEqhvZq6hZvi342653YYrR3G7hdesWdG+sUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747816049; x=1747902449; bh=y6KgSY/GEGQNYLDev5BEh/XjLIz/wHAKf6P
	fO5ghsE8=; b=RVkoJ2NJ4g8Hfk7m9AMrBfUB8K7Wdcge91oZ0vzNtDs/gysgmD+
	SWkFunbMUmsrU806hVEuypTHJWl87yrfL9zX15/BcZVgMmiIvOnwIkX4b4Htn3NR
	fJGmTJOfOYVcF+02Yy3KPKiMFVUWz2A1Fba1C7fTf2kuIANzQaZb2Mr3clzCgG21
	AFdne4UzF6OjunsGSNvJig0MoehIGGL56KvaQqqQGzY+l8sRVDTfpYVdIw3y4wrF
	TQSHS7QdY5lrLJiRgW5T4A4+KELCWR2A7f8s87k448bB5xz3SHB+VlXe65kVfr1X
	nXmGuQY9OiaR2IPrWAZHnRbZNm/1J6I11JA==
X-ME-Sender: <xms:cY4taMg7yU4Fwg8JUYrIy1GTyEjyxoXU0fOvVrWP77tNvDA1M_I_6Q>
    <xme:cY4taFBAuitzC9DEsmziDVYUbNNIjwX0tTzfPAdXReywfJ6lp3XUIcDNubTRXzdz4
    9HX3pMiVlKp8RkTxg>
X-ME-Received: <xmr:cY4taEGaNZU-aGjRNaIEtF0TmaRXsfJ70slFvFwAzR-TOqWTnnpRpg2YkOIoMT6aMqiycdO9mXBgIFwIN3NQ9SGG_3JmL3lJkvNHm5pELJKoeg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvheelucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhgg
    tggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrug
    htuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepvdefiedvvedtiefgtddt
    teeggfffheevueegueekffeluefgleffffdvteekhefhnecuffhomhgrihhnpehpuhgslh
    hitgdqihhnsghogidrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhr
    tghpthhtoheprghvrghrrggssehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkh
    hnohgslhgvodhgihhthhhusgesghhmrghilhdrtghomhdprhgtphhtthhopehjohhhrghn
    nhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:cY4taNR_OIfP-DyqDZ-amPEepecAHNvZDYOtUAil6JKx1AhH3WRb7A>
    <xmx:cY4taJypmkF9wXpSXjM9Jj6Ax3Y0Yr0Djt87rSwkaaIEP_Y-wFcrAg>
    <xmx:cY4taL778geAZCmkVGtGHHtJL_9w0txHUgqiwODQj4kK-CuXL5DKHQ>
    <xmx:cY4taGx1Z_pQtPx9iYNZnwFK60Rdf7Q7bKsF7cFegjcu_CL90nR3EQ>
    <xmx:cY4taI2k64YYyo09fHJj-amY9hoei_vlf6OZMr3SV_ny5MXQKPr5NKw4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 May 2025 04:27:28 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4bb1a74e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 21 May 2025 08:27:26 +0000 (UTC)
Date: Wed, 21 May 2025 10:27:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 4/4] drop git_exec_path() from non-Git commands' PATH
Message-ID: <aC2OaeLYJQAOE_S1@pks.im>
References: <20250520193506.95199-1-ben.knoble+github@gmail.com>
 <20250520193506.95199-5-ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520193506.95199-5-ben.knoble+github@gmail.com>

On Tue, May 20, 2025 at 03:34:58PM -0400, D. Ben Knoble wrote:
> We setup_path() with git_exec_path() unconditionally (8e3462837b (Modify
> setup_path() to only add git_exec_path() to PATH, 2009-01-18)) when Git
> starts; as a result, all child processes see Git's exec-path when run,
> including editors and other programs that don't need it [1]. This can
> cause confusion for such programs or shells, especially when they rely
> on finding "git" in PATH to locate other nearby directories, in a
> similar vein as a0b4507ef7 (stop putting argv[0] dirname at front of
> PATH, 2015-04-22) solved.
> 
> Since we only need this for finding git-* subprocesses, drop it from
> child processes that aren't Git commands.

I agree with what Junio mentioned in a parallel thread, especially
around Git hooks. The expectation there is that those may execute other
Git commands, and that should typically be using the same execution
environment as the original Git command that has been invoking the hook.
So refining this patch so that the mechanism is opt-in probably makes
sense.

    A slight tangent: I wonder whether it is even required nowadays to
    adapt PATH at all anymore. As far as I understand this was a
    requirement back when people still executed dashed binaries
    directly. But nowadays scripts don't really do that anymore, but
    instead use the git binary. And that one doesn't need PATH to be
    adapted at all, as it knows to listen to GIT_EXEC_PATH and its
    built-in path anyway.

    So I have to wonder whether this is something that we can deprecate
    to finalize the migration away from dashed builtins. There probably
    are edge cases though. Shell scripts for example still execute ".
    git-sh-setup", which I think relies on PATH to resolve the script's
    location.

    In any case, this is of course outside of the scope of this patch
    series.

> [1]: https://public-inbox.org/git/CALnO6CDtGRRav8zK2GKi1oHTZWrHFTxZNmnOWu64-ab+oY3_Lw@mail.gmail.com/
> 
> Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
> Suggested-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Same comment regarding the order of trailers.

> diff --git a/run-command.c b/run-command.c
> index dee6ae3e62..8a8b5c8455 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -448,11 +448,51 @@ static int prepare_cmd(struct strvec *out, const struct child_process *cmd)
>  	return 0;
>  }
>  
> -static char **prep_childenv(const char *const *deltaenv)
> +static void remove_git_exec_path(struct string_list_item *path_item) {

Style: the curly brace should be on its own line.

> +	struct strbuf buf = STRBUF_INIT;
> +	const char *exec_path = git_exec_path();
> +	size_t exec_len = strlen(exec_path);
> +	char *b, *p;
> +
> +	/* Value comes from environ; we should not modify it directly. But
> +	 * strbuf copies data, so we now have our own playground. */

Style:

    /*
     * Multi-line comments should be written like this, with their
     * opening and closing parts on their own lines.
     */

> +	strbuf_addstr(&buf, (const char *)path_item->util);
> +
> +	/* skip past "PATH=" to start search */
> +	p = strchr(buf.buf, '=');
> +	if (!p || !*(p + 1))
> +		return;
> +	b = p + 1;

You could use `if (!skip_prefix(buf.buf, "PATH=", &p))` instead.

> +
> +	for (p = strstr(b, exec_path); p; p = strstr(p, exec_path)) {
> +		if ((p[exec_len] && p[exec_len] != PATH_SEP) || (p != b && p[-1] != PATH_SEP))
> +			p += exec_len; /* false positive, skip */
> +		else {
> +			size_t offset = p - buf.buf, delete_len = exec_len;
> +			if (p != b) {
> +				/* include the preceding path separator */
> +				offset--;
> +				delete_len++;
> +			} else if (p[exec_len] == PATH_SEP) {
> +				/* include the path separator following GIT_EXEC_PATH */
> +				delete_len++;
> +			}
> +			strbuf_splice(&buf, offset, delete_len, "", 0);
> +		}
> +	}
> +
> +	/* Overwrite PATH value with new (owned) data. This leaks memory because
> +	 * the only future owner is a char** childenv, which is freed, but whose
> +	 * contents are not (because most of them come from environ). */
> +	path_item->util = (void *)strbuf_detach(&buf, NULL);

Same comment here regarding style of the comment.

Regarding the memory leak... you could probably track allocations in a
separate array and free them via that array. Another alternative would
be to just copy the whole environment in case we need to modify it. I
doubt that the performance hit would matter given that the cost to spawn
the new process is likely to significantly outweigh the additional
memory allocations.

Patrick
