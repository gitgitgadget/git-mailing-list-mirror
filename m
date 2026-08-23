Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F11377ABE
	for <git@vger.kernel.org>; Sun, 23 Aug 2026 17:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787505589; cv=none; b=uEJt4XFgCUV9X9DtN5JiA/aJi/2evRz0uBEvb+BJoXE7uZaIbu/tvih/QZN28Ye02LvVulPOtJjQ78JOcblB7JA2vDj/LM+gCRDxvnT/GvrmDl2uBnbS7lSqkMhyNrN3wkYY/08Fvr9cll4H0U7tKSsWYN8Aka2QHD+7Vwaitn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787505589; c=relaxed/simple;
	bh=rM+O/c6VtORXlnx07KncVjZ3s+NfBwT4IWCXTEINFLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dSiU0MgIBJrfM60gXyr7EA0pUgOOP3/purJ9C5h50OJfpXCuMOMa6Qf7L7biPqBF6DRZxAKQZ/yKdTxY+k1AGD2abrcgCWNqxJh9FG0ULsjOEDwb55d0H8ciQ59cBgiQl4wRBjBOONMBWJ99mQr+NfHR5os8S1G7R9v8gMJSmR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZBhMEnjG; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBhMEnjG"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38f620399a0so2252855a91.2
        for <git@vger.kernel.org>; Sun, 23 Aug 2026 10:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787505577; x=1788110377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pivIGkSzjgy6rsOdKDjV8h/NkDalc5LdxF+fT45AX1o=;
        b=ZBhMEnjGHxTsmvfOFp3oc8aOxeGUIp0vdtw/nZ8pyG0bwo2bGGZBJwvUfClUeEmqB+
         oYt2RSFMz9fqnQmaXe1IQO75hw+qdGe9WpWDgdBOJ6J+Cxj8QLQ5i0Ov+hAxd6YtqRBl
         ToKDfjfarydOOStkX68MOSL6BDbpQyeqGDDA39SVno1g0KK15/R/lg/fnLbcZLtkgKQN
         vFcVGzlbO4CIhC0JOppoiZatVbdTajmx01dll8OU1OKNZqmlrVXm94sgqta4ZaihKH3R
         awQXpaiiT+V9BAci6MqyBP+k4WHoMCLfeN8axvVE1oHOJjiMCGLEWo76cbDSX/9IjcFi
         B/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787505577; x=1788110377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pivIGkSzjgy6rsOdKDjV8h/NkDalc5LdxF+fT45AX1o=;
        b=mpxHQ3xhhbKpfjgWU/gBEDlBPhaeXJtJWvPDEFkIJ4rrvGzbm9jAiP4YjEBjI8r8Ld
         7ENJwdjnirUbTWhSAsH0gqiz3G71PQvJquHgObD7NjeJj8ttLVLgRj2+mw8pgAB7sGN7
         Lkd2ziePwKqa5LZzlw8QT7ItpRS+CYwsMgvJ+q65G9bfJU+0sk7GMkDLmEI9qCjaDL1k
         XKXMCm60HIvb7tI7UGVZmhfMHuTPE0pmf8ly8z6ZijUSLigc/7Hsf4ppgqajVfnsNeFu
         np5cbmdOfHhh20yXLgK1h6IODU5HS0gVzxpzsv/JHEfizMttXKGjSCnJ16t9V8H6ZB8r
         zuhg==
X-Gm-Message-State: AFuF++nuXvXNmtUynm57dB1IXpgBXG3facnjGPQR0Xe5CkH7qi6Nf9NY
	FjfqfAhtKh70dbCAlmQOLjKx9zwYoOXH95IhVFYM4C5OqB4c9hdi+PfCohsaAg==
X-Gm-Gg: AR+sD138s+m3DeKPpPNNyhtSIknmhWSOyWiCBUjrTsxP81IPTPHPi1JB3Du1AHcyEGo
	gx7MOI87HejOns3k2h26iVfd6zKDQBVH/iXhBpjPXQ/lE3raAC29Ft42cNd66gqaPaiQgpAzDyy
	eZttZUX6QdDuGudT2+mXO3rolS/GsWu/h9VU6XnoOv95nRPWgvx0KGj5XScjlW230BYnmLuqlq6
	7xP7Fn7DqZ/SuV3Pvi1IE2cc1q0i6MY3lRASS0ugfV8t3lUyyA6Dp66JKwBMHlk+RjWahFkkRqv
	h8wt6j4n1MyCg++VBCcYsp0jqPPSXsQMN7Xl7FtnsLLNx3YnEvyytgjmWKJrHhs8CaTTxplMAZX
	P8YkFJSfXHU7nJuXZxh1ZX5MiGgA7m3vqg53Q7M91UrBfbHKiuh8DCIEwMmIfcmYtsOoc+7YVNb
	Fqe/GETY0giB40wrNHyOhjJ1MKdE3ad6HBx3MwQeeksAAk/N5EKJceGmt3ZkVF3yr6FJeT46L01
	fRDsKHsYs9+5yDiqfXSLXEgWWqWiBgiCr9Fp8qgBKpkR2fwujMJ5i/XcpGmFad+LpLg7vhZNWke
	5HNiiWaSbB490wJcs0nKsnz4QHvwL+NJxpugDozhrvBh/8eCvGk=
X-Received: by 2002:a17:90a:ec8e:b0:38e:c7b0:84ad with SMTP id 98e67ed59e1d1-395c2f2a10bmr36802346a91.0.1787505575812;
        Sun, 23 Aug 2026 10:19:35 -0700 (PDT)
Received: from localhost (192-184-169-91.fiber.dynamic.sonic.net. [192.184.169.91])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3280782f09fsm9658224eec.20.2026.08.23.10.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 10:19:35 -0700 (PDT)
From: Michael Montalbo <mmontalbo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <pks@pks.im>
Subject: [RFC PATCH 11/14] revision: gather the revision sources under revision/
Date: Sun, 23 Aug 2026 10:18:55 -0700
Message-ID: <20260823171915.2662373-12-mmontalbo@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260823171915.2662373-1-mmontalbo@gmail.com>
References: <20260823171915.2662373-1-mmontalbo@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the 14 revision C sources and 15 headers into revision/ as renames.
Repoint every reference to their old paths to the new ones: the #include
lines across the tree, the Makefile and meson.build build entries, and
the tutorial #include examples.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 .gitorganize                                  | 58 +++++++++----------
 Documentation/MyFirstContribution.adoc        |  2 +-
 Documentation/MyFirstObjectWalk.adoc          |  6 +-
 Makefile                                      | 28 ++++-----
 add-interactive.c                             |  2 +-
 archive.c                                     |  2 +-
 attr.c                                        |  2 +-
 builtin/add.c                                 |  2 +-
 builtin/am.c                                  |  6 +-
 builtin/backfill.c                            |  2 +-
 builtin/bisect.c                              |  4 +-
 builtin/blame.c                               |  8 +--
 builtin/branch.c                              |  2 +-
 builtin/cat-file.c                            |  2 +-
 builtin/checkout.c                            |  2 +-
 builtin/clone.c                               |  2 +-
 builtin/commit.c                              |  6 +-
 builtin/describe.c                            |  4 +-
 builtin/diff-files.c                          |  2 +-
 builtin/diff-index.c                          |  2 +-
 builtin/diff-pairs.c                          |  2 +-
 builtin/diff-tree.c                           |  4 +-
 builtin/diff.c                                |  4 +-
 builtin/fast-export.c                         |  6 +-
 builtin/fast-import.c                         |  2 +-
 builtin/fetch.c                               |  6 +-
 builtin/gc.c                                  |  2 +-
 builtin/history.c                             |  4 +-
 builtin/last-modified.c                       |  2 +-
 builtin/log.c                                 |  8 +--
 builtin/merge-base.c                          |  2 +-
 builtin/merge-tree.c                          |  2 +-
 builtin/merge.c                               |  4 +-
 builtin/name-rev.c                            |  4 +-
 builtin/notes.c                               |  2 +-
 builtin/pack-objects.c                        | 10 ++--
 builtin/prune.c                               |  4 +-
 builtin/pull.c                                |  2 +-
 builtin/rebase.c                              |  4 +-
 builtin/receive-pack.c                        |  4 +-
 builtin/reflog.c                              |  2 +-
 builtin/remote.c                              |  2 +-
 builtin/repack.c                              |  2 +-
 builtin/replay.c                              |  2 +-
 builtin/repo.c                                |  4 +-
 builtin/reset.c                               |  2 +-
 builtin/rev-list.c                            | 14 ++---
 builtin/rev-parse.c                           |  8 +--
 builtin/revert.c                              |  2 +-
 builtin/shortlog.c                            |  2 +-
 builtin/show-branch.c                         |  2 +-
 builtin/stash.c                               |  4 +-
 builtin/submodule--helper.c                   |  4 +-
 builtin/tag.c                                 |  2 +-
 builtin/unpack-objects.c                      |  2 +-
 bundle.c                                      |  6 +-
 bundle.h                                      |  2 +-
 chdir-notify.c                                |  2 +-
 diff/combine-diff.c                           |  4 +-
 diff/diff-lib.c                               |  4 +-
 diff/diff-merges.c                            |  2 +-
 diff/diff-no-index.c                          |  2 +-
 diff/diff.c                                   |  4 +-
 diff/diffcore-pickaxe.c                       |  2 +-
 diff/range-diff.c                             |  4 +-
 fetch-pack.c                                  |  4 +-
 fetch-pack.h                                  |  2 +-
 fmt-merge-msg.c                               |  4 +-
 git.c                                         |  2 +-
 grep.c                                        |  2 +-
 http-push.c                                   |  6 +-
 http-walker.c                                 |  2 +-
 merge-ort.c                                   |  4 +-
 meson.build                                   | 28 ++++-----
 notes-cache.c                                 |  2 +-
 notes-merge.c                                 |  2 +-
 odb/commit.c                                  |  6 +-
 odb/object-name.c                             |  4 +-
 odb/source-packed.c                           |  2 +-
 pack/commit-graph.c                           |  2 +-
 pack/midx-write.c                             |  4 +-
 pack/pack-bitmap-write.c                      |  4 +-
 pack/pack-bitmap.c                            |  6 +-
 pack/packfile.c                               |  2 +-
 pack/packfile.h                               |  2 +-
 pack/reachable.c                              |  4 +-
 pack/repack.h                                 |  2 +-
 path-walk.c                                   |  6 +-
 read-cache.c                                  |  2 +-
 refs/files-backend.c                          |  2 +-
 refs/pack-refs.c                              |  2 +-
 refs/ref-filter.c                             |  4 +-
 refs/ref-filter.h                             |  2 +-
 refs/reflog-walk.c                            |  2 +-
 refs/reflog.c                                 |  2 +-
 remote.c                                      |  4 +-
 replay.c                                      |  2 +-
 bisect.c => revision/bisect.c                 | 10 ++--
 bisect.h => revision/bisect.h                 |  0
 blame.c => revision/blame.c                   |  4 +-
 blame.h => revision/blame.h                   |  0
 commit-reach.c => revision/commit-reach.c     |  6 +-
 commit-reach.h => revision/commit-reach.h     |  0
 decorate.c => revision/decorate.c             |  2 +-
 decorate.h => revision/decorate.h             |  0
 graph.c => revision/graph.c                   |  4 +-
 graph.h => revision/graph.h                   |  0
 line-log.c => revision/line-log.c             |  8 +--
 line-log.h => revision/line-log.h             |  0
 line-range.c => revision/line-range.c         |  2 +-
 line-range.h => revision/line-range.h         |  0
 .../list-objects-filter-options.c             |  2 +-
 .../list-objects-filter-options.h             |  0
 .../list-objects-filter.c                     |  6 +-
 .../list-objects-filter.h                     |  0
 list-objects.c => revision/list-objects.c     |  8 +--
 list-objects.h => revision/list-objects.h     |  0
 list.h => revision/list.h                     |  0
 log-tree.c => revision/log-tree.c             | 10 ++--
 log-tree.h => revision/log-tree.h             |  0
 pretty.c => revision/pretty.c                 |  4 +-
 pretty.h => revision/pretty.h                 |  0
 revision.c => revision/revision.c             | 16 ++---
 revision.h => revision/revision.h             |  6 +-
 shallow.c => revision/shallow.c               |  8 +--
 shallow.h => revision/shallow.h               |  0
 send-pack.c                                   |  2 +-
 sequencer.c                                   |  6 +-
 setup.c                                       |  2 +-
 submodule.c                                   |  4 +-
 t/helper/test-path-walk.c                     |  6 +-
 t/helper/test-reach.c                         |  2 +-
 t/helper/test-ref-store.c                     |  2 +-
 t/helper/test-revision-walking.c              |  4 +-
 t/unit-tests/u-example-decorate.c             |  2 +-
 t/unit-tests/u-list-objects-filter-options.c  |  2 +-
 tempfile.h                                    |  2 +-
 trailer.c                                     |  2 +-
 trailer.h                                     |  2 +-
 transport.h                                   |  2 +-
 upload-pack.c                                 |  8 +--
 wt-status.c                                   |  2 +-
 142 files changed, 289 insertions(+), 289 deletions(-)
 rename bisect.c => revision/bisect.c (99%)
 rename bisect.h => revision/bisect.h (100%)
 rename blame.c => revision/blame.c (99%)
 rename blame.h => revision/blame.h (100%)
 rename commit-reach.c => revision/commit-reach.c (99%)
 rename commit-reach.h => revision/commit-reach.h (100%)
 rename decorate.c => revision/decorate.c (98%)
 rename decorate.h => revision/decorate.h (100%)
 rename graph.c => revision/graph.c (99%)
 rename graph.h => revision/graph.h (100%)
 rename line-log.c => revision/line-log.c (99%)
 rename line-log.h => revision/line-log.h (100%)
 rename line-range.c => revision/line-range.c (99%)
 rename line-range.h => revision/line-range.h (100%)
 rename list-objects-filter-options.c => revision/list-objects-filter-options.c (99%)
 rename list-objects-filter-options.h => revision/list-objects-filter-options.h (100%)
 rename list-objects-filter.c => revision/list-objects-filter.c (99%)
 rename list-objects-filter.h => revision/list-objects-filter.h (100%)
 rename list-objects.c => revision/list-objects.c (98%)
 rename list-objects.h => revision/list-objects.h (100%)
 rename list.h => revision/list.h (100%)
 rename log-tree.c => revision/log-tree.c (99%)
 rename log-tree.h => revision/log-tree.h (100%)
 rename pretty.c => revision/pretty.c (99%)
 rename pretty.h => revision/pretty.h (100%)
 rename revision.c => revision/revision.c (99%)
 rename revision.h => revision/revision.h (99%)
 rename shallow.c => revision/shallow.c (99%)
 rename shallow.h => revision/shallow.h (100%)

