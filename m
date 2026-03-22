Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B1B1A6830
	for <git@vger.kernel.org>; Sun, 22 Mar 2026 13:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774187452; cv=none; b=YqRThWpqKzAmZDqiW+s8r+bOS8FRRNOKHuW1gzSjv/SZ1DsUyxZpq2EodvWnCRxx4vFtyNTUrNCzMK/vEYjNwp+eyfR3inl6QtiHAC2kIifWwKnknT0x/DAtTRA4PcLiztOFnxDIHKEdpnWOa6nIe0adP5JSDSGBEI0FjRxQS4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774187452; c=relaxed/simple;
	bh=kVD8ieq4s8tB9XQPlWhqoLeTx+mGxTAx6qAj7ckbXqs=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=YO51mBglua8swXUvzjzurCo9O/TNITBaE62Ey1LHps2c2Okkub1Flh2l34B99UGzTZRiCmGYr7UqHK0pVRfhgtwpikbDmiCRfMARy9e85SxztabdEU+DUZOxMWjLlUybmyjIOPc1ZmUnQHW0NaX5Q5ArqvmYKepPdkLDs6U7tDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c6FIf+L0; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6FIf+L0"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2c10a2e2cd1so609251eec.0
        for <git@vger.kernel.org>; Sun, 22 Mar 2026 06:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774187450; x=1774792250; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WssT2pqZqt/GUy1jIAprt+LAG/4BaeEakuGtV0fCuvU=;
        b=c6FIf+L0sVIVgRt8J0TNaG7UifUDzDLgJlhJJYPC8Gyle6JfplQ+zGPfjKU5Qh88X/
         UE4GAr9sxwzOo2InBlgeo0RtipcWnuRli7BQfQLd3+zKyWmVzqm2MKJNOFJejZA3iyYu
         L/+dlGyX5uRdlergeoMhbVABDOG5JhV/x4Iw1RSt7wWsKG2RpYkc8/TYWOgZLf70Anbr
         5VG4Ov8ZzdtfoQm0Th0kNWpGaSBdjqvV3Cr2IW4dxOLRqvSYFRVABqfyyKNiHNinFI/V
         It2Jw8l0B4AzQouHEMlAiL72siKUmKbNkl8o15qBlhJgNEtCy9vkZ5Kedt+vkHFOoKrz
         msyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774187450; x=1774792250;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WssT2pqZqt/GUy1jIAprt+LAG/4BaeEakuGtV0fCuvU=;
        b=pQ5/fjeigskbrWxQH5TNw4d0tBfZjzc+RvYGVQ9kvdB0aer4dyTF8OX8IdMnqMuUdd
         4Vx6hbLZp8eX8ILap5j+n9A/QmetiC0aqNAfAutArKj8KqGG3NXVHMDtxEOtMaSj2Odb
         peHbfsl3PFozN8AbLupoFRjZzmygd7/5t+zpe++z7hLlDXROlMLdhUPxKlR6Z57yVawW
         acj39SrV/H1ulBDbCMEwrJNVYMVf+CxBFwJGtKpvsddagyZNYZ+U6vwhMLpFBTIoD6a2
         19N2JZY8dA3IKn1Ws/4xsuResMmxuqljLkUlgU4vfFkF4MQqdtr373MUh/LL78462o5s
         4Rcg==
X-Gm-Message-State: AOJu0Ywifz2GgsBE7NZE3diNZlrxB6OMHuhMtKzNoeoJgb6gARxLMAn4
	9iwN2NKsn8pBmUlMqMh2IFIy+dXotCLBy44I/doQZMfFM1KGFQYaU7ixynf9vxAF
