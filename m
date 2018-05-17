Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A08D51F51C
	for <e@80x24.org>; Thu, 17 May 2018 18:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751649AbeEQSND (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 May 2018 14:13:03 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:38824 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750938AbeEQSNC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 May 2018 14:13:02 -0400
Received: by mail-pg0-f68.google.com with SMTP id n9-v6so2163706pgq.5
        for <git@vger.kernel.org>; Thu, 17 May 2018 11:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=d63bhPhik/bj0HCS3wH7a3dVrGOwU2MZX82lzdbq2EA=;
        b=LOwchJCYw0JGlFVdVMGsGpqYX+2tAGf/ntCtSfSAhg2WR+SKqQklqKF+xoGorrvtG1
         vzds/Cjcb9fxayS6d7MaUokYCWkYosNItrnYIvOaikck2Tn0/ZZ7BnlWNfew4QsFBq8B
         JlhVoxahidN6/AqBTfhEiXmNl0DsmaO9+BlcXKZgaf1Ke2J+2MlssNeX/CiaSjlSUH5I
         IJiT8778TDhv3uyqtTWFo2IQrucaV+xJVgv7cAOTuNQw0Zl5FjYSUWGiRWX13awxqurX
         TiKtFIwN+51v9f+qgbr04Fw/u+XYKUepNA7dLIutXXiu6dZnhtn8gnTDFPRWxLtW3yUD
         AUKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=d63bhPhik/bj0HCS3wH7a3dVrGOwU2MZX82lzdbq2EA=;
        b=B3ksYcHFJ7ZMw7t5tm1/e6/l8cDGI2qUUG+mrelHYSCeTZ4YGkm/6CK1i+OoQ+rWwn
         3/blmcbnjb8S8Q0pi3pvn7oL+PKS12P8jrmGw+19UtU5C0rkOakUcyYTvGaucFBK16Ff
         2Cw59TYn3hyE48WH+nny3MhErh/pcynLGc5DanuVzIPGBxWfRs6nYjachQ4qyT1M5Abe
         ru4ReA5oWASvlI8M6wHXa8qNPKVqOYxY0XJBp1iPw4IzLpngQzptMdpiwSJGIaxsBEi/
         Dlo7BqonDIeigz0suNHkrl0u+vpP1dNPg4PcleSvkWurmGe5mQo+eIi+7Ec3/gZQrMs8
         j1LA==
X-Gm-Message-State: ALKqPwcNfjK8T5kBO2HYbJGjpYIri7YyR02MyAia8FU6r0LAX0LXUN+i
        PnTmfMGUihFvwBTkKu/TStqD4Tg7ly/YD0ApSaM=
X-Google-Smtp-Source: AB8JxZqHeB3yTDCGYs+JNmo2NUkzsrLjnOBh9ZWYBKYI/YworrrNeqnpDysFcgf4H1DQNXextsOsFyrfFTjgTuS6Jd8=
X-Received: by 2002:a62:e903:: with SMTP id j3-v6mr6187145pfh.196.1526580781517;
 Thu, 17 May 2018 11:13:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.187.139 with HTTP; Thu, 17 May 2018 11:13:00 -0700 (PDT)
In-Reply-To: <20180511211504.79877-10-dstolee@microsoft.com>
References: <20180510173345.40577-1-dstolee@microsoft.com> <20180511211504.79877-1-dstolee@microsoft.com>
 <20180511211504.79877-10-dstolee@microsoft.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 17 May 2018 20:13:00 +0200
Message-ID: <CAN0heSrkRTfqhbSYgBcJPh-9XjUzmKmjyfbbFQVHRSZB7sDNyQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/12] fsck: verify commit-graph
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "peff@peff.net" <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11 May 2018 at 23:15, Derrick Stolee <dstolee@microsoft.com> wrote:
> If core.commitGraph is true, verify the contents of the commit-graph
> during 'git fsck' using the 'git commit-graph verify' subcommand. Run
> this check on all alternates, as well.

> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index 5ab268a024..91c8406d97 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -205,6 +205,16 @@ test_expect_success 'build graph from commits with append' '
>  graph_git_behavior 'append graph, commit 8 vs merge 1' full commits/8 merge/1
>  graph_git_behavior 'append graph, commit 8 vs merge 2' full commits/8 merge/2
>
> +test_expect_success 'build graph using --reachable' '
> +       cd "$TRASH_DIRECTORY/full" &&
> +       git commit-graph write --reachable &&
> +       test_path_is_file $objdir/info/commit-graph &&
> +       graph_read_expect "11" "large_edges"
> +'

This should be in the next patch.

> +graph_git_behavior 'append graph, commit 8 vs merge 1' full commits/8 merge/1
> +graph_git_behavior 'append graph, commit 8 vs merge 2' full commits/8 merge/2

(Possibly the same here.)

>  test_expect_success 'setup bare repo' '
>         cd "$TRASH_DIRECTORY" &&
>         git clone --bare --no-local full bare &&
> @@ -335,7 +345,7 @@ test_expect_success 'detect OID not in object database' '
>         cd "$TRASH_DIRECTORY/full" &&
>         cp $objdir/info/commit-graph commit-graph-backup &&
>         test_when_finished mv commit-graph-backup $objdir/info/commit-graph &&
> -       corrupt_data $objdir/info/commit-graph 1134 "\01" &&
> +       corrupt_data $objdir/info/commit-graph 1134 "\00" &&

This and two similar ones as well, I guess.

Actually, I can drop them altogether and the tests still pass. Rebase
mishap?

> +test_expect_success 'git fsck (checks commit-graph)' '
> +       cd "$TRASH_DIRECTORY/full" &&
> +       git fsck
> +'

Maybe inject an error and verify that `git fsck` does indeed catch it,
i.e., it does call out to check the commit-graph.

Maybe also a run with `-c core.commitGraph=no` where the error should
not be found because the commit-graph should not be checked?

Martin
