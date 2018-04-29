Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 272331F428
	for <e@80x24.org>; Sun, 29 Apr 2018 20:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754216AbeD2UVT (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Apr 2018 16:21:19 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34316 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753898AbeD2UVS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Apr 2018 16:21:18 -0400
Received: by mail-wm0-f65.google.com with SMTP id a137so7851302wme.1
        for <git@vger.kernel.org>; Sun, 29 Apr 2018 13:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WobzhFSUWuw4p/+b6cCIgk3EhwtrLxvE0rh+N7dweDs=;
        b=lYSHPyA747ni9xAKTv4f3ykmNy1LjeMCvQd4cTOW8ovW08F6Z899BNUqUdkBFduBSf
         7FeWwpbSyJaQhotcaH68Pzob4GF16HW3jp3VLAeSl4v/TUrwPU2x/W0Xe6q9G0gfjqRw
         OSfx6SFiaKZSgW8aN6gWbNUt8bKKlL91bBmXw4ZSZx+bHKriuSPIti6e8NyAaQqRwNBR
         kQnzkWtGDJWtoZQL634++wMcvLkZtcRHfkSz3flPG3R/nQwr3NN5vbsubPwWMpB1zVNm
         8UZa0q+U5rVYln62b895cEmxehkWF+AQsH72gA+M5tRuaSlnQPmKi+R5XGEgAmSswRwN
         GXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WobzhFSUWuw4p/+b6cCIgk3EhwtrLxvE0rh+N7dweDs=;
        b=Ec46gBn6fEMfvRJDgp4muYM+qsgDMQdjBq1Z670mcqBGszTl/RrxJkC46kfbfRsw52
         i0Pl6RzfvDv14A8zGVthG8NyerAev30JGCpT56zRfHKcoz+xRBYdAOiV8Wxbg8+5FRIB
         6bNOC94xjyURZEs8WxEbGavJ7IieWKxyMP0TJ5S7ATkJnwAGsJkleGqIo/mptAWr7500
         nc96OSfhogwXbzseSV2a18/VYIFlV50Vcg7rC8uZBzu/y2niCKyo0Q199cqsHjO4DdsU
         5oc41JVNWM2nyryatCTUlkgO3DMehle9Vx2++/T64qQGK+H0xbV3k7TninaRhAV3nnKS
         LkBw==
X-Gm-Message-State: ALQs6tB4rEQ9n4801SwgQO0gclJi7z+djOESV/ElpYbBW44V1STgKOGF
        +61tGC8UUqUZEXdURSJhpvvuIMUZ
X-Google-Smtp-Source: AB8JxZo/ihnlK3aK35U+2zO0unYdu3CYnptxsd0wQ379qqgHg0SOqOIFAPxzKVdu0vZYbOOmdwgp2Q==
X-Received: by 10.28.109.151 with SMTP id b23mr6125496wmi.86.1525033276878;
        Sun, 29 Apr 2018 13:21:16 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id y42-v6sm8134917wry.21.2018.04.29.13.21.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Apr 2018 13:21:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/8] "git fetch" should not clobber existing tags without --force
Date:   Sun, 29 Apr 2018 20:20:52 +0000
Message-Id: <20180429202100.32353-1-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <CACBZZX7HFnEMD8PKWj0c7VWqv=yeYCXYJjy-5YPZnF_pJAy0jw@mail.gmail.com>
References: <CACBZZX7HFnEMD8PKWj0c7VWqv=yeYCXYJjy-5YPZnF_pJAy0jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 27 2018, Ævar Arnfjörð Bjarmason wrote:

> On Tue, Apr 24, 2018 at 9:57 PM, Wink Saville <wink@saville.com> wrote:
>> If have a repository with a tag "v1.0.0" and I add a remote repository
>> which also has a tag "v1.0.0" tag is overwritten.
>
> I feel like this thread has gotten somewhat side-tracked by the valid
> discussion about whether we should have remote tracking tags, but the
> much easier thing to fix is that the "+" prefix for refs/tags/* means
> nothing.
> [...]

This patch series implements that simpler way of digging ourselves out
of the immediate hole that we're clobbering tags by default without
the --force option.

I'm not 100% happy about this, but I think sans stuff that comes up in
review it's in principle ready for inclusion, stuff I wished I'd done
but have left for later:

 * Write a gitrefspec(5) man page, now we have how they work, and how
   they work on push/pull scattered over two docs, which before this
   are in conflict with one another.

 * Have much more exhaustive tests, I started trying to integrate this
   with the much more exhaustive tag pruning tests in my
   https://github.com/avar/git/tree/refspec-support-+-in-tags but gave
   up because the various interaction with those tests is messy,
   e.g. if we fail a tag update we don't prune as the existing tests
   assert, because the whole ref transaction fails.

 * 05/08 notes how the semantics of whether something needs a --force
   are really confusing because the rules are different depending on
   the ref namespace you're pushing into. We should probably build on
   top of this and e.g. refuse to clobber tags outside of refs/tags/*.

 * Should we do better to mitigate this breaking stuff for existing
   users who really are expecting their tags to be clobbered? Maybe by
   adding a --force-tags option (which wouldn't clobber branches), or
   have some config option either enable the old behavior, or make
   this opt-in?

Ævar Arnfjörð Bjarmason (8):
  push tests: remove redundant 'git push' invocation
  push tests: fix logic error in "push" test assertion
  push tests: add more testing for forced tag pushing
  push tests: assert re-pushing annotated tags
  push doc: correct lies about how push refspecs work
  fetch tests: correct a comment "remove it" -> "remove them"
  fetch tests: add a test clobbering tag behavior
  fetch: stop clobbering existing tags without --force

 Documentation/fetch-options.txt    | 15 ++++--
 Documentation/git-push.txt         | 30 ++++++++---
 Documentation/gitrevisions.txt     |  7 +--
 Documentation/pull-fetch-param.txt | 22 +++++---
 builtin/fetch.c                    | 20 +++++---
 t/t5510-fetch.sh                   |  2 +-
 t/t5516-fetch-push.sh              | 82 ++++++++++++++++++++++--------
 t/t5612-clone-refspec.sh           |  4 +-
 8 files changed, 130 insertions(+), 52 deletions(-)

-- 
2.17.0.290.gded63e768a

