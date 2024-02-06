Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD3F1C684
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 22:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707260235; cv=none; b=Y8bezAYfeice5n1ePUnqs9zgB5w2nVDzhRQkySe+uFNRU6MSuH8VeISA5oJVGDXalfnkwQ4JPO70KTa2oy6VqwKKhZz0x5vpkoXm5ARPJ1/xYqJZNLRMhc24bcAPOOasq+71GwWooqdN91mrbbjR7QLodu5Ka52g6owG009xUas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707260235; c=relaxed/simple;
	bh=3qKh27jsrUcj7bfIOZep3BM3tLL6s7jWgR8ZlXFcl4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aqkw1XJhH3vC4+yYK+GsNf5uimAm65tPV/2LoRk1okZZMm5CP3mPjfuDhRDDEtbd8wgUuP84pNxquRflgii58o8lYoCuzDaVgay0pbq/YQZ3LJ3w41816Sf30tA6vwY8EUQ10HJ1y6RT6HhEhkhx4jpkFymrsJirXbdWZ81yIAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ItvZF2/T; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItvZF2/T"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-290fb65531eso4614372a91.2
        for <git@vger.kernel.org>; Tue, 06 Feb 2024 14:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707260233; x=1707865033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5g+/7jrq18KLHAbv5nChhn1t9Cdsv01Fs6TwNRYoGcM=;
        b=ItvZF2/TwlHIcUnzbDUu+zJhgoYZP5UBeEcKOWcLRkS0oB0DjksfGCs/2s0VJoKEF7
         CutZ/oRnSmOlk3N9G3JjjJctG9nyjGQivQEk05Ava+at9klW7pebX98+LIc0mBJ+pURR
         agND3LS8fhkaXtzglrOvwvf5FmeVmRYjpSlR7JoB22W3g3cNvZNNXkKdcxtMTGqLol9U
         7pHZOqMuz8i8pD+ymohV81x8Que3Z24hKkJyYLHCeq4/u+8GMVW/rJq343gDBUEsGhZz
         WhlX1S/EaOaW9hQKt+RzH2KCa0LreS+uppWTgku9BJiGSqUyPP0X7gRCeRcTgGGuHmi/
         mwPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707260233; x=1707865033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5g+/7jrq18KLHAbv5nChhn1t9Cdsv01Fs6TwNRYoGcM=;
        b=wtdEINv7VmDFDf81dkHrKAuXNgiu91PDKCk5Y+oxYwa1NAUcDut2GolP1y2EQh6h82
         wrB+c9tji9yKZ3Pd93+i/dNUB2PjL1URCMZenAyjHcFO5CV290KvsUUntwgmmIvWYolQ
         VvFiJ3R6av5t/aQ9dcNi96vGT0VyCZb05pwu1SSd1hIyy++3Qmccx2kulN4JH61R/ivI
         n7V/mUX47UwIyw+k5/Lr58xAg4waGBi8H2zZu4gBXE/pdcSrPyupgsfeVJYD4wP1fjbl
         Sr3zwubzNhZneBMo3MJRkc2eOzGKAUFR69h8MHUT+O/y43RDLAx4hBR5EVcXwebu1c7M
         qsnA==
X-Gm-Message-State: AOJu0YwIOeS3X5pf7bcAh2S03K3yyJFDNhNKh3qAvF8lsorhUKwtZyyQ
	rW0/FaFg8LrxfvPEEaCyAyIHPeLaOhvgheyEU5SFiBb16jYIvtGZBxLb+X1c
X-Google-Smtp-Source: AGHT+IEEq8GUeggErb+OeyXIA+hdHBr2A/Jv2tY18Tny3U71jNRebmJ75BpE6o7EA1VohtEMYbUqeQ==
X-Received: by 2002:a17:90a:b90b:b0:286:9d2d:3a79 with SMTP id p11-20020a17090ab90b00b002869d2d3a79mr1034033pjr.12.1707260232625;
        Tue, 06 Feb 2024 14:57:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXE3lRxorngc7+RO1bwwZTlxUBDAKh4LdoCQ8B27RvtcNRoZLaZpSQ60zYS2epMKVoC310KM7mWO+96PChJy0rwIdlRzxZnvCwAy+OAQlgsdeAx9R4NXyxb2Us9q2nTUcj0gHR52lYrqPSmYPQocwQ=
Received: from localhost.localdomain ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id x20-20020a17090aca1400b00290f9e8b4f9sm46741pjt.46.2024.02.06.14.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 14:57:12 -0800 (PST)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood123@gmail.com,
	ps@pks.im,
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Subject: [PATCH v4 1/3] add-patch: remove unnecessary NEEDSWORK comment
Date: Wed,  7 Feb 2024 04:20:36 +0530
Message-ID: <20240206225122.1095766-4-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203112619.979239-2-shyamthakkar001@gmail.com>
References: <20240203112619.979239-2-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comment suggested to compare commit objects instead of string
comparison to 'HEAD' for supporting more ways of saying 'HEAD' (e.g.
'@'). However, this approach would also count a non-checked out branch
pointing to same commit as HEAD, as HEAD. This would cause confusion to
the user.

Junio described it best as[1]:

"Users may consider 'HEAD' and '@' the same and
may want them to behave the same way, but the user, when explicitly
naming '$branch', means they want to "check contents out of that
OTHER thing named '$branch', not the current branch"; it may or
may not happen to be pointing at the same commit as HEAD, but if
the user meant to say "check contents out of the current commit,
(partially) reverting the local changes I have", the user would have
said HEAD.  After all, the user may not even be immediately aware
that '$branch' happens to point at the same commit as HEAD."

[1]: https://lore.kernel.org/git/xmqqmssohu69.fsf@gitster.g/

Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
---
 add-patch.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 79eda168eb..68f525b35c 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1729,14 +1729,6 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
 	if (mode == ADD_P_STASH)
 		s.mode = &patch_mode_stash;
 	else if (mode == ADD_P_RESET) {
-		/*
-		 * NEEDSWORK: Instead of comparing to the literal "HEAD",
-		 * compare the commit objects instead so that other ways of
-		 * saying the same thing (such as "@") are also handled
-		 * appropriately.
-		 *
-		 * This applies to the cases below too.
-		 */
 		if (!revision || !strcmp(revision, "HEAD"))
 			s.mode = &patch_mode_reset_head;
 		else
-- 
2.43.0

