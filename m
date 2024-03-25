Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B7C2F2D
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 20:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711400396; cv=none; b=PkOAIBFCbRotUF/2RWSsiFZBOiZ7pMVy2hRzrBaOTw/nVTdCKLCwQnxSYYcR7xuwxduXXCg8oTH4iG80lVV+ql1P2CfXjyKglHhPiJdIAsZQf9KJvl5kKW6PlnOqASospolmmBzTUhlfponDHdML487VsusFYPtLYyp6EzZkmOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711400396; c=relaxed/simple;
	bh=2At3jZFKR3/qe1sqkpVbi80dEVmqh3iW4xrJk4K4LkM=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=NEVLaue9Yatm2rWpJv617upQlItUrcocjdvmvK9Ht99lcypwOm8aRst6yVLfmPxN3e1SbfG/oTO3zA9QR5odpL2elknWk6bbhtfpPtcROJD6KjQUz4ICsbqkJW6NytHon0r27/h2M7tOObRdeP/hVVX4uChKPIdcYKXW7+HyPOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TelR78M8; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TelR78M8"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-341ccef5058so1012073f8f.2
        for <git@vger.kernel.org>; Mon, 25 Mar 2024 13:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711400393; x=1712005193; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:cc:to:content-language:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qTsZby/qCvwmw+zbJV0OT44RzW4TVwi24Ks5rDgD00g=;
        b=TelR78M8gYptAlv3ZuINzdYI6BeFtuBxA0z+IXPLryWkkop4V4wvy7UbE0iY1HvS81
         /ie8+rPqh92T3psqkyg24mVFT0tEMAo2h6Yltnk+0qDmn5fAjL//IP4jH+NCXFFGzafm
         oABwaREszPT/TW1K3LycKM183GMwmpLVJhUjmhcslI/zNSYWI6dtBd8wMB6Rdqa9AhCk
         PSNRcwT97Jo1LRHgO1zkpob9O5RGXS2jDrLZHy2l5bxGJUJ+hFZh7wFaXnjBv1xwnFDE
         YYTQRRPpoQi5c+FcG5xfsV1fJPknk1TRXT3sSXeMHfrL+9y3xq2liUVmStfusSL1zlCB
         yx/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711400393; x=1712005193;
        h=content-transfer-encoding:subject:cc:to:content-language:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qTsZby/qCvwmw+zbJV0OT44RzW4TVwi24Ks5rDgD00g=;
        b=evnWZU4kOeMZ8wLmQ63hSoYlUXKaAvfV7u1r+M8LtxKffugrOKLqLvACFhhKA4W5Dt
         YoqwAy48dC0jgXSNo+pKV/2WVMm9YK+S9I90FSpOqUhLwk7HliB4cLqjxI39dhSq3do7
         n8TNBjdVmzRtxQdD4VXxRXZXVg9GUkBziYLge0GfIcjkTlye48InEm0MmLc0LOJDgw4a
         fKQ6s4S76hcpfhBPzwu/j/TxY/UgJTl3BB4xXBwjjMztn4PgxfK3RNOaqB7QNdSD5ipO
         FR5KM0degplJs76NTuqH+yvfpoVepAf38guyC1eKzBRFWc1S6xYumRW2QxdldZ46J6hd
         6iTw==
X-Gm-Message-State: AOJu0YxMpuIWMOlo+ygKtLANDXPW7VpOrsd2cgwP6fRTc9lQ9WZgWZio
	joZxPzJnddCSLVqGpCjHnJENiEiljJoi2okTI7J3mUQzkr5diWlUUCIGzgwK
X-Google-Smtp-Source: AGHT+IGD+IVNmCTkbWF6nlFas/B32PjxLmUscfPHWNqbsPKVpEOk+W9nWVw2IIWwy5Hu8qHuuH693A==
X-Received: by 2002:adf:cd90:0:b0:33e:d68a:7d42 with SMTP id q16-20020adfcd90000000b0033ed68a7d42mr5005135wrj.30.1711400392601;
        Mon, 25 Mar 2024 13:59:52 -0700 (PDT)
Received: from gmail.com (70.red-88-14-202.dynamicip.rima-tde.net. [88.14.202.70])
        by smtp.gmail.com with ESMTPSA id cl1-20020a5d5f01000000b00341b9737fc5sm9391962wrb.96.2024.03.25.13.59.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 13:59:52 -0700 (PDT)
Message-ID: <2c99dee8-fa6b-4f4f-93b4-3f7a8e0901f9@gmail.com>
Date: Mon, 25 Mar 2024 21:59:42 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
To: Git List <git@vger.kernel.org>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 0/2] improve interactive-patch
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Let's reduce the verbosity in the interactive-patch process, in order
to make it less confusing.

Rubén Justo (2):
  add-patch: introduce 'p' in interactive-patch
  add-patch: do not print hunks repeatedly

 add-patch.c                | 20 +++++++++++++++-----
 t/t3701-add-interactive.sh | 22 +++++++++++-----------
 2 files changed, 26 insertions(+), 16 deletions(-)

-- 
2.44.0.494.gf640f9da83

