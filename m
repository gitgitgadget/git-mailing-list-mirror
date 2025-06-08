Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0875BA3D
	for <git@vger.kernel.org>; Sun,  8 Jun 2025 09:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749373792; cv=none; b=jkYNQNZumG3jjhcW9hCRQBlm1eyfIT5psdnQeqZC78zXAj4wjznWwhkW8ATl/xIW0UhIhwpl6xMkquCwM2saBZvmowq/s1O3g4Ahu97VNq4u/LxUSz7QIfjkolOlfiDp9ibZ1s4NF6PH/LXc0N4DQUIPsrkvpFnIuEHK9HunEz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749373792; c=relaxed/simple;
	bh=LsiC8n2c6P9gWAviSQMBk2FWXkAwHbQ3dEcMf8Wlrp4=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=EJBHZvcCuo9Lu3Lr8mPrv7lyeDlLvpob0k8iWBOpHoCxUvyW+z8O1fXuhfpgtB786E5qIgrBOCxhls4FY9vKXe9pGihCuhXJfURGNHwkolOW8wUKkCHsXJ0l/Y8BYlBwrnAFzX1BGzOpVfBTtO9STd+ikj/Ud/4CqECKsL0xBno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OF/K7voo; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OF/K7voo"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-450cfb6a794so22702535e9.1
        for <git@vger.kernel.org>; Sun, 08 Jun 2025 02:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749373788; x=1749978588; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yF5aQhUlUC5kuNVA8g+YM5JPTf447yLkebfIIUb3PJQ=;
        b=OF/K7voonZ6nJq3ZFRWow9wA3sEOoH6wBqc1te6tOc9f6TMHMlJp0e4GJxAa87beBY
         RSGUMbCa/Rb054MLmPReCnskyaahaGpfNqpvkF4jjNul5R3S1c8/jh6AsVYRpuiBT+sI
         /nj+W+vE4yzfvI3BYC4aSvdKlVDCMU2ja+ogelFBU1xm38gyoO4BJI1eQFGNomUj+F9m
         a0i5VR9V0AHX/QpivouWzhoN1Fj/RARAbwXdrTjXqKyJzOTMqrTnea7kcveBThBl3FsE
         fx1YP0PKpKQ5hKh4jj88jfkswUHyfGUc9BSIeJZqBnM1wbkKfONLWRsyRFjJIHfaFf3l
         jMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749373788; x=1749978588;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yF5aQhUlUC5kuNVA8g+YM5JPTf447yLkebfIIUb3PJQ=;
        b=urbEioj9j+FAd1oUrXXqh5fg9q4bCz1uHxQPaGL087n6xx6WAmEreslpUl2ydy1xX+
         cQllJQLE0v3zql6MJWK1OZB5/rSE10dle9wJWlneBYKNT5o2F/2yTJCiRF5IEunL86Uo
         /g1pzbP/mTU+zeVOO2a2nAlUDBMzE2rEN07Bb+3l641MdJ49AgVZiZOL0NituiBwFIWF
         +agJ/+k1GppNWFNrlno3qPENm/Hl6Hw6vPX0x/Llym8Bk/HvHR06q0q9yeWfrnz+S+mj
         jEkxAhwLRosJG4KB10ZrvyVU3OVcrpG0uTufEvZJ1l8xYL57vpkLgze7AQaLGdpHUDGk
         pXPQ==
X-Gm-Message-State: AOJu0Ywy+EEuEVJaLVr2JicYjE/nYPUE6GQ9gKOtVsyrHPlBodutewlu
	+oZ7dCQdtByVy4NWEmnedO9ugihnXvy/JjUkNMbIBZbR2NDxfnPXMddZODRjyg==
X-Gm-Gg: ASbGncu2clcZqKBSg30Y4sGCrIgcaZfysp88x21DcoGLU4tvhz/ajTfDEPz3A2vZyf3
	ra4bIK5aMDkA9Ot7MBDBfa0AMd+8Mlm+QNz+PjBX76XPU99f2wYu7xL3gRhWxKvYfggCQd4Vhsf
	2QPov6S/Q8YQ9tJQF7wvapQm7OuDqkWMF8iFE61p0Hvtys+iUjU8ojjlN6FmBc5USmlSXEDARYE
	3B/s/GQXbZrNIGbrJt2fpU+1n+oeaRH73nGKwXQJprf83cXRTlPScf3Hs6y4/p3eEKMHGZycZeX
	USRPxUQ4icSf6ikGMkKpImb5JluMvwxpW8isByrz6VY5qtIsOn1Y
X-Google-Smtp-Source: AGHT+IHwe0Wo5wDnPJgb6zq68tW8Pakrwhlx2QgZxrkPkoIvNQOkl/EevINnKZnmafDvdzGZE/jvIA==
X-Received: by 2002:a05:600c:1e8c:b0:450:d386:1afb with SMTP id 5b1f17b1804b1-45201350cc7mr93276955e9.9.1749373788340;
        Sun, 08 Jun 2025 02:09:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45209ce132csm79845015e9.12.2025.06.08.02.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 02:09:47 -0700 (PDT)
Message-Id: <pull.1933.git.1749373787.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 08 Jun 2025 09:09:37 +0000
Subject: [PATCH 0/9] Doc git log
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
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>

This series converts the man page of git log to the synopsis format style.
Git log is the second largest manpage after git config, which makes the
changes quite large.

A special note about the log format description which required escaping the
synopsis processing of parentheses.

Jean-Noël Avila (9):
  doc: convert git-log to new documentation format
  doc: git-log convert rev-list-description  to new doc format
  doc: git-log: convert line range options to new doc format
  doc: git-log: convert line range format to new doc format
  doc: git-log: convert rev list options to new doc format
  doc: git-log: convert pretty options to new doc format
  doc: git-log: convert pretty formats to new doc format
  doc: git-log: convert diff options to new doc format
  doc: git-log: convert log config to new doc format

 Documentation/asciidoc.conf.in             |   2 +-
 Documentation/asciidoctor-extensions.rb.in |   4 +-
 Documentation/config/log.adoc              |  45 +--
 Documentation/diff-options.adoc            |  40 ++-
 Documentation/git-log.adoc                 |  83 ++---
 Documentation/line-range-format.adoc       |  26 +-
 Documentation/line-range-options.adoc      |  10 +-
 Documentation/pretty-formats.adoc          | 283 +++++++--------
 Documentation/pretty-options.adoc          |  71 ++--
 Documentation/rev-list-description.adoc    |   6 +-
 Documentation/rev-list-options.adoc        | 390 ++++++++++-----------
 11 files changed, 490 insertions(+), 470 deletions(-)


base-commit: b32feae0f1b21faaf8e191e8d3314a32470a536b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1933%2Fjnavila%2Fdoc_git_log-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1933/jnavila/doc_git_log-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1933
-- 
gitgitgadget
