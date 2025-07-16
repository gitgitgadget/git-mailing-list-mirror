Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644D22EF9C1
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 09:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752656827; cv=none; b=WZr+P+HK5BuTCTwBDsZh7Juif6CbMWYadDcCkuG/0ljMmodfytqcKUROIzDKxcN0R8ueLUezWNp3jjDFLZMAqw73TYfmHfy4QvMthtmjRu5s2fi7AXpsQ3OopD/AFvCBZWtGvEia/3sLNz24+i13CRu7KdcBoNTuy/Y3r/qsNQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752656827; c=relaxed/simple;
	bh=EKLqRzYyn9L7ipmwdn98PWFulNFCb8Sk+1xJ/XKT4Ws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vom2FfXt50+9h6oqmcmGtuNj1yu/9d9an8/SMb9YPXpamZZYx7JP7MFHlMuXM93Qva9iN7jdvfLQzCGZl3EPINni76ZyvZj0Fxef7HQt8gvJzhYfVUa+6y+H/X93O10vyF3uYSmVKlOUw9V3G+B7hNpFg+jjMhVteK8ufvKdycs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GO44zrPr; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GO44zrPr"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-70a57a8ffc3so61339107b3.0
        for <git@vger.kernel.org>; Wed, 16 Jul 2025 02:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752656825; x=1753261625; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+9EAFpDh9Ns5H6e0NSBtIyToHKkULKxV9vXe4J1LtUA=;
        b=GO44zrPr02aEcQmhygQb4K3YGz5lzXTn7Cri0qnyexvbqx/ifhaoa9X0O9fg4QRAqM
         zQCuq/+UVfemCNss4PoFUoz/bi1aT46IM2k/3MKRJXM56uG3G502XvmBgib8/hfU0LFR
         OABhHI6o2NmOLG5f6O0baS6KO0B+CABvkaoa0ps/EpOjDy6DuBeXaZlUolsGmpEKNHJm
         cYHD1OWsAN6cLjkEVorz0kJwchd2+YS0AyryF3d7fIKi1SLkB0/faKo9MaBYFoNKn9T/
         QPOz4K/OOf7Qd/8ntaa+7TWJ8hOklbnzky96wWHq5CcNTi6p8z9C2X2rXdnjx6g39uSw
         5JNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752656825; x=1753261625;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+9EAFpDh9Ns5H6e0NSBtIyToHKkULKxV9vXe4J1LtUA=;
        b=en/pJD6UjEIGaUHr++PcppYP4hf6u8H+/aREDNYN2jF4UfxxGvaZxwculX+Fa6z0KQ
         ZAbrsi44pca+PcLm5pelPKYiFeBOJIBKV0R3CRYrOzD/RmmWEEi3t7l7WIhiM2eeSQdP
         DVuRaWtiuSDekGoaAfwBl2AnwEgUVlQwb9mDP+HWHcD/bTGCrAzHvKsAh0Ji+GmWajCe
         APXDZ8zuGIJpt1FIEyXQynxXbt4PYqW4BePN98wqA2bj4/wYBuhYAYOs0z1Jo9WN+xyf
         Jn4nhnqXCVyDWRSuk23z4S2l0CjYBTkGgJKWR4tLPz+qfS5PdGKqddd4OtE7qXQeUdLH
         Umfg==
X-Gm-Message-State: AOJu0YxI/n+8ucI/v4gOpqFXe2mM8Igj6MtOh1flK8WvZp+Me8NTV68u
	NdpPCS1CX04Af3jXxTTsqveKlCT8Ac9LMTUV8whMbrI9vT6buj82I7owwelxHUn36KBvcQTL0EW
	07i50ibeCLdhAyqhUveFxI/mznz0DRKnnYNqA0oXrxw==
X-Gm-Gg: ASbGncuXZtFvIJc7nFDs8r6Hhnrz9eYSoiuZ0Rq7QL2o8T/hcZvLqcvfPZPqoUTGvrU
	RfaZjMWlG9Ay/iSZyVOouz1JLdj1LbjssKZD4gHXLU6OSF949smv7VXFYL03BU19pA/TK/F3tIq
	dV/tfH+tYVFQ5EewmQMNBSUX0C3Ve97Ztpj7d++SiT7OvswgQTXdJGUXF4cZjqfwb2YGXd7DTFk
	Dnt1JRZR7NLrBqfAyU=
X-Google-Smtp-Source: AGHT+IFaZddDQCWtwrRjArzaeVVslDoD01+GB72h2p237k3f2USs3tKPwCQjk7sgwWXYsJMT5JAWEj72NM/OMRBp9Ig=
X-Received: by 2002:a05:690c:f09:b0:70e:128c:3005 with SMTP id
 00721157ae682-71835157392mr31475627b3.21.1752656825147; Wed, 16 Jul 2025
 02:07:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aGwHt9HCd86hVuKh@pks.im>
In-Reply-To: <aGwHt9HCd86hVuKh@pks.im>
From: Seyi Kuforiji <kuforiji98@gmail.com>
Date: Wed, 16 Jul 2025 10:06:46 +0100
X-Gm-Features: Ac12FXxnnWjEEOpCkOONaSraW1fHX3I_vdGM2x2khIMW6UjtBLqwEGo2xyAsF2g
Message-ID: <CAGedMtdRenBejPanZ4JJem_35EUX6v9v3=p4v4obKQC=DDMw9Q@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git Mini Summit at Open Source Summit Europe,
 Amsterdam, August 28th
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Jul 2025 at 18:45, Patrick Steinhardt <ps@pks.im> wrote:
>
> Hi,
>
> I am happy to announce that there will be a Git Mini Summit co-located
> with the Open Source Summit Europe in Amsterdam [1]. The details are as
> follows:
>
>   Date: August 28th
>   Time: 9:00 - 13:00
>   Location: RAI Amsterdam, Europaplein 24, 1078 GZ Amsterdam
>
> This event is not intended to be a replacement for the upcoming Git
> Merge 2025 [2]. Rather, it is intended to be a smaller community event
> for those who cannot travel to the Git Merge due to whatever reason, or
> those who are interested in Git and already attend the Open Source
> Summit anyway.
>
> The event will be structured so that we have a section of lightning
> talks (probably two to three hours) followed by some time for people to
> connect with one another (probably one or two hours).
>
> The registration is not yet open, but as the date is approaching fast I
> wanted to give the community a heads up so that they can plan. It is
> expected that sign up for this event starts next week. Tickets can be
> either bought as an add-on to your already existing Open Source Summit
> Europe ticket or standalone and will cost 10$. I will send an update as
> response to this announcement once tickets are available.
>
> If you want to submit a talk, please send a short proposal to me. I will
> vet these proposals together with other involved parties. Deadline is
> July 28th. Furthermore, if you got any other input, please feel free to
> send me an email, too.
>
> Thanks!
>
> Patrick
>
> [1]: https://events.linuxfoundation.org/open-source-summit-europe/
> [2]: https://git-merge.com/
>

Hi Patrick,

I trust you are well.

I would like to confirm whether only those attending the event in
person are allowed to submit a talk proposal.

Best,
Seyi Kuforiji
