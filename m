Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795242636;
	b=AS2FOO/CRZno45R7AFg/eKduwfh8BxcQiJrMenftaS5bYr+j5icGbs8uSddeBFeBGAwq
	 wlNnN4rE+bGDsAROq7vy2G0AEMib0/JcRqeS8VTL9ZLd99Ko+3e56vU4NPlxxEKAly0/N
	 CFWPx5D2Ow/Dwwoj/NFo6kJTNqP4Bjb3Nl/wvpQhx59pVgewVN8FZMHQByxxLkki8Mmvr
	 NIuL/NK28CFUI9ODnnLxddBGmYepS1shw+wo8UGIiMcCR7YN1G0MyV6+dBOf15Qlt0U1H
	 hV37BcDLm2vNU6fqTD59ZToWVEjVxu9z500OeQI5pJgq/CpQXhuFoBKJt1G7o7Z9uDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795242636;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=xys1Q7QhXUEe/BtDvQvuqTOU9r2KwNZu13uJYged28w=;
	b=rVtzUTfzHCGIeL8qL7iZ+I+KwLz2Cu79Q21ShWtEXHrLi5JvBBOns4We16oXT/kpblqu
	 gdaoEzSc9mQc6k+Ri5QGwXXTMOp2jwtekPvB/hYJycGcIgwmkLjaVGIIAo26UgpoLNwEV
	 zVLlMfDyOQxtRHGzAF74ixTZMy+0o68W9TcF+ORH0kP3RpaZhYO/9sbgLu6NLBAshtAqX
	 DRWCV4iwkOLQmpg/oX+LlGApi9mqCxE1mKdPx+/Qa0jdz+YP/VQURElVcUPosWo49uLjl
	 UM1FIliArCUmiAqz6FAm/PpvCmlAQNjET2ddpTCXBB6pbN9YLtKRnWMxSVUvQQF8BVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r9Au95MM;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297DF606A33C
	for <git@vger.kernel.org>; Sat, 21 Nov 2026 06:30:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 297DF606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r9Au95MM
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1b244fb7fffso1656989c88.1
        for <git@vger.kernel.org>; Fri, 20 Nov 2026 22:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795242635; x=1795847435; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xys1Q7QhXUEe/BtDvQvuqTOU9r2KwNZu13uJYged28w=;
        b=r9Au95MM0tiOl3HD4oVJ2Y81xYWi8DWJPb2vooscpqeXf72ixNRTlXuIoRQD9gItUX
         f9zCNnDiFQ54FNwqUbtyjhXDLS/An+mK+69Q/9jPXogFXY4tUZQkWhHB0QcTDN/Nex1y
         Mx55FzmN/KQKP5o10CIZRr/O+DDGXGJb0dGx/ev/oADAVZ9CPweQUSFpqi2Isrec0+13
         WRT5F7DO3J6PMTQ6IIw89qghPbgu9CS/t/fCR1u6f0xAmxMTpMrL5yBTyZbdMW930L/g
         3XaPqSzCgZwscJhQHb+THAz92v86SsY4i/zN+E/xDZ2m+2i71IGe9CBNqX0DfM/KKjVR
         YFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795242635; x=1795847435;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xys1Q7QhXUEe/BtDvQvuqTOU9r2KwNZu13uJYged28w=;
        b=HWAs2ne7HwO5wtxh1U+EUEx8C1evOTvNGfFPWtptEBZQK/0/EnnQIBln6APLfIm4/n
         TMhSDoLn0VUhrf/eyBcxmdqEHou2qCYEXRUBA+W78OHJ8b0nAIzcjiTiYCKTZrGsm1gu
         THrJOmDpH5ajO4BEkXeHLURdsHaXDQrovCN/VrkjkjfEvXz8Iqnx/bKPem7n8A2n63vs
         rGwTuBIl4OnG0kYZPfgb6tsZdFSv+iz5hOeya/8XShXae0D2P9/UtZ3smR0//t4welk1
         DXDl3nwz9Hec/mMJ4jpoi2p1hFLQQms6j0RlpzNub/cQfEDV24YZNZbWJDHJwnhn0wSw
         mE5g==
X-Gm-Message-State: APuU4Z/S+lAq6Kr9YKCwtA2vzjVvDcWMrXw05Ah0FJj1vyXpOy5vXKJe
	br4fJBV3ag2j2/3xSCw0vSL9IDwBhKXC+k9ecNO2YiUmK7Wo3O1WaNt/55PJEA==