diff --git a/.gitorganize b/.gitorganize
index 160365fbca..d62d0a2240 100644
--- a/.gitorganize
+++ b/.gitorganize
@@ -41,10 +41,6 @@ attr.h component=convert role=header prefix=attr cochange=convert:50,index:13,di
 banned.h component=? role=public prefix=banned
 base85.c component=? role=lib prefix=base85 cochange=diff:4,pack:2,convert:1,transport:1
 base85.h component=? role=public prefix=base85 cochange=diff:1
-bisect.c component=revision role=lib prefix=bisect includes=odb:5,revision:5,setup:2,diff:1,index:1 cochange=revision:61,odb:32,transport:31,refs:13,diff:9
-bisect.h component=revision role=header prefix=bisect cochange=revision:29,odb:2
-blame.c component=revision role=lib prefix=blame includes=odb:5,diff:2,index:2,pack:2,revision:2 cochange=diff:68,revision:66,odb:56,index:29,pack:22
-blame.h component=revision role=header prefix=blame includes=diff:1,odb:1 cochange=revision:19,odb:7,diff:4,archive:1,index:1
 branch.c component=? role=lib prefix=branch includes=refs:3,setup:3,odb:2,submodule:1,transport:1 cochange=refs:62,transport:41,setup:28,index:19,revision:12
 branch.h component=? role=public prefix=branch cochange=setup:8,refs:4,submodule:4
 builtin.h component=? role=public prefix=builtin includes=setup:1 cochange=diff:15,index:15,transport:12,odb:6,notes:5
@@ -62,8 +58,6 @@ color.c component=? role=lib prefix=color includes=setup:1 cochange=diff:21,inde
 color.h component=? role=public prefix=color cochange=diff:18,index:12,revision:12,transport:2,odb:1
 column.c component=? role=lib prefix=column includes=setup:1 cochange=transport:6,setup:5,diff:4,revision:3,index:2
 column.h component=? role=public prefix=column
-commit-reach.c component=revision role=lib prefix=commit-reach includes=revision:3,odb:2,pack:1,refs:1 cochange=revision:38,odb:17,pack:15,transport:9,index:5
-commit-reach.h component=revision role=header prefix=commit-reach includes=odb:2 cochange=revision:32,odb:9,transport:8,pack:3,refs:3
 common-exit.c component=? role=lib prefix=common-main
 common-init.c component=? role=lib prefix=common-main includes=odb:2,setup:2,convert:1 cochange=setup:1
 common-init.h component=? role=public prefix=common-main
@@ -86,8 +80,6 @@ ctype.c component=? role=lib prefix=ctype cochange=setup:3,index:2,odb:1,pack:1,
 daemon.c component=? role=program prefix=daemon includes=setup:3,transport:2 cochange=transport:77,index:14,setup:13,diff:7,refs:5
 date.c component=? role=lib prefix=date cochange=revision:17,odb:16,refs:14,setup:9,diff:7
 date.h component=? role=public prefix=date cochange=refs:7,revision:4,setup:2,archive:1,odb:1
-decorate.c component=revision role=lib prefix=decorate includes=odb:1,revision:1 cochange=diff:6,odb:5,revision:5,pack:2,transport:2
-decorate.h component=revision role=header prefix=decorate cochange=revision:4,odb:1
 diagnose.c component=? role=lib prefix=diagnose includes=archive:1,index:1,odb:1,pack:1,setup:1 cochange=index:4,revision:4,odb:3,pack:3,transport:3
 diagnose.h component=? role=public prefix=diagnose cochange=revision:2,refs:1,transport:1
 diff/combine-diff.c component=diff role=lib prefix=combine-diff includes=odb:5,diff:4,revision:2,convert:1,refs:1 cochange=diff:198,revision:67,index:35,odb:16,transport:16
@@ -152,8 +144,6 @@ git-zlib.h component=? role=public prefix=git-zlib cochange=archive:3,setup:2,od
 git.c component=? role=lib prefix=git includes=setup:4,odb:2,convert:1,index:1,revision:1 cochange=setup:70,revision:54,transport:47,index:28,diff:25
 gpg-interface.c component=? role=lib prefix=gpg-interface includes=setup:3,index:1,odb:1 cochange=revision:25,odb:22,setup:13,transport:11,diff:8
 gpg-interface.h component=? role=public prefix=gpg-interface cochange=odb:22,revision:15,merge:4,transport:3,refs:1
-graph.c component=revision role=lib prefix=graph includes=revision:2,odb:1,setup:1 cochange=revision:38,diff:23,index:4,odb:3,transport:3
-graph.h component=revision role=header prefix=graph includes=diff:1 cochange=revision:19,diff:2,odb:1
 grep.c component=? role=lib prefix=grep includes=diff:4,odb:1,revision:1,setup:1 cochange=diff:40,revision:28,transport:10,index:7,refs:7
 grep.h component=? role=public prefix=grep includes=diff:1 cochange=revision:23,diff:10,transport:4,index:2,refs:2
 hashmap.c component=? role=lib prefix=hashmap cochange=diff:33,revision:19,index:17,refs:13,submodule:13
@@ -183,23 +173,10 @@ kwset.c component=? role=lib prefix=kwset cochange=convert:2,diff:1,pack:1,revis
 kwset.h component=? role=public prefix=kwset
 levenshtein.c component=? role=lib prefix=? cochange=diff:2,revision:2,odb:1
 levenshtein.h component=? role=public prefix=? cochange=transport:2,diff:1,refs:1,setup:1
-line-log.c component=revision role=lib prefix=line-log includes=odb:4,revision:4,diff:3,setup:2,pack:1 cochange=revision:52,diff:48,odb:23,pack:15,notes:8
-line-log.h component=revision role=header prefix=line-log includes=diff:1 cochange=revision:20,odb:3,diff:2,setup:1,submodule:1
-line-range.c component=revision role=lib prefix=line-range includes=diff:2,revision:1 cochange=revision:14,diff:8,archive:1,odb:1,pack:1
-line-range.h component=revision role=header prefix=line-range cochange=revision:13
 linear-assignment.c component=? role=lib prefix=linear-assignment cochange=diff:1,revision:1
 linear-assignment.h component=? role=public prefix=linear-assignment
-list-objects-filter-options.c component=revision role=lib prefix=list-objects-filter-options includes=revision:1,setup:1,transport:1 cochange=revision:39,transport:21,setup:9,diff:6,index:4
-list-objects-filter-options.h component=revision role=header prefix=list-objects-filter includes=odb:1 cochange=revision:40,transport:17,odb:4,diff:3,refs:2
-list-objects-filter.c component=revision role=lib prefix=list-objects-filter includes=odb:5,revision:3,diff:1,index:1 cochange=revision:32,odb:13,index:10,diff:6,pack:3
-list-objects-filter.h component=revision role=header prefix=list-objects cochange=revision:16,odb:1
-list-objects.c component=revision role=lib prefix=list-objects includes=odb:6,revision:4,diff:1,pack:1,setup:1 cochange=revision:91,odb:68,pack:40,transport:28,index:15
-list-objects.h component=revision role=header prefix=list-objects cochange=revision:32,pack:13,transport:4,odb:1
-list.h component=revision role=header prefix=list cochange=submodule:2,transport:2,index:1,revision:1
 lockfile.c component=? role=lib prefix=lockfile includes=setup:1 cochange=refs:18,index:13,setup:9,diff:8,merge:3
 lockfile.h component=? role=public prefix=lockfile cochange=index:5,revision:4,diff:3,refs:3,odb:2
-log-tree.c component=revision role=lib prefix=format-patch includes=odb:8,revision:5,diff:3,setup:3,refs:2 cochange=revision:222,diff:112,odb:112,refs:31,transport:16
-log-tree.h component=revision role=header prefix=format-patch cochange=revision:64,diff:11,refs:3,odb:2,transport:2
 mailinfo.c component=? role=lib prefix=mailinfo includes=setup:2 cochange=transport:5,index:3,notes:3,odb:3,revision:3
 mailinfo.h component=? role=public prefix=mailinfo
 mailmap.c component=? role=lib prefix=mailmap includes=setup:3,odb:2 cochange=setup:13,transport:11,refs:10,index:8,revision:5
@@ -340,8 +317,6 @@ pkt-line.c component=transport role=lib prefix=pkt-line includes=transport:2 coc
 pkt-line.h component=transport role=header prefix=pkt-line cochange=transport:94,pack:5,convert:4,odb:2,diff:1
 preload-index.c component=index role=lib prefix=preload-index includes=index:6,setup:3 cochange=index:52,setup:15,diff:12,revision:5,merge:3
 preload-index.h component=index role=header prefix=preload-index cochange=index:2,setup:1
-pretty.c component=revision role=lib prefix=pretty includes=odb:3,revision:2,setup:2,diff:1,notes:1 cochange=revision:115,odb:72,refs:29,notes:23,transport:19
-pretty.h component=revision role=header prefix=pretty cochange=revision:26,refs:7,diff:5,odb:5,archive:4
 prio-queue.c component=? role=lib prefix=prio-queue cochange=odb:5,revision:5,diff:2,pack:2,transport:2
 prio-queue.h component=? role=public prefix=prio-queue cochange=odb:3,revision:2,transport:2,pack:1
 progress.c component=? role=lib prefix=progress includes=setup:1 cochange=index:11,diff:6,setup:6,pack:4,revision:2
@@ -394,8 +369,35 @@ reset.c component=? role=lib prefix=reset includes=odb:3,index:2,refs:1,setup:1
 reset.h component=? role=public prefix=reset includes=odb:1,setup:1
 resolve-undo.c component=index role=lib prefix=resolve-undo includes=index:4,odb:1 cochange=index:33,merge:5,revision:4,diff:3,notes:2
 resolve-undo.h component=index role=header prefix=resolve-undo includes=odb:1 cochange=index:12,merge:3,archive:1,revision:1
