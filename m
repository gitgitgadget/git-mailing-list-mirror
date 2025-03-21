Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E26F1E51F2
	for <git@vger.kernel.org>; Fri, 21 Mar 2025 02:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742525509; cv=none; b=YEkhnLsD4szk99/MN89PvL7MhADRXBBpIlkZ6K5oE1NU9Phut5ai45yNkYZI+84QugDkEFc3RQ6vUECe+qFKKDH/lxLMbyCmIZnvuiXsG0u+QNZlCrlNL7W9EfMsH3y0H092IMvaccC3DqDlrzAO4QFhNcygwPWea3cj4248CIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742525509; c=relaxed/simple;
	bh=bM0Zm6RTStjSTSF59a3MCw42siAvD+qhnzUbGNKV2WY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uPtRqVU+8wHpXQ/BCHkceo/UwYxlJ1078gAImmY9BCsCQnCZMR/qDI9CQcDspJZssB9JjLV/beKUQRndE2VAPN0+3BBtGFbBjq7DEiyTGizgu856B52c05waZeC0GAIbzbAljWtFtXEb2LJqaazU28XH9Q0A/A+3HCeS0HSrMhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XeZPRinV; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XeZPRinV"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-224191d92e4so29342685ad.3
        for <git@vger.kernel.org>; Thu, 20 Mar 2025 19:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742525507; x=1743130307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TQc3FkaZauuu56gmZYov9zFLU+0jjThD9LxM/amNd44=;
        b=XeZPRinVlZxhI4CR6T79PA2EFPS22HBqEfvpb337h2/0PjgnzWlkSm3Wm9rOJN0hyv
         zdcZXswpR7hu/Z1LPUekyg3IRR36yD3BvRdNGY0Zcao0i1nQtQgQPPquqww3bfwfhiPz
         0JRQ9ZJFXjgd4cP1RvFP3bOfbw9WsSKcy+fhwXQ3XJLuw7J83BSG+Hnnu+IyBCcIXKOI
         i3+rMZ3AiOx1obrSCf0MIvbsWZp+LfuvbyU9DqdNFz1Xya8LqaUOpLfn+IAMH8cPSCQq
         gIAEeYCzWhwpxR7wxV3AEU1C60I2hXs/DR8VM5ahbfyGZBgdP+AIqZX73Os6o5VOTCWU
         A8Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742525507; x=1743130307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TQc3FkaZauuu56gmZYov9zFLU+0jjThD9LxM/amNd44=;
        b=pfREOub+3xV4vM+/opgCDq84FFaGyAJeP0OKs+XmQyflzVutrc2qgsMLDUGD9LwOE9
         MySJWiH6XG646flYwAkfg4oUWW4VR5nJZG6eZhSJkXwtHrcIvmbfkvXxE/lP7dUuc3oS
         YKuBhZKr3afMJXJIeL4cd8c3wjT0+Ju3SCkEKPTBVK9kdWVTabP8quZw5Wn8mOBO+fJJ
         OUS0NVpdWaicREzJbUKwsFweUlWEkPmcG2U/s/lzsE2jwu2WyULYv8HB7Z5Uc+cj2ahh
         +TFgJFx0fREAPRwsdYNCL27qnHzjj91QObahk2sEV/4PLbmRFPWdof4KI6jnfmPIrCNC
         p2EQ==
X-Gm-Message-State: AOJu0Yz627+HeFN45Y2jniXw8MHAKFPI4RbkyY/oiqKQ8I0j8Ukt7/fc
	oNpx9EcEPbrTaYFlqom2q6iWH7YRScYOFdo1Ug2IOv5Rjlg0HoJjnBuX6ubs/80=
X-Gm-Gg: ASbGncsX66qwlEULTa536McS9Tk5BiMVT8/QbzhemTohHZPiBBQ52PygVQwatNUB7dp
	ssrhM45XlR1WSeUjzqYgHyklEVOkkXshAgq1jdzrQV3yG5wkZOud/eMlY9f+QclpSvlD11EMJ0Z
	TVXqj0g4kmquqEC6Kx9zqmcJ/vSisj05JnpnwZEw+fwnjJu0/4hThL8+EukuqCLUUih+Lk+JdB8
	/mb3sP3grmdXW2u+lbn2pmhmcq9y+SXBORD1/iQKflOvx3Exl44pNHMHir2hM63EFeFkT8/faom
	rVhvdxU/b/QHkq3EQE5CGv4R8xaI9/Bmylu1RDE8owG0z7nU6drT
X-Google-Smtp-Source: AGHT+IEbww1d0E2piXL/d/v+J7enoVPmN6tXLPUPKPWlcjy9EUpBG+0D/kgdhPyKO/KdM70dAecS6g==
X-Received: by 2002:a17:902:f64d:b0:21f:6a36:7bf3 with SMTP id d9443c01a7336-22780d8b817mr31201245ad.12.1742525507614;
        Thu, 20 Mar 2025 19:51:47 -0700 (PDT)
Received: from localhost.localdomain ([39.184.61.67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811bae9asm5591395ad.138.2025.03.20.19.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 19:51:47 -0700 (PDT)
From: Zheng Yuting <05zyt30@gmail.com>
X-Google-Original-From: Zheng Yuting <05ZYT30@gmail.com>
To: git@vger.kernel.org
Cc: 05zyt30@gmail.com,
	meetsoni3017@gmail.com,
	gitster@pobox.com,
	Zheng Yuting <05ZYT30@gmail.com>
Subject: [GSoC PATCH v6 1/2] send-email: capture errors in an eval {} block
Date: Fri, 21 Mar 2025 10:51:27 +0800
Message-ID: <20250321025128.68463-2-05ZYT30@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250321025128.68463-1-05ZYT30@gmail.com>
References: <20250319020221.2160371-1-05ZYT30@gmail.com>
 <20250321025128.68463-1-05ZYT30@gmail.com>
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
