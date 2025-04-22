Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938CE238C1C
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 07:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745306358; cv=none; b=cA/1eM/yiXwZG43T6B4sFSk4kxi8fG5JNc5cfWMdO+BZ4dgmM//1fTGlyCLCOkC6PxS16xyM8E5YAuviivEpan5l+AUUDMITL3Xo+gZz5sFB62+5wcQH+q4I/IG/sseisSexK0plLcOpyGjJvxIInUd83QSfRxzfLTmgSEXd+1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745306358; c=relaxed/simple;
	bh=PTsI7BtcdZcK8XOKXrRpINfUIxr66iA7eVtWoOV0Qdc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Lzih1ZBjBi/kSSjRxTP8FuxsdU//+W3ZZBKJx2GVs6YhtJl6/6w1G4JfIpYxIy4pNrDOHWC/SxdwIWnVSAyoUZWW1AVFQBNssJhYwpw7U9HdP9gFJrBn9JvOCrodkSn+UrZdfSOPBqBXCJXY9unKQiI+KuAsT0kFJLLEjaPSp1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kD8qn+0z; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kD8qn+0z"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso52238295e9.1
        for <git@vger.kernel.org>; Tue, 22 Apr 2025 00:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745306354; x=1745911154; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FBeFS2mmDd/KNqYgjAVvkm4so3rOLpwhFFQTmA89EpM=;
        b=kD8qn+0za7Wo8o8hCkawywunroq99fWXKkGaOugDa2XsFBNC8lwLMDPoLs1cDZ8lDK
         eVp7fN3Ac0UfCMkGK43ibfgMRDw4qomenHS3zYs8OyOc3diKT/zu96mZsCkfiQ7awmOI
         J/IUFBeCFnF7pfSFUSrQm8tMhfNpfyFwyWC0AQTDoNfvzHYRg3gcwS2tXUKULOSqvW1C
         Qic9ppWfs90Hk3JBXgyYOsInrdPOokl5G5nRQ3OI/LRW8wIQUhMzsWUIwYKPveJZhzRc
         m2sZ+464hfzW6fRCaat5hbUS4f20pH+NA4XgEfLdwJJiTbHuY5J1+55E5wt+NKg5GkjV
         vXBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745306354; x=1745911154;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FBeFS2mmDd/KNqYgjAVvkm4so3rOLpwhFFQTmA89EpM=;
        b=R3BCMukN0Wmv5ZY3V+biMsjvRGh0D2BpZBqMNfpOXujNpJw77VANdRQe3kJiZyNp2u
         mWbVAWJ2JXBM8C6Xy+voOYJ9FF1iMmpcJOirrenwMbh0Jbep2UAZKQ4w2zUWU3dtEznK
         VazNOu/tbW5T1fTbu0gfktAuDsNdaPSFFX3iBvpGZONaloXuLJsszPA3cvIyFigwfrP1
         x+8uCd5Jb3n5fDEkaVMBq3aQ00m4gbar2xVQ6AwejayXAqnp0geLnOGGdCi+vsKfnrk8
         GSJU+DQM037lrJ2VaBqsowFPnu9wZZTS0uz+f+EnoGFtUg17pPWpwGSsA9qEBD/cI2SR
         CKqA==
X-Gm-Message-State: AOJu0YyygAFjNZFBVjDA1jqjprHRwPtr+SuOI50dK+2OrVixtjeGbfsy
	sX5No7vAChHBjTmIJ78+atg3zBu/M8Aqg3feZke812c1lBad7ofph9GWJQ==
X-Gm-Gg: ASbGncsELyXRDZ67nRaCnnnzuSQPobF3o7p4g1NO6NzWq87SfhKL32v471/vPjDCl1K
	OsF0AH5kn1Nc24gTz5X7FkAVFMjww0cAHtNMf0CIxpXWi8ynxM61sjxvrOHuxcNnXYfvu3XTGAI
	snJD5Xl1MFXKW36U1HZmcBFrVLcKklDpgYFEkZ0t1cr9z+Mmx86L7+riM9592ueRdkSgJPMo2Uw
	968+U7gyKgNlJng13ZHdVJNey85xW/1+xPBP4DOPDZFLA2YQH3RZmCC14BzXX027Mqxw9VSSRCO
	5z50KOcfGyZAP1L2AEBN5UjF/pk1laSySlJMXdwAXw==
X-Google-Smtp-Source: AGHT+IGQLhrsnzLnTRh7tjQl5jo3XnoSHmGEImDEDA+9gGRJU+hR4ezwDk6vQwN2UUfbuM59+5vVbA==
X-Received: by 2002:a05:600c:4f94:b0:43c:f3e4:d6f7 with SMTP id 5b1f17b1804b1-4406ac1fd21mr124273235e9.31.1745306354332;
        Tue, 22 Apr 2025 00:19:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa43d22esm14358216f8f.52.2025.04.22.00.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 00:19:13 -0700 (PDT)
Message-Id: <00e1be73ab91db1c37447544ebcdc4f33432dbcb.1745306351.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1949.git.git.1745306351.gitgitgadget@gmail.com>
References: <pull.1949.git.git.1745306351.gitgitgadget@gmail.com>
From: "Aditya Garg via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 22 Apr 2025 07:19:10 +0000
Subject: [PATCH 2/2] send-email: retrieve Message-ID from outlook SMTP server
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: M Hickford <mirth.hickford@gmail.com>,
    Julian Swagemakers <julian@swagemakers.org>,
    sandals@crustytoothpaste.net,
    Shengyu Qu <wiagn233@outlook.com>,
    Aditya Garg <gargaditya08@live.com>,
    Aditya Garg <gargaditya08@live.com>

From: Aditya Garg <gargaditya08@live.com>

Outlook does not accept the Message-ID header in the email body. Instead
it saves it in its own proprietary X-Microsoft-Original-Message-ID
header and a random Message-ID is set my the server. As a result,
replying to threads does not work.

The $smtp->message variable in this script for outlook is something like
this:

2.0.0 OK <Message-ID> [Hostname=Some-hostname]

This contains the Message-ID set by Microsoft in the first <>.

This patch retrieves the Message-ID from this server response
and sets it in the email headers instead of using the self generated one.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 git-send-email.perl | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/git-send-email.perl b/git-send-email.perl
index aa6aad596f2..f2a926872de 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1799,6 +1799,17 @@ EOF
 			$smtp->datasend("$line") or die $smtp->message;
 		}
 		$smtp->dataend() or die $smtp->message;
+
+		# Retrieve the Message-ID from the server response in case of Outlook
+		if ($smtp_server eq 'smtp.office365.com' || $smtp_server eq 'smtp-mail.outlook.com') {
+			if ($smtp->message =~ /<([^>]+)>/) {
+				$message_id = "<$1>";
+				print __("Outlook: Retrieved Message-ID: $message_id\n");
+			} else {
+				warn __("Warning: Could not retrieve Message-ID from server response.\n");
+			}
+		}
+
 		$smtp->code =~ /250|200/ or die sprintf(__("Failed to send %s\n"), $subject).$smtp->message;
 	}
 	if ($quiet) {
-- 
gitgitgadget
