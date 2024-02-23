Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E379212B6F
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 03:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708658321; cv=none; b=ruuGKyge1d6ExMl5LyOMq4DND3TtdbhNj3Mwi+VCfCsKJtI1qCmXhmIRaowYDPCWrC5Z7cszYmNfBP3gn0v32Upkh7iy6wXcleGJmLpjpgFKQoHfRGKbCLznvomyhLrKuEqOJsv4AbwXgHqBwwHG8i15t9loVEY+r9V7gvMufx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708658321; c=relaxed/simple;
	bh=gITuhz03qFDco93TuWaDax7YUxmrZqVlPLqSq64UCaE=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=JV0e0nj8gd2DFyzYV07akOsR5S96d9LEALichr0vSFyQvQWLUXmaQjDHOvZdLrPasKvWZRMmdVv+EgSfrLHR+pgd5YQ5fh8P0lKvXO9C7x8kCIyRlKE7dLvDay1pUbEpKfekeCtcheuK3PUMeP3N2dtXxc2xp/n4Ql140OKIG1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DWhsDhNh; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWhsDhNh"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41293dec05cso513085e9.1
        for <git@vger.kernel.org>; Thu, 22 Feb 2024 19:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708658318; x=1709263118; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C3BT76YdmHwSNScO97hUhhT9sG4uVF3slVVWP5cUEQU=;
        b=DWhsDhNhYfp3ybrW9IuoyTV3eapfyAJQ+M4P7ovLEIr6ukVK6TScU9MvkEoSbtQC7F
         K+tq4Ze0fRvfpg1AZFrZoNe/EmOdb6vf5+hfSxj70fFUEWnpTGJhz3zPxHB4aTub/zNQ
         ZhrBf5YcfnCJhyv8enmr1Qlk7BXU8+7prSKLRuNsR6g3ZFo2NLgv5GBs2DgJ8YlLz49J
         cWVunsolROyMRoUw28pWH2Ne6FUIYJ0B1eiKl1V1LvqOgDitWv7Cwl0cVUlHgo5F7bdn
         RPi1EEtUdwl4miIjOximGH7ML8Zu/4t37tmCL+CVwhOL3kpyuql8CZXmxFx/wJZTwZis
         01Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708658318; x=1709263118;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C3BT76YdmHwSNScO97hUhhT9sG4uVF3slVVWP5cUEQU=;
        b=LXE1dUQ4k9sxFIXR545suT2s40DKR1NxEOmXUxkwp12edwUyWfXgpyLxgG7Jmg/tA0
         Ei23XjfjIcTv4hypLCDHQSi6lj1NjnsocjQgYMB4rOnEegPFxLOOgsPuLMYAdm17AW+3
         RdVoY9QThDLOOMjc5xHvawLmhkKFt/HADdpXTMy+KkSXkcttZm/Y1fOtCJkA88Kt8ueO
         MBPuZtU0fi8ksglnacKHHYm6r/nfLUudSyBuQ+gtdcfxI/ZP5Ab5D8E9SRL1C82uoyxl
         T9QKeurOIAtaKcRpjEOE/uOE9Fy+gfI8BzikvwLBuHsd1lTgf381+1O9C+I1MzIC6rxQ
         U2Cw==
X-Gm-Message-State: AOJu0Yxdzp83gb+7CYOWwoDhcjdfDkGs54japuqYRABjR9U8GV2+kiaZ
	3RGsLUAE07YC6sbe484q6WX3hLK2UNhp4+9tVVvwD2BNm7ic+WSo7UWT0Ct3
X-Google-Smtp-Source: AGHT+IFZIBtFBYLBBlpsofbKHUQeymW3+susOgx457ixXkPjoUoUr+8x3vzotEONzDLRX8jvZ7Zvdg==
X-Received: by 2002:a05:600c:3051:b0:412:78da:8abe with SMTP id n17-20020a05600c305100b0041278da8abemr336497wmh.30.1708658317530;
        Thu, 22 Feb 2024 19:18:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u16-20020a05600c211000b004126732390asm575229wml.37.2024.02.22.19.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 19:18:37 -0800 (PST)
Message-ID: <467d3c1fe2ca86d5ba8dff7e4c6b1f5cc9c5806c.1708658300.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
References: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
	<pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
