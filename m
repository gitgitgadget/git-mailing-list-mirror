Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794528392;
	b=r2HJ9K+Ed7/pcJ1PI90CwhlPAqHoB+7aijkC4IPZ/n4X4Q0ZlzDRvhW8pXhNNPHjTMN5
	 yfY15t3oLEDrF0Vr8ZTbN2qVGsd9nK8Lc2ejLNa5VZdmNcAnmxhVI3vmoJhUIDaRcSaBy
	 UFCPjMzMbEz3FOKvJY4riLYy3ehZOKWEyY2ilQXSozPpMSzAh3f4qfo/A5sqY3xe55txD
	 b4Vv7YRGP/rOqYzz3C2kraQoe4nJ4bQSlgFplk0Cq45FM8fOmShtcD79BfcVqnzDS2kBr
	 GP3wk/3LzDbfS6LjTksZg3f08sbse1cxNYbyrX3SogyeMI7MCkSsISexV2tnkgCdvOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794528392;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=qqCI7GOll3Mi9ctjOxK2M/IvTPN8fKS8/Mi83lev5k0=;
	b=ejsDZNtfmVzzZLB2dsWpBaANyHAOPcbM9q8+xpWIQL7AKar55kVVJrRd8W5C5r2qlKJY
	 B9xgvt4uUMib4PpYtahyH+mTRA+vgG0XRxa0e7VH820T7ZqzS1qPz6HY7CXbwQgXl/qNC
	 AMK9Tlz72RnBqVegpTCSSHY+GF5bgmxWjWBHytaWsctHglvrBvTCstdSxW12lo2Sx4ym0
	 /w1GbpqHZipXzxhMuzd88TExNi5naJntxVFVvhJbsGEZ06ZNoJTMbHGJO9l+c8ZNW4e0s
	 +RwR79ydqZDAEy0AQeqL5EYpRB+dNkbygHHPnrh0wi8lucagjMgCSZ5JTiF2Gm8dDkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S74VMdJ0;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB92606A321
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 00:06:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFB92606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S74VMdJ0
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3282db206d3so36398eec.0
        for <git@vger.kernel.org>; Thu, 12 Nov 2026 16:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794528391; x=1795133191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qqCI7GOll3Mi9ctjOxK2M/IvTPN8fKS8/Mi83lev5k0=;
        b=S74VMdJ0lydmxG4gpuyMkKRLLxvmfQF78bU2DBUJU2BwksFc3eg1c45DfydF4bsvat
         YoUxWC/NbtwnpyOOxHx8bzvogRoySPhl7pV7DMZnTvKFl5KHbgskd5pOCbi3aWIQQPI+
         RuS5C8OVhM6EdWXgofMo9JO7w0T4S0VJ7Pxb80YrKuE27LnCSf/oSuZGqqBxSoNix11z
         GEXQjO8oRm9jAcnpthccyuEWiB4QIrGxdW7lMk0+Ar4pYGpl2t08d/Chv1QuFBYQ0/XA
         /UJ/IyPV9/LjsKmFm1oLCrsvWkP6iuIGg/8Zd+8kIBzx8Ow2+xY3gtcTf27rTdzapcEg
         T46A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794528391; x=1795133191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qqCI7GOll3Mi9ctjOxK2M/IvTPN8fKS8/Mi83lev5k0=;
        b=Syygu1B0rYxL6kIE1/FBclIy0F6a3kIOMsbmtfkJESYkT4K22hQONyHlBAnAEacE9+
         q0mpk10Ib1Kqg2mmv+EMsUFsACDqfHrSrOT9Q2cBtX+2zQIZKtc/Zy3UF5XSsVzZQJhB
         p2p5MxkD3u7mVcoWgng3TBTSImqdRQux2pMbI3sOOWdc2LyM/sinw7klZYmuA0GoA08s
         ORJGCeIRCF31eWS5QAWqL4cmNwEb1QHs6tegSzTwXm3RzNBnOSD4SjLPepSZdIirqhMz
         8oVuv+Nwa6qD6o+pS/6FArOzTbVUpn+xp7762xy448UatZzQ1vupvlKfPT1yCd6wEa3a
         CmWw==
X-Gm-Message-State: APuU4Z+SP3eGynK1h/Q/mtFOG42dQZ4pTAK04sf7PybXwejl5/lXuetd
	0y6nEKW/KOFBh5xTiIqT51nKBUjrzr8tda0UDDDV0CcnfWUckppeYel6IKuHVhka
X-Gm-Gg: AYBFou25yBpJsAQOaLl6jYsig2fKV9WSFzL60avKLQJDz1L2inWKewt+0qtuDYf2Aev
	nxYW+teSKFm9yzdN4eTwFcJCH36WEIyLkmwuTdzpHh9oDNdrswB/w5BNVjc76PFnuqB5fzgoIo0
	4tXydUpHh9AGlIfpDhg9RAsENlZw8ynkqTSr33Oy5bS4Mpq3nENuuUDi9d7VthUuyh/p6167ebH
	waeQ53P6M85AJ+Bc9IV/QuNvssHJhHnlZeiHu/8zfUpZt1axxN1zEHvWcFyNrAJlcIfxrEFg/6Y
	eQ6g9Iw9l6Zsmqo9GkLgOVVmvOSoX596NHnKxdHDHR9nLx2aDJOhn3GT505tG1fEo75NLZ7ygBI
	BTaHvRR1ZLF2AmeyLEWAim1q2JYgg67FJlk8lorVXk37ZlYQYLa++90XXgGgQtkL8t9PsjlPJNO
	JNHncOChshAPr/wX2zC0w/VgmJAizElDWqnWuPzjFAbVDzmLchuGLV1jJ4/XUhSSKD8uUT3v/GZ
	c33Wy0uTAh2nRGf1zAMyfpWMY0KWrPy8CdNvTmIZdiFhd/juHaWwTjZrVb4eU3J8TM5qhDE/gLI
	1GyYWFhY9C8fMe3z6PvrWmrDHXGc57RJmaIs3ufk7mSeodSv+uDRSly6eQC6YZFAoccDG11jNI6
	Fyj4tOy+95+QccYdDzbbFRiBu2RsoJe3z81PW5J222mR4VahgqTb6w8jH3diy0fYPTUjkjGcx+l
	vF08BoFoaIc1+kwMOMqS2k/xi6st+ZTd1q2ieBxXjN9KLmmwKdOJ1VnwV9ghA+ZRQ/BKqzicTjS
	B/+WI4=
