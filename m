Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5801DC745
	for <git@vger.kernel.org>; Sun, 30 Mar 2025 17:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743354973; cv=none; b=oBU5xD1YCzw3la8EE4zUX8xtpR+RpC/dZqneF8xzPakE/tgqbdC+M9ioH1dONmvAW+Ppx4YG032NBHFrz7OVV9+vCVNj7XS9CbzhEDVuzOYUYsteb30Owttyt6dWVLEKbOS8A2JKh86XE8gyWWZEWTV4LshROWQTVaOHJ4+CW9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743354973; c=relaxed/simple;
	bh=M9XsA+OSmsH4RsuXbNaJhjb92BbkVZfM2vzE7llGugg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=I/+MZm3WpRji8dtRVPSv6ndEWOGi7jztVgaV4n0JmiitlSDH6EIugBzAx+covzmxCtuvqzgUzvh8ypopv/a9Xilva9ymmSuo73vG/J0aIcD57yftAfU9jeA6rCTClNWTmaPwWcAtiYZvhpShcAeE3WEWQKe9Jdf/fpZs9iu9JL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Av3AnCRI; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Av3AnCRI"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43bb6b0b898so32924675e9.1
        for <git@vger.kernel.org>; Sun, 30 Mar 2025 10:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743354970; x=1743959770; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Sy4Ddd+FQkwANT/sTwpIZiUSSES38kAezkndsJMIcI=;
        b=Av3AnCRI4kh1kf5GSer7vU6XOQ9MdNcBAVF3NAt4jPSr4muB9jjrJaoJ8w4UepDBL0
         aQeU21c3Tg5TQBEdtRTvs40FkGPbNQXW+vEgXDzjCQP1lL/MRvuQtdu6vwtXdlGNONWP
         8wKDTc3vKQ1anWGeteYKJYCJIp+0zcbpPxCwtjBw6gVD1wbVHoyxgDbNtMd7Mfw1fmDx
         LEcvGrMjKDzTufysyRUe4sc7qHZxtrfvNkhut9DIgyPuVifmXxCwbf6+l0Z1onnnhG7B
         xG2JSsV6wkDGdp1Gmv7lWyuWY5vU+xkiMhUA9AsGwMNSM2OFZDf0HZBxtXdOtG5m09ni
         tegg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743354970; x=1743959770;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Sy4Ddd+FQkwANT/sTwpIZiUSSES38kAezkndsJMIcI=;
        b=lf7CO84Xxj88MQtUy6YY/XfH17I+y23yVtQJmWqkR20DmBbcQhNFdjuugU6/ebPB3Y
         KMGw07VSGQxnVPDIMb73wsF3mrw9m2BkoN/I30SuIED8mE8JRH7MlIbzX/a3zbj7wDQ0
         Gj09fTXiYNfwqLuyGWgILKz7PpoyVotPYVUSZv9cojUYS6X3eIT3EQsWnAcoow56W8wz
         +FFgq6czoRl7YC/0OuxdreOlW9QZtfYjoVxJE1f205CAzTqJ3yKWcBm9E/X3CWCNX1fF
         rgz9GbJZck+IemdTm9N4M/ktaxyEnhxHKp3BO3n+ANhqHZFF9zcpnmN0qUbyGAPgVsVQ
         UTXA==
X-Gm-Message-State: AOJu0Yzk3h7IDxn7sEn8FyZ0phmDYkj+zqPLQV6kSTKQGIa7ripqo3C3
	UK3Gqo0niRBDz4FCIoGClhnFkDWGiQ5PwqKgyECPdw4MDMUMDFpNdDQcrw==
X-Gm-Gg: ASbGncuDdCwsLmkRAI7S1sxf1+GcQLtRbdH6Mi6nmQd6tj3ffsAHBUTPMx0uvC87wUI
	g7mOtCJzMoJRgiwAgtLmKfvCIhv7DDCBrvvrH5L60/AmGAXFKUv7b/olu5mp2UZq/v9gNhXUZOO
	ZqRf2JMgpfC65B4Z/acGZ9ZZKjwA918/QTOUaKdi3KVzNIOEvbl9xKBLROjt8It1Xj6UIkV1mYA
	7xUtMtVG+hxBTZoBY/2bXdrlifSsK9GKq5roPsWfb15OZD7SzD/wb2GSOI2vSwAviB7n1SdTc/w
	YED8B8RlhchgTObRGQ7TxnEiDeKsMLopTD9AQSqI77z3SzyIcWg/1KId
X-Google-Smtp-Source: AGHT+IF7ILqzs536gQ5VaMxNqwsX9f/PwVNjDrgViMdsEpVTIkzWgWDGkmlAAxRCkmLptpI6bgzX0w==
X-Received: by 2002:a05:600c:1e16:b0:43d:40b0:5b with SMTP id 5b1f17b1804b1-43dbc6f9cafmr53125255e9.25.1743354970002;
        Sun, 30 Mar 2025 10:16:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d90001413sm97160165e9.39.2025.03.30.10.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Mar 2025 10:16:09 -0700 (PDT)
Message-Id: <9f7cd02cc1ef76bfe92cbb8152f34460c67b2eda.1743354964.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1896.git.1743354964.gitgitgadget@gmail.com>
References: <pull.1896.git.1743354964.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 30 Mar 2025 17:16:03 +0000
Subject: [PATCH 4/5] doc: move synopsis git-mv commands in the synopsis
 section
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

This also entails changing the help output for the command to match the new
synopsis.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/git-mv.adoc | 6 ++----
 builtin/mv.c              | 3 ++-
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-mv.adoc b/Documentation/git-mv.adoc
index dc1bf615341..08d660643fc 100644
--- a/Documentation/git-mv.adoc
+++ b/Documentation/git-mv.adoc
@@ -9,15 +9,13 @@ git-mv - Move or rename a file, a directory, or a symlink
 SYNOPSIS
 --------
 [verse]
-'git mv' [<options>] <source>... <destination>
+'git mv' [-v] [-f] [-n] [-k] <source> <destination>
+'git mv' [-v] [-f] [-n] [-k] <source> ... <destination-directory>
 
 DESCRIPTION
 -----------
 Move or rename a file, directory, or symlink.
 
- git mv [-v] [-f] [-n] [-k] <source> <destination>
- git mv [-v] [-f] [-n] [-k] <source> ... <destination-directory>
-
 In the first form, it renames <source>, which must exist and be either
 a file, symlink or directory, to <destination>.
 In the second form, the last argument has to be an existing
diff --git a/builtin/mv.c b/builtin/mv.c
index 55a7d471dca..9e36b616ab6 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -28,7 +28,8 @@
 #include "entry.h"
 
 static const char * const builtin_mv_usage[] = {
-	N_("git mv [<options>] <source>... <destination>"),
+	N_("git mv [-v] [-f] [-n] [-k] <source> <destination>"),
+	N_("git mv [-v] [-f] [-n] [-k] <source> ... <destination-directory>"),
 	NULL
 };
 
-- 
gitgitgadget

