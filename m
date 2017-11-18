Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4793C201C8
	for <e@80x24.org>; Sat, 18 Nov 2017 17:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424347AbdKRR1u (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Nov 2017 12:27:50 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:40279 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424344AbdKRR1t (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Nov 2017 12:27:49 -0500
Received: by mail-pf0-f196.google.com with SMTP id u70so4224732pfa.7
        for <git@vger.kernel.org>; Sat, 18 Nov 2017 09:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MgMgFh4qy9iQMPfTLAwOSu+pfWwlexlTO8Pdfg7KA6k=;
        b=YCNAdlns6we+liE5c2uHXghNFg+kTC3Db3X4yMXvTbSO/2EWEj+25Hw5/eMET/dHCj
         iKv11RCYBRLK5CRiiLF8r2SOhmx5XyZU/lohdUPjfphY6Bcx3mFh5GfSFbpyomIER118
         wXN6zUH7yB0HcAHoZXNcbxEe+dOcXkNqrhGqLp92UppLmyfwy7sCHLwqEsuE4MmAM78L
         9u02vC3R+CD1ang2fUEN0qLbygmSvpNxZXyJ4Y5RXgG11MC91bBKn97w9r1xiqVgwGRo
         Z395uxhOhRTmd+R9WHf9RckWZFXb5/lO9cqm+Xn4wCgQrbq0BHdF1iqr/ueIcmhdzscP
         F9Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MgMgFh4qy9iQMPfTLAwOSu+pfWwlexlTO8Pdfg7KA6k=;
        b=T9HcX3D+p6wUVC2/SUFuxN7yAA+vT93tKV5QbPNRgPBtB/eLQ/5CteSoJsND45s7m+
         QqACIPHy1x6PSHnuIL9AxloLi5tVuKmeglgBpgRRBB40oMG8PtM9yC2tC0JlylfqmxQm
         oKVA1LyHR+JXkAoL3NzYxw0OQp8VStt1JtDd1yJr+YOtrDS+Uq0E4BwOgjCIrZpDqUlb
         wovyd2t/BCgQ7628LgKKtazDh9E+32hYcnG/GS0rJJTQWgfr395rJcxGxFgftZTT9pDo
         RrIR+v0EGv1oJUT7gLRsbAjh7gxXlpGOTK1YSY+7cqRnIwddgKKWACjz4pJ+nW3iGmQl
         jV8A==
X-Gm-Message-State: AJaThX5jqcXBoUitZQqMIqL49wqIPCJeLpbKF+5LCPmHqvn9fgKBirVi
        0BEyCM1zTFjeDCtLLsAh60ASgewH
X-Google-Smtp-Source: AGs4zMYu2OefJGrV01FJf1KlRouC7C68JNeXwITEtjEFj8rTAc6Z9F6UhMRDufiUNUPIn4Vq8ZiYLQ==
X-Received: by 10.159.241.1 with SMTP id q1mr9009383plr.383.1511026068280;
        Sat, 18 Nov 2017 09:27:48 -0800 (PST)
Received: from localhost.localdomain ([2405:204:72c0:fc36:f2a4:a5ab:70fc:f807])
        by smtp.gmail.com with ESMTPSA id d12sm10479749pgt.16.2017.11.18.09.27.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Nov 2017 09:27:47 -0800 (PST)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Git mailing list <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 0/4] cleanups surrounding branch
Date:   Sat, 18 Nov 2017 22:56:44 +0530
Message-Id: <20171118172648.17918-1-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.15.0.291.g0d8980c5d
In-Reply-To: <20171102065407.25404-1-kaartic.sivaraam@gmail.com>
References: <20171102065407.25404-1-kaartic.sivaraam@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On the process of making 'git' give more useful error messages
when trying to rename a branch[0], I found a few things that could
be cleaned up. After noticing that the cleanup commits exceeded
the commits that are related to the series, I thought it would
be better to separate the cleanups into an independent series
to keep that topic focused on improving the error messages.

1/4 and 2/4 were part of that series until v3. The others are new
cleanups.

This series goes on top of 'master' and can be found in my fork
as branch 'work/branch-cleanups'[1].

Note: 1/4 might possibly have some conflicts with jc/branch-name-sanity

Footnotes:

[0]: cf. <20171102065407.25404-1-kaartic.sivaraam@gmail.com>

[1]: https://github.com/sivaraam/git/tree/work/branch-cleanups


Kaartic Sivaraam (4):
  branch: improve documentation and naming of create_branch() parameters
  branch: group related arguments of create_branch()
  branch: update warning message shown when copying a misnamed branch
  builtin/branch: strip refs/heads/ using skip_prefix

 branch.c           |  4 ++--
 branch.h           | 10 ++++++++--
 builtin/branch.c   | 20 +++++++++++++-------
 builtin/checkout.c |  2 +-
 4 files changed, 24 insertions(+), 12 deletions(-)

-- 
2.15.0.291.g0d8980c5d

