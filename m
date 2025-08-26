Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A135933CEB3
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 12:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756210790; cv=none; b=O7VadSJuhXj5xupuLJPwRn1FjdceD7x+poNNT2bJlMFHSgIcvHDWmbdiDufPcLRM3qDQE6fSbMRGsB+8cVCZDhL0L8qp2KqIQKpC8jiMvfMjZsXni7ATaG1snsmfVn7dnF0DBEqwF9H75rLWV6MTiCIXBzKM0hijNE99FOa+7CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756210790; c=relaxed/simple;
	bh=qQ4MDUWjCxoVogTG7H4v2UgTToNv3DCykCNv02ZyAUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zg7LXfLjC9V0r4ykX7s85YabvqHd7Olg+7H1P0O2/OO8wde5LnNdkp8Vzy6YmTAMTdhPkXfiPuAQFC9nI/OQd+JFz9udfbP/fbuTX9oyNABBokGzVxeF0eIzF9ZQYQT0ipr1W7z8TZ1bRXx4+OVezXRASp1i4KJyLF9meFyOKNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RxNe4LTZ; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RxNe4LTZ"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-afcb7a3a085so871740866b.2
        for <git@vger.kernel.org>; Tue, 26 Aug 2025 05:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756210774; x=1756815574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WDsgLliS2q5wKWHHlNGXi+JHqfdW/MPU0pbkPOlLogM=;
        b=RxNe4LTZo4CBj0afnPywVllothyRKq87T9PrnXh5cIesv0ONx8NGL5xIPQ/CM8nQKK
         D+xJsZzCIEFmogIAsYZs8s8sC5bDrxCBFZOKVIqnFY0EKLD4hcAt0YKPPMaN4lwE2Zv/
         pF02lXEnoa7V9mKXOgcO+Vqx5GPIMs+aEL9ZUw/4lCssCU3WGeJ1gsc3aPI+JTeC7iH9
         6041URW911VlAYX+21cJgBds+VRlg632AHAvFQf8NjKLLPpw1bERlvxpFrRHwIDKt2yC
         8LIMdivuGiss1BfQlvTHmfuYbHI+Wpmd3a7Ja3xHIcWmNeprCs1yral6ULH/kOI3kT+q
         qCmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756210774; x=1756815574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WDsgLliS2q5wKWHHlNGXi+JHqfdW/MPU0pbkPOlLogM=;
        b=uHb3oT4yq+0huThObUJtF2IGOan0VOWgSG2NjGN9tlT+aBG4nfMIAQTyHrSJvqTF7V
         XYXo0yuAxZhGbbDWBb5jTLmZT5GOwILntKlSdM351XEdm2k5tYTeM1BFOeeZ6D3mmy6X
         0p2mC8fJaH4T1vD+8QtS5jScF5wED1COMcmX/770upzGBGoNP2NyFk4szKZpGPR/oWp1
         uX6gMMpWUEgRmi+o08klBHFPGl2zwUiJ2CffR4B2JnwYseVnbW9Y0UgT+ddltxWQ48PX
         iDeWX09aKo4PrK+RpKKVwkMEs8tNgP4y59L0skS4wxbHw0eBO1ygVFIyMIjVDQxPXXxJ
         pYTA==
X-Gm-Message-State: AOJu0YzIN8ZYoSbHdrvHXsGU2I289Gva61M3GBeae2E887DTujLCBHpl
	AWDS5qg0xr2P7E/GaW5G0znWw+6lW6RzYhSsgo0kjTBUAjompapk0vLUmW2O5bK/HXE=
X-Gm-Gg: ASbGncs2jRnMh4p8cdOf/Sjl1ycRR5k3q7kGu9t1nl26LmJYAmSJ5QN3H62MaiIXoed
	BiUXEgmiwPzxGYabZUH9m6LH+9+xCeUcppPHWgCheMsoLLI8hedaZlgUzehmCf28p2+ujgOJg8j
	4Djm48FKzKcMOsqG0Bg0FsrY/3lXeNMWKvXhxB4Drn8sihmTcwStZ+SEp9ETF4smhQtChGr06Q+
	YLo9tzU2VC+sngXvC4I2hSPgViwUlHaulHdYWYpExIOWIsYmYI0KdrUn/FXA1SWCuXY3f9O4vRs
	4sbLGOveCv1/Vcc2trlRdgdFn7club97kvk+XPgmnIU6zugcaQhjDlRukLSDNR8SjQyvkJfM2AP
	qlUNZ5J+GmnXRM75YzRPz2Whs6ppRuU9TB7wyCN4h
X-Google-Smtp-Source: AGHT+IGC/pUX1RD6Wih90fU9U9mNEGV3TA9W8gjXNt8zDF0f+YFVF48CHQBk9Oc24zwiD5Mj8TdFUw==
X-Received: by 2002:a17:907:9486:b0:afa:1a67:e012 with SMTP id a640c23a62f3a-afe28f86573mr1286903666b.8.1756210773765;
        Tue, 26 Aug 2025 05:19:33 -0700 (PDT)
Received: from knayak--20220801-595b8 ([213.244.170.152])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe56dd5632sm710934466b.110.2025.08.26.05.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 05:19:33 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	karthik.188@gmail.com,
	ps@pks.im
Subject: [PATCH] Documentation: note styling for bit fields
Date: Tue, 26 Aug 2025 14:19:28 +0200
Message-ID: <20250826121928.22317-1-karthik.188@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <xmqqwm6uvruu.fsf@gitster.g>
References: <xmqqwm6uvruu.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Our codebase uses a lot of bit field variables, generally to mark
boolean type variables. While there is a formatting rule in the
'.clang-format', there is no guideline specified in the
'CodingGuidelines'.

Since the '.clang-format' is not yet enforced, let's also add a
guideline with the same rule as mentioned in the '.clang-format', which
is to not use any spaces around the colon, like so:

    unsigned my_field:1;
    unsigned other_field:1;
    unsigned field_with_longer_name:1;

This would allow us not to modify the clang-format file, and more
importantly, discourage people from doing ugly alignment with spaces,
i.e.

    unsigned my_field               : 1;
    unsigned            other_field : 1;
    unsigned field_with_longer_name : 1;

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---

I think it would be worthwhile to also add this decision to the
'CodingGuidelines', but if you feel it is unnecessary, feel free to drop it.

 Documentation/CodingGuidelines | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 224f0978a8..df72fe0177 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -650,6 +650,12 @@ For C programs:
    cases. However, it is recommended to find a more descriptive name wherever
    possible to improve the readability and maintainability of the code.
 
+ - Bit fields should be defined without a space around the colon. E.g.
+
+   unsigned my_field:1;
+   unsigned other_field:1;
+   unsigned field_with_longer_name:1;
+
 For Perl programs:
 
  - Most of the C guidelines above apply.
-- 
2.50.1

