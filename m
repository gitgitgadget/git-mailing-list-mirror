Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69B721F404
	for <e@80x24.org>; Wed, 28 Feb 2018 18:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932155AbeB1S5I (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 13:57:08 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:38893 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753054AbeB1S5H (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 13:57:07 -0500
Received: by mail-wr0-f196.google.com with SMTP id n7so3547836wrn.5
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 10:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=M+qtEJvfawrzM8fXwJgaO1egWJQaqsKZqs3ho8jaAeI=;
        b=Rl41biD3RG4XViCJW0HI3IgqJK9+Jjt483F2OW3AGcbaQQA1sK8MhDxoe5w3dsuxCQ
         gB/zbAYo17jzLLf/FlEIpNnKNibUepk6PMPWk4xboWRP1pkjuCji93JlUFjkUQjNE+fz
         ccJ/8Zuao6KnMw+tsoJkPAqTRZxaLie6W6UCIIcYAOeY8+lMEHXIZMEp3OAQFRSlpGrC
         H8CnEdJN4jzTHsIiIy+R1iKJ3pXE3d1v8jWfdrzHWyY2aoQho1tSDW+osLzKCZJOw8rh
         v4sCv41CToQrqzerApx60tHaIriIojYgc/+sy3Z1g5De5CW/0uVYOGN5vnUpGoj7v0Bw
         bS6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=M+qtEJvfawrzM8fXwJgaO1egWJQaqsKZqs3ho8jaAeI=;
        b=rBM7EDakZIQUOgQ6INt73DCDFD3zPRoTXtA6azQtJehMTa5aZbdwryCiYtROzI2wVW
         LlPVatFdhr2iMfhu7onZke35ObQ4/4EK4tivFsLSFNB4i9V3dwTdyDMC4OlIcmKQWGGA
         AOt8Cm1d34/k7GSF0VLe2Ad3ied8MaFMASuAWBtZNKpsFqDxuw1jfOyIOzD5f03J5Ofa
         9turcA+okC9jmqpavqVqHAlZKIa5exevlTf9Ft487+k0tIGb8iAw38RLJeNFcBeMFBhP
         rbLp0JRl1zT7Wv/uJNLy7cRuJKeCU+T9ZdA0Z6BJA6x/1XIi7jJHVIy03Kwl4Xw0uGpA
         5u9Q==
X-Gm-Message-State: APf1xPBLlTJaxcnA6CEQC4qTrn6hWRU09WO0KiYjomW9o1Nuw+DIBmHV
        AOsFJxJRXrkRgOAk1OP1xN4=
X-Google-Smtp-Source: AH8x2251IUTYcwGXyTeCnwGmxLt63NcX8ri6LdIbH9w6g2A69NAe3aRU0q+rfI9ElhMKnmqogRXyMA==
X-Received: by 10.223.135.136 with SMTP id b8mr16701550wrb.72.1519844225683;
        Wed, 28 Feb 2018 10:57:05 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b7sm2967447wmg.41.2018.02.28.10.57.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Feb 2018 10:57:05 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     bmwill@google.com, git@vger.kernel.org, jonathantanmy@google.com,
        sbeller@google.com, sunshine@sunshineco.com
Subject: Re: [PATCH v3 0/4] Delete ignore_env member in struct repository
References: <20180227095846.9238-1-pclouds@gmail.com>
        <20180228013727.13815-1-pclouds@gmail.com>
Date:   Wed, 28 Feb 2018 10:57:04 -0800
In-Reply-To: <20180228013727.13815-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Wed, 28 Feb 2018 08:37:23 +0700")
Message-ID: <xmqqefl5kkn3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> v3 fixes comment style. Also since Brandon raised a question about
> shared_root, it's obviously not a good name, so I renamed it to
> commondir.
>
> I still keep the delete patch 2/4, but I move the repo_setup_env()
> deletion back to 1/4 so all env logic is in one patch (the
> introduction of new helper functions in 1/4 and deletion in 2/4 are
> still diff noise if 2/4 is completely merged back).

Thanks.  After replacing sb/object-store with the last one posted
and re-tweaking resolution of conflicts with ds/commit-graph that is
in flight, I think I can squeeze this topic in.  Among the three, I
find that this kind of clean-up is the most interesting/urgent thing
we need before we can move forward ;-)



>
> Interdiff:
>
> diff --git a/environment.c b/environment.c
> index 47c6e31559..b2128c1188 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -149,7 +149,8 @@ static char *expand_namespace(const char *raw_namespace)
>  	return strbuf_detach(&buf, NULL);
>  }
>  
> -/* Wrapper of getenv() that returns a strdup value. This value is kept
> +/*
> + * Wrapper of getenv() that returns a strdup value. This value is kept
>   * in argv to be freed later.
>   */
>  static const char *getenv_safe(struct argv_array *argv, const char *name)
> @@ -170,7 +171,7 @@ void setup_git_env(const char *git_dir)
>  	struct set_gitdir_args args = { NULL };
>  	struct argv_array to_free = ARGV_ARRAY_INIT;
>  
> -	args.shared_root = getenv_safe(&to_free, GIT_COMMON_DIR_ENVIRONMENT);
> +	args.commondir = getenv_safe(&to_free, GIT_COMMON_DIR_ENVIRONMENT);
>  	args.object_dir = getenv_safe(&to_free, DB_ENVIRONMENT);
>  	args.graft_file = getenv_safe(&to_free, GRAFT_ENVIRONMENT);
>  	args.index_file = getenv_safe(&to_free, INDEX_ENVIRONMENT);
> diff --git a/repository.c b/repository.c
> index c555dacad2..4f44384dde 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -27,15 +27,15 @@ static void expand_base_dir(char **out, const char *in,
>  }
>  
>  static void repo_set_commondir(struct repository *repo,
> -			       const char *shared_root)
> +			       const char *commondir)
>  {
>  	struct strbuf sb = STRBUF_INIT;
>  
>  	free(repo->commondir);
>  
> -	if (shared_root) {
> +	if (commondir) {
>  		repo->different_commondir = 1;
> -		repo->commondir = xstrdup(shared_root);
> +		repo->commondir = xstrdup(commondir);
>  		return;
>  	}
>  
> @@ -58,7 +58,7 @@ void repo_set_gitdir(struct repository *repo,
>  	repo->gitdir = xstrdup(gitfile ? gitfile : root);
>  	free(old_gitdir);
>  
> -	repo_set_commondir(repo, o->shared_root);
> +	repo_set_commondir(repo, o->commondir);
>  	expand_base_dir(&repo->objects.objectdir, o->object_dir,
>  			repo->commondir, "objects");
>  	free(repo->objects.alternate_db);
> diff --git a/repository.h b/repository.h
> index 07e8971428..e05a77a099 100644
> --- a/repository.h
> +++ b/repository.h
> @@ -81,7 +81,7 @@ struct repository {
>  extern struct repository *the_repository;
>  
>  struct set_gitdir_args {
> -	const char *shared_root;
> +	const char *commondir;
>  	const char *object_dir;
>  	const char *graft_file;
>  	const char *index_file;
>
> Nguyễn Thái Ngọc Duy (4):
>   repository.c: move env-related setup code back to environment.c
>   repository.c: delete dead functions
>   sha1_file.c: move delayed getenv(altdb) back to setup_git_env()
>   repository: delete ignore_env member
>
>  cache.h        |  2 +-
>  environment.c  | 31 +++++++++++++++++--
>  object-store.h |  5 ++-
>  object.c       |  1 +
>  repository.c   | 84 ++++++++++++++++++++++++--------------------------
>  repository.h   | 21 +++++++------
>  setup.c        |  3 +-
>  sha1_file.c    |  6 +---
>  8 files changed, 87 insertions(+), 66 deletions(-)
