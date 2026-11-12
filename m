Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504855;
	b=jKwcKgDnfzzZkK1Q6HOaWpJSUOn0XVCd9G4/kSi9DwEzra2GPZ6usKsI/eUYiPPhcQq8
	 smkpJw6npYS6zB6OCX8oZ4QbqNJh7Qm0IoroE2NqVeoa/9jISxP1tMTNAWBe2pINtGLRv
	 oOfQrkYAuU9In4UypQgXMYEKK2RkRPCCTBKArMvJhf7wLDDZqHIIt6dW5D+HWO2057naK
	 IqMnsZ4k1gjY1NqMgqkgI5tjbJhLtayy2UthIsk6Ca5FGTEq7oOsztkJHxl465AlN49pS
	 6UAPKdbFNjlvRvOgBDBOsWGKv7CUy+a02OD1aTn/zLKRACrq3oKwXchdAvb4e1V5B5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504855;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=X3xSC2QCiKDc3U2xYjOKBtTviK++aIz6bQzdda0oz50=;
	b=MuCG/TQ0KgaF46EqaqxGCkJE06hTO0pAMMdm6KUEryyRDU1BTu+yv9SQUQHRqZ0dZLvJ
	 ovy3QHiA/E6166gLbbi+TFf99klmcGfIxpg/QVQbjfQAwYNc+OpoAcbhSnAVdoIYsZo5O
	 cs9nTox6Rw1TLjJ5mp45KYsTE89R1VQzsaeJmXac0doeLxru9pRA8xeGovWiVLU9MZOmF
	 AN0Mh3BM/UOfEpeXAqy32iDP2FU3CSCjUo8Ej5+CIoSL99a+MBMkfuqDnXkVU3Wug5+TL
	 Lmm6UwGhDYxWeMCS6ec6K4z1bGB6eDkTIl5Nj20OIMdObLDy/tcrfgIe2gYwUqOiIWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zMSTZFD2;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249C660A2631
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 17:34:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 249C660A2631
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zMSTZFD2
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-490c3ae81d3so5300f8f.2
        for <git@vger.kernel.org>; Thu, 12 Nov 2026 09:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794504853; x=1795109653; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X3xSC2QCiKDc3U2xYjOKBtTviK++aIz6bQzdda0oz50=;
        b=zMSTZFD2G2g49ERGy+ZF3nIkFk2SFMa6NjFBmmExy3Z51BczksApu15yjxdo0YCA8F
         A/7Q3BfLKZ7S+sK6nUrRBq2cybHTKL/JPPtxdamrLxvVAhs7TyNbwGBpcZbr9gdf93Vf
         Vq0trtJU+GcHAfkpqBCV3nSSENPq9uVKcgdMKKgwVZa4ng2pR06J3mjTARHr7iM5Co0Q
         5FIl2XIP/j6XRfBrLQZ/Yy2y4KXNrJHlkhv4cxmtNtZsiecLrMeqIgFsdcCUmLu9JtxJ
         k9A+IUZ5uk3/kCVJBrjMtmwS4+b7R8zAbhkYUQVSJgopfxMjShuGpcJoRryZywE0FA36
         UaCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794504853; x=1795109653;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X3xSC2QCiKDc3U2xYjOKBtTviK++aIz6bQzdda0oz50=;
        b=xj8XauyY16C+bxZPhmB72c8UoC3FHNZ11pzndTHvjGAHV7SG+dQUM+0KNMXFoClBe7
         3rhFz/1xorXI+z+mw2MEeFvORe/Nana8aHOBCFw69eXh8jsyoK2zohr28W83DUW6glzO
         oktwEqAXt7oxH2G3hN1W580RaaZqQC1ysyWeUq67FqZqlL3fP4/dRtEXX9/dBuwLFA37
         moCXKgKJW+a/Z2qCYZKpQuf5LYasU7v5ZhYO/pKb+/Hb/oFwize9zY0PquGDTB3PQ0CN
         u/yXknaeRALTHcaInFVjFjhQrPedVHxsuyQkGsdh+Gi2fOEnWE4q8T7pbtMtQ7hgPaNq
         rvew==
X-Gm-Message-State: APuU4Z9ucL8bgCyGbIU2EY9eSyrMNE4QKhUEGpzaXzeImObQueTsGZsA
	wxrusnPqKQBqn2UdAhKjMzczdAVDtQjV6nOYqh9qv6gSancFGI9RSJM0emlqXA==
