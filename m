Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412D4CD613F
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 21:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378848AbjJIV7D (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 17:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378789AbjJIV7B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 17:59:01 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE71199
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 14:58:59 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-405497850dbso46907415e9.0
        for <git@vger.kernel.org>; Mon, 09 Oct 2023 14:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696888738; x=1697493538; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s11bODZEakhGdR+zOZGuYd5a5ILcB4q914ODA4acxOA=;
        b=aJKNQcmGj4z88mmZRTLWgdAra11plg1VNmU2Dd1DJREqNzZhwW8TKWYADafJ9HHm2s
         znuCQb5MklfRzNRGmZqwfp1ShBcgPqZE+zRHdmFy+pyrlspbRnzUwC0BOUCC5F4tid+w
         narTrshGotAtqKBSfo1boK+osSr4TmVDMXmmZYhvWhC0C+QGtjdMVv/yPr73S2cZX0yO
         k0JlvvDM946QZXzyEWze5iRQcuUNCkNi1hypWlCFuLErx8sqGwlzq24MO0thV6nop6+6
         P3fHYrOJaX3FebyOQljk8j3wId7Ix453dU8L7XKNUW7j6CaVPbkBht2oZNV1p7dOtCrZ
         v2Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696888738; x=1697493538;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s11bODZEakhGdR+zOZGuYd5a5ILcB4q914ODA4acxOA=;
        b=GQ7/wFx79bYA/sYLsIsIEk9hbCE5UB9cvE1d7hdyO7REXWhTFjz6I+a1Fa4FyIEeuJ
         0Z5oHct4Hd7OBYEywuLFHwvJ+gL3P1N0KGzv5HBtf7ILu5YW+Gx2IL6QGdoX0dkm+usR
         I9iqxYZVV4IyCpTQS2Un6nlN9G8Rb1EGfWzPcz9KtKCCNf+gl+UvE8dC1NPz6YV+Nt7F
         V3g1GQLWblfOLXemuCneijCBZoMO3KhUET+CYhXL1Hl7+JY/ucbiIU2u/SPfHLGAytMl
         oVvRpvB54GTxUvy/2CoKsXSmlpv37fcQdPFW+PUPmXMXwXWF16xmCK0/UrE9/15U1cUv
         GGow==
X-Gm-Message-State: AOJu0YyZivoaRaeWUVSjWIXHih5Tx96uy1Rf24IPoqBomUXMEGtV2QLc
        ssULJXgluGzF385jBCAWSS4iMwoJ79k=
X-Google-Smtp-Source: AGHT+IFkWrWF0ds2Yt0KJq57CQogAmfQlcJ/nf/zjGlAikZOgWkuMp/8zcSoOq9i4XSxwxiEZAAycA==
X-Received: by 2002:a5d:50c8:0:b0:321:677d:98b0 with SMTP id f8-20020a5d50c8000000b00321677d98b0mr15546069wrt.11.1696888737587;
        Mon, 09 Oct 2023 14:58:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g7-20020adfe407000000b003232d122dbfsm10757587wrm.66.2023.10.09.14.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 14:58:57 -0700 (PDT)
Message-ID: <pull.1594.v2.git.1696888736.gitgitgadget@gmail.com>
In-Reply-To: <pull.1594.git.1696615769.gitgitgadget@gmail.com>
References: <pull.1594.git.1696615769.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 09 Oct 2023 21:58:52 +0000
Subject: [PATCH v2 0/4] Performance improvement & cleanup in loose ref iteration
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While investigating ref iteration performance in builtins like
'for-each-ref' and 'show-ref', I found two small improvement opportunities.

The first patch tweaks the logic around prefix matching in
'cache_ref_iterator_advance' so that we correctly skip refs that do not
actually match a given prefix. The unnecessary iteration doesn't seem to be
causing any bugs in the ref iteration commands that I've tested, but it
doesn't hurt to be more precise (and it helps with some other patches I'm
working on ;) ).

The next three patches update how 'loose_fill_ref_dir' determines the type
of ref cache entry to create (directory or regular). On platforms that
include d_type information in 'struct dirent' (as far as I can tell, all
except NonStop & certain versions of Cygwin), this allows us to skip calling
'stat'. Benchmarking against repos with various quantities of loose refs
indicates a 5-8% speedup from these changes [1].


Changes since V1
================

 * Added tests in patch 1 to demonstrate the bugfix

Thanks!

 * Victoria

[1]
https://lore.kernel.org/git/28ae03f5-7091-d3f3-8a70-56aba6639640@github.com/

Victoria Dye (4):
  ref-cache.c: fix prefix matching in ref iteration
  dir.[ch]: expose 'get_dtype'
  dir.[ch]: add 'follow_symlink' arg to 'get_dtype'
  files-backend.c: avoid stat in 'loose_fill_ref_dir'

 diagnose.c                    | 42 +++--------------------------------
 dir.c                         | 33 +++++++++++++++++++++++++++
 dir.h                         | 16 +++++++++++++
 refs/files-backend.c          | 14 +++++-------
 refs/ref-cache.c              |  3 ++-
 t/t1500-rev-parse.sh          | 23 +++++++++++++++++++
 t/t4205-log-pretty-formats.sh | 30 +++++++++++++++++++++++++
 7 files changed, 112 insertions(+), 49 deletions(-)


