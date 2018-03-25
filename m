Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A62B81F404
	for <e@80x24.org>; Sun, 25 Mar 2018 05:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751100AbeCYFsd (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 01:48:33 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:51028 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751090AbeCYFsc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 01:48:32 -0400
Received: by mail-it0-f67.google.com with SMTP id d13-v6so7036284itf.0
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 22:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5EyvoQYdQka9LAkwHMUM4gUKZOqB+W9WNjn6egKpTxI=;
        b=c0QBuqRhaZ1Ltx0js/N8aMOn32U0sI6RkmSeKdb9MT+8BJPpmFCuz2OyNajVkbyN8d
         knkuQpIuyvBEMBton8QHP217RW4rZD/YVbkSPYX684C5oOI+1dXEZns68WCRsXE8reH3
         JJXuJ6Bqq10anN2XENiGGBNTHAIox0IYx42iz/nmP2MnDNiAZPSm1w/wxvcTuhSKwBzr
         1+aBAzhEV50zb/6olBJ+INhCud+IR+R1owyv7k+enHhlHAnZvkdFLDAG/ZV897xYsiv9
         uI47rYr0vu5fn6fV+b83wMd41G6VxwMcUAKFsSbeGEdDLHx6UaqI7wHUk988CrremEFA
         I2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5EyvoQYdQka9LAkwHMUM4gUKZOqB+W9WNjn6egKpTxI=;
        b=JpHEhmfdst0pPldiixgUHUda13ctlNO9R6P85jFyPPabfrxg10RhE5E1nylE5ALo8q
         ZzrqpuSHNZpMv6z5YFsvWz30F7/MPTw74OGEozfddh5bwdnnUy0wpAFgrL2+5B1Kb8zS
         1g8JATtT4U65xx4a4I1pt8SyvOvrxvuAOK1ge8imXHRacxAYU9jASa29jne+LaaJepMc
         eJTKLSHO8TN+N6XXY27nzfcZmspIm5xV4FsPPXQseHwHrL0/FFBuPgj5LUWYFn+Ngyn3
         Xl8t71KzHXQ8WIRFQB6llejb9KHTUUH13/csWp/OFxI9bqJjcWWF86Cib+sp13Gcf+Qt
         rRdA==
X-Gm-Message-State: AElRT7FmokXkhhYOY1xBKVdmwYcibq8GfcFreghNnoyIhGFuB2KzepLK
        6tLYfeNxYOJuxYQLIhG4twc=
X-Google-Smtp-Source: AG47ELuoThArn363KYbRzYJ6QcnRFuDqTQYHjOvxaPpZeOb2nheyn5nvWIiTuJhSzwmOCCqzyKEBNw==
X-Received: by 2002:a24:d445:: with SMTP id x66-v6mr19456412itg.5.1521956911609;
        Sat, 24 Mar 2018 22:48:31 -0700 (PDT)
Received: from flurp.local (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id i94sm8204933ioo.46.2018.03.24.22.48.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 22:48:30 -0700 (PDT)
Date:   Sun, 25 Mar 2018 01:48:24 -0400
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] branch -l: print useful info whilst rebasing a non-local
 branch
Message-ID: <20180325054824.GA56795@flurp.local>
References: <20180324183844.4565-1-kaartic.sivaraam@gmail.com>
 <CAPig+cQ8xw23SGhpx5qtDEyzJGR1v4L2Lm9tEWe56Rh3c8Q3cg@mail.gmail.com>
 <87ea8cac-c745-b7e6-7804-5116cd94ed48@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ea8cac-c745-b7e6-7804-5116cd94ed48@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 25, 2018 at 09:11:34AM +0530, Kaartic Sivaraam wrote:
> On Sunday 25 March 2018 07:04 AM, Eric Sunshine wrote:
> > Can we have a couple new tests: one checking "git branch --list" for
> > the typical case (when rebasing off a named branch) and one checking
> > when rebasing from a detached HEAD?
> 
> Sure, but I guess it would take some time for me to add the tests. I'll
> send a v2 with the suggested changes.

A couple more comments:

* Please run the commit message through a spell checker; it contains
  several typographical errors.

* I wonder if it makes sense to give slightly different output in the
  detached HEAD case. Normal output is:

      (no branch, rebasing <branch>)

  and, with your change, detached HEAD output is:

      (no branch, rebasing d3adb33f)

  which is okay, but perhaps it could be better; for instance:

      (no branch, rebasing detached HEAD d3adb33f)

Anyhow, I wrote the tests for you. When you re-roll, you can make the
following patch 2/2 and your fix 1/2. (If you go with the above idea
of using a slightly different wording for the detached HEAD case, then
you'll need to adjust the 'grep' slightly in the second test.)

--- >8 ---
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 25 Mar 2018 01:29:58 -0400
Subject: [PATCH] t3200: verify "branch --list" sanity when rebasing from
 detached HEAD

"git branch --list" shows an in-progress rebase as:

  * (no branch, rebasing <branch>)
    master
    ...

However, if the rebase is started from a detached HEAD, then there is no
<branch>, and it would attempt to print a NULL pointer. The previous
commit fixed this problem, so add a test to verify that the output is
sane in this situation.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t3200-branch.sh | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 6c0b7ea4ad..d1f80c80ab 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -6,6 +6,7 @@
 test_description='git branch assorted tests'
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-rebase.sh
 
 test_expect_success 'prepare a trivial repository' '
 	echo Hello >A &&
@@ -1246,6 +1247,29 @@ test_expect_success '--merged is incompatible with --no-merged' '
 	test_must_fail git branch --merged HEAD --no-merged HEAD
 '
 
+test_expect_success '--list during rebase' '
+	test_when_finished "reset_rebase" &&
+	git checkout master &&
+	FAKE_LINES="1 edit 2" &&
+	export FAKE_LINES &&
+	set_fake_editor &&
+	git rebase -i HEAD~2 &&
+	git branch --list >actual &&
+	grep "rebasing master" actual
+'
+
+test_expect_success '--list during rebase from detached HEAD' '
+	test_when_finished "reset_rebase && git checkout master" &&
+	git checkout HEAD^0 &&
+	oid=$(git rev-parse --short HEAD) &&
+	FAKE_LINES="1 edit 2" &&
+	export FAKE_LINES &&
+	set_fake_editor &&
+	git rebase -i HEAD~2 &&
+	git branch --list >actual &&
+	grep "rebasing $oid" actual
+'
+
 test_expect_success 'tracking with unexpected .fetch refspec' '
 	rm -rf a b c d &&
 	git init a &&
-- 
2.17.0.rc1.321.gba9d0f2565
--- >8 ---
