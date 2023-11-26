Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D154BE6
	for <git@vger.kernel.org>; Sun, 26 Nov 2023 09:49:25 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso2793264276.2
        for <git@vger.kernel.org>; Sun, 26 Nov 2023 09:49:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701020965; x=1701625765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nCpK2AuqyM8T0XZ4TLwPK/F2AWZyd1QYK+N+ZmRFZZc=;
        b=q1G8MgXsLNnL2QKMs+waRYCapOSeqLQa4dgZcJ05Zg6RFeemwV5h5KIJFHJVbSSY+x
         QWvK5Nmp1QxyCNN7ivHfNzHp07nbfzNrGt3qRXkdRT9Wye1ZvhIoTfv/i67+PS7RkP4i
         6eUVEnoNDASPmLEaTFhFcoQ2mSA1Rt6bDgk9lBhLVlslQTGkabDQD/6gDEMvZg+Vnoas
         0nrhWJdmS/7RVnghp5u971MGGpsyrQ4ujOH6iGbxGurvsNLHK/x/6KhzO19PN+C2mmD/
         q7mUqq89BIXP5Imf+jtpmzwoZ6PFJRi1aGtEkJLk91hMNoDiWPh3lfwtSP/x3qINSWZU
         6vvQ==
X-Gm-Message-State: AOJu0YylepEMFOWOSL/OjYR0KLc17lRnb/bLY6McF1wnWhcHe9anO89U
	o6bReA/gzK+1H8AYm5z5XPut9GPy+k8yolMHMoGaLUQnMraAnw==
X-Google-Smtp-Source: AGHT+IH3YmPQpGQfwZEDcyT0ke2SZDMyTGsBO0j1VnqnE8izVlBu2sYtLTwiSRyj+HNnjQ6zPYNuqckv1JCzk6pxqCA=
X-Received: by 2002:a5b:309:0:b0:db0:232c:451c with SMTP id
 j9-20020a5b0309000000b00db0232c451cmr6743748ybp.10.1701020964746; Sun, 26 Nov
 2023 09:49:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e6eb12e4-bb63-473c-9c2f-965a4d5981ad@web.de>
In-Reply-To: <e6eb12e4-bb63-473c-9c2f-965a4d5981ad@web.de>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 26 Nov 2023 12:49:13 -0500
Message-ID: <CAPig+cR5PKkyC24LkOU4+yzng1xeBOBbADTBHXH61xkAR7kymw@mail.gmail.com>
Subject: Re: [PATCH] i18n: factorize even more 'incompatible options' messages
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>, =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 26, 2023 at 6:57=E2=80=AFAM Ren=C3=A9 Scharfe <l.s.r@web.de> wr=
ote:
> Continue the work of 12909b6b8a (i18n: turn "options are incompatible"
> into "cannot be used together", 2022-01-05) and a699367bb8 (i18n:
> factorize more 'incompatible options' messages, 2022-01-31) to use the
> same parameterized error message for reporting incompatible command line
> options.  This reduces the number of strings to translate and makes the
> UI slightly more consistent.

Thanks for tackling this.

A couple additional instances recently slipped into `show-ref.c` which
were caught during review[1,2] but nevertheless made it to
"master"[3,4]. This patch, of course, doesn't need to address those,
but if rerolling for some other reason, perhaps they can be included,
as well(?).

[1]: https://lore.kernel.org/git/CAPig+cSrp7vZuy7D_ENHKZKZzF4OSmCtfYNHPGMtS=
1Hj6gArDw@mail.gmail.com/
[2]: https://lore.kernel.org/git/CAPig+cRTOMie0rUf=3DMhbo9e2EXf-_2kQyMeqpB9=
OCRB1MZZ1rw@mail.gmail.com/
[3]: 199970e72f (builtin/show-ref: ensure mutual exclusiveness of
subcommands, 2023-10-31)
[4]: 9080a7f178 (builtin/show-ref: add new mode to check for reference
existence, 2023-10-31)
