Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F05681F597
	for <e@80x24.org>; Wed, 18 Jul 2018 22:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730491AbeGRXYn (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 19:24:43 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52088 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729679AbeGRXYm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 19:24:42 -0400
Received: by mail-wm0-f65.google.com with SMTP id h3-v6so3821518wmb.1
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 15:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=JWNZI85T6IM7dq/OuPbH+iEjovIgTLwU0nLz58csokw=;
        b=Qtc/+77rnE8OrNRjdVrk+fA/AQ4TKij0MBMX6isyIjZ/GEcOipsHKxxIgW4i4Q2/8w
         l+v+s0jxg6h1ZF/bJn3QYjNPHQNWk6YOC9UjifsRYXGs152Ampi48rXQPnDh+2cEm6ck
         fhu6TTi8zXUdPT7Zpq0IIGmKZxjZrnE6DqfhNs1p07cQlS0VuTdLs9FkwX01LmUpLTZq
         I0o3NQ/mqb4DMTeKh9+BNnnGOHfimvPx6IA+30qjl47mz8ipVz97BIdAtBx+xjcS9pAE
         ByIxJNWhkIkoESVoZA9vgseiIDtShCgIEWZtJ5LSORjV91GbHy+a/h9enuZohJjiXdAH
         sqXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=JWNZI85T6IM7dq/OuPbH+iEjovIgTLwU0nLz58csokw=;
        b=P7sMc0Jkbuek8bHAFziAbYuISCxyJkBaqNly+9et/f5vtNULSLvwbZgoHRwh18n6CV
         Vrvk+SB4djxbCUW9EVS9KuFRDn8Riw5kj7vgT1wwfs5+fb0VteZhPh2nRjM9G+6CmBct
         Twhvm0furqMRtmyl/NzRhaM4wh1H0Ji1uesgIdpOXCGFLWCRERtHDdY1tkF00vV8SPJU
         vx4xC33M53rfuBWOFZt5EAUHie/lYRBn8MarCTybYQ9sU/TPT68GtQIsIkdgK488FGX2
         7i+ocoKJNev63uqKjo8MG9vZVXoFs6AuJ0jIDMUM5bu/kU2e3DtO/RK19LhoMdhi/gt5
         Ccfw==
X-Gm-Message-State: AOUpUlEfW+KorZ7xyFVcOJ/JOnwberoltSmec0xebdf9tVW9ZnZj+wkO
        gQR/8QKG73860JDNLQ8Swr0=
X-Google-Smtp-Source: AAOMgpeZ2Y1JG3qEHTLnOlaL8Q0SVe+7eMcxEpA80ZECSE0FsitsRNLOEWSzfKttjvVlAd3J/biSyw==
X-Received: by 2002:a1c:6709:: with SMTP id b9-v6mr2714836wmc.68.1531953877041;
        Wed, 18 Jul 2018 15:44:37 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id h12-v6sm269433wmb.3.2018.07.18.15.44.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 15:44:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        Derrick Stolee <dstolee@microsoft.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 2/3] check_replace_refs: rename to read_replace_refs
References: <20180718204424.GA1483@sigill.intra.peff.net>
        <20180718204519.GB31816@sigill.intra.peff.net>
