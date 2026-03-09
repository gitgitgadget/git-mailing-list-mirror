Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E673C2D
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 03:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773026618; cv=none; b=aaToAuURjZOth0nLeZ+r2WWoP70qb39+NWVs/Y7XfBff0KfQt0erD2Snb41HHx8YGYN6HKH5Rb93+N/dXDq/po6tL/TB4I1Zn3Hs0w6KI1yc42HDNUjJKIguBbtodHacMuV4603EQRiY9fMRABPZFBUySJWusSQ7eXAICHdteNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773026618; c=relaxed/simple;
	bh=j/GZgAi+I+hcO4iatj9QHqFyuKZZN4iK33tZw07IIMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Zt/1i5hB6n/8J8JbEVyS0XAwlWuKM3+oxfv/6hF+tLMXzimQJe1bQG+3+C4Fhy3/u3W45El813x5uChVFQf4CBbUekIOLN2Woc9ICtLFtMz/Ru6RQdcXyK/NqTcSOZ918eVGrr3xm4+neWy0QHJfBb9di9ehoijpWDpAq45Xg9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lmQe1mVq; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmQe1mVq"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-128d2e3082eso2143315c88.0
        for <git@vger.kernel.org>; Sun, 08 Mar 2026 20:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773026617; x=1773631417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=01Xj8xFDOfJPt7XwjpWAygGHBW4rdkBTmlzt+mLP7lM=;
        b=lmQe1mVqKF1NIii4+rU6orYrC9FkMDXaRHN+SdDc22v68pXo8dGXhX2If0nyUvkyxJ
         pa8pj5YoP7zOVyRotxAltD7fGq2ZzjPQpualK5KmGHsMrYD7Sx6ga9RpVygO5g2DroPF
         lgbj/lyWdDpnu7vT4HEh4WI3KI5qKBZ0AlBj17DCSEnNffL3DY92kVfglj3yDg2ogV4S
         pIhAM5dkRUnl9NZFeal66fQVY70L4qNV/MUSinjL6UK7ixen5UuaNI2jwLZT8dQlNTdn
         Bf4ebykcOgHTB6B7vHxGOfHR/8Rm0gBwsC/JmRyQ78+s6RS8kHbzoe4+99lOxZRj9PjN
         BBTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773026617; x=1773631417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01Xj8xFDOfJPt7XwjpWAygGHBW4rdkBTmlzt+mLP7lM=;
        b=w8sLnNl7GlZQHzNGbQjoApDXEMKHdq15dBIApy6ZRi+FHwKCpc9KKGf0/rxW86PUHC
         +voAaWyrLzxAbKqL7/tbomMQ5p3z4E9dPF58bpM5Ux3OUbucNTRuAxHX9zByghsbRHrB
         HFqfsk0JDUW/14sacrw+ebGj3ot390Z8N6K1pITdHTKB/1U3b7EpoUWPfRt1cHYhRL7S
         uIppRjuL3LLry2/jO6ZtfkRbUMntx4nTkSwfz99747euB1tnHjHcZLr+z9rsd7tdIexR
         OISxTsSQWi8pvi9ENjvsTd/8pZQFdILJuplZj02f7mJiB1S7iXBJeRU738AuE8BdBotx
         0yhQ==
X-Gm-Message-State: AOJu0YwQZkQlopXtNCebrJugM8DtE6Z8Ze2rE2SuKeeGCErMSqxVlpGf
	KOhfjWIC1GT9F+hA7shU5OW5fcE6CZ/FRbyyzXPSzUwwNI7Cfv1pu1IkOiTaag==
X-Gm-Gg: ATEYQzxusr5A+GiimLw/Kxhzj0/KN6bLXlDTnwnBamGGv8SrCY+iR0NQ3SeeNIaYg8c
	xN1yxaArbhESPIT23XDhEbuTu91JYRUOniT9815rql4NTXtmdAUUQ08v1R7HvdlRlxgHP97bdA+
	AkpEjYbSrOFLFdEq9ey7nZH6zHQ3ZY2/D1OeU6d8df2rbbbcTwlFN81w3aa67l721sVosyaUcXU
	O2479Wq+dzEk5Da2I+jZV6l4B+xun9hf+1i93R6WmjB1TXRJPS0ZicRPF0chKuPF1RS41UfHFA/
	DVgqoSloYvM81Z6rvbpstqMy3vNCnytjDOI3JVNskLmuMwz7J//38aWT7thPiJ3PvdDtmS/yZbg
	SX7jgnf1BPKp77a/aUshLaharVDHxFu4DkXzFhe9VWUiMubwTprJ1+WR/LtAEKOUGTXC2GYHdD5
	XM3RK3Sq5FgOdZLiiSfkx4vDyY
X-Received: by 2002:a05:7022:faa:b0:123:34e8:aec2 with SMTP id a92af1059eb24-128c2d90a07mr4124650c88.1.1773026616711;
        Sun, 08 Mar 2026 20:23:36 -0700 (PDT)
Received: from localhost.localdomain ([2601:646:8081:3770::36e5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128c3d7a2aesm6948998c88.7.2026.03.08.20.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 20:23:36 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: git@vger.kernel.org
Cc: Collin Funk <collin.funk1@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Derrick Stolee <stolee@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] dir: avoid -Wdiscarded-qualifiers in remove_path()
Date: Sun,  8 Mar 2026 20:23:06 -0700
Message-ID: <3ad40c3d0762c2e8c14792dfb68cba9f63a883a3.1773026586.git.collin.funk1@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When building with glibc-2.43 there is the following warning:

    dir.c:3526:15: warning: assignment discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
     3526 |         slash = strrchr(name, '/');
          |               ^

In this case we use a non-const pointer to get the last slash of the
unwritable file name, and then use it again to write in the strdup'd
file name.

We can avoid this warning and make the code a bit more clear by using a
separate variable to access the original argument and it's strdup'd
copy.

Signed-off-by: Collin Funk <collin.funk1@gmail.com>
---
 dir.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/dir.c b/dir.c
index 026d8516a9..fcb8f6dd2a 100644
--- a/dir.c
+++ b/dir.c
@@ -3518,15 +3518,15 @@ int get_sparse_checkout_patterns(struct pattern_list *pl)
 
 int remove_path(const char *name)
 {
-	char *slash;
+	const char *last;
 
 	if (unlink(name) && !is_missing_file_error(errno))
 		return -1;
 
-	slash = strrchr(name, '/');
-	if (slash) {
+	last = strrchr(name, '/');
+	if (last) {
 		char *dirs = xstrdup(name);
-		slash = dirs + (slash - name);
+		char *slash = dirs + (last - name);
 		do {
 			*slash = '\0';
 			if (startup_info->original_cwd &&
-- 
2.53.0

