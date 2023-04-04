Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A322C6FD1D
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 20:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235955AbjDDUNZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Apr 2023 16:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjDDUNY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2023 16:13:24 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B542108
        for <git@vger.kernel.org>; Tue,  4 Apr 2023 13:13:23 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id h25so43852875lfv.6
        for <git@vger.kernel.org>; Tue, 04 Apr 2023 13:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680639201;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6H0SDbqCsrDNEOc+JFkDrRxVH5WCi6YQDqfPDxVF5Tg=;
        b=SufMjin84c32hjp+jR8NyWWHs9f/lWCa9PKYqkHJYaosbjk6chetjwNRKYKIh7mrgc
         FBNrnYgYDDKlZmos/Ij5OLqXDHrZMMtis2ibPsGNyX4xVnty/fVzCobHczR3blesEVIJ
         PfyvZC093uROl/iPY0vzT2KURHGuw29C68FtAR219c5joO24DxoHLvAAYMEarjpUCC7/
         Sw8fUtaxIK3rrFBl8sA2JpokYJjgEiRvsT31gcvZixOZNJLLTk/7ncqWx42kMJxB0BKb
         sev6OQmv60hbV2iefOBEFjKeG2sWsl/dxvJE7tAHPtV1DWgi746MT5ueBJpwYiFWrBYe
         JSTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680639201;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6H0SDbqCsrDNEOc+JFkDrRxVH5WCi6YQDqfPDxVF5Tg=;
        b=M7a6PPhrgxLF4mB4/gkZ7k1AaxgCecmqWcsqFx7cLG+pJSizGMlKdtuDEEFVEjJyCq
         23LZASyYrNU43EhmSMmrcKOLwqNTsHQJW5ChEQTEiiZW6qxRTY3T3h+RLAGsV86JFoTv
         7+e6hcsz22Q2lNUabT2VGf0bbBDLnEXvO7LAHLw3C6ex7FWzprVHXqLoYjoIyxNh7Jrp
         OlBS1Mp3Bw+f7LmrqxFaeMjcmEvSUaqXVEtcPGHs/cBeMvQKeapZgWtrxOQ2CUJvxifJ
         LA28RveXTxlZksmeHZZlzSxxetk3fSnSqUyec1GHpRye7qgshzQ96qJmodmNh3SeDz6p
         dHvw==
X-Gm-Message-State: AAQBX9eNKQyFY7UEPkSvw0ZHpMbtGD5/m0wEOkneN5pDqfPQdCkmOI3l
        Bas4F+ZW0IuIE7TNbjV0FQKkizvPtVMEcX0rl2TcWLipcB2jUg==
X-Google-Smtp-Source: AKy350b3j9AKX7OrJ+fLr6IE21mgvD3z0tdibxoHCcC3DABsGzUUBK6Jyk6KQfOMLI6QrsFHf6zyMB1Hfo7IGBnmrfw=
X-Received: by 2002:a19:a41a:0:b0:4db:1a0d:f260 with SMTP id
 q26-20020a19a41a000000b004db1a0df260mr1117364lfc.0.1680639201473; Tue, 04 Apr
 2023 13:13:21 -0700 (PDT)
MIME-Version: 1.0
From:   Rohit Ner <rohitner1@gmail.com>
Date:   Wed, 5 Apr 2023 01:43:09 +0530
Message-ID: <CAKazavxTXwcZFtL2XyU3MpaUR=snWY8w8Lwpco+mkbqm2nWE=w@mail.gmail.com>
Subject: git log causing hang while browsing upstream linux
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
1. git clone https://github.com/torvalds/linux.git
2. git checkout master
3. git log --oneline --graph

What did you expect to happen? (Expected behavior)
See a graph of onelined commit histories

What happened instead? (Actual behavior)
Hang after entering the command

What's different between what you expected and what actually happened?
The output is empty and the cursor is stuck. Cursor is unresponsive to any key
press other than ^C which leads to an output like below
### OUTPUT START ###
...
~
~
~
~
(END)
### OUTPUT END ###
Pressing q key helps get the prompt back.

Anything else you want to add:

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
compiler info: gnuc: 12.2
libc info: glibc: 2.36
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
commit-msg
pre-commit
prepare-commit-msg