X-Gm-Gg: AYBFou1zqOGUDMixiLs8OPvnzfDgoT828gT5ru0PoTbGsHpwdtkI+g7z7vWQ2R0iWRg
	4mYvzLMDV6YsTZLq0aR3E/rKnXLLSTD6Sy8Zu5/sgQm7imew1rtZK72mmmPYlOxRCtmH0GZW6Bz
	K870ypUbYKkVaXbi17sXgHp90/od2/LyrMxhnMyYBmrF7zHqtCrEQu1DZbcaz+YKc9aQEkxw4QB
	F4bmlQkgOLub9Eu2r8D9YgVlvxik/oYdFqsyOELhFEQYzk1+5etxYm3bdl5b43BszdPATC+K3tm
	ipeowTPphN0Ht09mr2or2jCN6hnFqxjjVjT8C/RZfBcof63arutsFDym0FkwUu5bFxL6Yl8keuD
	QQ32jrV2FfkwstvuOqe9MYdMMVfKzUuiPc1q/iMFFsFoOJvk7B1VMtmoT7oCvqtlpKUb5TbxjjN
	Hbfiz1vRRUBfEAEDKlErELdeACpF7gJNi8t6syiE2QHk0Vu9mTW3hr5+p+x+7PyBRJyWZ4YAI2x
	C15PsbFBJR37JjI5DJn0J4k2RKg/r2pe6ihDWE2obYu5gA95MQvHByuL6xbYAUea5AyyhxN8bFn
	b7VsYsrrQaECPXyQA3G7dDFI8L/8/jp4m19llUv6I/EiVxyv4aUrC96bYZj2coWl4y37
X-Received: by 2002:a05:6000:98c:b0:48e:b1a:fa6 with SMTP id ffacd0b85a97d-49c727d1d55mr126318f8f.40.1794504853555;
        Thu, 12 Nov 2026 09:34:13 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:cb2b:22fd:d791:9595])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c604ee47dsm345988f8f.38.2026.11.12.09.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 09:34:13 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 12 Nov 2026 18:34:01 +0100
Subject: [PATCH v2 01/20] t9300: move 'fastimport.unpackLimit' to the
 required test
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-kn-fast-import-tests-1-v2-1-b8c3a0ab27e8@gmail.com>
References: <20261112-kn-fast-import-tests-1-v2-0-b8c3a0ab27e8@gmail.com>
In-Reply-To: <20261112-kn-fast-import-tests-1-v2-0-b8c3a0ab27e8@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1246; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=CgE3aK1+0RAYiTwT5y0fv1oz2ZoMFUEW11hJVTjLwGc=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGr1+JBz7rDapafmSTeIhFeWm8D90acE9BQn5
 pjScPTa6U2CD4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJq9fiQAAoJED7VnySO
 Rox/BPML/jG1z74oWKe0eRSvpAqVJSjf/NsKNwi/h9UsIxzsE3MWXxZfS2TjS1jrigKtGQE2vgG
 8rvnrXH0ax8DlPdIsyh+IWjb3+WgNlDHBsdBm2ZiAOFY7E8pqjVuaanOKb44+hB95GyzCWLC9IW
 T9X4sDjKPOIL5UAbDzUtRki7FBgeuSi1833Xszs4FXBu72J6IS8ODKxvj0k1jrehHJwzJ7ftdbJ
 sZ42D99dzC4zcdpfSCFTTHQYnQBYJCS3pOM34YhIAA88dQ4dlqE95tnpVeHZi/mmef6hVpqBD+w
 2vQhCMncVnjuyXtoaSekpQjXEpLANVWrC31XcxM75rU6VR0mt9xhI5vv7OwaKbRKnIz3SJGQM3N
 4r1TRaS/X+LQRymIG60rrtsqogoCdNsECkQBbtfdBkhQIJvNDwKU/nAx0KIS3zDvV10gjV040h3
 U+HDwQbgZSpkSpEp5YZLA9fsBZ9yX6gGqoTOs8BcE2ZSEUVPK0QAFXVDnVzyY8oIx/gEnplrcN5
 3I=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The 'empty stream succeeds' test sets 'fastimport.unpackLimit' to '0',
so that the following imports write packs for the 'verify pack' tests
to check. The test itself doesn't need it. A following commit makes it
run in its own repository, where the setting would no longer reach the
tests after it.

Move the configuration to 'A: create pack from stdin', the first test
which needs it. The configuration must persist for the 'verify pack'
tests of the following series, so set it with 'git config' and not with
'test_config'.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 t/t9300-fast-import.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 15f511fb6b..4cffe43a71 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -38,7 +38,6 @@ echo "$@"'
 ###
 
 test_expect_success 'empty stream succeeds' '
-	git config fastimport.unpackLimit 0 &&
 	git fast-import </dev/null
 '
 
@@ -47,6 +46,7 @@ test_expect_success 'truncated stream complains' '
 '
 
 test_expect_success 'A: create pack from stdin' '
+	git config fastimport.unpackLimit 0 &&
 	test_tick &&
 	cat >input <<-INPUT_END &&
 	blob

-- 
2.56.GIT

