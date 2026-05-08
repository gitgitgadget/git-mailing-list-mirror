Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CB6382294
	for <git@vger.kernel.org>; Fri,  8 May 2026 08:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778228223; cv=none; b=P2C4SsOsPLZlXBg/Rnbzg+E+K0gDTzQHClyTGzEdTdsQbxecAjz1DYaMyitiom8fnrYQ+vrN+rXLg2Sp1gfXP+npA7eY4m6bJuRazdJ/ObWBRuwKjoe8uMr42bhKDqOejnzboZbUgb8zVP1m2I1qnXK4IMcGm7vmc1bqJJwVJ2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778228223; c=relaxed/simple;
	bh=LbHwbsSRObIKXgG6/GAGMTzOlaZOCtXaa7+uZISFc0s=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bbw0fwntJhKMejmHtCzkCAN6n+5KF7KJTR4xmgDvFIemM4xFA5PF1xvUjmy4qI12QU24Xi3y0NKV84X48/AhAwPkLUTwt7hFVvzW5KLmfLZVWzm/1yXbZ+M61tM8UM2zncGwz32l+eO52Q+Ay6BYK/bKyHdINEMiLINyjnq5vM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ccG/1BaK; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ccG/1BaK"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51306c9f2e1so17037091cf.0
        for <git@vger.kernel.org>; Fri, 08 May 2026 01:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778228221; x=1778833021; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J4xodm3fjmxi+KQJTMUvyrLC0OV52p21gKVMP81J1fM=;
        b=ccG/1BaKn+IukKDI0IvZtB6/SkO1MX5aVIRBQUsHITZMOmI7vUSaCfynaLs0edqHbv
         3bxrmlRM35hkXUST3ggfxi+p/P69Ff1CdulE3G1eCsifCRUl44+2diZCR1hjBy/3Z2w4
         03dUY/IasBP1wbxjw7n/sDt1tTOHrq1smZ68WIcXfpzhoE8Ase+yrY+H5ns18y+nayYR
         frq8eC09E1rjNv6egG80Ap1djhbwKZ4Q3TnbYCOPea6I+ww0K2PQsmWgtjHGUAPhZYLn
         wkVfoxPgzb0c8BZ2v6jp6QLHI3YV5FdSZeV/3dn6ZrmoddySTOgD712RiXqbF3Lsm8uC
         Ixyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778228221; x=1778833021;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J4xodm3fjmxi+KQJTMUvyrLC0OV52p21gKVMP81J1fM=;
        b=UmT3mjG85vf1C7914GGOflSNLcDNuKdFi82VKxoEmLJvJSN413bWrz+kVZ1t6uqkIV
         UNn4xaozJ+9zIjVRD+VtxBNAPk0pqunhndrDBQ9oil6n5XIdKAqGCluLi05TdycxrCrU
         E7Wqcso90qjxhjHFjIoVey/p/0vbKOk8sgt0ULNjm4djYL5wxpGWwstyYZYyyHG9My7o
         Vo69AhO8fH5b8EvXlzAZTQkXvwElwpkF1b6wXAFGBEyw1Ag2BKaSHBSi5UDcKFqGjHGn
         sXA1dWCOYG6cmEik1o4IeV5t/+mf6aspN1c0tVtQdvPMWp7s+QMykxcPBTAQtH0XQyv6
         Xxhg==
X-Gm-Message-State: AOJu0YzDsIz37WKLlgPTJGDSwdyfiZrQ8xjbOihsgYgDZTQfasHY1MnA
	W8yIaVcynW/RC8JwRguMnXdqByfxh2SblQ8LHdHnWQReIHXY+RLAv3puG/5CKw==
X-Gm-Gg: AeBDiet+JfnbcsWOcE7T5q68gjzr74YGe1+ns2FajjRIz8SC+w0Tnqe5TocT7EiaQWD
	eaW6WIL/C5TpiZEAwZPw7b3Sn4m1CNxK6OcXd8w2ujcSgjYWZ1oxW4lxsr1UU5gD4degKG3cXVS
	U0ahY8IIhgqE/KyN9iNK+4eUf84H05dVw3Ba4ibdKZyiZd/piyMZ6A5gbNWtQpc3Sf8XSQkWo6P
	Wv8aVR5ori8edGg0dtGUOohxQ/78hPpWIXFE00dejd84FhlsRmH1VbJDNysoNXa7Lcd/ChPLbKa
	MTZZc8Ivmb6ob+QeYqM2yZHQ0ouFngM5VZxHUWUAQqc+LxUSsO8Vb4glugHvy/ut5ejUtdN8OxE
	y2o5p7V+hEhq5DzQ+2IAy6Vs6/NnK5Nb8JlR5d1nLGjtK7vRdsfN6Sx/nTBRgy47nb1eB0jY+eS
	Cd9tBQGPoqzXEQ5t11TIU5npA6gQ==
