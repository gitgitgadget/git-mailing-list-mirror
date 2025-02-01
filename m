Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F0D1DFE8
	for <git@vger.kernel.org>; Sat,  1 Feb 2025 13:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738417311; cv=none; b=ZCxoom2VnIWSoRndyMV4rMj61XvVi4lUQv85/sK1qCz/yQGM2CiFgjO0GYzX8jhqCFd+CV5MLloV+FxZgqV3TCwuDO7XMHyLDznPAKm21OPNh26bDZTzuH3u6N1uNbaZEelK7ELtfGSB80QIEpXEOnwqXeRuy+PrnNRb3bDsDOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738417311; c=relaxed/simple;
	bh=6S2525yqhyKpImexYSk2G8chwmuxse2NrXbTBcWHQG4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eKaOIl6JsfqdOBBMRkyvYx/JgJx9Mua87y2faLRnC6F2kRoBHUQnYJ1/OAPxslhXXdJPSRnqRkMgSC6BfWh1e7+ZgHseN4eOfzRbwIwy86+oBdK4rnCfXKiWEw087Mimbf+lmn7kWus0gEKkOBs0lzpOL3cUBaFYtve8pN7GKEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gMn8NqRf; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMn8NqRf"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-216281bc30fso65861365ad.0
        for <git@vger.kernel.org>; Sat, 01 Feb 2025 05:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738417309; x=1739022109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=05A71CPFVr2XyPU29tLrLK9fP0y0KV4YLIDAqdK22+w=;
        b=gMn8NqRfmZ8Kn5td8mKV7YNyugPPyI4N3IW8AsMgf/SYbBcnaTX6DBtiFpGPBF2Qhi
         FRqSp1Qv6I+PpL2ypG362MdMXYIObi5dTRvqgmK6c3a058aPWclRx61rBRa7unR0fK52
         tb3p5Y+Mjr79k1dC8FHOZfszq66HNROuc/pcGpytJpQodRCsU00NcL2PqR0n5YKjY5Na
         ng8QLoR8xIsQuC8rRGIjG1SFK6KK9OepSoaJY0d4fjzJRiRnfJe4QY7vQV/J9JV2+UXx
         O/1GnDfN1BvgET96YfhmpRqQc06vuaXMc9FiMIRBNAKRfeRDwSAonJG561E28DvfjYeU
         3myg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738417309; x=1739022109;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=05A71CPFVr2XyPU29tLrLK9fP0y0KV4YLIDAqdK22+w=;
        b=vLViQ5QEy6KCgZvG1YwyGoicm+AOFceySEYcda06f0osaKRjd2LCOy7k1m1SX0OLun
         nTMARzYXXA59DJspt8NIa0WOsvcvHkTCfyhvjqOHgFvXuElvw+BZJqu3sDQTnApnzE7i
         9U4B9QK3lbl92zdCxMELVQR41e9cwwl7IdT1Q1MEGkYNUxvzGIlkOa7mBmPnuCgQfP5a
         9xaHDbtZfPA+41eY+W30D4FTktVLkmEicEvOe1cSaQrsxPlMqb6Qh9i/+AaTfsEjKiOZ
         u9b/XWPv8YK1Zn1zLeBRi44/3dwI4Odm03geICW9WoEbbdUT33KUHah+P7ot37apufWc
         1IYA==
X-Gm-Message-State: AOJu0YySX9vNF7lMfZ3OYaoouZDVNF2YoYIQ51cKhSz4kZ9i/xYiluwj
	+kUHB4/aBj+hxEN5hGA5ERbVpw5vkuwlv2xyZaBDT46fKdoRKkTBS9p+9w==
X-Gm-Gg: ASbGncvdrUJN1j1XHLRV6T7tlbmKEoznPgnLI97pmjemtR3/VhHLJ0ET2BCX8K9qdrF
	PJRWRxMkhklNqcRD7rbyLm3+jqEyWxejEOfmEqMrCCgANsgzIh9RSOpR2/gAOD5n/PLq3U4AIKG
	Rd3ivlxBdpqRrpsRLCw4LSibRvDnzlKzDnDNkK/7+oY5d3mgihxq9OqaFrbQddljjDEdtUSnRbR
	cyU0KRGbIxfgYZRlgByt7w4S6ey+aCksQKCv8WQOnr0j7VEN4uxMd4NhjCjzeiBgTjM0GyNdO8m
	uE7nyyz8UJ9oBVmv8hboYClroQ==
X-Google-Smtp-Source: AGHT+IGBEZJwK4tQ526uWZJetd4mmpU3rypcb9OvyhNRoXM1ltnxKychcrIbB2kGnRP+3tjcdqal8w==
X-Received: by 2002:a17:902:ce8d:b0:215:94eb:adb6 with SMTP id d9443c01a7336-21dd7dd46bemr237688555ad.40.1738417309620;
        Sat, 01 Feb 2025 05:41:49 -0800 (PST)
Received: from localhost.localdomain ([171.60.225.9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de4a91af6sm44200755ad.17.2025.02.01.05.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2025 05:41:49 -0800 (PST)
From: Moumita <dhar61595@gmail.com>
To: git@vger.kernel.org
Cc: Moumita <dhar61595@gmail.com>
Subject: [PATCH 0/1] Rename all *.txt files to .adoc in Documentation
Date: Sat,  1 Feb 2025 19:10:23 +0530
Message-ID: <20250201134023.27695-1-dhar61595@gmail.com>
X-Mailer: git-send-email 2.48.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello, I am Moumita Dhar . I am a newbie I tried to do this issue because it was tagged #leftoverbits . This patch renames all `.txt` files in the Documentation directory to `.adoc`
to align with AsciiDoc formatting standards.

Moumita (1):
  Renamed all *.txt files to .adoc of Documentation

-- 
2.48.0

