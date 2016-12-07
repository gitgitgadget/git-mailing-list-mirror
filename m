Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0F411FBB0
	for <e@80x24.org>; Wed,  7 Dec 2016 10:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751704AbcLGKH4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 05:07:56 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:36276 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751091AbcLGKH4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 05:07:56 -0500
Received: by mail-io0-f193.google.com with SMTP id s82so12608804ioi.3
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 02:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yDmjTyip7k4qd+QNzN25TKDQ0kXUUyjQqCXH/bisEII=;
        b=WFqUhDzU1Nf1U37nAIYpEok9LNZ+6YORsc6SuZrdA0dZjg78QINjRWWSh7KRe06uWV
         IJ/LzdkiQ7vdvbmEIU55r41E9m3rT9+7ut42ZlKocLK6H8NB04x7eEXuw9JHw5kOdnhc
         1kgIsg+UQUDP6dWuaHbb9MtHU+AtLGAkgiOtTI5tP65sHJqv10zU9ZUc1HN8i4HHEruU
         ff5XbM4JOStfzFZKUhDRttlW/8qT4NZK4pmehUC2Iaml4+5nTKE9KTU7/YZF9ZK1RDUV
         UxYk56thaWrBUry+6JbebpYYFGuCslNcZE/F1M9EHnkmbaLfoo76y03kIocMsX7qt99B
         2p8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yDmjTyip7k4qd+QNzN25TKDQ0kXUUyjQqCXH/bisEII=;
        b=SH5b7wmdIGiJ9HSwX1CWeevf1qhR3r1LeVAvqDZAGbza2w15k+GitmLqrm930bdatE
         b8PMOJOVVx3rxkOoTSg4NBK7Vj4HVVUSJgamyDnuW5uDvAQwsrFbTweQH95upk8ZYaWg
         n7nZLeIgo3wQLph3Cxk2Q7/F98ovIPvloiRGFZ2LYQSduNlDHjISAI7LWkzv6w+TNrSh
         4nJ+ggQGO5bYKd8EyonITK3xa5CP4kh4WdS2G5dsp7BzgBl23p5uAqQtvXFAdz55y7zY
         nLbWUW4f4ClmdoTlXxHk10RLRYcfSXf7KQLa9ruHoh0EfczB2bMEIvqBujaypNf/TVs5
         MClg==
X-Gm-Message-State: AKaTC03tBubA3yJa4vjai3wF/gXJ9JACqkIs15hYWWAaL056klEIcFTfNTs/Npdhz+Dt3VYcPJuPQy1jtI8m7A==
X-Received: by 10.36.26.148 with SMTP id 142mr1463967iti.74.1481105275189;
 Wed, 07 Dec 2016 02:07:55 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Wed, 7 Dec 2016 02:07:24 -0800 (PST)
In-Reply-To: <1481061106-117775-2-git-send-email-bmwill@google.com>
References: <1481061106-117775-1-git-send-email-bmwill@google.com> <1481061106-117775-2-git-send-email-bmwill@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 7 Dec 2016 17:07:24 +0700
Message-ID: <CACsJy8Bm+Nif_PL1=BzTYLKGrnz94rjKOB=_PXz6OB47Js6v2A@mail.gmail.com>
Subject: Re: [PATCH 01/17] mv: convert to using pathspec struct interface
To:     Brandon Williams <bmwill@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 7, 2016 at 4:51 AM, Brandon Williams <bmwill@google.com> wrote:
> Convert the 'internal_copy_pathspec()' function to use the pathspec
> struct interface from using the deprecated 'get_pathspec()' interface.
>
> In addition to this, fix a memory leak caused by only duplicating some
> of the pathspec elements.  Instead always duplicate all of the the
> pathspec elements as an intermediate step (with modificationed based on
> the passed in flags).  This way the intermediate strings can then be
> freed prior to duplicating the result of parse_pathspec (which contains
> each of the elements with the prefix prepended).
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  builtin/mv.c | 45 ++++++++++++++++++++++++++++++++-------------
>  1 file changed, 32 insertions(+), 13 deletions(-)

