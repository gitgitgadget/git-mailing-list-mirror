Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDD72F3B
	for <git@vger.kernel.org>; Sat, 29 Mar 2025 06:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743229126; cv=none; b=kWxKUcdN5AQqsxlKf0IXXn9bjgJc5lCAC4WIrE2Z2Bs8n7FS/5N9QuXSZczqDkXEELSpx/PMLLd688N21Nktvr05WQ54xHY1s+Ly4DEvH7O8i2uUKScLvE3HIOvY9im7fsc9FIb6QNHK+YocdM7OCk5syK6gPE9XUnK1K0I/HVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743229126; c=relaxed/simple;
	bh=klo5+AHDbQifcdiSEW7sl2gd2XS3tQOmHUAZmfFN1zE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=PK3sx3dLOzoIpZpidn9bhedACdZTc2jVfaQEiTK4LEaG5NHVqMICOeu+T7WQP6/7i6VE7gc2nPRY+z3hLVa+QpfaeKRJu5LrASRiAJFjlzevZwsjB4H7x6W52fAlJy3/Qpku/ltzGLr9LL0iqc7yonMyKyJWJVj6CfXtyRKDUKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hncr4TXx; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hncr4TXx"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22548a28d0cso81786535ad.3
        for <git@vger.kernel.org>; Fri, 28 Mar 2025 23:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743229125; x=1743833925; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nDoS/dErGOz5Mywa70EqUiUtul9rAa3JY1V48dm12Rg=;
        b=Hncr4TXx5Qz3Fbu4EEwvoEjUo6VzVjWp5dij/DTfGtZlVkGOu981oga5Nw74vPr3bk
         pNDJz+5l9VwpLpnQ7JeiF6T+0nJORwPBLVSXFbWKvWc+zBMNliejz/tJkpxj7NUZCEuK
         AlRCeryWpLPc0WxZEiUXHgks46qDwz2quPRrUtup4gbvMZXuzbbNg2CUkeZWJTKJGp06
         po/3z+S2K0bdUlvRr/XyBmWtjfFxWtcxfDp+sPGH1DU5EC5dg4wHkFFPU2HANmZO5lIn
         NdIkTPhrTMXVxDBdYQ1jmwHxNg+f85t8Pk4hs4KlnTl+vdGLNsrYPpi+45INuIkpUGmB
         3cdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743229125; x=1743833925;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nDoS/dErGOz5Mywa70EqUiUtul9rAa3JY1V48dm12Rg=;
        b=wZD7P9z2m4woCXOxGpr9HTTQ4SgKdAeLHpDzboVhaAAKI0TL+dRv7DVGqClg7ygPVS
         W8jeJOHglYjOJwaRR1jeu84KITFBjx4dRfIW9Kyhl9vztwFsb0dUL0Vx2em+U3+2sWpn
         ksHfuBHcDXVTyvFmkf58bNkcA43MUSo1wrWf+4laOq8A5jiWoTw8sQo8dcFICGvj24IE
         bFlyCE+RfLTgF4/nvgGMLa84Hc0orZNUWmkWpNHH883rPKc1BRzCOlHyXhWLOIdbU6QH
         pgVkx/45C7yuEWI6thcJCROr3NfSwzWKO9KAkmneabjqWOWPtIU873Hp3MnS3gnDqVU6
         F1Mw==
X-Gm-Message-State: AOJu0YwR4T7v42IVaEH65Mw3xeDanAslLyD4GDV3hstkS6BxBp4UbZVC
	eBd83nxIvwYanUwhCtVWQbVWZQB+k0ocZE3kCiHyDhF37reCqgeZVI+uBA==
X-Gm-Gg: ASbGnct+oEyc0MUi6JC/k9avbA0y3qgB0vzjeQkNVhpIa0GFhbnmHBgkWvcFMkcQIkh
	tyXpxJ6OHq2wGNJFoMX0DNlBJuTc5qHPLVOdLomIzHZumrL1g5QvLDMGCsrnTScxWpgbSd4le/2
	XFICTx47mtvqmxZX2yJWdu+hqSvEniV9dZHCYbS3U1Cr99ZTt3EciDeYxJ68B5Ar4FM96G7dkyk
	fJ0OO46mEKBdP85A5VdSusGJjpt2/ol2wP2s6he17qI9EBQDlb+dDdW5J2vkiVL0yKHq7jp8MhB
	fXlynnz+vMHzxokIDpZmee7RfKwF4bzT7lQqBbgAj80G2kVZTGbpMktUg71f0g==
X-Google-Smtp-Source: AGHT+IFHdsjChX4n74WCxPn+iuKApo4Un0+pEGXzlnQGLPy7BihXUhKywO/2gd9Pmx+M0DL2KvJiVA==
X-Received: by 2002:a05:6a21:3406:b0:1f5:a3e8:64d3 with SMTP id adf61e73a8af0-2009f639295mr3922666637.21.1743229124666;
        Fri, 28 Mar 2025 23:18:44 -0700 (PDT)
Received: from [10.61.238.175] ([103.21.124.55])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af93b8ad842sm2596542a12.50.2025.03.28.23.18.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Mar 2025 23:18:44 -0700 (PDT)
Message-ID: <e093e548-0955-4ced-8770-01cd6eb29967@gmail.com>
Date: Sat, 29 Mar 2025 11:48:43 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSoC PATCH v2] pathspec: fix sign comparison warnings
From: Arnav Bhate <bhatearnav@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>
References: <a3aa5f99-63ce-4be5-8d64-fb6e226b3bf9@gmail.com>
 <aa7753f2-27f5-4a7a-830d-780bd21191f7@gmail.com>
Content-Language: en-US
In-Reply-To: <aa7753f2-27f5-4a7a-830d-780bd21191f7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This patch incorporates Karthik's suggestions.

-- 
Regards,
Arnav Bhate
(He/Him)

