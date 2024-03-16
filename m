Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A541613D
	for <git@vger.kernel.org>; Sat, 16 Mar 2024 05:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710565339; cv=none; b=qIZ0gaeVfBtxyO2yUjsFQl1Pg1hM3mcZJteUcKpG8Ce0HSPVycSVk+0BsmSAYXoo4rFSEAjmeyihUPwqM0T1pKGAGDtg55n3I27PDABe8yN/HXAffAWyvL0ONrvh+qq/cyVG2oR6JR9g2qLNUyxcixHaLB+uSX++2SkN7jSF9A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710565339; c=relaxed/simple;
	bh=jasPRwBObxDNGRbn2l09kCqVqPWBsjaa74269vI9MVI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=La50mxjRwb8nnpa/X6RS2uQ0lRa4NgxZuntWlaXhi+GZhwziCeqjI9fLL1hb2gcU1N/dExnoBAJWzXhNhCZTQZpnoJjPXZvdqubgP0PKa/6vxKknpj05GKLmlLnU8eKdv4UjbqGT4RzNV11rTjg/oGh9yUpXdL6PEl76boNh2zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gs3w1YcU; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gs3w1YcU"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6e519d73850so1925017a34.2
        for <git@vger.kernel.org>; Fri, 15 Mar 2024 22:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710565337; x=1711170137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ibC5Q2TgHmjvomQKUYke5Lpdu9KJmeuYO0IWqfHTjiQ=;
        b=gs3w1YcUw5prz6u7iff8R6h6NrU/A6WmOV3UdpxvqPnll2z57dTBY0LdcmyyLY4uEp
         iQJteRZ1DlsytRfBxDPBvbM7Ul4TF072DDkmUsCNtz2gqotQXi02QGmh3rHt7Ln30Ec6
         le6FSGPXlnlGUhYtrD/jJAb2S1GHhEWRxLwAeKEseFCC94kmSzdUWG3IvdWQ4GXZr+Ao
         lCuUvC1BPB3VB4oUIQ88gI8yE5yxv6oK5I5WQUebowNiG1shWzyASa5OWqPPnRUmA62x
         N7QsfPT9/h43B5wrFHTDlqyfKQWQvB9lcS0GvgNC3F7Ts282s7yuiBgKWc2Rjtx+H90a
         na3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710565337; x=1711170137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ibC5Q2TgHmjvomQKUYke5Lpdu9KJmeuYO0IWqfHTjiQ=;
        b=YHx1TodSmcIYWRlpsSmqGChZkvRIr3AbrPeC4//PCGe5E3gxIkc2q+m5scowhcYbVY
         RTfn2JpI+osawJ1Mq1A+7UdAQFmB32a4Eojg7FTEUHKTdKWm+fYRTVkYNS/2MhTKvfBI
         Xnp7ftCJWNaNYfFsR/DYBnHzMSFvH0Aw+CV4JmL8U0/bD6Zindv+Fcgd+gSTEhJgXh3n
         486wvJn6N0FjyEIFXSqhGDkYtnVmhqLgKX7/2ujc1zpduz2WKDSCQJxy8YkD1E7m3kn5
         tlFrKbGh9JuaZbNtpJdspK3lq4EuLBe58mpE48O9h5rTWD651f+tbiaEeLpW2n5rEbd3
         1qTw==
X-Gm-Message-State: AOJu0Yw/kndMAYMJuVysJJTsioFSTkNWug6HXgRfd0/NFR3VG++uD/YA
	narkmSSY0GXoBh2gvghC3Ku3VxSQy1RwWtsLbyCxqRY22dXZK74AqBS3tHh4
X-Google-Smtp-Source: AGHT+IF1ZJhRNcSIi/ab/aR1wrb8l5kyUtkIcUZxHz28m4cQ6lr+SVqK1W/1fkhpLEMyG8vSrDRXiA==
X-Received: by 2002:a9d:6a56:0:b0:6e6:75ef:5d97 with SMTP id h22-20020a9d6a56000000b006e675ef5d97mr5665885otn.21.1710565336746;
        Fri, 15 Mar 2024 22:02:16 -0700 (PDT)
Received: from localhost.localdomain (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id f6-20020a0562141d2600b00690cba72427sm2765420qvd.33.2024.03.15.22.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 22:02:16 -0700 (PDT)
From: Brian Lyles <brianmlyles@gmail.com>
To: git@vger.kernel.org
Cc: Brian Lyles <brianmlyles@gmail.com>
Subject: [PATCH 1/2] docs: clarify file options in git-config `--edit`
Date: Sat, 16 Mar 2024 00:01:24 -0500
Message-ID: <20240316050149.1182867-1-brianmlyles@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The description for the `-e`/`--edit` option references scopes
inconsistently: system and global are referenced by their option name
(`--system`/`--global`), but repository (`--local` is not. Additionally,
neither `--worktree` nor `--file` are referenced at all, despite also
being a valid options.

Update the description to mention all four available scopes as well as
`--file`, referencing each consistently by their option name.

Signed-off-by: Brian Lyles <brianmlyles@gmail.com>
---
 Documentation/git-config.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index dff39093b5..6876803253 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -275,7 +275,8 @@ Valid `<type>`'s include:
 -e::
 --edit::
 	Opens an editor to modify the specified config file; either
-	`--system`, `--global`, or repository (default).
+	`--system`, `--global`, `--local` (default), `--worktree`, or
+	`--file <config-file>`.
 
 --[no-]includes::
 	Respect `include.*` directives in config files when looking up
-- 
2.43.0

