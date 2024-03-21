Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AF213398E
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 19:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711049968; cv=none; b=u4Ge9UCN1dhC75OcJ8jxFTLonsBaTApKNUur4ScUDQCbXvjGlSj8Fv1ncTqnHyUQ9r0UxKTWoTDfYc8RwO9/ij5xrC01Sca4gRtVai/VNgnQwly7Mt0P0yiP+d8RFYRDMSEMsL0YyQuSdS55oK9W+n6vS7C/vZhBxtGsIUp9lm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711049968; c=relaxed/simple;
	bh=FxYBFdy8WU8RUaxzCKPMJC+JaJySQFRjntKay9BFFh8=;
	h=Message-ID:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Bp3H10d2wvndFQGzzUIUDjT7k7QJzlD3/156H7iRFpU/ZYds/F+FEQpQbW2a3E4MByxrEp2vr0Nm4PEVmf8l6F0WaNHYD9Ghf861tgwbTyQp5X4qYd3tr5Ofkn0dwGXJijcofixANksGWednXKqOZ1ft6KbCkVKBwzm1yHelMiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6GieYSE; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6GieYSE"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4146e9e45c8so11484915e9.1
        for <git@vger.kernel.org>; Thu, 21 Mar 2024 12:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711049965; x=1711654765; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fHUav0NlDgOUNMuv5Qjt/Gzzl4fpsKA4pSNpwGqi3ck=;
        b=P6GieYSEBY+n3Em77+6iU0rwMgbQr2kdgc2b6LESeK5lIzsDIZfSTljNdF4tihI4uo
         4WaBe4mV/zNL142swKqmYap/tZ2CMYevUeg21EtkzUeP+zQhrycsYd8M33Er06jMKt3q
         jmPwLnva/cmgp6Hgu+Gg/DASAvXBydyisiVEOPtNtmoGW83xpkqBUzs/ctW3ROSnfMqj
         lh4cdDnt48CflIsR1WwKXHseqq1suPXfO1BHYI9qyq63SN3cZr07xkzb10khbaEx17XB
         HDHKa0if2lqZRvrcttGhYTnLCYtELIvGISUM/J+Y7UuQzVxGzYfhNqsD+WJpd9WeruuA
         LzAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711049965; x=1711654765;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fHUav0NlDgOUNMuv5Qjt/Gzzl4fpsKA4pSNpwGqi3ck=;
        b=JLgUa03Ah0RK9WQX+i/qEDmJizblUhPF4qD/mfpGZTfH5vK9wIbNTDpbn5ECT4BOWD
         NlFLmZYHBX0/51Mz1ctUrlTxBqm9w1hlS4MtDryjraGkFvf8A5zYvi/Mi1iuxtEOPPJc
         QON52PBm2L6eolesxqTdgFdoWPQfMmE6p82G6jVvVJJjwB1HJZZMVWTEV8jqr8DXxmCb
         ascvZLmbgy4qkU+kNI2vUJfvoTZ5SvzmdwajPNSUp/NhtIP9JqPg+uQLbKPco93xbXOl
         7DkME3hqApI7H37gWDgofAbgIvTlrF9wHZI98wWOy0zusiPCikmlhOMb9f03jOKJV5W5
         qXaw==
X-Gm-Message-State: AOJu0YzV94Y69IZKkQ+9tHEwaYrj0qc/CHO6mBUkAMahs0OI6DWXcTGh
	p7970cqDCbaXsDq1eTyw2xO66xO6fksozWdYN4KMx1Hc80NV+RlmV3/vnY8X
X-Google-Smtp-Source: AGHT+IH8bGKSl8CE1mPQeYjwFnMA1apjni8bN2HMazIMmcgHId73tvpemcUkEcEyrtZjVmtjv0MRxg==
X-Received: by 2002:a05:600c:1d96:b0:414:37f:18dc with SMTP id p22-20020a05600c1d9600b00414037f18dcmr3525995wms.1.1711049964435;
        Thu, 21 Mar 2024 12:39:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n11-20020a05600c3b8b00b00413eb5aa694sm687061wms.38.2024.03.21.12.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 12:39:24 -0700 (PDT)
Message-ID: <pull.1691.git.git.1711049963.gitgitgadget@gmail.com>
From: "Sanchit Jindal via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 21 Mar 2024 19:39:21 +0000
Subject: [PATCH 0/2] t9803-git-p4-shell-metachars.sh: update to use test_path_* functions
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
Cc: Sanchit Jindal <sanchit1053@gmail.com>

Correct Typo in Branch name

Sanchit Jindal (1):
  t9803: update commit messages and description

sanchit1053 (1):
  t9803-git-p4-shell-metachars.sh: update to use test_path_* functions

 t/t9803-git-p4-shell-metachars.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)


base-commit: 3bd955d26919e149552f34aacf8a4e6368c26cec
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1691%2Fsanchit1053%2Fsj%2Ft9803_use_path_helper_fn-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1691/sanchit1053/sj/t9803_use_path_helper_fn-v1
Pull-Request: https://github.com/git/git/pull/1691
-- 
gitgitgadget
