Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308903375DC
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 17:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768584680; cv=none; b=nBDmSZZokRSQbXTGmyJjKmLq3ghKjrbSnpv9rmElix1L3bJXMtbWjiiepCrYyJVefneOGz42aopXj9gO1rVSCpViSJFC/huyseEJfYKuAry9XrRoVmpMN0oEQAdTOLKNEstjDLUbbY8wcH4J1/Ea1IQ66kJWiauYhxLU2Yx6WLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768584680; c=relaxed/simple;
	bh=9QjW1V3v+yI076ZGiLiDKFTd1Aedos37PmgjMyIwqu8=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=HN/QQvf+6VO1XRgcwe6QwzPiEfMoxxx590eB2q8glHaWcwpx7j8zznGlyjACSUxrP3lxVpnP1dojAhFZxAFGJAFezPb+PyhSx8e61wYeVQkv3Si30lz7umQcgyJPF310DfDT56YlZo4tbJdcMWHzP9P26gqqbfO/+6Iei9GUx/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FBdiRzbJ; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBdiRzbJ"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-661097640a8so1019955eaf.2
        for <git@vger.kernel.org>; Fri, 16 Jan 2026 09:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768584678; x=1769189478; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZCpMs+p/9kyh7yXZAOZQxH9SR2DFidQTM+wfgzLuw58=;
        b=FBdiRzbJX/L/Hn6Y+ny9M9MagPYtwR2jH/SwJHRuS/G5ZQ7PjPSBfUg8GG2UZgM3FI
         Lz1HF8lqaQlSTPxVaTPrhM2O+IkMsvHtPhqtpi+Dup/TpjBaJrGc2MMdMynLw4caFHJL
         yYDA0268W3o/IpZ0xCHs/+XJuCdKfI9/kYa3w4aEmc2SUp2HX0RNP2kUBlL/a8+kHNTN
         hiYJiTkGLG9lZ43PM/Mie2XMUwBmqHK0NmwBKJ1itdbwjTPM/TtL6jDkzFKBsJRmsVh8
         TwlSan6EsvbZIzsWYkgH7ND5W+nG/P4SNciN4nQMM3U36Jow5bqKZVPWDsVAM0yt7kqB
         ELIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768584678; x=1769189478;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZCpMs+p/9kyh7yXZAOZQxH9SR2DFidQTM+wfgzLuw58=;
        b=Yu+Vf3jutlApdjguovOKKf5me7SBQ6aOpq/V0njmxlid+dqFUibmLyd3M9rQOXC909
         W6FrWGcFK5ftVSNdWYwzf2mMfquLtlHzJDCBPEN+LADLt2RWj8DHxKK4NEEvFedZsb0q
         Ww/0d5NqCHozufYPLf3U5aPg5BiG/DEu0VZV4NRDDVVD1Mf0e1wjwcVC+FXnCryemMDA
         cglrWiBfIb88QWF3GeUdrAGtzmXvXepZGo2533SIFw2SrovHnAOICadIwjyUX1lpj+36
         U0BbGbkiqqhs5wzUgOIrge9KhKAfcnmmOiOMi8JdM4EKusENdKceD2lE/3QspP+QoOXL
         NFCw==
X-Gm-Message-State: AOJu0YzUby0oFCjXRSK/bsDvgmLSNLJJvWZGOWRhL0szXOhC7Wbp3lpo
	QXED4smuEwXVgunLbW9vLca3vu2tQsT1TqPC46gHZ6XJ/oSOjnmw0kvao+e0rQ==
X-Gm-Gg: AY/fxX7V791EXufYcCVKc1BDSuHC9WXpsT8xunvQB/2Yb1/bUzqPLFLkVI9sNgXwtf/
	tTilIgqIUjKUGftnrKHDRjAsC3X6OHkUYibj8sU2vfFAurkEDWeQ5rqyPhZEJBxsLYallVWlktL
	4QDr7pUaaocbQkP5g4AG+AT/OZcdZn7F2mFKjWzOIRnlAOJpnDeOQmjE01mPw0w6aTjxC9lxmFz
	kv0Cd+rz5e1oA2sO9prrPMnlwWf8m+yTxKlR5WBY1NiN5edq5C0+ad2tSBfvDZOvfcVKFJatSDQ
	bNxSagHbfzrlViDQjqVklRhQ58z+3fKOLPxFkabyOGoi63/HNhR88+6s1zZoV+xVDsDFWgA5U0H
	UgqnTnvdi7v6CIkHNK5cqAhb5+hEp/fVH8Kv3XsMxKKRwcvElZI6LhFm65zCZa7JdQzaZT4c7qS
	47sOdILt1OKThIqA==
X-Received: by 2002:a05:6820:813:b0:65f:5bc2:844d with SMTP id 006d021491bc7-661179cee7emr1602869eaf.62.1768584677810;
        Fri, 16 Jan 2026 09:31:17 -0800 (PST)
Received: from [127.0.0.1] ([172.212.163.17])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-66289e3af7dsm207467eaf.14.2026.01.16.09.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 09:31:17 -0800 (PST)
Message-Id: <pull.2031.git.1768584676520.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 16 Jan 2026 17:31:16 +0000
Subject: [PATCH] ci(*-leaks): skip the git-svn tests to save time
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

I noticed recently that the leak-checking jobs still take a lot of time,
and upon analysis, the git-svn tests contribute significantly to this.

Analyzing a recent CI run, I saw that the Git test suite contains
1,017 tests, running for approximately 5¼ hours total. Of these, 65
git-svn-related tests (~6% of test count) took 42.24 minutes combined,
accounting for ~13.% of the total runtime. This implies that the git-svn
tests are roughly twice as expernsive compared to the other tests.

However, testing git-svn in the leak-checking jobs provides minimal
value: git-svn is implemented as a Perl script, and leak checking only
handles C code. While git-svn does call into Git's built-in commands
that are implemented in C, these are standard Git operations that are
already thoroughly exercised elsewhere in the test suite. Therefore,
running the git-svn tests in the leak-checking jobs only adds to the
overall run time with little value in return.

Given that the leak-checking jobs are particularly time-intensive and
these 42+ minutes of SVN tests per job provide no additional leak
detection value, skip them in the *-leaks jobs to reduce CI runtime.

Assisted-by: Claude Sonnet 4.5
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    ci(*-leaks): skip the git-svn tests to save time
    
    I leaned heavily on AI to implement this patch, in particular when
    analyzing the logs. That's why I added that trailer talking about Claude
    Sonnet. If this is undesirable, please let me know.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2031%2Fdscho%2Fskip-svn-and-leak-tests-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2031/dscho/skip-svn-and-leak-tests-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2031

 ci/lib.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ci/lib.sh b/ci/lib.sh
index f561884d40..a165c7f268 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -356,6 +356,7 @@ linux-musl-meson)
 	;;
 linux-leaks|linux-reftable-leaks)
 	export SANITIZE=leak
+	export NO_SVN_TESTS=LetsSaveSomeTime
 	;;
 linux-asan-ubsan)
 	export SANITIZE=address,undefined

base-commit: 7264e61d87e58b9d0f5e6424c47c11e9657dfb75
-- 
gitgitgadget
