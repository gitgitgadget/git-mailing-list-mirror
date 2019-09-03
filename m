Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	SPOOFED_FREEMAIL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70F0A1F461
	for <e@80x24.org>; Tue,  3 Sep 2019 18:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbfICSE6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 14:04:58 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34814 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbfICSE6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 14:04:58 -0400
Received: by mail-wr1-f68.google.com with SMTP id s18so18521164wrn.1
        for <git@vger.kernel.org>; Tue, 03 Sep 2019 11:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=bYaXF+V5z/TzhOnlHnATq4j2R77dE6oiTNeK1m+Ol/M=;
        b=nmTYgISeIt9V1mMrktDzGFXwtb2MKuwf4K12lp4iYEdniWiHBIawMS9qKQXepthdld
         KTFhjcjduAONcCb2HQnc0fS3EVdGimgJ0GOcqpDA6wxeNuYGUQ1OJ3FDgryQMshfpMsS
         WB+kADrVj7kvnsjjLU8XyD1LXXGgdcfmSRJuVo/H+3uNvDFXX++yhDT9mq9+ayoQgve6
         mVgMv2djCwch3haQpRbwW7XzR9sceR9IGC1Oj7J3y2iyVCASkct4ZKh/Yi2o4LHymexA
         0/k2MuISNTjW8fuPOJUjkNZ7HfGMRt1N1z1lTJ32b3OZxyu56U3eL/k8F5u0bUMS9CRf
         1qpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bYaXF+V5z/TzhOnlHnATq4j2R77dE6oiTNeK1m+Ol/M=;
        b=hae3c6UhDwMFSw/LocfBevq1SRLIa/qw96G671z2hw0JyCs+WO4JpRkYXZ6aRHhttr
         cu59i35d4f+R+w/ar2I6GzhUgd1m5H/A6pHkuH4zxuKpvwPX8i+5wLTgehVLqybcHS3m
         8ZNVOz3rYqloQr7E1CVD43oof6wYCLa5m4owKd47sGQ6JgcISSN7JKSCp410lGLx2w+o
         wyDgnSj3x08AvCuq3xpSPaTn3toMW4Ebvh3WUQB+KlOPoTe4YEl4BVtTQlbuMhhptUw0
         FmBpH0tJghwUyB4npR1hLBt335XkURuhahVNsoLi7xbWm4OPnBt3HMtdeqvSQpO6qqg6
         W11w==
X-Gm-Message-State: APjAAAX9vpzilANsFmccZ3s+iidch7FycOyBE5+CIgH31bli1pQJsumH
        wFJqKe3oEKCwnf66TM+RNZgm+kNd
X-Google-Smtp-Source: APXvYqyGSMdK0mpdmxlriIyNr71vpWRfdUBVkLoLe08EtgHz0FCBCJrrAC8WM3b7V1iIZPcE3PabKg==
X-Received: by 2002:adf:dfc8:: with SMTP id q8mr11455590wrn.121.1567533894944;
        Tue, 03 Sep 2019 11:04:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b26sm450419wmj.14.2019.09.03.11.04.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Sep 2019 11:04:54 -0700 (PDT)
Date:   Tue, 03 Sep 2019 11:04:54 -0700 (PDT)
X-Google-Original-Date: Tue, 03 Sep 2019 18:04:48 GMT
Message-Id: <pull.329.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/5] Refactor excludes library
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, pclouds@gmail.com, peff@peff.net,
        jon@jonsimons.org, matvore@comcast.net,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The exclude library defined in dir.h was originally written for the
.gitignore feature, but has since been used for .gitattributes and
sparse-checkout. In the later applications, these patterns are used for 
inclusion rather than exclusion, so the name is confusing. This gets
particularly bad when looking at how the sparse-checkout feature uses
is_excluded_from_list() to really mean "should be included in the working
directory".

This series performs several renames of structs and methods to generalize
the exclude library to be a "pattern matching" library. Instead of a list of
excludes, we have a list of path patterns. It is up to the consumer to
decide what to do with a match. The .gitignore logic will still treat the
patterns as a list of exclusions, the sparse-checkout logic treats the
patterns as a list of inclusions.

For this reason, some methods and structs in dir.h retain "exclude" in their
name. These are limited to things consumed only by the .gitignore feature
(as far as I can tell).

Most of these changes are mechanical find-and-replaces, with the exception
of some variable names and the last patch.

The last patch, "unpack-trees: rename 'is_excluded_from_list()'", performs a
more meaningful refactor. The method is_excluded_from_list() was only used
by sparse-checkout (inside the clear_ce_flags() methods) to see if a path
should be included in the working directory. The return value of "1 for
excluded" was confusing. Instead, use a new enum value. This required
changing several method prototypes inside unpack-trees.c.

This refactor was inspired by Elijah Newren's feedback [1] on my
sparse-checkout builtin RFC. I am working on a few other orthogonal changes
to make to the existing sparse-checkout behavior before I resubmit that RFC.

I had started working on v2.23.0, but found adjacent-diff conflicts with
md/list-objects-filter-combo [2] and js/partial-clone-sparse-blob [3]. Those
branches are independent, but the conflicts with
md/list-objects-filter-combo were more severe (and that branch seems closer
to merging) so this is based on md/list-object-filter-combo. Hopefully the
conflicts with js/partial-clone-sparse-blob are clear enough to resolve
easily.

Thanks, -Stolee

[1] 
https://public-inbox.org/git/CABPp-BFMtO=7UGVZPbqh3tthSetvz5F=W3S=RsryPSuchmZeZw@mail.gmail.com/
Re: [PATCH 8/9] sparse-checkout: use hashmaps for cone patterns

[2] https://public-inbox.org/git/cover.1558030802.git.matvore@google.com/
[RFC PATCH 0/3] implement composite filters

[3] https://public-inbox.org/git/20190828201824.1255-1-jon@jonsimons.org/
[PATCH 0/2] partial-clone: fix two issues with sparse filter handling

Derrick Stolee (5):
  treewide: rename 'struct exclude' to 'struct path_pattern'
  treewide: rename 'struct exclude_list' to 'struct pattern_list'
  treewide: rename 'EXCL_FLAG_' to 'PATTERN_FLAG_'
  treewide: rename 'exclude' methods to 'pattern'
  unpack-trees: rename 'is_excluded_from_list()'

 Documentation/RelNotes/2.7.1.txt              |   2 +-
 Documentation/RelNotes/2.8.0.txt              |   2 +-
 .../technical/api-directory-listing.txt       |   6 +-
 attr.c                                        |  10 +-
 builtin/check-ignore.c                        |  34 +--
 builtin/clean.c                               |  12 +-
 builtin/ls-files.c                            |   8 +-
 dir.c                                         | 284 +++++++++---------
 dir.h                                         |  71 +++--
 list-objects-filter.c                         |  37 +--
 unpack-trees.c                                |  67 +++--
 unpack-trees.h                                |   4 +-
 12 files changed, 285 insertions(+), 252 deletions(-)


base-commit: 90d21f9ebf6906f0ebb4fb1b20ec9536072e2916
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-329%2Fderrickstolee%2Fexclude-refactor-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-329/derrickstolee/exclude-refactor-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/329
-- 
gitgitgadget
