Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE,STOX_REPLY_TYPE_WITHOUT_QUOTES shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BF9D1F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 14:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751638AbdB0Ox4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 09:53:56 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:34030 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751403AbdB0Oxz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 09:53:55 -0500
Received: by mail-ot0-f193.google.com with SMTP id w44so8647800otw.1
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 06:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:to:subject:date:mime-version
         :content-transfer-encoding:importance;
        bh=WKDR6xEmMx4bdmnzRjVYNKMo2xhUsJiN5F+DLzs4ftg=;
        b=dCafFHX1oNuBwsxQZ2SvcA7VUIRNE5HUzJhL2RJ/GkOTqMEDGuhLnjmf05VLUPG11F
         z4JidZcFdvRPsiYFblyl4Ang2m7bzmTtbTe4nUNQIfVnA6fF+3BLCgva/C3ntI/uR9qT
         SONgGHYr+yukMSDjaUNk3o9G2jfQulw62lO85uit33x6dU8MbzVEMojL1TEhcCmfILdn
         tWbgFWl69/uD6dHCe/qc8LPORDIcrt5JkGqPoieeAv+5rfRfuqccgBNTZUSoyC7qAvka
         jNkFh65Ue/1MKhmqRVaIwQXxCUFUIuMDTtxs0Zm6WawWXREfHWIPcPDW290aQSF/FqMx
         TmCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:to:subject:date:mime-version
         :content-transfer-encoding:importance;
        bh=WKDR6xEmMx4bdmnzRjVYNKMo2xhUsJiN5F+DLzs4ftg=;
        b=oHgeWqfKFl9RbnYTMuM4rxl9mFh7ZFfHLi7PUQ6DqEwIU5jXCN5F2w2uSFC7ZgkTV0
         fUODfMr1Y35T/Bq7I4ztNHNKmj91Dts4TuePljkXPQXGtfsDr8uvqlzVygEqR/eJF47h
         G1qwd971LCL1EBIUbiBVCZkQv2wylsluf8djl1GpImG34/4a7a4fYUx/6oZ/vMXILpy5
         5Wd1dNkgTeHnW9VMojebOW28PtWc/nLQIn7Yr3RHPcJVY2f+lZ3lToRQmLpcIC/8dMWZ
         4RAV/xxuRohw+ue1fr3psSAeofb4k9vFPCIYcYqB/VJdkVdVtNTd2UEd7bLMK+nScB7Y
         UbmA==
X-Gm-Message-State: AMke39kYT2bVdGWZ66B8Eo8gozIPLyU6fi1iW50FwgHu3UpzYJZj4gV8ejlcAStVS/LWDw==
X-Received: by 10.157.40.48 with SMTP id m45mr936104otb.59.1488205357049;
        Mon, 27 Feb 2017 06:22:37 -0800 (PST)
Received: from daddy (ip68-5-136-133.oc.oc.cox.net. [68.5.136.133])
        by smtp.gmail.com with ESMTPSA id m35sm6139443otm.43.2017.02.27.06.22.36
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Feb 2017 06:22:36 -0800 (PST)
Message-ID: <0E511C089BC341FBA9DC694C1CE770AE@daddy>
From:   "Alexander Grigoriev" <alegrigoriev@gmail.com>
To:     <git@vger.kernel.org>
Subject: Bug: "git worktree add" Unable to checkout a branch with no local ref
Date:   Mon, 27 Feb 2017 06:22:35 -0800
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="utf-8";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
Importance: Normal
X-Mailer: Microsoft Windows Live Mail 16.4.3564.1216
X-MimeOLE: Produced By Microsoft MimeOLE V16.4.3564.1216
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git version 2.10.2.windows.1:
If a remote branch has never been checked out locally (its ref only exists 
in remotes/<remote>/ directory), "git worktree add" command is unable to 
check it out by its normal short name (not prefixed by remotes/<remote>), 
while "git checkout" command has been able to handle such a branch and 
properly convert it to a local branch. 

