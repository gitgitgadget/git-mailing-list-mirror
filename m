Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343AA2DEA68
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 19:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771959601; cv=none; b=nxq7pyKn1TjfsqOJswJOsZHN9LEEki/wHZnGrV0pqqJ+eOsbdjkepZO8MqJRX9gt1ux56nZk+K2qamrCH6WzlbmJFTTPVzm72T5DlBF9xIb6SlrhIq5CrVEuJfAI7SJhWhAj7BXPa6gcUi/E4+CNZZHQWsFFijtW+lXPaDjfge8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771959601; c=relaxed/simple;
	bh=TSUnhCvnrNzfU+xDV5vxRNnSQTjwDXrE+P2xH+V7naw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iA2TJ4WMdKQvwZvNiTFfJ87GG3ItxXFjX2rtnnpLL7Ybc09CitiSVwpNlJaul16IRhtHpCOHDGpEidEwhpEjLB4+kyg3f5nKDT0hVnyQqUBYKkT1PsA3MHp6SxPzxadRJVifvkF5h/0DhGbAGq5JNXbiMx6v9waswPKg0JRJ5Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=p/nzg5e3; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="p/nzg5e3"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-897002b7576so77462756d6.3
        for <git@vger.kernel.org>; Tue, 24 Feb 2026 11:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1771959599; x=1772564399; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Eh3bI899Xrsztie0NdtaxE0RfHcye3myoFnf54gxZ6Y=;
        b=p/nzg5e3gh7agWUoVUQu8N/+TWgl0YbOpQtPvt1Rt+J9c6W5ocWxX6a+bNN4Q6Z9P3
         r5qoXmLRfjtNl18zmPY5z6isA7PP26TDusfoXSaZIyEk7eki/7G57D6FaZdmGxgWtagu
         yypvamISpKItMeWVinBPnYLoSOwSGKRiABV3+3S/DCku0S1/5tT5alNwAMDmLDrWDyPW
         Fwb89hZGk4BhrngbO/AEd1Vl7oz2OG1uW5QhV1v3PdYOTqZfodM7qQ+ZHNMa3pxMmOIs
         L4Dqz4LaiGfcaK3LvkDbpjiyvN//3RcOTlSR5KENAtPDF7DUhwVEn5P2DUeHCgJyVukY
         t14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771959599; x=1772564399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eh3bI899Xrsztie0NdtaxE0RfHcye3myoFnf54gxZ6Y=;
        b=DO88vq6kAZ1thEGqLwicoinzv59diWhen8RkrcL8ovAcriv3klm+eaUAMj7LZn4G+i
         qphvIEP9dw8X8lhjL2+ecA5yNzvY2xHJosx21ix7UqvR1a/OLGQLQgRsL0StODtSUl9S
         HeHrDgjm1SJiC/j5EW/BCG31dBOxoFKVl2GnBiC0hg5nAop8SbsIgtLBHiM2R9tOcjWQ
         0gsNAG5mLqqW0Ya5uDg+t4Zwn2A/u6rpTHeaUQs7vPYZRYfhQPn+eGUqgghs3wGCI+gf
         gKgT35HtoMszDR6iJEQsPNg59CxjP1b7DZGyR1kXuNbZlH0wKMybtQ1OBrNWH0Ou8K1B
         FPPg==
X-Gm-Message-State: AOJu0Yw964TiCFAT+Y9otpCiSM5cNrRvQAU4F5qFvTr1L/HurdgcCHLD
	kw0tIEHs5PeJC0ENAtHI6KmyAUX7hTH07rRWni4t7QQY7N6OjltX9wey74XBMcRPjQ12Ew8DSq0
	0Y4mZUITQ5Q==
