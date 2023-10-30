Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AA323C3
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 21:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="eVLiz8Om"
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8C39F
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 14:29:37 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id a1e0cc1a2514c-7b610279c8aso2117933241.3
        for <git@vger.kernel.org>; Mon, 30 Oct 2023 14:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1698701375; x=1699306175; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AUYSldOm3dPrS+hNVAiFUKe/ulyLwwEw7eXgzn0ARyo=;
        b=eVLiz8Om39y0i4r2wmwdmgnOTiUKoB8FWh4gRP+fg0zkwOsB7TFYQelpzH8k3QAQYW
         5HExW8gcsoMGbs++q9BnbRX1pQduPdrx+6Td/I4f/SxlYh3hCQtnR0aWVwHArHB9Xj4I
         QCmUygOZWmDDAiGbnrpjZ8OaP+vXImZOUMGka8Hd4+kCVBd+U2MIpfboyiWJITUHeYet
         u5JtXQ/B5fktJB3OqV0yAjN6l2NpDIGoaxk+4KSOxC7q74hnSnwP5Kdkh5zCZvPQ1rVX
         PvmK0ewJPYt+aHb/p7uDRVrz32rHpV+GF+irL9Epr/PVC1pSyVrJZytJk8l6CWmwXbQg
         pNjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698701375; x=1699306175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AUYSldOm3dPrS+hNVAiFUKe/ulyLwwEw7eXgzn0ARyo=;
        b=Nmc8GHBH0NyEWJrhQ1c2NvJxT4vvkRBqdxAK97M2V09rRjMk/2zWdUqzNSolNrk7E1
         YHaq5KnUxLHHgbTc/i9K9SxM+H+6wwiSRIwLVIVk09LIk5xmHNrNvaTBIZF/xnIJp1nI
         GMeMKhxIvj0lcB4Rf8X/mEPJGJF04BFLJph4fq0YwSKK5/SISIbYxnQuujvA3ndD5Oun
         BlPksGyl6h6pQY/X4jyo7FiZE23Pp7u+MsuMhP3/uvvHsr821IwUTfcC/8tvQQYwvDWU
         1N7axPXNcvUaQ/ZagQMAXsBtf1gncRWK6ZdutPXLc72o+ZgYPwj4IxgjD8BkzOQiGvV4
         j9Sw==
X-Gm-Message-State: AOJu0Yx1McH7CCx9fdig0pEymJtJP6N81uDyzhuE/Ww3lgJBd8XarGIr
	3cGxPgx46AY9eiMGsyEbb46nBg==
X-Google-Smtp-Source: AGHT+IEw0xv+VJ45I7DqtgxzdECuQ8wq74BzTdlFES8rLFm0phY4us35pmsfLbMhyWn+xuh2mgWnpA==
X-Received: by 2002:a05:6102:512a:b0:45a:9bb2:d486 with SMTP id bm42-20020a056102512a00b0045a9bb2d486mr11866331vsb.15.1698701374724;
        Mon, 30 Oct 2023 14:29:34 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c19-20020a056214071300b0066d818fa482sm2808946qvz.115.2023.10.30.14.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 14:29:34 -0700 (PDT)
Date: Mon, 30 Oct 2023 17:29:33 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/2] commit-graph: introduce envvar to disable commit
 existence checks
Message-ID: <ZUAgPVR8HxgEZEWo@nand.local>
References: <cover.1698060036.git.ps@pks.im>
 <a89c4355285bc0bb0ec339818e6fe907f9ffd30e.1698060036.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a89c4355285bc0bb0ec339818e6fe907f9ffd30e.1698060036.git.ps@pks.im>

