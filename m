Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 765631F770
	for <e@80x24.org>; Mon, 31 Dec 2018 04:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbeLaEfQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Dec 2018 23:35:16 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35173 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbeLaEfP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Dec 2018 23:35:15 -0500
Received: by mail-oi1-f195.google.com with SMTP id v6so21260918oif.2
        for <git@vger.kernel.org>; Sun, 30 Dec 2018 20:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7tobkw0SPP75mop2533GepcOpGyK37yLBhHtK5BBLgU=;
        b=ocJuyY2jn6LEb8lQOmTa2rw+/4YgWxfCy0CXfv0+vWKiBf2O1GYG9R7DOXaRzekj9Y
         gHjjxFxkF8L43vS42BkK6BzyoxENv8PKrjt2at9RtAGBCEHB6gk6rIKB4gf9kJSvUVT8
         hfEZkrKcrhDMBWLwky9oq7xZ0lElEQ+BZfJf27/QUEZwPTmeMMlBWL6P5I3G9+SG1+di
         utnLDhkytBaJMmcpn7noz1que6FRC23fBPPBWW93v0HJsv3R37VpKPT+kQL7+CKPJh5q
         biMa6Ivxko9MuS0wxwWK7n3jJMlZRQEaTnqFVN2CtZurm5OoW3A/E40OfAJnbrMqZmTx
         SWYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7tobkw0SPP75mop2533GepcOpGyK37yLBhHtK5BBLgU=;
        b=C95ZIiUddxp+JJ4eYGSrXlDcZ9Px4ZAJMWv6Dw01jNoyWzQB6MvIrKcn6tU/71TqgH
         fDaLO4ZZRavC1a5wu04CFyDAWVW3omlneTU23H+xugg0g3Lx28ddmJRa0aqQIJ2spNYx
         1oZIeaoSybPMSjTZPj3Adbsamprq+6cBJjyEAaImusk451+nWUkPKFNNw/Qc/7pcCSEo
         RYDvozqYu2imnlCIQVyBFU3nNQD3fnuvAAZiVy8tMnNJJQolyh28YL6ZQjOebMMHX+KE
         gYz6MP1KxizavJiOMjax1CjN8qy2S+wKQU1oIun9EF0PtXDyqGUrFVyPZqM1+nv5ZLnH
         6LeA==
X-Gm-Message-State: AA+aEWbgD0fnHOkPPm+p1kkCYZhaElyuanMX9I9xmsIoPU+fwlWd5X+p
        1uttRHglt7PfU4SOQhmYs5w7Q23qHGHvygsVH3M=
X-Google-Smtp-Source: AFSGD/VRfNNiovim96tUYxFrVayGRlyucR/7WFXmWEyVxlTP607465S4gUDU5VjZDVy+pbu7dN3schMltiummHtrLGE=
X-Received: by 2002:aca:cf54:: with SMTP id f81mr24355266oig.16.1546230914171;
 Sun, 30 Dec 2018 20:35:14 -0800 (PST)
MIME-Version: 1.0
References: <20181219083305.2500-1-issac.trotts@gmail.com> <5dfd92d1-2e87-3006-1630-a33794b6066b@gmail.com>
In-Reply-To: <5dfd92d1-2e87-3006-1630-a33794b6066b@gmail.com>
From:   Issac Trotts <issac.trotts@gmail.com>
Date:   Mon, 31 Dec 2018 15:35:02 +1100
Message-ID: <CANdyxMz8RsCUmumyNP=0Nxh8TpoC2z5TGRW8Hpf_Z_MH7wAj4Q@mail.gmail.com>
Subject: Re: [PATCH] log: add %S option (like --source) to log --format
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Noemi Mercado <noemi@sourcegraph.com>,
        Issac Trotts <issactrotts@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Derrick, thanks for your feedback.

I'll send out a new patch with the changes.

On Fri, Dec 28, 2018 at 12:20 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 12/19/2018 3:33 AM, issac.trotts@gmail.com wrote:
> > From: Issac Trotts <issac.trotts@gmail.com>
> >
> > Make it possible to write for example
> >
> >          git log --format="%H,%S"
> >
> > where the %S at the end is a new placeholder that prints out the ref
> > (tag/branch) for each commit.
> >
> > Using %d might seem like an alternative but it only shows the ref for the last
> > commit in the branch.
> >
> > Signed-off-by: Issac Trotts <issactrotts@google.com>
> >
> > ---
> >
> > This change is based on a question from Stack Overflow:
> > https://stackoverflow.com/questions/12712775/git-get-source-information-in-format
> > ---
> >   Documentation/pretty-formats.txt |  2 ++
> >   builtin/log.c                    |  2 +-
> >   log-tree.c                       |  1 +
> >   pretty.c                         | 15 ++++++++++
> >   pretty.h                         |  1 +
> >   t/t4205-log-pretty-formats.sh    | 50 ++++++++++++++++++++++++++++++++
> >   6 files changed, 70 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
> > index 417b638cd..de6953108 100644
> > --- a/Documentation/pretty-formats.txt
> > +++ b/Documentation/pretty-formats.txt
> > @@ -134,6 +134,8 @@ The placeholders are:
> >   - '%cI': committer date, strict ISO 8601 format
> >   - '%d': ref names, like the --decorate option of linkgit:git-log[1]
> >   - '%D': ref names without the " (", ")" wrapping.
> > +- '%S': ref name given on the command line by which the commit was reached
> > +  (like `git log --source`), only works with `git log`
>
> This "only works with `git log`" made me think about what would happen
> with `git rev-list --pretty=format:"%h %S"` and the answer (on my
> machine) was a segfault.

