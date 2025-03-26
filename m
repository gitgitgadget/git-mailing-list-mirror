Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A631F95C
	for <git@vger.kernel.org>; Wed, 26 Mar 2025 16:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743008247; cv=none; b=Ow5T9uBpkXcAVnAyLl3/NcY8V4TKxk3/6t8a2rzHZIuTf4Z0BoKIn3oqsbqgrupmMNxaCfq8Je78pvZ/wTYSUil3r0Y8Xbf3yzdb2wwSqAb3VZOft7IXwCsOmCWUgKR0xt9ARaiRfpnO7+ACwFJYF8Ny6FZegB7P42/EjQ0tH2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743008247; c=relaxed/simple;
	bh=wSMao+hT5j/kvcS+ZVBD8E2tEENLDWJWsPj6/4eMbmo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Ud7D8ZEqlEYuQjwt+KNyd6ceqbq1bF+z3FVFE2wglolSVQrx3FSGgH0CCSAOleNN9TLNnG4LEMOpxjx3ZfgS24/6+aXS//u8+kTA1JZamSinY9PmL/Xi8a5DGIqVf8YIMfs7WW9lwmGmrLbKVSVCleJo3BDY2zs1A9QY+5oI/aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=ZTZIE1WL; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="ZTZIE1WL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1743008240; x=1743613040;
	i=johannes.schindelin@gmx.de;
	bh=ugPdPiadbcCkiaEvAXHbSYDwdXWrxIi0SIzqSNWtOpU=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ZTZIE1WLBI+3ws89FgBILcyZd3WH5VQk8fzFCm+a+47ar0JL7z3Bpp3VsdQLflhw
	 dN5BOGxSHoHttI3/3XybPFKuYm0oGkTZMSRyeRQFaA+OqjFAJzrX1Khv6oekiYdg3
	 OgABDpmuRLepYspcCRJRAQABCMyGw5CJp7IVjIxHe8Aho5OGn82P0jyewd9IoyZKi
	 hXXPxZRYN/6Aypiz3ZJPgliMA4f8hftQeARaTwf/Xx/YVsT1ar/JNKC+uJmBw5FLK
	 8bWBlosAH8fowT4BRZ8OwTFr/JbaW9zeVoscIpvEHgR87fUP7HNlbAHq/vIh69NXA
	 f89pUGB5UlTvCIw08w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.213.156]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MbivG-1tQ5Wg0dva-00pUGG; Wed, 26
 Mar 2025 17:57:20 +0100
