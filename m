Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F8C34DCFE
	for <git@vger.kernel.org>; Thu, 13 Nov 2025 18:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763057439; cv=none; b=mXZa90Sx/eXdWMrEr2tHo5uUvcZ/L4VGFrudBM6W957n3NlYw2PcVPeMd3H1px0tm2c3s2x1yoW6RNW1nWB65ERK5DypZaUOnTPXnzehtIHaaouAEJIecoH/QoUolsC7i3Wkz2d8HYuy1TL/K3nQy2nHvd4nXYH3oebZ8x9REug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763057439; c=relaxed/simple;
	bh=y+VtKNOdXTO7yx6jU8bZzx36C2kFuaoctGa2DHfnOOA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=LtwOBKTy0Ztoy7PtDz21SgZIWBGuu877b/iyQrAXtLduXZLUP22qwLPYourqEF8SuZ+WfSctda4YxuvZXzaTWMXAtMM+4kkznKN0N51SqzZVJmLAbgzG40WxetqWujunJAuTIV9ZcA2HjSIm3aEgqV72ae8Amvp59Q2oD0Bwd58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RHeeluze; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHeeluze"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-29516a36affso11328825ad.3
        for <git@vger.kernel.org>; Thu, 13 Nov 2025 10:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763057437; x=1763662237; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MhXvnMeH2Q3tsOeLXeu47PCr8ZvZ/ZV/l4wDIKPGvKo=;
        b=RHeeluzeiUVoocnC9YD3eD8eQX/+W6sx8CcSANwH5adTJNpFGIYFuRx0OB8N8KfiGw
         BU3zXcek9KxNFy14uqlU/xsTGdY+8O6wpicUVpDNDhUa9gvLJXYj7ZQuTFe+t73V6pqW
         vW/kWHfjOtQGD5ryG4kge213yWwZCHyw1iOBo1NZFC1pL/lXyM1DDHuR61TPk+BpVun+
         TvgZmF/UKofN9EuxRdtlUnK4LppNEzSiv/7iGJ+/KMjwfunaYB9IdjpY1nPw9UXRxMy1
         RSGiReKuy+FhghZ8SChWqXEcRtdihaMVpegkGZ5vE/CnwJ37hPEwoY0CNN4/pa/OakRG
         vqzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763057437; x=1763662237;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MhXvnMeH2Q3tsOeLXeu47PCr8ZvZ/ZV/l4wDIKPGvKo=;
        b=jZtFSjuQ7sJC+KD35NzVtez9gpXxzF7G+Eahv6XVACVXsV5im5SkbQ66xvLQXK4VhW
         hrWLw4RuiVmWp4Y1zpB3AqYlNETpbdqCuhqZXHmAFaxc5BoqH2cf017NvhhmPuOG2A08
         KR3TqKmh8Mnxj4wP4GyXEamocIWYgl+uALqKg3DlCmauJOKeB20/E20Kin8OJ6MtLiPi
         2U2MkYusZl/uZ3SAw+W7PpKZKjla/aEIzIe2kvJOR1zKsmtpfgsqsL/4EpJ9W225GVjI
         6apbDhqNIxv0b17hhgEhAhoKdFII8BUdiDoAhXRLlhyk5Ilm0GsjEPggN4oWnGk769hC
         /dHA==
X-Gm-Message-State: AOJu0YytkGSwOemlMdgsD4aE0coGqLgebcYdZ1pCbx8MESHMd9hft81v
	EshGozS8MhiYKbF5WQck1gpjAchytnyICPwyCzZJN/uN8I0ErZNAz/0CSaFwwg==
X-Gm-Gg: ASbGncsAY/M6e9m/43AwhajxzfGYdC12LGCTl2a4NoKF4UI/Ag3fSX26hTLp0uy/uY6
	oKv31HjL6I1EWOUs5s+sR6SDmtR6nmCBbgm2FH4Wwdg3MiNfT1uUg6Z+A8+/YcPyUhYTzGcGiiI
	Ul9fwtHOnOfTYxfb0eoG/POuOG0DRE4kzKUJgvDdqvR1CrCZ0Cgt0Ylll8DsVQw7l9ScWc47uqV
	SqFukuFm8NCxiPySf4OoJyfm6FSYJJgzMpiOmeLuPfdO3udo0UJB/P6DvGCF+rZM8w/6u/Jesl8
	11gD1AroACcHWzck2FW84B0WUpCiyKE0vz/fTlXKjcpZyc89iV9dzfojE964ocJaeB43D5fuBpu
	XxWZ2Mz+vE7EVD3YOLRYULgXsHDaHFBLn3DKDquPeXmHlhH91BLU4LbFjf/+dFK8CT3msaiAaOi
	Xs8A==
