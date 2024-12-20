Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E42225A50
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 23:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734736748; cv=none; b=Wp2ev/aTXR1rxscfFgc8eTXR/SFbRrhzMrYvFCq2a23vFEppH8pDQrNVGP/9qcgNH2GjWLHbpJtA7IIOCMGhVCXpVKNdDW9sxR+BAComGNuRsBcJunk5xTQ1H9n0undCEm1Dsj5GF9jJrp3n8hDGu53jSVXvpOXY4oe0oBFYbVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734736748; c=relaxed/simple;
	bh=kNN8giT6mSJVgHRrafsJRfeWkkZuJs6fUx1U3sejWdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZqAuTz62SBkFOpYf9KhfTvjL1yBztKnWMDpNnKVGMNuQXwLaUvNE49PteBI6GMOQqkn7o2wcDEMMjI1kDphs2kuTptmQ1M1pcvpLbvfDsJljoaeH7JLhOxmSpsiGd6mbCVAbOF9T16UiVxPBTjnK+bjcn2rldTo2q7cPQRJgDzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WuUwZyr2; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WuUwZyr2"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5401c52000fso2336226e87.2
        for <git@vger.kernel.org>; Fri, 20 Dec 2024 15:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734736744; x=1735341544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wh33UYwldurK/CO6sA0h1ZNjWzXi8BoS2c54DvkdKj0=;
        b=WuUwZyr2UDwK6r4WIDtPXIp+YrcRgG9wXnEfaZrt+AEHL3LNxP6yG0AKemZrS3/IcF
         wydoazxl9xWkXM6S+Z2//Iya8nI24OnPZI1vzrDAki0hlioHOAZUB3HcwA+XSXQU+L3K
         NqCrIArOwRknwJ9cebvRA/wOighNPKNfJ4BJNW1SAEo/MlFgneMZgUxQfYK+ANX7NWUr
         iIYFsgZr4cQH5XMKy0LC26AYykmVLVXJphaFK893LCLI0wSr+AuTaQAmTwUqDF5rYnhr
         Pqnd2wd+vRb1hgzBH/ODF3HFEHbpayNOhap2e2fjwU5yvZImseLkkIy891NmPR+/z2qa
         wbdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734736744; x=1735341544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wh33UYwldurK/CO6sA0h1ZNjWzXi8BoS2c54DvkdKj0=;
        b=tIif7QmSxPVClRSnYXCjd0pR2e0Jfhl7fvcnjZHPAeHXbIg+CBWeszw8RTYw1zAnEj
         gqoq4RtjBn6w4CEODodpqjtwx83xFW3YP31rx9OozQt19koa4TfdSJHOTpCdr6radm1V
         k24EhP8wEkMoQNy58w3zRqJkloMdmTgKReYDbCku8Wu/T30zJJOftLStaYKj/ccE+WVy
         5XddBI/4KE2cjp4fTHGXxC8UF6x5bd2kluyG/wkf9Il8up62oN4WuDpQfeyAb6sT0dju
         GuGDv1X64NYA7f549xfTyi7gRawFc1UXtT8G/i3SkAIRCEO9DCfKFfh9qbKqI/AFStTR
         awxQ==
X-Gm-Message-State: AOJu0Yzb7jiY40bfDON/yoMLfH5X+8cSdCynHugDaUKhMlYo7XAhoVJU
	Q26aR6wNxi4+7WuOa6e/OA8kEUK50ZY2WSBAhL+1frt55RcvHQVmJkXcsQ==
X-Gm-Gg: ASbGncuP8WDhaURuCFjQDvUrFhaUbu8+v7HGOVpp7lvIqogguJQoTqc/e+do4QUlR25
	IGYGUxqEl586zGL7ugBAhrXOw+wciqg7DQTXV2LV3KoFGFqhojPcR9HpwGyYFNbexzM4awpkNjI
	dwcBuQ7NSnbdtB9NPpr5u9u25RVPlCcnwqDxgCScLzrH6VDxH6FcyCZpHoa6qEjdEO2xuyAd+7W
	Mca1g5F5nCdD/DdvljjxsG8IKnALKf2AdJo1fb9uo7npgF2qiqUHabgWKeiWIWNxY12mjDwTVWw
	yTilL3wPh6KlgOtclS4mX0n7X6A9/kzxOsI=
