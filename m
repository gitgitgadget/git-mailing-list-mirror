Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AEA120899
	for <e@80x24.org>; Tue,  8 Aug 2017 18:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752254AbdHHSzr (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 14:55:47 -0400
Received: from mail-lf0-f51.google.com ([209.85.215.51]:36144 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752190AbdHHSzq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 14:55:46 -0400
Received: by mail-lf0-f51.google.com with SMTP id o85so18762826lff.3
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 11:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mpkbKo/fax9z1jCdWd6ijvqedDO+q8G5WsXhs5atX10=;
        b=bHU9p3rkdbYPXHDDik3xzb0fj+by3bnFN0OfJkDOzmnnOybSpUjoTwsReAEYTtQgkR
         RhEHtaccbxI4nTiPAmIUH/LqvteRLbiPUrVLIaCPkP6oqPOxfv6K0pH5ZW9rgi2MnZP1
         ylLpN8Ww2QWylYEhKfWeGFHcqGObt40PF+YPKMi/OHq1DQQbq3nzvsBobB7pRkl7r75M
         9r+Lmqh1HCChAeq7IOGpKPROY9BRIK/c1Z3dBjPLXHU00w9dG0i+O/TWlhK8xqAaZiBG
         Hh52+qDxV1SMuIW5nG3oesP97WzR1aamd5oMAB5V0mU85cStNwpF/kK3S5OJ6N9Q6ogu
         7kNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mpkbKo/fax9z1jCdWd6ijvqedDO+q8G5WsXhs5atX10=;
        b=ZQ4Ay+e0eyXeB6soUbwKzvMZmQgB+hxEDZsSKtjMVreWwvW3e6XG+3uRhBB746xn76
         QDgcHR3h5EePGN1mdluPS+w0+NG/7HWpO76+W3ydsDd2UDgLVY3+j4/xfzJ5SABnoLaG
         q9MDWEHPk96YrM3Is0Q/4MKLr3IcCvlNkwarnCcduykpmrM8NBLItDpemOPMT6c1Yi1G
         HtGFtTA6g6dnx0FPwgXE/lTxqqrYnV04lmXi2Opdy51RQvspo1c077UAjBcFrtCrLKZV
         z8MRqQpdOIf3ipT3T70IvuEgi1JXI41Pjt3hpYDvw2MbaTBpVipS+DWvSJ7kgljIie0f
         IJew==
X-Gm-Message-State: AHYfb5ggHNikpAi9u+A/Wm3fWordmxkDoYcWGyTvq7gzEfoJxK5uFOk5
        4voDXg6a2XoPrOwtZoYcDj00au7vM4KN
X-Received: by 10.25.20.68 with SMTP id k65mr2318650lfi.260.1502218544676;
 Tue, 08 Aug 2017 11:55:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.1.130 with HTTP; Tue, 8 Aug 2017 11:55:43 -0700 (PDT)
In-Reply-To: <20170808171136.31168-2-kaarticsivaraam91196@gmail.com>
References: <xmqq60dzp00l.fsf@gitster.mtv.corp.google.com> <20170808171136.31168-1-kaarticsivaraam91196@gmail.com>
 <20170808171136.31168-2-kaarticsivaraam91196@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 8 Aug 2017 11:55:43 -0700
Message-ID: <CAGZ79ka779gwmLKuSumRdFj3PqXkUe8SfG2ri+qmf_9Z3gsckg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2 / RFC] branch: quote branch/ref names to improve readability
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 8, 2017 at 10:11 AM, Kaartic Sivaraam
<kaarticsivaraam91196@gmail.com> wrote:
> Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
> ---
>  branch.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

I like this patch.

In submodule.c we quote a lot of things (branches, submodules, paths), so
this is another step to make the output as a whole more consistent.
(Though wondering for non-submodule users, if they perceive it as
inconsistency as other parts of the code may not follow the rigorous quoting)

>
> diff --git a/branch.c b/branch.c
> index ad5a2299b..a40721f3c 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -90,24 +90,24 @@ int install_branch_config(int flag, const char *local, const char *origin, const
>                 if (shortname) {
>                         if (origin)
>                                 printf_ln(rebasing ?
> -                                         _("Branch %s set up to track remote branch %s from %s by rebasing.") :
> -                                         _("Branch %s set up to track remote branch %s from %s."),
> +                                         _("Branch '%s' set up to track remote branch '%s' from '%s' by rebasing.") :
> +                                         _("Branch '%s' set up to track remote branch '%s' from '%s'."),
>                                           local, shortname, origin);
>                         else
>                                 printf_ln(rebasing ?
> -                                         _("Branch %s set up to track local branch %s by rebasing.") :
> -                                         _("Branch %s set up to track local branch %s."),
> +                                         _("Branch '%s' set up to track local branch '%s' by rebasing.") :
> +                                         _("Branch '%s' set up to track local branch '%s'."),
>                                           local, shortname);
>                 } else {
>                         if (origin)
>                                 printf_ln(rebasing ?
> -                                         _("Branch %s set up to track remote ref %s by rebasing.") :
> -                                         _("Branch %s set up to track remote ref %s."),
> +                                         _("Branch '%s' set up to track remote ref '%s' by rebasing.") :
> +                                         _("Branch '%s' set up to track remote ref '%s'."),
>                                           local, remote);
>                         else
>                                 printf_ln(rebasing ?
> -                                         _("Branch %s set up to track local ref %s by rebasing.") :
> -                                         _("Branch %s set up to track local ref %s."),
> +                                         _("Branch '%s' set up to track local ref '%s' by rebasing.") :
> +                                         _("Branch '%s' set up to track local ref '%s'."),
>                                           local, remote);
>                 }
>         }
> --
> 2.14.0.rc1.434.g6eded367a
>
