Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEEF29BD80
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 20:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772050651; cv=none; b=rFvR2WFJS1Z9nWRoex17jPLmqivDxwxv71tEDny5usNLSoDFlHBquIpM5bHHV8ymUF6yA2yCwEYT5tp4vZaSZ72qqFIpjetTz7Yq6vuI0EGTWisGbUqryy5295W0nu1xnKfVVS+r/bs+LABccP1NZGmb/gRdX7wlcgFeRV5HvS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772050651; c=relaxed/simple;
	bh=JOAUQgtalMHRhgdNV/YeiqvOLi3+yXa+k5LuMfKxqRU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=EgdV2e/eVUAqaalDd51/h9Yix/1+LKOi2Tlqy/rT7SBI5S9TW4pljLyTDUdZZDqV3oi1mGXc8ahln0FxV0TSO9AWQzh1EAedR4I8HqQXwx0wnqZz0yKB0QKzkZBYy18L7G8MsQYiKQ0BtYGjOfFf/Ah0QhmnOzS5T8XRRh6Cq70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FdRgwzx9; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdRgwzx9"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8cb3e22435fso109285185a.1
        for <git@vger.kernel.org>; Wed, 25 Feb 2026 12:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772050649; x=1772655449; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BbDNRmr8p87w3ZUQ1LQGNLGseO50776wwblaeHGbHPU=;
        b=FdRgwzx9+PuSSYOQpSBruB9T88ShPbbYeeuEO9y/gaBUQhRfWLfkAd/raEhaf1lN++
         f2NYhErWyDmDlX59pcP82MkDVAlmsIMHHtZTPHnynHvBu1LnlbNEXpBqzzAr0dg1XLD7
         fZK/RjBSkHC1P8qOztj+9HMkbbdWr5na0SxwrnGL4jHVwYz0WsW2AVfRFnbKNXpA04Mc
         AsiqnungoiXtjNVYMAt/SbsPOnH4ZC6roO0XIzuj8hiTmxkrCMludY8SpKht26NQscqb
         wUmqpg96C+7fbjxT9LVJzUdmd+S62aBaWw1KBnxPYu4WPXGRXabDo4rksDsfkN6MUQu6
         4SWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772050649; x=1772655449;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BbDNRmr8p87w3ZUQ1LQGNLGseO50776wwblaeHGbHPU=;
        b=wdZ3HAMWDSd3LfLsonI82US+z7xwhyXnWe/u33vXQemo5fW6mcA4q2yk+wN+4mbXUh
         5p2JqPWgCtHDrlBTu9bpkrO1qBApLQBE9tsGlc5ZmPXP3alCneJdWxf21kpZagDr0yWA
         5/4tEuqCpKZVMyAk+bS5DrCzWhrvMYrSelq69oMUjj0j5kvyf4nVegwyI35Bpx7Pntnn
         24GiitK00MG2sa8G4oR3G8ZHXKLejwiimEINbo7wTHDQE3ELd5D0nArVfeJYhjtys4Oi
         5dzkJO5qXP0A4JBC7jqQarL3fdobbiWtjktId9TeaCznPat4u12ENHlI0OwWosgc01xU
         D7og==
X-Gm-Message-State: AOJu0YxbmPDPMz7dgnGiTyvHMXa+nwc6fybmuFttxIE/rQejxVkKKW6u
	49RRSaZvaxY1bWvaoEN/Xv25UGqiTS2K+Qi3afBMW7ExP2RXWiA6LlY0nwwyFA==
