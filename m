Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1C433D512
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 17:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771610032; cv=none; b=WftfZ/YIL3+Ki73cTqdhOUQHiMSIHs7JkytDM2kWOoXUL7o8Lj6Ii1IkQZm4QTV6jy1DzpvT8dohuJt6rN/NS/tvqUQDC00TE/RVPZvlNZoMqTuhLn1kH+2mWAJDQKVgMGh29utsBYRPDGDgXAooSzrfgegzweyUvbs56giMcFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771610032; c=relaxed/simple;
	bh=D+/BQhp8Q4FCZwQ2Uu+QjugVxWN6lYLgsNbA9A/D2XE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hJ/Rcgo7CoLfmvedDNtYyPj6UEdbLhv+dGwsuJeU5zIoxGcqlbt7vE0HWtB1OxbrCPc2/3w6yLVovDdpSPJjCKC0RqLCkS0cGMeGuITU5d/RqC36xKd2LtqL2ydV6NPcMucZmcD2pKS2VkfOwVt4pMgFUYSwEuU+3d0XLLgO6JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jF9QwdVq; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jF9QwdVq"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8230f2140beso1901794b3a.1
        for <git@vger.kernel.org>; Fri, 20 Feb 2026 09:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771610031; x=1772214831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FZ9SJHpEvrWPWp2JqxZLUMaHHPIKmzJrNpLsx7QWKDo=;
        b=jF9QwdVqte3aPPtAD6pT876sKZZ9giEmpT8o4+Fxj3nJfGR01iv+odwxiP8pAx4UmD
         mGdDc/4ojLbbcxWeD8ti+1hQucJKaq9Ld/OeRD5jEk79QBkX1SpeynKgO5/FGELJ7/42
         5hiYdIxCvYdavKkns9hN9YT08QokZbCELG6KnG2jCytE3zg2VfGXvoLvJ2c7elbD5a1f
         fptkRthNgbck//123fQ0ohYStm4NAXolENPM2GUsHBZFMki2m6ykHnTVZMMT1RaQmHVU
         XN/znyKKXglJ1X0K7oUjjzSO/zosdU6g04+q7V1Y5/J1wsUV4d78TMsyGd0t/0OwUS16
         DzPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771610031; x=1772214831;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZ9SJHpEvrWPWp2JqxZLUMaHHPIKmzJrNpLsx7QWKDo=;
        b=dZ550PCO++8Ocy0aBJwTfkqLgBZH6Hg53fYXs/diVlCQMDSHY5yBS95nWLKdFItPgJ
         /hD/BbQEvInHO1ZJuIpKCZWBRnvjsn+nKrqvUFB2dBkGuwkDeLXXokBxWbXv8T53lM30
         Um+ITRU3wfuDqwddkFXXLXRFMRnGWybiJgQNnxw85D0X7c95yT/O54fBpF5iS8Btfrcj
         Qx1sP5PqzaMvrJd8BgpRLgM4PswrcZsHWuZsNyovN9zn7nBco7sgpw14dtcJNsFyMpob
         4tYlAeHPzVWEVJvBqJsPeaFCpRgU25bRo0yxZ3FajCXGU1OrOJktBZ6dz+rvq2DQsmIp
         ZTlA==
X-Gm-Message-State: AOJu0Yy1AWzKmNymxJni4Q9NDKm9oqfFmIs/WtKaB6iMgVeMnlqY7Rog
	QnvTZeFtbeosUzk1lBCXC9NkF/+c8vs76GNxhEuEy8ppZtYBIyo1cIW0SH26Dw==
X-Gm-Gg: AZuq6aKbYqUgv2mYGzked9OMkHcSGLOXca2bH7lKpYP7cJsf+hrjH/+Q8diECK7Rc5d
	P9x+FYrrOeu8/k03lx1nTry95IBSYXjHXtkjeXCpPqy9870WFv8KYd1khpXno+mViVidUnUPTCw
	cos6jydtOoLHMPvjUHTnwwyzdJm8iOMpKW4nWFwTzU5SVd5jzCOqGfn0E8I10V2KDGLL6E7Se6R
	W66a+EUP9hSw2bURZcNLSoAoEVjG0RGp0lYqZYaSwKvrxUuxGsjDZyfYneIjBLajBjgVJRMijLa
	PWLRSVyP3gzlnqa5ez4ZcSGNDiGWROJdIerQA1rCiaNVPyEuYJsepJcRQXsp5w+TTeKYeE5ZwdI
	zPSyh8JvVA0cr5PD3+FVeMp5bz42Kb254ZuvC06dZ7awRxqz8nSlcT2/7Own4HmKy+i2naDEoMm
	Ksn57h1Qh5g30AmnaMp2U64TKDRN7tGUQViJgwh3aQQmSv4nrgr+Ia5EXywg==
X-Received: by 2002:a05:6300:624b:b0:394:65e8:8726 with SMTP id adf61e73a8af0-39517b337ccmr5699318637.6.1771610030732;
        Fri, 20 Feb 2026 09:53:50 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:375b:ceee:9366:5d6:fd9d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70b71a7ba7sm74767a12.9.2026.02.20.09.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 09:53:50 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [PATCH] tree-diff: remove the usage of the_hash_algo global
Date: Fri, 20 Feb 2026 23:21:26 +0530
Message-ID: <20260220175331.1250726-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

emit_path() uses the global the_hash_algo even though a local repository is
already available via struct diff_options *opt.

Replace these uses with opt->repo->hash_algo. With no remaining reliance on
global states in this file, drop the dependency on 'environment.h' and remove
'#define USE_THE_REPOSITORY_VARIABLE'.

This follows earlier cleanups to introduce opt->repo in tree-diff.c [1][2].

[1]- https://lore.kernel.org/git/20180921155739.14407-21-pclouds@gmail.com/
[2]- https://lore.kernel.org/git/20260109213021.2546-2-l.s.r@web.de/

Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
---
 tree-diff.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index 631ea86812..2f5c956d02 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -2,7 +2,6 @@
  * Helper functions for tree diff generation
  */
 
-#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
@@ -11,7 +10,6 @@
 #include "hash.h"
 #include "tree.h"
 #include "tree-walk.h"
-#include "environment.h"
 #include "repository.h"
 #include "dir.h"
 
@@ -253,7 +251,7 @@ static void emit_path(struct combine_diff_path ***tail,
 
 		strbuf_add(base, path, pathlen);
 		p = combine_diff_path_new(base->buf, base->len, mode,
-					  oid ? oid : null_oid(the_hash_algo),
+					  oid ? oid : null_oid(opt->repo->hash_algo),
 					  nparent);
 		strbuf_setlen(base, old_baselen);
 
@@ -278,7 +276,7 @@ static void emit_path(struct combine_diff_path ***tail,
 				mode_i = tp[i].entry.mode;
 			}
 			else {
-				oid_i = null_oid(the_hash_algo);
+				oid_i = null_oid(opt->repo->hash_algo);
 				mode_i = 0;
 			}
 
-- 
2.53.0

