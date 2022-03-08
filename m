Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA30C433EF
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 22:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350730AbiCHWRj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 17:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350723AbiCHWRA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 17:17:00 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A924658394
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 14:15:57 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id t11so256853wrm.5
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 14:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RuvnNt5XyOl7a++pYSyJu9F102IfAfVCdDUqPCvNqSk=;
        b=Ccs6giRyHYyFfeX2r5DCMK01PDbMSGODWcpQE15oGYLflI5c5icrW+vy+9XtvuZET5
         f9wAPARl34AZUizsAs0MEHiQEFcwwaTZ0GLn6qesy7XFyeIIFIimXQWmiKzA6DVNFtrC
         SpnH7QoB2PYFes2K9Nv/37wguBtsg8638O2peXHZ//FISKlMfnZBgnCnJXckCM/tMQg7
         c0JyXLQqA3fcg1A8Q1CWaWbWCpPNQa8HHOFoEgbWkWR9ntnunLzGYztdQbRabCQvp49c
         rpao5QVcghhxza0CgnlOr1dQ2kbAEee5AYj1z4Q2+lVi9WHUV4XkKEk/LN3P37QxTFWo
         sSBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RuvnNt5XyOl7a++pYSyJu9F102IfAfVCdDUqPCvNqSk=;
        b=VQ8BM8ELBoncCepyheEuQj0HEMutdZoVT2eiE9FVnJr4Y9AYdHUpIQXSQiInymfztQ
         KekfYLIdVlibBy8SLhIY9fR8hfFSFuR25BqkAPlZSFRkOhd8w/xXdxHs5adt1PF2zfKN
         WvmrIIZTcgjUWlaFiU2J/iTOtXDxiHa/7tdX0IJggGcYwX8CmZU8hyqWssIaHkuSmu0e
         9Njne6Z2JagEiygekGJH8hv1oRCXSUHAq4eLPTSdfQXSLQEbs/wL8MwJ5fQu7DtvbNPi
         H1LBCxoCkWh514qz/tG1s+hSIAFxddhc1DYa31qULriKkzikMRsDwxFqEJVnEQy+tsEg
         3ooA==
X-Gm-Message-State: AOAM531TutEZvn8YpbBGQWTalqJwP8j7KnPIrBWraBIO2Ngg/4ABLqPD
        f5ZRxMeG+85pKylX06SwbzXqtoeucDA=
X-Google-Smtp-Source: ABdhPJwRyM2mu0LPDeo/747efWHhGyPN2hqs9QGQ5Ki5Rq5uk7osC/vta73rled2lmwW8Xgcl4CJXw==
X-Received: by 2002:adf:dfc2:0:b0:1f0:262a:d831 with SMTP id q2-20020adfdfc2000000b001f0262ad831mr13036443wrn.589.1646777756151;
        Tue, 08 Mar 2022 14:15:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e20-20020adfa454000000b001f01a14dce8sm86147wra.97.2022.03.08.14.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 14:15:55 -0800 (PST)
Message-Id: <a45c1fd3000802ef3c8855bd3e9d7c3f2b11f6fd.1646777728.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
        <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Mar 2022 22:15:26 +0000
Subject: [PATCH v2 26/27] t7527: test Unicode NFC/NFD handling on MacOS
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
 t/t7527-builtin-fsmonitor.sh | 54 ++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index a41e37236b5..48c9125d8da 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -861,4 +861,58 @@ test_expect_success CASE_INSENSITIVE_FS 'case insensitive+preserving' '
 	egrep "^event: abc/def/xyz$" ./insensitive.trace
 '
 
+unicode_debug=0
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
+	(
+		GIT_TRACE_FSMONITOR="$(pwd)/unicode.trace" &&
+		export GIT_TRACE_FSMONITOR &&
+
+		start_daemon test_unicode
+	) &&
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