X-Received: by 2002:a05:622a:5a9b:b0:50e:c093:9051 with SMTP id d75a77b69052e-51461fa08e6mr142640891cf.30.1778228220627;
        Fri, 08 May 2026 01:17:00 -0700 (PDT)
Received: from [127.0.0.1] ([40.76.117.241])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e7c0289sm11445681cf.18.2026.05.08.01.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 01:17:00 -0700 (PDT)
Message-Id: <88f992903f8c0f01335f7573e2806ecfba4b508f.1778228209.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2102.v3.git.1778228209.gitgitgadget@gmail.com>
References: <pull.2102.v2.git.1777914508.gitgitgadget@gmail.com>
	<pull.2102.v3.git.1778228209.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 08 May 2026 08:16:44 +0000
Subject: [PATCH v3 06/11] t5608: add regression test for >4GB object clone
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
Cc: Derrick Stolee <stolee@gmail.com>,
    Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
    Jeff King <peff@peff.net>,
    Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The shift overflow bug in index-pack and unpack-objects caused incorrect
object size calculation when the encoded size required more than 32 bits
of shift. This would result in corrupted or failed unpacking of objects
larger than 4GB.

Add a test that creates a pack file containing a 4GB+ blob using the
new 'test-tool synthesize pack --reachable-large' command, then clones
the repository to verify the fix works correctly.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5608-clone-2gb.sh | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/t/t5608-clone-2gb.sh b/t/t5608-clone-2gb.sh
index 87a8cd9f98..af93302dde 100755
--- a/t/t5608-clone-2gb.sh
+++ b/t/t5608-clone-2gb.sh
@@ -49,4 +49,41 @@ test_expect_success 'clone - with worktree, file:// protocol' '
 
 '
 
+test_expect_success SIZE_T_IS_64BIT 'set up repo with >4GB object' '
+	large_blob_size=$((4*1024*1024*1024+1)) &&
+	git init --bare 4gb-repo &&
+	head_oid=$(test-tool synthesize pack \
+		--reachable-large "$large_blob_size" \
+		4gb-repo/objects/pack/test.pack) &&
+	git -C 4gb-repo index-pack objects/pack/test.pack &&
+	git -C 4gb-repo update-ref refs/heads/main $head_oid &&
+	git -C 4gb-repo symbolic-ref HEAD refs/heads/main
+'
+
+test_expect_success SIZE_T_IS_64BIT 'clone >4GB object via unpack-objects' '
+	# The synthesized pack has five objects, so a large unpack limit keeps
+	# fetch-pack on the unpack-objects path.
+	git -c fetch.unpackLimit=100 clone --bare \
+		"file://$(pwd)/4gb-repo" 4gb-clone-unpack &&
+
+	# Verify the large blob survived the clone by comparing its OID
+	# between source and clone.  We cannot use "cat-file -s" because
+	# object_info.sizep is still unsigned long, which truncates >4GB
+	# sizes on Windows.  OID equality proves content integrity since
+	# the clone already verified checksums via index-pack/unpack-objects.
+	source_blob=$(git -C 4gb-repo rev-parse main^:file) &&
+	clone_blob=$(git -C 4gb-clone-unpack rev-parse main^:file) &&
+	test "$source_blob" = "$clone_blob"
+'
+
+test_expect_success SIZE_T_IS_64BIT 'clone with >4GB object via index-pack' '
+	# Force fetch-pack to hand the pack to index-pack instead.
+	git -c fetch.unpackLimit=1 clone --bare \
+		"file://$(pwd)/4gb-repo" 4gb-clone-index &&
+
+	source_blob=$(git -C 4gb-repo rev-parse main^:file) &&
+	clone_blob=$(git -C 4gb-clone-index rev-parse main^:file) &&
+	test "$source_blob" = "$clone_blob"
+'
+
 test_done
-- 
gitgitgadget

