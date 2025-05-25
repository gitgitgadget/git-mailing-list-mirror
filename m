Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A8C17BED0
	for <git@vger.kernel.org>; Sun, 25 May 2025 10:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748168359; cv=none; b=Q2KSV8Scmkxk70ihbq2ti36qtKyNzadehVgv86w0V07IXLwtkB1wxa/aB+ewW3XQZxfA5OfgRhcxzMWix/kgGx3ZVX3oytLIyBbOUJEEJvIwxJPOGS3FkNnta8DsjvN0Hnl6dhvp1L/hRQZBNngnHL/b6LxVD71zXKUWR0FTUiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748168359; c=relaxed/simple;
	bh=g8Lvl6B6IMvqt6W1zCHKhnP1EZfkYHa+0TFuBzPEDr4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=kzfQUpUTW4bxOGQrJlL0hap1M/KzmHOItJ1+tGpoFpsu/2NI1bFHj9QWlQ6rqUoCSya+exwSMByghu7FlpLodzFuVWqbnAGKhQB96vnQSsdgvKW6tUAisuGxqXjOeaou6Pjo7tTGFX25ye7olwZGecgwT3tNUAGqK8yxR0pIWsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CEq5gGWy; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEq5gGWy"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a4c9024117so995157f8f.0
        for <git@vger.kernel.org>; Sun, 25 May 2025 03:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748168355; x=1748773155; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dJcdTI+rWBhUSRQP/LtGIHG/k2qSr1X5QOkM3jSsq/4=;
        b=CEq5gGWyMbKMCKSUYqL4+UTff9iyQlJOz8irYKIUlZ2HR6ayoZUgDOZNwB4nT69cFG
         MkncJoINT96xh8+N7ZvLEUU2xyC6KAnhTwEyf/g7HtxdubI/0J1qoa7HbskU4OgnvHDz
         SlE0wuuOJoMAJz3uv6MpCouLq/jB5jObfL0Y1/G0p4gU0o0EyzhuQTXStHEKd8SXqcX1
         VtV0n2Nk3tCzqNzvtlQwHx0R1HS+vGRl2i0CpL2rk6WJJWb1eeaVy2o0JGWCvpQF9Upt
         +bol1npyPhAgYmPDxLL8C+toSIuzKhJjG5fDy+iaHB1YUOCsJYaXSz6rWxbKA9cU9ket
         kJvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748168355; x=1748773155;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dJcdTI+rWBhUSRQP/LtGIHG/k2qSr1X5QOkM3jSsq/4=;
        b=Z0JD3fYu7p7d6Ulr+6ZKwQ06FqN8osm2GccH7+oulSLCoFVt0cbLeelq9485SvSZCl
         WOjcBEbCqMJv6/ndf0qFmc9OrwyXHRodeCnsNfCJfQlehmdxsdSzWAZI5Iia711r/NNH
         D03ytZoxwvwpaKe4EvqjM6T3a8LJ7COTcqezCio430rVYgqTq++hyF4aGVGSoNbgt8ia
         Ug+sXC5wiiq+mm7y/Uk4tDpMxkQpYu3jAPupmIyGcyuR21Et1ZZ2Xysxn4/n50ejwpAR
         AzErSt+DdKtA+9KNue9y3+7t1QUKlXCe+ftd/K0o8YXD8iovjVC9rkP4lgXRyO1XxJjF
         3ULQ==
X-Gm-Message-State: AOJu0Yz0slt6cncVECBw+YTR7lZ+aMBmuUSwlcIOBe6P1EVfZDF9B7K4
	rRP4ENi8scurpNoYrf4WbpWt68xdr2KRMSOI+Pbc9bn/Xqh7sDCtwJIGQWUp5w==
X-Gm-Gg: ASbGncvgXZCERNPMKRyfdoCkQ/24gAA0gv8nKJIRLBBcHHmSdSoFzHAXZXa9RLN0t7i
	UWzTyAyOG5wjBeiK1/XZJpNPceXufwFuWMo42OvEJtY36uAoA+WtdZvQQSUMJYTGFqx9H838MSJ
	ndG8litjuIz+F9txXL3f7VH6NNkwE6ZWiqq+yXFkGHM0Vbee3wWH3MVAYuawzNeAI2c50GjxqmY
	75X9QzVBVO1lnNsNwO1K2/HKv55qVUzRmF8nagV1eAvPcOHpq0PlEIwZjtQPj82/8VkK9hjQdFq
	in537eVvO1nTp4X7WYJZ/gp4cWxyQqzrJWBqlPUg4AJnKIYwOCbt9CciMQK8sU4=
