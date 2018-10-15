Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7CA91F453
	for <e@80x24.org>; Mon, 15 Oct 2018 22:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbeJPFuu (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 01:50:50 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43014 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbeJPFuu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 01:50:50 -0400
Received: by mail-wr1-f66.google.com with SMTP id n1-v6so23078711wrt.10
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 15:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2piBkyu72aWHL9b8cy/Vd5mVhGQA/bQV2OAarx255X8=;
        b=oPUnbwBDBnzu1i6IF7x3dGFdWD63m7VoGqBC2RDn5WVL5++UE3ztS2MyHRIyoH6+BE
         1uVIWmGuEu/WwVXp/YhGEV+S1xFRKYglq1Z36DUwjTPSyBxqw/18hcZ/tGXuxa0M4MqS
         Njafi5cx994WdbK2yGK6SzMFWhgo17yQ7yi0TQ3yL81UXkhpPtvTd3ljChzRAmYc1SI5
         Fhb14kqtTjCEKnjS/HZ49eQy0Ne8mCJpF+cA5l567TvjuPjKTe0sGJ5JmqksiB5QdhA4
         BF4Q0LmMUrKKEITHxZKB7msxJ8O+rcCA62o7rQEO/7aumBwzqA0S/50lA327eNuBu2O6
         HPBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2piBkyu72aWHL9b8cy/Vd5mVhGQA/bQV2OAarx255X8=;
        b=BRjPMNRLGf9QfCya6hsYbadT/VEcvRtDSb+JhxcniV1tpgU2vVS6o8FzriysbfOjFa
         9tkGn25XpM9fn9MT9IHq9NUHYB+kf3pzb4HNeV9q4bpPbt6ASBWGmANqfeKhVVv3Jh5x
         CQfNQIlgrLNtmKElYT6rUIlJqcgGMXpXR5K6YlpqczKvjgzlrbRUyKbeweX4WupeyBiv
         T0ywQxdwK1VpxPfo/WDiRJCh0TcvhCBWxPzX3j64akuxx4hBVfLjyOsjxXomMai47WnE
         3NJx+sbxPs9LFQWdDmY6GHk5Db1Qbm5qBKNVECaTQWY2gtwKqt3REjxPUbAwmrJFZE5A
         6ksg==
X-Gm-Message-State: ABuFfohBBA/3578Uuxip89mj7HG/p71LAKJRsE4lLep+GX5ol0QRYSDe
        AXj+MutefkW2fMniL7igxOMlU4Us
X-Google-Smtp-Source: ACcGV60O6d4PRnKTspkpLDHA3IpOg1G6QkoFuvpbS3mmZ7Qas9V0pQuBdABxXAlf4i+CdDRapif/1A==
X-Received: by 2002:adf:ba87:: with SMTP id p7-v6mr15123304wrg.203.1539641021190;
        Mon, 15 Oct 2018 15:03:41 -0700 (PDT)
Received: from localhost ([31.127.45.92])
        by smtp.gmail.com with ESMTPSA id v16-v6sm9350083wru.31.2018.10.15.15.03.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 15:03:40 -0700 (PDT)
Date:   Mon, 15 Oct 2018 23:03:38 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v10 19/21] stash: convert `stash--helper.c` into `stash.c`
Message-ID: <20181015220338.GB4883@hank.intra.tgummerer.com>
References: <cover.1539553398.git.ungureanupaulsebastian@gmail.com>
 <004f2b2e3e8c4d1069a808034f3d6fe16853085c.1539553398.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <004f2b2e3e8c4d1069a808034f3d6fe16853085c.1539553398.git.ungureanupaulsebastian@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/15, Paul-Sebastian Ungureanu wrote:
