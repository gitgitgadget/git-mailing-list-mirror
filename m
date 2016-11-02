Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0C0420193
	for <e@80x24.org>; Wed,  2 Nov 2016 17:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756581AbcKBR3a (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Nov 2016 13:29:30 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33874 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756572AbcKBR33 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2016 13:29:29 -0400
Received: by mail-pf0-f180.google.com with SMTP id n85so15360571pfi.1
        for <git@vger.kernel.org>; Wed, 02 Nov 2016 10:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+yG8swFZxC5ZbghEWyYUFBR70/1G8IXGf+UN9G/DPww=;
        b=WLXYgajf1XWhm+Ja2huyklLIxA4BNb0mRUIW1qnf8IjFP8jeWQW5tP1Nd1qkUYMKdx
         W6FBz7IMLgWw0X090cMl+pIQULUjkoVNgHjjN5/gk6PF4YJEz2LPX0vfDE5jF1Qbn8MM
         8iJr/bnzL8Dcrhhbjv3EW9wAy1sEOF05wX/Nb68NQW2xZJSxLx9pP/ZyrHRuDygb44WS
         g1VsUTtcAh3Kwh1wDBHOMNBFzPa0jMCH5wuUaITB50oQvqTRezc1+Ev7cvy/9lEFPeK1
         TWUcSOUsukeus12b9FFjPiRj6wPgkbs1LPgoU3MnbAfRZSqMTC+a6AmF8Z3zthZNx1zT
         6iqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+yG8swFZxC5ZbghEWyYUFBR70/1G8IXGf+UN9G/DPww=;
        b=mwCvYSwAHsYyk1LTdln1hh+t5GYyZ9Dnxl1LUic6C2pe8MoOvz4xR4IFSHQFub9zcd
         XIKmyGPzYlX3zVF4Nv8YoADHsCuM1sa66/BdwXSMNLLxVwXOnQuG1V/+kFQuEjtxiojx
         Opt3BFcxoywrGx4DhVEgFsi0VtWM/nlOSLs9Wv/UILpDqQ2jdIjFZgfdRXEz3e4mqpgQ
         4Jl7fQhDZ++7Ap0v2FwAoYdwqjIUqjTOqVdRNslhaczmLFs71WCYm7NdjTNuJjvInfws
         3FniYggNv36ATV1DQeCNQhPU71x+/8SPguXN3JTzVt961HBieYgDdG8bsqVCadyAMNyf
         DKQg==
X-Gm-Message-State: ABUngvfUfd/9K7T5sgJGgKVIMN/vHKiaqBC6h9xBD9q1noGZt5iStLIlyrMVLhZkPU/IbmNo
X-Received: by 10.98.107.136 with SMTP id g130mr8918073pfc.20.1478107768875;
        Wed, 02 Nov 2016 10:29:28 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id f23sm6185167pff.59.2016.11.02.10.29.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Nov 2016 10:29:27 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Subject: [PATCH v3 0/5] Make other git commands use trailer layout
Date:   Wed,  2 Nov 2016 10:29:15 -0700
Message-Id: <cover.1478107666.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <cover.1477698917.git.jonathantanmy@google.com>
References: <cover.1477698917.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the same as v2 except that in 1/5, the comment about
find_separators has been moved from the commit message to the code
itself. Also, a trailing whitespace and unused variable fix.

Jonathan Tan (5):
  trailer: be stricter in parsing separators
  commit: make ignore_non_trailer take buf/len
  trailer: avoid unnecessary splitting on lines
  trailer: have function to describe trailer layout
  sequencer: use trailer's trailer layout

 builtin/commit.c         |   2 +-
 commit.c                 |  22 ++--
 commit.h                 |   2 +-
 sequencer.c              |  75 +++---------
 t/t3511-cherry-pick-x.sh |  16 ++-
 t/t4014-format-patch.sh  |  37 +++++-
 t/t7501-commit.sh        |  36 ++++++
 trailer.c                | 299 +++++++++++++++++++++++++++++------------------
 trailer.h                |  25 ++++
 9 files changed, 316 insertions(+), 198 deletions(-)

-- 
2.8.0.rc3.226.g39d4020

