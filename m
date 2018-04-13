Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 880B01F404
	for <e@80x24.org>; Fri, 13 Apr 2018 17:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751756AbeDMR2Q (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Apr 2018 13:28:16 -0400
Received: from mail-yw0-f177.google.com ([209.85.161.177]:42274 "EHLO
        mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751630AbeDMR2P (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Apr 2018 13:28:15 -0400
Received: by mail-yw0-f177.google.com with SMTP id z82so4473847ywd.9
        for <git@vger.kernel.org>; Fri, 13 Apr 2018 10:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+5DGLuex3KqwC4r2ii629Non6gVnZLGedklvytBEJCk=;
        b=kIpqJKwXllBkmCTPB5iAnT3N2yr3ZZqP54HFDU9atFUmnDH/+Qnh/XIo0uKSVX8eHU
         PRswiIfNEFdVD5DTuqVIJV/MRe8bz7xpMguuySLDjoFto6DpUds6EE14UpVOMUiHAFvV
         iWxzkRbXTlROtbO97p89JkTp6AOtJZ+1UjuFTy3iEiCVF4kuHKFxIJB7uozUjsj0+1Fh
         NBMDnb5Zjor4VmImu4qjOLornUqFU3mp2NOG19wbvC4ugLQWsGML3Vo611rjyLG81xDq
         55TvxBHeTjV+i8rGXFR66kfCBLmafHKgVD0BrUtWp6kSyGTaegagnaYBcxtYb/jZ3Duy
         HC/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+5DGLuex3KqwC4r2ii629Non6gVnZLGedklvytBEJCk=;
        b=TMHYcKohTcTh2D7WLuUpQuROH5WDNEUrftp5yE9N1u9EwiDg/A61D6KLdo9yEgbYNJ
         11pu5jJs9sCIGnDtCzWr9TiIiKwxRi8oaFRtY3r/KtdJ/mLbT/q1vpVdaZ0HvfByWGJQ
         evqKP9dLSuqgsv8o7NkyqaS71FsChuT6CO/6ukv1eeN6WviCvwEl2qlo3WOcF6pRor0D
         lvoNAG/lSPXYT7zMFzTthl+0j0f+mlQPmksf7fWTiNkCUWk75Nh8Z+PXhpZJiY01Ott1
         oBlf47F+wneUidLbNDWAwtYHXLQhJpp7ix9kHytlC5kJYtf/muccxNSbPBe6NUJZ/tRt
         KAlg==
X-Gm-Message-State: ALQs6tAI5f3SDl2ag5uCqirVs9Oycw5ujvDEfQcFSR/escwSBrcRHrV2
        ilB16aYsZcvTEOKyWaz163JdmPKq6Pvac88ex8M92g==
X-Google-Smtp-Source: AIpwx49PtCWf8/ptA8e7Tnw07W7PG68x6jJD9SHvNUunR+tFRNaQdBI+Y7hdLt3e4BGWyNgSfdqkTVtvveqQMZtY+zY=
X-Received: by 10.129.136.7 with SMTP id y7mr5267653ywf.238.1523640494121;
 Fri, 13 Apr 2018 10:28:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Fri, 13 Apr 2018 10:28:13
 -0700 (PDT)
In-Reply-To: <20180413094314.GA2404@bod>
References: <20180409090047.lfru2ul5fbnggfg7@bod> <87in90zq2a.fsf@evledraar.gmail.com>
 <20180413094314.GA2404@bod>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 13 Apr 2018 10:28:13 -0700
Message-ID: <CAGZ79kZDUnxkKfqRnZiLhweJ4HNO5sSGUfxkEvJPGagV4wmtkg@mail.gmail.com>
Subject: Re: [RFC PATCH] Add "git show --follow-symlinks HEAD:symlink"
To:     Michael Vogt <mvo@ubuntu.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Michael,

thanks for the patch,

> Thanks for the intial reivew. I updated the patch with a test and
> documentation for the new option. Happy to merge the test into one of
> the existing test files, I read t/README and greping around I did not
> find a place that looked like a good fit.

I think keeping tests as separate as possible is a good idea.
Looking at the patch https://public-inbox.org/git/20180413094314.GA2404@bod/

The patch seems reasonable, apart from minor nits:
In the test we'd prefer no whitespace on the right side of the redirection,
i.e. echo content >foo

Instead of evaluating git commands in shell and assigning it to a variable,
we'd prefer to dump it to files:

  git show HEAD:symlink >actual &&
  echo foo >expect &&
  test_cmp expect actual

(instead of content=$(git show HEAD:foo) && test $content == ...)

The reason for this is that the &&-chain will inspect the return code
of the git command.

There is a typo &e&.

Can we reword the documentation, such that we do not have
an occurrence of "extended SHA-1" ?
(By now the Git community came up with a plan to migrate
away from SHA-1, hence we'd not want to introduce more
dependencies even in the form of documentation for that)

Maybe

Follow symlinks inside the repository when requesting
objects in extended revision syntax of the form tree-ish:path-in-tree.

Thanks,
Stefan
