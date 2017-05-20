Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4BB5201A7
	for <e@80x24.org>; Sat, 20 May 2017 21:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932307AbdETVnY (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 May 2017 17:43:24 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34657 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932135AbdETVnP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2017 17:43:15 -0400
Received: by mail-wm0-f67.google.com with SMTP id d127so24396402wmf.1
        for <git@vger.kernel.org>; Sat, 20 May 2017 14:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b4FmghXhthipWmU4fpG4IiIVmDGMMJgCn8x1buEpANo=;
        b=Y+F3Ib3/q9zYvWyU1DRfhxCLhtWM6p2iHgtGIySeQ3WL08VWo1k2QfS13vfqA7pK/8
         UWDs3170bv/br3Ldic4lUTXCRtY9SiX/GkY8IKeUGGMK6Zs5gWO5F18PEMaKa7iHrJe1
         nQN9B75mFLcYQXLNkgLMOWanpT7aQcQydDcahESlIKeH+nAsCw9hwlXfwdVzjCodAUVA
         g2wNIDvwcHeK775OiiHbwjPWanwxB1kKdf9OrNPAtjJkWJ9btBpfZq6gmyft5BgnnSNm
         whEyRuxzuZglwix2Zk99uDKXw9R5pEctwT38U/uZl7rK5/wTNZTP4KhgL0Pm1EoOPC9m
         p3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b4FmghXhthipWmU4fpG4IiIVmDGMMJgCn8x1buEpANo=;
        b=uCVuZJGyxxajvpHNtUPT5f1o4AAyg7jaX9cWfu+1Ze9E3SY83npy52VOVEF6j5/WMi
         nCG/9lGdOxsEc5HyJfuS5WtbTaR1d0uIllA/K5u5zUAo+m1Duuuv3UFCoqgCDeEdFBbi
         v42Muz1J9kfQ7v1uMABZ8i+pExSLL9oqOvSfaOspmpFmWxPhd9xF+0GM4g4xQX0tcbff
         LG9HA3a9LFzdTTceYFIOcJyk6ImvQEocuRW4uIf0JPmCL5fcM9nORaWdU+uhxDT6klAA
         4xOUkutRxdmaDRXIzToAs6w8lDEEds6+MXh8IKla/3syYiq04BoZq+kMLWwNnxIz3pvV
         81Ag==
X-Gm-Message-State: AODbwcBimnDj3PvJ4gAemp/SmMWvcw+ed2JCw7PjlgaNiVOpAiEqP7zp
        qHetgPKZIC+j1w==
X-Received: by 10.28.93.10 with SMTP id r10mr10416498wmb.68.1495316593747;
        Sat, 20 May 2017 14:43:13 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id e73sm25666835wmd.1.2017.05.20.14.43.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 May 2017 14:43:12 -0700 (PDT)
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
Subject: [PATCH v3 13/30] grep: prepare for testing binary regexes containing rx metacharacters
Date:   Sat, 20 May 2017 21:42:16 +0000
Message-Id: <20170520214233.7183-14-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169
In-Reply-To: <20170520214233.7183-1-avarab@gmail.com>
References: <20170520214233.7183-1-avarab@gmail.com>
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

