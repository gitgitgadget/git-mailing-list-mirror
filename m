Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198AAC433EF
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 16:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352069AbiCXQyh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 12:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352000AbiCXQyV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 12:54:21 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63771B1880
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:52:00 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id h4so7461861wrc.13
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FkHtcUIpCvBMRQq6VQNQWGVHNfetkHBIIGiWhruIogg=;
        b=jnZNjXm3EKpxGWmK80uZt0jDoKyklPkoHzLNL/Rb8oL1VJZSYU0zAWokJD8oTdape4
         cLtwq6orLRASJcJom3iDFeE3WQ+Go55MANmeQWTQGHWOEP1xukTYHBleK4aOX5AEl70I
         g7LvcJBcS1DgwZo9iOKYhPuqb9ZilqdtPqTDCeuYhtjpCM/vvqHwt2039MQBTtg8tha2
         8v4qdoPWvwH8DxEauXLzbaOKrihthmqdLQf+2tvtMBbS3BtpGdcX4SqwkXAEFPP9gN3E
         mvdEIVyk4fZESEncz0W256x1CCx/c2S8PBCF+eKsNA11F4GIiobJsZA2saJ0TcRoFuwX
         bFYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FkHtcUIpCvBMRQq6VQNQWGVHNfetkHBIIGiWhruIogg=;
        b=5VMpqAnMs7ylkuk/EtgNM19v8o0zwJtVbrVSSAXjp3XYoVu44pbQpVHgjFhtGa4e8W
         /1YJBzwW2JzIfYTiuerl9dMSiD7HuA0IE8+m1RUk7cFi0YTaDTpObE0zD/TuOGM+U1/E
         uqR07FsZwld/BarAuMZva8JXmJD/inB5Vt0K+MNLoe1Fb9FBUfgUWJiPooBgHsxjLP8F
         HBzWbS9IoPdNOVssC7YHjmUOyE+TO+ADe3s/iTaEBJSD7zlOZ7F7mZo7pAMtadKa0Uel
         AfPw9No6VNy/6GHgylMNqthbMlca02v0mPkInvKNlKgYba/i4xOigKqG3PXrOo/2G3Qz
         JY2g==
X-Gm-Message-State: AOAM533O8RrEj3RCcbfstGkk0dpSxTvcQXngvZFtj+bP2jrvFUXzKqhu
        T0xZTcwYJkqvmp7wvYCfJ/zGoeetg0E=
X-Google-Smtp-Source: ABdhPJwmpVZlqk/6PimZUNIloxw5eegAYSDkdyToRZlrMfDdu0J9idU1SBi11qG5kyzovs09CU3iDw==
X-Received: by 2002:a5d:598e:0:b0:205:9da6:1621 with SMTP id n14-20020a5d598e000000b002059da61621mr983595wri.573.1648140718802;
        Thu, 24 Mar 2022 09:51:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r13-20020adfbb0d000000b00203e0efdd3bsm3168053wrg.107.2022.03.24.09.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 09:51:58 -0700 (PDT)
Message-Id: <176c530c3fa9a3ee7c6b2e55d440feaa09093480.1648140680.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
References: <pull.1143.v3.git.1647973380.gitgitgadget@gmail.com>
        <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Mar 2022 16:51:20 +0000
Subject: [PATCH v4 27/27] t7527: test Unicode NFC/NFD handling on MacOS
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
index 0b92a9bc22f..3f4e1c2ad7c 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -861,4 +861,59 @@ test_expect_success CASE_INSENSITIVE_FS 'case insensitive+preserving' '
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
