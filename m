Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793188493;
	b=YGxDSdvDv3pqQDyDTXXJoOq6t56e3eLm0FWvWycMS3eMzItO1i/Wgk8UHyO99carL7Rr
	 rDJ7B4nIuJUk8XlaJuVpvQ9j9xK2pmz4SsTMyzLP9TO6ke0aWllkWKHKo8gZPopWT9PIz
	 bp6tAtms240ZSfG/WZDxp8sdEMzG9tJXsZ24+FeMQ9cKZss2CX/Q6nBOyv0pIc1rblSOE
	 galsVwAP1cOQwWjmcE/LdVC0FoNsuGdxOj3PsFFaSo03Zp0kyYnIZ7+pTeLYJhn2h7fPV
	 1/Ph/5mFH2V0/1g5bxOC22dnBtm30j7zs7cinysp48zPqOxYsRrxl1t6Hb4NymRgoZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793188493;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DgyJs0ub2+4tFgCyXKiBxKyo9kPiLcTw+4Xeo3/Fyys=;
	b=FR4S8GVNIhofpD6b3k9y8WfemBaA0gScIi6Mdj3p+Lu4pUgPrnf9SPWSM777mC22YwpN
	 b1o6/BsxitPqrHhh5ALj+tbI+GiG5R0oVwyXq9Vg7Hw15FRPFj69RA1Sg98WrN/I73c+q
	 3L6KM+HKl06xRd5OQXI3qWgiU84eVg3uEFDmlR9TgdIbFePb0neOrP4fqRp8uZgAeBwzm
	 HICj56epdiC+kppebeWn6HVIMDFtWDhQP+c5ve8lT/2xDM7d8cRj0R8kXlfsKOP0hz1x2
	 9nCKniSPi53PDE4hsbvmPM4IvrxMKrn2XcNcGWuDxMblBYKzIqOkKN+EClYsrlwBDow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w8MKgFbW;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BF4606A31C
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 11:54:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4BF4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w8MKgFbW
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-18cdcfc05ffso1177164c88.1
        for <git@vger.kernel.org>; Wed, 28 Oct 2026 04:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793188492; x=1793793292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DgyJs0ub2+4tFgCyXKiBxKyo9kPiLcTw+4Xeo3/Fyys=;
        b=w8MKgFbWReayADaTSc2spwjhrrZDXU2McgiOxb533S+ONID9sD2iOCOxa32lmZF74U
         lcMA70UtPrzxzRFpD05JtguWSGjGdFQfHmtzqvUe2wrpzfd1js+hRnOhWVbfoZoYy/Tv
         ra85+7qLYT52Ma2RYGVP9HtmmHH+VdTYf9EZDcgFM6KHmSpt1Z/r1vlb+wEPefNXs2kx
         H+zIX5/XHbvyDiIg9n9M6DLQaYgIyjcfg8m3A4yFdSb7gnCwoYZj6eHPrxDm+S4MF2Bo
         AcRXSeay9AZlr+H0umrdDa7dihmuLgWtnjbZe1ZPyyrNaguSWNHM5xY+wE/gL5B7ZeR1
         VZ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793188492; x=1793793292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DgyJs0ub2+4tFgCyXKiBxKyo9kPiLcTw+4Xeo3/Fyys=;
        b=Ez+pFmOd3VO36hQr2wHuIIzI62aAFl1OsFka1yvHl4BDOMB3NAUebrVRR/4dkc+lk4
         WF6lQXXp9//9+0YmsoMd51q3GHamexHsAb/5ObIcd32QPyiwjItvJZZMeFAVS2OfeDvg
         jT5s6Hh8xB0AJOhhNs2Jxm7tg+HkPm91CV5xTdSUNjmOzx11ER4GcGvhFQUk0AvYV0gQ
         ErsTlL3lc/cu1mKrE8gMjCN0gKAwXlLhyHr6/0kJjMIc/6uq2cpDSRXixjazg23d6p4e
         dyq4FDVoPJ4HCeBbwWgf/DjTJrlgdA5700lk4RXkAFF0RHKbOHhy05CVlbNg5Ce/1f+c
         4siw==
X-Gm-Message-State: AFq9FYKYaSHLg8h1X+siu2eaoASWscooA12yeRa706OFRpMAtbozOcy6
	4NZwJ5Z1Y/S+qrWH9I6GJTA3qEt46XybFGhjhQ2mtMWr+gS9CAqAPsBy1J3bmg==
