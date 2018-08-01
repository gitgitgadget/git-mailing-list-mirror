Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 847B31F597
	for <e@80x24.org>; Wed,  1 Aug 2018 19:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387414AbeHAVVh (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Aug 2018 17:21:37 -0400
Received: from mail-oi0-f73.google.com ([209.85.218.73]:36540 "EHLO
        mail-oi0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387396AbeHAVVh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Aug 2018 17:21:37 -0400
Received: by mail-oi0-f73.google.com with SMTP id c18-v6so17802121oiy.3
        for <git@vger.kernel.org>; Wed, 01 Aug 2018 12:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=+SaPqGiGRd6RBbMh2cP3Bh+xn0aynJmIZ7KhY0PugOQ=;
        b=JiSf/YP4zaneGko5eZvTXfljKGzV9jtl4PMy59LcRUWNGPlthQma6UnAfOFWOZFi55
         z8GMBRewL7nf6cae1k8rpllJbvI6wJ078cBtIqFVUV09PJlRpR74oK4rh+fto/vMpjUw
         5R+LHMzRapAerKmQSfTcG/nV+iVldc1BM7AFzlgynYC++WPhdM2d4gIHfPOci9XY0mhy
         mKPgNaRSYFsHWkZBLbN9KtEO2+QW0usDPsk6DrTMJNBlAiEgkIs6U9zgYe1RSuhDrVwT
         +rtLBWjumcW5ypLNSjN1ozgXvStCKQImbyYhcSZcdUCc57v2Xr4bF9HgbxR4tYwgdaYI
         qPGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=+SaPqGiGRd6RBbMh2cP3Bh+xn0aynJmIZ7KhY0PugOQ=;
        b=OyBzm2HBRolC8S89ECGVLmYGOBbD7MHktqtV3YAjEkT+KJe1iA2Utn8bvUqgc0yFmB
         QOWH05vUx5XoQ7S/BVPVG1ypT4ziiFiwGvYkcZVG+Qc4TK9PDzuLwgD5qBnY0Nh/KPg+
         mNI75mmMPXVosF46eaXciBuMHieHMJzTULwZ84uzGPTP6esCF/7z1edFiG7A5R5iJEeT
         D1qr/YkuCG7OPhojRWPQHhruQIHRe9S0Ela02q0xt9OaU+t/tg1C+9RTYRqpWeJqojme
         eoGQfGINs9/YnFWJUb6ucNBr26VevcsC4o74nKrZYL3U5k9mRGiXduZQiUm+MSGjxo2Z
         Rjuw==
X-Gm-Message-State: AOUpUlGYBMJ3FLWv2BzwZFOe7SnzRzn0TBxv1Pv5SYK4cMtxduI/3WcA
        PINOauGGRlB3oJmdJOmx5l8tSTC9b1hJ
X-Google-Smtp-Source: AAOMgpePlhA5svOlsmIfoU3SWrN5y9+an5iAeF/wwXL8MyCO7fxq4SvjlIuA5Qz26bqkOSczlOXxXFBGMmIh
MIME-Version: 1.0
X-Received: by 2002:aca:c0c2:: with SMTP id q185-v6mr1950612oif.43.1533152058838;
 Wed, 01 Aug 2018 12:34:18 -0700 (PDT)
Date:   Wed,  1 Aug 2018 12:34:10 -0700
In-Reply-To: <xmqq7elbe8po.fsf@gitster-ct.c.googlers.com>
Message-Id: <20180801193413.146994-1-sbeller@google.com>
References: <xmqq7elbe8po.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.18.0.132.g195c49a2227
Subject: [PATCH 0/3] sb/config-write-fix done without robbing Peter
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     bmwill@google.com, git@vger.kernel.org, johannes.schindelin@gmx.de,
        peff@google.com, sbeller@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Am I correct to understand that this patch is a "FIX" for breakage
> introduced by that commit?  The phrasing is not helping me to pick
> a good base to queue these patches on.

Please pick 4f4d0b42bae (Merge branch 'js/empty-config-section-fix', 2018-05-08)
as the base of this new series (am needs -3 to apply), although I developed this
series on origin/master.

> Even though I hate to rob Peter to pay Paul (or vice versa)

Yeah me, too. Here is a proper fix (i.e. only pay Paul, without the robbery),
and a documentation of the second bug that we discovered.

The first patch stands as is unchanged, and the second and third patch
are different enough that range-diff doesn't want to show a diff.

Thanks,
Stefan

Stefan Beller (3):
  t1300: document current behavior of setting options
  config: fix case sensitive subsection names on writing
  git-config: document accidental multi-line setting in deprecated
    syntax

 Documentation/git-config.txt | 21 +++++++++
 config.c                     | 12 ++++-
 t/t1300-config.sh            | 87 ++++++++++++++++++++++++++++++++++++
 3 files changed, 119 insertions(+), 1 deletion(-)
