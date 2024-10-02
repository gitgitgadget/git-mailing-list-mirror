Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8441112E5D
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 22:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727908708; cv=none; b=Gt8VD6AHDfdN1TV5Fc/7wqsRrcyxbsBtgGRx13T/n4Jzumefia+WK4RWUn1QttqWAjdYJrTn3Av03tIEprQE8+cqXkeYuZSuc29DRlEA4LevdIfJuMQ2LxbxPN5kLpXr/FPq//eiLissWGt6ll3sO3etbibaV198dcvN979Ng58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727908708; c=relaxed/simple;
	bh=sF0lTlSacxJyYz7rHBwWE6MdUoTGTn1L6fCI6a+ubA0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LGW8uuv2CYNwxq5kvNnYpiMFpnDUxDQI1/sEJn5iWYxl8Ldl0JZBOpopcqOVRjvIAy+kVGYh1W2P5H2hiQ2WEf2SpA24l6yTi+66m6mxheS2O35uR0qIpPrHTPyni7YjA9npaAB8Nt+d2oQVMSoP/KGMD3iyovHDk1ARpiwxSvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mX7h5k5p; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mX7h5k5p"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cbbb1727eso2351065e9.2
        for <git@vger.kernel.org>; Wed, 02 Oct 2024 15:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727908704; x=1728513504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lSsDaRhJ5oFj9U0ZzZf5Za7mDKhVVcVNJxZf7P19BgM=;
        b=mX7h5k5pzrN+Ru9xpWZPUzZ6Eeun5VQ7c85NM3mxyQ/o3bv551QPLTt8N0QO0C9aOn
         IhP+NETIX29tMQJxz83ScxDOBpci7DyF6c5ZGmKKsT2RcfVjcPIdapz3yuFn4cC9qqj7
         5OFJzsom3ZNjnNhrKLPNHC8akGNnkUZkgZ24h6OJdpGFwQGmwrTxm0HwDqzX5aDfWH3+
         hFOmdQlTADvqGYD8mWnkIhRgBWZ3A0EGvgp+lNsbYNtvh5498o6CvTdnnpoSWuNqDJAg
         W48H4vZvwQQnpIFj2UsyBwiree4DvTiCTdsf20OsrE+/ZCWx3MwSapgbZIutmN4H8PBT
         /bVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727908704; x=1728513504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lSsDaRhJ5oFj9U0ZzZf5Za7mDKhVVcVNJxZf7P19BgM=;
        b=JrEa8+WnYcG61jK5BXpjOocNhmVtkZCpya94mfvTNDgMXPh3ccev2rp2LcIzuh1i/B
         1/0eGe0L36E2Tsu5DAJuLTtcuE33D1dQWmxG5BMEk2eALc6URbbDSen4XCHI2xZgnL3Z
         rduxMjM/qhKHm2q7W3K8UpFzz92rwxwaLTU9aolzyy1mzmGKR5Po64T8reN/EN516Ovg
         07tqkn38sN1+xuMIPKI3QUScj6VKDppS8UwvHt2LyoDJxjIqYq4BqWV+rBnVPv/p/wPK
         kf9FtOQYAf2NgvxupR2ME7DM0RoQuvwgA24Ned1ZgDCxWlptLPU9ybJgFXKAoGWFmKAR
         gziQ==
X-Gm-Message-State: AOJu0YziYr7gVnhXlTMH6fsI/FUF8wilXJ5aJ33yQszQBAHIUHEOtHyr
	c3NUSBXflz6oBrwOMJlr9//9Z2Y6aSwR5OElYoukeSyIpWcefbILLuxV0L8L
X-Google-Smtp-Source: AGHT+IFhfjMV4psGt7KJ0kiEecM+XDLnboF6ot/nyctv9N46vPqwfdLdxxxRWN7/JUezsK7eBmOotw==
X-Received: by 2002:a05:600c:3b02:b0:42c:b22e:fc3e with SMTP id 5b1f17b1804b1-42f777c7c88mr33474385e9.15.1727908703817;
        Wed, 02 Oct 2024 15:38:23 -0700 (PDT)
Received: from void.void ([141.226.9.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f79eacba2sm29753095e9.14.2024.10.02.15.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 15:38:23 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: git@vger.kernel.org
Cc: Andrew Kreimer <algonell@gmail.com>
Subject: [PATCH 0/5] Fix typos
Date: Thu,  3 Oct 2024 01:38:11 +0300
Message-Id: <20241002223816.14858-1-algonell@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in documentation, comments, etc.

 gitk-git/gitk      | 2 +-
 mergetools/vimdiff | 2 +-
 perl/Git/I18N.pm   | 2 +-
 reftable/reader.h  | 2 +-
 trace2/tr2_ctr.c   | 2 +-
 trace2/tr2_tls.h   | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.39.5

