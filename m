Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0C1824BD
	for <git@vger.kernel.org>; Thu,  3 Oct 2024 22:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727994464; cv=none; b=nsiZRY6jv8spnpLEYv+SZE62AMv7ls9F0HfgJwtC/9noI5lCAcuYP9dQLJ5/qVq1U6MIwi9gI65DHE6MtdXk6560FnwVDx0msRUuSElxgmeqw+vGtbEoePlKgkVcuJePDGQ730n2jN+z8tjAhrv89IwdPZesGme5rVOc4q9gSXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727994464; c=relaxed/simple;
	bh=qOZ5CcjeMtugafZ7oxTaWWIetQBRf0ooLjwcrb8FkrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hMJqTKUDSM3OlBpMXLeyOVaz2RhMcwiCh39Uhppfs80XPci7JCJwqjGvITgLDOYkGlswxPWXqBnCZt6CfkqSZ1HbTT9dsPdNLj3DKjbuUTz9jGg8mSvlguOYtPMr4x5zrHA1QJFaLsQbB1rFRphVoREU5DBjallVjp5rq7B4csw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6cb3cd42eedso1640306d6.2
        for <git@vger.kernel.org>; Thu, 03 Oct 2024 15:27:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727994461; x=1728599261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qOZ5CcjeMtugafZ7oxTaWWIetQBRf0ooLjwcrb8FkrU=;
        b=E9hHZzC/RVpMP5TFx7xIYca6I+a2jyg9nTpQellJwD0uEhMHsnnwSDt9Wrt+Y9+MNi
         YvHSSJsxRDna4X3kkwiNXog/pkGbI25QhzgREqpboyw+ebK0+l8yIgchwV05LrnBWAD3
         OGf4mSrulewRwxSceRwDoNXtVmXVnTUu2EK8GB4M7N6+zYSAtJTzPG809VJrGZBy2d9L
         FcxPt6vTXbtp/qQWbnW4QTmnQc2kikaTo8D8GnVKxPT1zc+PXLOji8mNDuMH2Cg6gk8V
         /Bj9x41e+gKlq3YelaBCHp7DRgkF9UsVp5cQvHSmczv7T4K8d+Es2zdJ/lxKSBUvuJSm
         s6dQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbEMu6C7WmgwEL4ad+Rsi+MVNgjMc1PmRXf6+MsG0cgfkMNPaYe9fCe9CEyzvIJbEx8iA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu2u+snQ2AWEHIgbrfleMx6AFFuBGqN0O0LJy9YMycnYLm3Ptv
	LIJaw/nI7DMuklnhssjfJMavYhVxFl1HtEcYYuKYoG6/tVqDxzEGR4K0TVZKLv5MTwLQEwU+pAj
	BH7QD7LjkCbvAqvGBIdWxxZypfXM=
X-Google-Smtp-Source: AGHT+IHeNW/XMPqkGRrdAtwiUca8sOHW/BzRgeZz/KNTZA6f2T2wySAIO6wvvwQDIWeP7v3Z3LPi5BwDBIl9/m3Fc1M=
X-Received: by 2002:a05:6214:1c0e:b0:6c5:258f:26c1 with SMTP id
 6a1803df08f44-6cb9a4efee1mr6960826d6.7.1727994460997; Thu, 03 Oct 2024
 15:27:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930220352.2461975-1-sandals@crustytoothpaste.net>
 <20240930220352.2461975-2-sandals@crustytoothpaste.net> <2d2f14ea-cfdc-4b52-948f-b42c8f6e41de@gmail.com>
 <Zv3DehUxEN6SJI1M@tapette.crustytoothpaste.net> <CAPig+cRkA58wr_Pn-uhVM0zFA7B0hnArXDeumrjnWrgBbG64Yw@mail.gmail.com>
 <Zv3IHd0c4_0NPjOK@tapette.crustytoothpaste.net> <CAPig+cQjk5_VJ-LNc9Hx3Q4n6H5bgg5cAztWhFpuweG8wFTjMw@mail.gmail.com>
 <xmqqwmipi342.fsf@gitster.g>
In-Reply-To: <xmqqwmipi342.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 3 Oct 2024 18:27:29 -0400
Message-ID: <CAPig+cSta8arLqa+v1rVwMdd7w0q4RxNzrooCzKAma88cR25hA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] Add a type for errors
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, phillip.wood@dunelm.org.uk, 
	git@vger.kernel.org, Emily Shaffer <nasamuffin@google.com>, 
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 12:05=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > That's why I said in my original response that I didn't understand
> > your response to Phillip. You seem to be using a non-justification
> > ("other programmers suffer, so Git programmers can suffer too") as a
> > justification for a non-ergonomic design.
>
> The statement may be a bit too harsh [...]

Yes, sorry if that came across as harsh, brian. The "Git programmers
can suffer too" was my (clearly) poor tongue-in-cheek attempt to
soften the earlier part of the email in case it sounded harsh.