Stefan did something similar last year [1] but I couldn't find why it
did not get merged. Not sure if the reasons are still relevant or
not...

[1] http://public-inbox.org/git/%3C1438885632-26470-1-git-send-email-sbeller@google.com%3E/

> diff --git a/builtin/mv.c b/builtin/mv.c
> index 2f43877..4df4a12 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -4,6 +4,7 @@
>   * Copyright (C) 2006 Johannes Schindelin
>   */
>  #include "builtin.h"
> +#include "pathspec.h"
>  #include "lockfile.h"
>  #include "dir.h"
>  #include "cache-tree.h"
> @@ -25,25 +26,43 @@ static const char **internal_copy_pathspec(const char *prefix,
>  {
>         int i;
>         const char **result;
> +       struct pathspec ps;
>         ALLOC_ARRAY(result, count + 1);
> -       COPY_ARRAY(result, pathspec, count);
> -       result[count] = NULL;
> +
> +       /* Create an intermediate copy of the pathspec based on the flags */
>         for (i = 0; i < count; i++) {
> -               int length = strlen(result[i]);
> +               int length = strlen(pathspec[i]);
>                 int to_copy = length;
> +               char *it;
>                 while (!(flags & KEEP_TRAILING_SLASH) &&
> -                      to_copy > 0 && is_dir_sep(result[i][to_copy - 1]))
> +                      to_copy > 0 && is_dir_sep(pathspec[i][to_copy - 1]))
>                         to_copy--;
> -               if (to_copy != length || flags & DUP_BASENAME) {
> -                       char *it = xmemdupz(result[i], to_copy);
> -                       if (flags & DUP_BASENAME) {
> -                               result[i] = xstrdup(basename(it));
> -                               free(it);
> -                       } else
> -                               result[i] = it;
> -               }
> +
> +               it = xmemdupz(pathspec[i], to_copy);
> +               if (flags & DUP_BASENAME) {
> +                       result[i] = xstrdup(basename(it));
> +                       free(it);
> +               } else
> +                       result[i] = it;
> +       }
> +       result[count] = NULL;
> +
> +       parse_pathspec(&ps,
> +                      PATHSPEC_ALL_MAGIC &
> +                      ~(PATHSPEC_FROMTOP | PATHSPEC_LITERAL),
> +                      PATHSPEC_KEEP_ORDER | PATHSPEC_PREFER_CWD,
> +                      prefix, result);
> +       assert(count == ps.nr);
> +
> +       /* Copy the pathspec and free the old intermediate strings */
> +       for (i = 0; i < count; i++) {
> +               const char *match = xstrdup(ps.items[i].match);
> +               free((char *) result[i]);
> +               result[i] = match;

Sigh.. it looks so weird that we do all the parsing (in a _copy_
pathspec function) then remove struct pathspec and return the plain
string. I guess we can't do anything more until we rework cmd_mv code
to handle pathspec natively.

At the least I think we should rename this function to something else.
But if you have time I really wish we could kill this function. I
haven't stared at cmd_mv() long and hard, but it looks to me that we
combining two separate functionalities in the same function here.

If "mv" takes n arguments, then the first <n-1> arguments may be
pathspec, the last one is always a plain path. The "dest_path =
internal_copy_pathspec..." could be as simple as "dest_path =
prefix_path(argv[argc - 1])". the special treatment for this last
argument [1] can live here. Then, we can do parse_pathspec for the
<n-1> arguments in cmd_mv(). It's still far from perfect, because
cmd_mv can't handle pathspec properly, but it reduces the messy mess
in internal_copy_pathspec a bit, I hope.

[1] c57f628 (mv: let 'git mv file no-such-dir/' error out - 2013-12-03)

>         }
> -       return get_pathspec(prefix, result);
> +
> +       clear_pathspec(&ps);
> +       return result;
>  }
>
>  static const char *add_slash(const char *path)
> --
> 2.8.0.rc3.226.g39d4020
>



-- 
Duy
