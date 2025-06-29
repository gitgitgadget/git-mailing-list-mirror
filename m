Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2291F2222DD
	for <git@vger.kernel.org>; Sun, 29 Jun 2025 13:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751203250; cv=none; b=Uo5WBTkG/zSCuulh7W2d50lqdPVMTbFH+93F6MhoZ+KAixrGXnN8nsXXxC/UnnFLJbdIlnvtm8pzX3mqtbx1YhaA8aP76upKiYPCrEh6aA7ZjKIR6J9XYGpUgVmold5vsoky8dzunip+RHozhwBEpOXOxdHIDFudIMiVyeH55qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751203250; c=relaxed/simple;
	bh=ycuh470JgOMKOPCZ5ZyCa53f1xY0kKsH2F4D/zhuIJU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=Gbn1Gdmi9aOzKcanEaFkqgVOvMBOz4axQJxe7HYO5tH6t2tFI8pO4PxI6j/gtd6rNT57ika8c+UeWw+hMNmeb7xji2sDyk+EAGhs6OI6XKKI/DbE4a6HqsLGX2jg3uCWeL1be0hrJQI49lFcGkZ+5KSyM72kiAnHZSlRbp6NIqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QmYdgquT; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmYdgquT"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-453608ed113so13525405e9.0
        for <git@vger.kernel.org>; Sun, 29 Jun 2025 06:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751203247; x=1751808047; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CtGLQIoK+r3lkTuRkZEbs3LHqcoKyxr7lYoIjxI11zo=;
        b=QmYdgquTFiBCAAU8w6gYPskqHoJ7hDFvp4d+EaQ8iRA+XnW8kJtaDCuilYoIIZ+tlC
         EPjkoOdzG3YK4JuSExdzNqhu2nlQ+6F5k1KgTvQrWPovcn6HqiSfRxM0fqMBE/MHkHuP
         7oZLB15GwisNm8B5lzNx4InoWZkx+izOe8AqUWDX7TS60RDLHk4px+YRjsRtTgK6VYy5
         X0nHrZABJQVT8yZtsqQFNolxnk2Es6uGtUaID6zH9jy2fYOjtm85ojWUyE10l8D185do
         KSrXyd+0GF3hhvCY3CuYGio1lDgrxiyf+mZxvA23RSQfVjdnJseqpD7SCnNwySe0X68n
         tE2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751203247; x=1751808047;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CtGLQIoK+r3lkTuRkZEbs3LHqcoKyxr7lYoIjxI11zo=;
        b=igz5w0mHEYMHEaNlgqnYHJLGw1nq1hmQ6zqQftAkfRKbOKHS1VLpbMh4TVUfL+jtck
         w1+7TU8L4iSlQw4GGHNHAFAA2YN57DKrb2IW1DX74tU6fqvGrNp8+JB+h2Oh/sIXGQzN
         Hz0NAsPUmMJA6SRTzKZSL2f05iTEDEdb2C33oydTUdZSFtTjev26FRc6cqGFqbKmEqPx
         nL21S/nO0vqDA2nMQjPVC2FGj9hLOvoCkvpIsalpX1yzAzcBZgk1qHBYcvkt7XLfr1rc
         9qs6OhJ+Nn4MV/jM+rfHG/RgLVSjxNACe6Xh54py2QTMy6YGN8QCfvgX8vnTSSJFjI1P
         l2vA==
X-Gm-Message-State: AOJu0YyFOps5z/O3TLwNI9LCb+Q5jMIIhmG0qKBLCJlczC//f2rkSZAD
	OHIPXj0gC2JvTAUrvisf75rrZdO9hagKMIOCwj994dSDc4QvmZ3wUrWaY/xbgQ==
