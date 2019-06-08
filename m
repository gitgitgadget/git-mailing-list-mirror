Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 088D81F462
	for <e@80x24.org>; Sat,  8 Jun 2019 22:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbfFHWP7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Jun 2019 18:15:59 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:8732 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727215AbfFHWP7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jun 2019 18:15:59 -0400
Received: from [192.168.1.22] ([78.148.161.28])
        by smtp.talktalk.net with SMTP
        id ZjcxhF3igniZTZjcxhCp67; Sat, 08 Jun 2019 23:15:55 +0100
X-Originating-IP: [78.148.161.28]
X-Spam: 0
X-OAuthority: v=2.3 cv=B8HHL9lM c=1 sm=1 tr=0 a=ujKALdKAi7z8notBBWqKeA==:117
 a=ujKALdKAi7z8notBBWqKeA==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=4agKAnUZAAAA:8 a=xtxXYLxNAAAA:8 a=52-Yb1kGAAAA:20
 a=78P192lCtf-zAGwu5TEA:9 a=QEXdDO2ut3YA:10 a=6xpKdUgVHagA:10
 a=LOQEGXnSQUYAeq1akIYl:22 a=xts0dhWdiJbonKbuqhAr:22
Subject: Re: Git Test Coverage Report (Thursday, June 6 2019)
To:     Derrick Stolee <stolee@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <396091fc-5572-19a5-4f18-61c258590dd5@gmail.com>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <f28dd5b1-fda8-cf51-5582-067a7d2c2472@iee.org>
Date:   Sat, 8 Jun 2019 23:15:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <396091fc-5572-19a5-4f18-61c258590dd5@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfOzHS+Vacf90R2K1Q+4AYoq1fwrxoBfvbXpuLYZJjtqg6KgnEIJPBJcUOEn0ztNDhuPg0rj0AfXvfcovmWLHR3Jx7v//ARb+jPUKuQPaokZmx45xDEr9
 Dr/8KSSAAafIzw6xmAwgjQqWDErkVn+8EfPgKwDlf1UHqz2MuMkMYhFGv2+NEGNoaSRLBDMAj365YB4wYkJPOupMeCBai+79/m4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stollee

On 07/06/2019 02:19, Derrick Stolee wrote:
> Here is today's test coverage report.
>
> Thanks,
> -Stolee
>
> [1] https://derrickstolee.github.io/git-test-coverage/reports/2019-06-06.htm
> [2] https://derrickstolee.github.io/git-test-coverage/reports/2019-06-06.txt
>
> ---
>
> pu	4f91bbec8a3cc2fff435fb3dbb0dfa5f9d223141
> jch	e1895a3c3b1fef6d1bc80251d09598e219d3908d
> next	ee3066bb6536c68f973b3c0ffaaa13f4bfda5ea3
> master	74583d89127e21255c12dd3c8a3bf60b497d7d03
> master@{1}	aa25c82427ae70aebf3b8f970f2afd54e9a2a8c6
>
>
> Uncovered code in 'pu' not in 'jch'
> --------------------------------------------------------
>
> [snip]
>
>
> Uncovered code in 'jch' not in 'next'
> --------------------------------------------------------
>
> builtin/branch.c
> 1fde99cf 841) die(_("The -a, and -r, options to 'git branch' do not take a branch name.\n"
>
> [nip]
>
> Commits introducting uncovered code:
> ...
> Philip Oakley	1fde99cf doc branch: provide examples for listing remote tracking branches
> [snip rest]

The change was just a change to the die() message, but was not tested 
previously.

I've guessed that t3203 would be the right place for an extra test which 
I've hacked (but not yet tested) as

---
phili@Philip-Win10 MINGW64 /usr/src/git (branch-patterns-v2)
$ git show -1
commit d5a799d8833b0ae195915eefd5365f3fc4c7c0a4 (HEAD -> 
branch-patterns-v2, my/branch-patterns-v2)
Author: Philip Oakley <philipoakley@iee.org>
Date:   Sat Jun 8 22:50:06 2019 +0100

     t3203-branch-output: test -a & -r pattern options

     Users may wrongly use the -r and -a options with a branch pattern when
     looking for a remote tracking branch. Test that we fail for that 
misuse.

     Signed-off-by: Philip Oakley <philipoakley@iee.org>

diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index ee6787614c..e78bd1c56d 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -264,4 +264,9 @@ test_expect_success '--color overrides auto-color' '
         test_cmp expect.color actual
  '

+test_expect_success '-a & -r options do not take a branch name, without 
--list' '
+       test_must_fail git branch -a HEAD
+       test_must_fail git branch -r HEAD
+'
+
  test_done
---
https://github.com/PhilipOakley/git/commit/d5a799d8833b0ae195915eefd5365f3fc4c7c0a4

Not sure if that's the right way to do it (Its my first proper try at 
tests themselves..)

I'm going to be away for about a week with only intermittent internet 
hence the unfinished reply.
--
Philip
