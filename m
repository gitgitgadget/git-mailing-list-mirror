Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD78F8824
	for <git@vger.kernel.org>; Sun, 21 Jan 2024 03:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705808318; cv=none; b=be7Hr4djQWYCXM59ezp2R8Y1t5xL5kBf61XWitspygUuYjuNkWA0kxL8j3378WEVtTb3QBVkKHF58PGG2HMRrA3mBlifNaCl4GX0LoIHA4W0SmqipXz2OwrKvDVSNk4dffChQ4TMWpVnxBcP4HsVb1SXReQ6sgVAP9XvKI4Quw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705808318; c=relaxed/simple;
	bh=yoOCjUtXV83GyMr4gJdc6v+DNXQ5Ro5SrIZQ6WeL+zg=;
	h=Message-ID:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=BhjS6CLRyS7K53qejbrI/Vzz8IGk0NHfs2mvvvTeVuP2tfx7haeYej4ktB12Npsep8mz2PITOvkcqx+t7E2Pq0P7BCUi+e4dFtSzYnauBybOXeWYygkLvy53Y1GoWtzpKPet1gbyJXntnF5AP9vNO/aOZ64yGvuC25tm2hvyfaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Teo5SzeY; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Teo5SzeY"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-337d05b8942so2253819f8f.3
        for <git@vger.kernel.org>; Sat, 20 Jan 2024 19:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705808315; x=1706413115; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=u2N9rt9yBGSyftmlEkS+ov3JsVXm/OBeeuaXFr3pneU=;
        b=Teo5SzeYi/k/WIiPNu2leOvrHXBHsb7gPXF2MATE/vj37vf72GMAhZC/0dBxpiA04e
         w/ZiTqdZcp+PE/ESwEHPa3qVr9AeVHIlbwEytSOLjJBh8sr/wQc/56QLWrQpj+oK1RNY
         D31FHN3QMBj6aNty4DGL1T9SuBC0THocu4WXjovP5tzrxqmAuaVvslFU8W4ZmlMx/8cH
         LuKWkAmjxq32AxpWQ4w7DDKmcxfcvfdCWFyzWueiA0GdSQedaFXRfFRIhmti6G+BuCBk
         u9dytMgMjm3TOKImdtQ61ZuTV+5K4uwq4MXS1VJBhaHyoU3J7H1YZOKD0hsVkaw9CfcI
         BpOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705808315; x=1706413115;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u2N9rt9yBGSyftmlEkS+ov3JsVXm/OBeeuaXFr3pneU=;
        b=K0Z4HbPrccsVowrqDvCBQ8+K12BkfUhBN2FmKE51yjNpEfmuvzjjeYtbtg8QBxZNRR
         HVCSRHDS02VnlM8yYV4o094Eo8gBQkFzrmKzV+XXYKogJvvJOn/NiOSaJvnDDK6wkzDx
         2QzPRkqXYp0Gy68dXYuHFyFCibAsM4Jgmn1NIxNb5QU5ZuZebYj+egx4m7B/FzsfR5/e
         Z3UxkUIbArDBTHtV3V7jQx2pC+bGpmjT+dgGnqSKIb9gu+YU/ZiA4ivqPL85ELL6ybUm
         SoC/PF3E7tE1GRLz8JOTkobyXVdvp/p+RXdRoYEAqAupgcApBRTdgxhhbBQylvDPUPNu
         2HlA==
X-Gm-Message-State: AOJu0YzLt/fpxjmE/WS9DdbFtVlApJEQiCYWIKPryqMIQWSGYimEa8Zs
	rE6aXqUW9LwwXMBDZ4CnUaw4q3HGW9rnX4LuBB/O9cmP7RnQQvyXQhKIVIIr
X-Google-Smtp-Source: AGHT+IFxPEuExlYz4vHZGWc4Xie4FHpZgBENB7FKZ5BTNu6y1oWL3/8fSOfcmiIaL9EvHpqodHKcdQ==
X-Received: by 2002:a5d:58c5:0:b0:336:615e:9308 with SMTP id o5-20020a5d58c5000000b00336615e9308mr1114326wrf.18.1705808314398;
        Sat, 20 Jan 2024 19:38:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l20-20020a5d5274000000b00337d1c832basm7605896wrc.113.2024.01.20.19.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jan 2024 19:38:34 -0800 (PST)
Message-ID: <pull.1649.git.git.1705808313306.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 21 Jan 2024 03:38:33 +0000
Subject: [PATCH] ci(github): also skip logs of broken test cases
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
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Victoria Dye <vdye@github.com>,
    Philippe Blain <levraiphilippeblain@gmail.com>,
    Philippe Blain <levraiphilippeblain@gmail.com>

From: Philippe Blain <levraiphilippeblain@gmail.com>

When a test fails in the GitHub Actions CI pipeline, we mark it up using
special GitHub syntax so it stands out when looking at the run log. We
also mark up "fixed" test cases, and skip passing tests since we want to
concentrate on the failures.

The finalize_test_case_output function in
test-lib-github-workflow-markup.sh which performs this markup is however
missing a fourth case: "broken" tests, i.e. tests using
'test_expect_failure' to document a known bug. This leads to these
"broken" tests appearing along with any failed tests, potentially
confusing the reader who might not be aware that "broken" is the status
for 'test_expect_failure' tests that indeed failed, and wondering what
their commits "broke".

Also skip these "broken" tests so that only failures and fixed tests
stand out.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
    ci(github): also skip logs of broken test cases
    
     * An example of a run with failed tests appearing along with several
       "broken" tests:
       https://github.com/phil-blain/git/actions/runs/7589303055/job/20673657755
     * An example of a run with the same failures, but with this patch on
       top (no "broken" tests listed):
     * https://github.com/phil-blain/git/actions/runs/7598605434/job/20694762480

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1649%2Fphil-blain%2Fgithub-ci-skip-broken-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1649/phil-blain/github-ci-skip-broken-v1
Pull-Request: https://github.com/git/git/pull/1649

 t/test-lib-github-workflow-markup.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/test-lib-github-workflow-markup.sh b/t/test-lib-github-workflow-markup.sh
index 970c6538cba..33405c90d74 100644
--- a/t/test-lib-github-workflow-markup.sh
+++ b/t/test-lib-github-workflow-markup.sh
@@ -42,8 +42,8 @@ finalize_test_case_output () {
 	fixed)
 		echo >>$github_markup_output "::notice::fixed: $this_test.$test_count $1"
 		;;
-	ok)
-		# Exit without printing the "ok" tests
+	ok|broken)
+		# Exit without printing the "ok" or ""broken" tests
 		return
 		;;
 	esac

base-commit: e02ecfcc534e2021aae29077a958dd11c3897e4c
-- 
gitgitgadget
