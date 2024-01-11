Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFB910E1
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 00:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbhaFHOe"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50e7af5f618so5348955e87.1
        for <git@vger.kernel.org>; Wed, 10 Jan 2024 16:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704934778; x=1705539578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6ie49I21xOUlj0X2KqVdu9Z9NAzGccNU/pvvj3eclM=;
        b=fbhaFHOeEIqrQpnkXj0JJSjRQkW54c+VvGcUsfqpkXREMQqsnp3QWCIn2F0/5RN1IS
         NvqAFSK07NX4JZyiOz0pV/X6vryJLNZYerAV/OThzZyj3fwVOwDYYS/lf7AG5vMEIAXV
         CNpMbImHzixhBrYnskc3EWl/UXGpQARj0A7kT33IltioPpBOGKnT8XjiBaqxZPO522Hx
         rOozQQvoC697MuB0hp0Ur0BoEcAEYz8gWdem/nY1iTo6ZyZ7Bel7GINqYmlBke/e2M7v
         qBhjfugxqAYX2hxv2DfhCq8PNizQbnfeZVpmojxyy9hZK/hnjy8lr51vGZ4VGnZZ7Rt7
         U6Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704934778; x=1705539578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K6ie49I21xOUlj0X2KqVdu9Z9NAzGccNU/pvvj3eclM=;
        b=j2mrr8b7NhFi+KiA1t4RmJ+18C0YcEscccVMQ0HZthq5gCZaXRnPZUnyr82SpqoaSi
         hDeVwCo0dGCGY84lfFIQRG+hItqfZBxDhxmy2WpUpEvzNzWV1kFDoZcXS3d4raMvMRql
         M2Dbq7DTetMXYTVZhfbQBLPWzMUb4/BfHGWp8+UqtGKfYF6k5SHxaaAf6WETVuCUu2oe
         Iu7mX5OR4IojryiG6KKeHPT5VypZOWb+XZ9cHlHHOy+vTYpV5uSNbXzLqbusic6H+vgp
         qBiLJQLtKRl44wC/1gT15srs64BymA6p0t3iqP4LwKsXTForBJU2QFuU/Ra+5e+MsccO
         MFBw==
X-Gm-Message-State: AOJu0YywtU6t5Y9TZT8KJ2LPe9D1fT7trWuNnVXmAEOs7fBgvRQQuwTt
	b4EET2btU4KKNMjDOjUt51BeB0QfA76ow6MS894=
X-Google-Smtp-Source: AGHT+IHUocfVRxWO82Xww3NZbpv+QHK8mWcE6eT5seLMYac7VF6QJ90JGYE8AJKAqEfVs5yvyG3UQTo4RiTLQYeOYBM=
X-Received: by 2002:a05:6512:238d:b0:50e:d514:77c4 with SMTP id
 c13-20020a056512238d00b0050ed51477c4mr168732lfv.2.1704934778114; Wed, 10 Jan
 2024 16:59:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZZ77NQkSuiRxRDwt@nand.local> <b2651b38a4f7edaf1c5ffee72af00e46@manjaro.org>
 <xmqqjzog96uh.fsf@gitster.g> <006b01da4412$96c6c500$c4544f00$@nexbridge.com>
 <ZZ8ZlX6bf+hjmhN+@nand.local> <007c01da4420$10a7b700$31f72500$@nexbridge.com>
In-Reply-To: <007c01da4420$10a7b700$31f72500$@nexbridge.com>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 10 Jan 2024 16:59:25 -0800
Message-ID: <CABPp-BEw_HFL-9u6WdSEe-qr_JfJyQtfU6PP7izEdPChKooc6g@mail.gmail.com>
Subject: Re: [DISCUSS] Introducing Rust into the Git project
To: rsbecker@nexbridge.com
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, 
	Dragan Simic <dsimic@manjaro.org>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 3:52=E2=80=AFPM <rsbecker@nexbridge.com> wrote:
>
> On Wednesday, January 10, 2024 5:26 PM, Taylor Blau wrote:
> >On Wed, Jan 10, 2024 at 05:15:53PM -0500, rsbecker@nexbridge.com wrote:
> >> Just a brief concern: Rust is not broadly portable. Adding another
> >> dependency to git will remove many existing platforms from future rele=
ases.
> >> Please consider this carefully before going down this path.
> >
> >I was hoping to hear from you as one of the few (only?) folks who partic=
ipate on
> >the list and represent HPE NonStop users.
> >
> >I'm curious which if any of the compiler frontends that I listed in my e=
arlier email
> >would work for you.
>
> Unfortunately, none of the compiler frontends listed previously can be bu=
ilt for NonStop. These appear to all require gcc either directly or transit=
ively, which cannot be ported to NonStop. I do not expect this to change an=
y time soon - and is outside of my control anyway. An attempt was made to p=
ort Rust but it did not succeed primarily because of that dependency. Simil=
arly, Golang is also not portable to NonStop because of architecture assump=
tions made by the Go team that cannot be satisfied on NonStop at this time.=
 If some of the memory/pointer issues are the primary concern, c11 might be=
 something acceptable with smart pointers. C17 will eventually be deployabl=
e, but is not available on most currently supported OS versions on the plat=
form.

Would you be okay with the following alternative: requiring that all
Rust code be optional for now?

(In other words, allow you to build with USE_RUST=3D0, or something like
that.  And then we have both a Rust and a C implementation of anything
that is required for backward compatibility, while any new Rust-only
stuff would not be included in your build.)
