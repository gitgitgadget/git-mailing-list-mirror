Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C8CD1FBB0
	for <e@80x24.org>; Thu,  1 Sep 2016 07:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754623AbcIAHuJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 03:50:09 -0400
Received: from mout.gmx.net ([212.227.15.15]:53399 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753003AbcIAHuI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 03:50:08 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0M86jp-1asTAW3LdZ-00ve3U; Thu, 01 Sep 2016 09:49:53
 +0200
Date:   Thu, 1 Sep 2016 09:49:52 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/22] sequencer: completely revamp the "todo" script
 parsing
In-Reply-To: <135c9ac7-49a6-8aa1-fc10-02c2a1fd0b1a@gmail.com>
Message-ID: <alpine.DEB.2.20.1609010836010.129229@virtualbox>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <163aaa2a64ddf6dfb28c77c821726e14cc78619e.1472457609.git.johannes.schindelin@gmx.de> <135c9ac7-49a6-8aa1-fc10-02c2a1fd0b1a@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1396571872-1472711871=:129229"
Content-ID: <alpine.DEB.2.20.1609010837550.129229@virtualbox>
X-Provags-ID: V03:K0:k0udxuYTgqhRUXF7Ov3Hds6hb+BdmVzXg1qHVA7phbZP5jtQK7v
 Gi6OGRgHXzBmmejTRxZjboQ5GMZ5ECPgcLi+PDUhiZqe7/CGSrsMVusIrMOrBng8UwhNOfg
 jVs7Ha0QgZvCUoAHmcCz1mS71k8SQaRW1YuunZQ4Aj9X1zoTZVNxTJuIg03UaC+NYHtqrJj
 SG7XgADI+ae7y2uH83QtQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MMWnzG3A/5U=:L3FO4EyGEpnOvXQrmUJ8B1
 u6SAzbWz2dCsNAr2BWJ6jrjShOXosxqRiXA6yuq939s+K+yAK50sbVJTpcoPPpYBZWXekf4gp
 ZBWfngTDClApNM+Ojm1EDwNVtDcEToJ/k4V17lAn0VBYodbhuZYBBFHxIKlWlGeH2kX8qhxHS
 OkGcscQ0F5+zauYf1zzRx6GMNrqSbz2bt3PD7+/8LKufeG3LL7hoZP4XjimbffWzZgITqvS+H
 50oobqjYDmBNWkefDhNhU742Ur5P2/T4sBANfuNJztGfpNpMHBesob8u/6XTyFrVAWvrv9NRN
 RpW+amnSJ9gaw0LgiUEP5U6VWkyTioLRJRmZ+iicIqsw8yWbNddq+EmeLzBJ6wiUkkZFu0D0R
 Ejby4kE1RTP/vXs4prvpc/C/2bgD09J6k7wbe7jYspuScGP1fXG+xQQ7kr+cbknOv6XyMFf48
 9/c5pqayJ3mConQ5sx3AQuQ6XLE+xGZWxcYN0RWVPauBNoguW/er1Vl70YFuRrYWd7OA+hJI1
 L19h4i74ZlRIGd9hDd5V6wG+kK8tBj66cMVi/3Jdx6enR8qg5gjSe06cE9N1o1xTEH4n7JCbu
 iVTol0lNUNlzIW0Cb9yLEUkKkPbFCXu8sRofClLmgYIa5y2frnUE8ZmPQ89XdWeGTEg0/S1w4
 mMoyQLtKJa7aVZ+W44SPphEX8oFXpqLWRQtIA4uHV7BhBMsRXOk34z7ehFGfO5ETfQ5FPSMve
 qMf3HKYmxBBQwl+kwySZOzteGcbmAqIR/OSFh9yau+Fp6yXkL3vUdgZo+LuceKQ+HNW4HcO7d
 mL1FZEe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1396571872-1472711871=:129229
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.20.1609010837551.129229@virtualbox>

Hi Kuba,

On Wed, 31 Aug 2016, Jakub Nar=C4=99bski wrote:

> W dniu 29.08.2016 o 10:05, Johannes Schindelin pisze:
>=20
> > When we came up with the "sequencer" idea, we really wanted to have
> > kind of a plumbing equivalent of the interactive rebase. Hence the
> > choice of words: the "todo" script, a "pick", etc.
> >=20
> > However, when it came time to implement the entire shebang, somehow thi=
s
> > idea got lost and the sequencer was used as working horse for
> > cherry-pick and revert instead. So as not to interfere with the
> > interactive rebase, it even uses a separate directory to store its
> > state.
> >=20
> > Furthermore, it also is stupidly strict about the "todo" script it
> > accepts: while it parses commands in a way that was *designed* to be
> > similar to the interactive rebase, it then goes on to *error out* if th=
e
> > commands disagree with the overall action (cherry-pick or revert).
>=20
> Does this mean that after the change you would be able to continue
> "git revert" with "git cherry-pick --continue", and vice versa?  Or that
> it would be possible for git-cherry-pick to do reverts (e.g. with ^<rev>)=
?

I guess that I allow that now. Is it harmful? I dunno.

> > Let's just bite the bullet and rewrite the entire parser; the code now
> > becomes not only more elegant: it allows us to go on and teach the
> > sequencer how to parse *true* "todo" scripts as used by the interactive
> > rebase itself. In a way, the sequencer is about to grow up to do its
> > older brother's job. Better.
>=20
> Sidenote: this is not your fault, but Git doesn't do a good job on
> changes which are mostly rewrites, trying to match stray '}' and the
> like in generated diff.  I wonder if existing diff heuristic options
> could help here.

I guess --patience would have helped. Or Michael's upcoming
diff-heuristics.

> > While at it, do not stop at the first problem, but list *all* of the
> > problems. This helps the user by allowing to address all issues in
> > one go rather than going back and forth until the todo list is valid.
>=20
> That is also a good change, though I wonder how often users need
> to worry about this outside interactive rebase case.  If it is
> preparation for rebase -i, where instruction list is written by
> prone to errors human, it would be nice to have this information
> in the commit message.

Okay.

