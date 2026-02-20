Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1178F34D911
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 14:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771599102; cv=none; b=S/Ytis+DipsVLkw6tazazMWeSyQ0gaTvMkRmH5FJIxww1LH0QnlA/udoVYHOEh8Fb23cakoEWPCFH0czd2GQvwy8Dt2BwN5Ps/jA8W7Vedlvslvm6yRZ3Ow3g1wDmnTMx798h2myf1sqZWXkVfMV1KylVO1yu161rQ3Toehp2tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771599102; c=relaxed/simple;
	bh=aR9vzKsmgueaddRSq0NDTus0yC2+BtQfIKyPgGGO+70=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=StAZhn9lWRQs5OIr1q1wNDBzxEESYp8cCAemdV1YggJ5RnVHs63voGPOt5lkoRO4Hwq0C1JDy9Y7tZWMI9A6x/in2DZ1opX/Z8Q/CdC9HiIAP+yy1qbWxv6xNSgXboElhy58n735ggbMuvrI1QmDayiJwHiTSDQXlNK3KfPBNWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L2QvyK0q; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2QvyK0q"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-823081bb15fso1235902b3a.3
        for <git@vger.kernel.org>; Fri, 20 Feb 2026 06:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771599100; x=1772203900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=A7NcpxKuoIPmPTUFAegLd6U/nvAoowqcyyynKRMgkhs=;
        b=L2QvyK0qJwAuOAJLRWJuC06A9bTQanFGigtl1ixp/+dJnZYZVBDSzZYLNNnKtucnmA
         hj9krGT13pWcpIHLj62paUJTDSQlII2sIQ5RN3MlS0LkF8Qybvn9GCa6UA2CLg60gdY0
         IzAwZAMDE/QkG+w1AtjLLH6SauDkjqnlJytvpwqEk88i5eBljL5tbiGuX2I1L6cmERq6
         cmb8oxf2XFrGAPN7wy0uqJZOW0cyVlxPgKdtKKv569377Xmj+vTq+7GqQ6StYxWPbyGr
         0kBmldcnxvJU/R2E5nOotpo6m3/XqYtgDFF2RjhjRV9h+Mm6iwpzn6MS4pYN0Un1PZMo
         o8rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771599100; x=1772203900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A7NcpxKuoIPmPTUFAegLd6U/nvAoowqcyyynKRMgkhs=;
        b=c5G5RLw6ogF5PxJz9b79H1uIuOo/s4WAYm7gAGF0OvuKcESFd1yyupawHc62e1cip+
         HPESKSKaQQIZqUvMZwMn9Q2vyM9hRmR7YZsV/Z5ncOqVlCflwSKMJj73nKdD4GCZIJMt
         uvurC+AJ8rGR5Sk8H6O9Lh+ywxYRuoC6GuXBrwJLOd5JEOYiEa5xz1VrtgkfyAwnScSu
         /FlHyzsWx2PxukprWx+4J5GzXPHhpf8W6y4sCt3PY+htlXNUN3WGltH8D6yLxf3CXtL7
         hLIwxiVXxzYM8q1tpIsN4Pxoznt5npBYAadUFqZdFKUDSuugi5+IpiuZLsNDWW7sPpGq
         1QNg==
X-Gm-Message-State: AOJu0YwnMGzwpO78GUUBl0GHI8/FFvdDhMjkEYbxMObN42IrtXhhZOEr
	P6VrLzwuUOMAwR6jyzgPPZ9Rp7x5USmhOfxq1BXqAzJ9uaE7zalVvDm0nYLXaw==
X-Gm-Gg: AZuq6aJO+/9Uw4lgkIVY3iDmGlUCCVr5uWfH75xV4HvK8PJowDyvjjAACk/qoBpVaKF
	DOVqkSgfILQenpB0spVOXxBsgFWO4UfwT8rc35FNRGE1HHTDftIPuEqXvlK9SLi32BLY5quo0cy
	iQpmGvA8hrVDcPO4UyEF9WyOmJfKqkWhjY0rIpMRetgFZOmQgI1PQB8IrcBmu+HC7db3aw89XWH
	NMT/PE7tuQkCEfYHtvWg8FeR9I4TDITNdGCo15pYxQIsgNQEEL9qhiVVyKwq6LhBewJr2yz/wjr
	dDJpGU5+sPoWG2CK7up5ntAUYs3h3ALeSbjDujurXcmrzc3tTh2pcE//WCxeY2keWR1C7oKXtCx
	u392Zh2ftFcX8MHBu8PZD5ZexaQX7McmVLjUVaWpVsNFDV21NN/odH7DapCprKbIvIzq94L7MTa
	NKjrSi9oQ05ol1S+Wah90EGNe3DS9wTwCUgU7BA366s2+6OKqxSiq/48FMVTCNiSaO9sE2
X-Received: by 2002:a05:6a21:4849:b0:394:a026:4c74 with SMTP id adf61e73a8af0-394a0265020mr15442572637.40.1771599100211;
        Fri, 20 Feb 2026 06:51:40 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:375b:ceee:9366:5d6:fd9d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6bba008sm21769112b3a.64.2026.02.20.06.51.38
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 06:51:39 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Subject: [RFC] send-email: UTF-8 encoding in subject line
Date: Fri, 20 Feb 2026 20:20:46 +0530
Message-ID: <20260220145126.131651-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

While using git send-email I ran into some confusion around the prompt that
appears when any 8-bit (non-ASCII) content is detected.

When prompted with,

  Which 8bit encoding should I declare [UTF-8]? y
  Are you sure you want to use <y> [y/N]? y

I initially assumed this was a yes/no style confirmation and answered "y",
and ignored the 'which' part (this was due to my oversight). This resulted
in the charset being set to "y", which later produced a subject line like,

  =?y?q?...?=

Mail clients like Gmail still displayed the message correctly, but the
mailing list archive showed the raw encoded form[1].

Afterwards, I realized the prompt expects a charset name (e.g., "UTF-8")
rather than a yes/no answer, and pressing enter would have selected the
default (which is UTF-8).

I had also encountered this earlier when the non-ASCII character was in the
message body rather than the subject, in that case the result appeared to
work fine even with the mistaken input, which made the issue less obvious
to me at first.

This made me wonder whether the current UX around the prompts or input
validation could be improved in any way to reduce the chance of accidental
input being interpreted as a charset name.

Best,
Shreyansh

[1]- https://lore.kernel.org/git/20260219181154.66814-1-shreyanshpaliwalcmsmn@gmail.com/
