Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB03C433EF
	for <git@archiver.kernel.org>; Mon, 23 May 2022 20:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbiEWUPT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 16:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbiEWUNw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 16:13:52 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361DFAEE16
        for <git@vger.kernel.org>; Mon, 23 May 2022 13:13:26 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id e28so22291379wra.10
        for <git@vger.kernel.org>; Mon, 23 May 2022 13:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Z0XrUde5uDfFnpUippOjLw4aZcgNdzO+W6hgorgFd94=;
        b=b0tt/a06QWRAoF3Aa/0quNTCa3GMLuFrRDAzyKYfG+d/Hzv73Ki7L3YTcPx9iKysfe
         GbUdgYl2n6CKVv/29a5RlnbN/JSiin9VaWMYmj13Dfw1rextzlikoq74rxSdJcGuLVzp
         t7FDjV5Ke+1LuFzqPtjDKvpxc+CuOD+X0EyPl0YMGE4CcRnujaF40rGbmuYF84vgO+0m
         7ESkOYNGRW6tHg8jzj/U79giDxOMdLO/S6qFn9iMavbep3ePcZiEcfm7MMOhKe0WYzl0
         i3028Y+TcgJLpBmqhzMxhP9XxzaE/g4Tgrfrm8yhqFD1He1lIOb6K869sCsXGvi97dbH
         Eamw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Z0XrUde5uDfFnpUippOjLw4aZcgNdzO+W6hgorgFd94=;
        b=Z0TK+Sbgcm7JSTLJCM7/J9YEBJCuvAES4KKSvMjwIj8cWC5A0YoUroWkqb7y/nO6p0
         LXbAxWZukst3mnLteXaOz3nbpO7tphRMYDSH9Wmud35mHP0PKzzy24thIx1WzGS3/gRT
         B9DkTkx0NPe+od+/xxcLWlu5SSTCwzG5d1x+n+qQ/yc/+gmZyU7Gd9mWDKn1FdQqN25f
         8X5Vsmai6cyQ9zCfEUpPHpKAUrAyMrzzpLbKCyJtohQL5J17eZPfE4ANCW6FagxsQFxI
         6gL68qUvilhRN1/zgpbUMV23f/l1OUo3Tti83bwH3oLG7E4mp0N+zfvLL9d6Py+/zsll
         4zkQ==
X-Gm-Message-State: AOAM532XU/eSDlOrdEJAWUoaymMYsb9rNUESHWVo8tS0R9arNkA2OvLu
        ks5sPcNUYfXTEFMcCbma1a/1B+in4L4=
X-Google-Smtp-Source: ABdhPJwtLdBdNjgewAtgXdYccQH4pcTHFyIOga2d0974oJhuNOo5jkHDNVmkOt8sCcp2Ztz+pbOIIA==
X-Received: by 2002:a05:6000:1f99:b0:20e:61f4:91e4 with SMTP id bw25-20020a0560001f9900b0020e61f491e4mr20303711wrb.425.1653336801773;
        Mon, 23 May 2022 13:13:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z18-20020a05600c0a1200b0039756cdc8e1sm189787wmp.37.2022.05.23.13.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 13:13:21 -0700 (PDT)
Message-Id: <6a8308699543faaea760d4605babe50a0e478f41.1653336765.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
References: <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
        <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 May 2022 20:12:42 +0000
Subject: [PATCH v7 27/30] t/lib-unicode-nfc-nfd: helper prereqs for testing
 unicode nfc/nfd
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

Create a set of prereqs to help understand how file names
are handled by the filesystem when they contain NFC and NFD
Unicode characters.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/lib-unicode-nfc-nfd.sh | 158 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 158 insertions(+)
 create mode 100755 t/lib-unicode-nfc-nfd.sh

