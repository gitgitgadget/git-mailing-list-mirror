Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F4BC433EF
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 08:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349551AbiBCIje (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 03:39:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349552AbiBCIjc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 03:39:32 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B18C06173B
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 00:39:31 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id o12so6183060eju.13
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 00:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uq0wBDrcozCKUi6uALTChWtsPqS1YcVjR/OlpvB0JY0=;
        b=oVL9x9Mq8vtfChqlAqBI558Bucr3wBw5nUjnIbZopGBIaEu5/RoM1h8khh4PZHldyt
         7cgEQG7vTrFEy6Pcb7X0FqbZ5UblJkdFKmzfMjE/B85VvNQAF2ByyZKzxE295gtwyCJ4
         dJD+iGQnzTtfCS08DG6Q2A3ppHnD05baqnxYqQoQzbKzc23p1wVX1d+NJ3ThfffEddCQ
         PqvyMia8rUegRxkLN20FAfHwL/NuFlCue0yByTvewDyS9YuJoH9X/tEyMbenpW1UrMBH
         +GE/hlitlCvNaLvTsDZdK5oop4gaQPdUvx/XSXgUcMVHVIhM3OnMosTGh8bUXUG39o3L
         ZWwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uq0wBDrcozCKUi6uALTChWtsPqS1YcVjR/OlpvB0JY0=;
        b=mg7lFHLxFtJvQoL4V6+fQSf+QtMWWApX8v/17w0ShvWgbYwG0P6FRuSpkyTmhk3I7H
         0mhLjQTe/58NvzD2NS4PpgwFT4QmjU/btlwE/FLbw1U/f4W3/YQGjJI7/Q7Ixw4ZbRj9
         U0uAh9zNYORWZH52KMT8LOmDtVkI/KC3CzbGgVA8mhpM0KvT6RhdVMFmhLFhPBMzJn/d
         RNsTzTL0IVXObANhKWEvtsf6lxea48G9UND0joGiPsSqkGLIRUl1t1qCcv5lTPqT13YC
         17OkGR77PGA7AFlSIwhlkyXBlsEeqNquAfiXOg6O+Zb2RPIeUEw1sdOh6a58ynC3OqyP
         YcFQ==
X-Gm-Message-State: AOAM532fA4MB8wDHGCPAqIaOIZi0rxS7+0vo1AOvdztzAow1ajZMGCoc
        dEdQUvuCIAxHUl0B3rVKTop+K60VGBiQEwZlIn0=
X-Google-Smtp-Source: ABdhPJxfqYTC5h3xAlbuhOPm0JheSXP7DbZKrX97EuSFqEjhSNj+7PsGyzi2cFBJ1KI9bULIpCGRAcvzQgGH5b6z7wk=
X-Received: by 2002:a17:906:4c47:: with SMTP id d7mr21454264ejw.192.1643877570127;
 Thu, 03 Feb 2022 00:39:30 -0800 (PST)
MIME-Version: 1.0
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
 <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com> <c322e4c6938b7270b6e90998994642074a2813e0.1643479633.git.gitgitgadget@gmail.com>
 <xmqqr18lvts0.fsf@gitster.g> <CABPp-BGd38Yb_LaJWLG+oiTit0CVRkE-5vmviGfoUOtBFP6yMg@mail.gmail.com>
 <220203.86iltw7nhm.gmgdl@evledraar.gmail.com>
In-Reply-To: <220203.86iltw7nhm.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 3 Feb 2022 00:39:18 -0800
Message-ID: <CABPp-BHKpOPM85bRiYmtZ6YT7AK_jpn6aen+o9jeNM6Jwbns=A@mail.gmail.com>
Subject: Re: [PATCH v2 11/13] merge-tree: provide easy access to `ls-files -u`
 style info
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 2, 2022 at 5:22 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> On Wed, Feb 02 2022, Elijah Newren wrote:
>
> > On Wed, Feb 2, 2022 at 1:32 PM Junio C Hamano <gitster@pobox.com> wrote=
:
> >>
> >> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >>
> >> > @@ -450,7 +451,11 @@ static int real_merge(struct merge_tree_options=
 *o,
> >> >               merge_get_conflicted_files(&result, &conflicted_files)=
;
> >> >               for (i =3D 0; i < conflicted_files.nr; i++) {
> >> >                       const char *name =3D conflicted_files.items[i]=
.string;
> >> > -                     if (last && !strcmp(last, name))
> >> > +                     struct stage_info *c =3D conflicted_files.item=
s[i].util;
> >> > +                     if (!o->exclude_modes_oids_stages)
> >> > +                             printf("%06o %s %d\t",
> >> > +                                    c->mode, oid_to_hex(&c->oid), c=
->stage);
> >> > +                     else if (last && !strcmp(last, name))
> >> >                               continue;
> >> >                       write_name_quoted_relative(
> >> >                               name, prefix, stdout, line_termination=
);
> >>
> >> OK.  The addition (and disabling of the deduping) is quite trivial.
> >> We do not even have to worry about line termination since the extra
> >> pieces of info are prepended to the pathname.  Nice.
> >>
> >> > @@ -485,6 +490,10 @@ int cmd_merge_tree(int argc, const char **argv,=
 const char *prefix)
> >> >                           N_("do a trivial merge only"), 't'),
> >> >               OPT_BOOL(0, "messages", &o.show_messages,
> >> >                        N_("also show informational/conflict messages=
")),
> >> > +             OPT_BOOL_F('l', "exclude-modes-oids-stages",
> >> > +                        &o.exclude_modes_oids_stages,
> >> > +                        N_("list conflicted files without modes/oid=
s/stages"),
> >> > +                        PARSE_OPT_NONEG),
> >>
> >> Why does "-l" give shorter output than without it?  "-l" strongly
> >> hints a longer output than without, at least to me.  Just wondering
> >> if this will not become a source of confusion to future scripting
> >> users.
> >
> > Here's another example where I was struggling with naming.  Something
> > like ls-tree's `--name-only` would have been nice, but I was worried
> > it'd be confusing since it only affected the conflicted info section
> > and does not suppress the printing of the toplevel tree or the
> > informational messages sections.  And the name
> > --exclude-modes-oids-stages was long enough that I wanted a short flag
> > for it, and just used the first letter of the description ("list
> > conflicted files...").  I'm happy to change either the long or the
> > short name for this flag if anyone has suggestions.
>
> There's always sidestepping it by replacing it with a --format :)

Another solution that occurred to me, and I was _really_ close to
doing it for v3, was to just flat drop this patch entirely and not
include any such option.  But...

  * "Which files had conflicts?" seems like such an obvious question
  * I've used `git ls-files -u | awk {print\$4} | uniq` a lot in the
past after `git merge` (Or `git rebase`) to get this info (yeah, it
turns out `git diff --name-only --diff-filter=3DU` is 4 fewer
characters)
  * "display the list of files where conflicts were present in the web
UI" was listed as an early usecase[1]

[1] https://lore.kernel.org/git/YYlqpuzv+bmZaFzz@nand.local/

So it seemed like making that question easy to answer was worthwhile.

> Anyway, I'd mentioned that in an earlier review in
> <220124.864k5tigto.gmgdl@evledraar.gmail.com>. FWIW here's an experiment
> to do that that I polished up (mostly copied from the ls-tree WIP code
> I'd written already).
>
> I don't know if it will ever be useful, or if you think it's
> worthwhile/simpler, but in either case I think in doing this I spotted
> the following issues or otherwise noted inconsistencies in the pre-image:
>
>    The docs say that "<stage> <path>" is SP-separated, but it's
>    actually TAB-separated, the rest is SP-separated.

Yeah, good catch.  However, it doesn't actually say they are
SP-separated; it's ambiguous about the spacing.  Which probably isn't
a good thing, but it was kind of copied from the ls-files manual:

"""
       git ls-files just outputs the filenames unless --stage is specified =
in
       which case it outputs:

           [<tag> ]<mode> <object> <stage> <file>
"""

(which also uses a tab between <stage> and <file> and a space
otherwise, but the output above may lead you to believe otherwise.)

>  * That you de-dupe --exclude-modes-oids-stages is a bit of a hidden feat=
ure,
>    but argubly initiative. Should it by optional? In any case my formatti=
ng
>    experiment makes it optional, since it then needs to be generalized to=
 de-dupe
>    after we've formatted.

I think without de-duping the flag isn't helpful enough to bother
implementing.  Requiring two flags also seems painful, given the
common case scenario.

I hope I'm not coming across as dismissive.  I think eventually adding
a --format and --dedupe (the combination of which might be implied by
whatever flag is used now) might be useful additions.  Maybe --abbrev
too...eventually.  But I'm worried that it's distracting from focusing
on usecases.  In particular, I'm worried it leads to "well, script
writers technically can get what they want because we provided
everything" rather than focusing on making the most common things easy
to get, and then extending the command for flexibility as needed
later.

I'd really rather that early versions _just_ focus on actual usecases
as far as UI is concerned (and thus I was really happy to see Dscho
and Taylor concentrate on that side; I think Christian might have been
talking about that angle some but it was hard to differentiate from
the "merge-tree on steroids" spitballing).  While I want to be careful
to avoid preventing UI flexibility, I think building it in from the
beginning tends to lead to a design that is less usable.  (e.g. the
possible loss of de-duping that would naturally have arisen from
looking at things from the other angle.)  It's just a bias I have.

>  * Perhaps we should support --abbrev as ls-tree does? The below diff sho=
ws
>    it's easy enough.

This one is less problematic to me, but I'd still rather that the UI
side of things focused on the usecases for early versions.

>  * The dance you have with sed-ing out the hash in the tests could be mad=
e much
>    easier with "sed 1d <out >actual" and --no-messages for some existing =
tests.

Ignoring the first line is semantically different than verifying it
looks like a hash.  It also only works on the first line, and hashes
appear in multiple places, so you'd need a variety of different sed
commands for different parts of the output, which doesn't seem any
easier at all to me; I think using the same replacement everywhere is
simpler.  But perhaps I should turn it into a shell function that I
use in each case.

> diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-t=
ree.txt
> index 6a2ed475106..e906d1dc9bf 100644
> --- a/Documentation/git-merge-tree.txt
> +++ b/Documentation/git-merge-tree.txt
> @@ -44,10 +44,9 @@ OPTIONS
>         newline.  Also begin the messages section with a NUL character
>         instead of a newline.  See OUTPUT below for more information.
>
> ---exclude-oids-and-modes::
> -       Instead of writing a list of (mode, oid, stage, path) tuples
> -       to output for conflicted files, just provide a list of
> -       filenames with conflicts.
> +--conflict-format::
> +       Override the default "%(objectmode) %(objectname)
> +       %(stage)%x09%(path)" format.
>
>  --[no-]messages::
>         Write any informational messages such as "Auto-merging <path>"
> @@ -89,13 +88,13 @@ Conflicted file info
>
>  This is a sequence of lines with the format
>
> -       <mode> <object> <stage> <filename>
> +       %(objectmode) %(objectname) %(stage)%x09%(path)
>
>  The filename will be quoted as explained for the configuration
> -variable `core.quotePath` (see linkgit:git-config[1]).  However, if
> -the `--exclude-oids-and-modes` option is passed, the mode, object, and
> -stage will be omitted.  If `-z` is passed, the "lines" are terminated
> -by a NUL character instead of a newline character.
> +variable `core.quotePath` (see linkgit:git-config[1]).
> +
> +If `-z` is passed, the "lines" are terminated by a NUL character
> +instead of a newline character.
>
>  Informational messages
>  ~~~~~~~~~~~~~~~~~~~~~~
> diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
> index 58c0ddc5a32..14fed95a8ce 100644
> --- a/builtin/merge-tree.c
> +++ b/builtin/merge-tree.c
> @@ -395,9 +395,64 @@ struct merge_tree_options {
>         int mode;
>         int allow_unrelated_histories;
>         int show_messages;
> -       int exclude_modes_oids_stages;
> +       const char *conflict_format;
> +       int unique_conflicts;
> +       int abbrev;
>  };
>
> +struct expand_conflict_data {
> +       const char *prefix;
> +       struct string_list_item *item;
> +       struct strbuf *scratch;
> +       int abbrev;
> +       struct strbuf *sb_tmp;
> +};
> +static size_t expand_conflict_format(struct strbuf *sb,
> +                                    const char *start,
> +                                    void *context)
> +{
> +       struct expand_conflict_data *data =3D context;
> +       struct string_list_item *item =3D data->item;
> +       struct stage_info *info =3D item->util;
> +       const char *end;
> +       const char *p;
> +       size_t len;
> +
> +       len =3D strbuf_expand_literal_cb(sb, start, NULL);
> +       if (len)
> +               return len;
> +
> +       if (*start !=3D '(')
> +               die(_("bad format as of '%s'"), start);
> +       end =3D strchr(start + 1, ')');
> +       if (!end)
> +               die(_("format element '%s' does not end in ')'"), start);
> +       len =3D end - start + 1;
> +
> +       if (skip_prefix(start, "(objectmode)", &p)) {
> +               strbuf_addf(sb, "%06o", info->mode);
> +       } else if (skip_prefix(start, "(objectname)", &p)) {
> +               strbuf_addstr(sb, find_unique_abbrev(&info->oid, data->ab=
brev));
> +       } else if (skip_prefix(start, "(stage)", &p)) {
> +               strbuf_addf(sb, "%d", info->stage);
> +       } else if (skip_prefix(start, "(path)", &p)) {
> +               const char *name =3D item->string;
> +
> +               if (data->prefix)
> +                       name =3D relative_path(name, data->prefix, data->=
scratch);
> +               strbuf_addstr(sb, name);
> +
> +               strbuf_reset(data->sb_tmp);
> +               /* The relative_path() function resets "scratch" */
> +
> +       } else {
> +               unsigned int errlen =3D (unsigned long)len;
> +               die(_("bad format specifier %%%.*s"), errlen, start);
> +       }
> +
> +       return len;
> +}
> +
>  static int real_merge(struct merge_tree_options *o,
>                       const char *branch1, const char *branch2,
>                       const char *prefix)
> @@ -446,23 +501,43 @@ static int real_merge(struct merge_tree_options *o,
>         puts(oid_to_hex(&result.tree->object.oid));
>         if (!result.clean) {
>                 struct string_list conflicted_files =3D STRING_LIST_INIT_=
NODUP;
> -               const char *last =3D NULL;
> -               int i;
> +               struct string_list_item *item;
> +               char *last =3D NULL;
> +               struct strbuf sb =3D STRBUF_INIT;
> +               struct strbuf tmp =3D STRBUF_INIT;
>
>                 merge_get_conflicted_files(&result, &conflicted_files);
> -               for (i =3D 0; i < conflicted_files.nr; i++) {
> -                       const char *name =3D conflicted_files.items[i].st=
ring;
> -                       struct stage_info *c =3D conflicted_files.items[i=
].util;
> -                       if (!o->exclude_modes_oids_stages)
> -                               printf("%06o %s %d\t",
> -                                      c->mode, oid_to_hex(&c->oid), c->s=
tage);
> -                       else if (last && !strcmp(last, name))
> +               for_each_string_list_item(item, &conflicted_files) {
> +                       struct expand_conflict_data ctx =3D {
> +                               .prefix =3D prefix,
> +                               .item =3D item,
> +                               .abbrev =3D o->abbrev,
> +                               .scratch =3D &sb,
> +                               .sb_tmp =3D &tmp,
> +                       };
> +
> +                       strbuf_expand(&sb, o->conflict_format, expand_con=
flict_format, &ctx);
> +                       strbuf_addch(&sb, line_termination);
> +
> +                       if (o->unique_conflicts && last && !strcmp(last, =
sb.buf)) {
> +                               free(last);
> +                               last =3D strbuf_detach(&sb, NULL);
>                                 continue;
> -                       write_name_quoted_relative(
> -                               name, prefix, stdout, line_termination);
> -                       last =3D name;
> +                       }
> +
> +                       fwrite(sb.buf, sb.len, 1, stdout);
> +
> +                       if (o->unique_conflicts) {
> +                               free(last);
> +                               last =3D strbuf_detach(&sb, NULL);
> +                       } else {
> +                               strbuf_reset(&sb);
> +                       }
>                 }
>                 string_list_clear(&conflicted_files, 1);
> +               strbuf_release(&sb);
> +               strbuf_release(&tmp);
> +               free(last);
>         }
>         if (o->show_messages) {
>                 putchar(line_termination);
> @@ -474,7 +549,11 @@ static int real_merge(struct merge_tree_options *o,
>
>  int cmd_merge_tree(int argc, const char **argv, const char *prefix)
>  {
> -       struct merge_tree_options o =3D { .show_messages =3D -1 };
> +       struct merge_tree_options o =3D {
> +               .show_messages =3D -1,
> +               .conflict_format =3D "%(objectmode) %(objectname) %(stage=
)%x09%(path)",
> +               .unique_conflicts =3D 1,
> +       };
>         int expected_remaining_argc;
>         int original_argc;
>
> @@ -493,14 +572,15 @@ int cmd_merge_tree(int argc, const char **argv, con=
st char *prefix)
>                          N_("also show informational/conflict messages"))=
,
>                 OPT_SET_INT('z', NULL, &line_termination,
>                             N_("separate paths with the NUL character"), =
'\0'),
> -               OPT_BOOL_F('l', "exclude-modes-oids-stages",
> -                          &o.exclude_modes_oids_stages,
> -                          N_("list conflicted files without modes/oids/s=
tages"),
> -                          PARSE_OPT_NONEG),
> +               OPT_STRING(0, "conflict-format", &o.conflict_format, N_("=
format"),
> +                          N_("specify a custom format to use for conflic=
ted files")),
> +               OPT_BOOL(0, "unique-conflicts", &o.unique_conflicts,
> +                        N_("omit duplicate --conflict-format lines")),

The latter of which you didn't include in the manual?  Also,
unique_conflicts seems like something that is trivial to understand
from the coding perspective, but probably require quite a bit more
explanation from the manual.  For example, if objectname is included
in the format, unique-conflicts is essentially a no-op.  And that's
the default...so, you'd probably have to spend time in the manual
explaining under what circumstances it's useful.  I'm also not sure if
a user who wanted (mode, path) would want unique_conflicts to default
to 1; it may be something only meaningful in the particular case of
"just give me conflicted filenames".

>                 OPT_BOOL_F(0, "allow-unrelated-histories",
>                            &o.allow_unrelated_histories,
>                            N_("allow merging unrelated histories"),
>                            PARSE_OPT_NONEG),
> +               OPT__ABBREV(&o.abbrev),
>                 OPT_END()
>         };
>
> diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-=
tree.sh
> index 4de089d976d..e6354b2d284 100755
> --- a/t/t4301-merge-tree-write-tree.sh
> +++ b/t/t4301-merge-tree-write-tree.sh
> @@ -93,7 +93,7 @@ test_expect_success 'Barf on too many arguments' '
>  '
>
>  test_expect_success 'test conflict notices and such' '
> -       test_expect_code 1 git merge-tree --write-tree --exclude-modes-oi=
ds-stages side1 side2 >out &&
> +       test_expect_code 1 git merge-tree --write-tree --conflict-format=
=3D"%(path)" side1 side2 >out &&
>         sed -e "s/[0-9a-f]\{40,\}/HASH/g" out >actual &&
>
>         # Expected results:
> @@ -115,8 +115,35 @@ test_expect_success 'test conflict notices and such'=
 '
>         test_cmp expect actual
>  '
>
> +test_expect_success 'merge-tree --unique-conflicts is the default' '
> +       test_expect_code 1 git merge-tree --write-tree --conflict-format=
=3D"%(path)" --no-messages side1 side2 >out &&
> +       sed 1d <out >actual &&
> +       cat >expect <<-\EOF &&
> +       greeting
> +       whatever~side1
> +       EOF
> +       test_cmp expect actual &&
> +
> +       test_expect_code 1 git merge-tree --write-tree --conflict-format=
=3D"%(path)" --no-messages side1 side2 >out2 &&
> +       sed 1d <out2 >actual2 &&
> +       test_cmp actual actual2
> +'
> +
> +test_expect_success 'merge-tree --no-unique-conflicts' '
> +       test_expect_code 1 git merge-tree --write-tree --conflict-format=
=3D"%(path)" --no-unique-conflicts --no-messages side1 side2 >out &&
> +       sed 1d <out >actual &&
> +       cat >expect <<-\EOF &&
> +       greeting
> +       greeting
> +       greeting
> +       whatever~side1
> +       whatever~side1
> +       EOF
> +       test_cmp expect actual
> +'
> +
>  test_expect_success 'Just the conflicted files without the messages' '
> -       test_expect_code 1 git merge-tree --write-tree --no-messages --ex=
clude-modes-oids-stages side1 side2 >out &&
> +       test_expect_code 1 git merge-tree --write-tree --no-messages --co=
nflict-format=3D"%(path)" side1 side2 >out &&
>         sed -e "s/[0-9a-f]\{40,\}/HASH/g" out >actual &&
>
>         test_write_lines HASH greeting whatever~side1 >expect &&