> The old shell script `git-stash.sh`  was removed and replaced
> entirely by `builtin/stash.c`. In order to do that, `create` and
> `push` were adapted to work without `stash.sh`. For example, before
> this commit, `git stash create` called `git stash--helper create
> --message "$*"`. If it called `git stash--helper create "$@"`, then
> some of these changes wouldn't have been necessary.
> 
> This commit also removes the word `helper` since now stash is
> called directly and not by a shell script.
> 
> Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
> ---
> @@ -1138,7 +1133,6 @@ static int do_create_stash(struct pathspec ps, char **stash_msg,
>  			fprintf_ln(stderr, _("You do not have "
>  					     "the initial commit yet"));
>  		ret = -1;
> -		*stash_msg = NULL;
>  		goto done;
>  	} else {
>  		head_commit = lookup_commit(the_repository, &info->b_commit);
> @@ -1146,7 +1140,6 @@ static int do_create_stash(struct pathspec ps, char **stash_msg,
>  
>  	if (!check_changes(ps, include_untracked)) {
>  		ret = 1;
> -		*stash_msg = NULL;
>  		goto done;
>  	}
>  
> @@ -1167,7 +1160,6 @@ static int do_create_stash(struct pathspec ps, char **stash_msg,
>  			fprintf_ln(stderr, _("Cannot save the current "
>  					     "index state"));
>  		ret = -1;
> -		*stash_msg = NULL;
>  		goto done;
>  	}
>  
> @@ -1178,14 +1170,12 @@ static int do_create_stash(struct pathspec ps, char **stash_msg,
>  				fprintf_ln(stderr, _("Cannot save "
>  						     "the untracked files"));
>  			ret = -1;
> -			*stash_msg = NULL;
>  			goto done;
>  		}
>  		untracked_commit_option = 1;
>  	}
>  	if (patch_mode) {
>  		ret = stash_patch(info, ps, patch, quiet);
> -		*stash_msg = NULL;
>  		if (ret < 0) {
>  			if (!quiet)
>  				fprintf_ln(stderr, _("Cannot save the current "
> @@ -1200,7 +1190,6 @@ static int do_create_stash(struct pathspec ps, char **stash_msg,
>  				fprintf_ln(stderr, _("Cannot save the current "
>  						     "worktree state"));
>  			ret = -1;
> -			*stash_msg = NULL;
>  			goto done;
>  		}
>  	}
> @@ -1210,7 +1199,7 @@ static int do_create_stash(struct pathspec ps, char **stash_msg,
>  	else
>  		strbuf_addf(&stash_msg_buf, "On %s: %s", branch_name,
>  			    *stash_msg);
> -	*stash_msg = strbuf_detach(&stash_msg_buf, NULL);
> +	*stash_msg = xstrdup(stash_msg_buf.buf);
>  
>  	/*
>  	 * `parents` will be empty after calling `commit_tree()`, so there is
> @@ -1244,30 +1233,23 @@ static int do_create_stash(struct pathspec ps, char **stash_msg,
>  
>  static int create_stash(int argc, const char **argv, const char *prefix)
>  {
> -	int include_untracked = 0;
>  	int ret = 0;
>  	char *stash_msg = NULL;
>  	struct stash_info info;
>  	struct pathspec ps;
> -	struct option options[] = {
> -		OPT_BOOL('u', "include-untracked", &include_untracked,
> -			 N_("include untracked files in stash")),
> -		OPT_STRING('m', "message", &stash_msg, N_("message"),
> -			 N_("stash message")),
> -		OPT_END()
> -	};
> +	struct strbuf stash_msg_buf = STRBUF_INIT;
>  
> -	argc = parse_options(argc, argv, prefix, options,
> -			     git_stash_helper_create_usage,
> -			     0);
> +	/* Starting with argv[1], since argv[0] is "create" */
> +	strbuf_join_argv(&stash_msg_buf, argc - 1, ++argv, ' ');
> +	stash_msg = stash_msg_buf.buf;

stash_msg is just a pointer to stash_msg_buf.buf here..
>  
>  	memset(&ps, 0, sizeof(ps));
> -	ret = do_create_stash(ps, &stash_msg, include_untracked, 0, &info,
> -			      NULL, 0);
> +	ret = do_create_stash(ps, &stash_msg, 0, 0, &info, NULL, 0);
>  
>  	if (!ret)
>  		printf_ln("%s", oid_to_hex(&info.w_commit));
>  
> +	strbuf_release(&stash_msg_buf);

We release the strbuf here, which means stash_msg_buf.buf is now
'strbuf_slopbuf', which is a global variable and can't be free'd.  If
stash_msg is not changed within do_create_stash, it is now pointing to
'strbuf_slopbuf', and we try to free that below, which makes git
crash in t3903.44, which breaks bisection.

>  	free(stash_msg);
>  
>  	/*

I think the following diff fixes memory management, by making
do_push_stash responsible for freeing stash_msg when it's done with
it, while the callers of do_create_stash have to free the parameter
they pass in (although it may be pointing to something different than
what was passed in).

diff --git a/builtin/stash.c b/builtin/stash.c
index e945c13c42..3b50f4bd53 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1199,6 +1199,7 @@ static int do_create_stash(struct pathspec ps, char **stash_msg,
 	else
 		strbuf_addf(&stash_msg_buf, "On %s: %s", branch_name,
 			    *stash_msg);
+	free(*stash_msg);
 	*stash_msg = xstrdup(stash_msg_buf.buf);
 
 	/*
@@ -1241,7 +1242,7 @@ static int create_stash(int argc, const char **argv, const char *prefix)
 
 	/* Starting with argv[1], since argv[0] is "create" */
 	strbuf_join_argv(&stash_msg_buf, argc - 1, ++argv, ' ');
-	stash_msg = stash_msg_buf.buf;
+	stash_msg = xstrdup(stash_msg_buf.buf);
 
 	memset(&ps, 0, sizeof(ps));
 	ret = do_create_stash(ps, &stash_msg, 0, 0, &info, NULL, 0);
@@ -1522,7 +1523,7 @@ static int save_stash(int argc, const char **argv, const char *prefix)
 	}
 
 	memset(&ps, 0, sizeof(ps));
-	ret = do_push_stash(ps, stash_msg, quiet, keep_index, patch_mode,
+	ret = do_push_stash(ps, xstrdup_or_null(stash_msg), quiet, keep_index, patch_mode,
 			    include_untracked);
 
 	strbuf_release(&buf);

The above, as well as the some of the changes I quoted above should
probably be squashed in to the relevant patches, rather than being
part of this patch ("stash: convert create to builtin", and "stash:
convert save to builtin").
