Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52C042018D
	for <e@80x24.org>; Thu, 11 May 2017 17:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933327AbdEKRvy (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 13:51:54 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:34193 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933309AbdEKRvx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 13:51:53 -0400
Received: by mail-qk0-f194.google.com with SMTP id u75so4657440qka.1
        for <git@vger.kernel.org>; Thu, 11 May 2017 10:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xjiEKbK35LdpgnQSs4W+L1lu3YhrhmmBAcQ4cVZtLz4=;
        b=rxdepau/eh5pKr/2XCQA64PvDPrMlGkoSnqYp7VNOwZuZIqXQGI9YAxa17V+WQ3QvU
         Nj+Mt7si2ucVpmzm4b7BuTKOmvvKOgHYBJlRgOtRQltabCLVV6Ib0H8YiInl8GG/GXVy
         gY4drh+GCOrXVtM1xz1ZjqI/Qn3sk4cYXt+cADG0+iZuWoC4+shheIPOlM/VnF/FQGyn
         KqSXNwblu6QmLwi0mY1u6WOgpgVeVlinJyvQd1AoFcI2xcL8g3TeYaoLnvtFzwHOniWs
         RZOCfNQIAC7ySJ/SMO2onQKn9uvv10oJpEaduRywYLeKgMEyU7p34vEhPPkU14me1Sum
         DmYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xjiEKbK35LdpgnQSs4W+L1lu3YhrhmmBAcQ4cVZtLz4=;
        b=F5029zgGbfW38ViBgJMQEfJMjsW7vL2NLX+d5JxO3DvaF27ruer5EM5NiXxqmozwqv
         v6Vr6Ku2qjC6ebOYB4tG+wxFp17jXj1G6AlcE7lxU+xWO3CTF1UwrRhUe+2mzvB16s/k
         9jKO9L6oxIKkkH06QwDhhIM7AaQiuNqEZEAxRZG5gFupM88feaE4Ab2k70HNIHbn116L
         V10DG0t2uEx+xPGmbAnxGZgTEdoojVlXxE3LW0X9vS5me9T6tszaJqDWxQWJdPPwCFhH
         rO/TI8nDc6ZCdqjCe9DSbVA7knw5QHXzqCxhAlVTxhvx2UMy9fdUUdvDDOWTKBGO3dpz
         Ksqw==
X-Gm-Message-State: AODbwcCWTHWA2z8WL/i0rvJ52vwnF0FOikuE15lTAPPBqIK1shkfvn9v
        kjj+UgLlQNOnrg==
X-Received: by 10.55.40.41 with SMTP id o41mr8641qkh.3.1494525112146;
        Thu, 11 May 2017 10:51:52 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id g3sm561483qte.66.2017.05.11.10.51.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 May 2017 10:51:51 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH/RFC 4/6] test-lib: add LIBPCRE1 & LIBPCRE2 prerequisites
Date:   Thu, 11 May 2017 17:51:13 +0000
Message-Id: <20170511175115.648-5-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170511175115.648-1-avarab@gmail.com>
References: <20170511175115.648-1-avarab@gmail.com>
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

There are various edge cases or version-specific features that need to
be tested for.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/README      | 12 ++++++++++++
 t/test-lib.sh |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/t/README b/t/README
index 2f95860369..1ff612ca65 100644
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
index 44d4679384..13ed81dc16 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1012,6 +1012,8 @@ test -z "$NO_PERL" && test_set_prereq PERL
 test -z "$NO_PTHREADS" && test_set_prereq PTHREADS
 test -z "$NO_PYTHON" && test_set_prereq PYTHON
 test -n "$USE_LIBPCRE1$USE_LIBPCRE2" && test_set_prereq PCRE
+test -n "$USE_LIBPCRE1" && test_set_prereq LIBPCRE1
+test -n "$USE_LIBPCRE2" && test_set_prereq LIBPCRE2
 test -z "$NO_GETTEXT" && test_set_prereq GETTEXT
 
 # Can we rely on git's output in the C locale?
-- 
2.11.0

