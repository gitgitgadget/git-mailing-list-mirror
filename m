Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F1722325
	for <git@vger.kernel.org>; Wed, 17 Jan 2024 16:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705508133; cv=none; b=EWrg5CvZroqRAjs83zsQN1T4EgHZWm9JfMTvx7dOqQQSjenPmUfjuMSJSzAs8aJofOuDxSeq6cBSH9e+kyY0VXxpS101Q+Hz29eitP+CKzYXFMhbxCceftsvfvn6AbPqFh/qs09jWInI8fYjijywQhnmB8V8WDRhye7uUaJ94zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705508133; c=relaxed/simple;
	bh=KaUOXIRoInaIcb1IfJ5XQDnxeGjPMNOqkPXFXlE91Q4=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=jKZWq9bcLPJfhhIgfUYjlmE7DBGAEQ3m1f8RTpY+OiIpB+iA7x75IlcBOLMs1TVnvQbnk8tThcy2ZTNgO8Acz7kBLPnKOb2JGyGKlouvDj+3iYnKLc4ysk/HJy7ppK/J8rpUPHD2ByOnzsxeKLyY/dBpAwENja6iWgdoK/i8Ueo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMZAacOk; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMZAacOk"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-28d0052beb0so6858891a91.0
        for <git@vger.kernel.org>; Wed, 17 Jan 2024 08:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705508131; x=1706112931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tk3fPPkPO/iHRG0z7rG3DkykXwHNo8t2FtV4HnA/1Ys=;
        b=bMZAacOkHuo7IPVVWWpyR/Uc8x1sPOGyB2cATr48EGqFw3U4CkO6z3ebC/nK0tdQiQ
         EPFcWvmnYIQGzJyEo0AdogBXqxL7SFJhuqdhgzTbj2xfD8owg0c7gdnaQ40DeL3Bk/Q1
         KtzLZcMYtB6/LPohue9vXA0eLiFqFFQgZ/xFz9cgTATTPwPU4hTzY/FSeETL7lBnx9qy
         YwntgusCx9vARo8wtg+eUHQXIH5dPz06IUARv/cFI7Jvyc11X4Mpc1XkPM3dNkU0Lrm8
         rAyymG1M9PflS7e2RilrtaxpX+aPKx5yoWpLUUZQpOT4zOstqNyds9Ucq5K/TWTkbOx3
         8cMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705508131; x=1706112931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tk3fPPkPO/iHRG0z7rG3DkykXwHNo8t2FtV4HnA/1Ys=;
        b=lSaZJcmZvbZ4eqK4G2Jjn49jwDVhKH3mtBflU6EWI7aZ8Adpz5UZHknnKTCWzQ4PdE
         +De6p59/6wo9WaTJIGoJ55DSWQVXoUDxjtJdrHlskSvThT7+UbQRlz9NpQekZBy5rwCp
         Nf3GN0S/beGwiv7HlE+bfJfT0gOCCjmz4EERec4q2YTTjSmN6ocb0e5lsrCFOFx9doI9
         CawYJDN7RHjbj3AaLOkNgMWGRH38gSXqjodd6L4C9tKr4a4Ji2MH3ifbI3yXdcRXuLj/
         PmeSaQDhYBgkxsl2H1VKBQoCLOU04WHtXqOVcIcKQ+ejQsy4S2/bk86sW6TYVecO7l2p
         D+6g==
X-Gm-Message-State: AOJu0YyGS48CTuLpSB5fRcVL7r0z43YUqA9OhudPqE0hHYIIrcSRyRYJ
	lsjVfxuUxG/KLx6JmGeopTkouMMwOHpp0skv
X-Google-Smtp-Source: AGHT+IHf/mqrvPlNiU28rkExsWugA6I+9w6fpcMmqZEJ/tPYbOYF9D7IppWnZB0nQC2rI9MzQ0FP/w==
X-Received: by 2002:a17:90a:bc8:b0:28f:fd7a:bdff with SMTP id x8-20020a17090a0bc800b0028ffd7abdffmr644666pjd.88.1705508131312;
        Wed, 17 Jan 2024 08:15:31 -0800 (PST)
Received: from localhost.localdomain ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id sh2-20020a17090b524200b0028dfdfc9a8esm12634126pjb.37.2024.01.17.08.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 08:15:30 -0800 (PST)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood123@gmail.com,
	christian.couder@gmail.com,
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Subject: [PATCH v6 0/2] t7501: add tests for --include, --only, --signoff
Date: Wed, 17 Jan 2024 21:43:53 +0530
Message-ID: <20240117161421.17333-1-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240113042254.38602-1-shyamthakkar001@gmail.com>
References: <20240113042254.38602-1-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The v6 addresses the comments from Junio, which suggested to improve the
TODO comment describing the potential bug for --include. Also, replace
here-doc with expected output file for better debugging, as suggested by
Junio.

--signoff tests remain unchanged.

Ghanshyam Thakkar (2):
  t7501: add tests for --include and --only
  t7501: add tests for --amend --signoff

 t/t7501-commit-basic-functionality.sh | 98 ++++++++++++++++++++++++++-
 1 file changed, 96 insertions(+), 2 deletions(-)

-- 
2.43.0

