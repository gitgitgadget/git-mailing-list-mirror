Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AECEC433F5
	for <git@archiver.kernel.org>; Mon, 23 May 2022 20:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbiEWUOz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 16:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232695AbiEWUNv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 16:13:51 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7D0AE265
        for <git@vger.kernel.org>; Mon, 23 May 2022 13:13:23 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id r23so22935717wrr.2
        for <git@vger.kernel.org>; Mon, 23 May 2022 13:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Z9IxtYpTOmmUNIoUdSuKzuSelfyJ5z/hHgvnSuipErQ=;
        b=oz0G28uu/P1qfbadluoZ5mu0tWDBHgwum/blG2Ru7Q8bJjtcTWw/LP9qLTRunfOrsm
         6HLA82ojkcKOSbfQkFTcl0Hy7p6x72g5kmSEJLxod5YD/namI3ekIucyE1t5khzKLn9i
         5QvuWmvLVeq72IJ4V9WDtl3ueR9rsShNLV9KJt02cQ3YA7HyXNfr40E1vqH8eB87H+8G
         5DzBtcmhiRh6MlEbg11C4BkjoB+N7b9NSnDoJssqC7NKChmVCsjiPBDIvyA941BE7/2J
         Fwct13NcjImCtA/mOwu4EjsftT6uVaiBxBnpLIm6KUAx5q+JUd/MdGoNizNMDFZ8nrX8
         x61A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Z9IxtYpTOmmUNIoUdSuKzuSelfyJ5z/hHgvnSuipErQ=;
        b=p4NprghI6Jbde8cka5cmo0hLOF3FSA9i+7vIkrHnGx2bNTBKj1fR27SfbrAWDYWrnf
         5p/ps8yUr0s5SvyjnWR/Ca9JXu/EO09o0Ytbm/EbJIE+UVXU3IsUsxHZLeKxorq0GFTr
         giK8FUf7u4eb/EaFmp7owyCSvagz0N4fuWna/3PLb+Lih1873j+iHTeKK+CtgWYBEobr
         GNKxZ5hsorP3TcqbupcDY8+I1dD9Fx+RwX5HJ8bkusmmPSPZ/5wKyWZOSlZkMJrJjj0W
         MqKVhXnqjcLOdUg0y4QNR1zq0EvpkhX4Xosu8/sxqVXR5xeNcm2HjFF5N2m/Ax3e6RZ0
         sx5w==
X-Gm-Message-State: AOAM530CSQdPL5hveM6ke5IoikCassBapl2/GqK5FWt5D9gDuYuxiBQI
        S0h1uU9mnqkxkR04TOZXdnDxORWRG6w=
X-Google-Smtp-Source: ABdhPJwu8jB/OjrUjfGpRdg2rEy6+JFVUhrjRd4eSxGbPEFZp5zjQBffJwWb3O1xLjdNm+8po7AdeA==
X-Received: by 2002:a5d:47af:0:b0:20f:eb21:245f with SMTP id 15-20020a5d47af000000b0020feb21245fmr2468829wrb.6.1653336802817;
        Mon, 23 May 2022 13:13:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id az37-20020a05600c602500b0039746638d6esm168029wmb.33.2022.05.23.13.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 13:13:22 -0700 (PDT)
Message-Id: <f9a7869d202b5c3fc953967ab6e9e032e7450e79.1653336765.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
References: <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
        <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 May 2022 20:12:43 +0000
Subject: [PATCH v7 28/30] t7527: test Unicode NFC/NFD handling on MacOS
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
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
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
index fbb7d6aef6e..9edae3ed830 100755
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

