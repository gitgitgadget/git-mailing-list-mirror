Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12C3290F
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 02:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742349763; cv=none; b=f8I2E9MIKy5uSvtFGFFYnvfMCDL9twMzm2FybNoiLzG8wkanFRJ4ZJe0LOSpTesGoMdDpS+oFJB64YvuDKjKjVC466Zh3AQB99qk4gAslhnbR+1iNN1vAsdzqaCL90TsK8u6eAJHUnTX416XA+b0Q0QxgYfuNoi/0MN6eGTF4FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742349763; c=relaxed/simple;
	bh=CYI89cx+H6SD4+2yK0zLvbteXynxuj1dUuGO1k/dEoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DzwHYSHD2fahxmubQGngEtnoKuodtffCdUc4g8DQuoWBYRGx+XN8z904JygtdMd7GO1NgDlyPRiBKO2RQZDtuoSCQbUXABTDaYSyUgoL/UdyT+LZt2guREkQnKT+AQ5QX/SsuwvaubRCYaPayT5azRZnUW0fF9+Yw7IMJAmLi0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XloPAy1D; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XloPAy1D"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-225b5448519so121297765ad.0
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 19:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742349761; x=1742954561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hfZFpjzX4DW5AEhAeMl6GJ9xLv3JCepTmde0X++bWs=;
        b=XloPAy1Dz5zM9U23os6HBjz7/Lo1+KEhha2nN+9yFiavKMf1XnIXT815qrj3kIp/Xv
         cqCF8k/Vf042DgMufEiIOS1A0abRzDrvY2cyVlV2d5OfJAHNZxPjTt6CJef86bLVRCAh
         rilS3g+4RHAaBMvljaS4h4/7j4WSOVhrPl+AFfyiEvl+Yt1Broug2+Ift8adGOCNMsYZ
         CKqGQ34eFIB4tqovuoYaQRQ0hANm0FtT/+ZZ9WGRhn1wb43tusrWmrnOEOBGt0qikyEt
         HMkjGPnZ7clNuMJ+wsGrZgitkWrxoPuI3mAA8PQqeunM7ivjSuuhjPGmDijeY7REqPgl
         nZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742349761; x=1742954561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1hfZFpjzX4DW5AEhAeMl6GJ9xLv3JCepTmde0X++bWs=;
        b=mS5rytmMUcnlrNFgYvbyEUCqqYAxGy7pXOdQwbp/E8JGA8UHEDfe4v9hql6xnx2rBF
         V4MDYC2SKufb1P3LMCrYUkM9joJRZDRElVHvVygQWOpY9WkoFPzsefslKfPrr20qf/Gz
         kHcZhoOi49VrFbNM2g2kC7rGjrufdbM02Olyvv/lAVybHBh1Dum00maEg5rhyIE/GM8W
         7K60ACORJ+x7M4O1Ncc868FF0kPyZYemUV88CO2lL4IPluCLRsWE4dRY2W1Xcchg3JYV
         eqsbKE02Qw5Tg/imCqvNS68PcbId9W2fb0MHDVGeZcjTbSywqx/M183GPg/oCp5yYelY
         xy3Q==
X-Gm-Message-State: AOJu0YzALVEg+2rBpzOSRNtfOxf5GjiSXDm3iv35DmDZWSUOtazt+2o3
	BpojO7JuHs1uDWa0/mfY293KmQVLg/mPm769iI0t6LW7vNZnnJxdk58YsMZ1
X-Gm-Gg: ASbGncvtew48sml191NZ4PjX5Cg1bgFuTkajm2nvir89/htPM39JSqAFk/OO90cEkCN
	mycO7G+lbCQfwrT+qJSK6/sczS85LvHSXA30wb20Wc7uy/tAdkEZ2U1gbCika1F6hVMFgE5oxcf
	ZisATjG3zfowd1wkXTkR7FuM+p8KIpVHTxka88M2hfqO2BevT9Fp8ckwg45Orw1hzvNOGRJYzvK
	bJQ/4IeLdUCOdS+9edjErzrZJ9AyisB8AS9bqL0ayJGp5imz74w4rcGFXZ0JPT5HDkhiFOs+fC6
	J8MC/rlxSdesKu8Q+LwA23Av5INShgxs5Gq2hoziYdAWMcINqh1N
X-Google-Smtp-Source: AGHT+IHeYVIia5wqTwticfxYV0PiFPot5+PVqn6+9oiq3KqipC9ClF1Z8ZFYV/m4fzgWBOVWrAEcqw==
X-Received: by 2002:a17:903:32cf:b0:224:76f:9e59 with SMTP id d9443c01a7336-22649928306mr15028475ad.10.1742349760974;
        Tue, 18 Mar 2025 19:02:40 -0700 (PDT)
Received: from localhost.localdomain ([39.184.60.80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68aa616sm102516965ad.93.2025.03.18.19.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 19:02:40 -0700 (PDT)
From: Zheng Yuting <05zyt30@gmail.com>
X-Google-Original-From: Zheng Yuting <05ZYT30@gmail.com>
To: 05zyt30@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	Zheng Yuting <05ZYT30@gmail.com>
Subject: [GSoC PATCH v5 1/2] sendemail: capture errors in an eval {} block
Date: Wed, 19 Mar 2025 10:02:20 +0800
Message-ID: <20250319020221.2160371-2-05ZYT30@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250319020221.2160371-1-05ZYT30@gmail.com>
References: <20250316050920.3264895-1-05ZYT30@gmail.com>
 <20250319020221.2160371-1-05ZYT30@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Auth relied solely on return values without catching errors, misjudging
non-credential errors as auth failures without details.

Wrap the entire auth process in an eval {} block to catch all exceptions,
including non-credential errors.

Add $error to store exceptions for future handling and $result for
auth results.

Uses 'or do' to replace direct returns.

Merges if/else branches, integrates SASL and basic auth, with comments
for future status code handling.

Signed-off-by: Zheng Yuting <05ZYT30@gmail.com>
---
 git-send-email.perl | 45 ++++++++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 798d59b84f..8feb43e9f7 100755
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
@@ -1431,25 +1431,32 @@ sub smtp_auth_maybe {
 		'password' => $smtp_authpass
 	}, sub {
 		my $cred = shift;
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
-	});
-
-	return $auth;
-}
+		# NOTE: SMTP status code handling will be added in a subsequent commit
+		return $result ? 1 : 0;
+	}

 sub ssl_verify_params {
 	eval {
--
2.48.1
