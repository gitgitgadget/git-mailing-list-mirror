Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECEC267F5D
	for <git@vger.kernel.org>; Thu, 22 May 2025 09:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747905824; cv=none; b=J2fWYeyO1ZgYgepJ3pZQsM2Kdsj/tZY8NAfgxlj4apm025ftaJnowAkah1zeTxwF2ym20gsqgVKwJz/1dxwyA0ug1cVPES3PAAwjwEYhvR4T5zXcgaujF67/HrXKptlHY/GkO0SPZ+1Zb3q7OiQMYDjVJahGW7pt9YEwAZjU/Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747905824; c=relaxed/simple;
	bh=p4HrtwMxNW9lJwAwJuL/6PJEuhSN4/HpOH8xlUC7eFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uvRn7lq03gqiISF6TkYQf21jFW0rM7clfpW/gNg4iDXY0D3SJhxBK4o8I/O5qKA0qHOQAMh4CtkCTGESQF879i410SpVOOVifetXLps3YbV6AZAIbU2cCYqe3V+mVYFg9R/UIGCu9GVFNcVD3gPLYIdvU7+f/X7PoQhc5EDTwPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DroQSrAv; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DroQSrAv"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ad1b94382b8so1407294766b.0
        for <git@vger.kernel.org>; Thu, 22 May 2025 02:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747905821; x=1748510621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLkaQf3w0Sd/tspMZmz8DuOefZPa80/9UfbyfNHV8iA=;
        b=DroQSrAvSuP1Z0Rd9LRgX/0XKDF6cMeFCbnKurU17NanokBco2Mu+dM5zX0W+nKZcN
         cRdDWkCpCyTcCuRPFlKIPhTlgTLvT0MvQQuVlisB+R4gMDLKIW8/UznpmXNuTje6EBMp
         d2QIXHyqifKJHBShkxSoxtLfWYn9506yikH59bNjCe3L7wQ32D2wiLnSfPD72uGjhqOH
         ds2hbtTrSu9Pi2IBE2qcMF7o73WNhWg5hxv+jzyZlN3JSAHtK0FpXUwmRPaEEuA9RK1O
         VxuQ0GzXZrm83ZA+XKBRdKvla/2DwasaRRX6+TvL42KjtM/ZaGUcaAagB4RZOTQt6WMY
         8cMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747905821; x=1748510621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hLkaQf3w0Sd/tspMZmz8DuOefZPa80/9UfbyfNHV8iA=;
        b=jhEUoBSbxxa505r/lwY5Wq+FAtYJISsOgVUmhCS4kmOrm7hEUEumbz0TRuibr7OS4g
         L1v25JNUoo3KTdPpWgx46Ah8TvekgVy/JCA/1ZtyMBCPs5z7eFOR8Ok1slRJl+c4pxZH
         ikZ5/grVTL/hnyma2/mUXByft3BywIpd7R6SnjOGdLXYEXVWDk1AB4vBCwPSxCh7yl4u
         FiHx+oK2WWyMNhgxhdHZYQ/ERrYKbmy1ZMNmq8vw3mdVZD0suuW/H/2NBE/ek3+YP9zp
         zbSqjZuMCoO6L3vQk7GZ0HLvtrlGJg08GTjzzzY4AxEo+YM8PuUOICGrOoI4Vym0eHxx
         utdw==
X-Forwarded-Encrypted: i=1; AJvYcCXW+cnVNeXpe3uEQICLr1uWSSy1l5wlSiBrDj1SI7mBvbpaET9A4pWy9hfAVg16stD8i/A=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl6CBAzbhVkzqOZNXYxWcKpjLguB/ewgpX9Vn8j7mqRUaMxKKa
	Ate/7Xg66PHlRuvXLJuv+K1VLeFwP37AUS2olA9kgpdRj5f7berwaAHb8ItSHt485CUAPcrWKKi
	Lx4d1b3D0NSaDRHJxmXGfyyTL3OG6o/Q=
X-Gm-Gg: ASbGnct2qG7DnBCdCXluWS0tItCTMT3H/20NMr/ttz/oHdF09LBrQCSjUHf5Uxjtc0R
	7vwiZxK2bsuE9poAg8kSlKWK0T2jPFLiBFCkTHsiJGgOQ62LAi7Z/sizNwUQEZ+0O6LnNure5cH
	EjHRL8UOZrifo4bBgspYrTFL5f52BOVxbiwheAKUMLbByElUaPRIZn
