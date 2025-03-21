Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA801E51F2
	for <git@vger.kernel.org>; Fri, 21 Mar 2025 02:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742525514; cv=none; b=HDYljOCx7imRG6W4pU5Q2AMQgcX3Fm0mpg8arioQTnM5T2fwkzx3VGsVEquagVj8/BpqTxO0EC6qrzGVQW5nJwxEIqCSuh7pao1p1Tpby1dwS95uz1JNXd7hgZAcRoDv++Jywcg9CiDevGIfRtsMvSzMm5izDZfRSTvvzQMPKJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742525514; c=relaxed/simple;
	bh=totuXfzUshR0g2AgFZjjJn9EkkByT7CsiuSsl90O84w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HYkaFGdfkUJnxCz6XvHYUMkFC1RJsUY592wksYlVX3ZcKnPyEmag9OL0m4Hd4kFrI58/So68ATygPThIKOXzWLni8h94AlNa9KWajqP/JKXrkOMJCRQi/x0aE7j5xXX1K1G0QH7Ox5hguSQDifxvHnPgY9x/b+2OW6HnnciJgtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LGvumA3A; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGvumA3A"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-301918a4e3bso2799013a91.3
        for <git@vger.kernel.org>; Thu, 20 Mar 2025 19:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742525510; x=1743130310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7mOA1YZhOX2eTonvPGr8pvWi++Ajpg7zb3WxIat1feM=;
        b=LGvumA3AluomAGsJi9Be89gL+Af8sE3JLQhr44Cjupwg2+TtKYnGW8yJ24iNuVSMfO
         BeGEvGjB0N12y0GSjsKcnqNTjPLXzpcnpKgtWfDKYhMhRmJoxdDILfViYp99nX8MWOZi
         dSSAql4mGwqsyORqlZK9eBDASYl+dE1iNu1yO2VyRIRarbdVl/qAEjeZJ/qmi7ZQ0gRL
         I13JU+gErGIlJu5cxzqs+KaJFhGJ6Ihxtni7NZDJSwy03reiZ8bEEfyfL5ioLvIUrvQQ
         7oU2EhHO63JngL/+iufuAZZYqeY5KRkB/Behzdw4u5r+eXYRfKuPyBozd6I/Sa2lUf++
         /SHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742525510; x=1743130310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7mOA1YZhOX2eTonvPGr8pvWi++Ajpg7zb3WxIat1feM=;
        b=HVo4z88f80eESVmDylQEd6ZxMBbfj0NN+MtiS+mBoWOOmoovvmNjm707Psg71Ahly1
         up/EIcMA7eyL55IaJ3gPHikAqEuk88Wc+oKQE98wrEwzrP7BU3pZxrt6Hl78GwOImMOC
         XMH5G5gatWuDzxIcY6T35ADqizxvV1I4PW1Uh/HQBO+9y4S11oVVAkEK1T/Cm+hVezkQ
         o/eUrlg+NNSOMaqZnNOTlfBbNXyhG8fsB+bKutGBqR49cTgw9r3Dn2DMbHoe4Bl3Exa0
         vatv4WrjxFICwvSfcOfKfLOdPJcUn6HUsLn5rwkf7QJdsYjhCleHRg3Fa06vAInqEMfS
         /y4w==
X-Gm-Message-State: AOJu0YwXd7294f2+V/2p3F5HGHjqVsKj0i7hoXApkjunyOkkFB/ZvqJY
	jrce3dJk/l7A4+K78P+/WeIPzOeZCna0YcWZdKdg+vhUlLJ9z9d1UFrOG4JwPyc=
X-Gm-Gg: ASbGnctN+VGWpwSho3mRhgInIf2uJbdjWvijIJQET/+agpBPJeBQmLK4b1ICjg29vy3
	aIeMSZ9345x+ouRSJEAQihHS3jeGrUzzETxEenME8zpdjUJ8l+PBCQfYmv8H5m5HEMuPpKArLSZ
	FEXL0W+rAXdJfzq2LLhr5+d1ekhmzpXotD4P2YBOZNBNksaPSibq/3ijIVnfNhJ/XQBalnYGrGj
	kMJbaQNBbr2RnVrdZXzLld/O4H6CGWXCv9dffFpHw/j3sg4DQG6Kvv/4k8IBu0lThdqzHWDO7r5
	zrj1Q7uhXFyIB1iivnaTwbby586wfDngi/9KWm6XTWD4YHai96p4
X-Google-Smtp-Source: AGHT+IFpIfVI74xIFEnPg8tkGszBBauGlPaoFJprJMGWR48mVvdwCuVb4WMDollmDDWGKewLwiuz7w==
X-Received: by 2002:a17:90b:2247:b0:2ff:64c3:3bd4 with SMTP id 98e67ed59e1d1-3030ff046fdmr2315102a91.31.1742525510511;
        Thu, 20 Mar 2025 19:51:50 -0700 (PDT)
Received: from localhost.localdomain ([39.184.61.67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811bae9asm5591395ad.138.2025.03.20.19.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 19:51:50 -0700 (PDT)
From: Zheng Yuting <05zyt30@gmail.com>
X-Google-Original-From: Zheng Yuting <05ZYT30@gmail.com>
To: git@vger.kernel.org
Cc: 05zyt30@gmail.com,
	meetsoni3017@gmail.com,
	gitster@pobox.com,
	Zheng Yuting <05ZYT30@gmail.com>
Subject: [GSoC PATCH v6 2/2] send-email: finer-grained SMTP error handling
Date: Fri, 21 Mar 2025 10:51:28 +0800
Message-ID: <20250321025128.68463-3-05ZYT30@gmail.com>
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

Code captured errors but did not process them further.
This treated all failures the same without distinguishing SMTP status.

Add a regex to extract status codes as defined in RFC 5321:

- For 4yz (temporary errors), return 1 and allow retries.
- For 5yz (permanent errors), return 0 as failure.
- For unrecognized codes, treat as permanent errors.
- If no error occurs, return the authentication result.

Signed-off-by: Zheng Yuting <05ZYT30@gmail.com>
---
 git-send-email.perl | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 8feb43e9f7..69ba328653 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1454,9 +1454,30 @@ sub smtp_auth_maybe {
 			$error = $@ || 'Unknown error';
 		};
 
-		# NOTE: SMTP status code handling will be added in a subsequent commit
-		return $result ? 1 : 0;
-	}
+		# check if an error was captured
+		if ($error) {
+			# parse SMTP status code from error message in:
+			# https://www.rfc-editor.org/rfc/rfc5321.html
+			if ($error =~ /\b(\d{3})\b/) {
+				my $status_code = $1;
+				if ($status_code =~ /^4/) {
+					# 4yz: Transient Negative Completion reply
+					warn "SMTP temporary error (status code $status_code): $error";
+					return 1;
+				} elsif ($status_code =~ /^5/) {
+					# 5yz: Permanent Negative Completion reply
+					warn "SMTP permanent error (status code $status_code): $error";
+					return 0;
+				}
+				# if no recognized status code is found, treat as permanent error
+				warn "SMTP unknown error: $error";
+				return 0;
+			}
+			return $result ? 1 : 0;
+		} else {
+			return $result ? 1 : 0;
+		}
+}
 
 sub ssl_verify_params {
 	eval {
-- 
2.48.1

