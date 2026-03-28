Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB168345CBC
	for <git@vger.kernel.org>; Sat, 28 Mar 2026 20:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774728207; cv=none; b=VcceSmo3+pKXYWB8iNNvtWEyWtTLrDbM1uauyBjLkoWWmBYfQRoEFOIjFPHdLvc5QoRBcU6ITWHtvrHpawZuRbj/ZPIcK/TTfggi2QQubd3rL8cCXXWauddAEaG32G2582wBuyCTQ1mEwy47HePbpUa+cL4fpsGWqjWe0NBi/vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774728207; c=relaxed/simple;
	bh=gE5/Qp610WQ5f7viEHqnbE+WQ+3hnCOxJ4suxDCds9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jfpYveUFhbhQnsr+w9556Yykt+fE6YBdiSyzah0WVyqknzaWdB5pN46KHm2NzsyRnc4X7ggvzR/ThdcDmRGJoHLWwG7QoZGc5jig0Sjt6Tg/PJVJDgUcbo3VBhH/5tev29xs0dtH4PqUGqQ+M/T6zWc5vXKxRxsMTnwpX/RBRTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/djGL5u; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/djGL5u"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-35c2fe0d90fso1071283a91.1
        for <git@vger.kernel.org>; Sat, 28 Mar 2026 13:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774728205; x=1775333005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MbGkYCsVsF7bgZO+rENxu86m/jEYYtF+1NnD23Xr7go=;
        b=T/djGL5uue8nXTbN34gjF5JSWEclQQGBVQ/TuBHHUqypZk1eeZ08zQijaTAS76vKdF
         2wLkhu5LrGQhIM/hg6K8+nPnvVM7YtcJdgBM0zV+wRRMuRQmac5X0zeER+mlPVowddgS
         oCz4/axjUhXiPAyJAvmlf9VF81NJkCqRC6Biksvc1jpty7f6CEJmjPGJBPfpF6vnlqHz
         yrZ8+Ymiv1PnFzPYTv3DyH3cyIVQYylt3WgyX2WH+Wip8lgKl8TGKOad9wHpg4FZRbYL
         lJud4G0/BT7wgGrEnO+SErszJ+nKyHXIS94v6XSPZSlrdaCIOpH2iKGkZazK8LxihiGM
         vy1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774728205; x=1775333005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MbGkYCsVsF7bgZO+rENxu86m/jEYYtF+1NnD23Xr7go=;
        b=EgEpoi9f6ZBgWCH/yjLYHsZQ5XDOR6GgClUuqzAZ0LUvqwWZG0ANi0FmR/dOET7R5c
         B/SamVgE1prnGuZtm/M93UiySeHs+HzRN0t0qJASBUlMuLzgJhDv7fApRhxsgBlEXtIH
         nVo4p4O2IyIxblIjk2SbrIjzIUa5RymieyLuBSfUVABwpGachiwShw4SuuPmE0En8Kh/
         Sy3O6VFG1HmIr9yqrNvgaiGiFAAaSzNnsHaEJuLo3ehsvLHIZbv4AqktrugQCNUx+3de
         a6nfB142UgXBbMs7/eG63xdl0nA4oA6gzeGqWC3hA3DjvUvlZv6dJrlkYUsoRxESPC0W
         lUUg==
X-Gm-Message-State: AOJu0YzpdHUkpl81jRflCU0uNvPa4aRTIJKbvlqSc0207PNQe9XlFfvT
	R8pqrbRw2uy9Nrzz/JQ91mPafeKpZTyVx+KE983zprHfpd2dzHorAsgrXL9pZC+j
X-Gm-Gg: ATEYQzxwPfgis6CCfIA081TEfX39KJAOP3L0sCmt4SFCuYS3SRYEQpru8M0Crm/E9gT
	N8XnE9s28++SJc+6GWJFNE5N3w85oTPPwrsiXjqfTet6OyBF9EC+Cm4j8Vs3R2QX3B6QjSYmwgi
	kFO7rp1VenZ6D7QFsMoaH3zMNG5Bta1ixRVBW2U9PpUlSNJF4XE9e8Y1anQSUVoPYBUEVhlhuBG
	bwocPak5U+wY55MqqRGsF+oQlPIYWIjwXpO2U65sEeWXku/NLtWq4oncLremKuTnc/PUmZOgTCI
	eQrkrbYf7U/y9urwdGvP4S+EwFpp5GvEroizWCv5v2j1m+0Otw+Ry2Q272jxNr6nY1xCmyTF3hx
	bIvJbsSDB0PKzYcmQISSXuiH7z+JaQBU2Y3yrZC0hTFX7L0fSZ7dKLEMsYDlMnob16hehp/abQS
	LHlm4dJeMS0Ej2wWbbA5+gFdQU+37S52Nti4n8JTOrss9XsWytYgaV2pL1E/PD/7AXAMm63GiRm
	04TLrkK3uIzunYMjTN8
X-Received: by 2002:a17:90b:4c0b:b0:35d:997c:8eb8 with SMTP id 98e67ed59e1d1-35d997c9679mr1804316a91.24.1774728204924;
        Sat, 28 Mar 2026 13:03:24 -0700 (PDT)
Received: from trieu2-huynh-trieuhpn-ubuntu24.bee-live.svc.cluster.local ([27.122.242.65])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76917bb31asm2359786a12.23.2026.03.28.13.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 13:03:24 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
To: git@vger.kernel.org
Cc: Trieu Huynh <vikingtc4@gmail.com>
Subject: [GSoC PATCH 12/16] t3701: avoid suppressing git's exit code
Date: Sun, 29 Mar 2026 05:02:51 +0900
Message-ID: <20260328200255.247759-13-vikingtc4@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260328200255.247759-1-vikingtc4@gmail.com>
References: <20260328200255.247759-1-vikingtc4@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update t3701-add-interactive.sh to redirect git-cmds output
to a temporary file instead of piping it directly to not hide
the exit code of git commands behind pipes, as a crash in git
might go unnoticed.

Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
---
 t/t3701-add-interactive.sh | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 6e120a4001..a07db3b1aa 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -293,8 +293,10 @@ test_expect_success FILEMODE 'patch does not affect mode' '
 	echo content >>file &&
 	chmod +x file &&
 	printf "n\\ny\\n" | git add -p &&
-	git show :file | grep content &&
-	git diff file | grep "new mode"
+	git show :file >actual &&
+	test_grep content actual &&
+	git diff file >actual &&
+	test_grep "new mode" actual
 '
 
 test_expect_success FILEMODE 'stage mode but not hunk' '
@@ -302,8 +304,10 @@ test_expect_success FILEMODE 'stage mode but not hunk' '
 	echo content >>file &&
 	chmod +x file &&
 	printf "y\\nn\\n" | git add -p &&
-	git diff --cached file | grep "new mode" &&
-	git diff          file | grep "+content"
+	git diff --cached file >actual &&
+	test_grep "new mode" actual &&
+	git diff          file >actual &&
+	test_grep "+content" actual
 '
 
 
-- 
2.43.0

