Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD98731578E
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 16:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771865517; cv=none; b=KztiOdyy/IDa2Zqj0Rac1tiB4h7sMGZc3f3IYJjhKYcAgS298IQv0Mcmvlc8/uY8CVwIn6BJS9N+14YmceEFZz/Ke9ZWEgwfmdwHQlEMItCMt9zIdGUJvvA5rhliQy7xCGxlFRpD7nGSypXj4mgLPhpBRDLFBr5yAiIjB4vzZFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771865517; c=relaxed/simple;
	bh=NSRR0ud3IbFr9Et9MTm1QX0ZoyL8Hei1ze4euKfHVfE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=svjbBNvGQDnSSoaZoow+9QuA5oYI0sr6MbhopZIolTnQhHc+b7jxwHJDsnbJYUZC2iJY6HAhEomzvNuNvHg4dQaJlkz5oqzm3jdi99jARJoiqJhs5satUrlGIgsdzTqOwVqbEgW9lriE8nUk09UG2g/uuloQ9nKXOUeE1NJRPZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NzktRO9I; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NzktRO9I"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3530715386cso3726900a91.2
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 08:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771865515; x=1772470315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YG9d2PRutyRb7J/QtjR4+gxPZisC2ExQsx/hvXugEFM=;
        b=NzktRO9IuUCy0xeDZflEWSJ6nrlYQ+iOb1P7TG9MDAThgYu9DzqNMebU08E7OyT68V
         bY7rRmZaxsxpbCYRrSxbJD/+U9cPHAGbyJK2bboKfLd9KE7ADI764Ase1WEzPtS54NpS
         FR/7JKm+hVmeIbwgwyrM5LJITkBMaTABQgL5f0kmAp8d/dRdIIUfZTqKMD7NEH3LAb/+
         eElU8dpw6seKqncEMqwNjhLeFGHVLs6jQUkwQvj+qy19KApzIMnpZreDJs9f1cqVfGjZ
         GPBdvryMZoWO8M7KdhZxxu43Wa8tR23LVUQraehbbRVUNF57jcVyYreYHGAQ783tac43
         mgag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771865515; x=1772470315;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YG9d2PRutyRb7J/QtjR4+gxPZisC2ExQsx/hvXugEFM=;
        b=mc4e3G3+LmSQmwomAQpR3ZNIT5T/FlPwYxUsXHtioq/Hqn6drnvSJX2r2XXwm9CXfJ
         ymfIcqhn09yX4Xb5krvzVwpPJLhuG40rV5FEJ5DDuk3Om2i+cUPRW+MGRh+rJ9Adi1Bo
         rDAPDGyXGC4kQbjDSfXv+yZEUdOhTZRMdSurjHh8iMlYrzZwR38lIIYCmKUsfKA2llp4
         syGR0R5xnoSdPi+TwROWRTWwflr0Kh2d9neW4t5W1RJSzc6/SqrWbvqIQMI/R2ucDQ5z
         ByqQOhP1lrKI9e/3gDQJTNNK/sKFhEExmVLdBEajkFIb+ngHO8PCBqFvLWR2s34uOMwu
         Reng==
X-Gm-Message-State: AOJu0YwvkX80wHb9WkpEHOdnLHxCgWuHhGoQadArZeeM8EnoU+05AIau
	wTY7QTsHj+QuWrXJ4RSxqZPJTst474vCcp/AbfEmb6Re8CttW4lRkVf7+jpn3Q==
X-Gm-Gg: ATEYQzxz9OWkyDL4G2T21aBUBoAYmTa8PV9we6bZw29Tt42FuWu3hPMstAHOyN4Y2vX
	dEmr+f9BodZSP0oXjfx3ra7FNVuPhXWOZCwhNFh1FRbMI+PjyGn609i10WVZZQic0JLPRYrVVPa
	vORczl0ip9+pjSiVEpdj1A5xE2N1gXxsdCkivrHe4lps9qb6F6pcrGOkvg/6/UPXDsH4b7QmTaz
	vQbSItII3tH+e33DICJCWDWVQXlHCiW61KuYTeB/fpQqe4zILITauGjSXb+M6MaJLvVkFrfls60
	/YMjKE2YeAADCjTB36IR40o/l7TmA9QhzcYYp27HIlPlD7wD/QtWYGj15+A8Ler4ZWPApwXsfJn
	dabtJZ91xttYWAXDHNfGiWAFT+SUc9b4U7qDVY4RpA4vwhooTx9Tj12srzRLhihbSWogUZBUKVI
	t4vXEGIOmNPDrye2FIeROQ8TM3nC0BtrwFxQq18gpVP3JHShI=
X-Received: by 2002:a17:90b:3881:b0:354:c629:efaf with SMTP id 98e67ed59e1d1-358ae8dc667mr7222570a91.35.1771865514867;
        Mon, 23 Feb 2026 08:51:54 -0800 (PST)
Received: from CPC-yingh-DJJP7.reddog.microsoft.com ([70.37.26.37])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-358af71f9a3sm7203971a91.6.2026.02.23.08.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 08:51:54 -0800 (PST)
From: Andrew Au <cshung@gmail.com>
To: git@vger.kernel.org
Cc: cshung@gmail.com
Subject: [PATCH 0/1] Fix zombie children when git is PID 1 in containers
Date: Mon, 23 Feb 2026 16:51:46 +0000
Message-ID: <20260223165147.3294516-1-cshung@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When git runs as PID 1 inside a container and exits via exit(128) on
transport errors, child processes (git-remote-https, ssh, proxy) are
never waited on because the normal cleanup paths (disconnect_helper,
finish_connect) are bypassed. Since PID 1 has no parent to reap its
children, these become zombies that persist for the container's lifetime.

This patch registers atexit handlers in transport-helper.c and connect.c
to ensure children are reaped on any exit path, and clears them on the
normal cleanup paths to avoid double-waiting.

Blog post with detailed investigation: https://cshung.github.io/posts/zombie-git/

Andrew Au (1):
  transport-helper, connect: add atexit handler to reap children on
    abnormal exit

 connect.c          | 17 +++++++++++++++++
 transport-helper.c | 11 +++++++++++
 2 files changed, 28 insertions(+)

-- 
2.43.0

