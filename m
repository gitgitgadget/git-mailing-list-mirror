Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E4BD1F453
	for <e@80x24.org>; Tue, 30 Oct 2018 18:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbeJaDi2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 23:38:28 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37611 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbeJaDi2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 23:38:28 -0400
Received: by mail-wm1-f65.google.com with SMTP id p2-v6so12299623wmc.2
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 11:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jHUG3Zna9to3SZZLmgz3hzLh000Dh0hSSqUNMS4S9YY=;
        b=HJoJBxLaGK/UYwaicqRv0hNGa7zXk+rcp52rGnrc8yS3L5wGsOZbCN2jWhJ0vSZJUu
         o4yIK/1CkWONgkgWyv+pGs3mUTmCDl0XEwpiwLtkzlVYYjr03eSlKUliErfvpitD/kTd
         DXDv5E+K34C1gnU2KlRXJ/rRJSgEJyKyap9b6WNgunvybburJIHrd7TnIxCByH5wuMU0
         +X9WdPbg0SQYW5FeHwbl6RUTXudQrR9BI39oj6q6LZSg510hAk1xeNlmewy+WUUnsupS
         pwPElA83yrGROfX9pVRtPMZBmXxrQ9vqc0/3BKYVsvWVmhEL6lwPGnpSC5VMe36gZqLI
         A5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jHUG3Zna9to3SZZLmgz3hzLh000Dh0hSSqUNMS4S9YY=;
        b=fao3n7MbcjAqBkqJzYxATQSsbT9axKQmgpfhRaow4OGH/tcQDGLWmh1P8iXYou/5zS
         dSOHepk1kzgQ7CqBwo/srT7en6q4t1gv/IMFGXnFfr/je4IgwNjweYdRTrEUnbVYQ/tk
         S638HCn1fieHKFIYkpuYfdKuVgfeN9Fk74uwhYLUzKRXKxQogcE7D3wMyyDo0eLkwKU2
         wzdAMBNO/RcZ0a1k9Lws+DUJYXKy2E3R73FvOkDbRRHJhN/BVXK39ivqwlhmhLBNnOoO
         QoVAmtOsAkrOZqFT3MeSO/Dwyy3xcin/jKlMqRNUOfmrN5JrQqbm2utVx7SMLBx6/BFJ
         cPgQ==
X-Gm-Message-State: AGRZ1gJJ/eU+IfLRFCM4wxoRjE5PwNCVBPRfbhOyLccH+bsMEkf/XWgA
        U5Z7ZJ99kBqMRPfEqtliIW3s4hRV
X-Google-Smtp-Source: AJdET5cazDCQBtpX3at3QpI0g0ela70qd6qHm4Do6K0sLwo4SJTBHK+Qv08xUFySNGGwWqU6WqpiIg==
X-Received: by 2002:a1c:868e:: with SMTP id i136-v6mr49928wmd.50.1540925027757;
        Tue, 30 Oct 2018 11:43:47 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k66-v6sm9999825wmd.47.2018.10.30.11.43.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 11:43:47 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Geert Jansen <gerardu@amazon.com>,
        Christian Couder <christian.couder@gmail.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Petr Baudis <pasky@ucw.cz>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/3] index-pack tests: don't leave test repo dirty at end
Date:   Tue, 30 Oct 2018 18:43:31 +0000
Message-Id: <20181030184331.27264-4-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.899.g0250525e69
In-Reply-To: <20181028225023.26427-1-avarab@gmail.com>
References: <20181028225023.26427-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change a test added in 51054177b3 ("index-pack: detect local
corruption in collision check", 2017-04-01) so that the repository
isn't left dirty at the end.

Due to the caveats explained in 720dae5a19 ("config doc: elaborate on
fetch.fsckObjects security", 2018-07-27) even a "fetch" that fails
will write to the local object store, so let's copy the bit-error test
directory before running this test.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1060-object-corruption.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/t1060-object-corruption.sh b/t/t1060-object-corruption.sh
index ac1f189fd2..4feb65157d 100755
--- a/t/t1060-object-corruption.sh
+++ b/t/t1060-object-corruption.sh
@@ -117,8 +117,10 @@ test_expect_failure 'clone --local detects misnamed objects' '
 '
 
 test_expect_success 'fetch into corrupted repo with index-pack' '
+	cp -R bit-error bit-error-cp &&
+	test_when_finished "rm -rf bit-error-cp" &&
 	(
-		cd bit-error &&
+		cd bit-error-cp &&
 		test_must_fail git -c transfer.unpackLimit=1 \
 			fetch ../no-bit-error 2>stderr &&
 		test_i18ngrep ! -i collision stderr
-- 
2.19.1.899.g0250525e69

