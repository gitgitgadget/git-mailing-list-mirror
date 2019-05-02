Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE4271F453
	for <e@80x24.org>; Thu,  2 May 2019 11:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfEBL6d (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 May 2019 07:58:33 -0400
Received: from mail-io1-f51.google.com ([209.85.166.51]:34722 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfEBL6d (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 May 2019 07:58:33 -0400
Received: by mail-io1-f51.google.com with SMTP id h26so1873025ioj.1
        for <git@vger.kernel.org>; Thu, 02 May 2019 04:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=ILn6tv1Y3XgL7v66f1RWGvu60D4Pt9Hscyk0DOA0KBM=;
        b=jtuTdVK/On0qYNE2oCyPC4fv+MsnZqDSAJtknY3uGiWSarX3+YsNPyB/LQ2h3lsbRM
         iD18oTSYY0cihn9TRfNPLrWEpSelfnLQP1QWLbO4S4UqPqE11uHcu8ml187qiu3RXujd
         uC49kKfK6Ewfu6yloFS+sHwM5gGT5CwGKEWoOzIhmmhZljAIyJB3l6BahA8SFPRfn7zk
         NoaVmbc5qca3K61oNZ85guJIj+RZFkX9k83v8oNvjyXzt1/sYyjnR0DuLFhUXus3BJ3f
         1xkHBmrzzqAQ8PXht0IFwF91FbmA2lfYn3uOdYLNud9/hPBpetxodVmUK7m/H7+TNZnw
         f77g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ILn6tv1Y3XgL7v66f1RWGvu60D4Pt9Hscyk0DOA0KBM=;
        b=GlR6FkIyyfXIiB6uGCqX7DXbDGaxEopxxkwaVXTN+0u4kb+w2ytZqFslLtF356cBVo
         ijKTKfrXgB7HtLYe8FUYftlK7pkR8KONa7yptz6RA87bEgCuBrQSiMnCZisTWVW/tdXn
         thMrO0iuvfNZgfX1LsXyCZ+drGqJ1o56YdckHaK4QT8ZxzXqDE5HALCvW17BN3IWWhRf
         /NYLSacz3oa5+Hq5weLLGclqHGhRnXvJt2Ozbb4RgbpOLFC0RZyvRPjJANcfSWHI50pl
         X+zrbjGj5m3lTrWovyemFC0iyTidEaydan3D7j+YdUTCOGRHm2szvxWWsnu0XitcE+mz
         lJCA==
X-Gm-Message-State: APjAAAXqd3c8hamV/WLk5JNszzFtXSC+bcuC6dIB0VrL6KdVW/gZr03p
        HJ8lGDFFbiLv1nC8wPoEVZfqpwi5VHlXQTYyW7qySQ==
X-Google-Smtp-Source: APXvYqyrpoWW4oRh+j75bb9Gi7saQ+ivkipP+gZRikQzshfQnzkaGOgS+Og7NUdP2bbZ0x1NHsRoWW/kQx/4lduuwRw=
X-Received: by 2002:a5e:8b09:: with SMTP id g9mr2163325iok.137.1556798312743;
 Thu, 02 May 2019 04:58:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:4103:0:0:0:0:0 with HTTP; Thu, 2 May 2019 04:58:31 -0700 (PDT)
From:   frank kulow <kulow.f@googlemail.com>
Date:   Thu, 2 May 2019 13:58:31 +0200
Message-ID: <CAA2qrhBmbSe5R0xQPBZiRcz0MGG=JcF4BjxHqmyeTFNR19FKbg@mail.gmail.com>
Subject: "git branch -f" corrupt other worktree
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git version 2.21.0.windows.1

> /c/tmp/gt (Branch_702091a0)
$ git worktree add ../wt master
Preparing worktree (checking out 'master')
HEAD is now at f534c32 4

> /c/tmp/gt (Branch_702091a0)
$ git branch -D master
error: Cannot delete branch 'master' checked out at 'C:/tmp/wt'

#but this is possible:

> /c/tmp/gt (Branch_702091a0)
$ git branch -f master HEAD

#and the other worktree is now corrupted:

> /c/tmp/wt (master)
$ git status
On branch master
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

        modified:   txt.txt
        deleted:    txtb.txt



greetings f.kulow
