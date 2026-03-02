Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70DE3FD135
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 14:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772461322; cv=none; b=GamBhYY+qOWrm0hkQYWj6PLJMs4PooSkkX5a/oTZiU9Su+nFPqCxan0zvDq1kNRpvd3Uy8b7thI0zYdI5M3WJhKC9W3aVTZa6J21IBTT35lchulxpcNZRzkXlYYoLM9DbOkv29+yhRmh3lmb5SKMYxFRaOxCpHH4uNbZgQnbHSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772461322; c=relaxed/simple;
	bh=yzcPLPSnsj1cDOW91IXtfaHWXhbK0RjrLQtH7YFAaSY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fJXOq8g7T9lJuIaCO/qSiy3haVgWGma510atXWJpexmIcvTgRaHfJ03Pt8PLTYPVg4WrWDmWdWFIzt/+UNhPSb+pli+ia1D7aHXPsFTcQRRqdRyEGe7j+znzePrgHvmdEy2VIzHz3Jo+lAlhJ7RrXgmTZUKigo0KzaRxyK4PC14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=StldXOMY; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StldXOMY"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-358d80f60ccso1929568a91.3
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 06:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772461321; x=1773066121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D5DJNcPX8D33sV31ozsmvznyUftKznsl27iexFyRfs8=;
        b=StldXOMYqx/ckldDcbqeAj4HJBSvNi2rcZ1irJwJIeoi88+OkneC13iENhlOc4yAcc
         jVSpqgbW52tSmLzvEafYLZGzV0ut6vNvPYjPr6kTayVRWMIHEO3Y0XIy6pehyxnYXfxu
         o6vDRtCRb/51Qna9R3seXaXxSjkvKgcKeyrt1ktrMQ//AjwmPHwujLQwTGL7wzKIYX6W
         rGASzUVG62lU828Lj0oYSd67c4gn3Yq2F01kCIXKMaswEe8ivCMfDkFHIchDJQY6EtxP
         7cFtfSg9g5mI4PNBR8cVCLEGMrvzB0kMZbftdj3eLSVHD7gTZ0Pv/qePBycfacWh4m01
         BCrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772461321; x=1773066121;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5DJNcPX8D33sV31ozsmvznyUftKznsl27iexFyRfs8=;
        b=NDWI2ErNf++poZejQlNNxgKkEgdNVuqW32nGo69YzSpWiupXxaazJlLPU1LnE3np/m
         ElC0F85dm2d3jKpcmkJixnQGv37ltPqHL/DKrVsDkA13DnxYPH4+GdNQIBEGDA2y3CiW
         SMwAtQK6cPwI1U/HG8xsmHAj373w1Fgi+6MCYpFMyOQis+aLL0veUUS1khNMYn1TlX3L
         tuCORwtdLYkvYh+pSR7TkjksqQIlM5Y2merRABREmuUmTw2HXBKLFiFnpHqC8wvC9N98
         qQp4ecq5WTZvbMffscFKuk1ijacjcwWJxBmrNEQC4hBJhc5u098EetnotRZ5Nul0I87N
         ZaoA==
X-Gm-Message-State: AOJu0YwiwjLftWmAPpnHc+IeUKRg90mXBqmg9mpqR4vOFaaZ0Sl3oUuJ
	Zs9aIVtmwBAdB9Udl0675E4CzQQrklg31S+sPT1ZYauBVsxMhIln2df5nRfs6uP7
X-Gm-Gg: ATEYQzwp0s4YrqQODb7xRKwFcAPykQ1y+uvWR3CT5JCZ7/NVlvUBrx2SFxnTNOY+8dR
	dBggS4TR0P9VX8GpfDUy1i4OmWmZubr8B4u0VrfHqeTJP8dhe1ymvG9IG1Ygn9DvRxSJpyreRvR
	fmFtw0OYtexXqZ8EhzHqS4uW4D9W0hgayCEVTSZVLQ9H9XmfMsjVbEnB+IsGJQvataCbY0C331W
	rMeJsClxa81epIZxR1C8oyjcyJ7btNAO9SGagZRTD+Jfvpn485Xo5la8ZKg+ai+hYy3j8tggnQq
	QRZNrABNpons7MZhDvDif89YarVAFrWbP+8RrGrJn1AI2enGt7hIXrIryTixvMiVAPJaH+Z8PiD
	4S0zC40RvbIii9Vj7358U1ZI8D7U1g8ACCSGEZNx9IcRJycqLgqWUC3AVxg4BLIbKlg3aEe/bEK
	onn4WIKt4uRcq5KrdlK4mQmLB10mg2uYlkllSVLF5E/AbPet4dkWcI0jnS1VegSEwgMg8ZH4yWw
	cnAfpoYU8hvDADttF7WOoAwWOM6hU3a
X-Received: by 2002:a17:90b:240e:b0:359:8812:7c07 with SMTP id 98e67ed59e1d1-35988127f37mr3057123a91.14.1772461320966;
        Mon, 02 Mar 2026 06:22:00 -0800 (PST)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35912fbc363sm11329843a91.2.2026.03.02.06.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 06:22:00 -0800 (PST)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Subject: [PATCH 0/3] path: clean up few things
Date: Mon,  2 Mar 2026 19:51:35 +0530
Message-ID: <20260302142138.712273-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While reviewing path.c in preparation for the upcoming git repo info path expansions,
I noticed a few areas of accumulated technical debt.

This series cleans up the file by removing an unused header, enforcing proper
size_t typing for path lengths, and eliminating redundant settings evaluations
to keep the underlying path API clean.

K Jayatheerth (3):
  path: remove unused header
  path: use the right datatype
  path: remove redundant function calls

 path.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

-- 
2.53.0
