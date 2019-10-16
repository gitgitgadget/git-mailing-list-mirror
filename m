Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 520561F4C0
	for <e@80x24.org>; Wed, 16 Oct 2019 17:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731980AbfJPR00 (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Oct 2019 13:26:26 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:34746 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbfJPR0Z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Oct 2019 13:26:25 -0400
Received: by mail-pf1-f180.google.com with SMTP id b128so15163891pfa.1
        for <git@vger.kernel.org>; Wed, 16 Oct 2019 10:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ICE8zbl5q3kL2XOUVog4ToI5568qYet4H0QuspA/gmg=;
        b=h5lf8M3ONhdL4/XZYMaMm664MBeV9jOnVsYFFw+gBr8TSSrn5FwnWCspDB9FcWNvPI
         LFQgEDIwg7MzXv1om6fedtiyPQkfY6y5h0OHMoJnjc1iSadNPjaf8k96Ys+jSkwan5iP
         Cl7abQIISQveK3bo/tNPQwTJ668NLMjOEnbUNP6CR9nk7so0mSX8yRldErYp5AaFWBut
         PxFtPFKR+cYkiGL5yzOdqAmo9XsA800C7nAN0XUIm9ldSgYn2MoOD7xn1DkITO3BYthR
         WZZwh8Q0HtdffE7gtEMMIczVy0C4BN2Q2FLwLHjtk+Q0RNPGtmUc2gEffalKt+FN6D5U
         v4cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ICE8zbl5q3kL2XOUVog4ToI5568qYet4H0QuspA/gmg=;
        b=DC9bo96BlB5dQmWc+cBx828XlX96NbrC1YzT2ZLKj3LBB1RgAhJT0m3+QtKbEZGDse
         nSblIx8YqPnmXDG1VL3tr7NqX5//U2Ec/gGOmJ/OOG7X94uJaeUKY8833tPS/LkII7t+
         FXBy9likJT06w1YcDZVRfvE746PmLOPR6TOW83wqCj1uykvV2171j6PLfwy/9mHgH3iq
         HoZpJoyijtT9JiiLffH4el7F2VZdtkbM8Vq3MAtOvFUsvXf42blo2IfihACpAn4rehdx
         1+F+CL62GSEvfTvrWW6P+Esx7sGW3OMfTjt3WVwujiN0BSYBC5nZpi9clOEvUXZKywlg
         zRqA==
X-Gm-Message-State: APjAAAUkfebxXxl6uR8zD6wTAXs+MElKJpXn/s4cbyx4JyewqzCdh3/E
        cpnBmt8u9Ohcl8BV6w0Cncvw8MwG
X-Google-Smtp-Source: APXvYqy6qgMck7msRZwIYX6wqWTlhRU9GSYKKoW3s37olX9XSG0fKVkK/xh3/3veeSFHocrxc4kE+w==
X-Received: by 2002:a65:6096:: with SMTP id t22mr44990940pgu.409.1571246783299;
        Wed, 16 Oct 2019 10:26:23 -0700 (PDT)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id i8sm25650069pgl.18.2019.10.16.10.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 10:26:22 -0700 (PDT)
Date:   Wed, 16 Oct 2019 10:26:21 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH 1/7] Makefile: alphabetically sort += lists
Message-ID: <02a16f9bdf740841d9a4be765e72b9fa5ae5d75c.1571246693.git.liu.denton@gmail.com>
References: <cover.1571246693.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571246693.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are many += lists in the Makefile and, over time, they have gotten
slightly out of order, alphabetically. Alphabetically sort all += lists
to bring them back in order.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Makefile | 75 ++++++++++++++++++++++++++++----------------------------
 1 file changed, 38 insertions(+), 37 deletions(-)

diff --git a/Makefile b/Makefile
index de60c8e7aa..268a273df5 100644
--- a/Makefile
+++ b/Makefile
@@ -604,12 +604,12 @@ unexport CDPATH
 SCRIPT_SH += git-bisect.sh
 SCRIPT_SH += git-difftool--helper.sh
 SCRIPT_SH += git-filter-branch.sh