On Mon, Oct 23, 2023 at 01:27:16PM +0200, Patrick Steinhardt wrote:
> Our `lookup_commit_in_graph()` helper tries to look up commits from the
> commit graph and, if it doesn't exist there, falls back to parsing it
> from the object database instead. This is intended to speed up the
> lookup of any such commit that exists in the database. There is an edge
> case though where the commit exists in the graph, but not in the object
> database. To avoid returning such stale commits the helper function thus
> double checks that any such commit parsed from the graph also exists in
> the object database. This makes the function safe to use even when
> commit graphs aren't updated regularly.
>
> We're about to introduce the same pattern into other parts of our code
> base though, namely `repo_parse_commit_internal()`. Here the extra
> sanity check is a bit of a tougher sell: `lookup_commit_in_graph()` was
> a newly introduced helper, and as such there was no performance hit by
> adding this sanity check. If we added `repo_parse_commit_internal()`
> with that sanity check right from the beginning as well, this would
> probably never have been an issue to begin with. But by retrofitting it
> with this sanity check now we do add a performance regression to
> preexisting code, and thus there is a desire to avoid this or at least
> give an escape hatch.
>
> In practice, there is no inherent reason why either of those functions
> should have the sanity check whereas the other one does not: either both
> of them are able to detect this issue or none of them should be. This
> also means that the default of whether we do the check should likely be
> the same for both. To err on the side of caution, we thus rather want to
> make `repo_parse_commit_internal()` stricter than to loosen the checks
> that we already have in `lookup_commit_in_graph()`.

All well reasoned. I think the most compelling reason is that we're
already doing this extra check in lookup_commit_in_graph(), and having
that be somewhat inconsistent with repo_parse_commit_internal() feels
error-prone to me.

> The escape hatch is added in the form of a new GIT_COMMIT_GRAPH_PARANOIA
> environment variable that mirrors GIT_REF_PARANOIA. If enabled, which is
> the default, we will double check that commits looked up in the commit
> graph via `lookup_commit_in_graph()` also exist in the object database.
> This same check will also be added in `repo_parse_commit_internal()`.

Sounds good.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Documentation/git.txt   |  9 +++++++++
>  commit-graph.c          |  6 +++++-
>  commit-graph.h          |  6 ++++++
>  t/t5318-commit-graph.sh | 21 +++++++++++++++++++++
>  4 files changed, 41 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 11228956cd..22c2b537aa 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -911,6 +911,15 @@ for full details.
>  	should not normally need to set this to `0`, but it may be
>  	useful when trying to salvage data from a corrupted repository.
>
> +`GIT_COMMIT_GRAPH_PARANOIA`::
> +	If this Boolean environment variable is set to false, ignore the
> +	case where commits exist in the commit graph but not in the
> +	object database. Normally, Git will check whether commits loaded
> +	from the commit graph exist in the object database to avoid
> +	issues with stale commit graphs, but this check comes with a
> +	performance penalty. The default is `1` (i.e., be paranoid about
> +	stale commits in the commit graph).
> +

The first two sentences seem to be flipped. Perhaps:

    When loading a commit object from the commit-graph, Git will perform
    an existence check on the object in the ODB before parsing it out of
    the commit-graph. The default is "true", which enables the
    aforementioned behavior. Setting this to "false" disables the
    existential check when parsing commits from a commit-graph.

>  `GIT_ALLOW_PROTOCOL`::
>  	If set to a colon-separated list of protocols, behave as if
>  	`protocol.allow` is set to `never`, and each of the listed
> diff --git a/commit-graph.c b/commit-graph.c
> index fd2f700b2e..12ec31902e 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -939,14 +939,18 @@ int repo_find_commit_pos_in_graph(struct repository *r, struct commit *c,
>
>  struct commit *lookup_commit_in_graph(struct repository *repo, const struct object_id *id)
>  {
> +	static int object_paranoia = -1;
>  	struct commit *commit;
>  	uint32_t pos;
>
> +	if (object_paranoia == -1)
> +		object_paranoia = git_env_bool(GIT_COMMIT_GRAPH_PARANOIA, 1);
> +

I don't think that this is a reroll-able issue, but calling this
variable object_paranoia to store a setting for *graph* paranoia feels
like a good itch to scratch. But obviously not a big deal ;-).

> @@ -821,4 +821,25 @@ test_expect_success 'overflow during generation version upgrade' '
>  	)
>  '
>
> +test_expect_success 'stale commit cannot be parsed when given directly' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit A &&
> +		test_commit B &&
> +		git commit-graph write --reachable &&
> +
> +		oid=$(git rev-parse B) &&
> +		rm .git/objects/"$(test_oid_to_path "$oid")" &&
> +
> +		# Verify that it is possible to read the commit from the
> +		# commit graph when not being paranoid, ...
> +		GIT_COMMIT_GRAPH_PARANOIA=false git rev-list B &&
> +		# ... but parsing the commit when double checking that
> +		# it actually exists in the object database should fail.
> +		test_must_fail git rev-list -1 B

Would "cat-file -p" be more direct here than "rev-list -1"?

Thanks,
Taylor