X-Google-Smtp-Source: AGHT+IEp+oUWHn1O+UoU0ECWlU7ISAYKdpJizFxKWhvHyspurjmPfi9kZDz0qbn6gpSdvqOiXooJcpoN+OlLwtxneVA=
X-Received: by 2002:a17:907:868f:b0:ad5:45d6:5fd5 with SMTP id
 a640c23a62f3a-ad545d66146mr2117876266b.30.1747905820712; Thu, 22 May 2025
 02:23:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1971.git.git.1747854310479.gitgitgadget@gmail.com> <xmqqr00hahdt.fsf@gitster.g>
In-Reply-To: <xmqqr00hahdt.fsf@gitster.g>
From: Jouke Witteveen <j.witteveen@gmail.com>
Date: Thu, 22 May 2025 11:23:29 +0200
X-Gm-Features: AX0GCFuxXezncYqcLfuZeo1JQp5xIYwJR8bhfh92mhBKRUzzs7fxSQfu6KUBXcE
Message-ID: <CAJ2ouazRuF8CGddobgV=xJr8=1RQ4Pv8+ndH0E4qxk-gJhG4AQ@mail.gmail.com>
Subject: Re: [PATCH] doc: update references to renamed AsciiDoc files
To: Junio C Hamano <gitster@pobox.com>
Cc: Jouke Witteveen via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 9:33=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Jouke Witteveen via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Jouke Witteveen <j.witteveen@gmail.com>
> >
> > diff --git a/Documentation/gitprotocol-v2.adoc b/Documentation/gitproto=
col-v2.adoc
> > index 5598c93e67c3..abc42efcc774 100644
> > --- a/Documentation/gitprotocol-v2.adoc
> > +++ b/Documentation/gitprotocol-v2.adoc
> > @@ -54,7 +54,7 @@ In general a client can request to speak protocol v2 =
by sending
> >  `version=3D2` through the respective side-channel for the transport be=
ing
> >  used which inevitably sets `GIT_PROTOCOL`.  More information can be
> >  found in linkgit:gitprotocol-pack[5] and linkgit:gitprotocol-http[5], =
as well as the
> > -`GIT_PROTOCOL` definition in `git.txt`. In all cases the
> > +`GIT_PROTOCOL` definition in `git.adoc`. In all cases the
> >  response from the server is the capability advertisement.
>
> ... shouldn't this reference be also linkgit:git[1] just like the
> two references on the previous line?  Given that such a correction
> needs to be made on exactly the same line, I wonder if we want to do
> the change we see here, which stops at an in-between state, rather
> than going to the end game of using linkgit: properly.

Yeah, I should have looked a bit further and done that. I see you did
it for me. Thanks!

> > diff --git a/Documentation/technical/build-systems.adoc b/Documentation=
/technical/build-systems.adoc
> > index d9dafb407c40..1ae2a5292f3b 100644
> > --- a/Documentation/technical/build-systems.adoc
> > +++ b/Documentation/technical/build-systems.adoc
> > @@ -32,7 +32,7 @@ that generally have somebody running test pipelines a=
gainst regularly:
> >    - OpenBSD
> >
> >  The platforms which must be supported by the tool should be aligned wi=
th our
> > -[platform support policy](platform-support.txt).
> > +xref:platform-support.adoc[platform support policy].
>
> ... this one did not stop at "txt" -> "adoc" replacement, but
> attempts to make a proper link.
>
>     Side note: I do not think we are using an explicit xref: syntax
>     in our documentation anywhere; have you checked how this gets
>     rendered?
>

Turns out I was too lazy and blindly replaced what I recognized as a
Markdown link to the appropriate AsciiDoc link. However, the
inter-document xref functionality is unavailable in the legacy
AsciiDoc processor (`asciidoc`) and is disabled in Asciidoctor by our
use of `--atribute compat-mode`. I'm not sure what the right course of
action is now. The old link was wrong, but the suggested change only
starts working when we drop support for `asciidoc` :-(.

Sorry to introduce more worries than fixing.
