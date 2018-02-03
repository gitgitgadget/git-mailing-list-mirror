Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAC2C1F404
	for <e@80x24.org>; Sat,  3 Feb 2018 17:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752593AbeBCRU0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Feb 2018 12:20:26 -0500
Received: from mout.web.de ([212.227.17.12]:54453 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752438AbeBCRUY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Feb 2018 12:20:24 -0500
Received: from macce.local ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M8iPI-1eaHCE3gdg-00CA6C; Sat, 03
 Feb 2018 18:20:22 +0100
To:     Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: contrib/completion/git-completion.bash: declare -g is not portable
Message-ID: <1e618c0c-81ba-fa7e-8039-748bdfa5a6d9@web.de>
Date:   Sat, 3 Feb 2018 18:20:18 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:weEzPemvm1j4TE5txfizeBmxJuw627a5qGMicKSX1Ta/IMP2kzW
 I4r0+OP+1/pZaMBZiS/lHcB2Xf5rtx/JL6yPBQwPkSxuHwDS+t4QEvXf9Fn6MR1QEYdkw+r
 aI2slLHNK4haI6VPgVlzUPjKh7bqly3hPla7ojXpWmr4Lz8z4BJLTP/oatgcZcf1bd9+K+2
 /ldJ11npqV3JOajJZR3FA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PBlv9yz64Ns=:tbCC6kmatMfTVOXMsLkboK
 7Ce5ZiJSPUbAPAGuuswHTHFcW1LrKk4gJTvA8c56AoZl5dpiswRlNVRe0pPhqNCYoyWzf2OeF
 rAOir14CDG15sMmvp6meoM6Vgq0cyYh7Q30+b9dc99njIoMubArWm/fRlhbWEyQ9nbhoCHLMz
 v4BlrtKdF7MAS8Bwrqw2Ja+sTurbTA79kkaUjwGttdWU5aVjsz22OTXQZe+XqpverzZtDfDzq
 F/QpOeljwRr6+ZdKWJcZyRcCob+O6YjJ9rmb1jFn3sRLyhUZfzWdsbiOgZ9Nh8tkcWPLZNGD3
 yqhnBWaTRbFo9PbaXPVAyOWznQKLsF8rbgUinjcN0LXB/TjH3msdxMhrrdGq8XOLVjKxezaac
 q3w1yL5QgXLgqqVYJ95WMrTq1T4tBVWRoSVWotNtK3Gan2ncfBsSE8Yfoeak3FE9wDvy0VnzJ
 e5uZC5kIQ9rD7mYBXN1myr4qBs0fB0kEqcUQAVMRbuGYwr6gAln9Dvs4HwFjJXwIQKIAmCaWQ
 1Q9cVBqGb+WgufK05La6XT6ZZhZW93MCc56fG1wW8LX+SNNF+inPsAsWwpUqJs39t3js7fJ7+
 ELh7r8ABChnDsloqGp6e0Q/AQ6+A9jiHKtXBNg5yWoH3Q9wo5eIwL8Z8/yHEfaeDGlM6y35TE
 I08pvu9aVFjnf2nseSNwRoCEwrYwA0ff0PSHGqoAWmeZPO/oyk8Rllzir/wemMRy7D0vuPZ0I
 lK86s9eCPaC/Z+v/a77egpMQX11KC47IrnteflpJMHfLVgdNLZCCUhupI1pUYof32V1olJzms
 3u4QAMkHGSHtAaJgITVacY19voDWccwDsUzm/pmf0UFTdAY3BU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hej Duy,
After running t9902-completion.sh on Mac OS I got a failure
in this style:

.../projects/git/git.pu/t/../contrib/completion/git-completion.bash: line 300:
declare: -g: invalid option
declare: usage: declare [-afFirtx] [-p] [name[=value] ...]
--- expected	2018-02-03 17:10:18.000000000 +0000
+++ out	2018-02-03 17:10:18.000000000 +0000
@@ -1,15 +1,2 @@
---quiet
---detach
---track
---orphan=
---ours
---theirs
---merge
---conflict=
---patch
---ignore-skip-worktree-bits
---ignore-other-worktrees
---recurse-submodules
---progress
 --no-track
 --no-recurse-submodules
not ok 92 - double dash "git checkout"

What is "declare -g" good for ?

<https://www.gnu.org/software/bash/manual/html_node/Bash-Builtins.html#index-declare>
