Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6D6B20450
	for <e@80x24.org>; Sat,  4 Nov 2017 00:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756342AbdKDAmj (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Nov 2017 20:42:39 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:49377 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756007AbdKDAmh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Nov 2017 20:42:37 -0400
Received: by mail-wr0-f195.google.com with SMTP id g90so3884759wrd.6
        for <git@vger.kernel.org>; Fri, 03 Nov 2017 17:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CK+Z1TGKwhj7PuVgqUf5gN+gmocNFFHgmXvmoMpyMVw=;
        b=rjAkSAW9JfIUeedQ4AWsLid3Jhn/dIvr0ylP+omRvW5nZuSnWbsD2gYM4uFaio+1Sa
         p5LJ1WJ6FyrNBUAnj4SZltyat28g8M4jG7xnJyFbDmjrGrj8du5yp5le6lLgKIU1PLee
         OHz47p0fwoB2epTKsoQLxRrnjnCNxJqjo/CJpu690Yk1DYVsvHOL9otzhz8eus2X7Zg5
         BedBUxPntvfs/yYwAFoYYIz9NdInRLm3TMgkwUyr105OPpXTjMN4qIdFfmNsqVLoqnAy
         mtZZRcpNMf7adoOUYxa8PTHDt7gQIVNE3eHmzo6ig68s6YEDOYvCSOtwzXrXAG/OHhef
         /ZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CK+Z1TGKwhj7PuVgqUf5gN+gmocNFFHgmXvmoMpyMVw=;
        b=KZOQMVy3Vlz9vrg9gPJ7BvX0ESBRDzDtyX73do9YagmCWu9I/w1pidm9r8IVN14Jj2
         AnUql7Hl/t/CAB61TKsSyPn6dHPipHPmHNkDdKaJdESY1brcFan7VMVHwWkLFxGQ4N25
         pi0ppi2AjGtXY1VCkkaCTfJIuuCrH6oLm63kcQZfyAm9np/7AUxqo2YboDYzJw9f4OmQ
         ZerB48XvXjoaLVpoloQrtSaJlUAZ+9aLy5AGeHuikrzokywnODMNgOfH1vmEi7LYxclf
         PDlcnDI06FpQxqUJJEeQ7YVKxF6mglffnHil8YV3HnaXpNUilzUHwyx0gQnE3h3h/FUH
         2Y1A==
X-Gm-Message-State: AMCzsaW4wWgkZYMdXeKcb0MYKGPOEeesFaiixTiAJdnS4LwqNJXaFmd/
        PmZ/SScYzoK6msEjFAPEKukQuQIOk2w=
X-Google-Smtp-Source: ABhQp+TNNW7rRaa+62GIBzZD9RTJoQzbZpemV18VtGVmIz49GZv8yHeZDBjhpO5igTUyI4TPNDFsNQ==
X-Received: by 10.223.167.65 with SMTP id e1mr7786983wrd.280.1509756156127;
        Fri, 03 Nov 2017 17:42:36 -0700 (PDT)
Received: from rigel.lan (101.154.108.93.rev.vodafone.pt. [93.108.154.101])
        by smtp.gmail.com with ESMTPSA id o8sm11956418wrc.10.2017.11.03.17.42.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Nov 2017 17:42:35 -0700 (PDT)
From:   =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        me@ikke.info, gitster@pobox.com, hjemli@gmail.com,
        mhagger@alum.mit.edu, pclouds@gmail.com,
        ilari.liusvaara@elisanet.fi
Subject: [PATCH v1 0/2] Add option to git log to choose which refs receive decoration
Date:   Sat,  4 Nov 2017 00:41:42 +0000
Message-Id: <20171104004144.5975-1-rafa.almas@gmail.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As suggested by Documentation/SubmittingPatches
Hi, this is my first patch.\n

I basically stumbled on the same issue mentioned here:
https://public-inbox.org/git/xmqqzim1pp4m.fsf@gitster.mtv.corp.google.com/

This patch implements two new command line options for `git log`:
`--decorate-refs=<pattern>` and `--decorate-refs-exlcude=<pattern>`

Both options accept a glob pattern which determines what decorations
commits receive.

At first I considered adding '--trim-decoration', that would filter refs
based on values passed to '--branches=' '--remotes=' '--tags=' and
'--exclude='.

After reading the email, I think it's better to have those two
behaviours decoupled.

I also had plans to add:
(Not sure if others deserve having their own command)
--decorate-branches=
--decorate-remotes=
--decorate-tags=

But was not sure if a 'niche' function like this is worth 5+ command
line options. I personally find that those two are enough.

---
Rafael Ascensão

Rafael Ascensão (2):
  refs: extract function to normalize partial refs
  log: add option to choose which refs to decorate

 Documentation/git-log.txt |  12 ++++++
 builtin/log.c             |  10 ++++-
 log-tree.c                |  37 ++++++++++++++---
 log-tree.h                |   6 ++-
 pretty.c                  |   4 +-
 refs.c                    |  34 +++++++++-------
 refs.h                    |  16 ++++++++
 revision.c                |   2 +-
 t/t4202-log.sh            | 101 ++++++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 198 insertions(+), 24 deletions(-)

-- 
2.15.0

