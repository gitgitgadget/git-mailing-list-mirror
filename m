Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75714149DF2
	for <git@vger.kernel.org>; Fri, 16 Feb 2024 19:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708112096; cv=none; b=Cl9iD1aiPT8IVBN5jrHGzNzKVM2vXamMzDAECUyb8ftdAgPORBvqeEv0EEN72j+r3trf95afG6krDtP2+SOyT/uFdhh6XY5mRMucLssXBT0CxsaIyUlVxB/Ra4OdMRfRw0ogQHZqH5ss7uSlr3f91ArxzBLcCxEiZF4k+OVKq7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708112096; c=relaxed/simple;
	bh=l5hfY6//S6lKaXwYAlOPkYUu9ettgV5+3F4FklbHExU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=fYqQZLcWuFPiuFlGYgZjF9R8PsxbsTsLxUwdti2PqfecZEkn2Q9oclSbbfT8k5eBV7kmqNo0OIb6FiiPYqpWAsSDDG/Zjb4u4E/djdItMxGNpgJJhL6CnVdISgvjDx/Xh5qka8SqJbP3IAab9K8rch3E2OtdnrEhjBaWpsGtB8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cw9hDBJD; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cw9hDBJD"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-363cdbd584eso8245425ab.0
        for <git@vger.kernel.org>; Fri, 16 Feb 2024 11:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708112094; x=1708716894; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l5hfY6//S6lKaXwYAlOPkYUu9ettgV5+3F4FklbHExU=;
        b=Cw9hDBJDBcNpSH54R8yv701MIydJQHpvsUzDd2LUw1ngPpZO7o+NrJa9MZPcNT02Av
         +E7D+5gwYDFjd9Waq8oqms4Iy+oZoH4lFghaT1AQjmS1OUetAzpoj8ze6pjpLKIN98Hp
         alht3XTcki/uk4wyhKMwFxkHnpgF8Vx1S+bo/Bc31ArBqXe6VQJIzBwi5qTdZlH39vRV
         2r2eVoC+tekFvDhSIcsY/nOXWzO7nI+3Y9fjm7RGwexSx1fxWpprKhFJ+RUmE1Q35/Vl
         GXdYifCl+h1Z4/+IPgyGSgZenmYg2Y4ee0vDVDXbORrnuBueR7GfKgYV1SekwMQMrV8A
         OwIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708112094; x=1708716894;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l5hfY6//S6lKaXwYAlOPkYUu9ettgV5+3F4FklbHExU=;
        b=s/tM/X/IoncXzVaZiIBZaErj3iZi6LHTSgsYFG9wcVLz7ibe15EMu+ubm+hJ4Sp2Bx
         IsVjZAxXgati7YB80mbFBK0RJfP9j1XsyLsYgr3Er1CnnkX1AxxgE6UdQZ+IK7CGcPEc
         bwGI2y72bWT/suz/k8kl7AyL1AtAejl171ljD8XztrAh3ZBwPcB1zlPHN8nCZzxB0kVc
         g7nGD5IwB2juzZoKQeyuLTZies+mw8BSTj77aa4qgixT9G5Jw/+4aE56eivsx1aIzRWo
         lN4LMPebhuYm1vLqC0skFkFjui7fNWgVfWhjkOX0iR0Qd8RByC/YH2ey4lE8CUOOFByO
         QjeQ==
X-Gm-Message-State: AOJu0YwnqgKnAi8VLhStq4gy/BpyDe2UYlr3ZAsKkOOVWCDOWj8aIK2k
	6EzKgVXdsm8wjflc8nzFB6iGCrWHvdrXU0GL+q7jAViAPQbK+ZqucLQzFROhOuiv7NHZJj2Nmr+
	kHw0h5/DMAh0k3AzEtjSCx4GxDaIbrvm9/ZRvWw==
X-Google-Smtp-Source: AGHT+IGVWNteUP9vcL+3J4xcrw64nLb4DopuPw1Adfu41gx/0Od26/nfww7+ONygswvMfnbQlUwo1KYBzMlGNnmgzTk=
X-Received: by 2002:a05:6e02:4ce:b0:363:d9eb:c2e0 with SMTP id
 f14-20020a056e0204ce00b00363d9ebc2e0mr2789923ils.28.1708112094294; Fri, 16
 Feb 2024 11:34:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Gabor Urban <urbangabo@gmail.com>
Date: Fri, 16 Feb 2024 20:34:39 +0100
Message-ID: <CAL=1hhwreG_W_Ch-B5DXioqjUsfkgjayNZbkCk7uOv3vc=TBSQ@mail.gmail.com>
Subject: Question about migrating a repository
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi guys,

I need a bit help.

I have migrated my git repository from my old computer using a bundle.
(The repo was local with no clones.) That computer will be dismantled
and thrown away.

I checked and verything is working fine till I get a git status
report. The most relevant part is:

On branch master
Your branch is up to date with 'origin/master'.

I would like to make THIS repository to be the "origin". (The other
will be destroyed.) How could I do that?

Thanks for any help in advance,


--=20
Urb=C3=A1n G=C3=A1bor

Linux is like a wigwam: no Gates, no Windows and an Apache inside.
