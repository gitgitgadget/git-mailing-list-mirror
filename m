Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 505FE1F404
	for <e@80x24.org>; Fri,  2 Feb 2018 18:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752770AbeBBS41 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Feb 2018 13:56:27 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34859 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751833AbeBBS4Z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Feb 2018 13:56:25 -0500
Received: by mail-wr0-f193.google.com with SMTP id w50so23517534wrc.2
        for <git@vger.kernel.org>; Fri, 02 Feb 2018 10:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=CweoYOaZLroZWhKo07MqlHwEpChBVI9Y6iVCh/wGz10=;
        b=bFcN4qVgjfP8pjxpKR2wYgK9rqAezCTfiFrd3qDny2a4JT2TqAH3Zzhpg2hTzIxpV6
         oAX2T/NhWd4jhKIxFRm6yjVk0LQVnJnlwMlGvS0LOk1jdStwuvT0ii89hCfvIgRHpiui
         Eb7xKKrc+LeEHqsW+/vQB6P2zYwKL4yOQEFuaGcPmgWcKUX0y3o9JW7I0KHWpwxuqKCR
         VHNLDHZ1Z8pmFbJ5ptw0x+TB2JBEshShi4PLGd2ztwH45mQuZ2TanELtap80YHyMrViC
         mAH8tEkPGVW+oE2BgjzGs4wO+3d3ZN3DeJ1MWqw2/sLf1kn4yJFU1eFKwgvz4J2AxC9Z
         jmOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=CweoYOaZLroZWhKo07MqlHwEpChBVI9Y6iVCh/wGz10=;
        b=TnLd1xzR7MS8/X7/bYr7mTl0Lmf0c59yjkKvOm+Br1Qir87qTrDaD2FpziGlJNEHNW
         FthkyMkpNXmOKk2tJx3klvmTN5RUXncXQok+85Ss/9sD2HlZEn1HXGqabNfrxUSKzWie
         JyCCukm7AoX6W5E+X37wCwB9X//kUj5OH0c2ofYadAke5IML1IT5aVsDmB7Aro+q8KT6
         SRlqeKvZ5ymuS7/XZWGYqPSOOFmmiuOrEhzYtw0Dub7hrYo35O+jh2yRWp216/uf1pdy
         +/S2jnsfanwvQBx3oe2vd0IBn5gBZlspIOTs7v2ipkFtLv5hJMpR2AVA7Q2d7Ugb9sGz
         qcOQ==
X-Gm-Message-State: AKwxyteqy/AB4UgiqKjPnRSDixAoV/eYguR8pFmE8DRphHctqrLLao3v
        pLuF7QwP7hEi7tJ1OR0lEfs=
X-Google-Smtp-Source: AH8x2260qLf7kx7RKOxYXHj83PGov4Nu2XNyudwLOokesHBc+hDjCStfCSVLaKZg6zFsLjl8Er/J8Q==
X-Received: by 10.223.182.14 with SMTP id f14mr6942356wre.158.1517597783904;
        Fri, 02 Feb 2018 10:56:23 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a139sm1086864wme.1.2018.02.02.10.56.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Feb 2018 10:56:23 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        tim@tim-landscheidt.de
Subject: Re: [PATCH v2 1/3] am: add --show-current-patch
References: <20180126095520.919-1-pclouds@gmail.com>
        <20180131093051.15525-1-pclouds@gmail.com>
        <20180131093051.15525-2-pclouds@gmail.com>
        <CAPig+cR24=0_NPekYaF+oG9OovDkv1Et-RpNvAHqE7Qd7g7QQA@mail.gmail.com>
        <xmqqpo5pr5wr.fsf@gitster-ct.c.googlers.com>
        <20180202092511.GA28946@ash>
