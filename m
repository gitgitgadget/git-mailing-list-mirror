Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8F9C282C1
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 13:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E34C619E1
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 13:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242277AbhIMNgD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 09:36:03 -0400
Received: from mout.gmx.net ([212.227.15.18]:59149 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242687AbhIMNeT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 09:34:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631539973;
        bh=WXRetjxFEPgKDEltguv9WyjKn6NCOExJYXEx0rsX6zw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=R8IhmWsP+pFt002fzkhWvgg5Vell3RNIAkdZtmoYlvLt/40H9eIN3WVgM43jgkfx/
         5LwoPkQMfGSTWqlIsgP246LmebbsdAn8GE9iZUTCqbD1oJg2Bwl98TKu6ST1t1wp7t
         /wXoR0BfOMgM0YIRKt9yk1IqYZVYQhAOevyTeVBg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.116.95] ([89.1.214.165]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MAfUo-1mEonM3pUm-00B3lT; Mon, 13
 Sep 2021 15:32:53 +0200
Date:   Mon, 13 Sep 2021 15:32:50 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v3 01/15] scalar: create a rudimentary executable
In-Reply-To: <CABPp-BGxYVP6X6v5eu4grZUgDb6hmHYVDEwT1Cu4u592KeQ1fA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2109131531210.55@tvgsbejvaqbjf.bet>
References: <pull.1005.v2.git.1630691688.gitgitgadget@gmail.com> <pull.1005.v3.git.1631129086.gitgitgadget@gmail.com> <b8c7d3f84508ae0fb300f47c726764f4cbf46be9.1631129086.git.gitgitgadget@gmail.com>
 <CABPp-BGxYVP6X6v5eu4grZUgDb6hmHYVDEwT1Cu4u592KeQ1fA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:qMoBPnTx8ivetT/ycn1v2W+qsjj8MMoqIy8OKAMezyjbft3Abcd
 g5XtycrjLnu1dlJGXv6MmQNDOSKZ0I3K9DANo8Nhva3rS0EY/xZyzRoP7jNQbrneoqAw412
 eUDLqFenvn+ZKW4a6NqvJViYg7xYNyRejnoVlP46okV3pDvJ5MhZ+V9m534EResDDwsmobO
 jbOiPbssiRG+NwVsVYB2w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8Upb+8bj3QM=:TsLpL490Awt/bjMeRj28S6
 HmtfkmlQuleLuCDiSfkMMScD6Dlr+rk7uIrL6wutDEZg+BtUyamAJaGylxo4cF9lZRkk9h5P0
 gPFfxfSgtUSSlBnrD74mAmv/KbubjVdZ4BC8JjR947C0YvHCj1V+ZO3FJH2IYosD4tBfE1y9I
 QwqBAVN9eu+uSIVWsQZ5K9YQDy6i/qVmKmVwUzKunWUQ8+x8xJX02bU91ahsYg57dKqwBF5IW
 pylbKLHDmbHIgcBjvcKosqKmRrusRHbrg0yAyBkcFwJlRAtAh6l8VnldfplaEIx1d0t9jukUk
 bdXKg1S35YaB9CRI/1tPRRRZ8cP8XGARRaIYSE7R284s7GLcZb8Bhl8JAeg+vhy2M8DUQsqOu
 VJ28QI/YH74CjfymCnFr6Ve2C713QV4XZ58IF6sRhuNphnExwTUtBcgpQSXmf1I1oj6FUN28y
 wNGbxJutuETWjurhzCA9DrDiVqLjOfknW8fa52AVM1vGHs39nGHbmaRhUBr9bN2kmK8oxy4AK
 2pil3Ds9qIpejWEroE4Wa2LIOSd3odmgbp0z7VT39j8NguNmKAp85I9ajPI5GUAyqyFtEUq/6
 84tEUoYCu8jbyRsp6Dw7Xwu4IX3X7hMEvQiNaXaIlusb+a8FELPdCTuuGMHVnNVG/QyeHTHJ8
 AoOUmEk2Luywolj1W2Dsz0PELUM1fF2YCyx9/2rXs6T/y/7qHxaqgR0cXaYAkM8cFvNx/HfkY
 u9pQ6IYt2Eako0Hp8Nd7J5bPOaTnvUKPQVZd5BAJMZ+DHZDGYqoOTAmMH7zrikYKh3uqfyFMn
 FOBDch3rVDY+h/Tmi/010WN8wvrEh2Lws8Qtul33q02rL41ve+1fKjjmlJzLD6+ZnsA/6ZK7L
 JgZs6FpYKXVeVsE9K4oIRmsNm/h7IxrwmC7+7VbT6g65Rf4VuhVOENC703zIZZd3JlSv/YICd
 sEUWuJiWEPXS4+6IIlhLn79NeWoXBLa+gdlegXwokJ3plY7atmFiqPkSyYiHHN+mvkIp6CCRX
 IYnugLjy+5Oxilh2oLXBN2pzfL3vHi012hixaZnoOPO5G472xfPlSOY8l7OquBT3v1lPVXFgM
 YuZr+Namhtk0Kw=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Thu, 9 Sep 2021, Elijah Newren wrote:

