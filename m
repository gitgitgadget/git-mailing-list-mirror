Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 465EF211B3
	for <e@80x24.org>; Tue,  4 Dec 2018 13:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbeLDN1Z (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 08:27:25 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51471 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbeLDN1Y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Dec 2018 08:27:24 -0500
Received: by mail-wm1-f65.google.com with SMTP id s14so9619680wmh.1
        for <git@vger.kernel.org>; Tue, 04 Dec 2018 05:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=anv3R5BIcWXhqjtUM9rlrbSpb7kjRg5tyczvk27cQ8s=;
        b=I02g75boYvNgM84+ZXUuAMUKRcBcGuV3Te+wMKCOEGL19+U/iO+nAN2Yy1el3x7wNe
         mNkT1C3MxTtvmMfevh74uFNSdvW9J9rSmGt13C2oR0fRGrDailYpJWtwmdJ1h0XbZRsQ
         ox2tTeD9Mz5wUFNwT5Kxo/XeVProvqYmcPK6a0/dxGFVjqHlgpUbV2Whsac8SXfx6+H/
         c/qJW1+Hz4e/9Phvk4X+DuENsQ8zBcl0JwRdCAz7AEpTbsxMqPFnxGZ+227+D1NVUd/f
         6bLMsI9LXIa2JqPuUSAhMNtNgV0SGIJ1jOqUoFyUUQ3KHiq9JaYwvPDHposVCrtunpxw
         tzJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=anv3R5BIcWXhqjtUM9rlrbSpb7kjRg5tyczvk27cQ8s=;
        b=NXTRc+Sm/dyyjoS9lmi1/T02RIF9LfaSsb5FmYBEiv2MeQsfj26PPPxZsqNdWX4xRW
         KDdHQKzqArYhgu57itsJbAM5o35rvxvMXgA+363aq0VtIJSwksraC+8UhCiutigaHEOb
         gf1hXk774XVPd7AB8+vgvIIgBgI2fbDBS/561kn0LhZBewQYiS4kbKht/Gaw1WTpKRdd
         VDxyoYNvs0X/1YXfc8yv8dAbeFDhVzZhQyc4K4hlR44qdWTCG44/PYvQZ2nC5Kp80Efh
         bB3xZFJiJBJJNuHVdS90spkbW4kgVsF4TrdH16TS62cCfonWRWT68BpTd7qLr7fXS315
         KtVw==
X-Gm-Message-State: AA+aEWa14rWiw5Qa3outrGrSRgOU8nrv871jbKya62gQJVg9h8J8Z9Ht
        LdUP0hv+7oSWbhsAWY9HyX7C/Qsu
X-Google-Smtp-Source: AFSGD/Vtu8UrZdvKWS8vMjxQaRF3Nyh+QLJvXI/IdV8ND3e7NFDOHvXZ2gcVqz1EoDIbI8kya7q2Xw==
X-Received: by 2002:a1c:c303:: with SMTP id t3mr11646178wmf.94.1543930042074;
        Tue, 04 Dec 2018 05:27:22 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h16sm24588523wrb.62.2018.12.04.05.27.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 05:27:21 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Derrick Stolee <stolee@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/3] sha1-file: test the error behavior of alt_odb_usable()
Date:   Tue,  4 Dec 2018 14:27:14 +0100
Message-Id: <20181204132716.19208-2-avarab@gmail.com>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805
In-Reply-To: <87tvjtvah0.fsf@evledraar.gmail.com>
References: <87tvjtvah0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a test for the error() case in alt_odb_usable() where an alternate
directory doesn't exist. This behavior has been the same since
26125f6b9b ("detect broken alternates.", 2006-02-22), but if that
error() was turned into die() the entire test suite would still pass.

Perhaps we should die() in that case, but let's start by adding a test
here to assert the long-standing existing behavior.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5613-info-alternate.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/t5613-info-alternate.sh b/t/t5613-info-alternate.sh
index 895f46bb91..d2964c57b7 100755
--- a/t/t5613-info-alternate.sh
+++ b/t/t5613-info-alternate.sh
@@ -136,4 +136,11 @@ test_expect_success CASE_INSENSITIVE_FS 'dup finding can be case-insensitive' '
 	test_cmp expect actual.alternates
 '
 
+test_expect_success 'print "error" on non-existing alternate' '
+	git init --bare I &&
+	echo DOES_NOT_EXIST >I/objects/info/alternates &&
+	git -C I fsck 2>stderr &&
+	test_i18ngrep "does not exist; check" stderr
+'
+
 test_done
-- 
2.20.0.rc2.403.gdbc3b29805

