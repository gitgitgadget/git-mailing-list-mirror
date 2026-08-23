Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085A030E0D5
	for <git@vger.kernel.org>; Sun, 23 Aug 2026 17:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787505595; cv=none; b=CCc8hkchs6H9cD34Vqpgq//AYTcmzRFJ3AQ0JBcuFLvWxFU9zQSt6mYrWO2ZxE2qOT6blHie1F4FBhEwwAXWP0WNy5B80oA9dGELz+fXfC/l6+5xSfXVjokz8+H+2TFr7vsrSo4eX+E0p6Xjz6GZbKwjVNueWCUhOY13t2T4ziU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787505595; c=relaxed/simple;
	bh=/w9zwP2ouWzwz061S/CiesHGqGOGMVaSO3o6XBwRVFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nA2QwvNeGWOjAk89EttwqP8BS3hO57XdUJf10dsfbOjOxiNnaSM7rzpdX3PJxI8RqBeUp2U5bDaa8PktxIF91Odr5TaskqarxNZveGiNmlfdtuR0lka7OX3YTEtWQ9VPySY2NO3gEKbtxb8PJ1D8gb3gOhXpdcJsTFKQkSF8qUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uuklv3Je; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uuklv3Je"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so2175340a91.0
        for <git@vger.kernel.org>; Sun, 23 Aug 2026 10:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787505582; x=1788110382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EUH81CfSfuZXFPloY8ncMeT5QvtvDQfXDTh6uItXyZ8=;
        b=Uuklv3JeZWdVrCGMZRE7IV+rJGSv+ydO6ju2lXQ0nDRafCQiZWOx3G025pvMt9Xl+L
         E+BBlWtgaL1M9/Z6UR/KdyewNVqA170p7RTjDdyabSoA/XBPLY8Qgk7lX2NBET7xkUdH
         4k0/C5AnJ/Pnc3rkNDuXLFwyDg2qZATtuPo9/4SGD+LKL7+Gx1RPzQVN0VBwEacRpfwG
         c0iKX87a2QuVFN5tQA0WpTv/dczqbdxvEjo4T8NQiS2Du0jdhwSGv7JZnnC4K1Yr1QIN
         TnkqrPUEqdakfol40af6uOJpMrU0h/RrtIJ8kQYqA8ZvCtCgaYC8Evgc6q0q1BU71Jbr
         NKMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787505582; x=1788110382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EUH81CfSfuZXFPloY8ncMeT5QvtvDQfXDTh6uItXyZ8=;
        b=qNvjCcTUNymUv/pVTCJOkWATxi39klgrJIQ842xVbqIRTtRUeyr3mQ18G2RypJlmnN
         HvfQTkBSJJbhA5loAm4JwEWL5mbIwEiGc8+WCNe7Ihks1Cl0w6PuyeSLwSK208NvNd35
         +lXwXtnaF+ndBwLjO+kmhE3d0Podpzi6f2znArD51B4xvUi9L9NZHMUHyYDoDKvjUEQi
         gqk8Owwh2bk2wbMqTOOc8Mj4D9RH7P6JKAxthE0VnRwDfELztyBn54dido6yuDaHYnSq
         jrPrk9Dkjjj5U+8f5TZZXX8nr6OnbSxDyJmDhV+vfPxPVSt/T9ipv5X70N8lYEACdEbG
         G0qw==
X-Gm-Message-State: AFuF++mXwtKtnc29SUX0iy3QrhhstWiBI8juyKhGnSj5gVSu8z5f56Cn
	Y5mpnnJa98OoBrSp/+hRQlLbDzQJ07FexWTYIUrP0LkYDk67wZbr/ltef+iT5w==
X-Gm-Gg: AR+sD11ktljkjo8yTEAhmcAju3C9B1+1ZloEh+C+m3u6UiBtOVPnnJjN/UDRBHU6dpG
	28+MLTmUdYLVNj2Nuxy9YAF7St4dfGHpFywSTnnGVsMc4I3svj2fTSe6hxzenLk6n/O/rvzt2p8
	y0it5968NTSiFRVkC/dpFpDIKcVqA45vcZp0zEUyMq/8aO8NzCL9QObAf5d6wB9mWSTkNnan9Mx
	lP8wBtrjUriO5xuAlbRKa3pIUasn4Gpd1wRmQO3uw3wjzwa0JC6PccG4rpY5VTjPQpxc2zU6kYL
	J+DCP/47/EqMtHJL4QehNSB2kDUSV7ZEYDleyIJJZgAWKGXk/eqi+WhNMwMdRG+TkmsDG48tZt4
	pBSVToIyvtyKIqOPPZdcrXYMJFWnT2LPzukvdCA4bjB9pWEwaFdXorGI/IbvZZeLajrfk6fsl42
	E8YFDt4QPVR4LI/dP/Hccpzxd36WVzlVAAiVdaPH2lZGuQY7sFIb9BhAiZeR35nFBN+KTma7Ryx
	jWwtSbi0PF47USBpxnPAIBgQNnEGVpHu5ND+vzeWINBH/XM+54z7P72LE7I70E7186OQlonOI1U
	g56kLDHG1I/Z5sNFtb3DeOHImEA9FVboCUcA+2PmAdRLug==
X-Received: by 2002:a17:90b:51c3:b0:383:f52b:d616 with SMTP id 98e67ed59e1d1-395c3707434mr39364832a91.10.1787505580597;
        Sun, 23 Aug 2026 10:19:40 -0700 (PDT)
Received: from localhost (192-184-169-91.fiber.dynamic.sonic.net. [192.184.169.91])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1418619d6e1sm20102671c88.15.2026.08.23.10.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 10:19:39 -0700 (PDT)
From: Michael Montalbo <mmontalbo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <pks@pks.im>
Subject: [RFC PATCH 14/14] transport: gather the transport sources under transport/
Date: Sun, 23 Aug 2026 10:18:58 -0700
Message-ID: <20260823171915.2662373-15-mmontalbo@gmail.com>
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

Move the 22 transport C sources and 21 headers into transport/ as
renames. Repoint every reference to their old paths to the new ones: the
#include lines across the tree, the Makefile and meson.build build
entries, the contrib CMake sources.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 .gitorganize                                  | 86 +++++++++----------
 Makefile                                      | 54 ++++++------
 branch.c                                      |  2 +-
 builtin/archive.c                             |  4 +-
 builtin/backfill.c                            |  2 +-
 builtin/branch.c                              |  2 +-
 builtin/bundle.c                              |  4 +-
 builtin/cat-file.c                            |  6 +-
 builtin/checkout--worker.c                    |  2 +-
 builtin/checkout.c                            |  2 +-
 builtin/clone.c                               | 12 +--
 builtin/fast-export.c                         |  2 +-
 builtin/fetch-pack.c                          | 10 +--
 builtin/fetch.c                               | 12 +--
 builtin/gc.c                                  |  2 +-
 builtin/grep.c                                |  2 +-
 builtin/index-pack.c                          |  2 +-
 builtin/log.c                                 |  4 +-
 builtin/ls-remote.c                           |  6 +-
 builtin/merge.c                               |  2 +-
 builtin/pack-objects.c                        |  4 +-
 builtin/pull.c                                |  2 +-
 builtin/push.c                                |  8 +-
 builtin/receive-pack.c                        | 12 +--
 builtin/remote-ext.c                          |  4 +-
 builtin/remote-fd.c                           |  2 +-
 builtin/remote.c                              |  4 +-
 builtin/repack.c                              |  2 +-
 builtin/send-pack.c                           | 12 +--
 builtin/submodule--helper.c                   |  2 +-
 builtin/upload-archive.c                      |  4 +-
 builtin/upload-pack.c                         |  8 +-
 builtin/worktree.c                            |  2 +-
 compat/simple-ipc/ipc-win32.c                 |  2 +-
 contrib/buildsystems/CMakeLists.txt           |  6 +-
 convert.c                                     |  2 +-
 daemon.c                                      |  4 +-
 diff/diff.c                                   |  2 +-
 diff/diffcore-break.c                         |  2 +-
 diff/diffcore-rename.c                        |  2 +-
 help.c                                        |  2 +-
 http-backend.c                                |  4 +-
 http-fetch.c                                  |  4 +-
 http-push.c                                   |  4 +-
 imap-send.c                                   |  2 +-
 index/cache-tree.c                            |  2 +-
 index/checkout.c                              |  2 +-
 index/parallel-checkout.c                     |  2 +-
 index/read-cache.c                            |  2 +-
 index/unpack-trees.c                          |  2 +-
 index/wt-status.c                             |  2 +-
 index/wt-status.h                             |  2 +-
 merge-ort.c                                   |  2 +-
 meson.build                                   | 46 +++++-----
 negotiator/default.c                          |  2 +-
 negotiator/noop.c                             |  2 +-
 negotiator/skipping.c                         |  2 +-
 odb/object-name.c                             |  2 +-
 odb/odb.c                                     |  2 +-
 odb/source-files.c                            |  2 +-
 pack/pack-write.c                             |  2 +-
 pack/packfile.c                               |  2 +-
 refs/ls-refs.c                                |  2 +-
 refs/ref-filter.c                             |  2 +-
 refs/refspec.c                                |  2 +-
 revision/list-objects-filter-options.c        |  2 +-
 revision/shallow.c                            |  2 +-
 setup/repository.c                            |  4 +-
 simple-ipc.h                                  |  2 +-
 sub-process.c                                 |  2 +-
 submodule.c                                   |  2 +-
 t/helper/test-bundle-uri.c                    |  6 +-
 t/helper/test-pkt-line.c                      |  4 +-
 t/helper/test-proc-receive.c                  |  4 +-
 t/helper/test-rot13-filter.c                  |  2 +-
 t/helper/test-serve-v2.c                      |  2 +-
 t/helper/test-submodule.c                     |  2 +-
 bundle-uri.c => transport/bundle-uri.c        | 10 +--
 bundle-uri.h => transport/bundle-uri.h        |  0
 bundle.c => transport/bundle.c                |  4 +-
 bundle.h => transport/bundle.h                |  0
 connect.c => transport/connect.c              | 14 +--
 connect.h => transport/connect.h              |  2 +-
 connected.c => transport/connected.c          |  6 +-
 connected.h => transport/connected.h          |  0
 .../fetch-negotiator.c                        |  2 +-
 .../fetch-negotiator.h                        |  0
 .../fetch-object-info.c                       |  6 +-
 .../fetch-object-info.h                       |  4 +-
 fetch-pack.c => transport/fetch-pack.c        | 16 ++--
 fetch-pack.h => transport/fetch-pack.h        |  2 +-
 .../git-curl-compat.h                         |  0
 http-walker.c => transport/http-walker.c      |  6 +-
 http.c => transport/http.c                    |  8 +-
 http.h => transport/http.h                    |  2 +-
 pkt-line.c => transport/pkt-line.c            |  4 +-
 pkt-line.h => transport/pkt-line.h            |  0
 .../promisor-remote.c                         |  4 +-
 .../promisor-remote.h                         |  0
 protocol-caps.c => transport/protocol-caps.c  |  4 +-
 protocol-caps.h => transport/protocol-caps.h  |  0
 protocol.c => transport/protocol.c            |  2 +-
 protocol.h => transport/protocol.h            |  0
 remote-curl.c => transport/remote-curl.c      | 18 ++--
 remote.c => transport/remote.c                |  6 +-
 remote.h => transport/remote.h                |  0
 send-pack.c => transport/send-pack.c          | 12 +--
 send-pack.h => transport/send-pack.h          |  0
 serve.c => transport/serve.c                  | 12 +--
 serve.h => transport/serve.h                  |  0
 sideband.c => transport/sideband.c            |  4 +-
 sideband.h => transport/sideband.h            |  0
 .../transport-helper.c                        |  8 +-
 .../transport-internal.h                      |  2 +-
 transport.c => transport/transport.c          | 24 +++---
 transport.h => transport/transport.h          |  4 +-
 upload-pack.c => transport/upload-pack.c      | 12 +--
 upload-pack.h => transport/upload-pack.h      |  0
 walker.c => transport/walker.c                |  2 +-
 walker.h => transport/walker.h                |  2 +-
 120 files changed, 320 insertions(+), 320 deletions(-)
 rename bundle-uri.c => transport/bundle-uri.c (99%)
 rename bundle-uri.h => transport/bundle-uri.h (100%)
 rename bundle.c => transport/bundle.c (99%)
 rename bundle.h => transport/bundle.h (100%)
 rename connect.c => transport/connect.c (99%)
 rename connect.h => transport/connect.h (98%)
 rename connected.c => transport/connected.c (98%)
 rename connected.h => transport/connected.h (100%)
 rename fetch-negotiator.c => transport/fetch-negotiator.c (94%)
 rename fetch-negotiator.h => transport/fetch-negotiator.h (100%)
 rename fetch-object-info.c => transport/fetch-object-info.c (97%)
 rename fetch-object-info.h => transport/fetch-object-info.h (91%)
 rename fetch-pack.c => transport/fetch-pack.c (99%)
 rename fetch-pack.h => transport/fetch-pack.h (99%)
 rename git-curl-compat.h => transport/git-curl-compat.h (100%)
 rename http-walker.c => transport/http-walker.c (99%)
 rename http.c => transport/http.c (99%)
 rename http.h => transport/http.h (99%)
 rename pkt-line.c => transport/pkt-line.c (99%)
 rename pkt-line.h => transport/pkt-line.h (100%)
 rename promisor-remote.c => transport/promisor-remote.c (99%)
 rename promisor-remote.h => transport/promisor-remote.h (100%)
 rename protocol-caps.c => transport/protocol-caps.c (98%)
 rename protocol-caps.h => transport/protocol-caps.h (100%)
 rename protocol.c => transport/protocol.c (98%)
 rename protocol.h => transport/protocol.h (100%)
 rename remote-curl.c => transport/remote-curl.c (99%)
 rename remote.c => transport/remote.c (99%)
 rename remote.h => transport/remote.h (100%)
 rename send-pack.c => transport/send-pack.c (99%)
 rename send-pack.h => transport/send-pack.h (100%)
 rename serve.c => transport/serve.c (97%)
 rename serve.h => transport/serve.h (100%)
 rename sideband.c => transport/sideband.c (99%)
 rename sideband.h => transport/sideband.h (100%)
 rename transport-helper.c => transport/transport-helper.c (99%)
 rename transport-internal.h => transport/transport-internal.h (98%)
 rename transport.c => transport/transport.c (99%)
 rename transport.h => transport/transport.h (99%)
 rename upload-pack.c => transport/upload-pack.c (99%)
 rename upload-pack.h => transport/upload-pack.h (100%)
 rename walker.c => transport/walker.c (99%)
 rename walker.h => transport/walker.h (97%)

