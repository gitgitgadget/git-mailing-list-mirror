Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CB9374E48
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 20:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786653841; cv=none; b=DlYan9z4wtxnGtaNSsjpBrpOYi4sbeyubiX6qPXIK61tRSU2ZQMTYIbABR+kJyJhOVTlrKArfy6sQpk2FMMiwX5h5u5spf7VXrVxR3O9ZtGnDlLg5j9F1emzna84pVqquQbglNxY0zKksY4Vy6K8akbfvwNWqXgaHYB9pcdP05I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786653841; c=relaxed/simple;
	bh=ylohb7Y3GapoNOc+6xrUVm4p+xv9g8dbwhlzwH5M2YI=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=q/+pIJMH/LoTgJ10YX31BAfbL4PAw8g8thLd4iZHHZjyWrHyyiMIZDFlv/8l0G8wbC/c8UlgoPgAcQ4r5LwqGXdcnJqr8S1PegeL9kiePpLhoGAePnRnNjMFtewKnX9nWW/zrf6ul3EhHpYClC+QLEGF8C0lKor1pGKJXYwkHcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rGqOGdMh; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rGqOGdMh"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7e9f1f24cbcso243650a34.0
        for <git@vger.kernel.org>; Thu, 13 Aug 2026 13:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786653839; x=1787258639; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ewpIc1q6FnDc9FrNb1ibFnhkO2Wpj/TuxlR4glBXEBo=;
        b=rGqOGdMhJwWJ4FhkjoURHn0iGNQyQAMAWi0VMUm71jmJ5XblDu3uX50VJO3iNCRGV6
         O0xJAfRcCQDYFlWSENbAFeDA3Ejk8CtyU5iqZbPiii+WqoSi4Q7TtF8/wkaTigyqavMY
         ro60iz1k6ZmqX1qUXcJRicQUcR8151KO9FBeZc5sh/7StCpRq2PTcqwnTZCmdaqqOGSn
         AFzHw9qr3e3Hk/tGjvxjlBV/Oq9r//+be6Tov84B0+eQIBZG32Tp9rBjNBoE5B194xaF
         cDd4oV2x4L59ek5VwMGnMxKMcobTFlDlzFpax3tIWDcRx9IYIOaUjANesGKEg6y1ib5m
         FbEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786653839; x=1787258639;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ewpIc1q6FnDc9FrNb1ibFnhkO2Wpj/TuxlR4glBXEBo=;
        b=NSZNekUdyFzeOvzhfh2YZFEocUIEwzRcA3lIH3IXQGhkuY7oD2X/EfvIgSK1SDn/EQ
         mLXrROSVV7tWXfzcsDZla5NNrUdJECoPQ9GPPBwI0uENuguWpkMv47AGv/fMTrGXkXdR
         GpZpyBsdfn9CPcaOlO7UtOt0Qw3ek15xbYk4W/rEmF8BByMhJTMPGkEU7cUymG9HpAIs
         pu15tqoJ3S8fNIe7uOA2cPmHvDMlUzT420hIEwFd1QdbDtYB3uIeoaDriGP42QfRopZm
         Pwu7YvW9hFiWqT6UivvOvOxeeKwDxyC8OjTR11VSViKjtBsD5T0J+9m+pGHH3ghZiu28
         4mWA==
X-Gm-Message-State: AOJu0Yxst+WYZsn0E+RVS+WfVO7sQOrx2hoiOP7/W9EC5LWSBdUm8n8j
	ksLqtKykVc5Or2UGXAUFYf2f7DvfSOezV28qX+IviziqqU+PshVPebuTVGdiSA==
X-Gm-Gg: AR+sD12zL65+BynnPCXnqakFnYjtN9RVJxwZJqY1EowXwPtnuGDGk5Z4CgjRbZx6o/8
	IDBMbVIX+QUXVBfkuv4UjxD5n1AQLXq6SDAqjm256rP/ArS7Cn2TzSX8g9e9HiBl6hySKq0cWys
	VRXQEHE7C8oLGbfREL3/T86KvveSg90de3joZJ8HkBX1dp1rq7RDGAl90Cv+GLNy7yWYQURQGGf
	vP1pq0FWP2IBh9XOi1ya3PyZckEvYXYcdJoVHWU35LfP/eQ65zyMg2MArctITVuaIJTA4wWcF/o
	Y2LPjKeVCWe7VF5QKF3YFQF4lRJePvfLKrdbwThnajRY/HD7y2ywGjrL6ZWojFcrIGDdtdREu17
	yC2lgPn95FM75mZWjfeMiX3v4mcqLdmoPtG/uO4YnbPfPALPQIrzUfwR5uL6G45JX/uo/818qTj
	Y1Wkomq2qtJaQkG6auPx6t0rbzXRR8UzagzEmY2Ku69EXETMs0p7p43ihtRX+l6+kCRg==
