Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57022225A50
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 23:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734736752; cv=none; b=Ey0FU4VzNqdpbN0becrtka4hvTdtlArPMKa2MwaB1Gjn+T+Ut83JhSwLo2+BWs379NFyQRNycCePVdYOD9zPiSK77n0WRNGK4b3XJ2W2fuU+0abT41CVguDjcBoB13+kLTNcXo9Tk1frtB1/FvMqfsyaPZ0/I7TH8iAyiMYmkWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734736752; c=relaxed/simple;
	bh=onMYNTSTpi4kf/jFpJvpFldAT7jdfZu+iqwVsCRK1ao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uxT0lyjgx/GjEOQqvMVGmdznZxUfpQazfZHz3Z+pncJV/Oq9MGHBthUouMz2nmeZM4ktJICkQmitsbxDFtx/YVdC6KtH8JveUs0MXLJJ35miJv82d/z6zsQf9onolV5MmMiuH29JGl/vdkx1+r1kCuNnj4j2DSsK2fl6MgYaoSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eyj5fZLT; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eyj5fZLT"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5401e6efffcso2863984e87.3
        for <git@vger.kernel.org>; Fri, 20 Dec 2024 15:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734736748; x=1735341548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OlLcZFEfcOt32k9p0DiIdPRUQUpfIH0DMsp6IMJFJcY=;
        b=Eyj5fZLT1r02DanYy2xmHtgAMRaIV3QY4xUJqEhtaFYn/0B90H6X93/bueiuwwd6Fa
         /bWvcLGifJXk0ZDpy42pWCAe382oqUnfXjCV5pu3RzqYDzMDKMWEER5JKcq8Dd3Q2wDW
         3ofR0qYBKuoHE+A3Kej2b+rBMB7b2WAdzAuf40rIkNC8dZVw9SYJG4dtbCk+d5GtiHsV
         WBmKHNuQ43GixkEfjqP80GstzAsTcrzPeYyfyHimeDsUrqavUEhgeegsbQoUIUkq2O4w
         FYht38g9XTkqnrfti8b6k/jWydTP8BjnzqMbl/yvmdn9VDqT/LiEJos4y9o/TWE0CKNe
         ffDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734736748; x=1735341548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OlLcZFEfcOt32k9p0DiIdPRUQUpfIH0DMsp6IMJFJcY=;
        b=TWGZGnf3J+ySBxS8ajCrp7WOtABJAfpCAVIk6H38RAr8juaMI+BIcl6vWb0dfYisDr
         bvceBtlliIWP+/KhdfpngRDJoBrya150Zhy3lNH9yqL22i5cliY1lMaYsTjw1I02guVO
         Qh5rhajFpRH5iacDv5BwWdlyFL+GKAsv/6cacQlAqzrPFt4HfKaCuueXod/V/CM+p4ah
         t3gq0X8W9qiqdLTpfBCaUYmiJnvlWlvhThqzAMYOj8SA7WGaXNit/YEa8EQ/qXwAg/Kc
         gsSFfDpRo7Mc0cczp9hGJ/WXUQNkvbGEuih6pwDj0fTrDj+6ppQEFmZCngSOTn5ogEmd
         vGJg==
X-Gm-Message-State: AOJu0YyIjhzEGJfFv+X94dDunLqShAGc/+q0ANqdP3FRYNu66gZNJZ3E
	Oi1ZVCNrHMbk1wszq9NWphb6jixNc1zNJzHiAxQNuna3xC7u00EzbkEkLQ==
X-Gm-Gg: ASbGnctiSXrzKjoI1pwwuZpaQ3KFB5oeOcgFUrarwAKxP0DPxkXKka30Qyq/26foFtm
	sYmYDQ5BXAX7EQ8TFYWcSJ9VblGZ9Hr3Iq3IrhzcUGy//OWXm+zw+xbeynnYfCoQzRgabNQKkzP
	+ThLsWPbZQ8UTzpYfTaNdm3Xlb+SGI/aHQJDHBUvlzUqO9eX8eHGf4hM/LBapzD4BeF9MYijgvf
	c8gqvdnPXInctVhXDRS4bUaFzd6w8zuSFhI15cwhqtUqT7CIuOVQJoMS8bT3cvHefeD5a6vOoD2
	OxRC079klcbsV00vURj4ChZhCn6xwXGNgVU=
X-Google-Smtp-Source: AGHT+IF5Aq5c2DlOFW5rlDAfImgxkmtyMZEjyWEEE+pcYN8vox9nHzkH5rdiaE37a99o2xLNVT54Og==
X-Received: by 2002:a05:6512:ace:b0:53e:362e:ed6 with SMTP id 2adb3069b0e04-5422959cefbmr1557286e87.50.1734736747969;
        Fri, 20 Dec 2024 15:19:07 -0800 (PST)
Received: from localhost.localdomain (81-227-45-223-no2667.tbcn.telia.com. [81.227.45.223])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-542238137f0sm583733e87.164.2024.12.20.15.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 15:19:07 -0800 (PST)
From: =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 3/3] asciidoctor-extensions.rb.in: inject GIT_DATE
Date: Sat, 21 Dec 2024 00:18:18 +0100
Message-ID: <c17a7319f06e6602337f9e749b32343bbe107dd3.1734734612.git.martin.agren@gmail.com>
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

After a38edab7c8 (Makefile: generate doc versions via GIT-VERSION-GEN,
2024-12-06), we no longer inject GIT_DATE when building with
Asciidoctor.

Replace the <date/> tag in the XML to inject the value of GIT_DATE.
Unlike <refmiscinfo/> as handled in a recent commit, we have no reason
to expect that this tag might be missing, so there's no need for "maybe
remove, then add" and we can just outright replace the one that
Asciidoctor has generated based on the mtime of the source file.

Compared to pre-a38edab7c8, we now end up injecting this also in the
build of Git.3pm, which until now has been using the mtime of Git.pm.
That is arguably even a good change since it results in more
reproducible builds.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/asciidoctor-extensions.rb.in | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/asciidoctor-extensions.rb.in b/Documentation/asciidoctor-extensions.rb.in
index fd1b84c2be..2494f17a51 100644
--- a/Documentation/asciidoctor-extensions.rb.in
+++ b/Documentation/asciidoctor-extensions.rb.in
@@ -31,6 +31,7 @@ module Git
         if document.basebackend? 'docbook'
           output = output.sub(/<refmiscinfo class="source">.*?<\/refmiscinfo>/, "")
           output = output.sub(/<refmiscinfo class="manual">.*?<\/refmiscinfo>/, "")
+          output = output.sub(/<date>.*?<\/date>/, "<date>@GIT_DATE@</date>")
           new_tags = "" \
             "<refmiscinfo class=\"source\">Git @GIT_VERSION@</refmiscinfo>\n" \
             "<refmiscinfo class=\"manual\">Git Manual</refmiscinfo>\n"
-- 
2.48.0.rc0.241.g3cddc25e2a

