Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D11C19CC28
	for <git@vger.kernel.org>; Mon, 21 Jul 2025 20:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753130089; cv=none; b=MlDhzfhlsURLxcoYdHWbY+oCcpW35pLsnuiHYwHG07xVy/YJXMv6SBPl+qgcyozXvRCKIcIyuT+LBwkX/egnwi4dRxC93LM7sgBVxhNUBT3NDQFdNGJv5zARsVVtwEPgZ32i38GbicnXKHHYNc5kfUGQwLXg9RAekthH8Rs9WJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753130089; c=relaxed/simple;
	bh=Wr4OgQ88k2303NzjU6W7w/xAxH1Yd8xmgtRNBBykTMg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=PYIsn8Dl3i/uZjKpqyo5MFspt/6zBGDiWxgA9GIAOAPbhGkT3WBy578syLz93xQ9xQpM/AjqRlBSZUS0q2IPZzXlHGlZd7piDGck4chM8S8jQW6mfxvADpmgDGlygIp6Jjjoq7HT+ULC/Z7MdAjtSLVQp2O2x/HFw+E5RGKFK04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d1gnivdK; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1gnivdK"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ae708b0e83eso849894666b.2
        for <git@vger.kernel.org>; Mon, 21 Jul 2025 13:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753130086; x=1753734886; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Wr4OgQ88k2303NzjU6W7w/xAxH1Yd8xmgtRNBBykTMg=;
        b=d1gnivdKQJWF1F5SjlGg7LD1tYq6q+alT3GdOuCln1Kh6Vf4nw6uvY/toC1JqsN10b
         oa382L+wrW05o4/IhQQpDa4N7Gn9tneIWeZ0QelKeWzVfLvpC0rZp76sclTsUnFU5XVL
         q70PZuVZDbppDUmXiz8IPrfRimOpJ1eyWBhbLbHHxbLYPzoDvfWHLNMwOosOWe+kMv+q
         RHJa6fo1XX/yj6WqHHl37yqUlrWn1L3AkUBb2LGrWtyCcK6T/8nOCwWdJY6TbFORW6qM
         L3DzggPoEGiN96GXFWsTDCxuFdw46y/g55IV3cIIFdRvQT4CXYHIGWYJV1pSQkI7wVpg
         L16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753130086; x=1753734886;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wr4OgQ88k2303NzjU6W7w/xAxH1Yd8xmgtRNBBykTMg=;
        b=NxC+XLweo3vaVduD9OHHUXGg4lbzA7n1S86lTT75ISarBAbyA3l5BFlMhoPvweGvlO
         t21ywn9p4VBxZIpl8aCKvMMKRLhS+BQarMPKI1hmSbuoLNvlsRvhz9KsG6OMYHAj70w6
         rijWVN6NFMd5o6Yuu/1w1YqGV8+zzuMJC2fMQ4lw3Uw2u30sDHJKjgeMtkGTaOI6/mw/
         Mybv/jDMXkT8CpZKQl3qFX8R4DcrrjsqiFV544QA6ym1fRx/882fEyzULd5Lqo+INiLI
         rX3op0r8qzRKG32ND4aeMaqPKTegzJimmSSth4tXKQZZlPRbTC5mZF10dtO65KS0RCy6
         WzMA==
X-Gm-Message-State: AOJu0Yxk8EGqu1NEpDqYh4c2XdAB53AwpB8OvvngfW0VqVknd/veQpZ0
	nRNir5KiVyQ42+lkdWgwKV+iCJvnICwEZUXssUCa4gOQX5i5kVIFDpNnBJrqiTgUOZYXHucLr3l
	FFUMovwf4eGFNIHkP5J3y/qcF/ogrEyrzVB5rt/0=
X-Gm-Gg: ASbGncsXZGz81JuQTKpIIjZxYsiaGdc9Ydfq8h9fXZ7tf6WxaXJ6O0rlxT9ehYhnvoo
	YSum4+5zTiSV1M3q1xFKDXE8Gy96EVYlLxigrwGblHHkZFa74qMKyGtNpX09c41Ny6y3d4tMPLt
	QTIEMlzOjGqniFjP2+lwclR+kkvMEzHHNncMrmeH94pQI1NSYBf6qR0239vI67ADdBnoVDRxr/6
	KuLeo0=
X-Google-Smtp-Source: AGHT+IGZHR88CaYyEjwr3FdMF3oy/4ZTMOrCmH267PuyGYhQrwCU4Xy2IzvRNNhNusOKCyOnKmy2N+zuUFkeu+YXZpc=
X-Received: by 2002:a17:907:3c8c:b0:ae3:5212:c906 with SMTP id
 a640c23a62f3a-ae9cdd83460mr2324276566b.10.1753130085493; Mon, 21 Jul 2025
 13:34:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: James Gao <thehighmountain25@gmail.com>
Date: Mon, 21 Jul 2025 16:34:35 -0400
X-Gm-Features: Ac12FXy8Tb1V4XC6bks88ziexw41HVcsEv3J2rq6aYW4G6WCC3bOO0G_UNC6FvU
Message-ID: <CA+=FFpNPLEYsajBZqhxhnD3-642t=qQribO+oNDF5-3hhuxDnA@mail.gmail.com>
Subject: Bug report: latest (2.50.1) x64 version of Git for Windows
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi!

I just installed my system, and downloaded latest (2.50.1) x64 version
of Git for Windows and installed it.

I am on Windows 11 Pro, 10.0.22631.
Git CLI is not getting permission to the folders.
For example, I cannot run git init - error: couldn't set 'HEAD'
I cannot git pull or clone or git add

It returns me similar errors:
error: unable to write file
.git/objects/36/dd1796da4dcbb2f53005b64afeef698cfaf510: Permission
denied
error: src/helpers/schedule.ts: failed to insert into database
error: unable to index file 'src/helpers/schedule.ts'

I have tried every single help articles and blogs, nothing is working.

I tried running git bash as Administrator, still not working.

I am planning to download older versions, but it would be great to get
it fixed for lts.

Best
James
