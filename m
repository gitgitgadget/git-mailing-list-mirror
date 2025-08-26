Received: from mail.reprendre.net (mail.reprendre.net [193.23.30.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B569262FDC
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 15:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.23.30.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222719; cv=none; b=OgrJkEIAWxRWuKQZ51bB62wbfpZXNoBK9UWUM/dWfS4/ZpY1ydluGG+t/jUV+H1gQB6v5wOKn5AYmpG7qG+P47VOgtVSyB/eG+LM6Ab/RXrJ7PrVNdb9BVsC/rD9EIeyoNfyNEzRsu1pS0h8gyGuVDuyf2PN9cU6+IWDIn74hqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222719; c=relaxed/simple;
	bh=f/3ujZsVxa7g+gbyiuXtqOy+4sqlzLUgsxNdHxBHUOc=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NfwH8/ArQcduRfW2KwMIf67TJ21DTisdrMYi7KPSyaAXRWkYmS5eekoO4Zfq0orhlfylpZrjZVkZIIFtoysjBGF5F2BnoR9kCpdzqa52q3dyi8IBaiIqQ3EnzmBPwcSUPMhFV3ShjzvRoroSJ49I4voky8h1L7s9p2hHzx8b0Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cassou.me; spf=pass smtp.mailfrom=cassou.me; dkim=pass (2048-bit key) header.d=cassou.me header.i=@cassou.me header.b=WTy8HIB5; arc=none smtp.client-ip=193.23.30.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cassou.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cassou.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cassou.me header.i=@cassou.me header.b="WTy8HIB5"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 31C9A2C999A
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 17:38:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cassou.me; s=dkim;
	t=1756222706;
	h=from:subject:date:message-id:to:mime-version:content-type:in-reply-to:
	 references; bh=LUsbcY1gXGbsWlxyKFEHYCAlbYlG21TVdhJTh1fkBf0=;
	b=WTy8HIB5MQI2rb4ki+TITooQiKp6r8Ogjce5kLZTVd37C5ruY13/IpKm1hIdM1QCrGmhO2
	xPn46kWXlLTK/Jaw6bf1thNLuWruuDBTbSsBK5fJW64A8+1yJCbljH4z89UrReLvdmGYu5
	ZxRbaiewWvvfAf5T0p3SdbrfP2O0dAj/iPO0ae7GTaVjCdLpd5lHu1eQ6iEDP7B0Zc3h97
	Te+4Q292H6syJZhRvlFrfIArjjGT0Gm8HMZc5MdLKiuxzl1IYCMAsuE06hCCjU67geQFLV
	kINYiAPPtOCXi6EIeuFLYuFpYxZ/nRmCeg8XA47BMCEvt1a/VS3UEBcWmRaAKw==
From: Damien Cassou <damien@cassou.me>
To: git@vger.kernel.org
Subject: Re: git status shows a different result depending on how fast a
 file is changed
In-Reply-To: <m0o6s7xuh3.fsf@cassou.me>
References: <m0o6s7xuh3.fsf@cassou.me>
Date: Tue, 26 Aug 2025 17:38:24 +0200
Message-ID: <m08qj6jdov.fsf@cassou.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Last-TLS-Session-Version: TLSv1.3

Damien Wyart sent me a bunch of links explaining my issue and allowed
me to send them to the list in his name:

https://git-scm.com/docs/racy-git
http://www-cs-students.stanford.edu/~blynn/gg/race.html
https://tylercipriani.com/blog/2023/11/30/racy-git/
https://github.com/git-lfs/git-lfs/issues/196
https://stackoverflow.com/a/71003895
https://speakerdeck.com/msohn/racy-jgit-a-short-history-of-time

Best,

-- 
Damien Cassou

"Success is the ability to go from one failure to another without
losing enthusiasm." --Winston Churchill
