Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063BB36A004
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 21:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786655558; cv=none; b=uVE+zD4q17qqFZjaujOgutFjsWuzM7ogSTlHSriA6F1Vw2ex56U4T+tPQmtk6o4jD68RecyR+XnUGZRh2zsTR+VeFzro1EwTMIbsIokOA026eszgYpdBKtpwOKh5wpC46tCi7+RER56DQJV6o0eeStpR1QkdbKJF/e6v5ZSmU54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786655558; c=relaxed/simple;
	bh=dld4TDTAsBTiqaPOdeV7CfFlF3CxpgPfGsr6OKAp0co=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=dY5ptWLiTjrYW+JU+FQdB5CHAH/LBPevn2KV5Tpy0aSxiP3WgD7i+lzcRXPHypcKlCg+4YjDX0WtUvix59+yafM9yRJWY2jytpuU/EqfKvu3CFoVQT4GJgv5k0FqK1ypPWpEcyA0miEZRtjoOakYVJBX7unpgN5sMPh/5VJlrbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dmBguYLy; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmBguYLy"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-936cda0e3fbso29266585a.3
        for <git@vger.kernel.org>; Thu, 13 Aug 2026 14:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786655556; x=1787260356; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OM+tm+2NHaGMsmrFua+FXeB/HVODi/rKiOpHq0O/QrI=;
        b=dmBguYLyiLMXYwNntTxB5UE4kBM1FhBAm5e7tjniKwVig/4q1LuRA5auvLld0hz/ob
         57An8D6A/O+jV4F9LToL7718BabHkYvbsY2JZVJKbWo4aBNhc1rqvYJ9dnFLHiRagHlV
         vF6rF5HG4GCy3Wv+sYkb4uNpd6vCQSrq2SwVpGx60h4J/H2N6nqN59hTlp93oMwmWOPr
         /qS7k2MxfF/xrPYbLw7VJkid0Nx/l/RdntJ5//z9t9X1LBbk7WFpSDceQKKQj7c8LOS5
         j6etvf3MfDfht8iGv7/+ABhIVIC6iepGgcf8i6GiEnbEuA5sIEojChOWKnjB1AhUerGE
         2KNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786655556; x=1787260356;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OM+tm+2NHaGMsmrFua+FXeB/HVODi/rKiOpHq0O/QrI=;
        b=sjXJP5Sdg4YU5peL8I3TOuOoAkjAJoXBk8JiHj4C+9x0IlKgPmTJq9oCChHLS7goM1
         cGC1Hbqlsl8Tg45SDKuqmkYkdJ2tC0ncQMEySGqwzTpVJnzP3ydR8WniO69gtCjZkeFt
         NYhAFcaNlc3YCM1MoUXFDqH5ED329fJJqxJPvZV8qAj1Ck2ueBlshLDBQJbIMUpVsId+
         GcPv/+lLsesBj1kt2s8QzG456rl3xk29ONxupyB90G49vRScl5TtKLS7Ij7wRglEmkYS
         yyT/T96YEkoz+a3lYJb0YbP0kLYofn2mlr6/oDp8B3sUCHXQtOPFMNGHNAcUvnyFRNol
         nC8g==
X-Gm-Message-State: AOJu0YwcDsuYveJSQ3U2aNBeNjzk2ypz+aaYgDOJceL7UrsBIwO4yduV
	2sC3y8P+8kbYPBd2vMyCTruqoBA2JAQT+Lnn0zIjoyu6VjZMeud7TPI0UV/SJQ==
