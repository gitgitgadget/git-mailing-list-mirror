Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082AB28A3FA
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 16:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780590270; cv=none; b=Yc1EXdUSTLrFoerN3M7JHlzYgilHu1OVPRuoUb6ZMCJhvGHQN55mMg5WZxskSrIbyjgr/jPthACsi35MjAg9vCFZ5zGlLaxkGgY/2FTdR4IKqfwEqhaCsXuQWigmphlwZtSUif4HYAOnoD0PDifRE/iwy5vekrZ1jOf0HWwmE78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780590270; c=relaxed/simple;
	bh=Aeg7uO2vgPTvccPFN3PI/KaGdE+RJwiqS6KP4FtNoYw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=VBRM+veNTKedYqk0Ssj2GcJUPZykWnpofsrJRUk200qa33grOhpCfh/B3VhjamoOcXFJYdSLSnyKKoPcvgUfHH2FyLlbqRooCbpaYlrpE7wU4YB7GCWr+VwGTQojr5LEppPyQMEuta5m1ohBiucy5UnM+vDuY2np55YCb6RoBd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jwmE7T55; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwmE7T55"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-30759632453so1365477eec.1
        for <git@vger.kernel.org>; Thu, 04 Jun 2026 09:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780590266; x=1781195066; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLoZqEWiFWMKhCt1BddIDD/KAc+IGWRrLEoFtnqGoB4=;
        b=jwmE7T55RKSa+iV1lv3WWSnLZ4POMAl1P1H6KASP75XSS4hNAmx3sp04btPgy3tPFd
         FK/dqgfJbk7+q9FfR007Rij/LV6IOSshJUSIrQgVn5reVzh7+bHCv5pj3REZcDKrR280
         4WcIB3CXY7S/j56B4s1mYU+no3CNmWc8HtFU1MWletRNoj/y6r5QTk95chGTj9VE3/a+
         +stSYiOj9JW4OvV0FrTHSr8L5ibhglIN1EGDWiKF0+25Z9K3JHGEk9AB2MHYIfTaYUqY
         LtJkNiXDx2Rvwb/c3VwUDNJo6f/bAWkIm64svIsoa0lmTVRRBBPJd1yMbvgkdnYi+fz1
         Ot3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780590266; x=1781195066;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eLoZqEWiFWMKhCt1BddIDD/KAc+IGWRrLEoFtnqGoB4=;
        b=shftsMP1llXtJkT2IhV0l5SJ/ZAFNtAabBupG5hMeUkp5Z23tmUl8IojTW5ec/ZUxV
         VeYbHuWJFkO4V68GKopE+xcsjG9GH39XdVxtVu9zIWmFmXJ9YhlaX+8dgG/SmDUKcYNb
         R9Kv1cBIOr1BHyLTkQBKvGY1fVxpjGg9ApNLz5+65ZaCISorTJUEULf9+z00vnnxVMRI
         mg4CTBi3KRgxueQT6esLe1TVk8glaF1m7co1v9wEHwCoeRHp51epyDayA+vaZ7OqnWuT
         9iTHLgm7ZFGp1vHNJPvSkmELmUJnhfn/KOC7mE4WfYr6Spj6UFmFpnsc0PwsI19GzfaX
         8UWA==
X-Gm-Message-State: AOJu0Yxj5lQTlKUfCR9aRhSPetbGp2nMRf2v8BfPv/unEvVuCFRJNBUU
	jPWLh4QWkYu2iIWMh21EYyn+Ni/QoolFv8Fip+GqQgkU8aIZRpmP8CFbUWTrw7m8
X-Gm-Gg: Acq92OF0iC5dwsgjneVhlYKcHTDkw9mFNgolxzO/uX6cr5ao+pKrr5I1XFOHj9BKIx3
	dZZnbaFHq7juCUcmJuxE5c+4f2r2/YEBkwL+DWbV/espbYfja7jNiukEdj0oH5VN5gVedazzuCo
	2PxDCaa32gnB/hUlzu1PUNcUegfP1vkUjpw0DWIi5985cCQcfDVeK+p5tO/uXEV5byu7WnSD0Ci
	ayM0S/OjMQrhsEAxdv8V8mGQmY5YlGzBIiuy8ngUAEv7f8zUuFfZBj+7fJTGeoXDOQWpf0fN+UN
	I541hZQr7N0KtV+pi7inRpy1IMyIhNt5y7FNDJBclV7cx3lqFrizmiXHb7pCNmo1IdsCA2w6S77
	vw8ag2E7YjTKo0/ecHW5BelpOTnc6fCEg9rVoLI0VIsyoayLP1wo5JqZNy3xiVzsI6IfVpQ5JRo
	9ipIcTN9ETSZxdCRPLKR24kWEK3TIwMTYlQiSi
X-Received: by 2002:a05:7300:dc03:b0:2ef:8b91:212 with SMTP id 5a478bee46e88-3074faa0516mr4738126eec.14.1780590265694;
        Thu, 04 Jun 2026 09:24:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.83.233.101])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074df3b234sm6966907eec.23.2026.06.04.09.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 09:24:25 -0700 (PDT)
Message-Id: <297cc921fb8c12d85f8bf4c1e05edfbab9609191.1780590261.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2130.git.1780590261.gitgitgadget@gmail.com>
References: <pull.2130.git.1780590261.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 04 Jun 2026 16:24:20 +0000
Subject: [PATCH 2/2] mingw: really handle SIGINT
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

Previously, we did not install any handler for Ctrl+C, but now we really
want to because the MSYS2 runtime learned the trick to call the
ConsoleCtrlHandler when Ctrl+C was pressed.

With this, hitting Ctrl+C while `git log` is running will only terminate
the Git process, but not the pager. This finally matches the behavior on
Linux and on macOS.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index 973049ffe3..f2b6c51f98 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -3580,7 +3580,14 @@ static void adjust_symlink_flags(void)
 		symlink_file_flags |= 2;
 		symlink_directory_flags |= 2;
 	}
+}
 
+static BOOL WINAPI handle_ctrl_c(DWORD ctrl_type)
+{
+	if (ctrl_type != CTRL_C_EVENT)
+		return FALSE; /* we did not handle this */
+	mingw_raise(SIGINT);
+	return TRUE; /* we did handle this */
 }
 
 #ifdef _MSC_VER
@@ -3617,6 +3624,8 @@ int wmain(int argc, const wchar_t **wargv)
 #endif
 #endif
 
+	SetConsoleCtrlHandler(handle_ctrl_c, TRUE);
+
 	maybe_redirect_std_handles();
 	adjust_symlink_flags();
 
-- 
gitgitgadget
