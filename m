Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3095C433F5
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 15:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241082AbiBOP7v (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 10:59:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237550AbiBOP7t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 10:59:49 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8A8BD2FA
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 07:59:39 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id h6so32893898wrb.9
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 07:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mhF4CuQxafkn47pjkZom0XYeBg1uoIRwdMOe7ojOkSE=;
        b=ZaWr8uH24kzlYbxholEeBzf96FHwKqiJw0BRm9f9mtjQMF4sagh4mvVxByOi0Mpx/z
         LGLuP1EUPINEbcEQhNJlrBuaMTlRRMKNo5bvXQmyOVYb8OlU6Aq2C0Ty6A2zpAP0IT5v
         6Hi/ycbgNzofM6AURPFyOJ3sv+VONv1JnSnZmQ5HHHfOI9eMmNZ2rX4siEhvYZX306qn
         S66ND4/mOqfUaydvMeOCMyqtvUj9An4e0k2oY6O4qNFHLM0lvaBHFl6NNJviPeBre3N+
         VACUfhjql3ApnPqXLRBmIhRiKPvVdmByAQBqVKVF1SHRKdD3eJ3GLcGVEyHiFBaxP21d
         v9iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mhF4CuQxafkn47pjkZom0XYeBg1uoIRwdMOe7ojOkSE=;
        b=cF+F94yQ0L20FMKwVgG7jRUHLgoWcz7QOORyrPFHS4zrAq/lPoRN4dz1Kl38A4dOqD
         vs557BNNKCIQ7aP0uMoTetcsGq55CkDHi1UbazuAAy9GkPd0qjhxscwRkQUyFzaUWIHL
         i4E+f+p0SC0B3aq1v/0LqN+MdwhatyaKlMlv94lCBm7ivdffkOj/T3auKtyvEp/s1Tha
         v6jTJdCEp6iQX0SGSthgXsSeQjngXkDxDqvurC1zmIQB+CFKTTNQC8xza+F6/PJWga5Y
         hUU9kJr10Ip+h7fezOl6peTeSXWl0MSzqaGIUM0Z2j8arDwxOqaAdTAV5JapGQsVZbTr
         8EVA==
X-Gm-Message-State: AOAM533DraTkxXQedOxFOxTpLamsYAhopbGAm04B9D0iEpNpqlwcZke8
        Fh0vdT6tnB3Eh2Il0C007EYHDDh9QKQ=
X-Google-Smtp-Source: ABdhPJwqjMaHpr+o59fbeQsNjQkIWCE2RvjpE70OIOKaQRJPOgjoTjmmVqheguc7z4I5e3AKqMIquw==
X-Received: by 2002:a5d:4903:: with SMTP id x3mr3749851wrq.363.1644940778013;
        Tue, 15 Feb 2022 07:59:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h6sm6625573wmq.8.2022.02.15.07.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 07:59:37 -0800 (PST)
Message-Id: <ad8cf6d9a47b61d9fe41a961466122be16e4f041.1644940773.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Feb 2022 15:59:12 +0000
Subject: [PATCH 02/23] t7527: test FS event reporing on macOS WRT case and
 Unicode
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Confirm that macOS FS events are reported with a normalized spelling.

APFS (and/or HFS+) is case-insensitive.  This means that case-independent
lookups ( [ -d .git ] and [ -d .GIT ] ) should both succeed.  But that
doesn't tell us how FS events are reported if we try "rm -rf .git" versus
"rm -rf .GIT".  Are the events reported using the on-disk spelling of the
pathname or in the spelling used by the command.

NEEDSWORK: I was only able to test case.  It would be nice to add tests
that use different Unicode spellings/normalizations and understand the
differences between APFS and HFS+ in this area.  We should confirm that
the spelling of the workdir paths that the daemon sends to clients are
always properly normalized.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/t7527-builtin-fsmonitor.sh | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index dbca7f835eb..1fdabfc4f1e 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -188,6 +188,36 @@ test_expect_success MINGW,SHORTNAMES 'implicit daemon stop (rename GIT~2)' '
 	test_must_fail git -C test_implicit_1s2 fsmonitor--daemon status
 '
 
+# Confirm that MacOS hides all of the Unicode normalization and/or
+# case folding from the FS events.  That is, are the pathnames in the
+# FS events reported using the spelling on the disk or in the spelling
+# used by the other process.
+#
+# Note that we assume that the filesystem is set to case insensitive.
+#
+# NEEDSWORK: APFS handles Unicode and Unicode normalization
+# differently than HFS+.  I only have an APFS partition, so
+# more testing here would be helpful.
+#
+
+# Rename .git using alternate spelling and confirm that the daemon
+# sees the event using the correct spelling and shutdown.
+test_expect_success UTF8_NFD_TO_NFC 'MacOS event spelling (rename .GIT)' '
+	test_when_finished "stop_daemon_delete_repo test_apfs" &&
+
+	git init test_apfs &&
+	start_daemon test_apfs &&
+
+	test_path_is_dir test_apfs/.git &&
+	test_path_is_dir test_apfs/.GIT &&
+
+	mv test_apfs/.GIT test_apfs/.FOO &&
+	sleep 1 &&
+	mv test_apfs/.FOO test_apfs/.git &&
+
+	test_must_fail git -C test_apfs fsmonitor--daemon status
+'
+
 test_expect_success 'cannot start multiple daemons' '
 	test_when_finished "stop_daemon_delete_repo test_multiple" &&
 
-- 
gitgitgadget

