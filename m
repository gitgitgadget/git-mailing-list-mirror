Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A31101F4B5
	for <e@80x24.org>; Mon, 18 Nov 2019 12:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfKRMHu (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Nov 2019 07:07:50 -0500
Received: from mail-qk1-f182.google.com ([209.85.222.182]:43089 "EHLO
        mail-qk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbfKRMHu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Nov 2019 07:07:50 -0500
Received: by mail-qk1-f182.google.com with SMTP id z23so14096204qkj.10
        for <git@vger.kernel.org>; Mon, 18 Nov 2019 04:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nneil.com; s=default;
        h=mime-version:from:date:message-id:subject:to;
        bh=3qcpdpBWAFEx3CrKCVjWgy5+t3ld4QI42LK6h0IhpEc=;
        b=YVvZXkv3rPowmIr9LyiGA4LCb2U77W2iHcIxFmKVvnGxVbvlTYZAWWdDNjJYnUcdkw
         O5W7WSjRnonSSuA6JGDTCjcfPFzzia3+tCHricVfpV6bMCHKHXXNMTjX0lKR3+rpXnmn
         IaId9VWJ+Nopdxp2q9m/WuVlXKKZczS+DETdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=3qcpdpBWAFEx3CrKCVjWgy5+t3ld4QI42LK6h0IhpEc=;
        b=q9jRGWTWR30WgHoILd1uM7CalEZWAY6CkRhqS8Vh8ciVsLbvoxUmEYifJlcfotYJ4E
         DmmdNV1iDneYO2VDnv7I5Xz9m8BskUx8b+SPuxd9tCfDUX5CgR/zDgt33esiVdAYY2RV
         5EFG+N6Z+h2GW8XJS47oNpBDVnfMCLjSulmmNFiY3ISkOs4638OExGY36XzR+Lu7bn3q
         nhImD1CCT8Z9Gka45dwlAsO942WB8XirA3K8J+7yCOOgThij+1o32SMqyjpgohCuGGO4
         F/aMhQutATTGBlA7HXm3BsDkXXEqepVoaGwYdJR8p99kT7qRd1yF6jpuxcKNHGDVaUqg
         xeuw==
X-Gm-Message-State: APjAAAXz6Rs0YTMEfzumK7fMyZT24kxcU9B7rnFb8k6kCLKFl58Oq4Tw
        x6rbhLTeui6vjpKx/DHlEj6fQ3eNsVMvhRwNklt57E6vNA0=
X-Google-Smtp-Source: APXvYqwOwQE3kc46U9lozqQmk1kywU6j0muACeI/pMQV9BEWH3xiejHVmt0qk49IPGbEZZX7MyeKcx1NbtW9s0I42is=
X-Received: by 2002:a05:620a:13c4:: with SMTP id g4mr24499696qkl.391.1574078869516;
 Mon, 18 Nov 2019 04:07:49 -0800 (PST)
MIME-Version: 1.0
From:   N Neil <nneil@nneil.com>
Date:   Mon, 18 Nov 2019 12:07:39 +0000
Message-ID: <CAPvfG_To8gzS6_f1GxPKZEcae2HDu-gH_Hnb-ym00nGzTNbh0Q@mail.gmail.com>
Subject: Windows installer does not set environment for first run
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The windows installer invites you to start a bash shell at the end of
the install process. I configured git to use plink as my ssh tool.
This requires the GIT_SSH variable to be set. It is not set in this
first run, so git doesn't work properly. The installer was
Git-2.24.0.2-64-bit.exe

$ grep plink first-run-env second-run-env
second-run-env:GIT_SSH=C:\Program Files\PuTTY\plink.exe
second-run-env:SVN_SSH=C:\Program Files\PuTTY\plink.exe
