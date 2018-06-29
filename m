Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDD5B1F516
	for <e@80x24.org>; Fri, 29 Jun 2018 14:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933516AbeF2Otx (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 10:49:53 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35626 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932254AbeF2Otw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 10:49:52 -0400
Received: by mail-qt0-f194.google.com with SMTP id z6-v6so8042469qti.2
        for <git@vger.kernel.org>; Fri, 29 Jun 2018 07:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ZHw4hKvbl7rQfzWJmfeo061AVYGPyWauVV3qZg3OvMY=;
        b=jg9LTZyI9pcij6S750fpYnLi5lktRFc1hcOR1XVVB2L7KRO4yM+gBTN6y9HU2Ry6b5
         VcM1ijTX/9ZMUUaDLw13N6bws+fOZz/AoA1aN8Sxwwva5ooPyXiae9hbKpk+Pn42GQcK
         IZMjtcKYBp+Dk3i7OGaVKRTScUIDtPWaNpOKGiY/d1KOk+zwZre3M+YjHzSCsO7x2Ef4
         M08JjAUeH9HVnCbMiD4A6KmIR7dj0v3x+/SogEETbroV/jgHrNJzi3Q11Sw7gG86AyK5
         GNB22v/y9SUCteb6uw+d7zmXzogp8unDm+2NR2/dVXIKZ0JUekAebHt0iBmkorrQcvQV
         0ZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ZHw4hKvbl7rQfzWJmfeo061AVYGPyWauVV3qZg3OvMY=;
        b=NQAZhryKHXbOh+UXvWPsI4Tbb1sGv1b6vJlhG7Nhy/QaqDXeMAE1KKCKuWV9sNByvD
         bN/gq9NK5eRn04m3egDKn4QLVzXHhkae7idP/hrKwyBvL/+KWi2KYSw3aWd0Y1xIIxwP
         bhKRi8ynSvNLamYIlkpkTN1gFnh7t1HSVCiwwSEaKRNqjwgcw3nj+zV/QRArvJ+6rdTK
         qlW2N4i4CDjrIy0cqRsdz6y2jyT9HCxuBaL8nUtlsdxMsvcw1syWAcPwT/200YyCvsor
         kGwaNqcya2x/YSyGhHr2LdidbV+mODAx2/Jz/BSv+Ocv+zNuqmCh0q+PIAfGhxRla+WK
         lIQw==
X-Gm-Message-State: APt69E3cV5fyaeRiXwlAqsSUnNmVwBdu/l4x5bny2mp0ELsd47Ay08rJ
        ncRWSWeHWq5WA0MrZlm891E=
X-Google-Smtp-Source: AAOMgpcCjXqG4rqI8dWUJZfpxYw/Dy3PDYKD3ZYLzcADjIVJlx7VaWJNaVVzcgkxHSbe1DS3lMev0A==
X-Received: by 2002:ac8:1e12:: with SMTP id n18-v6mr13805200qtl.65.1530283792046;
        Fri, 29 Jun 2018 07:49:52 -0700 (PDT)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id q5-v6sm7314972qtq.66.2018.06.29.07.49.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jun 2018 07:49:51 -0700 (PDT)
Subject: Re: [PATCH v3 10/32] commit: add repository argument to
 parse_commit_buffer
To:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>
References: <20180629012222.167426-1-sbeller@google.com>
 <20180629012222.167426-11-sbeller@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c893b789-ea0b-7c84-c730-b156ecb605be@gmail.com>
Date:   Fri, 29 Jun 2018 10:49:49 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180629012222.167426-11-sbeller@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/28/2018 9:22 PM, Stefan Beller wrote:
> Add a repository argument to allow the callers of parse_commit_buffer
> to be more specific about which repository to act on. This is a small
> mechanical change; it doesn't change the implementation to handle
> repositories other than the_repository yet.
>
> As with the previous commits, use a macro to catch callers passing a
> repository other than the_repository at compile time.
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>   commit.c    | 4 ++--
>   commit.h    | 3 ++-
>   object.c    | 2 +-
>   sha1-file.c | 2 +-
>   4 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/commit.c b/commit.c
> index 4803c8be1df..75d0bdede84 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -363,7 +363,7 @@ const void *detach_commit_buffer(struct commit *commit, unsigned long *sizep)
>   	return ret;
>   }
>   
> -int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long size, int check_graph)
> +int parse_commit_buffer_the_repository(struct commit *item, const void *buffer, unsigned long size, int check_graph)
>   {
>   	const char *tail = buffer;
>   	const char *bufptr = buffer;
> @@ -448,7 +448,7 @@ int parse_commit_gently(struct commit *item, int quiet_on_missing)
>   		return error("Object %s not a commit",
>   			     oid_to_hex(&item->object.oid));
>   	}
> -	ret = parse_commit_buffer(item, buffer, size, 0);
> +	ret = parse_commit_buffer(the_repository, item, buffer, size, 0);
>   	if (save_commit_buffer && !ret) {
>   		set_commit_buffer(item, buffer, size);
>   		return 0;
> diff --git a/commit.h b/commit.h
> index cd80dab59c1..f326c13622b 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -82,7 +82,8 @@ struct commit *lookup_commit_reference_by_name(const char *name);
>    */
>   struct commit *lookup_commit_or_die(const struct object_id *oid, const char *ref_name);
>   
> -int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long size, int check_graph);
> +#define parse_commit_buffer(r, i, b, s, g) parse_commit_buffer_##r(i, b, s, g)
> +int parse_commit_buffer_the_repository(struct commit *item, const void *buffer, unsigned long size, int check_graph);
>   int parse_commit_gently(struct commit *item, int quiet_on_missing);
>   static inline int parse_commit(struct commit *item)
>   {

This part also conflicts with ds/commit-graph-fsck because I added a 
'parse_commit_internal' between parse_commit_buffer() and 
parse_commit_gently(). Likely, you'll want to add a repository struct to 
that method, too.

That series also adds new callers to parse_commit_buffer().

> diff --git a/object.c b/object.c
> index 530c55e41e4..5494c0cbaa1 100644
> --- a/object.c
> +++ b/object.c
> @@ -214,7 +214,7 @@ struct object *parse_object_buffer_the_repository(const struct object_id *oid, e
>   	} else if (type == OBJ_COMMIT) {
>   		struct commit *commit = lookup_commit(the_repository, oid);
>   		if (commit) {
> -			if (parse_commit_buffer(commit, buffer, size, 1))
> +			if (parse_commit_buffer(the_repository, commit, buffer, size, 1))
>   				return NULL;
>   			if (!get_cached_commit_buffer(commit, NULL)) {
>   				set_commit_buffer(commit, buffer, size);
> diff --git a/sha1-file.c b/sha1-file.c
> index de4839e634c..75ba30b4ab1 100644
> --- a/sha1-file.c
> +++ b/sha1-file.c
> @@ -1801,7 +1801,7 @@ static void check_commit(const void *buf, size_t size)
>   {
>   	struct commit c;
>   	memset(&c, 0, sizeof(c));
> -	if (parse_commit_buffer(&c, buf, size, 0))
> +	if (parse_commit_buffer(the_repository, &c, buf, size, 0))
>   		die("corrupt commit");
>   }
>   