+SCRIPT_SH += git-legacy-stash.sh
 SCRIPT_SH += git-merge-octopus.sh
 SCRIPT_SH += git-merge-one-file.sh
 SCRIPT_SH += git-merge-resolve.sh
 SCRIPT_SH += git-mergetool.sh
 SCRIPT_SH += git-quiltimport.sh
-SCRIPT_SH += git-legacy-stash.sh
 SCRIPT_SH += git-request-pull.sh
 SCRIPT_SH += git-submodule.sh
 SCRIPT_SH += git-web--browse.sh
@@ -617,8 +617,8 @@ SCRIPT_SH += git-web--browse.sh
 SCRIPT_LIB += git-mergetool--lib
 SCRIPT_LIB += git-parse-remote
 SCRIPT_LIB += git-rebase--preserve-merges
-SCRIPT_LIB += git-sh-setup
 SCRIPT_LIB += git-sh-i18n
+SCRIPT_LIB += git-sh-setup
 
 SCRIPT_PERL += git-add--interactive.perl
 SCRIPT_PERL += git-archimport.perl
@@ -686,9 +686,9 @@ PROGRAM_OBJS += daemon.o
 PROGRAM_OBJS += fast-import.o
 PROGRAM_OBJS += http-backend.o
 PROGRAM_OBJS += imap-send.o
+PROGRAM_OBJS += remote-testsvn.o
 PROGRAM_OBJS += sh-i18n--envsubst.o
 PROGRAM_OBJS += shell.o
-PROGRAM_OBJS += remote-testsvn.o
 
 # Binary suffix, set to .exe for Windows builds
 X =
@@ -709,9 +709,9 @@ TEST_BUILTINS_OBJS += test-dump-untracked-cache.o
 TEST_BUILTINS_OBJS += test-example-decorate.o
 TEST_BUILTINS_OBJS += test-genrandom.o
 TEST_BUILTINS_OBJS += test-genzeros.o
+TEST_BUILTINS_OBJS += test-hash-speed.o
 TEST_BUILTINS_OBJS += test-hash.o
 TEST_BUILTINS_OBJS += test-hashmap.o
-TEST_BUILTINS_OBJS += test-hash-speed.o
 TEST_BUILTINS_OBJS += test-index-version.o
 TEST_BUILTINS_OBJS += test-json-writer.o
 TEST_BUILTINS_OBJS += test-lazy-init-name-hash.o
@@ -735,8 +735,8 @@ TEST_BUILTINS_OBJS += test-revision-walking.o
 TEST_BUILTINS_OBJS += test-run-command.o
 TEST_BUILTINS_OBJS += test-scrap-cache-tree.o
 TEST_BUILTINS_OBJS += test-serve-v2.o
-TEST_BUILTINS_OBJS += test-sha1.o
 TEST_BUILTINS_OBJS += test-sha1-array.o
+TEST_BUILTINS_OBJS += test-sha1.o
 TEST_BUILTINS_OBJS += test-sha256.o
 TEST_BUILTINS_OBJS += test-sigchain.o
 TEST_BUILTINS_OBJS += test-strcmp-offset.o
@@ -746,10 +746,10 @@ TEST_BUILTINS_OBJS += test-submodule-nested-repo-config.o
 TEST_BUILTINS_OBJS += test-subprocess.o
 TEST_BUILTINS_OBJS += test-trace2.o
 TEST_BUILTINS_OBJS += test-urlmatch-normalization.o
-TEST_BUILTINS_OBJS += test-xml-encode.o
 TEST_BUILTINS_OBJS += test-wildmatch.o
 TEST_BUILTINS_OBJS += test-windows-named-pipe.o
 TEST_BUILTINS_OBJS += test-write-cache.o
+TEST_BUILTINS_OBJS += test-xml-encode.o
 
 # Do not add more tests here unless they have extra dependencies. Add
 # them in TEST_BUILTINS_OBJS above.