-revision.c component=revision role=lib prefix=revision includes=odb:9,revision:8,index:4,setup:4,diff:3 cochange=revision:379,diff:194,odb:181,refs:109,pack:101
-revision.h component=revision role=header prefix=revision includes=odb:4,revision:3,diff:1,notes:1,setup:1 cochange=revision:304,odb:48,diff:24,pack:19,refs:15
+revision/bisect.c component=revision role=lib prefix=bisect includes=odb:5,revision:5,setup:2,diff:1,index:1 cochange=revision:61,odb:32,transport:31,refs:13,diff:9
+revision/bisect.h component=revision role=header prefix=bisect cochange=revision:29,odb:2
+revision/blame.c component=revision role=lib prefix=blame includes=odb:5,diff:2,index:2,pack:2,revision:2 cochange=diff:68,revision:66,odb:56,index:29,pack:22
+revision/blame.h component=revision role=header prefix=blame includes=diff:1,odb:1 cochange=revision:19,odb:7,diff:4,archive:1,index:1
+revision/commit-reach.c component=revision role=lib prefix=commit-reach includes=revision:3,odb:2,pack:1,refs:1 cochange=revision:38,odb:17,pack:15,transport:9,index:5
+revision/commit-reach.h component=revision role=header prefix=commit-reach includes=odb:2 cochange=revision:32,odb:9,transport:8,pack:3,refs:3
+revision/decorate.c component=revision role=lib prefix=decorate includes=odb:1,revision:1 cochange=diff:6,odb:5,revision:5,pack:2,transport:2
+revision/decorate.h component=revision role=header prefix=decorate cochange=revision:4,odb:1
+revision/graph.c component=revision role=lib prefix=graph includes=revision:2,odb:1,setup:1 cochange=revision:38,diff:23,index:4,odb:3,transport:3
+revision/graph.h component=revision role=header prefix=graph includes=diff:1 cochange=revision:19,diff:2,odb:1
+revision/line-log.c component=revision role=lib prefix=line-log includes=odb:4,revision:4,diff:3,setup:2,pack:1 cochange=revision:52,diff:48,odb:23,pack:15,notes:8
+revision/line-log.h component=revision role=header prefix=line-log includes=diff:1 cochange=revision:20,odb:3,diff:2,setup:1,submodule:1
+revision/line-range.c component=revision role=lib prefix=line-range includes=diff:2,revision:1 cochange=revision:14,diff:8,archive:1,odb:1,pack:1
+revision/line-range.h component=revision role=header prefix=line-range cochange=revision:13
+revision/list-objects-filter-options.c component=revision role=lib prefix=list-objects-filter-options includes=revision:1,setup:1,transport:1 cochange=revision:39,transport:21,setup:9,diff:6,index:4
+revision/list-objects-filter-options.h component=revision role=header prefix=list-objects-filter includes=odb:1 cochange=revision:40,transport:17,odb:4,diff:3,refs:2
+revision/list-objects-filter.c component=revision role=lib prefix=list-objects-filter includes=odb:5,revision:3,diff:1,index:1 cochange=revision:32,odb:13,index:10,diff:6,pack:3
+revision/list-objects-filter.h component=revision role=header prefix=list-objects cochange=revision:16,odb:1
+revision/list-objects.c component=revision role=lib prefix=list-objects includes=odb:6,revision:4,diff:1,pack:1,setup:1 cochange=revision:91,odb:68,pack:40,transport:28,index:15
+revision/list-objects.h component=revision role=header prefix=list-objects cochange=revision:32,pack:13,transport:4,odb:1
+revision/list.h component=revision role=header prefix=list cochange=submodule:2,transport:2,index:1,revision:1
+revision/log-tree.c component=revision role=lib prefix=format-patch includes=odb:8,revision:5,diff:3,setup:3,refs:2 cochange=revision:222,diff:112,odb:112,refs:31,transport:16
+revision/log-tree.h component=revision role=header prefix=format-patch cochange=revision:64,diff:11,refs:3,odb:2,transport:2
+revision/pretty.c component=revision role=lib prefix=pretty includes=odb:3,revision:2,setup:2,diff:1,notes:1 cochange=revision:115,odb:72,refs:29,notes:23,transport:19
+revision/pretty.h component=revision role=header prefix=pretty cochange=revision:26,refs:7,diff:5,odb:5,archive:4
+revision/revision.c component=revision role=lib prefix=revision includes=odb:9,revision:8,index:4,setup:4,diff:3 cochange=revision:379,diff:194,odb:181,refs:109,pack:101
+revision/revision.h component=revision role=header prefix=revision includes=odb:4,revision:3,diff:1,notes:1,setup:1 cochange=revision:304,odb:48,diff:24,pack:19,refs:15
+revision/shallow.c component=revision role=lib prefix=shallow includes=odb:5,revision:4,diff:1,index:1,refs:1 cochange=odb:83,transport:73,revision:31,index:20,refs:14
+revision/shallow.h component=revision role=header prefix=shallow includes=odb:2,setup:1 cochange=revision:10,transport:7,odb:5,diff:3,index:2
 run-command.c component=? role=lib prefix=run-command includes=setup:2,index:1,pack:1 cochange=transport:27,index:21,setup:14,odb:8,submodule:6
 run-command.h component=? role=public prefix=run-command cochange=transport:21,setup:8,odb:6,submodule:5,refs:4
 sane-ctype.h component=? role=public prefix=sane-ctype
@@ -411,8 +413,6 @@ setup.h component=setup role=header prefix=setup includes=refs:1 cochange=setup:
 sh-i18n--envsubst.c component=? role=program prefix=sh-i18n--envsubst cochange=index:3,diff:1,transport:1
 sha1dc_git.c component=? role=lib prefix=sha1dc cochange=diff:3,odb:2,revision:2,setup:1
 sha1dc_git.h component=? role=public prefix=sha1dc cochange=odb:2
-shallow.c component=revision role=lib prefix=shallow includes=odb:5,revision:4,diff:1,index:1,refs:1 cochange=odb:83,transport:73,revision:31,index:20,refs:14
-shallow.h component=revision role=header prefix=shallow includes=odb:2,setup:1 cochange=revision:10,transport:7,odb:5,diff:3,index:2
 shell.c component=? role=program prefix=shell includes=setup:1 cochange=transport:10,setup:4,revision:2
 shortlog.h component=? role=public prefix=shortlog cochange=revision:2
 sideband.c component=transport role=lib prefix=sideband includes=transport:2,setup:1 cochange=transport:51,revision:6,diff:5,index:5,refs:4
diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index 4b50aaa40e..2da56ca8fc 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
@@ -429,7 +429,7 @@ Add the following includes:
 
 ----
 #include "odb/commit.h"
-#include "pretty.h"
+#include "revision/pretty.h"
 #include "strbuf.h"
 ----
 
diff --git a/Documentation/MyFirstObjectWalk.adoc b/Documentation/MyFirstObjectWalk.adoc
index 87b2433b2c..7fb63e6861 100644
--- a/Documentation/MyFirstObjectWalk.adoc
+++ b/Documentation/MyFirstObjectWalk.adoc
@@ -259,7 +259,7 @@ Add the `struct rev_info` and the `repo_init_revisions()` call.
 We'll also need to include the `revision.h` header:
 
 ----
-#include "revision.h"
+#include "revision/revision.h"
 
 ...
 
@@ -359,7 +359,7 @@ the walk loop below the `prepare_revision_walk()` call within your
 `walken_commit_walk()`:
 
 ----
-#include "pretty.h"
+#include "revision/pretty.h"
 
 ...
 
@@ -668,7 +668,7 @@ Complete your implementation of `walken_object_walk()`.
 We'll also need to include the `list-objects.h` header.
 
 ----
-#include "list-objects.h"
+#include "revision/list-objects.h"
 
 ...
 
diff --git a/Makefile b/Makefile
index b96345ba0c..74013e8380 100644
--- a/Makefile
+++ b/Makefile
@@ -1110,8 +1110,8 @@ LIB_OBJS += archive-zip.o
 LIB_OBJS += archive.o
 LIB_OBJS += attr.o
 LIB_OBJS += base85.o
-LIB_OBJS += bisect.o
-LIB_OBJS += blame.o
+LIB_OBJS += revision/bisect.o
+LIB_OBJS += revision/blame.o
 LIB_OBJS += odb/blob.o
 LIB_OBJS += pack/bloom.o
 LIB_OBJS += branch.o
@@ -1126,7 +1126,7 @@ LIB_OBJS += color.o
 LIB_OBJS += column.o
 LIB_OBJS += diff/combine-diff.o
 LIB_OBJS += pack/commit-graph.o
-LIB_OBJS += commit-reach.o
+LIB_OBJS += revision/commit-reach.o
 LIB_OBJS += odb/commit.o
 LIB_OBJS += common-exit.o
 LIB_OBJS += common-init.o
@@ -1144,7 +1144,7 @@ LIB_OBJS += credential.o
 LIB_OBJS += csum-file.o
 LIB_OBJS += ctype.o
 LIB_OBJS += date.o
-LIB_OBJS += decorate.o
+LIB_OBJS += revision/decorate.o
 LIB_OBJS += pack/delta-islands.o
 LIB_OBJS += diagnose.o
 LIB_OBJS += pack/diff-delta.o
@@ -1179,7 +1179,7 @@ LIB_OBJS += fsmonitor-settings.o
 LIB_OBJS += gettext.o
 LIB_OBJS += git-zlib.o
 LIB_OBJS += gpg-interface.o
-LIB_OBJS += graph.o
+LIB_OBJS += revision/graph.o
 LIB_OBJS += grep.o
 LIB_OBJS += odb/hash-lookup.o
 LIB_OBJS += odb/hash.o
@@ -1192,14 +1192,14 @@ LIB_OBJS += ident.o
 LIB_OBJS += json-writer.o
 LIB_OBJS += kwset.o
 LIB_OBJS += levenshtein.o
-LIB_OBJS += line-log.o
-LIB_OBJS += line-range.o
+LIB_OBJS += revision/line-log.o
+LIB_OBJS += revision/line-range.o
 LIB_OBJS += linear-assignment.o
-LIB_OBJS += list-objects-filter-options.o
-LIB_OBJS += list-objects-filter.o
-LIB_OBJS += list-objects.o
+LIB_OBJS += revision/list-objects-filter-options.o
+LIB_OBJS += revision/list-objects-filter.o
+LIB_OBJS += revision/list-objects.o
 LIB_OBJS += lockfile.o
-LIB_OBJS += log-tree.o
+LIB_OBJS += revision/log-tree.o
 LIB_OBJS += odb/loose.o
 LIB_OBJS += refs/ls-refs.o
 LIB_OBJS += mailinfo.o
@@ -1263,7 +1263,7 @@ LIB_OBJS += path-walk.o
 LIB_OBJS += pathspec.o
 LIB_OBJS += pkt-line.o
 LIB_OBJS += preload-index.o
-LIB_OBJS += pretty.o
+LIB_OBJS += revision/pretty.o
 LIB_OBJS += prio-queue.o
 LIB_OBJS += progress.o
 LIB_OBJS += promisor-remote.o
@@ -1317,14 +1317,14 @@ LIB_OBJS += repository.o
 LIB_OBJS += rerere.o
 LIB_OBJS += reset.o
 LIB_OBJS += resolve-undo.o
-LIB_OBJS += revision.o
+LIB_OBJS += revision/revision.o
 LIB_OBJS += run-command.o
 LIB_OBJS += send-pack.o
 LIB_OBJS += sequencer.o
 LIB_OBJS += serve.o
 LIB_OBJS += pack/server-info.o
 LIB_OBJS += setup.o
-LIB_OBJS += shallow.o
+LIB_OBJS += revision/shallow.o
 LIB_OBJS += sideband.o
 LIB_OBJS += sigchain.o
 LIB_OBJS += sparse-index.o
diff --git a/add-interactive.c b/add-interactive.c
index f656db231c..7bfc410361 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -10,7 +10,7 @@
 #include "preload-index.h"
 #include "read-cache-ll.h"
 #include "repository.h"
-#include "revision.h"
+#include "revision/revision.h"
 #include "refs/refs.h"
 #include "string-list.h"
 #include "lockfile.h"
diff --git a/archive.c b/archive.c
index 53820bd859..a2402fb7e6 100644
--- a/archive.c
+++ b/archive.c
@@ -11,7 +11,7 @@
 #include "hex.h"
 #include "odb/object-name.h"
 #include "path.h"
-#include "pretty.h"
+#include "revision/pretty.h"
 #include "setup.h"
 #include "refs/refs.h"
 #include "odb/odb.h"
diff --git a/attr.c b/attr.c
index e7c6562bee..e7d364d490 100644
--- a/attr.c
+++ b/attr.c
@@ -21,7 +21,7 @@
 #include "quote.h"
 #include "read-cache-ll.h"
 #include "refs/refs.h"
-#include "revision.h"
+#include "revision/revision.h"
 #include "odb/odb.h"
 #include "setup.h"
 #include "thread-utils.h"
diff --git a/builtin/add.c b/builtin/add.c
index dd5e33c7b0..4dbdccd928 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -22,7 +22,7 @@
 #include "preload-index.h"
 #include "diff/diff.h"
 #include "read-cache.h"
-#include "revision.h"
+#include "revision/revision.h"
 #include "strvec.h"
 #include "submodule.h"
 #include "add-interactive.h"
diff --git a/builtin/am.c b/builtin/am.c
index 7bd7fde14b..5dbe1f171b 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -30,9 +30,9 @@
 #include "odb/object-name.h"
 #include "preload-index.h"
 #include "sequencer.h"
-#include "revision.h"
+#include "revision/revision.h"
 #include "merge-ort-wrappers.h"
-#include "log-tree.h"
+#include "revision/log-tree.h"
 #include "notes-utils.h"
 #include "rerere.h"
 #include "mailinfo.h"
@@ -40,7 +40,7 @@
 #include "string-list.h"
 #include "pager.h"
 #include "path.h"