> > diff --git a/sequencer.c b/sequencer.c
> > index 982b6e9..cbdce6d 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -473,7 +473,26 @@ static int allow_empty(struct replay_opts *opts, s=
truct commit *commit)
> >  =09=09return 1;
> >  }
> > =20
> > -static int do_pick_commit(struct commit *commit, struct replay_opts *o=
pts)
> > +enum todo_command {
> > +=09TODO_PICK,
> > +=09TODO_REVERT
> > +};
>=20
> Do we have a naming convention for enums elements?  Or are we explicitly
> making enums and #defines interchangeable?  I wonder...
>=20
> ...uh, I see we don't have naming convention, but all caps snake-case
> names dominate:
>=20
>   $ git grep -A2 'enum .* {'
>   [...]
>   diff.h:enum color_diff {
>   diff.h- DIFF_RESET =3D 0,
>   diff.h- DIFF_CONTEXT =3D 1,
>   --
>   dir.c:enum path_treatment {
>   dir.c-  path_none =3D 0,
>   dir.c-  path_recurse,
>   --
>=20
> Shouldn't we say 'TODO_PICK =3D 0' explicitly, though?

Sure.

> > +static const char *todo_command_strings[] =3D {
> > +=09"pick",
> > +=09"revert"
> > +};
>=20
> It's a bit pity that we cannot use designated inits, and hanging comma,
> (from ISO C99 standard).  That is:
>=20
>   +static const char *todo_command_strings[] =3D {
>   +=09[TODO_PICK]   =3D "pick",
>   +=09[TODO_REVERT] =3D "revert",
>   +};

I agree, it is a pity. I could do something like I did in fsck.c:

=09#define FOREACH_TODO_COMMAND(FUNC) \
=09=09FUNC(PICK, "pick") \
=09=09FUNC(REVERT, "revert")

=09#define COMMAND_ID(id, string) TODO_##id,
=09enum todo_command {
=09=09FOREACH_TODO_COMMAND(COMMAND_ID)
=09=09TODO_END
=09};
=09#undef COMMAND_ID

=09#define COMMAND_ID(id, string) string,
=09static const char *todo_command_string[] =3D {
=09=09FOREACH_TODO_COMMAND(COMMAND_ID)
=09=09NULL
=09};
=09#undef COMMAND_ID

However, this is not even readable, let alone any other type of an
improvement. So I won't.

> > @@ -548,7 +568,7 @@ static int do_pick_commit(struct commit *commit, st=
ruct replay_opts *opts)
>=20
> From here on changes are about
>=20
>   s/opts->action =3D=3D REPLAY_\(PICK\|REVERT\)/command =3D=3D TODO_\1/
>=20
> Do we still need opts->action, or it is just needed less,
> and it is 'todo' instruction that decides about command
> (as it should)?

We need opts->action. For example, the state directory changes depending
on it: REPLAY_INTERACTIVE_REBASE stores its stuff in
git_path("rebase-merge").

There is lots more behavior that also changes depending on opts->action.

> > [...]
> >  =09if (res) {
> > -=09=09error(opts->action =3D=3D REPLAY_REVERT
> > +=09=09error(command =3D=3D TODO_REVERT
> >  =09=09      ? _("could not revert %s... %s")
> >  =09=09      : _("could not apply %s... %s"),
> >  =09=09      find_unique_abbrev(commit->object.oid.hash, DEFAULT_ABBREV=
),
>=20
> And here those changes end.
>=20
>   s/opts->action =3D=3D REPLAY_\(PICK\|REVERT\)/command =3D=3D TODO_\1/
>=20
> I wonder if Coccinelle / Undebt would help here; or would simple
> sed or query-and-replace-regexp be enough...

I did this by hand, to verify that I did nothing idiotic.

> > @@ -683,116 +703,107 @@ static int read_and_refresh_cache(struct replay=
_opts *opts)
> >  =09return 0;
> >  }
> > =20
> > -static int format_todo(struct strbuf *buf, struct commit_list *todo_li=
st,
> > -=09=09struct replay_opts *opts)
> > +struct todo_item {
> > +=09enum todo_command command;
> > +=09struct commit *commit;
> > +=09size_t offset_in_buf;
> > +};
> > +
> > +struct todo_list {
> > +=09struct strbuf buf;
> > +=09struct todo_item *items;
> > +=09int nr, alloc, current;
> > +};
>=20
> So there should be s/commit_list [*]{1,2}todo_list/todo_list *todo_list/
> from here on?

Almost, but not quite.

> Hmmm... commit_list is, as defined in commit.h, a linked list.

That is the most prominent reason why the rest is not a mindless
conversion from commit_list to todo_list.

And we need todo_list as an array, because we need to be able to peek, or
even move, backwards from the current command.

> Here todo_list uses growable array implementation of list.  Which
> is I guess better on current CPU architecture, with slow memory,
> limited-size caches, and adjacency prefetching.

That is not the reason that an array is used here. The array allows us
much more flexibility.

One of the major performance improvements will come at the very end, for
example: the reordering of the fixup!/squash! lines. And that would be a
*major* pain to do if the todo_list were still a linked list.

> > +#define TODO_LIST_INIT { STRBUF_INIT, NULL, 0, 0, 0 }
>=20
> Same as with other patches in this series, it would be enough to
>=20
>   +#define TODO_LIST_INIT { STRBUF_INIT }

As it happens, after Hannes' comment about REPLAY_OPTIONS_INIT, I already
had changed TODO_LIST_INIT as indicated. I just had no time to send out
another iteration (besides, I wanted to give the sequencer-i patch series
more visibility).

> You are consistent.

Thank you!

> > -=09struct commit_list *cur =3D NULL;
> > -=09const char *sha1_abbrev =3D NULL;
> > -=09const char *action_str =3D opts->action =3D=3D REPLAY_REVERT ? "rev=
ert" : "pick";
> > -=09const char *subject;
> > -=09int subject_len;
> > +=09strbuf_release(&todo_list->buf);
> > +=09free(todo_list->items);
> > +=09todo_list->items =3D NULL;
> > +=09todo_list->nr =3D todo_list->alloc =3D 0;
> > +}
> > =20
> > -=09for (cur =3D todo_list; cur; cur =3D cur->next) {
> > -=09=09const char *commit_buffer =3D get_commit_buffer(cur->item, NULL)=
;
> > -=09=09sha1_abbrev =3D find_unique_abbrev(cur->item->object.oid.hash, D=
EFAULT_ABBREV);
> > -=09=09subject_len =3D find_commit_subject(commit_buffer, &subject);
> > -=09=09strbuf_addf(buf, "%s %s %.*s\n", action_str, sha1_abbrev,
> > -=09=09=09subject_len, subject);
> > -=09=09unuse_commit_buffer(cur->item, commit_buffer);
> > -=09}
> > -=09return 0;
> > +struct todo_item *append_todo(struct todo_list *todo_list)
>=20
> Errr... I don't quite understand the name of this function.
> What are you appending here to the todo_list?

A new item.

> Compare string_list_append() and string_list_append_nodup(),
> where the second parameter is item to append.

Yes, that is correct. In the case of a todo_item, things are a lot more
complicated, though. Some of the values have to be determined tediously
(such as the offset and length of the oneline after the "pick <oid>"
command). I just put those values directly into the newly allocated item,
is all.

> > +=09ALLOC_GROW(todo_list->items, todo_list->nr + 1, todo_list->alloc);
> > +=09return todo_list->items + todo_list->nr++;
> >  }
> > =20
> > -static struct commit *parse_insn_line(char *bol, char *eol, struct rep=
lay_opts *opts)
> > +static int parse_insn_line(struct todo_item *item, const char *bol, ch=
ar *eol)
>=20
> Why the change of return type? =20

Because it makes no sense to return a commit here because not all commands
are about commits (think rebase -i's `exec`). It makes tons of sense to
return an error condition, though.

> Why now struct todo_item is first when struct replay_opts was last?

Those play very, very different roles.

The opts parameter used to provide parse_insn_line() with enough
information to complain loudly when the overall command was not identical
to the parsed command.

The item parameter is a receptacle for the parsed data. It will contain
the pointer to the commit that was previously returned, if any. But it
will also contain much more information, such as the command, the oneline,
the offset in the buffer, etc etc

So "opts" was an "in" parameter while "item" is an "out" one. Apples and
oranges.

> > +=09for (i =3D 0; i < ARRAY_SIZE(todo_command_strings); i++)
> > +=09=09if (skip_prefix(bol, todo_command_strings[i], &bol)) {
>=20
> skip_prefix() is such a nice abstraction...
>=20
> > +=09=09=09item->command =3D i;
> > +=09=09=09break;
> > +=09=09}
>=20
> Nice.  Replacing if-elsif chain with loop. =20
>=20
> I guess any hashmap would be serious overkill, as there are and would be
> only a few actions possible.

If at all, we should use a trie here. But as you said: overkill to the
max.

> > +=09if (i >=3D ARRAY_SIZE(todo_command_strings))
> > +=09=09return -1;
> > =20
> >  =09/* Eat up extra spaces/ tabs before object name */
> >  =09padding =3D strspn(bol, " \t");
> >  =09if (!padding)
> > -=09=09return NULL;
> > +=09=09return -1;
> >  =09bol +=3D padding;
> > =20
> > -=09end_of_object_name =3D bol + strcspn(bol, " \t\n");
> > +=09end_of_object_name =3D (char *) bol + strcspn(bol, " \t\n");
>=20
> Why is this cast needed?

Because bol is a "const char *" and we need to put "NUL" temporarily to
*end_of_object_name:

> >  =09saved =3D *end_of_object_name;
> >  =09*end_of_object_name =3D '\0';
> >  =09status =3D get_sha1(bol, commit_sha1);
> >  =09*end_of_object_name =3D saved;

Technically, this would have made a fine excuse to teach get_sha1() a mode
where it expects a length parameter instead of relying on a NUL-terminated
string.

Practically, such fine excuses cost me months in this rebase--helper
project already, and I need to protect my time better.

> > -=09/*
> > -=09 * Verify that the action matches up with the one in
> > -=09 * opts; we don't support arbitrary instructions
> > -=09 */
> > -=09if (action !=3D opts->action) {
> > -=09=09if (action =3D=3D REPLAY_REVERT)
> > -=09=09      error((opts->action =3D=3D REPLAY_REVERT)
> > -=09=09=09    ? _("Cannot revert during another revert.")
>=20
> Errr... could the above ever happen?  Namely
>=20
>   action !=3D opts->action && action =3D=3D REPLAY_REVERT && opts->action=
 =3D=3D REPLAY_REVERT
>=20
> Surely not.

Your reply pointed to the very circumstance when this may happen: `git
cherry-pick --continue` after an interrupted `git revert`.

But then, I remove that code here, so I should not try to defend it.

> > -=09=09=09    : _("Cannot revert during a cherry-pick."));
> > -=09=09else
> > -=09=09      error((opts->action =3D=3D REPLAY_REVERT)
> > -=09=09=09    ? _("Cannot cherry-pick during a revert.")
> > -=09=09=09    : _("Cannot cherry-pick during another cherry-pick."));
> > -=09=09return NULL;
> > -=09}
>=20
> Anyway, while it is / would be a good idea to prevent starting any
> sequencer-based command (cherry-pick, revert, soon rebase -i) when
> other command is in progress (cherry-pick, revert, soon rebase -i).
> That is, if cherry-pick / revert waits for user action, you cannot
> run another cherry-pick or revert.
>=20
> Which I guess the above code was not about...

It was about that, though.

It went about it in a pretty round-about way: opts->action comes from the
name of the command ("was I called as `git revert` or `git cherry-pick`?")
and action comes from the todo script, which was assumed to be written by
a previous run of the sequencer, using the then-current value of
opts->action.

So it wrote that command into *every single line* of the todo script, *for
the sole purpose* of verifying that it was the same action when running
via --continue.

As I said earlier, I would not complain at all if an interrupted `git
revert` could be continued via `git cherry-pick --continue`.

If that is not desirable, I can reintroduce that overzealous check, but
that will have to wait until after v2.10.0. And it would require an
argument that convinces me.

> > +=09=09item =3D append_todo(todo_list);
>=20
> A better name, in my personal option, would be
>=20
>   +=09=09item =3D todo_list_next(todo_list);
>=20
> Or todo_next(todo_list).

That sounds more like a function that performs the next command in the
todo_list.

While I agree that naming is hard, I still think that `append_todo()` with
the todo_list as single parameter and returning a todo_item is pretty much
self-explanatory: it appends a new item to the todo_list and returns a
pointer to it.

> > +=09=09item->offset_in_buf =3D p - todo_list->buf.buf;
> > +=09=09if (parse_insn_line(item, p, eol)) {
> > +=09=09=09error("Invalid line: %.*s", (int)(eol - p), p);
>=20
> This error message should, I think, be also translatable:
>=20
>   +=09=09=09error(_("Invalid line: %.*s"), (int)(eol - p), p);
>=20
> > +=09=09=09res |=3D error(_("Could not parse line %d."), i);

Sure. In the meantime, I consolidated those two error()s into one, and now
I also marked it translatable.

> BTW. would be we able to show where exactly there was problem parsing,
> that is at which character in line?  Or is it something for the future?

Maybe for the future.

> > -static int read_populate_todo(struct commit_list **todo_list,
> > +static int read_populate_todo(struct todo_list *todo_list,
> >  =09=09=09struct replay_opts *opts)
> >  {
> >  =09const char *todo_file =3D get_todo_path(opts);
>=20
> If I understand it correctly, replay_opts is used only to find out
> correct todo_file, isn't it?

Probably. Maybe also to make certain code paths conditional on rebase -i
mode. Maybe also to figure out whether we run in verbose mode in the
future. Or something.

Think of this `read_populate_todo()` function more as if it were a method
of the "replay class", and the "opts" parameter is kind of "self" or
"this" or whatever it is called in your favorite object-oriented language.


> > -=09if (strbuf_read(&buf, fd, 0) < 0) {
> > +=09if (strbuf_read(&todo_list->buf, fd, 0) < 0) {
> >  =09=09close(fd);
> > -=09=09strbuf_release(&buf);
>=20
> A question: when is todo_list->buf released?

Why, I am glad you asked! It is released in todo_list_release(), called at
the end e.g. of sequencer_continue().

> > -static int walk_revs_populate_todo(struct commit_list **todo_list,
> > +static int walk_revs_populate_todo(struct todo_list *todo_list,
> >  =09=09=09=09struct replay_opts *opts)
> >  {
> > +=09enum todo_command command =3D opts->action =3D=3D REPLAY_PICK ?
> > +=09=09TODO_PICK : TODO_REVERT;
> >  =09struct commit *commit;
> > -=09struct commit_list **next;
> > =20
> >  =09if (prepare_revs(opts))
> >  =09=09return -1;
> > =20
> > -=09next =3D todo_list;
> > -=09while ((commit =3D get_revision(opts->revs)))
> > -=09=09next =3D commit_list_append(commit, next);
> > +=09while ((commit =3D get_revision(opts->revs))) {
> > +=09=09struct todo_item *item =3D append_todo(todo_list);
> > +=09=09const char *commit_buffer =3D get_commit_buffer(commit, NULL);
>=20
> I see that you are creating todo file contents while walking revision lis=
t,
> something that was left for later in current / previous implementation
> of the sequencer...

Not really. This function was always about generating a todo_list. It just
did not format it yet.

With the change of keeping the original formatting of the todo script
instead of re-formatting it in save_todo(), this function now has to
format the todo_list itself.

> > +=09=09const char *subject;
> > +=09=09int subject_len;
> > +
> > +=09=09item->command =3D command;
> > +=09=09item->commit =3D commit;
> > +=09=09item->offset_in_buf =3D todo_list->buf.len;
> > +=09=09subject_len =3D find_commit_subject(commit_buffer, &subject);
> > +=09=09strbuf_addf(&todo_list->buf, "%s %s %.*s\n",
> > +=09=09=09opts->action =3D=3D REPLAY_PICK ?  "pick" : "revert",
>=20
> Wouldn't it be simpler to use
>=20
>   +=09=09=09todo_command_strings[command],
>=20
> Also, this string does not change during the loop, though I guess
> compiler should be able to optimize it.

Sure!

> > +=09=09=09find_unique_abbrev(commit->object.oid.hash,
> > +=09=09=09=09DEFAULT_ABBREV),
> > +=09=09=09subject_len, subject);
>=20
> ...Did format of the 'todo' file changed?  And if yes, was it in backward
> compatible way, so that "git revert" or "git cherry-pick" started with
> old version of Git can be continued with new version, and what is also
> important (for somebody who sometimes uses system-installed Git, and
> sometimes user-compiled one) the reverse: started with new, continued
> with old?

The old format and the new format are compatible. In fact, sequencer's
format was based on rebase -i's format (which makes it all the more
surprising how much the processing deviated).

> > @@ -964,30 +990,24 @@ static int sequencer_rollback(struct replay_opts =
*opts)
> >  =09return -1;
> >  }
> > =20
> > -static int save_todo(struct commit_list *todo_list, struct replay_opts=
 *opts)
> > +static int save_todo(struct todo_list *todo_list, struct replay_opts *=
opts)
> >  {
> >  =09static struct lock_file todo_lock;
> > -=09struct strbuf buf =3D STRBUF_INIT;
> > -=09int fd;
> > +=09const char *todo_path =3D get_todo_path(opts);
> > +=09int next =3D todo_list->current, offset, fd;
>=20
> The "next =3D todo_list->current" looks a bit strange.

Depending whether we need rebase -i processing or revert/cherry-pick's
slightly different one, the "current" position points to the next one
already...

> Also, we do not change todo_list->current, we use it in one place, so it
> can be used directly without help of temporary / helper variable.  But
> that is just my personal opinion.

No, it has nothing to do with opinion. It prepares the code to keep it
readable even when REPLAY_INTERACTIVE_REBASE is introduced.

> Also, from 'next', 'offset' and 'fd', all those are different uses of
> int: the index (int, rarely size_t), the offset in string (formally
> ptrdiff_t, or size_t, but usually int), and the file descriptor.  I
> think from those the file descriptor could be kept in separate line; it
> would help diff to be more readable.  But this is fairly marginal
> nitpicking, and a matter of personal opinion.

Right. At this point, I am really much more concerned about correctness of
code than discussing personal preferences.

> > -=09fd =3D hold_lock_file_for_update(&todo_lock, git_path_todo_file(), =
0);
> > +=09fd =3D hold_lock_file_for_update(&todo_lock, todo_path, 0);
> >  =09if (fd < 0)
> >  =09=09return error_errno(_("Could not lock '%s'"),
> >  =09=09=09=09   git_path_todo_file());
>=20
> We should use 'todo_path' here...

True.

> and this should be done in one of earlier patches, isn't it?

No. I deliberately skipped save_todo() from "future-proofing" as I planned
to rewrite it anyway. There is no point in future-proofing something you
are going to toss in a minute.

> > -=09if (format_todo(&buf, todo_list, opts) < 0) {
> > -=09=09strbuf_release(&buf);
> > -=09=09return error(_("Could not format %s."), git_path_todo_file());
>=20
> Can we still get this error?  Could we get this error anyway,
> and under what conditions?

No. We keep the original formatting. Keeping it cannot possibly result in
a formatting error.

> > -=09}
> > -=09if (write_in_full(fd, buf.buf, buf.len) < 0) {
> > -=09=09strbuf_release(&buf);
> > -=09=09return error_errno(_("Could not write to %s"),
> > -=09=09=09=09   git_path_todo_file());
> > -=09}
> > +=09offset =3D next < todo_list->nr ?
> > +=09=09todo_list->items[next].offset_in_buf : todo_list->buf.len;
> > +=09if (write_in_full(fd, todo_list->buf.buf + offset,
> > +=09=09=09todo_list->buf.len - offset) < 0)
> > +=09=09return error(_("Could not write to %s (%s)"),
> > +=09=09=09todo_path, strerror(errno));
>=20
> Ah, so it saves the remaining todo_items on todo_list, not the
> whole todo_list... the name does not fully show it.

The name also does not fully show that it will write a "done" file after
the sequencer-i patch series.

>=20
> > -=09if (commit_lock_file(&todo_lock) < 0) {
> > -=09=09strbuf_release(&buf);
> > -=09=09return error(_("Error wrapping up %s."), git_path_todo_file());
> > -=09}
> > -=09strbuf_release(&buf);
> > +=09if (commit_lock_file(&todo_lock) < 0)
> > +=09=09return error(_("Error wrapping up %s."), todo_path);
>=20
> Note: this is unrelated change, but we usually put paths in quotes, like =
this
>=20
>   +=09=09return error(_("Error wrapping up '%s'."), todo_path);
>=20
> (in this and earlier error message), so that paths containing spaces show
> correctly and readably to the user.  Though this possibly is not a proble=
m
> for this path.

Right.

> Also, how user is to understand "wrapping up"?

The same as before: the removed lines already had the error message,
missing the quotes, too.

Don't get me wrong: I am a big fan of consistency, and I wish that Git's
source code had more of it. So I would love to see a patch series that
makes all error messages consistently reporting paths enclosed in single
quotes.

I am also a big fan of the separation of concerns, though. And this patch
series' concern is consistency *with the existing code*.

So I won't change the error message that I inherited at this point.

> >  static int single_pick(struct commit *cmit, struct replay_opts *opts)
> >  {
> >  =09setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
> > -=09return do_pick_commit(cmit, opts);
> > +=09return do_pick_commit(opts->action =3D=3D REPLAY_PICK ?
> > +=09=09TODO_PICK : TODO_REVERT, cmit, opts);
>=20
> The ternary conditional operator here translates one enum to other enum,
> isn't it?

Well, almost. Please note that the enum will receive a new value in the
sequencer-i patch series. And there is no equivalent todo_command for
REPLAY_INTERACTIVE_REBASE.

Thanks for the review!
Johannes
--8323329-1396571872-1472711871=:129229--
