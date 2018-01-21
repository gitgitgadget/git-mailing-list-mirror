Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E457D1F424
	for <e@80x24.org>; Sun, 21 Jan 2018 00:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756789AbeAUADl (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Jan 2018 19:03:41 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39485 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756767AbeAUADg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Jan 2018 19:03:36 -0500
Received: by mail-wm0-f66.google.com with SMTP id b21so10189569wme.4
        for <git@vger.kernel.org>; Sat, 20 Jan 2018 16:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=OSTZqggGIXeMr43ZWLSzV4vuV7hN+2LJ809bSUfqc3w=;
        b=ZwXH9XFXBh0kcgVceGKEYGXK/y/QMr8nP4FaOaooRKUaak82qXV8+O3tkX3a5gsiTp
         TWCFsnF3o50lm7hOU6kHKqAOTCq6Q07l3eJuEZPbMrwJoVdnGJvNyEi+NxPVKwKhV+nO
         lMirVatki6VUA6If17q8KCZffzYDOKmxd7PgLjae+55iXm8UIUp33ZfTqRBGnd1vXbYD
         D9GFp6WKKnjYPW5QOQmhbdwdY8N/5vpO/fc6tltRFRx5oHiGtknH7JRrrafkCOBhP77q
         NQsX7Q02wZ8AmjhgqUq9ZfB96EhG1NlYWBJeZcihyOyp40NI9yc81K4yk2k2plYO6opa
         jLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=OSTZqggGIXeMr43ZWLSzV4vuV7hN+2LJ809bSUfqc3w=;
        b=uKYI3r6Z+Gz/SZzU62ffEx+MZuFoOjv3+4S8nn/mSyciOIXchTUG9zeQsHhLco8gNg
         Ayp7LlL+NwkYAkxHqDkpX6vJOelvrr5eEFxCH/z3y9PvJq7yLry9ReGS4kelqREXo0v/
         i1vmOZ+aakOWOczfYVUasLaf1IFIg4bRIRqEfBlvGskQUF8u6ReJpWSzxcMjMoLy8yIr
         OnikHab60r3Nd/n4d37fkZE2X+krUtlzFNRJcYrpuYY7QbQSyLzRuwOMmXNOpedlFqp1
         uGgJfgrX52pyyFe1bw7o2KSujYpMOWs0NUZJJFff6uvW6IVsQkgpPcSDVw2Sg6TcTBnC
         s/JA==
X-Gm-Message-State: AKwxytfp2AVs/SzZhQXHBwbe+3zFwGcjy3xkOhUVIIjiDDM8kvETSq93
        tfVuHR1d3rfbk7L6Zl460yZfuyjE
X-Google-Smtp-Source: AH8x224OUmmaf88hyKaXqCQFzhm6okP+XgLlJ2OGlwU+IX5jauqEUSOkFMNh9Ctbc3S1l9f478H5Ow==
X-Received: by 10.28.146.197 with SMTP id u188mr2008391wmd.124.1516493014139;
        Sat, 20 Jan 2018 16:03:34 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id v75sm18677641wrc.45.2018.01.20.16.03.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Jan 2018 16:03:32 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 05/12] fetch tests: test --prune and refspec interaction
Date:   Sun, 21 Jan 2018 00:02:57 +0000
Message-Id: <20180121000304.32323-6-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180121000304.32323-1-avarab@gmail.com>
References: <20180121000304.32323-1-avarab@gmail.com>
In-Reply-To: <20180119000027.28898-1-avarab@gmail.com>
References: <20180119000027.28898-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a test for the interaction between explicitly provided refspecs
and fetch.prune.

There's no point in adding this boilerplate to every combination of
unset/false/true, it's instructive and sufficient to show that no
matter if the variable is unset, false or true the refspec on the
command-line overrides any configuration variable.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5510-fetch.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 542eb53a99..576c2598c9 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -609,6 +609,10 @@ test_configured_prune () {
 test_configured_prune unset unset kept   kept   ""
 test_configured_prune unset unset kept   kept   "--no-prune"
 test_configured_prune unset unset pruned kept   "--prune"
+test_configured_prune unset unset kept   pruned \
+	"--prune origin 'refs/tags/*:refs/tags/*'"
+test_configured_prune unset unset pruned pruned \
+	"--prune origin 'refs/tags/*:refs/tags/*' '+refs/heads/*:refs/remotes/origin/*'"
 
 test_configured_prune false unset kept   kept   ""
 test_configured_prune false unset kept   kept   "--no-prune"
@@ -625,6 +629,10 @@ test_configured_prune unset false pruned kept   "--prune"
 test_configured_prune false false kept   kept   ""
 test_configured_prune false false kept   kept   "--no-prune"
 test_configured_prune false false pruned kept   "--prune"
+test_configured_prune false false kept   pruned \
+	"--prune origin 'refs/tags/*:refs/tags/*'"
+test_configured_prune false false pruned pruned \
+	"--prune origin 'refs/tags/*:refs/tags/*' '+refs/heads/*:refs/remotes/origin/*'"
 
 test_configured_prune true  false kept   kept   ""
 test_configured_prune true  false pruned kept   "--prune"
@@ -641,6 +649,10 @@ test_configured_prune false true  pruned kept   "--prune"
 test_configured_prune true  true  pruned kept   ""
 test_configured_prune true  true  pruned kept   "--prune"
 test_configured_prune true  true  kept   kept   "--no-prune"
+test_configured_prune true  true  kept   pruned \
+	"--prune origin 'refs/tags/*:refs/tags/*'"
+test_configured_prune true  true  pruned pruned \
+	"--prune origin 'refs/tags/*:refs/tags/*' '+refs/heads/*:refs/remotes/origin/*'"
 
 test_expect_success 'all boundary commits are excluded' '
 	test_commit base &&
-- 
2.15.1.424.g9478a66081