-#include "pretty.h"
+#include "revision/pretty.h"
 
 /**
  * Returns the length of the first line of msg.
diff --git a/builtin/backfill.c b/builtin/backfill.c
index c42226d3e8..d2ef39bc58 100644
--- a/builtin/backfill.c
+++ b/builtin/backfill.c
@@ -19,7 +19,7 @@
 #include "promisor-remote.h"
 #include "strmap.h"
 #include "string-list.h"
-#include "revision.h"
+#include "revision/revision.h"
 #include "trace2.h"
 #include "progress.h"
 #include "pack/packfile.h"
diff --git a/builtin/bisect.c b/builtin/bisect.c
index 51e2e949cc..cfb0741d22 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -8,7 +8,7 @@
 #include "hex.h"
 #include "odb/object-name.h"
 #include "parse-options.h"
-#include "bisect.h"
+#include "revision/bisect.h"
 #include "refs/refs.h"
 #include "strvec.h"
 #include "run-command.h"
@@ -16,7 +16,7 @@
 #include "path.h"
 #include "prompt.h"
 #include "quote.h"
-#include "revision.h"
+#include "revision/revision.h"
 
 static GIT_PATH_FUNC(git_path_bisect_terms, "BISECT_TERMS")
 static GIT_PATH_FUNC(git_path_bisect_ancestors_ok, "BISECT_ANCESTORS_OK")
diff --git a/builtin/blame.c b/builtin/blame.c
index cb9f8b4ff0..9e5776e31b 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -15,7 +15,7 @@
 #include "hex.h"
 #include "odb/commit.h"
 #include "diff/diff.h"
-#include "revision.h"
+#include "revision/revision.h"
 #include "quote.h"
 #include "string-list.h"
 #include "mailmap.h"
@@ -23,13 +23,13 @@
 #include "prio-queue.h"
 #include "utf8.h"
 #include "diff/userdiff.h"
-#include "line-range.h"
-#include "line-log.h"
+#include "revision/line-range.h"
+#include "revision/line-log.h"
 #include "progress.h"
 #include "odb/object-name.h"
 #include "odb/odb.h"
 #include "pager.h"
-#include "blame.h"
+#include "revision/blame.h"
 #include "refs/refs.h"
 #include "setup.h"
 #include "odb/tag.h"
diff --git a/builtin/branch.c b/builtin/branch.c
index 7909f250aa..c80df76d36 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -28,7 +28,7 @@
 #include "refs/worktree.h"
 #include "help.h"
 #include "advice.h"
-#include "commit-reach.h"
+#include "revision/commit-reach.h"
 
 static const char * const builtin_branch_usage[] = {
 	N_("git branch [<options>] [-r | -a] [--merged] [--no-merged] [(--forked <branch>)...]"),
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 4fd1999f80..94979a2683 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -15,7 +15,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "ident.h"
-#include "list-objects-filter-options.h"
+#include "revision/list-objects-filter-options.h"
 #include "parse-options.h"
 #include "diff/userdiff.h"
 #include "odb/oid-array.h"
diff --git a/builtin/checkout.c b/builtin/checkout.c
index c35c3d92d1..286fcdc1ba 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -28,7 +28,7 @@
 #include "remote.h"
 #include "repo-settings.h"
 #include "resolve-undo.h"
-#include "revision.h"
+#include "revision/revision.h"
 #include "sequencer.h"
 #include "setup.h"
 #include "sparse-index.h"
diff --git a/builtin/clone.c b/builtin/clone.c
index 7b5274e884..8ed07e1a15 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -43,7 +43,7 @@
 #include "pack/packfile.h"
 #include "path.h"
 #include "pkt-line.h"
-#include "list-objects-filter-options.h"
+#include "revision/list-objects-filter-options.h"
 #include "hook.h"
 #include "bundle.h"
 #include "bundle-uri.h"
diff --git a/builtin/commit.c b/builtin/commit.c
index d2b4ecbd40..aa89e0dc52 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -21,7 +21,7 @@
 #include "odb/commit.h"
 #include "add-interactive.h"
 #include "gettext.h"
-#include "revision.h"
+#include "revision/revision.h"
 #include "wt-status.h"
 #include "run-command.h"
 #include "strbuf.h"
@@ -39,9 +39,9 @@
 #include "sparse-index.h"
 #include "mailmap.h"
 #include "help.h"
-#include "commit-reach.h"
+#include "revision/commit-reach.h"
 #include "pack/commit-graph.h"
-#include "pretty.h"
+#include "revision/pretty.h"
 #include "trailer.h"
 
 static const char * const builtin_commit_usage[] = {
diff --git a/builtin/describe.c b/builtin/describe.c
index ff44b55e9e..bbeba1e465 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -13,14 +13,14 @@
 #include "odb/object-name.h"
 #include "parse-options.h"
 #include "read-cache-ll.h"
-#include "revision.h"
+#include "revision/revision.h"
 #include "diff/diff.h"
 #include "hashmap.h"
 #include "setup.h"
 #include "strvec.h"
 #include "run-command.h"
 #include "odb/odb.h"
-#include "list-objects.h"
+#include "revision/list-objects.h"
 #include "odb/commit-slab.h"
 #include "wildmatch.h"
 #include "prio-queue.h"
diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index 39eaf9cfce..d1e8d2b462 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -13,7 +13,7 @@
 #include "diff/diff-merges.h"
 #include "odb/commit.h"
 #include "preload-index.h"
-#include "revision.h"
+#include "revision/revision.h"
 
 static const char diff_files_usage[] =
 "git diff-files [-q] [-0 | -1 | -2 | -3 | -c | --cc] [<common-diff-options>] [<path>...]"
diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index 799f5533ad..f3b2eadda0 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -7,7 +7,7 @@
 #include "diff/diff-merges.h"
 #include "odb/commit.h"
 #include "preload-index.h"
-#include "revision.h"
+#include "revision/revision.h"
 #include "setup.h"
 
 static const char diff_cache_usage[] =
diff --git a/builtin/diff-pairs.c b/builtin/diff-pairs.c
index e3350b2915..df5630be47 100644
--- a/builtin/diff-pairs.c
+++ b/builtin/diff-pairs.c
@@ -7,7 +7,7 @@
 #include "hex.h"
 #include "odb/object.h"
 #include "parse-options.h"
-#include "revision.h"
+#include "revision/revision.h"
 #include "strbuf.h"
 
 static unsigned parse_mode_or_die(const char *mode, const char **end)
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 8f2103013c..2bd5ed4004 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -6,9 +6,9 @@
 #include "odb/commit.h"
 #include "gettext.h"
 #include "hex.h"
-#include "log-tree.h"
+#include "revision/log-tree.h"
 #include "read-cache-ll.h"
-#include "revision.h"
+#include "revision/revision.h"
 #include "odb/tmp-objdir.h"
 #include "odb/tree.h"
 
diff --git a/builtin/diff.c b/builtin/diff.c
index 774c12cea6..e4487901d3 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -20,8 +20,8 @@
 #include "diff/diffcore.h"
 #include "preload-index.h"
 #include "read-cache-ll.h"
-#include "revision.h"
-#include "log-tree.h"
+#include "revision/revision.h"
+#include "revision/log-tree.h"
 #include "setup.h"
 #include "odb/oid-array.h"
 #include "odb/tree.h"
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 6683d49660..565cdccb40 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -21,9 +21,9 @@
 #include "odb/tag.h"
 #include "diff/diff.h"
 #include "diff/diffcore.h"
-#include "log-tree.h"
-#include "revision.h"
-#include "decorate.h"
+#include "revision/log-tree.h"
+#include "revision/revision.h"
+#include "revision/decorate.h"
 #include "string-list.h"
 #include "utf8.h"
 #include "parse-options.h"
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 3b7d650e24..f3af94307f 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -26,7 +26,7 @@
 #include "odb/object-name.h"
 #include "odb/odb.h"
 #include "mem-pool.h"
-#include "commit-reach.h"
+#include "revision/commit-reach.h"
 #include "khash.h"
 #include "date.h"
 #include "gpg-interface.h"
diff --git a/builtin/fetch.c b/builtin/fetch.c
index b14b96ce5c..2f744ac8b8 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -32,12 +32,12 @@
 #include "pager.h"
 #include "path.h"
 #include "pkt-line.h"
-#include "list-objects-filter-options.h"
-#include "commit-reach.h"
+#include "revision/list-objects-filter-options.h"
+#include "revision/commit-reach.h"
 #include "branch.h"
 #include "promisor-remote.h"
 #include "pack/commit-graph.h"
-#include "shallow.h"
+#include "revision/shallow.h"
 #include "trace.h"
 #include "trace2.h"
 #include "bundle-uri.h"
diff --git a/builtin/gc.c b/builtin/gc.c
index bdf3d43108..c340489c64 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -34,7 +34,7 @@
 #include "path.h"
 #include "refs/reflog.h"
 #include "rerere.h"
-#include "revision.h"
+#include "revision/revision.h"
 #include "refs/refs.h"
 #include "remote.h"
 #include "exec-cmd.h"
diff --git a/builtin/history.c b/builtin/history.c
index 56b5015bc0..73a31ce152 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -3,7 +3,7 @@
 #include "builtin.h"
 #include "cache-tree.h"
 #include "odb/commit.h"
-#include "commit-reach.h"
+#include "revision/commit-reach.h"
 #include "config.h"
 #include "editor.h"
 #include "environment.h"
@@ -18,7 +18,7 @@
 #include "refs/refs.h"
 #include "replay.h"
 #include "reset.h"
-#include "revision.h"
+#include "revision/revision.h"
 #include "sequencer.h"
 #include "strvec.h"
 #include "odb/tree.h"
diff --git a/builtin/last-modified.c b/builtin/last-modified.c
index 911441a321..88e122db9b 100644
--- a/builtin/last-modified.c
+++ b/builtin/last-modified.c
@@ -17,7 +17,7 @@
 #include "prio-queue.h"
 #include "quote.h"
 #include "repository.h"
-#include "revision.h"
+#include "revision/revision.h"
 
 /* Remember to update object flag allocation in object.h */
 #define PARENT1 (1u<<16) /* used instead of SEEN */
diff --git a/builtin/log.c b/builtin/log.c
index a93b97858b..82144cf2b6 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -23,8 +23,8 @@
 #include "diff/diff.h"
 #include "diff/diffcore.h"
 #include "diff/diff-merges.h"
-#include "revision.h"
-#include "log-tree.h"
+#include "revision/revision.h"
+#include "revision/log-tree.h"
 #include "odb/oid-array.h"
 #include "odb/oidset.h"
 #include "odb/tag.h"
@@ -35,7 +35,7 @@
 #include "remote.h"
 #include "string-list.h"
 #include "parse-options.h"
-#include "line-log.h"
+#include "revision/line-log.h"
 #include "branch.h"
 #include "version.h"
 #include "mailmap.h"
@@ -44,7 +44,7 @@
 #include "advice.h"
 #include "utf8.h"
 
-#include "commit-reach.h"
+#include "revision/commit-reach.h"
 #include "promisor-remote.h"
 #include "diff/range-diff.h"
 #include "odb/tmp-objdir.h"
diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index 191e4e7fa0..7eec05ae7b 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -7,7 +7,7 @@
 #include "hex.h"
 #include "odb/object-name.h"
 #include "parse-options.h"
