Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DB021F597
	for <e@80x24.org>; Tue, 17 Jul 2018 09:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729690AbeGQKZn (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 06:25:43 -0400
Received: from mout.gmx.net ([212.227.15.19]:34541 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729060AbeGQKZn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 06:25:43 -0400
Received: from [192.168.0.129] ([37.201.195.94]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lp3sy-1gHhde2paW-00eq9h; Tue, 17
 Jul 2018 11:53:46 +0200
Date:   Tue, 17 Jul 2018 11:53:29 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     gitgitgadget@gmail.com, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 03/20] range-diff: first rudimentary implementation
In-Reply-To: <CAPig+cQo1hM59P5eB4YTw=zvMAWh0OO8zsf0PMcwYoJtGwLKCQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1807162011210.71@tvgsbejvaqbjf.bet>
References: <cover.1525448066.git.johannes.schindelin@gmx.de> <pull.1.v3.git.gitgitgadget@gmail.com> <076e1192d15562d868a8a6014f36155f360da83d.1530617166.git.gitgitgadget@gmail.com> <CAPig+cQo1hM59P5eB4YTw=zvMAWh0OO8zsf0PMcwYoJtGwLKCQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:TUrxowA2BcwVLOqrX9KTXDWgXx9cK9j6upk27qC8fmxb6fRJQlV
 RB4akngvz/rI+GkDZkth7aMSTOOvXpK6xPbv2fW+UjIfs31vnTRz/NDb697O1MnYOD4BI5/
 iOo6CLtAHQ+3pocj8kgi3dSV9TkJu5umNTkWv7zUgFIIe4icU3lCLcfsE1Aq04pa8aI7XlC
 eUjKmddjPZmiUWv4OQBLQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:q22rn4pLMrc=:T2RzmVQ4oMdwVN/MepUF3Z
 Fzr+nfxniMLcM2x3w1rZmly4w7JFPjEfEm1g1b2hHX+VOpKQAxIV2vg1XnuqGyXVDEOi5htxS
 0eBnIdioePMp3YiQTgXGIO9HNFBbQO+9oEndMwF+FvWHO8J/3NTbIlDeRTkr/HLsRSwmBtLWN
 c5KXiQjuFPL6/Dg1iq6h0KZfK8MEih57iDfodEo5gPp8TBdcHmYhgECVLrRyU48jOCcd4j3Tq
 5No8N32MIZVBK5xLDTBjDjcKpTGUrVfFIzSOzcwLNElJE7as4+6gX9BSBxjxO5YWiU1JOZFWi
 xcNTaWGsq8rlrHAgTVyE9O3e/33VCDSzAquzHaijtTW0gT5qJvw7/eYx5EtOyCIiGkWeVx4ZF
 ORxVgObrrgKQ96HMW6jAarBQDJXiw1O0ZnQLuF0ohrSfO6VykEu+GJrF1QWqF1c8nuTBqW7Fu
 W7wY7bFVJMGjGgFQFIjHmAeM9pmvWJ7jBY6awDP1wTLb0u7/EbpTtk6ACiPiCbPjVURgdmgIx
 AG8WSFb5ZWGnDprvPvxZFhOYHvU+8zJgHVgMzAGgHxUYZYAh9mc1HPaJ/cIDyAOAALQvxb72i
 3gtdgjbRCkseetArq9U2mpt9t/hIKrhRofYvZ27LBy/dkZOIq8mM0VSZroBpHRymArIvoXR+8
 8d3jirxY6gR1a156AleLpMqBi1TYMX//9Q2Si9Yd0z7lDVAGJ+gqiMQsdnRj78CIBz5Q1NpMW
 agWLecjxcQmaOI0MW4ybW1hB70SSRHsgHIQeK5coXLXAyIVyYcdACm38zC0n/oBQdjNKaIB8u
 fgeVy7R
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Mon, 16 Jul 2018, Eric Sunshine wrote:

> On Tue, Jul 3, 2018 at 7:27 AM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > At this stage, `git range-diff` can determine corresponding commits
> > of two related commit ranges. This makes use of the recently introduced
> > implementation of the Hungarian algorithm.
> 
> Did you want s/Hungarian/Jonker-Volgenant/ here? (Not worth a re-roll.)

It is worth a new iteration, and I'd rather say "linear assignment" than
either Hungarian or Jonker-Volgenant. Thanks for pointing this out.

> > The core of this patch is a straight port of the ideas of tbdiff, the
> > apparently dormant project at https://github.com/trast/tbdiff.
> > [...]
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > diff --git a/builtin/range-diff.c b/builtin/range-diff.c
> > @@ -17,9 +18,49 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
> > +       int res = 0;
> > +       struct strbuf range1 = STRBUF_INIT, range2 = STRBUF_INIT;
> >
> > -       argc = parse_options(argc, argv, NULL, options,
> > -                            builtin_range_diff_usage, 0);
> > +       argc = parse_options(argc, argv, NULL, options, builtin_range_diff_usage,
> > +                            0);
> 
> This parse_options() change appears to be merely a re-wrapping of the
> line between patches 2 and 3.

True, and it is a bad change because it makes the line longer than 80
columns.

Fixed.

> > -       return 0;
> > +       if (argc == 2) {
> > +               if (!strstr(argv[0], ".."))
> > +                       warning(_("no .. in range: '%s'"), argv[0]);
> > +               strbuf_addstr(&range1, argv[0]);
> > +
> > +               if (!strstr(argv[1], ".."))
> > +                       warning(_("no .. in range: '%s'"), argv[1]);
> > +               strbuf_addstr(&range2, argv[1]);
> 
> Should these die() (like the "..." case below) rather than warning()?
> Warning and continuing doesn't seem like intended behavior. When I
> test this with on git.git and omit the "..", git sits for a long, long
> time consuming the CPU. I guess it's git-log'ing pretty much the
> entire history.

I had to go back to `git-tbdiff.py` to see how it handles this, and you
are right: it should die().

Fixed.

(Technically, it is conceivable that some user wants to compare two
independent commit histories, e.g. when a repository was imported from a
different SCM two times, independently. I guess when that happens, we can
always implement a `range-diff --root <tip1> <tip2>` or some such.)

>     % GIT_TRACE=1 git range-diff v1 v2
>     warning: no .. in range: 'v1'
>     warning: no .. in range: 'v2'
>     trace: git log --no-color -p --no-merges --reverse \
>         --date-order --decorate=no --no-abbrev-commit v1
>     ^C
>     %
> 
> > +       } else if (argc == 3) {
> > +               strbuf_addf(&range1, "%s..%s", argv[0], argv[1]);
> > +               strbuf_addf(&range2, "%s..%s", argv[0], argv[2]);
> > +       } else if (argc == 1) {
> > +               const char *b = strstr(argv[0], "..."), *a = argv[0];
> > +               int a_len;
> > +
> > +               if (!b)
> > +                       die(_("single arg format requires a symmetric range"));
> > diff --git a/range-diff.c b/range-diff.c
> > @@ -0,0 +1,307 @@
> > +static int read_patches(const char *range, struct string_list *list)
> > +{
> > +       while (strbuf_getline(&line, in) != EOF) {
> > +               if (skip_prefix(line.buf, "commit ", &p)) {
> > +                       [...]
> > +                       in_header = 1;
> > +                       continue;
> > +               }
> > +               if (starts_with(line.buf, "diff --git")) {
> > +                       in_header = 0;
> > +                       [...]
> > +               } else if (in_header) {
> > +                       if (starts_with(line.buf, "Author: ")) {
> > +                               [...]
> > +                       } else if (starts_with(line.buf, "    ")) {
> > +                               [...]
> > +                       }
> > +                       continue;
> > +               } else if (starts_with(line.buf, "@@ "))
> > +                       strbuf_addstr(&buf, "@@");
> > +               else if (line.buf[0] && !starts_with(line.buf, "index "))
> > +                       /*
> > +                        * A completely blank (not ' \n', which is context)
> > +                        * line is not valid in a diff.  We skip it
> > +                        * silently, because this neatly handles the blank
> > +                        * separator line between commits in git-log
> > +                        * output.
> > +                        */
> > +                       strbuf_addbuf(&buf, &line);
> 
> This comment had me confused for a bit since it doesn't seem to agree
> with the 'then' part of the 'if', but rather applies more to the
> 'else'.  Had it been split into two parts (one for 'then' and one for
> 'else'), it might have been easier to digest. That is, something like:
> 
>     else if (line.buf[0] && !starts_with(..., "index "))
>         /* A line we wish to keep. */
>         strbuf_addbuf(...);
>     else
>         /*
>          * A completely blank line between commits or
>          * or one in which we are otherwise not interested.
>          */
>         continue;
> 
> or something. Structuring it a bit differently might have helped, as well:
> 
>     else if (!line.buf[0])
>         /* A completely blank line between commits. */
>         continue;
>     else if (starts_with(..., "index "))
>         /* A line in which we are not interested. */
>         continue;
>     else
>         strbuf_addbuf(&buf, &line);

I like this much better, too.

> Not at all worth a re-roll.

I'll have to send a new iteration anyway, after digging into ws.c, I
think.

Also: I had this idea that dimming the "old" diff would make a ton of
sense, so I want to try that.

> > +               else
> > +                       continue;
> > +       if (util)
> > +               string_list_append(list, buf.buf)->util = util;
> 
> So, the parser is grabbing each commit and shoving all the
> "interesting" information about the commit in a 'patch_util'. It grabs
> the OID, author, the commit message (indented), the "diff --git",
> "+++", "---" lines (but ignores "index" line), "@@" lines (but
> ignoring the gunk after "@@"), and all context and patch lines.
> 
> Looks good.

Correct.

> > +       strbuf_release(&buf);
> > +
> > +       if (finish_command(&cp))
> > +               return -1;
> > +
> > +       return 0;
> > +}

Thank you for your suggestions!
Dscho
