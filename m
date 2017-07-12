Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF0482035A
	for <e@80x24.org>; Wed, 12 Jul 2017 00:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755934AbdGLALZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 20:11:25 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34230 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752939AbdGLALY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 20:11:24 -0400
Received: by mail-pg0-f65.google.com with SMTP id j186so849761pge.1
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 17:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=PqJ2rAj178Mjpj4hJPf6jjQbqmD0AolhEdnN/Cvkx9g=;
        b=kq0PVysMu27MD/cbdREue+Za/k+VsqQUMX//4QTiGiVpqVIDeC5iUZAdUPB3zGSMd+
         4aejWBRSzZc3CeZXkbZoyKCRxhrorKOdeoPJjLfDmWpF92xnTmPOu+C+jJuYZytWggDO
         gk4ZmLM2ZcCVblKqwUjyxSP+LlIc08H7gwbCSpA4J+mQwaSTT2WkWHF5fidWWTCFakFD
         j2/pOzHwmNNBQIVgHSatQIvDeOfIbb5P9zAthlIiiozkxMjZvEAQQRP3F+Y2zcmDnFup
         toA7e3AXGVeCZ1/3OwjGxgnS0O/KtIth9H/C59qH78hapTYPTqRaA3XWigWDyaJTHwDz
         2WlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=PqJ2rAj178Mjpj4hJPf6jjQbqmD0AolhEdnN/Cvkx9g=;
        b=nDQJH4KsQV1QD5SdaxoQ4W2Kid2gnPM3U4qrrqc7QFrYyMrHPuL6MV/u9P75NQdhkq
         YYimFmAuyPlo6WxMPSAS28le3E0G9+wTxucU6CF/rLKhuMy/LRmAcnXBw1boTBF+SAbl
         NA18vPC4zv6/U/WLCArc8DuQXA1Ylz+rHa1Vrs8VqCGisbCILmnGArDGe6D4k2kvJvzr
         uAnrwKTPseB9LX9I+xapLGIEvQI1S/HWOZ6cARn8wXzb8sknga4GuvH7t5fO4EYmFsQu
         fvS5p/8Ge/P5VH3hjsCe3JLD3OtC0jP6ol6wjPdJ1k3EyKBSvrCiAGvrqbRq27Q1LOmt
         Pg0Q==
X-Gm-Message-State: AIVw112Nm04eAV+AQgBCXSBSBMwuqdeGfCKsvwdHgKfP5u0eLxYzfq2t
        i3FVhobeUN7M0g==
X-Received: by 10.99.185.28 with SMTP id z28mr1045962pge.123.1499818283075;
        Tue, 11 Jul 2017 17:11:23 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:fdda:b931:7ea7:8e3c])
        by smtp.gmail.com with ESMTPSA id r27sm893920pfe.0.2017.07.11.17.11.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 11 Jul 2017 17:11:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH 2/3] setup: have the_repository use the_index
References: <20170711220408.173269-1-bmwill@google.com>
        <20170711220408.173269-3-bmwill@google.com>
Date:   Tue, 11 Jul 2017 17:11:21 -0700
In-Reply-To: <20170711220408.173269-3-bmwill@google.com> (Brandon Williams's
        message of "Tue, 11 Jul 2017 15:04:07 -0700")
Message-ID: <xmqqzica1pli.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Have the index state which is stored in 'the_repository' be a pointer to
> the in-core instead 'the_index'.  This makes it easier to begin
> transitioning more parts of the code base to operate on a 'struct
> repository'.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  setup.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/setup.c b/setup.c
> index 860507e1f..b370bf3c1 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -1123,6 +1123,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
>  			setup_git_env();
>  		}
>  	}
> +	the_repository->index = &the_index;
>  
>  	strbuf_release(&dir);
>  	strbuf_release(&gitdir);

I would have expected this to be going in the different direction,
i.e. there is an embedded instance of index_state in a repository
object, and the_repository.index is defined to be the old the_index,
i.e.

	#define the_index (the_repository.index)

When a Git command that recurses into submodules in-core using
the_repository that represents the top-level superproject and
another repository object tht represents a submodule, don't we want
the repository object for the submodule also have its own default
index without having to allocate one and point at it with the index
field?

I dunno.  Being able to leave the index field NULL lets you say
"this is a bare repository and there is no place for the index file
for it", but even if we never write out the in-core index to an
index file on disk, being able to populate the in-core index that is
default for the repository object from a tree-ish and iterating over
it (e.g.  running in-core merge of trees) is a useful thing to do,
so I do not consider "index field can be set to NULL to signify a
bare repository" a very strong plus.

