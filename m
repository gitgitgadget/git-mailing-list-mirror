Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 002171F6BD
	for <e@80x24.org>; Thu,  2 Feb 2017 08:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750984AbdBBIuQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 03:50:16 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33985 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750937AbdBBIuP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 03:50:15 -0500
Received: by mail-pg0-f68.google.com with SMTP id 3so1261775pgj.1
        for <git@vger.kernel.org>; Thu, 02 Feb 2017 00:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KRwGpPb5koF0ggyRUqPmWAYul1z0gIB3scUsc2Je6L4=;
        b=kasPZxmm9T7ofkdpBHPWmhlbp3lipQSBByWI0BWm2OCvVTT2A0Lg2XcG/p/J4waI5g
         NBEcon8eNu/td2ZpcypY9B/UVR8gaUIfhvMVxmgCMbFu+hk21y9rY1oIDhR6snHzaP3M
         08VFhpni271IoaJn+/8R/t1TfJS9hCgcYyy+dRhY/ETE+SfWT+QeV+FK9SpHFCvgNvp3
         OtHxC/857XwAHtmc2Dvh4vxd/nHr6SJHTj4qzdM3yKYtizaggdBhag0otT5eFt4RO9PE
         lxiKIBIjmKmLKRclnf5y0G91NFg5qBt9h8StLlEUbyA/Z6x6eiFinq6TI8H5IHIf7/d7
         XejA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KRwGpPb5koF0ggyRUqPmWAYul1z0gIB3scUsc2Je6L4=;
        b=EoNT2icP6VskAu2toXKIdwMBzZCd/QwHc5FYVV9Jv8GQ9unnOvGB7vnIxDWNA71fzC
         XsLbmgG0q4fCaKGBWhTmNnanQrXg3hivxoGCCJMKv7BGL8zw3VMP1776fhB0SFaCxXS7
         cE9tPz1FhZpnpAsdt0rOi7d4CnDMbA+4tW3jaUlrwkhTOoQlt9hlzzniHHhbateM4ilx
         kS0PpzdyAIj2SnCHzgPVrb5wY7scvtwM7g/2bnZyC1mlKG+iNlficYm05SHF9O4NiuuQ
         pWu4joRsXkekbcUc0znmTT9CaRdzMUmRicJEGZiA8BTN9ab2YbQiEvd12df6CZcjpRmC
         HUzQ==
X-Gm-Message-State: AIkVDXIPiljMixLDKcmuMC6BTkULGGAMdGBtCSUfc1wV04HvxDOl462D8yzdXXXRwPEW6A==
X-Received: by 10.84.225.20 with SMTP id t20mr10947748plj.154.1486025415029;
        Thu, 02 Feb 2017 00:50:15 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id w2sm56099475pfi.65.2017.02.02.00.50.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Feb 2017 00:50:13 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 02 Feb 2017 15:50:08 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 00/11] nd/worktree-move update
Date:   Thu,  2 Feb 2017 15:49:56 +0700
Message-Id: <20170202085007.21418-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This squashes two changes from Johannes and Ramsay:

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 339c622e20..a1c91f1542 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -528,7 +528,7 @@ static int unlock_worktree(int ac, const char **av, const char *prefix)
 
 static void validate_no_submodules(const struct worktree *wt)
 {
-	struct index_state istate = {0};
+	struct index_state istate = { NULL };
 	int i, found_submodules = 0;
 
 	if (read_index_from(&istate, worktree_git_path(wt, "index")) > 0) {
diff --git a/t/t2028-worktree-move.sh b/t/t2028-worktree-move.sh
index 084acc6c6d..b3105eaaed 100755
--- a/t/t2028-worktree-move.sh
+++ b/t/t2028-worktree-move.sh
@@ -71,13 +71,14 @@ test_expect_success 'move locked worktree' '
 '
 
 test_expect_success 'move worktree' '
+	toplevel="$(pwd)" &&
 	git worktree move source destination &&
 	test_path_is_missing source &&
 	git worktree list --porcelain | grep "^worktree" >actual &&
 	cat <<-EOF >expected &&
-	worktree $TRASH_DIRECTORY
-	worktree $TRASH_DIRECTORY/destination
-	worktree $TRASH_DIRECTORY/elsewhere
+	worktree $toplevel
+	worktree $toplevel/destination
+	worktree $toplevel/elsewhere
 	EOF
 	test_cmp expected actual &&
 	git -C destination log --format=%s >actual2 &&


Nguyễn Thái Ngọc Duy (11):
  worktree.c: zero new 'struct worktree' on allocation
  worktree: reorder an if statement
  get_worktrees() must return main worktree as first item even on error
  worktree.c: get_worktrees() takes a new flag argument
  worktree list: keep the list sorted
  worktree.c: add validate_worktree()
  worktree.c: add update_worktree_location()
  worktree move: new command
  worktree move: accept destination as directory
  worktree move: refuse to move worktrees with submodules
  worktree remove: new command

 Documentation/git-worktree.txt         |  28 ++++--
 branch.c                               |   2 +-
 builtin/branch.c                       |   2 +-
 builtin/worktree.c                     | 176 +++++++++++++++++++++++++++++++--
 contrib/completion/git-completion.bash |   5 +-
 t/t2027-worktree-list.sh               |  40 ++++++++
 t/t2028-worktree-move.sh               |  57 +++++++++++
 worktree.c                             | 126 +++++++++++++++++++----
 worktree.h                             |  15 ++-
 9 files changed, 410 insertions(+), 41 deletions(-)

-- 
2.11.0.157.gd943d85