Date:   Wed, 18 Jul 2018 15:44:36 -0700
In-Reply-To: <20180718204519.GB31816@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 18 Jul 2018 16:45:20 -0400")
Message-ID: <xmqqh8kwi2p7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This was added as a NEEDSWORK in 3c36d7de2 (replace-object:

I'll do s/3c36d7de2/c&/; while queuing.

Like you, I do not think one is vastly better than the other between
these two names, but since a patch has been written, so ...

> check_replace_refs is safe in multi repo environment,
> 2018-04-11), waiting for a calmer period. Since doing so now
> doesn't conflict with anything in 'pu', it seems as good a
> time as any.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/fsck.c           | 2 +-
>  builtin/index-pack.c     | 2 +-
>  builtin/pack-objects.c   | 2 +-
>  builtin/prune.c          | 2 +-
>  builtin/replace.c        | 2 +-
>  builtin/unpack-objects.c | 2 +-
>  builtin/upload-pack.c    | 2 +-
>  cache.h                  | 2 +-
>  environment.c            | 4 ++--
>  git.c                    | 2 +-
>  log-tree.c               | 2 +-
>  replace-object.c         | 2 +-
>  replace-object.h         | 2 +-
>  13 files changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index 3ad4f160f9..0c3cbb86fc 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -689,7 +689,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
>  	fetch_if_missing = 0;
>  
>  	errors_found = 0;
> -	check_replace_refs = 0;
> +	read_replace_refs = 0;
>  
>  	argc = parse_options(argc, argv, prefix, fsck_opts, fsck_usage, 0);
>  
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index 74fe2973e1..a24faa0e51 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -1679,7 +1679,7 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
>  	if (argc == 2 && !strcmp(argv[1], "-h"))
>  		usage(index_pack_usage);
>  
> -	check_replace_refs = 0;
> +	read_replace_refs = 0;
>  	fsck_options.walk = mark_link;
>  
>  	reset_pack_idx_option(&opts);
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 71056d8294..63ee2c14c9 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -3185,7 +3185,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
>  	if (DFS_NUM_STATES > (1 << OE_DFS_STATE_BITS))
>  		BUG("too many dfs states, increase OE_DFS_STATE_BITS");
>  
> -	check_replace_refs = 0;
> +	read_replace_refs = 0;
>  
>  	reset_pack_idx_option(&pack_idx_opts);
>  	git_config(git_pack_config, NULL);
> diff --git a/builtin/prune.c b/builtin/prune.c
> index 518ffbea13..a1307b2f0d 100644
> --- a/builtin/prune.c
> +++ b/builtin/prune.c
> @@ -117,7 +117,7 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
>  
>  	expire = TIME_MAX;
>  	save_commit_buffer = 0;
> -	check_replace_refs = 0;
> +	read_replace_refs = 0;
>  	ref_paranoia = 1;
>  	init_revisions(&revs, prefix);
>  
> diff --git a/builtin/replace.c b/builtin/replace.c
> index 6da2411e14..9f4a616750 100644
> --- a/builtin/replace.c
> +++ b/builtin/replace.c
> @@ -544,7 +544,7 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
>  		OPT_END()
>  	};
>  
> -	check_replace_refs = 0;
> +	read_replace_refs = 0;
>  	git_config(git_default_config, NULL);
>  
>  	argc = parse_options(argc, argv, prefix, options, git_replace_usage, 0);
> diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
> index 6e81ca8ca2..5f76e6fe4e 100644
> --- a/builtin/unpack-objects.c
> +++ b/builtin/unpack-objects.c
> @@ -512,7 +512,7 @@ int cmd_unpack_objects(int argc, const char **argv, const char *prefix)
>  	int i;
>  	struct object_id oid;
>  
> -	check_replace_refs = 0;
> +	read_replace_refs = 0;
>  
>  	git_config(git_default_config, NULL);
>  
> diff --git a/builtin/upload-pack.c b/builtin/upload-pack.c
> index decde5a3b1..42dc4da5a1 100644
> --- a/builtin/upload-pack.c
> +++ b/builtin/upload-pack.c
> @@ -31,7 +31,7 @@ int cmd_upload_pack(int argc, const char **argv, const char *prefix)
>  	};
>  
>  	packet_trace_identity("upload-pack");
> -	check_replace_refs = 0;
> +	read_replace_refs = 0;
>  
>  	argc = parse_options(argc, argv, NULL, options, upload_pack_usage, 0);
>  
> diff --git a/cache.h b/cache.h
> index 6365fd6c0f..f98eb09441 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -806,7 +806,7 @@ void reset_shared_repository(void);
>   * $GIT_NO_REPLACE_OBJECTS is set, but is set to false by some
>   * commands that do not want replace references to be active.
>   */
> -extern int check_replace_refs;
> +extern int read_replace_refs;
>  extern char *git_replace_ref_base;
>  
>  extern int fsync_object_files;
> diff --git a/environment.c b/environment.c
> index 2a6de2330b..05d0d469b4 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -51,7 +51,7 @@ const char *editor_program;
>  const char *askpass_program;
>  const char *excludes_file;
>  enum auto_crlf auto_crlf = AUTO_CRLF_FALSE;
> -int check_replace_refs = 1; /* NEEDSWORK: rename to read_replace_refs */
> +int read_replace_refs = 1;
>  char *git_replace_ref_base;
>  enum eol core_eol = EOL_UNSET;
>  int global_conv_flags_eol = CONV_EOL_RNDTRP_WARN;
> @@ -183,7 +183,7 @@ void setup_git_env(const char *git_dir)
>  	argv_array_clear(&to_free);
>  
>  	if (getenv(NO_REPLACE_OBJECTS_ENVIRONMENT))
> -		check_replace_refs = 0;
> +		read_replace_refs = 0;
>  	replace_ref_base = getenv(GIT_REPLACE_REF_BASE_ENVIRONMENT);
>  	free(git_replace_ref_base);
>  	git_replace_ref_base = xstrdup(replace_ref_base ? replace_ref_base
> diff --git a/git.c b/git.c
> index 9dbe6ffaa7..c304a0626b 100644
> --- a/git.c
> +++ b/git.c
> @@ -164,7 +164,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
>  			if (envchanged)
>  				*envchanged = 1;
>  		} else if (!strcmp(cmd, "--no-replace-objects")) {
> -			check_replace_refs = 0;
> +			read_replace_refs = 0;
>  			setenv(NO_REPLACE_OBJECTS_ENVIRONMENT, "1", 1);
>  			if (envchanged)
>  				*envchanged = 1;
> diff --git a/log-tree.c b/log-tree.c
> index d3a43e29cd..95fa51a652 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -90,7 +90,7 @@ static int add_ref_decoration(const char *refname, const struct object_id *oid,
>  
>  	if (starts_with(refname, git_replace_ref_base)) {
>  		struct object_id original_oid;
> -		if (!check_replace_refs)
> +		if (!read_replace_refs)
>  			return 0;
>  		if (get_oid_hex(refname + strlen(git_replace_ref_base),
>  				&original_oid)) {
> diff --git a/replace-object.c b/replace-object.c
> index 801b5c1678..4162df6324 100644
> --- a/replace-object.c
> +++ b/replace-object.c
> @@ -51,7 +51,7 @@ static void prepare_replace_object(struct repository *r)
>   * replacement object's name (replaced recursively, if necessary).
>   * The return value is either oid or a pointer to a
>   * permanently-allocated value.  This function always respects replace
> - * references, regardless of the value of check_replace_refs.
> + * references, regardless of the value of read_replace_refs.
>   */
>  const struct object_id *do_lookup_replace_object(struct repository *r,
>  						 const struct object_id *oid)
> diff --git a/replace-object.h b/replace-object.h
> index f996de3d62..9345e105dd 100644
> --- a/replace-object.h
> +++ b/replace-object.h
> @@ -26,7 +26,7 @@ extern const struct object_id *do_lookup_replace_object(struct repository *r,
>  static inline const struct object_id *lookup_replace_object(struct repository *r,
>  							    const struct object_id *oid)
>  {
> -	if (!check_replace_refs ||
> +	if (!read_replace_refs ||
>  	    (r->objects->replace_map &&
>  	     r->objects->replace_map->map.tablesize == 0))
>  		return oid;
