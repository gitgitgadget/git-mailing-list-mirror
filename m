Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 544951F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 13:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733178AbfAPNhW (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 08:37:22 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36015 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730419AbfAPNhV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 08:37:21 -0500
Received: by mail-ed1-f68.google.com with SMTP id f23so5442486edb.3
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 05:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=S9l8PThRNXFwxdyLAe/5CRclpCbaYhwBQrzddfwVmSE=;
        b=A91QFC3qFwx2mMCaVmObRnpPY/Iorhbf2w+dD5oY10I+JGHjUcNL293hGxV3qZPRQZ
         JfqKiXBvSfwkTJe3cdu0+x9Uqqn2I7KMaBjNYxA4PAfvspRFvh0yugOaYRq/TatqP7BE
         1/nqdcJkmhbNtFh7QBwom04ngq2bmZasa6blghT+V0h/pz5frAlrCFAmWlj+hhYGfKT2
         1m63MSpZjN2mF6VZCPROw10YOGhhKA7P3cwvFlKWTU228pbads0CS468wjndWDALB6JE
         +1tWZRDLxusd5pMsKksKt2CMkbo/163MXt42GDS7yEexYppAZCRMv5ralVJcBPzMKwcP
         AlCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=S9l8PThRNXFwxdyLAe/5CRclpCbaYhwBQrzddfwVmSE=;
        b=D6iESKcdaP+xjNhRS+eizLDLGHX1G1k6xsj7GeLlftu81o2N5y7FcX5Giq9yJJFEwu
         neda/Y2EN4nYg4k/IMk/K+mpmLF+U4AtlO0vnaDd2+ZRrXuYM1GjSq07VpcTFG4KVscp
         zLLmVA5D2miAvO8fa2ak70xK1NH+8HV/QE6cbtn7PRLO3cPbCFzxMIUBbIJMQSG9fEJJ
         hszIHYc9z7vsqmdZyaDXNhQD+71ejurCD0NNiVTBvgD1LPvILqVYuXdZSev3yYVmBg87
         4DWWMe7cYwWrhIemqg2v7edqlfGbepPe0am+nBokqhDLX4gIlqcxbsZnem4nWQ0z8rXK
         WuKQ==
X-Gm-Message-State: AJcUukcFGrsFVK/FqzYMEJP8wIlq1thOpFCG3RBmuWTa2T+GdT/rOH+R
        319xxpHRTYERpVKY5pV2cU/FXke7
X-Google-Smtp-Source: ALg8bN62E1l08PzhlT/SqYErANdrmPfmS/z6DRypT3FnSEteDH0kOY+Cy+H2lvI6qRCVzmTIoTGJeA==
X-Received: by 2002:aa7:d9d6:: with SMTP id v22mr7382498eds.265.1547645839884;
        Wed, 16 Jan 2019 05:37:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e51sm5553573edd.35.2019.01.16.05.37.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 05:37:19 -0800 (PST)
Date:   Wed, 16 Jan 2019 05:37:19 -0800 (PST)
X-Google-Original-Date: Wed, 16 Jan 2019 13:37:17 GMT
Message-Id: <pull.109.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] t6042: fix breakage on Windows
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Unfortunately, Travis decided to change some things under the hood that
affect the Windows build. As a consequence, master has not been tested in
quite a while, even if the test runs pretended that it had been tested :-(

So imagine my surprise when master simply would refuse to pass the test
suite cleanly outside Travis, always failing at t6042, despite the fact that
Travis passed.

It turns out that two files are written too quickly in succession, running
into the issue where Git for Windows chooses not to populate the inode and
device numbers in the stat data (this is a noticeable performance
optimization). As a consequence, Git thinks the file is unchanged, and fails
to pick up a modification. And no, we cannot simply undo the performance
optimization, it would make things prohibitively slow in particular in large
worktrees, and it is not like the bug is likely to be hit in reality: for
Git to be fooled into thinking that a file is unchanged, it has to be
written with the same file size, and within a 100ns time bucket (it is
pretty improbable that there is any real-world scenario that would run into 
that, except of course our regression test suite).

This patch works around this issue by forcing Git to recognize the new file
versions as new files (which they really are: the patch simply replaces

git mv <old> <new> && mv <file> <new> && git add <new>`

by

git rm <old> && mv <file> <new> && git add <new>`

which is not shorter, but even a performance improvement (an unnoticeable
one, of course).

Johannes Schindelin (1):
  t6042: work around speed optimization on Windows

 t/t6042-merge-rename-corner-cases.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)


base-commit: 77556354bb7ac50450e3b28999e3576969869068
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-109%2Fdscho%2Ffix-t6042-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-109/dscho/fix-t6042-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/109
-- 
gitgitgadget
