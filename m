Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D84D202F2
	for <e@80x24.org>; Thu, 23 Nov 2017 14:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752840AbdKWORM (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Nov 2017 09:17:12 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33119 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752020AbdKWORK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Nov 2017 09:17:10 -0500
Received: by mail-wm0-f67.google.com with SMTP id g130so17327239wme.0
        for <git@vger.kernel.org>; Thu, 23 Nov 2017 06:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p9Aooau1OGHI/d1BHlDHPDaJFd56jklfJEOZV+iatro=;
        b=bEb4OALyPFLqd9pzv0PeMOfs5T7OY/h97Oky3cnYofY98Y+GBcoGPIVYlZ5xH/xKRC
         pzif5bvZY43UTnV3wnh/S49JyuixEhQgMLByDEkt1b0l9loYyxwWTVZA0/B+STdwi35F
         r1fCAcu4sNaxFybji5pS/9BCZ60fYu5Uc1aOoM17hJ6nbcxMZW8g95R0DGTi8+tkvAYm
         6c8zOlmlywMslsqLWWDAkCYH6elpNDpTsThSQDbYGy/IhyWO+IGrZw0X1lZKsPaJc8l3
         v7lK8cKy+zBVSAxrmqP3tPtXm0wfHEBQtxlBJlU2FiL9KgbkReapFl4f9jX7tndQ8d4H
         wUtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p9Aooau1OGHI/d1BHlDHPDaJFd56jklfJEOZV+iatro=;
        b=QRjGvNKck7HqWtOb+k3HAHDiG+g7Hrdnv0qurQ9lZDQdWhq42q7xqzezDg8APnNr13
         uIGpJQFGikJH63BpjaqnO/bTP8F/zZITsZvtME5BjPqBZa4MtgLU0Nr/CYSZjuBXBDrO
         +Ma9vLOQbLMVgfpFCpEgXC2TU9FulQweVVBmu/V8YNDS/tDfVcjv6Qdbt7Ut//FDXhB4
         vzBBWyBXXNwTXnLfzXwDngPVj+g5tv5b7Cc8JGwZGAJ/ZHf7fSi2Yr3SI5yafEkSTFCY
         Z7/HnbHcsJZOYIs5qWGO4sEj3RpdWTLXPvrecWNHDbtv5wGMezLNFVrT2ZveMna9nxyq
         Z+Ug==
X-Gm-Message-State: AJaThX5nP9Mg6M9fPdKGM7hNRFy6VTBnU9SaLIPAUZQtwQ2WANMq5qD0
        8sHTAvqP0IJSTLIEiC04YFE2UVk2
X-Google-Smtp-Source: AGs4zMbpV4V9tJEAYV/rqlfdS4ArmMKxkHuo3v2TyPstgsKmZRQuAXpgSNw3ywrDxdokWNtTyvctwQ==
X-Received: by 10.28.158.212 with SMTP id h203mr7152903wme.157.1511446629241;
        Thu, 23 Nov 2017 06:17:09 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id n143sm14755536wmd.31.2017.11.23.06.17.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Nov 2017 06:17:07 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Simon Ruderich <simon@ruderich.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/2] test-lib: add LIBPCRE1 & LIBPCRE2 prerequisites
Date:   Thu, 23 Nov 2017 14:16:57 +0000
Message-Id: <20171123141658.13010-1-avarab@gmail.com>
X-Mailer: git-send-email 2.15.0.403.gc27cc4dac6
In-Reply-To: <20171122133630.18931-2-avarab@gmail.com>
References: <20171122133630.18931-2-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add LIBPCRE1 and LIBPCRE2 prerequisites which are true when git is
compiled with USE_LIBPCRE1=YesPlease or USE_LIBPCRE2=YesPlease,
respectively.

The syntax of PCRE1 and PCRE2 isn't the same in all cases (see
pcresyntax(3) and pcre2syntax(3)). If test are added that test for
those they'll need to be guarded by these new prerequisites.

The subsequent patch will make use of LIBPCRE2, so LIBPCRE1 isn't
strictly needed for now, but let's add it for consistency and so that
checking for it doesn't have to be done with the less obvious "PCRE,
!LIBPCRE2", which while semantically the same is more confusing, and
would lead to bugs if PCRE v3 is ever released as the tests would mean
v1, not any non-v2 version.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

As noted on-list I changed nothing here in the code, but noted in the
commit message why I'm keeping LIBPCRE1.

 t/README      | 12 ++++++++++++
 t/test-lib.sh |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/t/README b/t/README
index 4b079e4494..599cd9808c 100644
--- a/t/README
+++ b/t/README
@@ -808,6 +808,18 @@ use these, and "test_set_prereq" for how to define your own.
    Git was compiled with support for PCRE. Wrap any tests
    that use git-grep --perl-regexp or git-grep -P in these.
 
+ - LIBPCRE1
+
+   Git was compiled with PCRE v1 support via
+   USE_LIBPCRE1=YesPlease. Wrap any PCRE using tests that for some
+   reason need v1 of the PCRE library instead of v2 in these.
+
+ - LIBPCRE2
+
+   Git was compiled with PCRE v2 support via
+   USE_LIBPCRE2=YesPlease. Wrap any PCRE using tests that for some
+   reason need v2 of the PCRE library instead of v1 in these.
+
  - CASE_INSENSITIVE_FS
 
    Test is run on a case insensitive file system.
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 116bd6a70c..e7065df2bb 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1028,6 +1028,8 @@ test -z "$NO_PERL" && test_set_prereq PERL
 test -z "$NO_PTHREADS" && test_set_prereq PTHREADS
 test -z "$NO_PYTHON" && test_set_prereq PYTHON
 test -n "$USE_LIBPCRE1$USE_LIBPCRE2" && test_set_prereq PCRE
+test -n "$USE_LIBPCRE1" && test_set_prereq LIBPCRE1
+test -n "$USE_LIBPCRE2" && test_set_prereq LIBPCRE2
 test -z "$NO_GETTEXT" && test_set_prereq GETTEXT
 
 # Can we rely on git's output in the C locale?
-- 
2.15.0.403.gc27cc4dac6