> On Wed, Sep 8, 2021 at 12:24 PM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > The idea of Scalar (https://github.com/microsoft/scalar), and before
> > that, of VFS for Git, has always been to prove that Git _can_ scale, a=
nd
> > to upstream whatever strategies have been demonstrated to help.
> >
> > With this patch, we start the journey from that C# project to move wha=
t
> > is left to Git's own `contrib/` directory, reimplementing it in pure C=
,
> > with the intention to facilitate integrating the functionality into co=
re
> > Git all while maintaining backwards-compatibility for existing Scalar
> > users (which will be much easier when both live in the same worktree).
> > It was always to plan to contribute all of the proven strategies back =
to
> > core Git.
>
> s/always to plan/always the plan/
>
> > For example, while the virtual filesystem provided by VFS for Git help=
ed
> > the team developing the Windows operating system to move onto Git, whi=
le
> > trying to upstream it we realized that it cannot be done: getting the
> > virtual filesystem to work (which we only managed to implement fully o=
n
> > Windows, but not on, say, macOS or Linux), and the required server-sid=
e
> > support for the GVFS protocol, made this not quite feasible.
> >
> > The Scalar project learned from that and tackled the problem with
> > different tactics: instead of pretending to Git that the working
> > directory is fully populated, it _specifically_ teaches Git about
> > partial clone (which is based on VFS for Git's cache server), about
> > sparse checkout (which VFS for Git tried to do transparently, in the
> > file system layer), and regularly runs maintenance tasks to keep the
> > repository in a healthy state.
> >
> > With partial clone, sparse checkout and `git maintenance` having been
> > upstreamed, there is little left that `scalar.exe` does that which
> > `git.exe` cannot do. One such thing is that `scalar clone <url>` will
> > automatically set up a partial, sparse clone, and configure
> > known-helpful settings from the start.
>
> s/does that which/does which/

Thank you!

I am holding off from sending a new iteration (with the suggested fixes)
until tomorrow, waiting for more suggestions to trickle in.

Thanks,
Dscho

>
> > So let's bring this convenience into Git's tree.
> >
> > The idea here is that you can (optionally) build Scalar via
> >
> >         make -C contrib/scalar/Makefile
> >
> > This will build the `scalar` executable and put it into the
> > contrib/scalar/ subdirectory.
> >
> > The slightly awkward addition of the `contrib/scalar/*` bits to the
> > top-level `Makefile` are actually really required: we want to link to
> > `libgit.a`, which means that we will need to use the very same `CFLAGS=
`
> > and `LDFLAGS` as the rest of Git.
> >
> > An early development version of this patch tried to replicate all the
> > conditional code in `contrib/scalar/Makefile` (e.g. `NO_POLL`) just li=
ke
> > `contrib/svn-fe/Makefile` used to do before it was retired. It turned
> > out to be quite the whack-a-mole game: the SHA-1-related flags, the
> > flags enabling/disabling `compat/poll/`, `compat/regex/`,
> > `compat/win32mmap.c` & friends depending on the current platform... To
> > put it mildly: it was a major mess.
> >
> > Instead, this patch makes minimal changes to the top-level `Makefile` =
so
> > that the bits in `contrib/scalar/` can be compiled and linked, and
> > adds a `contrib/scalar/Makefile` that uses the top-level `Makefile` in=
 a
> > most minimal way to do the actual compiling.
> >
> > Note: With this commit, we only establish the infrastructure, no
> > Scalar functionality is implemented yet; We will do that incrementally
> > over the next few commits.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  Makefile                  |  8 ++++++++
> >  contrib/scalar/.gitignore |  2 ++
> >  contrib/scalar/Makefile   | 34 ++++++++++++++++++++++++++++++++++
> >  contrib/scalar/scalar.c   | 36 ++++++++++++++++++++++++++++++++++++
> >  4 files changed, 80 insertions(+)
> >  create mode 100644 contrib/scalar/.gitignore
> >  create mode 100644 contrib/scalar/Makefile
> >  create mode 100644 contrib/scalar/scalar.c
> >
> > diff --git a/Makefile b/Makefile
> > index c3565fc0f8f..2d5c822f7a8 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -2447,6 +2447,10 @@ endif
> >  .PHONY: objects
> >  objects: $(OBJECTS)
> >
> > +SCALAR_SOURCES :=3D contrib/scalar/scalar.c
> > +SCALAR_OBJECTS :=3D $(SCALAR_SOURCES:c=3Do)
> > +OBJECTS +=3D $(SCALAR_OBJECTS)
> > +
> >  dep_files :=3D $(foreach f,$(OBJECTS),$(dir $f).depend/$(notdir $f).d=
)
> >  dep_dirs :=3D $(addsuffix .depend,$(sort $(dir $(OBJECTS))))
> >
> > @@ -2586,6 +2590,10 @@ $(REMOTE_CURL_PRIMARY): remote-curl.o http.o ht=
tp-walker.o GIT-LDFLAGS $(GITLIBS
> >         $(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter=
 %.o,$^) \
> >                 $(CURL_LIBCURL) $(EXPAT_LIBEXPAT) $(LIBS)
> >
> > +contrib/scalar/scalar$X: $(SCALAR_OBJECTS) GIT-LDFLAGS $(GITLIBS)
> > +       $(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
> > +               $(filter %.o,$^) $(LIBS)
> > +
> >  $(LIB_FILE): $(LIB_OBJS)
> >         $(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
> >
> > diff --git a/contrib/scalar/.gitignore b/contrib/scalar/.gitignore
> > new file mode 100644
> > index 00000000000..ff3d47e84d0
> > --- /dev/null
> > +++ b/contrib/scalar/.gitignore
> > @@ -0,0 +1,2 @@
> > +/*.exe
> > +/scalar
> > diff --git a/contrib/scalar/Makefile b/contrib/scalar/Makefile
> > new file mode 100644
> > index 00000000000..40c03ad10e1
> > --- /dev/null
> > +++ b/contrib/scalar/Makefile
> > @@ -0,0 +1,34 @@
> > +QUIET_SUBDIR0  =3D +$(MAKE) -C # space to separate -C and subdir
> > +QUIET_SUBDIR1  =3D
> > +
> > +ifneq ($(findstring s,$(MAKEFLAGS)),s)
> > +ifndef V
> > +       QUIET_SUBDIR0  =3D +@subdir=3D
> > +       QUIET_SUBDIR1  =3D ;$(NO_SUBDIR) echo '   ' SUBDIR $$subdir; \
> > +                        $(MAKE) $(PRINT_DIR) -C $$subdir
> > +else
> > +       export V
> > +endif
> > +endif
> > +
> > +all:
> > +
> > +include ../../config.mak.uname
> > +-include ../../config.mak.autogen
> > +-include ../../config.mak
> > +
> > +TARGETS =3D scalar$(X) scalar.o
> > +GITLIBS =3D ../../common-main.o ../../libgit.a ../../xdiff/lib.a
> > +
> > +all: scalar$X
> > +
> > +$(GITLIBS):
> > +       $(QUIET_SUBDIR0)../.. $(QUIET_SUBDIR1) $(subst ../../,,$@)
> > +
> > +$(TARGETS): $(GITLIBS) scalar.c
> > +       $(QUIET_SUBDIR0)../.. $(QUIET_SUBDIR1) $(patsubst %,contrib/sc=
alar/%,$@)
> > +
> > +clean:
> > +       $(RM) $(TARGETS)
> > +
> > +.PHONY: all clean FORCE
> > diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
> > new file mode 100644
> > index 00000000000..7cff29e0fcd
> > --- /dev/null
> > +++ b/contrib/scalar/scalar.c
> > @@ -0,0 +1,36 @@
> > +/*
> > + * The Scalar command-line interface.
> > + */
> > +
> > +#include "cache.h"
> > +#include "gettext.h"
> > +#include "parse-options.h"
> > +
> > +static struct {
> > +       const char *name;
> > +       int (*fn)(int, const char **);
> > +} builtins[] =3D {
> > +       { NULL, NULL},
> > +};
> > +
> > +int cmd_main(int argc, const char **argv)
> > +{
> > +       struct strbuf scalar_usage =3D STRBUF_INIT;
> > +       int i;
> > +
> > +       if (argc > 1) {
> > +               argv++;
> > +               argc--;
> > +
> > +               for (i =3D 0; builtins[i].name; i++)
> > +                       if (!strcmp(builtins[i].name, argv[0]))
> > +                               return !!builtins[i].fn(argc, argv);
> > +       }
> > +
> > +       strbuf_addstr(&scalar_usage,
> > +                     N_("scalar <command> [<options>]\n\nCommands:\n"=
));
> > +       for (i =3D 0; builtins[i].name; i++)
> > +               strbuf_addf(&scalar_usage, "\t%s\n", builtins[i].name)=
;
> > +
> > +       usage(scalar_usage.buf);
> > +}
> > --
> > gitgitgadget
> >
>
