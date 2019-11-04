Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 098771F454
	for <e@80x24.org>; Mon,  4 Nov 2019 20:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbfKDUDs (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 15:03:48 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39740 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728332AbfKDUDr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 15:03:47 -0500
Received: by mail-pg1-f195.google.com with SMTP id 29so817968pgm.6
        for <git@vger.kernel.org>; Mon, 04 Nov 2019 12:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=TRHUahrZHBwXU/KPBN+BShwu/3xcpKiH+cY+isEo6yU=;
        b=bqv/HpjjrLOzAuv3q/hdudf5KD0BqslG/XTPD2wkDyIhLIzKUAUUnuBXGf8DdEvpKc
         VAiXwV0CfZkjG8Nf83kdq0b5qM5diRSH2hLHCZJpruoRC+PIexgQS0k1bSCwgDCkJ87G
         ooa4zrZtBQ+K61L6O54xYMzH2NqKq7vyGD8Jw1XOWKKGMZMn+KlWIvTGkU5Vc+VsFyNc
         kxTV5r3GBJULAC2NXD1DbBNekeGevKc2Gc+J3mqATnr7EOGYMNSnDAGWCjVv89e2AxLb
         lqDmQpvD5bOzApUI2RfgKuwj5D72U+cpiKoEdWNDnP0Z9bYPuoEvp/BFJUdFqMamB1rQ
         Jfug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=TRHUahrZHBwXU/KPBN+BShwu/3xcpKiH+cY+isEo6yU=;
        b=RA/eyDOAXzaDfLhnfB0VGXMef7Fj+k3z6EuKFJqKReFYEGISZp+0rW9WZ4N4IT3qxk
         qJcIV8UiQS2PQcGyEjsgnPkVVYPwGjHC7xSpbjAr6gJkqlI7X/MOs8WMtOJjXbuBhvk1
         f0pOEjnU4d6f9d9BJIFQw13lvcxlEP+zsbdcgTm65zPdbUp33D+BjXWKK4Yr8BaUn9AX
         iFYRKqKcr0opOIPj3H4hG8o/E0FJ/BjfqWii28h+5TG+DQDYVPfCxrKrG/o6R8nDJGms
         E07sIJfTo4TjMAhT2/rjnz1Egn+NNziE8enKur8J1ITB+M/e21/JgVNxdA/d7yFXP9s9
         Qmcg==
X-Gm-Message-State: APjAAAWUO8uQxJ1efzClDdMT9srNLIsHeV9yo+XTdNZ4wzFqnV2vEV/p
        pxoNrWuhBSOlFFFKZw8ek92A8qWL
X-Google-Smtp-Source: APXvYqyoaT0C+Kgw9nq0qSwBSBtxB00CPk5aDQtRR5nPnKhemwEdDNf0k/XAKhlKXXK9RbcQsLRerA==
X-Received: by 2002:aa7:9428:: with SMTP id y8mr33690053pfo.233.1572897826702;
        Mon, 04 Nov 2019 12:03:46 -0800 (PST)
Received: from generichostname ([204.14.236.210])
        by smtp.gmail.com with ESMTPSA id g9sm16552743pjl.20.2019.11.04.12.03.45
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 12:03:45 -0800 (PST)
Date:   Mon, 4 Nov 2019 15:03:43 -0500
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 0/8] learn the "summary" pretty format
Message-ID: <cover.1572897736.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On this mailing list (and many others) the standard way to reference
other commits with the "summary" format, e.g. "f86a374 ("pack-bitmap.c:
fix a memleak", 2015-03-30)". Since it's so commonly used, let's
standardise it as a pretty format.\n

Denton Liu (8):
  pretty-formats.txt: use generic terms for hash
  revision: make get_revision_mark() return const pointer
  revision: change abbrev_commit_given to abbrev_commit_explicit
  pretty.c: inline initalize format_context
  pretty.c: extract functionality to repo_format_commit_generic()
  reflog-walk.c: don't print last newline with oneline
  pretty: implement 'summary' format
  SubmittingPatches: use `--pretty=summary`

 Documentation/SubmittingPatches    |  6 +++
 Documentation/pretty-formats.txt   | 25 ++++++----
 Documentation/pretty-options.txt   |  2 +-
 Documentation/rev-list-options.txt |  2 +-
 builtin/log.c                      | 30 ++++++++++--
 log-tree.c                         | 15 ++++--
 pretty.c                           | 74 +++++++++++++++++++++++++-----
 pretty.h                           |  1 +
 reflog-walk.c                      |  6 ++-
 revision.c                         |  7 +--
 revision.h                         |  6 +--
 t/t4205-log-pretty-formats.sh      | 52 +++++++++++++++++++++
 12 files changed, 188 insertions(+), 38 deletions(-)

-- 
2.24.0.rc2.262.g2d07a97ef5

