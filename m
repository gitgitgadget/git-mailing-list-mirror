Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1C801F405
	for <e@80x24.org>; Wed,  8 Aug 2018 22:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731196AbeHIAzy (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 20:55:54 -0400
Received: from mail-io0-f201.google.com ([209.85.223.201]:43135 "EHLO
        mail-io0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727706AbeHIAzy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 20:55:54 -0400
Received: by mail-io0-f201.google.com with SMTP id w19-v6so2830623ioa.10
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 15:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mnJQh7kJYbvHlmJsEe/CUlv3eSwqFCBuhAN+tQVYWek=;
        b=ZwMoWs5OZASGVxReVeCfKzULNvAEZDLUy6monqXKmFXUNMYYbXR3tIUhQP4eMKXFQ7
         TDAEkRGGINQiFr0B6HyvXnKvkWpdOrBNotA2r5DLTRYNVbD3EV0gYH194p7QsmwKoFeF
         fgSX4RuumBkfr14yLz21UGmCdauVccbSfFgUyNhvKD/E3BpnOaz5oFG1WTR1bE+pyDtR
         q3ZAhqCJPjofsk8JqS57YV024eOJDw9O6rX+XoVthfsilDxh2M/xF/JECPuZwxXbX4IK
         vm48FQEgpJNIuaM0vlH3rhJAmSnXK/Jk/Ow8kWWUMGWRY2GZwjBe1XjIyCUMZxVWR4cV
         9p0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mnJQh7kJYbvHlmJsEe/CUlv3eSwqFCBuhAN+tQVYWek=;
        b=rVtIDRk0zKr410vbaMMyggcKX3jHJ4FIsJuZFoUScqhQ8sLuNonc5LLjMpvHa0axUP
         ytY/l4kMW+bunL+zDjQZPs4DMMyzwziYqTa1go1xCXhKtWVnpZmxEl8rQahSIMn/3DRu
         Bdp7nFcGy1E36FbaGbXwWGT192HG/8IfR4PCpTud6oGgAP0kLxVTSHpgyG/hvRozVY9W
         Bfmvb4hJm68jrew9Fc9J2GBN/Fwbfa6TIq/yxYq6U80yHS3lTMXREaVd7snnHJ/CmmW1
         DIiHwX1AJV8qwM+6r01ICzuYzDhDG1wGFtCf+daneFS6zbA93snWAypA0/nNhUcb4cH8
         hsIQ==
X-Gm-Message-State: AOUpUlFl9ZJISoLfK+dEteH/5CS9C4zRbcr207DyOEmgHYWi8rFW3VMX
        vmpcQha2j02Eo1eCwiyg/v3elHOs8WETa7G4980bA03thG0nyzzUXFzC33A8aUyDywg33vjrPMO
        eTlRW0uuHr4qWz/x5FONw0F7Oqb95OGRtRCcZnRwVwjV/JgqQBn2k2ULR20Kr5QXu0y9FsdPYiE
        Lz
X-Google-Smtp-Source: AA+uWPy9o5pU/yJHeh4SegqpVWxg7ddDdfEBPExkzMXeinYMzrzDIv7gdeBCaCBXRF6wiPzpnT13bTys3dBBfVnyxEoa
X-Received: by 2002:a6b:a303:: with SMTP id m3-v6mr2040542ioe.96.1533767649726;
 Wed, 08 Aug 2018 15:34:09 -0700 (PDT)
Date:   Wed,  8 Aug 2018 15:34:04 -0700
In-Reply-To: <cover.1533672584.git.jonathantanmy@google.com>
Message-Id: <cover.1533767314.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1533672584.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH v2 0/2] Repacking of promisor packfiles
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes from v1:
 - add NEEDSWORK stating that input to pack-objects could be removed
 - run pack-objects to repack promisor objects only if there is at least
   one of them - this exposed a possible bug where the later part of
   cmd_repack() requires a correct packed_git (this was mostly noticed
   by tests that deal with corrupt packfiles), so insert a call to
   reprepare_packed_git() after all packfile manipulation is done
 - rename prepare_packed_objects() to prepare_pack_objects() to better
   reflect that we are preparing a call to pack-objects, not preparing
   existing packed objects

Peff raised the possibility of making for_each_packed_object() use pack
order instead of index order - I'll also take a look at that, separately
from this patch series.

Jonathan Tan (2):
  repack: refactor setup of pack-objects cmd
  repack: repack promisor objects if -a or -A is set

 Documentation/git-repack.txt |   5 +
 builtin/repack.c             | 182 ++++++++++++++++++++++++++---------
 t/t0410-partial-clone.sh     |  85 +++++++++++++---
 3 files changed, 213 insertions(+), 59 deletions(-)

-- 
2.18.0.597.ga71716f1ad-goog

