Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6564F50242
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 15:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJF1jo6+"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dbeda700015so4499397276.2
        for <git@vger.kernel.org>; Thu, 11 Jan 2024 07:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704987739; x=1705592539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O2tQsSyzmRkSzrSimniXFLuvyG6QXb2Rcbx0OgwaCWQ=;
        b=AJF1jo6+ASEMgKhwTPmy2oFB/seDo8TG4VOR2jlflbMeIJG9papE50fWttaVhL8f5j
         N60gvHJEs/mjnM6p/nXvvF0VuUKkxpXjqbrZLH9mbtiML5TWQankCUmUfZvc5KENbWQG
         N4Mwba8JShNYBIZbirrLUowBMijIJP4YPCynxDuEZhWsc4Tq1WFB6V8TWe1TNTPhp3Aa
         6+gN8LcbN78GiVGIWPyq3cOqhXLkB/FF2M/Yfc2bQrjJIdcQob+Sg1mLcSABFrsYDs44
         O1fl48xJ82/4J+q5h1VF//4yhibpDF3Tk8xTRlbhSLFbS8QUamkrSIKNj/wdlLiicCiY
         6k2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704987739; x=1705592539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O2tQsSyzmRkSzrSimniXFLuvyG6QXb2Rcbx0OgwaCWQ=;
        b=oBQ1f1eb8Q6T9gd9IuCLwhHGCMo0SYlfseNWqBHAC3qDG1efoL3iLomRf5aiqWjTnh
         x91XgMAcGs1kPRWvnm4uhhz0XxC330wFCnTzh8/mDuc1nykL1dr4eDF2GPsIrOYLJIAC
         BGhZh3LNWNUP1ewWTs6UXABTt/clWynhFXWhm6PIUmOh41UaV6v/GdmyDpa0FZ63+Fsj
         ZQGAxgLVd39wbwoGP16dcjs4M//4/KkH7FWC9+twyzokCmHs6UmBDYNgyZonK0F5dKXb
         njsldN4LMvBe8L8rlyzYXKbZZYFi8kwj1g1HphXM6jXY5LnM4dGTAH6LMCQ10vggSc24
         O9Ww==
X-Gm-Message-State: AOJu0YwOh3Y01TX6P4R/t/pd3F+mIih7w6YPcAXBCiBH1S0WdYjA2r8Z
	g0ofdqr4Jr0bA+uQum3iBuUU1yjs9UD+fpcEioU/bl0hCvFgeVxg
X-Google-Smtp-Source: AGHT+IHvDEbxSCcDQyPiKxpkxscrzXCCUDEM5gZzIOM8uBG4TOTPKVdM3FihlQFrRg61R9qigXUCJvuusNi5cuB4KFw=
X-Received: by 2002:a5b:907:0:b0:dbd:4594:51a2 with SMTP id
 a7-20020a5b0907000000b00dbd459451a2mr1176253ybq.23.1704987739310; Thu, 11 Jan
 2024 07:42:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANAnif95ux=vCNCKbVw0q_vYamQRkbFqSa9_-u6xRvK6r+2a+Q@mail.gmail.com>
 <CAP8UFD30h7D7D42Eiq3sk97v_ef8hi=K1qdy2wRczQ18JM++LA@mail.gmail.com>
 <CANAnif90Bqp2pWCn_71t-Fss6wspo+==vMdYsX+Wt5m=4Ocpng@mail.gmail.com>
 <CAP8UFD0ELy2WegVYdxi_O5UpHS4MyOPp4tuAQK+XvvNmABc2ZA@mail.gmail.com>
 <CAP8UFD3e=Zv2wkx5tswCz05Vwn3vD68Vw-TD6SoENWK+norYsw@mail.gmail.com>
 <CANAnif-hWovPnRmSy0pnEJnA274vwiSAkRexstGQdQJ4u-5+pw@mail.gmail.com> <CAP8UFD0YicYXrYgHdvcrWps+cMa=Dp9Ob7SfYLMXQKLp7-B+7w@mail.gmail.com>
In-Reply-To: <CAP8UFD0YicYXrYgHdvcrWps+cMa=Dp9Ob7SfYLMXQKLp7-B+7w@mail.gmail.com>
From: Sergius Nyah <sergiusnyah@gmail.com>
Date: Thu, 11 Jan 2024 16:42:08 +0100
Message-ID: <CANAnif-OganZLi0Cu_uq=nveC+u5n14c=o_DQHT-wFOqQ9Vs0Q@mail.gmail.com>
Subject: Re: [GSOC][RFC] Add more builtin patterns for userdiff, as Mircroproject.
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, newren@gmail.com, l.s.r@web.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 4:11=E2=80=AFPM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Thu, Jan 11, 2024 at 3:23=E2=80=AFPM Sergius Nyah <sergiusnyah@gmail.c=
om> wrote:
> >
> > ---------- Forwarded message ---------
> > From: Christian Couder <christian.couder@gmail.com>
> > Date: Thu, Jan 11, 2024 at 11:51=E2=80=AFAM
> > Subject: Re: [GSOC][RFC] Add more builtin patterns for userdiff, as
> > Mircroproject.
> > To: Sergius Nyah <sergiusnyah@gmail.com>
> >
> >
> > On Thu, Jan 11, 2024 at 11:48=E2=80=AFAM Christian Couder
> > <christian.couder@gmail.com> wrote:
> > >
> > > On Wed, Jan 10, 2024 at 9:10=E2=80=AFPM Sergius Nyah <sergiusnyah@gma=
il.com> wrote:
> >
> > > > > Okay then. I will add support for shell, as it was primarily sugg=
ested
> > > > > in the idea itself.
> > >
> > > As Bash is a shell and is already supported, I am not sure which kind
> > > of shell you want to support. There are other shells or kinds of shel=
l
> > > with different syntax that might be worth supporting, but then you
> > > might want to tell us which shell or which new kind of shell.
> > >
> > > Thanks!
> >
> > I've definitely learned one more thing. Thank you!
> > Also, after taking another keen look at the Patterns defined in userdif=
f.c,
> > In accordance with what you've said, I realized that Kotlin isn't
> > supported yet.
>
> It is actually already supported too:
>
> $ grep -i -n kotlin userdiff.c
> 186:PATTERNS("kotlin",
>
> To help you a bit, you can get the list of already supported languages us=
ing:
>
> $ perl -ne 'print "$1\n" if m/PATTERNS\(\"(\w+)\"/ or
> m/IPATTERN\(\"(\w+)\"/' <userdiff.c

Thank you for these. $ perl -ne 'print "$1\n" if
m/IPATTERN\(\"(\w+)\"/' userdiff.c works too.

> ada
> bash
> bibtex
> cpp
> csharp
> css
> dts
> elixir
> fortran
> fountain
> golang
> html
> java
> kotlin
> markdown
> matlab
> objc
> pascal
> perl
> php
> python
> ruby
> rust
> scheme
> tex

Great! JavaScript, despite its widespread use, isn't implemented, so I
will take it.
Thank you!
