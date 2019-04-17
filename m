Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 352D520305
	for <e@80x24.org>; Wed, 17 Apr 2019 07:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731234AbfDQH6g (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 03:58:36 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42495 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728815AbfDQH6f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 03:58:35 -0400
Received: by mail-pg1-f193.google.com with SMTP id p6so11620520pgh.9
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 00:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mr4zzpiRsWSZhdMm3/Sf42Uun9n84E5hl9wrBtkmwRQ=;
        b=grI59vDtXeNnyDBLpqq0Sw6jjQ8FbMZyXajpOl22PavLwjc4DjaKe/QfVrR9tzunnX
         NaCrTgtaMaJY/iktAdncOl4thiV1VNFWSu2ut9Bt9hs4aTcONEG1sdqB64pSkELRRSsh
         ZSlXn2ka6oQCxxOdXa4h8ReZodmyu0jJVPgr3miGx/gF1atjtZHi9kRoHJ3x3JgIoY+j
         L5pZWIkGPq8OvPdzRUvm8+QvILNa3Mt2ObBSAc9rRrsobcs/gPSjBOKycEtrMWFnOMX8
         m8m49mxd2psFrJVGmVJxAYNY1ZvKqPe1tRs5X3qUUa/oxj0gsPj5blj9otA9g4YdAEXQ
         F7fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mr4zzpiRsWSZhdMm3/Sf42Uun9n84E5hl9wrBtkmwRQ=;
        b=eZTFW++jaFkRq+ITNmLwXaWslOuYEfMCfSqIPdTv8zI2tYdSFvL7YqTYVVEoqNYELl
         xHLHU6Mf9kghgMmXjfrMmT9/UKElh4CVgsWrffybr8pmmT/6rpFMdTaSUtnRXpBEHz1K
         TsKMk7Sas2E1/aCHIBP5eETsyhP0ak5NhkWI2OD6YoBcXoNo146byE9p+ZqOS5ImyEDt
         b/3dJjZp2B8MsNghpYJin6LizkXTURgRP1hji2vaqSuqW0wiCrRx7H3DhqjDgPtovWnD
         PHW+/0iPUGpTE992caan94ep2WFqB5/Y4WzoB+m3wtA6ZMs9+HuESGLeFzMkk/iH5x6O
         xLaQ==
X-Gm-Message-State: APjAAAW1lzDPy3yxm6JcPDHpAaPt9kDCQUjh5wHqf2+7uClNLJibHB4r
        v96pzB2QUTbsiB9uDPAdViQ86AjS
X-Google-Smtp-Source: APXvYqwkdPPn2au2GfAAuWJhnKpPE/Eby6BSKvFcKZG8gsZ2/4iIggpLFlv1FC/B7Cq5DhBVaqiA0g==
X-Received: by 2002:a65:5682:: with SMTP id v2mr82473300pgs.100.1555487914422;
        Wed, 17 Apr 2019 00:58:34 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id c3sm100195180pfg.88.2019.04.17.00.58.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 00:58:33 -0700 (PDT)
Date:   Wed, 17 Apr 2019 00:58:31 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 0/4] remove extern from function declarations
Message-ID: <cover.1555487380.git.liu.denton@gmail.com>
References: <cover.1555352526.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1555352526.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Thomas,

Thanks for the feedback.  I couldn't find a tool that could selectively
fix indentation on patches so I went through and manually realigned the
parameter lists wherever the tools mangled the alignment. I guess this
also implies that one pair of (tired) human eyes has manually inspected
the machine-generated diff.

Hopefully, patch 3/4 won't be as onerous to review as it was to write ;)

---

Changes since v1:

* Used spatch with sed instead of sed alone
* Fixed sed expression to ignore function variables

Changes since v2:

* Rebased on latest master (since last patchset hasn't been picked up
  yet)
* Manually aligned parameter lists that were mangled by the tools

Denton Liu (4):
  *.[ch]: remove extern from function declarations using spatch
  *.[ch]: remove extern from function declarations using sed
  *.[ch]: manually align parameter lists
  cocci: prevent extern function declarations

 advice.h                          |   2 +-
 archive.h                         |  24 +-
 bisect.h                          |  26 +-
 blame.h                           |   2 +-
 branch.h                          |  14 +-
 builtin.h                         | 254 ++++++++++----------
 bulk-checkin.h                    |  10 +-
 cache.h                           | 386 +++++++++++++++---------------
 checkout.h                        |   6 +-
 column.h                          |  16 +-
 commit.h                          | 116 ++++-----
 compat/mingw.c                    |   2 +-
 compat/mingw.h                    |   6 +-
 compat/nedmalloc/malloc.c.h       |   6 +-
 compat/obstack.h                  |  14 +-
 compat/poll/poll.h                |   2 +-
 compat/regex/regex.h              |  66 ++---
 compat/win32/pthread.h            |   8 +-
 config.h                          | 226 ++++++++---------
 connect.h                         |  22 +-
 contrib/coccinelle/noextern.cocci |   6 +
 csum-file.h                       |  20 +-
 decorate.h                        |   4 +-
 delta.h                           |  14 +-
 dir.h                             | 144 +++++------
 exec-cmd.h                        |  16 +-
 fmt-merge-msg.h                   |   2 +-
 fsmonitor.h                       |  14 +-
 gettext.h                         |   8 +-
 git-compat-util.h                 | 132 +++++-----
 grep.h                            |  22 +-
 hashmap.h                         |  30 +--
 help.h                            |  36 +--
 http.h                            |  62 ++---
 khash.h                           |  16 +-
 kwset.h                           |  10 +-
 line-log.h                        |  16 +-
 lockfile.h                        |  12 +-
 ls-refs.h                         |   4 +-
 mailinfo.h                        |   6 +-
 merge-blobs.h                     |   6 +-
 object-store.h                    |  32 +--
 object.h                          |  12 +-
 oidmap.h                          |  12 +-
 pack.h                            |  26 +-
 packfile.h                        |  82 +++----
 path.h                            |  42 ++--
 pkt-line.h                        |  10 +-
 ppc/sha1.c                        |   4 +-
 prio-queue.h                      |  10 +-
 protocol.h                        |   6 +-
 quote.h                           |  34 +--
 reachable.h                       |   8 +-
 reflog-walk.h                     |  28 +--
 refs.h                            |   2 +-
 remote.h                          |  24 +-
 replace-object.h                  |   4 +-
 resolve-undo.h                    |  14 +-
 run-command.h                     |   8 +-
 serve.h                           |   6 +-
 sha1-lookup.h                     |   8 +-
 streaming.h                       |   8 +-
 string-list.h                     |   4 +-
 sub-process.h                     |   8 +-
 submodule-config.h                |  22 +-
 tag.h                             |  16 +-
 tempfile.h                        |  30 +--
 trace.h                           |  44 ++--
 transport.h                       |   4 +-
 tree-walk.h                       |   4 +-
 upload-pack.h                     |   8 +-
 url.h                             |  16 +-
 urlmatch.h                        |   4 +-
 utf8.h                            |   2 +-
 varint.h                          |   4 +-
 vcs-svn/sliding_window.h          |   2 +-
 vcs-svn/svndiff.h                 |   4 +-
 worktree.h                        |  36 +--
 xdiff-interface.h                 |  12 +-
 79 files changed, 1197 insertions(+), 1191 deletions(-)
 create mode 100644 contrib/coccinelle/noextern.cocci

-- 
2.21.0.832.gd5ec0d3bee