X-Received: by 2002:a05:7301:11b:b0:36d:2b50:4eb9 with SMTP id 5a478bee46e88-37967316395mr749003eec.25.1794528390639;
        Thu, 12 Nov 2026 16:06:30 -0800 (PST)
Received: from christian--20230123--2G7D3.nvidia.com ([216.228.127.247])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3795378d73dsm1846569eec.2.2026.11.12.16.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 16:06:29 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH] promisor-remote: fix crash without a repository
Date: Fri, 13 Nov 2026 01:06:01 +0100
Message-ID: <20261113000600.202744-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.56.1.471.g1891de46f7.dirty
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

When `git ls-remote` is run outside a repo with some promisor remote
related config options that make it write to its config, namely:

  - "promisor.acceptFromServerUrl", which makes it auto-create a
    remote, or
  - "promisor.acceptFromServer" with "promisor.storeFields", which
    makes it store fields,

it crashes in configure_auto_promisor_remote() or store_one_field(), as
the `repo` argument passed to these functions has its `gitdir` member
set to NULL.

This has been happening since 3e20258d11 (promisor-remote: allow a
client to store fields, 2026-02-16) for the `storeFields` case, and
since 7a56394fc6 (promisor-remote: auto-configure unknown remotes,
2026-05-27) for the auto-creation case.

Let's fix that by checking if `repo->gitdir` is NULL at the beginning
of filter_promisor_remote() and returning from it right away in that
case. It doesn't make sense to further process the promisor remote
advertisement as `git ls-remote` currently has no use for promisor
remotes anyway.

Note that `git ls-remote` seems to be the only command that can run
outside a repo and still process the "promisor-remote" capability
advertised by the server, as sending the `ls-refs` protocol v2
command makes it call send_capabilities(), which processes that
advertisement.

Let's also add tests in t5710 for both cases where a crash happened.

Signed-off-by: Christian Couder <christian.couder@gmail.com>
---

This is a fix for another bug found during the NVIDIA hackathon
following the Gerrit User Summit 2026.

 promisor-remote.c                     |  7 +++++-
 t/t5710-promisor-remote-capability.sh | 31 +++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index 316d9950aa..9c405847bb 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -1310,9 +1310,14 @@ static void filter_promisor_remote(struct repository *repo,
 	struct store_info *store_info = NULL;
 	struct string_list_item *item;
 	bool reload_config = false;
-	enum accept_promisor accept = accept_from_server(repo);
+	enum accept_promisor accept;
 	struct string_list accept_urls = STRING_LIST_INIT_DUP;
 
+	if (!repo->gitdir)
+		return;
+
+	accept = accept_from_server(repo);
+
 	/* Load and validate the acceptFromServerUrl config */
 	load_accept_from_server_url(repo, &accept_urls);
 
diff --git a/t/t5710-promisor-remote-capability.sh b/t/t5710-promisor-remote-capability.sh
index 463e9e00b0..50a73ec8b0 100755
--- a/t/t5710-promisor-remote-capability.sh
+++ b/t/t5710-promisor-remote-capability.sh
@@ -813,6 +813,37 @@ test_expect_success "clone with invalid promisor.acceptFromServerUrl" '
 	initialize_server 1 "$oid"
 '
 
+test_expect_success "ls-remote without a repo doesn't auto-configure" '
+	git -C server config promisor.advertise true &&
+
+	nongit git -c promisor.acceptFromServerUrl="$ENCODED_TRASH_DIRECTORY_URL/*" \
+		ls-remote "$TRASH_DIRECTORY_URL/server" >out 2>&1 &&
+
+	# Refs are properly listed
+	test_grep "refs/heads/" out &&
+
+	# No remote is configured
+	test_grep ! "Auto-creating" out
+'
+
+test_expect_success "ls-remote without a repo doesn't store fields" '
+	git -C server config promisor.advertise true &&
+	test_config -C server promisor.sendFields token &&
+	test_config -C server remote.lop.token "fooBar" &&
+
+	nongit git -c promisor.acceptFromServer=All \
+		-c promisor.storeFields=token \
+		-c remote.lop.promisor=true \
+		-c remote.lop.url="$TRASH_DIRECTORY_URL/lop" \
+		ls-remote "$TRASH_DIRECTORY_URL/server" >out 2>&1 &&
+
+	# Refs are properly listed
+	test_grep "refs/heads/" out &&
+
+	# No field is stored
+	test_grep ! "Storing new token" out
+'
+
 test_expect_success "clone with promisor.sendFields" '
 	git -C server config promisor.advertise true &&
 	test_when_finished "rm -rf client" &&

base-commit: 1891de46f79dc444a47db1c87bd0c8c76b5463f2
-- 
2.56.0

