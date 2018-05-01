Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 932F2215F4
	for <e@80x24.org>; Tue,  1 May 2018 12:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755190AbeEAMH5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 08:07:57 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:36318 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755074AbeEAMHh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 08:07:37 -0400
Received: by mail-wr0-f180.google.com with SMTP id u18-v6so10640934wrg.3
        for <git@vger.kernel.org>; Tue, 01 May 2018 05:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ZzaTD37bNNzXtz6MH4XOgTCb+KtJdJcuYJKroCu4fSk=;
        b=OX30MR7QRMP+PiH7d9AQLIiaga9TIA9Y9W6fnqi8hM7M191w8w01PoVz2qBBF2dvAP
         ZP6/RDxv59PumzuDPojcKC1/XuUcctM2al6PdSFQ4+lFx7KutWlTxcXUWQOrqW/L+K7Q
         8B6nrULkf2n68OecgX3RxTCVgqtljinN0xQABVArNAENlovBxEZJFxOUFlfxojMd4LWb
         8LtcdOwiRx325LpBackW05pg1B9/zSnyT0gj70vwcFjmipofklUf1xxMOC4V/7Vk2gwa
         Y+bHwm3MB+KbRZVii/ZvWKJyzN8YtQC/DoKFsQUnKU7sLwyxzh5AaoHcsWrULpY3zGiW
         C/YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ZzaTD37bNNzXtz6MH4XOgTCb+KtJdJcuYJKroCu4fSk=;
        b=WbF9o3WEfQdxp9GFugcoCTX4OhyVlb9OtRK9VczFAnH6ReRtGXD2uvxc10H6I8BZsT
         zCbZLCcWl0YZx//gFXhEuT73MGZ1q0hoQ0K5N1cKzwBiKStFQURFkryruCeDJER+Hvtu
         p2QHTmRONKkkUx8B9j3qgjp2+i/VQCBGIsOwKzRFEMkhRypHKQjgzAPsdfXmCvwBUO6x
         PKdV9g4Nnygzxx/Hpr2DdIn3VNmbw6Vdv3v9njSv3fmHxRx0QdIvMNfBgnjX7iIWiFt1
         zaimQg/2X9OdLyCrTwz+hFIUOVrMRXatw1Gwyd5WiSsaUO/9uUnJdnVTPpfV+JLlhFlD
         40/g==
X-Gm-Message-State: ALQs6tD4YnFYtB0jFZ3yAZ+ZCz1eEaeYxga/gktrMK9JsbBnOEa7S27j
        EOrauua7UEYBHJnm6z/kegOUHt4G
X-Google-Smtp-Source: AB8JxZqUawMfH96LiV+qTD/VzmagaGnBWA/uKZX/JXzfCM236JaByFQzd7Vi/o9h3F7q5UqXTxi/qg==
X-Received: by 2002:adf:a0ea:: with SMTP id n39-v6mr11634662wrn.87.1525176455924;
        Tue, 01 May 2018 05:07:35 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id m134sm11738710wmg.4.2018.05.01.05.07.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 05:07:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 08/12] get_short_oid: learn to disambiguate by ^{blob}
Date:   Tue,  1 May 2018 12:06:47 +0000
Message-Id: <20180501120651.15886-9-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180501120651.15886-1-avarab@gmail.com>
References: <20180501120651.15886-1-avarab@gmail.com>
In-Reply-To: <20180430220734.30133-1-avarab@gmail.com>
References: <20180430220734.30133-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The disambiguation logic had all the pieces necessary to only print
out those blobs that were ambiguous, but they hadn't been connected.

The initial logic was added in daba53aeaf ("sha1_name.c: add support
for disambiguating other types", 2012-07-02), and when the flags were
propagated in 8a10fea49b ("get_sha1: propagate flags to child
functions", 2016-09-26) GET_OID_BLOB wasn't added to lookup_flags.

Before this change requests for blobs were simply ignored:

    $ git rev-parse e8f2^{blob}
    error: short SHA1 e8f2 is ambiguous
    hint: The candidates are:
    hint:   e8f2650052 tag v2.17.0
    hint:   e8f21caf94 commit 2013-06-24 - bash prompt: print unique detached HEAD abbreviated object name
    hint:   e8f26250fa commit 2017-02-03 - Merge pull request #996 from jeffhostetler/jeffhostetler/register_rename_src
    hint:   e8f2bc0c06 commit 2015-05-10 - Documentation: note behavior for multiple remote.url entries
    hint:   e8f2093055 tree
    hint:   e8f25a3a50 tree
    hint:   e8f28d537c tree
    hint:   e8f2cf6ec0 tree
    hint:   e8f21d02f7 blob
    hint:   e8f21d577c blob
    hint:   e8f2867228 blob
    hint:   e8f2a35526 blob
    e8f2^{blob}
    [...]

But now we'll do the right thing and only print the blobs:

    $ git rev-parse e8f2^{blob}
    error: short SHA1 e8f2 is ambiguous
    hint: The candidates are:
    hint:   e8f21d02f7 blob
    hint:   e8f21d577c blob
    hint:   e8f2867228 blob
    hint:   e8f2a35526 blob
    e8f2^{blob}
    [...]

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 sha1-name.c                         | 2 ++
 t/t1512-rev-parse-disambiguation.sh | 6 +++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/sha1-name.c b/sha1-name.c
index 68d5f65362..023f9471a8 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -971,6 +971,8 @@ static int peel_onion(const char *name, int len, struct object_id *oid,
 		lookup_flags |= GET_OID_TAG;
 	else if (expected_type == OBJ_TREE)
 		lookup_flags |= GET_OID_TREEISH;
+	else if (expected_type == OBJ_BLOB)
+		lookup_flags |= GET_OID_BLOB;
 
 	if (get_oid_1(name, sp - name - 2, &outer, lookup_flags))
 		return -1;
diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-disambiguation.sh
index 74e7d9c178..9ce9cc3bc3 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -337,7 +337,11 @@ test_expect_success C_LOCALE_OUTPUT 'ambiguity hints respect type' '
 	test_line_count = 7 hints &&
 	git rev-parse 000000000^{tag} >stdout &&
 	test_line_count = 1 stdout &&
-	grep -q ^0000000000f8f stdout
+	grep -q ^0000000000f8f stdout &&
+	test_must_fail git rev-parse 000000000^{blob} 2>stderr &&
+	grep ^hint: stderr >hints &&
+	# 5 blobs plus intro line &&
+	test_line_count = 6 hints
 '
 
 test_expect_success C_LOCALE_OUTPUT 'failed type-selector still shows hint' '
-- 
2.17.0.290.gded63e768a

