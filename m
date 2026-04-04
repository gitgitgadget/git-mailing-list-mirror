Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E110634888F
	for <git@vger.kernel.org>; Sat,  4 Apr 2026 19:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775332222; cv=none; b=O4PbHy/dKvNk4yyvxYtIcLEkdJ21iNlM4yYXNQOZ8XKTpjtoC3KvwJqMXRgSYMMGDrOXLm62lU7QBsKvBK+avNRu7QrMffmLQ0FT0lo57fZZuShXRsEe2FW9b2Pmj+h8BUby8N98JqV6/T6hce0qUq3a2yJxdzkXiYKuP3hlTb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775332222; c=relaxed/simple;
	bh=dtncqUT7zDp/SpAEOWhVR9ivNLDtj9HO9Yn/da0pYmc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=acMPCleKBMlrsdKgf0oafZqo607uc7WzWKuOE8XsQb9jI1EtUPFRyC1BIZBKM7v3o3cZaWrP+oE6FvILlprBuJYL0058FCXINK5AXuHCTZl10j+idytlvACqbvX16MqjIEAnuobtI6h2ZuNry1VG+QnE04907gScSQifdjbhULI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qM7z2Yz1; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qM7z2Yz1"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8a23f802e0cso48300446d6.1
        for <git@vger.kernel.org>; Sat, 04 Apr 2026 12:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775332218; x=1775937018; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aB/n1bjwPf5DzQNdvwgWmbQWriYNdfNABq5Yc7hCd4A=;
        b=qM7z2Yz1NuM7OIFeSWP9iz9wcca5wSAUrUt3xT4LSRxERDwWr2/jxsCmTS1Us1ZmD3
         oWRW28v0RCMLBsj8IkF8PBcZKn4uNKFeQrZ5NhqbHpajwE4HHSAk0loZqMkaZSpKwSlu
         ECTpcIBOxNOpVpG8jVRLIl/U/WwtJ35tpUL55JUkgb6kDO1vfVkPLVv8xCHUE2xTYY7B
         VPlB1HrFcPDIYZiZfdx8dkECCAOVGPw2tmR4vUZ77ihLj2ooK4pq5f9BTmLoO+TqXmvo
         7Gwx1VCPq4O+UNteqyWeXI/zynkkwyAPIi4exYy05O0Mim4z/cO1VVge66tXQi41eYW5
         4Kjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775332218; x=1775937018;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aB/n1bjwPf5DzQNdvwgWmbQWriYNdfNABq5Yc7hCd4A=;
        b=p6jSFjt28nRnMO6rB43Hnqmg86UwYZjBqJ7UBK/sjXa12qpuudvDP2SF4PGPzqn8Sa
         6AN4LjfPwbufW8bYtgVjdlu0KpaiNuO6OyHDRboCGk2otEpvpzg1MFh7kicIueGcodqP
         mIBtd3gK5qlr8fS7/Du442O6BcOSn565CFZCSg7+8EmDg7JceoFGT+R12TFWjizoe1Ss
         dDS51LbXsAPAmDuHNc5avtcPmoEtDG3ajfHW0NKuajvb4e25+P8jt5HkC1yABTKEdtoI
         nd5DuEwNjrTHWUgwnSAAOyIQX8PgYCYMkZXLj5luJuZ5Us3xxubq+3tXW1SjVL6AFqXG
         SbUg==
X-Gm-Message-State: AOJu0YzgdwFhX0p93RqUuN6RJc6RISp8Hofj9BLVRevmbQQxnhl/0WSD
	NfhI3ZWQYTJgxnILrPL1TdJvkXzUKFNIV3yOEHuXjjcXJyXS4Qw6nI5tJ/LmUA==
X-Gm-Gg: AeBDiesrhfkAAiF/hJhW61vJOAcnGQWZ0rMBGQjw5bpQ41wVVbngWPMzYM9no3Hxi6y
	gZBMm9ShXvZcuJtfwSrdgWnL5BfEqPKYkaZ8tgK+TaVAQ5akC9X2NHw8uCMXvI5WNmc9bD4gHeo
	KAfYHJkv0CxyB+v6v4kLjbmVXbYhDb9JxNbFZRxCdLWYSNr91MWT2WVj1b1nOjI7MkBi+iJVfyH
	n5TqUuK2NNuAZcXBrUNrke0L8z7mJeT4wqMhY942m0Fi5HRvLVaPwHaBC40fuyV+bOGr+m9vP0p
	7S1CaA4BftDx9toNjLKuBWGygyo17FLPZLy/L8V9HaTquSwBgHpS6pUm1liTkEHrnUZyoErqh72
	wSToCUnfulhaNUuk8/mnkxyTg2gAJ2sYYl6sCGBxrFjfe668RndWzCZcn+0iP/wgAYeiIM8z4U4
	GqQbOn0bTp6ORVwp5jdExyPyBxdihM3eYzFmcVHw==
X-Received: by 2002:a05:6214:d09:b0:89c:dfa2:b348 with SMTP id 6a1803df08f44-8a7042f67bcmr136625206d6.39.1775332218590;
        Sat, 04 Apr 2026 12:50:18 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.121.197])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a596915794sm78560136d6.30.2026.04.04.12.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 12:50:18 -0700 (PDT)
Message-Id: <139b9da946e7adb1e4331bb5005e6481b2c2de20.1775332197.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2076.v2.git.1775332197.gitgitgadget@gmail.com>
References: <pull.2076.git.1775140403.gitgitgadget@gmail.com>
	<pull.2076.v2.git.1775332197.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 04 Apr 2026 19:49:57 +0000
Subject: [PATCH v2 17/17] git p4 clone --bare: need to be explicit about the
 gitdir
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When `safe.bareRepository` will change to be safe by default, bare
repositories won't be discovered by default anymore. To prepare for
this, `git p4` must be explicit about the gitdir when cloning into a
bare repository, and no longer rely on that implicit discovery.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-p4.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/git-p4.py b/git-p4.py
index c0ca7becaf..dd38dbca22 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -4360,6 +4360,7 @@ class P4Clone(P4Sync):
         init_cmd = ["git", "init"]
         if self.cloneBare:
             init_cmd.append("--bare")
+            os.environ["GIT_DIR"] = os.getcwd()
         retcode = subprocess.call(init_cmd)
         if retcode:
             raise subprocess.CalledProcessError(retcode, init_cmd)
-- 
gitgitgadget