diff --git a/.gitorganize b/.gitorganize
index cb6416bfc3..f2f686feac 100644
--- a/.gitorganize
+++ b/.gitorganize
@@ -42,10 +42,6 @@ base85.h component=? role=public prefix=base85 cochange=diff:1
 branch.c component=? role=lib prefix=branch includes=refs:3,setup:3,odb:2,submodule:1,transport:1 cochange=refs:62,transport:41,setup:28,index:19,revision:12
 branch.h component=? role=public prefix=branch cochange=setup:8,refs:4,submodule:4
 builtin.h component=? role=public prefix=builtin includes=setup:1 cochange=diff:15,index:15,transport:12,odb:6,notes:5
-bundle-uri.c component=transport role=lib prefix=bundle-uri includes=transport:5,odb:1,refs:1,setup:1 cochange=transport:28,setup:7,odb:4,merge:2,pack:2
-bundle-uri.h component=transport role=header prefix=bundle-uri cochange=transport:14
-bundle.c component=transport role=lib prefix=bundle includes=odb:3,revision:3,setup:2,transport:2,diff:1 cochange=transport:63,odb:24,revision:21,refs:17,pack:10
-bundle.h component=transport role=header prefix=bundle includes=revision:1 cochange=transport:37,revision:5
 chdir-notify.c component=? role=lib prefix=chdir-notify includes=revision:1 cochange=index:2,archive:1,merge:1,revision:1
 chdir-notify.h component=? role=public prefix=chdir-notify
 color.c component=? role=lib prefix=color includes=setup:1 cochange=diff:21,index:14,revision:13,setup:7,transport:7
@@ -56,10 +52,6 @@ common-exit.c component=? role=lib prefix=common-main
 common-init.c component=? role=lib prefix=common-main includes=odb:2,setup:2,convert:1 cochange=setup:1
 common-init.h component=? role=public prefix=common-main
 common-main.c component=? role=lib prefix=common-main cochange=setup:5,transport:4,convert:3,index:1
-connect.c component=transport role=lib prefix=connect includes=transport:7,setup:4,odb:1,refs:1 cochange=transport:238,setup:19,diff:13,index:10,refs:10
-connect.h component=transport role=header prefix=connect includes=transport:1 cochange=transport:58,refs:1
-connected.c component=transport role=lib prefix=connected includes=transport:3,odb:1,pack:1 cochange=transport:39,pack:31,odb:7,diff:6,index:5
-connected.h component=transport role=header prefix=connected cochange=transport:23
 convert.c component=convert role=lib prefix=convert includes=convert:2,index:1,merge:1,odb:1,setup:1 cochange=convert:59,diff:43,index:41,setup:30,transport:30
 convert.h component=convert role=header prefix=convert includes=odb:1 cochange=convert:29,index:18,diff:8,setup:8,archive:4
 copy.c component=? role=lib prefix=copy cochange=pack:6,transport:5,diff:3,odb:3,merge:2
@@ -101,19 +93,12 @@ editor.c component=? role=lib prefix=editor includes=setup:2 cochange=transport:
 editor.h component=? role=public prefix=editor cochange=transport:1
 exec-cmd.c component=? role=lib prefix=strvec includes=setup:1
 exec-cmd.h component=? role=public prefix=argv-array cochange=refs:4,transport:4,odb:1,setup:1,submodule:1
-fetch-negotiator.c component=transport role=lib prefix=repo-settings includes=setup:1,transport:1 cochange=setup:8,transport:7,index:2,odb:1
-fetch-negotiator.h component=transport role=header prefix=fetch-negotiator cochange=transport:7,setup:3,odb:1,pack:1,revision:1
-fetch-object-info.c component=transport role=lib prefix=cat-file includes=transport:3,odb:2 cochange=transport:7,odb:1
-fetch-object-info.h component=transport role=header prefix=cat-file includes=transport:2 cochange=transport:7,odb:1
-fetch-pack.c component=transport role=lib prefix=fetch-pack includes=transport:8,odb:7,setup:4,pack:3,revision:2 cochange=transport:303,odb:96,revision:46,pack:40,setup:25
-fetch-pack.h component=transport role=header prefix=fetch-pack includes=odb:1,revision:1,transport:1 cochange=transport:108,odb:2,pack:2,refs:2,diff:1
 fmt-merge-msg.c component=merge role=lib prefix=fmt-merge-msg includes=odb:3,diff:2,revision:2,setup:2,merge:1 cochange=revision:10,odb:7,index:6,diff:4,setup:4
 fmt-merge-msg.h component=merge role=header prefix=fmt-merge-msg cochange=merge:3,setup:2
 for-each-ref.h component=? role=public prefix=?
 gettext.c component=? role=lib prefix=gettext includes=setup:1 cochange=pack:5,refs:3,setup:2,transport:2,merge:1
 gettext.h component=? role=public prefix=i18n cochange=transport:2,setup:1
 git-compat-util.h component=? role=public prefix=git-compat-util cochange=setup:48,index:35,odb:22,pack:21,diff:17
-git-curl-compat.h component=transport role=header prefix=git-curl-compat cochange=transport:22
 git-zlib.c component=? role=lib prefix=git-zlib cochange=archive:2,odb:1,transport:1
 git-zlib.h component=? role=public prefix=git-zlib cochange=archive:3,setup:2,odb:1,transport:1
 git.c component=? role=lib prefix=git includes=setup:4,odb:2,convert:1,index:1,revision:1 cochange=setup:70,revision:54,transport:47,index:28,diff:25
@@ -132,9 +117,6 @@ hex.h component=? role=public prefix=hex includes=odb:1 cochange=revision:3,odb:
 http-backend.c component=? role=program prefix=http-backend includes=setup:4,odb:3,transport:2,pack:1,refs:1 cochange=transport:57,pack:41,setup:19,refs:14,revision:13
 http-fetch.c component=? role=program prefix=http-fetch includes=setup:3,transport:2 cochange=transport:46,setup:10,pack:9,index:7,refs:7
 http-push.c component=? role=program prefix=http-push includes=odb:7,revision:3,setup:3,transport:2,diff:1 cochange=transport:272,odb:134,revision:82,pack:60,diff:34
-http-walker.c component=transport role=lib prefix=http includes=transport:3,odb:2,pack:1,revision:1,setup:1 cochange=transport:73,pack:40,odb:17,index:11,refs:7
-http.c component=transport role=lib prefix=http includes=transport:4,setup:3,odb:2,pack:2 cochange=transport:195,pack:71,odb:27,diff:8,setup:8
-http.h component=transport role=header prefix=http includes=transport:1 cochange=transport:149,pack:15,diff:6,odb:4,archive:3
 imap-send.c component=? role=program prefix=imap-send includes=setup:3,transport:1 cochange=transport:47,diff:16,index:16,refs:9,odb:8
 index/cache-tree.c component=index role=lib prefix=cache-tree includes=odb:5,index:2,setup:1,transport:1 cochange=index:94,odb:69,revision:27,transport:21,diff:20
 index/cache-tree.h component=index role=header prefix=cache-tree includes=odb:2 cochange=index:42,diff:4,revision:4,odb:3,refs:1
@@ -322,20 +304,12 @@ path-walk.c component=? role=lib prefix=path-walk includes=odb:9,revision:3,inde
 path-walk.h component=? role=public prefix=path-walk includes=odb:1 cochange=index:2
 path.c component=? role=lib prefix=path includes=setup:2,index:1,odb:1,pack:1,refs:1 cochange=setup:78,refs:29,index:26,transport:15,odb:12
 path.h component=? role=public prefix=path includes=setup:1 cochange=setup:23,refs:13,odb:11,index:10,pack:8
-pkt-line.c component=transport role=lib prefix=pkt-line includes=transport:2 cochange=transport:102,pack:6,convert:5,diff:5,odb:3
-pkt-line.h component=transport role=header prefix=pkt-line cochange=transport:94,pack:5,convert:4,odb:2,diff:1
 prio-queue.c component=? role=lib prefix=prio-queue cochange=odb:5,revision:5,diff:2,pack:2,transport:2
 prio-queue.h component=? role=public prefix=prio-queue cochange=odb:3,revision:2,transport:2,pack:1
 progress.c component=? role=lib prefix=progress includes=setup:1 cochange=index:11,diff:6,setup:6,pack:4,revision:2
 progress.h component=? role=public prefix=progress cochange=index:5,diff:3
-promisor-remote.c component=transport role=lib prefix=promisor-remote includes=setup:3,transport:2,odb:1,pack:1 cochange=transport:32,setup:15,odb:6,pack:5,index:4
-promisor-remote.h component=transport role=header prefix=promisor-remote includes=setup:1 cochange=transport:18,setup:7,diff:4,index:3,revision:3
 prompt.c component=? role=lib prefix=prompt includes=setup:2 cochange=index:7,setup:6,pack:4,diff:3,transport:2
 prompt.h component=? role=public prefix=prompt cochange=transport:1
-protocol-caps.c component=transport role=lib prefix=protocol-caps includes=odb:3,transport:2,setup:1 cochange=transport:6,odb:3,refs:2,merge:1,setup:1
-protocol-caps.h component=transport role=header prefix=protocol-caps cochange=transport:6,refs:2
-protocol.c component=transport role=lib prefix=protocol includes=setup:2,transport:1 cochange=transport:21,index:4,setup:4,refs:2,diff:1
-protocol.h component=transport role=header prefix=protocol cochange=transport:5
 quote.c component=? role=lib prefix=quote cochange=index:15,diff:12,transport:7,odb:6,revision:6
 quote.h component=? role=public prefix=quote cochange=diff:8,transport:6,index:5,odb:5,refs:5
 rebase-interactive.c component=? role=lib prefix=rebase-interactive includes=odb:3,setup:3,index:1 cochange=revision:4,transport:4,index:3,odb:3,merge:2
@@ -358,9 +332,6 @@ refs/refspec.c component=refs role=lib prefix=refspec includes=refs:2,odb:1,tran
 refs/refspec.h component=refs role=header prefix=refspec cochange=transport:31,refs:29,submodule:3,index:2
 refs/worktree.c component=refs role=lib prefix=worktree includes=setup:4,index:2,refs:2 cochange=refs:73,setup:53,index:22,submodule:13,pack:11
 refs/worktree.h component=refs role=header prefix=worktree includes=refs:1 cochange=refs:61,revision:10,pack:5,setup:5,odb:4
-remote-curl.c component=transport role=lib prefix=remote-curl includes=transport:9,setup:3,odb:1 cochange=transport:226,diff:9,revision:6,setup:5,archive:4
-remote.c component=transport role=lib prefix=remote includes=odb:3,setup:3,transport:3,refs:2,revision:2 cochange=transport:272,refs:91,revision:56,index:51,odb:30
-remote.h component=transport role=header prefix=remote includes=odb:1,refs:1 cochange=transport:245,refs:24,index:12,revision:6,setup:2
 replay.c component=? role=lib prefix=replay includes=odb:2,merge:1,refs:1,revision:1,setup:1 cochange=transport:1
 replay.h component=? role=public prefix=replay includes=odb:1
 rerere.c component=merge role=lib prefix=rerere includes=index:4,merge:2,odb:2,setup:2,diff:1 cochange=index:54,merge:29,pack:26,odb:25,transport:25
@@ -400,12 +371,8 @@ run-command.c component=? role=lib prefix=run-command includes=setup:2,index:1,p
 run-command.h component=? role=public prefix=run-command cochange=transport:21,setup:8,odb:6,submodule:5,refs:4
 sane-ctype.h component=? role=public prefix=sane-ctype
 scalar.c component=? role=lib prefix=scalar includes=index:3,setup:2,pack:1,refs:1 cochange=setup:9,transport:7,pack:4,index:3,merge:3
-send-pack.c component=transport role=lib prefix=send-pack includes=transport:6,odb:3,setup:2,revision:1 cochange=transport:177,odb:29,revision:17,refs:15,pack:8
-send-pack.h component=transport role=header prefix=send-pack cochange=transport:39
 sequencer.c component=? role=lib prefix=sequencer includes=odb:8,index:5,merge:4,setup:4,revision:3 cochange=revision:84,odb:83,index:77,refs:60,transport:55
 sequencer.h component=? role=public prefix=sequencer includes=index:1 cochange=revision:5,index:4,notes:3,odb:3,transport:3
-serve.c component=transport role=lib prefix=serve includes=transport:6,setup:3,odb:1,refs:1 cochange=transport:53,refs:7,odb:4,setup:3,index:1
-serve.h component=transport role=header prefix=serve cochange=transport:9,refs:3,submodule:1
 setup/alias.c component=setup role=lib prefix=alias includes=setup:2 cochange=setup:8,diff:4,transport:3,convert:2,index:2
 setup/alias.h component=setup role=header prefix=completion cochange=setup:3,transport:2,pack:1,revision:1
 setup/config.c component=setup role=lib prefix=config includes=setup:4,odb:2,convert:1,index:1,refs:1 cochange=setup:274,index:93,diff:75,refs:48,revision:46
@@ -429,8 +396,6 @@ sha1dc_git.c component=? role=lib prefix=sha1dc cochange=diff:3,odb:2,revision:2
 sha1dc_git.h component=? role=public prefix=sha1dc cochange=odb:2
 shell.c component=? role=program prefix=shell includes=setup:1 cochange=transport:10,setup:4,revision:2
 shortlog.h component=? role=public prefix=shortlog cochange=revision:2
-sideband.c component=transport role=lib prefix=sideband includes=transport:2,setup:1 cochange=transport:51,revision:6,diff:5,index:5,refs:4
-sideband.h component=transport role=header prefix=sideband cochange=transport:23
 sigchain.c component=? role=lib prefix=sigchain cochange=diff:2,transport:1
 sigchain.h component=? role=public prefix=sigchain cochange=diff:2
 simple-ipc.h component=? role=public prefix=simple-ipc includes=transport:1 cochange=submodule:1
