Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A452A1F0994
	for <git@vger.kernel.org>; Fri,  2 Jan 2026 06:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767334871; cv=none; b=OQ4WmdIaDSZUfilYNR6342AbHrHA4nvi/I1cbwHsaqFqxD9V8Hq//isDX0pjFfOQTMWVPEp3r6o7K7k1+cN8c2vLtczXn7YKieTCdgpjFoOy8X9IA5T5wHpoeRXCvzenBAEGmNRUk/yTlI5vumn+teB/vohxwsUL0twBczNRgPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767334871; c=relaxed/simple;
	bh=OumeRBYyqscxjiHibD1FhVM8BITcL5gmaM7dVD+2OE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ps5aA+BIbP2LpdV6CjcwWJui4EE7kVelfa0/ZZs7WyGqJZ5/7cu13wKOinjtf4v+uCmOBOOb7WhKaaubzIpv2QJX9fifgwjY4odKQgdALt+f0VpxVdiD6NBf1q9zUA9RHNQ4Y9jkb/8787yA1aOUqCcg99wOj39nqcZ9hcCMte4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ca4uPMAA; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ca4uPMAA"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-29f2676bb21so163327685ad.0
        for <git@vger.kernel.org>; Thu, 01 Jan 2026 22:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767334867; x=1767939667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4lG7wPmC+JCawkJlsN8S2YW9RhXcO84d7M+4IPK+7Mo=;
        b=Ca4uPMAA39arDtGYU5gqeipBD7ehM1Edwo1HOOfz8ycGzyZZuRBm/dnIF7D3VQi6VE
         uE6dU2VDN9TaKbv6WQYyJAgNvqN4qrWfqckL6fbAO+RL+/qwlyKgk7Iv1a/QTOEdv9rk
         Ka+yM/ByHNsR7orPPnaCz2Z+5EgIfHymVaiiP3PsYNa1iVDAKtqybddij90ZE+lRn/+Y
         Qg/KwZuPGPuJ8tOYeAngMFlSBvWSJBhgL1RDV+Pzh2QVg1fLoPFCp6ykdj/xwpwo7WB+
         uP5jRNTsmtL7896u3tLh/3TEpAN8CBBbUBBSK/66KWGoz2JIvh0HMzGBsd8eAn/TyeyA
         3uNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767334867; x=1767939667;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4lG7wPmC+JCawkJlsN8S2YW9RhXcO84d7M+4IPK+7Mo=;
        b=MQPLJP8euXvB86cs3HBnvC8dQVbyBAzVld1J+kcbXqX80A6wkmgtczabQn7ol4mlJT
         gKJ9PdUb4y/194UvaKZvPConJH6JBt3O4PpEwSTdqQOEjRKJE5UmfVu+DCPvo+b1CXRr
         b0q3qPpfeJGFvHA4x+/qMB62FOOtLsr2mIauDTau0/xudweVyfLWzKEGqEq5/PCovPa0
         7XI4mixDK7TKXYMWfAS4T9Rl3RxjUcK6p6IsR3cwNyemu0GPbjBy2BA44wN+MxiFAJ2J
         dYho/SuLYrSrxQYojkgEH1xFwY3UPud8LHkXXax2RN3BGyP9P2/N9l0IXb1btNiPWiLj
         c7vQ==
X-Gm-Message-State: AOJu0Yz9rqie/HhvPZ88djomgP9ytkU9B4CymfhpiOMYI2No+rnfSpi7
	V1zeHrrUUy3Am4wFwFcTLacInbnd6RKQD6dVJCllpkFLj1I1W3DufoTL9cKwmUH5
X-Gm-Gg: AY/fxX4XBL/PKGXI5nJrS64wftdG4ciGYAVdXjjMhQSS4WS+rtiZxQRsOR/sFjAg+wl
	m0rr8Efz3ipPWziGQPtC7ja1IvYBwX89MsiPl2/T+bR+spJZbvQhvx/Wcgy9pbzR9NbSUAIHQj8
	hTQyCmUjDGw0azXr6zUCcCeWa6wkk4Xz/RcATzjTXPk7kTL9u61Aie/EocZqWB7sCNzJiFoJitm
	L92sgkaoikgU4Z2711DxPf4QPBmaQqGIZt+MGHTM7AWGCOdcJ2r5N3dwnljig/96qU4Gzh9/eHy
	u+x93BYD+iwlFUQs4AXy9O2dSLqIgIkZx+CWWiI4paI11hgVjoC2YmU8VhEe/tksij1vossiXDd
	LifBRy+3iTz5prfff1AaOq3yI54ihGxoHJNtT3OEk4pA1gy8g5v6gE5Hu31wXTOKipV/fc9s+hL
	houTOAnvNjV2yhl3Je2pqyLpZ/fzbUGCCz
X-Google-Smtp-Source: AGHT+IHz4JUhxHlgE1DwKApaAoAsHL89JARq6syoagBVjFCunuAzos0KMfTa6chqOjIFxSmvL5Dlig==
X-Received: by 2002:a17:902:ce0d:b0:295:1e50:e7cb with SMTP id d9443c01a7336-2a2f232c836mr454496615ad.23.1767334866573;
        Thu, 01 Jan 2026 22:21:06 -0800 (PST)
Received: from localhost.localdomain ([1.39.18.9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c83325sm369541945ad.34.2026.01.01.22.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jan 2026 22:21:06 -0800 (PST)
From: pushkarkumarsingh1970@gmail.com
To: git@vger.kernel.org
Cc: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Subject: [PATCH] t1300: use test helpers instead of shell primitives
Date: Fri,  2 Jan 2026 06:20:23 +0000
Message-ID: <20260102062029.18210-1-pushkarkumarsingh1970@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>

Replace plain "test -f" checks with "test_path_is_file" and symbolic
link checks with "test_path_is_symlink". The test framework helpers
provide clearer diagnostics and better consistency across the test
suite.

Signed-off-by: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
---
 t/t1300-config.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 358d636379..9850fcd5b5 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1232,12 +1232,12 @@ test_expect_success SYMLINKS 'symlinked configuration' '
 	test_when_finished "rm myconfig" &&
 	ln -s notyet myconfig &&
 	git config --file=myconfig test.frotz nitfol &&
-	test -h myconfig &&
-	test -f notyet &&
+	test_path_is_symlink myconfig &&
+	test_path_is_file notyet &&
 	test "z$(git config --file=notyet test.frotz)" = znitfol &&
 	git config --file=myconfig test.xyzzy rezrov &&
-	test -h myconfig &&
-	test -f notyet &&
+	test_path_is_symlink myconfig &&
+	test_path_is_file notyet &&
 	cat >expect <<-\EOF &&
 	nitfol
 	rezrov
-- 
2.43.0

