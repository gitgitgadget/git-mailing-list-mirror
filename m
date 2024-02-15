Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E6A135A40
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 18:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708021049; cv=none; b=qcxiegnYCvko8e5mHEM5XpmsbDthN+hAwHCGFPNu/F+SbdHI3r6VI9yL1Zmtmn40hW2r1WjrpTOAEvDz3PFDzJKJzxRBxTrmpJw+MCnpYUnO2Nhh/qZ1nHuqnfVZPz3PZxJbQVR7NPFJMVonL6GxcCfQ57/8oebPNWt/TYCcOGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708021049; c=relaxed/simple;
	bh=cP6Y65Zjktn4KlzRrL/HnB/PvMae/isBMLhmauOqaVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZX1LZyDB+r3ry35dXmsxzN9kq2mRyuT7l8mvPwvk+/mydq771ms2VdjyGRlHsxeCEQml3xYfL/Pfcw/SQaHuZN8shVRt1g51oXY9LFYFjKqV4dR16ImWYcAQ4txseBC843l909Eq9h6MJGcloI+Ts1sweIWKT5ude9ubyBL5XyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dw6by0oU; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dw6by0oU"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so165411166b.2
        for <git@vger.kernel.org>; Thu, 15 Feb 2024 10:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708021045; x=1708625845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cP6Y65Zjktn4KlzRrL/HnB/PvMae/isBMLhmauOqaVQ=;
        b=dw6by0oUa56pcuF7ynPc16NseHWdkrpurKBg1JVgEMg5tRluN6GWNrFNvVYwn2TsU2
         5zeivQo4EfO27twuNxW4sPfKrut/RIQdgpmGxBqJLmGKPKP+0HrzzELoj9XKXRkrVgMO
         M55fOP95rkyR0YZmuntBahyd/Gi0PXtz4CB40aGVbRKPdtdcOI5LYuNcvPSj6VpuVfE7
         KZrXS3jyoFXI10CFPb57/3Gs42dHZYoQFCX1kDLZDRytnD8TRA/YgOBnHgXSH9GMe2dH
         W8RvRrKKCx00razy8MNShs4jJ5x/I0MDh9c6U3mn1Wt8eZmbmlAPGDnHt91qXYIJT9oa
         hqzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708021045; x=1708625845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cP6Y65Zjktn4KlzRrL/HnB/PvMae/isBMLhmauOqaVQ=;
        b=J5tb3lgFY/BFU1KwqY6XydQ+HVaWolpok644jzbdAX1WrfwWnetf6n42cY9u1UZRyQ
         CBbfdy2ixxP1STA7tKI632q2h9knLQrak3pf+pQbALToWBiWkZBxHHA66S/x9nrCCANY
         EGYldoMUV89s+EEaequUquhFJnEAoYfbpc0SYwNC/8OQK0cSugZiJDUdwERzQ6nNhrjO
         e9nGVj61psICeH61W1JbCA8LEBe2CyxiIOcSw6aQWWvrWxZ9dJAR2JjURQHkKA2Qz518
         Pty11Hd1cUCuIbcXJXKNC1hGv65/iPr4lLLN/Dz4/Cx5GBXPoFLI+J3l2/vhdh7S7kp2
         eFzQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3vU0jkmw809FM8aS+lR6dk7mVpO+FsR1ihIEWv9mGFgrUzSg7d+Jk8eNAH11U9AnZUnteFRuJx9yRJgvdYVaWGMC+
X-Gm-Message-State: AOJu0Yw0FvRKkE3xkx2yR5wrXHdSeQm7FjLcfkMfo+cDw6l6tZ+Uzglf
	NZZ2eeYssDd/jKXg2zQIA0RJBJu5G8M1o5gCIPNzu1qfwVaeEm0xVDYppuBXurVq1KrM1UWqwqW
	UJK7wt3hBn4A87myJaoRzeWW+eQo=
X-Google-Smtp-Source: AGHT+IGqFuhG8uatRhXwHe33QC86o4ao16s8IfMvTqH3t8dPES6CZ5UMXd0l3hkSUsKXgiOEJ/pIFPLTraX9XV8XFt8=
X-Received: by 2002:a17:906:3518:b0:a3d:bd8a:7665 with SMTP id
 r24-20020a170906351800b00a3dbd8a7665mr384344eja.43.1708021045369; Thu, 15 Feb
 2024 10:17:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215094243.147057-1-gitter.spiros@gmail.com> <xmqqcysxskd9.fsf@gitster.g>
In-Reply-To: <xmqqcysxskd9.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 15 Feb 2024 19:17:13 +0100
Message-ID: <CAP8UFD2hHYeUxtXm1tNDe3tpBAif7amLbkTQpurp3w1n7uO+HQ@mail.gmail.com>
Subject: Re: [PATCH] use C99 declaration of variable in for() loop
To: Junio C Hamano <gitster@pobox.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 6:33=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Elia Pinto <gitter.spiros@gmail.com> writes:
>
> > With the exception of cbtree.c, which would need initial
> > reworking to remove the usage of goto, it expands the
> > use of variable scope reduction in for loops as
> > permitted by the C99 standard, which was first introduced
> > in the git codebase with commit 44ba10d6.
>
> Thanks, but ...
>
> Our test balloon may have proven that nobody will be inconvenienced,
> and it does mean we can be liberal using it when we add new code or
> update existing loops "while at it", but I personally do not think
> such a code churn is very welcome.

Perhaps such changes could be accepted when they are made in only one
file as part of a microproject though?
