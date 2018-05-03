Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35635200B9
	for <e@80x24.org>; Thu,  3 May 2018 21:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751103AbeECVBk (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 17:01:40 -0400
Received: from mout.gmx.net ([212.227.17.22]:35969 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750822AbeECVBj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 17:01:39 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MUHbK-1enIJK29Hm-00R158; Thu, 03
 May 2018 23:01:32 +0200
Date:   Thu, 3 May 2018 23:01:33 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Stefan Beller <sbeller@google.com>
cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH 03/18] branch-diff: first rudimentary implementation
In-Reply-To: <CAGZ79kYzZkdZKdR4hMK0V6D6=cm4damct01MGidGA0g-dtW+gQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1805032246040.77@tvgsbejvaqbjf.bet>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <ec51c71779a325263c1b705a6b1bfb003fcd528a.1525361419.git.johannes.schindelin@gmx.de> <CAGZ79kYzZkdZKdR4hMK0V6D6=cm4damct01MGidGA0g-dtW+gQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:9DqANfxlSXyD1sjbZdkgt9Tqb09Cc11ieZK5dVXFa2lILgCQdaZ
 1WVW6YJSCQwE6X4QNnkk6ouCIrhzXoQdE61SN9dAg3wMZpdHCwCtHm7E2Avp5YBT1bJXXYG
 w4iZr9cMcW72c8C+s4nBHdMdqR3DrOSKfQXb0I/F1CJtyDJk56ngJ7TUX8coz7EFK+eSaZP
 ZCEY5FCBnxPO0ILeebg/g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YunfFVCMRqI=:8alzbqfeN2m2q926b0iMHc
 gMl0azmH4UXGakBgEn4D/Qmlfg6no2hdRMCDDXbssrm/6spx83PPlUvJSNf9ddbB+sQXs7wBy
 zock2wkxrdZ18yo9jdoSYeKe7ayOHK7xQU96w4JrC/gca3pckH1SyPYbFiLRRK3P8L+8KszHe
 dsvOPoG3ER0Z49inmJquOqHS4kJ9//umVY8CQvEkJ5YZi84K8FPe7w9JenARu6WfDdpMEq0bE
 o1nOsQ4bq8Asl7R1Ww9gq+EoYHVjp2vfkfPYd/u1mpvcVra98mAfa8jbi66AFlx/a7pLMDK8b
 8Ea7YpYzz1VkWj2ktOKTagrFnNiCz7xgI9h6mRDwXQ8wy4YZQE3Gc+UkVvC+s8C+cJs0Fk4uG
 zTfLEvPF448pJZbiJrK/nUEuSkakrA0dlTo2vQU+0w52HGZcOpamuWUQ8FBF4ZgBI5EEDVirh
 aOxfPnn2IpvrNxblgj8/pci/q9VZqRmHXbkQreTbxmGzs1bIms3zZB0La/vCEDIKezwnhcREx
 YhTLITuTv1BdYfIofVXX1XXKIe5UaSOvxUAog1VQlMdnVOOiCkTUf9QsGvU2drzSi7pAZam+J
 yQQOxKc4t0ubtTasfjTVTJlWBB2lacqtP+ef4qZ6xlQL1C454lTFJmJZLiVlezsTO2+OsJOhD
 zB3qQtzogFTw7kHEFfs+jE59QPtbx0YY49HvCBeV9COjn6+OPb+8m7KRYzRh73m16I4MK4kAg
 ds0ULgEeu3LtnUu2TCl6MtxFq9/wQaSY8N5H1KPQvHpSlutIv4Ngv4IIyhhdgeKQ+aRAfwxgh
 i5hXI/5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Thu, 3 May 2018, Stefan Beller wrote:

> On Thu, May 3, 2018 at 8:30 AM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> 
> > Note: due to differences in the diff algorithm (`tbdiff` uses the
> > Pythong module `difflib`, Git uses its xdiff fork), the cost matrix
> > calculated by `branch-diff` is different (but very similar) to the one
> > calculated by `tbdiff`. Therefore, it is possible that they find
> > different matching commits in corner cases (e.g. when a patch was
> > split into two patches of roughly equal length).
> 
> Does that mean, we may want to tweak the underlying diff parameters for
> this special use case eventually?

I don't think that will be necessary. Generating diffs is an ambiguous
business, after all, and we just have to live with the consequence that it
might even be possible that the cost is non-symmetric, i.e. that the
length (i.e. line count) of the diff is different depending whether we
compare old patch to new patch vs new patch to old patch.

If the result changes due to these vagaries, it means that there is no
single one good answer to the question which old/new commits form a pair.
I would expect that only to happen if a commit with a lengthy diff is cut
into two commits whose diffs have roughly equal lengths (so that the
difference of the commit message won't matter that much).

> > -#define COLOR_DUAL_MODE 2
> > -
> 
> Leave this out in the first patch?

Yep, as Ramsay said.

> > @@ -19,6 +23,279 @@ static int parse_creation_weight(const struct option *opt, const char *arg,
> >         return 0;
> >  }
> >
> > +struct patch_util {
> > +       /* For the search for an exact match */
> > +       struct hashmap_entry e;
> > +       const char *diff, *patch;
> > +
> > +       int i;
> > +       int diffsize;
> > +       size_t diff_offset;
> > +       /* the index of the matching item in the other branch, or -1 */
> > +       int matching;
> > +       struct object_id oid;
> > +};
> > +
> > +/*
> > + * Reads the patches into a string list, with the `util` field being populated
> > + * as struct object_id (will need to be free()d).
> > + */
> > +static int read_patches(const char *range, struct string_list *list)
> > +{
> > +       struct child_process cp = CHILD_PROCESS_INIT;
> > +       FILE *in;
> > +       struct strbuf buf = STRBUF_INIT, line = STRBUF_INIT;
> > +       struct patch_util *util = NULL;
> > +       int in_header = 1;
> > +
> > +       argv_array_pushl(&cp.args, "log", "--no-color", "-p", "--no-merges",
> > +                       "--reverse", "--date-order", "--decorate=no",
> > +                       "--no-abbrev-commit", range,
> > +                       NULL);
> > +       cp.out = -1;
> > +       cp.no_stdin = 1;
> > +       cp.git_cmd = 1;
> > +
> > +       if (start_command(&cp))
> > +               return error_errno(_("could not start `log`"));
> > +       in = fdopen(cp.out, "r");
> > +       if (!in) {
> > +               error_errno(_("could not read `log` output"));
> > +               finish_command(&cp);
> > +               return -1;
> > +       }
> 
> With the implementation of --color-moved, there is an option
> to buffer all diff output in memory e6e045f8031 (diff.c: buffer
> all output if asked to, 2017-06-29), so I posit that running this
> diff in-core may be "not too hard". Famous last words.

True. I *did* stumble over emitted_symbols and thought that there might be
a way to leverage it, but I did not find any existing knob, and did not
want to interfere with any other user case of that feature (which we may
want to allow combining with branch-diff one day, afer all).

To be honest, the main reason I spawn here is that I did not want to be
bothered with resetting the commit flags after traversing the first commit
range. But I guess I was just too cheap and should really do it?

OTOH spawning here is a lot easier than not spawning, so maybe it would be
premature optimization?

> In addition to that patch, we'd have to buffer commit messages
> and buffer multiple commits, as that only buffers a diff of a single
> commit.

... and make sure that the moved-code logic (which is currently the only
user of emitted_symbols, correct?) would never be called at the same time
as we generate the diff.

> The benefit would be no invocation of new processes, letting us
> do more in core. This would allow for tweaking revision walking
> internally, e.g. passing of options to this command such as rename
> detection factors, can be passed through easily without the need
> of translating it back to the command line.

On the other hand, we can simply copy those options to the command-line
for `log`. Which might even be better, as e.g. `--format` changes global
state :-(

> > +
> > +               if (starts_with(line.buf, "diff --git")) {
> 
> When using the internal buffers, you would not need to
> string compare, but could just check for the
> DIFF_SYMBOL_HEADER.

True. Not sure whether the current way is *that* terrible, though, as the
`diff` line is meant for parsing by other commands, anyway.

> > +               } else if (starts_with(line.buf, "@@ "))
> > +                       strbuf_addstr(&buf, "@@");
> 
> So we omit line information for hunks. Makes sense,
> though then we could also skip the "index ..." lines?

And we do, in the next line:

> > +               else if (line.buf[0] && !starts_with(line.buf, "index "))

Ciao,
Dscho
