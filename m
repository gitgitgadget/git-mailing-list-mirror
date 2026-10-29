Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793283330;
	b=b1unzykGvu2E+hq7DMxhxBaVWjWX9SQKac9+hdq3tNfDeHd+/r1L8XDqqkEkF5RnIu5/
	 IzSWJyJaqnY+arsLJMqYBk7F146lgob924/tXwblbq1wCJv8KeTTllaSbc68lWivAxthe
	 QhchIwd2tXCFtHE39tKsSuDmi7YW5Y/6kknfeKGSemLdzDnQAAjUpQjEGifv+c6gOco6v
	 qrwml53VmT0C8+8M37BX9C2Rhrzg6LXXaPclR4xtG8Ggb9M9exkkP5YLer2PYhNPtEf53
	 aBsSNgjiKP1mOt1cOrQVB6xrPdlwsdgoipHrCU7hWMupTgstu6RyCJ+3JaVt5cu0xhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793283330;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=UKi0a1UZMdK4wKYAN8M7vBgSv7WStN7g+j6BiE/gjoo=;
	b=WuA8GlvgesMQdpzgnKNDDmx4NYYqX6JXgg05yDW8gdFteu7hfkqFbQf1SPTn0HojnYHQ
	 5Galb8Uh6afAqO9FJCp2ccc9cSM/7NfTwgwGuqccC6cUpDHt9L/bvPlhm3h9+tDu1wkxS
	 XHI7JnYAGjtAHf9fu4DbmCDefWt7BFCcDQQvVPecLMLkZ/Ti3Dig74Q8cfSXyofdX08+t
	 80AYpDkT9oJQ7Es2MB8dOHIWyKH75EVSvJReeSOPgQAvV6HdmZyNzdvgPtGovqJHRTt8j
	 fOlzOQrj426MH/sWPmhQrLyq8J0sBWSzbXIlBoXJHUEs/hAxwC5h1QJ2UrG6mz+5FTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uDnuQkDy;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D735B606A31C
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 14:15:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D735B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uDnuQkDy
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1a2af4c8d00so1147729c88.0
        for <git@vger.kernel.org>; Thu, 29 Oct 2026 07:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793283329; x=1793888129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UKi0a1UZMdK4wKYAN8M7vBgSv7WStN7g+j6BiE/gjoo=;
        b=uDnuQkDyoL3T/Y2sTtkIEihzliDtBG1mTNUmxKUqLX4eVsyUpawfz7wyR3TiYq5cjY
         XNDHzn8Nw2z9e3G1f8mEpiRF+NNl1wkcwY+mLNZps2awgLD6gjC8BiQe6qzVRF1Rs901
         JNilPcxRptQIsanCrMZk9LTlEcvQvR0Q7cdqWXa2NVhr4U3b/HJdXKoukqyu/aDGV24p
         2iCnMXzl5NrhK/b1Sh9m/EjxOo2IZ2ZkUg0FWz5KM8YMN2iSee51qJbgGqA1DImHU8mV
         8240fugQ/bpLnFQW/Nd7QHyv3gU77NAiRA0Uj2CmMpW9dp+gSzTY6rM+ImAOxwJCmlrm
         qMig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793283329; x=1793888129;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UKi0a1UZMdK4wKYAN8M7vBgSv7WStN7g+j6BiE/gjoo=;
        b=rWBIKw/upTRSt/DufYXd+v8HQcdlIAB58Z2RgKezWiQq6E0nu01zyoZ5StA+y1IAw6
         XRfBD0VaR8Yd97rQ5MnEHbA5+Sn3v6OvyoikVcuzwN/u83QRO7JlzKk3zHWn4u62chnW
         DW5bXbIUNybny8Gzr6icF6LihjXv4xAS6CcvHdGpn2XuyiyaXvFA7/brXlKUpsV3qRA1
         wN17Ih6J1QZQRsXsi8W01Gc96XpVu5pdVTkMBU5AnXDDK21kuYydpA8VKYLJi2XhNvR8
         Y0vBWzIcDH9GhK0TYn0sxt2ry806t+6RU54Ot+Dc50T2NxP9qxEMUQxBD8zfiyCWkbFh
         R3xg==
