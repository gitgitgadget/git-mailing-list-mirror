Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3625234D92F
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 11:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765885588; cv=none; b=O49JNaiQysc71bs9YqOxh7xVQ++pWEiVN98VwDx9pa972hwLnj89I53CwplUuB3hgJFP7wDftGU6sBaBto6BO338/kqMM3/olWoYiUo/O4X690uRIflLLu/Omkf0xy/x/cgrVBEAHtDyXS8hYUJwUoICgUXLFjzl4qMgSXN8sgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765885588; c=relaxed/simple;
	bh=FmZ1EmmFxNcMpg7KM7vErvr9YWR3QeIOBWc7lA2I9mw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=YxKV0OWLkFdob1L4smI8SfJpdQJpvDcFADUJ/9Q5XseXEoFGzd0IG8FRGL0Q2z6KdEvw2zQgQSMYuy90CtimnALtljvYzj+VbOyGk3MT5R1kf2016k1esE0I77O4Dij4ThE3n1xwfqz8LzaFcVSYxzh65z9ZgWlPvy8Z1GixVcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OmMu8xcY; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmMu8xcY"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7aab7623f42so5352037b3a.2
        for <git@vger.kernel.org>; Tue, 16 Dec 2025 03:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765885586; x=1766490386; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jln5oKLuVcu/8Peam3zLKYxnxJWWhgAblJ1HPG65xkM=;
        b=OmMu8xcY4yN1fOwhuUQH1jrfsnVrr7cyO6RE2KUT5ZYAiFyUdT+kLXd53hjbPbGBnY
         suXt3KRIyRHcbgGLHgWib1FZbRb+vfQcy9lxL0+Ys+2H6g1cQ8pcPcwuqyzDUUzfdGtq
         QrWYCMUeNeTUliG5tu6VkPAZ1xC45U9uVrkML8Dgn6iN5ixZpH90dlqY6X17rES4z6YN
         x5zc5QSf74jvRyhi6NlZvSN2s+G1cxns/f4QXIJ5gzXBDGXvRAXHYz7pZPacfpkYn7+u
         qgVf5cE0fnUmaDoWRDaXAXhgfjEZoNqOwoz7WesNNAxLE3MzhViibluPLRguknGdEAAG
         3IIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765885586; x=1766490386;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jln5oKLuVcu/8Peam3zLKYxnxJWWhgAblJ1HPG65xkM=;
        b=XQEGd8FSXv13dF5QBQDq0hcGXLrxRKEuWDAcHphzGqZI0F42xP0ee5oq+5fUCTurpW
         NogEJWV+AxBZ7TTfrj4Uwjd2P5XIRO0JtYh0+G9SIACpHtXpxf6Tlsu8euWPnVZlAdeI
         cQGevovI9OpQwkQJntLRAnfz7EH2ICkRQO9WY1Y4NWro1dn5Yvkf5Z8TxgPkI9yknCDE
         22XT64Wt0uAIbiv5qQLW5EP4dcMXVgB6itThiQMLWd91MazQb8kXCNc6TgyHeE3C2jHG
         g3WfRIvusMQLgX5z8DP/F8Jv1XPhyjp+di2qYQpc00+i2ZAA6SaSGg7wp9VixHOD1n5I
         Y0bg==
X-Gm-Message-State: AOJu0Yw9Pk0rrM7txzd9GuwF9JtJg0uLPdXgpkPs3NLKFR3OAqYyCA2P
	TAv76y7hIY3kX0VaRlvDctT6PWEvOlt1c1jKYz4jszb0ZLC2oeQ2y5gzPs5oFQ==
X-Gm-Gg: AY/fxX4km8hs89hrIheE16xTnQFIzfGEk4tNogfPB6t208S4Sdx9rUsHviMA0nJk7GC
	sokc9QfF57NoqLA+CMXHw7NAyI2Rjp0bfLQUcrwSLqrp1tBtK6Tseaq2ApfOFHjT9ilPw+n2Wyf
	OHo+Gos0S4UFQxRpsF8yo24yzFxgYaThOgwyQ71Els0kSLHuV/GOCZKDyXul2x0bdK1giptBhX3
	tj9DdeQ0CKvnGOX8nFrLWV62IvNwUI1sH6ekL9JlLJNhVOjniKGHsruKLh3V/9zPfpuUQrbVXBY
	AX+5rTONUaoN1/wx/CzH8zt1O2Aj4XImpi8aiF0GBloh4OSfQ8MPyHLTtiNlaDn/8EcNzCiQW6h
	pFJQdWXCnhKhrCxND2D4Q5w+MRjJglg62KUm1ts2qCoZBImCPf6iEwJFdbUkgv25fNCH8N1uUGW
	IMuoudwC4cuh3j
X-Google-Smtp-Source: AGHT+IF/FphU0sZZ/1s6GGbrzmCbZio3zmWOZdjMGvAjWnSBpFCwsX5mSxJSnwRTBkjabPI4UjdR9A==
X-Received: by 2002:a05:701b:2407:b0:119:e56c:189c with SMTP id a92af1059eb24-11f34ac1a1bmr7008524c88.4.1765885585969;
        Tue, 16 Dec 2025 03:46:25 -0800 (PST)
Received: from [127.0.0.1] ([52.161.69.165])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f2e153e7esm42988255c88.0.2025.12.16.03.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 03:46:25 -0800 (PST)
Message-Id: <0d371ee552a0fd8aaad9e94c3a7477823852d25e.1765885577.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2009.v3.git.1765885577.gitgitgadget@gmail.com>
References: <pull.2009.v2.git.1764946945.gitgitgadget@gmail.com>
	<pull.2009.v3.git.1765885577.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 16 Dec 2025 11:46:12 +0000
Subject: [PATCH v3 05/10] t0301: another fix for Windows compatibility
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
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Just like 0fdcfa2f9f5 (t0301: fixes for windows compatibility,
2021-09-14) explained, we should not call `mkdir -m<mode>` in the test
suite because that would fail on Windows.

There was one forgotten instance of this which was hidden by a `SYMLINK`
prerequisite. Currently, this prevents this test case from being
executed on Windows, but with the upcoming support for symbolic links,
it would become a problem.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t0301-credential-cache.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t0301-credential-cache.sh b/t/t0301-credential-cache.sh
index dc30289f75..6f7cfd9e33 100755
--- a/t/t0301-credential-cache.sh
+++ b/t/t0301-credential-cache.sh
@@ -123,7 +123,8 @@ test_expect_success SYMLINKS 'use user socket if user directory is a symlink to
 		rmdir \"\$HOME/dir/\" &&
 		rm \"\$HOME/.git-credential-cache\"
 	" &&
-	mkdir -p -m 700 "$HOME/dir/" &&
+	mkdir -p "$HOME/dir/" &&
+	chmod 700 "$HOME/dir/" &&
 	ln -s "$HOME/dir" "$HOME/.git-credential-cache" &&
 	check approve cache <<-\EOF &&
 	protocol=https
-- 
gitgitgadget

