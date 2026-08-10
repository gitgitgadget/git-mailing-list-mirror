Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EDA407CD3
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 15:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786374529; cv=none; b=N5msj9bwAL54P3iaXBxa0LUl+wXXTTSEVZVOYroZuCcr/J/f/lY4ZGVdxqDT51jA5mGQA+9KwcONMbby5lejG5+as74x4yYBe/OArSr4G0Y4zAr7QVT7bJTmpbn+VutbgyB4M3f3ZdfzGAVFOvBYVWWgzpdwPHwzw3PXymOQUr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786374529; c=relaxed/simple;
	bh=xnncgOYrNzG+O32Ioit/TGhlL4FbjjJcxqZqGx7PXdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UDOP/jRbNNRS/rsvyEkqIgB5RoG87FhwAl7cW6sMTHoWG/7kFWItFPAhsaExU1P4ZNpnnySpRdCycnDKGs0d3v+y+Sbu/N1UR0GHHYKlGSRIciwkJHOQhDz0nJ9Gbr0lkF/8z7om+nK5jtHhTlasJMfl9xNHWgMsUn40ygB21zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j0uQED4X; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0uQED4X"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c15f020a223so293054766b.1
        for <git@vger.kernel.org>; Mon, 10 Aug 2026 08:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786374526; x=1786979326; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0ud2guhNCEA+3guJvdIiZIVUkiMv9b+9X/oozqBI5Kc=;
        b=j0uQED4XumGFOhkScmQEC67pQNhJ3Nmf+HRhhLhRVFnOglwIsc4YXEX/yhF+RlDKuB
         y8YsblSKFmnOtz6uYKCH7P39NI9/YIMiAvKZTAHJnv+qwdKG+bYIpOH9pWwWIsVBlsP0
         YXOAVInMdJnbLcOBLEN4Ik9oMIa8R6UR+PDPNMUy6wd7sEoOBjupRwAa1bxeGokcGXDu
         LBPPq321lWSv2RgEs0qToOgYwMlDOwgV/O8XA5/f3vjJFbjglblP73xfVmt0GxBcU8o/
         yLy7sKFuL4qAVK2ZUDTReJpNKR1ugZRoeziRdaQuG2e2VwKSv1DkAFnuRjI6Lzfbv7IL
         zZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786374526; x=1786979326;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0ud2guhNCEA+3guJvdIiZIVUkiMv9b+9X/oozqBI5Kc=;
        b=TEiK8qReiaiSjEBRGRtJK55/z5X/zyuhMTokZCwjdlqj8BXSMKfbabkIMaiBcjDsy1
         zhMfs5J0WtXnFo677CuLeFS3bEt45rMeDKl7sTCYwwClE+NPbg5lSEutctjMKuBUOKFF
         RvhGA9KHtoL2sVFP4Mx5OCAzGa9rvO1bV2RzqBeLaHYGVUlLYAZHRGlld/pGEPejP5mU
         +58WElR5/Lg0W/cxN+3aZblJe3mXNzZCLrQqc7vtssU2wn5UQEiclB51t/no5ssdoRjQ
         0/wW20UDcLBMLh1XkoTkL7wcZW1/RXroSuO3K+3M9jMyp7Z8TDk1vG1whb8Bz9y6iWiV
         1AkQ==
X-Gm-Message-State: AOJu0Yzkju7M5/fyCCoSxAgxbPuHtyxHbDq0yeu+IEHYMD6hKZWbAW+C
	+ihWi6w7JWVVScbkUTPA6r4f2GkEQrJDnnVPqlo+NwxIvhqiRmYb3mvazdAG91wp
X-Gm-Gg: AR+sD11IdUL1Si3MoHV3Fk3+odXWN5CsD8+s6h61ydN+tsoLidITYlQPKt2aZtnDEOw
	oLTzM+QH5ldTXF35mHL1MahsYR2v/taOZP/fE4f85mlX2xhEe6zFbCJAhlLkGB85SnnjDwYlwDl
	j6BqxfpQyNgbnA8qcHBB5jpo0QjmEpR6Rw7A+RN5EyIiQu0aPnSni8TR3rH32WvDlIodF4ZPhPa
	rIWMadRWfx7R/0LAn1CV57BWquPnv0XcsLAB5J2AWokfWzRZnjwGDsaLU+ZrJjH8Wg+uhllhVoy
	JULCJFJ5BL68pFNeBLBalOg6TaBHXO9qRWcRsIDDFIfKAsfI5fjzMnKG8H6Atetl9aXS+fI5HeN
	TCNzbqhTRwD6xEvytXlBqcPXHzR7a2YEVBOMasTVVykcs+kch78yAoY3T6LSK3ONYxeT28Hq0wS
	dkphDAkp3GiULg62Znfae546dJCCSqnNsvOmL3AcpPjlra9DSoThLliRD3GtQ3lUBSP6ZHx9cs2
	e5FMDhHlZA4guxWPu5juQonn1WvlQTJ0y+GXSJRIN6BaUYV1y8jDinJE3wJtPPiRNiaPwa/bRJj
	0uu7ydBAAcaNZaPE5w==
X-Received: by 2002:a17:907:ea8b:b0:c16:84dc:9607 with SMTP id a640c23a62f3a-c2039cad202mr2089426766b.19.1786374526035;
        Mon, 10 Aug 2026 08:08:46 -0700 (PDT)
Received: from M-K2012N0113010.localdomain ([88.119.128.229])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2080a6fa80sm412549966b.22.2026.08.10.08.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 08:08:45 -0700 (PDT)
From: Paulius Zaleckas <paulius.zaleckas@gmail.com>
To: git@vger.kernel.org
Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <avila.jn@gmail.com>,
	Glen Choo <glencbz@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v6 0/2] fetch: make submodule fetch errors configurable
Date: Mon, 10 Aug 2026 18:08:44 +0300
Message-ID: <20260810150844.4003918-1-paulius.zaleckas@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260716140956.1023740-1-paulius.zaleckas@gmail.com>
References: <20260716140956.1023740-1-paulius.zaleckas@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Gentle ping.  This has been marked "Needs review" in What's cooking
for a few weeks.  Ramsay, Jean-Noël: you already looked at earlier
rounds -- would one of you have time to review the series?

Thanks.
