Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FE131F51C
	for <e@80x24.org>; Sun, 20 May 2018 17:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752367AbeETRpP (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 13:45:15 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:40087 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751521AbeETRpO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 May 2018 13:45:14 -0400
Received: by mail-wm0-f46.google.com with SMTP id j5-v6so22868242wme.5
        for <git@vger.kernel.org>; Sun, 20 May 2018 10:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f/r/x93gGu3jXwAzNyNg1nPEsGqzHVoTSFaIttJKMqY=;
        b=kPZISk4TwD1oxGb9OU7CtJUPTzpYTf7bhL8b1YcffvUbM9fAMbcm6Odlu1V4hDJfuM
         sKz+rj7B5KvIqIJHuukRwAWFSuLb1+nD7d0llB3o0v7gSZ8EbaKqz+oy/2EI/Wihx4+d
         7QI5YDwc0EKd2QFgnwmMk+a6lEChrKDnZO1G5Ajz4cEWF8WvYMpeQvqWwFu+EfYFLiVD
         qhaiGPLhhShbdat8j0H8Y3j/OUJJKEKzUsESRTmOZq3Sbnzmrsd2qrVMJBZK6OstPkwh
         JYWYgwz30arYTR9esZ09oFY8dsTdwH0h2AWFTNIH0K7i7SlwF8Rm0+BvI8YUcRZyiCwz
         EOgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f/r/x93gGu3jXwAzNyNg1nPEsGqzHVoTSFaIttJKMqY=;
        b=mi40ULyApsNM5UsCwSK9l0WsRARZkkgoMzmD2F7ibwMxWVfw0weDaCzbJmxlaKnkV3
         oR50j61BRK7KJ9MIqRaP6iIcJNchi7WR5j6BSin8RDr8SPi09Ch/ZEyc75TW21JtBRrD
         wWjZMFLX+/86hgDQW3S0nCraJHsa3S85WnuYvmfBNV52wtQxg6465mDv2zwEJv/OMJgB
         NcelOtXAu3px/IL1IAq70TW39Uaf0IDddBCvGOcoApLM8nJ6hkACHhaTla3GawSW+gYC
         oMxhlM2to1wGjuESM/pzPIMt99/gFYYr0p18U6EfBs8vAKBJcpTS2oGeHdqF6ICJr5HQ
         7PtQ==
X-Gm-Message-State: ALKqPwd7+LswICNYFJjooMH+fwsubpNlFgaGXgUeK0UPQnWKdnWJsq8p
        HWs6Gydju4GZt+wLFtSRCvg=
X-Google-Smtp-Source: AB8JxZojFdsAqOdSmCcekVau7ZcszZEd4MnsFsqqTJBlvUtALmdYDbgRA9XN4V9qF5NpVcMWgZn7WQ==
X-Received: by 2002:a1c:eacc:: with SMTP id g73-v6mr9871026wmi.137.1526838312805;
        Sun, 20 May 2018 10:45:12 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id h196-v6sm13876792wme.1.2018.05.20.10.45.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 20 May 2018 10:45:11 -0700 (PDT)
Date:   Sun, 20 May 2018 18:45:37 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     pclouds@gmail.com, ao2@ao2.it, bmwill@google.com,
        git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 07/11] rerere: use repo_read_index_or_die
Message-ID: <20180520174537.GA18193@hank.intra.tgummerer.com>
References: <CACsJy8A8WZ-Gqe2Y-whJmbADrt+gZjLZ7MTwCtdnK7JDnEdtog@mail.gmail.com>
 <20180516222118.233868-1-sbeller@google.com>
 <20180516222118.233868-8-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516222118.233868-8-sbeller@google.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/16, Stefan Beller wrote:
> By switching to repo_read_index_or_die, we'll get a slightly different
> error message ("index file corrupt") as well as localization of it.

Apart from the slightly different error message, and the localization
(both of which I think are a good thing), I notice that this also
turns a "return error(...)" into a "die(...)".  I thought we were
going more towards not 'die'ing in libgit.a code, and letting the
caller handling the errors?  Either way I think this change should be
described in the commit message.

Also all other messages in 'rerere.c' are currently not translated.
I'm currently working on a series that includes a patch to do just
that (amongst some other changes to 'rerere'), which I'm hoping to
send soon-ish, but the textual conflicts should we still want this
patch should be easy to solve.

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  rerere.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/rerere.c b/rerere.c
> index 18cae2d11c9..5f35dd66f90 100644
> --- a/rerere.c
> +++ b/rerere.c
> @@ -10,6 +10,7 @@
>  #include "attr.h"
>  #include "pathspec.h"
>  #include "sha1-lookup.h"
> +#include "repository.h"
>  
>  #define RESOLVED 0
>  #define PUNTED 1
> @@ -567,8 +568,7 @@ static int check_one_conflict(int i, int *type)
>  static int find_conflict(struct string_list *conflict)
>  {
>  	int i;
> -	if (read_cache() < 0)
> -		return error("Could not read index");
> +	repo_read_index_or_die(the_repository);
>  
>  	for (i = 0; i < active_nr;) {
>  		int conflict_type;
> @@ -600,8 +600,7 @@ int rerere_remaining(struct string_list *merge_rr)
>  	int i;
>  	if (setup_rerere(merge_rr, RERERE_READONLY))
>  		return 0;
> -	if (read_cache() < 0)
> -		return error("Could not read index");
> +	repo_read_index_or_die(the_repository);
>  
>  	for (i = 0; i < active_nr;) {
>  		int conflict_type;
> @@ -1103,8 +1102,7 @@ int rerere_forget(struct pathspec *pathspec)
>  	struct string_list conflict = STRING_LIST_INIT_DUP;
>  	struct string_list merge_rr = STRING_LIST_INIT_DUP;
>  
> -	if (read_cache() < 0)
> -		return error("Could not read index");
> +	repo_read_index_or_die(the_repository);
>  
>  	fd = setup_rerere(&merge_rr, RERERE_NOAUTOUPDATE);
>  	if (fd < 0)
> -- 
> 2.17.0.582.gccdcbd54c44.dirty
> 
