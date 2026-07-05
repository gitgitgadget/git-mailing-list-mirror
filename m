Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DED936CDF8
	for <git@vger.kernel.org>; Sun,  5 Jul 2026 08:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783239897; cv=none; b=ofmwwqNul3Fv9wz74yvnhBuaYz5M5FybgDlcua9vhX3tbF4Ul4aqE4IaSBJHw1rnRK84Rdb91x6693kRbQx+waFiBMJy7obbrooiihsfs3j2IHO6RR9/ud/Xlk9sDv+t3Y3nYRQIiJ4LGw2MssAxrSq37+fTLiRHDyo5WHmgpEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783239897; c=relaxed/simple;
	bh=Bkjfz3KbeCFlicHjKek6Sh4lZPkOcx7ghKadRwdAeh0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=E5YF7j6FOBgihrNkXwZlRs+ZYc81UH6Y7XJ+tRIX1CwyQZ7zaHYGYgUCa2LSCoU7P1u9v14qUKTMZ6wXIOrpmMXYbcvJqtrTLxnHG7ZNvEVZ+n1p32OFVxDqrp5fxFBoyDn3n0/UbSkd2F+AJk/04XzWlLw6p/D0bSgvtUXUYwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DHBiP+hk; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHBiP+hk"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8f24f290af5so16735906d6.1
        for <git@vger.kernel.org>; Sun, 05 Jul 2026 01:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783239895; x=1783844695; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WPx5BQTbO2lF/w+ZFibLzZUc0uzx7cEkT84MIW4mTZY=;
        b=DHBiP+hkbH4fR9wPH433+EhfjdmY/XUHkKJysWgIMPpIt96DMyzkcXlkqfmPGdPnu2
         r6Zv6Eji9AsWe4CBA9e8IL2axslLr9AKZVOUI/lJ7KUYpSg4VaBATM1LVHDWg32ntkMx
         Dh3gSY9yx7/6a2JgVrEAl04fG4VPnP34pDABKchfDiPNuYtstaImD2aPjBbeQME9R+dz
         peScWa4NXLKTBcRk8XolNWkWcHoA3UMV1oJizBgT/WRTMP7ENHs3bScSJrakzusi2p0y
         RBVcx7Y/KnfMWwZT6TBUKmMcpoxiANnNRgD3exuxp3HOHc/5yuXEotjdJovXCFNRawJN
         m3ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783239895; x=1783844695;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WPx5BQTbO2lF/w+ZFibLzZUc0uzx7cEkT84MIW4mTZY=;
        b=KKZ4LgnzKWcShkIngorPh0TArzhtgTwRgdRuLah4v/Qq8o9kUOrFzy2kdrkIFXxcfa
         /IyrhTTJhFc9IkVa6A+cHCDC4ojFgTKzLMmICOQw6/GZ4pL9F7LK7eAG+nMpeSRJU1/i
         QtnP2Aqp2n9cujmbpVC4O1FT3BI8Cqn5KNsU9jhRobB7bviueWLAp96GS+ROTZSAiuTo
         Bdhv6TIWzxyFLFDXSW0Tv+F01sBg+B/7QGNFCSa+jhC51t1H/eiHBJZswnBacnNmlLTj
         Tqi7Ewn4X7DN/GFlZqYzLz2UmUYv2UgIO3o1TfT5Sw+CLwUkh+2OspeIYkQJW5Xv5umc
         6Jbw==
X-Gm-Message-State: AOJu0Yypv7nX72KvwVLuYaMgsaLdz7Wywk0YVxz8oaR7+uuM2y773xJM
	o/an8g/sbOLY/e+gwzAtzOKp2pUa/V5sYBlBTVUfqlxNUyEKYxzeOiXQw9jlSQ==
X-Gm-Gg: AfdE7cmFN7YmE/n/m/1Vl2A7BZC/vPpX3I/NFS5Swgc8fzllE3Yr9VrWS5wVWyWjuMq
	ua7XMyPv6jB5JHVybEIM/4USXp9tRyb5paaVzZZFTHjFEws6xIVSC7dWVFW2S+j12H8oLXfUKEp
	/J1TMhEYAIKKyypDX3DpEnzTSGGt8VNusz1VM3G61P2iRV/vSfIpTPg5GnqDU+JqQhExJFXYzYx
	aAk6XXoxECmho/cQ66XGmGYd72eG4hjiJNL8we1sXV/HxPX0rUtsvxcwAo0IRusHgKDI/0xWKG+
	PxwnDNiuD4/jUOuRfNWIp6S+0v2GR8nuXuixW9jME+czoJkfDSKPLFbOJyjf740GC2njSzlFrP3
	fLEWcyWNECJGPhbjQzAeFI46LkwUk15Rm7+m7Wci73GiAL9FMfDBbTqAVk8iESVjbw74Qb1kDuf
	Hg+mO33ZZeeH78Dl6FIw==
X-Received: by 2002:a05:6214:20ab:b0:8e8:e8bd:8e42 with SMTP id 6a1803df08f44-8f749a75044mr101323636d6.5.1783239895239;
        Sun, 05 Jul 2026 01:24:55 -0700 (PDT)
Received: from [127.0.0.1] ([135.237.130.145])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f46f013f05sm102911446d6.16.2026.07.05.01.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 01:24:54 -0700 (PDT)
Message-Id: <a5a6c27184097f0f8bfc1174e691dd1b94eb165d.1783239870.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2163.v2.git.1783239870.gitgitgadget@gmail.com>
References: <pull.2163.git.1782889472.gitgitgadget@gmail.com>
	<pull.2163.v2.git.1783239870.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 05 Jul 2026 08:24:29 +0000
Subject: [PATCH v2 12/12] mingw: make `exit_process()` own the process handle
 on all paths
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

After "mingw: kill child processes in a gentler way", the ownership of
the HANDLE passed to `exit_process()` and `terminate_process_tree()` is
inconsistent. `terminate_process_tree()` always closes the handle;
`exit_process()` closes it on success and on the terminate-tree
fallback, but leaks it on the early return where GetExitCodeProcess()
fails or reports the process is no longer STILL_ACTIVE.

`mingw_kill()` compensated by closing the handle on its own error path,
which is a double-close on every error path that does not hit that one
leaky branch -- the callee has already closed the handle by then.
Coverity flagged the resulting use-after-free as CID 1437238.

Pin down the invariant that `exit_process()` and
`terminate_process_tree()` own the handle from the call onward and close
it on every return path; with that, the bogus close in `mingw_kill()`
goes away.

Assisted-by: Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c              | 4 +---
 compat/win32/exit-process.h | 1 +
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 41e055f7de..e2cb92a414 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2269,10 +2269,8 @@ int mingw_kill(pid_t pid, int sig)
 			}
 			ret = terminate_process_tree(h, 128 + sig);
 		}
-		if (ret) {
+		if (ret)
 			errno = err_win_to_posix(GetLastError());
-			CloseHandle(h);
-		}
 		return ret;
 	} else if (pid > 0 && sig == 0) {
 		HANDLE h = OpenProcess(PROCESS_QUERY_INFORMATION, FALSE, pid);
diff --git a/compat/win32/exit-process.h b/compat/win32/exit-process.h
index d53989884c..26004161bc 100644
--- a/compat/win32/exit-process.h
+++ b/compat/win32/exit-process.h
@@ -159,6 +159,7 @@ static int exit_process(HANDLE process, int exit_code)
 		return terminate_process_tree(process, exit_code);
 	}
 
+	CloseHandle(process);
 	return 0;
 }
 
-- 
gitgitgadget
