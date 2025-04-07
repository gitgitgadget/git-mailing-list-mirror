Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8439C21638C
	for <git@vger.kernel.org>; Mon,  7 Apr 2025 17:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744046719; cv=none; b=ThThY3vef7LL0Q0tEsAPKMxObQel5tsNK9exJ2zrPM+5ewS5XGa7EoGsKbE+cghASLBibrMKZs34BMFj36A/0byfulACdfJ6xrYGNHUJJWFbf7oG5+7GHK9Ck7QdgnKayA2ravePmBGih43k4NkXov7COm7PNEhg7imCtwRvayY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744046719; c=relaxed/simple;
	bh=ifMuZG9Iz71h4ItnLnz3UIGQy1c4doz7EYuPldJjPaU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CvsnjEi02ASVqz541T/md7lM4KhQCsGrc953pNjyzJS4MS7+WYx7UYcsxhIWb3A1YcjxDuL+K45fwpnrJ4ifhN4iMZKxPfDpIVMhHozh3Il4D7DHr+uVM31WsHqdhyXNTfqIxMUSjTmRSgR7oKf0/tRcSI8og+me9gSr1vatkR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jxPQqR25; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxPQqR25"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ac298c8fa50so778835066b.1
        for <git@vger.kernel.org>; Mon, 07 Apr 2025 10:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744046716; x=1744651516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4fLZ22f7JoRp4VTn7PF6r/KMIOlDWHlEUpf6u8IrmU=;
        b=jxPQqR25RRK2VWwWFzsAkb3nmMzAoR5s+31Ll1rS3YQZd8os0bv++ccdeC1LzjTvi/
         ZdW9g1z57AlPStkOcYE8+kBSAvQDTJl14As5cOFSHyQNMZANLjM2GYLYabJ+F8DLvlKr
         vlkjfis54vqrmPM8RtrGyYnpRsDSRnifDWtQ7XutA2xaGiidSq0hlefldZbMyjWWJnhI
         YkgCwuzAvC7bc6Ukz5181ZfO+/iC8FhCJxkzzRRuhXB5puGA1xeNxYwkA1/cEr+LAiq0
         EDUQ5nQOqE0Y7SxslHKGCrwgD9rf9LfP/vF4NGc9CUu0tHAv0Q8n77H5p8xpO60E/xXA
         ojeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744046716; x=1744651516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f4fLZ22f7JoRp4VTn7PF6r/KMIOlDWHlEUpf6u8IrmU=;
        b=Hmcb+cWMO4olVgySLkcOFjKtnAdr1BdvGsXrV9hf0HYVFVQCisanslmSaGFZT8WwnM
         evzVoEQHGgGma0MZ1QtYziadEyXFW2tWDPOYBUpurqATZkKfWQvA1aqkxwdzWFr1NalP
         HK3SfYV8ehC+gg4AEm6RN/iRNwC12g0Hx7y+SHxdllWOlAxk6tNc/P67Y6W3IF/GL4jI
         6MSXV2meaKJYcOsCKO4UKqaxv6dtkBm4hgXNkbgL1t7J+TMSAdS2lc3KjGT73XSqZV4H
         sEZiKMtyymPeTmWgGB3B22ULpCArV+2sjRBWYaqYDNtAOc+6cU78AbM7GBQA8LjlCAMf
         cQTQ==
X-Gm-Message-State: AOJu0YwGkbVEE+HEq3e+2n/68E5zPqMh5FoUndea57EQl0jMp1SClcW1
	J1TUtrHwrysxwlsFqgHWReJm+UDYJqls5wEx3Ev0gtaHg/nn/c4=
X-Gm-Gg: ASbGnctMqnttOvMfAjnDb/uUoPwGM18TPC3i1vXmIJHvF5A0vD043zDOLdtDqJ37fSf
	l38L2RoxQR35+MVqrZTC35XWIDDhRfeyKnY0mI0UFf6xhb1gjmOt6KihBO88hJEOi5U1eeg0y8T
	2lJ+DyPgJewW453xmXYEKN7PnHC5p8PuZHGCnv9M8+vJwXBeN9GQasDrkfeEfzsIzwkbGq5e0ch
	+8cByMgRjzJ3TjzZ1GMzVFt94vs13pyOAh5nLUkjdHjQGwfUUvi68u6LPVcJWnXik+yixW3R+cN
	md51ZJx1ICYw94Rgjh5jToqSdbjVhcE8kucNHDLCbmmeprKD3YOQ2/xlEVROhbTn+pvI6MzRM0o
	AzrAHo2KG1u7Z
X-Google-Smtp-Source: AGHT+IFzj49m/3Gd5sc3CTHC+dzGmYcf8v0ZtsAAhQ6pAkDqtSqP0ulnFvgdbnfi4hQNpKweFJcmgw==
X-Received: by 2002:a17:906:6a22:b0:ac7:805f:905a with SMTP id a640c23a62f3a-ac7d17d8758mr1128924166b.28.1744046715642;
        Mon, 07 Apr 2025 10:25:15 -0700 (PDT)
Received: from localhost.localdomain (generic-nat.unisi.it. [193.205.5.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7c01c0fb1sm790193966b.179.2025.04.07.10.25.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Apr 2025 10:25:15 -0700 (PDT)
From: Anthony Wang <anthonywang513@gmail.com>
X-Google-Original-From: Anthony Wang <anthonywang03@icloud.com>
To: ps@pks.im
Cc: git@vger.kernel.org,
	karthik.188@gmail.com,
	shejialuo@gmail.com,
	christian.couder@gmail.com,
	shyamthakkar001@gmail.com,
	sunshine@sunshineco.com,
	Anthony Wang <anthonywang03@icloud.com>,
	Anthony Wang <anthonywang513@gmail.com>
Subject: [GSoC] [PATCH v3 3/3] t9811: Change `grep` to `test_grep` for debug output
Date: Mon,  7 Apr 2025 19:25:04 +0200
Message-Id: <20250407172504.50849-4-anthonywang03@icloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250407172504.50849-1-anthonywang03@icloud.com>
References: <20250405103718.25160-1-anthonywang03@icloud.com>
 <20250407172504.50849-1-anthonywang03@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change `grep` to `test_grep` to provide helpful debug
output in case of test failure by printing contents of the non-matching file.

Signed-off-by: Anthony Wang <anthonywang513@gmail.com>
---
 t/t9811-git-p4-label-import.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t9811-git-p4-label-import.sh b/t/t9811-git-p4-label-import.sh
index e69dae55dc..e9c2aad2aa 100755
--- a/t/t9811-git-p4-label-import.sh
+++ b/t/t9811-git-p4-label-import.sh
@@ -96,9 +96,9 @@ test_expect_success 'two labels on the same changelist' '
 		git p4 sync --import-labels &&
 
 		git tag >output &&
-		grep TAG_F1 output &&
-		grep TAG_F1_1 output &&
-		grep TAG_F1_2 output &&
+		test_grep TAG_F1 output &&
+		test_grep TAG_F1_1 output &&
+		test_grep TAG_F1_2 output &&
 
 		cd main &&
 
-- 
2.39.5 (Apple Git-154)

