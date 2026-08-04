Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD23448BB4
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 20:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785876142; cv=pass; b=YRFnmxmthOd/LFs5hQfOv8iQnT4IcWEhzQaLOml6YdhCEGKMaQYAcjc4uyPaTq7P7tysxcVauKMR2m5lUlNLNgtnzT5KToXln8uI57q9lo8ixs17+wdL02iQF4UuMvcZSWKiCjVipaBQzKRoExaVu2xO7fUune/c/S9n0ab/ras=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785876142; c=relaxed/simple;
	bh=Jxe+jjYAC5gIAu444E9AteqX1vZKfibCv0OT3UIXqGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j/9MMIspMeUZN9qO17qWRmPDJWSQDbWjR2zrRzsPdyS7oN2slCy2JoNfPIq7eRy0EXgMLi/Vf61bgbwzPIxYZ+9nrtvMD6wvWhTyh5s0lZSHK0+fGts0iar1An8LfUxX+eex0H4No68gYoVxS8g+fg9qho4/IQcOW/rsjKdUdbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WAlKukMJ; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAlKukMJ"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-69c5fda04a8so377926a12.1
        for <git@vger.kernel.org>; Tue, 04 Aug 2026 13:42:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785876140; cv=none;
        d=google.com; s=arc-20260327;
        b=Y4k1g2bl3PATmotDN8ADGxu82kt9mFi4sQRiwZjYcJ6719m/P5k9tpodGDIWREtY2M
         rYNA9N89LUV4lSE8GbWNLcoo5F320k4vxlFsXzr0nUcr0ZfjTJH2lJA/PZx7nbD+MsqY
         2b/PgwgQ9m/fPdrNJb/LBoAjd9x7/n1jHjGfNqur3sIUjP6lIH3RTKz6aT074vBJuR69
         oQTxoEfnyrH0A/L1uMKsK2nZ7ZLJZXrDubr+MesBcpJ2HKeudEiG4pnw+xoRDTa0pCGo
         L5dVB0hIiGwn1H7i9Z6iPD2lv6v7e0AyRbxlsVRUNCRpYeweJBUQ8O66pbz9Kc9zMpSB
         frpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Jxe+jjYAC5gIAu444E9AteqX1vZKfibCv0OT3UIXqGw=;
        fh=STFwXFf2v+Z9KXm8pd2v3d1W7iY+OI73/ovM5X/VfiY=;
        b=kSkFHF6EUGrGKOD+F6Lwlw111tdjgEbo3CGjHaH8g9pe8L4dx0VHhPljdMlnPchFfp
         x3FvSvVYAHIejBQmdXW4Wzza7dwBMnoseUMxmoV1cD74dyiFl5XIOOwDyuXgGEwfeuz7
         dV/MyWuAzwLD/ywW3UfVcdCMqNrshwE/bHnC0lNymiy6IjCQwTATsbSX1uMyrotxsYRO
         9ukgtDMmy7U2IKmz0K//hvg+X/IoY9aGHioCGEP2OcI3KAZogAL6NgGuq4fq5Zs0LBw3
         b3dx6yhGIM/TQzMQNgEo8UM1+CBVchgM/uclJEVO034jPgowF0HsZA4Xd6DQUHP4uPZY
         GuMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785876140; x=1786480940; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Jxe+jjYAC5gIAu444E9AteqX1vZKfibCv0OT3UIXqGw=;
        b=WAlKukMJ2LIAnHZ69UdzdAtdZnx3VKyObYfNuI0Ar/04WDmCaMf360CpjAhkZGhyel
         fkZejpTC1M3FteptzLZNYhwg7meYUaSTHjHnInf8BsylknxIbK8YCeuOdB5A07eClpm3
         ER1AvL7sfnRO1NROMA2HLSdyKmLXvaJpPv2rCCQEO+8YO4HhKr8piZ1Dyfr4db9MGkUJ
         cDSrkvgc8/xzILFURkLRIu3d8hrzJHAVmr+66geSxPOYq+hJd3Je3mTLmW5U79eoiSZ0
         Lmf5ND7vjPKitxv7iaDm2Nm8ZffuUcbeAGllJyAlQiaVoqvcuzw5fN73p8XmHrEGmFEq
         cPvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785876140; x=1786480940;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jxe+jjYAC5gIAu444E9AteqX1vZKfibCv0OT3UIXqGw=;
        b=QPImKn+zC9+5lkdPYeygzHqhtqg0r6ByssvtD1P0oEc6huAAJqLrdiFKJN/W/RUjSn
         Tqai7AtLZicso6g8HGb8ofcZvQmHs2aMFv58p1Dh+A5SeaTJYrl/WlKWdm7wAvJDydg+
         qHWlBE5TrhG1iidn9zkreVFTM41oQrLhxcCrWwJ49cOH6Ymo8+a53uX6ppwPiNTMJAnt
         +MholAwOluRvet7XUPYSrtC2Q7vf1n7RcZiWVzCAflTJ90poRLD7L/DySIcQSknWIn8E
         4/74iVKwGJS5a6q5EWJ6gIlBndH5gEYZ2KNdeeyVwye1dU+uW4OhRVSaeSeEhkWgNDI/
         O7YQ==