X-Google-Smtp-Source: AGHT+IHNUIkeFEd72Sf9+Q54J3yAXmdv5bOpSKNzrAVJbzr8Z5l4jVG29enERccKmG/a4U+iYRtWPg==
X-Received: by 2002:a05:6000:26d1:b0:3a0:92d9:dbf with SMTP id ffacd0b85a97d-3a4ca123d71mr4401340f8f.3.1748168354439;
        Sun, 25 May 2025 03:19:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4ccc2c88dsm4515807f8f.69.2025.05.25.03.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 03:19:14 -0700 (PDT)
Message-Id: <pull.1964.v2.git.git.1748168353204.gitgitgadget@gmail.com>
In-Reply-To: <pull.1964.git.git.1747226641249.gitgitgadget@gmail.com>
References: <pull.1964.git.git.1747226641249.gitgitgadget@gmail.com>
From: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 25 May 2025 10:19:12 +0000
Subject: [PATCH v2] sequencer: replace error() with BUG() in
 update_squash_messages()
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Lidong Yan <502024330056@smail.nju.edu.cn>,
    Lidong Yan <502024330056@smail.nju.edu.cn>

From: Lidong Yan <502024330056@smail.nju.edu.cn>

In sequencer.c, caller only pass TODO_SQUASH or TODO_FIXUP to
update_squash_messages(), any other command passed in should be
considered as BUG. Thus I think `return error('unknown command')`
should be replaced as `BUG('unknown command')`.

Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
---
    sequencer: replace error() with BUG() in update_squash_messages()

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1964%2Fbrandb97%2Ffix-sequencer-leak-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1964/brandb97/fix-sequencer-leak-v2
Pull-Request: https://github.com/git/git/pull/1964

Range-diff vs v1:

 1:  a4bf7dd1cf6 ! 1:  aa5ff030b37 sequencer: fix memory leak if `update_squash_messages()` failed
     @@ Metadata
      Author: Lidong Yan <502024330056@smail.nju.edu.cn>
      
       ## Commit message ##
     -    sequencer: fix memory leak if `update_squash_messages()` failed
     +    sequencer: replace error() with BUG() in update_squash_messages()
      
     -    In sequencer.c:update_squash_messages, `repo_logmsg_reencode` returns
     -    either an allocated reencode string or commit buffer if no encode is
     -    needed. To free `repo_logmsg_reencode` result, `repo_unuse_commit_buffer`
     -    should be used. However, when encountering the error("unknown command..."),
     -    the absence of `repo_unuse_commit_buffer` results in a memory leak. I
     -    think we should add a `repo_unuse_commit_buffer` before return.
     +    In sequencer.c, caller only pass TODO_SQUASH or TODO_FIXUP to
     +    update_squash_messages(), any other command passed in should be
     +    considered as BUG. Thus I think `return error('unknown command')`
     +    should be replaced as `BUG('unknown command')`.
      
          Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
      
       ## sequencer.c ##
      @@ sequencer.c: static int update_squash_messages(struct repository *r,
     - 		strbuf_addstr(&buf, "\n\n");
       		strbuf_add_commented_lines(&buf, body, strlen(body),
       					   comment_line_str);
     --	} else
     -+	} else {
     -+		repo_unuse_commit_buffer(r, commit, message);
     - 		return error(_("unknown command: %d"), command);
     -+	}
     + 	} else
     +-		return error(_("unknown command: %d"), command);
     ++		BUG(_("unknown command: %d"), command);
       	repo_unuse_commit_buffer(r, commit, message);
       
       	if (!res)


 sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index b5c4043757e..3cd0dd3434e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2139,7 +2139,7 @@ static int update_squash_messages(struct repository *r,
 		strbuf_add_commented_lines(&buf, body, strlen(body),
 					   comment_line_str);
 	} else
-		return error(_("unknown command: %d"), command);
+		BUG(_("unknown command: %d"), command);
 	repo_unuse_commit_buffer(r, commit, message);
 
 	if (!res)

base-commit: 6f84262c44a89851c3ae5a6e4c1a9d06b2068d75
-- 
gitgitgadget
