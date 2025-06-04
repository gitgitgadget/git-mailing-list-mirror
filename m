Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFD6BA42
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 03:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749006542; cv=none; b=giMSTVqB12TdG7sdR30317pMVX5RnU4kuTl2jDnYFgdDWLciyUN9oeK5wYXRnUaSpDM9eyGXBo1RRCElbN07tmTL6miLPiQ19qbT1RIk0PRmIT5JLDrnq/6mf373BaSuJLhCUe/7Iok2cTUr2ZxDG6ZxegnFQawKaReFp6n20Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749006542; c=relaxed/simple;
	bh=4HzdQ+/BKAkvunlNzUVuWL06E3nVypquGROh6FerLFQ=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Z/F+5JH4BqmRxgBdVY+LXaSW0LOH7kmeU8f8hoxxK4seYbTPImpvR2mtz6/ODwGroxtC5+o4zAcEv0VqKqbQaG3JM5AfxGj3G/NAyfNPLykmLekmIVBkVfnsOjCaeBc3/uLLEYy5pk3tvGzURHLJW6Pme+kMw7Pc/E2a9tOk+fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lyr/R5ZK; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyr/R5ZK"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-451dbe494d6so30435365e9.1
        for <git@vger.kernel.org>; Tue, 03 Jun 2025 20:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749006539; x=1749611339; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Xxpi2VQdn68trJmStezwd1MD0DAgv5EfybJ5vHOH4LM=;
        b=lyr/R5ZKdzA+OuYbTunJBZpj26989hVkt+ACWJg8qfJRa+xdXbmgkdM+bMQxUcR+1E
         2WxWy/FXNChT7M1A+UDUxBfc/lNSd/PHQH5t8lBn7gqkb0lR7UXQXUB4KjsSPJipo+pY
         HkvX82YXW/C1QFG7I2WBiY1cyrmVEJK4eFwrWsALNW6isgvp2x/bWtGTrQJRjMXmWPTE
         8BbmNhZfSb6fzGYHsFljHCUz9yj5eSfO868GsB0xjyg2kPx00M63teXaAO0v2Wv2RB9y
         psyVEySmu0m9Rd4M3dvCfw6UGtjpUMQMQ5t3/nNyKpCtB6QyDf8KaRzBNoj9Y9sSjyJs
         e1Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749006539; x=1749611339;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xxpi2VQdn68trJmStezwd1MD0DAgv5EfybJ5vHOH4LM=;
        b=Efvn1kTZny77FJHN+9pC5cWblquV79oC9WbD0NvYAc0BNhtgw5JQOAkw8kQCUKWHRB
         4RMRG4JkKQjtYcM3C7C+8Ip6MTYZVy0lUQjCm+w1sQEEa/zv13rwi72/IGo7/cSH6A35
         DqJXFmf2m5Szj1QeM1pdzHHKTeDFPmt/0ywlBegdLrsTb15kieOVELByBhwfe0VVaxwY
         veZm0NFmzDCaAS7YTDRtF41YKvDbFGc1BSe5mNPTE1LaZYywTa3bVbKsgj0ChqAOTJ8z
         hzdVNFpf5QrN6eM+mUcgtkoulIOGqEJvxkUWzADAQZeNzLr2FevcKfP5o6Noul9cwFot
         BJ+Q==
X-Gm-Message-State: AOJu0Ywnq1jvBKwKcz5GoS+mWCiyUSzdoP7wbkkJVQAfNDOP7FW/s8yK
	tPPVCVepB42cUklOKd7DWkc65GM77dxWMdk6LBG4RnPSlzBi1+lsxtYf1hegtA==
X-Gm-Gg: ASbGnctAw2E4QjFIsw6UEvXw4MYexrAx4CpUSutSTnijkv0sXCfjSJlUaZwRk2ugK1R
	aiTnobUcck6JkyJ0cPBCgxa0Vz3xV/F6HlVEb8OrDe75heKU+1e511JK7lGtguwANj8UwB7gVOO
	kJ5/IBzTzbOe5ywDGYf9ybOuD0OhG66uCP7wkFxeIZILm6jdZkAtlDxM6vrM5hSU9ABILlBKv8P
	M8y/0E0rn/+ZRKTrBdOZyNdyShhP2KFvQHR3RCFBfXl0Yd7PR2zv1iD5qge5aciyVFzhWscZ9si
	+F3oRxbdYzMp6z/VzXiQcYPqdGCamY+Z9SpMdQ9dTZm4ebukkUCUiEvw2jE/b5iEsIj/+y1YGA=
	=
X-Google-Smtp-Source: AGHT+IEp3AY1h6EkNz4MNfeiSNP5c2P42CAc28RolPEmVRT+kwR360ucTFV+2DzESqXiezDa/7WBnw==
X-Received: by 2002:a05:600c:6309:b0:442:e109:3027 with SMTP id 5b1f17b1804b1-451f0b23d75mr6227905e9.24.1749006538444;
        Tue, 03 Jun 2025 20:08:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7fa25besm180676705e9.14.2025.06.03.20.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 20:08:58 -0700 (PDT)
Message-Id: <pull.1989.git.git.1749006537271.gitgitgadget@gmail.com>
From: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 04 Jun 2025 03:08:56 +0000
Subject: [PATCH] revision: fix memory leak in prepare_show_merge()
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
Cc: Lidong Yan <502024330056@smail.nju.edu.cn>,
    Lidong Yan <502024330056@smail.nju.edu.cn>

From: Lidong Yan <502024330056@smail.nju.edu.cn>

In revision.c:prepare_show_merge(), we allocated an array in prune
but forget to free it. Since parse_pathspec is not responsible to
free prune, we should add `free(prune)` in the end of prepare_show_merge().

Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
---
    revision: fix memory leak in prepare_show_merge()
    
    In revision.c:prepare_show_merge(), we allocated an array in prune but
    forget to free it. Since parse_pathspec is not responsible to free
    prune, we should add free(prune) in the end of prepare_show_merge().

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1989%2Fbrandb97%2Ffix-revision-leak-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1989/brandb97/fix-revision-leak-v1
Pull-Request: https://github.com/git/git/pull/1989

 revision.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/revision.c b/revision.c
index 2c36a9c179e..afee1111961 100644
--- a/revision.c
+++ b/revision.c
@@ -2060,6 +2060,7 @@ static void prepare_show_merge(struct rev_info *revs)
 	parse_pathspec(&revs->prune_data, PATHSPEC_ALL_MAGIC & ~PATHSPEC_LITERAL,
 		       PATHSPEC_PREFER_FULL | PATHSPEC_LITERAL_PATH, "", prune);
 	revs->limited = 1;
+	free(prune);
 }
 
 static int dotdot_missing(const char *arg, char *dotdot,

base-commit: 7014b55638da979331baf8dc31c4e1d697cf2d67
-- 
gitgitgadget
