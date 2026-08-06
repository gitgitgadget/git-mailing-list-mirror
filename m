Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DA43FB072
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 15:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786028951; cv=pass; b=YfIBFAArEjYRfKZI6UqzoeIyWxaS8uIt4c5Iev7iTy0QR27NkAh4tv2tlpPuvcg5HlJHaM96FSCpmVzjPMLhduFD0Ie8GgNp1zgXB+1XbAc5rReu6HTngUXkv0fMIRos/8y371JCt7W0BV4FbqcbQJnrUqy0hCj9CfSiM1k4wQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786028951; c=relaxed/simple;
	bh=EbtR8ogVcBT3pBoGD5NlmmJOX041cHJmtNgUhAxsT6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dFT2+yhT09/yZsND/jri9NCM3TSAV9qNQddXB552zFOo2BiTuEoH4qAyl3t7CtBC4HKsntReCM4ZHPUxT3opnd5z/zcNiGOtmUti0lGV4srgMgghlHBB516a27YHXXAXxfZHw4Vg7b7fUCExZgeuVZHIRH4RGjxp3KMiRVuGV5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mAfGzTrA; arc=pass smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAfGzTrA"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-39c8ee87f7eso20027031fa.3
        for <git@vger.kernel.org>; Thu, 06 Aug 2026 08:09:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786028948; cv=none;
        d=google.com; s=arc-20260327;
        b=dYgaLXTj42jx9dG7U73fUDKEI325KOMatJ2b7SWvxHQ1AVBKCLLPydyNS30tZzpwAn
         G4fNaPIJN/mO7+DkYi+++CEXz6rDbH0NC8yIthiHjP7Y0n5xOG1c6pU9PijOiituZ8iv
         sUo0rGGPc2UHsEAE9VUWnlR/jQVs4P8KnU7V4n/CrPcGoHZ1SNRwcIJKlMBFXGpiTxOG
         oWNmgKIXZ8+qpGlxVA/U6+qQBAyLXcPZG+Fwn8mUgTdyhvjFE0wrXAXRd4xIxCQ3QSaU
         k5ksPz0mxE+/amZJc8C4i1eIqTj6tx5a+EG3RqE6cJURiyHCTCs1AUig7m2eBA1eNz4P
         wUAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=EbtR8ogVcBT3pBoGD5NlmmJOX041cHJmtNgUhAxsT6c=;
        fh=ZdJHbzywGGZgO3ETNTfDcBtox+XvoNihaQqSe7PfjiE=;
        b=OujlQ2gElfC4Wn8vOPBtpMSkbRfssFE0afRzJJDKAoLoBmSlZXinKR90sdEaSEoYUK
         9t6qXwSKx92CKqFljI7FaBXrrsLxaK0O3oO8y8rMrNs/VNB6G1CHDshzCTjQrRgbAkFi
         XmLsR01M7CK/j9Z9YxNAgflH1EtZo2+BS4IQpFqDNjsSer+mnMz6KBPNRzdFUZb3lbU/
         Rfxrmvo9D9kVkzv6wkp6/Va1fNx1LoOYkWT6/CVzWjBZ4ct5ZSCV48zx0Frtv8ppCWBQ
         9FNy4WNFLRdMM4zHG3xt6eOeSx1yiM2mEm4Vzv+9cmIfKu39jDNW4imLvrb0iTivpFmU
         wZow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786028948; x=1786633748; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EbtR8ogVcBT3pBoGD5NlmmJOX041cHJmtNgUhAxsT6c=;
        b=mAfGzTrA4gqRj0ww1ZqgWU959/mJUsnWRP1T0gIh1haFNWMOdKrmFfQLdLeBs4WE+3
         vn4HX0HfDusbEZVSrwBmbYstteSZgZAyzhCPSMjv+tRdxxyrCFrh8W+CBr6h7Q0lEJUc
         AXrceHL+ZBkDyMBzsxDldqj0km+vSMVOhxiyHGtnbHfEWoqxjXuQg/uXbiPxiOxxwejc
         HA3Qkdo3fXePR+MuALzneStD2r/DxCI6BF3KxBzjMLBTipXker9SkWDhbWdTPk0vORbb
         lXXV6VRG1Oc1669i2zCCWnOY5BgD1ou7dNnOQOaZ4r0yNxDEVTxlIfwtQVh3gbZ56pCj
         R0fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786028948; x=1786633748;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EbtR8ogVcBT3pBoGD5NlmmJOX041cHJmtNgUhAxsT6c=;
        b=ai4q6TR+MNJr6XI2Vh1mvRdKdwRNBl3aIp6TK2gqdIZbPIjGc3Op5vy1G5OwmMnBct
         uInfDjaTxpmFwVgDPCtog8gQwZ3QvKKiS9fj5SYg0K2ZJircCLvuuoo8h2n+Xj2XAnwV
         oc5H1228CfD4FYmY/6kyBf6N54o0A3joA+CsnMrL/iMMXuCELh17EtUBW+X5ZxVp42In
         pwh/7WB1g7+SZN/Zcuq6Tiy7GyJz3qZk8kOoh5G9tzc902tlT0tjmkOtGGe/KrYC4ct1
         TE7LIEZIWJ9uXb9YOUdycg5NjCKiOuzMzREAMGKB4UBYdVgiI2m84MKB/clK4tN1+qHh
         hEmA==
