Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6F035F161
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 14:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791989171; cv=pass; b=mXncGnlGcdxH/LSKHJ1YIouZp5aUfHFiqiqC045Q5PW8uAdHh65xBiV9SIH3FZWwsaHtdpZiOQkWsvNoNj+ELdR5TfvjR6ar5gliSuoZ5uiO5GNxWAwbNqj+PxNxACgYN4/ae4yFI8L+J7GGt1Sqjkfgz6u65RDSJlHSw4YXeLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791989171; c=relaxed/simple;
	bh=lhK0j8CI941+cApa9SsXyPNAsQtmxICq4tdvguD1u4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EnnjtMgm6SPyYz6nF0jvvxWGXanZeMZ7/G+NxoKp3pC3Kwl/p9FNqdLASwfDwdpbvxKO9poB9wb7dkixm+X2aMEx3ORh7mUhrKtFLkAPmnkDwQY9C+ErkvWzpYHAZq3msHt2AIKBdEFQfLLnnzIM0sWMroh/1hnYmAF4F89N1XA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYRNErO0; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYRNErO0"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b1afcd2d23so4462942a12.1
        for <git@vger.kernel.org>; Wed, 14 Oct 2026 07:46:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791989168; cv=none;
        d=google.com; s=arc-20260327;
        b=OcwPZq6sgL1qwsYzGa5vzJZRUlgud52oM/Mu4rNFBg801g43qpKs8Yqh3ABgDqQLIM
         VmMys9br+HPD6cq2qJ/tkwVf7asQ4lMYbbxGA0NqIHBYy23i73/Y5ZGo6+2CcC9Nj5M/
         9nw9cr1sYWr1VXnpfRHEDX4IxfH3QZmtfatE479EAQu2lt8aF5yDHudIs9l6YLFBo5Zt
         1x+MkhotMTmGRqQj9sV+65kV81gyq3vnNc1DOcp9NWF9r7Aqdonn12m4nd/ZD+CmIKhH
         K54guw4SX+V2+q1N7TVLNPgfExuYaHKThO/b25d7mf2wC2ESXfsIZHe8kcSiPj+unpW7
         ++gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lhK0j8CI941+cApa9SsXyPNAsQtmxICq4tdvguD1u4c=;
        fh=rUzWb1UUZHWaC51Hxty2oPk7WUzlHC8vHxaySzYfPkk=;
        b=E0pLK3JuzR9IP/9dCy2+sj0MdrDFNibdjSAT0TC93BeCZl7QhRm5kNpxfA3FGSY2Ew
         4Y0ZEKGIaZW06ap8o4aRJf2E2/ytuj4WeEsZIKIRN3SMYukLGbBpaHw5teBLYBUEJPus
         5/R6UKlb+mp79vhcjuhQtnzleH4wKeCfDyOX7Ygxg4bcWnNPV/cm65rw4WJm9JyttK6Y
         NykuieVmuWzdmml1pYDqQJZb/BiHLL8cMXo6WpYWBvCioG3iX/c0lbPowdJXw249X0K+
         OzDbxYMvpBWDWiO4i0D88y1tBRLGv+1RRa2rJTDDnQ2yaBM9nSykYpztYJqXHQv/aepo
         SqZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791989168; x=1792593968; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lhK0j8CI941+cApa9SsXyPNAsQtmxICq4tdvguD1u4c=;
        b=SYRNErO06rKvnQTTWMlZEm/aNuS52BNipnTodh5Ko/l7PxJibpiMLdACDOGXkKD6AY
         XImrnL/er6FrNmgcA/fLCq9PmjbwAqHUeGDFYRPv9BTIK1I5cylr/g4iGPmZzrOF3Q8X
         s9AJqdjFTUDUrNuxcY/eO5NK6DSXrCAvCM+QVNU/k40pltJzcCgfIy+KHbrAxod1RYms
         p/8pJ2IHV+4ZK2e3jpPgE9M/xhk2MkhbrAScAQfOPBKRjydGzr1jfcNk9cON6AUM0ctm
         5v1sqDBQjpW4J0GEZb4CW708PwMm2zBh2jLAjDoMIVD+SocdsrvGLbuDHYQogp+n5X5v
         EPQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791989168; x=1792593968;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lhK0j8CI941+cApa9SsXyPNAsQtmxICq4tdvguD1u4c=;
        b=bUkgha+doZ+iBVDI90gqM3BKHME5bZCLoIl/SB9A/+8X+ZwMSPuCpGDCfVY4EohdYv
         xsUfccUdfqAObnq2GC/az8FOqLTKSzWBSelcY/ysABIbV7yyVpqoZ44rpdzDyd2nJI2C
         npVctjq+jFw0vQvCbN1qR1A8l2cXpmwP74rjvvdw/IinQ1sMpoWbY6C/EumiaiqvvoAS
         Lak91lc/4kfefuB33uYOVFv5mktlAI3cl9wWx6pwg3PeVNwlrPaT+xm8q/+D+IobgsUU
         D1Pur9yVLK30oEvDj2GmgfjCudEhKI9FaZ4kmh1s8PaTg0guOtz1K+C3IFvin5yqKM/p
         u9WQ==
