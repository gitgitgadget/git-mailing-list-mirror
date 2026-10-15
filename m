Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B224C8C53
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 11:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792062068; cv=none; b=q8DcmSO7d870fFqo8TZwOpnIshCMXZU2gMsvRO7rsVkOjKe0xhjtn8A643crpY0y2i8c9ebSrkY5zJDVJvAXlpU6pww5aL4JcwG56s5ZjUrdW30bYY8U+oExsF7Bk4/2HhOk2Sn6HdyZh4XqpzinBZOZX/WeAwwiOlCyYbxiMcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792062068; c=relaxed/simple;
	bh=uuHOcR+xAuTQwt6yFT7tk4I68RMnTJXRnuNz+DjVtmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FKd2Poy2yAJRpDz+qO1g6enoBtZqJ25VS/pmt711k49tlIuLaRHF3Oeu9S7j75x+1JBpVwXXmoPIsvn7OvDqCl5QhzJTXc1XJBYD1BUuauAKPhLdy3uB8kiCn+hoiy3xOhm/p9rlm7mXxQaNYIgm61+H2pVJ3JfvwesA3B4TCKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZCL8OxJ; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZCL8OxJ"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-98c5876f2b0so671953241.2
        for <git@vger.kernel.org>; Thu, 15 Oct 2026 04:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792062064; x=1792666864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hicPQGgFWGTKGlb3u+9HS1R0GZr7sLHZl2DvMpT2Zfw=;
        b=JZCL8OxJ8knrdZz34x+WG81O0CkJYPE4FUK5QABub4px2BGNM5W/+3t8YBMrG4JUfw
         3qF0dXEOhvR4sarwAneUBlWmH73kBaNrvlSlwWzu78LwUDQkXHRiuelWy1qpC099ijUr
         j1xmSrETjSRsCCR5K9leJzQZyCtiMt5K8lQC5fwck9cfyFtVKTWrCAmQhhsWFWdfrjgU
         5oG9SWYwCStgr1+AOhAsC/960e6a5a03QVTm+J+OzKK4LxGtpEBstCvcJRhf+0VeVb2K
         44ucyUBMlM2IOohVki+IBpRoaiv9iF+JRGb3l9hcPfWyOSL81FLoQJSWrH14eOSNYvoP
         eCqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792062064; x=1792666864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hicPQGgFWGTKGlb3u+9HS1R0GZr7sLHZl2DvMpT2Zfw=;
        b=bGN3Not62kQTepGSZfFjD1zjUjUaK4b/dk493gNel4uIH3AG4CzqbRmqZWWYeiBMX6
         51JuMzdZFbId4cHgC8GHQ082aXex7lIOUN3v/AJpAHHLifABAk/FysLSFDuoKHdURGLd
         +rs4fvuNDIYzw8K0/a9gKoxkFwqc7lJMNR9w0Mk+UeGZwsx+ayGYKo2m+6ey/4HUsAVz
         4ElX1B1n8fs2I34AiM3gSKhcUsdd2d9IBePpGrIPyGITq1LLEe6/2lr1FPlGg6jTripr
         JExn2osZZDXjhuNDkGJYRHZ0Gl/InaWo5EFaE6eE9VZhbe2FKEEEbDhs/RLNu3+/VSDE
         G/jQ==
X-Gm-Message-State: AFq9FYKiMvnxO6mjwsVOJ3GTR3H+uEwxDNHXDHv0tmg8unyI8D9EVN21
	G/6tfy5hLbiOR7J8+eAqPB8SpLv12P8J/lV2jYCwjj2tSyG+Wkn1squDbyMf8S8aSGA=
X-Gm-Gg: AYBFou2CfiraRVd6a7AQL94NavHRJSgEsI25jIte7gzJhkguV+tQysz2UW700jnVfld
	ryMDUkiR0zuaOGvWFCFga0qQ4JNrdysPIH+d6Px1u6cbqF/Myf4Hrv/kGcKcBKF3SOIZN+c6awM
	hgEOyh5jZ5oQyuVoSDw2emgIpt9E/VLPOnYRJ8XCX5oTtmno3OlUNhRSIfVFRo7ki+XHTW8qASD
	GvdUdX+KTmFTzj51XjBLa8W9OnrXeCKbQ4zeVVERfiW73m6H7YQv9X/JpP1RvL0WIwtDwBoOJqQ
	90zyXO5prnBmEb6lI9jW4iMb8TTowak0qBZyG2zuXnOIHSbX1A7mctb8rpRJmgWPZmXG/KTdYSH
	jSF/817fPLmiCUDrtHCbHDTC/CuiRA+uSHIJ9ADuYt5aZzva9HNhtsxgSKdYBG6P3B5jOI41uJ2
	U+i4CEu+ilv9brJH/JJ2dtCLR7v3mN+bKJklhWo60r/DqDnafEbeN+fzHkq8SJucu9DO0pGT0oz
	H3fuW+FfN99tSSBIYnY/4+193i50MNSi8g+Jnw3kMYb
X-Received: by 2002:a05:6102:15cd:b0:7cb:f96e:c437 with SMTP id ada2fe7eead31-7cbf96ec463mr812333137.34.1792062063689;
        Thu, 15 Oct 2026 04:01:03 -0700 (PDT)
Received: from isabella-caselli-linux.. ([2804:388:d001:9f94:7eb9:62e0:e1e9:151e])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7cb35471536sm13099381137.11.2026.10.15.04.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 04:01:03 -0700 (PDT)
From: Isabella Caselli <bellacaselli20@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ignacio Encinas <ignacio@iencinas.com>,
	Isabella Caselli <bellacaselli20@gmail.com>
Subject: [PATCH v2 2/3] t6500: get hostname from "git var"
Date: Thu, 15 Oct 2026 07:58:58 -0300
Message-ID: <20261015105859.3184108-3-bellacaselli20@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015105859.3184108-1-bellacaselli20@gmail.com>
References: <20261012015846.2649843-1-bellacaselli20@gmail.com>
 <20261015105859.3184108-1-bellacaselli20@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test "background auto gc respects lock for all operations" simulates
a concurrent gc by writing our shell's pid and hostname to "gc.pid".
It gets the hostname from the "hostname" command, falling back to
"unknown" if the command fails.

"git gc" only checks whether the pid in "gc.pid" is alive if the
recorded hostname matches its own. If the hostnames differ, it assumes
the lock belongs to a gc running on another machine and skips the pid
check. Since the test passes in either case, it may pass without
checking whether "git gc" detects a running process on the same
machine.

Use "git var GIT_HOSTNAME" to get the same hostname as "git gc".
Keep the "unknown" fallback, which "git gc" also uses when it cannot
determine the hostname.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Isabella Caselli <bellacaselli20@gmail.com>
---
 t/t6500-gc.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index a7142ab815..f928089bf0 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -413,7 +413,7 @@ test_expect_success 'background auto gc respects lock for all operations' '
 
 	# now fake a concurrent gc that holds the lock; we can use our
 	# shell pid so that it looks valid.
-	hostname=$(hostname || echo unknown) &&
+	hostname=$(git var GIT_HOSTNAME || echo unknown) &&
 	shell_pid=$$ &&
 	if test_have_prereq MINGW && test -f /proc/$shell_pid/winpid
 	then
-- 
2.43.0

