Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C032157A6B
	for <git@vger.kernel.org>; Mon,  9 Dec 2024 19:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733771899; cv=none; b=Q8WJQ50u8klSy14I1au8Dr359cRUFXYwWjD/8Yy1Jab87R2kqTBpDdcjQ8csRoMQszM73LO3eyN8qvRQVYTtj7aJprwXIYrprTaHIqr1wtH9HusxVOFh/9xBVCtfj77Y2ECHJDjH5snlzn3GOp4Lf/zHwIzekCB4yAtsIVg8Eeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733771899; c=relaxed/simple;
	bh=DMENNpoFGFrpF8WOSyd5dYHovODTMriUvWQ6NJyvk74=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=R3Chms8yhpG8iFtLtklUDF576bvPjRsYwx/vBxHssVOvDgLP7iufL7Ua7F2cikTawpHIKqyIVZQHEsnJbcR3EmOPvNG8Xp1m8iDCFjrI+0z+ZDB9Sig+f83JlsbIla4snzjvABxmy3E2/c2mRBFMQPEHtKHaRviM+6wRiiANJag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VoPaBmyB; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VoPaBmyB"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa69107179cso208947966b.0
        for <git@vger.kernel.org>; Mon, 09 Dec 2024 11:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733771896; x=1734376696; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HwwgXai+acc6VeZX0f/peyynjrwSCIW1sUjj9BmcTp4=;
        b=VoPaBmyBolmYo035dWFNfw212F2D7Fw4/jdIUpG+X0UFkX8Gu6CmGmv9sP0/p8XmLN
         461e3d1dD6NejBTLzF+w0/2VcrmxAhmRO4XIvNkIGOGKdacjoMNgskWaanZlIf3Lb+wA
         Ns9A2wArwT57bgWBkCSvtbnLPd/F2i5VKBndwBlm1agsYTSVlUx8fysoqpyFNCmms0ol
         awryBwst3l7E0spSmCWL2PLrIl9gytpXiIStFZzFGLo78NbmDpo11GX+lkzjthmiNmtn
         PJQ/XbvPt+mNnxLZoVx0x853A6XaHhXwUzKDWXRhB/v8PGJZpeiiujT3tojGz6ZZoRMl
         0Jzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733771896; x=1734376696;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HwwgXai+acc6VeZX0f/peyynjrwSCIW1sUjj9BmcTp4=;
        b=BGU9r5cJwEKcEla1mIu2S8If9Q97K0pUsBceEq0Mwp368LyJDSx7j3MQMTDpm5wwAT
         376yCVjS1hqCLqWf+jWJ0+OMwUBzqtQu2gFf91j917qKoYOt2mOUQfgRVhmmKx1k9Tqj
         8yao0AdyFxah7DXHVpGdc9TjE8XvoeTIz/4Tx1xbkIkB3bLe9Q2I64+6ihQwapfAOnSv
         XA2zd4DpO6dPBgj3AQnGMBIZqQmUBAUZG+oJOBn8r7abEgLJOiNfY/SS5LbDHSjy3Kwq
         VrBKJQiM2H/IZ5Ed5ZI0xuoGzOo+MPGQz7WuLrC5FNqQQLMBSGtLt+AWRYqUVoutY2+O
         0EeA==
X-Gm-Message-State: AOJu0YyCzm8DP1FdN8IZ4NLIEuS3/xQRFmgBOLqnOVTa91Bzuo57PSoM
	5o+sGYJEMd6hKGqVIABd07dvjCOvRs/OkPeGBFjkqJv4a8xibUQhNX4I6g==
X-Gm-Gg: ASbGncv+RhZ7fmYkmgT97sxpqpF7kPY/bAqkKanS9VqnMxuudOoNERTHwC7Sva81Ijm
	E7F0mwM4MQOZDO+HMG91QciqZkFhJaQUweEzgOjPWRMqAlq0s5dNlaC6eqBUpTpIHH+3r8M1wZl
	PIVjNc71R0fSxD6X0RceUMDJavw1QGcgWSZjqHs1PTBEz0r59WwvKMvwrjAwPMh5dFZbKrTcm1A
	bdqscqRpffC/mSXsCpacMXGASWhEvHXbaDzJrYxbteWrqJ6769CrOQ=
X-Google-Smtp-Source: AGHT+IEKSC6ilNwUwz19NCqew/nrkxs+I7eGpZdxKAdeXF5BHAZESLjpijcb8rqoafio2bWWvYz/6A==
X-Received: by 2002:a17:907:7708:b0:aa6:79fa:b475 with SMTP id a640c23a62f3a-aa69cd5b3e7mr164427766b.25.1733771895801;
        Mon, 09 Dec 2024 11:18:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa686bb8cb2sm201566366b.153.2024.12.09.11.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 11:18:15 -0800 (PST)
Message-Id: <pull.1834.git.1733771894867.gitgitgadget@gmail.com>
From: "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 09 Dec 2024 19:18:14 +0000
Subject: [PATCH] Document HOME environment variable
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
Cc: M Hickford <mirth.hickford@gmail.com>,
    Alejandro Barreto <alejandro.barreto@ni.com>

From: Alejandro Barreto <alejandro.barreto@ni.com>

Git documentation refers to $HOME and $XDG_CONFIG_HOME often, but does
not specify how or where these values come from on Windows where neither
is set by default. The new documentation reflects the behavior of
setup_windows_environment() in compat/mingw.c.

Signed-off-by: Alejandro Barreto <alejandro.barreto@ni.com>
Signed-off-by: M Hickford <mirth.hickford@gmail.com>
---
    Document how $HOME is set on Windows
    
    CC: Alejandro Barreto alejandro.barreto@ni.com, Johannes Schindelin
    johannes.schindelin@gmx.de
    
    Fixes https://github.com/git-for-windows/git/issues/5282

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1834%2Fhickford%2Fhome-docs-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1834/hickford/home-docs-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1834

 Documentation/git.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index d15a8697625..47509c9e1a3 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -477,6 +477,14 @@ their values the same way as Boolean valued configuration variables, e.g.
 
 Here are the variables:
 
+System
+~~~~~~~~~~~~~~~~~~
+`HOME`::
+	Specifies the path to the user's home directory. On Windows, if
+	unset, Git will set a process environment variable equal to:
+	`$HOMEDRIVE$HOMEPATH` if both `$HOMEDRIVE` and `$HOMEPATH` exist;
+	otherwise `$USERPROFILE` if `$USERPROFILE` exists.
+
 The Git Repository
 ~~~~~~~~~~~~~~~~~~
 These environment variables apply to 'all' core Git commands. Nb: it

base-commit: cc01bad4a9f566cf4453c7edd6b433851b0835e2
-- 
gitgitgadget
