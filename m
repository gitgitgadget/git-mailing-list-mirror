Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CAF2D238A
	for <git@vger.kernel.org>; Thu, 14 May 2026 15:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778773599; cv=none; b=SVUJz/8G8ijmwoDdXk1aG2qJbIjhgZs2RoN7MlOLS21hRBxPLSe6qp3aGDcjgdDDalCgu45jt+l7V9jnFrFvrCZwmG6DqNxPVzeD6i4JSFMh3XdQB23aPawESlN9en1XvHBAKCz9vYpc1t5LTF+VYGeZS0hlaQHyUpH3BxkmKzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778773599; c=relaxed/simple;
	bh=Jy8K8ln/KfLV2wVRDa8gd198pgfdg9/Fr0Kh0Mv+JGw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CLZ5e3jxJlcD5I2YyK+K2m/BbMffLQatnkJYeEkfchq2QSfhBKNmBbeNVjjOwt2H8WZzfOYQ0DBosVxNrh23cUCpWN9vxCPQBu7JLlyVI/k2TpKQCN2/amYrjJLD4QDGGPcHEBadUgPpOyS6evklTIad/iyPJse1c1hS0PuFmsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YNoPVlEh; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNoPVlEh"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8c9166b26b4so11607856d6.0
        for <git@vger.kernel.org>; Thu, 14 May 2026 08:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778773597; x=1779378397; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KxbkaxiNQuxXrNAiSxuwznCHA68kPzMXE0+0bEwcz84=;
        b=YNoPVlEhjFpP9ReMsmy+59MwaO0L1kbaFZFy3Na6kEJeU7H+flzLL6BCnFgzQHEoNq
         O1I8IDV79yTIdIt+HI9z/bk0uoDTwmLHeeYiJUK+PGntyz6I6VS8yecGbQNf+SdD4hg0
         /9gV556enTfqVWmOtOfMghjRlrq8CeDGMcpmtYQeFuRGuZui/KNuDE9x7qOR/FixyWmS
         rqniZpJRdiLKh9aR4sdLMVH4wmjJADjbG3lu9eOsUXt1E8+7ZwRi7R7hq6Ivzepeqt/C
         7w04JBIMApa2VnJ85kJMs9hTg0VKZCRz8XxfToc1yqAieXaQmxJp/qXLudv2oduPvy3S
         ts5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778773597; x=1779378397;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KxbkaxiNQuxXrNAiSxuwznCHA68kPzMXE0+0bEwcz84=;
        b=ac4i6ZxNCRipbn1mFowR5rUwTNK8R8ENFOza9vzTLP3IJAyOOFDlFxc6eoW+eAb3aJ
         frDCS76FzgfNVAWk43lY0UbMJENj+aZBmmRCKKNqRrbFWvnTrqWAxQeo993zLVl+7JzP
         vs6+Uk/EyuXrRHbc7LSOsju0RqBtocwBMqNNPgCpXFduQBGYyqNEe+YTJU/QvWxB7sAX
         FgHD9haxkmhEb5IFrSosw4SftqzO6FDcb68tr9X2BsxhR74vgwpf2YIsrLEn8O6dg4yC
         VWP9wLP90j1Xa5uF+pVj+MoH023Tgtgp3t7OFLNkrWQ8hqjT7xmVRPjofdJnvEPUqML9
         ripw==
X-Gm-Message-State: AOJu0YwAfvFofxfeG8uckQmKN8bGwvr5YoLAw82lJ04JUFrQP1xkaSdW
	XGNvvHeA5TlNzLWnOKjgdAF//9Bjk7yfD6CzfORICbzK47e/iPrL/jDdJAGq/A==
X-Gm-Gg: Acq92OGRvh06WfsakZOzTbhO02b9ABXwKnxNfVlzOfihedHq4dJHpQqe6+DLwA7WDfs
	uffO9VWDiMvOC9dyUi7IYcqeX9K1z1Xy3h8QbdV/Gd/YiSfg6NexC1bg0qUjmGQSpepPKSumUwB
	w16p8L6wjGp0PIXNK7ql7GCLaoxY8JelGUMTQit8HpvnVVea7CcUjgTdrr7xLIihNv2i8tOA45I
	QVGZTX5G9lwUprHNRlF4YS6bRnDiTKOI4xFYSxPV/Gc+TIbUBkzpaWFoZ2fZ7AimBhedqjW7xQo
	Ds8sPbSb07gEvZKqYxX8H9L7kWj8Ix1mS3v9rzFd7eSURTqhPuraEKUm6nko8+85rWqNNPDYToo
	0+mJHkiqfzg+pb3K2xmzUUFxmv42j0bXbU13UeJTmdmo4ypsB+dG1p/zIg/kBmk7QKrJNy00Lb+
	52Jv4bYW7JeCeGMhZQ3EP2+e6DocqM
X-Received: by 2002:a0c:e01c:0:b0:8be:9e6:3150 with SMTP id 6a1803df08f44-8ca0f668a40mr1455786d6.2.1778773597305;
        Thu, 14 May 2026 08:46:37 -0700 (PDT)
Received: from [127.0.0.1] ([172.208.126.102])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c90bb80ed0sm26282216d6.35.2026.05.14.08.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 08:46:36 -0700 (PDT)
Message-Id: <1b2f9d1a07b6e93cc9e137b4fdf6e8f5fee9214e.1778773592.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2300.git.git.1778773592.gitgitgadget@gmail.com>
References: <pull.2300.git.git.1778773592.gitgitgadget@gmail.com>
From: "Sebastien Tardif via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 14 May 2026 15:46:32 +0000
Subject: [PATCH 3/3] daemon: guard NULL REMOTE_PORT in execute() logging
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
Cc: Sebastien Tardif <sebtardif@ncf.ca>,
    Sebastien Tardif <sebtardif@ncf.ca>

From: Sebastien Tardif <sebtardif@ncf.ca>

The REMOTE_PORT environment variable is used in a format string
without a NULL check, while REMOTE_ADDR is checked. If REMOTE_PORT
is unset, NULL is passed to printf's %s, which is undefined behavior.

Add a fallback string for the NULL case.

Signed-off-by: Sebastien Tardif <sebtardif@ncf.ca>
---
 daemon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/daemon.c b/daemon.c
index 103c08d868..78cca8673f 100644
--- a/daemon.c
+++ b/daemon.c
@@ -753,7 +753,7 @@ static int execute(void)
 	struct strvec env = STRVEC_INIT;
 
 	if (addr)
-		loginfo("Connection from %s:%s", addr, port);
+		loginfo("Connection from %s:%s", addr, port ? port : "?");
 
 	set_keep_alive(0);
 	alarm(init_timeout ? init_timeout : timeout);
-- 
gitgitgadget