X-Google-Smtp-Source: AGHT+IHLsdB0l7NU4MXI3/N+lLU1fo2klKaoQDKAfluUY0kQdXx1bxa4Fqt2OLiGzb3v/1lSC/0BSA==
X-Received: by 2002:a05:6512:3b26:b0:540:3566:5b37 with SMTP id 2adb3069b0e04-542295aa1cdmr1652803e87.57.1734736743910;
        Fri, 20 Dec 2024 15:19:03 -0800 (PST)
Received: from localhost.localdomain (81-227-45-223-no2667.tbcn.telia.com. [81.227.45.223])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-542238137f0sm583733e87.164.2024.12.20.15.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 15:19:03 -0800 (PST)
From: =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 1/3] asciidoctor-extensions.rb.in: delete existing <refmiscinfo/>
Date: Sat, 21 Dec 2024 00:18:16 +0100
Message-ID: <8bdc26c1ae74b59f2c3cd3408111336ce3af1447.1734734612.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.48.0.rc0.241.g3cddc25e2a
In-Reply-To: <cover.1734734612.git.martin.agren@gmail.com>
References: <cover.1734734612.git.martin.agren@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

After the recent a38edab7c8 (Makefile: generate doc versions via
GIT-VERSION-GEN, 2024-12-06), building with Asciidoctor results in
manpages where the headers no longer contain "Git Manual" and the
footers no longer identify the built Git version.

Before a38edab7c8, we used to just provide a few attributes to
Asciidoctor (and asciidoc). Commit 7a30134358 (asciidoctor-extensions:
provide `<refmiscinfo/>`, 2019-09-16) noted that older versions of
Asciidoctor didn't propagate those attributes into the built XML files,
so we started injecting them ourselves from this script. With newer
versions of Asciidoctor, we'd end up with some harmless duplication
among the tags in the final XML.

Post-a38edab7c8, we don't provide these attributes and Asciidoctor
inserts empty-ish values. After our additions from 7a30134358, we get

  <refmiscinfo class="source">&#160;</refmiscinfo>
  <refmiscinfo class="manual">&#160;</refmiscinfo>
  <refmiscinfo class="source">2.47.1.[...]</refmiscinfo>
  <refmiscinfo class="manual">Git Manual</refmiscinfo>

When these are handled, it appears to be first come first served,
meaning that our additions have no effect and we regress as described in
the first paragraph.

Remove existing "source" or "manual" <refmiscinfo/> tags before adding
ours. I considered removing all <refmiscinfo/> to get a nice clean
slate, instead of just those two that we want to replace to be a bit
more precise. I opted for the latter. Maybe one day, Asciidoctor learns
to insert something useful there which `xmlto` can pick up and make good
use of -- let's not interfere.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/asciidoctor-extensions.rb.in | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/asciidoctor-extensions.rb.in b/Documentation/asciidoctor-extensions.rb.in
index c4c200dace..d8d06f9a57 100644
--- a/Documentation/asciidoctor-extensions.rb.in
+++ b/Documentation/asciidoctor-extensions.rb.in
@@ -29,6 +29,8 @@ module Git
     class DocumentPostProcessor < Asciidoctor::Extensions::Postprocessor
       def process document, output
         if document.basebackend? 'docbook'
+          output = output.sub(/<refmiscinfo class="source">.*?<\/refmiscinfo>/, "")
+          output = output.sub(/<refmiscinfo class="manual">.*?<\/refmiscinfo>/, "")
           new_tags = "" \
             "<refmiscinfo class=\"source\">@GIT_VERSION@</refmiscinfo>\n" \
             "<refmiscinfo class=\"manual\">Git Manual</refmiscinfo>\n"
-- 
2.48.0.rc0.241.g3cddc25e2a

