Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B87301F462
	for <e@80x24.org>; Fri,  7 Jun 2019 01:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfFGBIh (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jun 2019 21:08:37 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:53286 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfFGBIh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jun 2019 21:08:37 -0400
Received: by mail-yb1-f201.google.com with SMTP id k142so533316ybk.20
        for <git@vger.kernel.org>; Thu, 06 Jun 2019 18:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8CGAvuaElmn5zjo9uy7v8uXIonwhuoKMRJps8D9FQY4=;
        b=Oaf/CLpkNbRTzOo2ejjE5hDILUJYGJRzm8zXD/wMWRBFGS4tZv/r96ecRBoTzLl/zC
         k/FA2TUsRG8O7TzHybYJj/WRXrrKF8g6eLl75UkrEvkzdQATUzxOejN0MWGuLlhNtQAk
         RKIIcZcFXQB6Ng24a8ug1/Jikh/c+v3TiQCdivUrzlTnbToR+0PfM96qErIenDQ9ArgV
         u4rXF1/b3WzEqa0WdQtVXPgSgkFIh02LP4Se2WsRFdZ/YgezMObEp2ZLtA0fXoTpV4/3
         y5/vN2zeCbexfxyi6xur6h4Dd7KxhWDO8mv5OmRWniNLoK0CmrCKgBP1spqPUYZ4w7fj
         8PDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8CGAvuaElmn5zjo9uy7v8uXIonwhuoKMRJps8D9FQY4=;
        b=VBw7iYgD7n5gOrKCsIfIAq6pmvuPNL7mPAkdZYkW4xXRTna9YKmhgVdHWMH9yUk3Nb
         ITYz+BIaUqk10KeZubQJh+jH0iR2m5zFC/ThDD0525a1vUr8N3MryOfcZyx53i6to+rW
         XVCVweBC1x4ANatXCvBWPcuDmHOX9NyARDZQI7MsjO9paFdgmCDwOddNNLyY3hZdGY1u
         tsbZJz9USacAG3baYtJrf7U8TcpZXrqB6WVLIz6EnYOuum1p19aXb+o3KsChn/2tGmcw
         iN7CsWQdwPLvj3AWNYnppbd88SGEWhAsUKC8CJpDq3dhq6zVycgnc4c5TEvGebEcYrTF
         fraA==
X-Gm-Message-State: APjAAAUzNTwYa70j1E/sB5o6AW0u6npRqcTtGyBnb76GGAPRML0uCqSL
        p7LMrxOxVT7Niewbl1GCzNaYK07eEYNuUozSystyCPXAgyVnXMafJZv/BOKgIyApKcbdnO0VmQu
        Pwrryvj6JMJrIYipu0dhImgpQYXwaiLlaxar7XjIv4bhAdpwiDa1ul31u8waV9ob4w0N95kengA
        ==
X-Google-Smtp-Source: APXvYqzPf69lRYwaOUWhmtlX+Frbrvkf2CAEGKw58Wfs438QnEXtf7yT4GW7JzrvEldK8+cAx0kd8zmxAuNx+U2KDzI=
X-Received: by 2002:a5b:491:: with SMTP id n17mr28465ybp.30.1559869716545;
 Thu, 06 Jun 2019 18:08:36 -0700 (PDT)
Date:   Thu,  6 Jun 2019 18:07:58 -0700
In-Reply-To: <20190607010708.46654-1-emilyshaffer@google.com>
Message-Id: <20190607010811.52944-1-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20190607010708.46654-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [RFC PATCH 00/13] example implementation of revwalk tutorial
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patchset is NOT intended to be merged to the Git project!

This patchset should indicate what a contributor would generate by following the
MyFirstRevWalk tutorial.

I intend to push a feature branch with these patches to my own mirror of
Git on Github (github.com/nasamuffin/git/tree/revwalk). I'm sending them
for review by the list to check for consistency with the Git codebase,
so they aren't a bad example for new contributors.

Thanks for any reviews, all!
 - Emily

Emily Shaffer (13):
  walken: add infrastructure for revwalk demo
  walken: add usage to enable -h
  walken: add placeholder to initialize defaults
  walken: add handler to git_config
  walken: configure rev_info and prepare for walk
  walken: perform our basic revision walk
  walken: filter for authors from gmail address
  walken: demonstrate various topographical sorts
  walken: demonstrate reversing a revision walk list
  walken: add unfiltered object walk from HEAD
  walken: add filtered object walk
  walken: count omitted objects
  walken: reverse the object walk order

 Makefile         |   1 +
 builtin.h        |   1 +
 builtin/walken.c | 263 +++++++++++++++++++++++++++++++++++++++++++++++
 git.c            |   1 +
 4 files changed, 266 insertions(+)
 create mode 100644 builtin/walken.c

-- 
2.22.0.rc1.311.g5d7573a151-goog

