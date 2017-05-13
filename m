Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 520DA20188
	for <e@80x24.org>; Sat, 13 May 2017 23:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758794AbdEMXQ3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 19:16:29 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:35404 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758725AbdEMXQZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 19:16:25 -0400
Received: by mail-qk0-f194.google.com with SMTP id k74so12531496qke.2
        for <git@vger.kernel.org>; Sat, 13 May 2017 16:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2hn3S+6TfBwNJ7d5o8M+v7dcCxuxJc2fgmBtWC5MFkE=;
        b=JTEApYLQjZbYl827eWaM04b1l45T286yGc79ttv1dkxqM+Etes7BAMBCFWwfB8XAR5
         ORQygBnhPBYXQ4/h17m9PqD5wgMJASPzJAgrbElD3ty9m5w8+Z3bWBqF9Ae6MsaYlOgq
         uiRj/HJwGLQlHvMgdEBWlVF1lTFlTegwCqsttCGCUfrER9V2tfX94iCily4UQvr2O29x
         1TA3UZ9ihZUkX+BZI5231iXXYyfPmBkLbPvS/BWJubeyEQsV/z4clRVoKin+MEvaulip
         JaiJXqxpCXTNPRNXnR3eKFEo028d1ilUrLhw0tiyLgh/xllVHp1R/rKlZeQ9ablWK+SB
         U63g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2hn3S+6TfBwNJ7d5o8M+v7dcCxuxJc2fgmBtWC5MFkE=;
        b=BOETFPiPgRepbZEv1+/uDRFwfpCnu7AHhjm3Kw2s8nVwBEGEuY9pBPuifw7zdVER0R
         WTO3+a8nmdgHNGsuHWwVKRALl+pIrnjVp85SS3xb5Po5+HlsH71XO5f/v2QkKoNvxB0j
         NU6iB/gqhcm9/mF2KjcjIJsDc+dugTFrg5u5q+lQHRd+eJxB4I4yXl5wj4amtLKyQOmB
         9l8VkjH4x9AHoFWJT3tZt0iKHZPHx2y5vQEmQgIjw1Q3JC0tFkgTCp/jjBA5j8X4k9Ae
         Ws+wawjeH7ALP22SsmsRNsilZJti6onIYdd83xEU8cwzvnsLamyATqLGS4z+fFKoSCeU
         r04g==
X-Gm-Message-State: AODbwcB+EdWEyJnYCeCu9Di/KmZLqUJGScbNmOq52GCXN+k+F/hb6nCO
        PEkzoteZJtp9Ig==
X-Received: by 10.55.217.93 with SMTP id u90mr9535962qki.277.1494717384272;
        Sat, 13 May 2017 16:16:24 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k86sm5574840qkh.12.2017.05.13.16.16.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 May 2017 16:16:23 -0700 (PDT)
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
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 12/29] grep: prepare for testing binary regexes containing rx metacharacters
Date:   Sat, 13 May 2017 23:14:52 +0000
Message-Id: <20170513231509.7834-13-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170513231509.7834-1-avarab@gmail.com>
References: <20170513231509.7834-1-avarab@gmail.com>
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
index 70e7868829..e7754c3946 100755
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
2.11.0