X-Gm-Gg: ASbGnctQjCmIrzwqm8g0RSczQ5QzlJFCXraaEHpIuezMP/rU7GVaZ4paJTkhEwzAe6+
	VrjpBvz4g5DBKawU1PGqN1Gt6KR3vR2MdZQcN3r3R3nHT1utauDcVzY7b5K2HDDnNbE4rQQ1M5k
	VU6UmdQDPppSZPgujZs+8xw0rVfxywJjmMQwiaFF6LR2C7nVRQy67KAqYfxYC04OP0ocDabkAl1
	V7HnBbE+9r0shMZE2Ol8MHKcxBViFhdOT6+NFROkZpJO87f/T98YC6BHZpNuBZBk0SCkD5VfXAO
	mrWYWKROimAUiIzjT2nhFC3R+MTxuQbJn2AiOAz9IIkSZt4qnqs7cUFDsJ1QpBU=
X-Google-Smtp-Source: AGHT+IHF6C9fgHEv8e8qqRHlR/0e/n9T/Fsup9nJFX7iTYqhkeCe/VIfJVKDtR8y/KpY5TRUNZeNxQ==
X-Received: by 2002:a05:600c:1911:b0:44a:b7a3:b95f with SMTP id 5b1f17b1804b1-4539264fd0fmr74977665e9.25.1751203246716;
        Sun, 29 Jun 2025 06:20:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7fb67dsm7894615f8f.35.2025.06.29.06.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 06:20:46 -0700 (PDT)
Message-Id: <384a7d23563ade9764a261be5492dc229445a8d0.1751203241.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1933.v2.git.1751203241.gitgitgadget@gmail.com>
References: <pull.1933.git.1749373787.gitgitgadget@gmail.com>
	<pull.1933.v2.git.1751203241.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 29 Jun 2025 13:20:36 +0000
Subject: [PATCH v2 4/9] doc: git-log: convert line range format to new doc
 format
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

- Use _<placeholder>_ instead of <placeholder> in the description
- Use `backticks` for keywords and more complex option
descriptions. The new rendering engine will apply synopsis rules to
these spans.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/line-range-format.adoc | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/Documentation/line-range-format.adoc b/Documentation/line-range-format.adoc
index 9b51e9fb6614..3cc2a14544cf 100644
--- a/Documentation/line-range-format.adoc
+++ b/Documentation/line-range-format.adoc
@@ -1,30 +1,30 @@
-'<start>' and '<end>' can take one of these forms:
+_<start>_ and _<end>_ can take one of these forms:
 
-- number
+- _<number>_
 +
-If '<start>' or '<end>' is a number, it specifies an
+If _<start>_ or _<end>_ is a number, it specifies an
 absolute line number (lines count from 1).
 +
 
-- `/regex/`
+- `/<regex>/`
 +
 This form will use the first line matching the given
-POSIX regex. If '<start>' is a regex, it will search from the end of
+POSIX _<regex>_. If _<start>_ is a regex, it will search from the end of
 the previous `-L` range, if any, otherwise from the start of file.
-If '<start>' is `^/regex/`, it will search from the start of file.
-If '<end>' is a regex, it will search
-starting at the line given by '<start>'.
+If _<start>_ is `^/<regex>/`, it will search from the start of file.
+If _<end>_ is a regex, it will search starting at the line given by
+_<start>_.
 +
 
-- +offset or -offset
+- `+<offset>` or `-<offset>`
 +
-This is only valid for '<end>' and will specify a number
-of lines before or after the line given by '<start>'.
+This is only valid for _<end>_ and will specify a number
+of lines before or after the line given by _<start>_.
 
 +
-If `:<funcname>` is given in place of '<start>' and '<end>', it is a
+If `:<funcname>` is given in place of _<start>_ and _<end>_, it is a
 regular expression that denotes the range from the first funcname line
-that matches '<funcname>', up to the next funcname line. `:<funcname>`
+that matches _<funcname>_, up to the next funcname line. `:<funcname>`
 searches from the end of the previous `-L` range, if any, otherwise
 from the start of file. `^:<funcname>` searches from the start of
 file. The function names are determined in the same way as `git diff`
-- 
gitgitgadget

