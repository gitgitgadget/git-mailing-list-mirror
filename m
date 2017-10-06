Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62B9320372
	for <e@80x24.org>; Fri,  6 Oct 2017 20:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752676AbdJFUMg (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 16:12:36 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:45546 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751484AbdJFUMd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 16:12:33 -0400
Received: by mail-wm0-f66.google.com with SMTP id q124so9666630wmb.0
        for <git@vger.kernel.org>; Fri, 06 Oct 2017 13:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dSWHzwI02HbQ0za2jmrCxGNYLUqNGynMg3UJJ0QTVgw=;
        b=hmcjA6vyDTZHbHlJuNzI3d7xV5X+VyBsOsF/I/C4B6a/H+zGB32PbpYio3fwPCka8j
         BosGQa9C8O9ucEg6tFnJwTtY4vkhkW+5Px5w0ODYNXDapo3t2yRB12mzrD5UzSY+BBcF
         GctYDOgVi2TaR73PPEurjY5p3jAjz0FnpblFGcm8mewclYWa6ArOEe5FYNk6QqTmaTJh
         4mPfmUpKKQiaOsT+u6Pc98vnDPPRKxGrJLyp8asxaR18bIKfT+QoKNsvzot9R77PLoCr
         2y2c3qoickjn2DKUysp02CrsFl+OSi8G7HFHqu7gZXlFgFz06pJd0VpUfodax/J8h4oZ
         /HCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dSWHzwI02HbQ0za2jmrCxGNYLUqNGynMg3UJJ0QTVgw=;
        b=bKlk9KYfSbUMq+QZkuzIKQL63H4ihKfNFNFzrK3Nw5/5GyAxXue163TTs5i3oDQV70
         466QCE4CNomlO0zYNy1X83bMBaR/luYoZIlSkrRqfdPNClunCleihf1Bouta9Vw0Xqsl
         sz9rvn7R+RlWgUiC2UxqGrqZtJ7tZzM/egp3FAY4P+KWxjCDigYz10lNm0gg/fmj7JVk
         9g/cl+Px6wzteQBPgOPvrinxrFB4nyt7iWwPsvwymXYjoc5qpxXd3wQ8ybfq4Y4L1qlq
         MKwYle4Pr27t1RjBcalzJuoeOr55eppa6EE7YbjoXRT71u5tJ2/Cav4VOYSwRGGxELq8
         nDHA==
X-Gm-Message-State: AMCzsaWXrvJcWpl1Li+A+e1EmGOhe+q2nEd4W2tUdviU2sPyZOFCEMN3
        LcuNMNA8QXpXBbTWluVv7GOOwhOfc00=
X-Google-Smtp-Source: AOwi7QChHxSn4HorzrfP2HnpucEicaxXp1DAemo94ggTpZpUCj2GZG4t0jaSjQJBeQNLb9zHjJxNZA==
X-Received: by 10.28.55.2 with SMTP id e2mr2826707wma.60.1507320752149;
        Fri, 06 Oct 2017 13:12:32 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id h45sm2906522wrf.36.2017.10.06.13.12.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Oct 2017 13:12:30 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
        Paul Tan <pyokagan@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 00/12] Re: various lockfile-leaks and -fixes
Date:   Fri,  6 Oct 2017 22:12:02 +0200
Message-Id: <cover.1507320376.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.15.0.rc0
In-Reply-To: <CAN0heSqr77dptPG2mixnLdNKKcgD36aPnEFtnTB6Oyip6WfQBA@mail.gmail.com>
References: <CAN0heSqr77dptPG2mixnLdNKKcgD36aPnEFtnTB6Oyip6WfQBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6 October 2017 at 21:44, Martin Ågren <martin.agren@gmail.com> wrote:
> Ok, thanks. I've got a rerolled series running through the final checks
> right now. I did end up making this log message a bit more succinct.

This is v3 of this series. All patches are identical to
ma/lockfile-fixes in Junio's tree, except 10 and 11.

Martin Ågren (12):
  sha1_file: do not leak `lock_file`
  treewide: prefer lockfiles on the stack
  lockfile: fix documentation on `close_lock_file_gently()`
  tempfile: fix documentation on `delete_tempfile()`
  checkout-index: simplify locking logic
  cache-tree: simplify locking logic
  apply: move lockfile into `apply_state`
  apply: remove `newfd` from `struct apply_state`
  cache.h: document `write_locked_index()`
  read-cache: drop explicit `CLOSE_LOCK`-flag
  read-cache: leave lock in right state in `write_locked_index()`
  read_cache: roll back lock in `update_index_if_able()`

 apply.c                  | 25 ++++++++-----------------
 apply.h                  |  8 +++-----
 builtin/am.c             | 27 ++++++++++++---------------
 builtin/apply.c          |  4 +---
 builtin/checkout-index.c |  8 +++-----
 builtin/checkout.c       | 14 ++++++--------
 builtin/clone.c          |  7 +++----
 builtin/commit.c         | 10 +++++-----
 builtin/diff.c           |  7 +++----
 builtin/difftool.c       |  1 -
 cache-tree.c             | 12 ++++--------
 cache.h                  | 25 ++++++++++++++++++++++++-
 config.c                 | 17 ++++++++---------
 lockfile.h               |  4 ++--
 merge-recursive.c        |  6 +++---
 merge.c                  |  8 +++-----
 read-cache.c             | 31 +++++++++++++++++--------------
 sequencer.c              |  1 -
 sha1_file.c              | 19 ++++++++-----------
 tempfile.h               |  8 ++++----
 wt-status.c              |  8 ++++----
 21 files changed, 121 insertions(+), 129 deletions(-)

-- 
2.15.0.rc0

