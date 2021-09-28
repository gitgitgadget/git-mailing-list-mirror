Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3719FC433F5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 05:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F204761153
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 05:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbhI1FHK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 01:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhI1FHJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 01:07:09 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45F1C061575
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 22:05:30 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id n64so9241315oih.2
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 22:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R88JBGgywJUTAygpL+wXTcnShgotUV/F6BmdabFthyE=;
        b=a8Vze+m/j774q+7bQz273o0z95S+1hTZ1p5+6o1iL8dzgHl1x53do9oVIYRwbRZ+ra
         xfvxYoNs3QP4CjMuLa3g+DgJj5W137woFmpLGhQ32xuahfDyk4XKlDx/zhHni5DD8WGE
         Npgjc7TzdC6uiEaVHR0cXHzk7a3Vjo3jF3sZd2WQ6S7Rd1XJdPV8Ks2FbxcmAjAjBkFZ
         dlLa5526KXVhsNrnk6Pzf3rvx8K+VaZoLOi0Y7G2Klc89m5NHfoLQWQGuXZMceapIULh
         rr7FotA9xf8cLl2JZWO3eCAsW9ZDlrl/ZrY1vdN/qO3QqB9xxoE1/D72oaps0Jv8jWIh
         V2sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R88JBGgywJUTAygpL+wXTcnShgotUV/F6BmdabFthyE=;
        b=3y1/du2JXLxvt3LHZP1uBF7X0vtj5t/Sua3mwKCxwPuaVId5B9cWirC3YxYv26a01j
         hMi0YPsKLE1rsl7vLEyc9HR+iEDMs0gUDSSguQCPSUs3HFLPCO6EUm9dZ1TprBb7lD4B
         oFZt1qZTTCnMf83rWFOMAlj+1d8F7PWdT9jtSZmt0sffJm1urkD7Tfl9ppQZxJeejie3
         cvLSLO6aIwg344Exbo1SK6yCt2ZiFyJfA9GOcvJgcpc5u/xUyvQNl1SgseGdh5GLubvr
         K0P5hJvP+IpN0X69PlT+iLE8F26UgQGJZEOTgZmS+oxEXu1FwcqjpRyRIxjhUMGVluAE
         AbQw==
X-Gm-Message-State: AOAM5312GjEEx+5pmtjtPzEsNmoU3/Dg0AzLMR4Hb4Q9u9P/p8OxjIeM
        aj/BrcOYbgZVVfFi5f22O7PZQRziMolsFhQc3TYPE3WENl32QA==
X-Google-Smtp-Source: ABdhPJw+3szKawOgvqt+GcbR7jyXX8BWCNUWPk4xxJk/pPpWaeaETsVhrP7MPqPn26B+Hbv8PR7f9tZjiVuf7Lty0bs=
X-Received: by 2002:a05:6808:1787:: with SMTP id bg7mr2261069oib.39.1632805530071;
 Mon, 27 Sep 2021 22:05:30 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1005.v3.git.1631129086.gitgitgadget@gmail.com>
 <pull.1005.v4.git.1631630356.gitgitgadget@gmail.com> <bbbc4c3339043bcd718dd2defcbaaaac2092227a.1631630356.git.gitgitgadget@gmail.com>
In-Reply-To: <bbbc4c3339043bcd718dd2defcbaaaac2092227a.1631630356.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 27 Sep 2021 22:05:18 -0700
Message-ID: <CABPp-BGLcLKk1QLHtb6KpCOpn=M1-wwK6KD91rLCYbh6n5gTYA@mail.gmail.com>
Subject: Re: [PATCH v4 04/15] scalar: 'register' sets recommended config and
 starts maintenance
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry, one more thing...

On Tue, Sep 14, 2021 at 7:39 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
...
> +               /* check if currently in enlistment root with src/ workdir */
> +               strbuf_addstr(&path, "/src/.git");
> +               if (is_git_directory(path.buf)) {

...and...

> +               /* check if currently in workdir */
> +               strbuf_addstr(&path, "/.git");
> +               if (is_git_directory(path.buf)) {

Do these two checks suggest that only a primary worktree can be
enlisted with scalar?  (Is git-worktree generally incompatible?)
