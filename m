Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08A4C48BE0
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 11:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2D12613B8
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 11:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbhFKLWG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 07:22:06 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:40623 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhFKLWG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 07:22:06 -0400
Received: by mail-ed1-f43.google.com with SMTP id t3so36685895edc.7
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 04:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NM3bHNp6opZ7P4HkjttchdQc2pk9SI1IqT+Qkpj5bMk=;
        b=aGkFQx/Xyhxw+vDI75VLCpKOWbxmTIlPoo/NYKnFIsV/sQ2Vp47ElpZ4f7eKZBi3hj
         wQNZsV3gIF5chrZqzjhoM2QcIFe48ClMT24FP0jCLrXKnOGnPWkCgvGmACvSO9MNDXKI
         9dFYB/cVKbx6r/qMExQXBV/ymWGlKRsBkMwrFrv3exD2EIGJoc8/ePA081/slulnb9C3
         1FgvtSWyyKi8+Vvzad0DzqU237I7NE1D5hqHPNwKIj825pCZ8umF/ZQRGhwessl688s/
         ZonF76dbciPn4uIrGUZWoP/aJE73La5GB3k2DCxIjlb/MoKhC9BTADtpaKznvBbGrh2o
         axwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NM3bHNp6opZ7P4HkjttchdQc2pk9SI1IqT+Qkpj5bMk=;
        b=Txr+2id8kDvPDsyz1w3SBLB60RThre+jbhhveZIo9u8rzGroLcjo9XSzVVlSv4SmRG
         NCFV5L6tZOUkIbQC+2hsPHrAPFespTWmbhm5Pga9Zc/+8qls8LgaxGPi1u3Be83oxzBx
         fSJZwM535qojs/TgBmB4kAck/gh8VCpPX9z9J7yhaF5FSvSdCDZcgZUti//xxmX/USPS
         t/7FdxDDBEwP7SNulFG6v2Oico8/42oaUDPcfRXvkWXZNu1r8TsjrL2SPFtkl/1zEb2m
         MYVsniwX8l7Rk24PaEdNE7tvNWFfOui+PtzVuujZGjBHQUzB/BxpEexQqabZTl4jkszM
         zcHQ==
X-Gm-Message-State: AOAM533p5v4eCV8cP02lKf6PazOjySEoZsseI4iZE90YnX4PxSXT+Ugi
        RXlaEUGUyWZrim0dZT39KkMDB0ctStX/mjqg
X-Google-Smtp-Source: ABdhPJxXxhNcvhrPm416zGzl5DBIFvaSM+BbBtXvpwEKiPm/MfAtTfRmUVQpttNIngwHvwMd2CMNcw==
X-Received: by 2002:a50:ee16:: with SMTP id g22mr3191035eds.27.1623410333307;
        Fri, 11 Jun 2021 04:18:53 -0700 (PDT)
Received: from localhost.localdomain ([138.199.18.64])
        by smtp.gmail.com with ESMTPSA id p13sm2005795ejr.87.2021.06.11.04.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 04:18:52 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     felipe.contreras@gmail.com, gitster@pobox.com
Subject: [PATCH v3] *: fix typos which duplicate a word
Date:   Fri, 11 Jun 2021 13:18:50 +0200
Message-Id: <20210611111850.3430523-1-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210609102641.3531183-1-rybak.a.v@gmail.com>
References: <20210609102641.3531183-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix typos in documentation, code comments, and RelNotes which repeat
various words.  In trivial cases, just delete the duplicated word and
rewrap text, if needed.  Reword the affected sentence in
Documentation/RelNotes/1.8.4.txt for it to make sense.

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---

Thanks to Felipe Contreras and Junio C Hamano for review.

Changes since v2:

  - reworded commit message
  - new fixes in files:
    - Documentation/RelNotes/1.6.0.3.txt
    - Documentation/RelNotes/1.8.4.txt
    - Documentation/RelNotes/2.29.0.txt
    - Documentation/RelNotes/2.8.0.txt
    - Documentation/technical/hash-function-transition.txt
    - merge-recursive.c

 Documentation/RelNotes/1.6.0.3.txt                   | 2 +-
 Documentation/RelNotes/1.8.4.txt                     | 2 +-
 Documentation/RelNotes/2.29.0.txt                    | 4 ++--
 Documentation/RelNotes/2.8.0.txt                     | 2 +-
 Documentation/technical/hash-function-transition.txt | 2 +-
 Documentation/technical/protocol-v2.txt              | 2 +-
 attr.c                                               | 2 +-
 builtin/log.c                                        | 3 +--
 git-compat-util.h                                    | 2 +-
 git-cvsserver.perl                                   | 2 +-
 merge-recursive.c                                    | 2 +-
 remote.c                                             | 2 +-
 t/t5505-remote.sh                                    | 2 +-
 t/t9100-git-svn-basic.sh                             | 2 +-
 14 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/Documentation/RelNotes/1.6.0.3.txt b/Documentation/RelNotes/1.6.0.3.txt