X-Forwarded-Encrypted: i=1; AHgh+Rox7/2kUvQ3eN8V+33s992tVgqcYYw+7UJSDDand9TG+pVam0N3VvnpEGFwZbdpu914rg4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+5+tsl6DrTvkVBioQXejwFfil0ddn6JZaP4sTYK9Td8TA7+qf
	g90cWZ9V84Yu7PB+LXxwbUN/eFiCQm3DSRuYVvBze+mtsUl/goRzaviysPbjN+tST828n6pP+Ze
	z6lCWWjwZd2AO/q+f5yzkvKfCiYFL038=
X-Gm-Gg: AR+sD11yeorwcSjQmr1XkJMXjugY2MsV8BWZFRO0wwJs9pbT2O4VmYbvZuzfdDPygv/
	f/rzYMydqUMFrDlSoWDY/5TZ5vYQ4oa5BikjpGQul94Gm9KBHL+svrsFfT5eLHZntQly0o4TPIR
	p5qoNn9dPC4m4av15ZUi68Qbn8Nqn/wBd6DjA4R3eT8aKE2QMSDuHnFLae6DqBNp1xuU85Coh9G
	3yiBChjr+sVyOAjR4xrayMbyiFYMMyvgmeISwuXcA4i1BZTtkOYyNqtaLw9xK2m24GB9TO0biRY
	htoUli0BXjmMfIadWaY7ieclusiJbMY5HYciaqE1a+or
X-Received: by 2002:a05:6402:4509:b0:698:c13e:179a with SMTP id
 4fb4d7f45d1cf-6a14f12439bmr1032852a12.10.1785876139777; Tue, 04 Aug 2026
 13:42:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6b5b2c93f2e3e55bf456b86a8be61f5f85137a2c.1784536024.git.gitgitgadget@gmail.com>
 <cover.1785750108.git.phillip.wood@dunelm.org.uk> <CAHwyqnX8Api2VWqaDt4vgnG5P9RHGkK2Bhhi4dVAu7Qrh908rw@mail.gmail.com>
 <xmqqqzkevx62.fsf@gitster.g>
In-Reply-To: <xmqqqzkevx62.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Tue, 4 Aug 2026 22:41:42 +0200
X-Gm-Features: AUfX_myZYJ-B3yxbAmP2iJ5lmwcqPAp3hAAjxGjrwjaqt5xzu_q8FJIgMu8EwxE
Message-ID: <CAHwyqnXJLQ_naFb1RRQWS3eft0FXL7ripviSA15Zy5D6nvHGAQ@mail.gmail.com>
Subject: Re: [PATCH v10 3/5] history: add squash subcommand to fold a range
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood@dunlem.org.uk>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood@dunelm.org.uk>, Matt Hunter <m@lfurio.us>, Patrick Steinhardt <ps@pks.im>, 
	"D . Ben Knoble" <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Phillip and Junio!

I admit I=E2=80=99m trying to expedite the process. Especially given what
feels like endless review cycles, and some frustration that this topic
was queued for =E2=80=99master=E2=80=99 and now it feels like we=E2=80=99re=
 miles away again.
I recognize that this mindset is not a good collaborative attitude, so
I=E2=80=99ll try to step back and re-adjust my mindset.

I am used to a work process where moving fast is paramount, and good
enough is good enough in terms of code quality. I=E2=80=99m not seeing a
healthy code review process here =E2=80=94 any feedback halts the process
completely. Should it really take months to merge a topic?

I realize I'm too impatient for asynchronous communication, I get very
stressed about the idea of getting out-of-sync. When Phillip
graciously wrote a lot of code for me, I wanted to bring us up to
speed as soon as possible so his changes were not wasted if someone
else also started reviewing v11 in parallel. (In this particular case
I went back to v10, applied the fixups and then fit my v11 work on top
of that.)

I have v13 already in the pipeline, but I won=E2=80=99t send it now.


Harald
