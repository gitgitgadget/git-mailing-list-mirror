Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE99288DB
	for <git@vger.kernel.org>; Thu, 28 Nov 2024 09:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732787518; cv=none; b=mzHmvUXrFeeCP2cSKyr/J3Ox6IPpFBZS6y2cZPji2uA2VoHTonUSwwVb/HzqJpEu7FIG8oyBF1aX3do+aZUc7luhWKRScZ1CnQRzvqntAaCXhV581NhkOV/BLDuyPhooLjtEvpVacHy4xRwpAV0UCVdOsMZaYzkw1VQKA/ivrrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732787518; c=relaxed/simple;
	bh=4SQXUKrD3fG2R+oMB5eYf/DbAniVxdLnbUBKfHB7gRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K6OmZbipTeMBGkJIc9HYiLVPeKpiJO7VgEb2aEvA9k3YRiIHgA9DlT0EuTYhlsz7ZHhEYcWGrRmLV9zDgmEuydOnRGtWflU7xVC0rUnW/1PoXOGSeolf+LTbmEqBDhfK2AmQvFRJk5YDhzb2p0VEdEWwENYLacx8pHBBLKIMR+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6d41ae05df2so1342106d6.3
        for <git@vger.kernel.org>; Thu, 28 Nov 2024 01:51:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732787515; x=1733392315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rcI3H8MW3sV/RQs4QWpTrKTOiKQWOLUYvkwdDHCdS+k=;
        b=d/1O4f6zaOAzhQSOKjts/UjBsa1dSJpx9yiazx2/4rZ7b55S8uSPPbfdQO9KO+PGf4
         hsn0pJTeR+5GUjbEVxcHtO4Tu038mHsckijgPoDlMLfzjjn73q4cwcFPlJUdsAYDwaNZ
         CdOhCjC0u+ddqYpVU/NBy3DJjuRaWMZ404GMSFk4w/FRyFiQkAPBqNRhP70j5WdmCw+6
         nJRKuKazjK1PBq3wLGXuEu5gJt0LRYoFQlqsyk74aty6YzVUAzT+jdXXuHQURNOXB9ca
         TW0qPTH/1S/g+l+tusc5OBsNB7Hjgysm46ilzx64GNQKoKXDqCanH3HrPMkTl77SjC/1
         6Fdw==
X-Gm-Message-State: AOJu0Yx2JUEQVLIpohsqsDTwLzqo7OaHtwm7TgHCc0m7Goz5yTGygaaS
	g8CILbFbZaGNYQJ/KrOXPDtmWQ/bmKrHl9dYg5mdU3EQ/AR5/ZAC6gO8VrJev2og9ou3m1bhtmt
	y3bkij/+3FYaq1hUfx4gOtfHJV/c=
X-Gm-Gg: ASbGncvt/pF443dApp9taG2MoAaIYwWT1NWh1iADxNQ8ksc4QDT2a31+Mj6K3QQVhp3
	dYRTTseFt4dhzqAYAmqIcBqpqrwCIzw==
X-Google-Smtp-Source: AGHT+IFiZOqH0H8DfAKU2O4ptOv+z4d1RXedW609o5a4cXImbzJ3mvwRNZyXE+edjDkGXizhxoW6v368kTKJuKeWyGg=
X-Received: by 2002:a05:6214:2a47:b0:6cb:e981:d7d0 with SMTP id
 6a1803df08f44-6d864d92b52mr33169176d6.7.1732787515634; Thu, 28 Nov 2024
 01:51:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1831.git.1732557520428.gitgitgadget@gmail.com>
 <pull.1831.v2.git.1732561248717.gitgitgadget@gmail.com> <79f6027b-123c-40a6-975b-1c6053b9391c@app.fastmail.com>
 <xmqq1pywvmhq.fsf_-_@gitster.g> <xmqqa5dkqjmr.fsf_-_@gitster.g>
 <CAPig+cSXGreymhni_J8TZ56rp+VZB_Z7ekaRtwFdxE3a2QWS5w@mail.gmail.com> <xmqq34jbogg3.fsf@gitster.g>
In-Reply-To: <xmqq34jbogg3.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 28 Nov 2024 04:51:44 -0500
Message-ID: <CAPig+cS3KdUKms7UkJQkkMD5WQnD6Khauq4RwttetzrJ34VCdg@mail.gmail.com>
Subject: Re: [PATCH v2] CodingGuidelines: a handful of error message guidelines
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2024 at 4:28=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> >> +   Porcelain command should be marked for `_("translation")`.
> >
> > Here you capitalize "Porcelain" but below, "plumbing" is all lowercase.
>
> ;-) I think that is how we spell them in our documentation when we
> contrast them against each other.

I must not have been paying close enough attention.

> >> + - BUG("message") are for communicating the specific error to
> >> +   developers, and not to be translated.
> >
> > Okay, although could be slightly more explicit:
> >
> >     - BUG("message") is for communicating a specific failure to
> >       developers, not end-users, thus should not be translated.
>
> The way I read your rewrite is that the "communitation" mentioned is
> between the program and the user who saw the message.  I wanted to
> say that the message is seen first by an end-user, and then is
> communicated to developers.  And not translating is one way to make
> sure the message is not mangled, and stays grep-able, during the
> game of telephone.
>
> Would this work better?
>
>   - In order to help the user who saw BUG("message") to accurately
>     communicate it to developers, do not mark them for translation.

Let's not spend too much time fine-tuning this. I found your original
clearer than this rewrite. It was just the "and not to be" bit that
made my reading hiccup. Taking your original but substituting in
"thus" may help:

    - BUG("message") are for communicating the specific error to
      developers, thus should not be translated.
