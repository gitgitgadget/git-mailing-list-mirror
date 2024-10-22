Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655B649652
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 22:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729637253; cv=none; b=NVszvxDl/OO2gYxSSIuX/Utq2VbAF6b5Fpsik4MA1mVOfua3F6nglWyqsA3m5GM+ZfJLY0PTQSjD1/CqXMjORXb9J5nu8CMTaYf70qE7FSh42Tok4kVoIYwT5SBk/eciM/yFaQYb3ssBJyGkpuPMt4+2d77CHWP2Tn8fFOfQXV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729637253; c=relaxed/simple;
	bh=mqk98GP19dZ+Ay7HEP68kLZER2bT/NkIqYTu8jMJ4BE=;
	h=From:Message-ID:To:Subject:Date:MIME-Version:Content-Type; b=tvLS37wUAmcDI/loxHrECVvMDC4ySLFtWUmBSYPq84uOw1TV9C2Fvm1R4y9I6tNengBULYR2kZaLgc1NCmocvz3hUCXR6EUjQGmHFbEx55CaYkchPPfss7LCliVx6SYdIdK3nuwqY/Q9tHfRX5RmIKc7oWov07Z9q9LoJog7TWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNZCLZ/p; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNZCLZ/p"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539f0802bf1so786440e87.3
        for <git@vger.kernel.org>; Tue, 22 Oct 2024 15:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729637249; x=1730242049; darn=vger.kernel.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mqk98GP19dZ+Ay7HEP68kLZER2bT/NkIqYTu8jMJ4BE=;
        b=QNZCLZ/pD3rGyi6IYFEOQ7TzX/TmeW25PrEO3MzLMEY1i91DPcoRufO1iXX3Bdv3GK
         B+qTAG1rOcWKjaH/vCgRNiYgs1XSZFcihZbgJC97kHtHn5XVBQUaN2+nVcLP2jVspNSm
         ItRJBx4L1yNEVZQR3jyUd15AvBKuIppWy6VBiVc65BSle7YLIaKn0u9roov0b6MYpqCm
         S6NsxxZXS3FCL8d3+oyMFPei/p3tnp19c6ZmH74hhKxOuz5UDhSBiGoEvulRn1wMUgrp
         N9CVUsdXM3+GYKtKaUu6XHKtcGsv+A/nyWkLHPBUD0C2kFycbAN6Tj5A+8va9IaK3tum
         vmxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729637249; x=1730242049;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mqk98GP19dZ+Ay7HEP68kLZER2bT/NkIqYTu8jMJ4BE=;
        b=G0XzzY7N8Vqgq01Rgh/WEEN65ZYep0J57tSEiEYy2uUV1ifZxNs3loQUZK54zi4HQc
         nj2UtW319RMtrOvY7k2+UKLOSDbwc7REDOIEujZOrn88dn3I5jIqLcH9arFsNU2oXiDp
         gecsJVOcMGRZDioWEq01SBXqOohuSG5Ppzhgo2Io6yk4drqt/1O/HKBXjVn8xlH3BHUz
         rzqUh4m7sCEQ5QCEdWGJVf0kfG5eNIKhZzlVFY5TuofshijL59x1KFlSn18W1U9mgPhQ
         D1kOTAt099j8fs6CVzmc9YSEQ19gbIepmk50soi7jmOR9tGsWDhf1tOIVgzhesD5I6Aa
         S5Zg==
X-Gm-Message-State: AOJu0YzBlXnDml/i26UtdYhovGM4goRKvVIAvaFj5l5mWT7r+h63LAVu
	1ssteT0UWcZccyyY8Wfxu94LtHjOGgCAkuhRzUKyWlxr73Sd6F0O1c4y6w==
X-Google-Smtp-Source: AGHT+IF8mbM5lCaD4tegTrfGNkX8zvtwrhKH/zt9UbIRPHMk0dNscIf1ANlsXMDLIyDg8NpplpFNWg==
X-Received: by 2002:a2e:bc0e:0:b0:2f7:5c24:1cab with SMTP id 38308e7fff4ca-2fc9d37df6fmr628961fa.10.1729637248940;
        Tue, 22 Oct 2024 15:47:28 -0700 (PDT)
Received: from [87.120.84.56] ([87.120.84.56])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66c725dfsm3619830a12.81.2024.10.22.15.47.26
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Oct 2024 15:47:27 -0700 (PDT)
From: William Cheung <gausfu6778@gmail.com>
X-Google-Original-From: William Cheung <info@gmail.com>
Message-ID: <1e2b0a603ecf4f1bf1b32d073103ad4c5a775a01558e23762d36b1b849915e3a@mx.google.com>
Reply-To: willchg@hotmail.com
To: git@vger.kernel.org
Subject: A Proposal
Date: Tue, 22 Oct 2024 15:46:48 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

I have a lucratuve proposal for you, reply for more info.
