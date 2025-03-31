Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1074D13AA3E
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 03:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743390803; cv=none; b=ILgtBoG1pRZprLxqCoOg/nGmNGexGaP7Nfea8Tp5oE76o8wKJH7leNJEncIxXA+eXEHrH4bMYcVy3ibDUVVUCm7yH77C1yLrn226THOO7hwYOG7Gkcdxk4PO5l1lu3QNB8d3uSS4nkt3l/9ptfLa39MXtODnAh+DpcJYXkIEAUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743390803; c=relaxed/simple;
	bh=QDpLxaTvHfi7iVsjzi3xOdQQbsAhCIAUP6B0cNpyfgA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gLQN0Ck9z/KqKg9EeC8/Y3GEiSLTAHpVEO1p4x7E2lZckTSXfzu3ZoUM5rrk3lT1w/56vLaFuUb1pYgxTKhQ28Z90CkT6DIV0Y10i8UmBn87WNkxhvZs+KuTQ6K7iC0NXRLiVg3cXdy6O9R06C3/e83WrA4xkBofIrIjcxqfDf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZTGq734; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZTGq734"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-301cda78d48so7139331a91.0
        for <git@vger.kernel.org>; Sun, 30 Mar 2025 20:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743390800; x=1743995600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GnEpP+hX85Ml+ZNgJkHhUbtBhk94B5HKbXgG6p4ibuo=;
        b=QZTGq734i9ZocV5NwBccFPlCkmEdMOFN33PwqUK+sy2fx4Cn1cW5akRijPhVm3Os6l
         uPRMLxj0p9MFB6+MhidXVpqzh1TAzOubpZHZ/ayf8G0BTIAYuyr+A/MSa2KFLSnD7QqL
         LGUoAIfvdrp01PUKJBT0gcPrrXK3+L4tomlpj4PPAitL7uzAUd0tl0tq/5PoDRT5Z687
         Ys9jQdcTqPsz1sz+NfuJa/87I6biaawmJEuWWFZtKGgvEWzOI/yOnFGl7cS1goVHKeFm
         fFWehSL8jVc7WevtJQV/iJRmn7Xy2ZzEAYCuUs94G7Zo9Rkw7cvR8/B+3al2kKL67hxz
         qGNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743390800; x=1743995600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GnEpP+hX85Ml+ZNgJkHhUbtBhk94B5HKbXgG6p4ibuo=;
        b=M7aUxv1O4FoTwz93O80bu6parVNMgd4Q/JzU0os36aUKvgLU7bocp9+vSecOoVluRr
         +QhfrU0QHTxN2GqJOl4FBDI7AP2nkm8G3y0tbI/zSokcgVNvo+TPr/zhEBgtESa/t7wm
         oUpnrSdqCUy3E21c4TdgqK9Y9rWP3N3FfeW3g8HNMSd7IId4dbLIl+ZUhI2+F/FBU0B9
         FdDRONfQ7wK2R7zMta48TFiI7B/58XAKMDV0b0iKtwwaHPtQY14ZXr0qiEYjOGuH9pGt
         Yp+bZvgmXOw8qyGkE4i3M10O9HwNY/OSwldJlOTil7cMyZuJcqWypdkCKrGDQye36kHh
         qLvA==
X-Gm-Message-State: AOJu0YzE0doQILJsxs5kvBTiU0AS9VgC5f3iup5znW6pN9Lt4zdb9BXW
	XbW7GwH8KZNpucdOi7Dl6V4FssrJwQ/IdAK/gsot2BxtgcSCnzMV8Hlg9w==
X-Gm-Gg: ASbGncuAusFvovWOEsG3ROdFVs5OmkndvnVQZGmaR4xKLdcLEjXveN3Zv59bxs+Qjm/
	OxbLPzHX+aT8UUqDO6vvRjLRhHlPLvs3nwlLuppUPMz7hqurtJh9h+D8mZ9OZOXdU0HShEDGU2W
	QGWr4Q3KGFMJqHOYGyifLykFzjZk56eWRfmthSJpHXFFUWD75Su237bk15iPazoJbLkmLGDKjOE
	dUCkWmf7JHwjILgzHFLnmjZBlq5caEXYGpj1PywqpIkILN8Wdgtj/guaYTNhEsj4evAaVIAUCyB
	gbN8PLZs7iW6uydaNpd0gA/Plr8xp5xwkYu6wxvEMT6P84aLFga7vdGgDe5SSZr/XabIjctqjFc
	+RClW2cIQ
