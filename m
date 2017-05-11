Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC24A1FF34
	for <e@80x24.org>; Thu, 11 May 2017 09:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755213AbdEKJT1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 05:19:27 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33111 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755191AbdEKJTZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 05:19:25 -0400
Received: by mail-wm0-f66.google.com with SMTP id y10so5503835wmh.0
        for <git@vger.kernel.org>; Thu, 11 May 2017 02:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2lXnZxkI8bWvY6+f/RNEoaOncelmBYOmJJU1XkNaE38=;
        b=YoxBCPY0m8zd1sWH6+RHsDzIqgSc1pVX8w4c3Qo2xPLHOEOB3bREdOZYt5ih92WuZO
         AHG049Pk7tT6JPZRwV5XlN0SI8VKHD4AqAQCl6ERaqwLEpAw7AD2RLwwwVQhWEllgXcP
         XfIJeXA5D67Ia/rj9kg1Ygs1RoxyHjwBTGF31CRVFaeu5Qx/NYkkU94tZSQAjUoWceoK
         wOk2tEF0/wvGMfnA6YA2T8WKHCSxtcFYWKQHa4aA04e9qadNanvFyXGLsaV7cZGk/Fkk
         0Z6S/sSLeBccyfud9QAihlUtX5Pucz10gCxOpdZg9poD4xkcl92kTvFGJpnPGXU39q1V
         oSvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2lXnZxkI8bWvY6+f/RNEoaOncelmBYOmJJU1XkNaE38=;
        b=rir7mFb6Hl6T33CqEeg7Ch7ShgSKI5BArhT1ZPTn3SXQ7OChIw7YbVNQkLiYSR9qD7
         uE1oRk02MMxPkThKciwsq8VD+znz76KGt9SA7XmjlfhDmOB0gBzoOrPWAjMnsSwxg9Vz
         xzktGJPkhWtlyQnCINhR7xRSQ11PoQX5X73z0RBRPosImXMPMHLdLMFhQBMdD/Er3RSA
         d0puy/HIY1ImH9CvpK/rEsOlqxNDO0dt20AVxP2xptwdYR6E7AS+5t6QMpIRn6qsMzpR
         9M4II2clZ0bJ7ERpYCCkQpli6WkZuI+Qkn8l8a8owpkRSxrJGnFPNwzVaLAQicdwNttd
         OBGw==
X-Gm-Message-State: AODbwcDj2NDfM5tS5Q9WJuJkoFnooavLVQP2CLs9O4MJ2KCRGmiJ9CGV
        Q75V35bmpImzkw==
X-Received: by 10.80.179.123 with SMTP id r56mr20759edd.1.1494494363962;
        Thu, 11 May 2017 02:19:23 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b3sm8341ede.9.2017.05.11.02.19.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 May 2017 02:19:23 -0700 (PDT)
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
Subject: [PATCH 12/29] grep: prepare for testing binary regexes containing rx metacharacters
Date:   Thu, 11 May 2017 09:18:12 +0000
Message-Id: <20170511091829.5634-13-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170511091829.5634-1-avarab@gmail.com>
References: <20170511091829.5634-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add setup code needed for testing regexes that contain both binary
data and regex metacharacters.

The POSIX regcomp() function inherently can't support that, because it
takes a \0-delimited char *, but other regex engines APIs like PCRE v2
take a pattern/length pair, and are thus able to handle \0s in
patterns as well as any other character.

When kwset was imported in commit 9eceddeec6 ("Use kwset in grep",
2011-08-21) this limitation was fixed, but at the expense of
introducing the undocumented limitation that any pattern containing \0
implicitly becomes a fixed match (equivalent to -F having been
provided).

That's not something we'd like to keep in the future. The inability to
match patterns containing \0 is a leaky implementation detail.

So add tests as a first step towards changing that. In order to test
that \0-patterns can properly match as regexes the test string needs
to have some regex metacharacters in it.

There were other blind spots in the tests. The code around kwset
specially handles case-insensitive & non-ASCII data, but there were no
tests for this.

Fix all of that by amending the text being matched to contain both
regex metacharacters & non-ASCII data.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t7008-grep-binary.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t7008-grep-binary.sh b/t/t7008-grep-binary.sh
index 6c1952eafa..1afba6cee9 100755
--- a/t/t7008-grep-binary.sh
+++ b/t/t7008-grep-binary.sh
@@ -28,7 +28,7 @@ nul_match() {
 }
 
 test_expect_success 'setup' "
-	echo 'binaryQfile' | q_to_nul >a &&
+	echo 'binaryQfileQm[*]cQ*æQð' | q_to_nul >a &&
 	git add a &&
 	git commit -m.
 "
@@ -162,7 +162,7 @@ test_expect_success 'grep does not honor textconv' '
 '
 
 test_expect_success 'grep --textconv honors textconv' '
-	echo "a:binaryQfile" >expect &&
+	echo "a:binaryQfileQm[*]cQ*æQð" >expect &&
 	git grep --textconv Qfile >actual &&
 	test_cmp expect actual
 '
@@ -172,7 +172,7 @@ test_expect_success 'grep --no-textconv does not honor textconv' '
 '
 
 test_expect_success 'grep --textconv blob honors textconv' '
-	echo "HEAD:a:binaryQfile" >expect &&
+	echo "HEAD:a:binaryQfileQm[*]cQ*æQð" >expect &&
 	git grep --textconv Qfile HEAD:a >actual &&
 	test_cmp expect actual
 '
-- 
2.11.0

