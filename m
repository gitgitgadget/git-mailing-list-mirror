Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0835B1386CC
	for <git@vger.kernel.org>; Mon, 20 May 2024 19:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716232805; cv=none; b=lVKlY4XBs8NSiNUewvIlS6s8Jrdhhq8aqEpvWOZ8MNqaBpLHFHwqcbEG56efd8+xAWU4AAhT0cq7qU3Dk99cDoSMR996R4qiigbhzo+s27mhjyyXO2VYrq5OeCowtoY6mZwOqXeAZRCA07r60lMKiWQpITexbeFFTuhw0yFNEok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716232805; c=relaxed/simple;
	bh=9J818fwrAZE0jP6qgWZVvvzmhV+lrF0ytwK13KoYkRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EIJBoHOYZwyInj2cXwn5HutRIgTjzP53XYdDjoD8NazN6J3un9j0A4oIXHPy+ajwjfHUhURsZJGz/0nzWEHNiA6fmIXcNYGvcsA+MPYc0ouvghAqFuANxJ9gapEzQMDAGqEh81bhvFw4IecPK6ja71oJvGvUhBxH1dcxA3Q6zCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-792bf1a4f75so294808885a.2
        for <git@vger.kernel.org>; Mon, 20 May 2024 12:20:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716232803; x=1716837603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9J818fwrAZE0jP6qgWZVvvzmhV+lrF0ytwK13KoYkRI=;
        b=qZtPBNnV+VRLiUV3GqZz4rFqxJoMIRJe3UVnvw6eogwd6rmIz+PHPlrnddWkN9Dtrz
         97xGRv1GkziUZwtI0r0+NWkXpYg2Xm03nYOohpfsGuOvPJg7eMVGw1Ad1n/qSghzRCux
         5+rxvPAug9jytinsM40xhzoW2oiJ12+FTSiiRc6Zx9UId3+/vsTfvkYuK/VvQ0VKG55o
         Iy6TtOwKmKdifQP/kETG3robbjc2Z/rCUBQXb/UqTWMrTwDISARvkfY52hI2CFOUBPn+
         993DtSRaqL7jQynq4Nte4HmFi+5/3ppqr1aCiSM8hq4r7KooKBDIALVFEoWYjfXKdVhZ
         qdJA==
X-Forwarded-Encrypted: i=1; AJvYcCUQevCZBlnD21T6C+Ao68v7U4CRaa4tbGLPSWrche111JHJ9001wqQOyx2KQGTwmon9mG/Nm9Hwyhc6Gmt5HVX46oUf
X-Gm-Message-State: AOJu0YwDZBs9ADSZp0Ef7byqTBRekzOY1TN/ElaoMxoRdMMdl0WqAbYz
	T+UznvTLB3S/wq3fPv7yV9EOzCwUnTNBHeWiVOuHss+PHtm4sZcFxAX3wuL8meJm05R7rbid9HA
	HSp1IWuGuXV8h0uQY8hiO4QfSoUU=
X-Google-Smtp-Source: AGHT+IEu1xZ1J8TP6X9fRcFbc2xWug8lNMeKP+5IPdOb9HiCAHqlkfouIbmpM1f1ExYzxULCZgcV9xHOta1zW0THW9I=
X-Received: by 2002:a05:6214:460c:b0:6aa:9d50:f509 with SMTP id
 6a1803df08f44-6aa9d50f663mr37347236d6.43.1716232802987; Mon, 20 May 2024
 12:20:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240520111109.99882-1-glaubitz@physik.fu-berlin.de>
 <20240520190131.94904-1-ericsunshine@charter.net> <277726443f533446be4391cf2aa3d487974a7a18.camel@physik.fu-berlin.de>
In-Reply-To: <277726443f533446be4391cf2aa3d487974a7a18.camel@physik.fu-berlin.de>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 20 May 2024 15:19:51 -0400
Message-ID: <CAPig+cQYJL+6J9PJX-vrNRXJ4TUCJCQRDQstUnPf4OOwOVCUnw@mail.gmail.com>
Subject: Re: [PATCH 0/3] improve chainlint.pl CPU count computation
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Eric Sunshine <ericsunshine@charter.net>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2024 at 3:17=E2=80=AFPM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On Mon, 2024-05-20 at 15:01 -0400, Eric Sunshine wrote:
> > From: Eric Sunshine <sunshine@sunshineco.com>
> > This series replaces a patch[1] sent by John Paul Adrian Glaubitz to fi=
x
> > chainlint.pl CPU count computation on Linux SPARC.
> >
> > Unlike its predecessor, this series also fixes an underlying problem in
> > which ncores() could return 0 which would result in chainlint.pl not
> > processing any of its input test scripts. Patch [3/3] also fixes CPU
> > count detection on Alpha[2].
>
> Works as expected on my Linux SPARC machine running Debian unstable.
>
> Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Thanks for testing. Were you able to check whether it fixes CPU count
detection on Alpha, as well?