base-commit: 3a06386e314565108ad56a9bdb8f7b80ac52fb69
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1594%2Fvdye%2Fvdye%2Fref-iteration-cleanup-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1594/vdye/vdye/ref-iteration-cleanup-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1594

Range-diff vs v1:

 1:  59276a5b3fd ! 1:  402176246ea ref-cache.c: fix prefix matching in ref iteration
     @@ Commit message
          'create_dir_entry' explicitly calls out the trailing slash requirement, so
          this is a safe assumption to make.
      
     +    This bug generally doesn't have any user-facing impact, since it requires:
     +
     +    1. using a non-empty prefix without a trailing slash in an iteration like
     +       'for_each_fullref_in',
     +    2. the callback to said iteration not reapplying the original filter (as
     +       for-each-ref does) to ensure unmatched refs are skipped, and
     +    3. the repository having one or more refs that match part of, but not all
     +       of, the prefix.
     +
     +    However, there are some niche scenarios that meet those criteria
     +    (specifically, 'rev-parse --bisect' and '(log|show|shortlog) --bisect'). Add
     +    tests covering those cases to demonstrate the fix in this patch.
     +
          Signed-off-by: Victoria Dye <vdye@github.com>
      
       ## refs/ref-cache.c ##
     @@ refs/ref-cache.c: static int cache_ref_iterator_advance(struct ref_iterator *ref
       				continue;
       		} else {
       			entry_prefix_state = level->prefix_state;
     +
     + ## t/t1500-rev-parse.sh ##
     +@@ t/t1500-rev-parse.sh: test_expect_success 'rev-parse --since= unsqueezed ordering' '
     + 	test_cmp expect actual
     + '
     + 
     ++test_expect_success 'rev-parse --bisect includes bad, excludes good' '
     ++	test_commit_bulk 6 &&
     ++
     ++	git update-ref refs/bisect/bad-1 HEAD~1 &&
     ++	git update-ref refs/bisect/b HEAD~2 &&
     ++	git update-ref refs/bisect/bad-3 HEAD~3 &&
     ++	git update-ref refs/bisect/good-3 HEAD~3 &&
     ++	git update-ref refs/bisect/bad-4 HEAD~4 &&
     ++	git update-ref refs/bisect/go HEAD~4 &&
     ++
     ++	# Note: refs/bisect/b and refs/bisect/go should be ignored because they
     ++	# do not match the refs/bisect/bad or refs/bisect/good prefixes.
     ++	cat >expect <<-EOF &&
     ++	refs/bisect/bad-1
     ++	refs/bisect/bad-3
     ++	refs/bisect/bad-4
     ++	^refs/bisect/good-3
     ++	EOF
     ++
     ++	git rev-parse --symbolic-full-name --bisect >actual &&
     ++	test_cmp expect actual
     ++'
     ++
     + test_done
     +
     + ## t/t4205-log-pretty-formats.sh ##
     +@@ t/t4205-log-pretty-formats.sh: test_expect_success '%S in git log --format works with other placeholders (part
     + 	test_cmp expect actual
     + '
     + 
     ++test_expect_success 'setup more commits for %S with --bisect' '
     ++	test_commit four &&
     ++	test_commit five &&
     ++
     ++	head1=$(git rev-parse --verify HEAD~0) &&
     ++	head2=$(git rev-parse --verify HEAD~1) &&
     ++	head3=$(git rev-parse --verify HEAD~2) &&
     ++	head4=$(git rev-parse --verify HEAD~3)
     ++'
     ++
     ++test_expect_success '%S with --bisect labels commits with refs/bisect/bad ref' '
     ++	git update-ref refs/bisect/bad-$head1 $head1 &&
     ++	git update-ref refs/bisect/go $head1 &&
     ++	git update-ref refs/bisect/bad-$head2 $head2 &&
     ++	git update-ref refs/bisect/b $head3 &&
     ++	git update-ref refs/bisect/bad-$head4 $head4 &&
     ++	git update-ref refs/bisect/good-$head4 $head4 &&
     ++
     ++	# We expect to see the range of commits betwee refs/bisect/good-$head4
     ++	# and refs/bisect/bad-$head1. The "source" ref is the nearest bisect ref
     ++	# from which the commit is reachable.
     ++	cat >expect <<-EOF &&
     ++	$head1 refs/bisect/bad-$head1
     ++	$head2 refs/bisect/bad-$head2
     ++	$head3 refs/bisect/bad-$head2
     ++	EOF
     ++	git log --bisect --format="%H %S" >actual &&
     ++	test_cmp expect actual
     ++'
     ++
     + test_expect_success 'log --pretty=reference' '
     + 	git log --pretty="tformat:%h (%s, %as)" >expect &&
     + 	git log --pretty=reference >actual &&
 2:  24014010ea3 = 2:  172538b5e30 dir.[ch]: expose 'get_dtype'
 3:  a382d2ba652 = 3:  295ca94003b dir.[ch]: add 'follow_symlink' arg to 'get_dtype'
 4:  e193a453182 = 4:  e89501cb51f files-backend.c: avoid stat in 'loose_fill_ref_dir'

-- 
gitgitgadget
