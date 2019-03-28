Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00D9820248
	for <e@80x24.org>; Thu, 28 Mar 2019 18:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfC1SBP (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Mar 2019 14:01:15 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:35594 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbfC1SBP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Mar 2019 14:01:15 -0400
Received: by mail-vs1-f65.google.com with SMTP id e1so12669059vsp.2
        for <git@vger.kernel.org>; Thu, 28 Mar 2019 11:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9ngwVgU66qR9Q+x/tcSsnm4uqNiwG+JYIIOQpSnt8t8=;
        b=CtKSYNCGgn1LSBLqBYja2rd1b9nsoJuS34bqJvJPe1Cq1NE00YeFflNsYBWBa2RR7S
         R4UaOt0pBcjNoSdnEivTzOTJzLRCparLoOPvMS9/M8OKkOvbhLNl3bAUyL+k/zSqIGDq
         qp82fJBH5VLztItKYKlq+YiXTegeuZfdsaiy7vZHzSsjXR4ph4QnjH46sAYNGESJ3e6/
         YsOzFTvGDCB7+lJMOhqZ2X8K5tChWqxEUZZmgZVei1UKiIOVNm+5bvg9y1DaKzJ8TXPI
         xEVoonOMkSKExVl/Mf6kRWrwXZcvgzd1q5NGCHqseTz5rny+R5k/puyIqdD9YiCqTyfv
         kjLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9ngwVgU66qR9Q+x/tcSsnm4uqNiwG+JYIIOQpSnt8t8=;
        b=emqN+8SBkx3Zw9LNXhToxRjHh9AJf0iKPgpqC/cOYUPk/IIf9r5jOUuVHG1sh5o+OF
         CTXdgbvGAuyeMw8OYr/99pzI3f33RH8i/WHGSpu+AMcHLRxsxRzhv84N/zKwFFpfRNTw
         CRp+5sFRic2/xvP39rnP2BGte3+lIczuzNY587y/WDL5vql6NwJZ9dutmwCuP+U0Z/lL
         R819KODIt11gwNXuo+K0L7wVZ4X8A7MmkE5DVVTJCEsaQ6NJtFkIFLEQQnsSGmAIV6oY
         +6u9WFdvfkTm4DClR8/73MQue23Ds0dtK2yzDgz2Hjg4eH0zcLqsrQBuJFSTmY9gC5Gw
         OR3w==
X-Gm-Message-State: APjAAAUDshwNX3TbftkM2U1s47jD8lVQzCnUMQPjeoV4yvyrUH9bGyWr
        V7joWAYNGxGUdGuLSudaOqop7UE+13eJ+4Z0mFRTk6VY
X-Google-Smtp-Source: APXvYqxvAUfsR2xxdmcFPr3nK8ElKjVh9OGYeTX2grsc+egctHuBcTmUtynDgmsiaOEGf6DKW/kTefdjott2g3bopkk=
X-Received: by 2002:a67:f615:: with SMTP id k21mr5208237vso.136.1553796074152;
 Thu, 28 Mar 2019 11:01:14 -0700 (PDT)
MIME-Version: 1.0
References: <1A5DE2FC-7D94-4785-A915-EA2A71C6C377@m-mooga.com>
 <CABPp-BE9vNhnN6XdcxnePnXkek0bNogAiA_cKJqZ1-ct=QA2pw@mail.gmail.com>
 <BF34A383-7714-40CC-B5EF-4FD20E7AC839@m-mooga.com> <CABPp-BGiP8BZwWQMbYhVQjqq8jZx+bbUTfgLaC6ZyukpLErZBw@mail.gmail.com>
 <1B12FDC7-20CD-4044-AA88-AE9A4E942531@m-mooga.com>
In-Reply-To: <1B12FDC7-20CD-4044-AA88-AE9A4E942531@m-mooga.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 28 Mar 2019 11:01:02 -0700
Message-ID: <CABPp-BHbEkVfhh_Q=_ZD2nNF+J+NdNmDL4nR-yH2WGmSvbx0Cg@mail.gmail.com>
Subject: Re: [GSoC][PATCH] microporject test_path_is_*
To:     Mooga <contact@m-mooga.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Mooga,

On Thu, Mar 28, 2019 at 10:08 AM Mooga <contact@m-mooga.com> wrote:
>
> I have done what is https://gitgitgadget.github.io/ but the problem is
> my pull request not being successful even what I have changed is " test_p=
ath_is_dir " in test file "t2400", it returns
>
> PowerShell exited with code '1'.
> Publishing build artifacts failed with an error: Not found PathtoPublish:=
 D:\a\1\s\t\failed-test-artifacts
>
> I have contributed before in open source community and I just need a quic=
k review to continue the proposal

Please don't top-post.

I may have to allow others to respond as I haven't used Windows
meaningfully in over two decades and don't know how to do anything
useful on that OS, but the fact you are attempting to run these bourne
shell scripts with PowerShell suggests you are not invoking them
correctly.  You'll need to get and use some version of Bash; see
https://github.com/git-for-windows/git/blob/master/CONTRIBUTING.md


Hope that helps,
Elijah


> =EF=BB=BFOn 28.03.19, 17:03, "Elijah Newren" <git-owner@vger.kernel.org o=
n behalf of newren@gmail.com> wrote:
>
>     On Wed, Mar 27, 2019 at 1:31 PM Mooga <contact@m-mooga.com> wrote:
>     >
>     > Hi Eliah,
>     > thanks for the advice, but still after I read the  SubmittingPatche=
s , and see around the Submitting patches process still confussing for me ,=
 there's a better way  for explanation as an example
>     >
>     >
>     > Regards
>
>     On this list, please respond to emails interleaved or below the
>     original email; we discourage top-posting.
>
>     What part of the process is confusing?  Without knowing that, we're
>     likely to just repeat the document as it stands.  Also, have you take=
n
>     a look at https://gitgitgadget.github.io/ (which is a new thing
>     designed to make submitting patches to git.git easier)?
>
>     Hope that helps,
>     Elijah
>
>
>
