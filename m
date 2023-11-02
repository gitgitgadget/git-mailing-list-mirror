Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD461BDE2
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 15:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWHl2M4T"
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A64E138
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 08:07:01 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-543c3756521so1692682a12.2
        for <git@vger.kernel.org>; Thu, 02 Nov 2023 08:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698937619; x=1699542419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jNfTFWnqfCrBf3rmtUbL9UNp3dU9CDFK2MjzE3SWm3A=;
        b=WWHl2M4Tv7b/NIIqIV8FyVNW8UUGaYd4aWX2aYM2vc4MVMIm++p2RHhMI7rDFm4OQy
         9kF/i9pUWAsvrgak5PL1h3Ln6ayPFC3C6LSw005SBLLLs85sFwwMirp3QRFjBnaVdfxq
         xEOpxoxj7K5dNzT5R5n//2h2mLS61cNFTXul7qCHzo7ZSXj9fPGvd7yX//9EH5hLzr2X
         xQp65nFk0XHD4Ymip+CovdZoIsuxy/X25JVBBVK3xHX+2/joCJGPyH4p6CsP5exqWAIk
         /xkLI+DHu0U4TwJyYafEDjNUA3ty5ErJl/dMsEo9tGni2o2OLISPuc6WmcIKtbTd+CqH
         9cTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698937619; x=1699542419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jNfTFWnqfCrBf3rmtUbL9UNp3dU9CDFK2MjzE3SWm3A=;
        b=b6zeIusYK6Fbc/bPYxqH7u94FXzcw9a5JU7blOUPdOCz283QCEBgXsONWl+APF6+cU
         BK/ban9dITmKMFjEOjCrGyVQjxL1b6UrEX2WHKJz+qzDtnya4+kXMzbQoctLSj9v6hJZ
         btaTd8wLZepQEhGX0AMMuMVESNjcvK4J67np2UZHsl0nVkOBB1yWHplZip0EzNDpTYQj
         wiFRfSnpjBNJTvDwDs2jjreAUO+1cxWxp75TYLw9xdPGOzEKnrhSwKzMv/U9EcIjP+d9
         6qeXzSErPCnJAj/4/ye8wh1gHIIP3TejJnptLAw4a2ib5nDIhj2IiO7H2w+aPSZBH1JS
         A7Eg==
X-Gm-Message-State: AOJu0Yz0qQT9pFULnJWdNZph8asea7xhiA91FpYKNGU8w59fhZDLwI4K
	Oox0dNUgiMrDT1a5/qtH7FEejW22aQ8hd2JWVm4=
X-Google-Smtp-Source: AGHT+IE+7SsWEQ1trzfgGx2/h586cmVMVzo4X/E13NZsiH7x5YNwREkPv77w8iLMWsF42s+fyYi9FmNFHaTL4uO+SIQ=
X-Received: by 2002:a50:d5d4:0:b0:53e:98c6:5100 with SMTP id
 g20-20020a50d5d4000000b0053e98c65100mr15774104edj.30.1698937619452; Thu, 02
 Nov 2023 08:06:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230907092521.733746-1-christian.couder@gmail.com>
 <20231010123847.2777056-1-christian.couder@gmail.com> <bd872b81-80a9-5e4e-dcb6-faebc9671848@gmx.de>
In-Reply-To: <bd872b81-80a9-5e4e-dcb6-faebc9671848@gmx.de>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 2 Nov 2023 16:06:47 +0100
Message-ID: <CAP8UFD09dZbrbebRFZvarY71q5Vc0YBfRQHbTg7A3H-qM2g8fg@mail.gmail.com>
Subject: Re: [PATCH v5 00/14] Introduce new `git replay` command
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>, Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	John Cai <johncai86@gmail.com>, Derrick Stolee <stolee@gmail.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, Calvin Wan <calvinwan@google.com>, 
	Toon Claes <toon@iotcl.com>, Dragan Simic <dsimic@manjaro.org>, Linus Arver <linusa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dscho and Elijah,

On Thu, Oct 26, 2023 at 3:44=E2=80=AFPM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

> In addition, I am still a bit uneasy with introducing both the manual pag=
e
> and the test script in this commit (see my comments in
> https://lore.kernel.org/git/03460733-0219-c648-5757-db1958f8042e@gmx.de/)=
.
> It would be better to uphold our high standard and introduce scaffolds fo=
r
> both files in the first commit, then populate the file contents
> incrementally in the same the patches that introduce the corresponding
> options/features/changes.

I have tried to improve on that in the v6 I just sent, but there are
many patches implementing changes in behavior that I think weren't
worth documenting and testing in `test-tool fast-rebase` (which had no
doc and no test) and that aren't worth documenting and testing
specifically in `git replay` either.

Thanks!
