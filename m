Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EDDF1F97E
	for <e@80x24.org>; Fri,  5 Oct 2018 21:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727475AbeJFEyw (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Oct 2018 00:54:52 -0400
Received: from mail-yb1-f202.google.com ([209.85.219.202]:46937 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbeJFEyw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Oct 2018 00:54:52 -0400
Received: by mail-yb1-f202.google.com with SMTP id m16-v6so7857133ybp.13
        for <git@vger.kernel.org>; Fri, 05 Oct 2018 14:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8PXU7PNPLDIaN4lV8/x7pRZrfnwdnW7XxMUtOK8az/c=;
        b=jU6eHk7olQZE5hzpC2DSrc/dPlJYYL7nKqcY12VuQ4l8scBTL4mFqiwJj9Y1hoLT5m
         +4oHEcpoTT4qZYtW4cCFKa2sLbwewgw6XwikI2peVal82icl5tWiBiIsVONysfmfBQqH
         rLebA5XYW5p8w2yC33ou13Fy6X3m31D7UzjFnrMWrVKIbxukBib1cjJ8mw7J7hBOVAJW
         wbOhhGT6pbgoCaf9RXHS8oWzGU+LoHasiUy9kkTKYJC1Eu4J0gImwzOnn45LA4urUJ+B
         EKZ5LZ3Q1Tz7hGGVE9Vz7PYnLpJcepPy7ZbLbdofq+ki/wL/5bKE6TWeB+dgof6an3Ed
         6rUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8PXU7PNPLDIaN4lV8/x7pRZrfnwdnW7XxMUtOK8az/c=;
        b=h7n21uESAe6EigyI0RWQNmWm0Pw5KLmRxpSvACDeLicu1ne7xwhx/hFgSsJCr6lpWQ
         WB8J/HRNXh17LQ4Yjb/Nl7XWQU8RgWR7tVGMcCzP3sNrK3CVAgC1Lnl/IjKpErqh2QZV
         Tm+pGwmUAKc0IiW9C2IC4BUP+9EhHewDn+uIcr0FAaO/0Hk6GESDO0qqU81b1Q8SBZfe
         cyENxY1WHWZCDzJwUjPoZSGknBQgV18P6YCs3dMrc0u8iGINKeYN2hvaeR5Dk1EC79xn
         N0x0bQi+z6N/ZvTATdz4Yph6zaE2UyF9IorEkm2RlilQDU8zNFORz+S6jFvDxUXLLucT
         Imzg==
X-Gm-Message-State: ABuFfohHDpsK0jPiZUz4AoFQhaSjxMgCDUJqqhTBlsLlLlYUrlF90T6a
        NsPmbQaBtzXFTfSEQuHDqGeNcfwpVtz2tnro5o0ji16exXOgI4iTgxe05oM8E85DHbkDnyZSVQt
        ywkR/A6oirsuPdpn1/kVJBeYvS8X5Gf72WtlcTA4Z9E8uqnung1TxWwcjiAI=
X-Google-Smtp-Source: ACcGV61Cno4XiIZFYoESdnVqa8bfXg7RcEK5g4DupkZAfuPqkumezLJkhYyf3FGKdVaS11nH7/pZvYBxQhoa
X-Received: by 2002:a25:5888:: with SMTP id m130-v6mr7260409ybb.34.1538776453133;
 Fri, 05 Oct 2018 14:54:13 -0700 (PDT)
Date:   Fri,  5 Oct 2018 14:54:00 -0700
In-Reply-To: <cover.1536969438.git.matvore@google.com>
Message-Id: <cover.1538775186.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1536969438.git.matvore@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH v5 0/7] subject: Clean up tests for test_cmp arg ordering and
 pipe placement
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, peff@peff.net,
        jonathantanmy@google.com, gitster@pobox.com, jrn@google.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This version of the patchset fixes some wording and formatting issues
pointed out by Junio. The commit message in the first patch has also
been reworded.

Thank you,
Matt

diff --git a/t/README b/t/README
index 9a71d5732..ab9fa4230 100644
--- a/t/README
+++ b/t/README
@@ -394,7 +394,7 @@ This test harness library does the following things:
    --debug (or -d), and --immediate (or -i) is given.
 
 Do's & don'ts
--------------------------------------
+-------------
 
 Here are a few examples of things you probably should and shouldn't do
 when writing tests.
@@ -466,8 +466,7 @@ And here are the "don'ts:"
    platform commands; just use '! cmd'.  We are not in the business
    of verifying that the world given to us sanely works.
 
- - Don't use Git upstream in the non-final position in a piped chain, as
-   in:
+ - Don't feed the output of a git command to a pipe, as in:
 
      git -C repo ls-files |
      xargs -n 1 basename |
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index eeedd1623..6ff614692 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -35,7 +35,7 @@ test_expect_success 'setup bare clone for server' '
 test_expect_success 'do partial clone 1' '
         git clone --no-checkout --filter=blob:none "file://$(pwd)/srv.bare" pc1 &&
 
-        git -C pc1 rev-list --quiet --objects --missing=print >revs HEAD &&
+        git -C pc1 rev-list --quiet --objects --missing=print HEAD >revs &&
         awk -f print_1.awk revs |
         sed "s/?//" |
         sort >observed.oids &&
@@ -93,8 +93,8 @@ test_expect_success 'verify diff causes dynamic object fetch' '
 test_expect_success 'verify blame causes dynamic object fetch' '
         git -C pc1 blame origin/master -- file.1.txt >observed.blame &&
         test_cmp expect.blame observed.blame &&
-        git -C pc1 rev-list --quiet --objects --missing=print >observed \
-                master..origin/master &&
+        git -C pc1 rev-list --quiet --objects --missing=print \
+                master..origin/master >observed &&
         test_line_count = 0 observed
 '
 

Matthew DeVore (7):
  t/README: reformat Do, Don't, Keep in mind lists
  Documentation: add shell guidelines
  tests: standardize pipe placement
  t/*: fix ordering of expected/observed arguments
  tests: don't swallow Git errors upstream of pipes
  t9109: don't swallow Git errors upstream of pipes
  tests: order arguments to git-rev-list properly

 Documentation/CodingGuidelines         |  18 ++
 t/README                               |  69 +++--
 t/lib-gpg.sh                           |   9 +-
 t/t0000-basic.sh                       |   2 +-
 t/t0021-conversion.sh                  |   4 +-
 t/t1006-cat-file.sh                    |   8 +-
 t/t1300-config.sh                      |   9 +-
 t/t1303-wacky-config.sh                |   4 +-
 t/t2101-update-index-reupdate.sh       |   2 +-
 t/t3200-branch.sh                      |   2 +-
 t/t3320-notes-merge-worktrees.sh       |   4 +-
 t/t3400-rebase.sh                      |   8 +-
 t/t3417-rebase-whitespace-fix.sh       |   6 +-
 t/t3702-add-edit.sh                    |   4 +-
 t/t3903-stash.sh                       |   8 +-
 t/t3905-stash-include-untracked.sh     |   2 +-
 t/t4025-hunk-header.sh                 |   2 +-
 t/t4117-apply-reject.sh                |   6 +-
 t/t4124-apply-ws-rule.sh               |  30 +--
 t/t4138-apply-ws-expansion.sh          |   2 +-
 t/t5317-pack-objects-filter-objects.sh | 360 ++++++++++++++-----------
 t/t5318-commit-graph.sh                |   2 +-
 t/t5500-fetch-pack.sh                  |   7 +-
 t/t5616-partial-clone.sh               |  50 ++--
 t/t5701-git-serve.sh                   |  14 +-
 t/t5702-protocol-v2.sh                 |  14 +-
 t/t6023-merge-file.sh                  |  12 +-
 t/t6027-merge-binary.sh                |   4 +-
 t/t6031-merge-filemode.sh              |   2 +-
 t/t6112-rev-list-filters-objects.sh    | 237 +++++++++-------
 t/t7201-co.sh                          |   4 +-
 t/t7406-submodule-update.sh            |   8 +-
 t/t7800-difftool.sh                    |   2 +-
 t/t9100-git-svn-basic.sh               |   2 +-
 t/t9101-git-svn-props.sh               |  34 ++-
 t/t9133-git-svn-nested-git-repo.sh     |   6 +-
 t/t9600-cvsimport.sh                   |   2 +-
 t/t9603-cvsimport-patchsets.sh         |   4 +-
 t/t9604-cvsimport-timestamps.sh        |   4 +-
 39 files changed, 568 insertions(+), 399 deletions(-)

-- 
2.19.0.605.g01d371f741-goog

