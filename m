Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601C07DA82
	for <git@vger.kernel.org>; Mon, 20 Jan 2025 18:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737396915; cv=none; b=XGkmOUlG+pouu5vrBFNajpnMrhtUWHXubVXEiiAYpnM7+B9luQQQXlMwFEWRnSDgyZHsoOmLO7ymRyOdMZhDSaWZOcqoAp0iQjjtZXm0vOOEdqtHHHSQ+4MqNV5kHADZFJFW4t/5FDQCvtLZGooOR2bybwbvDwRDXnk1RrBLaoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737396915; c=relaxed/simple;
	bh=3zwnYtM9o0GVgwLfYhl3Vutb0zxENN6GU8ldisXkiLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Egq2CNkTHBWrlVQyPECIASxSotX+i8QEr7kBJZmDPisqcT3ENTRRnB4oyx0QufecVl6u/NQCqLVXFitu6MG3lj9CB+XdhBul6CFjqr73btlRxbnr5HMrIZrv1DMqUyBodwiiV1qt7l9m5IFW5oENrU1WUSXtEceWT+8TMpB+2zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AkyViPlW; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkyViPlW"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5174db4e34eso3380848e0c.0
        for <git@vger.kernel.org>; Mon, 20 Jan 2025 10:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737396912; x=1738001712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lPkR7mzUm1u5VRfAxAPe8gWW7nPbvOpowa9An5C6Fac=;
        b=AkyViPlWoJcuv4QAr2S7V29mf1GAOmT4KLV2etUFX7QD4QndysbyhN8tMStTNCLIGi
         IpfNC6WyuBqzwZOl2FSppdPICQnRbspH+ZdY5am1gsx41NxaxRJbm8BNHak0as1YBK4W
         NQGRnC5CCPqo64UoR5+wd+C2CryzIa6ZeGoinMToRuJYo7ritgI2sS2m6ofIlvkx0NuR
         1VBxghM60x+wR9DSj1fGo2CIljU7x72m8htzGEVPlb1FID9zlmHMhX5c7MpHknUxznOn
         Vjff5mjqlmtSvkV59JB/dQoJXicds7MDs+Jv8zo+lMn27TBfkyjoXJkiw9bVoMsyse43
         Hrhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737396912; x=1738001712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lPkR7mzUm1u5VRfAxAPe8gWW7nPbvOpowa9An5C6Fac=;
        b=RMXXlRk7S17l3JmLehNZhW3bRemaSG6h2wgnTrQu4OcBvHrH7+BJNQsYvdDz+HalWC
         WncsfujJxZxGzJbEEWzkxGbCi84dxrBZyiqn45xAfOBSt9pbLyLbGvgtUC3sIiG3BnZX
         K7cLZfWoAlXEkPSaEmjYlyuIzgBpahzuJwbIaPzoFqeFvbqEzk2/yNRcq85sndWrl/gB
         pPod+CdN/vcR8IuIN7BD6IGRV3kC1wOtUJqYmmMEsD9I2WG1ZD4/pqz46vwqThwmFxYj
         znpqJfOYNOpX7yjJI7wp8G08TGlDOLDlJjDfodGBVWb5OyN3RttZp6PFMYY0PXIi3hcs
         0qRw==
X-Gm-Message-State: AOJu0YxHVNanrl/n64S1alwEQZ2k2d0jsVvZMyyB+EfzVIGHBIxTlt4S
	WR9SA+tBR2fwED0Ap9lPe5O0seStBDWBPzP6YogoEoK9V3OGd0k2pU2vv3NWQ8oS6mJu9+9eu6/
	t9K5LvnoTcCzhl3knrDTjkF6f/Ts=
X-Gm-Gg: ASbGnctq59PtNL95YASETowJg54+f2/7f+v6Qh/2g5x49w3Whiu2zbqenAF59r1Y9N+
	bucWxqik43qqM5Q6i9Wtfj9sBlgQs47BxC0+7Q7iurCXv333YqWk=
X-Google-Smtp-Source: AGHT+IHHYkIVmTesJ+YKFsrKkyGVQLmcI4630vMTjs7FiwO2OQ49oZSTgYixtjdp08dISx9DQqTip+I/PjN0Q2uppyQ=
X-Received: by 2002:ac5:ccd0:0:b0:518:8915:89ec with SMTP id
 71dfb90a1353d-51cd9679db8mr14271697e0c.1.1737396912067; Mon, 20 Jan 2025
 10:15:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106103713.1452035-1-usmanakinyemi202@gmail.com>
 <20250117104639.65608-1-usmanakinyemi202@gmail.com> <20250117104639.65608-6-usmanakinyemi202@gmail.com>
 <xmqq4j1xjd2m.fsf@gitster.g>
