Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E924D1F462
	for <e@80x24.org>; Sat, 15 Jun 2019 00:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbfFOAmC (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jun 2019 20:42:02 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:54214 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbfFOAmC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jun 2019 20:42:02 -0400
Received: by mail-qk1-f201.google.com with SMTP id i196so3580217qke.20
        for <git@vger.kernel.org>; Fri, 14 Jun 2019 17:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NjH8y2ZxmTWVRUs7J8iUv34tklAK1RSl07QqdTAkQ58=;
        b=Uxn5lq3DWDnNwjYcIzTLTLUA9NXBwDK/rt5WOYbEPzFwWI5nL12LmO8s88eVQUWDfe
         IjG6BWxqJ/jVond4+JQAPPazfCqfqu7aUtZ8AlFkDJYDP2SCjxKFtPF7ZVquw5ebxH85
         8Q/IM9AJ136HP0aHuG7idSQQ2syHF+gJ9qxXgSZtbJ86X43b8FALIHIOkysVrquoTCh+
         70XSpCBZJfM19pHt97btJWh3vak60bWTeWQOj23vWjv/JYA5Fm776Rszwhmu4xKbgpKH
         twOVKVUX/2x9Ly2YdLJr1ZmSVld5aqeSvoHZpeukz1V/Y7MLI0fNFdPGQcCoM+bTDym/
         +/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NjH8y2ZxmTWVRUs7J8iUv34tklAK1RSl07QqdTAkQ58=;
        b=uGfU2YRVggqgUp14IgL//8mE/QnkJsVqVGWiZl1CURZZZRQiDEriJk/njzWP2ffRMY
         S3ABF+2edXfZH1Ji3ZzgmsDAxQU/me0h+Jq67NcK4OKk2ZnT26bISbubilkNwS7WS8cy
         RFhNffvh3gJP2uNWDHwQGyh5gIrePdTKYThL/sb40not38sJD1KBWxJ4uG6oXCM+WuV5
         9QpXqE6mgtkp+vOExLJFTsbwZFoHuJzZFRl4eE00zsxmRR7vKMfmJgAuUv8TeylBnxkR
         KG/yATwRqUsV+y7P2wtEmuJxIvmZC/d4VIkZJIEDiyBjlYg/a4kZzoMENBMbT1p0BP97
         S9TA==
X-Gm-Message-State: APjAAAXGgK7SrK20wP/WnWYdmHWZajkEZgcapUD6JUYdZLWGNL4enzag
        umVhbFWihNEpE8stxh+9gzgVAqqWLP1oAP8TM5I70Hk1/4eHxAgIIBX5+QqLs7vUZMYAhIH+3lC
        V+fYb5tjlXkM+OTWi2prl4NVlmNvPF8lVK5qPlmE6s5B2S62UFPkbcS8HwwM=
X-Google-Smtp-Source: APXvYqzK2Wn9+HIZ4N4sEcHRWXv98l10hzN/jTV+adVnvNZApUrYB6BPoW12nhIhRI0LUEmYaWqUyYHkLMQI
X-Received: by 2002:a0c:95f8:: with SMTP id t53mr10988915qvt.115.1560559321256;
 Fri, 14 Jun 2019 17:42:01 -0700 (PDT)
Date:   Fri, 14 Jun 2019 17:40:06 -0700
In-Reply-To: <20190601003603.90794-1-matvore@google.com>
Message-Id: <cover.1560558910.git.matvore@google.com>
Mime-Version: 1.0
References: <20190601003603.90794-1-matvore@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v4 00/10] Filter combination
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org, jonathantanmy@google.com, jrn@google.com,
        dstolee@microsoft.com, jeffhost@microsoft.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, emilyshaffer@google.com
Cc:     Matthew DeVore <matvore@google.com>, matvore@comcast.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I had to rebase this onto the latest master rev. master now has the patch which
disables the sparse:path filter, and v3 of this patch set has conflicts with it.
This version does not so it can be patched in and tried out by others.

I have re-run the test suite on each commit. Sorry for the spamminess.

Thanks,

Matthew DeVore (10):
  list-objects-filter: make API easier to use
  list-objects-filter: put omits set in filter struct
  list-objects-filter-options: always supply *errbuf
  list-objects-filter: implement composite filters
  list-objects-filter-options: move error check up
  list-objects-filter-options: make filter_spec a string_list
  strbuf: give URL-encoding API a char predicate fn
  list-objects-filter-options: allow mult. --filter
  list-objects-filter-options: clean up use of ALLOC_GROW
  list-objects-filter-options: make parser void

 Documentation/rev-list-options.txt  |  16 ++
 builtin/clone.c                     |   8 +-
 builtin/fetch.c                     |   9 +-
 builtin/rev-list.c                  |   6 +-
 cache.h                             |  22 ++
 credential-store.c                  |   9 +-
 fetch-pack.c                        |  20 +-
 http.c                              |   6 +-
 list-objects-filter-options.c       | 267 ++++++++++++++++++----
 list-objects-filter-options.h       |  57 ++++-
 list-objects-filter.c               | 332 +++++++++++++++++++++-------
 list-objects-filter.h               |  35 ++-
 list-objects.c                      |  55 ++---
 strbuf.c                            |  15 +-
 strbuf.h                            |   7 +-
 t/t5616-partial-clone.sh            |  19 ++
 t/t6112-rev-list-filters-objects.sh | 194 +++++++++++++++-
 transport-helper.c                  |  10 +-
 transport.c                         |   1 +
 upload-pack.c                       |  13 +-
 url.c                               |   6 +
 url.h                               |   8 +
 22 files changed, 874 insertions(+), 241 deletions(-)

-- 
2.21.0

