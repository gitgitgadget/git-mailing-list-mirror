Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46CD3164B0
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 19:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756238274; cv=none; b=ffqBU0DifzuITA7OxImTYO14cmGln34xAX1x3N12AamEn2pKu/XlMEIyqYs0TV+8HJi0eXl0RW0WhRFNxza1jvwiDpUEzjeU/RbVw6Trr9sAXEB/0ZP5lK2AYy6/xjkC/dmEJEzhlhmvzLBvEESkpZVnikZG5gisTA0zWcDk/ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756238274; c=relaxed/simple;
	bh=fcr13ttIxlL3+g8miyVVI37Ir4cX3Tuaol8MVcq2Al0=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=B13D7RICBjy1URnsTn5xg7PktoLJI9DBpDasc6rIuttatc2drNiKQz61ucvujKtC8rw5sE1e/ijo7C2DqRu3hREDUNxQsbNbolId+hTHKXNfcKWE4muCcdU0+5dx2f+GKW8oZeaZjNHyiw0qR705eQxoC1MDK/z35aiGgNhSWDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BRutANON; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRutANON"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45b4d8921f2so44647265e9.2
        for <git@vger.kernel.org>; Tue, 26 Aug 2025 12:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756238271; x=1756843071; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kUZA27y2s3NaxFtdtl/5q29VAvU9k74kG+HPhILYko0=;
        b=BRutANONn3uCkVZy6gnCCl8MD6ekvIc7i8GDHzx2f3CzibmANzvZ8ir5ZggiCcJflE
         b6LNEJAzJdT19Rw4Fm77RP1QFOR4D9fFgFMQARc83pDmUwjYcKYePddpDE4y2tDevcCG
         o4Uzu8UllaHlSXTOnwQpzSEqP47ESs5TwqI5Rj1YCiL6hYFu95yeqluu8Ah2G1aU4T6Q
         TCsij0BXQCWBFcLaYMJHoFgVd5najsTeBqvbAkcgDHKsww1+97OWnD8VYrJmcHW3Ap93
         Ii012+uItZZtk2sk2JsWqTMncs5xZsCG3gY5B0i4KXUWQi0c+Ip04PqX/SfBJ87c6r0A
         U/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756238271; x=1756843071;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kUZA27y2s3NaxFtdtl/5q29VAvU9k74kG+HPhILYko0=;
        b=TRIlpArZljEHdKxtrAM4e/9MhErJyGe3+GGOCvQy5QaCng0F980JT6T6Jf7ay3fDhq
         9UANkHYK/ovynzSM92VesovVJ1Ht55XKkTFtMkNb21vcUeEaKXvIkaAxnGTAjUnHJj1w
         RJLqnf7EkLHqE5WHm2BeMR3CcN0/5g63JXzVN59g1BaJUJcbg8Y357njrFeYu+PiUhu4
         mfqMj5QrkxXWUFZ7Ad2GZazfS2Lkm4szQ1UVIbw9VLd2zOolAkuIk5PS6kPZqFnGSjCG
         yRDd0uxlQzcvFRF4+WXSj3OVxrtJ5kp3efNiIg7y1v/QnBEZ37i/C06lnlVNwWNfaXSq
         ad3A==
X-Gm-Message-State: AOJu0YwbXjI4b+Ekv1LKkMCE/yJPgnzJoJgX/ErkcYILdGlHPPVJT2on
	Hc/TJY9N4r/DszXS4U5uJkqdpVSS/MJi/XOwxMRr0Drfq5e0L7BxKiFoH2wb9g==
X-Gm-Gg: ASbGncvvQ/s+Da6G2/cwuIvbq6IK7rHUEww+HxfpI0huhI7c8DhJvnuQSjUJvc8E2sA
	Ap/RKUDuy2bxCe5kz8c+ATnrq58JhwSzNFNq+hsBRK+jw1tu5BA3oyNc4TW9eeuwGsgXo03br8o
	GqUadyAah6fdQ2l9nBtV5/7ExJ9+5ros0b3xwt2Lp9S6yGcRo0tHRSl4mGaYgBUq04MCYRM5GUL
	RrZcXWoe1FEeVBNZT3cfOsvJPG1QLOrwcPaZkLgLm97tcjhju669Ng30o4S01mCBKdkKOO7yDdz
	24rwEND0+bJ6VqHxE4/56vXOds1+7581qzOXwAsR/gIE92I70ZIWUNViqvQoHrCRrWru4PYNoCQ
	1vlpCOTTYSk84Lzn9Fo/mACif85M=
X-Google-Smtp-Source: AGHT+IEIRw5ztT8gestOjcfMi+4fBxpPOsmUCQUlU8kKtYi3/mc2MwCyjQB7t30Maj5a7mR32LjCbA==
X-Received: by 2002:a05:600c:3505:b0:456:1dd2:4e3a with SMTP id 5b1f17b1804b1-45b6bbd3411mr5438225e9.3.1756238270523;
        Tue, 26 Aug 2025 12:57:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f0c8b6bsm227055e9.4.2025.08.26.12.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 12:57:49 -0700 (PDT)
Message-Id: <pull.2040.git.git.1756238268790.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?=E3=83=8E=E3=82=A6=E3=83=A9?= | Flare via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 26 Aug 2025 19:57:48 +0000
Subject: [PATCH] reset slab_alloc and state fields in clear_alloc_state()
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
Cc: =?UTF-8?Q?=E3=83=8E=E3=82=A6=E3=83=A9?= | Flare <nouraellm@gmail.com>,
    =?UTF-8?q?=E3=83=8E=E3=82=A6=E3=83=A9?= <nea@odoo.com>

From: =?UTF-8?q?=E3=83=8E=E3=82=A6=E3=83=A9?= <nea@odoo.com>

clear_alloc_state() freed all slabs and nulled the slabs pointer but
left slab_alloc, nr, and p unchanged.  If the alloc_state is reused,
ALLOC_GROW() can wrongly assume that the slab array is already
allocated because slab_alloc still holds a stale nonzero capacity.
In that case s->slabs remains NULL and the next dereference writes
through a NULL pointer, causing undefined behavior.

To fix this, we reset slab_alloc, nr, and p to zero/NULL after
freeing the slabs.  This leaves alloc_state in a consistent empty
state for reuse and avoids dangling pointers.

Signed-off-by: Noura EL ALLAM <nouraellm@gmail.com>
---
    Reset slab_alloc and state fields in clear_alloc_state()

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2040%2Fnouraellm%2Ffix-dangling-pointer-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2040/nouraellm/fix-dangling-pointer-v1
Pull-Request: https://github.com/git/git/pull/2040

 alloc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/alloc.c b/alloc.c
index 377e80f5dda..6bf9421c123 100644
--- a/alloc.c
+++ b/alloc.c
@@ -49,6 +49,9 @@ void clear_alloc_state(struct alloc_state *s)
 	}
 
 	FREE_AND_NULL(s->slabs);
+	s->slab_alloc = 0;
+	s->nr = 0;
+	s->p = NULL;
 }
 
 static inline void *alloc_node(struct alloc_state *s, size_t node_size)

base-commit: f814da676ae46aac5be0a98b99373a76dee6cedb
-- 
gitgitgadget
