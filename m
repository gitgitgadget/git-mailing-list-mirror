Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A789B67E7C
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 10:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707992984; cv=none; b=aDOfZZu38HJFKpbWdKteKp5n7BQL5U7XpnVolwV0OSgSpwAHZ5EXsvKLIUkNa2MafrHPpjCirYJyDvkMCZWir+EcKJCg9IXaVQ1W4vmegdus62n7LNQQy4KfbwU4edoM49MVcB0uY2PAeTQ6TXrHPXz5r1+PoIweD15ZDc0ODd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707992984; c=relaxed/simple;
	bh=0VzQh58mSJ6P9Z8CVAzroirwUkIQ/btmWlkawhaszRg=;
	h=Message-ID:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=JwePw+1yCEztJj8WUtzYkZAHtouvLQ9X0jMhFzvlMvs+WTAcDw1aaXyN3yPoz9isfsjvjbOJpXOg5NSbdmcIy29P+NkozJ0r8d4BV6JkHA5Nvyl7FxXFbgFLV6cMnj0cAiG+UMHRmC6wg0oJYYpmnmQyHZeLjz4WRsfko7fW1CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OzLOG2E5; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzLOG2E5"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-411e71d8a2bso5052015e9.1
        for <git@vger.kernel.org>; Thu, 15 Feb 2024 02:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707992980; x=1708597780; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EU9XDB7nWUzqXS1qvQ5GyD1k0yFzMKOLGoaZ9v5lxBw=;
        b=OzLOG2E5RPwV+62NmYlJ+7E5rsUdIoXp9BZz9CnneDBnPHzudtnfnMUPwzINxsUzms
         q/nOh8bYAqNH3Z+afQ4vFqG/dZ2kjEtVwOMKJj8VzhVKjFeJy3t3P3T+JDBxzO5cfrmb
         1GBW9dJ5/GPEbb8DwdqZnXNfSJMxYUwMPrgY1r7j4FcOLm/5XsNAmdJ8ktHVPFXPZI73
         TgR021fC5m2lMB8Y6RC1pS1GHENllL9ADcIh5sMFbPTpafYToDN04KDD1paWeUppVozq
         SXnH0jFAJDDxLummXISNrVX6KLmch+gsPWUt4s4QpfZefVfFtMrPsuQhpkrBVxXBtRi5
         GF5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707992980; x=1708597780;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EU9XDB7nWUzqXS1qvQ5GyD1k0yFzMKOLGoaZ9v5lxBw=;
        b=wrWJciJEOuGFHiZAqsS7Bjv161rzMI5x8FkPUBcPtiWKBhUlurBhoiXrMwG5O+6jbj
         1ABcaofvkvOL7Ci0fkaego7dpwXA6BaargzJJQ023CCxPJh6FN4UrN3s8sQS031GO48t
         eWlB7hUBm7hv2QYdwww+pFWJmUFDnHG68pE4b3WeIWN39nA15FOkTdd8yEelVgaNfmZl
         ORVgCsI9ovjerg+D9uMZNQ5W9odwlVdcj3sVkfxCbo5csKS35YndPAoCP5nU2u0AzC8Y
         yF0Ezaj75Cd/6VT5PofYVkYOrbct9CXCtAJ7GNwU0VjAlxyyBqLxeSSeJPQph5TGp4Kv
         uxeg==
X-Gm-Message-State: AOJu0YzUpvjz5cBbU1WSDdZSmcgCvtcxPgBPG8eSRSMt7c0LKlHSwdZX
	salztq0Kl1b+IqS8W8swZSjjI4TgzXiOO7p2vwI128sh8TwSW5y4kUrKtXKy
X-Google-Smtp-Source: AGHT+IG4ItAFS5IHOQrCpF58+1glMUXUkczUNax5KbzCts97sVgbS+78NGa+4TdE79JvCEvUwHwOdA==
X-Received: by 2002:a05:600c:46d0:b0:410:bb99:af83 with SMTP id q16-20020a05600c46d000b00410bb99af83mr908584wmo.23.1707992979925;
        Thu, 15 Feb 2024 02:29:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a8-20020a056000100800b0033cef5812f6sm1333296wrx.109.2024.02.15.02.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 02:29:39 -0800 (PST)
