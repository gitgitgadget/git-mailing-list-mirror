Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 983C620370
	for <e@80x24.org>; Thu,  5 Oct 2017 20:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751446AbdJEUcc (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 16:32:32 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33706 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751407AbdJEUcb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 16:32:31 -0400
Received: by mail-wr0-f195.google.com with SMTP id z96so8944124wrb.0
        for <git@vger.kernel.org>; Thu, 05 Oct 2017 13:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SFcAUJvgahn21LlJupMRLH0t+dS6r+d8h9INQxPGWXc=;
        b=sJHspDCYVx9LNqTXmFG6Tz6KWwEaFWimPPubH+7J4xGBzG5ubghvu+cDXL4CmjGg02
         JLPDclPgvuKD6R7Nkw+9mLmOJI4qze/oCE5Gy43s1vDu/jk65a6lR/ovL8Ymio/x8n+b
         DLJpr1w19JVKSmfh5JRyGo0EcYLgY47oWtcBDzGz6D8AwATeOgmLGCuAD2WxJXxuwM6S
         WSAazlDSTVNWQd+qEaGzogqwHRYdgwDBNo+5SjycpNiWji8riNaqJlOohk1bzUJwpxur
         VwwOc+RP2q1xx8tbSjM0C9Gp8fyQ0oYBdpwD4WMDGFBXaBpLqnpHECXhLlMiGYURaKF0
         DoBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SFcAUJvgahn21LlJupMRLH0t+dS6r+d8h9INQxPGWXc=;
        b=jpko3Ug7AesFpjQ8jUL3tLwBHDNoO7Mzykw/k+KEEi0jElz7Mp5wgk8e50TA8XZkVW
         JuC7bWcbyUTX57MkWR3vygYqD9DM0b2L2uELe5cTOdjv/rSUmptJ5FanAaYlB1NuO2O5
         YxpAYeOmyeLOmK70YQmIR+/zSnRwlO4Q64dARS1yt0nLNc3JHwz44FENrqVcXltVdMkl
         tvxJ3qrbT0dVuhDCYqrOvaSHhYnFHqcSVpYHOVy2a40g5yu5K7t8bWyGspUmDT0M3yxq
         z+EmmxRNLIcSJXqR8nkvbFR1orVWdZLWCs5nLHCB4nMvuf9EwGuW0T/o5Hd333O1i2wr
         DkLw==
X-Gm-Message-State: AMCzsaUZEU4YTclcFP1pQqjIRbEhrWefamw04Ai58rmcuuDqRSDsd/PF
        w2xf37kqOrpOmbmJfQNWPnABGdB7B/w=
X-Google-Smtp-Source: AOwi7QDznhYvv/hwgV2yxzAKFyXySE07hkQP0DdxUsc3I7r1gmK4XL5yr2sZkNWUT7fykqRs//wWhw==
X-Received: by 10.223.179.18 with SMTP id j18mr12299266wrd.262.1507235549897;
        Thu, 05 Oct 2017 13:32:29 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id i76sm698424wmd.2.2017.10.05.13.32.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Oct 2017 13:32:28 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
        Paul Tan <pyokagan@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 00/12] Re: various lockfile-leaks and -fixes
Date:   Thu,  5 Oct 2017 22:32:02 +0200
Message-Id: <cover.1507228170.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.2.666.gea220ee40
In-Reply-To: <xmqqy3osiwe6.fsf@gitster.mtv.corp.google.com>
References: <xmqqy3osiwe6.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3 October 2017 at 08:21, Junio C Hamano <gitster@pobox.com> wrote:
> Martin Ågren <martin.agren@gmail.com> writes:
>> On 2 October 2017 at 08:30, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Thanks both of you for your comments. Based on them, I have made the
>> following notes:
>> ...
>> Especially 9-11 make me feel like wanting to re-roll this, for future
>> readers if nothing else. I expect to be able to do so in the middle of
>> this week (I don't know how this interferes with Junio's definition of
>> "soonish").
>
> OK, then I'll hold off and expect such a reroll.

Here it is. Several patches are unchanged (fetched from Junio's tree and
reposted). There are two new patches (5, 12) to address some similar or
related issues noticed by Peff and Junio.

I think this got better by getting rid of `CLOSE_LOCK` entirely instead
of playing with `HAS_SINGLE_BIT()`. Patch 11 also improved IMHO by
squashing patches 10-11 of v1 and presenting the issues a bit
differently in the commit message. Thanks for your feedback, both of
you.

Martin

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
 read-cache.c             | 28 ++++++++++++++--------------
 sequencer.c              |  1 -
 sha1_file.c              | 19 ++++++++-----------
 tempfile.h               |  8 ++++----
 wt-status.c              |  8 ++++----
 21 files changed, 118 insertions(+), 129 deletions(-)

-- 
2.14.2.666.gea220ee40

