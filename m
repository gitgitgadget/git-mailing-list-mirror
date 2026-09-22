Received: from mail-qk2-f42.google.com (mail-qk2-f42.google.com [74.125.230.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4B048EC85
	for <git@vger.kernel.org>; Tue, 22 Sep 2026 23:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790118377; cv=none; b=O2DFq3vsaeJHVc6W541iiVUJ7oI5s9GGz+Q9igpGlayamPB/lO+YblElEJYz+7IAgJy73mNvD0MdOyAvoDHMIpssa97cmp468N77uIgxzz16EvlbQjPnxWAc55nvnc4rx6wWdlbQjUWgjfjev9DhLuakaJHMzCWToPyZDqmNoMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790118377; c=relaxed/simple;
	bh=+C5omdJnFyRwDl4Ks+7bw9LiL7YaYeLbRT+hX++27yw=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Pd7y9NogZ0xY96UdXkmsXJ6YcefYDGCWdLviE3FB5rFTBeKMj8lDvTqnBsla95gT7epa0X+UbQft57lcnLCRV+cv3yJucNmtL0LXt6n91gUPOHmfl0hq4O4rgDkTjFnRqmqj49enJAfg1IaOVnoqWrSMoHQNSGTghc6bognh+Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDikOQh+; arc=none smtp.client-ip=74.125.230.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDikOQh+"
Received: by mail-qk2-f42.google.com with SMTP id af79cd13be357-93be29bb454so60273985a.1
        for <git@vger.kernel.org>; Tue, 22 Sep 2026 16:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790118375; x=1790723175; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=83vTg47ybMWvqpDccQK+QlEN35WRZWDqgRK5GmYeTmY=;
        b=GDikOQh+2BOdufJhQpOAIx1owaLw9jkE0pydbYkRqv4sIEHN+c3rFHybTyFf9/YIEc
         3G6PNn5l7tRfqfaEOHxHrtpfz3n6w6+sluZyR425bYBLoTJ1jSnwGUMIrwaN1zDhJ4JR
         TH2G43US66lZ8CDIpoofShirUUaRnhYE6bnL+1H5KFpKY7g8sbU0RwbZSQD9qbA+eGEP
         GmxWgjbP91KB4HUQ8Bo6C0r2PGHZC/13volDVDy2xTcDeRdWOuMUR5Jvq3Xnog5bOvek
         Tb6xZflUOwKZys/m8V1jguxXsBssQV4g+Hfkj+QB0XXcS5wOiES8Czs3WNt0n5YIJGfI
         khow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790118375; x=1790723175;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=83vTg47ybMWvqpDccQK+QlEN35WRZWDqgRK5GmYeTmY=;
        b=ky3x2LuFZZprf3MqiBcWQK+joopNpjpFQw2QGw4x/9IDj+Pfufp1S4TA5UOeMXCk9A
         9YcjtGrT/4iWuK/d2NybD9N1GxTHtHMatGJlTCMRPWvYpDCydd3rfTuRHhEw4zmw4V4a
         SabnC4rMYDIL+xCKIHzR5fE0WjuC8IzmWsMg17ZzQrq39UnO17j1jz/0JzAkkk/Y2Xfn
         BUpYzVKuQ0p/P/SMQGz2jcN5JKUx+Y3npHnuCmhxFYx7Krf5ITDiC+DbeT4635MLYex0
         sj2daUbPPIvwjGDPvT8LTvOeEb0mSk3fsK/k66C1izDIJ99EM0f/3oKg3ZGzsiSrs4As
         TSUg==
X-Gm-Message-State: AFuF++nNHlljaqL9BleNSJpDoZPKlwFXYp28b4Mj06bCNTZ/KE/KDEQN
	Tx8eEJW2QjD7kb4Kkg9C6gBXk7jp7Vj5wmU56QHSpfeGi0oe63VNmxAnBjrv4Q==
X-Gm-Gg: AYBFou3AhHyzzqoMOGHBbrdT2srn1229zD8SBH2edhogrAH1SV7EOMRtIGfckQN1RS9
	xPkc0qA7fCmhz79pquJDkYeUkQ7U/bZfiFbLAJox+hmIOzneL3A0jYmyv7i9Vhrvu+SaSIaBzRi
	cRZjTwomtIINk1Z+uM4ffaEj9FaI2Wc9W1wrBRiQl6L885WUqLUnQntH7i0iXVAX3eFcjrHzHQC
	cMnSbISUQAWd++IKdM6uwm3vFTEuw2FFoOQnU1r4poW2ytduLfTnTo+iEKCSwccKDunIjm2D9ZF
	GjQYVVmbTjaiVkx1s3pGp3/Hc5skcwpngdndDjxRKwVMWqTl4aAUIzFIVpyXzour6vlopgm+kO1
	3ukrgO8BM5hMp6ZSlEriFegkoIq/Uc1/KhmjLOe5z9lYocFhYRgnBUp82hnnO11qSVBy+K+a+VB
	ECPhAiJ3xcDC5XSNn2+vcWCE5QUWYqg3PazkoXeEt9IQSdbDA8qb1B6j6HA40AU14caF72LtcMc
	mjB
X-Received: by 2002:a05:620a:40d5:b0:93c:73a:3996 with SMTP id af79cd13be357-93c2521be32mr141221485a.57.1790118374998;
        Tue, 22 Sep 2026 16:06:14 -0700 (PDT)
Received: from [127.0.0.1] ([172.178.119.115])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c248dbf4asm87189785a.44.2026.09.22.16.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 16:06:13 -0700 (PDT)
Message-Id: <pull.2236.git.1790118373340.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 22 Sep 2026 23:06:13 +0000
Subject: [PATCH] ci: work around Debian 12's HTTP/2 authentication failures
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

Since 00fa8502354 (ci: bump debian-11 job to debian-12, 2026-09-05), the
`debian-12` job has intermittently failed t5559's half-auth clone with:

  curl 92 Stream error in the HTTP/2 framing layer

Anonymous discovery succeeds, but the upload-pack POST requires
authentication. Apache can return an early 401 and close the HTTP/2
stream before libcurl finishes sending the request body. Debian 12's
curl 7.88.1 treats that closure as a transport error instead of allowing
an authentication retry. Curl fixed this handling in 331b89a319d0
(http2: polish things around POST), included in 8.3.0:
https://github.com/curl/curl/pull/11756

This did not happen before switching to Debian 12 because Debian 11
ships with libcurl 7.74.0-1.3+deb11u16, which does not have that bug.

Replacing the packaged libcurl with a modern build would defeat this
job's purpose of testing older supported distributions. So let's simply
exclude the flaky t5559.15 and its dependent t5559.16 on Debian 12 until
the packaged curl carries the fix (or until the end of time, whichever
comes first).

Assisted-by: GPT-6 Astra
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    ci: work around Debian 12's HTTP/2 authentication failures
    
    While this is a regression in v2.56, it does not affect production code,
    it's just working around a flaky test. In other words: This patch does
    not need to be fast-tracked into v2.56.0, but it would be good to get it
    into master pretty soon after that, to reduce developer friction.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2236%2Fdscho%2Fwork-around-debian-curl-stream-error-92-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2236/dscho/work-around-debian-curl-stream-error-92-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2236

 ci/lib.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/ci/lib.sh b/ci/lib.sh
index c6ccbf8c17..1cf31b5a2c 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -334,6 +334,12 @@ pull_request,*|push,*next*|push,*master*|push,*main*|push,*maint*)
 esac
 
 case "$distro" in
+debian-12)
+	# Debian 12's curl 7.88.1 mishandles early HTTP/2 responses; see
+	# https://github.com/curl/curl/pull/11756. Skip the half-auth
+	# clone and its dependent fetch until Debian has the fix.
+	export GIT_SKIP_TESTS="$GIT_SKIP_TESTS t5559.15 t5559.16"
+	;;
 ubuntu-*)
 	# Python 2 is end of life, and Ubuntu 23.04 and newer don't actually
 	# have it anymore. We thus only test with Python 2 on older LTS

base-commit: 3bc0341126508f78f5869cbfc0005e987efdf0c7
-- 
gitgitgadget
