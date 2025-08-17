Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24849B652
	for <git@vger.kernel.org>; Sun, 17 Aug 2025 01:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755394353; cv=none; b=pnGGWKyJO2xhq7cg6X1U6Ug1ixj/6hGD4nDewr04m73oHDa7lF7r4vNKPT0pTavaeDmPQ2xnuC00Vl+ruLT6TCICznE3gQl2H/jkjyzUOKZBqwrYKzpm46nJU3r6NOPvTgKtSMHYwk7lmJdRhAEKq136+IPLLZBfVxyKTjtPTFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755394353; c=relaxed/simple;
	bh=jJToyimYP6dxGBmkhsV8KyVvMZHZVPKpsFvbMjINUzg=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=SXlSOKNrEX5IbU5I1NK7b1hVDl0g1UFOaPFrr43lspzwvZxRq9Yaom7nreRpT6ctG5OiTCo6qRHl0qlbNZbF6hk6fYJ1v+bFtoOGMYDAM9O2RHpAvU1EsLdu0EhcoLMZSCf2C80mlRYORDnuU7QOdZUoeWTipeEuCbakDSfDlkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gO7H/v7v; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gO7H/v7v"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b47156b3b79so2351366a12.0
        for <git@vger.kernel.org>; Sat, 16 Aug 2025 18:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755394351; x=1755999151; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJToyimYP6dxGBmkhsV8KyVvMZHZVPKpsFvbMjINUzg=;
        b=gO7H/v7vWbsUBOZQ27b1vhpVgRlfj0bkXIhOJgRMvxAVTPtS6dRXTnscG7ZAe0tk1V
         6JXjGBBtoKo4mnLSm7LDD7xVMrc1+tqj9XblSYmLJ8UszFHcm7jCu0AhHWxf7KhOEUJm
         +9ORsJWNv/A8YeS5T9izBHzGgFNhZCiZwEOdQCKCHvZgKeH/E8wHf7m2eERkVqGExfzK
         dLkSYdxTTx0/B5oQ2GZX5Ej0O5lktOYCMpqZMtfzXNAfk0/cDKDAHp46VeyUITlq0TSa
         4Qg6eWAVhasp35x0W6x3zyDORIlkypraBLI4koZd7Z0X1kE/zmJ1cZmSI/atxp6wHodm
         uNtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755394351; x=1755999151;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jJToyimYP6dxGBmkhsV8KyVvMZHZVPKpsFvbMjINUzg=;
        b=OYBLjDC3Y5M+psmAW+MhWW8bGGJDKJdoTl00+qoCBu3UGPVOjttkRbBORUrWLyjqa4
         +uvsKlpNGPdIzIGfkmikaFNse1gBd69Nua/Ajqz+FMOmaq4x9PTkHH0vRoKYUZos4eTX
         HxU/u5rxYVGKQamlIwlEfZIs0zy91BZEefy15+VTvYSn45OqXcLCvA0iTCPQO09A0dpe
         nCe7NXZ/vpz0LK9aimfK3L+QFXM9ENKdrJ6mz98dseK8xfCj1LvKUW7U8XQBmLDax5KJ
         r0zbErzpSvNGeSv9Ol1ZbwNVx/KjA48wMngbNwku0YOa7Hnvpmrz/wA9VEsld40NG9HP
         v+3Q==
X-Gm-Message-State: AOJu0YyOiHvWqTa5FffucZheFRQM+qICZLK/WJps5TEbSqYWSAUkNE6d
	Qn3hiKTD0sQ3uq43b+EQyPuXru944FK2EX38esXUij9YQEqPpgHPrg6jyLXbBvmW
X-Gm-Gg: ASbGncuMIdNiLlhTe1k6EVui3mLqUS3CCwSEOnhTNNIej4cKYfM3a9WhMGW9uffHUkW
	W+kkWh6ALvPjx4zegzWBGqeHna33aFGi0EYJ1xZLINcrfTaYo1b5dHuEl4tzDSbk4AKoSBKJHt6
	3QL2/DvVe1pRGd4YmE7Y84XVAgIYXLzZTUiiVPFKAWja6jbTOgjh7fnciySc6CpuUi0QKXGYCXV
	x2FETUMqFFMGSI9iVSpzyWvq7kz3xawJPMKdXBfZNP0HqR0l+1SlYnrCpZY1KMdsDFa8m9ddOTi
	2b11Uz3ECiFN+I/dWTaV2NkY1tqjCpCIHqltvamLofLGl8J6XZ/8x7qehwDmBac/94msgrssA3j
	CXOSY/KG+RcF8rFtWd0F+Aornfka96IyRRjoYE7vZ/BF9qwOdaanfH1wG/++sWFLRiGmvKrd8od
	e9BQs=
X-Google-Smtp-Source: AGHT+IH1FrmCvqJgLhDkZGAD3WDdN2+XkOgTJ8jFQo6AUDbJ5c1faSQTqpijf82K5eIuzgnwNXzVSQ==
X-Received: by 2002:a17:903:8d0:b0:240:ac96:e054 with SMTP id d9443c01a7336-2446bdf53f4mr95143885ad.23.1755394351230;
        Sat, 16 Aug 2025 18:32:31 -0700 (PDT)
Received: from [192.168.1.105] (23-93-88-48.fiber.dynamic.sonic.net. [23.93.88.48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d50f8easm44669585ad.97.2025.08.16.18.32.30
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Aug 2025 18:32:30 -0700 (PDT)
Message-ID: <76ee89b3-39cf-4218-bbb6-1cc3c6e16ddf@gmail.com>
Date: Sat, 16 Aug 2025 18:32:30 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org
From: Jon Forrest <nobozo@gmail.com>
Subject: How To See Index File Checksum?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I know how to see the checksums of the files in an index
file. But, I can't find a git command that shows the
checksum at the end of an index file.

Any ideas?

Cordially,
Jon Forrest

