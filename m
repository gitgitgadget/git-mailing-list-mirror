Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0403A2579
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 09:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Py78Q+v0"
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6584E5
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 02:16:33 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5a87ac9d245so31603517b3.3
        for <git@vger.kernel.org>; Mon, 23 Oct 2023 02:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698052593; x=1698657393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m74wrMWpbukbvREO27Y0VbdgSdMg6WFlV39iZF+y5YY=;
        b=Py78Q+v0NUPm4mQT25GW8tajZPALsZRO7kuzM1l3if8TduuW0uuSk7T6XHp3kyXrgx
         f7XZwV+UPRLuUVyJGEX9sWmTHwcUS8TooLpX2CSgi3PY0zd/ydx4mAeswHQG5d7qDYOf
         J1gw2q0JWK49od7CL7BMqr+LfG+4FhihT43JdpHDOidg9hpA+IDUHQV5z1a4K691uGX9
         NXmVLL7LX4kl4juogdpBO6sd/5AnDQXbpGfqPWvH+lSY13rIlO5YJY0e8zgwe8xizZgd
         dh4iRn/8exc0eaDIT6r+qk2doStF3RF6stWTn/whDN7TmM19OARFFyVntxm7xVoOYMo0
         Chzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698052593; x=1698657393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m74wrMWpbukbvREO27Y0VbdgSdMg6WFlV39iZF+y5YY=;
        b=T3iJnNAeQUzlSUB+SBI1YZ+e6J62QNI8PTVfhXq/vhewsPpi5DTyHKfM2Yb3wU+/mH
         cVuK8nekI0k/4VqdlM/6I3CHXkpMzZ+DTFt8/I0CyjXyhnva1sRIbsBO8bcWl56f5GLf
         NPf/DfJGbi6obY1a6VhWnkCiW3KSvvlYR9vIscnpv4HLaOGTcZH3oZE2LpRi53rVMwlI
         pH+l/tt02fWv8EVCY6Qah2mxoduYTYDCWu7v8+bDsHRVL02be6XitT4fqmTFTa1aoNKM
         8XQFGxdHFBEZKRP5WprlfCIry9/kchA+knq1XC/BzL1rbRva6g6DCkgVRjSi4HXTRQCM
         YwBg==
X-Gm-Message-State: AOJu0Yx0Sl4dA2EMLEfGk6xRPnolvT9v8wfYI30tYvjFTkblSID4geai
	awG7AOVMVcDs7AmWxsQ3OZVFlUCeJ+Wb0qtWK7M=
X-Google-Smtp-Source: AGHT+IHRBNXOSgPek7G3SVAvWsqXJRSzkLHLLb0zP2HX4ullFxKBlPkvhlqh+4aHz+7JwMRy3MwTNd7WdjUBFoj8/t4=
X-Received: by 2002:a81:5216:0:b0:58e:a9d3:bf98 with SMTP id
 g22-20020a815216000000b0058ea9d3bf98mr9272834ywb.27.1698052593049; Mon, 23
 Oct 2023 02:16:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <38b0b22038399265407f7fc5f126f471dcc6f1a3.1697725898.git.zhiyou.jx@alibaba-inc.com>
 <ced46baeb1c18b416b4b4cc947f498bea2910b1b.1697725898.git.zhiyou.jx@alibaba-inc.com>
 <ZTYue-3gAS1aGXNa@tanuki>
In-Reply-To: <ZTYue-3gAS1aGXNa@tanuki>
From: Jiang Xin <worldhello.net@gmail.com>
Date: Mon, 23 Oct 2023 17:16:20 +0800
Message-ID: <CANYiYbEJ_mHdsPM3-huDPFktSWFhrpoz7Cvf000JSfZM2cco9w@mail.gmail.com>
Subject: Re: [PATCH 2/2] fetch: no redundant error message for atomic fetch
To: Patrick Steinhardt <ps@pks.im>
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>, 
	Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 4:27=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Thu, Oct 19, 2023 at 10:34:33PM +0800, Jiang Xin wrote:
> > @@ -1775,10 +1775,8 @@ static int do_fetch(struct transport *transport,
> >       }
> >
> >  cleanup:
> > -     if (retcode && transaction) {
> > -             ref_transaction_abort(transaction, &err);
> > +     if (retcode && transaction && ref_transaction_abort(transaction, =
&err))
> >               error("%s", err.buf);
> > -     }
>
> Right. We already call `error()` in all cases where `err` was populated
> before we `goto cleanup;`, so calling it unconditionally a second time
> here is wrong.
>
> That being said, `ref_transaction_abort()` will end up calling the
> respective backend's implementation of `transaction_abort`, and for the
> files backend it actually ignores `err` completely. So if the abort
> fails, we would still end up calling `error()` with an empty string.

The transaction_abort implementations of the two builtin refs backends
will not use "err=E2=80=9C because they never fail (always return 0). Some =
one
may want to implement their own refs backend which may use the "err"
variable in their "transaction_abort". So follow the pattern as
update-ref.c and files-backend.c to call ref_transaction_abort() is
safe.

> Furthermore, it can happen that `transaction_commit` fails, writes to
> the buffer and then prints the error. If the abort now fails as well, we
> would end up printing the error message twice.

The abort never fails so error message from transaction_commit() will
not reach the code.

--
Jiang Xin
