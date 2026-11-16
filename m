Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794856414;
	b=F99U/hEHtcW17tZL2J5oWCr6ck5keOTwZwzBt+kbsKTb/hgvbLaBJhkzZURiZiRl3TF4
	 z1NXhrOUea5e/t4K1lcg1ODvq1GFiQqbPj3Jmhx+uyONDjsUUAeCW2N8QQJMkH9Q6rzEv
	 fGnJ4EPIa2+pIpQmgElBIl/aNaX2aZRDk57wsYL9+7OvxekvR8kawR73QbDSv+cRsZynE
	 leLkUYaYW4KV8liSOiGt0dO9JWW4EXkGmiNcm8IjL6ocgV7tG0AhYWdK7bNClJj3rKggm
	 8/OUtNvKBoilsTO0V87PUSCyVm5dUPZ9PndI6sM7Ucr9UURs9O5Oiz4XxF/B+xkjHMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794856414;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vruXOvKyrpmY0WiUKBT7PlOo098pBKhAbw7Uyvl/a3M=;
	b=wv1iGVWZNWM6xoQW5pfZwKDrk80AdBSM6BtDyEsTNQy2gvKUjK6CF3vQANwXh+WV3JCx
	 DfAphzhZpjW6gWUp1yIrEN7FxdVGFzjKK4qOK4xAn8unrWAv27FYwaKJ+YxuCLQ0ZWgLT
	 VJ2Bny2/8P5xX5pAbWyy2PMfPWesIxtsssP9JlBmy2bjTeczgKD4MTXmQBRvv8a0WNfW0
	 UycwPr9iheBnwm1oE7xgRUaobVNoBFMMwr2k8WzY+goqdlRY3WN3StRAZmS0od0j87d5M
	 FPXDTi7TtwafxlDiEzV2omAfGL00gCDKmuPUm/MUdurijD2KpPSY5migoimSXuyIOyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M0BMdolA;
	arc=none smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49244606A31C
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 19:13:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49244606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M0BMdolA
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c4697404c2bso519398066b.2
        for <git@vger.kernel.org>; Mon, 16 Nov 2026 11:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794856413; x=1795461213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vruXOvKyrpmY0WiUKBT7PlOo098pBKhAbw7Uyvl/a3M=;
        b=M0BMdolAFXm/JuhIKq5yjhxTWLqG7gTZ1WCw9jSO5XtErUB9qnJhBeWhyZLBTyrZx3
         dU0FoKQc/ySOXSVsBTeX/ozNtYZLW9z1CiCeSvRcB1YE2vjYBvOimksVH/FuCGSEFglt
         tbetljLB6jTOoRB1ojLH4MWgv/CEoEHiz0Z3Vfe1VPqdBmZUTZO0BKhPDIDQr5fEUQOt
         v4zw45DoXhHLLd/jmtcVm/cuz3QsYTBDCB6afm98E55rJv643Hdlkzn084zDihhSZRyG
         be7HR897zD1NI1HGnHQpVWyE2c5fX7pn/AMAfccslN95/UiOb5ZrJXIiAxuXDGa8vvg2
         fsRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794856413; x=1795461213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vruXOvKyrpmY0WiUKBT7PlOo098pBKhAbw7Uyvl/a3M=;
        b=YETP1kWkWtqYRO5psCnXTq5YHy7k7M4JRr3Pan0q6t1JEHmr6H3TauI9n28pj/QN91
         pcDQ3v5d0p0jP/Eoic+t5dvxkDhkuOXW/Fdz+lijeGzMZL+exULcJwi67vVLmPimvxWZ
         AyjUckw+aBrKcCa6s52vNbGEETo5orEy6BkSCWOm1ca+z1tVg0zVk1c14728N3kYVyaq
         Xdt+TU5FB2ZpXE8z46IjrpuDLCpG66G/vww+6pJ8M7facVBr0My9nNYDs2ZjSHtXy0AR
         dI+pPtuPMT3h/uFpNqHcbdFWBYAjZs7wenpxUzxEG6tbp1di7Lb1j8iSShm8wCQrkzJj
         8NSw==
