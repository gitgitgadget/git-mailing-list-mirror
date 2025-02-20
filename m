Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CB51C5D67
	for <git@vger.kernel.org>; Thu, 20 Feb 2025 22:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740092009; cv=none; b=OXLYRYftSv4ltgNVD0I52AqMcVowywu0BrtI3vjByM2CVCzLfXoItjkTo6LAHigSaVES6G/SoRVjYiZE8MUzUB0f4l5C3m37Gy3GM+RbCHCtGSAwTaHyDc9IDqsHFzcYPNpUqzWlsYcYU9pNnKsSPaUJyJQpCxYO9rWrK8LkvR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740092009; c=relaxed/simple;
	bh=3OTaL3/TsTqsJ2ijxz0Lk5RIX3y1G3oIORLhlAtMMkI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=N0Cl5uiAUkwlPni68Pq7mvp71Yth7wn/g2zy/PMMhiTDwySlfB6Q49Tsk5J9mD2/Jx3WcymVPklAyYOuSvMQG6NNsJ0QEfjBp1mxX4eTOfAQWh/wgd9fW8JKCRmqzUGgSKvtI3jJrodFzcwEiWomdABxD2W1n8PUVAHRaPVVHbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z10W8X3q; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z10W8X3q"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-546237cd3cbso1514064e87.0
        for <git@vger.kernel.org>; Thu, 20 Feb 2025 14:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740092005; x=1740696805; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3OTaL3/TsTqsJ2ijxz0Lk5RIX3y1G3oIORLhlAtMMkI=;
        b=Z10W8X3qRGuQh+CJLr6vO7GAj6GmcskkK36upK/52rxO7KkCqyDcg4H797bc79YDVx
         JkGPH9G/cbzpprDnz7e5m5SAPEi0gQ8SWmUft+Q6PEjP6/x96wH0sBmn7Tu5ITEqx0mr
         UQMiigKq/1HGZkqZIcThXIdgyqvbKzB4DcuCn/KJP3BFnAOXlNC4W6ky1DkRt8bM8U/E
         d93AnerGJFuZOTUYmW6d1x7ivtVxr7loznANW4sSWDWxjHMdinsVgSVVG15sGRT+T/Du
         dNsLvtsAvUviNWn8VxlF8zNb6px1mCxoasSR9Jjzm267QKS94vzoFstER5YBnxP63cnM
         bcQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740092005; x=1740696805;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3OTaL3/TsTqsJ2ijxz0Lk5RIX3y1G3oIORLhlAtMMkI=;
        b=ZLxNTQEB1Fqhh4rn0EiG8iBsuFsCANxzBrLaDvJbMMOw01s/PAitDULo4KwriK4DYf
         7Vnvt96dUDolZrTQ0gRg/QQn60uwC0RHNx8YlBD52FqhAGsJzJxymgjL8TUGP2/UqkJn
         9GoN71jsC4sJUpymxCPzYMQ2pmILlEqWC4hAU8DjdS7tVWXElg8y6/2Cqiy0WwKRkFQb
         Tfwrtr70n2fVmfaWJ6UPXiDWF2MTBZ7IfGPnwMfVDqWOnEYAJJhyeioNsExUEZJBFn6J
         maWe+30f3h+zk3X33BK/In2UDpmx2Nz7AS8kPQ2ZuV1MOdln1WEaJOziB/td+b84XU76
         53eA==
X-Gm-Message-State: AOJu0Yze/kBWQ3DVld3zAKXVifHxEWJATtV20vH6IGgPFi2lDcXFA4oR
	SRJgmGNbOTvCYQzLkVyrnj0dTTduuuO3auTHZG4cPIjhFua84SEe5uUlSsjW/Z9abnTXg2iXykj
	T11bNuYzsYAze0qbuEGreRnkj1BwBgKws
X-Gm-Gg: ASbGnctyhWnfEys0FKyl8ib8oxt2s+K3HYVFhJkg6NvnCZ7iIr6gDQ/YS9+sVQLCjDx
	HdWpbApuhLhYQjrsJ7NTKmL/mor5kHkQWUIcV8WwSjnu99GNPv8fqAnc/4+xIz/1UHUtVmuAD
X-Google-Smtp-Source: AGHT+IHGBeAhWtQUfbc81jKAdv8s9QjdWcJdZYTeGGYQuCz2B9etfxJIHr8P1fEAnxPe/v9pvmEBKLPe1OMB8ogF3aw=
X-Received: by 2002:a05:6512:4022:b0:545:2f09:a3f6 with SMTP id
 2adb3069b0e04-54838edee8fmr234870e87.1.1740092004994; Thu, 20 Feb 2025
 14:53:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jamenson Espindula <jafesp@gmail.com>
Date: Thu, 20 Feb 2025 19:53:06 -0300
X-Gm-Features: AWEUYZkyRu5lw-1VAKymc3mM6_1odG2dtKsaPbHrYTlLgzBQo91cXalxoZJ2t-g
Message-ID: <CAOW_YOkX8K=7i7w9c5oH5Cfia0kCzwC3=ok5E=eUwYgpcOKTRQ@mail.gmail.com>
Subject: Deleting first commits; maintaining last commits
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all.

My Git repository on GitHub <https://github.com/espindula/br-blfs> has
about 23,500 commits. However, there are several old (before Feb, 28
2022) commits I would like to delete and maintain the newer ones
(after Feb, 28 2022). So, Is there any Git command (or combined
commands) I could use?

Any help will be appreciated.

Thank you in advance.

Jamenson Ferreira Espindula de Almeida Melo
Jaboat=C3=A3o dos Guararapes, Pernambuco, Brazil
GNU/Linux user #166197; LFS ID 24492
Key fingerprint: 234D 1914 4224 7C53 BD13 6855 2AE0 25C0 08A8 6180
