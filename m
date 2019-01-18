Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 457851F453
	for <e@80x24.org>; Fri, 18 Jan 2019 12:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbfARMuK (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 07:50:10 -0500
Received: from mout.gmx.net ([212.227.17.20]:40067 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727597AbfARMuK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 07:50:10 -0500
Received: from [194.114.62.122] ([194.114.62.122]) by web-mail.gmx.net
 (3c-app-gmx-bs22.server.lan [172.19.170.74]) (via HTTP); Fri, 18 Jan 2019
 13:50:08 +0100
MIME-Version: 1.0
Message-ID: <trinity-9f702373-ab1b-4c3e-9418-894ab0a6ef5a-1547815808777@3c-app-gmx-bs22>
From:   "Steve Keller" <keller.steve@gmx.de>
To:     git@vger.kernel.org
Subject: How to convert SVN tags to git tags?
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 18 Jan 2019 13:50:08 +0100
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:1euB0TfGPeeRhAKJy7vuhkDvDstEE+UIgEJBD3jBJ5sniwAC04Z5kLIR4aZjZOBUcw1ol
 qfmjHV3PkCyAYd7uAQOuk3DqhxgS0ZpYn75/+JLoMiTEWTye0huoICjUwu5fzZJ4r4rbHtrM5EYY
 YkXSEj33oEcENYj+6MAQKBa8UAREVpE/+YX2tnKwSBkBbdCTdJpmO4gjQxujZ1UvsDGeIfM9JYMh
 p/WbjgzMnmulaBominm5kyCioQqcEsGSplxPCDFycv4qSB4+RZKsVWz22jg5NKvryTEz+WDhrSZu
 Xc=
X-UI-Out-Filterresults: notjunk:1;V03:K0:nxBtOdUCi7w=:07N8bW9ynDLeuvsGF8g9W7
 0gSsjno/5sotG9dokbIGE2RXnRZAm3Tle12/qpgtEjxFbMCJQ+5w8+POyKTwDQl7/sBPVVsGR
 wG7a5k3swAzbI9SsVvJEkcxk2/AdzEzm4wYFceyVOVoPJA0CuNJ0LjJG1rBwQv+dSMLGFxGWy
 P1IMKQ9oW8nw7Cf/i8JKOHH3m3dA0k9g01Mn5pkDRxasfNUiWXY2YNXGKCiV6vTLRXpgCqXPz
 56j3u+3pmXyjk4uhdxCoZnByQFIq4ISn6G7N0N89Xnmj1xwtU0h5z/UKSlaUf7QuTWQcT5/mR
 fC2Jo2WJmPGERboH2k1XYFMcQl2xAObbfF35/BBNHJP8daoqmNk2afEGoK8oIgloxdA1Tnqhi
 ArPkNoWRmbfHfIp1324vU9pwLrEWBDfifgftd6GV5RxXYB4povKWEIbUI/jUwHFpyCFJtuae8
 38xShPgBXC5qtH6BDS4Ftl1AVwqkXjHNRYjN+OyAiO4d4BbY/qViNY4UYbc7YH3Tz4BPBOjLu
 BCm2jmesdLUsFre/aDVXj1IGKS/C0WlCvxX1/ZxHkb42tZqngYg//qE8vQWNw5oA6NRFt8fOB
 QO+SB28NnFyws=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After converting from SVN to git using git svn init + git svn fetch,
my SVN tags appear as remote branches in git.  I find many suggestions
to convert these to git tags by calling git tag -a <tag-name> <branch-name>
but this gives something like this

               C4
               |
               V
    T -> C3 -> C2
               |
               V
               C1

that is, I still have a branch with only 1 commit C3 and I have a tag T
pointing to that commit.  Also, T will have a current timestamp.  I'd
prefer to get

               C4
               |
               V
          T -> C2
               |
               V
               C1

where T takes the commit message and date from C3.  How can I achieve
that?

Steve
