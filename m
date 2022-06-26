Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B410FC43334
	for <git@archiver.kernel.org>; Sun, 26 Jun 2022 13:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234590AbiFZNeU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jun 2022 09:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbiFZNeT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jun 2022 09:34:19 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BB3EE08
        for <git@vger.kernel.org>; Sun, 26 Jun 2022 06:34:18 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id p69so7154220iod.10
        for <git@vger.kernel.org>; Sun, 26 Jun 2022 06:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=osUmEa9BaAQY7EUJ2eVfF341clJ9uEmKJh77/WTxriw=;
        b=VxdHTRT1ePhyO+EntCIYaJXst0KMv1CVD0DY+/ZpE9uBVKZj2htnh/hSHliztHASnK
         6/6ZMiMGfbvC+NuQJ1TUTcMtSuzphHaUzH1KGjHTSQHE9BRr2ufDZhimHnamWGKS05SB
         bcsCLTdkj7Zk7hff24u+aT/uJNLpzkUP8PfA9HPFuLjQpifK8EM7Wd56aH8bENJNGSXy
         k5egwtAWvwoBYirc8tJ1lR4lpOyMXuejOWtzJ5Ltqpj8go/Fn2+W9WuWG9RoMiPPNFxi
         exo0TCzyhCdJdlHdk0euUEWPI+bGchKJbYHTZ/Fr+Bpcg3X/m34kIJ67rg1ZEAvNC8HW
         aq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=osUmEa9BaAQY7EUJ2eVfF341clJ9uEmKJh77/WTxriw=;
        b=pvOZjhzLWEqGqCpRfyPq49519g0CQr4Xg4XxN3Fn49utHxYreVwqb12bWvfaN8XVzP
         dE0zKE0bllE/teUfbvCHK3my5WaXn+MotH0U+PU5dZn/UseRL9aChgqSCLkY0pKHMEmc
         jCGmWv+xVAWR7ZqRxp/IH1MXH2OVPbAhbWnbr+8eC874iQ1yRQKwpPId0yZlE2j5bL8v
         XYpjfc1SR/L0qFXPrjeXBS83oDl7EdRXTMJ+b/8EaNCejUYPh0DJjMGyXQGRpn/CMCL8
         dFTrPNSFa2ykVZhs7gawK5xR4B8FTlGVYsT7mChUDVnflczUl8/ihOdhAvOX4nhuysXt
         /XTg==
X-Gm-Message-State: AJIora+2JFDNc8CZhhq+KLcay1bkFLVlkMn1bbFvwpbkdKBOq6lahFxV
        yloYPt4l27eJG5v7EfO4eFa5WMveeeboq5gNI2c5sPxWq9jiBQ==
X-Google-Smtp-Source: AGRyM1tCWORKzwbIldba+RYUFGiwKwRqJhrRCZqXatGfzI4L6qqEnWzYJXclwwa5YYiVXRP9DfoWt/H9zCmW+rCSBr8=
X-Received: by 2002:a6b:e70a:0:b0:674:eec5:b7a0 with SMTP id
 b10-20020a6be70a000000b00674eec5b7a0mr4211321ioh.174.1656250458057; Sun, 26
 Jun 2022 06:34:18 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1262.v2.git.1655629990185.gitgitgadget@gmail.com>
 <pull.1262.v3.git.1655777140231.gitgitgadget@gmail.com> <220624.86letmi383.gmgdl@evledraar.gmail.com>
In-Reply-To: <220624.86letmi383.gmgdl@evledraar.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 26 Jun 2022 21:34:06 +0800
Message-ID: <CAOLTT8RPrtgcsrrdPwNTcD2WUozThaN_QRYu+JOO2er0F8a8-w@mail.gmail.com>
Subject: Re: [PATCH v3] ls-files: introduce "--format" option
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> =E4=BA=8E2022=E5=
=B9=B46=E6=9C=8824=E6=97=A5=E5=91=A8=E4=BA=94 21:46=E5=86=99=E9=81=93=EF=BC=
=9A
>
>
> On Tue, Jun 21 2022, ZheNing Hu via GitGitGadget wrote:
>
> > From: ZheNing Hu <adlternative@gmail.com>
> > [...]
>
> In my mind almost the entire point of a --format is that you can
> e.g. \0-delimit it, and don't need to do other parsing games.
>
> So this really should be adding just e.g. "%x", not "flags: %x",
>

Yeah, I admit that there really shouldn't use extra formatting here.

> Similarly, let's no have :-delimited fields. First, for a formatted
> number "1656077225:850723245" is just bizarre for %(ctime), let's use
> ".", not ":", so: "1656077225.850723245".
>
> And let's call that %(ctime), then have (which is trivial to add) a
> %(ctime:sec) and %(ctime:nsec), so someone who wants to format this can
> parse it as they please, ditto for mtime.
>
> Looking at your tests it seemed you went down the route of aligning the
> output with the --debug output, which is already pre-formatted. I.e. to
> make what you have here match:
>
>                 printf("  ctime: %u:%u\n", sd->sd_ctime.sec, sd->sd_ctime=
.nsec);
>                 printf("  mtime: %u:%u\n", sd->sd_mtime.sec, sd->sd_mtime=
.nsec);
>                 printf("  dev: %u\tino: %u\n", sd->sd_dev, sd->sd_ino);
>                 printf("  uid: %u\tgid: %u\n", sd->sd_uid, sd->sd_gid);
>                 printf("  size: %u\tflags: %x\n", sd->sd_size, ce->ce_fla=
gs);
>
> I think that's a mistake, we should be able to emit those individual
> %-specifiers instead, not that line as-is without the " " prefix and
> "\n" suffix.
>

