Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA26A20248
	for <e@80x24.org>; Thu, 21 Mar 2019 00:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbfCUAQE (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 20:16:04 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:47202 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbfCUAQE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 20:16:04 -0400
Received: by mail-qt1-f201.google.com with SMTP id z34so4370233qtz.14
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 17:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to;
        bh=kMIMLUDVfH/WAOSx/SNxCeWtg/dlI3JjTkKf31C4K0U=;
        b=umF941aalNHukGqcLu9ZKwz2W3GJAjeHdSWPHUtsFGqnQ9qZfO9Kwdz+uPKHRuYAXf
         I5n6zkrjIrj5gbQgYhDQ4FbqkwPwvDYvnM3Jalul69F5SRQWTbqqalvhc3cxmUKcnuT6
         AzYljnib/RE3bYPjwmMK6W39VKKm84264ANsSlhecKgkwrR61paQewoJXUcmm0W7dRDc
         2lynKoR87Dkkf9/OfqTB78SuHKD2drIlLoiQnRIz1BJMzRQ1E5MBG7Kor4Zp/gUzslWl
         1zFQqu8LWAxyKnDhwc7BypjdU7klbzmyUBTBlT6PSjLCVEtX2kZaYja5NC6l+Mm+fNHX
         8GzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=kMIMLUDVfH/WAOSx/SNxCeWtg/dlI3JjTkKf31C4K0U=;
        b=mOjR/R537NqHukNCXmZh/H+7Wl1Dh92nE86JiMbnYyl3LHerdMrzEBZaVkJPlSf9+4
         QkTeCboPW4dAt/5LZUrbUL8uluGk4owiavnPlA8HZu76kp6hQSlpl0waFBRuREXcpOTe
         sPlcETB74LRXW0QHJGP91Pnr0mZ60FeIg2JQmHUHp2LgQYZ21Lsjs4hw9ujOyxgAm0/X
         cxLNuwZNqIJjJqWd2YIiWRqHurTxLTWoGjQ7hhgWAJM4R2wFFlOftwDWZKiGfCl9kUoA
         6HN0htJ0U0yijN3XEdrIaxcnXgAgmr1e9AXRvP1Ys7gOUJXdHOBMYkX4FYATj6uESnFg
         6xKw==
X-Gm-Message-State: APjAAAUmtnV2HUBgjU6Xq0W5MfDpH/Yei1YsvkJqeLOo2vXq04amRaX3
        5A0VkjF4JUNhBfIQE5hzPl17S3vc/URPn5hbPBthZzF/mIcTY/ikjeY1x8WcUek5CmNCL+5Vzwz
        TMNe45XucOBH6ZugRvQtLrmUlVsd6qzUqVlMuAyYlWHGIOYFvbJcfdCrrO21xEfM=
X-Google-Smtp-Source: APXvYqyySGLcKo+F6Vv+dl42+YGXr33yDscEIoexsqDlO8SZBaSuvoGxzTpZOkN9zw2Gf1z2E9XqAZmS1bw0RA==
X-Received: by 2002:ac8:35ad:: with SMTP id k42mr287404qtb.54.1553127363581;
 Wed, 20 Mar 2019 17:16:03 -0700 (PDT)
Date:   Wed, 20 Mar 2019 17:16:00 -0700
In-Reply-To: <cover.1552519463.git.steadmon@google.com>
Message-Id: <cover.1553126984.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1552519463.git.steadmon@google.com>
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
Subject: [PATCH v2 0/1] Write trace2 output to directories
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org, git@jeffhostetler.com, avarab@gmail.com,
        gitster@pobox.com, peff@peff.net, Johannes.Schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Persistently enabling trace2 output is difficult because it requires
specifying a full filename. This series teaches tr2_dst_get_trace_fd()
to create files underneath a given directory provided as the target of
the GIT_TR2_* envvars.

Changes since V1:

* No longer supports timestamp templates.
* No longer supports filename prefixes.
* Always creates filenames based on the final component of the trace2
  SID.

Josh Steadmon (1):
  trace2: write to directory targets

 Documentation/technical/api-trace2.txt |  5 +++
 t/t0210-trace2-normal.sh               | 15 +++++++
 trace2/tr2_dst.c                       | 61 +++++++++++++++++++++++++-
 3 files changed, 79 insertions(+), 2 deletions(-)

Range-diff against v1:
1:  e6b01ad4bf < -:  ---------- date: make get_time() public
2:  17ec237ba7 < -:  ---------- trace2: randomize/timestamp trace2 targets
-:  ---------- > 1:  59d8c6511b trace2: write to directory targets
-- 
2.21.0.225.g810b269d1ac-goog

