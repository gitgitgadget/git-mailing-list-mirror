Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC389220F23
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 20:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751400201; cv=none; b=BP+k0CdbkBnwFTyPiVJL4LLC4lGrC13fFjtbAJxQhCsMotep3BfzQsSYyeix8WjQ8oZnEQTnyyobKEHoFcq9rM5WOGye4Wqtg/yiBDkF4NUu0Nq3PQBlaUVyl0z2l++4NCvkdvxWo6bBvBOX6KKDBi5Srt0SkakTeG2PyTnGvvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751400201; c=relaxed/simple;
	bh=IgM/SMa1rpM9RxAxIugDYhh9Qoeqx9ndTX23H2acKbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C1uIjiSsQ5oE9E2VleBzP8LLUwIZcA4nLqHW4469jjD0YNrJzT70+xqcnmZZlpFijgqZwUfHR1CbuLk22AItl4/ih2+OjCYoG7sP/M4h7Kx9Bc3J3iloV60g8Xbct5DatV0SsfxBmBKf7EYamj5Ax4wCo6zvmvB0UbsBCiAEgaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7d21526eff6so50338085a.1
        for <git@vger.kernel.org>; Tue, 01 Jul 2025 13:03:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751400199; x=1752004999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aillcs7vtTuR97PT8dOqxOJURjTo1lMBtXhwRftTqHA=;
        b=H3/3thu2FKS68+isQ5Ynv7Lm0GJ54X1JeqK8sRaMmZvbq9Yw/gysRQP9wyzoKQn2yi
         fK4J00Ju+sQIria9WPbGuGkIEKrOdDDmDpBLLDVL8J3mGbhGmprcfF3eJfCURxNAreGn
         dJxD0xHNkJtQfM1k0m6zmaLfxyiriZpU2py8l57Heo9HfaEtqb7Kg8g/f/YWCJbR3K+3
         GHZhTlMAXxOPs1QeY+vEydinldM8O4SihIJrsnQKZAc3dGJ4LncsIcrKUt6+junQ0oEW
         MDgxNX1bkJPEF3maMuKWwYiwaRuIi69g+ppfVawrkJqTxt0Nlu/l7aTw9fIZYXxNEoyC
         +vDA==
X-Gm-Message-State: AOJu0YwXuqw8CjylRhjuR7qORfN/pVNx7yb4zs+YYg4JkfNGpZdo6fj7
	zcgymQDVWJqH87pbnFBND/H9KZxOSJYEwWQITjTNTBfiGN1wdtEsjQk9jZSodNeyMgliVDOymZi
	MG/qJtv0mPyqiwE7YXnBhIB+FWAdW/B4SFa61
X-Gm-Gg: ASbGncusKh/PoDc9lWfl9jOgPWFS2Wf0JKAtIM5u/NKIHVGzINJd9xC6QRXYWd6pX9h
	sIlw1/U8Nrfye89yCy5yIDA1PpQSlpMQJNB4bLT2IleE1UFeN2jNS1w9uyMrNiZe4a3Y5nygGmA
	dZ0yr3PRSvYiYsrpYOktGZ2Ppl3OkAGD+hwZpDnU/AwFBd8UIXGKUFkkpTrLRZX3G/llRHIXmD4
	A==
X-Google-Smtp-Source: AGHT+IG2K1pzCBZsJSz65LAOg382yYyg/5xX+/AGQBTTt/Mrz+F2oA5etnvpdWrB/+N61nOjVvpXQYdYnvy67afa++M=
X-Received: by 2002:a05:6214:4505:b0:6fb:1fc:7889 with SMTP id
 6a1803df08f44-7010bbc62bemr24757476d6.11.1751400198606; Tue, 01 Jul 2025
 13:03:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f32292e0-4c99-47d0-8eac-21dbc5aca302@FreeBSD.org> <9dce7213-0b8c-4636-ab37-4c26081aedf4@FreeBSD.org>
In-Reply-To: <9dce7213-0b8c-4636-ab37-4c26081aedf4@FreeBSD.org>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 1 Jul 2025 16:03:07 -0400
X-Gm-Features: Ac12FXxg5oGicGlb3PT-DVstLjG3WOeUsgAQndUaxp0nK2of_p7dNSj9HqJKduU
Message-ID: <CAPig+cT6UNroSf=_BnDMa2HZutpKkqy5xUXwD4vEmhORag9x0w@mail.gmail.com>
Subject: Re: Bug: build is broken on FreeBSD if libsysinfo is installed
To: Renato Botelho <garga@freebsd.org>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 12:09=E2=80=AFPM Renato Botelho <garga@freebsd.org> =
wrote:
> On 23/06/25 11:09, Renato Botelho wrote:
> > FreeBSD has a libsysinfo package which contains GNU libc's sysinfo port=
.
> >   Some users reported git 2.50.0 was failing to build when this port is
> > installed and it happened because configure script detected libsysinfo
> > but -lsysinfo was not added to LDFLAGS, ending up with following error:
> >
> > scalar.o common-main.o libgit.a xdiff/lib.a reftable/libreftable.a
> > libgit.a -lz -pthread
> > ld: error: undefined symbol: sysinfo
> >
> > This patch [1] was added to git port adding a user option to enable/
> > disable libsysinfo dependency and fix LDFLAGS when it's enabled.
> >
> > I'm not sure about what is best approach for git project in this case.
> >
> > [1] https://github.com/freebsd/freebsd-ports/blob/main/devel/git/files/
> > patch-configure.ac
>
> If someone let me know what would be the desired approach here I can
> work on a patch.  Would you like to make that option conditional as the
> patch did?  Or detect if OS is FreeBSD and do something different?

It depends upon how much effort you want to put into the patch. If the
primary goal is to just get FreeBSD building again, then the least
amount of work probably would be to use AC_LINK_IFELSE (with whatever
tweaking that requires) instead of AC_COMPILE_IFELSE in configure.ac
for the sysinfo check. With that change, HAVE_SYSINFO would not get
defined if the link fails due to the missing `-lsysinfo`.

If you do want sysinfo functionality to be used by Git on FreeBSD,
then probably the most correct approach would be as follows:

(1) Add a NEEDS_LIBSYSINFO to Makefile (patterned after existing
"NEEDS_" definitions in that file). This would involve documenting it
alongside HAVE_SYSINFO, and adding something along the lines of:

    ifdef NEEDS_LIBSYSINFO
        EXTLIBS +=3D -lsysinfo
    endif

(2) For people who build the project directly without utilizing the
"configure" script, optionally update the FreeBSD section of
config.make.uname to define HAVE_SYSINFO and NEEDS_LIBSYSINFO as
appropriate. Those definitions probably ought to be conditional based
upon some criteria that you determine so that compilation doesn't
break on older versions of FreeBSD (if they were lacking the sysinfo()
call or "libsysinfo").

(3) Update configure.ac to check whether `-lsysinfo` is needed, and
define NEEDS_LIBSYSINFO appropriately. This may mean employing both
AC_COMPILE_IFELSE and AC_LINK_IFELSE for determining HAVE_SYSINFO and
NEEDS_LIBSYSINFO, respectively, though there might be a cleaner way to
do so (I haven't put much thought into it).