index ae0577836a..ad36c0f0b7 100644
--- a/Documentation/RelNotes/1.6.0.3.txt
+++ b/Documentation/RelNotes/1.6.0.3.txt
@@ -50,7 +50,7 @@ Fixes since v1.6.0.2
   if the working tree is currently dirty.
 
 * "git for-each-ref --format=%(subject)" fixed for commits with no
-  no newline in the message body.
+  newline in the message body.
 
 * "git remote" fixed to protect printf from user input.
 
diff --git a/Documentation/RelNotes/1.8.4.txt b/Documentation/RelNotes/1.8.4.txt
index 255e185af6..882fa713ef 100644
--- a/Documentation/RelNotes/1.8.4.txt
+++ b/Documentation/RelNotes/1.8.4.txt
@@ -365,7 +365,7 @@ details).
    (merge 2fbd4f9 mh/maint-lockfile-overflow later to maint).
 
  * Invocations of "git checkout" used internally by "git rebase" were
-   counted as "checkout", and affected later "git checkout -" to the
+   counted as "checkout", and affected later "git checkout -" which took
    the user to an unexpected place.
    (merge 3bed291 rr/rebase-checkout-reflog later to maint).
 
diff --git a/Documentation/RelNotes/2.29.0.txt b/Documentation/RelNotes/2.29.0.txt
index 06ba2f803f..1f41302ebb 100644
--- a/Documentation/RelNotes/2.29.0.txt
+++ b/Documentation/RelNotes/2.29.0.txt
@@ -184,8 +184,8 @@ Performance, Internal Implementation, Development Support etc.
    the ref backend in use, as its format is much richer than the
    normal refs, and written directly by "git fetch" as a plain file..
 
- * An unused binary has been discarded, and and a bunch of commands
-   have been turned into into built-in.
+ * An unused binary has been discarded, and a bunch of commands
+   have been turned into built-in.
 
  * A handful of places in in-tree code still relied on being able to
    execute the git subcommands, especially built-ins, in "git-foo"
diff --git a/Documentation/RelNotes/2.8.0.txt b/Documentation/RelNotes/2.8.0.txt
index 27320b6a9f..38453281b8 100644
--- a/Documentation/RelNotes/2.8.0.txt
+++ b/Documentation/RelNotes/2.8.0.txt
@@ -377,7 +377,7 @@ notes for details).
    on that order.
 
  * "git show 'HEAD:Foo[BAR]Baz'" did not interpret the argument as a
-   rev, i.e. the object named by the the pathname with wildcard
+   rev, i.e. the object named by the pathname with wildcard
    characters in a tree object.
    (merge aac4fac nd/dwim-wildcards-as-pathspecs later to maint).
 
diff --git a/Documentation/technical/hash-function-transition.txt b/Documentation/technical/hash-function-transition.txt
index 7c1630bf83..260224b033 100644
--- a/Documentation/technical/hash-function-transition.txt
+++ b/Documentation/technical/hash-function-transition.txt
@@ -599,7 +599,7 @@ supports four different modes of operation:
     convert any object names written to output to SHA-1, but store
     objects using SHA-256.  This allows users to test the code with no
     visible behavior change except for performance.  This allows
-    allows running even tests that assume the SHA-1 hash function, to
+    running even tests that assume the SHA-1 hash function, to
     sanity-check the behavior of the new mode.
 
  2. ("early transition") Allow both SHA-1 and SHA-256 object names in
diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
index a1e31367f4..1040d85319 100644
--- a/Documentation/technical/protocol-v2.txt
+++ b/Documentation/technical/protocol-v2.txt
@@ -540,7 +540,7 @@ An `object-info` request takes the following arguments:
 	Indicates to the server an object which the client wants to obtain
 	information for.
 
