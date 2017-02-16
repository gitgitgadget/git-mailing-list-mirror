Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B549320136
	for <e@80x24.org>; Thu, 16 Feb 2017 11:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932096AbdBPLsy (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 06:48:54 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36815 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754912AbdBPLsx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 06:48:53 -0500
Received: by mail-pf0-f193.google.com with SMTP id 19so1482630pfo.3
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 03:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QsTGFdrItTvmhj41vs2GvbU/0KuHr8OGa9ydfLmeZ0s=;
        b=DweOwC5AS0UzWzct2J9OelhL7zikP/1tcx+4uatHd3jXCP55EKbIxJB8o7N38YfW1h
         KZVhIhUznyEHre0kTAk8a4UawY1FuH+RehCRP0mKQWbtJsnHl+55dBKerR4t6aTsImTp
         CCcv/Ej6gR//Vh6ucJ4L77CZsGSaGZjc2dnyAm2MVCc5TfU9+gvdCp/S2jetGuhMb5sE
         GFUk7CIg2Q921KbjW8lJXVGwpgwTjY4FcBkP1g54TFaTobD/amC3B66YW2kEPR+9wF/E
         73CFnHpta7tJfpWQ1So8CdgRKDdOSmxHn6JR8RYPGj/EGsyGQQgXtKFbXX+tEw1KCRPa
         f/aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QsTGFdrItTvmhj41vs2GvbU/0KuHr8OGa9ydfLmeZ0s=;
        b=H/DvYiBZhAntPPorTyCJfIM5J4OrepYa1PexDTdYqhW8uOF56lmGrrTY6LMKVTMOuG
         HIryGinfbsua1mIl19B+yB3AVwZV35QDjmUMFysk3jZdbhy/Iw+rePULCoVlkDM7C84C
         R4dLEBuKgi6/LjhnRTSSq+touNd/I9IM01z6ytG/Gy7Blhk8NjwAl/dtYHfaNK3svFnC
         wVRSLc+fjZZrltOB9wmtLTtAnx+4iiG2YghLrW5ksFAh0yZ92o7emlL0cGkMANUPfYLl
         PQ0SFROS9YviAL7zOy5lxRHlvaEoGGpbvVumHlkHqaaHQYTEwOZCgsxsFiGgtbGO4iej
         PX8Q==
X-Gm-Message-State: AMke39ndUYuO2vhUe1+aq2Y81UA12dRkYj485PFc1S4t9bP/bWvjh4FhddFSd7zub3A1Pw==
X-Received: by 10.84.148.134 with SMTP id k6mr2642596pla.142.1487245732417;
        Thu, 16 Feb 2017 03:48:52 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id j28sm13370147pfj.2.2017.02.16.03.48.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Feb 2017 03:48:51 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 16 Feb 2017 18:48:46 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 00/16] Remove submodule from files-backend.c
Date:   Thu, 16 Feb 2017 18:48:02 +0700
Message-Id: <20170216114818.6080-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170213152011.12050-1-pclouds@gmail.com>
References: <20170213152011.12050-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes in v2:

 - should fix all feedbacks I've got in v1
 - rebased on mh/submodule-hash v2
 - share the "submodule -> gitdir" code that I copied from
   strbuf_git_path_submodule() to files-backend.c
 - kill register_ref_store() and lookup_ref_store(). Their main code
   for submdules is still there, under the names
   {register,lookup}_submodule_ref_store(). There's no mixing up
   main and submodule stores anymore.

I think the end result looks pretty good. refs.c is now almost
submodule-free, if you don't count the submodule hashmap and the
wrapper API.

I'll be sending two more follow-up series, if you are interested, soon:

1) v2 of nd/worktree-gc-protection

which kills parse_ref() in worktree.c _and_ set_worktree_head_symref()
in files-backend.c. Both are bad things that should not have happened.
(PS. The topic name is misleading as this is mostly about eliminating
warts, unless Junio intended to combine my second series as well)

This series introduces get_worktree_ref_store() and adds two new APIs
refs_resolve_ref_unsafe() and refs_create_symref(). I'm still not sure
if the refs_ prefix is good naming, but I had to pick something to get
things going. Name suggestions are welcome.

2) the real worktree-gc-protection

This series adds a bunch of new refs API, enough for revision.c to
traverses all sorts of refs with a ref store instead of "submodule".
Many _submodule API are removed as a result because they no longer
have any callers (yay!). One of them remains though.


I'm also playing a bit on the side with the "linked worktree" ref
store, in order to get rid of worktree-specific logic from
files-backend. After that lmdb patches can use some cleanup and
finally enter. But this is kinda low priority for me.

Nguyễn Thái Ngọc Duy (16):
  refs-internal.c: make files_log_ref_write() static
  files-backend: convert git_path() to strbuf_git_path()
  files-backend: add files_path()
  files-backend: replace *git_path*() with files_path()
  refs.c: share is_per_worktree_ref() to files-backend.c
  refs-internal.h: correct is_per_worktree_ref()
  files-backend: remove the use of git_path()
  refs.c: introduce get_main_ref_store()
  refs: rename lookup_ref_store() to lookup_submodule_ref_store()
  refs.c: flatten get_ref_store() a bit
  refs.c: kill register_ref_store(), add register_submodule_ref_store()
  refs.c: make get_main_ref_store() public and use it
  path.c: move some code out of strbuf_git_path_submodule()
  refs: move submodule code out of files-backend.c
  files-backend: remove submodule_allowed from files_downcast()
  refs: rename get_ref_store() to get_submodule_ref_store() and make it
    public

 path.c               |  34 ++---
 refs.c               | 144 +++++++++++----------
 refs.h               |  13 ++
 refs/files-backend.c | 347 ++++++++++++++++++++++++++++++---------------------
 refs/refs-internal.h |  28 ++---
 submodule.c          |  31 +++++
 submodule.h          |   1 +
 7 files changed, 346 insertions(+), 252 deletions(-)

-- 
2.11.0.157.gd943d85

