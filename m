Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968CE218821
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 02:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782785067; cv=none; b=MQCleKBHBiIUwHxKE3SvxnNG+9ZztSCOtMV4doHAaiFvs4Y/8yuxjZL26UplTS42+40cAyAn2Bcc4+ZBBOYIx7XXfV2OxNdRZ8wnfbjdTaTT18jv2kovzW5V57qHrxTL0auUeQ1lIcBLdfopBYRZUtGKRgWtBGhYmHCqH8fVI7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782785067; c=relaxed/simple;
	bh=94BD/oZi9in+NE9TUC/DsRv/RnwbPptg3VCb5iDhtCo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LkAL/Ey1gwPS52LJk71VKpinrO+yEMDjtzdKQGPpH2izDEFShbz5LgH4TmqupWW9yCF6ZrYc0LgyosxUdo8LYGMRK8v+1zWhFOmXbRTJgWAUG7tZYUZs1M98IUwH0J4EyFtJ9yR0ucaAd9s8sv2uZZ0HNdwZLY82TrepsLo6g2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=tgmMCVuj; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="tgmMCVuj"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-30bf132969bso5739516eec.0
        for <git@vger.kernel.org>; Mon, 29 Jun 2026 19:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1782785063; x=1783389863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7hTQbvCBT75k3SpMu8Q1lHxbYaAl9lsGFT1xwAzBvjk=;
        b=tgmMCVujC+YFmWwXe5V2Q50r+DrbVjnpUMeqxaSW++g1dw9FnCFdJXrQn+gJZgeuFO
         CqqsFjlv2ykO13OEn1WlOjX2Q5xTVIz4gCwtIJ+YaQ1kR/UlZwpyF655AV6RpbeX0i+8
         OVuC/J+n10bbDGV2myrVsBk7u1MVTc4P7OJtQnbsWLEsd2r/+oEzfWWEnnZgfTHMPFba
         b0FGEkVDrKnTUlmtPp+FQSXgtNmfWBeCmKzz0TowVq7yDJKXVi+Z5jo5GVjUvKs350A4
         UhIA42M6IBY14ZRF22S05UeziHZ7A/kcccpOf27ylNKavU1JoUK4tZFSojKnZ6RS+EnR
         YpgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782785063; x=1783389863;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7hTQbvCBT75k3SpMu8Q1lHxbYaAl9lsGFT1xwAzBvjk=;
        b=l5qXexBrfElZQSz9zwxI85hIMLcYywQWMCRu/N/CLJgF4qpTkV7q06ECgXH/OpBQmN
         W4/PKnB3DU+Q3l8Faj65cQNWqUEtcCFVBaZT32V0ojxHOnQxddJftt4RYs2z94hUHGua
         Fh1Yp0Zl+VbIhYmckmw0O7fNet0qs+4/hGTTMFJ/PdSjxHcmCAiFGE6EA0vomf+mM6ow
         R9BRIwCkkdjraVu9ortKAXeA/ddqmvn++B7yjQPaklDdTjOZMb58OgVXGkwZ/tQbZhUp
         k1PgfDfWsK2Don/s5hut3D2oJ2PdFEYgmCYPlwo6WFEh74i3Jh78Xzt3WDhIU3mSBcJz
         83KQ==
X-Gm-Message-State: AOJu0YzunN11Mahr9nnWB6BythsRrAkigPKHJL/H/MAKqt4kLxHA+pC6
	OWh8LoFGQ0ZazdjqH1LQc5v1FYQbDIEUVM/lxgEQkvsqZjOswD+JKJdSciTwC+qA4rxWUa7UBJp
	QIgjO+riWRdZH
X-Gm-Gg: AfdE7ckpCehxkfJ6nSnRlhDgQ0LHxG+fcHlPTla0cuHET988zchzDL8yX8K7VsI5noo
	6saDHzpS2LXb7qxESg4Q/UoZ63wkuwQKPZhvaaDsyx0Iq5raEvE8Manm1S+UyEbguJ6Vi0onNMn
	E4hT9DU9iR9Wm9+uoQnPof2FizOApp4/ZM0YBTLuLHAtL1m6dTOHyIgCsGrykGC7VVdRV9QVysJ
	4meraq7gypM4sBqOs/1tzqXRjIeDY+vNm+A7URElZg7IThbeucAB1zTVPikM7DHKjMuMd/wv9HM
	BsaiJcXCPh5MjSMfWZ9t618BA2KJkP5r/MqxGvkN2GUpOmMhuzgYTWZ3qAHUE+x7XOq7zv1958v
	Ze6M43yIQzpkctbtOpQej3Z/iWh39SY5R21LRH/FLaoGJtJbF4XNVB9DUj2cKcubZDqRKC+v7yg
	rUrthwuBGTBh5nTwEJmKrpQxihDuB3z0QrMU5abeIvbRwe245gN9Un2wW9e0ZAeVRQZZKjhXvNi
	vzshdpTbSE206bhI5/vUtdaMUGNg4sgTybjGBBa8jdewmBm0CYlKw==