From: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 23 Feb 2024 03:18:20 +0000
Subject: [PATCH v2 16/16] t7527: update case-insenstive fsmonitor test
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Jeff Hostetler <git@jeffhostetler.com>,
    Jeff Hostetler <jeffhostetler@github.com>,
    Jeff Hostetler <jeffhostetler@github.com>

From: Jeff Hostetler <jeffhostetler@github.com>

Now that the FSMonitor client has been updated to better
handle events on case-insenstive file systems, update the
two tests that demonstrated the bug and remove the temporary
SKIPME prereq.

Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
---
 t/t7527-builtin-fsmonitor.sh | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index 4acb547819c..939521a0fac 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -1051,7 +1051,7 @@ test_expect_success 'split-index and FSMonitor work well together' '
 #
 # The setup is a little contrived.
 #
-test_expect_success SKIPME,CASE_INSENSITIVE_FS 'fsmonitor subdir case wrong on disk' '
+test_expect_success CASE_INSENSITIVE_FS 'fsmonitor subdir case wrong on disk' '
 	test_when_finished "stop_daemon_delete_repo subdir_case_wrong" &&
 
 	git init subdir_case_wrong &&
@@ -1116,19 +1116,20 @@ test_expect_success SKIPME,CASE_INSENSITIVE_FS 'fsmonitor subdir case wrong on d
 
 	grep -q "dir1/DIR2/dir3/file3.*pos -3" "$PWD/subdir_case_wrong.log1" &&
 
+	# Also verify that we get a mapping event to correct the case.
+	grep -q "MAP:.*dir1/DIR2/dir3/file3.*dir1/dir2/dir3/file3" \
+		"$PWD/subdir_case_wrong.log1" &&
+
 	# The refresh-callbacks should have caused "git status" to clear
 	# the CE_FSMONITOR_VALID bit on each of those files and caused
 	# the worktree scan to visit them and mark them as modified.
 	grep -q " M AAA" "$PWD/subdir_case_wrong.out" &&
 	grep -q " M zzz" "$PWD/subdir_case_wrong.out" &&
 
-	# However, with the fsmonitor client bug, the "(pos -3)" causes
-	# the client to not update the bit and never rescan the file
-	# and therefore not report it as dirty.
-	! grep -q " M dir1/dir2/dir3/file3" "$PWD/subdir_case_wrong.out"
+	grep -q " M dir1/dir2/dir3/file3" "$PWD/subdir_case_wrong.out"
 '
 
-test_expect_success SKIPME,CASE_INSENSITIVE_FS 'fsmonitor file case wrong on disk' '
+test_expect_success CASE_INSENSITIVE_FS 'fsmonitor file case wrong on disk' '
 	test_when_finished "stop_daemon_delete_repo file_case_wrong" &&
 
 	git init file_case_wrong &&
@@ -1246,12 +1247,14 @@ test_expect_success SKIPME,CASE_INSENSITIVE_FS 'fsmonitor file case wrong on dis
 	grep -q "fsmonitor_refresh_callback.*FILE-3-A.*pos -3" "$PWD/file_case_wrong-try3.log" &&
 	grep -q "fsmonitor_refresh_callback.*file-4-a.*pos -9" "$PWD/file_case_wrong-try3.log" &&
 
-	# Status should say these files are modified, but with the case
-	# bug, the "pos -3" cause the client to not update the FSM bit
-	# and never cause the file to be rescanned and therefore to not
-	# report it dirty.
-	! grep -q " M dir1/dir2/dir3/file-3-a" "$PWD/file_case_wrong-try3.out" &&
-	! grep -q " M dir1/dir2/dir4/FILE-4-A" "$PWD/file_case_wrong-try3.out"
+	# Also verify that we get a mapping event to correct the case.
+	grep -q "fsmonitor_refresh_callback MAP:.*dir1/dir2/dir3/FILE-3-A.*dir1/dir2/dir3/file-3-a" \
+		"$PWD/file_case_wrong-try3.log" &&
+	grep -q "fsmonitor_refresh_callback MAP:.*dir1/dir2/dir4/file-4-a.*dir1/dir2/dir4/FILE-4-A" \
+		"$PWD/file_case_wrong-try3.log" &&
+
+	grep -q " M dir1/dir2/dir3/file-3-a" "$PWD/file_case_wrong-try3.out" &&
+	grep -q " M dir1/dir2/dir4/FILE-4-A" "$PWD/file_case_wrong-try3.out"
 '
 
 test_done
-- 
gitgitgadget
