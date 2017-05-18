Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70B52201A7
	for <e@80x24.org>; Thu, 18 May 2017 01:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753717AbdERBpy (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 21:45:54 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35315 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752934AbdERBpx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 21:45:53 -0400
Received: by mail-wr0-f196.google.com with SMTP id g12so4071772wrg.2
        for <git@vger.kernel.org>; Wed, 17 May 2017 18:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=p5PeFrFS9StuSpSo20rVzMdaaEEHINgrxgQG/8tx6vU=;
        b=t4tr7OyuasxfbRpmF1d87o7JewJS7oeYelIzi9RMa0IXafBODh72FUa6IyRuX+fAP9
         vQNC7TzVuL3JPYPg9eJiG+v1DQHC+u9VLBRT3YvoXX1laCIyQYpKT4JOU7E6F4L0TNrX
         U9ULF2cbROL+M0bSpdRVNZPqEFsmKXl00soU7dC+m1320jcjekdAHcFmRAMUKQ0IX0Nz
         s+r9PCcANIvg/aaw1XtSzJz4yTOCkI1gUBXQbLM64OBGy6O8zpgyN5mhnWg5hbuOEg77
         IIy+LtIRrfpOVRv3MoC1V4j+lWuA2jPEXS09w27m8mo7wjGbnIZDQ44qHdes1ZQUfgIM
         URhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=p5PeFrFS9StuSpSo20rVzMdaaEEHINgrxgQG/8tx6vU=;
        b=l5PVcqK9xg3v4OVfPu6hJeeSnrAUWyPaxU07MVlEQPgpxitoTCMnRWR/ruJhVfXlzX
         V9pfRGlJhuAEB16aUskX6u8sVR2hRm2mvIq1gg7a0VFievbMrt6UhXZZpnc0mHmpcuZ6
         Ia+9i7JwWd6h2CxXAZf+EMzpv8H/FnSWh2Ujs1JY+tIClkfYU+/Zh8IO8D5N4mQjjBAH
         twd9+r1Eo3q0rnvC2HnH+8yUQaOjxLZ2HVUL+rbbuunRmNL7no+QuDlZc2+qV8gM21SG
         uxzNAiqsm9q/KUy3+/EoK+jTS9DZVE8JeNJ5kI2Nmas5ReUQCb9htQdpp38jWvXfYq0U
         o/bw==
X-Gm-Message-State: AODbwcAzc3e8erYP8en6DBlBv8fuicl8i+zITXi6mKF6fqDlW7K9cG1j
        dXfI4qa9OegFm+FZ2crxennyQoYFRg==
X-Received: by 10.46.0.65 with SMTP id 62mr582717lja.83.1495071951989; Wed, 17
 May 2017 18:45:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.46.71.69 with HTTP; Wed, 17 May 2017 18:45:31 -0700 (PDT)
In-Reply-To: <20170518014210.94189-1-manishearth@gmail.com>
References: <CACpkpxkGWhcALQZ2+2nOCRKgzAa7U7EjZg--S71zocdGY8NYag@mail.gmail.com>
 <20170518014210.94189-1-manishearth@gmail.com>
From:   Manish Goregaokar <manishearth@gmail.com>
Date:   Wed, 17 May 2017 18:45:31 -0700
X-Google-Sender-Auth: 7iQWach3aj8SuOdzF2lr1NQYiCc
Message-ID: <CACpkpxn1D_g=im0um4ncLiq3A18HRPpfu-sb1FLoY__tet0--Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] refs: Add for_each_worktree_ref for iterating over
 all worktree HEADs
To:     Manish Goregaokar <manishearth@gmail.com>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hm, my invocation of git-send-email keeps getting the threading wrong.
Is there a recommended set of arguments to the command?

Thanks,
-Manish Goregaokar


On Wed, May 17, 2017 at 6:42 PM,  <manishearth@gmail.com> wrote:
> From: Manish Goregaokar <manishearth@gmail.com>
>
> To ensure that `git prune` does not remove refs checked out
> in other worktrees, we need to include these HEADs in the
> set of roots. This adds the iteration function necessary
> to do this.
>
> Signed-off-by: Manish Goregaokar <manishearth@gmail.com>
> ---
>  refs.c | 20 ++++++++++++++++++++
>  refs.h |  1 +
>  2 files changed, 21 insertions(+)
>
> diff --git a/refs.c b/refs.c
> index 2d71774..7dc82ba 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3,10 +3,12 @@
>   */
>
>  #include "cache.h"
> +#include "commit.h"
>  #include "lockfile.h"
>  #include "refs.h"
>  #include "refs/refs-internal.h"
>  #include "object.h"
> +#include "worktree.h"
>  #include "tag.h"
>
>  /*
> @@ -1157,6 +1159,24 @@ int head_ref(each_ref_fn fn, void *cb_data)
>         return head_ref_submodule(NULL, fn, cb_data);
>  }
>
> +int for_each_worktree_ref(each_ref_fn fn, void *cb_data)
> +{
> +       int i, flag, retval = 0;
> +       struct object_id oid;
> +       struct worktree **worktrees = get_worktrees(GWT_SORT_LINKED);
> +       struct commit* commit;
> +       for (i = 0; worktrees[i]; i++) {
> +               if ((commit = lookup_commit_reference(worktrees[i]->head_sha1))) {
> +                       oid = commit->object.oid;
> +                       if (!read_ref_full("HEAD", RESOLVE_REF_READING, oid.hash, &flag)) {
> +                               if ((retval = fn("HEAD", &oid, flag, cb_data)))
> +                                       return retval;
> +                       }
> +               }
> +       }
> +       return retval;
> +}
> +
>  /*
>   * Call fn for each reference in the specified submodule for which the
>   * refname begins with prefix. If trim is non-zero, then trim that
> diff --git a/refs.h b/refs.h
> index 9fbff90..425a853 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -192,6 +192,7 @@ typedef int each_ref_fn(const char *refname,
>   * stop the iteration.
>   */
>  int head_ref(each_ref_fn fn, void *cb_data);
> +int for_each_worktree_ref(each_ref_fn fn, void *cb_data);
>  int for_each_ref(each_ref_fn fn, void *cb_data);
>  int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data);
>  int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data,
> --
> 2.10.1
>
