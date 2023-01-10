Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FECC54EBC
	for <git@archiver.kernel.org>; Tue, 10 Jan 2023 13:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238637AbjAJNP7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Jan 2023 08:15:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234141AbjAJNP3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2023 08:15:29 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55B058310
        for <git@vger.kernel.org>; Tue, 10 Jan 2023 05:15:24 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id k26-20020a05600c1c9a00b003d972646a7dso11818512wms.5
        for <git@vger.kernel.org>; Tue, 10 Jan 2023 05:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mDCgyWs/2/2Gtx4/oV/rRlkq4byR2DoJwVZgUPExL7Q=;
        b=nOLXie+URadvws8dk+RB0DInXyYh7TKZ7MKN5S37PQelmeEAdoZYd2X1EI0rUtH48N
         lvcv4bfzRGPJU23qSNi9ivfqTg/3ND2TcBH3igjAguc54e5s4Gb6KkaSc6y2n4VuxtYQ
         NsnYQFV9of9XhNF62hk4iAwlIqnyI07uuNgN+807oNxyj1r/g0c1k83ZFqzoRp0hLVO1
         1A3Dr/PnAU5nWPLFa6ikaSA4Nload55ejUxX5ZTq20jTh1ooMIEeBSPLMyL9uJX+L7Ld
         vKryg0cg5YzLnymhCLqzs0C5bZuhUJYfszohuL153qfQc/Z+h38qjP1QZwFdVq4IYxB0
         5LjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mDCgyWs/2/2Gtx4/oV/rRlkq4byR2DoJwVZgUPExL7Q=;
        b=1eMAXJKV3sBRMaSgVCyjliZ45caJMVt/tixG9Jr8spguAUbr0RLgeQkUkIP8vq4SNc
         R7W9lrNnLBe8ftVbomxZgHDQQQDDdoO0z5v+taArgdhznMn11bdHat9/BFfmVo0HnVkD
         FzWMSGrrMS5A53fT0oa1yioxMt7ZCsK5YgtlYVr+9x/FPdEb4CcTAm/iB8JSQlFydXpQ
         HhGs8eVbAnLdhzMFV+wa45IE2q5wjl+06Zg0mUH/DMtjEC7RVucFzHYK3tLOCtuPN4UM
         F1PIju59CgZD3SqtH6NUITJ0ZX1J6bxjUY/McWREUL4tBhVmV3hah5dD1kuUHG0JxR58
         okcA==
X-Gm-Message-State: AFqh2koY0CJ9P/+xgH8/ztRmtyYRA9Ru45IEPKJt3Hd4ojms5qEF/eio
        3MVgQaPDcUWR0QV5eUANtmz220F2ax4=
X-Google-Smtp-Source: AMrXdXtqyZ4X4mdaZyJl+UMbbw5ZdHcBTxLV7R2VjITfwe44NzwJXUKtIVunX4DL6rXDczIeDV/mmA==
X-Received: by 2002:a05:600c:4f12:b0:3d9:f9ef:3d23 with SMTP id l18-20020a05600c4f1200b003d9f9ef3d23mr1380917wmq.23.1673356523205;
        Tue, 10 Jan 2023 05:15:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r7-20020a05600c458700b003d974076f13sm15977992wmo.3.2023.01.10.05.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 05:15:22 -0800 (PST)
Message-Id: <pull.1456.v2.git.1673356521.gitgitgadget@gmail.com>
In-Reply-To: <pull.1456.git.1673120359.gitgitgadget@gmail.com>
References: <pull.1456.git.1673120359.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 10 Jan 2023 13:15:16 +0000
Subject: [PATCH v2 0/5] Documentation: updates and a correction around 'ORIG_HEAD'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Erik Cervin Edin <erik@cervined.in>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

 * added a link to the mailing list thread in the commit message of 5/5.

v1: Documentation: updates and a correction around 'ORIG_HEAD'

This series' initial motivation was to clear up a confusion that arose in
[1] where it was noticed that 'ORIG_HEAD' is not guaranteed to point to the
original branch tip at the end of the rebase if 'git reset' is used during
the rebase.

Patch 5/5 adds a note to 'git rebase's documentation to make that explicit.
When taking a look at the existing documentation mentioning 'ORIG_HEAD', I
also found an error in an example (patch 1/5), other small inconsistencies
(patch 2-3/5), and a potential improvement (patch 4/5).

Cheers,

Philippe.

[1]
https://lore.kernel.org/git/1b2b8e98-5506-a1e6-6059-a967757b3bb8@gmail.com/T/#m827179c5adcfb504d67f76d03c8e6942b55e5ed0

Philippe Blain (5):
  git-cherry-pick.txt: do not use 'ORIG_HEAD' in example
  git-reset.txt: mention 'ORIG_HEAD' in the Description
  git-merge.txt: mention 'ORIG_HEAD' in the Description
  revisions.txt: be explicit about commands writing 'ORIG_HEAD'
  git-rebase.txt: add a note about 'ORIG_HEAD' being overwritten

 Documentation/git-cherry-pick.txt | 2 +-
 Documentation/git-merge.txt       | 3 ++-
 Documentation/git-rebase.txt      | 7 +++++++
 Documentation/git-reset.txt       | 3 ++-
 Documentation/revisions.txt       | 3 ++-
 5 files changed, 14 insertions(+), 4 deletions(-)


base-commit: 4dbebc36b0893f5094668ddea077d0e235560b16
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1456%2Fphil-blain%2Fdoc-orig-head-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1456/phil-blain/doc-orig-head-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1456

Range-diff vs v1:

 1:  74b2d5a9144 = 1:  74b2d5a9144 git-cherry-pick.txt: do not use 'ORIG_HEAD' in example
 2:  f25c71fd4c3 = 2:  f25c71fd4c3 git-reset.txt: mention 'ORIG_HEAD' in the Description
 3:  e488ad3ce1d = 3:  e488ad3ce1d git-merge.txt: mention 'ORIG_HEAD' in the Description
 4:  302b789a486 = 4:  302b789a486 revisions.txt: be explicit about commands writing 'ORIG_HEAD'
 5:  9ef427a9a2a ! 5:  7eed8f35376 git-rebase.txt: add a note about 'ORIG_HEAD' being overwritten
     @@ Commit message
      
          Indeed, using other commands that write 'ORIG_HEAD' during the rebase,
          like splitting a commit using 'git reset HEAD^', will lead to 'ORIG_HEAD'
     -    being overwritten.
     +    being overwritten. This causes confusion for some users [1].
      
          Add a note about that in the 'Description' section, and mention the more
          robust alternative of using the branch's reflog.
      
     +    [1] https://lore.kernel.org/git/28ebf03b-e8bb-3769-556b-c9db17e43dbb@gmail.com/T/#m827179c5adcfb504d67f76d03c8e6942b55e5ed0
     +
          Reported-by: Erik Cervin Edin <erik@cervined.in>
          Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
      

-- 
gitgitgadget
