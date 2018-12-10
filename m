Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05EED20A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 18:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbeLJSrS (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 13:47:18 -0500
Received: from mail-pg1-f173.google.com ([209.85.215.173]:45267 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbeLJSrQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 13:47:16 -0500
Received: by mail-pg1-f173.google.com with SMTP id y4so5356529pgc.12
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 10:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=h6bw3zh0Owmk640i2fp+7lt4vD41oNHpD0FJtLWvX/Y=;
        b=iaUEG9snaa9WQRkYZQIQK7Wlc6PJpfAGx/e/b3odFtrsuKFiyeayBpUhzxEhrZSQT5
         0mptXJFwLPSk65ItFq//3C9mBlTgadqTEZOS28FhF66avLx/+EE8NZdY96RXiPD3XHHi
         aDgSsepEOTlEElC4SRCDix3+WoEn5jla52o8FTBLBf2Q7So1YkvxOQ1lsyWjJNYek6mS
         OPRGhErqRTh382yD1URNL1lk9r+aGoa/H4vmphVWM/n1KR5fMgTuTr3+ouv+NfNE2x/M
         T5MLrD3fxPtYBqwyVwiy+y3mQFN6LG939qrs6M0fxLVbMWUtLno2cty9h4g09y8fDnjr
         W6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=h6bw3zh0Owmk640i2fp+7lt4vD41oNHpD0FJtLWvX/Y=;
        b=pPy25y0ysTiLP8QT76CaCPrBGDnJfeZG30piOC+La4/cbEwSsWuG7QAA5jC+vqloxZ
         DEE4E0DR015HKr4sk9tYcSTWzxAkw9R3YD9mwuAGWXQscllVcb+Bxa9D8SmhqfuyMxhv
         +l0stCG5DvPfDnVWYhg57iZ4Jp98U+oBIL+0S2hj4VyiIPpJ9nDmM75jyDhXfs9J8Jzd
         E5+UadGxsrBB8pdM9IwJtGjOWhi0Y2hhOw8MWjKx+FeKvRd/wJxUy8BhSiVFVxvi8rnP
         deZNkjuOwIqNwjOsjB6VYlQG9ffsJC2+jXkis8UGSFnYTNyG4GLBQ9kobm7tF6awX6sp
         LN6w==
X-Gm-Message-State: AA+aEWZsAWSG2yqAOZZPnEIs2AsCriJV1MCTfO9iK1T7S/RmJUbE6Mso
        4395xjBzy84PnYFiKjRFkuBQ+kIG
X-Google-Smtp-Source: AFSGD/X3+6VGWcjFAlPOt70GsGGFtdcont8yq1RalyG2iH4A3p9/VigeLv9zQwnXdpu05TXd3A25Ag==
X-Received: by 2002:a62:4886:: with SMTP id q6mr13794671pfi.182.1544467634933;
        Mon, 10 Dec 2018 10:47:14 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id g15sm60299263pfj.131.2018.12.10.10.47.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 10:47:14 -0800 (PST)
Date:   Mon, 10 Dec 2018 10:47:14 -0800 (PST)
X-Google-Original-Date: Mon, 10 Dec 2018 18:47:10 GMT
Message-Id: <09a73fe1d30c9fedc2f010fe4df75a9cb000389c.1544467631.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.96.git.gitgitgadget@gmail.com>
References: <pull.96.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/2] mingw: demonstrate a problem with certain absolute paths
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

On Windows, there are several categories of absolute paths. One such
category starts with a backslash and is implicitly relative to the
drive associated with the current working directory. Example:

	c:
	git clone https://github.com/git-for-windows/git \G4W

should clone into C:\G4W.

There is currently a problem with that, in that mingw_mktemp() does not
expect the _wmktemp() function to prefix the absolute path with the
drive prefix, and as a consequence, the resulting path does not fit into
the originally-passed string buffer. The symptom is a "Result too large"
error.

Reported by Juan Carlos Arevalo Baeza.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5580-clone-push-unc.sh | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/t/t5580-clone-push-unc.sh b/t/t5580-clone-push-unc.sh
index ba548df4a9..c2b0082296 100755
--- a/t/t5580-clone-push-unc.sh
+++ b/t/t5580-clone-push-unc.sh
@@ -17,14 +17,11 @@ fi
 UNCPATH="$(winpwd)"
 case "$UNCPATH" in
 [A-Z]:*)
+	WITHOUTDRIVE="${UNCPATH#?:}"
 	# Use administrative share e.g. \\localhost\C$\git-sdk-64\usr\src\git
 	# (we use forward slashes here because MSYS2 and Git accept them, and
 	# they are easier on the eyes)
-	UNCPATH="//localhost/${UNCPATH%%:*}\$/${UNCPATH#?:}"
-	test -d "$UNCPATH" || {
-		skip_all='could not access administrative share; skipping'
-		test_done
-	}
+	UNCPATH="//localhost/${UNCPATH%%:*}\$$WITHOUTDRIVE"
 	;;
 *)
 	skip_all='skipping UNC path tests, cannot determine current path as UNC'
@@ -32,6 +29,18 @@ case "$UNCPATH" in
 	;;
 esac
 
+test_expect_failure 'clone into absolute path lacking a drive prefix' '
+	USINGBACKSLASHES="$(echo "$WITHOUTDRIVE"/without-drive-prefix |
+		tr / \\\\)" &&
+	git clone . "$USINGBACKSLASHES" &&
+	test -f without-drive-prefix/.git/HEAD
+'
+
+test -d "$UNCPATH" || {
+	skip_all='could not access administrative share; skipping'
+	test_done
+}
+
 test_expect_success setup '
 	test_commit initial
 '
-- 
gitgitgadget

