Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794565192;
	b=KwsD0rsANOU83J+s9JBWoEGVvqbW3F6sD2fcvAx08pIGaeyHKzYeAhfbLVcvvyfIor60
	 jqIRx9BUmNxDCsJ7GfM+Ip4e1xMA1ABDBZGsREUof3ahMF4kn1mhF7GXGqrPftG4G7ICM
	 QwCj90RWkbQfDEHB43u3UsAeiv/c8u5XkvndZ3v1YwQkCDlJNkT9I8xPJIKNj63KbMlBM
	 LxbBE0Oode7oSuY6vdzctqg6f9eURtU+huczJD4nT2C72Z3BtVrHGn3oG83x6OdqUD4+a
	 eGLlLb+mPPoeT591u4VAe+QMH1aY3x5C343CIY9d5yzRmHWFqREAsJjjYt5+kra5HRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794565192;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:MIME-Version:X-Received:Reply-To:Message-ID:Date:
	 Subject:From:To:Content-Type;
	bh=T35ByGxpXOxxWby/3ahnbFuRHeGDxBQRyMKwc4ywAec=;
	b=eoFr2U7scYjAjyrYhO1asvXRwOfC3JGawJLHNloIRfcWEYTpU/G5DaemesMJGt7X8Ud1
	 nm/BvyB2dMJhFsyt7C8v8Ln75CwFrzPsHuc+mNotpRwYNd6fOXCkLgpkMuzFHj8L3T6Cd
	 4JP5+F/4jjo9Y5ftYiL8Zl1v8+fKw30JnqN3kqXX5GUJgqUZrv3lxuUvm/6V+1p2OsS96
	 8snLrVJqEIAPNfVQoBMknIc0JLak8+iAQQuqixulsHPmhxbvyqBXaeWyE0bfSixoJGjh1
	 ksdjxl3w9npMCJoXW9yU0LajTSyiGKxfQXBE/s1kSTFPQemFkc+GG+3Y+CA92vqECBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uMlMD3Nb;
	arc=none smtp.remote-ip=74.125.224.69
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com [74.125.224.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02712606A323
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 10:19:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02712606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uMlMD3Nb
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-677deb12bceso1145322d50.0
        for <git@vger.kernel.org>; Fri, 13 Nov 2026 02:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794565191; x=1795169991; darn=vger.kernel.org;
        h=content-type:to:from:subject:date:message-id:reply-to:mime-version
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=T35ByGxpXOxxWby/3ahnbFuRHeGDxBQRyMKwc4ywAec=;
        b=uMlMD3NbXRv1Ug0ePyjUnenBR92SwR08Uy3e1af4ZfNuztxnzG41AXAXJV69r16mlx
         5QR5uV6M4z89RIc12NKQwgA6vzaiqB1q8rnrMRLe6+TFjPt3sXVTzitcuOIW7qII4IIl
         R6lSGFbvO7meN7vzxEICNhTGc/FxqptIhbm/rRA3LLPg3e2ZR2qmrN2oMa6pRfaXZIyv
         VFQvc04R3n5LPm8cKKHYm83kGSyTjNzmG1584e1EFYYUViLvjUd5GsBO68Yu+6XgN847
         RPv97xt4HzFIuOpqwDb0c19TfFCyPuxA5U2XW62vSc6vxHxLxpF+R8Uc4Ta/DLXBWDEC
         /ExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794565191; x=1795169991;
        h=content-type:to:from:subject:date:message-id:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T35ByGxpXOxxWby/3ahnbFuRHeGDxBQRyMKwc4ywAec=;
        b=sIAXHEDBcZMwGThBeAp6q3pxf0K2BEOi1m4hB8WYxKLuhsNOCgxhJAairQTzAUN0oB
         CHFVPDUyTb9AKarmvtiVUSQaT2FNREYOm61/b1o5mx/fNej4K3M+YUJq7X/fSI2C+JPf
         s6eB6mZVDGkEaWvwGJonNUluH+R+gevyZTPK9BdcuOW6f8sowVP0am3lAzWe4KDgUJtX
         C6wXy/56TLPhwe2hj3IV/1DVSGX+hZTJfW3OESeo5GFs1p6PcHKLEN5bAQT5alqPaHRh
         UFzngnmWy9v04Mh3OgKDENii5vp+cENOrdDm1BDZfR4/hjL1LLzsmlqlz2/OnzQ0OeRq
         iugQ==
X-Gm-Message-State: APuU4Z8vUbF3Lw+XAM27Tz1uazl8giygGVHCxgmobhPq1Lt5A2lOti1L
	is0g8NC+6C/r3oFRWuVQQpIULaygvfNCeuixbsFkf7N4dMhLUsqsljO/U70ZOk3lh58uyWXvFYc
	dMzs=
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:690e:4594:20b0:67b:feb2:4731 with SMTP id
 956f58d0204a3-67d896aad0dmr672426d50.64.1794565190997; Fri, 13 Nov 2026
 02:19:50 -0800 (PST)
Reply-To: editorjxu@gmail.com
Message-ID: <autogen-java-3e9f2798-eb83-4112-a4d4-cb9489115d2e@google.com>
Date: Fri, 13 Nov 2026 10:19:50 +0000
Subject: A journal for multidisciplinary research
From: hiauthors010@gmail.com
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

"Dear Researcher,

Finding a suitable journal for your manuscript can take time.

The Journal of Xidian University is a Scopus and UGC-approved journal with  
a multidisciplinary scope covering all subject areas.

We welcome scholarly contributions from researchers, practitioners, and  
academicians.

Journal details: https://xadzkjdx.cn/

Would you consider reviewing the journal?

Regards, Editorial Team

Reply ""Unsubscribe"" to opt out of future emails."
