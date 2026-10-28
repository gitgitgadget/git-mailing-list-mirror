Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793196138;
	b=HcQuHZPmN4TM1AJWezWq4oLRRjtOhbFz0QZL1ZKDhil02/++WZXW0E1gbjbudhKuT7mB
	 UqK1ilmlcDwaq3oO6Xm9fC4E/U7C1bIu4LgRA54MxiPw9eTdPIK77mWF/ZBRK80exKZ8h
	 EaTLlkRaZ3CuHPczjyG1KaJTx11JD+Fwx34rQp9chs+VvradcKC16hHK28LN6MYymR79C
	 CHfxzx9NCsm085dbBrrx+g9nQSwnkLd8edqpxoH/lhCdplUi49pZjMnh1tZdWmZfv8WXE
	 6EM2FRqKmoApfLV2vMnz2v+cpHsVAPGylAU8eGXbXWWVboXXVU2LRovKHdWEpfyJJwA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793196138;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=LA7ggMLw+uyccS0ZW18fV7/aDp9fSVONyDZ9uDm+DT0=;
	b=dV9eIyRrsnV3G/entZEPtjXkjQQTZmdhf2u/Lb/M1H46LIjxR0/ry+eE3usvs8vGZ7cu
	 snINdC0WCIW2b5vW/x9cJgzPZWUZbzR593LH4Y/Cf3tXEBQ7SlU7iPq3kLHK8pvgCJFaq
	 ORLi+lt1alYZClOHLEKR3RZDD/bLVcKPVEGbZytKwIhjTF5wMf4e4Id1CYKpSWnaXLY/t
	 d0qc+xw79Cpld8mM+VJ8AQmK99JU9LNMuO2kP4Tc837cz9vqCAsqDc9xtAD3UayJvNjZj
	 JxkuG8kIstnDCi32eN6QypAGSx+sR3Liu6pF3cC6YvVrsrFKtrGvvylqGejvIWqAyYw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Sw4EN17O;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DE0606A31C
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 14:02:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8DE0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Sw4EN17O
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c34bff61551so146450366b.2
        for <git@vger.kernel.org>; Wed, 28 Oct 2026 07:02:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793196136; cv=none;
        d=google.com; s=arc-20260327;
        b=Vsi5ezjKWQDIpQhfjKeLvqFKxCl2XebSJfvE5x+bWYSPbHPwz7axC4FGjcG97b8rn1
         6dOkW/geUHnFKuMQm5Ma/VMScQlZjModAKCYtR2/x/R+s9iJS4OVHbTIrmEHqv4PEWEx
         Cej2zn7DEv+gPubeA1htuYDT2n+IexLIu3j5S3QWya7WffWKcqoirAxqtWHhwDgSaeZe
         hTyhv7IYeCt6TTrOM3vCQ6STmBnsPmc1xAxCiylheZXwW+SuqKujmtdvM1AcwbtJ9nMZ
         ZODqFpeJgRlEokxGTrNcURCTS5NAA9mCsl2McIHQbOZksx3f6Wvc1ZzpBZT3A7elYb4T
         ULvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=LA7ggMLw+uyccS0ZW18fV7/aDp9fSVONyDZ9uDm+DT0=;
        fh=2neGNSFCezYEn8XotWoEp1Z60aJip6GkaOlz6pz9/oc=;
        b=hxTc/PxfbpxKguqim5S+Q3oReDD6XC7xcvSJi6XiaJDWr50Qt/iwKfS04KNpiv3a1H
         tMwjl9PDFqDAfaeOIAJO2dyEM8qvWkMXvNDhUghYpk7afk1BflZanbUm2XsVe6Fr17I9
         rBnMllaolbpdHj49UijlKZtQuM6GhN4Z72vJBYZzFtHEloJjWggm9RteUOGhZoTJ3h+4
         IAP7mQ6uePpPyLvK0ga7Vb0iyWFRcEBgrT6pYcYOIcxNVKy5Nh8Zq0crptCM7V41N8AM
         Mbsg98Ukuro+g9BpZEoAwm6MSV5hW2nbFRvcRtbUldRYn5yGxjAaiAvllFw21UO+eEup
         fDSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793196136; x=1793800936; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LA7ggMLw+uyccS0ZW18fV7/aDp9fSVONyDZ9uDm+DT0=;
        b=Sw4EN17OA04WzvdbRmRtVYMswJQV/PIqZrfuBkGCwf5cb4qOU80VzIdw7EjwU+JOSr
         6HiLILwefMN9NiBO/d0J3VvODgInKbqYvDEZ1nR63FdldKcFpJFKAt4PCsFfvO/Gs12Q
         sTHAYJcv4Cu5YwlKBCkBvsYGTR8hHOlRc0WZkBEsXwuV1n1He50RYo9oLzWQ0LfSufWw
         HYj4k52xva4dJR/JfgkeErlVoKe4jm7w2EwO8QZElqNrynZELqyepG1w1cHs12oLLTjO
         yEsVxAtWuHpqQQhQDa/Px58TfX6cqNt6p4IQa5fWeS3uhAfa5jfOuQzycrucJWbzYkV9
         BYkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793196136; x=1793800936;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LA7ggMLw+uyccS0ZW18fV7/aDp9fSVONyDZ9uDm+DT0=;
        b=DRNcnIB/hfcvIRLwEIZ6KYKh7oGEH4B6sMlLdJqE8aYqmD6UVdN9objYWBmTN3AyC9
         rs9LSsHnPbbE7+XzASIrOb1G7/9xWZwfRA4y0HO7wYm3XXpAktfxVym2bHZ+Rq03BJoU
         DgO6ZK8V5iZYnTr47wvEzvUmrafuF2+RNYPlc743rlmVoQnfLftXfIhyMWU2ToTzwwFT
         i4FdfvsW57vHz7dFd/xu4wORwVkxXzj/BVEJOhUBeaFF7uXaxVedJ+jkNU480WhLkDLh
         ONgQWs5bBBri494s8/QCaOpK2aeG/LDjLuYXCyicpcG5JBs2GXfVLzVjB/wpnxaLIriN
         anaA==
