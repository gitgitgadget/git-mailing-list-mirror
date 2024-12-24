Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECD31C549F
	for <git@vger.kernel.org>; Tue, 24 Dec 2024 12:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735043367; cv=none; b=GfwZLdb20jOee2xBwyhWGxWImVsJeM23GkM8sX2Ma4HIi1eIwADeqoGaXebhDoOrhN9Tw3QGkKaMWr6obxBAViTL27bmT4gH6MqNz4Xml/g9Q4kwPtnhPl4WGmTPqQWvMYjdq17dho2h7oi7vAJon9H+4Joeb9n8yZuusf3PTXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735043367; c=relaxed/simple;
	bh=u4S2srP2EXITF6pji+/GMRbcks98LYHqCpcnkFKTjlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EHH6oaT36qcclx1JwpuHoMwaRBd2P3YL+vOxVuhN5L79K/Y7eQcN94n2YFh663Rx94uNXiyawPFCCUTA1Oyz+N6fxl3u84+/GITp/WTz4fpg3Gsrga1BaU/MT7VltknaCg+u3o5SWSF7p0JPRGzfIID/oQJmxsCw9YKL+li+LXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kambanaria.org; spf=none smtp.mailfrom=kambanaria.org; dkim=pass (2048-bit key) header.d=kambanaria-org.20230601.gappssmtp.com header.i=@kambanaria-org.20230601.gappssmtp.com header.b=HFjgkgHw; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kambanaria.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kambanaria.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kambanaria-org.20230601.gappssmtp.com header.i=@kambanaria-org.20230601.gappssmtp.com header.b="HFjgkgHw"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9e44654ae3so821676566b.1
        for <git@vger.kernel.org>; Tue, 24 Dec 2024 04:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kambanaria-org.20230601.gappssmtp.com; s=20230601; t=1735043363; x=1735648163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b7GWsH6uAVMrw7KmMf0ez3QsR5424ZJmTHW4oYlyPkQ=;
        b=HFjgkgHwZeZt/c6AAffY2QMRxDxmzK2L2f+Cvxc3m6L0sw793mOkxLeXti3eL1M/mM
         WuVvWUwVHLMnzU1MOAaEIQ4VEKHAzc2rLI/3gpDI58cL8ujFd6T2hJ6kTF96Zyc+SnB0
         50x0eTGMY6G2BQQU+qYQ0wfcOq4FoPXTm/eSGsDHJwybJJUAJ+9gaWsZBTu65ukTXVxV
         RDqTxNsy/4zCXXomftBrBK9G/9sKBUtf/S6G8FESdK+CYB4wkj5BLLxFv1o+1SgNssmn
         HovUGCYKeSmBib5ZZGMyl3jpaHKqXP0BxsZgbMTX1pY4byksBehzOfHND9utdhzYNt3s
         EiNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735043363; x=1735648163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b7GWsH6uAVMrw7KmMf0ez3QsR5424ZJmTHW4oYlyPkQ=;
        b=Jk5EElTa9bckHcHsfQWXjtt7DDLfwNg4xWeyXs14mv9jGlg3NbjzLZ+lBom6N3d9Kn
         Ewa4NHnD5dIlIdSZY1F/HjpVJ8o2w447PCSazscmF93YlOeqRUEvLjzpUl4IpuEFy3ps
         gfGyPsrFSjOtFuFCyDJYtFmESFxOm1+4yaL1StuJg0QHeCAxRPibDIp+CcRsYl30/ePZ
         FnsggU+9ipacX1hpGYAH5cKDA847goh75My7NzcDRF0Z/OnHtBL2LDvBeRX8+OYKl+EH
         xjG2QHbzgb2/MahzbcvxraWBphcfG30fwidXh3b1XhJhYU0xMHob5Wg7cQqDsT0G0DWX
         dDkg==
X-Forwarded-Encrypted: i=1; AJvYcCW3WwmtWdZfXNjwcQvzvfNw1rY/HgX6MGwDw3e0bj3KL8TmGOleNf4ogW0sXD4Su5VEtYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwfIIK9Ant/zTQ3xe69NjYSRkuxs5Fwd21hQy2Y5wGeJXkoHSX
	B8zl9IwNFig8aIRs5H6TjBixKjVU5K/nLxZa+DORjdT4gidzAkYb9WQbPst22eU=
X-Gm-Gg: ASbGnctsxOxS2/Ko6yMzJGkEXWWbNJZYQM9TmRxufyrNNcURBsx9Lx//6+C9CFINHzl
	1X618noXAVkDuJP5HshdSGPJOVSI/YN859DhOovqfF2MfWywbzpYeFXnyvEBXAEVK/wQbWbj9L5
	Bg1kjB+NL0ufvRnUQ/QFLahidS17N357pBnWtfak+2ruk6K2AM9HurAy6iZsbnApbOQQII7UULd
	hIDN2BzvY6aeK6P1Pb/FcgjYLqQFWSxA6KvVYuWcc1mwOc4u37XJUbypIU4wZAJVmomSWf7EQpK
	fthDf/5eL6wKO8OAhPQBGLc/zQ==
X-Google-Smtp-Source: AGHT+IEmRKG7ap8MulayMefswqE9vil5/xw3/RwLaa5IuKrepqOEN3Xv/NFxGURIUgmK6/2Vvp4g9g==
X-Received: by 2002:a17:907:d0c:b0:aab:c78c:a7ed with SMTP id a640c23a62f3a-aac33661a71mr1424305366b.49.1735043362755;
        Tue, 24 Dec 2024 04:29:22 -0800 (PST)
Received: from ashopov-C7P4TNH9MQ.corp.uber.internal ([165.225.240.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0eae71desm644681466b.89.2024.12.24.04.29.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Dec 2024 04:29:22 -0800 (PST)
From: Alexander Shopov <ash@kambanaria.org>
To: j6t@kdbg.org,
	git@vger.kernel.org,
	gitster@pobox.com,
	worldhello.net@gmail.com,
	paulus@ozlabs.org
Cc: Alexander Shopov <ash@kambanaria.org>
Subject: [PATCH 1/1] Update the official repo of gitk
Date: Tue, 24 Dec 2024 13:29:09 +0100
Message-ID: <20241224122912.20666-2-ash@kambanaria.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <xmqqplliz2zj.fsf@gitster.g>
References: <xmqqplliz2zj.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Point out:
- current maintaner
- contribution flow is via the mailing list

Signed-off-by: Alexander Shopov <ash@kambanaria.org>
---
 Documentation/SubmittingPatches | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index d8a8caa791..3968abcc4c 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -692,16 +692,17 @@ rebase when I receive your patches).
 Some parts of the system have dedicated maintainers with their own
 repositories.
 
-- `git-gui/` comes from git-gui project, maintained by Johannes Sixt:
+- `git-gui/` comes from the git-gui project, maintained by Johannes Sixt:
 
         https://github.com/j6t/git-gui
 
-- `gitk-git/` comes from Paul Mackerras's gitk project:
+   Contibutions should go via the git mailing list.
 
-	git://git.ozlabs.org/~paulus/gitk
+- `gitk-git/` comes from the gitk project, maintained by Johannes Sixt:
 
-   Those who are interested in improving gitk can volunteer to help Paul
-   maintain it, cf. <YntxL/fTplFm8lr6@cleo>.
+	https://github.com/j6t/gitk
+
+   Contibutions should go via the git mailing list.
 
 - `po/` comes from the localization coordinator, Jiang Xin:
 
-- 
2.47.1

