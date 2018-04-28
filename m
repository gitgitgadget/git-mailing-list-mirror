Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA9B81F428
	for <e@80x24.org>; Sat, 28 Apr 2018 16:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757991AbeD1QL5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Apr 2018 12:11:57 -0400
Received: from mail-yw0-f172.google.com ([209.85.161.172]:35022 "EHLO
        mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757893AbeD1QL4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Apr 2018 12:11:56 -0400
Received: by mail-yw0-f172.google.com with SMTP id q17-v6so1541286ywg.2
        for <git@vger.kernel.org>; Sat, 28 Apr 2018 09:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=y4v8fLh1Wts5/wTzVcRbCAltd7VWeHxlDVxoZ9HhYIs=;
        b=UKz+Pc0AmQH76Vnji9yzrrdj09/4SatK46avDxjmmAC6EQ0HQ6PK6SlAeHRlkhJqbn
         9YQO0GAsxNuFqimPY7/ylMBgtI3JiE95kg3S5Xr7vXzr+a1u+g3gdhNp66KDuDZ0UT+4
         6AU39wNLjuQYNP3sXKZJEITtZp580qCS7t4BhrrHNK8bnPZR0KrjIlqhFu6wZYsA0TGT
         fllKaT+iYiHq7YhJ5QD0CGMMG2Rn/X8Kl7NjTwLr8ouubbA1gb61jDoTXkh2RCQ/g/kj
         PqrjJuPofY0zFt69Ze8TQdTvmaJ8+BPE7bryhAJQ/pNAKgyKxN4+JhnyVvYTxX6a7OtW
         wF1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=y4v8fLh1Wts5/wTzVcRbCAltd7VWeHxlDVxoZ9HhYIs=;
        b=ngHZ9UsuuHdQda9tLxHDE+16AsYnT+kS0wI6TzciU4xMqZVW/e3zlzmE8HuiaD3X32
         kkTwXfTO1pZKzAmZEh0iFR1EJxmbL1ScAGf90tCCBB2is/yEzKW6iHdWDw1CVO2kVam5
         geOgQuBsBcirS2TNV4L20sU+/FswI1iteZoIJFdYRd8UC7gMKvyne9xdX9SK8u2ily+M
         POvNOamoLpaaUxjiMC2niFEPtBbHhlgu81ZEC9r+MICIomynCaLize429DeXCMsWyOaN
         ICTDOVzTxfRUmMACF/K4XlpWV2WTsnJh9NGMutfAiiCQHvuHsEZzPo521ZOTJPGukvsb
         c9Kw==
X-Gm-Message-State: ALQs6tCclw+SG4O99IOq40UveMqOPZii210H2qBgVnPjTLJpMipNHpA4
        diXtl+9HuO5WAXkkqABTIdWYoZjkpL0Nby3ALADh3w==
X-Google-Smtp-Source: AB8JxZoUzH9lonIx/n1VY9fsEtdimB/K6KK//kNbRmhFfsqSFMLm5aPsvgIiiq4A2ZgVwqC953L+c8FhCVNegeI7C48=
X-Received: by 2002:a81:8801:: with SMTP id y1-v6mr3165991ywf.238.1524931915477;
 Sat, 28 Apr 2018 09:11:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Sat, 28 Apr 2018 09:11:54
 -0700 (PDT)
In-Reply-To: <42db734a98059fcfd67627aecc93cc8f0439fd37.1524868165.git.johannes.schindelin@gmx.de>
References: <cover.1524868165.git.johannes.schindelin@gmx.de> <42db734a98059fcfd67627aecc93cc8f0439fd37.1524868165.git.johannes.schindelin@gmx.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Sat, 28 Apr 2018 09:11:54 -0700
Message-ID: <CAGZ79kZJJadXVhcMfxqq2kH=F-6nKVuhOc_s-vgj_9w5YcOxkg@mail.gmail.com>
Subject: Re: [PATCH 2/6] sequencer: learn about the special "fake root commit" handling
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Wink Saville <wink@saville.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 27, 2018 at 3:31 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> When an interactive rebase wants to recreate a root commit, it
> - first creates a new, empty root commit,
> - checks it out,
> - converts the next `pick` command so that it amends the empty root
>   commit
>
> Introduce support in the sequencer to handle such an empty root commit,
> by looking for the file <GIT_DIR>/rebase-merge/squash-onto; if it exists
> and contains a commit name, the sequencer will compare the HEAD to said
> root commit, and if identical, a new root commit will be created.
>
> While converting scripted code into proper, portable C, we also do away
> with the old "amend with an empty commit message, then cherry-pick
> without committing, then amend again" dance and replace it with code
> that uses the internal API properly to do exactly what we want: create a
> new root commit.
>
> To keep the implementation simple, we always spawn `git commit` to create
> new root commits.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  sequencer.c | 104 ++++++++++++++++++++++++++++++++++++++++++++++++++--
>  sequencer.h |   4 ++
>  2 files changed, 105 insertions(+), 3 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 90c8218aa9a..fc124596b53 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -125,6 +125,12 @@ static GIT_PATH_FUNC(rebase_path_rewritten_list, "rebase-merge/rewritten-list")
>  static GIT_PATH_FUNC(rebase_path_rewritten_pending,
>         "rebase-merge/rewritten-pending")
>
> +/*
> + * The path of the file containig the OID of the "squash onto" commit, i.e.
> + * the dummy commit used for `reset [new root]`.
> + */
> +static GIT_PATH_FUNC(rebase_path_squash_onto, "rebase-merge/squash-onto")
> +
>  /*
>   * The path of the file listing refs that need to be deleted after the rebase
>   * finishes. This is used by the `label` command to record the need for cleanup.
> @@ -470,7 +476,8 @@ static int fast_forward_to(const struct object_id *to, const struct object_id *f
>         transaction = ref_transaction_begin(&err);
>         if (!transaction ||
>             ref_transaction_update(transaction, "HEAD",
> -                                  to, unborn ? &null_oid : from,
> +                                  to, unborn && !is_rebase_i(opts) ?
> +                                  &null_oid : from,
>                                    0, sb.buf, &err) ||
>             ref_transaction_commit(transaction, &err)) {
>                 ref_transaction_free(transaction);
> @@ -692,6 +699,42 @@ static char *get_author(const char *message)
>         return NULL;
>  }
>
> +static const char *read_author_ident(struct strbuf *buf)

This seems to be the counter part of write_author_script(*msg),
would it make sense to either rename this to read_author_script
or rename the counter part to write_author_ident ?

> +{
> +       char *p, *p2;
> +
> +       if (strbuf_read_file(buf, rebase_path_author_script(), 256) <= 0)

The 256 is a hint for read_file how to size the buffer initially.
If not given it defaults to 8k, which presumably is too much for
an author identity.



> +       for (p = buf->buf; *p; p++)
> +               if (skip_prefix(p, "'\\\\''", (const char **)&p2))
> +                       strbuf_splice(buf, p - buf->buf, p2 - p, "'", 1);
> +               else if (*p == '\'')
> +                       strbuf_splice(buf, p-- - buf->buf, 1, "", 0);

This part could be prefixed with
    /* un-escape text: turn \\ into ' and remove single quotes. */

> +       if (skip_prefix(buf->buf, "GIT_AUTHOR_NAME=", (const char **)&p)) {
> +               strbuf_splice(buf, 0, p - buf->buf, "", 0);
> +               p = strchr(buf->buf, '\n');
> +               if (skip_prefix(p, "\nGIT_AUTHOR_EMAIL=", (const char **)&p2)) {
> +                       strbuf_splice(buf, p - buf->buf, p2 - p, " <", 2);
> +                       p = strchr(p, '\n');
> +                       if (skip_prefix(p, "\nGIT_AUTHOR_DATE=@",
> +                                       (const char **)&p2)) {
> +                               strbuf_splice(buf, p - buf->buf, p2 - p,
> +                                             "> ", 2);
> +                               p = strchr(p, '\n');
> +                               if (p) {
> +                                       strbuf_setlen(buf, p - buf->buf);
> +                                       return buf->buf;

So here we have read GIT_AUTHOR_NAME, _EMAIL
and _DATE in that order and converted it to its form
"name <email> date" in a single line.

It would be better to invert the conditions and keep
the indentation level lower by:

    if (!skip_prefix(...))
        goto warning_and_return;
    strbuf_splice(...);
    ...

I wondered if we want to factor out the conversion of
"author string in commit form" to "author information
in script form" into their own functions, and keep the reading
writing out of them. But then again we only need them in
these use cases for now, and such a refactoring can happen
later if needed.

> +       warning(_("could not parse '%s'"), rebase_path_author_script());

This function needs all three environment variables in its correct order,
which sounds a little brittle, but then again we do not expect manual
editing of that file, but expect it to be written by Git.

> @@ -1369,6 +1448,12 @@ static int is_fixup(enum todo_command command)
>         return command == TODO_FIXUP || command == TODO_SQUASH;
>  }
>
> +/* Does this command create a (non-merge) commit? */
> +static int is_pick_or_similar(enum todo_command command)
> +{
> +       return command <= TODO_SQUASH;
> +}

This code looks scary.
Fortunately the enum todo_command hints that the order matters,
such that we're probably protected from wild reordering in the future,
however this implies that the section /* commands that handle commits */
comes first and that TODO_SQUASH is the last entry of that section.
So maybe we'd want to add a /* must be last in section */ to
TODO_squash and also document that the section must be first?

Do we have other code that needs a very specific ordering
with similar further assumptions (section being first/last, a
command being first/last in their section)?

I wondered what the _or_similar means and by looking up
that enum, I would think a name like

static int handles_single_commit(enum todo_command)

might be better?

> @@ -1523,7 +1608,14 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
>                         return error(_("your index file is unmerged."));
>         } else {
>                 unborn = get_oid("HEAD", &head);
> -               if (unborn)
> +               /* Do we want to generate a root commit? */
> +               if (is_pick_or_similar(command) && opts->have_squash_onto &&
> +                   !oidcmp(&head, &opts->squash_onto)) {
> +                       if (is_fixup(command))
> +                               return error(_("cannot fixup root commit"));

I would expect you also cannot squash into root commit?

Thanks,
Stefan
