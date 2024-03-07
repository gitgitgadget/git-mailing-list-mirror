Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D7213B783
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 21:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709846811; cv=none; b=dBctw5l1gm+T4059/czXsb1zL/3MtFO0rFcRby5Bn7v3b9S+4Ug0baMs125rzQJZGEAGoCjN3dkr1ambKg106gAlLhLJQIaDiHqQVOYot/nXXLJ7fLxKAMNsCs0EuQP+t+m56TRfc6ta0lDtqLz48KdWuKVZ85wn3uX2THOgdZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709846811; c=relaxed/simple;
	bh=0OKNQnKlUefBJ3Q91ZbeA4CCuPZih1/bKLR+4ZEBooE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f5Ebx7eOrVoTErgIDY0NHRLjWnRhuNDkeeQE0wHICWIUnBtg+ZG4B7W1jG3iusjKDjZ72WDiFYRbFQKu9DDGO8x+o9NXdOFjCW8qto3CnSCY1OsRu53H6CU8UPTtMEi5TLSt6b4kaYcok1899eb+zK2K5iW6DceV4SulGpznCqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-783045e88a6so18753485a.0
        for <git@vger.kernel.org>; Thu, 07 Mar 2024 13:26:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709846808; x=1710451608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7TST/8PV/+cYODjDUhOYG8F4xmLdwypAs119kCP2EsM=;
        b=iz7wwahkvp2ATQ1QRSdEGgLx2P0wuQD/ftVz9F3uVKG7kDQ5V2d6YwDzqAOux1xBXh
         75ELH35nww2vzKBO2Y6A+yup9PPJYtyHR4fzQI+JyTG8898qZCIcYkD8rz62Avp13599
         F6o6qqIZ/awVAcnCeE+YZjYB66HzELWGr56YwH91nreEfsD7yg3UsVhEEnoMHuSHw+bj
         0+OFaZZx2+3rUWhhEIGIF1Wrg8le2EMNSCyiQydjFmw7YEmzyBtANKr62AV4sALVS51z
         FiN1l3EUNiMFD0HSwPdqgBRQMaMc4Fj6tIUV2/zwJFBT/ZhPzkbpCOk1MqGUE5LkMHQa
         YULw==
X-Forwarded-Encrypted: i=1; AJvYcCUh/KQv0Oqfi/CyaxB4G+mak1z7FQhFqmmp61f7xrA5BbAlcqD0wp/e2ne+RCbbcRmhY1xVCmnco+3An2L0WBmuRjzd
X-Gm-Message-State: AOJu0YwEFqcpk9L1STpOEX6Yfc0R9/qgyof8Qx9R2welkpwAQjMqpxVH
	Bw5RtQTuFsgGRHSjTuOVuU0CIoje34QE1ybrJNsvAlkGX8c0zHPHaJUwDzMxvp3jdAaZe2CjXxv
	CpX57LkAnIk53j97G4WaML97WR4Q=
X-Google-Smtp-Source: AGHT+IHk5jVs+C4UsK1cEBRoImUORRcjhsR0dg7E7iOtUED+M+fyeZ5MNB9zErX1aejLxpn25iY0ujyLfwHbSFtw0FQ=
X-Received: by 2002:a0c:cdc2:0:b0:690:b03f:f193 with SMTP id
 a2-20020a0ccdc2000000b00690b03ff193mr1038750qvn.8.1709846807865; Thu, 07 Mar
 2024 13:26:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307183743.219951-1-flosch@nutanix.com> <xmqq34t1n91w.fsf@gitster.g>
 <xmqq7cidlqg5.fsf@gitster.g> <f8de2b3a-9e12-49fe-a7d9-481317f10c4d@app.fastmail.com>
 <xmqqo7bpka6e.fsf@gitster.g>
In-Reply-To: <xmqqo7bpka6e.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 7 Mar 2024 16:26:36 -0500
Message-ID: <CAPig+cRNa22A=fEmc__JvEjYiVF-QG8o7w0gukhbeL3e-PwVkA@mail.gmail.com>
Subject: Re: [PATCH] wt-status: Don't find scissors line beyond buf len
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>, git@vger.kernel.org, 
	Jonathan Davies <jonathan.davies@nutanix.com>, Phillip Wood <phillip.wood@dunelm.org.uk>, 
	Denton Liu <liu.denton@gmail.com>, Linus Arver <linusa@google.com>, 
	Florian Schmidt <flosch@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 4:24=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
> "Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:
> > On Thu, Mar 7, 2024, at 21:47, Junio C Hamano wrote:
> >> [jc: tweaked the commit log message and the implementation a bit]
> >
> > Just a question. Given the imperative mood principle/rule, why are thes=
e
> > bracket changelog lines always written in the past tense?
>
> These are not giving orders to the code to become like so.  The
> trailer block records what happend to the patch in chronological
> order---think of those written there at one level higher level,
> "meta" comments.

Also, they are not always written in past tense[*].

[*]: https://lore.kernel.org/git/20240112171910.11131-1-ericsunshine@charte=
r.net/
