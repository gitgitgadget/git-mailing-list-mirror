Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCB221ADB5
	for <git@vger.kernel.org>; Fri,  4 Jul 2025 23:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751673009; cv=none; b=XnNmXJJV1FlInligwXEeMj6eM0iTbT9Pi+26e/RDarhkPB9XfeWH/SGbcEvnW2Halcf8CvdilFedGKGbc2hZiTSfylYj7YoM5BDdvOXPS4GwCqVsNM8Wtu5zObst52eTsyzGsTt2VGBu0i48XoYuKKUlLdLk60Sw5gEhgOguc0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751673009; c=relaxed/simple;
	bh=6QFnuaIIiZwb0RxQFP7MG7Ss0Eq59uemKR45P0NXJ4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b+lRPZr5fvPZdOq1YoFUevBerJmIJz7pfEojlKCE+ic2a6ssYdiE8w5z898AGWiqZvUae1/GhiUg+4k/DZqJTZXanfqhHgcAsYn7yXY+qRJJvzMiMeUixNQ6utDk8xA18IF1PQ3zg0fqsnxmtRAkAvmh4bjN+ApoPBJM0byU4Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4a76f250566so1786921cf.0
        for <git@vger.kernel.org>; Fri, 04 Jul 2025 16:50:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751673006; x=1752277806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DIevbbeXytpeLYgfh0tI2E6xZsPysEmk2zmB56tYias=;
        b=d8iijN2hNO6mDol43xugKH+9P+d+ryr1gFp1oZF3ztMdgPcStC6XAx0wgKJRaMssx1
         FW5ML+6dHPRb+bDwvEyy2CQOygorKo8kVwXTK+RQ7tllsgdsW1ZaXBRAyCXeLJVUtWKT
         7p8K7jja10Ua7Z52o4MiCf83LttjPNZVO6IYb4qhqiZ9j3hbsZqHt9KrUtL5rKVW7FBY
         CQOsZ10WxJv925q2HXRqbXbEv+2EDgcrPljmNC1MJI5tyRS91NkN7mEZZ57dKsB0mTTK
         6C+M7J/GahqyJg0HOAHnfVb1tNw5fKrk3hW7+l00NIktcR4VGCgFfrWmKDYE897Xsoag
         02nA==
X-Gm-Message-State: AOJu0Yz2bV8ZczXEAjKDE0SueUQBTSe00gQtHoRmuptz/eah1F5pRSmj
	3H0FNLHVS76uIALEJ2Z0ARBahsC8eb8pNLyQ09mE4EDuqjbbb8yyJo1g2ue3DL4iFSj+mIqGX7X
	P4CiXZwVwMv4J0twRRZrTQjqhCJNlnIg=
X-Gm-Gg: ASbGncsP2iE4PaGX4t0j4U8sMCw7TlCIDP3/BQf9wD7acaS4w1C4gITk6izqFn78VQh
	tpTF9W1BT41poHjO1uBqR6cziCEoE9gQdii4kT1t2v0kKncUN2yyoS4MA/rFtiKafK5RMTE4aPa
	HvwX+wmgqJzGRC/e+AMWYlqhQfxeJCoUueJaB1YMbrXw==
X-Google-Smtp-Source: AGHT+IHXb+xIJvtrrKpWZwiaGZlRM8p0XuvpEXnFykiRbjjxwZqkGRe1EHfXnt7rFUk1NDAtUgmpMcNCN96AuGz9Zaw=
X-Received: by 2002:a05:6214:f65:b0:702:c2b5:67e9 with SMTP id
 6a1803df08f44-702c6a5ea53mr22670666d6.0.1751673005909; Fri, 04 Jul 2025
 16:50:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e6a80163-47ef-436b-98a6-2ac39c477080@ramsayjones.plus.com>
In-Reply-To: <e6a80163-47ef-436b-98a6-2ac39c477080@ramsayjones.plus.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 4 Jul 2025 19:49:53 -0400
X-Gm-Features: Ac12FXz5hgwxLAw0XqVLPkNat4U_oX5jAX-E6hBjUpibOyOLJ1Po-W0z0MTbBK8
Message-ID: <CAPig+cTybBgkwFEsMVNNu2o1w9T5qnhau4chvGU2opEPJO78zg@mail.gmail.com>
Subject: Re: [PATCH] build: fix FreeBSD build when sysinfo compat library installed
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: GIT Mailing-list <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>, 
	Patrick Steinhardt <ps@pks.im>, Renato Botelho <garga@freebsd.org>, Eli Schwartz <eschwartz@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 4, 2025 at 6:26=E2=80=AFPM Ramsay Jones <ramsay@ramsayjones.plu=
s.com> wrote:
> Commit 50dec7c566 ("config.mak.uname: add sysinfo() configuration for
> cygwin", 2025-04-17) and later commit 187ce0222f ("configure.ac: upgrade
> to a compilation check for sysinfo", 2025-05-19) added a 'sysinfo()'
> check to the autoconf build.
>
> The FreeBSD system has an optional sysinfo compatibility library, used
> to assist in porting software, which causes the build to fail when it
> is installed. The reason for the failure is the lack of '-lsysinfo'
> during the linking step.
>
> Several solutions were considered:
>
>   - add an 'linking' check to configure.ac in order to determine the

s/an/a/

(not worth a reroll)

>     need to link a separate library (-lsysinfo). (This would require
>     a similar change to meson.build).
>
>   - change the order of the preprocessor conditionals in the total_ram()
>     function in 'builtin/gc.c', so that the *BSD sysctl() function
>     (in the HAVE_BSD_SYSCTL block) takes priority over the sysinfo()
>     function (in the HAVE_SYSINFO block).
>
>   - suppress the setting of HAVE_SYSINFO when HAVE_BSD_SYSCTL has been
>     defined (in both configure.ac and meson.build).
>
> The first solution above, while simple, adds unnecessary code (the
> sysinfo compat function is likely implemented using sysctl() anyway)
> when git is happy to use sysctl() on *BSD systems.
>
> The second solution would only be required by the autoconf and meson
> build systems, the Makefile already sets the build variables to the
> required values (since they are not 'auto-detected').
>
> Here we opt for the final solution above, since it only requires that
> we prioritise the 'auto-detected' build variables in the autoconf and
> meson builds.

The final solution is almost certainly good enough (and is definitely
simple), although the second solution has the benefit that it "fixes"
the problem once and for all even if someone defines both
HAVE_BSD_SYSCTL and HAVE_SYSINFO (say, in config.mak), assuming I'm
understanding correctly.

> In order to fix the FreeBSD build, move the sysinfo() check after the
> determination of the HAVE_BSD_SYSCTL build variable, suppressing the
> setting of HAVE_SYSINFO if HAVE_BSD_SYSCTL is defined. Apply this logic
> to both the configure.ac and meson.build file.

Nicely described. I wasn't really following along with the discussion,
but this commit message summarizes the situation well, so I can
understand the reason for the change and (I hope) the implications.

> Tested-by: Renato Botelho <garga@FreeBSD.org>
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
