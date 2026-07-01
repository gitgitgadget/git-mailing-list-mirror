Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2887B3B3C10
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 07:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782889495; cv=none; b=P1Mn7XE6v+IcTbI9kKA+sNVBwYkBmoXvlFgO2DBl9LOYHuts2OiKVigCqiiFdB/bCwZ7iRIQg/1BnWkoUAOui/ZP45uj9Fs0E6V+wPbEv8fEByuG5VwfqxTfsyy7Y9Ba7WexoBjevPpN84GfvHHj13XsisC6ie+8QqKFPT5pNMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782889495; c=relaxed/simple;
	bh=rDWB9mr6o4XIfJrSTg11gRMqcuG07tHH1dzAvhJfRK0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=m9uKfJewt6L2CmNJ5QnD9AfIFBtFhFVO1Gi+LPO6lW/uvk8L/2U3H1tQW2Y8zepTHSdBAJutrSus5p3v6eZUX5Y2Md4WC+onq3m4NODT18P6ztupNkLxjtaHzZQyHZg4m+/HyR88lnDsZ+RfhnP5ChoffzDjvAj4hzHsLhB9go8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HB7utL4e; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HB7utL4e"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51c08df8513so2200461cf.3
        for <git@vger.kernel.org>; Wed, 01 Jul 2026 00:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782889493; x=1783494293; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AohsIVdbingOUXetGaeCq0/2eruZQsuFVLUbaUsffyk=;
        b=HB7utL4e2Q2UQqi4gWL83pvveBqZi6ynH65KNIbKNvjKQbUFduVdw3ElJDtfQig4Xx
         K+49LnBsRTGMXOsHXH2K/zNp0NPGuDjFGYDSkf6GwPVnxo8hVNMuS2X6orcil5pqMNd+
         d0ADN1Us4lqji8torQLjf+/BYvzZdXLEIfni8IGaf9vF4+icEaa3D/4roHP8l43kc+he
         Ytp1hvr2E+Xr3mKBdyeRVrsVNw/kjGPPiHgMS3ESVjP4Rqqgx+MewGjnb1frh0A+RgJ+
         hVW0nd+5SUGb+/Bf2dA19zbmUbwcroQJPJMqInY9DWd8u2yKOeNSWswns8wEyVqdRU3U
         m0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782889493; x=1783494293;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AohsIVdbingOUXetGaeCq0/2eruZQsuFVLUbaUsffyk=;
        b=Bj822+o5QECGTNt7NG2vSyOuIlwMnsXFPq8e0PwpUMhSVucMKbxqEa4XP3qK52QGxo
         YgWeK740dtWYMirHKIacPszRGbid+yzeKlXoyaB980E3le3YgSWoCxA7G1gf1TWoc7gF
         DjKOBqM5GUNrj1MReCo9ZSGTJltIlUY0MdeG9IYcOJtcdFQKzsK+MSDxni35WUxxc+FH
         uNEwlazmwSy4L4MjY39g9vPNorQr5kslGRdTFBd5IGNujncEsuGGtLh/Yhfbo8EGOF1Y
         XGCXixDZKTAfMyfcJiVPnwL68AgW7QicyOP7OqJHhexhBW3IE6wbPZ36h1qHai90KW3p
         o/bw==
X-Gm-Message-State: AOJu0YwPcX+q/aNP+lY5PF7IqySRghJfTFmG5LBPHA0uXoKKv0o+vI6U
	U3Bo7vOIbW7xsaglAVLZHkjqWlN7637oq1BOeVwoqLRoppGnUZiE4mfCToKKfA==
X-Gm-Gg: AfdE7cmEHE/Z3KTX/0lvF9pOiSfbpIDcbBYP+OIKVxugszl58WVuqPxdy3bXlXn6VIK
	66+MnBG+rmOrwyg79n/znjfvkbbbfrpWonI26aYDhwQqFgzKLBu8Ki5IhwTLNoJi+ds58SdLzpj
	iuVZokX62ZZ8eeBb9Wso2asiBJngosnuZmhQqaLX2KUKGPdkmV9KvKLMiLij+wVEJRbtjKuOUOz
	+BI/E7iTXsT/Zx+A2zrRCqfq69W/q2V1rPx2SQFXUF5GSzaKCpz8S3y82tvSuLBAcq/6bojX943
	5HCv+kGNFMKW4phYCQ+ldFvG2THZxGllTdmMvdkwbvGTlRQMTrmmn7sgiRYXJt90e4wdYYxezYb
	3TCVPKhVlJcKVdoOu5m/ffMZXKVpbZ0Ym+ZGxTFy+2hWzRfPBrFmATM7t93Q++Nbz3Llpors1y5
	BDK1dno1blL9x4mewu
X-Received: by 2002:a05:622a:13c8:b0:51a:8c99:1f0d with SMTP id d75a77b69052e-51c26b27961mr5850581cf.60.1782889492991;
        Wed, 01 Jul 2026 00:04:52 -0700 (PDT)
Received: from [127.0.0.1] ([172.214.44.231])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c10999272sm38536821cf.14.2026.07.01.00.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 00:04:52 -0700 (PDT)
Message-Id: <23ab9864b2a2b9894379d33350a122c71d411e3a.1782889472.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2163.git.1782889472.gitgitgadget@gmail.com>
References: <pull.2163.git.1782889472.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 01 Jul 2026 07:04:31 +0000
Subject: [PATCH 13/13] mingw: make exit_process() own the process handle on
 all paths
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
the HANDLE passed to exit_process() and terminate_process_tree() is
inconsistent. terminate_process_tree() always closes the handle;
exit_process() closes it on success and on the terminate-tree
fallback, but leaks it on the early return where GetExitCodeProcess()
fails or reports the process is no longer STILL_ACTIVE.

mingw_kill() compensated by closing the handle on its own error path,
which is a double-close on every error path that does not hit that
one leaky branch -- the callee has already closed the handle by then.
Coverity flagged the resulting use-after-free as CID 1437238.

Pin down the invariant that exit_process() and
terminate_process_tree() own the handle from the call onward and
close it on every return path; with that, the bogus close in
mingw_kill() goes away.

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
