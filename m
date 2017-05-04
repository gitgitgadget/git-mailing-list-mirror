Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B74D207D6
	for <e@80x24.org>; Thu,  4 May 2017 21:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751856AbdEDVpN (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 17:45:13 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:36080 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751508AbdEDVpN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 17:45:13 -0400
Received: by mail-io0-f195.google.com with SMTP id x86so6652352ioe.3
        for <git@vger.kernel.org>; Thu, 04 May 2017 14:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=QHFygv5d6OP6Qrf1zS1yUxZTkxyQEFuwXkI9oL9+TjM=;
        b=SktxBFy3v62BGn/p4EXNUsr7s/NEE5ablYTGptYVbnpRD9U7qeVte5E8vtBKO3fHfs
         Y9Y0VkNswFeBrT+WJZTgD3UksisK5YMLa2X/l8+L0b2ILFBZn49yxg+Nq0I+/hfNNbP/
         CL9MLawYVMSVm+nUAwrKtSqUBINJI7U7S7u+RgI+isjLGZrz3iAcrg3cJvIE1fb9AZQl
         pff1drpNY4tcBHKSylDbEga7R6tojHw1NcUZbpq9GkY6WRagqcwBE6qSeLq/2bD7L+5D
         5f0m6MnWgvG5bBPlrgx5bXkScZcWj0095h6fPQSjTr6WenjSUKxtzqs+m1FqfzquSk8q
         y15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to;
        bh=QHFygv5d6OP6Qrf1zS1yUxZTkxyQEFuwXkI9oL9+TjM=;
        b=PrahkvqZoCKTZA7hL0hzWWMqVxIYSm9415/TLoplGSUbs2knd6psonnTuU5lLjFIyU
         z7v5h6UuM4NJRbsYiFrwQ1fgrA/ABnY4oIeX22jYtCGz/fFx7VxqLJHyIAUu7OrtqXNB
         IIlyfZkQ3N6eiGH5LbrmfGf8n9VuKxMoKcGSbC+Yyd/03qX/H7vuIEjQU8AdeeFrqJfR
         0EBdfQQOh/CHtj/GH/OtScx1fCqS/Gr9mhNaxbRNhlzypAOH6VABDgEhezJf2tbdUgLn
         mJUIxOnWvrmkbJUI50Az+kKBb3ymYUy+r3ThV41Oy7oDAz6rCRoTqIDwAABmBnY4slAL
         NFjQ==
X-Gm-Message-State: AN3rC/5qM4sp/Kv4c1xFPEouh97U0wQ97W7V/1en/oHEW8Bd5TE/YWlI
        OFM1i7ZvnyU2iwzGsJNZA0OPVJYS3faE
X-Received: by 10.157.40.74 with SMTP id h10mr11031924otd.209.1493934311888;
 Thu, 04 May 2017 14:45:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.182.11.4 with HTTP; Thu, 4 May 2017 14:45:11 -0700 (PDT)
In-Reply-To: <1493933779-25611-1-git-send-email-miguel.torroja@gmail.com>
References: <20170425055817.codq2q3fd54uebfx@sigill.intra.peff.net> <1493933779-25611-1-git-send-email-miguel.torroja@gmail.com>
From:   miguel torroja <miguel.torroja@gmail.com>
Date:   Thu, 4 May 2017 21:45:11 +0000
X-Google-Sender-Auth: C17yBeAg5ExPlDt4JQJwWA0kIoY
Message-ID: <CAKYtbVZTnNG8Y-kZKQun9aYdwq9bR2_FX9L3gm+25qj6i7XyAQ@mail.gmail.com>
Subject: Re: [PATCH] fast-export: deletion action first
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous patch reorders the delete operations in fast-export
(preceding any other one), keeps renaming as last operations to
process (as original source code) and for any other operation it keeps
the same order as "diff"

The non deterministic reordering was one of the concerns when I first
sent the patch.
The behavior for the other corner cases pointed out by Jeff
(delete/rename dir/file ) are not tackled in this patch and the final
result is unknown.


On Thu, May 4, 2017 at 9:36 PM, Miguel Torroja <miguel.torroja@gmail.com> wrote:
>
> The delete operations of the fast-export output should precede any addition
> belonging to the same commit, Addition and deletion with the same name
> entry could happen in case of file to directory and viceversa.
>
> As an equal comparison doesn't have any deterministic final order,
> it's better to keep original diff order input when there is no prefer order
> ( that's done comparing pointers)
>
> The fast-export sorting was added in 060df62 (fast-export: Fix output
> order of D/F changes). That change was made in order to fix the case of
> directory to file in the same commit, but it broke the reverse case
> (File to directory).
>
> The test "file becomes directory" has been added in order to exercise
> the original motivation of the deletion reorder.
>
> Signed-off-by: Miguel Torroja <miguel.torroja@gmail.com>
> ---
>  builtin/fast-export.c  | 32 +++++++++++++++-----------------
>  t/t9350-fast-export.sh | 25 +++++++++++++++++++++++++
>  2 files changed, 40 insertions(+), 17 deletions(-)
>
> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> index e022063..e82f654 100644
> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> @@ -260,26 +260,19 @@ static void export_blob(const struct object_id *oid)
>                 free(buf);
>  }
>
> -static int depth_first(const void *a_, const void *b_)
> +/*
> + * Compares two diff types to order based on output priorities.
> + */
> +static int diff_type_cmp(const void *a_, const void *b_)
>  {
>         const struct diff_filepair *a = *((const struct diff_filepair **)a_);
>         const struct diff_filepair *b = *((const struct diff_filepair **)b_);
> -       const char *name_a, *name_b;
> -       int len_a, len_b, len;
>         int cmp;
>
> -       name_a = a->one ? a->one->path : a->two->path;
> -       name_b = b->one ? b->one->path : b->two->path;
> -
> -       len_a = strlen(name_a);
> -       len_b = strlen(name_b);
> -       len = (len_a < len_b) ? len_a : len_b;
> -
> -       /* strcmp will sort 'd' before 'd/e', we want 'd/e' before 'd' */
> -       cmp = memcmp(name_a, name_b, len);
> -       if (cmp)
> -               return cmp;
> -       cmp = len_b - len_a;
> +       /*
> +        * Move Delete entries first so that an addition is always reported after
> +        */
> +       cmp = (b->status == DIFF_STATUS_DELETED) - (a->status == DIFF_STATUS_DELETED);
>         if (cmp)
>                 return cmp;
>         /*
> @@ -287,7 +280,12 @@ static int depth_first(const void *a_, const void *b_)
>          * appear in the output before it is renamed (e.g., when a file
>          * was copied and renamed in the same commit).
>          */
> -       return (a->status == 'R') - (b->status == 'R');
> +       cmp = (a->status == DIFF_STATUS_RENAMED) - (b->status == DIFF_STATUS_RENAMED);
> +       if (cmp)
> +               return cmp;
> +
> +       /* For the remaining cases we keep the original ordering comparing the pointers */
> +       return (a-b);
>  }
>
>  static void print_path_1(const char *path)
> @@ -347,7 +345,7 @@ static void show_filemodify(struct diff_queue_struct *q,
>          * Handle files below a directory first, in case they are all deleted
>          * and the directory changes to a file or symlink.
>          */
> -       QSORT(q->queue, q->nr, depth_first);
> +       QSORT(q->queue, q->nr, diff_type_cmp);
>
>         for (i = 0; i < q->nr; i++) {
>                 struct diff_filespec *ospec = q->queue[i]->one;
> diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
> index b5149fd..d4f369a 100755
> --- a/t/t9350-fast-export.sh
> +++ b/t/t9350-fast-export.sh
> @@ -419,6 +419,31 @@ test_expect_success 'directory becomes symlink'        '
>         (cd result && git show master:foo)
>  '
>
> +test_expect_success 'file becomes directory'  '
> +       git init filetodir_orig &&
> +       git init --bare filetodir_replica.git &&
> +       (
> +               cd filetodir_orig &&
> +               echo foo > filethendir &&
> +               git add filethendir &&
> +               test_tick &&
> +               git commit -mfile &&
> +               git rm filethendir &&
> +               mkdir filethendir &&
> +               echo bar > filethendir/a &&
> +               git add filethendir/a &&
> +               test_tick &&
> +               git commit -mdir
> +       ) &&
> +       git --git-dir=filetodir_orig/.git fast-export master  |
> +               git --git-dir=filetodir_replica.git/ fast-import &&
> +       (
> +               ORIG=$(git --git-dir=filetodir_orig/.git rev-parse --verify master) &&
> +               REPLICA=$(git --git-dir=filetodir_replica.git rev-parse --verify master) &&
> +               test $ORIG = $REPLICA
> +       )
> +'
> +
>  test_expect_success 'fast-export quotes pathnames' '
>         git init crazy-paths &&
>         (cd crazy-paths &&
> --
> 2.1.4
>
