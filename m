Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10253C0C
	for <git@vger.kernel.org>; Fri, 28 Mar 2025 17:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743181526; cv=none; b=WK/zoJmbBrvUwJ/23GE3V9F8GW/XYveCHBRl9ZMotu2T6EYyeD/FhZ22R44UJDIBNIzlRs8mDD8eJRl8ZI2JVrNeKhAqO3sBo/5E1QuOiPPjHNZWAlzQS22CypYBiDuGKoKqlH4v8fWi+D3mael1qvwWDiV1nGur+wSgeu8fxG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743181526; c=relaxed/simple;
	bh=M/urdg7AFZU6gIdFn8Wb8F3g2ab9d1J2N4cESm2jStI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HdNM4uQD3s4CzV+HuikgSsO8shnEaL9zTIZEnnRy+xUxwjLDHsJgEhXU45d5RovXa2orhiWGtdnZ5t6qkZC8VRu5Z8PvciRXbrPoW4Gd0eOq7jcVFOLNWfjtbOF4Ll23NDhVgCyMgnvraWpPAX51pfR5+ANNbTLBf605b7N9mXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fsVXRUER; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fsVXRUER"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3f8df49e75fso631652b6e.1
        for <git@vger.kernel.org>; Fri, 28 Mar 2025 10:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743181523; x=1743786323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=atuNlulwb2JHQiGLSdgLN8PerF9jy6m7gIA1cIs/yxo=;
        b=fsVXRUER17FXJdDNhnmeCXGmjm57+bAt+4TOJKZp7r9ZiKEt/nlsYiC3CchGAlSep0
         4AofP2mUvYxyqd4Wkif5J0nBMpDuLmOhoPalQCWypQMftIdevwL/GRos4CBq12k76nhh
         SGkFkh5ZeeH544rucTodyx7xBqfJKeHWr6EHiLdEM9RCZheP6acGmmw+lXryAHI3pSmu
         eYd43S9WnO66LP/BUEiHVbrN/l/DLXzNMx5ZWLEAUXa0A/RciPEcSXcnkq2R/3f90taK
         72wuxtBo5+6SSPQdrsiLPr9EVofBT3Gnn2Parruxqzj4ayf4abDT+YWJBJkzZiB5XoDT
         kZVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743181523; x=1743786323;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=atuNlulwb2JHQiGLSdgLN8PerF9jy6m7gIA1cIs/yxo=;
        b=UWG7iC+t7NX/5AG4fcHgVCWtgasYQBIYLvmBB5oc1uJ9UbMPApB7hA3CWeh3fiplyl
         dAlYITaLeW5VTYxOaqL7oyXqBfmbA3QCgWiDC16jepoR2vuKqbIYLxl5vWcFqqbetPDY
         CtH7tBzBXZlhck2twj25D2Gem7nbpcNsFbqC9MbaCzLR/In0ARoVE39aP0oqmdtxDMy5
         yV8H9xl0j3rTH/xQh9HcAd3k1JKgrbG4our1uqGFLVZJJf/aYzPPNMGIlkRMd+CkAc16
         X00GnYYbvHIZmL6+lHZ3kSMPkg29KLGyMKCSkD6AKYxRSQMN2OtpQ+ZT88CIM++sUPlB
         jm/Q==
X-Gm-Message-State: AOJu0YyhXnZ1V0NGZJ2tGA8w+gaVYmEcWxtT4+epyc2qALowZg2aZVo9
	v8Ed8hgrH6VOj2swT/Biz9uk4Ds/BzzHWW7Lm56fjNUyU6evxYzMRvwaIA==
X-Gm-Gg: ASbGncsJHa2RhOC+FSlArrWW+sBxOJ6qVx4jsdT50HFMWyMAqZ4SGKVixGoTUKx8VSS
	aBPHhqG6d9yCLBNfXWogh/c1VDTsMHhTiDkshbQ60l/8iLgnfaoQdyaRfd4BNoUNFUpvfdifBci
	BWD/KpXCb2q5X4H6kCRZB+NfAkbCl2cYiIYOYF60/zHiQINGu71siuDp6VaDnWzbZ0Qjx0kzyCs
	hKp7PskWmRnrASTlAxNzoU9dmV6Vye8S5bJM3OBkPxnwXZdjtptjRk9b5745CD382nC3gDvLNFG
	tI1pjcx9PFt7wn1JDqGuUagkeRDXTZuRwMtLAuo0lTAuZ9mxyXFa
X-Google-Smtp-Source: AGHT+IGQy/X/ZxEACa3MEqN8GRLmN4qv5bv3isjN/3AqWDjUR2rPd6kgfCvoL3Jbk/iddOytdt7MwA==
X-Received: by 2002:a05:6808:3194:b0:3f7:d033:a0 with SMTP id 5614622812f47-3ff0f4e5112mr26924b6e.4.1743181523432;
        Fri, 28 Mar 2025 10:05:23 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3ff05166b27sm402136b6e.3.2025.03.28.10.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 10:05:22 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 0/2] help: include SHA build options in version info
Date: Fri, 28 Mar 2025 12:01:19 -0500
Message-ID: <20250328170121.157563-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings,

Additional information regarding how Git was build can be found via the
`--build-options` flag for git-verison(1). This currectly does not
include information about the SHA-1 and SHA-256 implementations Git is
built with.

This short series adds build option info for the SHA-1, SHA-256, and
unsafe-SHA-1 (if any) implementations which may be useful for diagnostic
purposes.

Regarding "unsafe-SHA-1", I wonder if we should use a different name in
the printed build options that sounds a little less scary. I was
thinking maybe "fast-SHA-1" and document its meaning appropriately. I'm
interested to know if anyone has thoughts on this.

Thanks,
-Justin

Justin Tobler (2):
  help: include SHA implementation in version info
  help: include unsafe SHA-1 build info in version

 Documentation/git-version.adoc |  3 +++
 help.c                         | 36 ++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)


base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
-- 
2.49.0

