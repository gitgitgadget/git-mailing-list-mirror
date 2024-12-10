Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC1F2046AF
	for <git@vger.kernel.org>; Tue, 10 Dec 2024 18:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733856341; cv=none; b=X/QuavvqaBruhiJJTmskL2CGEMCCP18i+LceEU4aniBhXviA+vAEM5/j7fwzwUrNQK2Nya/2vGFJxKm0gs7DUpzeqovq5JE5cKhCL/8GfMdGFdo79yYIGo/oMZLlp/hQl5xQjub+gXVxxzrbtBU368z05zH5uLpno3wfdqhwIp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733856341; c=relaxed/simple;
	bh=8T2UCdjSXSwqFmhj4MAHT9nZHFKA156xwfqP/euEr6A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IxjP2rcetbWDxjBegeT5nHOAfhKd83lcIPiKl59k974DMYwVlarbOy4lozAxJKUdiEhuelxUzAIufreVa10L19txH4ERd7dd8/6xVjDzRbbWUIyYctLAahx4Ud7WLaKwTIqh1PMM+DoHsbUxd2b1fzsvNX4OysKbg3YjLBIYGZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fA+i7tYZ; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fA+i7tYZ"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d3da226a2aso359844a12.0
        for <git@vger.kernel.org>; Tue, 10 Dec 2024 10:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733856338; x=1734461138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lUJYImH9KbEfelezgsKyr0GU7/pksSBxA3JcvekS0NA=;
        b=fA+i7tYZRUPoEX8ZyPM8HU6ecbFZclZ8+pCkKi6HgNZvjWyzOAj8X24pQe+gNiIGYO
         xobNpV/SUhEqrOpmEQ6nSNzhpjE+UP+yjP92nYrXBTbxuRxnfZ8s6wk5uRBRZ8ilnFNz
         3ejYewVfYKiDWX71Na/5+6s2p56Xpq0tlMwWFaeh0qC7HPJKR5tn8hB/Rp5r/+MQUwdi
         ijn3ZkbnTT0tgl3e9MhAG5sNBGHJz76sf8yBfkvsJu6tnmWMA8p8CecCRT8dCW2efjc9
         ncQdqI6k4nUKFLd22kAcmsq3ftNyEwXE0Rwt/cMD3tK5CBygznRxfEfqIwcm0WmvwLLQ
         HiAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733856338; x=1734461138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lUJYImH9KbEfelezgsKyr0GU7/pksSBxA3JcvekS0NA=;
        b=RwXZAeDzfxGlbJ+EtrpUpHT04xkt9kq22uyqyymHeBc1xjXxp4K5LkXrOR+Ne0Wlia
         CD+QR8Y6vkxI7rMsxpesiW35WvePASC9rlnxe05nn1r7cYN+dtKy6letrrCU+8X0uIE/
         TfRgFMzoibLXvHUhYDX4T+k66Jib5aYBPjh6f54fKfGCe0u4oPfhoPw7EY+z/XQkrl8j
         MIrYl9DJHSL4xrKxZqS1DN42eJXycy01ohH/77WXzhJQDQpc7+LBMajOxI5XhUjpBHDg
         vR1Fi8sLTj8OxoiEEKIBXod7xelx2EMPd2BHaAJ91yyNmi0Ift3+aRjwwETDt8cSeY+u
         XLAA==
X-Gm-Message-State: AOJu0YzS5HYbQInb3JSPURfCnolnuLSGi3s1IOO9oL3xuqDlxPaNVSLv
	0DYGJv9vVNZihC0gy9X5wW55GQvcOmE7pBGoD4l0D1naKW7XwQlLV0SQWS7F
X-Gm-Gg: ASbGncsbBIleSTG8S8cY5q7NqlKThQJdYGNQTQUAPcCZ4heeM8fLhaWRozoHoc+Dkxz
	pd301YSvRH7fkcpxhtUlNO5bCbhw4k5VFfXpMCrUwAObILlp8bTNhgH+JKjaRJKepdMQTs69+49
	Js43TjwOJXWjD4iXMbCYQaAcxTd0CggKfeMX4UAcCodeIOD8Vuj4jm+gpqmP7uKMws+KixPXW08
	ZuL+KZJSTGQdUFRMiy22Zwwf9VKOCVN4qqykG8o3d7AkuUYgO4a+RLX+t2orL0=
X-Google-Smtp-Source: AGHT+IH230h6VffoYY4bYjosjEAaS2cjScWPr4MS2FbnX8D+pqiOOqtIo0SdeZzunvTyJYQjrCZYlQ==
X-Received: by 2002:a05:6402:234a:b0:5d3:e843:fcfd with SMTP id 4fb4d7f45d1cf-5d41c66b00dmr1659679a12.11.1733856337617;
        Tue, 10 Dec 2024 10:45:37 -0800 (PST)
Received: from localhost.localdomain ([5.29.161.23])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d149a48882sm7895896a12.24.2024.12.10.10.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 10:45:36 -0800 (PST)
From: Roy Eldar <royeldar0@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Roy Eldar <royeldar0@gmail.com>
Subject: [PATCH v3 2/7] git-submodule.sh: improve parsing of short options
Date: Tue, 10 Dec 2024 20:44:37 +0200
Message-Id: <20241210184442.10723-3-royeldar0@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241210184442.10723-1-royeldar0@gmail.com>
References: <20241209165009.40653-1-royeldar0@gmail.com>
 <20241210184442.10723-1-royeldar0@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some command-line options have a short form which takes an argument; for
example, "--jobs" has the form "-j", and it takes a numerical argument.

When parsing short options, support the case where there is no space
between the flag and the option argument, in order to improve
consistency with the rest of the builtin git commands.

Signed-off-by: Roy Eldar <royeldar0@gmail.com>
---
 git-submodule.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/git-submodule.sh b/git-submodule.sh
index d3e3669fde..fd54cb8fa6 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -77,6 +77,9 @@ cmd_add()
 			branch=$2
 			shift
 			;;
+		-b*)
+			branch="${1#-b}"
+			;;
 		--branch=*)
 			branch="${1#--branch=}"
 			;;
@@ -352,6 +355,9 @@ cmd_update()
 			jobs="--jobs=$2"
 			shift
 			;;
+		-j*)
+			jobs="--jobs=${1#-j}"
+			;;
 		--jobs=*)
 			jobs=$1
 			;;
@@ -431,6 +437,9 @@ cmd_set_branch() {
 			branch=$2
 			shift
 			;;
+		-b*)
+			branch="${1#-b}"
+			;;
 		--branch=*)
 			branch="${1#--branch=}"
 			;;
@@ -519,6 +528,10 @@ cmd_summary() {
 			isnumber "$summary_limit" || usage
 			shift
 			;;
+		-n*)
+			summary_limit="${1#-n}"
+			isnumber "$summary_limit" || usage
+			;;
 		--summary-limit=*)
 			summary_limit="${1#--summary-limit=}"
 			isnumber "$summary_limit" || usage
-- 
2.30.2