X-Gm-Gg: ATEYQzy2Zx+CcrtIOyd1t+StM3dVMfww8DZtD/FCevruICrHEef8ZycUIbhU/sRcuVF
	b44NAOfcZ8Js7wHXjDbEH5DAJRHyHIvANAwpLAkC/NWFK9mra+m2qAvogcB/3N1uML+2JQ+Qj9n
	5Ga1it4gQuqjIJX8a4O7IU9AotWA1vcjNfNC6RygAoMq6DWqTY5Qn9qaN16x4TmdeB5UF2NetEU
	5kII38RZ05vU2DIkQJA3ByyH2/cDcwaRMo659o6TWkTG1BuqrEkhitw5Lw5mICT3paUoXbdm+2H
	RXdrbBLldcL+YWuGLWuI/eriIOrx/zPUVEqr2V0QV+I9ovXQu35uVx0c9wryGL8lK0UEoD5jUSe
	bK1K8aYZi5sAewlAgjH8QMt3C4ZmRbylJmzQfzKxls+Q8lUq2IqUBK0bsKj26XT5YCtzFOMQaKn
	1qaT8h8bz/fKCEtAQ/OnxXw11wjoiIAlic1Smr
X-Received: by 2002:a05:620a:700c:b0:8c6:b05b:1f33 with SMTP id af79cd13be357-8cbbf35211emr50230885a.9.1772050649090;
        Wed, 25 Feb 2026 12:17:29 -0800 (PST)
Received: from [127.0.0.1] ([135.119.235.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899b3863174sm34841846d6.25.2026.02.25.12.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 12:17:28 -0800 (PST)
Message-Id: <817489b3ea6a0831e4b815df1c4a0c0e100a2683.1772050636.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v6.git.git.1772050636.gitgitgadget@gmail.com>
References: <pull.2147.v5.git.git.1771896704209.gitgitgadget@gmail.com>
	<pull.2147.v6.git.git.1772050636.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Feb 2026 20:17:15 +0000
Subject: [PATCH v6 09/10] run-command: add close_fd_above_stderr option
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
    Paul Tarjan <github@paulisageek.com>,
    Paul Tarjan <github@paulisageek.com>

From: Paul Tarjan <github@paulisageek.com>

Add a new option to struct child_process that closes file descriptors
3 and above in the child after forking but before exec.  This prevents
long-running child processes from inheriting pipe endpoints or other
descriptors from the parent environment.

The upper bound for the fd scan comes from sysconf(_SC_OPEN_MAX),
capped at 4096 to avoid excessive iteration when the limit is set
very high.

Signed-off-by: Paul Tarjan <github@paulisageek.com>
---
 run-command.c | 11 +++++++++++
 run-command.h |  9 +++++++++
 2 files changed, 20 insertions(+)

diff --git a/run-command.c b/run-command.c
index e3e02475cc..cbadcf5ff8 100644
--- a/run-command.c
+++ b/run-command.c
@@ -832,6 +832,17 @@ fail_pipe:
 			child_close(cmd->out);
 		}
 
+		if (cmd->close_fd_above_stderr) {
+			long max_fd = sysconf(_SC_OPEN_MAX);
+			int fd;
+			if (max_fd < 0 || max_fd > 4096)
+				max_fd = 4096;
+			for (fd = 3; fd < max_fd; fd++) {
+				if (fd != child_notifier)
+					close(fd);
+			}
+		}
+
 		if (cmd->dir && chdir(cmd->dir))
 			child_die(CHILD_ERR_CHDIR);
 
diff --git a/run-command.h b/run-command.h
index 0df25e445f..a1aa1b1069 100644
--- a/run-command.h
+++ b/run-command.h
@@ -141,6 +141,15 @@ struct child_process {
 	unsigned stdout_to_stderr:1;
 	unsigned clean_on_exit:1;
 	unsigned wait_after_clean:1;
+
+	/**
+	 * Close file descriptors 3 and above in the child after forking
+	 * but before exec.  This prevents the long-running child from
+	 * inheriting pipe endpoints or other descriptors from the parent
+	 * environment (e.g., the test harness).
+	 */
+	unsigned close_fd_above_stderr:1;
+
 	void (*clean_on_exit_handler)(struct child_process *process);
 };
 
-- 
gitgitgadget

