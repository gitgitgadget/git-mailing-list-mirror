Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4556155301
	for <git@vger.kernel.org>; Mon, 19 Aug 2024 11:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724066433; cv=none; b=bVNGDFYayHOFMvZ7HESihAvUEHqCMDCkD3B7g5Ko6bzGZ2GSkjQ+8aH4Guo+AtHZnbXxOq3SWBqFEWnkAoU0n7YccfgAHVyNSwXMhJyqhYgQKZbonpLJYT7VY7l4NxEgVlyH6v26idyhdotwYaS09PlX57il0pNehYPg45xvXz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724066433; c=relaxed/simple;
	bh=Hbw27RqrnkmZsouexnsyZjMFcBnI4MG8WYB6dVJNrA8=;
	h=Content-Type:From:Mime-Version:Subject:Message-Id:Date:To; b=YWD/RmLK3eB/gXldSMLvBIqxKxLFel+tiwVceK55YxHvJitznQ9LeIQNaAzhmi7dIJtFGml39SKsbk/vdjwaLn5GI3VSNzxawkZnLjQEQ3fDo8mlGGFPosTvmuec3eMFERY1Mp6d86YoaGDxncAWIlDHxsm4L4CykX54erFdqvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DxjtOIae; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxjtOIae"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-713edc53429so734352b3a.2
        for <git@vger.kernel.org>; Mon, 19 Aug 2024 04:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724066431; x=1724671231; darn=vger.kernel.org;
        h=to:date:message-id:subject:mime-version:from
         :content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hbw27RqrnkmZsouexnsyZjMFcBnI4MG8WYB6dVJNrA8=;
        b=DxjtOIae5z2y2/y8d3htpXcFcVK//Om6V4mU5zw86PtbDGjfEm2kWFJyqOmHNrG96E
         xxh9iaIY9kWyMU9YpL71e7bIkUFD5XIM1k4EFN6x4RaA0PpWDrsCHxylwTFVGUPUokgc
         GPXXsxXTeFcGPg02laiimf6elP/fvoPgB7XkuymZKWFV+M588Xlc5Wbqwo6X7jQuXHnv
         KRZ7NmPnK0xfa/bAHa+qTIDxpR0p5BDoeSj87goe8OQgErbKz01gr81ycSCDmZJ8Pdle
         0e5WqtvB/xW7sWqwjCSXJCcwfUFzS3n+fXF6rJZQw3qYxOa2N02XUC4zv+85y81h8hhF
         CPCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724066431; x=1724671231;
        h=to:date:message-id:subject:mime-version:from
         :content-transfer-encoding:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Hbw27RqrnkmZsouexnsyZjMFcBnI4MG8WYB6dVJNrA8=;
        b=IgSqKYgzMeDLMbb9N9F2mY3T2HnkjdX+uSOHAkMaw7aprupDFczU901klQ76OJFYa5
         yVKxNrTbrXq4pYRgXzxeIAkq3ITdkyASmQZGA1qp6QOL5333xj2eqUXyzgjVgD0FnpH5
         gDWX/KsUqqEQGXeoR3OWJrG3JsHK3MRCN3ju3fA6NedWRMIZr+xlis+VA2UebfxDKdCo
         FWIlwy7XuKiWnOSOmnIjLcbord9s2rH6VeGWZbPwWxbtniGEfE7xzHGMMB8bInnkRGcU
         mZ1JEpNKwhoZG/YkuXgr3q8m3GAf/Uxdk7pRJsFJqckPpl/e1huZ6xcMPy+6DTuGfnp4
         0j+A==
X-Gm-Message-State: AOJu0YxAoGJ4khJoePOFnvBzKiUHXTl70+bidkCq9FjHC02XlLdaCqMM
	thkHSmO/IDQaoaRO0Nz6OA18HhPmELdN2gImBpgYEdf9kxYT3k+nR7kwCw==
X-Google-Smtp-Source: AGHT+IGPTT+XhAEDBox7rihh7uRg9Ud600faH6FnyjK6oNimQSWUZfBbbRcLZKGQIz/5gcbG8k4BUw==
X-Received: by 2002:a05:6a00:3c94:b0:70d:3354:a190 with SMTP id d2e1a72fcca58-713c4f22081mr10305263b3a.27.1724066430684;
        Mon, 19 Aug 2024 04:20:30 -0700 (PDT)
Received: from smtpclient.apple ([117.20.113.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127ae06bc2sm6413765b3a.55.2024.08.19.04.20.30
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 04:20:30 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: khmer song and funny clip 855 <limeangkonkhmer@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Hello
Message-Id: <CBF10415-729C-4765-BE00-5D983E6B6ED4@gmail.com>
Date: Mon, 19 Aug 2024 18:20:28 +0700
To: git@vger.kernel.org
X-Mailer: iPhone Mail (19H386)

=EF=BB=BF

Sent from my iPhone=
