Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947D21FFC60
	for <git@vger.kernel.org>; Sun, 23 Mar 2025 02:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742696495; cv=none; b=usg3f6iZEpt4zRKQos58O/z0gBuRyrB1f2QnYiQmDXS5IMfl/oIiC2Dir6TUUmATA8uBhOxV/Xylbo5R9pVMRavqki/Nitivau71kPmc+k6tDpTATORnd8UHEUEGXHSEwo0ERr/mcqEOAZij5+XHpvHY963H7hpubTPzzcUzXKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742696495; c=relaxed/simple;
	bh=oqkjPJ7NEZST4lmA49o+n5I46WhDO503EIfMlYL5raw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F9RBbX6oyHan+Ux1Sbv9lyd220ycUPBiQX+6CCMqAJQwxwHqZDqVUMOXoznaMtPu9w9Bc3jXYoXr6muvOu3ls1TWk00COg0XoXmdQ9tV5GTXdGAiK6aiV68llwfc5+lGnAluME38ZAtoD2xeQp/ZNhmBP9T0nxkq9dxl7WX6pUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IwZiV/WJ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IwZiV/WJ"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22398e09e39so65133925ad.3
        for <git@vger.kernel.org>; Sat, 22 Mar 2025 19:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742696493; x=1743301293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0mjeY5zESViOTfKh22wrELCw/LcTTtYx3HNj1ORR6w0=;
        b=IwZiV/WJ3Udk8k1+xw2VcVy7vnjX20D90zt1KdIP0Z3Sxdec+jlUvORFA4Lyu5cSnE
         rV20ZZ00de1xDKOp+SQnVkel8FhoWXrqknls94p+y7aEPC7/sylB2i5dznMdsfw7USRN
         TkO0Ete/NVXoqE/dk49P4ppFCXDKChqlmHRG2huVzEkVPwqUyKDxmnCF8c6swA33T3P8
         1vSL8yfGE/NkcOhTmQnv3WnBF6IBfOzTtfO1cpu2LisqDRKi87st2FLZwDZI07bzgB0Z
         1I4Mgc1jRFsMxjaixWolmPYwOmH+OChJ74P5814diOZ6gada+Zsu7JRPsO76etzkpkGr
         ZOBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742696493; x=1743301293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0mjeY5zESViOTfKh22wrELCw/LcTTtYx3HNj1ORR6w0=;
        b=IxnZ0/Tpw4JMR/ZT9hUKnX/YGjO1qAFHE/gs2mkDCxGW9Rc7Cj27p8ypBcfx7/pe+f
         Yz1Ss1W1xNHfWYFJYV/BiM+wKPFM49EKFEmTRTeWxaDNlJJEWJqB822ynSl02wsoouGB
         Qd1nZ/rPahGpU46tSE0RaqHd4yFBevHPtvdpz1tmCsuZ2GjLGDMr3Ay5/OoYVpJ31yXZ
         Ahw5TOMzcTz+HiDdmrDqw7/aE45AW6IIZw9y+YJd56PXUZahC6ON/jO+fKMlBlI9q3bk
         KPOt8U0gYtnfkuks2urZmqAobiGSOnDCygIBIy/gOn9ZS0vubLRP7HYsanGFada5J21Q
         vb+g==
X-Gm-Message-State: AOJu0YwG+BIne/VcRQ5ZFOIjfkDj6YsLDufzTvaOMRqiWbRBg93WASkv
	edLHsOT+rc/PVxEW548ErlULZIrDbfTsD6lEW8tBu2tLtwuMDCXKuirThkGZ4h0=
X-Gm-Gg: ASbGncvIwAXKT/Aew3kX9M8NmjE4zkse6vioHJN7mlYFGgYFdml+ndiSERfUa50sINI
	UyZdE8zIYaM4m/u+py/VA7z7EyXRDpAbWlZzeTaZsBqxV+riRzN4nzYtcTmf99Gq1xNZWZp/XK7
	Kx0DV0+3t5R/F49FM9mT4SaOnY/fYSk4MlPrTwKuoAEvr9vPVO3BEZRduYbsJUIZ7zvGUm/Ugb+
	3j2iXrAd4C6UnM9YnYIgY2BpQMjHDM/iMaLcfL8dJ2QrNg5xTQU8kqtK3tzyDv0FarSfOptWQ0J
	/HDsQSDrf7Oad+gALXZqcy5yYiHnvOmG4/YS33Cz2ieZ09gvPZAv
X-Google-Smtp-Source: AGHT+IGLuPFI480Dq1mtrWbcj28ii5Qi3YJjE6ggsDqKfdU0gNOZQ75hRE1eR8EJQZKHl9xyL8VHHg==
X-Received: by 2002:a17:902:f609:b0:220:c34c:5760 with SMTP id d9443c01a7336-22780e3b33bmr128203985ad.51.1742696492760;
        Sat, 22 Mar 2025 19:21:32 -0700 (PDT)
Received: from localhost.localdomain ([39.184.61.67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f3a2e0sm42817135ad.39.2025.03.22.19.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 19:21:32 -0700 (PDT)
From: Zheng Yuting <05zyt30@gmail.com>
X-Google-Original-From: Zheng Yuting <05ZYT30@gmail.com>
To: 05zyt30@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	meetsoni3017@gmail.com,
	Zheng Yuting <05ZYT30@gmail.com>
Subject: [GSoC PATCH v7 2/2] send-email: finer-grained SMTP error handling
Date: Sun, 23 Mar 2025 10:21:11 +0800
Message-ID: <20250323022111.20226-3-05ZYT30@gmail.com>
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

Code captured errors but did not process them further.
This treated all failures the same without distinguishing SMTP status.

Add a regex to extract status codes as defined in RFC 5321:

- For 4yz (transient errors), return 1 and allow retries.
- For 5yz (permanent errors), return 0 as failure.
- For unrecognized codes, return 1 as transient errors.
- For errors where the status code was not caught, return 1 as transient
errors.
- If no error and no result is returned, return 1 as a transient error.
- If no error occurs with result defined, return the authentication result.

Signed-off-by: Zheng Yuting <05ZYT30@gmail.com>
---
 git-send-email.perl | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 0f05f55e50..e09a4a316f 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1454,9 +1454,38 @@ sub smtp_auth_maybe {
 			$error = $@ || 'Unknown error';
 		};
 
-		# NOTE: SMTP status code handling will be added in a subsequent commit,
-		# return 1 when failed due to non-credential reasons
-		return $error ? 1 : ($result ? 1 : 0);
+		if ($error) {
+			# check if an error was captured
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
+				} else {
+					# if no recognized status code is found, treat as transient error
+					warn "SMTP unknown error: $error. Treating as permanent failure.";
+					return 1;
+				}
+			} else {
+				# if no status code is found, treat as transient error
+				warn "SMTP generic error: $error";
+				return 1;
+			}
+		} elsif (!defined $result) {
+			# if no error and no result is returned, treat as transient error
+			warn "SMTP no result error: $error";
+		    return 1; 
+		}
+		else {
+			return $result ? 1 : 0;
+		}
 	});
 
 	return $auth;
-- 
2.49.0

