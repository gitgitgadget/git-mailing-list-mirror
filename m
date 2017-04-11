Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 127D51FA14
	for <e@80x24.org>; Tue, 11 Apr 2017 09:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754510AbdDKJ2U (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 05:28:20 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:35721 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754435AbdDKJ2T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 05:28:19 -0400
Received: by mail-io0-f194.google.com with SMTP id t68so8623527iof.2
        for <git@vger.kernel.org>; Tue, 11 Apr 2017 02:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZOaqihQfcn/FrmUUgwNCShefbfM7ye2YBCadiBCfpDA=;
        b=XZbH1g/mL4I6x5oeS5HyxC1aInjSuBMZSO/dZlAtTdvpSm37qiprRU0O1e+Yv5Ec8t
         m1pe8/GRWkJoJhphpTTYLNDLHE+FduBRHTOZFgdKCZG4+T7laiTyyzGYxrKf8oTm0YuI
         z82V4+wHcxCH3QEJafAT+xDwkUj+k5josBVfnYVGargReRzAtzFXAUMrdcJifLGvu9Je
         ZAewXmqmPqjRDA0eTYM1LrUNlbVpFCmd9wFH2Pwz69+sDuLNdRqZeDr9BCos177s3FDw
         ND+MbxevSFYP+hu03NFWgh8wQGVXrvtEG0JGLw3VoA5x6r1thTom3BZ3m9rwHNdzor95
         /SIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZOaqihQfcn/FrmUUgwNCShefbfM7ye2YBCadiBCfpDA=;
        b=LOa4d8SI70LXmpvo8Jv1SeMkdE9PHqktTAVPO9DbmlcoJXlWekBE2AtLVqpYilce6F
         q16KI8oxt8dHPioLAyyxC6Zpb0Lss4bXarsfgagATVE8RBkZGWhXsijPcotogXc0AUuJ
         4CScqaLJaUKUnkESWnxcTj5F+9mlMqO4H5uvf0ywf6EgcoWI9yRDbFFBrjn0ZuxeeHgt
         bdHMjuvAr+P61KBKk0EGReLoaLdiV1kHPYCzdKzwaLnqU7FKJJC2cDkBl1vaKukOnCz4
         OYZOJ/lmajhfOUPwsxVE1WATBHUFvspE7FFd4I6BkPFU382m9gQXbCFe3wNgyMVVBWd4
         3Qpw==
X-Gm-Message-State: AN3rC/5uPP5ttSg3MH3bFX4XTTRb0qzCtOk3UROlRmSupgVEfC0zgRzv
        xS7w6GsL9wu1Ncb39S+vxnw7GoZNzQ==
X-Received: by 10.36.82.144 with SMTP id d138mr16663502itb.24.1491902898208;
 Tue, 11 Apr 2017 02:28:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.134.97 with HTTP; Tue, 11 Apr 2017 02:27:57 -0700 (PDT)
In-Reply-To: <20170411003554.2tjnn65vfco376kj@sigill.intra.peff.net>
References: <20170409191117.25175-1-avarab@gmail.com> <20170409191117.25175-3-avarab@gmail.com>
 <CACBZZX7OfM-zivJAQMXdNarHDjAhzQhqGNZNs2QqDUyOo3AA0g@mail.gmail.com>
 <20170411003023.ynzc76yzdmomxthp@sigill.intra.peff.net> <20170411003554.2tjnn65vfco376kj@sigill.intra.peff.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 11 Apr 2017 11:27:57 +0200
Message-ID: <CACBZZX4LxL_ZBnFwkwXSMfBPGcKvOtHe3LeMtG9n2xRqWVZBkA@mail.gmail.com>
Subject: Re: [PATCH] connect.c: handle errors from split_cmdline
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Joachim Durchholz <jo@durchholz.org>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 11, 2017 at 2:35 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Apr 10, 2017 at 08:30:23PM -0400, Jeff King wrote:
>
>> On Tue, Apr 11, 2017 at 01:23:32AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 B=
jarmason wrote:
>>
>> > There's one segfault in there:
>> >
>> > $ ./t5601-clone.sh --root=3D"xtmp.$(perl -e 'print chr 39')" -v -i -d
>> > [...]
>> > Cloning into 'ssh-bracket-clone-plink-4'...
>> > Segmentation fault
>> > not ok 45 - single quoted plink.exe in GIT_SSH_COMMAND
>>
>> Here's a fix for that one. I think there are a few other memory
>> irregularities in that function, too. I'll send another patch in a
>> minute, but I wanted to get this out in case you were working on it,
>> too.
>
> Actually, nevermind. I thought there was an issue with freeing via the
> results of basename(), but there isn't. There is a minor memory leak,
> but it's best squashed into my original patch, like so:
>
> -- >8 --
> Subject: [PATCH] connect.c: handle errors from split_cmdline
>
> Commit e9d9a8a4d (connect: handle putty/plink also in
> GIT_SSH_COMMAND, 2017-01-02) added a call to
> split_cmdline(), but checks only for a non-zero return to
> see if we got any output. Since the function returns
> negative values (and a NULL argv) on error, we end up
> dereferencing NULL and segfaulting.
>
> Arguably we could report on the parsing error here, but it's
> probably not worth it. This is a best-effort attempt to see
> if we are using plink. So we can simply return here with
> "no, it wasn't plink" and let the shell actually complain
> about the bogus quoting.
>
> While we're here, let's also fix the leak when our split
> fails (as it turns out, split_cmdline can never return 0, so
> this leak wasn't actually triggerable before).
>
> Reported-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  connect.c        | 6 ++++--
>  t/t5601-clone.sh | 6 ++++++
>  2 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/connect.c b/connect.c
> index 7d65c1c73..380997afd 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -729,18 +729,20 @@ static void handle_ssh_variant(const char *ssh_comm=
and, int is_cmdline,
>         } else {
>                 const char **ssh_argv;
>
>                 p =3D xstrdup(ssh_command);
> -               if (split_cmdline(p, &ssh_argv)) {
> +               if (split_cmdline(p, &ssh_argv) > 0) {
>                         variant =3D basename((char *)ssh_argv[0]);
>                         /*
>                          * At this point, variant points into the buffer
>                          * referenced by p, hence we do not need ssh_argv
>                          * any longer.
>                          */
>                         free(ssh_argv);
> -               } else
> +               } else {
> +                       free(p);
>                         return;
> +               }
>         }
>
>         if (!strcasecmp(variant, "plink") ||
>             !strcasecmp(variant, "plink.exe"))
> diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
> index b52b8acf9..9c56f771b 100755
> --- a/t/t5601-clone.sh
> +++ b/t/t5601-clone.sh
> @@ -426,8 +426,14 @@ test_expect_success 'GIT_SSH_VARIANT overrides plink=
 to tortoiseplink' '
>         git clone "[myhost:123]:src" ssh-bracket-clone-variant-4 &&
>         expect_ssh "-batch -P 123" myhost src
>  '
>
> +test_expect_success 'clean failure on broken quoting' '
> +       test_must_fail \
> +               env GIT_SSH_COMMAND=3D"${SQ}plink.exe -v" \
> +               git clone "[myhost:123]:src" sq-failure
> +'
> +
>  # Reset the GIT_SSH environment variable for clone tests.
>  setup_ssh_wrapper

Thanks. That makes it work.

Junio: If you're not in some rush to pick this up I'll take this, fix
up a bunch of other bugs & tests failures on odd --root directories
and submit this and Jeff's \r patch (after adding tests etc) along
with it.
