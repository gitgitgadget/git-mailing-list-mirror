Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F412C19F29
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 01:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237313AbiHDBpx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Aug 2022 21:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiHDBpw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Aug 2022 21:45:52 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73053DBD1
        for <git@vger.kernel.org>; Wed,  3 Aug 2022 18:45:51 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id z16so23497508wrh.12
        for <git@vger.kernel.org>; Wed, 03 Aug 2022 18:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UWkmwEMmDQA88Knl6wRhhl/jDXRNKzlTXKO5NvbUwn8=;
        b=dHo6EOuMzKFgVkqhPzvSXF75Q7GBIjr/rs3P/WeaX5MG3FsoeP6UgLHyiPAZ2ur8rg
         rmHdXcyg6Y5hwNFi+2N32fX3plV2pTi+SPtB2Uf+CPasPGojmXosz/5ENhVaPTLATaor
         teJUgv6TvK76wI1dqgE+T1KECASudXeMT7Ka6xOadzvYauiv77vO0QjidnOs9061jrhC
         9AkifpTRFuTWkTovjm7TiiYT+NxVn4Y7TLoH+zrm9AMZ0TANuPzJ7HtnP4t78WPpg3TK
         58TDpglDPp1kZMRnKjTcR5CAB3+s88q0H3BHuHGLYmpIfPvKjQofM8j08VEUIlUqr/s9
         rt8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UWkmwEMmDQA88Knl6wRhhl/jDXRNKzlTXKO5NvbUwn8=;
        b=djH4T5parG/T4MzuqlCarYacfmXEVsd7T4ggEhBuzcMOpNjFz/Ad3O8eBSHldzlq1p
         KpjjjcFLxhGFUFpuTXcgNRf5xGt5Qf20MwJ3Z4zz+PaL0w4dQGqtqFIqiOI9ghwjtU6U
         i5y/q+P8IucXaPAIQUyCfH/L5vGgGiujKN2hq18+NZGaRCyWE5Iod34rXNXm3c+gsC8B
         LA7sIWf0NEZXiT95wgLGOte/nDOxuBtEtVnDrFMpBho63xBDhFF1Fk0NT9KXwRclE/iF
         oxGoTyVGmXP3w/FrIEaPceYkJcjVZPNRaUs92/j6LGHP5UU3I2wl6urYClAKvED7wfdV
         xm1A==
X-Gm-Message-State: ACgBeo1cDSBaUCOFi+JPw3EwAuPHpvbuyJp8wkrAN9MlY0IEcCdaJwnV
        037i9gd7z+xWCGtIs1LtjHbSbOiJlvs=
X-Google-Smtp-Source: AA6agR7wSBpsxYyH7SzW8CXUDhr8G4BUZ4PZoDYz/59BuUQ3F47qDqTmnbAeUH/Gz/6VholPvt6p4w==
X-Received: by 2002:a5d:6047:0:b0:220:6dc5:73ee with SMTP id j7-20020a5d6047000000b002206dc573eemr7183980wrt.213.1659577549837;
        Wed, 03 Aug 2022 18:45:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m38-20020a05600c3b2600b003a31df6af2esm4714709wms.1.2022.08.03.18.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 18:45:47 -0700 (PDT)
Message-Id: <ad5b60bf11ef099e709dc9b69d80c28e196c4543.1659577543.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1310.v2.git.1659577543.gitgitgadget@gmail.com>
References: <pull.1310.git.1659388498.gitgitgadget@gmail.com>
        <pull.1310.v2.git.1659577543.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 04 Aug 2022 01:45:34 +0000
Subject: [PATCH v2 01/10] scalar-diagnose: use "$GIT_UNZIP" in test
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, johannes.schindelin@gmx.de,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Use the "$GIT_UNZIP" test variable rather than verbatim 'unzip' to unzip the
'scalar diagnose' archive. Using "$GIT_UNZIP" is needed to run the Scalar
tests on systems where 'unzip' is not in the system path.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 contrib/scalar/t/t9099-scalar.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/scalar/t/t9099-scalar.sh b/contrib/scalar/t/t9099-scalar.sh
index 10b1172a8aa..fac86a57550 100755
--- a/contrib/scalar/t/t9099-scalar.sh
+++ b/contrib/scalar/t/t9099-scalar.sh
@@ -109,14 +109,14 @@ test_expect_success UNZIP 'scalar diagnose' '
 	sed -n "s/.*$SQ\\(.*\\.zip\\)$SQ.*/\\1/p" <err >zip_path &&
 	zip_path=$(cat zip_path) &&
 	test -n "$zip_path" &&
-	unzip -v "$zip_path" &&
+	"$GIT_UNZIP" -v "$zip_path" &&
 	folder=${zip_path%.zip} &&
 	test_path_is_missing "$folder" &&
-	unzip -p "$zip_path" diagnostics.log >out &&
+	"$GIT_UNZIP" -p "$zip_path" diagnostics.log >out &&
 	test_file_not_empty out &&
-	unzip -p "$zip_path" packs-local.txt >out &&
+	"$GIT_UNZIP" -p "$zip_path" packs-local.txt >out &&
 	grep "$(pwd)/.git/objects" out &&
-	unzip -p "$zip_path" objects-local.txt >out &&
+	"$GIT_UNZIP" -p "$zip_path" objects-local.txt >out &&
 	grep "^Total: [1-9]" out
 '
 
-- 
gitgitgadget

