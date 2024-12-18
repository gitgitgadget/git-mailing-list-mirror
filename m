Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1029D1F931
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 02:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734488450; cv=none; b=RttacF2JdJaCzLtM1cFyEFwMLUbTqweFOyZB9S4cIvl9eFG6O/t30YdeedspijQjfjpxziDb8wbDpDJ66IDz75xCSgGq5mguIJKuOqBZdsduoawgP3/sTaus6FZwt5Z5IEyXnU3FpeiD21dLuFdRr5mG0t1zuX2sAhVLA8pyW/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734488450; c=relaxed/simple;
	bh=MR2iWNK/uALwaMkSHB3uKbziVgio5ZV/6ffr1R15Vx8=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=AI2jZX0RbHALZkhTPw8ZIVG2if/qS3SMFTdWrI4l1WogRb0TJoXtqBsp9R52F2avseH2on2zoSuyXctxR3Ad/rQ/OuNJeB8P0ltK8iQY35Jmx8VCoW0Kuhpm+T37cwvGiL3lmMJf193sMmyEmrKx54TzDiWFBy1mwQN/xPTdM7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kCvCxrVb; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCvCxrVb"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-385ef8b64b3so5169044f8f.0
        for <git@vger.kernel.org>; Tue, 17 Dec 2024 18:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734488447; x=1735093247; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IF+XOpV+AaJpuCKfV/s4sf7J3qGjMYrbRPoDDAmY9Gc=;
        b=kCvCxrVbiL/uaI0GCw7BfcmmC1rQ90hUYET3t3l1CxZclH1dm985qbj1EUMcWqouWI
         rF7YTiYOQhbXd2vKTvadegddwKXUGcyCEKJfNyJO/eDOEpJP9Kp9puV2cosTxQbeRYbd
         yt6q9iUUcrqcKrwrJQcs11Zfm9NdAPa3RO9k4nOhN8Q6vzP9CPMhBy3PcSuMEiGO7quG
         41itLyLJF+POQNygmjky5tU+ZFFi8xxr/BQFkbVa7S0Q83JErQAYDGmsiTFUEySqMfKi
         jcapQD3SVZDhwoE3zMnf4WPM+WuIq7KHqe8rFTHytQb8/enZEKZcZD8pjuClibgJ/TZg
         LdHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734488447; x=1735093247;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IF+XOpV+AaJpuCKfV/s4sf7J3qGjMYrbRPoDDAmY9Gc=;
        b=Z1tvw7BvMy9YilMz79Q8KGMt67dGYDZoH9FtOHQYmpK06Kf4osYctF2MyL8/McOwVz
         R9KyVtQR9EQC6KyO/o9ZpH4/x4T9pxbgaGSV7lXIzAIVdKey0KDBfRvQKfyqaMw485ds
         RtnmrJUeKUE3xoW2w5RjtwoDOAj0BrJuNhfaSog8fSMtTAM5Lo8N5/QhoE7nkDdivRbs
         cOz6ZetQwWZU2l61lOMssPj1rrf1qpfMCpBMksjoq3DX0y9Tg4jQn9p0v1vDWLLUDYkz
         ILbgcX5KPb39tDRa+iOVfrgwrP34gpg84DmaAIpoXgrlV+8IK4YiVAWfKX8SE3TepPgO
         ymwg==
X-Gm-Message-State: AOJu0YyK6OqlO21WHtmEkHo3OldgaCvfOsWS4eK2f/1W89rNQNk+a8Fd
	TBo4dcJdTBFjNhfwm5fGSGEBSjMR3LtnfshR3fmjzstJSIz/p4WsbyG+LQ==
X-Gm-Gg: ASbGncvDIYjTlqSkOOcRDvjeJoqsP6wNiKWTwy1pD16Xj2XPHPGWW5hgRlL6IQZskMo
	ZhZ92rWLVXKMpXpWJWNcDiwyPGlmK2GGeEV5LSEvdt4f+Ob2xKgZFeadeOspOTd4LotkDvn9zME
	Vtvyq8OUzvg21tuDE25k6B4IWcVkV37HyBQ6jHwGGCtM7s+esKpj9PIf9zVGyxZ/7sLOo8VI2F3
	PmssbytV8qi37UPOGIqIBL+ERaP9lhs9rnhr+JRIL8wk7hOqy0P1oveOA==
X-Google-Smtp-Source: AGHT+IGmWcfhO64BpSZOMcGwBEelkNyMKVzHn9ETgj3U+7lq7tggFYO91CDjt/yiiPiG23q4UD49pw==
X-Received: by 2002:a05:6000:18a3:b0:385:e35e:9da8 with SMTP id ffacd0b85a97d-388e4d439c5mr705097f8f.18.1734488446868;
        Tue, 17 Dec 2024 18:20:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c801acf2sm12513525f8f.52.2024.12.17.18.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 18:20:46 -0800 (PST)
Message-Id: <pull.1848.git.git.1734488445457.gitgitgadget@gmail.com>
From: "AreaZR via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 18 Dec 2024 02:20:45 +0000
Subject: [PATCH] refs: exit early from the loop if it is not a main worktree
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
Cc: AreaZR <gfunni234@gmail.com>,
    Seija Kijin <doremylover123@gmail.com>

From: Seija Kijin <doremylover123@gmail.com>

The is_main_worktree function just checks for !wt->id,
but the compiler doesn't know this as it is in a different
file, so just exit out early.

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    refs: exit early from the loop if it is not a main worktree
    
    The is_main_worktree function just checks for !wt->id, but the compiler
    doesn't know this as it is in a different file, so just exit out early.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1848%2FAreaZR%2Fexit-early-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1848/AreaZR/exit-early-v1
Pull-Request: https://github.com/git/git/pull/1848

 refs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/refs.c b/refs.c
index 8b713692359..cce63a618d7 100644
--- a/refs.c
+++ b/refs.c
@@ -2791,6 +2791,7 @@ static int has_worktrees(void)
 		if (is_main_worktree(worktrees[i]))
 			continue;
 		ret = 1;
+		break;
 	}
 
 	free_worktrees(worktrees);

base-commit: 063bcebf0c917140ca0e705cbe0fdea127e90086
-- 
gitgitgadget
