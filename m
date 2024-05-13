Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AA6C8E9
	for <git@vger.kernel.org>; Mon, 13 May 2024 01:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715564445; cv=none; b=ADfqLJeJFUhsDXmg3LK7uqxg+gZjq7ygiDrGFdpofuv7Mx9vsqTCoiY403ksl8+AztNabZAV/LE4xAi5Lz5/X06jaMI9Gx5KauKmml64dKsUBZqXL+RtPqfbZWm96113JMbxg+WRH0wlArxYXtgSyMn5Ol8hwvm3Nu9iClJOE9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715564445; c=relaxed/simple;
	bh=P7fdWTZK1zQoOvINMUpH85hvRwyeCmHR0ezfhx52ktM=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=HC7zrWLwjbFDGcG1GDuglwPZPF8EcjlfLnvLuKVhQUDZ7oujq41OLQa8Nyr47iMJTfRGx/yQQ9o2xpxjYrDy3VANZjZhTo47h/fOS7Yj4hRFJ3CQcKl6Y9uvr3cj7pp0p5+9G3/4SkMaXLCxaHtpJaN9XIwdChpGK2LXtTBsC0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kdvJUZhz; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdvJUZhz"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-792bcfde2baso360621985a.3
        for <git@vger.kernel.org>; Sun, 12 May 2024 18:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715564442; x=1716169242; darn=vger.kernel.org;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=P7fdWTZK1zQoOvINMUpH85hvRwyeCmHR0ezfhx52ktM=;
        b=kdvJUZhzGZJg02qK2h3razbtRxbNZXpQM+rZP1dMTrNo/Ph/lwKBOa/Z+4zHsObDLE
         roQlEbx4+l951DZHSY2z8OQJ+UNEgI535Pn4jaWyX0Y0oEYPLqOj148P04ksSSBBVsCX
         yZWIowN5W2wxiUAgD/DiPDTYGvQuwXIzH8rG3eIwushYoad15uLN3bu1pnIJKbF4b0XA
         9aUMK4AxYwt4ZTtikBTGNhbUkL5+Dhggr/s0yOo42NrcNXJAn7lqgjhun8LGfFi7fLUZ
         T29CBDcmOwD43cex6wxRCGptUoPzd/jTqkIVRPfsQwoMYW0Q/BekW/a5mxcC8ERgWhAp
         1Qjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715564442; x=1716169242;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P7fdWTZK1zQoOvINMUpH85hvRwyeCmHR0ezfhx52ktM=;
        b=YwCvHRiYZMd84mP+rdPFMgLIitSz0yM/zbVOx44fwEwVsQ8L2LP5pKKVY0nxg8OXlQ
         xTMKeJ15LKQFQ0QUKFZCq3iP+Zgl1+CSTGBCt7LPOP8PGbgHKfNO8vmf3O9scTnaxFS7
         MOnRqmASAu4oujn8mq0ilS2OGYhovR3ttq1oXTF6+iyp6xLsF9LdtOd0x2ExvyvhWLD0
         c1Nz/baqNm9/40TZUDudW7TtGISXeWxlfyw7OFpBvOpFio7PJ/JAjwa/TjHwQ90y816S
         w5h/NuPeWtnYiJ0cdh171/20xAMe/aqtX+u1siuBpCC3EgmKEdTHFrEEsgNHDFHzyx+a
         UJWw==
X-Gm-Message-State: AOJu0YwXdvTZSDug0uL6aGPkm4M5juYheP8LsXvdoi98r3PlAPqPNYnm
	N84SMG9IV9T7MDV4uQZnskI0bXBsGpymUUM3u9pk02cX1RRq03gNGbjohFDU
X-Google-Smtp-Source: AGHT+IFqwU3jKMbiUWSSJYAPs2ZhorMNvQlKO31IqMFg9Brj+JX9/Mk8emfGZeNMDaOmC3cdd8K5kg==
X-Received: by 2002:a05:6214:440b:b0:6a0:99f1:75f4 with SMTP id 6a1803df08f44-6a168142e14mr95665096d6.2.1715564441694;
        Sun, 12 May 2024 18:40:41 -0700 (PDT)
Received: from smtpclient.apple (syn-074-079-217-104.res.spectrum.com. [74.79.217.104])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e0ec47bf0sm18782681cf.3.2024.05.12.18.40.40
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 May 2024 18:40:41 -0700 (PDT)
From: Sam Clymer <clymersam@gmail.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Bug in git log -S
Message-Id: <ED9E5AD9-D15D-4E63-AF80-209EAAEBAD5C@gmail.com>
Date: Sun, 12 May 2024 21:40:30 -0400
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.3774.300.61.1.2)

There is a bug in git log -S where it doesn=E2=80=99t find every =
instance of the search string. I am working at Microsoft on internal =
code so I=E2=80=99m not sure if I=E2=80=99m allowed to share a repro.

Many thanks,
Sam Clymer=