In-Reply-To: <xmqq4j1xjd2m.fsf@gitster.g>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Mon, 20 Jan 2025 23:45:00 +0530
X-Gm-Features: AbW1kvZlSHDPs0kluFODriTdIm3BdzPooHHYji2kotzv6_TdFI2CQd1dOlGOhio
Message-ID: <CAPSxiM__kNH7+itsiOHzztJZZvpw-AcR1s=ZfSm=OLv4p0POsw@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] connect: advertise OS version
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, ps@pks.im, 
	johncai86@gmail.com, Johannes.Schindelin@gmx.de, me@ttaylorr.com, 
	phillip.wood@dunelm.org.uk, sunshine@sunshineco.com, rsbecker@nexbridge.com, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 18, 2025 at 3:52=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Usman Akinyemi <usmanakinyemi202@gmail.com> writes:
>
> > As some issues that can happen with a Git client can be operating syste=
m
> > specific, it can be useful for a server to know which OS a client is
> > using. In the same way it can be useful for a client to know which OS
> > a server is using.
>
> Hmph.  The other end may be running different version of Git, and
> the version difference of _our_ software is probably more relevant.
> For that matter, they may even be running something entirely
> different from our software, like Gerrit.  So I am not sure I am
> convinced that os-version thing is a good thing to have with that
> paragraph.
Hi Junio,

What could be a better way of describing this ? Also, user-agent capability=
 is
already sharing the information about the version of Git.
>
> > Let's introduce a new protocol (`os-version`) allowing Git clients and
> > servers to exchange operating system information. The protocol is
> > controlled by the new `transfer.advertiseOSVersion` config option.
>
> The last sentence is redundant and can safely removed.  The next
> paragraph describes it better than "is controlled by".
Noted, I will do that.
>
> > Add the `transfer.advertiseOSVersion` config option to address
> > privacy concerns. It defaults to `true` and can be changed to
> > `false`. When enabled, this option makes clients and servers send each
> > other the OS name (e.g., "Linux" or "Windows"). The information is
> > retrieved using the 'sysname' field of the `uname(2)` system call.
>
> Add "or its equivalent" at the end.
>
> macOS may have one, but it probably is not quite correct to say that
> Windows have uname system call (otherwise we wouldn't be emulating
> it on top of GetVersion ourselves).
Yeah, noted. I will do that in the next iteration.
>
> > However, there are differences between `uname(1)` (command-line utility=
)
> > and `uname(2)` (system call) outputs on Windows. These discrepancies
> > complicate testing on Windows platforms. For example:
> >   - `uname(1)` output: MINGW64_NT-10.0-20348.3.4.10-87d57229.x86_64\
> >   .2024-02-14.20:17.UTC.x86_64
> >   - `uname(2)` output: Windows.10.0.20348
> >
> > On Windows, uname(2) is not actually system-supplied but is instead
> > already faked up by Git itself. We could have overcome the test issue
> > on Windows by implementing a new `uname` subcommand in `test-tool`
> > using uname(2), but except uname(2), which would be tested against
> > itself, there would be nothing platform specific, so it's just simpler
> > to disable the tests on Windows.
>
> OK.
>
> > +transfer.advertiseOSVersion::
> > +     When `true`, the `os-version` capability is advertised by clients=
 and
> > +     servers. It makes clients and servers send to each other a string
> > +     representing the operating system name, like "Linux" or "Windows"=
.
> > +     This string is retrieved from the `sysname` field of the struct r=
eturned
> > +     by the uname(2) system call. Defaults to true.
>
> Presumably, both ends of the connection independently choose whether
> they enable or disable this variable, so we have 2x2=3D4 combinations
> (here, versions of Git before the os-version capability support is
> introduced behave the same way as an installation with this
> configuration variable set to false).
>
> And among these four combinations, only one of them results in "send
> to each other", but the description above is fuzzy.
Yeah, describing the four combinations would better right ?
>
> > diff --git a/connect.c b/connect.c
> > index 10fad43e98..6d5792b63c 100644
> > --- a/connect.c
> > +++ b/connect.c
> > @@ -492,6 +492,9 @@ static void send_capabilities(int fd_out, struct pa=
cket_reader *reader)
> >       if (server_supports_v2("agent"))
> >               packet_write_fmt(fd_out, "agent=3D%s", git_user_agent_san=
itized());
> >
> > +     if (server_supports_v2("os-version") && advertise_os_version(the_=
repository))
> > +             packet_write_fmt(fd_out, "os-version=3D%s", os_version_sa=
nitized());
>
> Not a new problem, because the new code is pretty-much a straight
> copy from the existing "agent" code, but do we ever use unsanitized
> versions of git-user-agent and os-version?  If not, I am wondering
> if we should sanitize immediately when we obtain the raw string and
> keep it, get rid of _santized() function from the public API, and
> make anybody calling git_user_agent() and os_version() to get
> sanitized safe-to-use strings.
>
> I see http.c throws git_user_agent() without doing any sanitization
> at the cURL library, but it may be a mistake that we may want to fix
> (outside the scope of this topic).  Since the contrast between the
> os_version() vs the os_version_sanitized() is *new* in this series,
> however, we probably would want to get it right from the beginning.
>
> So the question is again, do we ever need to use os_version() that
> is a raw string that may require sanitizing?  I do not think of any
> offhand.
In this case, I guess there has to be a conclusion on what to do.
