Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD7C1DCB2D
	for <git@vger.kernel.org>; Tue, 29 Oct 2024 18:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730227332; cv=none; b=lk7huAW+gmIGJuNCvSTwbutj7ke1UTIFpqkz8i/839U13UR4waJWZyCmOFQdMVoqw37mJTLRQR2CzlYlPTjx+qB2YUymb/V5JwGTi3cnECJVmXH65hoEbJKbfqAQhchf7OSLlaJL3Kewyi6eLjwUFSBFr5LXTYJXhbXJB0uFh8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730227332; c=relaxed/simple;
	bh=GIPV8dEVzo4NnOaMN8M3zcjP7+D8yq+DqHThEQmHX4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dDUCeRBTLc9kH+7ThRRGhW6mVrmTZLwmH7vJQpC+4pAPt+mAPtDQJIErwXEwAX5rp5DzIRSUZ2pSZpMdc7DrGJ8JKFzWNaFe/h7KdJH7MLDtdOFx++sPS82vYNhl0L/AMADSlpz0NE8F6pVH9rUP2IB08FqzHSivhKDi+opKnOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=L1C7sXwa; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="L1C7sXwa"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6e9f8dec3daso21433797b3.0
        for <git@vger.kernel.org>; Tue, 29 Oct 2024 11:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730227329; x=1730832129; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/p6UefEvVoSxQI/Oz0w+RsRpFSij2MdzbZxFW75Kj2o=;
        b=L1C7sXwaBBNO179ljpOUUtXTTNA5Qi5tCibStL6MZX39yp+tXSQ/Lw5uyaCuj+FjXL
         Omsfer9gzyIH7xgEUISC3nfrd4Rlel29PrZqnL34ZVmZX2uRQZil2mXdT1/mz09snoea
         bFhEPZYOpuuOHoQhMmqbNGF1zjTkGinSUhzgeisXjMDrS2NNnDaq6qRUh59RW7eC4S9K
         X8+1PM629D3lwCga2c2mJnE9kK9dSVyQYUQCWkZzeYsaE/5owr5goEjMyZBFS/ttWKhv
         5kZXdSn0egxQtlVuq3y51SrUxm/i9tknUMgmeUyM1N/Gz+voaY6fFBWRio+uzd+8G7kw
         XY/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730227329; x=1730832129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/p6UefEvVoSxQI/Oz0w+RsRpFSij2MdzbZxFW75Kj2o=;
        b=eSqfJryMJlOqtMqzP1QBu2h60mlBG4ID7kZ2A49VaXaj0MWZEjO3Bbl/jY4n8PEwxx
         LY8UxvknBxzDWJJF8hGwJMo9l5PIaAbLsmWlR7YQVnBacidEaQFzHNeXKYNv77MJdcTV
         dzZpZ0qu3MJiX4opveO2BRK+ba0WxMG3H/N3SSD+HsxDV85y0GFXoGhnjUUtsnaLY+Py
         IWHQgN35W6mloSVegUJqUYkZW0RcXJn5z83ivdQk1qlacf16r/sPRLnYwaidybDWn8jD
         z9qASp2KkTjwkijqZCN5qmzBS+MDQ181VzuNnxbCgLFE3eMlrSr155vYe3jw7YFWg64e
         s/1Q==
X-Gm-Message-State: AOJu0Yx5wRRjY3mSRx6K6ON9KcDdL3QGO4dAP4Q+ip6ToX/zAcNhE8j5
	TUQwQIJIl8EczwUySTSyd3P3l9H9ZTeTkscOOd4uMD0GyBHoWfpd/M/P48F7d4Y=
X-Google-Smtp-Source: AGHT+IG9Vg2QCmfC2U1cLZTFtNBJ5cQUmiESQPoK6vhrpLLtYfJRGCUhXX96G09yDqv/CrBkp1THvA==
X-Received: by 2002:a05:690c:45c7:b0:6e3:2508:43ca with SMTP id 00721157ae682-6e9d899cf9cmr124608837b3.27.1730227328851;
        Tue, 29 Oct 2024 11:42:08 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e9c6c77310sm20844287b3.82.2024.10.29.11.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 11:42:08 -0700 (PDT)