X-Gm-Message-State: APuU4Z99fVGxzzf/T5DAp1LC+9NB0rSY8mmDAD3tTnzLqUbgW4qn4oU1
	Ewh4NorWR/w7bw7HqmNHxv6uhx6O5Pzh4w/p19vOuOGb70G1lVpX8iHI
X-Gm-Gg: AYBFou2EJDOUIoDup8c5BXa/jDOEIAffbeTustLJCjUe/1Fel1QLcNK+73SYD/AGYJN
	FV3Ed67TbztskoTheGQuK/bNPZtRJS0orgxN4Pp9V4Oodn+lPngMYrxje5GIUNn2V87W7mfPkH+
	pB69BaxcJwDs6adP59AWxdKTTqjo4WumndHTOKQ1ylmyGtf5NvtYDQx/rVzCgyRnuo9IZfwttgc
	KKJvJc2Q4k9TYv87E6KO7Z+vPKzNJG3AOrV8KPW9CN8xpgthYSOny0cVhKMKWpMEt++iu7Tl+Bz
	AHFeizfF4HVOOSLEJB9C27SptYVJ76iBvLPaNLFX/0cbN+h2Md//McEkuSIOPQ5yjaAv3D+4ggo
	mLGm5F1mGZng8MAPAMZMPq7DxreK//8i6p2Z2Fil6VIsvjo67RwSGEbM2Vc8HbBmw5z9I8OFztA
	dqGOUafRDmdWwDnZeCp4268/y/vBM2vyyxyR/kDAeLdZ0DzGrFlSv57cdgMZMrjCni1zswaHcUw
	ouALsPKzutd01MgKthq47vhhxAB62cODxq/lUPftcxzIu0rnMvawtNBY5XT+rRrkcFIHFUW0eQA
	sZEi8JfNLZJbcPzG4Gh2k98moNofJe9Lb6XnZsqJ7n0mYnV5Et7MLO9aY6oVvuloLAXV3rN7I5w
	ahBqkB5egxASqsZdWpeASPqQB/6SxbXPDf6zr9SNJ1QUVtCrZP5ahetDzh4g4t8uJISB8cy473u
	dkv8vxPzk0FffkYrYfaHrq5fp/W54n
X-Received: by 2002:a17:906:9fcb:b0:c2e:61e:f4fd with SMTP id a640c23a62f3a-c509614e8f7mr973641366b.5.1794856412336;
        Mon, 16 Nov 2026 11:13:32 -0800 (PST)