X-Gm-Gg: AYBFou29XB3Df7gDy2WcpZyf0/TNh0AEccuKcliDMYaUvZHiQzbWvMXj9Ws7/7mIAMR
	q868FVYl1UhQMjbEhs2LK94vbqToO59gGy9ay4LJym+3tWAOU5RbrBHtsDD4TuUcvWpEhUju5/T
	ONsj2ETDYNC5pQ+/FfsYu9rEBE3T71d9iSmL4heYe7KvUWPEU/yO4QCGhBnPUnBT621vkx3Dv1o
	P62Y/CCEvf9PYe4t6I0cCKGl8Nxda1RiFFNvB7nfUD5uwN5Aoj7JNYhXOqlPrzsaf9acHE6RuU8
	JtREm301dADjVi7OjVWe7wHiUVpQqLGKzguFqOS6UMM76lH7zVhDSjlYBlP5DnfiUz60xo7dpPD
	NbWsj5BfnVZ/Bx8gBGaJFAm6JbYoR1DkP6Abf7Du+uKctmy9h5i5MWAwpUHKYzzsPvH2aTfR/b5
	/ax6l6f6BTjBijzJtTQ9fHMCF/AnXf0ZXlhLFYSNhCPMQK1VMbaWyGerk/qFKDvNHkh9rlCWqK/
	cBQitMeYbVNgo0jHXiKperypiHYidvp+IMzn70BPjhmQAXZMxtxz8Rj2i0iw7CRjefz2nc8s36j
	eFjeYMpG6ywNAB3asgYsdn8sgBCPo6VPagLbvqWPNSPIvwJcinInklwZ
X-Received: by 2002:a05:7022:618:b0:19f:527d:96da with SMTP id a92af1059eb24-1a6cdd3e006mr4141987c88.33.1793188491639;
        Wed, 28 Oct 2026 04:54:51 -0700 (PDT)
Received: from ksivaraam--20260831-PCX54 ([2406:7400:12b:66b5:b36d:2c4:846e:bbe6])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75f7fb28csm6350819c88.18.2026.10.28.04.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 04:54:51 -0700 (PDT)
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Git mailing list <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 2/5] t0009: add tests to cover more repository discovery scenarios
Date: Wed, 28 Oct 2026 17:24:00 +0530
Message-ID: <20261028115412.169748-3-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.56.0.283.g7d13445134
In-Reply-To: <20261028115412.169748-1-kaartic.sivaraam@gmail.com>
References: <20260924120502.2642141-1-kaartic.sivaraam@gmail.com>
 <20261028115412.169748-1-kaartic.sivaraam@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a few more tests to t0009 to cover repository discovery
scenarios. We introduce these as we intend to do some change
in upcoming commits which would benefit from this additional
test coverage.

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
 t/t0009-git-dir-validation.sh | 41 +++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/t/t0009-git-dir-validation.sh b/t/t0009-git-dir-validation.sh
index 4cba478e50..bc607e6c2a 100755
--- a/t/t0009-git-dir-validation.sh
+++ b/t/t0009-git-dir-validation.sh
@@ -74,4 +74,45 @@ test_expect_success 'setup: .git as an empty directory is ignored' '
 	)
 '
 
+test_expect_success 'setup: --git-dir pointing to an invalid directory is rejected' '
+	test_when_finished "rm -rf parent/empty-dir" &&
+	mkdir -p parent/empty-dir &&
+	test_must_fail git --git-dir parent/empty-dir rev-parse --is-bare-repository 2>stderr &&
+	test_grep "not a git repository" stderr
+'
+
+test_expect_success 'setup: discovery fails when GIT_DIR points to an invalid directory' '
+	test_must_fail env GIT_DIR="/path/to/does-not-exist" \
+		git rev-parse --is-bare-repository 2>stderr &&
+	test_grep "not a git repository" stderr
+'
+
+test_expect_success 'setup: command that does not need a repository stays silent for invalid GIT_DIR' '
+	echo x | GIT_DIR="/path/to/does-not-exist" git hash-object --stdin 2>stderr &&
+	test_must_be_empty stderr
+'
+
+test_expect_success 'setup: discovery fails when a valid git directory not found within GIT_CEILING_DIRECTORIES' '
+	test_when_finished "rm -rf parent/no-valid-git-directory-within-ceiling" &&
+	mkdir -p parent/no-valid-git-directory-within-ceiling/ceil/sub &&
+	(
+		cd parent/no-valid-git-directory-within-ceiling/ceil/sub &&
+		test_must_fail env GIT_CEILING_DIRECTORIES="$(pwd)/../../" \
+			git rev-parse --is-bare-repository 2>stderr &&
+		test_grep "not a git repository (or any of the parent directories)" stderr
+	)
+'
+
+test_expect_success 'setup: discovery fails with unusable $GIT_OBJECT_DIRECTORY and explicit gitdir' '
+	test_when_finished "rm -rf parent/invalid-git-object-directory-config" &&
+	mkdir -p parent/invalid-git-object-directory-config &&
+	(
+		cd parent/invalid-git-object-directory-config &&
+		git init --bare real-repo &&
+		test_must_fail env GIT_OBJECT_DIRECTORY="/path/to/does-not-exist" \
+			git --git-dir real-repo rev-parse --is-bare-repository 2>stderr &&
+		test_grep "not a git repository" stderr
+	)
+'
+
 test_done
-- 
2.55.0.1003.g10538fe699