X-Gm-Message-State: AOJu0YzlSEUvb/PXD3f7faZKfkyhfBf8ZXVGDb7K/x3t0v7/4AlO+eFm
	B8gjA94tfjnTbftp+0F4+xfZEYNcd/5KZlm7IuqGZyDbwFk88+t7MnBwh3zrwEeFhLE4xrXIPSc
	6H5lbZVAeMXxwwCvybO5vYRssC1sqE+XLXd0j
X-Gm-Gg: AR+sD11WhEowcvrQFhURYfUWj3NVjdZAFm+nsfqnkyZvhWKCi+2HilddoCYZ498c/JH
	m8oU0hc+3mA1wgUc32ugxizyI1e5iZJmorkT35M4zEO6RDiLksKg91CY3glecU4yaWIBCsK6Mu0
	rv0VA7sX4FgkS4b084VW9+x6p4szMvIkAmrMubhRtqzXE72YnozGkRCh6cHEQSb4QNh4BTUehHm
	XNIaDONF7Cm+dlajUi+tSfCPTJ98mczxbxI/n8+e3JACvJT47frSmKy2Axa4+CGynkyjATgageo
	Zqmk+VojKRpMn/gXFiQOAtPB0ENfVg7JvUKJgA8Z2lKfhhBs4EClGlX49ZGqZkC4mJS27/8/+mq
	YViM=
X-Received: by 2002:a05:651c:a38d:20b0:39c:7130:f0db with SMTP id
 38308e7fff4ca-39fbb063a78mr14445221fa.6.1786028947444; Thu, 06 Aug 2026
 08:09:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260802212826.1090943-1-sahityajb@gmail.com>
In-Reply-To: <20260802212826.1090943-1-sahityajb@gmail.com>
From: Sahitya Chandra <sahityajb@gmail.com>
Date: Thu, 6 Aug 2026 20:38:55 +0530
X-Gm-Features: AUfX_mzdGX-oscAQc7FWaHTPzB9Irnx72ehyZxoMYczXRj_3F20vj4LCHH2mJqs
Message-ID: <CAP=WS+vys5ob20mkxpzPqUjeCqG6hm7-EeDdec0Y0NaBc+tT1A@mail.gmail.com>
Subject: Re: [PATCH] read-cache: avoid sparse-index expansion for unborn HEAD
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	Elijah Newren <newren@gmail.com>, =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"

Just a gentle ping on this patch.

Thanks,
Sahitya
