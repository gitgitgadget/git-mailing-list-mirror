Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD96C433EF
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 18:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240373AbiCVS0t (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 14:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240381AbiCVS0U (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 14:26:20 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2094190FFD
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:24:11 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id a1so23265248wrh.10
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hFzBo7NPjbtbf/vT0CCaUkDt4/D28hCpl05V0u76UiM=;
        b=PuAPlyF29vZvmiStQlJCWIVGKCzXfE4SoaVV2eXBKMXOACsOtgnOH6lJch0I/8EEnF
         JcyWeMMlwOnanbrsilFgMWdIHM8vhmvrJSLz1ukrLwOas7hhhdHXBZ7cnhwudyMyUeqo
         5m/0bGV3efjwTj8vFTkAoIGoggvSqSfcZC/BSWbWs/P7ckx4Kv8Ym7fZiUU5/HJ6kOxg
         MiZXB8tH2PgC9IShTXfU9fIw8bjFgRIY61ao8K0TmhPqZF87WEh4qOlJMiWfag5amo5w
         BG/SDpDI4Qb4xbPoidMF2PwrjRYJj0XKbQIHlga5gNGrZDbBvH4RKZyjEzFH/VOFVk4Z
         Wv+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hFzBo7NPjbtbf/vT0CCaUkDt4/D28hCpl05V0u76UiM=;
        b=pwDvuuUn39pc4U98hFk4IjmoY20BpAJiQRX/VA3EplJoRJAQD4x260fZYZGhn7TApR
         zNl6jH+SLa+H91IbdYgRQnjeofMs/HUif4uyd5CStv/g9z/P/rj66ooEnZs0BEelZDTZ
         PfKsFt5whpCNX8m2rAPNNkjyGZ/6j0TzXbgdcz7+nghskffKCDUrcQ2srJr7BgmPmgEp
         fHgMU27VdnfzZXDQ8J8a/ku+kv44Nny9+W+7vEQV5WBxYqyBVBHgLSwW6VrNY+tvqY/Z
         +yu66akijPM5G6Xzp7Du4Qr0nrVYUup9xNgK4hkbld9fAwYuZxANTw7v7d1cvfxL13/P
         wKdw==
X-Gm-Message-State: AOAM532xHYb0ppOK1d4Hpp3qQAR7HZuSZ6bXvwAaOZpaH+/EB3b2CEdI
        RPh9EUFrHgflJzrsD/YCqRvSt4YTaWw=
X-Google-Smtp-Source: ABdhPJw26sfZct5bgkg3cFjj3fiJZ1NbKVeIC34rC7faIe/MIvOiEtPPsBePiWPtjKL/mHv4jeOHAg==
X-Received: by 2002:a5d:6c68:0:b0:205:80f5:4210 with SMTP id r8-20020a5d6c68000000b0020580f54210mr1562914wrz.512.1647973449496;
        Tue, 22 Mar 2022 11:24:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r13-20020adfbb0d000000b00203e0efdd3bsm16070038wrg.107.2022.03.22.11.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 11:24:08 -0700 (PDT)
Message-Id: <aa96a849ce44056f142f9972052a2ff7c34e7401.1647973380.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v3.git.1647973380.gitgitgadget@gmail.com>
References: <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
        <pull.1143.v3.git.1647973380.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Mar 2022 18:23:00 +0000
Subject: [PATCH v3 27/27] t7527: test Unicode NFC/NFD handling on MacOS
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
        rsbecker@nexbridge.com, Jeff Hostetler <jeffhost@microsoft.com>,
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
index 51cdf05e7ec..126bb2dc8de 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -847,4 +847,59 @@ test_expect_success CASE_INSENSITIVE_FS 'case insensitive+preserving' '
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
+	start_daemon -C test_unicode -tf "$PWD/unicode.trace" &&
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
