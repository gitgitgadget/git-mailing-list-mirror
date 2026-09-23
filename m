Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58502397E9A
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 17:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790183431; cv=none; b=jj6gfXufJX3tUMEqNjzX/GQSxH5MEQN81uQ4Zp8NwqbAatt6ncv7EnEnKs/OxDIjgioQ1MCNUbCbd4gLE2SdShwBFrGg3YN0Vx7E5jOB19RL6Gu7TSrlG///au0dOmBkXBt8DqqSRNaMSaLxcVfr/dSlq9Gohx95uX6rj/JkQFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790183431; c=relaxed/simple;
	bh=Gw4iw/D82Ap7QiwYwXHFOauf9HzTI4msKcmYYMENK2o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UqwIMMAGpnTaZ9yFisgjrIKyWL0L19IK52+BI7oSjepVIOEh3RpC3zKaoVIvoNSZYgNJGRICVGTexpK47BOf27KMctJYJeiHIG5aXumWU24UZQXuaB/HG+RCNypz1vlCnXkWqY7GQsnn5IPwRvGZZdBVCB2xVwBHrdC02ZJVjZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kquhmWbj; arc=none smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kquhmWbj"
Received: by mail-oi2-f12.google.com with SMTP id 46e09a7af769-7f4f0d37f9dso584788a34.1
        for <git@vger.kernel.org>; Wed, 23 Sep 2026 10:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790183428; x=1790788228; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TrB5/MXpOYoAG62qcMQ8s04R5TpcCT5w7z+WrVb5zaE=;
        b=kquhmWbju4W9Lzw01RuNsWWySKTwIBwfYIB2EKMuRFsrG6j+ZHaqENtjL2HDebWfHi
         vWnpYzBlPNhM2W9cMoGHoimt/twXC+xi0Ls7fQGVUuXlJ+VnBeGhrs4S8KnVUWmyDab1
         m+sUguhzx92Jkz3tICbJFCxFJr0+PPPH3D0htDZ+4P8N+r9r74fR9XUkGrL3p7ahIQTe
         iXQIEqKik+ZQqtUMp/d0qpf0/TMfVnb7Ukgmu6VCpAr2fmNVb0vjnsXVC4ITXUsy+Lic
         ROn0HTSLStakrXCn/ZtKJTqq91Yt6mIqi5Xf7FguIz6xD7YxRrxaFjET1ZTvIM7KC0vE
         652A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790183428; x=1790788228;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TrB5/MXpOYoAG62qcMQ8s04R5TpcCT5w7z+WrVb5zaE=;
        b=JAxWPKL0xmc4PpzVw13+hUhB4pNbsa9t7s3nN1/+X2V1sGVfsDBBoH9ZAJx6ahZ7Cj
         jZ6lgV9FUsiUGHHbJapFbCEKbEEYfpXj5L7HMf4PcnndL5ptb2yT+Lw7Yo1MIb1gugMh
         QXCNrSWaJYICan4Q1HULAigwgfPxPa/o1XH3VdCzEJjPNcXbvjhRvpsEeZXvCdv8ubgY
         hn7JKBnQD2wIYNn2gSoALiQeF5iehBBdN7T3CG5vkE5FUWmbD746yU8lVjrxPS3aA5bb
         u2P5q0GAUELliPERdnETp01eVeOivhc6vdFMhiFD/r0e9jb166D8bxW++HyJguIdhrdo
         07Iw==
X-Gm-Message-State: AFuF++l5neqnCaZAfTXIItNwh1vlmVitcDjF0uLk27vav6dd3fqIIxMQ
	1cl+LBJfCFudOG4Pz3SxAlQwb00/gmXgBA7Q4Gu4yIaGoDeou1lbSnFL
