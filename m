Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AEFC1F404
	for <e@80x24.org>; Fri, 20 Apr 2018 21:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751467AbeDTVZi (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 17:25:38 -0400
Received: from mail-yb0-f174.google.com ([209.85.213.174]:34385 "EHLO
        mail-yb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751227AbeDTVZh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 17:25:37 -0400
Received: by mail-yb0-f174.google.com with SMTP id b14-v6so3510865ybk.1
        for <git@vger.kernel.org>; Fri, 20 Apr 2018 14:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Fsiw6ZgIcvwLcLm0FNd/6EaaF9tjzHi5eTsq2xkMNHI=;
        b=T2r0ujhZZ64sKJimLKNGna3K1MXRQgqo83VjpGWWkyj8r2bEsyHe5W5uwyss3nxywJ
         aauEYgv7j6GWP9YSXgd9mxFEm5R/DF0aIjm33ejrCVB1Trk8OOwlFTVDnOTttDARwQSD
         HWYvPNyzrXzeSY+KtF/ctM+gd59dIJ4n5d/35yJ/SOpvGqpt9GFR1kPu/9bejFg6VFqI
         v8TPO6HM0mo4bh86oyxrSJ3+TiO8ftjeKzGuAIzqegIWNEmLcxt3TpSQAD94N7yElQ8A
         v+jQjE2zipB21yqAYPj0FwqmHcJ1BHssyD5FpsoE/uGbbUswkR9TfU4eNOSCurp9lF/r
         tkzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Fsiw6ZgIcvwLcLm0FNd/6EaaF9tjzHi5eTsq2xkMNHI=;
        b=P/j4ShSmAu4zdmOyY1SwhPKpPFIcguv9Ggo7axdMeJgbTwAKKHgcamJVFpJvTEUui7
         KDR4hSQPtFvst+nf416Hs43MP8/xKInggmYpmC5+BLyoww7IP3fyZDqbze0HNDa5qA8x
         J5LEojTVMmDxlvswuIl7Rw+gkYY/9f+WBA8QMr57Twtz3feZ0XdNKTvyptf7E7O80ZZF
         OleelFqBorZ6u/i2N2UAp/cM4EyV2YgkeJuhu0Hp3DVw+85f2HDREPkYZUh82a4CbD20
         36SFa3YJ1GN56hlCmpYccFqLiD1mZ0XqdxfVG880D3Ntd6bHuaMmf9/wdUGuQmXl84zI
         1fIQ==
X-Gm-Message-State: ALQs6tAwDtd2wdBeOXcuN1dqqmYWCWsui85RKCM4PgJEvt6hvLlD/bLA
        63HT25gbEqghMWej3FiZ/tW6qJ6PsTeQs/MECs98UQ==
X-Google-Smtp-Source: AIpwx48a7w7Ra0ZBNaMyxG5WhwKScpecRy6LJYvVM3/KFNy+rnBLxYq7rLaMc/BezfEe/RkMTBGnuDlSyUv7bBDaT1s=
X-Received: by 2002:a25:2704:: with SMTP id n4-v6mr7096962ybn.167.1524259535988;
 Fri, 20 Apr 2018 14:25:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Fri, 20 Apr 2018 14:25:35
 -0700 (PDT)
In-Reply-To: <c23608f35af1ac9b8f7e0b9c17e2fa1fdf189ab1.1524258351.git.johannes.schindelin@gmx.de>
References: <CAPig+cRrS0_nYJJY=O6cboV630sNQHPV5QGrQdD8MW-sYzNFGQ@mail.gmail.com>
 <cover.1524258351.git.johannes.schindelin@gmx.de> <c23608f35af1ac9b8f7e0b9c17e2fa1fdf189ab1.1524258351.git.johannes.schindelin@gmx.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 20 Apr 2018 14:25:35 -0700
Message-ID: <CAGZ79kaQXWi0GmHH_6D_yeQU=M3W_esAy6Y7QweDzp07x7z7dQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] sequencer: leave a tell-tale when a fixup/squash failed
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>  static GIT_PATH_FUNC(rebase_path_amend, "rebase-merge/amend")
> +/*
> + * If there was a merge conflict in a fixup/squash series, we need to
> + * record the type so that a `git rebase --skip` can clean up the commit
> + * message as appropriate. This file will contain that type (`fixup` or
> + * `squash`), and not exist otherwise.
> + */

Thanks for the documentation here, is there some other high level doc that
describes all things to know about the internals of the rebase-merge dir
or is this the definitive guide?

> +static GIT_PATH_FUNC(rebase_path_amend_type, "rebase-merge/amend-type")
>  /*
>   * When we stop at a given patch via the "edit" command, this file contains
>   * the abbreviated commit name of the corresponding patch.
> @@ -2400,10 +2407,20 @@ static int error_with_patch(struct commit *commit,
>  static int error_failed_squash(struct commit *commit,
>         struct replay_opts *opts, int subject_len, const char *subject)
>  {
> +       const char *amend_type = "squash";
> +
> +       if (file_exists(rebase_path_fixup_msg())) {
> +               unlink(rebase_path_fixup_msg());
> +               amend_type = "fixup";
> +       }
> +       if (write_message(amend_type, strlen(amend_type),
> +                      rebase_path_amend_type(), 0))
> +               return error(_("could not write '%s'"),
> +                            rebase_path_amend_type());

Do we want to wait with unlinking rebase_path_fixup_msg()
until after we are sure there is no error returned?
I first thought so as to preserve the state as before, but
then it only signals the amend type. But we're downgrading the
amend type from "squash" to "fixup", which means that if
this error happens and the user just retries the git command
we'll end up with a "fixup", i.e. not opening their editor?
