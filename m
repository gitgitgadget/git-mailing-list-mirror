Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC2761F453
	for <e@80x24.org>; Mon, 15 Oct 2018 09:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbeJORbf (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 13:31:35 -0400
Received: from mail-pf1-f177.google.com ([209.85.210.177]:44804 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbeJORbf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 13:31:35 -0400
Received: by mail-pf1-f177.google.com with SMTP id r9-v6so9394781pff.11
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 02:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=HD58Be0YbZ0YKOVVfLQHGlHd2XLp39ICXPv1vHt9TnE=;
        b=dajhXqQz8gXInZwVqtlQ9BtQkk1i8S9zYas7Xw7Nb2pUy4xTs6by3ThffSTzm85YPv
         nGl7y/Kd2SxlE+tMCOKFY9h7/erVIHY2gZleujFpl8PJH56imX/0mUqcs8etKWBao+G1
         8iTCLIfsRi3dKYPWJMucb1tokQ54qVQ5kOX7z/RnoG34MtNbtWcv3kIOVMffqpKnhfQR
         hmpqjVI7KwMWa4GT3gFVQ37jEuMQ+8CfTeWIvkjW4bDnjJPP0/PLCGsW2moI96DxRC+B
         /r3tlO01ru/fQcolKUdMEKzzBzTFlcdycc90zcVNq65XvxrrTfay9sgJGljhq17UZfEu
         hzCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HD58Be0YbZ0YKOVVfLQHGlHd2XLp39ICXPv1vHt9TnE=;
        b=P4qCAvD1wqb+46CBrhbbPY6yic+cOCH2PuoDyccWV0GeNKHLS+fkG8P1BksN8fuBm5
         oQVYjthWmgAkcPB1gFP8LmDO+79GYv/yzecgHzqGKEroecEZU/K99qHlDAsqkxKDjyae
         VQq098sQ1xZA1fHrEWAKa2gdHjGZagR6Z5ZNmrjBDl12naE5sca19m3dK2bJqrITzqgK
         Wkj9/sJcd9APpuOuKhQc73buXHMXnIJrqUPCUg8YpfqXyiFJ+mi1s9CGzxvX0XxQY9GB
         e9QmB8zMmOEjHFt3tss4KlLBGDCvJVv0Xy1fjCJYfOOulkRCVRliO8QvgsBwqNRy2C/O
         9zRw==
X-Gm-Message-State: ABuFfojBp6tdE+JyUtYb/bR8bP9CMcmW3mfLz3gqPWi7spkrgWuFEtgF
        /ZeyNcWgXKYknkE+hy9QHB2tGZOw
X-Google-Smtp-Source: ACcGV62DnIxKqfZoENEXy6ane/XpIAySSk7DCav2/Pp5g0U8/OFXSFpH/tJgouSV7CiC88VlUZCiXg==
X-Received: by 2002:a62:f553:: with SMTP id n80-v6mr16790669pfh.59.1539596824689;
        Mon, 15 Oct 2018 02:47:04 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id 76-v6sm16216744pfk.134.2018.10.15.02.47.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 02:47:03 -0700 (PDT)
Date:   Mon, 15 Oct 2018 02:47:03 -0700 (PDT)
X-Google-Original-Date: Mon, 15 Oct 2018 09:46:58 GMT
Message-Id: <pull.45.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/3] Provide a useful default user ident on Windows
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Linux, we use the gecos information to come up with a sensible user
name/email. On Windows, there is no gecos. But there is something
comparable, and with these patches, we use it.

This has been carried in Git for Windows for three years, and is considered
mature.

Johannes Schindelin (3):
  getpwuid(mingw): initialize the structure only once
  getpwuid(mingw): provide a better default for the user name
  mingw: use domain information for default email

 compat/mingw.c    | 60 +++++++++++++++++++++++++++++++++++++++++------
 compat/mingw.h    |  2 ++
 git-compat-util.h |  4 ++++
 ident.c           |  3 +++
 4 files changed, 62 insertions(+), 7 deletions(-)


base-commit: 5a0cc8aca797dbd7d2be3b67458ff880ed45cddf
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-45%2Fdscho%2Fdefault-ident-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-45/dscho/default-ident-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/45
-- 
gitgitgadget
