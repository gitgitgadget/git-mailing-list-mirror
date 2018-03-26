Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E40A1F42D
	for <e@80x24.org>; Mon, 26 Mar 2018 07:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750928AbeCZHFq (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 03:05:46 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:38363 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750783AbeCZHFp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 03:05:45 -0400
Received: by mail-it0-f67.google.com with SMTP id 19-v6so9394340itw.3
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 00:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/i9F6jmQix5Dl8jKcKI91vDD8v7WDLvOPQQoKVystv8=;
        b=flIyQo0MxlXfeD1CEW59vyCVsXQs3ohRc41UvKBla5F1dIIvme43MEf2jtOHAnI/Vx
         59k9BYKfEyjofU/zhpYvJAJGrRgOyi/Dw0Lx8Cn6RNEh4Ey+fpMNX/vCQPah2w1WBp4P
         zI/V4XKt3iz5ry3ElFc3DygZf+btAXBCO+Z+4dej963gyq1IH6DyerhQdds7vNBrO/h8
         ESuJhNtKwEuthTxa6yiBU0bP0m6s3yHnlIMmJSeb9bq3WjZ40TY5dqyBwonmrGHdaM3s
         KxCF08J+ywpgU8CLa+Puga7beftAAp2yffiKSajB99ym1Md7Y6pVHtiH+T3h7t3oCg2M
         cCRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/i9F6jmQix5Dl8jKcKI91vDD8v7WDLvOPQQoKVystv8=;
        b=SxBcfV9Kfh35uMZ9vGCTtY95sSHxMMCzAu9aNO/dfk6iBjwsBTNGWEl4vs4DChKO8r
         lRV7ANS+8PYu4Gkf4C5MLLRwTmlvD9lYwIrSDTw2XenXyy8+pnGS5lxOmtacdC7hzoj4
         j5akWRQLKLFY5uPr88lwxREO+1RAfMhfKrhqfwEt3LiAXEXUVWDeK+1/dpAvCj66+2H/
         hvdcHZY4m9xBWibes9iewmqPz+Dnuos1gRGIcwpuLwYaCkbSOQxWlTIusZFv34qb2NbZ
         EimH+882pSoqcNJ6UvMsOReto795S/Ha1rTuN0NGM2UfVScVK5Nq9hYTmD9P0SPmNIJz
         WI2A==
X-Gm-Message-State: AElRT7G0Ro8Ef9nepayZ28GnifiW0tOMTiQ+9zo1bnIokw9uMH7nxrNI
        RypO4ed1nL9slS3sx4bkf8JPLcYsflF6gmPYt14=
X-Google-Smtp-Source: AG47ELtZN0fwTf/rlzpDqSRerXKQZKG4KLtEkSmL31tFBr9d4uX4kPEr9tMU3sUmcrxkCJpQXVaCmkL9/alQRC2wuds=
X-Received: by 2002:a24:c457:: with SMTP id v84-v6mr20903396itf.81.1522047944632;
 Mon, 26 Mar 2018 00:05:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.34.9 with HTTP; Mon, 26 Mar 2018 00:05:44 -0700 (PDT)
In-Reply-To: <20180326011426.19159-4-joel@teichroeb.net>
References: <20180326011426.19159-1-joel@teichroeb.net> <20180326011426.19159-4-joel@teichroeb.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 26 Mar 2018 09:05:44 +0200
Message-ID: <CAP8UFD0wc2i3W4FNZPcDs3ELJGJj=4NaP8mhd-zMAkdK=vXT1A@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] stash: convert apply to builtin
To:     Joel Teichroeb <joel@teichroeb.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 26, 2018 at 3:14 AM, Joel Teichroeb <joel@teichroeb.net> wrote:
> Signed-off-by: Joel Teichroeb <joel@teichroeb.net>

The commit message in this patch and the following ones could be a bit
more verbose. It could at least tell that the end goal is to convert
git-stash.sh to a C builtin.

> +static void destroy_stash_info(struct stash_info *info)
> +{
> +       strbuf_release(&info->revision);
> +}

Not sure if "destroy" is the right word in the function name. I would
have used "free" instead.

