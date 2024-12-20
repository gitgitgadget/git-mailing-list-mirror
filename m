Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DC8218EA2
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 16:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734711684; cv=none; b=L+uRKi7NYI6f5fiCqN5QCpflZ2uHB9Gza8ISbDeT8Gi9vUKCYfdM/8bpAzHWN3qYLSk321WSkuUPBDQL1WXMvpEf215CZdhNEqd1R7wTy+Yvwzm8rXv39U6DU8eh7uQf3rnij5TJIm+AvZBrTdxfz+dsxC94EI/mUPU+ta/RuP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734711684; c=relaxed/simple;
	bh=PMdw0FTFVG2iUoZMyeWr7FZupnaMUztTqBtsfXjAVNQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XlOb/t/sscWXc36zFjQJwT3LXyWvj0TaCAIDz26Hn1mG/mGgOr0pj93eIMfspsQZX+I7vfM3kNJLDGNIpoKVBh3/Es5hDh1Qf+cljuUO1VM58KobE9k0f7uDY2iQideb3v/N976EDsOmj5gzR4z0s1Vnga2Tr3OrIN1VJ68V65I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ts4Lkab5; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ts4Lkab5"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-436202dd7f6so22880835e9.0
        for <git@vger.kernel.org>; Fri, 20 Dec 2024 08:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734711681; x=1735316481; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/dK2I2TXW5iAu4adBn9RAI0BX8gzXE/7TFrMGsUREmg=;
        b=Ts4Lkab52VwYVy+dJDI7LG38Rkbvx2HcjAlU42ysayGBiVnGH5MjnHdvWy8oAev7qK
         Js6LBLDubQSy0T/S5aEi7vZMDRTapxvxj2qBUVL2dE8GwxKIvML9ib1ZI9S8j5E6iOgJ
         eFcJJiJ8Fg4jRXsnEEDEAcJhtrZQ5vpk69wYmuCZyd35iTnibZsWJTgThOccmqAuiYn0
         FQS9IFw03FVsO1ap9VuzyuOOeFWBZ6tcsMUkLoMvewjTzSKMVqx0XdhV5Okh+fG3VG5R
         MXY+8a787JjnAbnkO/RWhOF6Wt7lPKOv/RIosXEPLYrR14ReDKPV9zZxM0Z5x0lx0pJ4
         qdnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734711681; x=1735316481;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/dK2I2TXW5iAu4adBn9RAI0BX8gzXE/7TFrMGsUREmg=;
        b=vWgs8DQPg4vxa1t48RDg3zLl7K+TzUylS+LlzjhyxmFZHfErs3X3SKhaYIvJyI7iNI
         RNmxHWib+JR88yaOZ4LzGos7N53VzEa/etPop4/gQWdL65HGmg5HG0uzX7OAt4H9Vf7q
         S1kapui311tUQlJIz3pkrCjnU0NudK5UTPeVncl2iL6E/DPbW8NUXm6LOR4Rn8e8wrMp
         9pZ9VNukmQjh9gCJZDIatTRdj5TZD2YNfdnlSQ9hvg+cv65IKvpawSz852p8To74Utro
         g106j9jUV6K/2jIMnGwiKdsUnabaU5ZbzJpUnpkHGYEeGMmq8np0AtZpWes3k/UMF8gf
         joXQ==
X-Gm-Message-State: AOJu0Yw72AiflZ2f/e5uMA6z2aTKzQ0f++fw0FHE267bHkZRB82Uxlp4
	2gTT7O8qBt4/B1s4Cw5cxIMtQ75pMT1AY7fKSpyNz2VKUM6Of7b+JVZbmw==
X-Gm-Gg: ASbGnctRsNxUnQ4MMzmImPfYyJM69Lp/21sCHgALLCn9C5As2H197cShNQDo+neI4Pr
	PvSFw3ZmUkDhJ4JJGImz6XwMcSQ5AcVwIHHjGOVRrkJb/fVbJs9SwkGwd2P1SkRZwbSEkiizWGE
	NtSoM04kMfsMIHL0zQjWhXsdnBZY/MJFutggMt4ASeuELvz5jNdb6dBpxD2UcNMeqgXeBF/m3ZM
	Uuxj2FskjDhVlz5IO0klfqEfPtxjA0T68yje6GSdzosi6DvZSE90oumpw==
X-Google-Smtp-Source: AGHT+IEaJz97MINcCZbigBB0M98faj6sd7RgiUgkBbqdO7MJtLwaEMobsbDj4jQouTjI2yY+i9oz4g==
X-Received: by 2002:a5d:59ab:0:b0:385:fd31:ca31 with SMTP id ffacd0b85a97d-38a223fd39fmr4249467f8f.53.1734711680480;
        Fri, 20 Dec 2024 08:21:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8a636asm4505583f8f.88.2024.12.20.08.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 08:21:19 -0800 (PST)
Message-Id: <8ad2a5e79a25975394e5863f7a35293f1e2e5a44.1734711676.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1818.v4.git.1734711675.gitgitgadget@gmail.com>
References: <pull.1818.v3.git.1733514358.gitgitgadget@gmail.com>
	<pull.1818.v4.git.1734711675.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 20 Dec 2024 16:21:10 +0000
Subject: [PATCH v4 2/7] test-lib-functions: add test_cmp_sorted
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
Cc: gitster@pobox.com,
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    christian.couder@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    jonathantanmy@google.com,
    karthik nayak <karthik.188@gmail.com>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

This test helper will be helpful to reduce repeated logic in
t6601-path-walk.sh, but may be helpful elsewhere, too.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 t/test-lib-functions.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index fde9bf54fc3..16b70aebd60 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1267,6 +1267,16 @@ test_cmp () {
 	eval "$GIT_TEST_CMP" '"$@"'
 }
 
+# test_cmp_sorted runs test_cmp on sorted versions of the two
+# input files. Uses "$1.sorted" and "$2.sorted" as temp files.
+
+test_cmp_sorted () {
+	sort <"$1" >"$1.sorted" &&
+	sort <"$2" >"$2.sorted" &&
+	test_cmp "$1.sorted" "$2.sorted" &&
+	rm "$1.sorted" "$2.sorted"
+}
+
 # Check that the given config key has the expected value.
 #
 #    test_cmp_config [-C <dir>] <expected-value>
-- 
gitgitgadget