X-Gm-Gg: AZFdTZehucWG2sr8noJOJiZKhPa7ZnldAsaRZH71bH8B8HN+nAstrKvwHOcHqd3BSZm
	midbIBhbWQTdgodYIrw9Lzm/AO5bbi5y4/eXMUGD2iH5wAiuuzRAVEUhIHOzhSboKgClUPw7leY
	sUEw50O0OWLEJA8zUa+0Ro+xGcD/dYFWZ9RRreCyW9EVEhH1IeEOUuabTf2+YrvBTR8cyEKk9lL
	7oirCUl01Y4kD+7wQSxMVANmbFqYVNZI8/HJ0wVcWlX8mMNI79eET/OHXmbFwXatRYAoyYENkur
	cvp858WeXrdvZX0qPayEu8dsndbcMn9n1i32ibNNV+zy6rD5cRzhrf77wNrKEr5UE7TNJROso/z
	/pjq7OZeb1H59XjDYu5qj2M3vXjZGz/1gFDZg/UHVZua0AYJ2NQu093KVgd2iSi2ul/3+UVXhJ3
	bKYJ9KsB37wMT/t7fTsuKW6KOZdErfgiJGrdbeN03vKR4ttmwfp5C/eVfswa80k3C15FK1/6jNA
	uARixSVK1Zdc/2Vb4lUrA+3pQ05OxmM6LV/4/NI2C3dFtPZ2LChw/yrR939q/UeDIiAexvBThaR
	iYAvoerpu1tRp8Hpa5a24qoypHPXzC2R28BSaOjcvk93QAwPu0n3rL4=
X-Received: by 2002:a05:7022:e0b:b0:1a3:8d5f:6f93 with SMTP id a92af1059eb24-1b556882ac7mr8321802c88.17.1795242635087;
        Fri, 20 Nov 2026 22:30:35 -0800 (PST)
Received: from [127.0.0.1] ([172.182.194.209])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5567ffa8csm11608195c88.7.2026.11.20.22.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 22:30:34 -0800 (PST)
Message-Id: <pull.2317.git.1795242633923.gitgitgadget@gmail.com>
From: "Wonseok Oh via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 21 Nov 2026 06:30:33 +0000
Subject: [PATCH] sequencer: reset saved HEAD OID when picking onto an unborn
 branch
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Wonseok Oh <wonseok_oh@korea.ac.kr>,
    Wonseok Oh <marinelay7@gmail.com>

From: Wonseok Oh <marinelay7@gmail.com>

When picking multiple commits, "git cherry-pick" stores the current HEAD
in .git/sequencer/head for "--abort" to return to. If the branch is
unborn, repo_get_oid() fails and leaves the object ID uninitialized,
but sequencer_pick_revisions() saves it anyway instead of clearing it
to the null OID that sequencer_rollback() checks for to report
"cannot abort from a branch yet to be born".

As a result, "--abort" errors out with "Could not parse object" in my
master build, while in Debian's 2.47.3 build the uninitialized memory
happened to hold the last picked commit's OID and moved the new branch
there.

Clear the object ID to the null OID when HEAD cannot be resolved, and
add a test.

Signed-off-by: Wonseok Oh <marinelay7@gmail.com>
---
    sequencer: reset saved HEAD OID when picking onto an unborn branch

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2317%2Fmarinelay%2Fcherry-pick-unborn-abort-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2317/marinelay/cherry-pick-unborn-abort-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2317

 sequencer.c                     |  9 ++++++---
 t/t3510-cherry-pick-sequence.sh | 10 ++++++++++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 4a1c0e70b8..20bfe00ba3 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5788,9 +5788,12 @@ int sequencer_pick_revisions(struct repository *r,
 		goto out;
 	}
 
-	if (repo_get_oid(r, "HEAD", &oid) && (opts->action == REPLAY_REVERT)) {
-		res = error(_("can't revert as initial commit"));
-		goto out;
+	if (repo_get_oid(r, "HEAD", &oid)) {
+		if (opts->action == REPLAY_REVERT) {
+			res = error(_("can't revert as initial commit"));
+			goto out;
+		}
+		oidclr(&oid, r->hash_algo);
 	}
 
 	if (save_head(oid_to_hex(&oid))) {
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 9400ddfc45..75004bba0c 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -269,6 +269,16 @@ test_expect_success 'allow skipping commit but not abort for a new history' '
 	test_cmp expect advice
 '
 
+test_expect_success 'cannot abort a cherry-pick sequence on a new history' '
+	pristine_detach initial &&
+	git checkout --orphan new_disconnected_seq &&
+	git reset --hard &&
+	test_must_fail git cherry-pick base..anotherpick &&
+	test_must_fail git cherry-pick --abort 2>advice &&
+	test_grep "cannot abort from a branch yet to be born" advice &&
+	test_must_fail git rev-parse --verify HEAD
+'
+
 test_expect_success 'allow skipping stopped cherry-pick because of untracked file modifications' '
 	test_when_finished "rm unrelated" &&
 	pristine_detach initial &&

base-commit: e1ec09b23c8e0deb21a0b95ac5996422277395d4
-- 
gitgitgadget
