Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88FB9211B4
	for <e@80x24.org>; Sun,  6 Jan 2019 00:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfAFA03 (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Jan 2019 19:26:29 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33612 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbfAFA03 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Jan 2019 19:26:29 -0500
Received: by mail-pl1-f195.google.com with SMTP id z23so19119465plo.0
        for <git@vger.kernel.org>; Sat, 05 Jan 2019 16:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3fy2CpAC5z+cQL3I2385dlC2wqncLfghP0tGT57ZDAg=;
        b=q9Rf+/DOUj0bG+QT9whmDY8TGnwy7rZiozeN5rmt4rnDvHIR5QcEJm8sY9eKKAEZph
         lu2J1opW7qrAj9g7XUw273GUKxj9VZy/tMQBJQczL9M8P0VebLFdnaem0kkGQnYvIWBI
         VhW1ArlSxzF5UrXwmhSt9iqhaHiaxayhEbkr+mRt/iRQA85dLNvjNgM3uLpgRvX1Mzi3
         BpTzcXzSgj/ZF4M1c0mbVfOuMp5O4j29Oq3XzWcO5SPKuhoVUor8aGXUEl3xMs5KQppM
         JfR4MjIhO9ctbEYVXWPPlhrEcJfG8/eBKTqBguzA1t2VLXt0eoREUOOAdhx18PxxwVSK
         M1vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3fy2CpAC5z+cQL3I2385dlC2wqncLfghP0tGT57ZDAg=;
        b=HdEnFMXaR/1YIgM4FbWtrpfShY5Gj3XfwVpybUHPT6+YDGas6FsriynJVnVgypoosw
         3edATirrmA+pYjzQXUuhp3X9C3v/0AQKm2ODgLrxT42N80ycyGX3MsKC9YowCJdIRhfm
         t5++pLL4A+BMio7vKmyTFNXfe5kEemRKkRLWYPCZ12vxflgWzQhn8uT6knbDGb0tokDL
         PuSEyEcc4wJ8F7qbEMPSTg3t+TvVGPXtk9VsogM1yNSAH+6FF1xi8KYH+ffi9PRuIKUm
         Bfby0x/kLraknmo84JzlE+xYNchE47YpkaqFVg/zNHS9yFM/knFUKHGlQesQcejwHiyQ
         pfag==
X-Gm-Message-State: AJcUukc7BjjaclX2CSXLQE4o+PdovVX+b2l5P6ThV6LR4HYZHARRBTU6
        5HqbuPWUNITftkT6x28dZvsgo5SS
X-Google-Smtp-Source: ALg8bN7lRLn6vyB1NdSGsirFMDpiCCBNRbhh9l1wGGWOI8HYoi1EeRH4CoJtU2ABSM0evfxaTsFB7A==
X-Received: by 2002:a17:902:7481:: with SMTP id h1mr56877949pll.341.1546734388100;
        Sat, 05 Jan 2019 16:26:28 -0800 (PST)
Received: from localhost.localdomain (cpe-23-241-199-231.socal.res.rr.com. [23.241.199.231])
        by smtp.gmail.com with ESMTPSA id e16sm85376485pfn.46.2019.01.05.16.26.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 05 Jan 2019 16:26:27 -0800 (PST)
From:   nbelakovski@gmail.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, rafa.almas@gmail.com, gitster@pobox.com,
        avarab@gmail.com, Nickolai Belakovski <nbelakovski@gmail.com>
Subject: [PATCH v5 0/3]
Date:   Sat,  5 Jan 2019 16:26:16 -0800
Message-Id: <20190106002619.54741-1-nbelakovski@gmail.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nickolai Belakovski <nbelakovski@gmail.com>

Replying to my original email to try to clean up the email chain

> Thanks for keeping with this.  I think we're getting quite close

Thanks to you as well for continuing to review the change set and provide feedback!
It does feel rather close, I'm getting exciting about following it through, even if
we just end up merging the worktreepath commit and not the ones to modify the branch
output, since I can always just make a local alias that uses the worktreepath atom.

The last set of changes all made sense, very non-controversial, so I've simply implemented
them. Beyond that, I moved where the structures for the ref<->worktree map are defined now
that they're no longer associated with used_atom. They still feel a little awkwardly
placed to me; I couldn't quite find a way I liked of arranging them together while also
sticking to the style in the rest of the code but I think it's a little better that
all of the relevant structs and the cmpfnc are all in the same place.

Travis-CI results: https://travis-ci.org/nbelakovski/git/builds/475825245

Nickolai Belakovski (3):
  ref-filter: add worktreepath atom
  branch: Mark and color a branch differently if it is checked out in a
    linked worktree
  branch: Add an extra verbose output displaying worktree path for refs
    checked out in a linked worktree

 Documentation/git-branch.txt       | 20 ++++++-----
 Documentation/git-for-each-ref.txt |  5 +++
 builtin/branch.c                   | 16 ++++++---
 ref-filter.c                       | 71 ++++++++++++++++++++++++++++++++++++++
 t/t3200-branch.sh                  |  8 ++---
 t/t3203-branch-output.sh           | 21 +++++++++++
 t/t6302-for-each-ref-filter.sh     | 15 ++++++++
 7 files changed, 140 insertions(+), 16 deletions(-)

-- 
2.14.2

