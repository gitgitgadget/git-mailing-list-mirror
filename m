Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4D761F404
	for <e@80x24.org>; Tue, 28 Aug 2018 19:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbeH1Xbs (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 19:31:48 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41749 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727098AbeH1Xbs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 19:31:48 -0400
Received: by mail-wr1-f67.google.com with SMTP id z96-v6so2622228wrb.8
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 12:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3J7vuojJlddd2Ez1A0L+sZspAMHaOeMQYhPzH9Ioue8=;
        b=sMHqj0yc1wTqiAC1456i6QGHxE2avZxbZ9EG2ScUh6kdqKU1YhgtqwzNvr029wQeu/
         nAeBREi3Vz69n/03nTpwRNmvsLc2eIObupvMJt+ESNpirhmInh7cXMji20juRUoTlK2v
         ZfEUhisUtH+XlYQVLslH55ppkkEF80GpTXzr0DyOWoeHfBVHr5z4/Z9v3xqzCC7Ef8n3
         medtNX4WEVjoGzcy+TlZ1/cOPJdJPSx5b9SWoAcwWrAnQCE3ZHxmVEtfX+bLmgAbFjw5
         LuqkDqrTsignWJ9jj5izLQ3NhK2KIUAYEOPQ2w0/ByUWkVT5Rp3yocxchPwEwK7vj3Xq
         nfKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3J7vuojJlddd2Ez1A0L+sZspAMHaOeMQYhPzH9Ioue8=;
        b=Mj4J51I6/Qg9ASv6n2KqkukNZx2NdZqMuE0Jb1GE4e/NJzYGtMl9qqg4gHdRTHGQzL
         Mrg1xmMbw1ssDnmh5VJtz0nduShB4rsDAmUca8ofZA6lV+LaIeiMC3fWzP8OOzKOh6sd
         ghP6loVnCWeWBLlDNffqzj9vmF51xY9BooRN1Wg+Q6Yk30p5Mt1ro7HaIvNwmER2wYb+
         qNWyXbBBGPDX62C4Sk83rCEvF5RmKI1FUqEoPy2lOHkeqkoSC0XFZeJaphu6VyMgQQEg
         FPSn90k8JF3RzMXEa7DVhlN3k++VDHYlF2f21TCT62TD0MBVO6CZPOuYymIGbZ4HrP7C
         M3/w==
X-Gm-Message-State: APzg51D2oxOjFjZz+ZZ7hBb10W0ggUQYxwAp8inDybf/S+O7w1jSxRFM
        dexutPzkrMWS5n7i0G/DsdhlecnWNPA=
X-Google-Smtp-Source: ANB0Vdb80tVLdC5xH2r4lE5pU7CMQ5xWDPRkGY6QNrErcLd4/B/EO5J/Bdznk3XeWLM+XZbSV/73Aw==
X-Received: by 2002:adf:8445:: with SMTP id 63-v6mr2108382wrf.41.1535485119201;
        Tue, 28 Aug 2018 12:38:39 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 139-v6sm3436938wmp.4.2018.08.28.12.38.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 12:38:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Ann T Ropea <bedhanger@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] tests: fix non-portable "${var:-"str"}" construct
Date:   Tue, 28 Aug 2018 19:38:26 +0000
Message-Id: <20180828193827.8648-2-avarab@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0
In-Reply-To: <20180828193827.8648-1-avarab@gmail.com>
References: <20180828193827.8648-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On both AIX 7200-00-01-1543 and FreeBSD 11.2-RELEASE-p2 the
"${var:-"str"}" syntax means something different than what it does
under the bash or dash shells.

Both will consider the start of the new unescaped quotes to be a new
argument to test_expect_success, resulting in the following error:

    error: bug in the test script: 'git diff-tree initial # magic
    is (not' does not look like a prereq

Fix this by removing the redundant quotes. There's no need for them,
and the resulting code works under all the aforementioned shells. This
fixes a regression in c2f1d3989 ("t4013: test new output from diff
--abbrev --raw", 2017-12-03) first released with Git v2.16.0.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4013-diff-various.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index f8d853595b..73f7038253 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -140,7 +140,7 @@ do
 	expect="$TEST_DIRECTORY/t4013/diff.$test"
 	actual="$pfx-diff.$test"
 
-	test_expect_success "git $cmd # magic is ${magic:-"(not used)"}" '
+	test_expect_success "git $cmd # magic is ${magic:-(not used)}" '
 		{
 			echo "$ git $cmd"
 			case "$magic" in
-- 
2.19.0.rc0.228.g281dcd1b4d0