@@ -460,17 +425,54 @@ trace2.c component=? role=lib prefix=trace2 includes=setup:2 cochange=setup:2
 trace2.h component=? role=public prefix=trace2 cochange=setup:2
 trailer.c component=? role=lib prefix=trailer includes=setup:2,odb:1,revision:1 cochange=transport:13,revision:12,odb:8,index:7,refs:6
 trailer.h component=? role=public prefix=trailer includes=revision:1 cochange=revision:7,refs:1
-transport-helper.c component=transport role=lib prefix=transport-helper includes=transport:4,odb:2,refs:2,setup:2,pack:1 cochange=transport:210,refs:23,revision:16,odb:14,index:12
-transport-internal.h component=transport role=header prefix=transport includes=transport:1 cochange=transport:42,refs:3,odb:1,submodule:1
-transport.c component=transport role=lib prefix=transport includes=transport:12,setup:3,odb:2,refs:2,submodule:1 cochange=transport:482,refs:35,setup:31,submodule:29,revision:21
-transport.h component=transport role=header prefix=transport includes=transport:2,revision:1 cochange=transport:249,submodule:6,odb:4,revision:2,diff:1
+transport/bundle-uri.c component=transport role=lib prefix=bundle-uri includes=transport:5,odb:1,refs:1,setup:1 cochange=transport:28,setup:7,odb:4,merge:2,pack:2
+transport/bundle-uri.h component=transport role=header prefix=bundle-uri cochange=transport:14
+transport/bundle.c component=transport role=lib prefix=bundle includes=odb:3,revision:3,setup:2,transport:2,diff:1 cochange=transport:63,odb:24,revision:21,refs:17,pack:10
+transport/bundle.h component=transport role=header prefix=bundle includes=revision:1 cochange=transport:37,revision:5
+transport/connect.c component=transport role=lib prefix=connect includes=transport:7,setup:4,odb:1,refs:1 cochange=transport:238,setup:19,diff:13,index:10,refs:10
+transport/connect.h component=transport role=header prefix=connect includes=transport:1 cochange=transport:58,refs:1
+transport/connected.c component=transport role=lib prefix=connected includes=transport:3,odb:1,pack:1 cochange=transport:39,pack:31,odb:7,diff:6,index:5
+transport/connected.h component=transport role=header prefix=connected cochange=transport:23
+transport/fetch-negotiator.c component=transport role=lib prefix=repo-settings includes=setup:1,transport:1 cochange=setup:8,transport:7,index:2,odb:1
+transport/fetch-negotiator.h component=transport role=header prefix=fetch-negotiator cochange=transport:7,setup:3,odb:1,pack:1,revision:1
+transport/fetch-object-info.c component=transport role=lib prefix=cat-file includes=transport:3,odb:2 cochange=transport:7,odb:1
+transport/fetch-object-info.h component=transport role=header prefix=cat-file includes=transport:2 cochange=transport:7,odb:1
+transport/fetch-pack.c component=transport role=lib prefix=fetch-pack includes=transport:8,odb:7,setup:4,pack:3,revision:2 cochange=transport:303,odb:96,revision:46,pack:40,setup:25
+transport/fetch-pack.h component=transport role=header prefix=fetch-pack includes=odb:1,revision:1,transport:1 cochange=transport:108,odb:2,pack:2,refs:2,diff:1
+transport/git-curl-compat.h component=transport role=header prefix=git-curl-compat cochange=transport:22
+transport/http-walker.c component=transport role=lib prefix=http includes=transport:3,odb:2,pack:1,revision:1,setup:1 cochange=transport:73,pack:40,odb:17,index:11,refs:7
+transport/http.c component=transport role=lib prefix=http includes=transport:4,setup:3,odb:2,pack:2 cochange=transport:195,pack:71,odb:27,diff:8,setup:8
+transport/http.h component=transport role=header prefix=http includes=transport:1 cochange=transport:149,pack:15,diff:6,odb:4,archive:3
+transport/pkt-line.c component=transport role=lib prefix=pkt-line includes=transport:2 cochange=transport:102,pack:6,convert:5,diff:5,odb:3
+transport/pkt-line.h component=transport role=header prefix=pkt-line cochange=transport:94,pack:5,convert:4,odb:2,diff:1
+transport/promisor-remote.c component=transport role=lib prefix=promisor-remote includes=setup:3,transport:2,odb:1,pack:1 cochange=transport:32,setup:15,odb:6,pack:5,index:4
+transport/promisor-remote.h component=transport role=header prefix=promisor-remote includes=setup:1 cochange=transport:18,setup:7,diff:4,index:3,revision:3
+transport/protocol-caps.c component=transport role=lib prefix=protocol-caps includes=odb:3,transport:2,setup:1 cochange=transport:6,odb:3,refs:2,merge:1,setup:1
+transport/protocol-caps.h component=transport role=header prefix=protocol-caps cochange=transport:6,refs:2
+transport/protocol.c component=transport role=lib prefix=protocol includes=setup:2,transport:1 cochange=transport:21,index:4,setup:4,refs:2,diff:1
+transport/protocol.h component=transport role=header prefix=protocol cochange=transport:5
+transport/remote-curl.c component=transport role=lib prefix=remote-curl includes=transport:9,setup:3,odb:1 cochange=transport:226,diff:9,revision:6,setup:5,archive:4
+transport/remote.c component=transport role=lib prefix=remote includes=odb:3,setup:3,transport:3,refs:2,revision:2 cochange=transport:272,refs:91,revision:56,index:51,odb:30
+transport/remote.h component=transport role=header prefix=remote includes=odb:1,refs:1 cochange=transport:245,refs:24,index:12,revision:6,setup:2
+transport/send-pack.c component=transport role=lib prefix=send-pack includes=transport:6,odb:3,setup:2,revision:1 cochange=transport:177,odb:29,revision:17,refs:15,pack:8
+transport/send-pack.h component=transport role=header prefix=send-pack cochange=transport:39
+transport/serve.c component=transport role=lib prefix=serve includes=transport:6,setup:3,odb:1,refs:1 cochange=transport:53,refs:7,odb:4,setup:3,index:1
+transport/serve.h component=transport role=header prefix=serve cochange=transport:9,refs:3,submodule:1
+transport/sideband.c component=transport role=lib prefix=sideband includes=transport:2,setup:1 cochange=transport:51,revision:6,diff:5,index:5,refs:4
+transport/sideband.h component=transport role=header prefix=sideband cochange=transport:23
+transport/transport-helper.c component=transport role=lib prefix=transport-helper includes=transport:4,odb:2,refs:2,setup:2,pack:1 cochange=transport:210,refs:23,revision:16,odb:14,index:12
+transport/transport-internal.h component=transport role=header prefix=transport includes=transport:1 cochange=transport:42,refs:3,odb:1,submodule:1
+transport/transport.c component=transport role=lib prefix=transport includes=transport:12,setup:3,odb:2,refs:2,submodule:1 cochange=transport:482,refs:35,setup:31,submodule:29,revision:21
+transport/transport.h component=transport role=header prefix=transport includes=transport:2,revision:1 cochange=transport:249,submodule:6,odb:4,revision:2,diff:1
+transport/upload-pack.c component=transport role=lib prefix=upload-pack includes=transport:6,odb:4,revision:4,setup:4,diff:1 cochange=transport:198,odb:88,revision:80,refs:55,pack:34
+transport/upload-pack.h component=transport role=header prefix=upload-pack cochange=transport:18,refs:5,submodule:1
+transport/walker.c component=transport role=lib prefix=refs includes=odb:6,refs:1,setup:1,transport:1 cochange=odb:70,transport:55,revision:42,refs:24,pack:17
+transport/walker.h component=transport role=header prefix=walker includes=transport:1 cochange=transport:19
 unicode-width.h component=? role=public prefix=unicode
 unix-socket.c component=? role=lib prefix=unix-socket cochange=diff:3,revision:2,setup:1
 unix-socket.h component=? role=public prefix=unix-socket
 unix-stream-server.c component=? role=lib prefix=unix-stream-server
 unix-stream-server.h component=? role=public prefix=unix-stream-server
-upload-pack.c component=transport role=lib prefix=upload-pack includes=transport:6,odb:4,revision:4,setup:4,diff:1 cochange=transport:198,odb:88,revision:80,refs:55,pack:34
-upload-pack.h component=transport role=header prefix=upload-pack cochange=transport:18,refs:5,submodule:1
 url.c component=? role=lib prefix=url cochange=transport:12,revision:8,diff:6,index:2,refs:2
 url.h component=? role=public prefix=url cochange=transport:9,revision:4,submodule:1
 urlmatch.c component=? role=lib prefix=urlmatch cochange=diff:3,odb:2,revision:2,setup:2,transport:2
@@ -482,8 +484,6 @@ varint.c component=? role=lib prefix=varint cochange=index:2,transport:1
 varint.h component=? role=public prefix=varint cochange=index:2,transport:1
 versioncmp.c component=? role=lib prefix=versioncmp includes=setup:1 cochange=setup:5,pack:3,transport:3,index:2,refs:2
 versioncmp.h component=? role=public prefix=versioncmp cochange=refs:1
-walker.c component=transport role=lib prefix=refs includes=odb:6,refs:1,setup:1,transport:1 cochange=odb:70,transport:55,revision:42,refs:24,pack:17
-walker.h component=transport role=header prefix=walker includes=transport:1 cochange=transport:19
 wildmatch.c component=? role=lib prefix=hex cochange=index:4,refs:3,diff:1,odb:1,revision:1
 wildmatch.h component=? role=public prefix=? cochange=index:3,refs:2,diff:1,revision:1,setup:1
 wrapper.c component=? role=lib prefix=wrapper cochange=setup:21,index:16,pack:6,transport:5,convert:4
diff --git a/Makefile b/Makefile
index cec75e834a..396d9b09cf 100644
--- a/Makefile
+++ b/Makefile
@@ -1115,8 +1115,8 @@ LIB_OBJS += revision/blame.o
 LIB_OBJS += odb/blob.o
 LIB_OBJS += pack/bloom.o
 LIB_OBJS += branch.o
-LIB_OBJS += bundle-uri.o
-LIB_OBJS += bundle.o
+LIB_OBJS += transport/bundle-uri.o
+LIB_OBJS += transport/bundle.o
 LIB_OBJS += index/cache-tree.o
 LIB_OBJS += odb/cbtree.o
 LIB_OBJS += chdir-notify.o
@@ -1136,8 +1136,8 @@ LIB_OBJS += compat/open.o
 LIB_OBJS += compat/terminal.o
 LIB_OBJS += compiler-tricks/not-constant.o
 LIB_OBJS += setup/config.o
-LIB_OBJS += connect.o
-LIB_OBJS += connected.o
+LIB_OBJS += transport/connect.o
+LIB_OBJS += transport/connected.o
 LIB_OBJS += convert.o
 LIB_OBJS += copy.o
 LIB_OBJS += credential.o
@@ -1168,9 +1168,9 @@ LIB_OBJS += ewah/ewah_bitmap.o
 LIB_OBJS += ewah/ewah_io.o
 LIB_OBJS += ewah/ewah_rlw.o
 LIB_OBJS += exec-cmd.o
-LIB_OBJS += fetch-negotiator.o
-LIB_OBJS += fetch-object-info.o
-LIB_OBJS += fetch-pack.o
+LIB_OBJS += transport/fetch-negotiator.o
+LIB_OBJS += transport/fetch-object-info.o
+LIB_OBJS += transport/fetch-pack.o
 LIB_OBJS += fmt-merge-msg.o
 LIB_OBJS += odb/fsck.o
 LIB_OBJS += index/fsmonitor.o
@@ -1261,15 +1261,15 @@ LIB_OBJS += diff/patch-ids.o
 LIB_OBJS += path.o
 LIB_OBJS += path-walk.o
 LIB_OBJS += index/pathspec.o
-LIB_OBJS += pkt-line.o
+LIB_OBJS += transport/pkt-line.o
 LIB_OBJS += index/preload-index.o
 LIB_OBJS += revision/pretty.o
 LIB_OBJS += prio-queue.o
 LIB_OBJS += progress.o
-LIB_OBJS += promisor-remote.o
+LIB_OBJS += transport/promisor-remote.o
 LIB_OBJS += prompt.o
-LIB_OBJS += protocol.o
-LIB_OBJS += protocol-caps.o
+LIB_OBJS += transport/protocol.o
+LIB_OBJS += transport/protocol-caps.o
 LIB_OBJS += pack/prune-packed.o
 LIB_OBJS += pack/pseudo-merge.o
 LIB_OBJS += quote.o
@@ -1303,7 +1303,7 @@ LIB_OBJS += reftable/system.o
 LIB_OBJS += reftable/table.o
 LIB_OBJS += reftable/tree.o
 LIB_OBJS += reftable/writer.o
-LIB_OBJS += remote.o
+LIB_OBJS += transport/remote.o
 LIB_OBJS += pack/repack.o
 LIB_OBJS += pack/repack-cruft.o
 LIB_OBJS += pack/repack-filtered.o
@@ -1319,13 +1319,13 @@ LIB_OBJS += reset.o
 LIB_OBJS += index/resolve-undo.o
 LIB_OBJS += revision/revision.o
 LIB_OBJS += run-command.o
-LIB_OBJS += send-pack.o
+LIB_OBJS += transport/send-pack.o
 LIB_OBJS += sequencer.o
-LIB_OBJS += serve.o
+LIB_OBJS += transport/serve.o
 LIB_OBJS += pack/server-info.o
 LIB_OBJS += setup/setup.o
 LIB_OBJS += revision/shallow.o
-LIB_OBJS += sideband.o
+LIB_OBJS += transport/sideband.o
 LIB_OBJS += sigchain.o
 LIB_OBJS += index/sparse-index.o
 LIB_OBJS += index/split-index.o
@@ -1358,13 +1358,13 @@ LIB_OBJS += trace2/tr2_tgt_perf.o
 LIB_OBJS += trace2/tr2_tls.o
 LIB_OBJS += trace2/tr2_tmr.o
 LIB_OBJS += trailer.o
-LIB_OBJS += transport-helper.o
-LIB_OBJS += transport.o
+LIB_OBJS += transport/transport-helper.o
+LIB_OBJS += transport/transport.o
 LIB_OBJS += diff/tree-diff.o
 LIB_OBJS += odb/tree-walk.o
 LIB_OBJS += odb/tree.o
 LIB_OBJS += index/unpack-trees.o
