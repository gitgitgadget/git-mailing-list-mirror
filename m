Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB9A6203F3
	for <e@80x24.org>; Fri, 21 Jul 2017 23:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753527AbdGUXNw (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jul 2017 19:13:52 -0400
Received: from mail-qt0-f180.google.com ([209.85.216.180]:33620 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753111AbdGUXNv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2017 19:13:51 -0400
Received: by mail-qt0-f180.google.com with SMTP id n42so48057968qtn.0
        for <git@vger.kernel.org>; Fri, 21 Jul 2017 16:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TfI9Ciiq+QhevvU22+TFEN6hyCxOnVLCOLct8r7XvJ4=;
        b=eppXMPAg6iKObC2H7IrwCUsCp+eX8iPa2cDScTvCGJdqXddscm1EFiREjC2Mf4jSv2
         A15svDl/zqsiw75dHxmHcU14kKuF7tyzKidkwxCDrQUZc1GcCNsi59QNwwxQFVgTNzF7
         2RUli8QXpQETHAwbZoT+g3oZh9vMmCK0dfINoIaWA+/vyH/3o+IELbnaOQqHg0IJQ7nC
         13/jOYEgHPLL9nnSPiculdvRfk1++/8lN9xvxPOlMzOqvtKdrCmwi/O3R4QaTOF4lVcq
         frQnVDAGxql3TvY8BtBjUtC8CCwsS8k3phKpTzB9zfBA4as2AOZmpdkvWdIh38AUazJN
         esDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TfI9Ciiq+QhevvU22+TFEN6hyCxOnVLCOLct8r7XvJ4=;
        b=gdiVcp14ZJgyho8sAH0QaqGEIL+CnNHxkGSG6corV8zQiq/PkpC+2gwYf5VxPCpwU5
         H9c48dqbnbJXkHswXcGtH3HGRrLubjdn/w307FjxF7OYjulqr8QxytyzKYFSYaxNbtoW
         4TtxSp9+fq0nBZI4/Ba5ejC5npvzu6KP6fLMlMD7AXY40PFXCS2WJCsgVrMWos5ViKs1
         YQ5z1mS9gxAMfnPpicjMPRGwW99uVAJ3TO10pwmANrx/ef4v9FHs17ybV+zUiZOddL/2
         dyavFEw30eI+evRQ7Oj/ea1CzxrUz3cqYABWvcPJbsEfBHNR0TSCSHKlA1ID8ee4YwpN
         PHcA==
X-Gm-Message-State: AIVw113X79EN0lCX4oVYQzfHDuCjCbcdlJlLjz+OrBGPgBJW/xBDA0X9
        Z3IeGp6ZgphyOl7oj7iNPmjKTOMgzQ==
X-Received: by 10.200.4.145 with SMTP id s17mr12275117qtg.198.1500678830842;
 Fri, 21 Jul 2017 16:13:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.193.38 with HTTP; Fri, 21 Jul 2017 16:13:50 -0700 (PDT)
In-Reply-To: <xmqqvamlfm6s.fsf@gitster.mtv.corp.google.com>
References: <249ac6f8-af3c-4b20-5bf0-87a82866cc7a@free.fr> <3ccfa2fb49d471f807d77d9a280e4b7cfe56faea.1500304209.git.worldhello.net@gmail.com>
 <xmqq7ez7htvj.fsf@gitster.mtv.corp.google.com> <CANYiYbEcMrriaor9OT4c2qtfh9Ja5NJ9KBSxa3XhPAuoN0t42A@mail.gmail.com>
 <xmqq60epfy27.fsf@gitster.mtv.corp.google.com> <CANYiYbFROuyXso2ZKuJWDp4cSwpBu=bNAbC-yZtEyDwkbUcAhQ@mail.gmail.com>
 <alpine.DEB.2.21.1.1707191456010.4193@virtualbox> <xmqq8tjkm3ly.fsf@gitster.mtv.corp.google.com>
 <xmqqo9sfkm32.fsf@gitster.mtv.corp.google.com> <CANYiYbGSaaFOq7iw=ON1Oo87bSA96o=zyzym5RDT32kMae7bsw@mail.gmail.com>
 <xmqqvamlfm6s.fsf@gitster.mtv.corp.google.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Sat, 22 Jul 2017 07:13:50 +0800
Message-ID: <CANYiYbF+XDANNbpZJ-jL7y81QhggW_snBuWeONSCUc4CPn2zMw@mail.gmail.com>
Subject: Re: [PATCH] PRItime: wrap PRItime for better l10n compatibility
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2017-07-22 6:40 GMT+08:00 Junio C Hamano <gitster@pobox.com>:
> Jiang Xin <worldhello.net@gmail.com> writes:
>
>> Sorry, I'm late. I want to try a safer way to change PRItime to
>> PRInMax using a hacked version of gettext.
>
> Why?  A vanilla version of gettext tool that is fed a known PRIuMAX
> in its input would be a safer choice, I would have thought.
>
> I've already queued the patch you responded to on 'master', but
> haven't tagged -rc1 yet, so it is possible for you to update on top
> of it before -rc1 is tagged.  I do not yet understand why you think
> a modified version of gettext would be a safer way to go, though.
>
> Thanks.

A very small hack on gettext.  When extract l10n messages to pot file
with `xgettext`, will grep "PRItime", and do "sed s/PRItime/PRIuMAX"
inside `xgettext`.

See this patch:
https://github.com/jiangxin/gettext/commit/b0a726431c93b5a1ca0fe749de376b07=
52e75fb0

    ---
     gettext-tools/src/x-c.c      | 17 ++++++++++++++++-
     gettext-tools/src/xgettext.c |  2 +-
     2 files changed, 17 insertions(+), 2 deletions(-)

    diff --git a/gettext-tools/src/x-c.c b/gettext-tools/src/x-c.c
    index 1844a5df7..51dd0a9bc 100644
    --- a/gettext-tools/src/x-c.c
    +++ b/gettext-tools/src/x-c.c
    @@ -1802,6 +1802,12 @@ phase6_unget (token_ty *tp)
     static bool
     is_inttypes_macro (const char *name)
     {
    +  /* PRItime is a maro for timestamp_t in git.git. */
    +  if (!strncmp(name, "PRItime", 7))
    +    {
    +      return true;
    +    }
    +
       /* Syntax:
          P R I { d | i | o | u | x | X }
          { { | LEAST | FAST } { 8 | 16 | 32 | 64 } | MAX | PTR }  */
    @@ -1843,8 +1849,17 @@ phase8a_get (token_ty *tp)
       phase6_get (tp);
       if (tp->type =3D=3D token_type_name && is_inttypes_macro (tp->string=
))
         {
    +      char *new_string;
           /* Turn PRIdXXX into "<PRIdXXX>".  */
    -      char *new_string =3D xasprintf ("<%s>", tp->string);
    +      if (!strncmp(tp->string, "PRItime", 7))
    +        {
    +          /* Replace PRItime with PRIuMAX for git.git project */
    +          new_string =3D xasprintf ("<%s>", "PRIuMAX");
    +        }
    +      else
    +        {
    +          new_string =3D xasprintf ("<%s>", tp->string);
    +        }
           free (tp->string);
           tp->string =3D new_string;
           tp->comment =3D add_reference (savable_comment);
    diff --git a/gettext-tools/src/xgettext.c b/gettext-tools/src/xgettext.=
c
    index f848d76d1..0350a1bee 100644
    --- a/gettext-tools/src/xgettext.c
    +++ b/gettext-tools/src/xgettext.c
    @@ -676,7 +676,7 @@ main (int argc, char *argv[])
       /* Version information requested.  */
       if (do_version)
         {
    -      printf ("%s (GNU %s) %s\n", basename (program_name),
PACKAGE, VERSION);
    +      printf ("%s (GNU %s) %s (PRItime to PRIuMAX for
git.git)\n", basename (program_name), PACKAGE, VERSION);
           /* xgettext: no-wrap */
           printf (_("Copyright (C) %s Free Software Foundation, Inc.\n\
     License GPLv3+: GNU GPL version 3 or later
<http://gnu.org/licenses/gpl.html>\n\
    --
    2.14.0.rc0.1.g3ccfa2fb49
--=20
=E8=92=8B=E9=91=AB

=E5=8D=8E=E4=B8=BA=E6=8A=80=E6=9C=AF=E6=9C=89=E9=99=90=E5=85=AC=E5=8F=B8
=E9=82=AE=E4=BB=B6: xin.jiang@huawei.com, worldhello.net@gmail.com
=E5=8D=9A=E5=AE=A2: http://www.worldhello.net/
=E5=BE=AE=E5=8D=9A: http://weibo.com/gotgit/
=E7=94=B5=E8=AF=9D: 18601196889
