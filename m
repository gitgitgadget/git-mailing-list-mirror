Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FCA920281
	for <e@80x24.org>; Fri,  3 Nov 2017 00:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964837AbdKCAYQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 20:24:16 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:52826 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934556AbdKCAYO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 20:24:14 -0400
Received: by mail-wm0-f50.google.com with SMTP id t139so2114584wmt.1
        for <git@vger.kernel.org>; Thu, 02 Nov 2017 17:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ENljxUw8QqeJIsvXg3/1HbeGxPYt/+rGwIoHri/CojE=;
        b=SmRVG09/hPcBpHP1S10i5P+Zbj3DdSeSzLbZbiNK0OoIfU0/IFp6fSJlWfs/zDM9Lv
         LW4X8OHfq257aT9xvcytrfWmHTUWWmq6DDM6zO/7Badu+S2w/0EvT/lT8E6F1GoBSr37
         u3h5WGFXgdx33uhD4kXA52kiAGxsZ18Vah+TETqWZufYpCyy/CnRPPE4eLhucLg8rEsa
         VvrBjFPBOLvwCUyx4NrWcGJsX8TgpUhampl9bgJFP0iBdHa0Y6h96dgkNsTTgfxKMgZR
         MjVvuT/MdAOU7TOX53+Dij8FFTyc2YOEfefJQjZWbhHtH9h0rDIHBtLBz4+nfgjxREfz
         kKVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ENljxUw8QqeJIsvXg3/1HbeGxPYt/+rGwIoHri/CojE=;
        b=Y76M5HDmZH8Zvz8oEjeRVJOXqkYoQNihcp58Y/t5wwVXvRLXiKQFR9xfCvdKRNo4Lp
         JfuLXqGbBIlW/9ZwN4NIvz4ZYay0xM7Mt2E4bjRR7TU7levp9rVaVAbkBc3xxCppDz7l
         1TZdSGx9lIVz8Wkc7UhHVpTeBD3y0BIONfIt4n89d1D3NSdQWuWhz6shFAvLI/AtUuMZ
         CfpbuiCKCAY0/6dO9rklkTz1zRbHdsDx7W5jJ/j7fdlB7UNMEch0g7TcfGk6FXT4eMK7
         hrqP4V4A9Y/GqNKzSWaCp+Ad8UglvUjeWPINrcbcdD0QAI/MOwziNDSfyvfdLCsw7nEl
         9agw==
X-Gm-Message-State: AMCzsaVedPshD9ui0CfAExdTjWTyD36FjTDGuBFB45XXPuEkbFRCAV2q
        tEbNznpElnkpfhE506Jw5IejrnMWOuTvRGnNUcA=
X-Google-Smtp-Source: ABhQp+TsnXDGgSEBU9avxbpbpuxJo/KcxJ3EvDSl3+6yfcUcLXfJ69R1Cxa0zxxHXBZR9k9pscUfs3h/rQPyofuOfu0=
X-Received: by 10.80.137.91 with SMTP id f27mr6224898edf.18.1509668652020;
 Thu, 02 Nov 2017 17:24:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.213.80 with HTTP; Thu, 2 Nov 2017 17:23:51 -0700 (PDT)
In-Reply-To: <20171102194148.2124-1-sbeller@google.com>
References: <20171031211852.13001-1-sbeller@google.com> <20171102194148.2124-1-sbeller@google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 2 Nov 2017 17:23:51 -0700
Message-ID: <CA+P7+xr0owJt4qvWeNkWhEionJ4468h0pTdB+h-FrEaBqi375w@mail.gmail.com>
Subject: Re: [PATCHv3 0/7] git describe blob
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git mailing list <git@vger.kernel.org>,
        Kevin Daudt <me@ikke.info>,
        Andreas Schwab <schwab@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 2, 2017 at 12:41 PM, Stefan Beller <sbeller@google.com> wrote:
> Thanks for the discussion on v2[1].
>
> Interdiff is below, just fixing minor things.
>
> We'll keep the original algorithm for now, deferring an improvement on
> the algorithm front towards a future developer.
>

I agree, "something" is better than "nothing", and we can work to
improve "something" in the future, especially after we get more real
use and see what people think. Only question would be how much do we
need to document the current behavior might be open for improvement?

> Thanks,
> Stefan
>
> [1] https://public-inbox.org/git/20171031211852.13001-1-sbeller@google.com/
>
> Stefan Beller (7):
>   t6120: fix typo in test name
>   list-objects.c: factor out traverse_trees_and_blobs
>   revision.h: introduce blob/tree walking in order of the commits
>   builtin/describe.c: rename `oid` to avoid variable shadowing
>   builtin/describe.c: print debug statements earlier
>   builtin/describe.c: factor out describe_commit
>   builtin/describe.c: describe a blob
>
>  Documentation/git-describe.txt     |  13 +++-
>  Documentation/rev-list-options.txt |   5 ++
>  builtin/describe.c                 | 125 ++++++++++++++++++++++++++++---------
>  list-objects.c                     |  52 +++++++++------
>  revision.c                         |   2 +
>  revision.h                         |   3 +-
>  t/t6100-rev-list-in-order.sh       |  47 ++++++++++++++
>  t/t6120-describe.sh                |  17 ++++-
>  8 files changed, 214 insertions(+), 50 deletions(-)
>  create mode 100755 t/t6100-rev-list-in-order.sh
> diff --git c/Documentation/git-describe.txt w/Documentation/git-describe.txt
> index 077c3c2193..79ec0be62a 100644
> --- c/Documentation/git-describe.txt
> +++ w/Documentation/git-describe.txt
> @@ -11,7 +11,7 @@ SYNOPSIS
>  [verse]
>  'git describe' [--all] [--tags] [--contains] [--abbrev=<n>] [<commit-ish>...]
>  'git describe' [--all] [--tags] [--contains] [--abbrev=<n>] --dirty[=<mark>]
> -'git describe' [<options>] <blob-ish>
> +'git describe' [<options>] <blob>
>
>  DESCRIPTION
>  -----------
> diff --git c/builtin/describe.c w/builtin/describe.c
> index 382cbae908..cf08bef344 100644
> --- c/builtin/describe.c
> +++ w/builtin/describe.c
> @@ -440,6 +440,7 @@ struct process_commit_data {
>         struct object_id current_commit;
>         struct object_id looking_for;
>         struct strbuf *dst;
> +       struct rev_info *revs;
>  };
>
>  static void process_commit(struct commit *commit, void *data)
> @@ -456,6 +457,7 @@ static void process_object(struct object *obj, const char *path, void *data)
>                 reset_revision_walk();
>                 describe_commit(&pcd->current_commit, pcd->dst);
>                 strbuf_addf(pcd->dst, ":%s", path);
> +               pcd->revs->max_count = 0;
>         }
>  }
>
> @@ -463,7 +465,7 @@ static void describe_blob(struct object_id oid, struct strbuf *dst)
>  {
>         struct rev_info revs;
>         struct argv_array args = ARGV_ARRAY_INIT;
> -       struct process_commit_data pcd = { null_oid, oid, dst};
> +       struct process_commit_data pcd = { null_oid, oid, dst, &revs};
>
>         argv_array_pushl(&args, "internal: The first arg is not parsed",
>                 "--all", "--reflog", /* as many starting points as possible */
> @@ -497,14 +499,12 @@ static void describe(const char *arg, int last_one)
>                 die(_("Not a valid object name %s"), arg);
>         cmit = lookup_commit_reference_gently(&oid, 1);
>
> -       if (cmit) {
> +       if (cmit)
>                 describe_commit(&oid, &sb);
> -       } else {
> -               if (lookup_blob(&oid))
> -                       describe_blob(oid, &sb);
> -               else
> -                       die(_("%s is neither a commit nor blob"), arg);
> -       }
> +       else if (lookup_blob(&oid))
> +               describe_blob(oid, &sb);
> +       else
> +               die(_("%s is neither a commit nor blob"), arg);
>
>         puts(sb.buf);
>
> diff --git c/list-objects.c w/list-objects.c
> index 03438e5a8b..07a92f35fe 100644
> --- c/list-objects.c
> +++ w/list-objects.c
> @@ -184,13 +184,13 @@ static void add_pending_tree(struct rev_info *revs, struct tree *tree)
>  }
>
>  static void traverse_trees_and_blobs(struct rev_info *revs,
> -                                    struct strbuf *base_path,
> +                                    struct strbuf *base,
>                                      show_object_fn show_object,
>                                      void *data)
>  {
>         int i;
>
> -       assert(base_path->len == 0);
> +       assert(base->len == 0);
>
>         for (i = 0; i < revs->pending.nr; i++) {
>                 struct object_array_entry *pending = revs->pending.objects + i;
> @@ -208,12 +208,12 @@ static void traverse_trees_and_blobs(struct rev_info *revs,
>                         path = "";
>                 if (obj->type == OBJ_TREE) {
>                         process_tree(revs, (struct tree *)obj, show_object,
> -                                    base_path, path, data);
> +                                    base, path, data);
>                         continue;
>                 }
>                 if (obj->type == OBJ_BLOB) {
>                         process_blob(revs, (struct blob *)obj, show_object,
> -                                    base_path, path, data);
> +                                    base, path, data);
>                         continue;
>                 }
>                 die("unknown pending object %s (%s)",
> diff --git c/t/t6100-rev-list-in-order.sh w/t/t6100-rev-list-in-order.sh
> index 651666979b..d4d539b0da 100755
> --- c/t/t6100-rev-list-in-order.sh
> +++ w/t/t6100-rev-list-in-order.sh
> @@ -1,21 +1,22 @@
>  #!/bin/sh
>
> -test_description='miscellaneous rev-list tests'
> +test_description='rev-list testing in-commit-order'
>
>  . ./test-lib.sh
>
> -
> -test_expect_success 'setup' '
> +test_expect_success 'rev-list --in-commit-order' '
>         for x in one two three four
>         do
>                 echo $x >$x &&
>                 git add $x &&
> -               git commit -m "add file $x"
> +               git commit -m "add file $x" ||
> +               return 1
>         done &&
>         for x in four three
>         do
>                 git rm $x &&
> -               git commit -m "remove $x"
> +               git commit -m "remove $x" ||
> +               return 1
>         done &&
>         git rev-list --in-commit-order --objects HEAD >actual.raw &&
>         cut -c 1-40 >actual <actual.raw &&
> @@ -32,9 +33,9 @@ test_expect_success 'setup' '
>                 HEAD~2^{tree}
>                 HEAD~2^{tree}:four
>                 HEAD~3^{commit}
> -               # HEAD~3^{tree} skipped
> +               # HEAD~3^{tree} skipped, same as HEAD~1^{tree}
>                 HEAD~4^{commit}
> -               # HEAD~4^{tree} skipped
> +               # HEAD~4^{tree} skipped, same as HEAD^{tree}
>                 HEAD~5^{commit}
>                 HEAD~5^{tree}
>         EOF
> diff --git c/t/t6120-describe.sh w/t/t6120-describe.sh
> index fd329f173a..aec6ed192d 100755
> --- c/t/t6120-describe.sh
> +++ w/t/t6120-describe.sh
> @@ -319,7 +319,7 @@ test_expect_success 'describe a blob at a tag' '
>         test_cmp expect actual
>  '
>
> -test_expect_success 'describe a surviving blob' '
> +test_expect_success 'describe a blob with commit-ish' '
>         git commit --allow-empty -m "empty commit" &&
>         git describe HEAD:file >actual &&
>         grep unique-file-1-g actual
