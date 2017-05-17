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
	by dcvr.yhbt.net (Postfix) with ESMTP id D57EF2023D
	for <e@80x24.org>; Wed, 17 May 2017 00:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751571AbdEQAIp (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 20:08:45 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36001 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751436AbdEQAIo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 20:08:44 -0400
Received: by mail-lf0-f66.google.com with SMTP id h4so4529710lfj.3
        for <git@vger.kernel.org>; Tue, 16 May 2017 17:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=9dBrrotKcZ4QW4/G6zMENwg5vdO1JtlKBbjZ8Q1DV+o=;
        b=HIZQzrqpOTbbqaTst9yQaIpbaoy0DgK+CHxxtzjIlnuMEqM/J3+tx48jInWpyDfMRn
         Kb+XYBrHlP4UokGtuT4hQf4oEuXizviIp63MxTNEag2YWXvbKsbHiNavd2PG64GUifol
         ZQtxkelqro9FCKyd5KLxr/mqUP6fiHzrD2Q6UJyumVaxFZF5N95m/R1fq4ngu/slXRt5
         vZqG9E/o4GMBL5ld8we/MLqoMWkWqpCh8T4P9OmymgG+/Ybj7qO7RyyH8KU+D+H8pdYg
         ZfGKYpQQpn2zz/XUrbR9YndxdvG/vtsUM3N/3CIz58S2mOWfzfzWVDhwHFKULszsgMr3
         mDDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=9dBrrotKcZ4QW4/G6zMENwg5vdO1JtlKBbjZ8Q1DV+o=;
        b=kha0hxs6ph96OXNSzx0Oqcg6rxRzwIruBveyBMOBHmFjddN8pJb1w95iPYhWFnTK45
         yvqlvRfZ8fwZyy/VizG6+FwnS5awd8vRYm7RNRLXzYnH78jcpQS12uDA/bbqHfCChHe2
         Yp3Fr6SkTFUFrIEVDv10C7GrDs/xrTuikVFFnjL5mQo0Fa7bz8HBy3351PtL5tL3RnXX
         haixi/nfQZ6qAuO7UIP8M5XI57/4atqfR3J1X7pByUL4sMeLynfq0WbpXtdKIJQjtsFm
         wHLcPqSrVs5I7WAkcQxbZIgtu2TG6/LSJHYJHpLGUWyQ8BLI9idgxuHJ6sJKQUBebHfD
         nDgQ==
X-Gm-Message-State: AODbwcAs4S+M41+s0Hg+Cx9qQBrZcphOEi62ucOvpWva+5Tou+3k+lx2
        0G4zSPMwk4cnKYiG6XHDEG5KwhbVbA==
X-Received: by 10.25.156.75 with SMTP id f72mr161267lfe.77.1494979723001; Tue,
 16 May 2017 17:08:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.46.71.69 with HTTP; Tue, 16 May 2017 17:08:22 -0700 (PDT)
In-Reply-To: <CACpkpxn4zSdUMT-i6XWBR77sQTpr5-vudbLVTCs1_hiv7a2t_w@mail.gmail.com>
References: <CACpkpxn4zSdUMT-i6XWBR77sQTpr5-vudbLVTCs1_hiv7a2t_w@mail.gmail.com>
From:   Manish Goregaokar <manishearth@gmail.com>
Date:   Tue, 16 May 2017 17:08:22 -0700
X-Google-Sender-Auth: -PEv__jlaz__dv8WkZJFYgwA1mw
Message-ID: <CACpkpx=O4UxrELRO3ojbbRL2LShcw0MLq=_4Dyck8csbwca9CQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] refs: Add for_each_worktree_ref for iterating over
 all worktree HEADs
To:     Manish Goregaokar <manishearth@gmail.com>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From 3f8015efdcc122e0d345baeb5f1f0485a9f0fcd8 Mon Sep 17 00:00:00 2001
From: Manish Goregaokar <manishearth@gmail.com>
Date: Tue, 16 May 2017 16:46:36 -0700
Subject: [PATCH 2/2] reachable: Add HEADs of all worktrees to reachability
 analysis

* reachable.c:
  mark_reachable_objects: Include other worktrees

Signed-off-by: Manish Goregaokar <manishearth@gmail.com>
---
 reachable.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/reachable.c b/reachable.c
index d0199ca..439708e 100644
--- a/reachable.c
+++ b/reachable.c
@@ -178,6 +178,9 @@ void mark_reachable_objects(struct rev_info *revs,
int mark_reflog,
     /* detached HEAD is not included in the list above */
     head_ref(add_one_ref, revs);

+    /* worktrees are not included in either */
+    for_each_worktree_ref(add_one_ref, revs);
+
     /* Add all reflog info */
     if (mark_reflog)
         add_reflogs_to_pending(revs, 0);
-- 
2.10.1

-Manish Goregaokar


On Tue, May 16, 2017 at 5:07 PM, Manish Goregaokar
<manishearth@gmail.com> wrote:
> Git prune will happily delete commits checked out in other worktrees.
> This is probably not desired.
>
> (Tabs have been converted to spaces in this email sadly, because GMail
> garbles these. This should suffice for review, and I'll send the patch
> as an attachment or in some other form when done so that it can be
> cleanly applied. Let me know if this won't work.)
>
>
> Thanks!
>
> Patch 1/2 follows (based on maint)
>
> -----
>
> From c3657cd0bb61921053fad4dd669589780881c574 Mon Sep 17 00:00:00 2001
> From: Manish Goregaokar <manishearth@gmail.com>
> Date: Tue, 16 May 2017 16:46:00 -0700
> Subject: refs: Add for_each_worktree_ref for iterating over all worktree HEADs
>
> To ensure that `git prune` does not remove refs checked out
> in other worktrees, we need to include these HEADs in the
> set of roots. This adds the iteration function necessary
> to do this.
>
> Signed-off-by: Manish Goregaokar <manishearth@gmail.com>
> ---
>  refs.c | 16 ++++++++++++++++
>  refs.h |  1 +
>  2 files changed, 17 insertions(+)
>
> diff --git a/refs.c b/refs.c
> index 2d71774..27e0b60 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3,6 +3,7 @@
>   */
>
>  #include "cache.h"
> +#include "commit.h"
>  #include "lockfile.h"
>  #include "refs.h"
>  #include "refs/refs-internal.h"
> @@ -1157,6 +1158,21 @@ int head_ref(each_ref_fn fn, void *cb_data)
>      return head_ref_submodule(NULL, fn, cb_data);
>  }
>
> +int for_each_worktree_ref(each_ref_fn fn, void *cb_data)
> +{
> +    int i, flag, retval;
> +    struct object_id oid;
> +    struct worktree **worktrees = get_worktrees(GWT_SORT_LINKED);
> +    for (i = 0; worktrees[i]; i++) {
> +        struct commit* commit =
> lookup_commit_reference(worktrees[i]->head_sha1);
> +        oid = commit->object.oid;
> +        if (!read_ref_full("HEAD", RESOLVE_REF_READING, oid.hash, &flag)) {
> +            if (retval = fn("HEAD", &oid, flag, cb_data))
> +                return retval;
> +        }
> +    }
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