X-Gm-Message-State: AFq9FYJk7anjjSoQciZjai8N5zTlSgXNH5C2wEWSkShNpKU0uD4jvG3+
	UKoIDu71xa1JZFqBRBxC1S4FVaXSrhJwDrljU51I+e+XqQkgS4p1t9AZOe4SgxnvArqyk+j+iwG
	KMs5hfTlvIGHGTYmRPYJZYWwSdsdo220=
X-Gm-Gg: AYBFou0u5mFJHbAEn/F4Z5NAeS7uHSmf9RkCmUOJpCSneoUIu5JdDEelSXR8fPU+Tb4
	tCp9k9xpq7/NK2EiOU7I5rlXjm1W/6TWYBsl+vwhYHOq9z/hgxXXWcQyfaqkkrsDBG7RN07OuKq
	0UIZl0VqtyWsz0EQu1+gvYzZUsZZlUk+o+SG4PYqsbzwhtDrBgb5m+uEzBc+XQ49GZKiMqxaaCF
	O8fx5JN9sQNqeuc44yIXDSulJcbhL8qtYTF0Ve5UF8S5evDtnZdw2UYt1I44FFBLAcbgnONRHtK
	csiX3C2v3rop6GiuF56mp+eGvv0wuvmf1V8bNZsr6oaTuEH3l5sAlL1aq5ylOMYmruSNIOzlL6h
	1W/8LnE9iGjtWL/iWOZ0jIgnT7M4PZHb3ah187sCHTHpkfOcjlejdfNIp8eF9QfdCEZNujwDO2y
	o2MDJNTte9vUpXXuU=
X-Received: by 2002:a17:907:843:b0:c3f:8c92:3b51 with SMTP id
 a640c23a62f3a-c49bdb67901mr234480866b.4.1793196136032; Wed, 28 Oct 2026
 07:02:16 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023154851.7876-1-ogundipesolataiwo12@gmail.com> <20261027183623.3600-1-ogundipesolataiwo12@gmail.com>
In-Reply-To: <20261027183623.3600-1-ogundipesolataiwo12@gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Wed, 28 Oct 2026 15:02:03 +0100
X-Gm-Features: AclHuK9Wsc2Wms2KgXYnrshxxkzVpxgQzkShD_ejFLZklhb6NCEpZOwGzNV1Kzk
Message-ID: <CAPSxiM9sZXbLQQsMFiWqXDmiGGM7FzCAH2hWizLL-mX3575g_Q@mail.gmail.com>
Subject: Re: [PATCH v2] t5300: modernize test path checks in t5300
To: Ogundipe Sola Taiwo <ogundipesolataiwo12@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>, 
	Siddharth Asthana <siddharthasthana31@gmail.com>
Content-Type: text/plain; charset="UTF-8"

>
> Improves test t5300-pack-object by converting old-style
Looks good now. Thanks.
