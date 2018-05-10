Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDC6C1F406
	for <e@80x24.org>; Thu, 10 May 2018 19:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751981AbeEJTaW (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 15:30:22 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34230 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751948AbeEJTaV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 15:30:21 -0400
Received: by mail-wm0-f66.google.com with SMTP id a137-v6so187166wme.1
        for <git@vger.kernel.org>; Thu, 10 May 2018 12:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6NcwI8ZJ9XUc1SVB/wxFu1RpsiVRW87laXcQ3288q8I=;
        b=dVT7SATtMT5gOiIDmbGf43nSDsjRviADEb9YhXoi1p4aRQNL4CFIOYT4etypbpI1d3
         cws0b3DyELFZuGZgCLG6D11zll6fKfmfhSDA37kpPhkCjtxsp159dZpReJ42pIHi5yXp
         Ok8leCn/R3ucbinXp7fiuvlYV4/wcNMrhXcHoT0EDbceKL+6o56RaXm/ursb3cquSk84
         6Gk8A7YlnV1HwXmiVbQtpYrg+UCO2LRYcnX8L9bzkCfD8c1Wc09qJg+QplRXW4JMEWq1
         HkU+3uZ+kxwT+wHUfBz4Ly5WvRODThkjgCFZswmMPuFokwSrAFyZ53IRHhA2B6rrzfVe
         zUoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6NcwI8ZJ9XUc1SVB/wxFu1RpsiVRW87laXcQ3288q8I=;
        b=Cr0lGOc5M9hsJnDDyPXeGVM1U2nnS8cO7Gi5bkN4CiMSjteYFyAHX2ECbBShqKrqWu
         90ulezz+Zh2lAClS5YNBt9YlyaEzptKRJ4ikaJqD6muOSvWFptdcQ5oUHJn6euMLadR0
         xmpVo9j82i64yNV/dkMOow0LhSyGw+ZHE+q2oQ1oXrjdgrIyEaG3gVSOeMGQItdRoeFw
         Ysj9elHyasCTOqrQID3lWUnjnQSs5Q3voYbsCxHvXqoVTALxTX81K4rUQt8XwdV2Spir
         JURmffFohJwtX3jTLqMzyEN/MvKvG8mvejvLGF07VAsbQoc9zkjGKzd14IVVM97CuZB+
         4b4w==
X-Gm-Message-State: ALKqPwdU8MHl7fE9OipzATci+xK6I0TmOSyg5BkVRph8FQhwSBtVVZmK
        u2Do4kQL6i/M3dUmy53ecReBtoXlhA4=
X-Google-Smtp-Source: AB8JxZoNeVzgf9Ffu/K6wNQ0mDNyBTplvbcBV049GkCvDXl1BxkdJWXBQK03BZqB1FaJ4i8ApCIc0A==
X-Received: by 2002:a50:d70d:: with SMTP id t13-v6mr3903249edi.260.1525980619244;
        Thu, 10 May 2018 12:30:19 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id z11-v6sm870817edh.60.2018.05.10.12.30.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 May 2018 12:30:18 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        David Turner <novalis@novalis.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 2/3] t1400: add tests around adding/deleting pseudorefs
Date:   Thu, 10 May 2018 21:29:55 +0200
Message-Id: <5daaf948da0575ee95cfa1499a04d6cced4e3454.1525979881.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1525979881.git.martin.agren@gmail.com>
References: <CAN0heSp-rxqAVJ3Q1KMD=eYqPUkcDP8xBTVTDtGfom6v5WpBLQ@mail.gmail.com> <cover.1525979881.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have not been able to find any tests around adding pseudorefs using
`git update-ref`. Add some as outlined in this table (original design by
Michael Haggerty; modified and extended by me):

Pre-update value   | ref-update old OID   | Expected result
-------------------|----------------------|----------------
missing            | value                | reject
missing            | none given           | accept
set                | none given           | accept
set                | correct value        | accept
set                | wrong value          | reject
missing            | zero                 | accept *
set                | zero                 | reject *

The tests marked with a * currently fail, despite git-update-ref(1)
claiming that it is possible to "specify 40 '0' or an empty string as
<oldvalue> to make sure that the ref you are creating does not exist."
These failing tests will be fixed in the next commit.

It is only natural to test deletion as well. Test deletion without an
old OID, with a correct one and with an incorrect one.

Suggested-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 t/t1400-update-ref.sh | 60 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 664a3a4e4e..3996109ba4 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -457,6 +457,66 @@ test_expect_success 'git cat-file blob master@{2005-05-26 23:42}:F (expect OTHER
 	test OTHER = $(git cat-file blob "master@{2005-05-26 23:42}:F")
 '
 
+# Test adding and deleting pseudorefs
+
+test_expect_success 'given old value for missing pseudoref, do not create' '
+	test_must_fail git update-ref PSEUDOREF $A $B 2>err &&
+	test_path_is_missing .git/PSEUDOREF &&
+	grep "could not read ref" err
+'
+
+test_expect_success 'create pseudoref' '
+	git update-ref PSEUDOREF $A &&
+	test $A = $(cat .git/PSEUDOREF)
+'
+
+test_expect_success 'overwrite pseudoref with no old value given' '
+	git update-ref PSEUDOREF $B &&
+	test $B = $(cat .git/PSEUDOREF)
+'
+
+test_expect_success 'overwrite pseudoref with correct old value' '
+	git update-ref PSEUDOREF $C $B &&
+	test $C = $(cat .git/PSEUDOREF)
+'
+
+test_expect_success 'do not overwrite pseudoref with wrong old value' '
+	test_must_fail git update-ref PSEUDOREF $D $E 2>err &&
+	test $C = $(cat .git/PSEUDOREF) &&
+	grep "unexpected object ID" err
+'
+
+test_expect_success 'delete pseudoref' '
+	git update-ref -d PSEUDOREF &&
+	test_path_is_missing .git/PSEUDOREF
+'
+
+test_expect_success 'do not delete pseudoref with wrong old value' '
+	git update-ref PSEUDOREF $A &&
+	test_must_fail git update-ref -d PSEUDOREF $B 2>err &&
+	test $A = $(cat .git/PSEUDOREF) &&
+	grep "unexpected object ID" err
+'
+
+test_expect_success 'delete pseudoref with correct old value' '
+	git update-ref -d PSEUDOREF $A &&
+	test_path_is_missing .git/PSEUDOREF
+'
+
+test_expect_failure 'create pseudoref with old OID zero' '
+	git update-ref PSEUDOREF $A $Z &&
+	test $A = $(cat .git/PSEUDOREF)
+'
+
+test_expect_failure 'do not overwrite pseudoref with old OID zero' '
+	test_when_finished git update-ref -d PSEUDOREF &&
+	test_must_fail git update-ref PSEUDOREF $B $Z 2>err &&
+	test $A = $(cat .git/PSEUDOREF) &&
+	grep "already exists" err
+'
+
+# Test --stdin
+
 a=refs/heads/a
 b=refs/heads/b
 c=refs/heads/c
-- 
2.17.0

