Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E176E14A4F9
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 12:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741351203; cv=none; b=QsyEbaRVjDa/Guhh4e6XEglmlIsyogLftaUQT4zH8DAVc01+H1ZGSLfKb/9+9o7TJuYAKqX9sduFj2/AGDI1AqAaJYT+KkQg2WJCUzV4HXujUW3qoRv1eXKFrO6q8+NR8SpHi7aqy+hGYXSxZvGOJ1Fnn7kKNNztg/c4cVDJc2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741351203; c=relaxed/simple;
	bh=ngqXLJzT9E8WI8K+/77nZnk6PkZ71aQTQdZC5dQKGrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BAgztZfyuHl8GqeadWn6UhjN3Bh1wmWOwPmmlxAomLCwT8BMjSAzNFUr5UodHn2wF5tJNCXGSN0MnNV8YoXken8CixZiLcnYyPYj+T7eN+lp7Yla2LrZ3nPNUv965fn3U1haFQsK2J5YUx8nX9ZgrtiVXIc8QAN15iR/hPBAlJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dRElHw4X; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRElHw4X"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22359001f1aso44536825ad.3
        for <git@vger.kernel.org>; Fri, 07 Mar 2025 04:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741351201; x=1741956001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+FI5cc+nOI4qdPzOAN1dTfUN4HjT76BDJX6n0rFZ5A=;
        b=dRElHw4X4CRSfqMXfnfvh8evG6MauoPMcp9ceE3AeoFGigxiqooynXhitcaVkUI4y9
         CKCSEpBV77KwazEwaVTt2UuPMQrkEhK/FH9vtv1UQJ70lpqfmDnKgN7RcsapePUINT6W
         DGFAdwP2Q+aQJ7jHN5XDNMZjm4obgCQ4L/vbq1yGpmi2J7cKqRfYYquZnLDfWLJrp7eo
         RHLtAx1QJFoVqApmtxlxr/0CwcIwimuS4ai5NIdJ6lCxP0/Xb/wd7yARAOG59uqbCsf2
         p+jN0NoWZyilvx7KOTqMoPB+vGaNF3BDCrKRWWuu0paWSiVYhfMu6q9YW/G/zBLnfIAf
         CG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741351201; x=1741956001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C+FI5cc+nOI4qdPzOAN1dTfUN4HjT76BDJX6n0rFZ5A=;
        b=OGxFb4Wo1JKto99VpUkGaFEyclJYJXh9qG7yD0LldHY1j2rCn6aPOGxAT+/TS+emEM
         5Z7Zxh4rdeZRXV4roFJG6cD/xKVqC3xAhBL9HHEMzB0V/s0X8e/mIUNlczbeu/YtBgHo
         xe3pvShHat+p8g5qhR4qw67M1JNe1kRk64SiMB4nUaX3UrByOlGwU0BrwdH9yTj5k2lz
         mbYxE4XoDLqnfvs2HYz0OOSEzbdCAjm9OdUjkUOT5QooZ5v7iyiEXJ1j4I5WdSNYO+0r
         njJYPLL4J/OhYB/W5CPMCnRp4XOWfT+Nw6fCa7jKTUVK9J/OZQraGJoDJJe9mlxLyJvk
         ylFQ==
X-Gm-Message-State: AOJu0YzUdKCSNIJ/CpQRLjxwn0zvozK/EnZvxK/5v8i3QI29n31CAPQ8
	1EUKmHSb2HuQ90jdZTl59+TweCVvwfKSfH+jdBB+zISOAVlm5DE7vg1TTACa
X-Gm-Gg: ASbGncu6E8+3FryjpqBlTzkRDWYaa4y6GWnLkJW+mbhtVamE0dGO2tdr36iV8T1bFlO
	kGQMyWuwbfETWuosUF0cOvq6T4FMaiWhIy8DGCgDYjqngJNaRFTV2izrkBjdWSYVe5psF1Vtbqx
	A119D8+/b4OoJPP7e3LeTpRbOFQ25u3fa67HK+EvX+sraB7EBdsjX5Qv9OqrmFJLpiZjdug3a/h
	OBflH1P71YiC3rkpAbQQmL5DLZiIVDiQxQYyTS0eMnLmtbm4MduREYUX+WrrHjZJgk05EB9sniR
	pWiw7daCP/xHonvYI/TrJXXHjjRpXTMBVv+dQeUsRhgaC2bfDfngMw==
X-Google-Smtp-Source: AGHT+IHYVpWefwoyk+GLcRt4/Extl0jZCfHK8GNJeLwb2dUkoHGQnJC7KKb+YE/+V4BRMioUiDMM4Q==
X-Received: by 2002:a05:6a20:a128:b0:1f3:4839:229b with SMTP id adf61e73a8af0-1f544f661e8mr5381650637.35.1741351200751;
        Fri, 07 Mar 2025 04:40:00 -0800 (PST)
Received: from localhost.localdomain ([39.184.61.194])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af28870cc98sm2232975a12.26.2025.03.07.04.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 04:40:00 -0800 (PST)
From: Zheng Yuting <05zyt30@gmail.com>
X-Google-Original-From: Zheng Yuting <05ZYT30@gmail.com>
To: git@vger.kernel.org
Cc: Zheng Yuting <05ZYT30@gmail.com>
Subject: [PATCH 1/1] Improve SMTP authentication error handling logic
Date: Fri,  7 Mar 2025 20:39:23 +0800
Message-ID: <20250307123934.2064275-2-05ZYT30@gmail.com>
X-Mailer: git-send-email 2.49.0.rc0.57.gdb91954e18
In-Reply-To: <20250307123934.2064275-1-05ZYT30@gmail.com>
References: <20250307123934.2064275-1-05ZYT30@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 git-send-email.perl | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 798d59b84f..a012d61abb 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1419,19 +1419,19 @@ sub smtp_auth_maybe {
 		die "invalid smtp auth: '${smtp_auth}'";
 	}
 
-	# TODO: Authentication may fail not because credentials were
+	# Authentication may fail not because credentials were
 	# invalid but due to other reasons, in which we should not
 	# reject credentials.
 	$auth = Git::credential({
 		'protocol' => 'smtp',
 		'host' => smtp_host_string(),
 		'username' => $smtp_authuser,
-		# if there's no password, "git credential fill" will
-		# give us one, otherwise it'll just pass this one.
 		'password' => $smtp_authpass
+
 	}, sub {
 		my $cred = shift;
-
+		my $result;
+		my $error;
 		if ($smtp_auth) {
 			my $sasl = Authen::SASL->new(
 				mechanism => $smtp_auth,
@@ -1441,13 +1441,27 @@ sub smtp_auth_maybe {
 					authname => $cred->{'username'},
 				}
 			);
-
 			return !!$smtp->auth($sasl);
+		} else {
+			# Handle plain authentication errors
+			eval {
+				$result = $smtp->auth($cred->{'username'}, $cred->{'password'});
+				1; # Ensure true value is returned
+			} or do {
+				$error = $@ || 'Unknown error';
+			};
 		}
-
-		return !!$smtp->auth($cred->{'username'}, $cred->{'password'});
+		# Unified error handling logic
+		if ($error) {
+			# Match temporary errors
+			if ($error =~ /timeout|temporary|greylist|throttled|quota\s+exceeded|queue|overload|try\s+again|connection\s+lost|network\s+error/i) {
+				warn "SMTP temporary error: $error";
+				return 1;
+			}
+			return 0;
+		}
+		return !!$result;
 	});
-
 	return $auth;
 }
 
-- 
2.49.0.rc0.57.gdb91954e18

