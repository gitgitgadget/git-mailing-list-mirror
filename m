Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CCE11F453
	for <e@80x24.org>; Tue, 23 Oct 2018 01:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbeJWJey (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 05:34:54 -0400
Received: from mail-oi1-f202.google.com ([209.85.167.202]:41595 "EHLO
        mail-oi1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbeJWJey (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 05:34:54 -0400
Received: by mail-oi1-f202.google.com with SMTP id w139-v6so29682942oie.8
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 18:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=vBoTJohYl+/xT6iROa6k2GSNI7A9xvvcJjwylZLm6dI=;
        b=ONWCutXo3TAXQNrSxIL/5UrQbNDPQXPcd6BlaqsdApTyh7N2tlrOv7lnF3bTmCRtQ6
         S3YK9T9pG1otD96/D3LHrkljpNPrxK4rZsAXaMIhwGuCo+CcWR5uHQ2VEctrJpS0F9u1
         SEw2xjz+C+cgV0ffVPf+5hDaLqFZ8mtxasSH+WFejyFhzj6Wy0WPhJ25Ij+lMviN8x2t
         035Tsd1m6j7V4Qj43qDv7GmuSsJnuxZPOKVu08MUOJgyEFYP5IpGIK10AoSQky40+PPj
         NTmqQY4NuqSEiHp1vGEgx4H3TZiu4UF1/0ROUCdCCX6jmVXNpAsBLtChA1c0AsnynTI4
         eGLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=vBoTJohYl+/xT6iROa6k2GSNI7A9xvvcJjwylZLm6dI=;
        b=A/gElEGOSJGSGw5EMJyI7LpWPgpZGw9AW3kPQHunQfdGcfJ9v6Ch3JfdBMNIDvRmS2
         lpKJAV7D+DFcOX+yfmF5WMg/AhHvtLvSOs4gxxjMREDQhEsmlcYKv/UKQo+cemW2htE3
         BKnoQtVTas0P+1WE6bGZk2DoCTWdNsNmsBItge1Ydv4lg6GCus/P/t42E/89StUYAqcd
         03NIkUL7mU63jZIFS1QLfCogiRjBjs17cpy+dLoAD6Njw8jrLhYjNe4pUdM4CWo484NA
         kWluPXMfX+MKJa9Bq8sesrokuiIWU+3redLovA4cCKnjgIhggH2AcBsHGtuMUSIUA9N7
         A57A==
X-Gm-Message-State: ABuFfoiAFpVFIKf22N6MFwJ/hDvyECc7XjZimgpR1esCmVjsYoUl66Hl
        olVs43qFEwP0vqKrkKnZaYYq2370wSNTpUJIcCdbKEp8GmTj3RAmAMpucsJC36mdvi0yM6wUBzV
        CwPiz20njFy2WORrfCmfnkPEZUY44dyVAa/thrCINWl3XyK3eRAo6YIu7xMI=
X-Google-Smtp-Source: ACcGV60+K0wSMDkdu2WAmibN+uJOjuprTRQENjnHUQ3Eq9toEsb7Ha7Xrduyo8CWhXiHe09k+ozyAuyD3tnZ
X-Received: by 2002:a9d:4338:: with SMTP id s53mr37526138ote.4.1540257233953;
 Mon, 22 Oct 2018 18:13:53 -0700 (PDT)
Date:   Mon, 22 Oct 2018 18:13:40 -0700
Message-Id: <cover.1540256910.git.matvore@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
Subject: [RFC 0/2] explicitly support or not support --exclude-promisor-objects
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, gitster@pobox.com,
        pclouds@gmail.com, peff@peff.net, jonathantanmy@google.com,
        jeffhost@microsoft.com, matvore@comcast.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch set fixes incorrect parsing of the --exclude-promisor-objects
option that I found while working on:

  https://public-inbox.org/git/cover.1539298957.git.matvore@google.com/

Thank you,

Matthew DeVore (2):
  Documentation/git-log.txt: do not show --exclude-promisor-objects
  exclude-promisor-objects: declare when option is allowed

 Documentation/rev-list-options.txt | 2 +-
 builtin/pack-objects.c             | 1 +
 builtin/prune.c                    | 1 +
 builtin/rev-list.c                 | 1 +
 revision.c                         | 3 ++-
 revision.h                         | 1 +
 t/t4202-log.sh                     | 4 ++++
 t/t8002-blame.sh                   | 4 ++++
 8 files changed, 15 insertions(+), 2 deletions(-)

-- 
2.19.1.568.g152ad8e336-goog

