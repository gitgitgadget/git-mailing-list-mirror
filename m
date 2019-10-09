Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9839E1F4BD
	for <e@80x24.org>; Wed,  9 Oct 2019 09:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729677AbfJIJTQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Oct 2019 05:19:16 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41570 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbfJIJTQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Oct 2019 05:19:16 -0400
Received: by mail-io1-f68.google.com with SMTP id n26so3364957ioj.8
        for <git@vger.kernel.org>; Wed, 09 Oct 2019 02:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8HlF5vYlG/fEAPRK5tMWoY6fz+BqA2zRVK7UEP9DAjo=;
        b=yMthQeZ7P5xo2x25j+NZaeEc2fd5l0MWQwTGmv6Nj5vAlTCSLr9zQGmLj1SSA73w77
         DkcvWXU9M9NP8s/kx023TDk9RBD0sf0kwXT9dvk/25Rfm4RjT99lvnWN6VQFRk9ds+uz
         VCBbdbVY3HTCpozmbP1yKWwgW5UKSwaK3fNfe5+7S2Fg7WNqIPuN1OestpO4gPaQjCdm
         qMyt0Fz614/GtsYx4sdEwmk5LWG9AXm3u9v0ADP3uvm3lEdzp7S8x+tjToyckXQfG211
         AuW5i6xwK/nzRKzR2HZP5CJ/Uf/xNVse8oMPjbnFBYdH+SpspHqOhRzeOVjszSgEkenB
         I6yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8HlF5vYlG/fEAPRK5tMWoY6fz+BqA2zRVK7UEP9DAjo=;
        b=PCQAPE26fZi4/UqUvmrOPY+OLTGgX2CecF9nMwCua3rxPlwAcZsyP70P8TW0wf68+/
         Yjm5XJIIXNdQWIfiedx4C8hkO5N9T3hHWv3+eWSNyhOKHpyFfs42A0zc0EzlKQPDJOeV
         xFb2hvCu6C5AKrte90W3VsAWs7lsfPKYOuRxd5XqZVnG93biNfgdwf2BRYJSeyjfzuRe
         NR2XdpuNcrJLwKiM5lEAX873sWHoqiwnEY5lIfX2MqUyYFgm2RtkM5fVb2j2zAesqCvt
         NoXpI/IpdeI02yiDnqJvZWcw0sKur9FtUSkDzoWkf5WQCuznB5yoVjbvDtHzDMU2bBOJ
         Cbhw==
X-Gm-Message-State: APjAAAXI0u7XUo/sR1mCtqYz08oIzHvh3nIHP1Qk4olFp6w2vnXSvgzg
        /zJzs0+op1XBpIL4osjpQmWMX4gV4/LJMWuZlhxa0A==
X-Google-Smtp-Source: APXvYqz3Ti0Td/85heTC5p9rNobX+GicDBaKMYHfVMCn9H/5mWGN+sesN3hBmulyx2HmKOy+IO+s9tC7Hs8Y51T5nQ8=
X-Received: by 2002:a92:d084:: with SMTP id h4mr2131156ilh.280.1570612754743;
 Wed, 09 Oct 2019 02:19:14 -0700 (PDT)
MIME-Version: 1.0
References: <20191008184727.14337-1-lucasseikioshiro@gmail.com> <20191008184727.14337-4-lucasseikioshiro@gmail.com>
In-Reply-To: <20191008184727.14337-4-lucasseikioshiro@gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Wed, 9 Oct 2019 06:19:02 -0300
Message-ID: <CAHd-oW4RrzhhiCSbfVYFdCGuCrsi=cJfpZJGMBqU53oPDk1QgA@mail.gmail.com>
Subject: Re: [RFC WIP PATCH 3/3] tag: add full support for --edit and --no-edit
To:     Lucas Oshiro <lucasseikioshiro@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Kernel USP <kernel-usp@googlegroups.com>,
        rcdailey.lists@gmail.com, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?B=C3=A1rbara_Fernandes?= <barbara.dcf@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 8, 2019 at 3:47 PM Lucas Oshiro <lucasseikioshiro@gmail.com> wr=
