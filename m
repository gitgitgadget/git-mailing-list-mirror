Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD14E225D7
	for <git@vger.kernel.org>; Sun, 25 May 2025 05:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748149788; cv=none; b=IyROr2QhvVOCHIb4br4hD0dhCZNJL8eNmwjGIKUn2HodcsPqZPN+zYHBXWEWLrFCBgVJOZguxOuhjoY6akHRQiQABW8EmzZmrXVuPAIGB4haslCp40D2PViqMslgOCA4WUfu02H9ZN0uC3XjiQtZODEF+DFiJu3DUGJ39IsVGH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748149788; c=relaxed/simple;
	bh=JF3m9b95aVzyRCWITaqmeaSYVUlv3X7SZzVlzTKTztc=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=fTBuwcvEFhqlfoAghk7snuhAgKkPNBZ7TeISuHyBWuiVuGY9n8NUMF9YdO0UPLYSHDq3u8UzJGizEKFSCshm7WRgJoU5BUuZiuHvBnBxPivvUlBzxKk027qUdaWO1Nz+vVWEsU9+0rZOIwFJocmcQgWDwnDx9tytnai8B7zMgKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ExO9ZJs8; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExO9ZJs8"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-442f9043f56so7291755e9.0
        for <git@vger.kernel.org>; Sat, 24 May 2025 22:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748149784; x=1748754584; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=x4+UJpkzWoP4NXvECEn29J592zVretIBNEMtZGE2BwU=;
        b=ExO9ZJs88VnqQ7page1x5zWDyzPEHhAwHXjPwOdldGVpAt/LzEOu1f+Sc+tdjUWtvQ
         2ceKnSQ38B5KXMHakpM5DKbKXK2Nm9T+QmlfRJUE59W18Sa48lGrYwVd8namT714EEcT
         FG00gJLU4eXtd9EK1P146/091Vir/pD8VhaNw9nEj64tgdVC52R5lsQ3YXUa6IX+2/58
         dwh6h24wOY3DmqxYF0A0WdSpdWoDoh+OeVcu1WFFw6Swm3EU/rj2kXyQ7XsE3ukLylEa
         PK1B1gMXkvRit7OLivR+TvKc9h476cInlJ1TGE4jHtGlqjaQqtgiNRnxd6T8s+tT7TMF
         2hEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748149784; x=1748754584;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x4+UJpkzWoP4NXvECEn29J592zVretIBNEMtZGE2BwU=;
        b=rwfg6+kTqWN0Mz6JhQOGMUH9UCQpsDzMT8vsv8ZBaKBrb4NgJibaV6rhijiGFRo3qL
         HVa/DE9pY8gOla9vAP3+zMxUYkl5nBy4szHq7+bKZqaqmrnSJ8w2LkJ3TZZUPFBmXTWl
         c24bEmG46ax9abuC6fAWEEx7Ycl0lXIt8UnbV6OEDH6ElLmmYJztZMpOdd+4UspKuHNv
         tk4IPZlm9epBxiePOJvmrpiDBNHWBH4CrN6mJPE+Bly2z9Tybo/BUCv1oX/5pcar91Eq
         O6tU9GvbPyPdpMr9fKxNg+VscAtjsqllC03YvJKoUdYXx+osmH0kALvBAcIg7NXv/6/I
         9OGQ==
X-Gm-Message-State: AOJu0YycXLFRWuF5+4VtWPxFvIYimBxU6ynx331O8Hnhwwk4FQGr2dkb
	fWwok5639NnME2uI/CjR7uu8vAGbqXGnziWZ80MbFWJr6ZvCYRPfv5qzP/3niw==
X-Gm-Gg: ASbGncsTdbvXUmLuh35ZX3aq1Rp/QmQqAQ9I932LYQVVxvNyZ6cJ06lTgeBJh/KPkj4
	5VBWSb/yiciQLvFhM2WaR687y4/Xmfna4o/Byr4AzMLYlvh0qg8LeHtygF3SfwVPe3OLMV0lCbR
	w8maw8opwRZ5n7xttkOb+RVgxKPErogI3fuAfBrsj0ebWVXS0N2KQJl2DcItkob5BEHSu3ZhKF2
	WEbOyNBiII+Zg3VkbMH7RZFUuN3ij9lfmOCMmGNRt40TnSf91ftoOe9W1EfKGKl4iqj52xIY9l5
	rtr46XVRlQ85/Z7zolk4aNA/Lh+Aek5Q0CQ6eu0Vtakz7VgjmaQ+
X-Google-Smtp-Source: AGHT+IEus2xHmzObs6WuHXnTTtwYb9NJtCCffqciADswYbhjiFWi3QUC17HWC+eEKmcm5/NuzXIXDg==
X-Received: by 2002:a05:600c:5297:b0:44b:1f5b:8c85 with SMTP id 5b1f17b1804b1-44c919e1690mr37654385e9.13.1748149784327;
        Sat, 24 May 2025 22:09:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f38145eesm193308025e9.26.2025.05.24.22.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 May 2025 22:09:43 -0700 (PDT)
Message-Id: <pull.1977.git.git.1748149783383.gitgitgadget@gmail.com>
From: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 25 May 2025 05:09:43 +0000
Subject: [PATCH] pack-bitmap: remove checks before bitmap_free
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
Cc: Lidong Yan <502024330056@smail.nju.edu.cn>,
    Lidong Yan <502024330056@smail.nju.edu.cn>

From: Lidong Yan <502024330056@smail.nju.edu.cn>

In pack-bitmap.c:find_boundary_objects, we build a roots_bitmap and
cascade it to cb.base. However, I’m wondering why we only free
roots_bitmap when the cascade succeeds. It seems we could safely remove
this check and always free roots_bitmap afterward, which might provide
some performance benefits.

Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
---
    pack-bitmap: remove checks before bitmap_free
    
    In pack-bitmap.c:find_boundary_objects, remove cascade success check and
    always free roots_bitmap afterward to make static analysis tool works
    better.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1977%2Fbrandb97%2Fremove-check-before-bitmap-free-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1977/brandb97/remove-check-before-bitmap-free-v1
Pull-Request: https://github.com/git/git/pull/1977

 pack-bitmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index ac6d62b980c..8727f316de9 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1363,8 +1363,8 @@ static struct bitmap *find_boundary_objects(struct bitmap_index *bitmap_git,
 			bitmap_set(roots_bitmap, pos);
 		}
 
-		if (!cascade_pseudo_merges_1(bitmap_git, cb.base, roots_bitmap))
-			bitmap_free(roots_bitmap);
+		cascade_pseudo_merges_1(bitmap_git, cb.base, roots_bitmap);
+		bitmap_free(roots_bitmap);
 	}
 
 	/*

base-commit: 845c48a16a7f7b2c44d8cb137b16a4a1f0140229
-- 
gitgitgadget
