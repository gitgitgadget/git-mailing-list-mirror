Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BCA1208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 17:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733018AbeHFTzN (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 15:55:13 -0400
Received: from mail-ua0-f201.google.com ([209.85.217.201]:49534 "EHLO
        mail-ua0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730922AbeHFTzN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 15:55:13 -0400
Received: by mail-ua0-f201.google.com with SMTP id j12-v6so9343501uaq.16
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 10:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=z3l0x+HOAZkrRgIC9rBeN3jR0Is0DWhtnY0ko5D7rO4=;
        b=qcxoKvKryuMPVT+acalT40bRIyt+kWTGS4nsjxP75hGQOdsmLZHqrAzgyiAcakxpoT
         D8J3sUxGXWjK9+Cxt3gwGv8C+hSXbb50JNbepCz29OdfPRUpHc6Fer9AxnXeQWYGQHOv
         GR+igt7VLXzoGAFzxrZGz5RoVY9nq8z5MGJj0WeFw2jhjwb01hYcnKe6cTciEzxSlwWL
         VbOMQ+SlY9GsYZB5GK6rw0J9akaP6LST7zy88nbHzsmscdEJwUkmHPwMrporB/a5b2WH
         T5R/sH1iagbDQcMwKJq6NCxbpZhtmc5qlXkmO7+RqaOOBqjbNZxUXn2WpjxFGtsN7Kus
         fTJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=z3l0x+HOAZkrRgIC9rBeN3jR0Is0DWhtnY0ko5D7rO4=;
        b=imXcYZR3zQohhoFqPBSLKskisH9B9mnfOg+FVDHySCa9UmWb1f2VJ5TuM7VR0GOig2
         T6WF2yX1ofIMpxwnAvzAm6bYX6FWUBJU92vUz8gScEFuyCPUu0SrLN8m69O0t2/XgRCc
         1Eh1zsnmDieNrTnQpyFbwPZQ47jz5J9vNF9noYTMYv7CiUwE6yAwBjGt4cHwufWoaP7J
         tU/j2nAUkeCHw3SQwOralzs8h9CbFqTUPU4iRtO6FSIc4mbf7A44etW8GVJgaT116Rht
         SCN1BMpwJ2MSej1sZ9yRTTtYO34JgDJ7pi6eBWwQTtk9oqTB+duJZs2a+lkM2JeyY+3K
         KUmQ==
X-Gm-Message-State: AOUpUlG3s8czJE9tCSLH+Pr+7iSZWoaxee+dT9Estabh+iJO4dBgFDZ3
        eK7tTQK6Md45B5GwgZ1kL/owHry/64I=
X-Google-Smtp-Source: AAOMgpdqaHe6caQG4NQ4iVYs12j0PyNhpX1LmL5Dw+lJR4UiDaSPdDv+0+n0NeJxrfEV6i07LBNpW6Z/rxE=
X-Received: by 2002:a1f:b40c:: with SMTP id d12-v6mr10166093vkf.17.1533577503662;
 Mon, 06 Aug 2018 10:45:03 -0700 (PDT)
Date:   Mon,  6 Aug 2018 19:44:58 +0200
Message-Id: <20180806174459.199589-1-hanwen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH v6 0/1] sideband: highlight keywords in remote sideband output
From:   Han-Wen Nienhuys <hanwen@google.com>
To:     gitster@pobox.com, sunshine@sunshineco.com, jrn@google.com
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

address Jun's comments.

Han-Wen Nienhuys (1):
  sideband: highlight keywords in remote sideband output

 Documentation/config.txt            |  12 +++
 help.c                              |   1 +
 help.h                              |   1 +
 sideband.c                          | 127 ++++++++++++++++++++++++++--
 t/t5409-colorize-remote-messages.sh |  87 +++++++++++++++++++
 5 files changed, 219 insertions(+), 9 deletions(-)
 create mode 100755 t/t5409-colorize-remote-messages.sh

--
2.18.0.597.ga71716f1ad-goog
