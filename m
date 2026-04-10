Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6318634C
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 22:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775861809; cv=none; b=rg0/4/T5JVXXERQN1xA31Vi9P6WweY8pQFbNjsl38Yc7h/guVwc/vnQVewnFlgqaWwUi76x2KvbeYT3KJJIyaQMtfIwrHp74j7BV2q205KFFNRedg2lijMhIN2c3MwyZDG6CHJXOuKvVSD637svqUMZegz0hXGd4TQfdtj07W0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775861809; c=relaxed/simple;
	bh=sMC6ArvQth9d75QDfroS477vGyl6+OfPzwXAaOdMPro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KY0ZKH2Um/YHF3fFBPPx0BvT3U7awHVm+0BqZuxb5cUaOYa6MTtx7RWzNgGj55LWFoGlS/arV/XM6znxDQebD4qWUPjI0Y4g01xD/4S3MSCq/BkeshXJv/1qoZeSwpwgGO30IKs5cv0sNNf49iOLW6MVjUt7MQk4WLw2F31G4Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMfNBWGJ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMfNBWGJ"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4888375f735so24629715e9.3
        for <git@vger.kernel.org>; Fri, 10 Apr 2026 15:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775861805; x=1776466605; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fuLFvkudJjyzAxCATJjlv39woY5vQPKZRoMMZzhalLo=;
        b=mMfNBWGJ7YJoSOn8v43yKwtIQd/PeT4crSzvSNIIF2AvfeQc7bSSG7tPQ/za0xa/QW
         rV94WGm7DUxis7HD0GPgevcriDy4rPngtpDBCzXNP2lNOC9x3llDUT4hnk87U52c8/J7
         +ztBtYaNm0RkGRPEeowxgc6Co4zGfKPZW74RzLEH+ZSAz6AAbpxWsudh1XWSkxXIhNdg
         /it2jbMPwgokR99DjUbHTlfsS2UxY+Vng227bi5mUUFT/6zgGZMJdkOJJ2+4QaxNkbmM
         Bxp19q4OV+6rwm2JxWikPVkNN+o/5vK4o8+vV2y+thExxJ6JzngPowrTwqi5fzywyDbh
         UFeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775861805; x=1776466605;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fuLFvkudJjyzAxCATJjlv39woY5vQPKZRoMMZzhalLo=;
        b=jYFQ6oWijpdnMccPidXOB0UawWINpyeKZlYiTnpLv5zdYbjfE61zfa8OgsMGf7/4mv
         TcSydsaDr+39KC5zR30Zx63JRMByQhLl3mBCS11lq/aYEQceP5cdbPuzlQhMUl/EAY1K
         aDt2HfHX5qd/MmSnstE/1duk6YdSZJVoEa6RpRiamZP5DXw6/DT6vixrjn6UmKwg0loS
         qy2FFtLDKAlwUxMy3NV2AjlZJTP86EVkmh7lAaTGhl523V3gMo6gYR7z24lfwbjB/fUX
         BT6MUJFXRBBGlEieDjuPz2b393HbZNZZFfAJiA7lpB2kgwZU8Gscxfx+oDTEkq/Dv44F
         fudw==
X-Gm-Message-State: AOJu0YzrdmMvGNPFgkXf0meLp7sir15/dq8MJIPALXFD/RS3s1YJBo1t
	2X2+uLxOV+/KL/lbYZBqlrc1ezX7JQhRfSxF66O/lPDBV4OHO6wzXeGgeRpE53nvKlk=
X-Gm-Gg: AeBDiesw327gwKARSBW47w/EJNAVZy3J6HXx0gXkRU4j1lsa6ZCowkYZSapVreFw1yB
	DtBph7u2ZW1EKeo1pRqku00v+HzszjcPKzV3T+kU3X4HKIlM/tZ0c7Af0BDWTHzZejSzpFOYIsh
	/nYho/4zNUrRjH9aqEZfN5gFOr3kgCz3+jsxPKFtcdrsrv3Ce7IQUdeCUrbbQyye3zK/LR3d8Me
	uI8JhlUftIZNYogcyIROesqqEIxNUj2DmqaX8kjPvTafMaDltGnOx/T+avSEOSHilhjDt2wIRsV
	tQ7wa4XYL7uyvNPJSA1yobk2D5CrQnRNnfQ5MI6bSMetHnIhf/w5fSC4EROQOWX8JGaBo1xTBiF
	UfJiGODzcMrYHdSbuMdgZkvZFSJNsEvWnDKlXAcFIGQAkgr1wRjb1y9wYkVXIFJHd/3bMHgdddF
	spdiT5bMFOvqYcKFdvgPmVpWdp9iK4xJ0a
X-Received: by 2002:a05:600c:64c4:b0:485:39b2:a47c with SMTP id 5b1f17b1804b1-488d686892emr58442355e9.25.1775861805349;
        Fri, 10 Apr 2026 15:56:45 -0700 (PDT)
Received: from lorenzo-VM ([84.33.160.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d592d606sm98025835e9.9.2026.04.10.15.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 15:56:44 -0700 (PDT)
Date: Sat, 11 Apr 2026 00:56:42 +0200
From: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Tian Yuchen <cat@malon.dev>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Elijah Newren <newren@gmail.com>
Subject: [GSoC PATCH v5 6/6] repack-promisor: add missing headers
Message-ID: <e8720aaf120f9ed534c85c4b694e1441b12f261d.1775861047.git.lorenzo.pegorari2002@gmail.com>
References: <cover.1775832056.git.lorenzo.pegorari2002@gmail.com>
 <cover.1775861047.git.lorenzo.pegorari2002@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1775861047.git.lorenzo.pegorari2002@gmail.com>

According to the coding guidelines, a C file must directly include the
header files that declare the facilities it uses.

Directly include these missing headers, in order to comply with the
coding guidelines.

Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
---
 repack-promisor.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/repack-promisor.c b/repack-promisor.c
index 6d9590cd4e..26055212a3 100644
--- a/repack-promisor.c
+++ b/repack-promisor.c
@@ -1,11 +1,17 @@
 #include "git-compat-util.h"
 #include "repack.h"
+#include "hash.h"
 #include "hex.h"
+#include "odb.h"
 #include "pack.h"
 #include "packfile.h"
 #include "path.h"
 #include "repository.h"
 #include "run-command.h"
+#include "strbuf.h"
+#include "string-list.h"
+#include "strmap.h"
+#include "strvec.h"
 
 struct write_oid_context {
 	struct child_process *cmd;
-- 
2.53.0.584.ge8720aaf12