ote:
>
> git tag --edit and --no-edit flags are not currently fully supported.
> This patch fixes the functionality that allows the editor to be opened
> on demand.
>
> Co-authored-by: B=C3=A1rbara Fernandes <barbara.dcf@gmail.com>
> Signed-off-by: Lucas Oshiro <lucasseikioshiro@gmail.com>
> Signed-off-by: B=C3=A1rbara Fernandes <barbara.dcf@gmail.com>
> ---
>  builtin/tag.c  | 16 +++++++++++++---
>  t/t7004-tag.sh |  4 ++--
>  2 files changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/tag.c b/builtin/tag.c
> index 0322bdbdfb..7dff61d45a 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -230,6 +230,7 @@ static int build_tag_object(struct strbuf *buf, int s=
ign, struct object_id *resu
>  struct create_tag_options {
>         unsigned int message_given:1;
>         unsigned int use_editor:1;
> +       unsigned int force_editor:1;

What if we turn 'use_editor' into a tri-state variable (--edit,
--no-edit and "nothing given") instead of adding this field? Maybe it
would simplify some condition checks at create_tag().

>         unsigned int sign;
>         enum {
>                 CLEANUP_NONE,
> @@ -307,13 +308,21 @@ static void create_tag(const struct object_id *obje=
ct, const char *object_ref,
>                     tag,
>                     git_committer_info(IDENT_STRICT));
>
> -       if (!opt->message_given || opt->use_editor) {
> +       if (opt->force_editor && !opt->message_given && is_null_oid(prev)=
 &&
> +           !opt->use_editor) {
> +               die(_("no tag message?"));
> +       } else if ((!opt->force_editor && !opt->message_given && is_null_=
oid(prev))
> +                 || (opt->force_editor && opt->use_editor)) {
> +               /* Editor must be opened */
>                 prepare_tag_template(buf, opt, prev, path, tag);
>                 if (launch_editor(path, buf, NULL)) {
>                         fprintf(stderr,
>                         _("Please supply the message using either -m or -=
F option.\n"));
>                         exit(1);
>                 }
> +       } else if (!opt->message_given) {
> +               /* Tag already exists and user doesn't want to change it =
*/
> +               strbuf_addstr(buf, get_tag_body(prev, NULL));
>         }
>
>         if (opt->cleanup_mode !=3D CLEANUP_NONE)
> @@ -436,7 +445,7 @@ int cmd_tag(int argc, const char **argv, const char *=
prefix)
>         static struct ref_sorting *sorting =3D NULL, **sorting_tail =3D &=
sorting;
>         struct ref_format format =3D REF_FORMAT_INIT;
>         int icase =3D 0;
> -       int edit_flag =3D 0;
> +       int edit_flag =3D -1;
>         struct option options[] =3D {
>                 OPT_CMDMODE('l', "list", &cmdmode, N_("list tag names"), =
'l'),
>                 { OPTION_INTEGER, 'n', NULL, &filter.lines, N_("n"),
> @@ -592,7 +601,8 @@ int cmd_tag(int argc, const char **argv, const char *=
prefix)
>                 die(_("tag '%s' already exists"), tag);
>
>         opt.message_given =3D msg.given || msgfile;
> -       opt.use_editor =3D edit_flag;
> +       opt.force_editor =3D edit_flag >=3D 0;
> +       opt.use_editor =3D opt.force_editor ? edit_flag : 0;
>
>         if (!cleanup_arg || !strcmp(cleanup_arg, "strip"))
>                 opt.cleanup_mode =3D CLEANUP_ALL;
> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> index 80eb13d94e..bf43d2c750 100755
> --- a/t/t7004-tag.sh
> +++ b/t/t7004-tag.sh
> @@ -1313,7 +1313,7 @@ test_expect_success GPG,RFC1991 \
>         'reediting a signed tag body omits signature' '
>         echo "rfc1991" >gpghome/gpg.conf &&
>         echo "RFC1991 signed tag" >expect &&
> -       GIT_EDITOR=3D./fakeeditor git tag -f -s rfc1991-signed-tag $commi=
t &&
> +       GIT_EDITOR=3D./fakeeditor git tag -f --edit -s rfc1991-signed-tag=
 $commit &&
>         test_cmp expect actual
>  '
>
> @@ -1356,7 +1356,7 @@ test_expect_success GPG,RFC1991 \
>  test_expect_success GPG,RFC1991 \
>         'reediting a signed tag body omits signature' '
>         echo "RFC1991 signed tag" >expect &&
> -       GIT_EDITOR=3D./fakeeditor git tag -f -s rfc1991-signed-tag $commi=
t &&
> +       GIT_EDITOR=3D./fakeeditor git tag -f --edit -s rfc1991-signed-tag=
 $commit &&
>         test_cmp expect actual
>  '
>
> --
> 2.23.0
>
