Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=172.105.7.114
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794100609;
	b=C4AI8IRSDTCLXy/WCwBMT8a/GRzUYBelkL8ck0XF21NNgOhDOpft66lzE/nYr9k2NgQc
	 0SRsoYTnW6dok1U1dC/Sf4eFreTgud5TRFL7pfttPd4t3fToeo8Ky74sOYUuNcLOPocGv
	 mOdyhMB8XjXADUFUIvxxIJXDWeILP69OlzBO0pfwr7K8uR9iWu6nvx8iqOd2nkeOBKaas
	 XjF6rH4U0oB0/3Mak1C2pa5u3wH1TsGNxocBFhMVJLdSRfE/tYQduSSa9tnLszFEJEb0n
	 B/uA6NBaKaID5oh8Ztg8gbcRnvJkezCOdg4mxxTdCaVKOnCvUbLudu0EEF+XiUTu1vQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794100609;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Bp+tMoHZ54kXst3Shmxegcw/fl38kYxdUUcfi1jjOSY=;
	b=2u9nAGXoB44jllPrtZgHsTLpXd9NLEokPTjPq+s/DY4IKBrzM0YjSyV7JqvyoRxLu6gy
	 JPH5LnDVFIvWNbMdbh8b0iThLpellaJwT7LA9LAQmAJ4b+6IckFCr7rDi5TvfgeJwDTAo
	 0edUGRRctUc0uG/KYIw5zitiPqCPhRdz0eRdu5WXD1DHKQ0KiQkSPzNdFBMJLx1iUc5is
	 db3pTfA5AyK3rWoTcbV8zG4GP37qwqO+zY0lCqXv9pfdHxu+eChDmLBWpmj+kxr6tIJii
	 5QAD37Y+2VH4xASs8NiRav73Osm9q6wUlk/bzLN4Av7PHSXJw4KkPefD9xNQNSpaE/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=crustytoothpaste.net;
	spf=pass smtp.mailfrom=crustytoothpaste.net;
	dkim=pass header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.a=rsa-sha256 header.s=default header.b=ERGdSnGz;
	arc=none smtp.remote-ip=172.105.7.114
Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B95606A326
	for <git@vger.kernel.org>; Sun,  8 Nov 2026 01:16:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00B95606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key, unprotected) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.a=rsa-sha256 header.s=default header.b=ERGdSnGz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1794100600;
	bh=Iz2YK7oEBe2OR9W7zyYWVMkxoTwjYnM/kopVj9Cvvfc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=ERGdSnGza8vcTioFNIwoqQM+kLUQOc3RIuaOkevxspN7Lk58dE6vHeoVwXHKn1a8S
	 GPF7bGc4kr4aRWAr+rljYGOT7QO3XyCybkbHWXVdWlns5sGZmTUOOK6hOC+Z03Spdv
	 ARSsVyB26atGtSoAlh/D3pla7EkLUk/ncBRDuHIhCUJNXOufw9MgjWvXYYlnlN7LCN
	 DbUDANRqHmVRdLGMX2n3EX2Md0n6QVo6vD1VRDejJuJkEr5IhtYkPk3r3SbcoM4RIO
	 NmgAurXij3HLVd0JTIWszN2N6pYIIAA2sUn4CwzOmya4svDguAxu2awOM4zKppNIVQ
	 VZrDazeWnkH2xYnw78QHvKFwVAdsTJuN6Vk9s0YY936tVC13xzJv7FlAtYHO4TD5GS
	 KO7tUEaRSr3OLe9sXuxom/RMsiSJYZCeaRK/Majjo+Ih/mHXgHBcbHG/VnKhaxbrLf
	 cvIRmyEntQte7OskG+a1P4gPpx6umzVHUeEvBpbSxlfkuix4FZ1
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:ba43:21ec:77f4:1818])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id D29B920069;
	Sun,  8 Nov 2026 01:16:40 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Adam Dinwoodie <adam@dinwoodie.org>
Subject: [PATCH] setup: default hash algo to GIT_HASH_DEFAULT
Date: Sun,  8 Nov 2026 01:16:33 +0000
Message-ID: <20261108011633.1772000-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.53.0.697.g625c4fb2daa
In-Reply-To: <CA+kUOampvjU3=VK3VGhYw2L5-E+LBsk=Q0UrAxhhR7hC5SUdJg@mail.gmail.com>
References: <CA+kUOampvjU3=VK3VGhYw2L5-E+LBsk=Q0UrAxhhR7hC5SUdJg@mail.gmail.com>
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

When we have no other hash algorithm to choose, we set no hash
algorithm, which ends up with us defaulting to SHA-1.  Instead, default
to GIT_HASH_DEFAULT.  This means that we will choose SHA-256 in breaking
changes mode and in Git 3.0, which is what we want.

Reported-by: Adam Dinwoodie <adam@dinwoodie.org>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 setup.c         |  2 ++
 t/t0001-init.sh | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/setup.c b/setup.c
index 61bcdafe82..4a0dfc8908 100644
--- a/setup.c
+++ b/setup.c
@@ -2830,6 +2830,8 @@ static void repository_format_configure(struct repository_format *repo_fmt,
 			repo_fmt->hash_algo = env_algo;
 	} else if (cfg.hash != GIT_HASH_UNKNOWN) {
 		repo_fmt->hash_algo = cfg.hash;
+	} else {
+		repo_fmt->hash_algo = GIT_HASH_DEFAULT;
 	}
 
 	/*
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index f1d227f271..98c7562f32 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -516,6 +516,22 @@ test_expect_success 're-init from a linked worktree' '
 	)
 '
 
+test_expect_success 'git init uses default object format' '
+	test_when_finished "rm -rf repo" &&
+	(
+		sane_unset GIT_DEFAULT_HASH &&
+		git init repo &&
+		if test_have_prereq WITH_BREAKING_CHANGES
+		then
+			echo sha256
+		else
+			echo sha1
+		fi >expect &&
+		git -C repo rev-parse --show-object-format >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'init honors GIT_DEFAULT_HASH' '
 	test_when_finished "rm -rf sha1 sha256" &&
 	GIT_DEFAULT_HASH=sha1 git init sha1 &&
