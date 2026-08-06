Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A233A0E8A
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 10:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786011977; cv=none; b=ljAt+qqPHqglrmGPnR+SWqxDweuW3LaBknh3qSE/BAZG39syXuN0+x/535qvyRd9uB5ST2D5jk2QOGmjvW0OJgKJs2HqewXjAmLMfYFVkB+w/0Uga/A9dyMXLjWnPUaKoF5NQ5evnfPJ5DlQldDxn4+N++yBkFzFapLFn4I+794=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786011977; c=relaxed/simple;
	bh=24g88sjCTWS9BwQwekS295I7DzmyTVCjIJaU1u4p1C0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jM0yrsugRt2y2JG8cfABJpAJdxwb3pbEU58q4PvMGkSA7hURQJkI8jvogbyezbaVJCDzzrelFV8PDgfu81k3Prm3wlKtgDRvUR58YF3QW7Z75EkflhE38WMeJp4o75dKkkQLL51QdH0DJHMnCjdDno9fcGQ4BupUyuZFmAZU1Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jjWCRFK3; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjWCRFK3"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38759bcd877so2150186a91.2
        for <git@vger.kernel.org>; Thu, 06 Aug 2026 03:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786011975; x=1786616775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jbOTiqkedQd/mZer9P/3g/cW23oaHkbDmlxZfykVFoo=;
        b=jjWCRFK3X64mdrM1o1BB1HJq89sJciWJvIEhvQhi+8qh3a8I9Hz01RSl185OUDx+49
         /tL3mjwovfmlrS5wT0/w7CMuc02nzt4R+/cAN4t7MlzROS9k+25NaKc73AZ3w977taVz
         euo40wu5b6845e8Q6PRaCBorEXdg1sD+9z5jS2TUOlvxrxVtpl7Lg2vFDjPkfeP9Lq38
         c+LiQJ76onlOM6RDCUUg0FUL+FmT9XO9uzkSMC4XSlrg4UyzeuQA1/ZJDnYR1ptS+zIs
         0wvYpB2Zu5kejSOeudJADGVtyO0yhjctETUfutFkJSf56j4xiZHPjapxv0fXSIHNLsfo
         N2XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786011975; x=1786616775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jbOTiqkedQd/mZer9P/3g/cW23oaHkbDmlxZfykVFoo=;
        b=AbOCmROQZMMICtrUsQ+2AtAa7ugssYxp7G3ExsgzmpomNmQKjdlpdFDvP+avxKBDgs
         4htUNT9IuH2v0BUglXmhfhPH1tSpdknqxmHqunxeqlWfKIsGF3T9Ibhu0GLScqYIoDlz
         PzSU3Qm7qtLYuHtF9RlkS6VS+uMOyRxA8Rm3BO2ox1qY3JVXrLyAt1MwOCreelIJ78ha
         ePKYCR2g4SZMrXd4lGcCz/EyZhe2NvgENGAN6bCVJDOLeAe/laDuyabd8pTgud+Azt9l
         1uLcHCT2ZgTxaAeU7y1HhQA7ygtnIwHNiXqKDw7IVtzZukWLK9wSRg/yHdjIXwueYEbb
         OZUQ==
X-Gm-Message-State: AOJu0YwEmxadpfOPu3dsCrfUNZkzi2UwtxT0GZBfq1yUt71UnVHJY2XB
	GY4CmQHWsZ5eXvbh3uvduoDuDVtkNB87ygAws1kQBxYmFnT6tkVTSksp
X-Gm-Gg: AR+sD10nOfwdt7uRhkbUZ5lPJDblZBmoHf06R8YWyiZX8SGNa9i9Zw9wjR/vBqS7OzW
	jyfrCk/8vFa51GZHKGdbDf9LAuqP5o96JMEOCcexHcHkIHEK24x5M6MaffpVvJPdzyPuuCOjWRk
	yFasS666lJv5ab94EfSnRSExTQJWemUtUouf/GohJ+PieMDnzCqk/PGxo9cladBLiAPDr81+e3V
	XhVBbEEuVlUpJaajBp+ItwUYuKZ7MeTVYTsISfgrL3e3oQ8ZibF7ijxxADs32VDvq9KDDLV06ON
	wb377q5b6BoyrMnEJeXRBJmkGd2v72t9joMgkRkTsN1/Eawm34Hq42BB0YZ5qxOJyic9hq1rn48
	UtuEW7ruaxl9b4sR79W7i9lfxHibDeCFeXUJH8FlD7YHk+Ean2R+H5jy0XHcpzCwoH7k3orWeb9
	pZ6hMvukkXJrn0G9wJ0hgsQzYk4Xu2micnPiQCmzVbaxeYyXq8GlghyU/UFIBuacqHzsss8rBri
	OcgSJwbwDCh3B5inbJYcNgwFlatEQIU8SEk4oCS+8h/SYX0xKEHQY95Ka/kkcK3l7H7BPI=
X-Received: by 2002:a17:90b:4b87:b0:38e:85fb:71b9 with SMTP id 98e67ed59e1d1-3903c538254mr12688082a91.4.1786011975324;
        Thu, 06 Aug 2026 03:26:15 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315863b76cfsm25525901eec.4.2026.08.06.03.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 03:26:15 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	lucasseikioshiro@gmail.com
Subject: [GSoC PATCH v4 7/7] repo: remove unused setup.h include
Date: Thu,  6 Aug 2026 15:45:56 +0530
Message-ID: <20260806101556.162940-8-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.55.GIT
In-Reply-To: <20260806101556.162940-1-jayatheerthkulkarni2005@gmail.com>
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20260806101556.162940-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The repository prefix is now stored in `struct repository`, so
builtin/repo.c no longer uses any declarations from setup.h.

Remove the now-unused include.

Mentored-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 builtin/repo.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index c0f99b6869..8e9f6296b8 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -14,7 +14,6 @@
 #include "ref-filter.h"
 #include "refs.h"
 #include "revision.h"
-#include "setup.h"
 #include "strbuf.h"
 #include "string-list.h"
 #include "shallow.h"
-- 
2.55.GIT
