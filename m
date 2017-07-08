Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F13AC2035A
	for <e@80x24.org>; Sat,  8 Jul 2017 19:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753079AbdGHTNH (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Jul 2017 15:13:07 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:36272 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753016AbdGHTNG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jul 2017 15:13:06 -0400
Received: by mail-io0-f181.google.com with SMTP id z62so9820516ioi.3
        for <git@vger.kernel.org>; Sat, 08 Jul 2017 12:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=fWPId/b/YBs20GTlf6aJnHkbiZkPYCE6g0baonnPfrQ=;
        b=u0egaPpfjsWcyySuOe2R9b+Cna5AVhTLahKW3OeTcIIQV8wkCKKMcStnVc6emZJqZU
         DBpTWScCjWWTlG5kdGRlgB5Xq0XxrpBKmkMn2amTw4BV8V1bf1zWrwkFC6bsLq9H3TcE
         HcENpXkvmp4mx7mXHUhGi3Csj6UU/1ivObTE8GMBwP1oGUjn5qDSkIGBoDwqWz0Rovsr
         KxxciAb9xgotLeGCeTtuUjvGjs+ZjDpwGN82YWCQYJJxCPbi5xEricNkds2vjfq03ju1
         usFSjmRnjdb2RryGZ1VrSMs8lg0FI0+L7pA3Gqt/+E1fsruIf7l0DQ+zAXQ5DoEXqMsJ
         ZEyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=fWPId/b/YBs20GTlf6aJnHkbiZkPYCE6g0baonnPfrQ=;
        b=CtDBEGg/oeeVXGHpKXaUNvsDSxB+vgvR4rEXKHyWdk/zkzvD5x/NuVTRD7+i1DwNBP
         iAU6FDt/AglyExZDMZYj3v0coF4/xkqGMrNWu1whFAQE9W4Sn4WFulwU1xPzSII7fmCq
         fTpZZ1LucW10HOhlyMflMjL54uBBGjckj5oDkkhRhZGUUr4iiGru8jQ4huvfFgP0fjDy
         0Kp+afhN020QogkjKe0yKF9JCxOid/LVDo2pUHWqMD72xg+F76T3k4G8dcgbEI/4SuWr
         B75c/aU8bJJbT2kENR0eFn6wQwc9DHyPrAjPxa6M/uCzHMPtdFwtF+xU8Qv7xjXxJJp5
         DxLw==
X-Gm-Message-State: AKS2vOyrM2ZKC4V6AwZxW0OHyzkJeK70E2OZMeDU/65GGK4BPpaVeNcg
        q6tnd8tbjlkLRshe4S2jNtL2Q2qEL/GC
X-Received: by 10.107.128.30 with SMTP id b30mr47398187iod.179.1499541185171;
 Sat, 08 Jul 2017 12:13:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.38.138 with HTTP; Sat, 8 Jul 2017 12:13:04 -0700 (PDT)
Reply-To: SLONIK.AZ@gmail.com
From:   Leo Razoumov <slonik.az@gmail.com>
Date:   Sat, 8 Jul 2017 15:13:04 -0400
Message-ID: <CADsUFkTuRK7wgtvZ16Dw-5y2CFXZByTBzNky6cQb0RzT58C5WQ@mail.gmail.com>
Subject: git-2.13.2: color.branch.local problem
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Everyone,

When I updated from git-2.10.2 to git-2.13.2 my 'color.branch.local'
config setting gets ignored. Corresponding 'remote' or 'current'
settings are honored and work as expected

Relevant parts of my config file is:
  [color "branch"]
    current=  reverse
    local  = red bold
    remote = green bold

I am on macosx-10.11.6 El Capitan. Git installation courtesy of homebrew.

Using command
$ git branch -a --color=always
I see current branch in reverse, remote branches in green, but local
branches in default color (black)

Any help is greatly appreciated.

Thanks,
--Leo
