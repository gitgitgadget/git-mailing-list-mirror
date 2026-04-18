Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6052533F5BA
	for <git@vger.kernel.org>; Sat, 18 Apr 2026 14:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776521854; cv=none; b=QjUhYlR/3+8B9QHcewMj5RD6tlaFCUSyOR0iXhG0VP/Uid6OeSFyRj6tdCitqAPfyzX6VL8vPRTi/5zj10asT9R3IQNN9T6EBeNvWNeMelPYOGwt5AlveC6zBFexGkGJ6MfkgfPYvI7+i7Y8GuvIUpRRgfVv7/6/VdliIUEbKXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776521854; c=relaxed/simple;
	bh=balYnzwyaIBmos6X0Lbj80c4cm8CatFZ7P17gTABG18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hv1e4BXdrdutMEBiyZyj+MqhQPPYj8vpbCyHeNTFqVdUyXTF3DOiNQ3uvTUofzBYjnAEFysi+8IbfgXipwsn/wQr4U/QbpqohkPC0h2FDs4wyfsr/UAq0vQXR5MvVcUtUIEuCZJ+DFASj04bwdCCY4Dgeqi9mWL+HGdsvnm37Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SreWtFKx; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SreWtFKx"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso14891815e9.3
        for <git@vger.kernel.org>; Sat, 18 Apr 2026 07:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776521852; x=1777126652; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DUThbH4PhzmxPPsWmDL9Wzcg7CpzsELy69KzLu7dlyA=;
        b=SreWtFKxJSBOYSnaIBMQvyZAoxX03iuDQqlNcoioJaYG4EXPs6n5UnptUeb+hAXQAU
         Fnuj7xEshg/t+sUoNQyF5fbMLIotPcNWN79Lk7nQj/UXK9I6YGMNAoJbndphDnsPK3nh
         PTBC+UTSfgcAHrlIIkwyvXi5P3ZUj5sFBcAFn5YAyjtzU+Zr1CcFrhn2tQr6Snu1M6fK
         4XDrDesQmFNd3qnTaZXhSnBABH2SU/v8Rj47omL5SAurwM76hzFpb3zaLEXCS8OuL8cV
         uwGe/fstskmlDpN7wIPLk4tkTDVEvsVZlPa2WE+CWnePuUp9/I8B3FL2fcF4Gxo9zohK
         g4bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776521852; x=1777126652;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DUThbH4PhzmxPPsWmDL9Wzcg7CpzsELy69KzLu7dlyA=;
        b=Gi1DGApKv8b9XNriAf3pP/HgrTJ/da4W3Z8zx3hLwVqqR794g9emCgA2WIGMsdG50a
         s9STtXCuHN3viyZn4AIQUBHMJdeFUbQIBiv7dhfVeD+ukxuyjn1NyAzIrow9XalU+2JW
         33EgQuw6dnNH/Hfm3V9zz5dMAyx10D+Ft7Gnt7+wTDu1GQiV3HcF3EXZysAU6/uQIbGZ
         P4stbaiZy2p4CsSKYaJardHVVougkLR7Yhkadm4/MzyL9sKqCAbmKMsQyHbbHItFiqD2
         7O1pMg9Bj1KNKFsocVJemOwaWETgkVoczvw9Y2zg8GPV4UdM4X8OfP8XffmHdP1bcJps
         vocQ==
X-Gm-Message-State: AOJu0Yzvbs86VqzAJnFG2ncdoDqXmREQHKCgiS6YmxkcnjIhHSIxOORx
	kaDwMaxGZbchpFY3NJS1HfwsprdoQ3NkoZBVyNu/Ps2yFXu4jA94luLhBAGpxg==
X-Gm-Gg: AeBDieu9WiH+QW/foBHJEs8vJ/EE90YTO/ZI9YbuGTyLL0YxLwlt1lzWnS+0Om30UKW
	ApzfbVXLxQOcXcb0BbNtwCGdjejM6vhh6WclI/C6aVpiAWOkFeEhKL1j04v61HUbqyrq2xiZMqI
	OoMjAW0QvMYT73si/I3LW62hmdXjEm/CAjFjenJbERdxPsqSQRaq4+PRkywF46Nfiqt+YtjCOni
	DJM6CY2AVnCS5d4dJ2sDOPhu1ftlMtWl2LdkFzQhr2Rru9OjJyrIV8hMlIfC4bGpP8MZWsZePWQ
	0plxYX5Pmm/LACOr1WOd3ELO5td3yoXO8GpFyXjXsdmoVRb2CSM+5XSfVVqnKJsbG9Rtb0WrLl4
	tWbZDoxVhNBEuyme2E3QI9WXuRTT1LVvDiJiG4s6HE1am0ieaERn9WqgRC669nQbZo8g85kCM7p
	cDiiQBiEuvma++RBZ19bZDqo8vae66NvPIFs3O5jF23Cbtec6R7313r1FFGAJV9nRfaOqJN+jfv
	rcDJfkcB75U4tldhzA=
X-Received: by 2002:a05:600c:a00f:b0:486:fe83:8621 with SMTP id 5b1f17b1804b1-488fb788924mr104535725e9.23.1776521851326;
        Sat, 18 Apr 2026 07:17:31 -0700 (PDT)
Received: from lorenzo-VM (host-79-19-37-238.retail.telecomitalia.it. [79.19.37.238])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc0f82bbsm212031005e9.3.2026.04.18.07.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 07:17:30 -0700 (PDT)
Date: Sat, 18 Apr 2026 16:17:29 +0200
From: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Tian Yuchen <cat@malon.dev>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Elijah Newren <newren@gmail.com>
Subject: [GSoC PATCH v6 6/6] repack-promisor: add missing headers
Message-ID: <6b87e8e9dd794ebb968461785cc3e496aa1fe996.1776384902.git.lorenzo.pegorari2002@gmail.com>
References: <cover.1775861047.git.lorenzo.pegorari2002@gmail.com>
 <cover.1776384902.git.lorenzo.pegorari2002@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1776384902.git.lorenzo.pegorari2002@gmail.com>

According to the coding guidelines, a C file must directly include the
header files that declare the facilities it uses.

Directly include these missing headers, in order to comply with the
coding guidelines.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
---
 repack-promisor.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/repack-promisor.c b/repack-promisor.c
index 06393ef06e..472aef0081 100644
--- a/repack-promisor.c
+++ b/repack-promisor.c
@@ -1,12 +1,18 @@
 #include "git-compat-util.h"
 #include "repack.h"
+#include "hash.h"
 #include "hex.h"
+#include "odb.h"
 #include "pack.h"
 #include "packfile.h"
 #include "path.h"
 #include "refs.h"
 #include "repository.h"
 #include "run-command.h"
+#include "strbuf.h"
+#include "string-list.h"
+#include "strmap.h"
+#include "strvec.h"
 
 struct write_oid_context {
 	struct child_process *cmd;
-- 
2.53.0.584.g6b87e8e9dd