diff --git a/t/lib-unicode-nfc-nfd.sh b/t/lib-unicode-nfc-nfd.sh
new file mode 100755
index 00000000000..76c6fbc0ec2
--- /dev/null
+++ b/t/lib-unicode-nfc-nfd.sh
@@ -0,0 +1,158 @@
+# Help detect how Unicode NFC and NFD are handled on the filesystem.
+
+# A simple character that has a NFD form.
+#
+# NFC:       U+00e9 LATIN SMALL LETTER E WITH ACUTE
+# UTF8(NFC): \xc3 \xa9
+#
+# NFD:       U+0065 LATIN SMALL LETTER E
+#            U+0301 COMBINING ACUTE ACCENT
+# UTF8(NFD): \x65  +  \xcc \x81
+#
+utf8_nfc=$(printf "\xc3\xa9")
+utf8_nfd=$(printf "\x65\xcc\x81")
+
+# Is the OS or the filesystem "Unicode composition sensitive"?
+#
+# That is, does the OS or the filesystem allow files to exist with
+# both the NFC and NFD spellings?  Or, does the OS/FS lie to us and
+# tell us that the NFC and NFD forms are equivalent.
+#
+# This is or may be independent of what type of filesystem we have,
+# since it might be handled by the OS at a layer above the FS.
+# Testing shows on MacOS using APFS, HFS+, and FAT32 reports a
+# collision, for example.
+#
+# This does not tell us how the Unicode pathname will be spelled
+# on disk, but rather only that the two spelling "collide".  We
+# will examine the actual on disk spelling in a later prereq.
+#
+test_lazy_prereq UNICODE_COMPOSITION_SENSITIVE '
+	mkdir trial_${utf8_nfc} &&
+	mkdir trial_${utf8_nfd}
+'
+
+# Is the spelling of an NFC pathname preserved on disk?
+#
+# On MacOS with HFS+ and FAT32, NFC paths are converted into NFD
+# and on APFS, NFC paths are preserved.  As we have established
+# above, this is independent of "composition sensitivity".
+#
+test_lazy_prereq UNICODE_NFC_PRESERVED '
+	mkdir c_${utf8_nfc} &&
+	ls | test-tool hexdump | grep "63 5f c3 a9"
+'
+
+# Is the spelling of an NFD pathname preserved on disk?
+#
+test_lazy_prereq UNICODE_NFD_PRESERVED '
+	mkdir d_${utf8_nfd} &&
+	ls | test-tool hexdump | grep "64 5f 65 cc 81"
+'
+
+# The following _DOUBLE_ forms are more for my curiosity,
+# but there may be quirks lurking when there are multiple
+# combining characters in non-canonical order.
+
+# Unicode also allows multiple combining characters
+# that can be decomposed in pieces.
+#
+# NFC:        U+1f67 GREEK SMALL LETTER OMEGA WITH DASIA AND PERISPOMENI
+# UTF8(NFC):  \xe1 \xbd \xa7
+#
+# NFD1:       U+1f61 GREEK SMALL LETTER OMEGA WITH DASIA
+#             U+0342 COMBINING GREEK PERISPOMENI
+# UTF8(NFD1): \xe1 \xbd \xa1  +  \xcd \x82
+#
+# But U+1f61 decomposes into
+# NFD2:       U+03c9 GREEK SMALL LETTER OMEGA
+#             U+0314 COMBINING REVERSED COMMA ABOVE
+# UTF8(NFD2): \xcf \x89  +  \xcc \x94
+#
+# Yielding:   \xcf \x89  +  \xcc \x94  +  \xcd \x82
+#
+# Note that I've used the canonical ordering of the
+# combinining characters.  It is also possible to
+# swap them.  My testing shows that that non-standard
+# ordering also causes a collision in mkdir.  However,
+# the resulting names don't draw correctly on the
+# terminal (implying that the on-disk format also has
+# them out of order).
+#
+greek_nfc=$(printf "\xe1\xbd\xa7")
+greek_nfd1=$(printf "\xe1\xbd\xa1\xcd\x82")
+greek_nfd2=$(printf "\xcf\x89\xcc\x94\xcd\x82")
+
+# See if a double decomposition also collides.
+#
+test_lazy_prereq UNICODE_DOUBLE_COMPOSITION_SENSITIVE '
+	mkdir trial_${greek_nfc} &&
+	mkdir trial_${greek_nfd2}
+'
+
+# See if the NFC spelling appears on the disk.
+#
+test_lazy_prereq UNICODE_DOUBLE_NFC_PRESERVED '
+	mkdir c_${greek_nfc} &&
+	ls | test-tool hexdump | grep "63 5f e1 bd a7"
+'
+
+# See if the NFD spelling appears on the disk.
+#
+test_lazy_prereq UNICODE_DOUBLE_NFD_PRESERVED '
+	mkdir d_${greek_nfd2} &&
+	ls | test-tool hexdump | grep "64 5f cf 89 cc 94 cd 82"
+'
+
+# The following is for debugging. I found it useful when
+# trying to understand the various (OS, FS) quirks WRT
+# Unicode and how composition/decomposition is handled.
+# For example, when trying to understand how (macOS, APFS)
+# and (macOS, HFS) and (macOS, FAT32) compare.
+#
+# It is rather noisy, so it is disabled by default.
+#
+if test "$unicode_debug" = "true"
+then
+	if test_have_prereq UNICODE_COMPOSITION_SENSITIVE
+	then
+		echo NFC and NFD are distinct on this OS/filesystem.
+	else
+		echo NFC and NFD are aliases on this OS/filesystem.
+	fi
+
+	if test_have_prereq UNICODE_NFC_PRESERVED
+	then
+		echo NFC maintains original spelling.
+	else
+		echo NFC is modified.
+	fi
+
+	if test_have_prereq UNICODE_NFD_PRESERVED
+	then
+		echo NFD maintains original spelling.
+	else
+		echo NFD is modified.
+	fi
+
+	if test_have_prereq UNICODE_DOUBLE_COMPOSITION_SENSITIVE
+	then
+		echo DOUBLE NFC and NFD are distinct on this OS/filesystem.
+	else
+		echo DOUBLE NFC and NFD are aliases on this OS/filesystem.
+	fi
+
+	if test_have_prereq UNICODE_DOUBLE_NFC_PRESERVED
+	then
+		echo Double NFC maintains original spelling.
+	else
+		echo Double NFC is modified.
+	fi
+
+	if test_have_prereq UNICODE_DOUBLE_NFD_PRESERVED
+	then
+		echo Double NFD maintains original spelling.
+	else
+		echo Double NFD is modified.
+	fi
+fi
-- 
gitgitgadget