-LIB_OBJS += upload-pack.o
+LIB_OBJS += transport/upload-pack.o
 LIB_OBJS += url.o
 LIB_OBJS += urlmatch.o
 LIB_OBJS += usage.o
@@ -1375,7 +1375,7 @@ LIB_OBJS += varint.o
 endif
 LIB_OBJS += setup/version.o
 LIB_OBJS += versioncmp.o
-LIB_OBJS += walker.o
+LIB_OBJS += transport/walker.o
 LIB_OBJS += wildmatch.o
 LIB_OBJS += refs/worktree.o
 LIB_OBJS += wrapper.o
@@ -1833,7 +1833,7 @@ else
         endif
         ifdef USE_CURL_FOR_IMAP_SEND
 		BASIC_CFLAGS += -DUSE_CURL_FOR_IMAP_SEND
-		IMAP_SEND_BUILDDEPS = http.o
+		IMAP_SEND_BUILDDEPS = transport/http.o
 		IMAP_SEND_LDFLAGS += $(CURL_LIBCURL)
         endif
         ifndef NO_EXPAT
@@ -2901,7 +2901,7 @@ ifdef INCLUDE_LIBGIT_RS
 endif
 
 ifndef NO_CURL
-	OBJECTS += http.o http-walker.o remote-curl.o
+	OBJECTS += transport/http.o transport/http-walker.o transport/remote-curl.o
 endif
 
 .PHONY: objects
@@ -2989,13 +2989,13 @@ gettext.sp gettext.s gettext.o: GIT-PREFIX
 gettext.sp gettext.s gettext.o: EXTRA_CPPFLAGS = \
 	-DGIT_LOCALE_PATH='"$(localedir_relative_SQ)"'
 
-http-push.sp http.sp http-walker.sp remote-curl.sp imap-send.sp: SP_EXTRA_FLAGS += \
+http-push.sp transport/http.sp transport/http-walker.sp transport/remote-curl.sp imap-send.sp: SP_EXTRA_FLAGS += \
 	-DCURL_DISABLE_TYPECHECK
 
 pack/pack-revindex.sp: SP_EXTRA_FLAGS += -Wno-memcpy-max-count
 
 ifdef NO_EXPAT
-http-walker.sp http-walker.s http-walker.o: EXTRA_CPPFLAGS = -DNO_EXPAT
+transport/http-walker.sp transport/http-walker.s transport/http-walker.o: EXTRA_CPPFLAGS = -DNO_EXPAT
 endif
 
 ifdef NO_REGEX
@@ -3017,10 +3017,10 @@ git-imap-send$X: imap-send.o $(IMAP_SEND_BUILDDEPS) GIT-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(IMAP_SEND_LDFLAGS) $(LIBS)
 
-git-http-fetch$X: http.o http-walker.o http-fetch.o GIT-LDFLAGS $(GITLIBS)
+git-http-fetch$X: transport/http.o transport/http-walker.o http-fetch.o GIT-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(CURL_LIBCURL) $(LIBS)
-git-http-push$X: http.o http-push.o GIT-LDFLAGS $(GITLIBS)
+git-http-push$X: transport/http.o http-push.o GIT-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(CURL_LIBCURL) $(EXPAT_LIBEXPAT) $(LIBS)
 
@@ -3030,7 +3030,7 @@ $(REMOTE_CURL_ALIASES): $(REMOTE_CURL_PRIMARY)
 	ln -s $< $@ 2>/dev/null || \
 	cp $< $@
 
-$(REMOTE_CURL_PRIMARY): remote-curl.o http.o http-walker.o GIT-LDFLAGS $(GITLIBS)
+$(REMOTE_CURL_PRIMARY): transport/remote-curl.o transport/http.o transport/http-walker.o GIT-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(CURL_LIBCURL) $(EXPAT_LIBEXPAT) $(LIBS)
 
@@ -3218,7 +3218,7 @@ LOCALIZED_C_CORE += builtin/clone.c
 LOCALIZED_C_CORE += builtin/index-pack.c
 LOCALIZED_C_CORE += builtin/push.c
 LOCALIZED_C_CORE += builtin/reset.c
-LOCALIZED_C_CORE += remote.c
+LOCALIZED_C_CORE += transport/remote.c
 LOCALIZED_C_CORE += index/wt-status.c
 
 LOCALIZED_C_CORE_GEN_PO = $(LOCALIZED_C_CORE:%=.build/pot/po/%.po)
diff --git a/branch.c b/branch.c
index 14483c1402..a8b2d808a0 100644
--- a/branch.c
+++ b/branch.c
@@ -11,7 +11,7 @@
 #include "path.h"
 #include "refs/refs.h"
 #include "refs/refspec.h"
-#include "remote.h"
+#include "transport/remote.h"
 #include "setup/repository.h"
 #include "sequencer.h"
 #include "odb/commit.h"
diff --git a/builtin/archive.c b/builtin/archive.c
index 3c1288a123..3355461fce 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -5,9 +5,9 @@
 #include "builtin.h"
 #include "archive.h"
 #include "gettext.h"
-#include "transport.h"
+#include "transport/transport.h"
 #include "parse-options.h"