Message-ID: <pull.1667.git.git.1707992978.gitgitgadget@gmail.com>
From: "marzi via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 15 Feb 2024 10:29:31 +0000
Subject: [PATCH 0/7] fsmonitor: completing a stale patch that Implements fsmonitor for Linux
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
Cc: "Eric Sunshine [ ]" <sunshine@sunshineco.com>,
    "=?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason [ ]" <avarab@gmail.com>,
    "Glen Choo [ ]" <chooglen@google.com>,
    "Johannes Schindelin [ ]" <Johannes.Schindelin@gmx.de>,
    "Taylor Blau [ ]" <me@ttaylorr.com>,
    marzi <m.ispare63@gmail.com>

The goal in the original pull is to deliver fsmonitor for Linux that works
similar to fsmonitor for Windows and Mac OS.

The original stale patch : https://github.com/git/git/pull/1352

This patch set builds upon previous work for done for Windows and Mac OS to
implement a fsmonitor back-end for Linux based on the Linux inotify API.
inotify differs significantly from the equivalent Windows and Mac OS APIs in
that a watch must be registered for every directory of interest (rather than
a singular watch at the root of the directory tree) and special care must be
taken to handle directory renames correctly.

More information about inotify:
https://man7.org/linux/man-pages/man7/inotify.7.html

Eric DeCosta (6):
  fsmonitor: rebase with master
  fsmonitor: determine if filesystem is local or remote
  fsmonitor: implement filesystem change listener for Linux
  fsmonitor: enable fsmonitor for Linux
  fsmonitor: test updates
  fsmonitor: update doc for Linux

marzi.esipreh (1):
  fsmonitor: addressed comments for patch 1352

 Documentation/config/fsmonitor--daemon.txt |   4 +-
 Documentation/git-fsmonitor--daemon.txt    |  26 +-
 Makefile                                   |   4 +
 compat/fsmonitor/fsm-health-linux.c        |  24 +
 compat/fsmonitor/fsm-ipc-darwin.c          |  57 +-
 compat/fsmonitor/fsm-ipc-linux.c           |   1 +
 compat/fsmonitor/fsm-ipc-unix.c            |  55 ++
 compat/fsmonitor/fsm-listen-linux.c        | 678 +++++++++++++++++++++
 compat/fsmonitor/fsm-path-utils-linux.c    | 196 ++++++
 compat/fsmonitor/fsm-path-utils-linux.h    |  91 +++
 compat/fsmonitor/fsm-settings-darwin.c     |  64 +-
 compat/fsmonitor/fsm-settings-linux.c      |   1 +
 compat/fsmonitor/fsm-settings-unix.c       |  64 ++
 config.mak.uname                           |  11 +
 contrib/buildsystems/CMakeLists.txt        |  11 +-
 t/t7527-builtin-fsmonitor.sh               | 138 ++++-
 16 files changed, 1262 insertions(+), 163 deletions(-)
 create mode 100644 compat/fsmonitor/fsm-health-linux.c
 create mode 100644 compat/fsmonitor/fsm-ipc-linux.c
 create mode 100644 compat/fsmonitor/fsm-ipc-unix.c
 create mode 100644 compat/fsmonitor/fsm-listen-linux.c
 create mode 100644 compat/fsmonitor/fsm-path-utils-linux.c
 create mode 100644 compat/fsmonitor/fsm-path-utils-linux.h
 create mode 100644 compat/fsmonitor/fsm-settings-linux.c
 create mode 100644 compat/fsmonitor/fsm-settings-unix.c


base-commit: 4fc51f00ef18d2c0174ab2fd39d0ee473fd144bd
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1667%2Fmaryis%2Ffsmonitor_linux-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1667/maryis/fsmonitor_linux-v1
Pull-Request: https://github.com/git/git/pull/1667
-- 
gitgitgadget