Received: from localhost.localdomain ([104.28.251.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b8eb83sm447983066b.79.2026.11.16.11.13.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Nov 2026 11:13:31 -0800 (PST)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	okhuomonajayi54@gmail.com
Subject: [Outreachy PATCH v3] credential-store: add lockTimeout config option
Date: Mon, 16 Nov 2026 20:13:21 +0100
Message-ID: <20261116191321.28837-1-okhuomonajayi54@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261016212216.58000-1-okhuomonajayi54@gmail.com>
References: <20261016212216.58000-1-okhuomonajayi54@gmail.com>
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

The other settings that retry taking a file lock are measured in
milliseconds and do not put the unit in the name:
rerere.lockTimeout, reftable.lockTimeout, core.filesRefLockTimeout,
core.packedRefsTimeout, and core.configLockTimeout.
credentialStore.lockTimeoutMS spells the unit out.

Add credentialStore.lockTimeout as the matching name. Keep
lockTimeoutMS as a deprecated synonym so existing configuration
still works. The value is still milliseconds, which the
documentation states.

Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
---
Changes since v2:
- Reword the message to say why the new name drops the unit. The
  other file-lock retries are milliseconds and do not put the unit
  in the name.
- Rebased onto current master (7fb6055e67, The 20th batch).

 Documentation/config/credential.adoc |  5 +++-
 builtin/credential-store.c           |  7 +++++-
 t/t0302-credential-store.sh          | 35 ++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/credential.adoc b/Documentation/config/credential.adoc
index 80a7c77772..6fa40560be 100644
--- a/Documentation/config/credential.adoc
+++ b/Documentation/config/credential.adoc
@@ -48,8 +48,11 @@ credential.<url>.*::
 credentialCache.ignoreSIGHUP::
 	Tell git-credential-cache--daemon to ignore SIGHUP, instead of quitting.
 
-credentialStore.lockTimeoutMS::
+credentialStore.lockTimeout::
 	The length of time, in milliseconds, for git-credential-store to retry
 	when trying to lock the credentials file. A value of 0 means not to retry at
 	all; -1 means to try indefinitely. Default is 1000 (i.e., retry for
 	1s).
+
+credentialStore.lockTimeoutMS (deprecated)::
+	This is a deprecated synonym for `credentialStore.lockTimeout`.
diff --git a/builtin/credential-store.c b/builtin/credential-store.c
index bc1453c6b2..afd2e4f3ce 100644
--- a/builtin/credential-store.c
+++ b/builtin/credential-store.c
@@ -67,7 +67,12 @@ static void rewrite_credential_file(const char *fn, struct credential *c,
 {
 	int timeout_ms = 1000;
 
-	repo_config_get_int(the_repository, "credentialstore.locktimeoutms", &timeout_ms);
+	/* lockTimeoutMS is a deprecated synonym of lockTimeout. */
+	if (repo_config_get_int(the_repository, "credentialstore.locktimeout",
+				&timeout_ms))
+		repo_config_get_int(the_repository,
+				    "credentialstore.locktimeoutms",
+				    &timeout_ms);
 	if (hold_lock_file_for_update_timeout(&credential_lock, fn, 0, timeout_ms) < 0)
 		die_errno(_("unable to get credential storage lock in %d ms"), timeout_ms);
 	if (extra)
diff --git a/t/t0302-credential-store.sh b/t/t0302-credential-store.sh
index c1cd60edd0..e1bbca3fcc 100755
--- a/t/t0302-credential-store.sh
+++ b/t/t0302-credential-store.sh
@@ -210,4 +210,39 @@ test_expect_success 'get: store file can contain empty/bogus lines' '
 	EOF
 '
 
+# Holding creds.lock makes the next store fail. The error reports the
+# timeout that was actually used, so "in 0 ms" means that name won.
+for v in lockTimeout lockTimeoutMS
+do
+	test_expect_success "credentialStore.$v=0 gives up immediately" '
+		test_when_finished "rm -f creds creds.lock" &&
+		>"creds.lock" &&
+		test_must_fail git -c credentialStore.$v=0 \
+			credential-store --file=creds store 2>err <<-\EOF &&
+		protocol=https
+		host=example.com
+		username=store-user
+		password=store-pass
+		EOF
+		test_grep "unable to get credential storage lock in 0 ms" err
+	'
+done
+
+# lockTimeout=0 must win over lockTimeoutMS=500: the error says
+# "in 0 ms", not "in 500 ms".
+test_expect_success 'credentialStore.lockTimeout wins when both are set' '
+	test_when_finished "rm -f creds creds.lock" &&
+	>"creds.lock" &&
+	test_must_fail git \
+		-c credentialStore.lockTimeout=0 \
+		-c credentialStore.lockTimeoutMS=500 \
+		credential-store --file=creds store 2>err <<-\EOF &&
+	protocol=https
+	host=example.com
+	username=store-user
+	password=store-pass
+	EOF
+	test_grep "unable to get credential storage lock in 0 ms" err
+'
+
 test_done

base-commit: 7fb6055e678f800320d8ab8cd8f201d9493d1ba0
-- 
2.56.0

