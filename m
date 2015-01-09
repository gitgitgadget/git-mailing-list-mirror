From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH] Makefile: collect BUILTIN_OBJS instead of directly writing by hand
Date: Sat, 10 Jan 2015 01:16:47 +0600
Message-ID: <1420831007-18251-1-git-send-email-kuleshovmail@gmail.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 09 20:17:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9f3V-0001HE-9Y
	for gcvg-git-2@plane.gmane.org; Fri, 09 Jan 2015 20:17:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757983AbbAITRD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2015 14:17:03 -0500
Received: from mail-lb0-f180.google.com ([209.85.217.180]:49221 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191AbbAITRA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2015 14:17:00 -0500
Received: by mail-lb0-f180.google.com with SMTP id l4so9663011lbv.11
        for <git@vger.kernel.org>; Fri, 09 Jan 2015 11:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=rgOAqQbDibr+BPwlKrcqVG0MCaDWqHmx1W465rGoIOY=;
        b=tRGCkZ8/+5DrbgJM/a0pIioowsMU14dPcIr1se5TqD2ECutza67xoz6Kk360IgK2NB
         Qhm3Y89KfCyaV6z8pPxhEEcxqUq0IY2jFtSZSS/DiHjxQgCEMy6k6S6CgvnqzqdvPqIW
         wXEbG363I0vvC2JWN9zNQDFirYCUp0sDr6TnnvgEviKQxWl1fn8T3YYsKGTFfi9mj1Q/
         tpfAtwdY8mzAUCIqgq5+c59nxnchcVqY9IFu7T5egnsEkNC1H0hLxSL7F9LhuQBIqHKJ
         RP+jtCuOJUI47dEtACcMY69kUNGgLNG8SkmNqXDMUplD9gvwIJYVKLJ1cIDHUcWFm9Ys
         +yfw==
X-Received: by 10.152.204.70 with SMTP id kw6mr23549431lac.53.1420831018629;
        Fri, 09 Jan 2015 11:16:58 -0800 (PST)
Received: from localhost.localdomain ([95.59.128.173])
        by mx.google.com with ESMTPSA id ei11sm2049024lad.18.2015.01.09.11.16.56
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Jan 2015 11:16:57 -0800 (PST)
X-Mailer: git-send-email 2.2.1.268.g1e6f5b2.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262241>

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 Makefile | 100 +--------------------------------------------------------------
 1 file changed, 1 insertion(+), 99 deletions(-)

diff --git a/Makefile b/Makefile
index 082d9ba..1f06624 100644
--- a/Makefile
+++ b/Makefile
@@ -797,105 +797,7 @@ LIB_OBJS += wt-status.o
 LIB_OBJS += xdiff-interface.o
 LIB_OBJS += zlib.o
 
-BUILTIN_OBJS += builtin/add.o
-BUILTIN_OBJS += builtin/annotate.o
-BUILTIN_OBJS += builtin/apply.o
-BUILTIN_OBJS += builtin/archive.o
-BUILTIN_OBJS += builtin/bisect--helper.o
-BUILTIN_OBJS += builtin/blame.o
-BUILTIN_OBJS += builtin/branch.o
-BUILTIN_OBJS += builtin/bundle.o
-BUILTIN_OBJS += builtin/cat-file.o
-BUILTIN_OBJS += builtin/check-attr.o
-BUILTIN_OBJS += builtin/check-ignore.o
-BUILTIN_OBJS += builtin/check-mailmap.o
-BUILTIN_OBJS += builtin/check-ref-format.o
-BUILTIN_OBJS += builtin/checkout-index.o
-BUILTIN_OBJS += builtin/checkout.o
-BUILTIN_OBJS += builtin/clean.o
-BUILTIN_OBJS += builtin/clone.o
-BUILTIN_OBJS += builtin/column.o
-BUILTIN_OBJS += builtin/commit-tree.o
-BUILTIN_OBJS += builtin/commit.o
-BUILTIN_OBJS += builtin/config.o
-BUILTIN_OBJS += builtin/count-objects.o
-BUILTIN_OBJS += builtin/credential.o
-BUILTIN_OBJS += builtin/describe.o
-BUILTIN_OBJS += builtin/diff-files.o
-BUILTIN_OBJS += builtin/diff-index.o
-BUILTIN_OBJS += builtin/diff-tree.o
-BUILTIN_OBJS += builtin/diff.o
-BUILTIN_OBJS += builtin/fast-export.o
-BUILTIN_OBJS += builtin/fetch-pack.o
-BUILTIN_OBJS += builtin/fetch.o
-BUILTIN_OBJS += builtin/fmt-merge-msg.o
-BUILTIN_OBJS += builtin/for-each-ref.o
-BUILTIN_OBJS += builtin/fsck.o
-BUILTIN_OBJS += builtin/gc.o
-BUILTIN_OBJS += builtin/get-tar-commit-id.o
-BUILTIN_OBJS += builtin/grep.o
-BUILTIN_OBJS += builtin/hash-object.o
-BUILTIN_OBJS += builtin/help.o
-BUILTIN_OBJS += builtin/index-pack.o
-BUILTIN_OBJS += builtin/init-db.o
-BUILTIN_OBJS += builtin/interpret-trailers.o
-BUILTIN_OBJS += builtin/log.o
-BUILTIN_OBJS += builtin/ls-files.o
-BUILTIN_OBJS += builtin/ls-remote.o
-BUILTIN_OBJS += builtin/ls-tree.o
-BUILTIN_OBJS += builtin/mailinfo.o
-BUILTIN_OBJS += builtin/mailsplit.o
-BUILTIN_OBJS += builtin/merge.o
-BUILTIN_OBJS += builtin/merge-base.o
-BUILTIN_OBJS += builtin/merge-file.o
-BUILTIN_OBJS += builtin/merge-index.o
-BUILTIN_OBJS += builtin/merge-ours.o
-BUILTIN_OBJS += builtin/merge-recursive.o
-BUILTIN_OBJS += builtin/merge-tree.o
-BUILTIN_OBJS += builtin/mktag.o
-BUILTIN_OBJS += builtin/mktree.o
-BUILTIN_OBJS += builtin/mv.o
-BUILTIN_OBJS += builtin/name-rev.o
-BUILTIN_OBJS += builtin/notes.o
-BUILTIN_OBJS += builtin/pack-objects.o
-BUILTIN_OBJS += builtin/pack-redundant.o
-BUILTIN_OBJS += builtin/pack-refs.o
-BUILTIN_OBJS += builtin/patch-id.o
-BUILTIN_OBJS += builtin/prune-packed.o
-BUILTIN_OBJS += builtin/prune.o
-BUILTIN_OBJS += builtin/push.o
-BUILTIN_OBJS += builtin/read-tree.o
-BUILTIN_OBJS += builtin/receive-pack.o
-BUILTIN_OBJS += builtin/reflog.o
-BUILTIN_OBJS += builtin/remote.o
-BUILTIN_OBJS += builtin/remote-ext.o
-BUILTIN_OBJS += builtin/remote-fd.o
-BUILTIN_OBJS += builtin/repack.o
-BUILTIN_OBJS += builtin/replace.o
-BUILTIN_OBJS += builtin/rerere.o
-BUILTIN_OBJS += builtin/reset.o
-BUILTIN_OBJS += builtin/rev-list.o
-BUILTIN_OBJS += builtin/rev-parse.o
-BUILTIN_OBJS += builtin/revert.o
-BUILTIN_OBJS += builtin/rm.o
-BUILTIN_OBJS += builtin/send-pack.o
-BUILTIN_OBJS += builtin/shortlog.o
-BUILTIN_OBJS += builtin/show-branch.o
-BUILTIN_OBJS += builtin/show-ref.o
-BUILTIN_OBJS += builtin/stripspace.o
-BUILTIN_OBJS += builtin/symbolic-ref.o
-BUILTIN_OBJS += builtin/tag.o
-BUILTIN_OBJS += builtin/unpack-file.o
-BUILTIN_OBJS += builtin/unpack-objects.o
-BUILTIN_OBJS += builtin/update-index.o
-BUILTIN_OBJS += builtin/update-ref.o
-BUILTIN_OBJS += builtin/update-server-info.o
-BUILTIN_OBJS += builtin/upload-archive.o
-BUILTIN_OBJS += builtin/var.o
-BUILTIN_OBJS += builtin/verify-commit.o
-BUILTIN_OBJS += builtin/verify-pack.o
-BUILTIN_OBJS += builtin/verify-tag.o
-BUILTIN_OBJS += builtin/write-tree.o
+BUILTIN_OBJS = $(patsubst %.c,%.o, $(wildcard builtin/*.c))
 
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
 EXTLIBS =
-- 
2.2.1.268.g1e6f5b2.dirty
