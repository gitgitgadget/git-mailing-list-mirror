Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDEB199FB0
	for <git@vger.kernel.org>; Wed, 26 Mar 2025 07:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742975589; cv=none; b=nUKggDWmo9QKYj2m2W+RYPa1n88Vj6/iGIN3uT89Vh4b3a+pqdgI/7SRBemcJSy7z3toFSbT9/tVuqLyEun3T51C97ynGcnqfu1QOy34Mb/TaiJbgJTop/mL7HcX/Yb+vwu74YT1edzy/+jkZBVtnoZKfy5QdD0x2gJpFjmjzpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742975589; c=relaxed/simple;
	bh=nKhvXlc9VUII90V9y72s85XoWwWJsAf0yjAam36cztE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pJWCfscj2GyKKd64guOPaWi7P2mnEywizLwWbW2zSZLkdJFp89ke3RZm/EfN2IYJuOasHouZ0J9gxGk/lGN2pynq7NFxijI4lm1x/10znvCSomRNecpl0liCKzy3J7X7CzbJLJfo/5W0TAYAHKsnx6erL3NAiBXEXyO1N4AmFlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sh6Rjija; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sh6Rjija"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2260c915749so88251085ad.3
        for <git@vger.kernel.org>; Wed, 26 Mar 2025 00:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742975586; x=1743580386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oRR1coZaRVYg9azhpKZc62eH1qYjUJErx0dIYunF7Sw=;
        b=Sh6RjijaspSdAtFR3+V0QQGPg1QSpOtP9K5igTk6OKrrN5zmCumt+ClG9V+5PfmYdt
         aEo38TidyjjjPSuNL81oC+1TPDP/6DmNE8mSRjZ99WvKDRxVj+KM615wAbkpWGcy9tvr
         S9ZSAPKyJwtGXFeb4Beq91xjIfH5OZzh+3xCFGSTpBetVpc+4ulYgIH3Na85D1x2WlfL
         AOX95BM6nTAz3Tsl4xKuQU46s7CRQ31a0cCSVwQzFdmbsdPHCLlHvnviUdoXBzc8oMyG
         F8MdYHSsMtkutX5CkBlSjNK0BgPeUhPIk9QYWgymGwCr+INrolNBmcnJ/Ow7L+6L1M7R
         H5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742975586; x=1743580386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oRR1coZaRVYg9azhpKZc62eH1qYjUJErx0dIYunF7Sw=;
        b=R+QlWjtFsbUvtR27EYzO+zHLrjudJOkShMz2CPd21MTVBdkA1ThX4ckR85WJ+1cgtI
         MstgFH0curJySQz4qrn4fV5TWt/vhL2sUr5t9+goTZXnP5KOMfFKUMrL3VCGxdRnfbLx
         nvWCYm0YzVGlcSOSCeAz4sZnZckPfhuviZbhnVulbSjuvYPO6kYVMQRDtIeIHnL7U6f7
         Ca+6/M+X2MJYfjqAmF5RsKtGJumZfvNRiaFsAtLylFjhHHr3nv1JjemIUpU15MOl94R8
         0axEJ93s+ZUA5XEVyIHb7BnFV14yrRi9NMdNbd84iz097iuh/3hyE/sm4wsZX1KOyqDO
         ga9g==
X-Gm-Message-State: AOJu0YxmIwumUgwwBr5PzWsH4TjYTUuWxYV6KlJExf+4WxR7p9WFQNiv
	6/7cVk7R0ICmz60e6rTdgqv8cOynFoTdaMp9RjWJZkS0ROfSqo5R/sogYXrE
X-Gm-Gg: ASbGncta6hFwWP6mYXV0MOeaxBllbHPHvVvXl3P/bzj4lyEVt5EOztyYtjjcHB6OTD7
	VGmhyHEvLQzoI6l3zzLxTFFwvki872AwWZo4AE33ghgfT5Mr83v6VgaWs34URGA7JF5vNVB3avc
	2dAAVDux1Z9f4d2G3MjRJXNUVpn31OydX+bU6GUf9dGcjP9WuY2nXcqQgUSOasx2ZX3aand0pEi
	U1h/GyC+t5G2JKOK3VfoksH5YwQF/cfzp2k938Ccp8ycZRdDV/Jj92QwnmL1a5ES9Nd7CLdGgeN
	I31byLrchaZHozt1kBtYXbVkm8vXIa8HYWQ6n3U76hUIwFa/BMvuy5LTi0TiLw==
