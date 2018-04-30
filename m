Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EF88215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 20:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932186AbeD3T13 (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 15:27:29 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:36206 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755929AbeD3T1Z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 15:27:25 -0400
Received: by mail-vk0-f67.google.com with SMTP id i185-v6so623570vkg.3
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 12:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xSgNa+Nj0g5uSo9F2ts+2amLo29r6PGhzpTA3ARRgSc=;
        b=PkvPW9OUXw7iqYxhbfInjhk02Q0/Ytq37qMlD1RXGZlinh3Y4Z8StMyLt6NgmM4k3y
         MgJmTUFJHZ9KeDYtNR5iUoexGpJV/vv6WpgljHlUgS0aJfrUc8cLyAs+rvappyaWcxfW
         UwRmKVqblPjQtKUSoxX/tcCI98VHN3sWNg239quIMSngTBBD20UrDqIrdiRUnpaMBK9M
         CQIaDthbX8a//seollxAWtKiSDDtygyHyoesVNwR/pufw77NqwLjVFHdtpapEI80JHVm
         5Edg0w/hbWvgL2HvBTu+lLLg7HAez8ZJcXBJ35CKEz3uBhu+j2RJHanzU2emdzxMI8lo
         KbfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xSgNa+Nj0g5uSo9F2ts+2amLo29r6PGhzpTA3ARRgSc=;
        b=PBRezI73cd/7A+i7R9AuPT8Cu5+4jx/p10wJ04asW33OaUxIddFtvL07Bb+xZI0BE3
         YXhKPWeCTI2mAqdqWFeYnLlcEPbrH0IjsLCOqT7RV6EH0WCFvnniFVmLw6IWWMcevQoA
         GoD6D0H8i+9rApbaxUa6hGkE4+IcL1JeyyJDvzIhu5eScRfXuXsVa/MD9LAJHwxRPCuC
         hVBzTrrnSkRrbi4dQUeyuONOd/Mwox76/RYaU3AcglsOlr+8VsFdnNsKlOGCZTM6bQOt
         0kK/o/L2bRZDs5gemCgsttRiQ6kc2SkdMF5jmjzbVUvPds/pySPT+y30z9wpoJySmvT7
         dRCg==
X-Gm-Message-State: ALQs6tBEDenllzpSAeQsYPfc+VQGmaKkPmmhKCIKzlRBocNJG8/7+ULv
        xKsWcHCSBG4svKQvkTq1IKTihB2JbCchPZwLLBw=
X-Google-Smtp-Source: AB8JxZpO+mEwv6PrBE/dJZBWrXI35yvDskMc3BnH28aVcLPC9yX1UZJPoMdqqWxl+Q35c5lQNNkKudtOwopFcXnZ0ss=
X-Received: by 2002:a1f:a50a:: with SMTP id o10-v6mr10472799vke.187.1525116444597;
 Mon, 30 Apr 2018 12:27:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Mon, 30 Apr 2018 12:27:23 -0700 (PDT)
In-Reply-To: <20180430093421.27551-2-eckhard.s.maass@gmail.com>
References: <20180430093421.27551-1-eckhard.s.maass@gmail.com> <20180430093421.27551-2-eckhard.s.maass@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 30 Apr 2018 12:27:23 -0700
Message-ID: <CABPp-BFbV0rmDjxJL4m7v+dJ=kFV7g+6DCgPbSMn0Oqx-3PPmA@mail.gmail.com>
Subject: Re: [PATCH 1/1] wt-status: use rename settings from init_diff_ui_defaults
To:     =?UTF-8?Q?Eckhard_S=2E_Maa=C3=9F?= <eckhard.s.maass@googlemail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <Matthieu.Moy@imag.fr>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Eckhard_S=2E_Maa=C3=9F?= <eckhard.s.maass@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eckhard,

On Mon, Apr 30, 2018 at 2:34 AM, Eckhard S. Maa=C3=9F
<eckhard.s.maass@googlemail.com> wrote:
> Since the very beginning, git status behaved differently for rename
> detection than other rename aware commands like git log or git show as
> it has the use of rename hard coded into it.  After 5404c116aa ("diff:
> activate diff.renames by default", 2016-02-25) the default behaves the
> same by coincidence, but a work flow like
>
>     - git add .
>     - git status
>     - git commit
>     - git show
>
> should give you the same information on renames (and/or copies if
> activated) accordingly to the diff.renames setting.

Thanks for sending this change in.  I agree with the logic.  I think
the last sentence needs a s/diff.renames setting/diff.renames and
diff.renameLimit settings/, though, because...

> With this commit the hard coded rename settings are dropped from the
> status command.
>
> Signed-off-by: Eckhard S. Maa=C3=9F <eckhard.s.maass@gmail.com>
> ---
>  builtin/commit.c       |  2 +-
>  t/t4001-diff-rename.sh | 12 ++++++++++++
>  wt-status.c            |  4 ----
>  3 files changed, 13 insertions(+), 5 deletions(-)
>
<snip>
> diff --git a/wt-status.c b/wt-status.c
> index 50815e5faf..32f3bcaebd 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -625,9 +625,6 @@ static void wt_status_collect_changes_index(struct wt=
_status *s)
>         rev.diffopt.output_format |=3D DIFF_FORMAT_CALLBACK;
>         rev.diffopt.format_callback =3D wt_status_collect_updated_cb;
>         rev.diffopt.format_callback_data =3D s;
> -       rev.diffopt.detect_rename =3D DIFF_DETECT_RENAME;
> -       rev.diffopt.rename_limit =3D 200;

By removing the hard-coded value of 200, the rename limit will instead
match whatever the user specified (or, if they didn't specify
anything, then the value of 400 from diff_rename_limit_default).  I
think that's a good change, for the exact same reasons as you argue
for making diff.renames be used everywhere in the commit message, it
just needs to be mentioned in the commit message.

Everything else in the patch looks good to me, so with that change
feel free to add:

Reviewed-by: Elijah Newren <newren@gmail.com>