> +static int get_stash_info(struct stash_info *info, int argc, const char **argv)
> +{
> +       struct strbuf w_commit_rev = STRBUF_INIT;
> +       struct strbuf b_commit_rev = STRBUF_INIT;
> +       struct strbuf w_tree_rev = STRBUF_INIT;
> +       struct strbuf b_tree_rev = STRBUF_INIT;
> +       struct strbuf i_tree_rev = STRBUF_INIT;
> +       struct strbuf u_tree_rev = STRBUF_INIT;
> +       struct strbuf symbolic = STRBUF_INIT;
> +       struct strbuf out = STRBUF_INIT;
> +       int ret;
> +       const char *revision;
> +       const char *commit = NULL;
> +       char *end_of_rev;
> +       info->is_stash_ref = 0;
> +
> +       if (argc > 1) {
> +               int i;
> +               fprintf(stderr, _("Too many revisions specified:"));
> +               for (i = 0; i < argc; ++i) {
> +                       fprintf(stderr, " '%s'", argv[i]);
> +               }

The brackets are not needed.

> +               fprintf(stderr, "\n");
> +
> +               return -1;
> +       }
> +
> +       if (argc == 1)
> +               commit = argv[0];
> +
> +       strbuf_init(&info->revision, 0);
> +       if (commit == NULL) {
> +               if (have_stash()) {
> +                       destroy_stash_info(info);
> +                       return error(_("No stash entries found."));
> +               }
> +
> +               strbuf_addf(&info->revision, "%s@{0}", ref_stash);
> +       } else if (strspn(commit, "0123456789") == strlen(commit)) {
> +               strbuf_addf(&info->revision, "%s@{%s}", ref_stash, commit);
> +       } else {
> +               strbuf_addstr(&info->revision, commit);
> +       }
> +
> +       revision = info->revision.buf;
> +
> +       strbuf_addf(&w_commit_rev, "%s", revision);

Maybe use strbuf_addstr()?

> +
> +

Spurious new line.

[...]

> +static int diff_cached_index(struct strbuf *out, struct object_id *c_tree)
> +{
> +       struct child_process cp = CHILD_PROCESS_INIT;
> +    const char *c_tree_hex = oid_to_hex(c_tree);

Indent looks weird.

> +
> +       cp.git_cmd = 1;
> +       argv_array_pushl(&cp.args, "diff-index", "--cached", "--name-only", "--diff-filter=A", NULL);
> +       argv_array_push(&cp.args, c_tree_hex);
> +       return pipe_command(&cp, NULL, 0, out, 0, NULL, 0);
> +}
> +
> +static int update_index(struct strbuf *out) {

The opening bracket should be on its own line.

> +       struct child_process cp = CHILD_PROCESS_INIT;

Maybe add a new line here to be more consistent with other such functions.

> +       cp.git_cmd = 1;
> +       argv_array_pushl(&cp.args, "update-index", "--add", "--stdin", NULL);
> +       return pipe_command(&cp, out->buf, out->len, NULL, 0, NULL, 0);
> +}

[...]

> +       if (info->has_u) {
> +               struct child_process cp = CHILD_PROCESS_INIT;
> +               struct child_process cp2 = CHILD_PROCESS_INIT;
> +               int res;
> +
> +               cp.git_cmd = 1;
> +               argv_array_push(&cp.args, "read-tree");
> +               argv_array_push(&cp.args, oid_to_hex(&info->u_tree));
> +               argv_array_pushf(&cp.env_array, "GIT_INDEX_FILE=%s", stash_index_path);
> +
> +               cp2.git_cmd = 1;
> +               argv_array_pushl(&cp2.args, "checkout-index", "--all", NULL);
> +               argv_array_pushf(&cp2.env_array, "GIT_INDEX_FILE=%s", stash_index_path);

Maybe use small functions for the above read-tree and checkout-index.

> +               res = run_command(&cp) || run_command(&cp2);
> +               remove_path(stash_index_path);
> +               if (res)
> +                       return error(_("Could not restore untracked files from stash"));
> +       }

Thanks.