X-Gm-Message-State: AFq9FYKMg4kwKDb/+YDWSwiG3L+7yDudmqn7/Sh78fFpXkUu81Fbt8CD
	iYwBYyfmG7K44qwLqaRXNWrSEL1dxUTy/JYTXY9C2ar5HOBgxTVAiuh2D35vrrqb
X-Gm-Gg: AYBFou3oe2GP/QvMriYPFsmUIj3FDnBb567neE6S8xJo2nErGNTHJNwQzoOU379Mngc
	FGA4W9DUT4lMqU32ir8920sj2KXhgNv0Yzz5reO6xJpX3m3os8H38G19x8s1px5n6CkHIc37HL7
	BSP4nCjxixfLZJbNV4iQyTatq5/cJ9MOn0x9Xd5Vifd0W7tCfnxjoSZlj7n7TNFWRRbNa5mVLLZ
	z5IvahnkLVpU450pdwjEQewUUV0QlKwaLQ2qadpc5WT0YbwkdX1MUt8N4Ne9BYTjCP828h8dkRm
	Gyoki5JRSk/fuQ7OXZ/axE91FYp4DqNkrU2bwXs7/1l2bXJp0ycal73/0oaIe4jGwb/0y9asQJT
	jxAxas5m+zON72SeuIYf6kmjlM/SsRv2TcMVYgyikW66QcUZriFj31d7ZPI9775H8pt1n5Tw5dN
	MCu5ZNlUtK8etiCcPxAzPMs/qHvIuDhSlkJFk99uHdGvKQXqROchgChXVgYimONzf8ZS7BVFg8f
	QyC64UjX6wjSin8UuGissdS+gGOFlyaZ8d02kmIlMfKai9TDh6oepywgwwyZ0RihSNqt/k/oQAE
	dUEw4TSW9tLt+vmm/LZlqDfVLy5jvXJ4oyUODheXoZdbf3W/gJdfAitbWo9ZHL1EjkHYjw==
X-Received: by 2002:a05:701b:2514:b0:196:d6e1:108b with SMTP id a92af1059eb24-1a6cbe7fa09mr7458809c88.10.1793283327899;
        Thu, 29 Oct 2026 07:15:27 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:3ea7:bd5d:c91e:2c81:a705:3fd6])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a760569d53sm15697905c88.23.2026.10.29.07.15.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 07:15:27 -0700 (PDT)
From: Tilak Kumar <raaztilak07@gmail.com>
To: git@vger.kernel.org
Cc: Tilak Kumar <raaztilak07@gmail.com>
Subject: [GSoC PATCH] t0410: use test_path_exists instead of test -e
Date: Thu, 29 Oct 2026 19:45:15 +0530
Message-ID: <20261029141515.68254-1-raaztilak07@gmail.com>
X-Mailer: git-send-email 2.55.0
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

Use the test_path_exists helper so that a missing
promisor packfile is reported with a clear message
instead of failing silently.

Signed-off-by: Tilak Kumar <raaztilak07@gmail.com>
---
 t/t0410-partial-clone.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index a54685e3c7..c3c5fd6e33 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -627,7 +627,7 @@ test_expect_success 'gc stops traversal when a missing but promised object is re
 	git -C repo gc &&
 
 	# Ensure that the promisor packfile still exists, and remove it
-	test -e repo/.git/objects/pack/pack-$HASH.pack &&
+	test_path_exists repo/.git/objects/pack/pack-$HASH.pack &&
 	rm repo/.git/objects/pack/pack-$HASH.* &&
 
 	# Ensure that the single other pack contains the commit, but not the tree
-- 
2.55.0

