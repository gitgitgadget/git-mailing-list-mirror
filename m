Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BA0200127
	for <git@vger.kernel.org>; Sun, 23 Mar 2025 02:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742696491; cv=none; b=uAIxsaWmakSS0MA1J0NAvdkFKvQ+5ns7dZYR6uwoYhmjymva0HnoAcaiO/FlFeSEg/lsu2YQEPaZvwd7rV+g6pu4ISale4csOifRdqAVyoeZr9RQpvIcs7soCiu2hn31sYRnAdWBFR8I1nbrmt6I0dhiqbMhe/o0rkqCTM0S694=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742696491; c=relaxed/simple;
	bh=nKhvXlc9VUII90V9y72s85XoWwWJsAf0yjAam36cztE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rlD7XPUoHm5yRWpzUmdasRindVWbZvJjxp85ssYpWORQ+2W1EKp7wJIvKyl2eaY6I5VnrCHTNgFUoQMeBwfFrom9c0g+L6datPTPHpnko5H590FG8hDcS7zmlBKFRNv6ClSFP5isIM3mZx9SayOtbBcofdhxQrW+vGqZv/9YINA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TuQ5y72/; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TuQ5y72/"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-227a8cdd241so6794755ad.3
        for <git@vger.kernel.org>; Sat, 22 Mar 2025 19:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742696489; x=1743301289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oRR1coZaRVYg9azhpKZc62eH1qYjUJErx0dIYunF7Sw=;
        b=TuQ5y72/pbHNwWcLqrr46YMEo8cT819CutRsAYu7l+rladT7Qn0hpWF1a51APRFV1k
         3cZa61PurGmZV/LhP4CaUnEywxPGTtPAOhRlQb6FcYpoVYFT9Y7/UwQqA5ahZn7n7kt1
         CUWpvDPO8NVjLU2WaUWDszXPPyq2AXB3M5KDWjpYmHjHHRD4Jz3Q4gAOwvY4LhG0GPqz
         5e8yt5ZkeLFocMZjPcqq0hozEIUoAaLj/eIdycp0NaNPUBtpH/6ccqm17F7MqH8dOpiK
         IGwdChVJuKeWOVW4JG2yX4hu6kZe0OUByAmS1QJe4mnkfCDD0Tjk/3zHvzQYCIYie4Yk
         fiFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742696489; x=1743301289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oRR1coZaRVYg9azhpKZc62eH1qYjUJErx0dIYunF7Sw=;
        b=HYbYfnEMdoIBAdUyMqnpMQMpH0vlTog0TC2T8P6PX+iuQIzHwgxOGhllpDAEVX+f4Z
         1QboNvXZTsR8DYHnJ6N1b7fJrBYQ1cWUMkYGvHK5AFhM71ZhqhJs1Ynr8bqfolpeDByZ
         LZASzSQ4YySsdqetbNdpUf06Q28e8KWNMhryGdhUacLk1Lcld7uqLu5yHgPc7EHqQnBb
         t5Rt4Y8NvQdya7ocCg5up1x8KyzRmvQfI53kYSvWC32jRLvYb04QYtkaKP684cJPgJTh
         mSqo6Fnod+7xwN8A1SnhslG2aSQswnA04nZCMGjbbTuMdzXPWDKme7Cy9UnCEXo8AGsc
         3PXQ==
X-Gm-Message-State: AOJu0Yy/GjPySkuK+3o28uZ6n435mvVPvqgPpJINyNmL4hYryvihxrh5
	OTiCzV71uUQiWwKnY7i5TumnnpVIGbTKN9W2//goZwndizVWBb46a1p8YolWmps=
X-Gm-Gg: ASbGncv0/sSw/CyhQF7+2Df5EIl/C9ErGxVh3WK6VU1odqvSS7H7sddbEq85A6zGsPX
	3ctcaNbntavMIV4ufZKIfM2BFXjNK1BZy8AB45RqVk53EFluARQGPPxBBE5GYob0CVN8sJ+grT4
	eUfUaygwuemSdhZP8cencB+7/sQxeHdR1lxrfOkWz+ilbCLQ2/ifDHis2kI/U34h+w+0w9mmz1h
	ds7Zq1Jj+PR13EP7zrnO/8kI8Ms9dVGh1injkPsNS6Gl3VoE4705bSdikFGtOGpLbaLBnniOX07
	l2t01LO1+j1W6uxwblxhtMoSuxJULpQ2heZzcoARNG7c8TaH90+C
X-Google-Smtp-Source: AGHT+IHwUiIgZBUx8nfBx6JX9X+p1eV39Kwxw26IjHn1pbgxsTKJI41nblBJMcUD9QDLMqvrjtv2pQ==
X-Received: by 2002:a17:902:f64e:b0:223:f408:c3dc with SMTP id d9443c01a7336-22780c50ab6mr141103485ad.9.1742696489330;
        Sat, 22 Mar 2025 19:21:29 -0700 (PDT)
Received: from localhost.localdomain ([39.184.61.67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f3a2e0sm42817135ad.39.2025.03.22.19.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 19:21:28 -0700 (PDT)
From: Zheng Yuting <05zyt30@gmail.com>
X-Google-Original-From: Zheng Yuting <05ZYT30@gmail.com>
To: 05zyt30@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	meetsoni3017@gmail.com,
	Zheng Yuting <05ZYT30@gmail.com>
Subject: [GSoC PATCH v7 1/2] send-email: capture errors in an eval {} block
Date: Sun, 23 Mar 2025 10:21:10 +0800
Message-ID: <20250323022111.20226-2-05ZYT30@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250323022111.20226-1-05ZYT30@gmail.com>
References: <20250321025128.68463-1-05ZYT30@gmail.com>
 <20250323022111.20226-1-05ZYT30@gmail.com>
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