X-Received: by 2002:a05:6830:67ef:b0:7db:a297:9e62 with SMTP id 46e09a7af769-7f3ca6b2621mr3580393a34.8.1786653838797;
        Thu, 13 Aug 2026 13:43:58 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.135.144])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f3c974c65esm3080225a34.0.2026.08.13.13.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 13:43:57 -0700 (PDT)
Message-Id: <pull.2203.git.1786653837190.gitgitgadget@gmail.com>
From: "Nikolaus Schuetz via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 13 Aug 2026 20:43:56 +0000
Subject: [PATCH] t1402: test forbidden characters in refnames
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
Cc: Nikolaus Schuetz <nikolauspschuetz@gmail.com>,
    Nikolaus Schuetz <nikolauspschuetz@gmail.com>

From: Nikolaus Schuetz <nikolauspschuetz@gmail.com>

git-check-ref-format(1) documents that a refname cannot contain a
space, tilde, caret, colon, question-mark, asterisk or open-bracket,
and that it cannot be the single character "@".  Of these, only "?"
was tested as a character embedded in an otherwise-valid refname;
"*" was checked only as a lone character or with --refspec-pattern.

Add the remaining forbidden characters in that embedded form, and
check that "@" alone is rejected even with --allow-onelevel -- where
"@" is otherwise a valid refname component, as "refs/@" confirms.

Signed-off-by: Nikolaus Schuetz <nikolauspschuetz@gmail.com>
---
    t1402: test forbidden characters in refnames
    
    git-check-ref-format(1) documents the characters that a refname may not
    contain (space, tilde, caret, colon, question-mark, asterisk,
    open-bracket) and the rule that it may not be the single character "@".
    t1402 only exercised a few of these directly.
    
    This adds the remaining forbidden characters in embedded form, and
    checks that "@" alone is rejected even with --allow-onelevel, where "@"
    is otherwise a valid refname component (as "refs/@" confirms).
    
    Test-only; documents existing behaviour, in the spirit of 919eb8ace
    (t1402: check for refs ending with a dot).

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2203%2Fnikolauspschuetz%2Fns%2Ft1402-forbidden-characters-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2203/nikolauspschuetz/ns/t1402-forbidden-characters-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2203

 t/t1402-check-ref-format.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t1402-check-ref-format.sh b/t/t1402-check-ref-format.sh
index cabc516ae9..bc1e878a0f 100755
--- a/t/t1402-check-ref-format.sh
+++ b/t/t1402-check-ref-format.sh
@@ -51,12 +51,20 @@ invalid_ref '.refs/foo'
 invalid_ref 'refs/heads/foo.'
 invalid_ref 'heads/foo..bar'
 invalid_ref 'heads/foo?bar'
+invalid_ref 'heads/foo~bar'
+invalid_ref 'heads/foo^bar'
+invalid_ref 'heads/foo:bar'
+invalid_ref 'heads/foo*bar'
+invalid_ref 'heads/foo[bar'
+invalid_ref 'heads/foo bar'
 valid_ref 'foo./bar'
 invalid_ref 'heads/foo.lock'
 invalid_ref 'heads///foo.lock'
 invalid_ref 'foo.lock/bar'
 invalid_ref 'foo.lock///bar'
 valid_ref 'heads/foo@bar'
+valid_ref 'refs/@'
+invalid_ref '@' --allow-onelevel
 invalid_ref 'heads/v@{ation'
 invalid_ref 'heads/foo\bar'
 invalid_ref "$(printf 'heads/foo\t')"

base-commit: 745601a9a94110d74769ab605ccd4f61339758d2
-- 
gitgitgadget
