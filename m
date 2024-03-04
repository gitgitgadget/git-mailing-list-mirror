Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08CB7D07C
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 23:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709596403; cv=none; b=eFrmdU5wBHpXFZpO+tFwPfdIWrcJUQfkVapEZi7Kr4AV3e9EMnOjRi7hN1IlvOZOWHkG6eqP6PdZeK2C4nTdQGMnylTzOBJ3eNl73P1nwcye54e70HAaaFMXc3IO9e/1WQgRYpF4yJl2AkXjM/5VzL558NCHCX+JTf422U6FjC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709596403; c=relaxed/simple;
	bh=s8UpZs3oPfOfOtBcqz8F3a6x2IjKYZz7KV12Xdz1La8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZNTPRx3lvS/kgFv+NEkzZvnWWL2GL658jvS4eQbmf/gFuKpim/Ome2ygG+m9TIl2Mv8Ng1vr3UKnL1a6KXlXkiBB7XWyZZJmFuTDB2BHuKR30qlQXAJWAGoi69oulO7I+37S3t02VglP7QNk903mlXTGcz7F5dS9o7CSv7RQXAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-59fb0b5b47eso2249519eaf.3
        for <git@vger.kernel.org>; Mon, 04 Mar 2024 15:53:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709596400; x=1710201200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s8UpZs3oPfOfOtBcqz8F3a6x2IjKYZz7KV12Xdz1La8=;
        b=pGYOzplMBFetKCF+x+Hz1EHovodrCmCcT8CniPLCfs2el7EFgM95A+WJaxiiIwOmbo
         lyjXirBurvuK9rXYt72f9Oe6sXf91lv69skgilnqyR54wtnoLiO+4jZk4ijMb8eydSAm
         1OEerAfjuqnYm4Eo2hCXfXCm2HGc3Gweulws3d2P+vbSK1QfVcYtGYYK+FR5NNsYaPYF
         BF8WEYdd0rhKEYdeeERTD5ReuFjrcCzg1pFGt4BszYDmOEGACMYnYBnSOnVVBYCTpVu8
         TXV86Oa2wtT2aGhKtXpf5HhuSAvFhiYdm+xcFOE25WP1zEYhbrLZ3MBbVG8++rnOBZx4
         /SBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVG15UPwun9ZRRXFiA6SDEh5fqauqOKAxzPYbD+PFZx37cDEyksOu30+ipZN8ud4I6HVhg+0fqlwuKs41U+7EvXDB9f
X-Gm-Message-State: AOJu0YxENLYnOUGu2IuSPpIkQnkdih4bOhriTGqQksgTZG+M6EL519EV
	aZZfeqlCS+OhuMvOM5Gt4Yftlvc1Bw5UY0wWKWu73PLw5470zDrw1303azkdJ6TIeIC6Ssl/Swu
	GV3j8EafP9IdiiTA73VCImhWZEes=
X-Google-Smtp-Source: AGHT+IFiXW4K4ugBxt90JAbzahUWQe6HEfKhNda92rL2BabJQ7nFS/H9W5mwOd762k42XpVRygfShUzIRrb73CMzmSE=
X-Received: by 2002:a05:6358:70b:b0:176:40d5:2bd5 with SMTP id
 e11-20020a056358070b00b0017640d52bd5mr200157rwj.6.1709596399989; Mon, 04 Mar
 2024 15:53:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227161734.52830-1-vincenzo.mezzela@gmail.com>
 <20240304171732.64457-1-vincenzo.mezzela@gmail.com> <20240304171732.64457-2-vincenzo.mezzela@gmail.com>
 <xmqqcys9oedq.fsf@gitster.g>
In-Reply-To: <xmqqcys9oedq.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 4 Mar 2024 18:53:08 -0500
Message-ID: <CAPig+cTMiFfwTf0H+X8wecDwcKnOR=TQX54NGNs1oXmKQ4TrUw@mail.gmail.com>
Subject: Re: [GSOC][PATCH v3 1/1] t7301: use test_path_is_(missing|file)
To: Junio C Hamano <gitster@pobox.com>
Cc: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 4:51=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
> Vincenzo Mezzela <vincenzo.mezzela@gmail.com> writes:
> > Refactor test -f to utilize the corresponding helper functions from
>
> As Eric pointed out to another GSoC applicant in a different thread,
> this is not refactoring any code, so saying "refactor" is a bit
> misleading.

This is probably a reference to [1], though I was definitely thinking
of [2] when I wrote [1], so we come full-circle.

[1]: https://lore.kernel.org/git/CAPig+cR2-6qONkosu7=3DqEQSJa_fvYuVQ0to47D5=
qx904zW08Eg@mail.gmail.com/
[2]: https://lore.kernel.org/git/xmqqmst2nszq.fsf@gitster.g/
