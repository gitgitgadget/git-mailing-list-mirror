Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E0E483BF0
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 09:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791450471; cv=none; b=CrslpisksdAbSpreQ+MWobyhLJ9LidKT44qzydc5hYmhWyXg6YsLMCOUO7p+yqrlXuNC7BET6l805Fl2h3YieYCmPPEmsRQJpuwWsO0z438yENRRgqhrslW/EMHnN42VJOD1Z3vNmEmfKvor84v6hMVQrUyN/NILBmfwDxPsgUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791450471; c=relaxed/simple;
	bh=QVs2SzXUXHcdrADwlYsFbylXR6xg4lpoYvRyR0wYmsI=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=c2WK7YmQC4AIybW2+oaLuoeSM1IiGmB6WLGFHutOxNqJ2u2YPbZd7wmovyzR0shGR0e7UYWvC3WZOv0x4h9QMbDH7aY09/rQ5oNZENl9Z7JbiG0OhJLtmp8iTaTpHKV6mTwSFToEzYi73Kx47Uu8QygIunwdKOWY491SIav+LN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IlkzDuPh; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlkzDuPh"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3516c82e96cso2438556eec.0
        for <git@vger.kernel.org>; Thu, 08 Oct 2026 02:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791450467; x=1792055267; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=sOeOo+K2ftq93tn5GMW6Cdsf0CgXihd8g/CJ71NUKMw=;
        b=IlkzDuPhDxxOAoeoVVmkSmnO0acwa2TuodMbXas1hDT2OmUbgA3fC7+N47o5rsQRUQ
         hl7gF5q3LbGuf4UX65wf82PS2oznKKh/iBbj8FShU+JsLHT+d0770o/H5joexxqTyux1
         dwGLrd8IW3ijFwvw3QlP/bbM6lxcgCpu2GXBhCUcFvFxAHa22kvkY5aIHCyxJBWJFoKE
         5wKi8TK3Bc5bb+bAVxwsqlV7raMyr5pmCd4TO7zPc9JiasL38COBQyvjhZrp+AM8Ojok
         o+6EJekTIRl2A13Z+lm8m/ZxtdPg0MnSrXu0M5HZBkvqO0sx9M5DzV26oC4aPk89g5Qe
         Inaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791450467; x=1792055267;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sOeOo+K2ftq93tn5GMW6Cdsf0CgXihd8g/CJ71NUKMw=;
        b=1XWgpc0bwsMMIR0AV2/aoqMz3pkMAejZdwouo9DZTePQTuSWtUU2OYgxKNicmQ3hkb
         KfaRPlL7hRpIn79oRtNhwnZE8tUei2ezL3tzfh9m3QaQOyrhYOCR8U46dWIzFi9aULGb
         vv8cjPkGJGuQCCQm+Zbj+7MB4hNsmgILwuuhYcJkQV93hVe61Azbbalu7BIxvBcomRVa
         2snfl006J96T/5rcU9jrbC/6D3JwbDdQjzxzMMmA7OqhlPGL49tjdLO0hwy+3YLRtKyw
         9++Yd8FrD3bHqVsEVeGCjNCg7zQ5yILiaJs+sMBUq47/RsPJfkhnRSDs6mTCFuI27VGV
         fAuA==
X-Gm-Message-State: AFq9FYLEZZw8XM1ze4RKxYuDSemmDvHMtND0++9NRHDaEFZsnPXPg+qq
	aU1wKoCvM35QDRFVou61eAyTX+D1hb8yPlvwOEYzU7MAjxZrydgcntlrevNeXg==
X-Gm-Gg: AYBFou03zodwvlCO62IZuwZXv6ZVTLugMSTgXwI4F79TLdoHTn/Q97UpZlbeE3HDaW8
	j+MPHAjUuX4x7foTgdxA5/SpCfpUr70LvLN4pWmYSmJnKiwAfNzM6kbpGc4SaHNvIa3kvcDcr4y
	qa/I4dWmYXM3m0pGu2WUIkvLrs6AxmSssNOEdZWlzqwkL9h+iPencTlr/km4s17D/NuMdMibfI0
	LPosHQv3GmzjxqNtZl0g6M1aiN6hiIpNuC8hAB8nMU3SNk/O9abtzYoPPtbHl6lBH3OfjpH+lTA
	KtIVVYEN9TA9l19WwevOB51o0Sb2vCBc7Uc3B3fLEJTo/ipz+Wx7CQqFOcfkV/iv5KQ7y2ZJCIa
	KoTkgcJd3OFHW49qwNOIuvr2L1xup1nQ8gv6HoXoFr92fRjQfK0NTL/8Zhs0QlqD6sav7s1eY37
	NN0qjuZk25b6QP8L2vb6NB+AMvAJJRPfcxfGHwALne6aEeSuF5EXdDRiUcEv/ews4BDy4peg8pW
	P4=
X-Received: by 2002:a05:7300:acad:b0:33e:a173:4aab with SMTP id 5a478bee46e88-3515dda8652mr6224094eec.14.1791450466767;
        Thu, 08 Oct 2026 02:07:46 -0700 (PDT)
Received: from [127.0.0.1] ([52.153.130.112])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3515aeb5b46sm14630351eec.7.2026.10.08.02.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 02:07:46 -0700 (PDT)
Message-Id: <pull.2443.git.git.1791450465178.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 08 Oct 2026 09:07:45 +0000
Subject: [PATCH] t7004: check a missing key without deleting gpghome
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

The "verify signed tag fails when public key is not present" test
deletes gpghome to lose the key, and this sometimes fails on Alpine
with

    rm: can't remove 'gpghome/S.gpg-agent.extra': No such file or directory

Point GNUPGHOME at an unused directory for the verification, which is
how t7510 checks a signature whose key is unknown.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    t7004: check a missing key without deleting gpghome
    
    Fix flaky test by checking missing key without deleting gpghome.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2443%2FHaraldNordgren%2Fflaky-gpg-http2-tests-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2443/HaraldNordgren/flaky-gpg-http2-tests-v1
Pull-Request: https://github.com/git/git/pull/2443

 t/t7004-tag.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 8c795d7218..a0c2c9a3a1 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -11,6 +11,7 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
+GNUPGHOME_NOT_USED=$GNUPGHOME
 . "$TEST_DIRECTORY"/lib-gpg.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
@@ -1525,8 +1526,7 @@ test_expect_success GPGSM 'git tag -s fails if gpgsm is misconfigured (bad signa
 # try to verify without gpg:
 
 test_expect_success GPG 'verify signed tag fails when public key is not present' '
-	rm -rf gpghome &&
-	test_must_fail git tag -v signed-tag
+	test_must_fail env GNUPGHOME="$GNUPGHOME_NOT_USED" git tag -v signed-tag
 '
 
 test_expect_success 'git tag -a fails if tag annotation is empty' '

base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
-- 
gitgitgadget
