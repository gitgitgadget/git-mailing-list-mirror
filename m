Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A17F25C71A
	for <git@vger.kernel.org>; Wed, 14 May 2025 12:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747226646; cv=none; b=CYUY9W86QjhVetdaMP34OWOTueNhNF+fi7MpV1dpQgj8zQZGbIPwODkJ9kWR6abtBnP82s/mx9RUoqRA0baCJn6HRWx33NFAlqUSY0UYuSx2VDMXkhGDzvrVbtRKn/E5Ft6RM5vtpU1wD2e8D3UMCihFyYs0HpuIdHj0XfNcpNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747226646; c=relaxed/simple;
	bh=+U5Q0QhNQscFo2x+veU921WX9WKBWamTi7d+u9B4OV8=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=sGO+q1BP4ZfUWrt2jO40vgXUKnLKAbGgbXbm0pWqnV/B7QdQ0JmW/C1R3L9dxSruLcajwxKUlAZV7pcCXxbPU8Szs5fiRv9wOXPg6ECl+/CQzVAZ9Wk5kDVWOc0ktqq6V1YPRFxE4qryZ6qQdKNNG6aegedLMH9QtY+4KEcsJsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cunleZQx; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cunleZQx"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a064a3e143so3937463f8f.3
        for <git@vger.kernel.org>; Wed, 14 May 2025 05:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747226642; x=1747831442; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8K/vXnk6kdvU1h7XBgmCIopQjHwmgNXecCetdwyJeYo=;
        b=cunleZQxn++7KsSZj9tEsZROTnuE3kPNvS7RgO2+NwLQgJ0ET1jZYi+r1qTNy82PMt
         nfb0hc9Nr+VV+s7Sq6/88ZerYHsZUs6Zi5+HAakCYl4Kgm0/JBsa6tCaCoO8Mx1pVdKd
         Wg3POhMpwi/GhZvA9W0JmVLTK/zTBa53Q3HTKKeV+UFEspGE3ZAY2Nt48K9jGqyU0VSq
         4LCDEmcr5A5pjA1PO/KvfiXO/Ta63batgZtuVc1o8gGC2uCQ8XDOU39cwntImqllgDwC
         BdJ+3A6zqjHKeDviUah7pwIPlCy2BxIZmM+SFuu5n7V6SVK5exKVPWXWM6AqzABefK9+
         DRSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747226642; x=1747831442;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8K/vXnk6kdvU1h7XBgmCIopQjHwmgNXecCetdwyJeYo=;
        b=kknmsf6jLZntfZ0La29plrldI2/xH+3xQQRh9F7I8G/Kmlyhs65W7mAxaDpLcJ7xHJ
         Nm5yjChHWirRqow77+DD+Ul1XwuGPFHLxfaFCyLVWqcc11Jkwo6zHQn7fNjn/L/R9zFm
         Bc4S4P/1iULPjVKdgy+TX14gwn5q0uy0iXckoP7gwhaUHdRJ5HGt5EInf2mustdAykuR
         y1hgCCYCP2aRUAzXqxz0vj+9wIqcVtbbGE2UypQA1MGrPT5J4uPBoc61F4ceY52LVd9K
         wXC5oDqNCSb9rEyfN+Ux/eqiskMNU3H6AXTFdyXqTjA8xkDNcjUH0cEH9fUHXX35TyDr
         DJaw==
X-Gm-Message-State: AOJu0Yzmr+ufvgGsneEKssug+XX8anx1EIpXxf46Uucw+sOBVbTpdSJj
	h/eLffhfqHWzGcyqHEkM+FjB4m/3RF9XoV73wMitxebXxH8JFLpMfHMCUA==
X-Gm-Gg: ASbGnct3gGnMhhpllrJuGEUpisBKfztfyLGTbRBvT9cmDk4vEj46d47GNp66sfGEze8
	QEjhAgs77kc7svOhGhH1NS/yBQZrNC8isToH4EfqtPIDSI+nC7YbFgBcWl28QEkJ+9Cb/CR8DQa
	kvwmpMpqB+BqhyGZkckQi55rjOAiomjL3c/ej+ChRD3Nr0L05Xa30L2Y8nddMPJKhX4wPMKfkZx
	lYhtr8TPudjME7pvyFeXhng1IGCzkzD1IqEub43hiMRNgiyjosnLG6vW1Ce3ozr48+hAPTvy2YP
	NXImbtB0x8+BYF4EORhr19qFBuzpNI/USOObBcOlBPrg4jcUAXAk
X-Google-Smtp-Source: AGHT+IEXeHLTlOTDitKOdaTunOqco1dbyYbAQiM51QEFP5rBcG3NOPEhXF4zTPeoKuG6ltWjCAO9EQ==
X-Received: by 2002:a05:6000:1a8d:b0:3a0:ad33:c1b3 with SMTP id ffacd0b85a97d-3a349695bfdmr2746661f8f.3.1747226642361;
        Wed, 14 May 2025 05:44:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58f396asm19981921f8f.59.2025.05.14.05.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 05:44:01 -0700 (PDT)
Message-Id: <pull.1964.git.git.1747226641249.gitgitgadget@gmail.com>
From: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 14 May 2025 12:44:00 +0000
Subject: [PATCH] sequencer: fix memory leak if `update_squash_messages()`
 failed
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
Cc: Lidong Yan <502024330056@smail.nju.edu.cn>,
    Lidong Yan <502024330056@smail.nju.edu.cn>

From: Lidong Yan <502024330056@smail.nju.edu.cn>

In sequencer.c:update_squash_messages, `repo_logmsg_reencode` returns
either an allocated reencode string or commit buffer if no encode is
needed. To free `repo_logmsg_reencode` result, `repo_unuse_commit_buffer`
should be used. However, when encountering the error("unknown command..."),
the absence of `repo_unuse_commit_buffer` results in a memory leak. I
think we should add a `repo_unuse_commit_buffer` before return.

Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
---
    sequencer: fix memory leak if update_squash_messages() failed
    
    In sequencer.c:update_squash_messages, repo_logmsg_reencode returns
    either an allocated reencode string or commit buffer if no encode is
    needed. To free repo_logmsg_reencode result, repo_unuse_commit_buffer
    should be used. However, when encountering the error("unknown
    command..."), the absence of repo_unuse_commit_buffer results in a
    memory leak. I think we should add a repo_unuse_commit_buffer before
    return.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1964%2Fbrandb97%2Ffix-sequencer-leak-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1964/brandb97/fix-sequencer-leak-v1
Pull-Request: https://github.com/git/git/pull/1964

 sequencer.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index b5c4043757e..f288a303eaa 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2138,8 +2138,10 @@ static int update_squash_messages(struct repository *r,
 		strbuf_addstr(&buf, "\n\n");
 		strbuf_add_commented_lines(&buf, body, strlen(body),
 					   comment_line_str);
-	} else
+	} else {
+		repo_unuse_commit_buffer(r, commit, message);
 		return error(_("unknown command: %d"), command);
+	}
 	repo_unuse_commit_buffer(r, commit, message);
 
 	if (!res)

base-commit: 6f84262c44a89851c3ae5a6e4c1a9d06b2068d75
-- 
gitgitgadget