@@ -786,10 +786,10 @@ OTHER_PROGRAMS = git$X
 
 # what test wrappers are needed and 'install' will install, in bindir
 BINDIR_PROGRAMS_NEED_X += git
-BINDIR_PROGRAMS_NEED_X += git-upload-pack
 BINDIR_PROGRAMS_NEED_X += git-receive-pack
-BINDIR_PROGRAMS_NEED_X += git-upload-archive
 BINDIR_PROGRAMS_NEED_X += git-shell
+BINDIR_PROGRAMS_NEED_X += git-upload-archive
+BINDIR_PROGRAMS_NEED_X += git-upload-pack
 
 BINDIR_PROGRAMS_NO_X += git-cvsserver
 
@@ -827,11 +827,12 @@ LIB_OBJS += advice.o
 LIB_OBJS += alias.o
 LIB_OBJS += alloc.o
 LIB_OBJS += apply.o
-LIB_OBJS += archive.o
 LIB_OBJS += archive-tar.o
 LIB_OBJS += archive-zip.o
+LIB_OBJS += archive.o
 LIB_OBJS += argv-array.o
 LIB_OBJS += attr.o
+LIB_OBJS += autostash.o
 LIB_OBJS += base85.o
 LIB_OBJS += bisect.o
 LIB_OBJS += blame.o
@@ -845,9 +846,9 @@ LIB_OBJS += checkout.o
 LIB_OBJS += color.o
 LIB_OBJS += column.o
 LIB_OBJS += combine-diff.o
-LIB_OBJS += commit.o
 LIB_OBJS += commit-graph.o
 LIB_OBJS += commit-reach.o
+LIB_OBJS += commit.o
 LIB_OBJS += compat/obstack.o
 LIB_OBJS += compat/terminal.o
 LIB_OBJS += config.o
@@ -861,17 +862,17 @@ LIB_OBJS += ctype.o
 LIB_OBJS += date.o
 LIB_OBJS += decorate.o
 LIB_OBJS += delta-islands.o
+LIB_OBJS += diff-delta.o
+LIB_OBJS += diff-lib.o
+LIB_OBJS += diff-no-index.o
+LIB_OBJS += diff.o
 LIB_OBJS += diffcore-break.o
 LIB_OBJS += diffcore-delta.o
 LIB_OBJS += diffcore-order.o
 LIB_OBJS += diffcore-pickaxe.o
 LIB_OBJS += diffcore-rename.o
-LIB_OBJS += diff-delta.o
-LIB_OBJS += diff-lib.o
-LIB_OBJS += diff-no-index.o
-LIB_OBJS += diff.o
-LIB_OBJS += dir.o
 LIB_OBJS += dir-iterator.o
+LIB_OBJS += dir.o
 LIB_OBJS += editor.o
 LIB_OBJS += entry.o
 LIB_OBJS += environment.o
@@ -889,7 +890,6 @@ LIB_OBJS += gpg-interface.o
 LIB_OBJS += graph.o
 LIB_OBJS += grep.o
 LIB_OBJS += hashmap.o
-LIB_OBJS += linear-assignment.o
 LIB_OBJS += help.o
 LIB_OBJS += hex.o
 LIB_OBJS += ident.o
@@ -899,9 +899,10 @@ LIB_OBJS += kwset.o
 LIB_OBJS += levenshtein.o
 LIB_OBJS += line-log.o
 LIB_OBJS += line-range.o
-LIB_OBJS += list-objects.o
-LIB_OBJS += list-objects-filter.o
+LIB_OBJS += linear-assignment.o
 LIB_OBJS += list-objects-filter-options.o
+LIB_OBJS += list-objects-filter.o
+LIB_OBJS += list-objects.o
 LIB_OBJS += ll-merge.o
 LIB_OBJS += lockfile.o
 LIB_OBJS += log-tree.o
