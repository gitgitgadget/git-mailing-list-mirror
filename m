Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC5A1F7092
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 14:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729521534; cv=none; b=MifwYwr2N1YSEICm/9shU2QzBdSMt9mlL/aMyfNHShrKfTyXqcSA7cjYOZ3BR74hK2horBxikKiBTsqqEER8vsDVnJ5Wy/hGGiroTqxVZ9NTP41XZvV+5t+Rd4mNgHwmJ9NKthgS95tN5v0n9laYJpghjPX8Ew0i2GmKr9lVx/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729521534; c=relaxed/simple;
	bh=MvsPFKay9cdEeq/kMEm59st47G8O3aR8Vzjzhrm3O9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Epd+blx2JIV2SD6ChAKpgOaOGJoQO+GxiuqfDyFhilXLV73tf0MCGvIsB9tiiBn4V1prAjD5Yp/cEsm49We+3XoKIkBRh8G8sE76LtMQxHUjIDWBl1DiavtT7Sz4oIuDPnBaWIVE2xVoxXb2Dv6q9INsO47S0s+m6fS/0Hwuwyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g/Desen+; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/Desen+"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-50d4213c5f6so1388625e0c.3
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 07:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729521531; x=1730126331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MvsPFKay9cdEeq/kMEm59st47G8O3aR8Vzjzhrm3O9I=;
        b=g/Desen+fCpOBLB/lX4y6r0pNiAg9ne3jBt1UA5SPBBegxoCIPtLDz5CsqoXEXq6Ui
         NdUOG1GjeBjG1yZyw+y4t+hmUX6FNzc+KK2Q6yJcDSi7ODHs1gF6oMxHxtZ7R46jZkiH
         F7t0EshSyXRrbAsgOkBJFfrTUhEVZtisjsqR+o3b1soFucpPOjXlWwYvbuTqOjuM+pWh
         bvFbALF0Kfn5xN2NcZGOtaCQA97l+Xd9xbPGfOFMGJ3oLyU7SGVcTUnPqmkh06/WB0bK
         R8Dd4aWHBwGOp7OUca6xHVGt+QyUL/YUheFzUhD9fJywX3JTZvWbRdF1JsB7nykG5MIG
         BRng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729521531; x=1730126331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MvsPFKay9cdEeq/kMEm59st47G8O3aR8Vzjzhrm3O9I=;
        b=WllXTtDe+5/Z7XLIoIs6wkcd00le/582rGvd3P+i+i/rVAMc7rQe3jx+p4XzTd7DY7
         w9//BZfuZQwHn0HRzO37Xx8dUZH1qVX3yz2KZ73TV+PEeMrhFlDOhwqqw3y6n8LQUYm9
         2CKXiBsDztXc9L0usAou0tf5D8TSrcC0LxWKNR+T3/gs89YusC4e6sHcsNbUNKigdliM
         1zjxkVE93WLZRdwzw8O6qhF1jkP+xl8Ro2j/rscOc8GoceqilFQVsynPvf5fGZiWsBuc
         AQDI8g5+nAPR5e0Yii0S3s5bfUU1y8UYjVkyL8NvoMkIMF6t4gwQsWpvkjNRZ+5s2nKP
         qlWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvbqzIQKrX3UwlTSdq/0Io+ofjEBbQTZMhOxmQr6GxdEw+sT0AshAWljzcXo1xaqWFTMU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe2M5FiyoBpw0UkxWpzVDln90xywq7S31ADRr5W3MkW5qqsykB
	4bptH1drXy+oPN6xIU4Hd25couWOZNwqluA4NVxSo6XevL03Xn/9Y+h7eVbxGUUxkdtJlcuzB0E
	X5sXKm7a7BZHsShYfAbBUt/6QZew=
X-Google-Smtp-Source: AGHT+IF66DIxOD1NyOsPJHSQiS9cA2P9Lxy2ns7TIEXAgLactlPd43NUub/LipRGoK9Ej19eSSTFt01t+jdh9cZxriI=
X-Received: by 2002:a05:6122:512:b0:50d:35d9:ad60 with SMTP id
 71dfb90a1353d-50dda1c47b6mr10036413e0c.5.1729521531582; Mon, 21 Oct 2024
 07:38:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1810.git.git.1728774574.gitgitgadget@gmail.com>
 <pull.1810.v2.git.git.1729259580.gitgitgadget@gmail.com> <c09c7b3df0d7eac3069cee45cddc49a76da2503e.1729259580.git.gitgitgadget@gmail.com>
 <ZxZHIk-gH0Onpt15@pks.im> <CAPSxiM-wLZfA1+1zvfjW-PN=Zpjrgy3KR9c_jrb=we7vhvoUYg@mail.gmail.com>
 <ZxZKQrc0Ch_YA1IV@pks.im>
In-Reply-To: <ZxZKQrc0Ch_YA1IV@pks.im>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Mon, 21 Oct 2024 14:38:40 +0000
Message-ID: <CAPSxiM9BuOCXSstZCm5B9dR6D0rg5vB23T0xNT3xAOJihQy0BA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] imap: replace atoi() with strtol_i() for
 UIDVALIDITY and UIDNEXT parsing
To: Patrick Steinhardt <ps@pks.im>
Cc: Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 2:01=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Mon, Oct 21, 2024 at 12:27:05PM +0000, Usman Akinyemi wrote:
> > On Mon, Oct 21, 2024 at 12:20=E2=80=AFPM Patrick Steinhardt <ps@pks.im>=
 wrote:
> > >
> > > On Fri, Oct 18, 2024 at 01:53:00PM +0000, Usman Akinyemi via GitGitGa=
dget wrote:
> > > > From: Usman Akinyemi <usmanakinyemi202@gmail.com>
> > > >
> > > > Replaced unsafe uses of atoi() with strtol_i() to improve error han=
dling
> > > > when parsing UIDVALIDITY, UIDNEXT, and APPENDUID in IMAP commands.
> > > > Invalid values, such as those with letters,
> > > > now trigger error messages and prevent malformed status responses.
> > >
> > > The line break after "letters," is a bit funny.
> > I just noticed that I will change it.
> > >
> > > It would also be nice to point out why this commit doesn't add any ne=
w
> > > tests. I guess the answer is that we don't have any tests for
> > > git-imap-send(1) at all, which is too bad, but a fair excuse and not =
a
> > > problem of your patch. So introducing such tests would be too much to
> > > ask.
> > I can try, but, why was it not introduced before, is there a reason ?
>
> I think it's mostly that we'd have to have an IMAP server available to
> test sending emails properly, so the test setup would be comparatively
> involved. Nobody felt like doing that, and thus we don't have any tests
> :)
Ohh, I see. I have not set up an IMAP server before though. I can take
it up but might require some level of guidance.

Usman Akinyemi.
>
> Patrick