X-Forwarded-Encrypted: i=1; AKwUvBw2rjUnfmgyePo6UXSSC6hryulYVYqTDB+wMauMEjrYa74PN/DPvVYomjn70ODaIe1n8wo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLTjN7gctfnbBijbQ2eYAokJW7pLZFi7c3lNNtH1vjHL+bgqBMr
	K8aIuoupZcBGuLtMQGY9x/WCah+2Ur5VrVnCiyDpJcPYRMsYwC/7UzqP0tgL7znJM5gs+iim3ps
	bHsIX5F8NVRWf7eiXefzW1d/gTIjCzaM=
X-Gm-Gg: AYBFou0pRKSZ3/Owq/CvbbB942EDomVA/l7GuUihA7YPNw3+acqHsvCoAm6j5Znx86L
	7dGKD7Pp6TpZmeiFJhUR40C4siFNUM8V5HRODm4CzHhIXw6cYN0aK72ghfRXCWvykv7wT1NLY4u
	FXNQXWfmatg/z0G27O9KUNdIo3dNdyWKpBvZMXGAbaiIyzhreQtkabjHUQU6nSc7ns3kK7AuyqW
	GtrnrTUzRAs1A7yzHhQB1SojuHLNqh4KLchX/W2dC2CQhun90+s/r/89r00Ocg/TQ3m55L5y7iB
	yJChAOLyKngplVNow54ga9TgUwBjnu5yxTH8nq2y5b/KJwoWsGYkCGvLTOFt90zFuE5h209D9gc
	vRX5YTyfSmvRJGhk=
X-Received: by 2002:a17:907:3ea6:b0:c2e:7ba6:12ed with SMTP id
 a640c23a62f3a-c31aa085c00mr1469887366b.36.1791989167939; Wed, 14 Oct 2026
 07:46:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+ew3JuatNJ_bQkormLgm2O1DVQ4ZBTXnXnJPjOMcfcKZZ+Ang@mail.gmail.com>
 <CAFpMFfAanhfXo62tF_jm15CWo5Pdi8-B_vEZi5NXztb8uppPKQ@mail.gmail.com> <CA+ew3JuQ4_xhgTC_rW1AOUzErjmDbsE90L=5wFFPqN52dsV_mg@mail.gmail.com>
In-Reply-To: <CA+ew3JuQ4_xhgTC_rW1AOUzErjmDbsE90L=5wFFPqN52dsV_mg@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Wed, 14 Oct 2026 15:45:54 +0100
X-Gm-Features: AclHuK-mKAHJIKBipV0ux16SMAAFIloI58Q2wUjP-dF34OcSWW9DqA59-v6F774
Message-ID: <CAPSxiM_AkSrCb_eEpD6BjxzmEqV7ZE5z3Am22hO36egna0D8xA@mail.gmail.com>
Subject: Re: : Interested in "Implementing promisor remote fetch ordering" as
 Outreachy Internship
To: Wasswa Edson <edsonwasswa54@gmail.com>
Cc: Okhuomon Ajayi <okhuomonajayi54@gmail.com>, git@vger.kernel.org, 
	kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"

>
> Thanks a lot.
We do not toppost.

Thanks.