X-Gm-Gg: AR+sD10aHfceWHppmctty4DEKfkhyGNBnBWM/4+9Geqmfr2ez9acrX8yDV2Qjpgc6Qj
	KcCUGNg1oIt8RW6YUb+/Vsnbe+3Zq/mmRtmMh8BJE+b7kd9xeGxOdo9TLi6/ZATLq1oLVYYEqdy
	WpiXMQVb+yHoBdpNmN88FfMmAxprKxM/26sUOb7j9UjOGGJSDDiBtFkWrIgISsG8GZtI+SsDrQJ
	6WZ0X1AO5/TW6Ot9RYW8VECcuTWCGvZn209TqS6NynSHCqvdEj6+78m76fwD4N2/21UVFxLa5oa
	COoDWwq6PZmPkYileoKFHcA9t/RJ/K1Nnz3Jh7aLxcnc/6kuPujHWPXkzoSe1PMoweGoEvEmobR
	4ArijupXCcYHj0oAQn8VkNboP+RmpYVS5U4WqonqRiFWzRqS6CpI1l9CDuliS9oVOzgQ1Mlqh8v
	wrO0dJuhl4vi0jD+7BIBuW+X5dEMxZRRjPdhQwP7fDGb+N5FWKwqvssqqfO9mL489d6yej4KSFh
	z+kng==
X-Received: by 2002:a05:620a:2b4c:b0:936:9bc3:e10f with SMTP id af79cd13be357-936d1fd6c4dmr91993985a.5.1786655555929;
        Thu, 13 Aug 2026 14:12:35 -0700 (PDT)
Received: from [127.0.0.1] ([172.208.127.199])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936ce24564asm76680385a.40.2026.08.13.14.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 14:12:35 -0700 (PDT)
Message-Id: <pull.2204.git.1786655554197.gitgitgadget@gmail.com>
From: "Nikolaus Schuetz via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 13 Aug 2026 21:12:33 +0000
Subject: [PATCH] t1401: test symbolic-ref exit codes on a non-symbolic ref
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

git-symbolic-ref(1) documents that reading a name that is not a
symbolic ref exits with a non-zero status, and that --quiet does so
silently rather than printing a diagnostic.  This was not tested.

Check that querying a non-symbolic ref exits 128 with the usual
"is not a symbolic ref" message, and that --quiet instead exits 1
with no output.

Signed-off-by: Nikolaus Schuetz <nikolauspschuetz@gmail.com>
---
    t1401: test symbolic-ref exit codes on a non-symbolic ref
    
    git-symbolic-ref(1) documents that reading a name that is not a symbolic
    ref exits with a non-zero status, and that --quiet does so silently
    rather than printing a diagnostic. This exit-code contract was untested.
    
    This adds two tests: querying a non-symbolic ref exits 128 with the
    usual "is not a symbolic ref" message, and --quiet instead exits 1 with
    no output.
    
    Test-only; documents existing behaviour, in the spirit of 919eb8ace
    (t1402: check for refs ending with a dot).

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2204%2Fnikolauspschuetz%2Fns%2Ft1401-symbolic-ref-quiet-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2204/nikolauspschuetz/ns/t1401-symbolic-ref-quiet-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2204

 t/t1401-symbolic-ref.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/t1401-symbolic-ref.sh b/t/t1401-symbolic-ref.sh
index a2a7e94716..602db6d080 100755
--- a/t/t1401-symbolic-ref.sh
+++ b/t/t1401-symbolic-ref.sh
@@ -38,6 +38,16 @@ test_expect_success 'symbolic-ref refuses bare sha1' '
 
 reset_to_sane
 
+test_expect_success 'symbolic-ref reports a non-symbolic ref with exit code 128' '
+	test_expect_code 128 git symbolic-ref refs/heads/foo 2>err &&
+	test_grep "is not a symbolic ref" err
+'
+
+test_expect_success 'symbolic-ref -q is silent and exits 1 on a non-symbolic ref' '
+	test_expect_code 1 git symbolic-ref -q refs/heads/foo 2>err &&
+	test_must_be_empty err
+'
+
 test_expect_success 'HEAD cannot be removed' '
 	test_must_fail git symbolic-ref -d HEAD
 '

base-commit: 745601a9a94110d74769ab605ccd4f61339758d2
-- 
gitgitgadget
