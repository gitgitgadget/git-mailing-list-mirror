Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CDEA201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 14:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932605AbdBVOFc (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 09:05:32 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35994 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932342AbdBVOFa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 09:05:30 -0500
Received: by mail-pg0-f68.google.com with SMTP id z128so534999pgb.3
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 06:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LC8mFPKlvq4p9oBp8jLXd3sRXD3gP8xog1YlmA0qN58=;
        b=WFeuvFO0Qia3+MDyLeSWqPQ4r9r94JyGlP4a3x/LTrJvSB4skFzKGXDNvZwnhNYMHg
         o8E4AfibmsNtP4JBAsV0DkojvoTYNLnzdQP6f8ZMx+1NiAHQh//j97/LAUHn8CVrAy3e
         Fn6kw45/4IPpYsTuBR7eXDTbrbbNWoxNTajMmA+naAd9yE9EZA4UrV0vPjp4BikM4gx3
         6lAh0G4bdQPYhqg/6CvpQRFrv96H45JQ4BJmDdXovh/ppZzvfaFvQ2Q8QVLC2oCMXh5J
         7DtZK+uUBZwk58n6ueSsYZwzmukXFw6UJalTTZFDJ3VMbKtACSxXSu5j/d+HF2EWiOL/
         EOTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LC8mFPKlvq4p9oBp8jLXd3sRXD3gP8xog1YlmA0qN58=;
        b=g+8SYr8G4YT/2jxXfnOZz+B9v4kBrE+C/w5rEOTpzd2rQ5DMwM37O/tI+8jJycPk+I
         Ih5UJVpxME99qVQ/wr6YMHrv5DYA7V+yhJi3S0rBjfdItkZGa7WBduuJss6iqkmoLZGv
         +Fq4MzwOTjVRUQEArXW9kStlk0f8O+lC5B0fWxO5NDPevWxnNk30i9qu8ZL/9rZXfbS+
         2DEgWyYtZF+BSQ+UbeotL+rE3d8ECZzZChWaOuxO5UfKjdhznS8WaS9AWNEeNsA0XABj
         IFntTBHTr6b/NLH+pjqtuQedhsbZbRThVkGKDeqXwoIP4V9R6BQyi9PEvigYRmge1Plr
         cvXw==
X-Gm-Message-State: AMke39lMyU61QO9AHzYsgrECN7sSlvB9TUzQC1AB2N0y/v4OLXPguya+WWeKjk8nXbNaLQ==
X-Received: by 10.98.4.71 with SMTP id 68mr20625170pfe.92.1487772329626;
        Wed, 22 Feb 2017 06:05:29 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id 17sm4098826pfi.40.2017.02.22.06.05.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Feb 2017 06:05:28 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 22 Feb 2017 21:05:21 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v5 00/24] Remove submodule from files-backend.c
Date:   Wed, 22 Feb 2017 21:04:26 +0700
Message-Id: <20170222140450.30886-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170218133303.3682-1-pclouds@gmail.com>
References: <20170218133303.3682-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v5 goes a bit longer than v4, basically:

 - files_path() is broken down into three smaller functions,
   files_{packed_refs,reflog,refname}_path().

 - most of store-based api is added because..

 - test-ref-store.c is added with t1405 and t1406 for some basic tests
   I'm not aimimg for complete ref store coverage. But we can continue
   to improve from there.

 - refs_store_init() now takes a "permission" flag, like open().
   Operations are allowed or forbidden based on this flag. The
   submodule_allowed flag is killed. files_assert_main.. remains.

 - get_*_ref_store() remain public api because it's used by
   test-ref-store.c and pack-refs.c.

 - files-backend.c should now make no function calls that implicitly
   target the main store. But this will have to be tested more to be
   sure. I'm tempted to add a tracing backend just for this purpose.

Junio, if you take this on 'pu', you'll have to kick my other two
series out (they should not even compile). I'm not resending them
until I get a "looks mostly ok" from Michael. No point in updating
them when this series keeps moving.

This series is also available on my github repo. branch
files-backend-git-dir-2.

Nguyễn Thái Ngọc Duy (24):
  refs.h: add forward declaration for structs used in this file
  files-backend: make files_log_ref_write() static
  files-backend: add and use files_packed_refs_path()
  files-backend: convert git_path() to strbuf_git_path()
  files-backend: move "logs/" out of TMP_RENAMED_LOG
  files-backend: add and use files_reflog_path()
  files-backend: add and use files_refname_path()
  files-backend: remove the use of git_path()
  refs.c: introduce get_main_ref_store()
  refs: rename lookup_ref_store() to lookup_submodule_ref_store()
  refs.c: flatten get_ref_store() a bit
  refs.c: kill register_ref_store(), add register_submodule_ref_store()
  refs.c: make get_main_ref_store() public and use it
  path.c: move some code out of strbuf_git_path_submodule()
  refs: move submodule code out of files-backend.c
  files-backend: replace submodule_allowed check in files_downcast()
  refs: rename get_ref_store() to get_submodule_ref_store() and make it public
  refs: add new ref-store api
  refs: new transaction related ref-store api
  files-backend: avoid ref api targetting main ref store
  refs: delete pack_refs() in favor of refs_pack_refs()
  t/helper: add test-ref-store to test ref-store functions
  t1405: some basic tests on main ref store
  t1406: new tests for submodule ref store

 Makefile                                |   1 +
 builtin/pack-refs.c                     |   2 +-
 path.c                                  |  34 +--
 refs.c                                  | 411 ++++++++++++++++++--------
 refs.h                                  | 100 ++++++-
 refs/files-backend.c                    | 509 +++++++++++++++++++++-----------
 refs/refs-internal.h                    |  64 +---
 submodule.c                             |  31 ++
 submodule.h                             |   1 +
 t/helper/.gitignore                     |   1 +
 t/helper/test-ref-store.c (new)         | 274 +++++++++++++++++
 t/t1405-main-ref-store.sh (new +x)      | 123 ++++++++
 t/t1406-submodule-ref-store.sh (new +x) |  95 ++++++
 13 files changed, 1269 insertions(+), 377 deletions(-)
 create mode 100644 t/helper/test-ref-store.c
 create mode 100755 t/t1405-main-ref-store.sh
 create mode 100755 t/t1406-submodule-ref-store.sh

-- 
2.11.0.157.gd943d85

