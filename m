Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D9F21F97F
	for <e@80x24.org>; Tue, 27 Nov 2018 22:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbeK1JyU (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 04:54:20 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45245 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbeK1JyT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Nov 2018 04:54:19 -0500
Received: by mail-wr1-f65.google.com with SMTP id v6so24379541wrr.12
        for <git@vger.kernel.org>; Tue, 27 Nov 2018 14:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RBvKkjhv+BnHSZ1uO6ZboWQwCGo/qQxocF5Y6NCe3Tc=;
        b=S88Ey+5SR5wKYB4++ymK4qsMYmUFzMhmaqjv1sXP2KB7IInwbDs0nwlk6rL3/jaaB/
         lSX0Uf6syk+lz7lUIIQxtsDH3JLyeIP/WGGU11fiA2o7RD+jK+/tLZwUlVBhz3zJ/BAd
         hamrJuFqi0J9AKSQ+RbQE0RMJB0a+/Qb5PPEpKUKIvfUVv7EuBfsYOBzNKU7O7la2BuR
         JZqOMPDE9+sABnIR6DxkKV/r8t+OE/529jClfG9zhKGoQjhGv6aBN6puh43l4PQyqhtG
         HdiFGBiGHXU5rtQGjIz4WXKt2x0scQ2imavF8pJtfl9C8dxddeGgmLYJMVD/9G3wIi5j
         leHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RBvKkjhv+BnHSZ1uO6ZboWQwCGo/qQxocF5Y6NCe3Tc=;
        b=WNFK9BM37W7ucVJp5WyrTzReP8q4+88zUBZHz0k0TkhBMw11IX6CbMZBIPUB6YxuRw
         cvDWKDGrkJIkE96fkf7+FxM9Gd3tvFf4JDxTFd1Pp1yi9X1iS5Sp+yuvAJzKzmpIDZpZ
         hOSxwHos8bq+NH6CVk0VtF7Bktseuuo0H5/thrDjUCnpjdC53uxOEZ+ZlDuuFyiQTh9s
         vDHJkrVeh8hSDfjWt54cpEUut8UVuhpYaSP0WFw7DovmfkwLqGkYdFxhhI0xrwD6UjPu
         FIZAomliTAcfdCgJO7ACT3kYDS2W972n+KwTeMOTIAndQBOFoS6WhNMs/OUUcLKMXqta
         K30A==
X-Gm-Message-State: AA+aEWYu5jZGXKqNlS8ghOqwT/mtoenmcHoZ1AgEKWH/mHP14Qd9OjC8
        aQpoqGjaFcYgkKbfjySgDJMPD5LF
X-Google-Smtp-Source: AFSGD/Vztaf0oNd/L1w3geTlg2jtWU1Dw5jE28H2vPWES5DrtzeeaeVzkanpT+em67J14SFnJaazZw==
X-Received: by 2002:adf:b783:: with SMTP id s3mr19021670wre.274.1543359291987;
        Tue, 27 Nov 2018 14:54:51 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v189-v6sm710604wmd.40.2018.11.27.14.54.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 14:54:51 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/5] t/README: modernize description of GIT_SKIP_TESTS
Date:   Tue, 27 Nov 2018 23:54:42 +0100
Message-Id: <20181127225445.30045-2-avarab@gmail.com>
X-Mailer: git-send-email 2.20.0.rc1.379.g1dd7ef354c
In-Reply-To: <20181127225445.30045-1-avarab@gmail.com>
References: <20181127225445.30045-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the GIT_SKIP_TESTS documentation was added in
fbd458a3f6 ("t/README: Add 'Skipping Tests' section below 'Running
Tests'", 2008-06-20) there was no way to declare test prerequisites,
that came later in a7bb394037 ("test-lib: Infrastructure to test and
check for prerequisites", 2009-03-01).

The docs were newer updated, and have been saying that you might want
to use GIT_SKIP_TESTS for a use-case which we'd never use them for,
skipping tests because 'unzip' isn't there. For that we'd use the
UNZIP prerequisite added in 552a26c8c0 ("Use prerequisites to skip
tests that need unzip", 2009-03-16). Fix the docs accordingly.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/README | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/t/README b/t/README
index b6ec28f634..3139f4330a 100644
--- a/t/README
+++ b/t/README
@@ -202,20 +202,21 @@ GIT_TEST_EXEC_PATH defaults to `$GIT_TEST_INSTALLED/git --exec-path`.
 Skipping Tests
 --------------
 
-In some environments, certain tests have no way of succeeding
-due to platform limitation, such as lack of 'unzip' program, or
-filesystem that do not allow arbitrary sequence of non-NUL bytes
-as pathnames.
+Certain tests may fail intermittently or entirely. These should
+ideally be reported as bugs and fixed, or guarded by a prerequisite
+(see "Using test prerequisites" below). But until then they can be
+skipped.
 
-You should be able to say something like
+To skip tests, set the GIT_SKIP_TESTS variable. Individual tests can
+be skipped:
 
     $ GIT_SKIP_TESTS=t9200.8 sh ./t9200-git-cvsexport-commit.sh
 
-and even:
+Or tests matching a glob:
 
     $ GIT_SKIP_TESTS='t[0-4]??? t91?? t9200.8' make
 
-to omit such tests.  The value of the environment variable is a
+The value of the environment variable is a
 SP separated list of patterns that tells which tests to skip,
 and either can match the "t[0-9]{4}" part to skip the whole
 test, or t[0-9]{4} followed by ".$number" to say which
-- 
2.20.0.rc1.379.g1dd7ef354c

