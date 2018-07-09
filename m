Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32BB61F85A
	for <e@80x24.org>; Mon,  9 Jul 2018 20:44:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754563AbeGIUor (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 16:44:47 -0400
Received: from mail-qk0-f201.google.com ([209.85.220.201]:34054 "EHLO
        mail-qk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754520AbeGIUoq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 16:44:46 -0400
Received: by mail-qk0-f201.google.com with SMTP id y130-v6so24768967qka.1
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 13:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=vnhw87cgRRktjJbpYaRAI+m+45V3ZfJgaRNdl21QEQM=;
        b=gQRc0VxkDU+ANuvOIIc6oIRkeceDBaTIzyZTD9ybHSxX+izXMtZt34dsY3sm2LV+yQ
         IulA4e8HyTvPt1WiLVoN5rIPeChDdvfVYOXgZ5GTKPOnQ75Rpp7S7fdS28OC2ymzzqnu
         7dO8bVfB+3dCunQCP9uuPx95pd7OwFPQbEO+O95eYCGlx6CveM3yQ57n3TwsYFjRw0my
         3gjgCkFPJt77onZ6HnTs8qAH6SSDuDKlLH5EdhznVD4QG9t+57Fq0XXfLdhz99AYQpvD
         mGdS73KcEtB2uFXN59MJiN9S/eRvwokDbIUc+UDa4G0wCP7iAPY8J/H6j6nE0afB6VpG
         ioCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=vnhw87cgRRktjJbpYaRAI+m+45V3ZfJgaRNdl21QEQM=;
        b=Jv4sccK5uNuv54e4GveFk8Zi58t0eKWU0APLfexanEXitqzRAgSgB13Vmo14zLHI8e
         90z9jcXzkdRQWZJngQdEarPGXP4k3EvVUuxvVzRwc2q/yFhDLjtpgRAOZDGDp2AKyB37
         1gJmuUBCxQK6bZuqMXgyz6gwsNtohueIDvidbgSLjjYX6H3S7C/1DFnBfregh9K/hDOP
         cC2fii/PMpabyR0R7WflQxv0f+lB5xOm+As8gweHAOFliNTf0JSuaqlFUIgWx8zjOikq
         fGKKiI03g7A6awHrKIjjrm6JNBTBzLZ/FWnF4WbjIc6nWN3Ewe5+k48cqnjVb9kmTW/3
         ASIg==
X-Gm-Message-State: APt69E0sU7gX9pniQf7tSXbiP9peApfsWSPlcMFu+pjy1ukdZj0r1vgp
        HzyuaJjsmhcVZEqWQ/LTpPJkOaxo7xiClkNwpLA/kjJ3t+7WE0658LjYPFM1yTHc+SQnaa6MnkW
        EtiTEijogZ9JmJ3XWrwqqjoPG0AeVnQ7NcCcOu8GNy2wN1HPU6LEFDbQpxwxcDVu+RKgmZ1BTms
        Ug
X-Google-Smtp-Source: AAOMgpdgBAFnrowOQs61LoHbsZirOCcK90nQO6EQqSfeqqvqIngmZNP1oH0/3dnvexsbHc6wuy/2qJWxlLmKry4vLy4f
MIME-Version: 1.0
X-Received: by 2002:a0c:f7c6:: with SMTP id f6-v6mr12616518qvo.17.1531169085386;
 Mon, 09 Jul 2018 13:44:45 -0700 (PDT)
Date:   Mon,  9 Jul 2018 13:44:34 -0700
In-Reply-To: <cover.1529616356.git.jonathantanmy@google.com>
Message-Id: <cover.1531168854.git.jonathantanmy@google.com>
References: <cover.1529616356.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: [PATCH v2 on ds/commit-graph-fsck 0/6] Object store refactoring:
 commit graph
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is on ds/commit-graph-fsck.

I saw that ds/commit-graph-fsck has been updated to the latest version
(v7, including "gc.writeCommitGraph"), so I've rebased my changes on top
of that branch. There were some mechanical changes needed during the
rebase, so I'm sending the rebased patches out.

I've also added a patch (patch 1) that removes some duplication of
implementation that Junio talked about in [1].

[1] https://public-inbox.org/git/xmqqefgtmrgi.fsf@gitster-ct.c.googlers.com/

Jonathan Tan (6):
  commit-graph: refactor preparing commit graph
  object-store: add missing include
  commit-graph: add missing forward declaration
  commit-graph: add free_commit_graph
  commit-graph: store graph in struct object_store
  commit-graph: add repo arg to graph readers

 Makefile                   |   1 +
 builtin/commit-graph.c     |   2 +
 builtin/fsck.c             |   2 +-
 cache.h                    |   1 -
 commit-graph.c             | 108 +++++++++++++++++++++----------------
 commit-graph.h             |  11 ++--
 commit.c                   |   6 +--
 config.c                   |   5 --
 environment.c              |   1 -
 object-store.h             |   6 +++
 object.c                   |   5 ++
 ref-filter.c               |   2 +-
 t/helper/test-repository.c |  88 ++++++++++++++++++++++++++++++
 t/helper/test-tool.c       |   1 +
 t/helper/test-tool.h       |   1 +
 t/t5318-commit-graph.sh    |  35 ++++++++++++
 16 files changed, 213 insertions(+), 62 deletions(-)
 create mode 100644 t/helper/test-repository.c

-- 
2.18.0.203.gfac676dfb9-goog

