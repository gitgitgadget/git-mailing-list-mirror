Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B076C13777E
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 07:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740641061; cv=none; b=nqps6f8f0kjKOUAaGV8L56w4L04sve1rykzX+vHaEdci6sC/oTQ+x2bc+togso3SokPtabgHCJnBXOc+xtIIatwfsEwaIg5LsP0XPWubUCufWQlR2NjRUD2QRDbyWFFyD25mpc8TbSiemDyi7DKlin0dRVzMSMdrWfyUVlDwTqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740641061; c=relaxed/simple;
	bh=XAsWzvfYrN/NM/KPiRpPpGogv5F7onk9GXWxa6JsUBw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=t6lnhK+hH+p6zr5KAEqteRBii8U1OflQddIm9yBtj8hkPAs5UeAzp9zdh8UCZkGRW8P6cvN/7VaLsK63N1DiDuNYu9e34vtSrtW9+PF8FlBh0D1397dgL0419y3yl2KrGH3iX0vRVtBLqeJ67nb/T8AG35gpsLMNYkjnSEg/8PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O1CN8uyV; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1CN8uyV"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2a88c7fabdeso528364fac.1
        for <git@vger.kernel.org>; Wed, 26 Feb 2025 23:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740641058; x=1741245858; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XAsWzvfYrN/NM/KPiRpPpGogv5F7onk9GXWxa6JsUBw=;
        b=O1CN8uyVfQC1dyYbZoZG80YSbZxwBTt79Hpm7s+opMxsDxgqJQH6+gtjS+1E2AnlA9
         4QxMypqZubtFeg+wb01eScfXuU0ZISBDoGIi/5d2vI+H05GgRpRiDRT+S3iCaxu5ByZx
         ttGCCrMw/Dh6g4Jc6Tp2cIIM4yGnPMpgnb1otVZUgrmi4GeynmScMe3NJG8NZFze2x0P
         JIW7wPYpwJLs9KKgfvRCUMg2ml+T2Hr2CiZsE4EnFDyEaL5+Sg1fyIbeKM5OqzCFTL24
         e4uztV6cDL+9DiyCnM+MzTQvXg4KX+uS4jogvJM25isfuE0nATufKJDTRWhENLrnZC81
         e/4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740641058; x=1741245858;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XAsWzvfYrN/NM/KPiRpPpGogv5F7onk9GXWxa6JsUBw=;
        b=w2bmsdfdv4qsN1hGIogcufbISakZMEdGhadIDBntc/YmJcnUwWl9xAs0eUdVlciTTX
         yGfq2Ce9dkSbLqxqoDln0WV3oMF4bXyQ3jeLdRlMkHbORx4TNRMKsohfnWhozPSS9Zha
         pHd0xZqDS1mQ/rJVyUoBjLMtuHo61DLrCubkneQFser4KwZ5ncSqbGX27vToMJqr62/r
         MnyNqsnnYap5qXiHXmmYHoY2lSXAWW3Ih4tcwvKvW0gRwpaVDZ43zYJJLwFRLLkzqARD
         v9zhgglFvZDYUZudzmJNSVW8kr815cZCWXLGUaP+E+Xs7LMtqfLRbg4OvyS+rP5gAIyu
         7f5Q==
X-Gm-Message-State: AOJu0YyvkOvFaMm4U0tzv0Pzkva6t3p7KnizWmLmo8EuAH7vZkcrwJ2L
	2H3IQY2Gc+suiqFtBIJujXoYmZAASOrcu4Z02jYMhWgmqPYf0y/6ks/IqQTK3NZdrivMDcB1gzE
	lnMdEY/GeF8s5M9wJ9DuoQHYJHh9j1teNo5/LDAGB
X-Gm-Gg: ASbGncv6T15PBbncVVNfK/J/MA4VdB/JfcGP52sxgJl3JT+McVB0AqcOG0dQ7FRGJH3
	EhgecM3A7XNtPXQP2bvzywmt+e7TDblZMuYpjvhsIW9yIL/siP/ZLjwEzeD0pJoUtkSoz5RlDdk
	FVPV4aq/A=
X-Google-Smtp-Source: AGHT+IGffkQJzbaAJOcJljXSbseCqfizCmw8N22eq+DGVc7VhlLheP+NH55ou/0sVls6Rx+hcpOxVoWrqCqUMqpW47c=
X-Received: by 2002:a05:6871:6a5:b0:2bc:9915:aeaa with SMTP id
 586e51a60fabf-2bd514e6553mr17814555fac.5.1740641058284; Wed, 26 Feb 2025
 23:24:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: SURA <surak8806@gmail.com>
Date: Thu, 27 Feb 2025 15:24:07 +0800
X-Gm-Features: AQ5f1JofDsZB-SYxZdt5N2gvsckSk2_0iWfbIl5u4HBWtUCaTMwmb9GZWF_kWTM
Message-ID: <CAD6AYr-ZC32VNfUfMB63H-rQRfTdV=VQfBm67i2mG+6GDCNxkQ@mail.gmail.com>
Subject: The transfer.hideRefs of the upload-pack process does not work properly
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello everyone

OS: Linux Mint 22
git version: v2.48.1

I found that packed refs are excluded by the transfer.hideRefs front
match, while loose refs use full match (when transfer.hideRefs ends
with '/', it is prefix match, which is normal)

When the server uses git, after setting transfer.hideRefs, the
references that the client can see before and after server repo gc are
different

It seems that 59c35fa accidentally damaged upload-pack when optimizing
git for-each-ref

It seems that there is no simple fix except rolling back this commit?
