Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95765D27E
	for <git@vger.kernel.org>; Fri, 28 Jun 2024 19:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719601534; cv=none; b=pffue+LsX+KqJFcKiJQQ7EsoWGhaAKzzWPU8SG39BqLlPnAgnSzKUMh/P0hUhgGqRrkx1dmiyBAk4eOsXLidmuJQgPPr1ckP3HUFtfPwsuwssdmKwhUAfgpGeSH8OP2OetUt+G5dpS+wGLl+lH9sIyxBtCh53iknqCSE9zhbw2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719601534; c=relaxed/simple;
	bh=rzfP/Czjwt/7YhbYUbMt0ubOkhdeQzItzm7NwYNfubU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c249eOqo19DfSaaR6lsz6+TPZ8vFXna2E7DPwCeqNhgFgR8LaPbEZ4Q7XG9MOxBYdQ9GGTbFMwLR/Tpxs+VV3yZihe9O0+qdABHw3kwZOmV1EOMwZ/zS1NLllOZuBnSFm6/4Zy6hUbvquUFjrjx6mYFZU9HbCI4UBv/olKogdEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bxedCjre; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxedCjre"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6b598cd61ebso4878046d6.3
        for <git@vger.kernel.org>; Fri, 28 Jun 2024 12:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719601530; x=1720206330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WwI8lyUD1zVnExQAj8PengiUK+OgPwo5K1ir5TrG8Rs=;
        b=bxedCjret2bqW4O+WmaEcy/lgunMLsR0WtykdEeJFhzInaPBDFa0xcpudL7eal0YQJ
         pHmlmcJeZu4U/WnuvBRqwsWpodC4yylMNzAIH8qfdfI+VoojaD3g3RQlKl2eku58xNun
         e0o6p6KG8PEvIowrH/e/pbkUJqI+02nS94obsRyehB2EhdX79IKJgGRqVnZtORShpzUN
         OU7qv1JeTnmYNAVD7QoRcU5Me+2gSLUCaxVQN+oWLaF0W5Er+wCSBP4ohgj6G9a1AMZZ
         U1q8l4pw+H/18yoeFtYl/w/50TzQ73+yYUEwbDtli+hnXLrvrjj/Kv/UneCk6/aCj6Cl
         7r1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719601530; x=1720206330;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WwI8lyUD1zVnExQAj8PengiUK+OgPwo5K1ir5TrG8Rs=;
        b=p3B6a7/ABKuaKGaefQtqRM7CjDBc+oaChDSjlH5Bem+7nsjkrdUh5z5sIPXk0Xfg4w
         bqB2SuTPhM1Hq7HH4s7ECNiO/NPjMOiJ8Yli4aMGP+8fArbVbadXy/OAQVqUOKlpquD4
         Mck2bE5o3XytWZCzyqWC6o7EzAsV7ZqHu7CJ2o95U9r30XaTYL3HE+VJ+yX4hyD7iA6l
         mpVmwNmmc13Uv/sRndC0BqC89EHg/P9eOXz/PM7QPOGCGVf8JO2ApyCmvDy+pBag8ofc
         A8OxPzl6YWl3tYnRTi7bqcpYQM9SfeinsP7l6XS4zTvm48bAyRze4Tuq9dKJdVNgC59u
         H6dw==
X-Gm-Message-State: AOJu0Yxu98i9qX190rMm1L/fmNUTPiYMrGLfzxIiJxb6ipKscoprzXlg
	9c4eGSpv7xLBPcR9VGRaT/Gez+wUvgDEVThWUoYxGUOOLiQ5ijj5Mgu0DXau
X-Google-Smtp-Source: AGHT+IE+M8AqYhCgsrNri+P6vgnrQeJR3XQg1gIs55szHwO3f5EptnuYkQQWJSiTJ+wNV1Y1XBrrww==
X-Received: by 2002:a05:6214:d6b:b0:6b5:9fab:3b83 with SMTP id 6a1803df08f44-6b59fab449fmr44916716d6.45.1719601530105;
        Fri, 28 Jun 2024 12:05:30 -0700 (PDT)
Received: from localhost.localdomain ([76.71.94.205])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e574cc4sm10262346d6.53.2024.06.28.12.05.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 28 Jun 2024 12:05:29 -0700 (PDT)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Calvin Wan <calvinwan@google.com>,
	Jonathan Tan <jonathantanmy@google.com>,
	John Cai <johncai86@gmail.com>,
	Eric Ju <eric.peijian@gmail.com>
Subject: [PATCH 0/6] cat-file: add remote-object-info to batch-command 
Date: Fri, 28 Jun 2024 15:04:57 -0400
Message-ID: <20240628190503.67389-1-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is a continuation of Calvin Wan's (calvinwan@google.com)
patch series [PATCH v5 0/6] cat-file: add --batch-command remote-object-info command at [1].

Sometimes it is useful to get information about an object without having to download
it completely. The server logic for retrieving size has already been implemented and merged in
"a2ba162cda (object-info: support for retrieving object info, 2021-04-20)"[2].
This patch series implement the client option for it.

This patch series add the `remote-object-info` command to `cat-file --batch-command`. This command
allows the client to make an object-info command request to a server
that supports protocol v2. If the server is v2, but does not have
object-info capability, the entire object is fetched and the
relevant object info is returned.

A few questions open for discussions please:

1. In the current implementation, if a user puts `remote-object-info` in protocol v1,
   `cat-file --batch-command` will die. Which way do we prefer? "error and exit (i.e. die)"
   or "warn and wait for new command".

2. Right now, only the size is supported. If the batch command format
   contains objectsize:disk or deltabase, it will die. The question
   is about objecttype. In the current implementation, it will die too.
   But dying on objecttype breaks the default format. We have changed the
   default format to %(objectname) %(objectsize) when remote-object-info is used.
   Any suggestions on this approach?


[1] https://lore.kernel.org/git/20220728230210.2952731-1-calvinwan@google.com/#t
[2] https://git.kernel.org/pub/scm/git/git.git/commit/?id=a2ba162cda2acc171c3e36acbbc854792b093cb7


Calvin Wan (5):
  fetch-pack: refactor packet writing
  fetch-pack: move fetch initialization
  serve: advertise object-info feature
  transport: add client support for object-info
  cat-file: add remote-object-info to batch-command

Eric Ju (1):
  cat-file: add declaration of variable i inside its for loop

 Documentation/git-cat-file.txt         |  22 +-
 builtin/cat-file.c                     | 240 ++++++++++----
 fetch-pack.c                           |  48 ++-
 fetch-pack.h                           |  10 +
 object-file.c                          |  11 +
 object-store-ll.h                      |   3 +
 serve.c                                |   4 +-
 t/t1017-cat-file-remote-object-info.sh | 412 +++++++++++++++++++++++++
 transport-helper.c                     |   8 +-
 transport.c                            | 102 +++++-
 transport.h                            |  11 +
 11 files changed, 785 insertions(+), 86 deletions(-)
 create mode 100755 t/t1017-cat-file-remote-object-info.sh

-- 
2.45.2

