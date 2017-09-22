Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95A87202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 19:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751866AbdIVTzQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 15:55:16 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:56361 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751795AbdIVTzP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 15:55:15 -0400
Received: by mail-qk0-f170.google.com with SMTP id g128so2062795qke.13
        for <git@vger.kernel.org>; Fri, 22 Sep 2017 12:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=21ROnlgmeb9laCSw4t8BOsnxYeF40J8g+7PfZmTc350=;
        b=OZGlmNr3PkvytH4uh0inAaRO6CXLvVOp47HeLDnfpMOP6+7HwfxqV2tZdXnilo2VAU
         rEdJgiQbpwm0iCNgUTWcj0RlE5UrSqNcUHT7orPUz1VsqIpZbaP3tjMQEPKV89sSSQmJ
         kcxxLETJQo3lSnG5aCu4DXxqO+0XHSf5iMozyPLCn/DvpBhVz6ZU9Ft8iwvIo0GkXiCB
         xRBMzkdNmnKySEriM7tYdi1GUrcbiXi8OfoeCwUTtip+MVED8Ie4iMnof0bUaHc8txys
         piBEHAff+J6g4JDT4O4wYbRlHMosIWtwFIWGgrCp2Ksh7g0XdTRJMKCbbYxhVAps3eoX
         yCNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=21ROnlgmeb9laCSw4t8BOsnxYeF40J8g+7PfZmTc350=;
        b=F8Zki/j02JZCf/Z93QVgIaSLDpKiYj2M+uLiTLK6kPWzrCgTrZ9hIqX7HB2ktQ0ne7
         PQluimdt9O99yer0PUDrls0r39sklP4tHqh1P6Aruk+uZgUYeqT5XfqGhWalDCKVonOa
         wN5WphEiQBvvgmF7m+tz+JWShGpBS01ObRWCHFQX9OWKmn3+fb12OoCL8O8eZkCyxm8Y
         C/Ka/+nSIpFDOGWUO4KcVJenXyFq17tR22jzS/NQiQNPHQyfWch3dUsB+xwEvFpdEcpq
         0TGyQw2wNvVsZ2X1lKADL5MhtIDBAKgf+BgkIZGQ7lXY5AvfZbus97bH0d8vf7LzF5Nq
         UH2g==
X-Gm-Message-State: AHPjjUhMJ+WwdIyx0Kdafj9c0uxqeHGvNPYlpshR9V0XbyoA7Ro48j9o
        hoUoP2CqMvvgO2Te8jxS+77DvHz/qQb7r63IWirWk2RF
X-Google-Smtp-Source: AOwi7QDdID7Mxif8S1asPmXORfGLJOtNUAAaQs7PBtcZuAlwbvyFXVpkTSVyrB3fz/46g0uWy8+8Dc4ov3/L60rZSC4=
X-Received: by 10.55.52.135 with SMTP id b129mr424050qka.308.1506110114494;
 Fri, 22 Sep 2017 12:55:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.51 with HTTP; Fri, 22 Sep 2017 12:55:13 -0700 (PDT)
In-Reply-To: <1ec69134cad991f01f6a48b57fbc7047cc226965.1506081120.git.git@grubix.eu>
References: <cover.1506081120.git.git@grubix.eu> <1ec69134cad991f01f6a48b57fbc7047cc226965.1506081120.git.git@grubix.eu>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 22 Sep 2017 12:55:13 -0700
Message-ID: <CAGZ79kZFPG7C8Me8dq6kf17HubMs5hwnCriuWArWUhcap4ushQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] merge: do no-verify like commit
To:     Michael J Gruber <git@grubix.eu>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 22, 2017 at 5:04 AM, Michael J Gruber <git@grubix.eu> wrote:
> f8b863598c ("builtin/merge: honor commit-msg hook for merges", 2017-09-07)
> introduced the no-verify to merge for bypassing the commit-msg hook,
> though in a different way from the implementation in commit.c.
>
> Change the implementation in merge.c to be the same as in merge.c so
> that both do the same in the same way.
>
> Signed-off-by: Michael J Gruber <git@grubix.eu>

Thanks for spotting.
Junio spotted it as well; I assumed I had reverted it in the last
sent out (accepted) patch.

If we want to further the commit message:
  This changes the output of 'git merge --help' in a way that
  it suggests that the hook is on by default.

Thanks,
Stefan

> ---
>  builtin/merge.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/merge.c b/builtin/merge.c
> index de254d466b..7ba094ee87 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -73,7 +73,7 @@ static int show_progress = -1;
>  static int default_to_upstream = 1;
>  static int signoff;
>  static const char *sign_commit;
> -static int verify_msg = 1;
> +static int no_verify;
>
>  static struct strategy all_strategy[] = {
>         { "recursive",  DEFAULT_TWOHEAD | NO_TRIVIAL },
> @@ -237,7 +237,7 @@ static struct option builtin_merge_options[] = {
>           N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
>         OPT_BOOL(0, "overwrite-ignore", &overwrite_ignore, N_("update ignored files (default)")),
>         OPT_BOOL(0, "signoff", &signoff, N_("add Signed-off-by:")),
> -       OPT_BOOL(0, "verify", &verify_msg, N_("verify commit-msg hook")),
> +       OPT_BOOL(0, "no-verify", &no_verify, N_("bypass commit-msg hook")),
>         OPT_END()
>  };
>
> @@ -798,7 +798,7 @@ static void prepare_to_commit(struct commit_list *remoteheads)
>                         abort_commit(remoteheads, NULL);
>         }
>
> -       if (verify_msg && run_commit_hook(0 < option_edit, get_index_file(),
> +       if (!no_verify && run_commit_hook(0 < option_edit, get_index_file(),
>                                           "commit-msg",
>                                           git_path_merge_msg(), NULL))
>                 abort_commit(remoteheads, NULL);
> --
> 2.14.1.909.g0fa57a0913
>