@@ -910,31 +911,31 @@ LIB_OBJS += mailinfo.o
 LIB_OBJS += mailmap.o
 LIB_OBJS += match-trees.o
 LIB_OBJS += mem-pool.o
-LIB_OBJS += merge.o
 LIB_OBJS += merge-blobs.o
 LIB_OBJS += merge-recursive.o
+LIB_OBJS += merge.o
 LIB_OBJS += mergesort.o
 LIB_OBJS += midx.o
 LIB_OBJS += name-hash.o
 LIB_OBJS += negotiator/default.o
 LIB_OBJS += negotiator/skipping.o
-LIB_OBJS += notes.o
 LIB_OBJS += notes-cache.o
 LIB_OBJS += notes-merge.o
 LIB_OBJS += notes-utils.o
+LIB_OBJS += notes.o
 LIB_OBJS += object.o
 LIB_OBJS += oidmap.o
 LIB_OBJS += oidset.o
-LIB_OBJS += packfile.o
-LIB_OBJS += pack-bitmap.o
 LIB_OBJS += pack-bitmap-write.o
+LIB_OBJS += pack-bitmap.o
 LIB_OBJS += pack-check.o
 LIB_OBJS += pack-objects.o
 LIB_OBJS += pack-revindex.o
 LIB_OBJS += pack-write.o
+LIB_OBJS += packfile.o
 LIB_OBJS += pager.o
-LIB_OBJS += parse-options.o
 LIB_OBJS += parse-options-cb.o
+LIB_OBJS += parse-options.o
 LIB_OBJS += patch-delta.o
 LIB_OBJS += patch-ids.o
 LIB_OBJS += path.o
@@ -952,6 +953,7 @@ LIB_OBJS += range-diff.o
 LIB_OBJS += reachable.o
 LIB_OBJS += read-cache.o
 LIB_OBJS += rebase-interactive.o
+LIB_OBJS += ref-filter.o
 LIB_OBJS += reflog-walk.o
 LIB_OBJS += refs.o
 LIB_OBJS += refs/files-backend.o
@@ -959,7 +961,6 @@ LIB_OBJS += refs/iterator.o
 LIB_OBJS += refs/packed-backend.o
 LIB_OBJS += refs/ref-cache.o
 LIB_OBJS += refspec.o
-LIB_OBJS += ref-filter.o
 LIB_OBJS += remote.o
 LIB_OBJS += replace-object.o
 LIB_OBJS += repo-settings.o
@@ -974,8 +975,8 @@ LIB_OBJS += serve.o
 LIB_OBJS += server-info.o
 LIB_OBJS += setup.o
 LIB_OBJS += sha1-array.o
-LIB_OBJS += sha1-lookup.o
 LIB_OBJS += sha1-file.o
+LIB_OBJS += sha1-lookup.o
 LIB_OBJS += sha1-name.o
 LIB_OBJS += shallow.o
 LIB_OBJS += sideband.o
@@ -985,9 +986,9 @@ LIB_OBJS += stable-qsort.o
 LIB_OBJS += strbuf.o
 LIB_OBJS += streaming.o
 LIB_OBJS += string-list.o
-LIB_OBJS += submodule.o
-LIB_OBJS += submodule-config.o
 LIB_OBJS += sub-process.o
+LIB_OBJS += submodule-config.o
+LIB_OBJS += submodule.o
 LIB_OBJS += symlinks.o
 LIB_OBJS += tag.o
 LIB_OBJS += tempfile.o
@@ -1006,11 +1007,11 @@ LIB_OBJS += trace2/tr2_tgt_normal.o
 LIB_OBJS += trace2/tr2_tgt_perf.o
 LIB_OBJS += trace2/tr2_tls.o
 LIB_OBJS += trailer.o
-LIB_OBJS += transport.o
 LIB_OBJS += transport-helper.o
+LIB_OBJS += transport.o
 LIB_OBJS += tree-diff.o
-LIB_OBJS += tree.o
 LIB_OBJS += tree-walk.o
