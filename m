Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F24C524C
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 05:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722318273; cv=none; b=dBeRTzLQdI5mszk60U1hd3vE54tU+dwqB9bYdNbRp4xDELrq6m9iRu75eQm+YzHq4Dx7xfhDLXcTA0SbEBf7SmLLMr8CwrEpTjRsIdWTs9dwLS2BiOqIOlRH32yf2PiNTUlXpigZtotrHCmOeJBEdQ/x7LRSzaFH7MO5yZwt13c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722318273; c=relaxed/simple;
	bh=dpp6n4Le96PcFdqrSN3HsUS7F8yAUobLSxh0ivCOqVA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=SDePXSSgWZFWqAudhLybt9A/U8hMOVy5xylzILQMnMVmCwGp/w1g3Ki8SfpALjOtGTEyU6xCeQoxChqwkTtnQJgB1AiSOJbTx9y/pv2ZSvkl9ALF37BXMZpZVQ6iys3Dz5ePeomDTJ+tRtI0x4yyBRLzWCG7nENmBtiLB+i75co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bigbinary.com; spf=pass smtp.mailfrom=bigbinary.com; dkim=pass (2048-bit key) header.d=bigbinary.com header.i=@bigbinary.com header.b=o1POORqF; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bigbinary.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bigbinary.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bigbinary.com header.i=@bigbinary.com header.b="o1POORqF"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7ab63a388bso333467166b.1
        for <git@vger.kernel.org>; Mon, 29 Jul 2024 22:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bigbinary.com; s=google; t=1722318269; x=1722923069; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dpp6n4Le96PcFdqrSN3HsUS7F8yAUobLSxh0ivCOqVA=;
        b=o1POORqF4GEEjIvFCu6ppXzW1U5AWZW8C5WC7ot9Z0dktvKrUGl9qGXzh58HW03REk
         K7h41clqHfsv5KIix5gco+cgjSblOPt86TcINocH3m/9T9Hk4TItRsivc70Shxb6IfVw
         eDS/rLwSsxBgzln+2WbkMLevVN2YLTgBS/lPtysetfETwTMRC14HS4kHPbCUnQJJzulV
         Ssr1bZxM+ivuYiNyPSaRjugIXE/sA8YnkJUvX00vV7uJAnlNQTQTc3ZjZh1elhgf+1gd
         zRd8bilbCwlyy4b5WwVwiNjCdWyXW4RnZmzBgQX5aCkIyo1Civi08bLC6ZIrMYt2Cx/W
         /qUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722318269; x=1722923069;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dpp6n4Le96PcFdqrSN3HsUS7F8yAUobLSxh0ivCOqVA=;
        b=WTbCvz+O8qCYptao/7HbeptBpvzZ15JfMbs+aQycFGq8xplRHS1wbvIBT0x4CSxpfA
         rK0YYwr4WiV+VC492tUc8qO14Urnn/x2Pf1ML6YvGCR1uliEU3CrhAv6pkGd8sn+W6jB
         naq2LwJL/08aD9vAruQKEkxlLlQUCr+1SdxL8s5AtX8tg4e/Tz5OXqaCtEJCv6AyOYma
         w/N0ctsLq/dqUU88BRXEWOs4hlNoMH9lwVQY8va5RhKwtJryDiWY2WAerpstE2WYt9Ww
         uXs+OsFa9lRJhpnxPn/kvegcQ0tRkKJE9vKplRGEYsTH3S8gKNXQiP4toCU4uCyx2Wj4
         HP+Q==
X-Gm-Message-State: AOJu0YzAZHTS4nCbBvZ6rjdiuJfAIFIwaairvLMaW7ZaZzM7pevWQv3O
	V8sS1OUrmc4s/vXrgHdp+LG19/jOZdoxtZB+APFTWiPoF/crjBUZHJTsnN0SuWYfnPIHZyc9Mqk
	a0gRjJSGy3zht3+zZOeAt9R7vD3eQh6s/39kxdLyN9xzRbMG9fwWfSQ==
X-Google-Smtp-Source: AGHT+IHrRmvQmJH7clfY3ON1Dnhh7+iTFuvJkmJkOK9tH2GTaJ6xi0KElfALAoBsUcnxvc2cB5SRXsH8Tv48FRb9wZY=
X-Received: by 2002:a50:c054:0:b0:5a4:5df5:12ed with SMTP id
 4fb4d7f45d1cf-5b02317cfb9mr7721638a12.29.1722318269199; Mon, 29 Jul 2024
 22:44:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sayooj Surendran <sayooj.surendran@bigbinary.com>
Date: Tue, 30 Jul 2024 11:14:18 +0530
Message-ID: <CAFGW38fkr+OuhpcyqNFxZNkhNDGPxTbOmCJLVHpCGUmbj05tMg@mail.gmail.com>
Subject: Output of git checkout goes to stderr
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
Noticed that the output of git checkout command is going to stderr
channel. Is this an intended behaviour?
git version: 2.45.2
terminal output:

=E2=9D=AF git checkout -b test > stdout.txt 2> stderr.txt
=E2=9D=AF cat stdout.txt
=E2=9D=AF cat stderr.txt
Switched to a new branch 'test'