X-Google-Smtp-Source: AGHT+IHgvzvSF2J5lHJW00cHwMzPtMmtdBGnqF9OPbRCaL6pv8k54q+nd8ar8kGq4mS0Mm3ZfhQXDQ==
X-Received: by 2002:a17:903:b0d:b0:294:ccc6:ccfd with SMTP id d9443c01a7336-2984ed41a1cmr84255245ad.24.1763057437139;
        Thu, 13 Nov 2025 10:10:37 -0800 (PST)
Received: from [127.0.0.1] ([104.209.7.211])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2b0d91sm31651885ad.63.2025.11.13.10.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 10:10:36 -0800 (PST)
Message-Id: <9ec79b9a116a1dda9fe7bd10d16c1faf77f778ed.1763057433.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1987.v2.git.1763057433.gitgitgadget@gmail.com>
References: <pull.1987.git.1760818039.gitgitgadget@gmail.com>
	<pull.1987.v2.git.1763057433.gitgitgadget@gmail.com>
From: "Claus Schneider(Eficode) via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 13 Nov 2025 18:10:30 +0000
Subject: [PATCH v2 2/5] read-cache: add/read-cache respect submodule
 ignore=all
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
Cc: =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason <avarab@gmail.com>,
    Junio C Hamano <gitster@pobox.com>,
    Brandon Williams <bmwill@google.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Claus Schneider <claus.schneider@eficode.com>,
    Claus Schneider <claus.schneider@eficode.com>,
    "Claus Schneider(Eficode)" <claus.schneider@eficode.com>

From: "Claus Schneider(Eficode)" <claus.schneider@eficode.com>

Submodules configured with ignore=all are now skipped during add operations
unless overridden by --include-ignored-submodules and the submodule path is
explicitly specified.

A message is printed (like ignored files) guiding the user to use the
--include-ignored-submodules flag if the user has explicitely want to update
the submodule reference.

The reason for the change is support submodule branch tracking or
similar and git status state nothing and git add should not add either.
The workflow is more logic and similar to regular ignored files even
the submodule is already tracked.

The change opens up a lot of possibilities for submodules to be used
more freely and simular to the repo tool. A submodule can be added for many
more reason and loosely coupled dependencies to the super repo which often
gives the friction of handle the explicit commits and updates without
the need for tracking the submodule sha1 by sha1.

Signed-off-by: Claus Schneider(Eficode) <claus.schneider@eficode.com>
---
 read-cache.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 32f32bdb4c..7b6d1b2914 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -48,6 +48,8 @@
 #include "csum-file.h"
 #include "promisor-remote.h"
 #include "hook.h"
+#include "submodule.h"
+#include "submodule-config.h"
 
 /* Mask for the name length in ce_flags in the on-disk index */
 
@@ -3956,7 +3958,7 @@ static void update_callback(struct diff_queue_struct *q,
 					}
 					if (pathspec_matches) {
 						if (data->include_ignored_submodules && data->include_ignored_submodules > 0) {
-							trace_printf("Add ignored=all submodule due to --include_ignored_submodules: %s\n", path);
+							trace_printf("Add submodule due to --include_ignored_submodules: %s\n", path);
 						} else {
 							printf(_("Skipping submodule due to ignore=all: %s"), path);
 							printf(_("Use --include_ignored_submodules, if you really want to add them.") );
@@ -3964,7 +3966,7 @@ static void update_callback(struct diff_queue_struct *q,
 						}
 					} else {
 						/* No explicit pathspec match -> skip silently (or with trace). */
-						trace_printf("pathspec does not match %s\n", path);
+						trace_printf("Pathspec to submodule does not match explicitly: %s\n", path);
 						continue;
 					}
 				}
@@ -3975,6 +3977,7 @@ static void update_callback(struct diff_queue_struct *q,
 				data->add_errors++;
 			}
 			break;
+		}
 		case DIFF_STATUS_DELETED:
 			if (data->flags & ADD_CACHE_IGNORE_REMOVAL)
 				break;
-- 
gitgitgadget