Yeah, agree. But now I just want to delete all atoms from %(ctime) to %(fla=
gs),
and let --debug can work with --format.

> > +
> > +     if (format && (show_stage || show_others || show_killed ||
> > +             show_resolve_undo || skipping_duplicates || debug_mode))
> > +                     die(_("ls-files --format cannot used with -s, -o,=
 -k, --resolve-undo, --deduplicate, --debug"));
>
> Use usage_msg_opt() or usage_msg_optf() here instead of die(), and no
> need to include "ls-files " in the message.
>
> See die_for_incompatible_opt4, maybe you can just use that instead? A
> bit painful, but:
>
>     die_for_incompatible_opt4(format, "--format", show_stage, "-s", show_=
others, "-o", show_killed, "-k");
>     die_for_incompatible_opt4(format, "--format", show_resolve_undo, "--r=
esolve-undo", skipping_duplicates, "--deduplicate", debug_mode, "--debug");
>

Good suggestion. I am curious about why there is no function like
die_for_incompatible_opt4() with variable parameters?

> But urgh, that helper really should use usage_msg_opt() instead, but
> using it for now as-is probably sucks less.
>
> I also think we should not forbid combining this wtih --debug, it's
> helpful to construct a format. This seems to work:
>
>         diff --git a/builtin/ls-files.c b/builtin/ls-files.c
>         index 387641b32df..82f13edef7e 100644
>         --- a/builtin/ls-files.c
>         +++ b/builtin/ls-files.c
>         @@ -343,12 +343,17 @@ static void show_ce(struct repository *repo=
, struct dir_struct *dir,
>                                           S_ISGITLINK(ce->ce_mode))) {
>                         if (format) {
>                                 show_ce_fmt(repo, ce, format, fullname);
>         -                       return;
>         +                       if (!debug_mode)
>         +                               return;
>                         }
>
>                         tag =3D get_tag(ce, tag);
>
>         -               if (!show_stage) {
>         +               if (format) {
>         +                       if (!debug_mode)
>         +                               BUG("unreachable");
>         +                       ; /* for --debug */
>         +               } else if (!show_stage) {
>                                 fputs(tag, stdout);
>                         } else {
>                                 printf("%s%06o %s %d\t",
>         @@ -814,7 +819,7 @@ int cmd_ls_files(int argc, const char **argv,=
 const char *cmd_prefix)
>                 }
>
>                 if (format && (show_stage || show_others || show_killed |=
|
>         -               show_resolve_undo || skipping_duplicates || debug=
_mode))
>         +               show_resolve_undo || skipping_duplicates))
>                                 die(_("ls-files --format cannot used with=
 -s, -o, -k, --resolve-undo, --deduplicate, --debug"));
>
>                 if (show_tag || show_valid_bit || show_fsmonitor_bit) {
>
> I.e. we'll get:
>
>         $ ./git ls-files --debug --format=3D'<%(flags) %(path)>'  -- po/i=
s.po
>         <flags: 0 po/is.po>
>         po/is.po
>           ctime: 1654300098:369653868
>           mtime: 1654300098:369653868
>           dev: 2306     ino: 10487322
>           uid: 1001     gid: 1001
>           size: 3370    flags: 0
>
> Which I think is quite useful when poking around in this an coming up
> with a format.
>

Maybe something like this will be easier?


@@ -343,6 +335,7 @@ static void show_ce(struct repository *repo,
struct dir_struct *dir,
                                  S_ISGITLINK(ce->ce_mode))) {
                if (format) {
                        show_ce_fmt(repo, ce, format, fullname);
+                       print_debug(ce);
                        return;
                }


> > +
> >       if (show_tag || show_valid_bit || show_fsmonitor_bit) {
> >               tag_cached =3D "H ";
> >               tag_unmerged =3D "M ";
> > diff --git a/t/t3013-ls-files-format.sh b/t/t3013-ls-files-format.sh
> > new file mode 100755
> > index 00000000000..8c3ef2df138
> > --- /dev/null
> > +++ b/t/t3013-ls-files-format.sh
> > @@ -0,0 +1,124 @@
> > +#!/bin/sh
> > +
> > +test_description=3D'git ls-files --format test'
> > +
>
> Add this line here:
>
> TEST_PASSES_SANITIZE_LEAK=3Dtrue
>
> I.e. just before test-lib.sh, see other test examples. Then we'll test
> this under SANITIZE=3Dleak in CI, to ensure it doesn't leak memory.
>
> > +. ./test-lib.sh
> > +
> > +test_expect_success 'setup' '
> > +     echo o1 >o1 &&
> > +     echo o2 >o2 &&
> > +     git add o1 o2 &&
> > +     git add --chmod +x o1 &&
> > +     git commit -m base
> > +'
> > +
> > [...]
>
> > +for flag in -s -o -k --resolve-undo --deduplicate --debug
> > +do
> > +     test_expect_success "git ls-files --format is incompatible with $=
flag" '
> > +             test_must_fail git ls-files --format=3D"%(objectname)" $f=
lag
> > +     '
> > +done
>
> Nit: I think it's good to move these sotrs of tests before "setup", and
> give them a "usage: " prefix, see some other existing examples.
>

Agree.

> We usually use test_expect_code 129 for those, depending on if you'll
> end up with die() or not...
>
> nit: missing \n before this line:
>
> > +test_done
> >
> > base-commit: ab336e8f1c8009c8b1aab8deb592148e69217085
>

ZheNing Hu
