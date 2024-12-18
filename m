Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E75919A
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 00:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734480958; cv=none; b=GMK+ajrZvVx+zXgkKDuNzgv87pvNYv2BPiM+sos+l5E56/CesKGE7T5DUMi4ChvsEw9eV32+CBRO0GVZLyMcP0t906Mzsu6ghws6bdbRUICwNDfoPwL15ch8yyE2g/uW28JiR2+R/Ho4X0GHRiyoyVLpavTyUO6lgrI3ERxbnkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734480958; c=relaxed/simple;
	bh=3zWzNprWCTJVqFJl+O2E98J5LYIwqWVjC4kUJhW0Txs=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=AGwmZ8q/u9lFsO0RWS+kE5EkNoRwMk57paj4Kh6+78KO7AAE6bAYdYeLip8IcCPFvxinZcs2ZdqpxrR8WyuULicqVMY/nYwQ/e/R2lu7xSu5J8LULfoW7tdgKvhjgf1SNGTP3zTvZFNTAvvLJaid82r1e7JXNI68N+vv1ccTKIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CIHr3MuN; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIHr3MuN"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3862ca8e0bbso5014549f8f.0
        for <git@vger.kernel.org>; Tue, 17 Dec 2024 16:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734480954; x=1735085754; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=I78l/p+h8as+lBMb1Vy7qaaKAznf2iRhdl7I2MaeWg4=;
        b=CIHr3MuNbiL149YXzdxzOfH9wSCcRJ36Y9Y18TJu2kDVXL+ulY5XfZbAxnsVuOP1R0
         YWmsy82VcnUb5esHLjNz5duzzHKohOHu956By0dEzvuXvNz6egh/uF9RLppmpJ0KQjsq
         jlcNiYf2YUXunBqjxtjj2Njd1BSKXxCLpEf2ySc57b73LthJktN8qM34yh+UhVpSv/cX
         CqfEZf70s+WNT+lTo5Ro34fDL0TOMVqpEgBY0gtVsgSWzrjYVf2Wa5sA7lqrsQ+dsHWq
         6RhG7kSoCCc6ItdW/MdEsSk2vuSNKxAo9z4R3yOXJz7Er9If74pbBjWXgsa8c0BdX7I3
         DTHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734480954; x=1735085754;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I78l/p+h8as+lBMb1Vy7qaaKAznf2iRhdl7I2MaeWg4=;
        b=WrNumuzbnWFiW0jBunDK79W+JeIH15zqMtuU2xjL2RrzP48eFg3siuEqCkpRCtDNdh
         C7vFN7OGQbKRo6c0FW0efrY090g85J/bJVd32cgbe6c3PYc7vvWNnlUkkvFfQLoCxMXr
         jAF20ZzzK1cxCvQp0Ds0QzuLWPUrv+tp6mkCBpn2zBpV8M7x5ygUQ2TXbFV8qgkg9hbe
         OJPCL2Ma7prRZ3TzOE6o5y6RzsHOlmNVGIcK7n9rgHsjO2AMRo3yXNvM3JjOOqlXDKgi
         AnYTrXb5y9z2TqOjwAf1tEdf26lASh6+F6fNlCpNQQABUlmQ1oKex3fC0YHhTUBKbySw
         IM/g==
X-Gm-Message-State: AOJu0Yyh/rj1jFD6nYNCb/+8Mk5Udo8Ss6EH4pQRW+Hcd/70voEJZowS
	INtbz3ugdZgZUIjmgqb+i9fIVFqfGLaSCBi7FhtmeVNyMjrSop0+ojxi8Q==
X-Gm-Gg: ASbGncvybTbiOUzy3s4fp0v9GVZ01WnUXIPBVDL7bUO6aR785fAqc9VqJ/DAk/mbY3F
	bW4gd7RnAxlQzc+EEylMW+yOBDNvS2FT4/ggaFe4loi0SUalrgkj6bEo50oiaepS0u2Kw+tu8n1
	K2x9Qf6TOjrbVD3BJCqTTVmRiZw6BFpGsPIPft/3gd8aNXPhOOiagxUJtMoh+BSSd3qqtgpWKOW
	4UxSmTbDY1wvBGUDcc9NWInzG/TdxauAnRkk8767NEV0J0XZGC6a16KmQ==
X-Google-Smtp-Source: AGHT+IGQrEigq31GvR0frg/AP4b0o9da8Tc5MPE+RRuBkZI9U5CN8gaExkRG+o3exISfX1EExftP7g==
X-Received: by 2002:a5d:6d81:0:b0:385:e88a:7037 with SMTP id ffacd0b85a97d-388e4d6aa52mr510879f8f.6.1734480953582;
        Tue, 17 Dec 2024 16:15:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c801bb00sm12278895f8f.62.2024.12.17.16.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 16:15:53 -0800 (PST)
Message-Id: <pull.1843.git.git.1734480952423.gitgitgadget@gmail.com>
From: "AreaZR via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 18 Dec 2024 00:15:52 +0000
Subject: [PATCH] git: use signed counters when comparing with signed vars
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
Cc: AreaZR <gfunni234@gmail.com>,
    Seija Kijin <doremylover123@gmail.com>

From: Seija Kijin <doremylover123@gmail.com>

The compiler (at least LLVM) treats them better anyway
because of the C standard not defining signed overflow.

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    git: use signed counters when comparing with signed vars
    
    The compiler (at least LLVM) treats them better anyway because of the C
    standard not defining signed overflow.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1843%2FAreaZR%2Fone-more-time-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1843/AreaZR/one-more-time-v1
Pull-Request: https://github.com/git/git/pull/1843

 add-interactive.c | 2 +-
 bloom.c           | 2 +-
 git.c             | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 49042b30261..12c23fa10ba 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -848,7 +848,7 @@ static int get_untracked_files(struct repository *r,
 			       const struct pathspec *ps)
 {
 	struct dir_struct dir = { 0 };
-	size_t i;
+	int i;
 	struct strbuf buf = STRBUF_INIT;
 
 	if (repo_read_index(r) < 0)
diff --git a/bloom.c b/bloom.c
index c4286341059..42db509bea9 100644
--- a/bloom.c
+++ b/bloom.c
@@ -314,7 +314,7 @@ static int has_entries_with_high_bit(struct repository *r, struct tree *t)
 
 		init_tree_desc(&desc, &t->object.oid, t->buffer, t->size);
 		while (tree_entry(&desc, &entry)) {
-			size_t i;
+			int i;
 			for (i = 0; i < entry.pathlen; i++) {
 				if (entry.path[i] & 0x80) {
 					t->object.flags |= HIGH_BITS;
diff --git a/git.c b/git.c
index 46b3c740c5d..86f7112f4bf 100644
--- a/git.c
+++ b/git.c
@@ -946,7 +946,7 @@ int cmd_main(int argc, const char **argv)
 	 */
 	setup_path();
 
-	for (size_t i = 0; i < argc; i++)
+	for (int i = 0; i < argc; i++)
 		strvec_push(&args, argv[i]);
 
 	while (1) {

base-commit: 2ccc89b0c16c51561da90d21cfbb4b58cc877bf6
-- 
gitgitgadget
