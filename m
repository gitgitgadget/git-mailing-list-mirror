Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C971A2574F
	for <git@vger.kernel.org>; Sun, 24 Mar 2024 22:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711318745; cv=none; b=Yuuwr+wmYk6BsoODyDXhhUTjGkkacBtxClIMg3wObS8c2Lc/+tgdjOscWW37Ho5moDVCSfBtgCW6fKmIO+2O7BS+UOlCC4CCX82EWmgiqYfP4HXUK+7Xm+DP8PpBzZijtXSypOJB1eZQMmqQbWxn2VkpaQBUFIYKT49d99EI8K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711318745; c=relaxed/simple;
	bh=AXzkYaHwdXGd5dxqNQiGoZA/AoRZebXkFIKogSzvbmA=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=LUwo5nwaN1zKNtWxFlf2CDeTdH9gip74cf3BkdtiePza7kKinh7owFQ56m5MJRjavgk/X82jCg3iE4RrWA/yWTAoP0kycquhaPJiHjrCqg2/QGYlL/NLa50q+3y8dYLZGEfMu1Yfja9hoqj6gMiz155BzGDee1xEVQw6A9/sa0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mk6EOOjt; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mk6EOOjt"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4148a18871eso914505e9.1
        for <git@vger.kernel.org>; Sun, 24 Mar 2024 15:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711318741; x=1711923541; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xEGAK3RPPqm6OxBtl9mryVfaR9KftIiE91prySDWcig=;
        b=mk6EOOjtAlL3wXUmqRLh6pS5b+uZKoJpsXN4lP/sIfrB9XqZVRMBGFagAUjD312pkv
         UtA8iN6pAlaNkf55R6d6SM7uPIi+oV2B14zsR/ksPbTrJkpIGsXRaJ1eEnf/L79ieES6
         8t4Q6d6q/ywEIRct0tw1xW2Va+/MUb83Jr5XYhtRCvcLLhsh7FSxkVse96x0/vWtBJSO
         QKrutqHPRq0D4v769ZphzkYb/eBLiHwo2duqmnAY4MqrBGcNg+TEOh1vXSqzTA5SUkZc
         e8z9l23uEVe3NPAJVD6FhRZ0+ltRiSP6b7VHXDgfgNBe6UlLitGuouhyQIWHdSUsL6I9
         /NKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711318741; x=1711923541;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xEGAK3RPPqm6OxBtl9mryVfaR9KftIiE91prySDWcig=;
        b=cJ0Y7g7Eoa9yiVuoO3bAQzI0UeYGgMtC/ZUmvTJ8WT0tq//mLJq73WNXz8ho21l6AL
         p+xxxEA2cabW/HO26+aWvJuctL5ZAln2WO0nUVp52LC3U024u5T9utktCqdmHMADFHsd
         mCcJwfy+jUBkWBJqXZJAO/IJY1tw4ULBs9GsaoWsr6tFbYelud1+XCRE4k8XAvZYzYui
         yHi93SlBEoQ1p0kYO6+PzHRRMvW7XvAbUubUW3rtb/8SFGODygubaFw+k+RX+p01nQI9
         6pcNZVW4390XJEdQ+7QZwP2r0zfRfdnR9a7mFoFx8FUn+qju72dXu8McrXwpfQfwvydQ
         wZRQ==
X-Gm-Message-State: AOJu0Yy7TRHbDvI7z5qI7eTunJ6/FXK0+4Ip4uxS0vG0eP+8uJJx2ggE
	ZdcvKlOZSTdcaM1u7VB33WL78kQnKxe8dJpvhrKvN82vMV1lYzn1T1QInTNE
X-Google-Smtp-Source: AGHT+IEFvcfhLiwiHzG3qILn8YCbiCuRSB8E8bFcl6WGxug5Mwte2762skbmwahi8YqGCTFNGtZbwA==
X-Received: by 2002:adf:eb88:0:b0:341:c673:f1e8 with SMTP id t8-20020adfeb88000000b00341c673f1e8mr2471799wrn.9.1711318741156;
        Sun, 24 Mar 2024 15:19:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e7-20020a5d5947000000b0033f20497d4asm7740062wri.5.2024.03.24.15.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 15:19:00 -0700 (PDT)
Message-Id: <pull.1702.git.1711318739.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 24 Mar 2024 22:18:55 +0000
Subject: [PATCH 0/4] Doc new guidelines
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>

This is hopefully the final rehearsal of documentation style rework before
the reroll on the all the man pages.

Following some more research on how man pages are usually formatted and on
our track record of editing our documentation, this series states as the new
standard that all literal text is now formatted in verbatim and that
placeholders are emphasized, wherever they appear.

The markup is a bit more involved in some cases, but the output is more
consistent and follows the principle of least surprise for readers
accustomed to reading man pages.

Jean-Noël Avila (4):
  doc: rework CodingGuidelines with new formatting rules
  doc: allow literal and emphasis format in doc vs help tests
  doc: git-init: apply new documentation formatting guidelines
  doc: git-clone: apply new documentation guidelines

 Documentation/CodingGuidelines | 147 ++++++++++++++++++---------------
 Documentation/config/clone.txt |  23 ++++--
 Documentation/config/init.txt  |   4 +-
 Documentation/git-clone.txt    | 120 +++++++++++++--------------
 Documentation/git-init.txt     |  46 +++++------
 Documentation/urls.txt         |  22 ++---
 t/t0450-txt-doc-vs-help.sh     |   2 +-
 7 files changed, 193 insertions(+), 171 deletions(-)


base-commit: 11c821f2f2a31e70fb5cc449f9a29401c333aad2
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1702%2Fjnavila%2Fdoc_new_Guidelines-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1702/jnavila/doc_new_Guidelines-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1702
-- 
gitgitgadget