+LIB_OBJS += tree.o
 LIB_OBJS += unpack-trees.o
 LIB_OBJS += upload-pack.o
 LIB_OBJS += url.o
@@ -1050,9 +1051,9 @@ BUILTIN_OBJS += builtin/checkout.o
 BUILTIN_OBJS += builtin/clean.o
 BUILTIN_OBJS += builtin/clone.o
 BUILTIN_OBJS += builtin/column.o
+BUILTIN_OBJS += builtin/commit-graph.o
 BUILTIN_OBJS += builtin/commit-tree.o
 BUILTIN_OBJS += builtin/commit.o
-BUILTIN_OBJS += builtin/commit-graph.o
 BUILTIN_OBJS += builtin/config.o
 BUILTIN_OBJS += builtin/count-objects.o
 BUILTIN_OBJS += builtin/credential.o
@@ -1083,13 +1084,13 @@ BUILTIN_OBJS += builtin/ls-remote.o
 BUILTIN_OBJS += builtin/ls-tree.o
 BUILTIN_OBJS += builtin/mailinfo.o
 BUILTIN_OBJS += builtin/mailsplit.o
-BUILTIN_OBJS += builtin/merge.o
 BUILTIN_OBJS += builtin/merge-base.o
 BUILTIN_OBJS += builtin/merge-file.o
 BUILTIN_OBJS += builtin/merge-index.o
 BUILTIN_OBJS += builtin/merge-ours.o
 BUILTIN_OBJS += builtin/merge-recursive.o
 BUILTIN_OBJS += builtin/merge-tree.o
+BUILTIN_OBJS += builtin/merge.o
 BUILTIN_OBJS += builtin/mktag.o
 BUILTIN_OBJS += builtin/mktree.o
 BUILTIN_OBJS += builtin/multi-pack-index.o
@@ -1109,9 +1110,9 @@ BUILTIN_OBJS += builtin/read-tree.o
 BUILTIN_OBJS += builtin/rebase.o
 BUILTIN_OBJS += builtin/receive-pack.o
 BUILTIN_OBJS += builtin/reflog.o
-BUILTIN_OBJS += builtin/remote.o
 BUILTIN_OBJS += builtin/remote-ext.o
 BUILTIN_OBJS += builtin/remote-fd.o
+BUILTIN_OBJS += builtin/remote.o
 BUILTIN_OBJS += builtin/repack.o
 BUILTIN_OBJS += builtin/replace.o
 BUILTIN_OBJS += builtin/rerere.o
@@ -2325,16 +2326,16 @@ reconfigure config.mak.autogen: config.status
 endif
 
 XDIFF_OBJS += xdiff/xdiffi.o
-XDIFF_OBJS += xdiff/xprepare.o
-XDIFF_OBJS += xdiff/xutils.o
 XDIFF_OBJS += xdiff/xemit.o
+XDIFF_OBJS += xdiff/xhistogram.o
 XDIFF_OBJS += xdiff/xmerge.o
 XDIFF_OBJS += xdiff/xpatience.o
-XDIFF_OBJS += xdiff/xhistogram.o
+XDIFF_OBJS += xdiff/xprepare.o
+XDIFF_OBJS += xdiff/xutils.o
 
+VCSSVN_OBJS += vcs-svn/fast_export.o
 VCSSVN_OBJS += vcs-svn/line_buffer.o
 VCSSVN_OBJS += vcs-svn/sliding_window.o
-VCSSVN_OBJS += vcs-svn/fast_export.o
 VCSSVN_OBJS += vcs-svn/svndiff.o
 VCSSVN_OBJS += vcs-svn/svndump.o
 
@@ -3143,9 +3144,9 @@ endif
 #
 ALL_COMMANDS = $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS)
 ALL_COMMANDS += git
+ALL_COMMANDS += git-gui git-citool
 ALL_COMMANDS += gitk
 ALL_COMMANDS += gitweb
-ALL_COMMANDS += git-gui git-citool
 
 .PHONY: check-docs
 check-docs::
-- 
2.23.0.897.g0a19638b1e

