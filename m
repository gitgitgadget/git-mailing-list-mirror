Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE1019440
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 19:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eksG1flx"
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410FACA
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 12:39:42 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3ae2896974bso77565b6e.0
        for <git@vger.kernel.org>; Thu, 19 Oct 2023 12:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697744381; x=1698349181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XYuenwWxfDZij6EC6zJZUlqMREG2QTyTxucK1lcvG3E=;
        b=eksG1flxDdrhG7U0Gn/sS0X866mMigpboqDCTKJVgqk4Lehsi0NNWphZNc/J8X5sUI
         fydfbvqKlS1B54UB3YlGA06SLJ0CjseA4UHQ8INQ4+K//MP3Kfhk57sb/F/O/0mtxRWu
         sUiiAtPoYP2wIWtPeHIdJ1UXm99Bf1N1hvoIXbuW2JdlGuYB8RANs+O3Ez93duDvLKkd
         YoMoJ6b37swPNAZgvRPYZwkFFR0uZG668YUvTGKUqt4JG416S6rj7532PtrbdzyjDGXn
         G6HKGxvDJKUQu4s+q8YUJHiofPvYgDT0s4H1Hq6frWobLEfE7+7UhllRJJ2n94AlqhAI
         53wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697744381; x=1698349181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XYuenwWxfDZij6EC6zJZUlqMREG2QTyTxucK1lcvG3E=;
        b=iibezJXLVQIQXfbObe5yycRBc/bg2Lty+tJb5AzC8u5+ocDfN5J71ztwdjSzSvC13Y
         gLq1qryCQdpO5wIr+ZObnOMqn98EOst2YAwF3eJu8dWxi0b1PWcZ8bCDvPf/kJAVXxOG
         4tCOxx6KKdWbATnnqngGkR1TqWkstuOl4YCME46z7pF+nGv8wU3LyYYHD/6pesyBI+bB
         i+D22FMIzDyiiqLqCqotd07S6pPs8EdCWu1NvG/C9ftNwsvT1oB6fzomWJwCPkzmKn/n
         A1HXm8IEi8nkAoIFH/2u2kGM9fCdXqXkV4xLS1XzDesPZ8XRRiIWrxqvqZKKiqFGUvAa
         JPUw==
X-Gm-Message-State: AOJu0YyqQ3T3mvSYHwTNtUN0i7QNXaTNj0mLDrJV+FSzeqATFl9yKmY1
	PtMHs7nFL0XACIwLR+yqeqkdHlYtYfU=
X-Google-Smtp-Source: AGHT+IF7wub1oV5V+jyyxViyhmxaRROZHeaX1GbvpkeJGujpazuog8NMo7IEl+IHQPV9L9Uyqt6Fww==
X-Received: by 2002:aca:1204:0:b0:3ae:bae2:fa76 with SMTP id 4-20020aca1204000000b003aebae2fa76mr3205733ois.36.1697744381510;
        Thu, 19 Oct 2023 12:39:41 -0700 (PDT)
Received: from u.ad.analog.com (cpc99472-lich12-2-0-cust1752.3-2.cable.virginm.net. [80.2.214.217])
        by smtp.gmail.com with ESMTPSA id ph5-20020a0562144a4500b0066d0ab215b5sm99940qvb.13.2023.10.19.12.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 12:39:41 -0700 (PDT)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH 1/7] config: restructure color.decorate documentation
Date: Thu, 19 Oct 2023 20:39:05 +0100
Message-ID: <20231019193911.1669705-2-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.42.GIT
In-Reply-To: <20231003205442.22963-1-andy.koppe@gmail.com>
References: <20231003205442.22963-1-andy.koppe@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

List color.decorate slots in git-config documentation one-by-one in the
same way as color.grep slots, to aid readability and make it easier to
add slots.

Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
---
 Documentation/config/color.txt | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/Documentation/config/color.txt b/Documentation/config/color.txt
index 1795b2d16be..b0e2eccad95 100644
--- a/Documentation/config/color.txt
+++ b/Documentation/config/color.txt
@@ -74,10 +74,25 @@ color.diff.<slot>::
 	`oldBold`, and `newBold` (see linkgit:git-range-diff[1] for details).
 
 color.decorate.<slot>::
-	Use customized color for 'git log --decorate' output.  `<slot>` is one
-	of `branch`, `remoteBranch`, `tag`, `stash` or `HEAD` for local
-	branches, remote-tracking branches, tags, stash and HEAD, respectively
-	and `grafted` for grafted commits.
+	Use customized color for the output of `git log --decorate` as well as
+	the `%d`, `%D` and `%(decorate)` placeholders in custom log formats,
+	whereby `<slot>` specifies which decoration elements the color applies
+	to:
++
+--
+`HEAD`;;
+	the current HEAD
+`branch`;;
+	local branches
+`remoteBranch`;;
+	remote-tracking branches
+`tag`;;
+	lightweight and annotated tags
+`stash`;;
+	the stash ref
+`grafted`;;
+	grafted commits (used to implement shallow clones)
+--
 
 color.grep::
 	When set to `always`, always highlight matches.  When `false` (or
-- 
2.42.GIT