X-Received: by 2002:a05:7300:8b2c:b0:30c:536e:3a87 with SMTP id 5a478bee46e88-30ee12c01bemr1126165eec.3.1782785063482;
        Mon, 29 Jun 2026 19:04:23 -0700 (PDT)
Received: from wolf-skin.semfio.usp.br ([143.107.37.129])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee2fc21casm2289257eec.10.2026.06.29.19.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 19:04:22 -0700 (PDT)
From: "Bryan B. Lima" <bblima@usp.br>
To: git@vger.kernel.org
Cc: bblima@usp.br,
	gustavoscorrea@usp.br,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] submodule absorbgitdirs tests: use test_* helper functions
Date: Mon, 29 Jun 2026 23:02:20 -0300
Message-ID: <20260630020220.1559190-1-bblima@usp.br>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use modern helper functions from test-lib-functions.sh to provide nice error messages.

Signed-off-by: Bryan B. Lima <bblima@usp.br>
Co-authored-by: Gustavo S. Correa <gustavoscorrea@usp.br>
Signed-off-by: Gustavo S. Correa <gustavoscorrea@usp.br>
---
 t/t7412-submodule-absorbgitdirs.sh | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/t/t7412-submodule-absorbgitdirs.sh b/t/t7412-submodule-absorbgitdirs.sh
index 0490499573..bd1c684480 100755
--- a/t/t7412-submodule-absorbgitdirs.sh
+++ b/t/t7412-submodule-absorbgitdirs.sh
@@ -34,8 +34,8 @@ test_expect_success 'absorb the git dir' '
 	git submodule absorbgitdirs 2>actual &&
 	test_cmp expect actual &&
 	git fsck &&
-	test -f sub1/.git &&
-	test -d .git/modules/sub1 &&
+	test_path_is_file sub1/.git &&
+	test_path_is_dir .git/modules/sub1 &&
 	git status >actual.1 &&
 	git -C sub1 rev-parse HEAD >actual.2 &&
 	test_cmp expect.1 actual.1 &&
@@ -47,9 +47,9 @@ test_expect_success 'absorbing does not fail for deinitialized submodules' '
 	git submodule deinit --all &&
 	git submodule absorbgitdirs 2>err &&
 	test_must_be_empty err &&
-	test -d .git/modules/sub1 &&
-	test -d sub1 &&
-	! test -e sub1/.git
+	test_path_is_dir .git/modules/sub1 &&
+	test_path_is_dir sub1 &&
+	test_path_is_missing sub1/.git
 '
 
 test_expect_success 'setup nested submodule' '
@@ -72,8 +72,8 @@ test_expect_success 'absorb the git dir in a nested submodule' '
 	EOF
 	git submodule absorbgitdirs 2>actual &&
 	test_cmp expect actual &&
-	test -f sub1/nested/.git &&
-	test -d .git/modules/sub1/modules/nested &&
+	test_path_is_file sub1/nested/.git &&
+	test_path_is_dir .git/modules/sub1/modules/nested &&
 	git status >actual.1 &&
 	git -C sub1/nested rev-parse HEAD >actual.2 &&
 	test_cmp expect.1 actual.1 &&
@@ -109,9 +109,9 @@ test_expect_success 'absorb the git dir in a nested submodule' '
 	EOF
 	git submodule absorbgitdirs 2>actual &&
 	test_cmp expect actual &&
-	test -f sub1/.git &&
-	test -f sub1/nested/.git &&
-	test -d .git/modules/sub1/modules/nested &&
+	test_path_is_file sub1/.git &&
+	test_path_is_file sub1/nested/.git &&
+	test_path_is_dir .git/modules/sub1/modules/nested &&
 	git status >actual.1 &&
 	git -C sub1/nested rev-parse HEAD >actual.2 &&
 	test_cmp expect.1 actual.1 &&
@@ -155,7 +155,7 @@ test_expect_success 'absorbing the git dir fails for incomplete submodules' '
 	test_must_fail git submodule absorbgitdirs 2>actual &&
 	test_cmp expect actual &&
 	git -C sub2 fsck &&
-	test -d sub2/.git &&
+	test_path_is_dir sub2/.git &&
 	git status >actual &&
 	git -C sub2 rev-parse HEAD >actual.2 &&
 	test_cmp expect.1 actual.1 &&

base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
-- 
2.54.0