Good find. Checking for c->pretty_ctx->rev == NULL prevents the seg fault.

> >   - '%e': encoding
> >   - '%s': subject
> >   - '%f': sanitized subject line, suitable for a filename
> > diff --git a/builtin/log.c b/builtin/log.c
> > index e8e51068b..be3025657 100644
> > --- a/builtin/log.c
> > +++ b/builtin/log.c
> > @@ -203,7 +203,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
> >           rev->diffopt.filter || rev->diffopt.flags.follow_renames)
> >               rev->always_show_header = 0;
> >
> > -     if (source) {
> > +     if (source || (rev->pretty_given && (rev->commit_format == CMIT_FMT_USERFORMAT) && w.source)) {
> >               init_revision_sources(&revision_sources);
> >               rev->sources = &revision_sources;
> >       }
>
> Likely, you'll want to duplicate this initialization in the revision
> machinery. Keep this one in builtin/log.c as it was before, but add
> something like this initialization to setup_revisions(). Add a test for
> rev-list.

Okay, I added a test to check that rev-list leaves %S alone and
implicitly that it doesn't segfault.

I'd like to limit the scope of this change to what's already here,
with the check preventing the segfault, if that's okay. Could support
for %S in rev-list be in a later patch?

>
> [snip]
>
> > @@ -1194,6 +1195,17 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
> >               load_ref_decorations(NULL, DECORATE_SHORT_REFS);
> >               format_decorations_extended(sb, commit, c->auto_color, "", ", ", "");
> >               return 1;
> > +     case 'S':               /* tag/branch like --source */
> > +             if (c->pretty_ctx->rev->sources == NULL) {
> Use "if (!c->pretty_ctx->rev->sources".
> > +                     return 0;
> > +             }
> > +             slot = revision_sources_at(c->pretty_ctx->rev->sources, commit);
> > +             if (slot && *slot) {
> I'm not sure this check for 'slot' being non-null is necessary, as we
> would already get a failure in the commit-slab code (for
> revision_sources_at()) if the slab is not initialized.
> > +                     strbuf_addstr(sb, *slot);
> > +                     return 1;
> > +             } else {
> > +                     die(_("failed to get info for %%S"));
>
> Here, you die() when you fail to get a slot but above you return 0 when
> the sources are not initialized.
>
> I don't see another use of die() in this method. Is that the right way
> to handle failure here? (I'm legitimately asking because I have
> over-used 'die()' in the past and am still unclear on when it is
> appropriate.)

Fixed.

>
> >   '
> >
> > +test_expect_success 'set up %S tests' '
> > +     git checkout --orphan source-a &&
> > +     test_commit one &&
> > +     test_commit two &&
> > +     git checkout -b source-b HEAD^ &&
> > +     test_commit three
> > +'
> > +
> > +test_expect_success 'log --format=%S paints branch names' '
> > +     cat >expect <<-\EOF &&
> > +     source-b
> > +     source-a
> > +     source-b
> > +     EOF
> > +     git log --format=%S source-a source-b >actual &&
> > +     test_cmp expect actual
> > +'
> > +
> > +test_expect_success 'log --format=%S paints tag names' '
> > +     git tag -m tagged source-tag &&
> > +     cat >expect <<-\EOF &&
> > +     source-tag
> > +     source-a
> > +     source-tag
> > +     EOF
> > +     git log --format=%S source-tag source-a >actual &&
> > +     test_cmp expect actual
> > +'
> > +
> > +test_expect_success 'log --format=%S paints symmetric ranges' '
> > +     cat >expect <<-\EOF &&
> > +     source-b
> > +     source-a
> > +     EOF
> > +     git log --format=%S source-a...source-b >actual &&
> > +     test_cmp expect actual
> > +'
> > +
> > +test_expect_success '%S in git log --format works with other placeholders (part 1)' '
> > +     git log --format="source-b %h" source-b >expect &&
> > +     git log --format="%S %h" source-b >actual &&
> > +     test_cmp expect actual
> > +'
> > +
> > +test_expect_success '%S in git log --format works with other placeholders (part 2)' '
> > +     git log --format="%h source-b" source-b >expect &&
> > +     git log --format="%h %S" source-b >actual &&
> > +     test_cmp expect actual
> > +'
> > +
> >   test_done
>
> Please also add a simple test to t6006-rev-list-format.sh.

Done.

>
> Thanks,
>
> -Stolee
>