X-Gm-Gg: ATEYQzxJJGHi0JKmGHxfDlOXs6iR1596hYnerYGUs5ekYrxbAi5BpxbER46kVaCq9qU
	UidqgUPkdwysZMDYsAves4THkY0uTIMiECmVQXQXE0kyO+xVYRxJTHHtgzHXvXk81MWh0uAy/cx
	qMwdIU5lHGVpcWIicYtRNT/ZiYeFFGAeLMv32nuq4AmhZz6RcQztCSShmKlSjE1lOI3oXD8KA/a
	A3kn5o9VGARA3wT4X4wuTlkwrpLIw4sZ+4br1TVIi+GzQ6F3cAkR/zk/ffLmzUIArxXtgAN90zU
	1bNmaoP5YfDgDv3rl9kbGa6/0q00hhq/jEsH/KxcG3zaJUHK2xIEfhciSiPiOi3MgTjJ0WQt3mr
	5m8KnZdOOOwEDaaU7lTCJJHvUEIH7VPr1yTJs0sgczA7JMTnUuSLX/D6YzghafhHe4mANVoGO8s
	WYZoyw0NYOFdM1Ms4PanGA7Tjqco1BXE5yhz4y7aV+dfFTrtIjjt3HU9OK/OT5nVnyreV3eyFTz
	dlKftteErnlWbw0sBJvUV12ZDXdUg==
X-Received: by 2002:a05:6214:29c8:b0:896:6be5:b468 with SMTP id 6a1803df08f44-89979c83c1fmr196847356d6.25.1771959599029;
        Tue, 24 Feb 2026 10:59:59 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997c6911ebsm98014506d6.7.2026.02.24.10.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 10:59:58 -0800 (PST)
Date: Tue, 24 Feb 2026 13:59:56 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 06/17] git-multi-pack-index(1): align SYNOPSIS with 'git
 multi-pack-index -h'
Message-ID: <1e86068046d953cfa410053e30c5aebb696f1e14.1771959555.git.me@ttaylorr.com>
References: <cover.1765053054.git.me@ttaylorr.com>
 <cover.1771959555.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1771959555.git.me@ttaylorr.com>

Since c39fffc1c90 (tests: start asserting that *.txt SYNOPSIS matches -h
output, 2022-10-13), the manual page for 'git multi-pack-index' has a
SYNOPSIS section which differs from 'git multi-pack-index -h'.

Correct this while also documenting additional options accepted by the
'write' sub-command.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-multi-pack-index.adoc | 7 ++++++-
 builtin/multi-pack-index.c              | 5 +++--
 t/t0450/adoc-help-mismatches            | 1 -
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-multi-pack-index.adoc b/Documentation/git-multi-pack-index.adoc
index a502819fc38..164cf1f2291 100644
--- a/Documentation/git-multi-pack-index.adoc
+++ b/Documentation/git-multi-pack-index.adoc
@@ -9,7 +9,12 @@ git-multi-pack-index - Write and verify multi-pack-indexes
 SYNOPSIS
 --------
 [verse]
-'git multi-pack-index' [--object-dir=<dir>] [--[no-]bitmap] <sub-command>
+'git multi-pack-index' [<options>] write [--preferred-pack=<pack>]
+		         [--[no-]bitmap] [--[no-]incremental] [--[no-]stdin-packs]
+		         [--refs-snapshot=<path>]
+'git multi-pack-index' [<options>] verify
+'git multi-pack-index' [<options>] expire
+'git multi-pack-index' [<options>] repack [--batch-size=<size>]
 
 DESCRIPTION
 -----------
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index ca98d4c3ba3..c0c6c1760c0 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -13,8 +13,9 @@
 #include "repository.h"
 
 #define BUILTIN_MIDX_WRITE_USAGE \
-	N_("git multi-pack-index [<options>] write [--preferred-pack=<pack>]" \
-	   "[--refs-snapshot=<path>]")
+	N_("git multi-pack-index [<options>] write [--preferred-pack=<pack>]\n" \
+	   "  [--[no-]bitmap] [--[no-]incremental] [--[no-]stdin-packs]\n" \
+	   "  [--refs-snapshot=<path>]")
 
 #define BUILTIN_MIDX_VERIFY_USAGE \
 	N_("git multi-pack-index [<options>] verify")
diff --git a/t/t0450/adoc-help-mismatches b/t/t0450/adoc-help-mismatches
index 8ee2d3f7c81..e8d6c13ccd0 100644
--- a/t/t0450/adoc-help-mismatches
+++ b/t/t0450/adoc-help-mismatches
@@ -33,7 +33,6 @@ merge
 merge-file
 merge-index
 merge-one-file
-multi-pack-index
 name-rev
 notes
 push
-- 
2.53.0.171.gde83996e422

