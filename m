Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05BA4C9D
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 06:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728195500; cv=none; b=K1bCgx484+mLpvd+28U/Pmzw+zJDvAxPU21ERMGHgyfaJOBOCpoT5g8iYHk13wZ+B7NtOYVtUvgsvaRv1jIR7Ut9jZLhRQ9ZeOhBjAhl2jETVbV80yOMff2a4DJztd4icVF+FQbpulRkCwojm2TF1z5He1Ab0fHWEFXHM2Tx4cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728195500; c=relaxed/simple;
	bh=Z0T+o4uCz7aO8E/SoG0qtOu6GtnpDqqD5pCBj1U8UMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sUI3pk6ueoFTch6h5aKu9+iWX3tGMYl5G9jlSfea+BwG/cg7UxyelMMmGAuT+MY8clyNEFKqpJV422DryX3GqxGJXl4tmt4JcrAgDoBGG9KEj6p3UPYYhPt20XzOt3uuvZv9yb7/EnC/+Saeq8InFdjo2z4voPjD20L2N04HlvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6cb2c1511fcso3741286d6.2
        for <git@vger.kernel.org>; Sat, 05 Oct 2024 23:18:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728195498; x=1728800298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z0T+o4uCz7aO8E/SoG0qtOu6GtnpDqqD5pCBj1U8UMA=;
        b=SMklhW8Xv1t1g5jPdcTIY8dwq0s1mXeHh+xP/zSOtNK3xrFd3Xjak6oP0zvmfBb1FJ
         mI5PvojYgTRFLXKBPiWfeC19QtOjiX4r7co5uoZz8D95K2ZFwO1dN6zMrF6JH4lx4rW+
         HNARBUGQ5+e23Mhwq7Gk0fuq1mfYKcFKcn3ieSkEYTPTn4ycXc1mzyirVDI+gnJAfMBi
         mYBZJdlIWja+TJLYVf/RJeTTauodTd0x5cjGJSBxpp6vKUx2E8uqx4cgQmYyUQPA7jge
         0IiTHcEUP50OPE3+uRTEzJPFJA1VgWSp0t5b9UH77NilsjIQonfgt8bCxMdNdO2sbR99
         uJ7Q==
X-Gm-Message-State: AOJu0Yyt3/yJXvzWpl9np1jO6IVb5P+thSoFjKXCousms962DUvh/WC0
	yccvgq/4IsLCPri86H96QwCOAWZJcCUKonYhNZDFZFG4DhuWs6z9I1cQgksWeICthdyINJAy/A/
	xUoc4BHTBsC/nfOmc+IxPgHSr1dI=
X-Google-Smtp-Source: AGHT+IEp8Z0vSQ9cp2WPhspIL0cAz/V12ZqtxiSdDD701IPq60aL7JhNmx7gy5IQ4ajJNK/QIbG238GCQ8g/D6yAseY=
X-Received: by 2002:a05:6214:1c48:b0:6cb:6140:f490 with SMTP id
 6a1803df08f44-6cb9a45437cmr55310186d6.8.1728195497771; Sat, 05 Oct 2024
 23:18:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241006060017.171788-1-cdwhite3@pm.me>
In-Reply-To: <20241006060017.171788-1-cdwhite3@pm.me>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 6 Oct 2024 02:18:06 -0400
Message-ID: <CAPig+cTuYaeGs_nsDZcXVQCu2qzt8OzWjv4spMw_8At78av5ig@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Link worktrees with relative paths
To: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 6, 2024 at 2:00=E2=80=AFAM Caleb White <cdwhite3@pm.me> wrote:
> This is a resubmission attempt to try to fix the damaged
> patch noted in previous discussions.

For the record, for those finding this message in the mailing list
archive, v1 is at:
https://lore.kernel.org/git/20241006045847.159937-1-cdwhite3@pm.me/