Date:   Fri, 02 Feb 2018 10:56:22 -0800
In-Reply-To: <20180202092511.GA28946@ash> (Duy Nguyen's message of "Fri, 2 Feb
        2018 16:25:11 +0700")
Message-ID: <xmqq372jdxux.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> Subject: [PATCH] Preserve errno in case case before calling sth_errno()
>
> All these locations do something like this
>
>     sth_errno(..., somefunc(...));
>
> where somefunc() can potentially change errno, which will be read by
> sth_errno(). Call somefunc separately with errno preserved to avoid
> this.
>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  builtin/am.c      |  8 +++++++-
>  builtin/commit.c  |  8 ++++++--
>  builtin/init-db.c |  9 ++++++---
>  rerere.c          |  9 ++++++---
>  shallow.c         | 27 ++++++++++++++++++---------
>  5 files changed, 43 insertions(+), 18 deletions(-)

> diff --git a/builtin/init-db.c b/builtin/init-db.c
> index c9b7946bad..e384749f73 100644
> --- a/builtin/init-db.c
> +++ b/builtin/init-db.c
> @@ -570,9 +570,12 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
>  			set_git_work_tree(work_tree);
>  		else
>  			set_git_work_tree(git_work_tree_cfg);
> -		if (access(get_git_work_tree(), X_OK))
> -			die_errno (_("Cannot access work tree '%s'"),
> -				   get_git_work_tree());
> +		if (access(get_git_work_tree(), X_OK)) {
> +			int saved_errno = errno;
> +			const char *path = get_git_work_tree();
> +			errno = saved_errno;
> +			die_errno(_("Cannot access work tree '%s'"), path);
> +		}
>  	}

This one is the most faithful conversion from "mechanical rewrite"
point of view, but I wonder if we should instead take the returned
path from get_git_work_tree() and use it in both calls.  After all,
this is hardly performance sensitive codepath, so even "an obviously
safe but wasteful with extra xstrdup/free" version

	work_tree_path = xstrdup(get_git_work_tree());
	if (access(work_tree_path, X_OK))
		die_errno(_("msg..."), work_tree_path);
	free(work_tree_path);

may be an improvement.

> diff --git a/rerere.c b/rerere.c
> index 1ce440f4bb..f19a53ff2c 100644
> --- a/rerere.c
> +++ b/rerere.c
> @@ -683,9 +683,12 @@ static int merge(const struct rerere_id *id, const char *path)
>  	 * A successful replay of recorded resolution.
>  	 * Mark that "postimage" was used to help gc.
>  	 */
> -	if (utime(rerere_path(id, "postimage"), NULL) < 0)
> -		warning_errno("failed utime() on %s",
> -			      rerere_path(id, "postimage"));
> +	if (utime(rerere_path(id, "postimage"), NULL) < 0) {
> +		int saved_errno = errno;
> +		const char *path = rerere_path(id, "postimage");
> +		errno = saved_errno;
> +		warning_errno("failed utime() on %s", path);
> +	}

Likewise.

> diff --git a/shallow.c b/shallow.c
> index df4d44ea7a..9da82f5292 100644
> --- a/shallow.c
> +++ b/shallow.c
> @@ -295,9 +295,12 @@ const char *setup_temporary_shallow(const struct oid_array *extra)
>  		temp = xmks_tempfile(git_path("shallow_XXXXXX"));
>  
>  		if (write_in_full(temp->fd, sb.buf, sb.len) < 0 ||
> -		    close_tempfile_gently(temp) < 0)
> -			die_errno("failed to write to %s",
> -				  get_tempfile_path(temp));
> +		    close_tempfile_gently(temp) < 0) {
> +			int saved_errno = errno;
> +			const char *path = get_tempfile_path(temp);
> +			errno = saved_errno;
> +			die_errno("failed to write to %s", path);
> +		}

It feels a bit questionable to my taste to pretend that we are truly
oblivious to how trivial get_tempfile_path() is, i.e. no more than
just a few field accesses to "tempfile" struct.  It buries more
important thing that is happening in the code in noise.

> @@ -319,9 +322,12 @@ void setup_alternate_shallow(struct lock_file *shallow_lock,

Likewise.

> @@ -366,9 +372,12 @@ void prune_shallow(int show_only)

Likewise.

All others I snipped looked like good changes.  Thanks.
