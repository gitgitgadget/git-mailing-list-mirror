Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7F2320954
	for <e@80x24.org>; Wed, 22 Nov 2017 13:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751438AbdKVNgn (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 08:36:43 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:46219 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751258AbdKVNgm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 08:36:42 -0500
Received: by mail-wm0-f66.google.com with SMTP id u83so10461773wmb.5
        for <git@vger.kernel.org>; Wed, 22 Nov 2017 05:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/24RVvLFyF6yVUPT3TIs4FCDbAAtI63C0R+u8T9F3+s=;
        b=cW07vFAVaywik5UX7Q0UHH7UVZ6qHD8b3grW+B1+8FrYi2qqAFOlFPuo6OMkPCTwF5
         3NWw4oy3R3kcSG36saEjzR2E/XuBFKKwL3U2kEmarPjUAjnpjxj4/IfvLtIUQke6c3Lc
         6umQoVPz5YtJqC8wNYET7tFJD+/24oW9jtQE3FItFSeWFSjR3TB+0WLayiu1ojFlP7pH
         AsXbaL6kksqGZm+MOkAP9VqZzejBBYs1JYbyO+hsQDiyhbOLG1Up1kYBV99WGwYhAmsO
         8qcSvvo/horodQgVcybLQnI1GVSOvG119Jp6T74vR7RAbcPfBqsBlwwl7Sn6AB4g4EU4
         VThw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/24RVvLFyF6yVUPT3TIs4FCDbAAtI63C0R+u8T9F3+s=;
        b=CgDZNxH9yflxc1Wr39OjoaQHaB/ycUjj0XDCIRiStj0o8I7bSDh8S80APRI7Jd7cN+
         Y/aU5xcEce79SOtNdBrcJ7udqdD3tlCjRhDbleDaOlU2hAAMAghwcS9hxRFwxaaSKYJH
         6m8r/hsMqcFD8hRZsjS1nYAM8EmipHTzLlHlf0i6L+q9OHDFA+Uet/MBtjIpxliYaH4x
         +nQFIPg8SgsSB4/SjRhx/urvKTLzYBLRXg+J6y01Klveaf9F+Z8HgUYDCeDacFmhRTQD
         k0JZmIy1YWrKFDTcoet9SoL48EwJqc/JyPxEHgmnUsOtYctprqYbxNX5rrlvvdTlWCfn
         gbjQ==
X-Gm-Message-State: AJaThX62PVzBQPKHm4IUXyQ1Li6zAABjVf26YkZLa40km+raSM+iCH77
        4e0kcfsi+fbjLyF38CU6aINcH4Ln
X-Google-Smtp-Source: AGs4zMYOtGBKYD1Y+OY8FNwqaldR7NzbMAvAW1U1LIxWFZgfD+yUqMnQNxJtshkMHL8lPtnu3CA6Uw==
X-Received: by 10.80.179.15 with SMTP id q15mr28684974edd.166.1511357801312;
        Wed, 22 Nov 2017 05:36:41 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k19sm12068426ede.35.2017.11.22.05.36.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Nov 2017 05:36:39 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] test-lib: add LIBPCRE1 & LIBPCRE2 prerequisites
Date:   Wed, 22 Nov 2017 13:36:29 +0000
Message-Id: <20171122133630.18931-1-avarab@gmail.com>
X-Mailer: git-send-email 2.15.0.403.gc27cc4dac6
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

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
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

