Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 633A320284
	for <e@80x24.org>; Thu, 25 May 2017 19:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1036716AbdEYTqw (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 15:46:52 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33353 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1036692AbdEYTqs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 15:46:48 -0400
Received: by mail-wm0-f66.google.com with SMTP id b84so39672403wmh.0
        for <git@vger.kernel.org>; Thu, 25 May 2017 12:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b4FmghXhthipWmU4fpG4IiIVmDGMMJgCn8x1buEpANo=;
        b=oW5OAJQtIC6BQYI/Qkpd/73UiZi0a+oZgGT8lIoLK2t+CfoRce/McZZPk47JkxN39v
         M/zrZ7UkCs5PQ38zSoB0ctnK+KPJMARhdSPhACmF1DNI/i7ZK/W7URJiuzlqA30eTQmw
         VT7UdL4fvqSTErsJ0+3bkQITOrzmARxvzPZJWAtmr++4SRI8nd+PJibLWeNc+k8zsRdh
         3s3tYZjxDOeATPeuLYoE1Z9Dyd51cTeNfZUFhCXHpCKW+B2hYFBm1TnCPWrCQUuB6w5u
         FbcWS9Ny4VVkuQJ+zFDDZEjszBrbbjI5/6seChCNBmbeNW+ETDOoeT9lEYN18lw6lDMf
         v1Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b4FmghXhthipWmU4fpG4IiIVmDGMMJgCn8x1buEpANo=;
        b=RNWr2e28gnTVMbE0xJvcxqfd5uLOLR0N+E6Ofj7xyIBdgULR9PWmDHG4kjD3Km9m1r
         H5wvnqJYQMdo3tZs1vReWvpui1mgNoJKY63McKkPaQB+iGh0YRb/jgqVKYrFM3AozmkS
         /bSrVYYAJqrVm5MbOXEP+qHnce3s0cyIjTFzMrQISORbycZWquU8zCUc5hlXBbwZbxp9
         OVA5VZhFRDvPCD7MENakbiOVnyMGofhf1Am2EK9NpVRT9c4WDnmI88mphk3h2NZ9Umtu
         RmGzgQ03bjTNH8syHc5zTXXMk7N7yXQ3srvm6OMEciyLNJc7DPuEDbZSvQHiJyYg3nU9
         rJXg==
X-Gm-Message-State: AODbwcBaF04h5PbFlh3zclHzz4s9RSRSzWkQROZaJN+7C1LAqwmS3AFk
        5LNy0ITGi9zybA==
X-Received: by 10.223.128.80 with SMTP id 74mr30114821wrk.30.1495741603773;
        Thu, 25 May 2017 12:46:43 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id q203sm8387273wme.0.2017.05.25.12.46.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 May 2017 12:46:42 -0700 (PDT)
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
Subject: [PATCH v4 13/31] grep: prepare for testing binary regexes containing rx metacharacters
Date:   Thu, 25 May 2017 19:45:17 +0000
Message-Id: <20170525194535.9324-14-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169
In-Reply-To: <20170525194535.9324-1-avarab@gmail.com>
References: <20170525194535.9324-1-avarab@gmail.com>
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
index df93d8e44c..20370d6e0c 100755
--- a/t/t7008-grep-binary.sh
+++ b/t/t7008-grep-binary.sh
@@ -28,7 +28,7 @@ nul_match () {
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
2.13.0.303.g4ebf302169

