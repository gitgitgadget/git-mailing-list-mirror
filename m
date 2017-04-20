Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB134207BE
	for <e@80x24.org>; Thu, 20 Apr 2017 21:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S947783AbdDTVYQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 17:24:16 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35283 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S943485AbdDTVYO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 17:24:14 -0400
Received: by mail-wr0-f196.google.com with SMTP id l44so9431291wrc.2
        for <git@vger.kernel.org>; Thu, 20 Apr 2017 14:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CcKirEDw/BK8THeqRiSpRy2Ya5BeiKnvFgH33Fz9iK4=;
        b=HFdlMqPt7Pk4+XZwIL68FFxYlw4kn3DaP1iSaBePkjMbx0aSAiVu0LDyh3AH8ikBtt
         DldjrJM6LqE0X++4BLWirLmfMgMuSQ0XgpplhYNuMRtoqltzZLbAKTszfvDtWiEYtfxS
         PDcJ+O3UPCt3C/Mrux19zh5slAoU+aVf9FPOja4cbp8+9hLTgivho0aJX0DGuylF6WNz
         Iet5ecrr8vlKHrFzdchMD0uuN4buGUclyMi2kbWPX9ebMaNHdAUW115VYXo2lgGggI85
         0GP52STG8+jLHxYZfVRLRsX3otyZE4l0ultx9IArSI7UEXYu+/7/5iXUWRrXrcLKy0dz
         K4yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CcKirEDw/BK8THeqRiSpRy2Ya5BeiKnvFgH33Fz9iK4=;
        b=RERncgjm5yyBeGEAqjh97QHwzu7h/h0xPChWso3O2gi5gAM8FS+5k3pRoftSfnYa04
         jpwVcLz/yHvMUXUdNCPJwLckEOxAiAGAWXrR3C9G353CBDvgcfeqmOYkrDULC5u0u28f
         JbAsOs1HnYUbauSj4PBpcCLbhpOLPmRlreEvoEhcdRw2B5UK7rc4ylrSMI3iA3fMdc+n
         eeu2LwAHf27sCWmf55a9DgZXgu+OdrDaDatbna7UK6Fiz4lCHa6bVKbfdbzbj4U6NxgI
         SBENIsTa//yfzYvpkOPSKhfyD4JnikWlzOWMZK9T1kNCOPA/IdGDPI+k2xnTiwzAloxu
         EjWw==
X-Gm-Message-State: AN3rC/6zJ47rOajbXnCnvohBLu5de82PowR8wHi5xpZV0F3e4Lg61lXO
        zaO431AQloFYLg==
X-Received: by 10.223.175.218 with SMTP id y26mr9252379wrd.63.1492723452826;
        Thu, 20 Apr 2017 14:24:12 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k63sm442322wmf.9.2017.04.20.14.24.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Apr 2017 14:24:11 -0700 (PDT)
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
        =?UTF-8?q?Zolt=C3=A1n=20Herczeg?= <hzmester@freemail.hu>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 02/18] grep: add tests for grep pattern types being passed to submodules
Date:   Thu, 20 Apr 2017 21:23:29 +0000
Message-Id: <20170420212345.7408-3-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170420212345.7408-1-avarab@gmail.com>
References: <20170420212345.7408-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add testing for grep pattern types being correctly passed to
submodules. The pattern "(.|.)[\d]" matches differently under
fixed (not at all), and then matches different lines under
basic/extended & perl regular expressions, so this change asserts that
the pattern type is passed along correctly.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t7814-grep-recurse-submodules.sh | 49 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
index 3c580b38ba..ef658b7899 100755
--- a/t/t7814-grep-recurse-submodules.sh
+++ b/t/t7814-grep-recurse-submodules.sh
@@ -313,4 +313,53 @@ test_incompatible_with_recurse_submodules ()
 test_incompatible_with_recurse_submodules --untracked
 test_incompatible_with_recurse_submodules --no-index
 
+test_expect_success 'grep --recurse-submodules should pass the pattern type along' '
+	# Fixed
+	test_must_fail git grep -F --recurse-submodules -e "(.|.)[\d]" &&
+	test_must_fail git -c grep.patternType=fixed grep --recurse-submodules -e "(.|.)[\d]" &&
+
+	# Basic
+	git grep -G --recurse-submodules -e "(.|.)[\d]" >actual &&
+	cat >expect <<-\EOF &&
+	a:(1|2)d(3|4)
+	submodule/a:(1|2)d(3|4)
+	submodule/sub/a:(1|2)d(3|4)
+	EOF
+	test_cmp expect actual &&
+	git -c grep.patternType=basic grep --recurse-submodules -e "(.|.)[\d]" >actual &&
+	test_cmp expect actual &&
+
+	# Extended
+	git grep -E --recurse-submodules -e "(.|.)[\d]" >actual &&
+	cat >expect <<-\EOF &&
+	.gitmodules:[submodule "submodule"]
+	.gitmodules:	path = submodule
+	.gitmodules:	url = ./submodule
+	a:(1|2)d(3|4)
+	submodule/.gitmodules:[submodule "sub"]
+	submodule/a:(1|2)d(3|4)
+	submodule/sub/a:(1|2)d(3|4)
+	EOF
+	test_cmp expect actual &&
+	git -c grep.patternType=extended grep --recurse-submodules -e "(.|.)[\d]" >actual &&
+	test_cmp expect actual &&
+	git -c grep.extendedRegexp=true grep --recurse-submodules -e "(.|.)[\d]" >actual &&
+	test_cmp expect actual &&
+
+	# Perl
+	if test_have_prereq PCRE
+	then
+		git grep -P --recurse-submodules -e "(.|.)[\d]" >actual &&
+		cat >expect <<-\EOF &&
+		a:(1|2)d(3|4)
+		b/b:(3|4)
+		submodule/a:(1|2)d(3|4)
+		submodule/sub/a:(1|2)d(3|4)
+		EOF
+		test_cmp expect actual &&
+		git -c grep.patternType=perl grep --recurse-submodules -e "(.|.)[\d]" >actual &&
+		test_cmp expect actual
+	fi
+'
+
 test_done
-- 
2.11.0

