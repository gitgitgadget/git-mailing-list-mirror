Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B7221ADB9
	for <git@vger.kernel.org>; Sun, 27 Jul 2025 20:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753647133; cv=none; b=KRlre/2deuPx3J3I18MVcrufAjd6ZUkk8EI/exBpU39Q0LM7F5UcpjvPeaLqtO5dDvAl7o1qTa/V5Gu+VD2amU7UMUfM15R+4GknaJZnJA8VUpp50wBusCO6dz3zqrgXjCDQNKgVB8NijpzKcbT+W6gOLY88Q5jZoYQe6vS9b2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753647133; c=relaxed/simple;
	bh=xZggO8zvNKOKKfvuEAFyf/hfus3q/Tl1QE2vzYca/rU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f5zPQ4uWs6f8KJLzMZFSoXaylsMJu4CadSZm/Vd4r2z4wJQr3Ov5kMlN7G8fJBijB80/8pNvOwTH5qOo32XTNwa/dXclb89u9nhVHSQbNEpJ7GrYkl+V0yRNOZ9icpBjRAN7Vxr7gBj4/CZGPLtgqkeNNM5PY+pO2IXI1MBdAzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7e33010556eso5755685a.0
        for <git@vger.kernel.org>; Sun, 27 Jul 2025 13:12:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753647129; x=1754251929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xZggO8zvNKOKKfvuEAFyf/hfus3q/Tl1QE2vzYca/rU=;
        b=Fz00aW2G4Upuu+IRXgUT8k+MO0L6OZo/fhxbspv+qd2dcQss/R4ITJP5AcYKvTphdy
         hDIYAhizsvMDvGZSrvygjfhuOvtsWcscL5X5h0mKEyQrKmCU9Vry+VoGmn0+NeILnmYa
         iAWV0QMWJe0+0jmIdQ731HHVulB+NlD58N2SwE9qXJRsTywi71Xoudkfu1LXXySrUufu
         lzkLSRQ2qApW5pCSLgiBuUIX+doi3b+qJDcxoU18amPprFRn+NGeGNvqTbZWCr2p1qz3
         eO9hbY02IC1Rw3D6bL/qUOiT3wo/Ayx37Ng2xa2J91p0Ea46Lo4b8S3ghxj5mtJXEGq4
         PlDA==
X-Gm-Message-State: AOJu0YwngVQ0BW4unkNs0KeWQ46hFQp4LES6J4YwyaWBqXD8pK2sbNRL
	h1jbJmTSE0V6m92fxAVe42YzedNE6BDA/zTVrdzdB9kZ976/fMqf4g7hP/WekVlbDhjFY4XUMUW
	11vUi5DrFF7pXbAc9NUrFqFpPvD1VxN0=
X-Gm-Gg: ASbGncvankqTFlsOq2A33OmA+k8jg8EU6DEE41EYJv4JQxVZYUMd+NvP8ebaeAvKkuF
	2gwCCdqqXYMRg0n92J4zRVtEkiyMplcGILQ+Guon3enHNr02qwm0Opl3wjmuBKp655Z3Oea0SYc
	vz+EnlNKSmYpkJPYd6djXGMLBSbtE+h02218YoIJ2YzJTT2Os/t2GUdNZpZ+p4fLJIoD4sAMsld
	YaoFKR/qygH+q/t1OsYbp2Hq0nTX1Fg4C01J4QZ
X-Google-Smtp-Source: AGHT+IEsXwtTP3bYQTluc5dGVoysDXLWAk0xAR+UKNAOMyUpNb8I36GgJQqUBiL9E2yCjApn34gekaCo+9HJicPUDnw=
X-Received: by 2002:a05:620a:1910:b0:7e6:2404:552 with SMTP id
 af79cd13be357-7e63bf907f7mr467147385a.8.1753647128724; Sun, 27 Jul 2025
 13:12:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com> <20250727175110.84770-1-lucasseikioshiro@gmail.com>
In-Reply-To: <20250727175110.84770-1-lucasseikioshiro@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 27 Jul 2025 16:11:57 -0400
X-Gm-Features: Ac12FXwfLal8Ll8opOnrxHf5gQR5ooU-ILY_eaqC6nWd0w1d0c8Ut4rIfOL_Fzg
Message-ID: <CAPig+cSBj+kSmzKUarNPQt4qk5p9vjHFGFrJVYmT6TrWHACcEg@mail.gmail.com>
Subject: Re: [GSoC PATCH v5 0/5] repo: add new command for retrieving
 repository info
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, oswald.buddenhagen@gmx.de, ps@pks.im, 
	karthik.188@gmail.com, ben.knoble@gmail.com, gitster@pobox.com, 
	phillip.wood@dunelm.org.uk, jltobler@gmail.com, jn.avila@free.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 27, 2025 at 1:51=E2=80=AFPM Lucas Seiki Oshiro
<lucasseikioshiro@gmail.com> wrote:
> This v6 contains small fixes pointed in v5.
>
> In v5, Patrick and Junio were discussing about quoting the values in the
> key=3Dvalue format using `quote_c_style` [1]. Given that it wouldn't affe=
ct
> this patchset and it's a simple change that can be done later, I didn't
> change it and I'll leave for further discussion when I start to deal
> with paths.

The counterargument to this stance is that if you employ
`quote_c_style` from the onset and document it, then if a future
version of Git does start outputting values containing "funny"
characters for properties which previously did not emit such values
(this isn't limited to paths), then consumers who heeded the
documentation won't find their tooling breaking suddenly. Tooling may
break for consumers who did not heed the documentation, but that will
be due to their own shortsightedness, not due to the Git project
failing to care about compatibility between versions. For this reason,
I'm of the opinion that `quote_c_style` should be used and documented
even at this very early stage.