X-Gm-Gg: AYBFou1pLdyjPUL9AiQFHaKea/AYM/dp5bLbzjUXX/dG/Kh5uOTxYCHTzR8mwg1whpi
	DLkezh79fXI2Rw+RowLZNN6UPgaC+rd8iZVgUQgyobxJ7Qh1ocJpClii1SuWU7fm01xofrZwgGs
	W5ppAuh+dFr6d+4Q+BtHiEGKZLCo1o7D6HbtKVyEDAbJHAykH48npiAwzlvKALlWcXa70HxS8Ka
	kZld0hfewlMTsIqBqMMaccy7864f7eFr2JnUyricvLQqdTK4XJni6DrVB/tFnY85Jgw+dqtrvGG
	pq92bhmypzWiNjBmJusDNJ3IDbe7PVzD0hqAcZlt9Ovj9IJ9AiEyAXFZUBBiIdnlcy24atFAZKn
	OYYtYFKB7/osYDc046mGVxFzmLYNysZcvA7+LfeRxaZuTv6woHB++dNCW/yvotxJm2lZWUP6eQI
	ueTa1Qw8wICDT09QVsGqO4bOWkN+mZ507o3PQNPt7YSEo8D6ztFd0L5Aw2Sz3Gaz5D8Oz2piTMk
	R/q5Wr6obAJcOrDaXop0tdB0HbiNu6dJ/nkHsjK9Sjlp2DsQcfctwA5r2LV77gmztRuWlwG8t0s
	4pYPu92HdwFF9LPVyQv7Ei6Midcwz7GLLYE8zjn3zN1uzgAJQQRki5ejfI8hh6jbix5LRRswd+b
	bvPPh8969YJZUY36OErUDmDg6H55Q/EsHWQm7oBWMsSv9/iub5atkGz/3a49ktKExuQuUTA==
X-Received: by 2002:a05:6830:6814:b0:815:5c1:d763 with SMTP id 46e09a7af769-815f3eff73bmr3423642a34.26.1790183428087;
        Wed, 23 Sep 2026 10:10:28 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (vpn-centralus-02.tradc-corp.com. [20.98.136.114])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-816049b7b15sm3470670a34.24.2026.09.23.10.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 10:10:26 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 23 Sep 2026 13:10:08 -0400
Subject: [PATCH 1/2] dir: hash ignore files before adding parser LF
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-ls-files-untracked-cache-v1-1-08db4cc1efdb@gmail.com>
References: <20260923-ls-files-untracked-cache-v1-0-08db4cc1efdb@gmail.com>
In-Reply-To: <20260923-ls-files-untracked-cache-v1-0-08db4cc1efdb@gmail.com>
To: git@vger.kernel.org
Cc: Tao Klerks <tao@klerks.biz>, Junio C Hamano <gitster@pobox.com>, 
 Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.17-dev

add_patterns() appends a newline for the pattern parser before computing
an ignore file's object ID. Its fallback hash therefore includes a byte
that is absent from the file. The fast path instead copies the original
blob ID from an up-to-date index entry.

Switching between those paths changes the recorded ignore identity even
when the file has not changed, invalidating the untracked cache below it.
Compute the hash before appending the parser newline so both paths agree.
Update the expected identities of the untracked ignore files accordingly.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 dir.c                             | 2 +-
 t/t7063-status-untracked-cache.sh | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/dir.c b/dir.c
index d896e7be4b..037780e556 100644
--- a/dir.c
+++ b/dir.c
@@ -1195,7 +1195,6 @@ static int add_patterns(const char *fname, const char *base, int baselen,
 			close(fd);
 			return -1;
 		}
-		buf[size++] = '\n';
 		close(fd);
 		if (oid_stat) {
 			int pos;
@@ -1215,6 +1214,7 @@ static int add_patterns(const char *fname, const char *base, int baselen,
 			fill_stat_data(&oid_stat->stat, &st);
 			oid_stat->valid = 1;
 		}
+		buf[size++] = '\n';
 	}
 
 	if (size > PATTERN_MAX_FILE_SIZE) {
diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index 8929ef481f..10d4850077 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -98,11 +98,11 @@ test_expect_success 'setup' '
 	: >.git/info/exclude &&
 	git update-index --untracked-cache &&
 	test_oid_cache <<-EOF
-	root sha1:e6fcc8f2ee31bae321d66afd183fcb7237afae6e
-	root sha256:b90c672088c015b9c83876e919da311bad4cd39639fb139f988af6a11493b974
+	root sha1:8510665149157c2bc901848c3e0b746954e9cbd9
+	root sha256:09ef24b38105f396a61ad78d73ba6a18ee3cbd89ce4524b4e13b6c1af191e2d8
 
-	exclude sha1:13263c0978fb9fad16b2d580fb800b6d811c3ff0
-	exclude sha256:fe4aaa1bbbbce4cb8f73426748a14c5ad6026b26f90505a0bf2494b165a5b76c
+	exclude sha1:2bdf67abb163a4ffb2d7f3f0880c9fe5068ce782
+	exclude sha256:b83643f4390b339c1b3ff2f5132c99bd4a77687dd321d3f386c25953aa6f1ce4
 
 	done sha1:1946f0437f90c5005533cbe1736a6451ca301714
 	done sha256:7f079501d79f665b3acc50f5e0e9e94509084d5032ac20113a37dd5029b757cc

-- 
2.56.0.rc0.807.ga0c0929ce1.frankengit

