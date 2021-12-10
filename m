Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349A4C433EF
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 02:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236258AbhLJDDL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 22:03:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbhLJDDJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 22:03:09 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F21C061746
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 18:59:35 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id z5so26172360edd.3
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 18:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UatuRLv9WBFjZXA3oMcPauGGzjg/7L0Lj3SGqkz0J4U=;
        b=Q2QQpV882kRUjJIe64SL1yXGnu3iVenWpfLuwSbBVXNVDA8vutb/zEPoOJ3EVkoGIT
         eunuixO9yPMkT0i2QG0+EfCq/YdxhogwFgw96G/J5ZaQFiuBjpm0cCyKbcygo640JhhT
         X5wM94xNou/qYscB2Q3VEu28qzJaUOwinPBiZdB9JGpb3Yf/oQZSJ/Ywl7O06bEUxFBX
         /3j98g7NaAmMmWOp0HDTjZ3BChDpw01Sg+MsFs4C/gjr9QlxbXZ946ho7XTJHaAJPrdT
         BQtsdUch+t7NPMwLjGKZC+mfakFQOl3T7kAJN/4UP22FFjDyV42cDaA35B8b80aPlrS8
         M0LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UatuRLv9WBFjZXA3oMcPauGGzjg/7L0Lj3SGqkz0J4U=;
        b=l2odjSnsEVV0iwhT3fq+ZUMX5ZglF/TwpjAFF9FyHuUCZ2HjpHDuHPA/qjM44uQkCn
         6o+U3GHeLvAiCBlg6Qcow05NCilRFGxGwCiH4kSt4Hjspv12ythcqJCTx4wHCjvui98v
         NzF0O32Os8M6rQmrfw0ZDfvkboQofkOuoRYI/i9nD2gTowoxueI+fLurTueBQeaXsoiD
         UN4ukBjwv4/FugA66uzCj2BLpAGyG/XQKfjwAEk1gWYTJ6BvJNXY/rhNg/YVqVWAig4x
         g3z8vekipfsCtO74S2GqamTHJH+gx26yKadSOAaRWm0//IbW3HSlmD8Y9QwhkoBLnzNt
         3QBQ==
X-Gm-Message-State: AOAM532nZsdeyBx2SJmZWN0WiBnrPNXAVWgYcWjzI3rp21+bwpK/j5AQ
        k3TMMuyKEPA5Mra8WT11lVZqhvJ+MZuUDp4jEQw=
X-Google-Smtp-Source: ABdhPJyfTR4c6v96f5pGKZH8OwVHWd9Ejp+mKYeh3CYOuOuu6arKIomZz7emGKAGkiE0Tc8dr6g1tNOful0iYl5QPVo=
X-Received: by 2002:a05:6402:2751:: with SMTP id z17mr35118602edd.296.1639105173972;
 Thu, 09 Dec 2021 18:59:33 -0800 (PST)
MIME-Version: 1.0
References: <20211204090351.42369-1-greenfoo@u92.eu> <20211204090351.42369-3-greenfoo@u92.eu>
In-Reply-To: <20211204090351.42369-3-greenfoo@u92.eu>
From:   David Aguilar <davvid@gmail.com>
Date:   Thu, 9 Dec 2021 18:58:58 -0800
Message-ID: <CAJDDKr77YQKJj15V52Rs=LPRMZVSkbpV8MWFDWNuYf4jqqCajg@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] vimdiff: add tool documentation
To:     Fernando Ramos <greenfoo@u92.eu>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Seth House <seth@eseth.com>, levraiphilippeblain@gmail.com,
        rogi@skylittlesystem.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 4, 2021 at 1:04 AM Fernando Ramos <greenfoo@u92.eu> wrote:
>
> Running 'git {merge,diff}tool --tool-help' now also prints usage
> information about the vimdiff tool (and its variantes) instead of just
> its name.
>
> Two new functions ('diff_cmd_help()' and 'merge_cmd_help()') have been
> added to the set of functions that each merge tool (ie. scripts found
> inside "mergetools/") can overwrite to provided tool specific
> information.
>
> Right now, only 'mergetools/vimdiff' implements these functions, but
> other tools are encouraged to do so in the future, specially if they
> take configuration options not explained anywhere else (as it is the
> case with the 'vimdiff' tool and the new 'layout' option)
>
> Signed-off-by: Fernando Ramos <greenfoo@u92.eu>
> ---
>  Documentation/git-difftool--vimdiff.txt  |  40 +++++
>  Documentation/git-mergetool--vimdiff.txt | 195 +++++++++++++++++++++++
>  git-mergetool--lib.sh                    |  14 ++
>  mergetools/vimdiff                       |  12 ++
>  4 files changed, 261 insertions(+)
>  create mode 100644 Documentation/git-difftool--vimdiff.txt
>  create mode 100644 Documentation/git-mergetool--vimdiff.txt


Should these be referenced from elsewhere in the Documentation/
tree in order to make them more discoverable?

Documentation/git-{difftool,mergetool}.txt seem like they should
include or link to these.


> diff --git a/mergetools/vimdiff b/mergetools/vimdiff
> index 5bf77a5388..db6cb75728 100644
> --- a/mergetools/vimdiff
> +++ b/mergetools/vimdiff
> @@ -364,6 +364,12 @@ diff_cmd () {
>  }
>
>
> +diff_cmd_help() {
> +       echo "Run 'man git-difftool--vimdiff' for details"
> +       return 0
> +}
> +
> +
>  merge_cmd () {
>         layout=$(git config mergetool.$merge_tool.layout)
>
> @@ -435,6 +441,12 @@ merge_cmd () {
>  }
>
>
> +merge_cmd_help() {
> +       echo "Run 'man git-mergetool--vimdiff' for details"
> +       return 0
> +}
> +
> +
>  translate_merge_tool_path() {
>         case "$1" in
>         nvimdiff*)
> --


My understanding is that we prefer "git help" instead of "man" when
providing hints.

That means we should suggest something like this instead:

        echo "Run 'git help mergetool--vimdiff' for details"


--
David
