Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20B991F453
	for <e@80x24.org>; Fri,  1 Feb 2019 22:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfBAWE2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 17:04:28 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34270 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfBAWE2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 17:04:28 -0500
Received: by mail-pf1-f193.google.com with SMTP id h3so3894015pfg.1
        for <git@vger.kernel.org>; Fri, 01 Feb 2019 14:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=QCo0NGkKWhHXU4ZyIzASsLNLbbbMegHz/hkhhyljAyQ=;
        b=JzwnMagIk+jaKgr3s3b+pHdRXp0OpBl5qN+i4mNExgSmi1YHAnxRamSAAr0nr48kmm
         /I3i/KtlU/EB+1DYwEyuVGqjp4vQnr5qz5zyydGwmsLMOaee2KGGmyxbRz/mhqoiDpcM
         /wgxzXrc7mGvg+l9u/K1XnCcEVN0bCcxVuYOiQsIdIHbAnFMMJyrWCOC7v60HvuEASBi
         Ih4y7GBCfnjqZfYlRO3AotbdnL4bIHSySHMbgt+lu0fi77BUtlv9yrKBhjNIpauSWa04
         2b+qNBCYGl9noXcojVHkJhMzAQC0n8VoJ308+fAnCh4motvXIm2lz4HJgpsiOXRYoJq5
         oH7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=QCo0NGkKWhHXU4ZyIzASsLNLbbbMegHz/hkhhyljAyQ=;
        b=qbtHEqfIP+d6O7anigLSdVq2AGYWlQ7QTzpZGyM3MOBd7QBty2ZL1oarPOxV/cbeVc
         2920OOyGSuz248ypyUhlrHd1V0/GuOfFbX1CUMa+ri54efRJKqhY9SI2PlTfDs0MbRY5
         u4z5QKK3U77XdfH+0Xd11rgq6emldVjSPKg0YJ2cVb+wet28lMppUnx18fuqN1SpopIq
         0eC3e20OGTRn5/0Y7kWCnlKBG1vov++O74MqWdeDdi5Z4GCAKteGrZ74kYnbIN1+8A0T
         xZIKFcGDoe2p5Y55jsMl9tZS7GbNBiDthKBWLZNsM9Vp127JnWcGOtJSEpSkOVNBAIQB
         rtMg==
X-Gm-Message-State: AJcUukdbQ9T1wB1/1VXqs1/UwswZ3GILHvdwGpBLZtvLiQoy4O0a7cv2
        TalJSm6NuWF+KyLfwrXh7iQw1gpr450=
X-Google-Smtp-Source: ALg8bN50CqWCOB5BuJ488S/9Vv9F4dDRfTUc1Srkm9N6ked+2GjdoxCc0NniCfVrpKoshDIn546tRA==
X-Received: by 2002:a63:7e1a:: with SMTP id z26mr36387868pgc.216.1549058667338;
        Fri, 01 Feb 2019 14:04:27 -0800 (PST)
Received: from localhost.localdomain (cpe-23-241-199-231.socal.res.rr.com. [23.241.199.231])
        by smtp.gmail.com with ESMTPSA id h128sm12131281pgc.15.2019.02.01.14.04.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 01 Feb 2019 14:04:26 -0800 (PST)
From:   nbelakovski@gmail.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, rafa.almas@gmail.com, gitster@pobox.com,
        avarab@gmail.com, Nickolai Belakovski <nbelakovski@gmail.com>
Subject: [PATCH v7 0/3]
Date:   Fri,  1 Feb 2019 14:04:17 -0800
Message-Id: <20190201220420.36216-1-nbelakovski@gmail.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <"<CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>">
References: <"<CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>">
In-Reply-To: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nickolai Belakovski <nbelakovski@gmail.com>


Moved initialization of ref_to_worktree_map outside of atom parser. Other minor fixes.

Put the hashmap and the worktree struct in the same struct, to make it more obvious that
they are to be initialized and free'd together.

Travis CI results: https://travis-ci.org/nbelakovski/git/builds/487642061

Nickolai Belakovski (3):
  ref-filter: add worktreepath atom
  branch: Mark and color a branch differently if it is checked out in a
    linked worktree
  branch: Add an extra verbose output displaying worktree path for refs
    checked out in a linked worktree

 Documentation/git-branch.txt       | 21 +++++-----
 Documentation/git-for-each-ref.txt |  5 +++
 builtin/branch.c                   | 16 ++++++--
 ref-filter.c                       | 78 ++++++++++++++++++++++++++++++++++++++
 t/t3200-branch.sh                  |  8 ++--
 t/t3203-branch-output.sh           | 21 ++++++++++
 t/t6302-for-each-ref-filter.sh     | 15 ++++++++
 7 files changed, 147 insertions(+), 17 deletions(-)

-- 
2.14.2

