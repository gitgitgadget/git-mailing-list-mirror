Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB90D1FADE
	for <e@80x24.org>; Tue, 12 Sep 2017 17:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751435AbdILRYL (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Sep 2017 13:24:11 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38246 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751423AbdILRYK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2017 13:24:10 -0400
Received: by mail-pf0-f193.google.com with SMTP id q76so6470493pfq.5
        for <git@vger.kernel.org>; Tue, 12 Sep 2017 10:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=59L4GfS0lqY1ZUFIndkutZf02vmlE2nFfyFJcxgX5ww=;
        b=SSoeg7LpmRQ7Vfw4Sa3jLtQCy4cu0iszrtebJ2112ssuBGT2yFeyG6IVmoWggl9Ezk
         kN0dr/EcUJBiSa6zFW2PpNBPFT/rJzWn/gnJ9OzIMFbtTnZwy/uTOfSanWd6k75ekzol
         nQ1mQVVLZVqm6dWjVk7dhdiu2Wb9fXMtW15G5eii6FJykW10uPPdRsz7hz7FyAoqWokj
         nesKb3+WoTetYBC4+Mxd8ouQHLneYvnPgE5Sg0onW1gX4gCNWygqcOFAQ03rH5yq02lV
         x073pwQDC6XOYYBKl6OJqOoW9lR+Fn2Y33b+4nwa/OvZdJ8Vugl16TPipvoKKR4G/Kv9
         kVeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=59L4GfS0lqY1ZUFIndkutZf02vmlE2nFfyFJcxgX5ww=;
        b=IZsVtAbaqE5u0qHw/LaCvfRB6DqDfPAJog/KTh1c2II7S82b4H/1Z80bXgR5AN53eH
         lcfbQRkWOVUUc0c2lNhj496j4SczUm9wxQTkC6Q9kh/4/UAIkb0euOLs8Wl+zSfJmnvQ
         WokmQ6JPVuCbTRPMN7XOVnOvuI7cZHW7e6B3ZFD1Su2unoeRws04+ucoWIdJ0uFPj7jX
         uUKAGyHR2UOfoFlnnuyD0+X72MbcZ/NaTW9hSgl4W5E796bycQGcPqlR3Oje1pV739r/
         2kh7WqhwCoeiUW4B2sm6gLxY5lVOHZRLearhqUPImLIBYOQ34h8Jjq3ipntQ+CNKdNuU
         EejA==
X-Gm-Message-State: AHPjjUiZByMhdZHaPe8o1NtGd5OmLPwltPktj5+fbPuyk67bssOxTpJo
        SeU4nXAx/di3aUx9d8k=
X-Google-Smtp-Source: ADKCNb5wSiptd8ih/bZQGTRDjI060QRn3Kvy6y+j8stQ3oYqR83/V1m6b9yIH1yaIW7jiT0OM9u+aQ==
X-Received: by 10.99.109.139 with SMTP id i133mr15210763pgc.29.1505237049548;
        Tue, 12 Sep 2017 10:24:09 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:9def:8161:22df:85ca])
        by smtp.gmail.com with ESMTPSA id k78sm21245355pfb.157.2017.09.12.10.24.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 12 Sep 2017 10:24:08 -0700 (PDT)
Date:   Tue, 12 Sep 2017 10:23:30 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/4] Fixes from the per-repository object store series
Message-ID: <20170912172330.GA144745@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

This is a continuation of the series at [1].  That was part 1 ---
you can think of this as part 0, since it contains the simplest and
least controversial part of the series --- each patch in this series
is a bugfix in its own right.

Patch 1 should be familiar if you reviewed the series [1].  It is
unchanged from the patch there, except to note Peff's ack.

Patches 2-4 have not yet visited the list but are fixes (or, in the
case of patch 4, cleanups) noticed as part of the same process of
teaching object store code to handle multiple repositories.

We hope that splitting these out should make them easier to review
and for people to benefit from these fixes without having to wait
for the rest of the series to settle.

Thoughts of all kinds welcome.

Jonathan Nieder (1):
  pack: make packed_git_mru global a value instead of a pointer

Stefan Beller (3):
  push, fetch: error out for submodule entries not pointing to commits
  replace-objects: evaluate replacement refs without using the object
    store
  packed refs: pass .git dir instead of packed-refs path to init_fn

 builtin/pack-objects.c         |  4 ++--
 cache.h                        |  4 ++--
 packfile.c                     | 12 +++++-------
 refs.c                         |  2 +-
 refs/files-backend.c           |  4 ++--
 refs/packed-backend.c          |  4 ++--
 submodule.c                    | 33 +++++++++++++++++++++++++--------
 t/t5531-deep-submodule-push.sh | 10 ++++++++++
 8 files changed, 49 insertions(+), 24 deletions(-)

[1] https://public-inbox.org/git/20170830064634.GA153983@aiede.mtv.corp.google.com/
