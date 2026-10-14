Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2317152E073
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 13:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791985524; cv=none; b=YXpYdXUqnar5viba0VXfC+Ss1jHmVtAyhg+fQOrwbZXJmWl7s/VYlP1N/Yeb5qrj7VU8nUD+v38AlaqPdCqkhG1Y7b8m2bK/pKQeHBkL2cPtR3CCLcNRK+8skvxi88ymQtJ5Y6FO7COzy2WEMeTxJSO4LNfFNer03eqy0tu31L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791985524; c=relaxed/simple;
	bh=3wu3hDEXjhaONGba9jjcYQK11hcN3zua3siOdSJ4oLE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C0M/MvyIj0wHBYd+WTJe3WOnO2Dh8oxUkvxvv6O3XcYz7asIL2hDOPQl+V0WaY6eZajgxydYvmN4BeQk0nXNf+hUO0WniudYbKDGo2ew02VlR+8zHlK4lGVh8NXQ5i1sR6toyL+hDloIhMjdWVlb1JAqjWQctP8hpyePaNyHfAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=POOYoa4X; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POOYoa4X"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a01933b584so36474395e9.0
        for <git@vger.kernel.org>; Wed, 14 Oct 2026 06:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791985521; x=1792590321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SPr6+F+nDp2vD7N6F+VoJDH4AMsF+rElpWLwkAn4xk4=;
        b=POOYoa4XUKBwE77rAWpHlp2Yv9eOFC54Ay5uQ9aZm9o4pC2yUvOfyjKkrTOhPyKRej
         j+lYuu3/GbjbwRm92O66ixv7GeBZMVSZPOGxdeU/N060Kj9671/2CK1P0XP6TF83p4iH
         Ttt2dm1OId5uCSZyiia4tN/lh2XkYuuKfG0ZmixEhDNZjl9E4hqkT4BpoFgH1z3gfcS3
         Ad1VaGfgaHJXWglWAua74fVnlIJbhxC4Yp2yLsTWrPUQJ3KdCPdD3IuFBoGvSMIddrTU
         kMecxgEaTUleTdCN3ecckiMawyUWjTZCFTogoi3pQr+lyIEXAxdgWAjttLbmzfvuTAK1
         gzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791985521; x=1792590321;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SPr6+F+nDp2vD7N6F+VoJDH4AMsF+rElpWLwkAn4xk4=;
        b=2p3nwHwOPDVcEJ5YxfErhvJZsrdk0uaIKL58dUuzQH2fH88FBQ4xhkirAFptM1w7Rc
         5Ckkul+zbGgpCM8qvZ+z7iWYaANtyNuOh+yFE7YyXvluAHBaO8GJwrdBZ3C5Ogla1wxS
         wgYVQBHb4KEVgz4h0KLu8RfYML1aogc3wz9Rrzlmav9yDx/HiZpyRUp8UVycnSVEfet8
         0tozmwJjeklazTPJjaeE0Q93GfMYiE/R7XZVfqzffrBow18dVOOYuukp9dbuaGwbLu3E
         S2355vagYSSQCUXcNbnQYqq1lNkZoEqv5yH0LZkAhocw/3UlhIrjGN7VIEEYC90TCY4P
         eSjA==
X-Gm-Message-State: AFq9FYK+xm/HqnNqn2ZDgJpUo7DOxCvj04LB/eNFDVpsi/6qd3P7EyLw
	S+GgRXBrKjpNmRK9oP5sQmYqSq/Mox5uDEPm2OyL2P369Lqh6r39VmHkbljjCQ==
X-Gm-Gg: AYBFou3KE9gbvz67gGEAPqUxPwGbTyspmZnIEPjsrvYL9PuqDJ+deGOVvy+dMrW7qNP
	K0e0jd6tOEUfRy8QPM/EO/PxI70CM1xadr3E8jzvx1tV1wzaotJDnM1+4FXtzf6JGz3kSdF7uEz
	bUdEohoO9MB1cASqn4de1GC48tg9E6q36AbBoWROPZ2QDy3AXhSBtgsK4cmXPHSf2kaEUuEJinV
	vo/yzlhEp69WRKJdOA7O6qml4Fi6fY3Z884K+Wonp/032cjohhFCrU+tHMn9QHyVROYlWrKo4mf
	L1KG+xeeerBaAu1meuteS65RQW7jaWdVSMICwoIKEnbaaTqSVJIwWqRA57robrE2LC+GrGakHW4
	DzpTDA93oJVett0ph96nKWMdDdJai8oweJdI+xTy5jSwYBLvHBWtTbW9DR3H1mz3wHsJKXlItz9
	qWtbBHEqDuimSPDbIcw5/uwo7mVgtqdHTBmP4aFNdY/erflS+pgRSzp33xStcH30fWClBAlM9S+
	8MMBNHpGEJTdNF00okSk5T/cAj9OXJziBw3HEeL1tXz
X-Received: by 2002:a05:600c:548c:b0:4a1:a7f8:c11f with SMTP id 5b1f17b1804b1-4a1a7f8c1cfmr120952705e9.9.1791985520605;
        Wed, 14 Oct 2026 06:45:20 -0700 (PDT)
Received: from Stealth.zuku.co.ke ([197.237.143.156])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de7003982sm9334303f8f.8.2026.10.14.06.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 06:45:20 -0700 (PDT)
From: Dorine Tipo <dorine.a.tipo@gmail.com>
To: git@vger.kernel.org
Cc: kaartic.sivaraam@gmail.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	usmanakinyemi202@gmail.com,
	Dorine Tipo <dorine.a.tipo@gmail.com>
Subject: [Outreachy PATCH 0/2] t0410: fix exit code and hash assumptions in the missing-tree test
Date: Wed, 14 Oct 2026 16:45:02 +0300
Message-Id: <20261014134504.1152225-1-dorine.a.tipo@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series cleans up the 'rev-list stops traversal at missing and
promised tree' test in t0410:

 - Patch 1 replaces the 'git ls-tree | grep | head | cut' pipeline that
   finds the OID of a_dir with 'git rev-parse HEAD:a_dir'. The pipeline
   drops git's exit code, and its cut assumes a SHA-1 length, so it
   yields an abbreviated OID under SHA-256.

 - Patch 2 stores the output of 'git rev-parse' in variables before
   passing it to test_grep, so a failure in git stops the && chain.

I ran the full test suite with both SHA-1 and SHA-256, and it passes.

There are more places in t0410 that pass "$(git ...)" directly as an
argument. If this approach looks good, I'm happy to convert the rest
in a follow-up.

This is my microproject for Outreachy.

Dorine Tipo (2):
  t0410: use rev-parse to get the subtree OID
  t0410: keep git's exit code in test_grep calls

 t/t0410-partial-clone.sh | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

-- 
2.34.1

