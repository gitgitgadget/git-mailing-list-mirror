Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A2EC4332F
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 22:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbiDVWjb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 18:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234459AbiDVWiS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 18:38:18 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2E225E8FF
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 14:30:26 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id m14so12765055wrb.6
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 14:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mFpyM5A8F5CTNStnygjsu0b80j0bp2xHaOoaR8p93zY=;
        b=CqUERqpiRR8oaLeW9ozmgdl5nVLuxRwQVQgGyY2gwEeRrr4ewaCpPvq+ZKn7Fw8+vH
         BI9m0cESC8xEFYy9TF0G+7tkzReRM/8idAlXGeKbQwM30h8lHwCflh0Db7WQHPRy9c6r
         WaTBltjxjWuPEawvSQyU7J1qj3JqCWnHzZ6aGH8YWIFLFvVf8F6CcI/ziMb6oV3XapP4
         KMr9uqS1YYpOth/7t5k5W4raPgYHpc2Fy8xtbxEBNomhU9GzEc8ko7kcS+TaUShBmBIL
         ipO70fAaxcgVN5wyX28a7SH5iC8/MHpuo69CpexaIUbGeRdWN0LsozXv1c0dupNS/MGg
         Un1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mFpyM5A8F5CTNStnygjsu0b80j0bp2xHaOoaR8p93zY=;
        b=UD+XvGzobv20yeMACwFe9M1/QvYuuhjRqFDzbCUFjue/QsB3sc/6Ni1xP2GuQvcRfl
         TLJdney4bktgxi+awN2LQLyCmpl18qTGhXZZuIEmMRpnOf/BMv9k5K1jE0Rc89uBRj1J
         C8hvL0DrrGpUXBWu4kF4gg6iT2Z8yLpUmzMTNfzZW7Hi3UcXOyE657osbZ3PV1H+15DZ
         WKESsYlzNmf+4TeqmGAuHWb6Z9WFmYexTXvtvaUAz3QyfnDfU/xP9/3Xmt2mo/utwfWW
         psIIeuZ6UJtEBfaM6Zcy7k1c03oHRhQ4pZyj+k4VVxh/MjfyRA2qmE8rE4QlyVmNgl+6
         Qvxw==
X-Gm-Message-State: AOAM5331fPwKgAH1yazH47qfXHBIyxA+XFBf+nwmloVPGsSN3oJed3wX
        F+0/n1ur8eOnh1VeNSWUUxrl5A4UQXw=
X-Google-Smtp-Source: ABdhPJyi2I0R/dFzVJGE5liTTxtxhZg4jA3XyOH7OL8O4lV1m3apPf5UUvyftGCHCjpEtzC0jrYtnw==
X-Received: by 2002:a5d:47a4:0:b0:20a:c95e:b3f3 with SMTP id 4-20020a5d47a4000000b0020ac95eb3f3mr4055542wrb.663.1650663024997;
        Fri, 22 Apr 2022 14:30:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u7-20020a05600c19c700b003928959f92dsm5865439wmq.2.2022.04.22.14.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 14:30:24 -0700 (PDT)
Message-Id: <4efb3a438389249b3d9f9b388d7f04d74aaa2f92.1650662994.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
References: <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>
        <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Apr 2022 21:29:53 +0000
Subject: [PATCH v6 27/28] t7527: test Unicode NFC/NFD handling on MacOS
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
index 1cdbacdbfb0..ab29cca535d 100755
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

