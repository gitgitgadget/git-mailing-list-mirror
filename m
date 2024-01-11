Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4382C58206
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 21:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dbeff3fefc7so4833806276.2
        for <git@vger.kernel.org>; Thu, 11 Jan 2024 13:45:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705009551; x=1705614351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xfmersojDo/ysxCewG8i+6he7EgQtSJGECBK7S9WQvs=;
        b=daD8Qi5fqT9wESrgBiuZBm3zh2yhXMcMRfI9e0JsZmAqEmIRx/kf/9uDvFiflhrRDD
         eSltEUzeRzlodQbMPtR+twpczGcb13OdxTRrY1GAtH+kBG5qsY2nCFrspnErTA8aG9vv
         gl6NMKi223q4LB4hsPdsqE9aZAO4PBT5tcJ8Fp8i/GKtsochqIFqpQd/inOoFoUG3wqC
         iYBr5sSoPJq4L7VMOwOJUZUol1RLji0F7fdxYWDhINoGi6w6Z4k2/TZ2m8nIbF9Zva33
         XL7Mdry2lkhte4SLKidbftiJqo9OdamH66zRH4z+3D8XB1qca5mssR2Kxz5dqka7dN90
         9tFg==
X-Gm-Message-State: AOJu0YxTJ6kghP/Xr0NVBHSkeCCdrId+w/Ki/Hy29nrG9r8D4Qd1gNTZ
	6faR1sdENAhcmKtk4G4zJ3xzeEcNg1BW1arev6w=
X-Google-Smtp-Source: AGHT+IEO/pWt8VhwGMJWC8D3rggbpsnbGQYr3lCBcDnOnQ5D/TA04ZzLYwWLhjW1caj6UA3rbvOM2WDIeuTqQBLaZ+c=
X-Received: by 2002:a05:6902:1009:b0:dbc:eaef:5c42 with SMTP id
 w9-20020a056902100900b00dbceaef5c42mr398913ybt.30.1705009551247; Thu, 11 Jan
 2024 13:45:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1638.git.1705008449995.gitgitgadget@gmail.com> <ZaBhHSCT7EOgTo/N@nand.local>
In-Reply-To: <ZaBhHSCT7EOgTo/N@nand.local>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 11 Jan 2024 16:45:40 -0500
Message-ID: <CAPig+cTsDxv4tmULLF-y3eE4q0b=f+W7-ChyYD2MzPxCiLJY8w@mail.gmail.com>
Subject: Re: [PATCH] push: improve consistency of output when "up to date"
To: Taylor Blau <me@ttaylorr.com>
Cc: Benji Kay via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Benji Kay <okaybenji@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 4:44=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
> On Thu, Jan 11, 2024 at 09:27:29PM +0000, Benji Kay via GitGitGadget wrot=
e:
> > -             fprintf(stderr, "Everything up-to-date\n");
> > +             fprintf(stderr, "Everything up to date.\n");
>
> Between the two, I have a vague preference towards "up-to-date", which
> would suggest changing the pull command's output to read "Already
> up-to-date". Personally I think that neither of them should include a
> period in their output, but whichever we decide should be done so
> consistently between the two.
>
> Also, should this string be marked for translation?

See: https://lore.kernel.org/git/7n9r5q74-9qr1-29sr-p2n5-943n01s0p78r@tzk.q=
r/
