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
	by dcvr.yhbt.net (Postfix) with ESMTP id 960A91F4BD
	for <e@80x24.org>; Thu,  3 Oct 2019 20:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730319AbfJCUtM (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Oct 2019 16:49:12 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41176 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727326AbfJCUtM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Oct 2019 16:49:12 -0400
Received: by mail-wr1-f67.google.com with SMTP id q9so4255991wrm.8
        for <git@vger.kernel.org>; Thu, 03 Oct 2019 13:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=VojsjNWvkzp8vRUTIkTAwPCdKFpCJMpSK5vfPgQhDyY=;
        b=eFms3u2GKNlHVl+TIiR3kMTiiQ2V9HJijV2lNWYynYARei1sV1efYPpfcwRXilfDLF
         +h0i9x3Z/VMb4FkmYzRCfn6NBnyZyhpcHi7jy2eU5tKglYg77vt3QKefEftqr7ATgQCB
         6AHsBaVbKzTyduVFqv3jkdFvvAfFd+ET7YXamditwIvn9mboy3UGa/i+eAsouoQoRrZ6
         V9JvKIb45j2Mat5hFFTuW7E5Kmgki2JbOdTKH0qvx3KQ+4Xt8eyFHNcuN/tcPdNn5Cz4
         wWuh1RFgW+9dth23cq8JSk1S/Sloppo4LVsQLbf0jmM5I78V54FBu3zy7phwm6gB38g2
         Dylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VojsjNWvkzp8vRUTIkTAwPCdKFpCJMpSK5vfPgQhDyY=;
        b=es6UdcBN5VUTOwz6WRQxvRSQfjCvI3gE3srrzjYcot93RAGTnw4YIoF8oD9xX9vQY/
         b+kSUWT5nfsgnzb2DBAC/BloAIgDPlN70Df6DgPEvrpIPUod9+r+6ss/vIe0yM7FaBVO
         pm8fZ9bwobpgjCl9+CV7MAoJH5yqXqGati5xLkzkrYfB9QnLKa74Tp0GoSQdh+oCR+2h
         HttBSB5xnKO2QTZcKC2zi4MSqYDSncLosdPbriRuJ9DWEfmHwa1YN/Zhcdk2wBN8zM3e
         Qdb2Am8xe+g/kvlb6yaYKhL1mbqvXpr6u1b2GVem8v+KecvWldOE7dTxXt1dX92m26Yk
         OHCQ==
X-Gm-Message-State: APjAAAWjMAkXw5dnoVmCkhGsw14ZhTCvcNhMGqPgSnDP7vhM0gCXb7C8
        OET9gRelxjSm4NjmOPdDlDyqVw/t
X-Google-Smtp-Source: APXvYqxCcFN/4N+17weX92zX++9o0NYg3G18kUi4KZekbtIJWjtQctbzPwjr2TgZ61F5FL1Dtw4otQ==
X-Received: by 2002:adf:df91:: with SMTP id z17mr8540197wrl.116.1570135749964;
        Thu, 03 Oct 2019 13:49:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 207sm6098817wme.17.2019.10.03.13.49.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Oct 2019 13:49:09 -0700 (PDT)
Date:   Thu, 03 Oct 2019 13:49:09 -0700 (PDT)
X-Google-Original-Date: Thu, 03 Oct 2019 20:49:07 GMT
Message-Id: <pull.375.git.gitgitgadget@gmail.com>
From:   "Arash via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] gitk: Addressing error running on MacOS with large repos.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Arash <axbannaz@gmail.com>, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

gitk: no need to specify all refs, since git log --all is the same as list
is all the refs/commit ids. Also Mac OS has a limit on size of the list of
params for a command line

Arash Bannazadeh-Mahani (1):
  gitk: Addressing error running on MacOS with large repos.

 gitk-git/gitk | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)


base-commit: bc12974a897308fd3254cf0cc90319078fe45eea
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-375%2Faxbannaz%2Fuse.all-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-375/axbannaz/use.all-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/375
-- 
gitgitgadget
