Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E338542CAE9
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 14:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784212076; cv=none; b=HxPS0QD635i1AfigbcDW9BR4Zm8XTavlLR1L5Ne1VslkfSlM9JVntsWsyuwnPmYRRkEJrk/HN9wAqIwvHP00nTSngwSzaK9c7vUZnFpJD2Bag47+Il+z/vBvMUeA+QSOXcPpJQLiN7JTYovWb6O0dhBa8xmkV383g5UPJXugPp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784212076; c=relaxed/simple;
	bh=Xet1avG6YZpc5cEhRSwJ5KeEpY2LBVY10ZikgI6n7wI=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=D/5EDm9yt2+NNW4kogOZKanYFBiojn8LFZv3zl/8TgztyN6ZwUwhQZc9FGutkE834sbSbrM07Vapsg998DwslE5pEVMUNvvWfrAefaUDZHgyVQK4y6XR94NwE8UyNFz2uPr9Pyb1Mm6F9jKtBAMa05jW/X0Ps4pgs8GVh5mQlqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YxsdwCF4; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxsdwCF4"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8eefd0c5f59so33902746d6.3
        for <git@vger.kernel.org>; Thu, 16 Jul 2026 07:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784212074; x=1784816874; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hBy0I6n1vLgW4MB1GJvbBt8rVp1A19ZwhVamYBMAya0=;
        b=YxsdwCF4rNo4I6But/L8ZBZleAnvqB+CsxgGqLCVdjMyALnqp30ukf5LM1ClNP2plv
         vZDqrXBCfnybOY5CwArUNChwsTzgQTqou/raahrgC6WW0E5657s+0ziPV2QwNJuWI8Gj
         vRCBj0aFOmn/55nC/WPB8hXk4/KwKk167GCsEza0SiXz4uI11GxZfbCkkeGSmfHWUgiw
         4re7YgMs01mHVpmP3igk8VyPW3OkTwpz6FXmSVH8YcdLDRpeAXK8HjdO6iKAKAjvOwMP
         a65PGUkcX+s0cqn/Jxq7r1V2GORyTT8YOmo7im1M7T8Q7dagyvjZ8mDwSWGHDqkU04Ar
         OJvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784212074; x=1784816874;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hBy0I6n1vLgW4MB1GJvbBt8rVp1A19ZwhVamYBMAya0=;
        b=K6YBkkMFkdtEkbjhuPkKRz4Xvr4L/M46P1cX4ikfTWhMwYYjIMpGIwZYgvtX5pd3OF
         Ib+gdkfQsuOyJtj/XF0naaLB4VBcIZ2KuCA265DOlox8bp3J3Yfur3nssjvPnaGz1JWE
         iq6GDbX/0jVvRlduqZViIkDLCSG2hlccNIH5XgbwQz26adXhyMmdRLXW6aXRbppezrx+
         A2N6IoQsS23gRBVYQ+DR+YIaehkCqQ2IS2nATr2o/zx1u/1keaIFUWXU+p/UllahV54t
         c7XJhRKrl91oR5gGKCj/svf5S61iF1t/cHFyWKT1pTR6Kh9ZNucuTeh++4z/LnzrTMhe
         jNtA==
X-Gm-Message-State: AOJu0YwQxeQblxStnH9Quam236/eeiaTqqghNzHUOryMTQw7BaXuXl0x
	/2PyqAZ0fEXQ4pmc9jEUIMSZXlip0I4DZijAIq1FAFFMvzXsSpamCcr8bQEskw==
X-Gm-Gg: AfdE7cks4WTkzbol/XVT/DBbr/n/pfxBBsr9Z1dNmPEzRIOQrAmc1PVFKF+DxQCWm7E
	jNdZ0pGaSUw2auJENM7cRgIQqrl57P1NY2u9Ua/G7hFjnnaf1bccC7WKNcgaU/ORttbIrKXUvUq
	14bQuUVe9DDv94OLn7k46AyzndgAd+Fw8ABT28kHgYeWJ325phBKQusNWgt7nfsMpEtq/MinnI2
	lecOzXCiBBqzZez/Q1xcJEKc+yGITtbXjNk/HOXrJjL7jjFyTpX35/qhWBVqga4k5rUllyA7eJR
	ZzYIZ2cBlWIJQ6YQfYb5el3xyBgrPjWAMKQ8XoJuhGUfWtFlxgLk6b5M+vY+SvGAm/QMbP3uvXf
	k9d57Ubr5apBJlM8BbJvHaIYOkdhjZtRtPQw5Vtnlj78yd30axbtrve4QEM++T75E9RdNPclIB4
	ozl+Y2
X-Received: by 2002:a05:6214:5b10:b0:901:730f:5eab with SMTP id 6a1803df08f44-9040038208amr271880966d6.27.1784212073446;
        Thu, 16 Jul 2026 07:27:53 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.28.185])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd87cacb8sm223347616d6.49.2026.07.16.07.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 07:27:52 -0700 (PDT)
Message-Id: <pull.2182.git.1784212072.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 16 Jul 2026 14:27:49 +0000
Subject: [PATCH 0/2] Some wincred fixes
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>

These were rolled out as part of the security fix release Git for Windows
v2.55.0(3).

Johannes Schindelin (2):
  wincred: avoid memory corruption when erasing a credential
  wincred: prevent silent credential loss when storing OAuth tokens

 contrib/credential/wincred/git-credential-wincred.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)


base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2182%2Fdscho%2Fwincred-fixes-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2182/dscho/wincred-fixes-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2182
-- 
gitgitgadget
