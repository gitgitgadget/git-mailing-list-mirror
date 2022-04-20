Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DB6C433F5
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 20:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382210AbiDTUrb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 16:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382203AbiDTUrK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 16:47:10 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275083CA63
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 13:43:57 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id c10so3880680wrb.1
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 13:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=49gznKgXXcaypBPlROyAWAIsdUble1wg/o3vHy/Znr4=;
        b=OQfBjneq8+g1B9khs3NnBTBaqkcadQvSKD+AXh8Q5YzB3/UNRfIinlhgJOJsd/oqhj
         KX5048/PU9BVdSAIyk8i6OlYoiDREfcxLPIOe9kXsRhrOuVNzbLEMZTYYea6hJ7H2fma
         +6Yc2oq8hOQ6nPYFhhcGnRIxGltJEH1SgnofAM556G4rKWSJHXoEC/dQjNiJtN/AYf2j
         sSsPoSCiwsbXAgeIShmqevDbTfpKUDSG2TQxIk0oauQC6JHm3AsHIYhKc5Hcl5BW+5wH
         xOsxAaRUNpOkQmoFGx/uDgajVYoIMLr+ykJF/Ifl6Uc8fcWWIrr+0bvVSx+G4hew0tVJ
         gkyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=49gznKgXXcaypBPlROyAWAIsdUble1wg/o3vHy/Znr4=;
        b=wbNrW23+h9Fhd6UyjFhI9UEwVeorrjmX5xo6F6TW5hwNjljs5tWvpytEGrIfyYSylD
         6XEPiupQhWa2HHqAwruz2yPmgjOkliTyte8l8O/SSueXnjK7QCFi3YebKLO77Gx5RJMg
         0w3c36aZ8N6NCFCvivqxLy1mW8jo9kHPmPQawPgdBxOeGjV0Qhh9Ts6epUCE75hnju66
         jdFIir+adOtakt2CdCnVd2ycJ+eqiA70+sRvB1oQUM1Xo3zRWm0ERKSLUzk8HS1T5so3
         E/tg4pqi6+m34gOnn7ST7C39M2CfH4BGlP6G/XRmSgRX1XSTLIXRdlAuHTtVlGvHq//P
         9ZtQ==
X-Gm-Message-State: AOAM531M7kekOQ4kqdhw5E72HzZKT6+7Us0v+2864w2ByAksIaeIMr+w
        XGpkqdmIOTdlCPoN8xE3wpnlL069JOs=
X-Google-Smtp-Source: ABdhPJxbFeYLt5V7qsjhVAnM1WNbsWRwDcqkmJFpLP31xpUPn5ugojsQEN5MbX1BcMcRGa2pOs0ChA==
X-Received: by 2002:adf:8b10:0:b0:20a:b1af:5597 with SMTP id n16-20020adf8b10000000b0020ab1af5597mr3135381wra.677.1650487435331;
        Wed, 20 Apr 2022 13:43:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d18-20020a05600c34d200b0038ed14b7ac3sm319180wmq.40.2022.04.20.13.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 13:43:54 -0700 (PDT)
Message-Id: <9724c41d18d4429f8993c9cf83e7622eca079c46.1650487399.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>
References: <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
        <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 Apr 2022 20:43:17 +0000
Subject: [PATCH v5 27/28] t7527: test Unicode NFC/NFD handling on MacOS
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        rsbecker@nexbridge.com, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Confirm that the daemon reports events using the on-disk
spelling for Unicode NFC/NFD characters.  On APFS we still
have Unicode aliasing, so we cannot create two files that
only differ by NFC/NFD, but the on-disk format preserves
the spelling used to create the file.  On HFS+ we also
have aliasing, but the path is always stored on disk in
NFD.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/t7527-builtin-fsmonitor.sh | 55 ++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index a4f8008fea7..5476a01cbff 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -868,4 +868,59 @@ test_expect_success CASE_INSENSITIVE_FS 'case insensitive+preserving' '
 	egrep "^event: abc/def/xyz$" ./insensitive.trace
 '
 
+# The variable "unicode_debug" is defined in the following library
+# script to dump information about how the (OS, FS) handles Unicode
+# composition.  Uncomment the following line if you want to enable it.
+#
+# unicode_debug=true
+
+. "$TEST_DIRECTORY/lib-unicode-nfc-nfd.sh"
+
+# See if the OS or filesystem does NFC/NFD aliasing/munging.
+#
+# The daemon should err on the side of caution and send BOTH the
+# NFC and NFD forms.  It does not know the original spelling of
+# the pathname (how the user thinks it should be spelled), so
+# emit both and let the client decide (when necessary).  This is
+# similar to "core.precomposeUnicode".
+#
+test_expect_success !UNICODE_COMPOSITION_SENSITIVE 'Unicode nfc/nfd' '
+	test_when_finished "stop_daemon_delete_repo test_unicode" &&
+
+	git init test_unicode &&
+
+	start_daemon -C test_unicode --tf "$PWD/unicode.trace" &&
+
+	# Create a directory using an NFC spelling.
+	#
+	mkdir test_unicode/nfc &&
+	mkdir test_unicode/nfc/c_${utf8_nfc} &&
+
+	# Create a directory using an NFD spelling.
+	#
+	mkdir test_unicode/nfd &&
+	mkdir test_unicode/nfd/d_${utf8_nfd} &&
+
+	git -C test_unicode fsmonitor--daemon stop &&
+
+	if test_have_prereq UNICODE_NFC_PRESERVED
+	then
+		# We should have seen NFC event from OS.
+		# We should not have synthesized an NFD event.
+		egrep    "^event: nfc/c_${utf8_nfc}/?$" ./unicode.trace &&
+		egrep -v "^event: nfc/c_${utf8_nfd}/?$" ./unicode.trace
+	else
+		# We should have seen NFD event from OS.
+		# We should have synthesized an NFC event.
+		egrep "^event: nfc/c_${utf8_nfd}/?$" ./unicode.trace &&
+		egrep "^event: nfc/c_${utf8_nfc}/?$" ./unicode.trace
+	fi &&
+
+	# We assume UNICODE_NFD_PRESERVED.
+	# We should have seen explicit NFD from OS.
+	# We should have synthesized an NFC event.
+	egrep "^event: nfd/d_${utf8_nfd}/?$" ./unicode.trace &&
+	egrep "^event: nfd/d_${utf8_nfc}/?$" ./unicode.trace
+'
+
 test_done
-- 
gitgitgadget