-The response of `object-info` is a list of the the requested object ids
+The response of `object-info` is a list of the requested object ids
 and associated requested information, each separated by a single space.
 
 	output = info flush-pkt
diff --git a/attr.c b/attr.c
index 9e897e43f5..d029e681f2 100644
--- a/attr.c
+++ b/attr.c
@@ -685,7 +685,7 @@ static struct attr_stack *read_attr_from_array(const char **list)
  * Callers into the attribute system assume there is a single, system-wide
  * global state where attributes are read from and when the state is flipped by
  * calling git_attr_set_direction(), the stack frames that have been
- * constructed need to be discarded so so that subsequent calls into the
+ * constructed need to be discarded so that subsequent calls into the
  * attribute system will lazily read from the right place.  Since changing
  * direction causes a global paradigm shift, it should not ever be called while
  * another thread could potentially be calling into the attribute system.
diff --git a/builtin/log.c b/builtin/log.c
index 6102893fcc..516a1142dd 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1968,8 +1968,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	} else if (rev.diffopt.close_file) {
 		/*
 		 * The diff code parsed --output; it has already opened the
-		 * file, but but we must instruct it not to close after each
-		 * diff.
+		 * file, but we must instruct it not to close after each diff.
 		 */
 		rev.diffopt.no_free = 1;
 	} else {
diff --git a/git-compat-util.h b/git-compat-util.h
index a508dbe5a3..df7dae9be1 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1368,7 +1368,7 @@ static inline void *container_of_or_null_offset(void *ptr, size_t offset)
 	(type *)container_of_or_null_offset(ptr, offsetof(type, member))
 
 /*
- * like offsetof(), but takes a pointer to a a variable of type which
+ * like offsetof(), but takes a pointer to a variable of type which
  * contains @member, instead of a specified type.
  * @ptr is subject to multiple evaluation since we can't rely on __typeof__
  * everywhere.
diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index f6f3fc192c..ed035f32c2 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -2149,7 +2149,7 @@ sub req_diff
                    ( $meta2->{revision} or "workingcopy" ));
 
         # TODO: Use --label instead of -L because -L is no longer
-        #  documented and may go away someday.  Not sure if there there are
+        #  documented and may go away someday.  Not sure if there are
         #  versions that only support -L, which would make this change risky?
         #  http://osdir.com/ml/bug-gnu-utils-gnu/2010-12/msg00060.html
         #    ("man diff" should actually document the best migration strategy,
diff --git a/merge-recursive.c b/merge-recursive.c
index d146bb116f..4327e0cfa3 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2152,7 +2152,7 @@ static char *handle_path_level_conflicts(struct merge_options *opt,
  *      implicit renaming of files that should be left in place.  (See
  *      testcase 6b in t6043 for details.)
  *   2. Prune directory renames if there are still files left in the
- *      the original directory.  These represent a partial directory rename,
+ *      original directory.  These represent a partial directory rename,
  *      i.e. a rename where only some of the files within the directory
  *      were renamed elsewhere.  (Technically, this could be done earlier
  *      in get_directory_renames(), except that would prevent us from
diff --git a/remote.c b/remote.c
index 6d1e8d02df..dfb863d808 100644
--- a/remote.c
+++ b/remote.c
@@ -1592,7 +1592,7 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 			else
 				/*
 				 * If the ref isn't stale, and is reachable
-				 * from from one of the reflog entries of
+				 * from one of the reflog entries of
 				 * the local branch, force the update.
 				 */
 				force_ref_update = 1;
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index c7b392794b..e6e3c8f552 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -182,7 +182,7 @@ test_expect_success 'rename errors out early when deleting non-existent branch'
 	)
 '
 
-test_expect_success 'rename errors out early when when new name is invalid' '
+test_expect_success 'rename errors out early when new name is invalid' '
 	test_config remote.foo.vcs bar &&
 	echo "fatal: '\''invalid...name'\'' is not a valid remote name" >expect &&
 	test_must_fail git remote rename foo invalid...name 2>actual &&
diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index 1d3fdcc997..ef35a54885 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -330,7 +330,7 @@ test_expect_success 'git-svn works in a bare repository' '
 	git svn fetch ) &&
 	rm -rf bare-repo
 	'
-test_expect_success 'git-svn works in in a repository with a gitdir: link' '
+test_expect_success 'git-svn works in a repository with a gitdir: link' '
 	mkdir worktree gitdir &&
 	( cd worktree &&
 	git svn init "$svnrepo" &&
-- 
2.31.1