X-Google-Smtp-Source: AGHT+IEohCmhSa8i0Uz2zpcMHpCT5mqvCdtLocqYyLh2xaN357HF994qCpFcT+bi9gyLAEH6hoYxhA==
X-Received: by 2002:a05:6a21:1707:b0:1f5:889c:3cdb with SMTP id adf61e73a8af0-1fe42f2a1fbmr34992686637.8.1742975586292;
        Wed, 26 Mar 2025 00:53:06 -0700 (PDT)
Received: from localhost.localdomain ([39.184.61.9])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af8a2803d8csm10330068a12.26.2025.03.26.00.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 00:53:05 -0700 (PDT)
From: Zheng Yuting <05zyt30@gmail.com>
X-Google-Original-From: Zheng Yuting <05ZYT30@gmail.com>
To: 05zyt30@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	meetsoni3017@gmail.com,
	Zheng Yuting <05ZYT30@gmail.com>
Subject: [GSoC PATCH v9 1/2] send-email: capture errors in an eval {} block
Date: Wed, 26 Mar 2025 15:52:45 +0800
Message-ID: <20250326075246.2612627-2-05ZYT30@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250326075246.2612627-1-05ZYT30@gmail.com>
References: <20250324145332.571813-1-05ZYT30@gmail.com>
 <20250326075246.2612627-1-05ZYT30@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Auth relied solely on return values without catching errors. This misjudges
non-credential errors as auth failure without error info.

Patch wraps the entire auth process in an eval {} block to catch
all exceptions, including non-credential errors. It adds a new $error var,
uses 'or do' to prevent flow break, and returns $result ? 1 : 0. And merges
if/else branches, integrates SASL and basic auth, with comments for
future status code handling.

Signed-off-by: Zheng Yuting <05ZYT30@gmail.com>
---
 git-send-email.perl | 43 +++++++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 798d59b84f..0f05f55e50 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1419,7 +1419,7 @@ sub smtp_auth_maybe {
 		die "invalid smtp auth: '${smtp_auth}'";
 	}
 
-	# TODO: Authentication may fail not because credentials were
+	# Authentication may fail not because credentials were
 	# invalid but due to other reasons, in which we should not
 	# reject credentials.
 	$auth = Git::credential({
@@ -1431,21 +1431,32 @@ sub smtp_auth_maybe {
 		'password' => $smtp_authpass
 	}, sub {
 		my $cred = shift;
-
-		if ($smtp_auth) {
-			my $sasl = Authen::SASL->new(
-				mechanism => $smtp_auth,
-				callback => {
-					user => $cred->{'username'},
-					pass => $cred->{'password'},
-					authname => $cred->{'username'},
-				}
-			);
-
-			return !!$smtp->auth($sasl);
-		}
-
-		return !!$smtp->auth($cred->{'username'}, $cred->{'password'});
+		my $result;
+		my $error;
+
+		# catch all SMTP auth error in a unified eval block
+		eval {
+			if ($smtp_auth) {
+				my $sasl = Authen::SASL->new(
+					mechanism => $smtp_auth,
+					callback => {
+						user     => $cred->{'username'},
+						pass     => $cred->{'password'},
+						authname => $cred->{'username'},
+					}
+				);
+				$result = $smtp->auth($sasl);
+			} else {
+				$result = $smtp->auth($cred->{'username'}, $cred->{'password'});
+			}
+			1; # ensure true value is returned if no exception is thrown
+		} or do {
+			$error = $@ || 'Unknown error';
+		};
+
+		# NOTE: SMTP status code handling will be added in a subsequent commit,
+		# return 1 when failed due to non-credential reasons
+		return $error ? 1 : ($result ? 1 : 0);
 	});
 
 	return $auth;
-- 
2.49.0

