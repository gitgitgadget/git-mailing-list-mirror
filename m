Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4557010782
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 09:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qu3ROOrg"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5ff4b02a187so6909787b3.1
        for <git@vger.kernel.org>; Tue, 16 Jan 2024 01:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705395880; x=1706000680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UerO2q2xIHp2MhMygj4XekZDcmQRIlXdz98LiSYi/yY=;
        b=Qu3ROOrgTIQyyFAljN8yqoh5mzsXEbsDJNn/2rzZPY73ZzWypcPvXhB4/OnECDX1BJ
         zQUfAQx9ty/48cdcEP8mVpfv+G8buNBMY0cMpqW6cuW/KLqBUKeaRlqHWWAm44UEkxQH
         5pDZJ4Jf+F2pxqMHhD1d1TolAmcP48o6x8gVBlk/2e6BdQFshmXIbwalFYDCVcU8uqPr
         7TpMn9CDVd4htTwrNuPB54pWRDhH8mmWkbJVa4/gvf2jpAJmmwq36GIm9hN2PYOAa+BV
         WyYfLaaOFSYi90hEXEvchioiDgwRWrCtZmMERNBelvgyZ3p6oCeWapblvSZKPD2Gfldp
         iaDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705395880; x=1706000680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UerO2q2xIHp2MhMygj4XekZDcmQRIlXdz98LiSYi/yY=;
        b=uOY4optzAYV0c3dWCKeZG8n7vwDhKWB7TND+uPDnG9AdcBME8qTz/ekiRieoSv9WHp
         uiSfr0AKUtys7AoUBrDbHtqXeP/lAP1qHi19ctNAmVKNGTKPMqWv2Mo/IiX/WyTK3mbH
         U8pcTIRtB66qh7tgo72VwmaoTeG1HH/NZMKTaVraDczRjhHlpMtvJf99h+CZ7FLtgIqr
         LiSHPwOFzcSvJ1Sdj+wCjM1zp/HUwKjBkdLYerkrX4NRtvIu40eM3J0kd2nTlYNFk9NF
         1iXOWl5LwKEA7gfWfBUFuZaxsBueCeU+LzOayNo7h0q/NQwi3PnuP1PdP8Zr1UJQ2mBn
         FtQw==
X-Gm-Message-State: AOJu0YzvP5xfiR6Wf6uHntFKApKZNys6mCQ464vgoalwpVH6Ownk+Auq
	FwBIhvhFRc2rRIxJwWB5LQ/+asG3aoqbmfY9Yaw=
X-Google-Smtp-Source: AGHT+IF6faiigBpD+hjm3KrooHaie0HjJGuksuP/UOfxCwpc693CYlsqi5ifPRZsaCS63woXD9QWWIal7TSRUSz9Pac=
X-Received: by 2002:a0d:cc56:0:b0:5ff:4755:3711 with SMTP id
 o83-20020a0dcc56000000b005ff47553711mr1369626ywd.11.1705395880060; Tue, 16
 Jan 2024 01:04:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1696432593.git.zhiyou.jx@alibaba-inc.com>
 <cover.1702562879.git.zhiyou.jx@alibaba-inc.com> <d343585cb5e696f521c2ee1dd6c0f0c2d86de113.1702562879.git.zhiyou.jx@alibaba-inc.com>
 <owlyy1cvhua5.fsf@fine.c.googlers.com>
In-Reply-To: <owlyy1cvhua5.fsf@fine.c.googlers.com>
From: Jiang Xin <worldhello.net@gmail.com>
Date: Tue, 16 Jan 2024 17:04:28 +0800
Message-ID: <CANYiYbFOa-E8Pivhgn_nmy982fn7VPtb803bewnC_UV7qY3xcw@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] transport-helper: no connection restriction in connect_helper
To: Linus Arver <linusa@google.com>
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>, 
	Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 3:42=E2=80=AFPM Linus Arver <linusa@google.com> wro=
te:
>
> Jiang Xin <worldhello.net@gmail.com> writes:
>
> > From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> >
> > When commit b236752a (Support remote archive from all smart transports,
> > 2009-12-09) added "remote archive" support for "smart transports", it
> > was for transport that supports the ".connect" method. The
> > "connect_helper()" function protected itself from getting called for a
> > transport without the method before calling process_connect_service(),
>
> OK.
>
> > which did not work with such a transport.
>
> How about 'which only worked with the ".connect" method.' ?
>
> >
> > Later, commit edc9caf7 (transport-helper: introduce stateless-connect,
> > 2018-03-15) added a way for a transport without the ".connect" method
> > to establish a "stateless" connection in protocol-v2, which
>
> s/which/where
>
> > process_connect_service() was taught to handle the "stateless"
> > connection,
>
> I think using 'the ".stateless_connect" method' is more consistent with
> the rest of this text.
>
> > making the old safety valve in its caller that insisted
> > that ".connect" method must be defined too strict, and forgot to loosen
> > it.
>
> I think just "...making the old protection too strict. But edc9caf7
> forgot to adjust this protection accordingly." is simpler to read.

Thanks for the above suggestions, and will update in next reroll.

> > Remove the restriction in the "connect_helper()" function and give the
> > function "process_connect_service()" the opportunity to establish a
> > connection using ".connect" or ".stateless_connect" for protocol v2. So
> > we can connect with a stateless-rpc and do something useful. E.g., in a
> > later commit, implements remote archive for a repository over HTTP
> > protocol.
> >
> > Helped-by: Junio C Hamano <gitster@pobox.com>
> > Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> > ---
> >  transport-helper.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/transport-helper.c b/transport-helper.c
> > index 49811ef176..2e127d24a5 100644
> > --- a/transport-helper.c
> > +++ b/transport-helper.c
> > @@ -662,8 +662,6 @@ static int connect_helper(struct transport *transpo=
rt, const char *name,
> >
> >       /* Get_helper so connect is inited. */
> >       get_helper(transport);
> > -     if (!data->connect)
> > -             die(_("operation not supported by protocol"));
>
> Should we still terminate early here if both data->connect and
> data->stateless_connect are not truthy? It would save a few CPU cycles,
> but even better, remain true to the the original intent of the code.
> Maybe there was a really good reason to terminate early here that we're
> not aware of?
>

It's not necessary to check data->connect here, because it will
terminate if fail to connect by calling the function
"process_connect_service()".

> But also, what about the case where both are enabled? Should we print an
> error message? (Maybe this concern is outside the scope of this series?)

In the function "process_connect_service()", we can see that "connect"
has a higher priority than "stateless-connect".

>
> >       if (!process_connect_service(transport, name, exec))
> >               die(_("can't connect to subservice %s"), name);

Regardless of whether "connect" or "stateless-connect" is used, the
function process_connect_service() will return 1 if the connection is
successful. If the connection fails, it will terminate here.