-#include "commit-reach.h"
+#include "revision/commit-reach.h"
 
 static int show_merge_base(struct commit **rev, size_t rev_nr, int show_all)
 {
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 8217938d86..41d8bbcbc1 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -8,7 +8,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "odb/commit.h"
-#include "commit-reach.h"
+#include "revision/commit-reach.h"
 #include "merge-ort.h"
 #include "odb/object-name.h"
 #include "odb/odb.h"
diff --git a/builtin/merge.c b/builtin/merge.c
index 7ec4554b0b..268ffc4855 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -31,7 +31,7 @@
 #include "odb/commit.h"
 #include "diff/diffcore.h"
 #include "path.h"
-#include "revision.h"
+#include "revision/revision.h"
 #include "unpack-trees.h"
 #include "cache-tree.h"
 #include "dir.h"
@@ -48,7 +48,7 @@
 #include "odb/tag.h"
 #include "alias.h"
 #include "branch.h"
-#include "commit-reach.h"
+#include "revision/commit-reach.h"
 #include "wt-status.h"
 #include "pack/commit-graph.h"
 
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index f3f4714c1d..31bc960b34 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -17,8 +17,8 @@
 #include "pack/commit-graph.h"
 #include "wildmatch.h"
 #include "mem-pool.h"
-#include "pretty.h"
-#include "revision.h"
+#include "revision/pretty.h"
+#include "revision/revision.h"
 #include "notes.h"
 #include "write-or-die.h"
 
diff --git a/builtin/notes.c b/builtin/notes.c
index 6ebb5db39c..61087b0fa5 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -19,7 +19,7 @@
 #include "odb/odb.h"
 #include "path.h"
 
-#include "pretty.h"
+#include "revision/pretty.h"
 #include "refs/refs.h"
 #include "exec-cmd.h"
 #include "run-command.h"
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 17721f13ac..3b025a08e9 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -16,9 +16,9 @@
 #include "csum-file.h"
 #include "odb/tree-walk.h"
 #include "diff/diff.h"
-#include "revision.h"
-#include "list-objects.h"
-#include "list-objects-filter-options.h"
+#include "revision/revision.h"
+#include "revision/list-objects.h"
+#include "revision/list-objects-filter-options.h"
 #include "pack/pack-objects.h"
 #include "progress.h"
 #include "refs/refs.h"
@@ -29,7 +29,7 @@
 #include "odb/oid-array.h"
 #include "strvec.h"
 #include "strmap.h"
-#include "list.h"
+#include "revision/list.h"
 #include "pack/packfile.h"
 #include "odb/object-file.h"
 #include "odb/object-file-convert.h"
@@ -39,7 +39,7 @@
 #include "dir.h"
 #include "pack/midx.h"
 #include "trace2.h"
-#include "shallow.h"
+#include "revision/shallow.h"
 #include "promisor-remote.h"
 #include "pack/pack-mtimes.h"
 #include "parse-options.h"
diff --git a/builtin/prune.c b/builtin/prune.c
index 0adf0f02d1..ba7b1303b3 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -7,7 +7,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
-#include "revision.h"
+#include "revision/revision.h"
 #include "pack/reachable.h"
 #include "parse-options.h"
 #include "path.h"
@@ -17,7 +17,7 @@
 #include "odb/object-file.h"
 #include "odb/object-name.h"
 #include "odb/odb.h"
-#include "shallow.h"
+#include "revision/shallow.h"
 
 static const char * const prune_usage[] = {
 	N_("git prune [-n] [-v] [--progress] [--expire <time>] [--] [<head>...]"),
diff --git a/builtin/pull.c b/builtin/pull.c
index bc8dcde318..af120a7e1b 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -29,7 +29,7 @@
 #include "submodule.h"
 #include "submodule-config.h"
 #include "wt-status.h"
-#include "commit-reach.h"
+#include "revision/commit-reach.h"
 #include "sequencer.h"
 
 /**
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 8f9fdcc79b..a14a31d60e 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -27,8 +27,8 @@
 #include "odb/commit.h"
 #include "diff/diff.h"
 #include "wt-status.h"
-#include "revision.h"
-#include "commit-reach.h"
+#include "revision/revision.h"
+#include "revision/commit-reach.h"
 #include "rerere.h"
 #include "branch.h"
 #include "sequencer.h"
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index f01cc1a188..9a816f1e86 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -4,7 +4,7 @@
 #include "builtin.h"
 #include "abspath.h"
 #include "odb/commit.h"
-#include "commit-reach.h"
+#include "revision/commit-reach.h"
 #include "config.h"
 #include "connect.h"
 #include "connected.h"
@@ -32,7 +32,7 @@
 #include "run-command.h"
 #include "pack/server-info.h"
 #include "setup.h"
-#include "shallow.h"
+#include "revision/shallow.h"
 #include "sideband.h"
 #include "sigchain.h"
 #include "string-list.h"
diff --git a/builtin/reflog.c b/builtin/reflog.c
index d227104063..d8d1cb2c6a 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -5,7 +5,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "odb/odb.h"
-#include "revision.h"
+#include "revision/revision.h"
 #include "pack/reachable.h"
 #include "wildmatch.h"
 #include "refs/worktree.h"
diff --git a/builtin/remote.c b/builtin/remote.c
index 9a5df99c11..3f6cee14ff 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -18,7 +18,7 @@
 #include "refs/refspec.h"
 #include "odb/odb.h"
 #include "strvec.h"
-#include "commit-reach.h"
+#include "revision/commit-reach.h"
 #include "progress.h"
 
 static const char * const builtin_remote_usage[] = {
diff --git a/builtin/repack.c b/builtin/repack.c
index 5927a0dfdb..aa74f2161a 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -13,7 +13,7 @@
 #include "pack/prune-packed.h"
 #include "promisor-remote.h"
 #include "pack/repack.h"
-#include "shallow.h"
+#include "revision/shallow.h"
 
 #define ALL_INTO_ONE 1
 #define LOOSEN_UNREACHABLE 2
diff --git a/builtin/replay.c b/builtin/replay.c
index 83b136a13e..4f5515a314 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -11,7 +11,7 @@
 #include "parse-options.h"
 #include "refs/refs.h"
 #include "replay.h"
-#include "revision.h"
+#include "revision/revision.h"
 
 enum ref_action_mode {
 	REF_ACTION_UPDATE,
diff --git a/builtin/repo.c b/builtin/repo.c
index e052e6c0ba..b296e2cda7 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -13,11 +13,11 @@
 #include "quote.h"
 #include "refs/ref-filter.h"
 #include "refs/refs.h"
-#include "revision.h"
+#include "revision/revision.h"
 #include "setup.h"
 #include "strbuf.h"
 #include "string-list.h"
-#include "shallow.h"
+#include "revision/shallow.h"
 #include "odb/tree.h"
 #include "odb/tree-walk.h"
 #include "utf8.h"
diff --git a/builtin/reset.c b/builtin/reset.c
index f843bab823..eed0d0ea0b 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -19,7 +19,7 @@
 #include "hex.h"
 #include "lockfile.h"
 #include "odb/object.h"
-#include "pretty.h"
+#include "revision/pretty.h"
 #include "refs/refs.h"
 #include "diff/diff.h"
 #include "diff/diffcore.h"
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index c0e0769aab..21d7b8aa81 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -8,24 +8,24 @@
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
-#include "revision.h"
-#include "list-objects.h"
-#include "list-objects-filter-options.h"
+#include "revision/revision.h"
+#include "revision/list-objects.h"
+#include "revision/list-objects-filter-options.h"
 #include "odb/object.h"
 #include "odb/object-name.h"
 #include "odb/object-file.h"
 #include "odb/odb.h"
 #include "pack/pack-bitmap.h"
 #include "parse-options.h"
-#include "log-tree.h"
-#include "graph.h"
-#include "bisect.h"
+#include "revision/log-tree.h"
+#include "revision/graph.h"
+#include "revision/bisect.h"
 #include "progress.h"
 #include "refs/reflog-walk.h"
 #include "odb/oidset.h"
 #include "odb/oidmap.h"
 #include "pack/packfile.h"
-#include "commit-reach.h"
+#include "revision/commit-reach.h"
 #include "quote.h"
 #include "strbuf.h"
 
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index b95cdac85e..ef4b6795dd 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -10,7 +10,7 @@
 #include "builtin.h"
 
 #include "abspath.h"
-#include "bisect.h"
+#include "revision/bisect.h"
 #include "config.h"
 #include "odb/commit.h"
 #include "environment.h"
@@ -26,12 +26,12 @@
 #include "read-cache-ll.h"
 #include "repo-settings.h"
 #include "repository.h"
-#include "revision.h"
+#include "revision/revision.h"
 #include "setup.h"
 #include "split-index.h"
 #include "submodule.h"
-#include "commit-reach.h"
-#include "shallow.h"
+#include "revision/commit-reach.h"
+#include "revision/shallow.h"
 #include "odb/object-file-convert.h"
 
 #define DO_REVS		1
diff --git a/builtin/revert.c b/builtin/revert.c
index a939c590fb..ae3f186f12 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -6,7 +6,7 @@
 #include "diff/diff.h"
 #include "environment.h"
 #include "gettext.h"
-#include "revision.h"
+#include "revision/revision.h"
 #include "rerere.h"
 #include "sequencer.h"
 #include "branch.h"
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 59be73a372..2fe86d6f46 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -7,7 +7,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "string-list.h"
-#include "revision.h"
+#include "revision/revision.h"
 #include "utf8.h"
 #include "mailmap.h"
 #include "setup.h"
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 4da3330a26..8db11f6e4c 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -7,7 +7,7 @@
 #include "gettext.h"
 #include "odb/hash.h"
 #include "hex.h"
-#include "pretty.h"
+#include "revision/pretty.h"
 #include "refs/refs.h"
 #include "color.h"
 #include "strvec.h"
diff --git a/builtin/stash.c b/builtin/stash.c
index c5e100746d..6458e3a2d6 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -22,10 +22,10 @@
 #include "read-cache.h"
 #include "repository.h"
 #include "rerere.h"
-#include "revision.h"
+#include "revision/revision.h"
 #include "setup.h"
 #include "sparse-index.h"
-#include "log-tree.h"
+#include "revision/log-tree.h"
 #include "diff/diffcore.h"
 #include "refs/reflog.h"
 #include "refs/reflog-walk.h"
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 5711a79428..0e061827f9 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -23,7 +23,7 @@
 #include "remote.h"
 #include "refs/refs.h"
 #include "refs/refspec.h"
-#include "revision.h"
+#include "revision/revision.h"
 #include "diff/diffcore.h"
 #include "diff/diff.h"
 #include "odb/object-file.h"
@@ -32,7 +32,7 @@
 #include "odb/source.h"
 #include "advice.h"
 #include "branch.h"
-#include "list-objects-filter-options.h"
+#include "revision/list-objects-filter-options.h"
 #include "wildmatch.h"
 #include "strbuf.h"
 #include "url.h"
diff --git a/builtin/tag.c b/builtin/tag.c
index c04c2cc207..46df0f7c27 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -24,7 +24,7 @@
 #include "odb/tag.h"
 #include "parse-options.h"
 #include "diff/diff.h"
-#include "revision.h"
+#include "revision/revision.h"
 #include "gpg-interface.h"
 #include "odb/oid-array.h"
 #include "column.h"
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 93caca20ef..fb724e46ea 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -18,7 +18,7 @@
 #include "odb/replace-object.h"
 #include "strbuf.h"
 #include "progress.h"
-#include "decorate.h"
+#include "revision/decorate.h"
 #include "odb/fsck.h"
 #include "pack/packfile.h"
 
diff --git a/bundle.c b/bundle.c
index 54ec76866b..dc50661bdd 100644
--- a/bundle.c
+++ b/bundle.c
@@ -12,12 +12,12 @@
 #include "odb/object.h"
 #include "odb/commit.h"
 #include "diff/diff.h"
-#include "revision.h"
-#include "list-objects.h"
+#include "revision/revision.h"
+#include "revision/list-objects.h"
 #include "run-command.h"
 #include "refs/refs.h"
 #include "strvec.h"
-#include "list-objects-filter-options.h"
+#include "revision/list-objects-filter-options.h"
 #include "connected.h"
 #include "write-or-die.h"
 
diff --git a/bundle.h b/bundle.h
index d664b2f2d6..fc78766902 100644
--- a/bundle.h
+++ b/bundle.h
@@ -3,7 +3,7 @@
 
 #include "strvec.h"
 #include "string-list.h"
-#include "list-objects-filter-options.h"
+#include "revision/list-objects-filter-options.h"
 
 struct bundle_header {
 	unsigned version;
diff --git a/chdir-notify.c b/chdir-notify.c
index 1237a45e2e..3d1d5ee3d2 100644
--- a/chdir-notify.c
+++ b/chdir-notify.c
@@ -1,7 +1,7 @@
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "chdir-notify.h"
-#include "list.h"
+#include "revision/list.h"
 #include "path.h"
 #include "strbuf.h"
 #include "trace.h"
diff --git a/diff/combine-diff.c b/diff/combine-diff.c
index 44f0eb5442..8e03062f39 100644
--- a/diff/combine-diff.c
+++ b/diff/combine-diff.c
@@ -13,12 +13,12 @@
 #include "quote.h"
 #include "diff/xdiff-interface.h"
 #include "xdiff/xmacros.h"
-#include "log-tree.h"
+#include "revision/log-tree.h"
 #include "refs/refs.h"
 #include "odb/tree.h"
 #include "diff/userdiff.h"
 #include "odb/oid-array.h"
-#include "revision.h"
+#include "revision/revision.h"
 
 static int compare_paths(const struct combine_diff_path *one,
 			  const struct diff_filespec *two)
diff --git a/diff/diff-lib.c b/diff/diff-lib.c
index fb0514dcb0..d48196f7c7 100644
--- a/diff/diff-lib.c
+++ b/diff/diff-lib.c
@@ -14,7 +14,7 @@
 #include "hex.h"
 #include "odb/object-name.h"
 #include "read-cache.h"
-#include "revision.h"
+#include "revision/revision.h"
 #include "cache-tree.h"
 #include "unpack-trees.h"
 #include "refs/refs.h"
@@ -24,7 +24,7 @@
 #include "trace.h"
 #include "dir.h"
 #include "fsmonitor.h"
-#include "commit-reach.h"
+#include "revision/commit-reach.h"
 
 /*
  * diff-files
diff --git a/diff/diff-merges.c b/diff/diff-merges.c
index ca3cbf7767..8300d21a4f 100644
--- a/diff/diff-merges.c
+++ b/diff/diff-merges.c
@@ -2,7 +2,7 @@
 #include "diff/diff-merges.h"
 
 #include "gettext.h"
-#include "revision.h"
+#include "revision/revision.h"
 
 typedef void (*diff_merges_setup_func_t)(struct rev_info *);
 static void set_separate(struct rev_info *revs);
diff --git a/diff/diff-no-index.c b/diff/diff-no-index.c
index 5712e5474d..19cb90d121 100644
--- a/diff/diff-no-index.c
+++ b/diff/diff-no-index.c
@@ -13,7 +13,7 @@
 #include "diff/diff.h"
 #include "diff/diffcore.h"
 #include "gettext.h"
-#include "revision.h"
+#include "revision/revision.h"
 #include "parse-options.h"
 #include "pathspec.h"
 #include "string-list.h"
diff --git a/diff/diff.c b/diff/diff.c
index 9062f96b7b..2b87f27238 100644
--- a/diff/diff.c
+++ b/diff/diff.c
@@ -13,7 +13,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "tempfile.h"
-#include "revision.h"
+#include "revision/revision.h"
 #include "quote.h"
 #include "diff/diff.h"
 #include "diff/diffcore.h"
@@ -32,7 +32,7 @@
 #include "string-list.h"
 #include "strvec.h"
 #include "odb/tmp-objdir.h"
-#include "graph.h"
+#include "revision/graph.h"
 #include "odb/oid-array.h"
 #include "pack/packfile.h"
 #include "pager.h"
diff --git a/diff/diffcore-pickaxe.c b/diff/diffcore-pickaxe.c
index e7289d9a26..d851afe3db 100644
--- a/diff/diffcore-pickaxe.c
+++ b/diff/diffcore-pickaxe.c
@@ -11,7 +11,7 @@
 #include "diff/xdiff-interface.h"
 #include "kwset.h"
 #include "odb/oidset.h"
-#include "pretty.h"
+#include "revision/pretty.h"
 #include "quote.h"
 
 typedef int (*pickaxe_fn)(mmfile_t *one, mmfile_t *two,
diff --git a/diff/range-diff.c b/diff/range-diff.c
index 2177b8ba2d..281c043480 100644
--- a/diff/range-diff.c
+++ b/diff/range-diff.c
@@ -15,11 +15,11 @@
 #include "diff/diffcore.h"
 #include "odb/commit.h"
 #include "pager.h"
-#include "pretty.h"
+#include "revision/pretty.h"
 #include "repository.h"
 #include "diff/userdiff.h"
 #include "apply.h"
-#include "revision.h"
+#include "revision/revision.h"
 
 struct patch_util {
 	/* For the search for an exact match */
diff --git a/fetch-pack.c b/fetch-pack.c
index b19cb3239e..d27a28502f 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -30,8 +30,8 @@
 #include "connected.h"
 #include "fetch-negotiator.h"
 #include "odb/fsck.h"
-#include "shallow.h"
-#include "commit-reach.h"
+#include "revision/shallow.h"
+#include "revision/commit-reach.h"
 #include "pack/commit-graph.h"
 #include "sigchain.h"
 #include "mergesort.h"
diff --git a/fetch-pack.h b/fetch-pack.h
index 14e4ba1079..42922616be 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -3,7 +3,7 @@
 
 #include "string-list.h"
 #include "protocol.h"
-#include "list-objects-filter-options.h"
+#include "revision/list-objects-filter-options.h"
 #include "odb/oidset.h"
 
 struct oid_array;
diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index 34f769ae9f..4993cc4a02 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -10,12 +10,12 @@
 #include "diff/diff.h"
 #include "diff/diff-merges.h"
 #include "hex.h"
-#include "revision.h"
+#include "revision/revision.h"
 #include "odb/tag.h"
 #include "string-list.h"
 #include "branch.h"
 #include "fmt-merge-msg.h"
-#include "commit-reach.h"
+#include "revision/commit-reach.h"
 #include "gpg-interface.h"
 #include "wildmatch.h"
 
diff --git a/git.c b/git.c
index 619219afef..9dace05858 100644
--- a/git.c
+++ b/git.c
@@ -14,7 +14,7 @@
 #include "odb/replace-object.h"
 #include "setup.h"
 #include "attr.h"
-#include "shallow.h"
+#include "revision/shallow.h"
 #include "trace.h"
 #include "trace2.h"
 
diff --git a/grep.c b/grep.c
index 88c87ba1c9..c4eb18ccd7 100644
--- a/grep.c
+++ b/grep.c
@@ -6,7 +6,7 @@
 #include "grep.h"
 #include "hex.h"
 #include "odb/odb.h"
-#include "pretty.h"
+#include "revision/pretty.h"
 #include "diff/userdiff.h"
 #include "diff/xdiff-interface.h"
 #include "diff/diff.h"
diff --git a/http-push.c b/http-push.c
index 6d38410ccb..d45daee9e0 100644
--- a/http-push.c
+++ b/http-push.c
@@ -9,9 +9,9 @@
 #include "odb/blob.h"
 #include "http.h"
 #include "diff/diff.h"
-#include "revision.h"
+#include "revision/revision.h"
 #include "remote.h"
-#include "list-objects.h"
+#include "revision/list-objects.h"
 #include "setup.h"
 #include "sigchain.h"
 #include "strvec.h"
@@ -21,7 +21,7 @@
 #include "pack/packfile.h"
 #include "odb/object-file.h"
 #include "odb/odb.h"
-#include "commit-reach.h"
+#include "revision/commit-reach.h"
 
 #ifdef EXPAT_NEEDS_XMLPARSE_H
 #include <xmlparse.h>
diff --git a/http-walker.c b/http-walker.c
index e73c3677d1..8df0c5329b 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -6,7 +6,7 @@
 #include "hex.h"
 #include "walker.h"
 #include "http.h"
-#include "list.h"
+#include "revision/list.h"
 #include "transport.h"
 #include "pack/packfile.h"
 #include "odb/object-file.h"
diff --git a/merge-ort.c b/merge-ort.c
index 61fb855500..71274c24bf 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -25,7 +25,7 @@
 #include "attr.h"
 #include "cache-tree.h"
 #include "odb/commit.h"
-#include "commit-reach.h"
+#include "revision/commit-reach.h"
 #include "config.h"
 #include "diff/diff.h"
 #include "diff/diffcore.h"
@@ -45,7 +45,7 @@
 #include "promisor-remote.h"
 #include "read-cache-ll.h"
 #include "refs/refs.h"
-#include "revision.h"
+#include "revision/revision.h"
 #include "sparse-index.h"
 #include "strmap.h"
 #include "trace2.h"
diff --git a/meson.build b/meson.build
index 87060ff883..65be53078d 100644
--- a/meson.build
+++ b/meson.build
@@ -319,8 +319,8 @@ libgit_sources = [
   'archive.c',
   'attr.c',
   'base85.c',
-  'bisect.c',
-  'blame.c',
+  'revision/bisect.c',
+  'revision/blame.c',
   'odb/blob.c',
   'pack/bloom.c',
   'branch.c',
@@ -335,7 +335,7 @@ libgit_sources = [
   'column.c',
   'diff/combine-diff.c',
   'pack/commit-graph.c',
-  'commit-reach.c',
+  'revision/commit-reach.c',
   'odb/commit.c',
   'common-exit.c',
   'common-init.c',
@@ -349,7 +349,7 @@ libgit_sources = [
   'csum-file.c',
   'ctype.c',
   'date.c',
-  'decorate.c',
+  'revision/decorate.c',
   'pack/delta-islands.c',
   'diagnose.c',
   'pack/diff-delta.c',
@@ -384,7 +384,7 @@ libgit_sources = [
   'gettext.c',
   'git-zlib.c',
   'gpg-interface.c',
-  'graph.c',
+  'revision/graph.c',
   'grep.c',
   'odb/hash-lookup.c',
   'odb/hash.c',
@@ -397,14 +397,14 @@ libgit_sources = [
   'json-writer.c',
   'kwset.c',
   'levenshtein.c',
-  'line-log.c',
-  'line-range.c',
+  'revision/line-log.c',
+  'revision/line-range.c',
   'linear-assignment.c',
-  'list-objects-filter-options.c',
-  'list-objects-filter.c',
-  'list-objects.c',
+  'revision/list-objects-filter-options.c',
+  'revision/list-objects-filter.c',
+  'revision/list-objects.c',
   'lockfile.c',
-  'log-tree.c',
+  'revision/log-tree.c',
   'odb/loose.c',
   'refs/ls-refs.c',
   'mailinfo.c',
@@ -468,7 +468,7 @@ libgit_sources = [
   'pathspec.c',
   'pkt-line.c',
   'preload-index.c',
-  'pretty.c',
+  'revision/pretty.c',
   'prio-queue.c',
   'progress.c',
   'promisor-remote.c',
@@ -522,14 +522,14 @@ libgit_sources = [
   'rerere.c',
   'reset.c',
   'resolve-undo.c',
-  'revision.c',
+  'revision/revision.c',
   'run-command.c',
   'send-pack.c',
   'sequencer.c',
   'serve.c',
   'pack/server-info.c',
   'setup.c',
-  'shallow.c',
+  'revision/shallow.c',
   'sideband.c',
   'sigchain.c',
   'sparse-index.c',
diff --git a/notes-cache.c b/notes-cache.c
index 02fb418c6f..1e734c5c19 100644
--- a/notes-cache.c
+++ b/notes-cache.c
@@ -4,7 +4,7 @@
 #include "notes-cache.h"
 #include "odb/object-file.h"
 #include "odb/odb.h"
-#include "pretty.h"
+#include "revision/pretty.h"
 #include "repository.h"
 #include "odb/commit.h"
 #include "refs/refs.h"
diff --git a/notes-merge.c b/notes-merge.c
index ff14b7dfcc..53f42ba863 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -22,7 +22,7 @@
 #include "strbuf.h"
 #include "trace.h"
 #include "notes-utils.h"
-#include "commit-reach.h"
+#include "revision/commit-reach.h"
 
 struct notes_merge_pair {
 	struct object_id obj, base, local, remote;
diff --git a/odb/commit.c b/odb/commit.c
index b78cd28013..1b0703a9ef 100644
--- a/odb/commit.c
+++ b/odb/commit.c
@@ -12,7 +12,7 @@
 #include "odb/odb.h"
 #include "utf8.h"
 #include "diff/diff.h"
-#include "revision.h"
+#include "revision/revision.h"
 #include "notes.h"
 #include "odb/alloc.h"
 #include "gpg-interface.h"
@@ -23,9 +23,9 @@
 #include "wt-status.h"
 #include "advice.h"
 #include "refs/refs.h"
-#include "commit-reach.h"
+#include "revision/commit-reach.h"
 #include "setup.h"
-#include "shallow.h"
+#include "revision/shallow.h"
 #include "odb/tree.h"
 #include "hook.h"
 #include "parse.h"
diff --git a/odb/object-name.c b/odb/object-name.c
index ff61d55590..825fc717bf 100644
--- a/odb/object-name.c
+++ b/odb/object-name.c
@@ -17,13 +17,13 @@
 #include "dir.h"
 #include "odb/odb.h"
 #include "odb/oid-array.h"
-#include "pretty.h"
+#include "revision/pretty.h"
 #include "read-cache-ll.h"
 #include "repo-settings.h"
 #include "repository.h"
 #include "setup.h"
 #include "pack/midx.h"
-#include "commit-reach.h"
+#include "revision/commit-reach.h"
 #include "date.h"
 #include "odb/object-file-convert.h"
 #include "prio-queue.h"
diff --git a/odb/source-packed.c b/odb/source-packed.c
index 0e391f6fcf..c1e2756471 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -3,7 +3,7 @@
 #include "chdir-notify.h"
 #include "dir.h"
 #include "git-zlib.h"
-#include "list-objects-filter-options.h"
+#include "revision/list-objects-filter-options.h"
 #include "mergesort.h"
 #include "pack/midx.h"
 #include "odb/source-packed.h"
diff --git a/pack/commit-graph.c b/pack/commit-graph.c
index afc04d74a5..d5537a9ee8 100644
--- a/pack/commit-graph.c
+++ b/pack/commit-graph.c
@@ -22,7 +22,7 @@
 #include "progress.h"
 #include "pack/bloom.h"
 #include "odb/commit-slab.h"
-#include "shallow.h"
+#include "revision/shallow.h"
 #include "json-writer.h"
 #include "trace2.h"
 #include "odb/tree.h"
diff --git a/pack/midx-write.c b/pack/midx-write.c
index 1f8f24410a..1d5a6525a6 100644
--- a/pack/midx-write.c
+++ b/pack/midx-write.c
@@ -13,8 +13,8 @@
 #include "pack/chunk-format.h"
 #include "pack/pack-bitmap.h"
 #include "refs/refs.h"
-#include "revision.h"
-#include "list-objects.h"
+#include "revision/revision.h"
+#include "revision/list-objects.h"
 #include "path.h"
 #include "pack/pack-revindex.h"
 
diff --git a/pack/pack-bitmap-write.c b/pack/pack-bitmap-write.c
index 22ee370bde..3b7b41c5d7 100644
--- a/pack/pack-bitmap-write.c
+++ b/pack/pack-bitmap-write.c
@@ -7,14 +7,14 @@
 #include "odb/odb.h"
 #include "odb/commit.h"
 #include "diff/diff.h"
-#include "revision.h"
+#include "revision/revision.h"
 #include "progress.h"
 #include "pack/pack.h"
 #include "pack/pack-bitmap.h"
 #include "odb/hash-lookup.h"
 #include "pack/pack-objects.h"
 #include "path.h"
-#include "commit-reach.h"
+#include "revision/commit-reach.h"
 #include "prio-queue.h"
 #include "trace2.h"
 #include "odb/tree.h"
diff --git a/pack/pack-bitmap.c b/pack/pack-bitmap.c
index 3adb5d0563..7cd24a37f5 100644
--- a/pack/pack-bitmap.c
+++ b/pack/pack-bitmap.c
@@ -7,9 +7,9 @@
 #include "strbuf.h"
 #include "odb/tag.h"
 #include "diff/diff.h"
-#include "revision.h"
+#include "revision/revision.h"
 #include "progress.h"
-#include "list-objects.h"
+#include "revision/list-objects.h"
 #include "pack/pack.h"
 #include "pack/pack-bitmap.h"
 #include "pack/pack-revindex.h"
@@ -18,7 +18,7 @@
 #include "repository.h"
 #include "trace2.h"
 #include "odb/odb.h"
-#include "list-objects-filter-options.h"
+#include "revision/list-objects-filter-options.h"
 #include "pack/midx.h"
 #include "config.h"
 #include "pack/pseudo-merge.h"
diff --git a/pack/packfile.c b/pack/packfile.c
index 0426bee827..72252faffe 100644
--- a/pack/packfile.c
+++ b/pack/packfile.c
@@ -4,7 +4,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
-#include "list.h"
+#include "revision/list.h"
 #include "pack/pack.h"
 #include "repository.h"
 #include "dir.h"
diff --git a/pack/packfile.h b/pack/packfile.h
index 55dc02539b..1e6e69fb77 100644
--- a/pack/packfile.h
+++ b/pack/packfile.h
@@ -1,7 +1,7 @@
 #ifndef PACKFILE_H
 #define PACKFILE_H
 
-#include "list.h"
+#include "revision/list.h"
 #include "odb/object.h"
 #include "odb/odb.h"
 #include "odb/source-files.h"
diff --git a/pack/reachable.c b/pack/reachable.c
index 7989f7327a..f61525308e 100644
--- a/pack/reachable.c
+++ b/pack/reachable.c
@@ -7,11 +7,11 @@
 #include "odb/commit.h"
 #include "odb/blob.h"
 #include "diff/diff.h"
-#include "revision.h"
+#include "revision/revision.h"
 #include "pack/reachable.h"
 #include "cache-tree.h"
 #include "progress.h"
-#include "list-objects.h"
+#include "revision/list-objects.h"
 #include "pack/packfile.h"
 #include "refs/worktree.h"
 #include "odb/object-file.h"
diff --git a/pack/repack.h b/pack/repack.h
index f9fbc895f0..6248e7deac 100644
--- a/pack/repack.h
+++ b/pack/repack.h
@@ -1,7 +1,7 @@
 #ifndef REPACK_H
 #define REPACK_H
 
-#include "list-objects-filter-options.h"
+#include "revision/list-objects-filter-options.h"
 #include "string-list.h"
 
 struct pack_objects_args {
diff --git a/path-walk.c b/path-walk.c
index ed4d3211d2..4b8ddb2a28 100644
--- a/path-walk.c
+++ b/path-walk.c
@@ -8,8 +8,8 @@
 #include "dir.h"
 #include "hashmap.h"
 #include "hex.h"
-#include "list-objects.h"
-#include "list-objects-filter-options.h"
+#include "revision/list-objects.h"
+#include "revision/list-objects-filter-options.h"
 #include "odb/object-name.h"
 #include "odb/odb.h"
 #include "odb/object.h"
@@ -17,7 +17,7 @@
 #include "path.h"
 #include "prio-queue.h"
 #include "repository.h"
-#include "revision.h"
+#include "revision/revision.h"
 #include "string-list.h"
 #include "strmap.h"
 #include "odb/tag.h"
diff --git a/read-cache.c b/read-cache.c
index 5bca3fda12..a970eb1b6a 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -34,7 +34,7 @@
 #include "read-cache.h"
 #include "repository.h"
 #include "resolve-undo.h"
-#include "revision.h"
+#include "revision/revision.h"
 #include "strbuf.h"
 #include "trace2.h"
 #include "varint.h"
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 35acc13ccc..a792297d8f 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -25,7 +25,7 @@
 #include "refs/worktree.h"
 #include "../wrapper.h"
 #include "../write-or-die.h"
-#include "../revision.h"
+#include "revision/revision.h"
 #include <wildmatch.h>
 
 /* So that we can drop `USE_THE_REPOSITORY_VARIABLE`. */
diff --git a/refs/pack-refs.c b/refs/pack-refs.c
index c9f36872cc..d6c41d64f1 100644
--- a/refs/pack-refs.c
+++ b/refs/pack-refs.c
@@ -4,7 +4,7 @@
 #include "refs/pack-refs.h"
 #include "parse-options.h"
 #include "refs/refs.h"
-#include "revision.h"
+#include "revision/revision.h"
 
 int pack_refs_core(int argc,
 		   const char **argv,
diff --git a/refs/ref-filter.c b/refs/ref-filter.c
index e3de16b7a7..7635e13f88 100644
--- a/refs/ref-filter.c
+++ b/refs/ref-filter.c
@@ -24,13 +24,13 @@
 #include "odb/tag.h"
 #include "quote.h"
 #include "refs/ref-filter.h"
-#include "revision.h"
+#include "revision/revision.h"
 #include "utf8.h"
 #include "versioncmp.h"
 #include "trailer.h"
 #include "wt-status.h"
 #include "odb/commit-slab.h"
-#include "commit-reach.h"
+#include "revision/commit-reach.h"
 #include "refs/worktree.h"
 #include "hashmap.h"
 
diff --git a/refs/ref-filter.h b/refs/ref-filter.h
index 11180f9570..0f4f80ec20 100644
--- a/refs/ref-filter.h
+++ b/refs/ref-filter.h
@@ -6,7 +6,7 @@
 #include "odb/commit.h"
 #include "string-list.h"
 #include "strvec.h"
-#include "commit-reach.h"
+#include "revision/commit-reach.h"
 
 /* Quoting styles */
 #define QUOTE_NONE 0
diff --git a/refs/reflog-walk.c b/refs/reflog-walk.c
index f9eee9a76f..4c321fb3a8 100644
--- a/refs/reflog-walk.c
+++ b/refs/reflog-walk.c
@@ -5,7 +5,7 @@
 #include "refs/refs.h"
 #include "diff/diff.h"
 #include "repository.h"
-#include "revision.h"
+#include "revision/revision.h"
 #include "string-list.h"
 #include "refs/reflog-walk.h"
 
diff --git a/refs/reflog.c b/refs/reflog.c
index 751485f885..1050ae6301 100644
--- a/refs/reflog.c
+++ b/refs/reflog.c
@@ -9,7 +9,7 @@
 #include "odb/odb.h"
 #include "refs/reflog.h"
 #include "refs/refs.h"
-#include "revision.h"
+#include "revision/revision.h"
 #include "odb/tree.h"
 #include "odb/tree-walk.h"
 #include "wildmatch.h"
diff --git a/remote.c b/remote.c
index c619009d30..8a65967fb0 100644
--- a/remote.c
+++ b/remote.c
@@ -17,12 +17,12 @@
 #include "path.h"
 #include "odb/commit.h"
 #include "diff/diff.h"
-#include "revision.h"
+#include "revision/revision.h"
 #include "dir.h"
 #include "setup.h"
 #include "string-list.h"
 #include "strvec.h"
-#include "commit-reach.h"
+#include "revision/commit-reach.h"
 #include "advice.h"
 #include "connect.h"
 #include "parse-options.h"
diff --git a/replay.c b/replay.c
index 8dd7b99502..6922a1f137 100644
--- a/replay.c
+++ b/replay.c
@@ -7,7 +7,7 @@
 #include "odb/object-name.h"
 #include "refs/refs.h"
 #include "replay.h"
-#include "revision.h"
+#include "revision/revision.h"
 #include "sequencer.h"
 #include "strmap.h"
 #include "odb/tree.h"
diff --git a/bisect.c b/revision/bisect.c
similarity index 99%
rename from bisect.c
rename to revision/bisect.c
index 1f8d81b894..696e365310 100644
--- a/bisect.c
+++ b/revision/bisect.c
@@ -8,17 +8,17 @@
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
-#include "revision.h"
+#include "revision/revision.h"
 #include "refs/refs.h"
-#include "list-objects.h"
+#include "revision/list-objects.h"
 #include "quote.h"
 #include "run-command.h"
-#include "log-tree.h"
-#include "bisect.h"
+#include "revision/log-tree.h"
+#include "revision/bisect.h"
 #include "odb/oid-array.h"
 #include "strvec.h"
 #include "odb/commit-slab.h"
-#include "commit-reach.h"
+#include "revision/commit-reach.h"
 #include "odb/object-name.h"
 #include "odb/odb.h"
 #include "path.h"
diff --git a/bisect.h b/revision/bisect.h
similarity index 100%
rename from bisect.h
rename to revision/bisect.h
diff --git a/blame.c b/revision/blame.c
similarity index 99%
rename from blame.c
rename to revision/blame.c
index c736441f18..54284ed8da 100644
--- a/blame.c
+++ b/revision/blame.c
@@ -14,11 +14,11 @@
 #include "hex.h"
 #include "path.h"
 #include "read-cache.h"
-#include "revision.h"
+#include "revision/revision.h"
 #include "setup.h"
 #include "odb/tag.h"
 #include "trace2.h"
-#include "blame.h"
+#include "revision/blame.h"
 #include "odb/alloc.h"
 #include "odb/commit-slab.h"
 #include "pack/bloom.h"
diff --git a/blame.h b/revision/blame.h
similarity index 100%
rename from blame.h
rename to revision/blame.h
diff --git a/commit-reach.c b/revision/commit-reach.c
similarity index 99%
rename from commit-reach.c
rename to revision/commit-reach.c
index 0b59c9ba29..e1e1b71819 100644
--- a/commit-reach.c
+++ b/revision/commit-reach.c
@@ -3,13 +3,13 @@
 #include "git-compat-util.h"
 #include "odb/commit.h"
 #include "pack/commit-graph.h"
-#include "decorate.h"
+#include "revision/decorate.h"
 #include "hex.h"
 #include "prio-queue.h"
 #include "refs/ref-filter.h"
-#include "revision.h"
+#include "revision/revision.h"
 #include "odb/tag.h"
-#include "commit-reach.h"
+#include "revision/commit-reach.h"
 #include "ewah/ewok.h"
 
 /* Remember to update object flag allocation in object.h */
diff --git a/commit-reach.h b/revision/commit-reach.h
similarity index 100%
rename from commit-reach.h
rename to revision/commit-reach.h
diff --git a/decorate.c b/revision/decorate.c
similarity index 98%
rename from decorate.c
rename to revision/decorate.c
index 262c9198eb..eeba03ec83 100644
--- a/decorate.c
+++ b/revision/decorate.c
@@ -5,7 +5,7 @@
 
 #include "git-compat-util.h"
 #include "odb/object.h"
-#include "decorate.h"
+#include "revision/decorate.h"
 
 static unsigned int hash_obj(const struct object *obj, unsigned int n)
 {
diff --git a/decorate.h b/revision/decorate.h
similarity index 100%
rename from decorate.h
rename to revision/decorate.h
diff --git a/graph.c b/revision/graph.c
similarity index 99%
rename from graph.c
rename to revision/graph.c
index 66c2be423e..c6f10398a2 100644
--- a/graph.c
+++ b/revision/graph.c
@@ -5,8 +5,8 @@
 #include "config.h"
 #include "odb/commit.h"
 #include "color.h"
-#include "graph.h"
-#include "revision.h"
+#include "revision/graph.h"
+#include "revision/revision.h"
 #include "strvec.h"
 
 /* Internal API */
diff --git a/graph.h b/revision/graph.h
similarity index 100%
rename from graph.h
rename to revision/graph.h
diff --git a/line-log.c b/revision/line-log.c
similarity index 99%
rename from line-log.c
rename to revision/line-log.c
index 78697cb377..3da7af2340 100644
--- a/line-log.c
+++ b/revision/line-log.c
@@ -2,18 +2,18 @@
 
 #include "git-compat-util.h"
 #include "diff/diffcore.h"
-#include "line-range.h"
+#include "revision/line-range.h"
 #include "hex.h"
 #include "odb/tag.h"
 #include "odb/tree.h"
 #include "diff/diff.h"
 #include "odb/commit.h"
-#include "decorate.h"
+#include "revision/decorate.h"
 #include "repository.h"
-#include "revision.h"
+#include "revision/revision.h"
 #include "diff/xdiff-interface.h"
 #include "strbuf.h"
-#include "line-log.h"
+#include "revision/line-log.h"
 #include "setup.h"
 #include "strvec.h"
 #include "pack/bloom.h"
diff --git a/line-log.h b/revision/line-log.h
similarity index 100%
rename from line-log.h
rename to revision/line-log.h
diff --git a/line-range.c b/revision/line-range.c
similarity index 99%
rename from line-range.c
rename to revision/line-range.c
index 1dbf761ecc..419d90d863 100644
--- a/line-range.c
+++ b/revision/line-range.c
@@ -1,5 +1,5 @@
 #include "git-compat-util.h"
-#include "line-range.h"
+#include "revision/line-range.h"
 #include "diff/xdiff-interface.h"
 #include "diff/userdiff.h"
 
diff --git a/line-range.h b/revision/line-range.h
similarity index 100%
rename from line-range.h
rename to revision/line-range.h
diff --git a/list-objects-filter-options.c b/revision/list-objects-filter-options.c
similarity index 99%
rename from list-objects-filter-options.c
rename to revision/list-objects-filter-options.c
index bc5d98f9e6..6730808896 100644
--- a/list-objects-filter-options.c
+++ b/revision/list-objects-filter-options.c
@@ -3,7 +3,7 @@
 #include "git-compat-util.h"
 #include "config.h"
 #include "gettext.h"
-#include "list-objects-filter-options.h"
+#include "revision/list-objects-filter-options.h"
 #include "promisor-remote.h"
 #include "trace.h"
 #include "url.h"
diff --git a/list-objects-filter-options.h b/revision/list-objects-filter-options.h
similarity index 100%
rename from list-objects-filter-options.h
rename to revision/list-objects-filter-options.h
diff --git a/list-objects-filter.c b/revision/list-objects-filter.c
similarity index 99%
rename from list-objects-filter.c
rename to revision/list-objects-filter.c
index a011cef0b5..0ea4cb826e 100644
--- a/list-objects-filter.c
+++ b/revision/list-objects-filter.c
@@ -6,9 +6,9 @@
 #include "hex.h"
 #include "odb/commit.h"
 #include "diff/diff.h"
-#include "revision.h"
-#include "list-objects-filter.h"
-#include "list-objects-filter-options.h"
+#include "revision/revision.h"
+#include "revision/list-objects-filter.h"
+#include "revision/list-objects-filter-options.h"
 #include "odb/oidmap.h"
 #include "odb/oidset.h"
 #include "odb/object-name.h"
diff --git a/list-objects-filter.h b/revision/list-objects-filter.h
similarity index 100%
rename from list-objects-filter.h
rename to revision/list-objects-filter.h
diff --git a/list-objects.c b/revision/list-objects.c
similarity index 98%
rename from list-objects.c
rename to revision/list-objects.c
index 6b67f0f927..fdf98b629f 100644
--- a/list-objects.c
+++ b/revision/list-objects.c
@@ -9,10 +9,10 @@
 #include "odb/blob.h"
 #include "diff/diff.h"
 #include "odb/tree-walk.h"
-#include "revision.h"
-#include "list-objects.h"
-#include "list-objects-filter.h"
-#include "list-objects-filter-options.h"
+#include "revision/revision.h"
+#include "revision/list-objects.h"
+#include "revision/list-objects-filter.h"
+#include "revision/list-objects-filter-options.h"
 #include "pack/packfile.h"
 #include "odb/odb.h"
 #include "trace.h"
diff --git a/list-objects.h b/revision/list-objects.h
similarity index 100%
rename from list-objects.h
rename to revision/list-objects.h
diff --git a/list.h b/revision/list.h
similarity index 100%
rename from list.h
rename to revision/list.h
diff --git a/log-tree.c b/revision/log-tree.c
similarity index 99%
rename from log-tree.c
rename to revision/log-tree.c
index ddeafedb45..e555d07072 100644
--- a/log-tree.c
+++ b/revision/log-tree.c
@@ -2,7 +2,7 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
-#include "commit-reach.h"
+#include "revision/commit-reach.h"
 #include "odb/commit-slab.h"
 #include "config.h"
 #include "diff/diff.h"
@@ -15,18 +15,18 @@
 #include "odb/tmp-objdir.h"
 #include "odb/commit.h"
 #include "odb/tag.h"
-#include "graph.h"
-#include "log-tree.h"
+#include "revision/graph.h"
+#include "revision/log-tree.h"
 #include "merge-ort.h"
 #include "refs/reflog-walk.h"
 #include "refs/refs.h"
 #include "odb/replace-object.h"
-#include "revision.h"
+#include "revision/revision.h"
 #include "string-list.h"
 #include "color.h"
 #include "gpg-interface.h"
 #include "sequencer.h"
-#include "line-log.h"
+#include "revision/line-log.h"
 #include "help.h"
 #include "diff/range-diff.h"
 #include "strmap.h"
diff --git a/log-tree.h b/revision/log-tree.h
similarity index 100%
rename from log-tree.h
rename to revision/log-tree.h
diff --git a/pretty.c b/revision/pretty.c
similarity index 99%
rename from pretty.c
rename to revision/pretty.c
index 3444617506..cdf63ded49 100644
--- a/pretty.c
+++ b/revision/pretty.c
@@ -11,10 +11,10 @@
 #include "utf8.h"
 #include "diff/diff.h"
 #include "pager.h"
-#include "revision.h"
+#include "revision/revision.h"
 #include "string-list.h"
 #include "mailmap.h"
-#include "log-tree.h"
+#include "revision/log-tree.h"
 #include "notes.h"
 #include "color.h"
 #include "refs/reflog-walk.h"
diff --git a/pretty.h b/revision/pretty.h
similarity index 100%
rename from pretty.h
rename to revision/pretty.h
diff --git a/revision.c b/revision/revision.c
similarity index 99%
rename from revision.c
rename to revision/revision.c
index 249a1736fd..9a19a5654a 100644
--- a/revision.c
+++ b/revision/revision.c
@@ -17,20 +17,20 @@
 #include "diff/diff.h"
 #include "diff/diff-merges.h"
 #include "refs/refs.h"
-#include "revision.h"
+#include "revision/revision.h"
 #include "repository.h"
-#include "graph.h"
+#include "revision/graph.h"
 #include "grep.h"
 #include "refs/reflog-walk.h"
 #include "diff/patch-ids.h"
-#include "decorate.h"
+#include "revision/decorate.h"
 #include "string-list.h"
-#include "line-log.h"
-#include "log-tree.h"
+#include "revision/line-log.h"
+#include "revision/log-tree.h"
 #include "mailmap.h"
 #include "odb/commit-slab.h"
 #include "cache-tree.h"
-#include "bisect.h"
+#include "revision/bisect.h"
 #include "pack/packfile.h"
 #include "refs/worktree.h"
 #include "path.h"
@@ -39,14 +39,14 @@
 #include "sparse-index.h"
 #include "strvec.h"
 #include "trace2.h"
-#include "commit-reach.h"
+#include "revision/commit-reach.h"
 #include "pack/commit-graph.h"
 #include "prio-queue.h"
 #include "hashmap.h"
 #include "utf8.h"
 #include "pack/bloom.h"
 #include "json-writer.h"
-#include "list-objects-filter-options.h"
+#include "revision/list-objects-filter-options.h"
 #include "resolve-undo.h"
 #include "parse-options.h"
 #include "wildmatch.h"
diff --git a/revision.h b/revision/revision.h
similarity index 99%
rename from revision.h
rename to revision/revision.h
index 64d9a47091..9cb9419b22 100644
--- a/revision.h
+++ b/revision/revision.h
@@ -6,12 +6,12 @@
 #include "notes.h"
 #include "odb/object-name.h"
 #include "odb/oidset.h"
-#include "pretty.h"
+#include "revision/pretty.h"
 #include "diff/diff.h"
 #include "odb/commit-slab-decl.h"
-#include "decorate.h"
+#include "revision/decorate.h"
 #include "ident.h"
-#include "list-objects-filter-options.h"
+#include "revision/list-objects-filter-options.h"
 #include "prio-queue.h"
 #include "strvec.h"
 
diff --git a/shallow.c b/revision/shallow.c
similarity index 99%
rename from shallow.c
rename to revision/shallow.c
index fa16834aff..51ba602971 100644
--- a/shallow.c
+++ b/revision/shallow.c
@@ -13,11 +13,11 @@
 #include "odb/oid-array.h"
 #include "path.h"
 #include "diff/diff.h"
-#include "revision.h"
+#include "revision/revision.h"
 #include "odb/commit-slab.h"
-#include "list-objects.h"
-#include "commit-reach.h"
-#include "shallow.h"
+#include "revision/list-objects.h"
+#include "revision/commit-reach.h"
+#include "revision/shallow.h"
 #include "statinfo.h"
 #include "trace.h"
 
diff --git a/shallow.h b/revision/shallow.h
similarity index 100%
rename from shallow.h
rename to revision/shallow.h
diff --git a/send-pack.c b/send-pack.c
index 97dcfac586..f59686f971 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -15,7 +15,7 @@
 #include "version.h"
 #include "odb/oid-array.h"
 #include "gpg-interface.h"
-#include "shallow.h"
+#include "revision/shallow.h"
 #include "parse-options.h"
 #include "trace2.h"
 #include "write-or-die.h"
diff --git a/sequencer.c b/sequencer.c
index 551e4529c4..d5b1eb9719 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -24,7 +24,7 @@
 #include "cache-tree.h"
 #include "diff/diff.h"
 #include "path.h"
-#include "revision.h"
+#include "revision/revision.h"
 #include "rerere.h"
 #include "merge.h"
 #include "merge-ort.h"
@@ -34,7 +34,7 @@
 #include "strvec.h"
 #include "quote.h"
 #include "trailer.h"
-#include "log-tree.h"
+#include "revision/log-tree.h"
 #include "wt-status.h"
 #include "hashmap.h"
 #include "notes-utils.h"
@@ -44,7 +44,7 @@
 #include "odb/oidset.h"
 #include "odb/commit-slab.h"
 #include "alias.h"
-#include "commit-reach.h"
+#include "revision/commit-reach.h"
 #include "rebase-interactive.h"
 #include "reset.h"
 #include "branch.h"
diff --git a/setup.c b/setup.c
index 925a600dba..62fbda948d 100644
--- a/setup.c
+++ b/setup.c
@@ -14,7 +14,7 @@
 #include "config.h"
 #include "dir.h"
 #include "setup.h"
-#include "shallow.h"
+#include "revision/shallow.h"
 #include "string-list.h"
 #include "strvec.h"
 #include "chdir-notify.h"
diff --git a/submodule.c b/submodule.c
index a9137aa180..16f4d30b82 100644
--- a/submodule.c
+++ b/submodule.c
@@ -13,7 +13,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
-#include "revision.h"
+#include "revision/revision.h"
 #include "run-command.h"
 #include "diff/diffcore.h"
 #include "refs/refs.h"
@@ -28,7 +28,7 @@
 #include "odb/object-file.h"
 #include "odb/object-name.h"
 #include "odb/odb.h"
-#include "commit-reach.h"
+#include "revision/commit-reach.h"
 #include "read-cache-ll.h"
 #include "setup.h"
 #include "advice.h"
diff --git a/t/helper/test-path-walk.c b/t/helper/test-path-walk.c
index f41c6be2c6..71d052d504 100644
--- a/t/helper/test-path-walk.c
+++ b/t/helper/test-path-walk.c
@@ -4,11 +4,11 @@
 #include "dir.h"
 #include "environment.h"
 #include "hex.h"
-#include "list-objects-filter-options.h"
+#include "revision/list-objects-filter-options.h"
 #include "odb/object-name.h"
 #include "odb/object.h"
-#include "pretty.h"
-#include "revision.h"
+#include "revision/pretty.h"
+#include "revision/revision.h"
 #include "setup.h"
 #include "parse-options.h"
 #include "strbuf.h"
diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
index df1c677b9f..7f00cc7d9c 100644
--- a/t/helper/test-reach.c
+++ b/t/helper/test-reach.c
@@ -2,7 +2,7 @@
 
 #include "test-tool.h"
 #include "odb/commit.h"
-#include "commit-reach.h"
+#include "revision/commit-reach.h"
 #include "gettext.h"
 #include "hex.h"
 #include "odb/object-name.h"
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 8c2fb0aad7..582e8b4d97 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -9,7 +9,7 @@
 #include "path.h"
 #include "repository.h"
 #include "strbuf.h"
-#include "revision.h"
+#include "revision/revision.h"
 
 struct flag_definition {
 	const char *name;
diff --git a/t/helper/test-revision-walking.c b/t/helper/test-revision-walking.c
index 7c66b8566f..57e0bcea63 100644
--- a/t/helper/test-revision-walking.c
+++ b/t/helper/test-revision-walking.c
@@ -13,10 +13,10 @@
 #include "test-tool.h"
 #include "odb/commit.h"
 #include "diff/diff.h"
-#include "line-log.h"
+#include "revision/line-log.h"
 #include "odb/object-name.h"
 #include "repository.h"
-#include "revision.h"
+#include "revision/revision.h"
 #include "setup.h"
 #include "string-list.h"
 
diff --git a/t/unit-tests/u-example-decorate.c b/t/unit-tests/u-example-decorate.c
index 2f01340c21..85d0277ee2 100644
--- a/t/unit-tests/u-example-decorate.c
+++ b/t/unit-tests/u-example-decorate.c
@@ -2,7 +2,7 @@
 
 #include "unit-test.h"
 #include "odb/object.h"
-#include "decorate.h"
+#include "revision/decorate.h"
 #include "repository.h"
 
 struct test_vars {
diff --git a/t/unit-tests/u-list-objects-filter-options.c b/t/unit-tests/u-list-objects-filter-options.c
index f7d73701b5..cbcae66fa5 100644
--- a/t/unit-tests/u-list-objects-filter-options.c
+++ b/t/unit-tests/u-list-objects-filter-options.c
@@ -1,5 +1,5 @@
 #include "unit-test.h"
-#include "list-objects-filter-options.h"
+#include "revision/list-objects-filter-options.h"
 #include "strbuf.h"
 
 /* Helper to test gently_parse_list_objects_filter() */
diff --git a/tempfile.h b/tempfile.h
index f571f3c609..40d8d230de 100644
--- a/tempfile.h
+++ b/tempfile.h
@@ -1,7 +1,7 @@
 #ifndef TEMPFILE_H
 #define TEMPFILE_H
 
-#include "list.h"
+#include "revision/list.h"
 #include "strbuf.h"
 
 struct repository;
diff --git a/trailer.c b/trailer.c
index 33fd1df188..7723c5cf52 100644
--- a/trailer.c
+++ b/trailer.c
@@ -9,7 +9,7 @@
 #include "odb/commit.h"
 #include "strvec.h"
 #include "trailer.h"
-#include "list.h"
+#include "revision/list.h"
 #include "tempfile.h"
 
 /*
diff --git a/trailer.h b/trailer.h
index b49338858c..5afc1775f2 100644
--- a/trailer.h
+++ b/trailer.h
@@ -1,7 +1,7 @@
 #ifndef TRAILER_H
 #define TRAILER_H
 
-#include "list.h"
+#include "revision/list.h"
 #include "strbuf.h"
 
 struct trailer_block;
diff --git a/transport.h b/transport.h
index a7869d18e0..064f4192cf 100644
--- a/transport.h
+++ b/transport.h
@@ -3,7 +3,7 @@
 
 #include "run-command.h"
 #include "remote.h"
-#include "list-objects-filter-options.h"
+#include "revision/list-objects-filter-options.h"
 #include "string-list.h"
 #include "connect.h"
 
diff --git a/upload-pack.c b/upload-pack.c
index acd381ebf1..09a986e486 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -15,8 +15,8 @@
 #include "odb/object.h"
 #include "odb/commit.h"
 #include "diff/diff.h"
-#include "revision.h"
-#include "list-objects-filter-options.h"
+#include "revision/revision.h"
+#include "revision/list-objects-filter-options.h"
 #include "run-command.h"
 #include "connect.h"
 #include "sigchain.h"
@@ -27,8 +27,8 @@
 #include "protocol.h"
 #include "upload-pack.h"
 #include "pack/commit-graph.h"
-#include "commit-reach.h"
-#include "shallow.h"
+#include "revision/commit-reach.h"
+#include "revision/shallow.h"
 #include "trace.h"
 #include "write-or-die.h"
 #include "json-writer.h"
diff --git a/wt-status.c b/wt-status.c
index 28a0c72a51..83fdf5334f 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -14,7 +14,7 @@
 #include "hex.h"
 #include "odb/object-name.h"
 #include "path.h"
-#include "revision.h"
+#include "revision/revision.h"
 #include "diff/diffcore.h"
 #include "quote.h"
 #include "repository.h"
-- 
2.54.0