X-Google-Smtp-Source: AGHT+IGtjJmE2EVpjQHu/Q+l/gxsBK8HC/L99bC2raKVZ5Y4sVBooPWsrhDbvhuWZYFD/0KV7PzqZw==
X-Received: by 2002:a17:90b:4a51:b0:2ef:2f49:7d7f with SMTP id 98e67ed59e1d1-305320af3c7mr13228517a91.18.1743390800240;
        Sun, 30 Mar 2025 20:13:20 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:32:980d:9445:ea6b:85ec:e259])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3039dfd37e5sm8491273a91.2.2025.03.30.20.13.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 30 Mar 2025 20:13:19 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	"D . Ben Knoble" <ben.knoble@gmail.com>
Subject: [GSoC PATCH v3] userdiff: add builtin driver for INI files
Date: Mon, 31 Mar 2025 00:13:09 -0300
Message-Id: <20250331031309.94682-1-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new builtin driver for generic INI files (e. g. the gitconfig
files), where:

- the funcname regular expression matches section names, i. e. any
  string between brackets at the beginning of the line, with or without
  indentation;

- word_regex matches any word with one or more non-whitespace
  characters without checking if it is a valid variable name or value.

Also add tests for the new userdiff driver. These files define sections
and subsections, with and without indentation.

Helped-by: Patrick Steinhardt <ps@pks.im>
Helped-by: D. Ben Knoble <ben.knoble@gmail.com>
Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---

The previous versions were more focused on the gitconfig format. This
patch generalizes for other INI files, such as the systemd .service files or
the Desktop.ini files on Windows.


 t/t4018/ini-section             |  5 +++++
 t/t4018/ini-section-noindent    |  5 +++++
 t/t4018/ini-section-same-line   |  4 ++++
 t/t4018/ini-subsection          | 12 ++++++++++++
 t/t4018/ini-subsection-noindent | 12 ++++++++++++
 userdiff.c                      |  4 ++++
 6 files changed, 42 insertions(+)
 create mode 100644 t/t4018/ini-section
 create mode 100644 t/t4018/ini-section-noindent
 create mode 100644 t/t4018/ini-section-same-line
 create mode 100644 t/t4018/ini-subsection
 create mode 100644 t/t4018/ini-subsection-noindent

diff --git a/t/t4018/ini-section b/t/t4018/ini-section
new file mode 100644
index 0000000000..c895ad9b4f
--- /dev/null
+++ b/t/t4018/ini-section
@@ -0,0 +1,5 @@
+[RIGHT]
+        # comment
+        ; comment
+        name = value
+        ChangeMe
diff --git a/t/t4018/ini-section-noindent b/t/t4018/ini-section-noindent
new file mode 100644
index 0000000000..733d23c801
--- /dev/null
+++ b/t/t4018/ini-section-noindent
@@ -0,0 +1,5 @@
+[RIGHT]
+# comment
+; comment
+name = value
+ChangeMe
diff --git a/t/t4018/ini-section-same-line b/t/t4018/ini-section-same-line
new file mode 100644
index 0000000000..522a1fa4a1
--- /dev/null
+++ b/t/t4018/ini-section-same-line
@@ -0,0 +1,4 @@
+[RIGHT] name = value
+        # comment
+        ; comment
+        ChangeMe
diff --git a/t/t4018/ini-subsection b/t/t4018/ini-subsection
new file mode 100644
index 0000000000..3d47349e60
--- /dev/null
+++ b/t/t4018/ini-subsection
@@ -0,0 +1,12 @@
+[LEFT]
+
+      [LEFT "CENTER"]
+      # comment
+      ; comment
+      name = value
+
+      [LEFT "RIGHT"]
+      # comment
+      ; comment
+      name = value
+      ChangeMe
diff --git a/t/t4018/ini-subsection-noindent b/t/t4018/ini-subsection-noindent
new file mode 100644
index 0000000000..698ea00ea3
--- /dev/null
+++ b/t/t4018/ini-subsection-noindent
@@ -0,0 +1,12 @@
+[LEFT]
+
+[LEFT "CENTER"]
+# comment
+; comment
+name = value
+
+[LEFT "RIGHT"]
+# comment
+; comment
+name = value
+ChangeMe
diff --git a/userdiff.c b/userdiff.c
index 340c4eb4f7..da75625020 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -211,6 +211,10 @@ PATTERNS("html",
 	 "^[ \t]*(<[Hh][1-6]([ \t].*)?>.*)$",
 	 /* -- */
 	 "[^<>= \t]+"),
+PATTERNS("ini",
+	 "^[ \t]*\\[[^]]+\\]",
+	 /* -- */
+	 "[^ \t]+"),
 PATTERNS("java",
 	 "!^[ \t]*(catch|do|for|if|instanceof|new|return|switch|throw|while)\n"
 	 /* Class, enum, interface, and record declarations */
-- 
2.39.5 (Apple Git-154)

