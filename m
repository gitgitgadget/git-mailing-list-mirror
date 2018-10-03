Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7313D1F453
	for <e@80x24.org>; Wed,  3 Oct 2018 15:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbeJCVtH (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 17:49:07 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35173 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbeJCVtH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 17:49:07 -0400
Received: by mail-pl1-f196.google.com with SMTP id f8-v6so3620279plb.2
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 08:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=hjMaIg5kdoZvhkJJTJJep2xOqYkMKoFy70LTAHHnVh0=;
        b=miC6yOuhHtNqIbMl6SpJpOKBNJ+ulGQ2EgCIJIdJ79P4DB/8vzpDceOrFczGxjrhAX
         KmisD5ECNH9lGtBxFS8fJGczSfSx1WmMiy5H9Wnv2y9gAUh5T4Xeq++I8TkKxDyFsivt
         9CVMg/UNN/wgvoJgR4d20256STjew1jJIb/Rt8yqu2iYrhO22WX0GWe/8V6Q9X/er8UF
         9xzowNfAwnF3EB6BV+nR/O6vi0kMMi51dho1EobYmThK1md8Astb0Ct0kpFFr0TqjaxQ
         XYA8fSUvGuqobQTEBKo37W/vsB6q+lFMlZoKPPT0pHxndlgvU40GdLWvSGUh8WEPYHg0
         DOwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hjMaIg5kdoZvhkJJTJJep2xOqYkMKoFy70LTAHHnVh0=;
        b=ZViRlyiLPtbJG9xA4gOnE8kxlyO7rWWFqqoT7Xq5lMq1PiKbep7jY+JwUAhFDjbo6k
         bUqUjgRjdGSO/r+00bGkfT6ekAMl6e0tumCDb4JsHS0byjgyEd3xq1+ziS0H4GzthZal
         DMue3erlhKiHdFvddlA0csq/nU148uUrttS0GNSMBsGn9cYcW44fsMQPk47qDt10WBOJ
         7eKGZyRWfCZSAGoaQy+28Zi+ZxeDjm27YeGFsXKtOred1K1Yi9VHlmKXpLxrDVAVf+Xc
         GbbL/AoVGbj4SWLag6JhPh7VdqL0oUe59Yq7F8MEYo1ZI1Amq9x3G3dCz+KRD7OIHOjh
         hQ9g==
X-Gm-Message-State: ABuFfoiryIBGbiMDUuOpKArdsZse873kOEsmcy9ORhsSq1z/++yN4POK
        Qu1J2G3pjLlZAvMfdiZBrqSlp5W8
X-Google-Smtp-Source: ACcGV62J9XyvbRJcAwhCcVi0huMBdn4BteAIEG3K0X/Zi93WWx/fJkSnJ5gSNGC78Vtaq6nZcrQHLQ==
X-Received: by 2002:a17:902:b7c2:: with SMTP id v2-v6mr2065893plz.238.1538578821243;
        Wed, 03 Oct 2018 08:00:21 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id i21-v6sm4565117pgj.55.2018.10.03.08.00.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 08:00:20 -0700 (PDT)
Date:   Wed, 03 Oct 2018 08:00:20 -0700 (PDT)
X-Google-Original-Date: Wed, 03 Oct 2018 15:00:17 GMT
Message-Id: <pull.43.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] rebase -i: introduce the 'break' command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan asked a while back
[https://public-inbox.org/git/20180118183618.39853-3-sbeller@google.com/] 
for a todo command in interactive rebases that would essentially perform the
"stop" part of the edit command, but without the "pick" part: interrupt the
interactive rebase, with exit code 0, letting the user do things and stuff
and look around, with the idea of continuing the rebase later (using git
rebase --continue).

This patch introduces that, based on ag/rebase-i-in-c.

Johannes Schindelin (1):
  rebase -i: introduce the 'break' command

 rebase-interactive.c       | 1 +
 sequencer.c                | 7 ++++++-
 t/lib-rebase.sh            | 2 +-
 t/t3418-rebase-continue.sh | 9 +++++++++
 4 files changed, 17 insertions(+), 2 deletions(-)


base-commit: b3fe2e1f8cbf5522e7ba49db76bff38f204e2093
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-43%2Fdscho%2Frebase-i-break-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-43/dscho/rebase-i-break-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/43
-- 
gitgitgadget
