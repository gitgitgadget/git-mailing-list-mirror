Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A58579EA
	for <git@vger.kernel.org>; Sat,  6 Jan 2024 14:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCGY3ZWP"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33674f60184so515237f8f.1
        for <git@vger.kernel.org>; Sat, 06 Jan 2024 06:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704551924; x=1705156724; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M6uWoWXUTZn5CC6tOHrePVDSsQrv0JSG+kzZuSVkUY8=;
        b=GCGY3ZWPboqYtv2jeHxoA8MxmryeNOIOv1A7gT7x8jHh6y///FcO+Dr70/OIZX0QDq
         w6n9MNhCePkHRfSF7Y4Iw5pAg1+EtSR443koxIAKAZ6ciRNOaCufg0OlTiehqyXBVGYA
         Ghijz8hyzQJhgzwYuxuxLhCQWjX5aeUnZj00j3dvavZmEf8WN0oMyYm6Hm73XWbi2eq1
         QlvgfZU0BPt0lMZRqX4+qK24CGxQpmswCsm1CpaZO5OSPjn+R150mLg78TSuXg9+uOIp
         hgxepNT8j/Z1TsSWvzLLIZFTsD35hSf0YorBLHthL/HukHBhFhxs0pHAfawIoibuEcNt
         9PRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704551924; x=1705156724;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M6uWoWXUTZn5CC6tOHrePVDSsQrv0JSG+kzZuSVkUY8=;
        b=n8Q1yyDOxP6YU0iM8NYYtX2Gb+PoA8qNrAWuvP4OqmAChY/AIl8aAArQJjcnqSnLjF
         0FayXwFONMWEA9ouXDVKIXiqlF/o2Ku3YezBY+a1R32j0OZa13+Lk1lrL3I6BtVkeWVV
         39rhMpDXhVQCVzZFqo11yfO8eplYi1YNYx8UsPMw7bx4IBf2FJZzJiMp078iTGJzPlvw
         +5mBxSOrwDT7e1CHf2zNNEc13Mcg3K4iuw37zHz5rdOpznsj/p4/lDVcxk+w3oNKPHn1
         Coz2/v3FLq6VAu8waxanZUqUDltvoqMQreGdyzsQvSB+3fuLMS8RppcJpGgnoIxXZjV5
         5JeQ==
X-Gm-Message-State: AOJu0YwaKcyn00RALMiUN8Qa8x9E63+48f5ESedAvkcOWa2pZ4/nxA+P
	DvKnrmtoSG9iY/+S/rYFVgbzWg6aSAs=
X-Google-Smtp-Source: AGHT+IHk75TVz1VCghAnH9X3NdeiYVWz4NKA2COLlcBjEr6LmvmtY0K8VBCV1hG/Q6Jzm804QfS/iA==
X-Received: by 2002:adf:ea4e:0:b0:337:58ba:d16a with SMTP id j14-20020adfea4e000000b0033758bad16amr612038wrn.54.1704551924422;
        Sat, 06 Jan 2024 06:38:44 -0800 (PST)
Received: from gmail.com (228.red-88-13-173.dynamicip.rima-tde.net. [88.13.173.228])
        by smtp.gmail.com with ESMTPSA id e8-20020a5d5948000000b00336898daceasm3485131wri.96.2024.01.06.06.38.43
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jan 2024 06:38:43 -0800 (PST)
Message-ID: <d38e5a18-4d85-48f3-bc8b-8ca02ea683a4@gmail.com>
Date: Sat, 6 Jan 2024 15:38:37 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Subject: [PATCH] branch: clarify <oldbranch> term
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since 52d59cc645 (branch: add a --copy (-c) option to go with --move
(-m), 2017-06-18) <oldbranch> is used in more operations than just -m.

Let's also clarify what we do if <oldbranch> is omitted.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 Documentation/git-branch.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 4395aa9354..233264549c 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -312,7 +312,8 @@ superproject's "origin/main", but tracks the submodule's "origin/main".
 	option is omitted, the current HEAD will be used instead.
 
 <oldbranch>::
-	The name of an existing branch to rename.
+	The name of an existing branch.  If this option is omitted,
+	the name of the current branch will be used instead.
 
 <newbranch>::
 	The new name for an existing branch. The same restrictions as for
-- 
2.42.0