Date: Wed, 26 Mar 2025 17:57:19 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: ps/reftable-sans-compat-util, was Re: What's cooking in git.git
 (Feb 2025, #09; Fri, 28)
In-Reply-To: <Z8bQsflIqzZd3AMs@pks.im>
Message-ID: <9cd879ed-5366-a7bf-f440-e35222a733d2@gmx.de>
References: <xmqq7c591sus.fsf@gitster.g> <Z8aeLc-xelujEjTE@pks.im> <0c808b85-d97c-ecd3-0b1d-fba546a1124b@gmx.de> <9cc294f6-03de-d88f-9734-510a23fc8991@gmx.de> <Z8bL0HUuQqj7LlTp@pks.im> <Z8bQsflIqzZd3AMs@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:81yY8foSNTjvTv6BD9qF/L9wU6K6JTkqhZyfMuUfNowgTRmP6Xf
 liObEDAjZcV9aNsmGpy8d/tJVSv4Az3N4aW92sQLIKRH2k9qsgrO1yw2BDEl6OpC8FLaebd
 0CBEPaaB/csktQ10akvjjFH/TbLULYA+V9s7hfXtbWb6ayH/keBh0lZerCalDrGNMvqUE7L
 7Le7cCktcaAzeDanjwnnQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GPNa9hNbzkw=;Xo2hUaQTfuCKfvTvk1dNi/klTax
 P6M0ZD1mhwYDgMmmvV01x+pv2TYbPKBBJ2SYvgg5pPrK3Tdvq7mUo2VPAq+gyh/wKhUMqZ2Wp
 GMROX87YYwmem8oQI2HZ9kvf2pTGLCxbJC3jyixQt2dG8PRhOkY5GM8XfCss+ognYRHztSxpw
 T7EYy1D/GlbIwAeC8vrxJY/1I81cYNpIc/mQN0a4zQngtTBGy+gfhRZKYMhCpBVF6cXrKEXne
 5ySgKPJjheexrsMhIRz5MsBo1fdOfQmng8s3IZzI/eRD1Z1MO+IjJLAHg9iKxB2+pl8aqwLMt
 E3SZvWC5AjKQOKh6V58zAW9yIlUaFl68yXetcKHQLFwUUgvU0ZTUra6Co0Rdz/L9Wgs1KS3kO
 shSlwsdXsaJOLSOyhwcZ+spQE6fgUWy9LPAffbDTTb+Anbu+78Z+QmlCsGji2L5b4lQh3Natq
 C+fMH6rW94MZbyF7LSvWJQw2Jgclmyw1oECDzhS9tNvQYLJPtfhIDtkXd1trY9kva++E/Mcie
 +46X2r8CrKEzc4c7yDweRfPHcL42FMTBieeBbnD3+Z12ve6QwfZCQokDkL7t8kZY4pc051xnT
 iuHZa5dWJ2IeBwHLDcm9BTQl43wck5AjGZtzgW7R11EA+jYeJ8hTm78FNgHejGcH2hEWTWynD
 OTTmkYZ3E1Kq/yma+E15TpZ6qpP7BMJHnhz7gPwDDoHesODxpjV2wY5Sc9USXqptW8tzNgHO4
 aB+r3P2V3aKJ3SQnEjd31enSIpIy2BH1HSWhM99uFH4VD187aN8qwAqaaHrFne+dZ1viY6Gup
 m7JC7MWJ2+kS+dhyjXfkjcgF7xBDEFSkI8t1Q5HeFoHcYTFNB6NcknxMmDam/Ei9Sy6PYgUB8
 HD0FjRL9qKkakCDY1lZrTk1of89IT+6IVHsTVMpRmUkwA6IWGMCDX6giMkLtVIYD8hbrUF+Jj
 l91lg+SrXXi7hXMshOgqChDzuFfm6CBNtKDBwpfFH4zT1163XHrWAMY0leJKdi0dVR5q6WPzB
 csunz8kIK/oVmyoNr7zZO+kCtPA1aBVPeUw2BR4h5puC2LAm6SqENTvG+6t0qRF49i66RyWc/
 p5OCLLAxFJ7WQA1Yyspiqw91saHoeVCrhHZo+xWxNIB8pyZ11slkVIXVzmRYOr4/shyGqC+um
 e8f++7w+ADIIT1FBKdmuCNXcU2j7XhintsjmqztZxRKs+vQTk6isMdVMMWZX20duWENsj0Q+u
 01975HoF4y/jP1Bh6OqKc7Co56iAoKCB1XwLiNds7KPpKjvSnTb6vWDa8uDpeEs2CKSRfX2gd
 3MLl4/tA9oS9i1Mban7JXYhovwhcYQQEyXp8HY6wL8xlYCOORJlcPhuWFMuxdORQ0VMBaIa6e
 vKAvcxjTS5L/fE3yueofiTJVYfaG0pdWnxjTEI5wW+CE0vz/9hSkBrAzOk///uRIRpMlF8KYP
 50HfZAUTCS+2F0B+b9F1q6cvX635OdvoMe8KT65rZXV0JBH+C14hlaewgiQzwsybFEl/dQ5Fe
 Nzoay5xiszfxjCAB3XciLXwT5iTmCGhcIY6l6QMw
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Tue, 4 Mar 2025, Patrick Steinhardt wrote:

> On Tue, Mar 04, 2025 at 10:46:17AM +0100, Patrick Steinhardt wrote:
> > On Tue, Mar 04, 2025 at 08:40:13AM +0100, Johannes Schindelin wrote:
> > > On Tue, 4 Mar 2025, Johannes Schindelin wrote:
> > > > On Tue, 4 Mar 2025, Patrick Steinhardt wrote:
> > > > > Johannes, did the new version of this patch series make your lif=
e any
> > > > > easier? As far as I can see the conflicts in your "shears/seen" =
branch
> > > > > seem to have been fixed, and the failing pipeline seems to be du=
e to
> > > > > other issues. If so, we would be able to move ahead with this pa=
tch
> > > > > series and the dependent fix for Windows below.
> > > >
> > > > Honestly, I cannot say whether it made my life any easier. As you =
can see
> > > > from
> > > > https://github.com/git-for-windows/git/actions/workflows/main.yml?=
query=3Dbranch%3Ashears%2Fseen,
> > > > the `shears/seen` branch failed to update automatically since I up=
dated it
> > > > manually last Thursday. According to
> > > > https://github.com/git/git/activity?ref=3Dseen, there have been 5 =
updates
> > > > that were hence missed.
> > > >
> > > > I'll try to update the `shears/seen` branch now, but I'll time-box=
 it to
> > > > half an hour because I really planned on taking care of other issu=
es.
> > >
> > > It seems that there are the usual CMake-related breakages (not relat=
ed to
> > > ps/reftable-sans-compat-util, but to the introduction of the
> > > `CLAR_TEST_OBJS` or at least the `lib-oid` addition to that). I hope=
 that
> > > the tip commit of `shears/seen` that I just pushed addresses that, b=
ut I
> > > ran out of time to monitor this.
> > >
> > > And there are some pretty bad `exit code 127` problems in the unit t=
ests
> > > on Windows, see e.g.
> > > https://github.com/git-for-windows/git/actions/runs/13648196783/job/=
38151312208#step:5:213
> > > (but again, I ran out of the allotted time).
> >
> > Interesting. All of the errors relate to reftable stuff. Curiously,
> > those errors only seem to happen in the MinGW build, but not with the
> > Meson-based MSVC build. I can reproduce the issue in MinGW indeed, so
> > I'll investigate. Thanks for the hint!
>
> Okay, I found the issue: it's mismatching allocators. Git for Windows
> has support for the custom mimalloc allocator, and it's getting roped in
> by default in MinGW builds. And because the allocator is declared in
> "git-compat-util.h", the reftable library uses allocators from mscrt.dll=
,
> whereas the rest of the Git code base uses allocators from mimalloc.
> This causes us to sometimes free memory with a different allocator than
> we have allocated it with, and that causes a SIGTRAP.
>
> Below patch addresses the issue.
>
> Patrick
>
> diff --git a/compat/posix.h b/compat/posix.h
> index b484029f751..5ad3539d55b 100644
> --- a/compat/posix.h
> +++ b/compat/posix.h
> @@ -176,6 +176,16 @@ typedef unsigned long uintptr_t;
>  #define _ALL_SOURCE 1
>  #endif
>
> +#ifdef USE_MIMALLOC
> +#include "mimalloc.h"
> +#define malloc mi_malloc
> +#define calloc mi_calloc
> +#define realloc mi_realloc
> +#define free mi_free
> +#define strdup mi_strdup
> +#define strndup mi_strndup
> +#endif
> +
>  #ifdef MKDIR_WO_TRAILING_SLASH
>  #define mkdir(a,b) compat_mkdir_wo_trailing_slash((a),(b))
>  int compat_mkdir_wo_trailing_slash(const char*, mode_t);
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 8d2acf86670..a102a365592 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -226,16 +226,6 @@ static inline const char *precompose_string_if_need=
ed(const char *in)
>  # include <sys/sysinfo.h>
>  #endif
>
> -#ifdef USE_MIMALLOC
> -#include "mimalloc.h"
> -#define malloc mi_malloc
> -#define calloc mi_calloc
> -#define realloc mi_realloc
> -#define free mi_free
> -#define strdup mi_strdup
> -#define strndup mi_strndup
> -#endif
> -
>  #ifndef PATH_SEP
>  #define PATH_SEP ':'
>  #endif

I integrated this into Git for Windows' `shears/seen` branch (i.e. the
continuously-rebased Git for Windows patches on top of the `seen` branch),
and for the first time in weeks, it passed the CI build:
https://github.com/git-for-windows/git/actions/runs/14087673643

Thank you very much!
Johannes
