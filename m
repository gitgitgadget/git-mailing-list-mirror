Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC245381B1
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 17:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721756882; cv=none; b=fhtyc0TxcRAMoalWaE/ASlkIjfi75E/RUBauzDxIToxDQlFzDBuT1c3ft2RVv5XgaP3BN+5sIfNyzk5Dj9npWFC/cfxe15svAfIfiR8GpaE4QA/nLaBDTnq6WIxOhieaLzPrfFcCRezWgysP1WMIww5zJhKbvICVEdZAdd8V29E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721756882; c=relaxed/simple;
	bh=kw2/jZc/+gXGzeAYlEXU1T5lh7kyED/PR3HkwJ1yCXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SoQdITNiMd7s4csdJSo5Jyw0W5JO4Xnwf1OGcUkQysWeH+Cyt3MxaUAEVGMu0dCvTT17IpumkRbqM1xPbx2a4N6aOeXrz4/knL1L60OhnGGdf4YOZCb8+omR+zik7NyLVi7pB7zU/48AIUdtV5U2kOZSNK6by77kxXeiIuVJUX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6b7a3e4686eso35745916d6.1
        for <git@vger.kernel.org>; Tue, 23 Jul 2024 10:47:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721756879; x=1722361679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FDxfHFSDUMdCBe/ycZth0aKYpIiCp6pcaS1qBNw9H04=;
        b=uEFrESuOhqLgMLH+PWaLLNkpgIrODK7h/wVgG9xLS9EJNV+CtZzv+xyHSL4+0uAjVD
         UU5CnjfB0bulPCVVWj48soSTWVV9u3zjGWLrx9dyZsiFW/W/zkkRFrHrE+PxhTCa4pNP
         pgIgaWDt3nHC/2/aVxu8tlKyVoZVoz9wDs4LP3HmcT0clnWs6A8OZAoG48ZzGygBF3zJ
         dV+fqlcKHdQAPhLx0F8SH9TTYURmIGzet0ADT4j1+4suoTEbM/mdOnW8rAjWTin2wug7
         Na+BECnEdwSUIbjcA50QGw7kDV60QSs2MdkkUxfNaBuu+YG4meq94ohSA7XJTb3qoAyO
         vvfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWldIP8VKyjI1kzrzEtc271c9V3OHb/5omTx+USoKzA66RzdpLU/DsR7Y5o1rcu34LvNKg4vIO4FIYvu4bX0de6Rcg7
X-Gm-Message-State: AOJu0YyMFw8NEPFgrZR766TfyVqzaQ3W7rE3J4JzxmdtBZeER0xKwYGg
	6X8q84MG9p1RIH8eanBm68vIT+Q7XVj0S5qfFHZzL3/0ex02cU/evwDZY6G4Tc7vPdZjY8iSqRD
	6CPh7xaivyBQEjNk9dA+EG1rNmpI=
X-Google-Smtp-Source: AGHT+IG+pXAif4E5BZ56vhEcy8yOEK6GMYTwcUFq30rNEz2vawKez+t7kuD/bpfeBq47deNKSiM3ZF5ggNrVCNxBRX0=
X-Received: by 2002:a05:6214:3014:b0:6b5:44e4:eb3f with SMTP id
 6a1803df08f44-6b95a924083mr142932246d6.47.1721756878805; Tue, 23 Jul 2024
 10:47:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1765.git.1721496853517.gitgitgadget@gmail.com>
 <xmqq8qxvhcy5.fsf@gitster.g> <8404759.T7Z3S40VBb@cayenne> <xmqqplr5e5yk.fsf@gitster.g>
 <89d00235-71db-4087-8ffb-7e93c3f470a0@free.fr> <xmqqv80w2ji8.fsf@gitster.g> <xmqqv80w0zrx.fsf@gitster.g>
In-Reply-To: <xmqqv80w0zrx.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 23 Jul 2024 13:47:47 -0400
Message-ID: <CAPig+cQK17Xt6p7PSO4Mn1CLx_ayceQdj8ZY1zBVG6-c33OvsQ@mail.gmail.com>
Subject: Re: [PATCH] doc: git-clone fix discrepancy between asciidoc and asciidoctor
To: Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?Q?Jean=2DNo=C3=ABl_Avila_via_GitGitGadget?= <gitgitgadget@gmail.com>, 
	git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 1:44=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> Subject: [PATCH] Doc: fix Asciidoctor css workaround
>
> The previous step introduced docinfo.html to be used to tweak the
> CSS used by the asciidoctor, that by default renders <code> inside
> <pre> as a block element, breaking the SYNOPSIS section of a few
> pages that adopted a new convention we use since Git 2.45.
>
> But in this project, HTML files are all generated.  We do not force
> any human to write HTML by hand, which is an unusual and cruel
> punishment.  "*.html" is in the .gitignore file, and "make clean"
> removes them.  Having a tracked .html file makes "make clean" make
> the tree dirty by removing the tracked docinfo.html file.
>
> Let's do an obvious, minimum and stupid workaround to generate that
> file at runtime instead.  The mark-up is being rethought in a major
> way for the next development cycle, so what the CSS workaround we

Perhaps? s/what/that/

> added in the previous step may have to adjusted, possibly in a large
> way, anyway.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
