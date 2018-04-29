Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BB721F428
	for <e@80x24.org>; Sun, 29 Apr 2018 12:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753349AbeD2Mdb (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Apr 2018 08:33:31 -0400
Received: from mout.gmx.net ([212.227.17.21]:35543 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753130AbeD2Md3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Apr 2018 08:33:29 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MIMyZ-1fE8IZ0HaJ-004AfO; Sun, 29
 Apr 2018 14:33:20 +0200
Date:   Sun, 29 Apr 2018 14:33:01 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Stefan Beller <sbeller@google.com>
cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Wink Saville <wink@saville.com>
Subject: Re: [PATCH 2/6] sequencer: learn about the special "fake root commit"
 handling
In-Reply-To: <CAGZ79kZJJadXVhcMfxqq2kH=F-6nKVuhOc_s-vgj_9w5YcOxkg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1804291255010.79@tvgsbejvaqbjf.bet>
References: <cover.1524868165.git.johannes.schindelin@gmx.de> <42db734a98059fcfd67627aecc93cc8f0439fd37.1524868165.git.johannes.schindelin@gmx.de> <CAGZ79kZJJadXVhcMfxqq2kH=F-6nKVuhOc_s-vgj_9w5YcOxkg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:N189+FtmuW4xPej+o4sPdzeQ0uurNCVIHKFoznEc6tmi871CpQn
 jQNXtPIwZXpR89Bw6HtbVAdKGe70KzpDcVE5b10RAPaLMamRCU8FMwzCvajeH3LZMb9GDSl
 5bCSxO0aolWfW1braZaN0k9yIooUHik4NBaRWB1SdtakO1qyZvyqb+QeTzUnHMdz2JUKWwv
 dkM8OdTDCL5FfWXo0X1Ag==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yFtNVlyPNRs=:nOCpmj6hT/L0fwchL+bP1S
 fbnSMZDLn7g51iOJtKIe0oXU6uxar/6DXPhptN2hFhR71xDZaxQB7y4sNlSslBL4qGdw4V7J3
 ryEeL+dbIJ8RDwAJSu9iIqiyN/mA8675mQqQWZdHQ2TgdKF1C2lwrIgZDPedVmeAIn94nVY2p
 2b9OSJFrUehD/tCa/OJOnOaES71Wg3B5ENPKh2pSMY01PajIb6g0uRzxiJZocf6hvEWxOsdkB
 zDB6BEKhHF0GXqO/s8YPLwHKu1XaAwvYxCgJmVXGdCSlwIoVXMTndjxrI3K6+r4I487rxKU89
 8ZXax1BBL04So5G31ZatXFYXiTQkb1QbqnhKUXVRFdC5doT3d20aJt8ZH2x2wvNPH1TXCF+tW
 JbqjwXgh+F27HF3xUd7qDIH8cziVPpRgzXyYa/7SBy5KCFJMriyh5i+IqsxdCaKIxqeTAfhVO
 bYXKJWPHNkwDUlb1OHFnq/EbO7KCVn0JSIFh0fH9jD6TWG8FSRa6dg0Y7t7/UOor81wOsRM9a
 bCh7WzRoU1vuEvqQxIT2mxZc8W0VX5TNxcezlK7j/ZgZoZvgBaU/jVNgemgAhbKdHe9A+DsHo
 gbc0WHJqN5Y6gjqjy0dutl3j7s8mZiSDDzssHNY0+8c7CXWKqxdN0C8vHzSj+xJHUzxVLTVSM
 p0rSnFOpb8sF62G8tbeCXzftpDta5AQIzlHGrrv17CAmqm2czUtEHDyJQKcgq5hpS9IoEO2t4
 lq3EK5Y7K9AoqlU0ebkP+yt9vmfH6pQX0N02Vz8An7rgOfZkFfOOfYTNkAPssrELhoCFCJ4xZ
 7XYvWPI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Sat, 28 Apr 2018, Stefan Beller wrote:

> On Fri, Apr 27, 2018 at 3:31 PM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > When an interactive rebase wants to recreate a root commit, it
> > - first creates a new, empty root commit,
> > - checks it out,
> > - converts the next `pick` command so that it amends the empty root
> >   commit
> >
> > Introduce support in the sequencer to handle such an empty root commit,
> > by looking for the file <GIT_DIR>/rebase-merge/squash-onto; if it exists
> > and contains a commit name, the sequencer will compare the HEAD to said
> > root commit, and if identical, a new root commit will be created.
> >
> > While converting scripted code into proper, portable C, we also do away
> > with the old "amend with an empty commit message, then cherry-pick
> > without committing, then amend again" dance and replace it with code
> > that uses the internal API properly to do exactly what we want: create a
> > new root commit.
> >
> > To keep the implementation simple, we always spawn `git commit` to create
> > new root commits.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  sequencer.c | 104 ++++++++++++++++++++++++++++++++++++++++++++++++++--
> >  sequencer.h |   4 ++
> >  2 files changed, 105 insertions(+), 3 deletions(-)
> >
> > diff --git a/sequencer.c b/sequencer.c
> > index 90c8218aa9a..fc124596b53 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -125,6 +125,12 @@ static GIT_PATH_FUNC(rebase_path_rewritten_list, "rebase-merge/rewritten-list")
> >  static GIT_PATH_FUNC(rebase_path_rewritten_pending,
> >         "rebase-merge/rewritten-pending")
> >
> > +/*
> > + * The path of the file containig the OID of the "squash onto" commit, i.e.
> > + * the dummy commit used for `reset [new root]`.
> > + */
> > +static GIT_PATH_FUNC(rebase_path_squash_onto, "rebase-merge/squash-onto")
> > +
> >  /*
> >   * The path of the file listing refs that need to be deleted after the rebase
> >   * finishes. This is used by the `label` command to record the need for cleanup.
> > @@ -470,7 +476,8 @@ static int fast_forward_to(const struct object_id *to, const struct object_id *f
> >         transaction = ref_transaction_begin(&err);
> >         if (!transaction ||
> >             ref_transaction_update(transaction, "HEAD",
> > -                                  to, unborn ? &null_oid : from,
> > +                                  to, unborn && !is_rebase_i(opts) ?
> > +                                  &null_oid : from,
> >                                    0, sb.buf, &err) ||
> >             ref_transaction_commit(transaction, &err)) {
> >                 ref_transaction_free(transaction);
> > @@ -692,6 +699,42 @@ static char *get_author(const char *message)
> >         return NULL;
> >  }
> >
> > +static const char *read_author_ident(struct strbuf *buf)
> 
> This seems to be the counter part of write_author_script(*msg),
> would it make sense to either rename this to read_author_script
> or rename the counter part to write_author_ident ?

It is not really *the* counterpart of write_author_script(). There are
many conceivable counterparts, one of them already exists and is called
read_env_script(). They serve different purposes, even if both read the
author-script file, and they parse things in a fundamentally different
way. I had already pointed out something along those lines in the review
of the patch introducing the read_env_script() and Junio did not believe
me. To make sure, it was my fault that I failed to make a compelling
enough argument. I am glad that I now have proof that I was right: just
because you read the same file, for a similar purpose, does not
necessarily imply that you can share code for those purposes. All you can
share is the name of the input file.

Having said that, *this* time round, what we need to do is actually very
similar to what builtin/am.c's read_author_script() does (even if we
cannot use it as-is: it populates part of a `struct am_state`). I'll have
to look into this more closely.

> > +{
> > +       char *p, *p2;
> > +
> > +       if (strbuf_read_file(buf, rebase_path_author_script(), 256) <= 0)
> 
> The 256 is a hint for read_file how to size the buffer initially.
> If not given it defaults to 8k, which presumably is too much for
> an author identity.

That is a correct reading of the code's intent.

> > +       for (p = buf->buf; *p; p++)
> > +               if (skip_prefix(p, "'\\\\''", (const char **)&p2))
> > +                       strbuf_splice(buf, p - buf->buf, p2 - p, "'", 1);
> > +               else if (*p == '\'')
> > +                       strbuf_splice(buf, p-- - buf->buf, 1, "", 0);
> 
> This part could be prefixed with
>     /* un-escape text: turn \\ into ' and remove single quotes. */

If could be prefixed that way, but it would be incorrect. We never turn \\
into '. What we do here (and I do not want to repeat in a comment what the
code does): we dequote what we previously quoted using single quotes. So
we use the fact that we know that the value is of the form 'abc', or if it
contains single quotes: 'this has '\''single'\'' quotes'.

> 
> > +       if (skip_prefix(buf->buf, "GIT_AUTHOR_NAME=", (const char **)&p)) {
> > +               strbuf_splice(buf, 0, p - buf->buf, "", 0);
> > +               p = strchr(buf->buf, '\n');
> > +               if (skip_prefix(p, "\nGIT_AUTHOR_EMAIL=", (const char **)&p2)) {
> > +                       strbuf_splice(buf, p - buf->buf, p2 - p, " <", 2);
> > +                       p = strchr(p, '\n');
> > +                       if (skip_prefix(p, "\nGIT_AUTHOR_DATE=@",
> > +                                       (const char **)&p2)) {
> > +                               strbuf_splice(buf, p - buf->buf, p2 - p,
> > +                                             "> ", 2);
> > +                               p = strchr(p, '\n');
> > +                               if (p) {
> > +                                       strbuf_setlen(buf, p - buf->buf);
> > +                                       return buf->buf;
> 
> So here we have read GIT_AUTHOR_NAME, _EMAIL
> and _DATE in that order and converted it to its form
> "name <email> date" in a single line.
> 
> It would be better to invert the conditions and keep
> the indentation level lower by:
> 
>     if (!skip_prefix(...))
>         goto warning_and_return;
>     strbuf_splice(...);
>     ...
> 
> I wondered if we want to factor out the conversion of
> "author string in commit form" to "author information
> in script form" into their own functions, and keep the reading
> writing out of them. But then again we only need them in
> these use cases for now, and such a refactoring can happen
> later if needed.

Right, but there *is* an opportunity now to share code with builtin/am.c.

> > +       warning(_("could not parse '%s'"), rebase_path_author_script());
> 
> This function needs all three environment variables in its correct order,
> which sounds a little brittle, but then again we do not expect manual
> editing of that file, but expect it to be written by Git.

It would not hurt to make it less brittle, I agree. Maybe I can do that
easily. If not, in my opinion it is not a big deal to expect that order,
for the reason you stated: we expect to have written the file ourselves.

> > @@ -1369,6 +1448,12 @@ static int is_fixup(enum todo_command command)
> >         return command == TODO_FIXUP || command == TODO_SQUASH;
> >  }
> >
> > +/* Does this command create a (non-merge) commit? */
> > +static int is_pick_or_similar(enum todo_command command)
> > +{
> > +       return command <= TODO_SQUASH;
> > +}
> 
> This code looks scary.
> Fortunately the enum todo_command hints that the order matters,
> such that we're probably protected from wild reordering in the future,
> however this implies that the section /* commands that handle commits */
> comes first and that TODO_SQUASH is the last entry of that section.
> So maybe we'd want to add a /* must be last in section */ to
> TODO_squash and also document that the section must be first?
> 
> Do we have other code that needs a very specific ordering
> with similar further assumptions (section being first/last, a
> command being first/last in their section)?

The code already does things like that, by testing `command <
TODO_COMMENT`.

But I guess your concerns would go away if I made this a big honking
switch() statement that lists *explicitly* what should be considered "pick
or similar"?

> I wondered what the _or_similar means and by looking up
> that enum, I would think a name like
> 
> static int handles_single_commit(enum todo_command)
> 
> might be better?

No, that would be incorrect. TODO_MERGE also *potentially* handles a
single commit (and one or more labels).

I really mean "is it a pick or similar", i.e. does it cherry-pick a
single, non-merge commit, possibly doing funny stuff such as `reword` on
top of it.

> > @@ -1523,7 +1608,14 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
> >                         return error(_("your index file is unmerged."));
> >         } else {
> >                 unborn = get_oid("HEAD", &head);
> > -               if (unborn)
> > +               /* Do we want to generate a root commit? */
> > +               if (is_pick_or_similar(command) && opts->have_squash_onto &&
> > +                   !oidcmp(&head, &opts->squash_onto)) {
> > +                       if (is_fixup(command))
> > +                               return error(_("cannot fixup root commit"));
> 
> I would expect you also cannot squash into root commit?

In sequencer.c, `is_fixup()` really means "is it a fixup or a squash?". So
yes, you are correct that we also cannot squash into a root commit.

However, a squash is the same as a fixup with the only difference being
that the squash lets you edit the final commit message (and does not
comment out the squash commit's message, in contrast to fixup).

Is it really worth adding an ugly line break in the middle of the error()
statement just to say "cannot fixup/squash into root commit"? I'd rather
not.

Ciao,
Dscho
