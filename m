Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B892571CE
	for <git@vger.kernel.org>; Mon, 21 Apr 2025 05:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745214541; cv=none; b=XwfFakTEs6RNJe8tqtDOiJi5e6Dzsu6GgqhOi8RHYFY5jW44g+3VKBcwDPCjYBp6vFybW2B8cmL6bs8AoKWHf+x19EzV1ajwpYvElT8n7S7gQNxefAHqvt1qMnAHfk5MNkE3iZbl1aqONH3AJK9gtVjyHMa6WvlLKwFIsErUOIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745214541; c=relaxed/simple;
	bh=XHxGwlAoHZ9IDn7jMCj9mZk5gMBH27diln605HuXKB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SJxxWcOn6LlNujEGeBLIDxQ3Jtk70QPjW6MyucCHQpxCdJogyAwMjxNYxpXBCsY7MyLzor6NPhLykz+Do3CsvXko/3B7zgPznUGTGDn0kV8RqlnZgVxhalkf2l0qhDWmZxg5W6BAG4kmrYR4WdQfbndeHtE/QtDA4AjysVbZDs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OTZe5qYk; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTZe5qYk"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-227e29b6c55so7109295ad.1
        for <git@vger.kernel.org>; Sun, 20 Apr 2025 22:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745214539; x=1745819339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b3n8E/9XA2uRzaLnld/p1Fdj+k3yHvpGq6BKo7jUDsM=;
        b=OTZe5qYk3deuvgJ9A8cLVRAMNqF1LOpUL0DHhffO+FkpIaGy6CHaBD/UKx9TW56Kxt
         iLkaU5XcIFTZLJfkiQO/O8FG1/BICEF2AcwuKhRujU5PbDFv9E2Lo6KKWyr0hQIKFCkJ
         t3xWqGqUMcggH837IKYlJXLOPGYSviqvkiBnIuGyScub7TLh7QXI7uUGpWsSgmVorzey
         97Qwb9J3DfcogfyHh+PzC3HpqtaaPpL6F0c/WaAXEAabugsuBcq1AP/pxg+mQo+vfRYx
         dLkC2zjz6DsCT8omXGyxc3Nq7h7ctTFdv3t1n6Ug4Za87mwQwqUg3hpwsrf6wa88ZhkJ
         XnTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745214539; x=1745819339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b3n8E/9XA2uRzaLnld/p1Fdj+k3yHvpGq6BKo7jUDsM=;
        b=E6DJRmXHEajIRflIWFGt0A0PgHP13jWnPI+YM2pxKDBU3YlKPNn7NJ+B9/2qk2zDtP
         odT3vvd3oEQ48pJ7VjX2ie1pIoqfYbFVBlKXudStpwcjKZyELQxp3e2DA4sQH0sxlB0h
         3OJ/U3UIkL7YEPAlfbWu0oIZRLJSvNC+LSaFh/yAev/ajYDEuXad8RI6a81aXTFFgSxm
         IjsBa/I8HnmPZcZdelsuok7gXqJyJoXU9TMkt8my1yfkfGmHCuV8TgB72rKjfwUCHOqh
         MfDJvBy5uTZxt5H7sxJL/arK7Q97z5ZspV+0LZfQpSAfKqpvGr2JDsWTdbqsjyJcfzsz
         XG/w==
X-Gm-Message-State: AOJu0YwDDu309XUA3SPdUVs5bX/ShlgG8jYc3NcyHTTYB2lKxHHl7p5y
	FciC84xNnEAnQQZWI+tGQxJRYaBAd/Qmi+tpxX+MMq+9k+dqa4SNtpDjtILK
X-Gm-Gg: ASbGncueFlsKp8pkz0rk9ZVG7wlQyIFrgjDiPpK2XvdGA4qmilKXB/5uqdwfCCqd3AY
	dVqiHZHs64O+5sRaPQg0ZHYob84Xiv3GLSyDmjZ03lMUYMdPXwJGoXwpTX/5wSPo6Ru+EXkQtHl
	ljIjN0Xgt+7jarlJpMdYlULDYaEMzHSmpYxAqrHkYB4b9NKH6bxvKo9XVEyxlpSLg0Up3rWZdga
	kdwiBEs5Peqxz7vCIPFyW5vr5OJyDGgHzu9ciLKgH2cZgksPDamdXPS2qYWst9ahiT0RyIb81V4
	Di49O95HiTLvOT/SgPM5XJ03Zv8NF/7LdltbV3MtAlQOEXQq7LBgCTUVFw3M
X-Google-Smtp-Source: AGHT+IE8ArMsmwJcvMDioq1BksL/DF5mWK+zyS2Ret0e3PvfVt1v7DQVZ1hnc45XRT+1Hz0VvoSRSg==
X-Received: by 2002:a17:902:cece:b0:216:30f9:93c5 with SMTP id d9443c01a7336-22c53581901mr57262655ad.6.1745214538788;
        Sun, 20 Apr 2025 22:48:58 -0700 (PDT)
Received: from localhost.localdomain ([185.153.179.23])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3087dee8811sm5682010a91.5.2025.04.20.22.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 22:48:58 -0700 (PDT)
From: Josh Heinrichs <joshiheinrichs@gmail.com>
To: git@vger.kernel.org
Cc: Josh Heinrichs <joshiheinrichs@gmail.com>
Subject: [PATCH 1/1] maintenance: fix launchctl calendar intervals
Date: Sun, 20 Apr 2025 23:46:33 -0600
Message-ID: <20250421054633.231069-2-joshiheinrichs@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250421054633.231069-1-joshiheinrichs@gmail.com>
References: <20250421054633.231069-1-joshiheinrichs@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using the launchctl scheduler, the weekly job runs daily, and the
daily job runs on the first six days of each month. This appears to be
due to specifying "Day" in the calendar intervals, which according to
launchd.plist(5) is for specifying days of the month rather than days of
the week. The behaviour of running a job on the 0th day is undocumented,
but in my testing appears to be the same as not specifying "Day" in the
calendar interval, in which case the job will run daily.

Use "Weekday" in the calendar intervals, which is the correct way to
schedule jobs to run on specific days of the week.

Signed-off-by: Josh Heinrichs <joshiheinrichs@gmail.com>
---
 builtin/gc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 99431fd467..cc13baa3bd 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -2075,7 +2075,7 @@ static int launchctl_schedule_plist(const char *exec_path, enum schedule_priorit
 
 	case SCHEDULE_DAILY:
 		repeat = "<dict>\n"
-			 "<key>Day</key><integer>%d</integer>\n"
+			 "<key>Weekday</key><integer>%d</integer>\n"
 			 "<key>Hour</key><integer>0</integer>\n"
 			 "<key>Minute</key><integer>%d</integer>\n"
 			 "</dict>\n";
@@ -2086,7 +2086,7 @@ static int launchctl_schedule_plist(const char *exec_path, enum schedule_priorit
 	case SCHEDULE_WEEKLY:
 		strbuf_addf(&plist,
 			    "<dict>\n"
-			    "<key>Day</key><integer>0</integer>\n"
+			    "<key>Weekday</key><integer>0</integer>\n"
 			    "<key>Hour</key><integer>0</integer>\n"
 			    "<key>Minute</key><integer>%d</integer>\n"
 			    "</dict>\n",
-- 
2.47.2