X-Gm-Gg: ATEYQzxzQ18AzkiotTEJQZZv9FmscbNDbjqvLoYFlRBbVKkp05xSTQgOnczEMbrz2M6
	oJseLT/54NlEsONlJCjwmYJfL33ABdjw4GWBcxa1PZb0w56Xei+zPdnpts/GFnpgocFswNwXKzK
	KcDjsZ3IPAo3jgxnSyx31TYB6pH9yJ6Z0H8Palh05ELR77at+bqYhj2wvuhS62TvwxvMkidHc/U
	xtcGLkfnMi3/EJjg1zoULEqYdd2dEksoIh7/wX8SQ3a4Y2qajq1KFu2Onf3pyJA1DDfKZiyIyAB
	qf2TJ3Kk94+4YZ1cBTM3/7kIgDpRak6eQJKUTAgGLqL+S9M+NtGFKsRJf4xunxORgP/fUe97OhC
	pxA5x4e2ELWQjS/AVMTrYIDMjdFUcHHUxTSid56IHxYdzTMMHQRtYcn7wJHZGPLdrYdqBeB6xTo
	cTNP1OONDYhUsAgSSbLkrCEwDT
X-Received: by 2002:a05:693c:3b0b:b0:2be:ca4:e119 with SMTP id 5a478bee46e88-2c1097abc22mr4416785eec.30.1774187449809;
        Sun, 22 Mar 2026 06:50:49 -0700 (PDT)
Received: from [127.0.0.1] ([20.163.83.247])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10aefd778sm13420549eec.0.2026.03.22.06.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 06:50:48 -0700 (PDT)
Message-Id: <pull.2248.git.git.1774187447563.gitgitgadget@gmail.com>
From: "Jayesh Daga via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 22 Mar 2026 13:50:47 +0000
Subject: [PATCH] t/pack-refs-tests: drop '-f' from test_path_is_missing
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
Cc: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>,
    Jayesh Daga <jayeshdaga99@gmail.com>,
    jayesh0104 <jayeshdaga99@gmail.com>

From: jayesh0104 <jayeshdaga99@gmail.com>

test_path_is_missing expects exactly one argument: the path to
check for absence. Passing '-f' is incorrect and results in
"bug in the test script: 1 param" during test execution.

The '-f' flag appears to have been carried over from the
equivalent 'test -f' usage, but test_path_is_missing does not
accept such flags.

Remove the extraneous '-f' to use the helper correctly and
restore proper test behavior.

Signed-off-by: Jayesh Daga <jayeshdaga99@gmail.com>
---
    t/pack-refs-tests: fix helper usage
    
    
    High-level (Intent & Context)
    =============================
    
    The test script t/pack-refs-tests.sh has two issues that prevent it from
    running correctly.
    
    It uses: ! test -f .git/refs/heads/f
    
    This is inconsistent with the Git test framework, where helper functions
    such as test_path_is_missing should be used instead of raw test checks.
    
    
    Low-level (Implementation & Justification)
    ==========================================
    
    Without sourcing test-lib.sh, the test framework is not initialized,
    leading to errors such as: test_expect_success: not found
    
    Replaced raw file check with the appropriate helper:
    
    - ! test -f .git/refs/heads/f
    + test_path_is_missing .git/refs/heads/f
    
    
    
    Summary
    =======
    
    Replace test -f with test_path_is_missing

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2248%2Fjayesh0104%2Ffix-pack-refs-test-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2248/jayesh0104/fix-pack-refs-test-v1
Pull-Request: https://github.com/git/git/pull/2248

 t/pack-refs-tests.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/pack-refs-tests.sh b/t/pack-refs-tests.sh
index 2fdaccb6c7..4a85d96c6b 100644
--- a/t/pack-refs-tests.sh
+++ b/t/pack-refs-tests.sh
@@ -61,7 +61,7 @@ test_expect_success 'see if a branch still exists after git ${pack_refs} --prune
 test_expect_success 'see if git ${pack_refs} --prune remove ref files' '
 	git branch f &&
 	git ${pack_refs} --all --prune &&
-	! test -f .git/refs/heads/f
+	test_path_is_missing .git/refs/heads/f
 '
 
 test_expect_success 'see if git ${pack_refs} --prune removes empty dirs' '

base-commit: 6e8d538aab8fe4dd07ba9fb87b5c7edcfa5706ad
-- 
gitgitgadget
