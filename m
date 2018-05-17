Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EA401F51C
	for <e@80x24.org>; Thu, 17 May 2018 18:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751695AbeEQSQY (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 May 2018 14:16:24 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33725 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751233AbeEQSQX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 May 2018 14:16:23 -0400
Received: by mail-pf0-f195.google.com with SMTP id a20-v6so2487079pfo.0
        for <git@vger.kernel.org>; Thu, 17 May 2018 11:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NMm5qb6sIH+CUEoUUUFG4vdlqwGH8vqSTYrsrkmler0=;
        b=TgSKPYP/3977fQtFRMTHwgWcHxU0udDkqaOaGmVqdPUs6B8zrSDBwphsnNywF9k7Dc
         2RVGa0gijip2fxOZAAXwpTSFjAho5+2UjDZdUN3aWPk4LDnAOPMgSjsBQcooZsvdnciN
         KHrkQl/65iipZfmfvh5kKarIg0Xkqm1hA9+RTUNqC9dC5WTC3wL0oXe2S0vdcech8ROP
         qpN4ljjJ5KD0sFWqnDZsRK+Afuy5biFEi2Mz1jOmtFgnKKC3SxA5cHc7pY8QKGC0sIcz
         LJNVJikZGZZgB8YkJXV791f5tzqn3pKRvPSEW/lEW/SXSGVA0YrubGWY/oXE2Zpd7Wzl
         kNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NMm5qb6sIH+CUEoUUUFG4vdlqwGH8vqSTYrsrkmler0=;
        b=a3rZ0Fv4BzPLQsYIxYWKo8dLRaBob94ZzjzN0bNj3UMbYQ1MZyncYYS02YdSbsJsHP
         ZaD3+Up7jhd8U3HRG38bqbUD66PARAOIBK2Q8etKybYgWMtM4YIDoy8UID++LTlH1nry
         YFT8iDta7j3JnikVMeHniMvsgSgLUpGVQX5pU6OJNJGqfbLacDAlkVMCuvXxjqz/0lna
         Pg/ZIO2nDjh7nshKOhnWLB0He9UC4WjfiRPbSoQMqE8d34K8NHb49+mBKR/7TjtyGk70
         NSCgfm7k0BxuCWKD3R+XCQ9ZQxSHOO3ivZr12ud9fRt+C14ea/UWrDhakrjUtSVViKoE
         qbSw==
X-Gm-Message-State: ALKqPwePEjiIyY9rRB4+mZvNwosD/+cryazKTHyR0bTMUlmQJDFvYADL
        sZFwKeB0FhqpEkg6cUWfbBYdt3d6v6O/X2j0yj54GA==
X-Google-Smtp-Source: AB8JxZqS8IHlRfgEkAYVWO17aYUOu1iDSlxAi1+kteaj/W2HxmMyh+Knl4kPe3beKDqnK0FZhtcLRNbT3/ZEhhlRPlA=
X-Received: by 2002:a62:5050:: with SMTP id e77-v6mr6239264pfb.16.1526580983452;
 Thu, 17 May 2018 11:16:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.187.139 with HTTP; Thu, 17 May 2018 11:16:22 -0700 (PDT)
In-Reply-To: <20180511211504.79877-11-dstolee@microsoft.com>
References: <20180510173345.40577-1-dstolee@microsoft.com> <20180511211504.79877-1-dstolee@microsoft.com>
 <20180511211504.79877-11-dstolee@microsoft.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 17 May 2018 20:16:22 +0200
Message-ID: <CAN0heSodgrk-yUaJVgNQ=qjj1nExe0o+55wAEvGoa9rf-9NKmw@mail.gmail.com>
Subject: Re: [PATCH v2 10/12] commit-graph: add '--reachable' option
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
> When writing commit-graph files, it can be convenient to ask for all
> reachable commits (starting at the ref set) in the resulting file. This
> is particularly helpful when writing to stdin is complicated, such as a
> future integration with 'git gc' which will call
> 'git commit-graph write --reachable' after performing cleanup of the
> object database.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/git-commit-graph.txt |  8 ++++++--
>  builtin/commit-graph.c             | 41 ++++++++++++++++++++++++++++++++++----
>  2 files changed, 43 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
> index a222cfab08..cc1715a823 100644
> --- a/Documentation/git-commit-graph.txt
> +++ b/Documentation/git-commit-graph.txt
> @@ -38,12 +38,16 @@ Write a commit graph file based on the commits found in packfiles.
>  +
>  With the `--stdin-packs` option, generate the new commit graph by
>  walking objects only in the specified pack-indexes. (Cannot be combined
> -with --stdin-commits.)
> +with --stdin-commits or --reachable.)

You could enclose --reachable in `...` for nicer rendering and fix
--stdin-commits as well while you're here.

>  With the `--stdin-commits` option, generate the new commit graph by
>  walking commits starting at the commits specified in stdin as a list
>  of OIDs in hex, one OID per line. (Cannot be combined with
> ---stdin-packs.)
> +--stdin-packs or --reachable.)

Ditto.

> +With the `--reachable` option, generate the new commit graph by walking
> +commits starting at all refs. (Cannot be combined with --stdin-commits
> +or --stind-packs.)

Ditto. Also, s/stind/stdin/.

Martin
