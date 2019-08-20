Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D0711F461
	for <e@80x24.org>; Tue, 20 Aug 2019 02:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbfHTCoQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Aug 2019 22:44:16 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33901 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728719AbfHTCoQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Aug 2019 22:44:16 -0400
Received: by mail-wr1-f66.google.com with SMTP id s18so10706219wrn.1
        for <git@vger.kernel.org>; Mon, 19 Aug 2019 19:44:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8B/JRmY/F+KYauSoHkLUlnAIIYNnZtUnHkNHUz2AkIk=;
        b=Tv7WvLmL8XhPSYlIUgF5m/r3uc03RZETapKk+Vy05ToIUnBr3gajsqOsFxwYJCkV+0
         pLkowHeAONeQqrDL2VgDn8jHnOJq3FMXPckwUFLmJB9Cw6wSGx/qJhFwboiCRLmaHGPu
         Y1y4o137PQY/ucSlW1gAAo7fCr3fsu3gIGhpQ0ytb5D8bfOl6cgSG107iW+tZCY29aOU
         k/8+zcpIRPstcx3lna+CQNEK252VkMg3mqE6FPwPqMOZDWVOvRXeC07NqBtRRQwAvEmL
         u4iF979dBEzm79td68Ta137jB0lUdRtoT5pNUkOGtKD5IcyloDDdm8jigFI58CQaB0QE
         eRbg==
X-Gm-Message-State: APjAAAXxtNiJXwjdbwQicC5/bYlkrs4Bd/hQnXBm1vlMXeW9VJMVy4vM
        zjQkkq3uUuaHFIvnIU0/Z2TvpX4FyLRJeEomhfs=
X-Google-Smtp-Source: APXvYqx4dX/W6D9IG5HDNv/L63HDeqCKx8GH12qOM4m2NK6MURUaGxKbbU25eOmP2HQD82AAxiM33Ou0QqbGWs6XtSg=
X-Received: by 2002:a5d:4c87:: with SMTP id z7mr29614368wrs.10.1566269054332;
 Mon, 19 Aug 2019 19:44:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1566258525.git.liu.denton@gmail.com> <fd908bcc01884469dce966fbc384d6982687b4bd.1566258525.git.liu.denton@gmail.com>
In-Reply-To: <fd908bcc01884469dce966fbc384d6982687b4bd.1566258525.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 19 Aug 2019 22:44:03 -0400
Message-ID: <CAPig+cTL3rtPuMQiFfZPcAX7T=v8fVSOL07ULDbXUuG+GD_jzQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] Doc: add more detail for git-format-patch
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 19, 2019 at 7:53 PM Denton Liu <liu.denton@gmail.com> wrote:
> In git-format-patch.txt, we were missing some key user information.
> First of all, using the `--to` and `--cc` options don't override
> `format.to` and `format.cc` variables, respectively. They add on to each
> other. Document this.

This entire paragraph can go away since v2 dropped this change.

> In addition, document the special value of `--base=auto`.
>
> Next, while we're at it, surround option arguments with <>.
>
> Finally, document the `format.outputDirectory` config and change
> `format.coverletter` to use camel case.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
> @@ -314,7 +314,8 @@ you can use `--suffix=-patch` to get `0001-description-of-my-change-patch`.
>  --base=<commit>::
>         Record the base tree information to identify the state the
>         patch series applies to.  See the BASE TREE INFORMATION section
> -       below for details.
> +       below for details. If <commit> is "auto", a base commit is
> +       automatically chosen.

Should <commit> be encased in backquotes in the paragraph body?