Date: Tue, 29 Oct 2024 14:42:06 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/5] worktree: add CLI/config options for relative
 path linking
Message-ID: <ZyEsfpcnAGCg+W6N@nand.local>
References: <20241028-wt_relative_options-v2-0-33a5021bd7bb@pm.me>
 <20241028-wt_relative_options-v2-1-33a5021bd7bb@pm.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241028-wt_relative_options-v2-1-33a5021bd7bb@pm.me>

On Mon, Oct 28, 2024 at 07:09:37PM +0000, Caleb White wrote:
> This patch introduces the `--[no-]relative-paths` CLI option for
> `git worktree {add, move, repair}` commands, as well as the
> `worktree.useRelativePaths` configuration setting. When enabled,
> these options allow worktrees to be linked using relative paths,
> enhancing portability across environments where absolute paths
> may differ (e.g., containerized setups, shared network drives).
> Git still creates absolute paths by default, but these options allow
> users to opt-in to relative paths if desired.
>
> Using the `--relative-paths` option with `worktree {move, repair}`
> will convert absolute paths to relative ones, while `--no-relative-paths`
> does the reverse. For cases where users want consistency in path
> handling, the config option `worktree.useRelativePaths` provides
> a persistent setting.

This is great. This addresses the main concerns that you and I discussed
in the earlier round of this series, which was making sure that the new
behavior be opt-in, as it breaks backwards compatibility and thus
requires a new extension to quarantine older Git versions from touching
repositories that list their worktrees out with relative paths.

This approach makes the most sense to me because it doesn't impose such
a breakage between Git versions when the user doesn't explicitly opt-in
to the new behavior, which is the right approach to take here IMO.

> In response to reviewer feedback from the initial patch series[1],
> this revision includes slight refactoring for improved
> maintainability and clarity in the code base.

Great :-).

> diff --git a/Documentation/config/worktree.txt b/Documentation/config/worktree.txt
> index 048e349482df6c892055720eb53cdcd6c327b6ed..44b783c2774dc5ff65e3fa232b0c25cd5254876b 100644
> --- a/Documentation/config/worktree.txt
> +++ b/Documentation/config/worktree.txt
> @@ -7,3 +7,8 @@ worktree.guessRemote::
>  	such a branch exists, it is checked out and set as "upstream"
>  	for the new branch.  If no such match can be found, it falls
>  	back to creating a new branch from the current HEAD.

I would have thought there would be a blank line in between this and the
section on worktree.guessRemote. ASCIIDoc doesn't require it because
this is a labeled list, but it does improve the readability of the raw
ASCIIDoc itself.

So not a big deal, but if you end up sending out another version of this
series it would be nice to include.

> +worktree.useRelativePaths::
> +	If set to `true`, worktrees will be linked to the repository using
> +	relative paths rather than using absolute paths. This is particularly
> +	useful for setups where the repository and worktrees may be moved between
> +	different locations or environments.

This is a good start, but I have a few suggestions on top that I'm
curious of your thoughts on. First: what is the default? Users
should have some insight into what the default is. Likewise, they should
know that that the default behavior does not introduce the repository
extension, but that setting this configuration to 'true' does.

Maybe something like the following on top?

--- 8< ---
diff --git a/Documentation/config/worktree.txt b/Documentation/config/worktree.txt
index 44b783c277..666cb3c190 100644
--- a/Documentation/config/worktree.txt
+++ b/Documentation/config/worktree.txt
@@ -7,8 +7,13 @@ worktree.guessRemote::
 	such a branch exists, it is checked out and set as "upstream"
 	for the new branch.  If no such match can be found, it falls
 	back to creating a new branch from the current HEAD.
+
 worktree.useRelativePaths::
-	If set to `true`, worktrees will be linked to the repository using
-	relative paths rather than using absolute paths. This is particularly
-	useful for setups where the repository and worktrees may be moved between
-	different locations or environments.
+	Link worktrees using relative paths (when "true") or absolute
+	paths (when "false"). This is particularly useful for setups
+	where the repository and worktrees may be moved between
+	different locations or environments. Defaults to "false".
++
+Note that setting `worktree.useRelativePaths` to "true" implies
+enabling the "relativeWorktrees" repository extension, thus making it
+incompatible with older versions of Git.
--- >8 ---

> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> index 70437c815f13852bd2eb862176b8b933e6de0acf..975dc3c46d480480457ec4857988a6b8bc67b647 100644
> --- a/Documentation/git-worktree.txt
> +++ b/Documentation/git-worktree.txt
> @@ -216,6 +216,18 @@ To remove a locked worktree, specify `--force` twice.
>  This can also be set up as the default behaviour by using the
>  `worktree.guessRemote` config option.
>
> +--[no-]relative-paths::
> +	Worktrees will be linked to the repository using relative paths
> +	rather than using absolute paths. This is particularly useful for setups
> +	where the repository and worktrees may be moved between different
> +	locations or environments.

This paragraph is redundant with what you wrote in git-config(1). I
think all we want to say is that it overrides the setting of that
configuration variable, and refer users there with linkgit.

> ++
> +With `repair`, the linking files will be updated if there's an absolute/relative
> +mismatch, even if the links are correct.

This is worth keeping.

> +This can also be set up as the default behaviour by using the
> +`worktree.useRelativePaths` config option.
> +

This should get folded into my suggestion above.

> diff --git a/t/t2408-worktree-relative.sh b/t/t2408-worktree-relative.sh
> deleted file mode 100755
> index a3136db7e28cb20926ff44211e246ce625a6e51a..0000000000000000000000000000000000000000
> --- a/t/t2408-worktree-relative.sh
> +++ /dev/null
> @@ -1,39 +0,0 @@

Was removing t2408 intentional here? I don't see the tests being
re-added elsewhere in this patch (though they may be introduced
elsewhere later in the series, I haven't read that far yet). Either way,
it may be worth mentioning in the commit message to avoid confusing
readers.

> diff --git a/worktree.c b/worktree.c
> index 77ff484d3ec48c547ee4e3d958dfa28a52c1eaa7..de5c5e53a5f2a758ddf470b5d6a9ad6c66247181 100644
> --- a/worktree.c
> +++ b/worktree.c
> @@ -14,6 +14,8 @@
>  #include "wt-status.h"
>  #include "config.h"
>
> +int use_relative_paths = 0;

I wondered whether 'use_relative_paths' should be static, or if we need to extern it in
from somewhere else in the tree. But we do, from worktree.[ch], which
seems reasonable. It would be nice if there was some way to thread that
into the worktree.h API, but I think that this is a reasonable measure
to take for now.

> +
>  void free_worktree(struct worktree *worktree)
>  {
>  	if (!worktree)
> @@ -111,9 +113,9 @@ struct worktree *get_linked_worktree(const char *id,
>  	strbuf_strip_suffix(&worktree_path, "/.git");
>
>  	if (!is_absolute_path(worktree_path.buf)) {
> -	    strbuf_strip_suffix(&path, "gitdir");
> -	    strbuf_addbuf(&path, &worktree_path);
> -	    strbuf_realpath_forgiving(&worktree_path, path.buf, 0);
> +		strbuf_strip_suffix(&path, "gitdir");
> +		strbuf_addbuf(&path, &worktree_path);
> +		strbuf_realpath_forgiving(&worktree_path, path.buf, 0);

Whitespace change?

>  	}
>
>  	CALLOC_ARRAY(worktree, 1);
> @@ -725,12 +727,15 @@ static int is_main_worktree_path(const char *path)
>   * won't know which <repo>/worktrees/<id>/gitdir to repair. However, we may
>   * be able to infer the gitdir by manually reading /path/to/worktree/.git,
>   * extracting the <id>, and checking if <repo>/worktrees/<id> exists.
> + *
> + * Returns -1 on failure and strbuf.len on success.
>   */
>  static int infer_backlink(const char *gitfile, struct strbuf *inferred)

Should this return an ssize_t instead, then? I don't think we're going
to have worktree paths that are actually larger than INT_MAX, but it
seems hygienic and good to prevent any accidental overflow issues.

Thanks,
Taylor
