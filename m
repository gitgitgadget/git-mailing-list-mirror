Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB5DE20248
	for <e@80x24.org>; Fri, 12 Apr 2019 11:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfDLLjp (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Apr 2019 07:39:45 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:43745 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfDLLjo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Apr 2019 07:39:44 -0400
Received: by mail-ed1-f45.google.com with SMTP id w3so8029612edu.10
        for <git@vger.kernel.org>; Fri, 12 Apr 2019 04:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=t8W/JItEx4tFUEXj1aQCp+oHVT89Yj0Sc4AHm2EeUlQ=;
        b=Z9252CMGJbY3S2QlIPPlFhfiEKmDNUoAPkJ3pU/k0rXLAI1m4lAamuTIg0JtiuU/ZU
         PHXDHq3WdisptmpmkstecAGt7w4uM26tA6QiPcia0r94prg2PchONC9U58BngeiAU8Tg
         F9VWsegtcVKWYwQ7lAs1pM5rud7gWVkrfZkViYpmKYcs4WaGqot/d5K/vpzW7RD3uJVp
         4Eb9kP+jK16Uo8/IPrvbpEh1CgebUBjUUEd9Dqilnema4UxKIgTWDTwz6rroIi/qwkIY
         r/LjxodRra09SmOeP/d9YjHAGqFCW9q8c6t/MWMHQ6l7j+3V6ZZ/MZhivRCljBLQaHU5
         65Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=t8W/JItEx4tFUEXj1aQCp+oHVT89Yj0Sc4AHm2EeUlQ=;
        b=CZMTa2hqi0lgOxe134lKBmc/UJ6AP1IJwAGIzNbM+3IIid/V6vW8blBcsLmkpKaruS
         NLd7Mqeyr0tlrnlbjH5a5KaPjAB3rl5TNL5tbSNs/2X5gbd0vYPy8fWsv17g0kBh750u
         VR4HSSHkulIqpmiI+Xy8YSsm2RIPr02uu3woDKvPgMNYh9G3rPFh4zNwNWMh83bcEFl2
         /vGWdb7c/j4D0kZFSFY9MUiobxMQnzOSC86NDg0zB5YyiTiunfrLwt8ZOZJZhCg5PjJ0
         +jLuvrfV4g5IXFcg0VvawBPpH+bcwVK5jA+98ti3o6pKArK7PxJMtulCBjLTYL0CTpbB
         Sqgw==
X-Gm-Message-State: APjAAAV5Mo2h1PBil/DkFmPtTZqhpxqr95aKcAxMpyxBHXEhRiYhrQOq
        suvbKXB8xMgnYc97LrctzpoCoA6L
X-Google-Smtp-Source: APXvYqxsi4KPvZZAMvSzZkPc26p4Z8IiIaR+a1q8PJEPJ2J3JrYt+LSXONfCFNUA2d2cHSsIcXk4+Q==
X-Received: by 2002:aa7:c58d:: with SMTP id g13mr13910987edq.258.1555069182998;
        Fri, 12 Apr 2019 04:39:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m26sm1967601edr.48.2019.04.12.04.39.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 04:39:42 -0700 (PDT)
Date:   Fri, 12 Apr 2019 04:39:42 -0700 (PDT)
X-Google-Original-Date: Fri, 12 Apr 2019 11:39:39 GMT
Message-Id: <pull.179.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/2] Prepare our git-p4 tests for running on APFS
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

Yesterday, the macOS agents of Azure Pipelines were upgraded to Mojave, and
since that does not support HFS+ anymore, everything will be upgraded to
APFS.

As I just found yesterday, we have one test that fails on that filesystem
(t9822, which is only run if Perforce's p4d is available).

The first patch adds a workaround, as I failed to find any way to finagle
APFS into accepting that ISO-8859-1 encoded file name.

The second patch is a fix to make things compile on Mojave again, apparently
Homebrew changed and the /usr/local/ directories need to be added to the
compiler and linker flags explicitly. Maybe this is a gcc-8 only thing, as
it seems to have affected only the osx-gcc job, not the osx-clang job.

Johannes Schindelin (2):
  t9822: skip tests if file names cannot be ISO-8895-1 encoded
  macOS: make sure that gettext is found

 config.mak.uname                | 2 ++
 t/t9822-git-p4-path-encoding.sh | 7 +++++++
 2 files changed, 9 insertions(+)


base-commit: e35b8cb8e212e3557efc565157ceb5cbaaf0d87f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-179%2Fdscho%2Fskip-t9822-on-apfs-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-179/dscho/skip-t9822-on-apfs-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/179
-- 
gitgitgadget