-#include "pkt-line.h"
+#include "transport/pkt-line.h"
 
 static void create_output_file(const char *output_file)
 {
diff --git a/builtin/backfill.c b/builtin/backfill.c
index f30addad55..4278a46b8c 100644
--- a/builtin/backfill.c
+++ b/builtin/backfill.c
@@ -16,7 +16,7 @@
 #include "odb/odb.h"
 #include "odb/oid-array.h"
 #include "odb/oidset.h"
-#include "promisor-remote.h"
+#include "transport/promisor-remote.h"
 #include "strmap.h"
 #include "string-list.h"
 #include "revision/revision.h"
diff --git a/builtin/branch.c b/builtin/branch.c
index eeab13a4b6..cbaa726584 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -16,7 +16,7 @@
 #include "odb/commit.h"
 #include "gettext.h"
 #include "odb/object-name.h"
-#include "remote.h"
+#include "transport/remote.h"
 #include "parse-options.h"
 #include "branch.h"
 #include "path.h"
diff --git a/builtin/bundle.c b/builtin/bundle.c
index 6dbe478bcb..86a9c9b01a 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -5,8 +5,8 @@
 #include "setup/setup.h"
 #include "strvec.h"
 #include "parse-options.h"
-#include "pkt-line.h"
-#include "bundle.h"
+#include "transport/pkt-line.h"
+#include "transport/bundle.h"
 
 /*
  * Basic handler for bundle files to connect repositories via sneakernet.
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 4a5c73720d..536b40a17c 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -25,12 +25,12 @@
 #include "odb/odb.h"
 #include "odb/streaming.h"
 #include "odb/replace-object.h"
-#include "promisor-remote.h"
+#include "transport/promisor-remote.h"
 #include "mailmap.h"
 #include "write-or-die.h"
 #include "setup/alias.h"
-#include "remote.h"
-#include "transport.h"
+#include "transport/remote.h"
+#include "transport/transport.h"
 
 /*
  * Maximum length for a remote URL. While no universal standard exists,
diff --git a/builtin/checkout--worker.c b/builtin/checkout--worker.c
index aa1ca1ed14..1347f4d2fc 100644
--- a/builtin/checkout--worker.c
+++ b/builtin/checkout--worker.c
@@ -8,7 +8,7 @@
 #include "gettext.h"
 #include "index/parallel-checkout.h"
 #include "parse-options.h"
-#include "pkt-line.h"
+#include "transport/pkt-line.h"
 #include "index/read-cache-ll.h"
 
 static void packet_to_pc_item(const char *buffer, int len,
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 3dedddc61a..53ec5431bf 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -25,7 +25,7 @@
 #include "index/preload-index.h"
 #include "index/read-cache.h"
 #include "refs/refs.h"
-#include "remote.h"
+#include "transport/remote.h"
 #include "setup/repo-settings.h"
 #include "index/resolve-undo.h"
 #include "revision/revision.h"
diff --git a/builtin/clone.c b/builtin/clone.c
index a8f7e1b6f3..f800d6cf97 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -29,24 +29,24 @@
 #include "odb/tree.h"
 #include "odb/tree-walk.h"
 #include "index/unpack-trees.h"
-#include "transport.h"
+#include "transport/transport.h"
 #include "strbuf.h"
 #include "index/dir.h"
 #include "index/dir-iterator.h"
 #include "iterator.h"
 #include "sigchain.h"
 #include "branch.h"
-#include "remote.h"
+#include "transport/remote.h"
 #include "run-command.h"
 #include "setup/setup.h"
-#include "connected.h"
+#include "transport/connected.h"
 #include "pack/packfile.h"
 #include "path.h"
-#include "pkt-line.h"
+#include "transport/pkt-line.h"
 #include "revision/list-objects-filter-options.h"
 #include "setup/hook.h"
-#include "bundle.h"
-#include "bundle-uri.h"
+#include "transport/bundle.h"
+#include "transport/bundle-uri.h"
 
 /*
  * Overall FIXMEs:
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 5e5e100884..9080474629 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -28,7 +28,7 @@
 #include "utf8.h"
 #include "parse-options.h"
 #include "quote.h"
-#include "remote.h"
+#include "transport/remote.h"
 #include "odb/blob.h"
 #include "gpg-interface.h"
 
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index c6ae0197ab..5f2cfefed4 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -5,12 +5,12 @@
 #include "gettext.h"
 #include "hex.h"
 #include "odb/object-file.h"
-#include "pkt-line.h"
-#include "fetch-pack.h"
-#include "remote.h"
-#include "connect.h"
+#include "transport/pkt-line.h"
+#include "transport/fetch-pack.h"
+#include "transport/remote.h"
+#include "transport/connect.h"
 #include "odb/oid-array.h"
-#include "protocol.h"
+#include "transport/protocol.h"
 
 static const char fetch_pack_usage[] =
 "git fetch-pack [--all] [--stdin] [--quiet | -q] [--keep | -k] [--thin] "
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 60be51f079..b23990bd51 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -19,28 +19,28 @@
 #include "odb/oid-array.h"
 #include "odb/commit.h"
 #include "string-list.h"
-#include "remote.h"
-#include "transport.h"
+#include "transport/remote.h"
+#include "transport/transport.h"
 #include "run-command.h"
 #include "parse-options.h"
 #include "sigchain.h"
 #include "submodule-config.h"
 #include "submodule.h"
-#include "connected.h"
+#include "transport/connected.h"
 #include "strvec.h"
 #include "utf8.h"
 #include "pager.h"
 #include "path.h"
-#include "pkt-line.h"
+#include "transport/pkt-line.h"
 #include "revision/list-objects-filter-options.h"
 #include "revision/commit-reach.h"
 #include "branch.h"
-#include "promisor-remote.h"
+#include "transport/promisor-remote.h"
 #include "pack/commit-graph.h"
 #include "revision/shallow.h"
 #include "trace.h"
 #include "trace2.h"
-#include "bundle-uri.h"
+#include "transport/bundle-uri.h"
 
 #define FORCED_UPDATES_DELAY_WARNING_IN_MS (10 * 1000)
 
diff --git a/builtin/gc.c b/builtin/gc.c
index e4c482c243..886be058bd 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -36,7 +36,7 @@
 #include "rerere.h"
 #include "revision/revision.h"
 #include "refs/refs.h"
-#include "remote.h"
+#include "transport/remote.h"
 #include "exec-cmd.h"
 #include "gettext.h"
 #include "setup/hook.h"
diff --git a/builtin/grep.c b/builtin/grep.c
index 10df2dacef..7e8df3cdd1 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -32,7 +32,7 @@
 #include "odb/oidset.h"
 #include "pager.h"
 #include "path.h"
-#include "promisor-remote.h"
+#include "transport/promisor-remote.h"
 #include "index/read-cache-ll.h"
 #include "write-or-die.h"
 
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 167a6df9e7..9eb9f1d0b0 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -27,7 +27,7 @@
 #include "path.h"
 #include "odb/replace-object.h"
 #include "odb/tree-walk.h"
-#include "promisor-remote.h"
+#include "transport/promisor-remote.h"
 #include "run-command.h"
 #include "setup/setup.h"
 #include "strvec.h"
diff --git a/builtin/log.c b/builtin/log.c
index 5b79637af3..29199b6684 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -32,7 +32,7 @@
 #include "diff/patch-ids.h"
 #include "path.h"
 #include "shortlog.h"
-#include "remote.h"
+#include "transport/remote.h"
 #include "string-list.h"
 #include "parse-options.h"
 #include "revision/line-log.h"
@@ -45,7 +45,7 @@
 #include "utf8.h"
 
 #include "revision/commit-reach.h"
-#include "promisor-remote.h"
+#include "transport/promisor-remote.h"
 #include "diff/range-diff.h"
 #include "odb/tmp-objdir.h"
 #include "odb/tree.h"
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 1b12d6e6ec..7d07c9d399 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -2,10 +2,10 @@
 #include "builtin.h"
 #include "gettext.h"
 #include "hex.h"
-#include "transport.h"
-#include "pkt-line.h"
+#include "transport/transport.h"
+#include "transport/pkt-line.h"
 #include "refs/ref-filter.h"
-#include "remote.h"
+#include "transport/remote.h"
 #include "parse-options.h"
 #include "wildmatch.h"
 
diff --git a/builtin/merge.c b/builtin/merge.c
index 090e2a8fb1..6605dc1f91 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -41,7 +41,7 @@
 #include "merge.h"
 #include "merge-ort-wrappers.h"
 #include "index/resolve-undo.h"
-#include "remote.h"
+#include "transport/remote.h"
 #include "fmt-merge-msg.h"
 #include "sequencer.h"
 #include "string-list.h"
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index cc97d7e814..2376d21a7a 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -40,10 +40,10 @@
 #include "pack/midx.h"
 #include "trace2.h"
 #include "revision/shallow.h"
-#include "promisor-remote.h"
+#include "transport/promisor-remote.h"
 #include "pack/pack-mtimes.h"
 #include "parse-options.h"
-#include "pkt-line.h"
+#include "transport/pkt-line.h"
 #include "odb/blob.h"
 #include "odb/tree.h"
 #include "path-walk.h"
diff --git a/builtin/pull.c b/builtin/pull.c
index cca98abb65..9206d7d1c2 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -19,7 +19,7 @@
 #include "parse-options.h"
 #include "run-command.h"
 #include "odb/oid-array.h"
-#include "remote.h"
+#include "transport/remote.h"
 #include "index/dir.h"
 #include "path.h"
 #include "index/read-cache-ll.h"
diff --git a/builtin/push.c b/builtin/push.c
index b4556466d7..2480f95e5b 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -14,13 +14,13 @@
 #include "hex.h"
 #include "refs/refspec.h"
 #include "run-command.h"
-#include "remote.h"
-#include "transport.h"
+#include "transport/remote.h"
+#include "transport/transport.h"
 #include "parse-options.h"
-#include "pkt-line.h"
+#include "transport/pkt-line.h"
 #include "submodule.h"
 #include "submodule-config.h"
-#include "send-pack.h"
+#include "transport/send-pack.h"
 #include "trace2.h"
 #include "color.h"
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 718073653c..731fc89894 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -6,8 +6,8 @@
 #include "odb/commit.h"
 #include "revision/commit-reach.h"
 #include "setup/config.h"
-#include "connect.h"
-#include "connected.h"
+#include "transport/connect.h"
+#include "transport/connected.h"
 #include "setup/environment.h"
 #include "exec-cmd.h"
 #include "odb/fsck.h"
@@ -25,15 +25,15 @@
 #include "pack/pack.h"
 #include "pack/packfile.h"
 #include "parse-options.h"
-#include "pkt-line.h"
-#include "protocol.h"
+#include "transport/pkt-line.h"
+#include "transport/protocol.h"
 #include "refs/refs.h"
-#include "remote.h"
+#include "transport/remote.h"
 #include "run-command.h"
 #include "pack/server-info.h"
 #include "setup/setup.h"
 #include "revision/shallow.h"
-#include "sideband.h"
+#include "transport/sideband.h"
 #include "sigchain.h"
 #include "string-list.h"
 #include "strvec.h"
diff --git a/builtin/remote-ext.c b/builtin/remote-ext.c
index bd2037f27d..c5409c69c2 100644
--- a/builtin/remote-ext.c
+++ b/builtin/remote-ext.c
@@ -1,7 +1,7 @@
 #include "builtin.h"
-#include "transport.h"
+#include "transport/transport.h"
 #include "run-command.h"
-#include "pkt-line.h"
+#include "transport/pkt-line.h"
 
 static const char usage_msg[] =
 	"git remote-ext <remote> <url>";
diff --git a/builtin/remote-fd.c b/builtin/remote-fd.c
index 39908546ba..6bccb2a0c7 100644
--- a/builtin/remote-fd.c
+++ b/builtin/remote-fd.c
@@ -1,5 +1,5 @@
 #include "builtin.h"
-#include "transport.h"
+#include "transport/transport.h"
 
 static const char usage_msg[] =
 	"git remote-fd <remote> <url>";
diff --git a/builtin/remote.c b/builtin/remote.c
index 5a4fa6de8b..fe039f8cfc 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -8,8 +8,8 @@
 #include "setup/ident.h"
 #include "parse-options.h"
 #include "path.h"
-#include "transport.h"
-#include "remote.h"
+#include "transport/transport.h"
+#include "transport/remote.h"
 #include "string-list.h"
 #include "strbuf.h"
 #include "run-command.h"
diff --git a/builtin/repack.c b/builtin/repack.c
index 1d861c6062..b54e47053e 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -11,7 +11,7 @@
 #include "pack/midx.h"
 #include "pack/packfile.h"
 #include "pack/prune-packed.h"
-#include "promisor-remote.h"
+#include "transport/promisor-remote.h"
 #include "pack/repack.h"
 #include "revision/shallow.h"
 
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 1e358bc0b0..203f830385 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -2,16 +2,16 @@
 #include "setup/config.h"
 #include "setup/environment.h"
 #include "hex.h"
-#include "pkt-line.h"
+#include "transport/pkt-line.h"
 #include "run-command.h"
-#include "remote.h"
-#include "connect.h"
-#include "send-pack.h"
+#include "transport/remote.h"
+#include "transport/connect.h"
+#include "transport/send-pack.h"
 #include "quote.h"
-#include "transport.h"
+#include "transport/transport.h"
 #include "odb/oid-array.h"
 #include "gettext.h"
-#include "protocol.h"
+#include "transport/protocol.h"
 #include "parse-options.h"
 #include "write-or-die.h"
 
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 5a97263743..042687f46d 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -20,7 +20,7 @@
 #include "submodule-config.h"
 #include "string-list.h"
 #include "run-command.h"
-#include "remote.h"
+#include "transport/remote.h"
 #include "refs/refs.h"
 #include "refs/refspec.h"
 #include "revision/revision.h"
diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
index 7b63b0185b..f837d8cc78 100644
--- a/builtin/upload-archive.c
+++ b/builtin/upload-archive.c
@@ -4,9 +4,9 @@
 #define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "archive.h"
-#include "pkt-line.h"
+#include "transport/pkt-line.h"
 #include "setup/setup.h"
-#include "sideband.h"
+#include "transport/sideband.h"
 #include "run-command.h"
 #include "strvec.h"
 
diff --git a/builtin/upload-pack.c b/builtin/upload-pack.c
index 7131fb6689..9eae3a2d9f 100644
--- a/builtin/upload-pack.c
+++ b/builtin/upload-pack.c
@@ -3,12 +3,12 @@
 #include "builtin.h"
 #include "exec-cmd.h"
 #include "gettext.h"
-#include "pkt-line.h"
+#include "transport/pkt-line.h"
 #include "parse-options.h"
-#include "protocol.h"
+#include "transport/protocol.h"
 #include "odb/replace-object.h"
-#include "upload-pack.h"
-#include "serve.h"
+#include "transport/upload-pack.h"
+#include "transport/serve.h"
 #include "setup/setup.h"
 #include "odb/commit.h"
 #include "setup/environment.h"
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 1d808800cc..412289cba7 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -19,7 +19,7 @@
 #include "branch.h"
 #include "index/read-cache-ll.h"
 #include "refs/refs.h"
-#include "remote.h"
+#include "transport/remote.h"
 #include "run-command.h"
 #include "setup/hook.h"
 #include "sigchain.h"
diff --git a/compat/simple-ipc/ipc-win32.c b/compat/simple-ipc/ipc-win32.c
index 4a3e7df9c7..cf15ab82c0 100644
--- a/compat/simple-ipc/ipc-win32.c
+++ b/compat/simple-ipc/ipc-win32.c
@@ -3,7 +3,7 @@
 #include "gettext.h"
 #include "simple-ipc.h"
 #include "strbuf.h"
-#include "pkt-line.h"
+#include "transport/pkt-line.h"
 #include "thread-utils.h"
 #include "trace.h"
 #include "trace2.h"
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 8f56203f34..e0c63639f9 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -771,15 +771,15 @@ add_executable(scalar ${CMAKE_SOURCE_DIR}/scalar.c)
 target_link_libraries(scalar common-main)
 
 if(CURL_FOUND)
-	add_library(http_obj OBJECT ${CMAKE_SOURCE_DIR}/http.c)
+	add_library(http_obj OBJECT ${CMAKE_SOURCE_DIR}/transport/http.c)
 
 	add_executable(git-imap-send ${CMAKE_SOURCE_DIR}/imap-send.c)
 	target_link_libraries(git-imap-send http_obj common-main ${CURL_LIBRARIES})
 
-	add_executable(git-http-fetch ${CMAKE_SOURCE_DIR}/http-walker.c ${CMAKE_SOURCE_DIR}/http-fetch.c)
+	add_executable(git-http-fetch ${CMAKE_SOURCE_DIR}/transport/http-walker.c ${CMAKE_SOURCE_DIR}/http-fetch.c)
 	target_link_libraries(git-http-fetch http_obj common-main ${CURL_LIBRARIES})
 
-	add_executable(git-remote-http ${CMAKE_SOURCE_DIR}/http-walker.c ${CMAKE_SOURCE_DIR}/remote-curl.c)
+	add_executable(git-remote-http ${CMAKE_SOURCE_DIR}/transport/http-walker.c ${CMAKE_SOURCE_DIR}/transport/remote-curl.c)
 	target_link_libraries(git-remote-http http_obj common-main ${CURL_LIBRARIES} )
 
 	if(EXPAT_FOUND)
diff --git a/convert.c b/convert.c
index 5490c4a558..15fc4fc0d8 100644
--- a/convert.c
+++ b/convert.c
@@ -14,7 +14,7 @@
 #include "quote.h"
 #include "index/read-cache-ll.h"
 #include "sigchain.h"
-#include "pkt-line.h"
+#include "transport/pkt-line.h"
 #include "sub-process.h"
 #include "trace.h"
 #include "utf8.h"
diff --git a/daemon.c b/daemon.c
index 219eeab179..5f9ed302ab 100644
--- a/daemon.c
+++ b/daemon.c
@@ -6,8 +6,8 @@
 #include "setup/environment.h"
 #include "gettext.h"
 #include "path.h"
-#include "pkt-line.h"
-#include "protocol.h"
+#include "transport/pkt-line.h"
+#include "transport/protocol.h"
 #include "run-command.h"
 #include "setup/setup.h"
 #include "strbuf.h"
diff --git a/diff/diff.c b/diff/diff.c
index 4603493a36..86c0fddf24 100644
--- a/diff/diff.c
+++ b/diff/diff.c
@@ -38,7 +38,7 @@
 #include "pager.h"
 #include "parse-options.h"
 #include "help.h"
-#include "promisor-remote.h"
+#include "transport/promisor-remote.h"
 #include "index/dir.h"
 #include "odb/object-file.h"
 #include "odb/object-name.h"
diff --git a/diff/diffcore-break.c b/diff/diffcore-break.c
index c822a0d56d..d4689ad0d3 100644
--- a/diff/diffcore-break.c
+++ b/diff/diffcore-break.c
@@ -8,7 +8,7 @@
 #include "diff/diffcore.h"
 #include "odb/hash.h"
 #include "odb/object.h"
-#include "promisor-remote.h"
+#include "transport/promisor-remote.h"
 
 static int should_break(struct repository *r,
 			struct diff_filespec *src,
diff --git a/diff/diffcore-rename.c b/diff/diffcore-rename.c
index 16746444d8..25e40cd39d 100644
--- a/diff/diffcore-rename.c
+++ b/diff/diffcore-rename.c
@@ -13,7 +13,7 @@
 #include "mem-pool.h"
 #include "odb/oid-array.h"
 #include "progress.h"
-#include "promisor-remote.h"
+#include "transport/promisor-remote.h"
 #include "string-list.h"
 #include "strmap.h"
 #include "trace2.h"
diff --git a/help.c b/help.c
index 34ab22ade5..f3440c7695 100644
--- a/help.c
+++ b/help.c
@@ -24,7 +24,7 @@
 #include "utf8.h"
 
 #ifndef NO_CURL
-#include "git-curl-compat.h" /* For LIBCURL_VERSION only */
+#include "transport/git-curl-compat.h" /* For LIBCURL_VERSION only */
 #endif
 
 struct category_description {
diff --git a/http-backend.c b/http-backend.c
index dcf8506c1e..b10f7e02f2 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -9,7 +9,7 @@
 #include "path.h"
 #include "setup/repository.h"
 #include "refs/refs.h"
-#include "pkt-line.h"
+#include "transport/pkt-line.h"
 #include "odb/object.h"
 #include "odb/tag.h"
 #include "exec-cmd.h"
@@ -20,7 +20,7 @@
 #include "strvec.h"
 #include "pack/packfile.h"
 #include "odb/odb.h"
-#include "protocol.h"
+#include "transport/protocol.h"
 #include "date.h"
 #include "write-or-die.h"
 
diff --git a/http-fetch.c b/http-fetch.c
index ad2447ce72..e3846d0b41 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -5,8 +5,8 @@
 #include "setup/environment.h"
 #include "gettext.h"
 #include "hex.h"
-#include "http.h"
-#include "walker.h"
+#include "transport/http.h"
+#include "transport/walker.h"
 #include "setup/setup.h"
 #include "strvec.h"
 #include "url.h"
diff --git a/http-push.c b/http-push.c
index fb18e8756f..3014dad9be 100644
--- a/http-push.c
+++ b/http-push.c
@@ -7,10 +7,10 @@
 #include "odb/commit.h"
 #include "odb/tag.h"
 #include "odb/blob.h"
-#include "http.h"
+#include "transport/http.h"
 #include "diff/diff.h"
 #include "revision/revision.h"
-#include "remote.h"
+#include "transport/remote.h"
 #include "revision/list-objects.h"
 #include "setup/setup.h"
 #include "sigchain.h"
diff --git a/imap-send.c b/imap-send.c
index de244d8011..6a16304783 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -35,7 +35,7 @@
 #include "setup/setup.h"
 #include "strbuf.h"
 #ifdef USE_CURL_FOR_IMAP_SEND
-#include "http.h"
+#include "transport/http.h"
 #endif
 
 #if defined(USE_CURL_FOR_IMAP_SEND)
diff --git a/index/cache-tree.c b/index/cache-tree.c
index bb813bd840..283c1cbc3d 100644
--- a/index/cache-tree.c
+++ b/index/cache-tree.c
@@ -14,7 +14,7 @@
 #include "index/read-cache-ll.h"
 #include "odb/replace-object.h"
 #include "setup/repository.h"
-#include "promisor-remote.h"
+#include "transport/promisor-remote.h"
 #include "trace.h"
 #include "trace2.h"
 
diff --git a/index/checkout.c b/index/checkout.c
index b262ada8c7..09c1cd14a6 100644
--- a/index/checkout.c
+++ b/index/checkout.c
@@ -2,7 +2,7 @@
 
 #include "git-compat-util.h"
 #include "odb/object-name.h"
-#include "remote.h"
+#include "transport/remote.h"
 #include "refs/refspec.h"
 #include "setup/repository.h"
 #include "index/checkout.h"
diff --git a/index/parallel-checkout.c b/index/parallel-checkout.c
index 0905a7ff1e..a525abbcd7 100644
--- a/index/parallel-checkout.c
+++ b/index/parallel-checkout.c
@@ -8,7 +8,7 @@
 #include "odb/hash.h"
 #include "hex.h"
 #include "index/parallel-checkout.h"
-#include "pkt-line.h"
+#include "transport/pkt-line.h"
 #include "progress.h"
 #include "index/read-cache-ll.h"
 #include "run-command.h"
diff --git a/index/read-cache.c b/index/read-cache.c
index 20a5e191a4..60d496535a 100644
--- a/index/read-cache.c
+++ b/index/read-cache.c
@@ -46,7 +46,7 @@
 #include "progress.h"
 #include "index/sparse-index.h"
 #include "csum-file.h"
-#include "promisor-remote.h"
+#include "transport/promisor-remote.h"
 #include "setup/hook.h"
 #include "submodule.h"
 #include "submodule-config.h"
diff --git a/index/unpack-trees.c b/index/unpack-trees.c
index 2eecede699..e06b0a6a77 100644
--- a/index/unpack-trees.c
+++ b/index/unpack-trees.c
@@ -27,7 +27,7 @@
 #include "trace2.h"
 #include "index/fsmonitor.h"
 #include "odb/odb.h"
-#include "promisor-remote.h"
+#include "transport/promisor-remote.h"
 #include "index/entry.h"
 #include "index/parallel-checkout.h"
 #include "setup/setup.h"
diff --git a/index/wt-status.c b/index/wt-status.c
index 847438f121..ef7b513214 100644
--- a/index/wt-status.c
+++ b/index/wt-status.c
@@ -20,7 +20,7 @@
 #include "setup/repository.h"
 #include "run-command.h"
 #include "strvec.h"
-#include "remote.h"
+#include "transport/remote.h"
 #include "refs/refs.h"
 #include "submodule.h"
 #include "column.h"
diff --git a/index/wt-status.h b/index/wt-status.h
index b7a508186d..81bb7292b9 100644
--- a/index/wt-status.h
+++ b/index/wt-status.h
@@ -4,7 +4,7 @@
 #include "string-list.h"
 #include "color.h"
 #include "index/pathspec.h"
-#include "remote.h"
+#include "transport/remote.h"
 
 struct repository;
 struct worktree;
diff --git a/merge-ort.c b/merge-ort.c
index f101b5e0c4..cc21e397de 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -42,7 +42,7 @@
 #include "odb/odb.h"
 #include "odb/oid-array.h"
 #include "path.h"
-#include "promisor-remote.h"
+#include "transport/promisor-remote.h"
 #include "index/read-cache-ll.h"
 #include "refs/refs.h"
 #include "revision/revision.h"
diff --git a/meson.build b/meson.build
index bad597d8ff..6902f5de75 100644
--- a/meson.build
+++ b/meson.build
@@ -324,8 +324,8 @@ libgit_sources = [
   'odb/blob.c',
   'pack/bloom.c',
   'branch.c',
-  'bundle-uri.c',
-  'bundle.c',
+  'transport/bundle-uri.c',
+  'transport/bundle.c',
   'index/cache-tree.c',
   'odb/cbtree.c',
   'chdir-notify.c',
@@ -341,8 +341,8 @@ libgit_sources = [
   'common-init.c',
   'compiler-tricks/not-constant.c',
   'setup/config.c',
-  'connect.c',
-  'connected.c',
+  'transport/connect.c',
+  'transport/connected.c',
   'convert.c',
   'copy.c',
   'credential.c',
@@ -373,9 +373,9 @@ libgit_sources = [
   'ewah/ewah_io.c',
   'ewah/ewah_rlw.c',
   'exec-cmd.c',
-  'fetch-negotiator.c',
-  'fetch-object-info.c',
-  'fetch-pack.c',
+  'transport/fetch-negotiator.c',
+  'transport/fetch-object-info.c',
+  'transport/fetch-pack.c',
   'fmt-merge-msg.c',
   'odb/fsck.c',
   'index/fsmonitor.c',
@@ -466,15 +466,15 @@ libgit_sources = [
   'path.c',
   'path-walk.c',
   'index/pathspec.c',
-  'pkt-line.c',
+  'transport/pkt-line.c',
   'index/preload-index.c',
   'revision/pretty.c',
   'prio-queue.c',
   'progress.c',
-  'promisor-remote.c',
+  'transport/promisor-remote.c',
   'prompt.c',
-  'protocol.c',
-  'protocol-caps.c',
+  'transport/protocol.c',
+  'transport/protocol-caps.c',
   'pack/prune-packed.c',
   'pack/pseudo-merge.c',
   'quote.c',
@@ -508,7 +508,7 @@ libgit_sources = [
   'reftable/table.c',
   'reftable/tree.c',
   'reftable/writer.c',
-  'remote.c',
+  'transport/remote.c',
   'pack/repack.c',
   'pack/repack-cruft.c',
   'pack/repack-filtered.c',
@@ -524,13 +524,13 @@ libgit_sources = [
   'index/resolve-undo.c',
   'revision/revision.c',
   'run-command.c',
-  'send-pack.c',
+  'transport/send-pack.c',
   'sequencer.c',
-  'serve.c',
+  'transport/serve.c',
   'pack/server-info.c',
   'setup/setup.c',
   'revision/shallow.c',
-  'sideband.c',
+  'transport/sideband.c',
   'sigchain.c',
   'index/sparse-index.c',
   'index/split-index.c',
@@ -563,13 +563,13 @@ libgit_sources = [
   'trace2/tr2_tls.c',
   'trace2/tr2_tmr.c',
   'trailer.c',
-  'transport-helper.c',
-  'transport.c',
+  'transport/transport-helper.c',
+  'transport/transport.c',
   'diff/tree-diff.c',
   'odb/tree-walk.c',
   'odb/tree.c',
   'index/unpack-trees.c',
-  'upload-pack.c',
+  'transport/upload-pack.c',
   'url.c',
   'urlmatch.c',
   'usage.c',
@@ -577,7 +577,7 @@ libgit_sources = [
   'utf8.c',
   'setup/version.c',
   'versioncmp.c',
-  'walker.c',
+  'transport/walker.c',
   'wildmatch.c',
   'refs/worktree.c',
   'wrapper.c',
@@ -1918,14 +1918,14 @@ bin_wrappers += executable('scalar',
 if curl.found()
   libgit_curl = declare_dependency(
     sources: [
-      'http.c',
-      'http-walker.c',
+      'transport/http.c',
+      'transport/http-walker.c',
     ],
     dependencies: [libgit_commonmain, curl],
   )
 
   test_dependencies += executable('git-remote-http',
-    sources: 'remote-curl.c',
+    sources: 'transport/remote-curl.c',
     dependencies: [libgit_curl],
     install: true,
     install_dir: git_exec_path,
@@ -1949,7 +1949,7 @@ if curl.found()
 
   foreach alias : [ 'git-remote-https', 'git-remote-ftp', 'git-remote-ftps' ]
     test_dependencies += executable(alias,
-      sources: 'remote-curl.c',
+      sources: 'transport/remote-curl.c',
       dependencies: [libgit_curl],
     )
 
diff --git a/negotiator/default.c b/negotiator/default.c
index 3211453743..98f2b44b7e 100644
--- a/negotiator/default.c
+++ b/negotiator/default.c
@@ -3,7 +3,7 @@
 #include "git-compat-util.h"
 #include "default.h"
 #include "odb/commit.h"
-#include "../fetch-negotiator.h"
+#include "transport/fetch-negotiator.h"
 #include "../prio-queue.h"
 #include "refs/refs.h"
 #include "setup/repository.h"
diff --git a/negotiator/noop.c b/negotiator/noop.c
index edf1b456f3..e547d6bb1f 100644
--- a/negotiator/noop.c
+++ b/negotiator/noop.c
@@ -1,6 +1,6 @@
 #include "git-compat-util.h"
 #include "noop.h"
-#include "../fetch-negotiator.h"
+#include "transport/fetch-negotiator.h"
 
 static void known_common(struct fetch_negotiator *n UNUSED,
 			 struct commit *c UNUSED)
diff --git a/negotiator/skipping.c b/negotiator/skipping.c
index eabfac6edd..e01c339dd0 100644
--- a/negotiator/skipping.c
+++ b/negotiator/skipping.c
@@ -3,7 +3,7 @@
 #include "git-compat-util.h"
 #include "skipping.h"
 #include "odb/commit.h"
-#include "../fetch-negotiator.h"
+#include "transport/fetch-negotiator.h"
 #include "../hex.h"
 #include "../prio-queue.h"
 #include "refs/refs.h"
diff --git a/odb/object-name.c b/odb/object-name.c
index af03d8d0e5..e734455585 100644
--- a/odb/object-name.c
+++ b/odb/object-name.c
@@ -13,7 +13,7 @@
 #include "odb/tree.h"
 #include "odb/tree-walk.h"
 #include "refs/refs.h"
-#include "remote.h"
+#include "transport/remote.h"
 #include "index/dir.h"
 #include "odb/odb.h"
 #include "odb/oid-array.h"
diff --git a/odb/odb.c b/odb/odb.c
index f326dbb284..76b0712120 100644
--- a/odb/odb.c
+++ b/odb/odb.c
@@ -17,7 +17,7 @@
 #include "odb/source-inmemory.h"
 #include "pack/packfile.h"
 #include "path.h"
-#include "promisor-remote.h"
+#include "transport/promisor-remote.h"
 #include "quote.h"
 #include "odb/replace-object.h"
 #include "run-command.h"
diff --git a/odb/source-files.c b/odb/source-files.c
index 7b8a21d137..02671605ab 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -13,7 +13,7 @@
 #include "pack/pack-objects.h"
 #include "pack/packfile.h"
 #include "path.h"
-#include "promisor-remote.h"
+#include "transport/promisor-remote.h"
 #include "pack/repack.h"
 #include "run-command.h"
 #include "strbuf.h"
diff --git a/pack/pack-write.c b/pack/pack-write.c
index 45066b9657..59b4638839 100644
--- a/pack/pack-write.c
+++ b/pack/pack-write.c
@@ -4,7 +4,7 @@
 #include "hex.h"
 #include "pack/pack.h"
 #include "csum-file.h"
-#include "remote.h"
+#include "transport/remote.h"
 #include "pack/chunk-format.h"
 #include "odb/object-file.h"
 #include "pack/pack-mtimes.h"
diff --git a/pack/packfile.c b/pack/packfile.c
index 9509d6efcb..15df048ce7 100644
--- a/pack/packfile.c
+++ b/pack/packfile.c
@@ -23,7 +23,7 @@
 #include "pack/midx.h"
 #include "pack/commit-graph.h"
 #include "pack/pack-revindex.h"
-#include "promisor-remote.h"
+#include "transport/promisor-remote.h"
 #include "pack/pack-mtimes.h"
 
 char *odb_pack_name(struct repository *r, struct strbuf *buf,
diff --git a/refs/ls-refs.c b/refs/ls-refs.c
index 03ab2720e9..83f847de81 100644
--- a/refs/ls-refs.c
+++ b/refs/ls-refs.c
@@ -9,7 +9,7 @@
 #include "refs/refs.h"
 #include "strvec.h"
 #include "refs/ls-refs.h"
-#include "pkt-line.h"
+#include "transport/pkt-line.h"
 #include "setup/config.h"
 #include "string-list.h"
 
diff --git a/refs/ref-filter.c b/refs/ref-filter.c
index 9a426b6ce9..c369856b54 100644
--- a/refs/ref-filter.c
+++ b/refs/ref-filter.c
@@ -19,7 +19,7 @@
 #include "odb/commit.h"
 #include "mailmap.h"
 #include "setup/ident.h"
-#include "remote.h"
+#include "transport/remote.h"
 #include "color.h"
 #include "odb/tag.h"
 #include "quote.h"
diff --git a/refs/refspec.c b/refs/refspec.c
index 324c274bff..bbd520f54b 100644
--- a/refs/refspec.c
+++ b/refs/refspec.c
@@ -8,7 +8,7 @@
 #include "strvec.h"
 #include "refs/refs.h"
 #include "refs/refspec.h"
-#include "remote.h"
+#include "transport/remote.h"
 #include "strbuf.h"
 
 /*
diff --git a/revision/list-objects-filter-options.c b/revision/list-objects-filter-options.c
index 38604a580c..a22dc5b435 100644
--- a/revision/list-objects-filter-options.c
+++ b/revision/list-objects-filter-options.c
@@ -4,7 +4,7 @@
 #include "setup/config.h"
 #include "gettext.h"
 #include "revision/list-objects-filter-options.h"
-#include "promisor-remote.h"
+#include "transport/promisor-remote.h"
 #include "trace.h"
 #include "url.h"
 #include "parse-options.h"
diff --git a/revision/shallow.c b/revision/shallow.c
index a6e8a66c14..8822ef7f4c 100644
--- a/revision/shallow.c
+++ b/revision/shallow.c
@@ -8,7 +8,7 @@
 #include "odb/odb.h"
 #include "odb/commit.h"
 #include "odb/tag.h"
-#include "pkt-line.h"
+#include "transport/pkt-line.h"
 #include "refs/refs.h"
 #include "odb/oid-array.h"
 #include "path.h"
diff --git a/setup/repository.c b/setup/repository.c
index 77be866c82..cd2719fb33 100644
--- a/setup/repository.c
+++ b/setup/repository.c
@@ -10,13 +10,13 @@
 #include "lockfile.h"
 #include "path.h"
 #include "index/read-cache-ll.h"
-#include "remote.h"
+#include "transport/remote.h"
 #include "setup/setup.h"
 #include "odb/loose.h"
 #include "submodule-config.h"
 #include "index/sparse-index.h"
 #include "trace2.h"
-#include "promisor-remote.h"
+#include "transport/promisor-remote.h"
 #include "refs/refs.h"
 
 /*
diff --git a/simple-ipc.h b/simple-ipc.h
index 701e005cb8..038ae97f02 100644
--- a/simple-ipc.h
+++ b/simple-ipc.h
@@ -37,7 +37,7 @@ enum ipc_active_state {
 };
 
 #ifdef SUPPORTS_SIMPLE_IPC
-#include "pkt-line.h"
+#include "transport/pkt-line.h"
 
 /*
  * Simple IPC Client Side API.
diff --git a/sub-process.c b/sub-process.c
index 2d5c965169..e639cca9b9 100644
--- a/sub-process.c
+++ b/sub-process.c
@@ -4,7 +4,7 @@
 #include "git-compat-util.h"
 #include "sub-process.h"
 #include "sigchain.h"
-#include "pkt-line.h"
+#include "transport/pkt-line.h"
 
 int cmd2process_cmp(const void *cmp_data UNUSED,
 		    const struct hashmap_entry *eptr,
diff --git a/submodule.c b/submodule.c
index 16b3ffbcc6..0272a7d553 100644
--- a/submodule.c
+++ b/submodule.c
@@ -22,7 +22,7 @@
 #include "strvec.h"
 #include "thread-utils.h"
 #include "path.h"
-#include "remote.h"
+#include "transport/remote.h"
 #include "refs/worktree.h"
 #include "parse-options.h"
 #include "odb/object-file.h"
diff --git a/t/helper/test-bundle-uri.c b/t/helper/test-bundle-uri.c
index 0c5fa723d8..48946a6fc2 100644
--- a/t/helper/test-bundle-uri.c
+++ b/t/helper/test-bundle-uri.c
@@ -1,11 +1,11 @@
 #include "test-tool.h"
 #include "parse-options.h"
-#include "bundle-uri.h"
+#include "transport/bundle-uri.h"
 #include "gettext.h"
 #include "strbuf.h"
 #include "string-list.h"
-#include "transport.h"
-#include "remote.h"
+#include "transport/transport.h"
+#include "transport/remote.h"
 
 enum input_mode {
 	KEY_VALUE_PAIRS,
diff --git a/t/helper/test-pkt-line.c b/t/helper/test-pkt-line.c
index 4daa82f00f..2ddc243472 100644
--- a/t/helper/test-pkt-line.c
+++ b/t/helper/test-pkt-line.c
@@ -1,7 +1,7 @@
 #include "git-compat-util.h"
 #include "test-tool.h"
-#include "pkt-line.h"
-#include "sideband.h"
+#include "transport/pkt-line.h"
+#include "transport/sideband.h"
 #include "write-or-die.h"
 #include "parse-options.h"
 
diff --git a/t/helper/test-proc-receive.c b/t/helper/test-proc-receive.c
index 8eccc34216..01576400b8 100644
--- a/t/helper/test-proc-receive.c
+++ b/t/helper/test-proc-receive.c
@@ -1,8 +1,8 @@
 #include "test-tool.h"
-#include "connect.h"
+#include "transport/connect.h"
 #include "hex.h"
 #include "parse-options.h"
-#include "pkt-line.h"
+#include "transport/pkt-line.h"
 #include "sigchain.h"
 #include "string-list.h"
 
diff --git a/t/helper/test-rot13-filter.c b/t/helper/test-rot13-filter.c
index ad37e10034..40da1eac59 100644
--- a/t/helper/test-rot13-filter.c
+++ b/t/helper/test-rot13-filter.c
@@ -37,7 +37,7 @@
  */
 
 #include "test-tool.h"
-#include "pkt-line.h"
+#include "transport/pkt-line.h"
 #include "string-list.h"
 #include "strmap.h"
 #include "parse-options.h"
diff --git a/t/helper/test-serve-v2.c b/t/helper/test-serve-v2.c
index 13452d4eab..56754c27d3 100644
--- a/t/helper/test-serve-v2.c
+++ b/t/helper/test-serve-v2.c
@@ -4,7 +4,7 @@
 #include "gettext.h"
 #include "parse-options.h"
 #include "setup/repository.h"
-#include "serve.h"
+#include "transport/serve.h"
 #include "setup/setup.h"
 
 static char const * const serve_usage[] = {
diff --git a/t/helper/test-submodule.c b/t/helper/test-submodule.c
index 7a82e1f0f9..2290808d5c 100644
--- a/t/helper/test-submodule.c
+++ b/t/helper/test-submodule.c
@@ -3,7 +3,7 @@
 #include "test-tool.h"
 #include "test-tool-utils.h"
 #include "parse-options.h"
-#include "remote.h"
+#include "transport/remote.h"
 #include "setup/repository.h"
 #include "setup/setup.h"
 #include "strbuf.h"
diff --git a/bundle-uri.c b/transport/bundle-uri.c
similarity index 99%
rename from bundle-uri.c
rename to transport/bundle-uri.c
index cd26d38249..e2466e27a2 100644
--- a/bundle-uri.c
+++ b/transport/bundle-uri.c
@@ -2,17 +2,17 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
-#include "bundle-uri.h"
-#include "bundle.h"
+#include "transport/bundle-uri.h"
+#include "transport/bundle.h"
 #include "copy.h"
 #include "gettext.h"
 #include "refs/refs.h"
 #include "run-command.h"
 #include "hashmap.h"
-#include "pkt-line.h"
+#include "transport/pkt-line.h"
 #include "setup/config.h"
-#include "fetch-pack.h"
-#include "remote.h"
+#include "transport/fetch-pack.h"
+#include "transport/remote.h"
 #include "trace2.h"
 #include "odb/odb.h"
 
diff --git a/bundle-uri.h b/transport/bundle-uri.h
similarity index 100%
rename from bundle-uri.h
rename to transport/bundle-uri.h
diff --git a/bundle.c b/transport/bundle.c
similarity index 99%
rename from bundle.c
rename to transport/bundle.c
index 1e01ab38d4..6a272e9390 100644
--- a/bundle.c
+++ b/transport/bundle.c
@@ -3,7 +3,7 @@
 
 #include "git-compat-util.h"
 #include "lockfile.h"
-#include "bundle.h"
+#include "transport/bundle.h"
 #include "setup/environment.h"
 #include "gettext.h"
 #include "hex.h"
@@ -18,7 +18,7 @@
 #include "refs/refs.h"
 #include "strvec.h"
 #include "revision/list-objects-filter-options.h"
-#include "connected.h"
+#include "transport/connected.h"
 #include "write-or-die.h"
 
 static const char v2_bundle_signature[] = "# v2 git bundle\n";
diff --git a/bundle.h b/transport/bundle.h
similarity index 100%
rename from bundle.h
rename to transport/bundle.h
diff --git a/connect.c b/transport/connect.c
similarity index 99%
rename from connect.c
rename to transport/connect.c
index 2a1b177490..e11fc530f6 100644
--- a/connect.c
+++ b/transport/connect.c
@@ -5,24 +5,24 @@
 #include "setup/environment.h"
 #include "gettext.h"
 #include "hex.h"
-#include "pkt-line.h"
+#include "transport/pkt-line.h"
 #include "quote.h"
 #include "refs/refs.h"
 #include "run-command.h"
-#include "remote.h"
-#include "connect.h"
+#include "transport/remote.h"
+#include "transport/connect.h"
 #include "url.h"
 #include "string-list.h"
 #include "odb/oid-array.h"
 #include "path.h"
-#include "transport.h"
+#include "transport/transport.h"
 #include "trace2.h"
 #include "strbuf.h"
 #include "setup/version.h"
-#include "protocol.h"
+#include "transport/protocol.h"
 #include "setup/alias.h"
-#include "bundle-uri.h"
-#include "promisor-remote.h"
+#include "transport/bundle-uri.h"
+#include "transport/promisor-remote.h"
 
 static char *server_capabilities_v1;
 static struct strvec server_capabilities_v2 = STRVEC_INIT;
diff --git a/connect.h b/transport/connect.h
similarity index 98%
rename from connect.h
rename to transport/connect.h
index 957e5fe2b9..97828112d7 100644
--- a/connect.h
+++ b/transport/connect.h
@@ -1,7 +1,7 @@
 #ifndef CONNECT_H
 #define CONNECT_H
 
-#include "protocol.h"
+#include "transport/protocol.h"
 
 #define CONNECT_VERBOSE       (1u << 0)
 #define CONNECT_DIAG_URL      (1u << 1)
diff --git a/connected.c b/transport/connected.c
similarity index 98%
rename from connected.c
rename to transport/connected.c
index 1884614b80..c5b8edda1e 100644
--- a/connected.c
+++ b/transport/connected.c
@@ -6,10 +6,10 @@
 #include "odb/odb.h"
 #include "run-command.h"
 #include "sigchain.h"
-#include "connected.h"
-#include "transport.h"
+#include "transport/connected.h"
+#include "transport/transport.h"
 #include "pack/packfile.h"
-#include "promisor-remote.h"
+#include "transport/promisor-remote.h"
 
 static int promised_object_cb(const struct object_id *oid UNUSED,
 			      struct object_info *oi UNUSED,
diff --git a/connected.h b/transport/connected.h
similarity index 100%
rename from connected.h
rename to transport/connected.h
diff --git a/fetch-negotiator.c b/transport/fetch-negotiator.c
similarity index 94%
rename from fetch-negotiator.c
rename to transport/fetch-negotiator.c
index 90fee42b50..19670d0c2c 100644
--- a/fetch-negotiator.c
+++ b/transport/fetch-negotiator.c
@@ -1,5 +1,5 @@
 #include "git-compat-util.h"
-#include "fetch-negotiator.h"
+#include "transport/fetch-negotiator.h"
 #include "negotiator/default.h"
 #include "negotiator/skipping.h"
 #include "negotiator/noop.h"
diff --git a/fetch-negotiator.h b/transport/fetch-negotiator.h
similarity index 100%
rename from fetch-negotiator.h
rename to transport/fetch-negotiator.h
diff --git a/fetch-object-info.c b/transport/fetch-object-info.c
similarity index 97%
rename from fetch-object-info.c
rename to transport/fetch-object-info.c
index 30cf131aed..d834731c91 100644
--- a/fetch-object-info.c
+++ b/transport/fetch-object-info.c
@@ -1,11 +1,11 @@
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "hex.h"
-#include "pkt-line.h"
-#include "connect.h"
+#include "transport/pkt-line.h"
+#include "transport/connect.h"
 #include "odb/oid-array.h"
 #include "odb/odb.h"
-#include "fetch-object-info.h"
+#include "transport/fetch-object-info.h"
 #include "string-list.h"
 
 /* Sends object-info command and its arguments into the request buffer. */
diff --git a/fetch-object-info.h b/transport/fetch-object-info.h
similarity index 91%
rename from fetch-object-info.h
rename to transport/fetch-object-info.h
index 269cebb3f7..12ae9dc3b5 100644
--- a/fetch-object-info.h
+++ b/transport/fetch-object-info.h
@@ -1,8 +1,8 @@
 #ifndef FETCH_OBJECT_INFO_H
 #define FETCH_OBJECT_INFO_H
 
-#include "pkt-line.h"
-#include "protocol.h"
+#include "transport/pkt-line.h"
+#include "transport/protocol.h"
 
 struct object_info_args {
 	struct string_list *object_info_options;
diff --git a/fetch-pack.c b/transport/fetch-pack.c
similarity index 99%
rename from fetch-pack.c
rename to transport/fetch-pack.c
index 5bc72eb370..953de0a964 100644
--- a/fetch-pack.c
+++ b/transport/fetch-pack.c
@@ -10,15 +10,15 @@
 #include "hex.h"
 #include "lockfile.h"
 #include "refs/refs.h"
-#include "pkt-line.h"
+#include "transport/pkt-line.h"
 #include "odb/commit.h"
 #include "odb/tag.h"
 #include "pack/pack.h"
-#include "sideband.h"
-#include "fetch-pack.h"
-#include "remote.h"
+#include "transport/sideband.h"
+#include "transport/fetch-pack.h"
+#include "transport/remote.h"
 #include "run-command.h"
-#include "connect.h"
+#include "transport/connect.h"
 #include "trace2.h"
 #include "setup/version.h"
 #include "odb/oid-array.h"
@@ -27,8 +27,8 @@
 #include "odb/odb.h"
 #include "odb/object-name.h"
 #include "path.h"
-#include "connected.h"
-#include "fetch-negotiator.h"
+#include "transport/connected.h"
+#include "transport/fetch-negotiator.h"
 #include "odb/fsck.h"
 #include "revision/shallow.h"
 #include "revision/commit-reach.h"
@@ -36,7 +36,7 @@
 #include "sigchain.h"
 #include "mergesort.h"
 #include "prio-queue.h"
-#include "promisor-remote.h"
+#include "transport/promisor-remote.h"
 
 static int transfer_unpack_limit = -1;
 static int fetch_unpack_limit = -1;
diff --git a/fetch-pack.h b/transport/fetch-pack.h
similarity index 99%
rename from fetch-pack.h
rename to transport/fetch-pack.h
index 42922616be..be5c5f2143 100644
--- a/fetch-pack.h
+++ b/transport/fetch-pack.h
@@ -2,7 +2,7 @@
 #define FETCH_PACK_H
 
 #include "string-list.h"
-#include "protocol.h"
+#include "transport/protocol.h"
 #include "revision/list-objects-filter-options.h"
 #include "odb/oidset.h"
 
diff --git a/git-curl-compat.h b/transport/git-curl-compat.h
similarity index 100%
rename from git-curl-compat.h
rename to transport/git-curl-compat.h
diff --git a/http-walker.c b/transport/http-walker.c
similarity index 99%
rename from http-walker.c
rename to transport/http-walker.c
index b5bba74da4..e0f8eb7162 100644
--- a/http-walker.c
+++ b/transport/http-walker.c
@@ -4,10 +4,10 @@
 #include "git-compat-util.h"
 #include "setup/repository.h"
 #include "hex.h"
-#include "walker.h"
-#include "http.h"
+#include "transport/walker.h"
+#include "transport/http.h"
 #include "revision/list.h"
-#include "transport.h"
+#include "transport/transport.h"
 #include "pack/packfile.h"
 #include "odb/object-file.h"
 #include "odb/odb.h"
diff --git a/http.c b/transport/http.c
similarity index 99%
rename from http.c
rename to transport/http.c
index 5b3b2b24d6..bb92754a80 100644
--- a/http.c
+++ b/transport/http.c
@@ -2,10 +2,10 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
-#include "git-curl-compat.h"
+#include "transport/git-curl-compat.h"
 #include "setup/environment.h"
 #include "hex.h"
-#include "http.h"
+#include "transport/http.h"
 #include "setup/config.h"
 #include "pack/pack.h"
 #include "run-command.h"
@@ -13,10 +13,10 @@
 #include "urlmatch.h"
 #include "credential.h"
 #include "setup/version.h"
-#include "pkt-line.h"
+#include "transport/pkt-line.h"
 #include "gettext.h"
 #include "trace.h"
-#include "transport.h"
+#include "transport/transport.h"
 #include "pack/packfile.h"
 #include "string-list.h"
 #include "odb/object-file.h"
diff --git a/http.h b/transport/http.h
similarity index 99%
rename from http.h
rename to transport/http.h
index 729c51904d..fab359450f 100644
--- a/http.h
+++ b/transport/http.h
@@ -11,7 +11,7 @@ struct packfile_list;
 
 #include "gettext.h"
 #include "strbuf.h"
-#include "remote.h"
+#include "transport/remote.h"
 
 #define DEFAULT_MAX_REQUESTS 5
 
diff --git a/pkt-line.c b/transport/pkt-line.c
similarity index 99%
rename from pkt-line.c
rename to transport/pkt-line.c
index 3fc3e9ea70..d8b341b75e 100644
--- a/pkt-line.c
+++ b/transport/pkt-line.c
@@ -1,10 +1,10 @@
 #include "git-compat-util.h"
 #include "copy.h"
-#include "pkt-line.h"
+#include "transport/pkt-line.h"
 #include "gettext.h"
 #include "hex.h"
 #include "run-command.h"
-#include "sideband.h"
+#include "transport/sideband.h"
 #include "trace.h"
 #include "write-or-die.h"
 
diff --git a/pkt-line.h b/transport/pkt-line.h
similarity index 100%
rename from pkt-line.h
rename to transport/pkt-line.h
diff --git a/promisor-remote.c b/transport/promisor-remote.c
similarity index 99%
rename from promisor-remote.c
rename to transport/promisor-remote.c
index 80caaeca99..e32b6d4e30 100644
--- a/promisor-remote.c
+++ b/transport/promisor-remote.c
@@ -4,10 +4,10 @@
 #include "gettext.h"
 #include "hex.h"
 #include "odb/odb.h"
-#include "promisor-remote.h"
+#include "transport/promisor-remote.h"
 #include "setup/config.h"
 #include "trace2.h"
-#include "transport.h"
+#include "transport/transport.h"
 #include "strvec.h"
 #include "pack/packfile.h"
 #include "setup/environment.h"
diff --git a/promisor-remote.h b/transport/promisor-remote.h
similarity index 100%
rename from promisor-remote.h
rename to transport/promisor-remote.h
diff --git a/protocol-caps.c b/transport/protocol-caps.c
similarity index 98%
rename from protocol-caps.c
rename to transport/protocol-caps.c
index ffda7e11dd..6217bebc27 100644
--- a/protocol-caps.c
+++ b/transport/protocol-caps.c
@@ -1,8 +1,8 @@
 #include "git-compat-util.h"
-#include "protocol-caps.h"
+#include "transport/protocol-caps.h"
 #include "gettext.h"
 #include "hex.h"
-#include "pkt-line.h"
+#include "transport/pkt-line.h"
 #include "odb/hash.h"
 #include "odb/object.h"
 #include "odb/odb.h"
diff --git a/protocol-caps.h b/transport/protocol-caps.h
similarity index 100%
rename from protocol-caps.h
rename to transport/protocol-caps.h
diff --git a/protocol.c b/transport/protocol.c
similarity index 98%
rename from protocol.c
rename to transport/protocol.c
index 7f19dbc04d..33051e8a08 100644
--- a/protocol.c
+++ b/transport/protocol.c
@@ -3,7 +3,7 @@
 #include "git-compat-util.h"
 #include "setup/config.h"
 #include "setup/environment.h"
-#include "protocol.h"
+#include "transport/protocol.h"
 #include "trace2.h"
 
 static enum protocol_version parse_protocol_version(const char *value)
diff --git a/protocol.h b/transport/protocol.h
similarity index 100%
rename from protocol.h
rename to transport/protocol.h
diff --git a/remote-curl.c b/transport/remote-curl.c
similarity index 99%
rename from remote-curl.c
rename to transport/remote-curl.c
index d0aa42c974..f643515c56 100644
--- a/remote-curl.c
+++ b/transport/remote-curl.c
@@ -2,28 +2,28 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
-#include "git-curl-compat.h"
+#include "transport/git-curl-compat.h"
 #include "setup/config.h"
 #include "setup/environment.h"
 #include "gettext.h"
 #include "hex.h"
-#include "remote.h"
-#include "connect.h"
+#include "transport/remote.h"
+#include "transport/connect.h"
 #include "strbuf.h"
-#include "walker.h"
-#include "http.h"
+#include "transport/walker.h"
+#include "transport/http.h"
 #include "run-command.h"
-#include "pkt-line.h"
+#include "transport/pkt-line.h"
 #include "string-list.h"
 #include "strvec.h"
 #include "credential.h"
 #include "odb/oid-array.h"
-#include "send-pack.h"
+#include "transport/send-pack.h"
 #include "setup/setup.h"
-#include "protocol.h"
+#include "transport/protocol.h"
 #include "quote.h"
 #include "trace2.h"
-#include "transport.h"
+#include "transport/transport.h"
 #include "url.h"
 #include "write-or-die.h"
 
diff --git a/remote.c b/transport/remote.c
similarity index 99%
rename from remote.c
rename to transport/remote.c
index ae77c5b1db..fe7962799d 100644
--- a/remote.c
+++ b/transport/remote.c
@@ -7,7 +7,7 @@
 #include "setup/environment.h"
 #include "gettext.h"
 #include "hex.h"
-#include "remote.h"
+#include "transport/remote.h"
 #include "url.h"
 #include "urlmatch.h"
 #include "refs/refs.h"
@@ -24,9 +24,9 @@
 #include "strvec.h"
 #include "revision/commit-reach.h"
 #include "advice.h"
-#include "connect.h"
+#include "transport/connect.h"
 #include "parse-options.h"
-#include "transport.h"
+#include "transport/transport.h"
 
 enum map_direction { FROM_SRC, FROM_DST };
 
diff --git a/remote.h b/transport/remote.h
similarity index 100%
rename from remote.h
rename to transport/remote.h
diff --git a/send-pack.c b/transport/send-pack.c
similarity index 99%
rename from send-pack.c
rename to transport/send-pack.c
index 546835b0aa..77079501b8 100644
--- a/send-pack.c
+++ b/transport/send-pack.c
@@ -5,13 +5,13 @@
 #include "gettext.h"
 #include "hex.h"
 #include "odb/odb.h"
-#include "pkt-line.h"
-#include "sideband.h"
+#include "transport/pkt-line.h"
+#include "transport/sideband.h"
 #include "run-command.h"
-#include "remote.h"
-#include "connect.h"
-#include "send-pack.h"
-#include "transport.h"
+#include "transport/remote.h"
+#include "transport/connect.h"
+#include "transport/send-pack.h"
+#include "transport/transport.h"
 #include "setup/version.h"
 #include "odb/oid-array.h"
 #include "gpg-interface.h"
diff --git a/send-pack.h b/transport/send-pack.h
similarity index 100%
rename from send-pack.h
rename to transport/send-pack.h
diff --git a/serve.c b/transport/serve.c
similarity index 97%
rename from serve.c
rename to transport/serve.c
index 4408187c47..0f24d2f682 100644
--- a/serve.c
+++ b/transport/serve.c
@@ -2,15 +2,15 @@
 #include "setup/repository.h"
 #include "setup/config.h"
 #include "odb/hash.h"
-#include "pkt-line.h"
+#include "transport/pkt-line.h"
 #include "setup/version.h"
 #include "refs/ls-refs.h"
-#include "protocol-caps.h"
-#include "serve.h"
-#include "upload-pack.h"
-#include "bundle-uri.h"
+#include "transport/protocol-caps.h"
+#include "transport/serve.h"
+#include "transport/upload-pack.h"
+#include "transport/bundle-uri.h"
 #include "trace2.h"
-#include "promisor-remote.h"
+#include "transport/promisor-remote.h"
 
 static int advertise_sid = -1;
 static int advertise_object_info = -1;
diff --git a/serve.h b/transport/serve.h
similarity index 100%
rename from serve.h
rename to transport/serve.h
diff --git a/sideband.c b/transport/sideband.c
similarity index 99%
rename from sideband.c
rename to transport/sideband.c
index b915fdf114..cba8394b6a 100644
--- a/sideband.c
+++ b/transport/sideband.c
@@ -6,9 +6,9 @@
 #include "setup/config.h"
 #include "editor.h"
 #include "gettext.h"
-#include "sideband.h"
+#include "transport/sideband.h"
 #include "help.h"
-#include "pkt-line.h"
+#include "transport/pkt-line.h"
 #include "write-or-die.h"
 #include "urlmatch.h"
 
diff --git a/sideband.h b/transport/sideband.h
similarity index 100%
rename from sideband.h
rename to transport/sideband.h
diff --git a/transport-helper.c b/transport/transport-helper.c
similarity index 99%
rename from transport-helper.c
rename to transport/transport-helper.c
index 94d3d9ced8..63a9b80cff 100644
--- a/transport-helper.c
+++ b/transport/transport-helper.c
@@ -1,7 +1,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "git-compat-util.h"
-#include "transport.h"
+#include "transport/transport.h"
 #include "quote.h"
 #include "run-command.h"
 #include "odb/commit.h"
@@ -10,15 +10,15 @@
 #include "hex.h"
 #include "odb/object-name.h"
 #include "setup/repository.h"
-#include "remote.h"
+#include "transport/remote.h"
 #include "string-list.h"
 #include "thread-utils.h"
 #include "sigchain.h"
 #include "strvec.h"
 #include "refs/refs.h"
 #include "refs/refspec.h"
-#include "transport-internal.h"
-#include "protocol.h"
+#include "transport/transport-internal.h"
+#include "transport/protocol.h"
 #include "pack/packfile.h"
 
 static int debug;
diff --git a/transport-internal.h b/transport/transport-internal.h
similarity index 98%
rename from transport-internal.h
rename to transport/transport-internal.h
index 60db0bedcd..c3edf136b7 100644
--- a/transport-internal.h
+++ b/transport/transport-internal.h
@@ -1,7 +1,7 @@
 #ifndef TRANSPORT_INTERNAL_H
 #define TRANSPORT_INTERNAL_H
 
-#include "connect.h"
+#include "transport/connect.h"
 
 struct ref;
 struct transport;
diff --git a/transport.c b/transport/transport.c
similarity index 99%
rename from transport.c
rename to transport/transport.c
index 18429b78f5..dfeae250fd 100644
--- a/transport.c
+++ b/transport/transport.c
@@ -5,15 +5,15 @@
 #include "setup/config.h"
 #include "setup/environment.h"
 #include "hex.h"
-#include "transport.h"
+#include "transport/transport.h"
 #include "setup/hook.h"
-#include "pkt-line.h"
-#include "fetch-pack.h"
-#include "fetch-object-info.h"
-#include "remote.h"
-#include "connect.h"
-#include "send-pack.h"
-#include "bundle.h"
+#include "transport/pkt-line.h"
+#include "transport/fetch-pack.h"
+#include "transport/fetch-object-info.h"
+#include "transport/remote.h"
+#include "transport/connect.h"
+#include "transport/send-pack.h"
+#include "transport/bundle.h"
 #include "gettext.h"
 #include "refs/refs.h"
 #include "refs/refspec.h"
@@ -25,12 +25,12 @@
 #include "odb/oid-array.h"
 #include "sigchain.h"
 #include "trace2.h"
-#include "transport-internal.h"
-#include "protocol.h"
+#include "transport/transport-internal.h"
+#include "transport/protocol.h"
 #include "odb/object-name.h"
 #include "color.h"
-#include "bundle-uri.h"
-#include "sideband.h"
+#include "transport/bundle-uri.h"
+#include "transport/sideband.h"
 
 static enum git_colorbool transport_use_color = GIT_COLOR_UNKNOWN;
 static char transport_colors[][COLOR_MAXLEN] = {
diff --git a/transport.h b/transport/transport.h
similarity index 99%
rename from transport.h
rename to transport/transport.h
index 064f4192cf..af4f1fa0db 100644
--- a/transport.h
+++ b/transport/transport.h
@@ -2,10 +2,10 @@
 #define TRANSPORT_H
 
 #include "run-command.h"
-#include "remote.h"
+#include "transport/remote.h"
 #include "revision/list-objects-filter-options.h"
 #include "string-list.h"
-#include "connect.h"
+#include "transport/connect.h"
 
 struct git_transport_options {
 	unsigned thin : 1;
diff --git a/upload-pack.c b/transport/upload-pack.c
similarity index 99%
rename from upload-pack.c
rename to transport/upload-pack.c
index 23c0357496..73edc8bb28 100644
--- a/upload-pack.c
+++ b/transport/upload-pack.c
@@ -7,8 +7,8 @@
 #include "gettext.h"
 #include "hex.h"
 #include "refs/refs.h"
-#include "pkt-line.h"
-#include "sideband.h"
+#include "transport/pkt-line.h"
+#include "transport/sideband.h"
 #include "setup/repository.h"
 #include "odb/odb.h"
 #include "odb/oid-array.h"
@@ -18,14 +18,14 @@
 #include "revision/revision.h"
 #include "revision/list-objects-filter-options.h"
 #include "run-command.h"
-#include "connect.h"
+#include "transport/connect.h"
 #include "sigchain.h"
 #include "setup/version.h"
 #include "string-list.h"
 #include "strvec.h"
 #include "trace2.h"
-#include "protocol.h"
-#include "upload-pack.h"
+#include "transport/protocol.h"
+#include "transport/upload-pack.h"
 #include "pack/commit-graph.h"
 #include "revision/commit-reach.h"
 #include "revision/shallow.h"
@@ -33,7 +33,7 @@
 #include "write-or-die.h"
 #include "json-writer.h"
 #include "strmap.h"
-#include "promisor-remote.h"
+#include "transport/promisor-remote.h"
 
 /* Remember to update object flag allocation in object.h */
 #define THEY_HAVE	(1u << 11)
diff --git a/upload-pack.h b/transport/upload-pack.h
similarity index 100%
rename from upload-pack.h
rename to transport/upload-pack.h
diff --git a/walker.c b/transport/walker.c
similarity index 99%
rename from walker.c
rename to transport/walker.c
index 079dcd378c..330b00a22c 100644
--- a/walker.c
+++ b/transport/walker.c
@@ -3,7 +3,7 @@
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "hex.h"
-#include "walker.h"
+#include "transport/walker.h"
 #include "setup/repository.h"
 #include "odb/odb.h"
 #include "odb/commit.h"
diff --git a/walker.h b/transport/walker.h
similarity index 97%
rename from walker.h
rename to transport/walker.h
index 25aaa3631c..3a1b822965 100644
--- a/walker.h
+++ b/transport/walker.h
@@ -1,7 +1,7 @@
 #ifndef WALKER_H
 #define WALKER_H
 
-#include "remote.h"
+#include "transport/remote.h"
 
 struct walker {
 	void *data;
-- 
2.54.0

