Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB6622157E
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 06:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761027988; cv=none; b=ePD9F2sfkxEKnaKnM//l4V9OTzXF3tR0m4+YUMq//dICtmBmnIkr/oFrDaZFdmgFkbhnUjcV+8xUL9hfMnqZGLEZjAA3+T7h1rZ5eYm4Qh0z/rZMC9D3Qn44wh+MmE4MKt6aPzQkoA+Mm8NnGqaQ3LqAymW+1e3van6jKRpMPmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761027988; c=relaxed/simple;
	bh=wlhs8AgRWQOP9F2lu2txZ+8p/u1AAWg65vfnntv4v84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ba1vYr/OiWaaVeW2SOZhaEQDcz6yMD4jG3DhALDtEmJ7RFAEAUF8JovgIxKOL2jAXRIaMsM2FGWp9zcDNWjrlId69l5VYJHM7f2wcclfXXcFgKOqvrOBXbzmahQw0UbjhEgiMqOyMRek0cJHGilLa9Fm8Lz5UsBaZeQj+5fnPpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=RmvtyTuh; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="RmvtyTuh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761027982; x=1761632782; i=tboegi@web.de;
	bh=/4/JxaNIDHZ2vhq9l9K430P1zfnrVcGzvhUaUs/IcZ8=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=RmvtyTuh3lmxQ2aJGr+wwb6hHKFrqZPw+IlChNYOIfBphCyA4Ceu6DwhOx7zcB9k
	 JOd9XWEgtoHyEhR9eQIgu/EliQGJSE+sJrzgMgfPtECy6uPPs8mT9WGSsvELE2NVO
	 THRZKUMixY08CaWCvUaXvXxvgwYSNIqE+SHGZy/BhnAz3MOBN6JeuHuCx9i8OwodD
	 UQXQri9omHo8HPfMTZsfzbHrgYQzAaFbcV7rCnv+TiHjE/GKgmjX8h0g+VwJRv2Ek
	 mKTDoHV911huOzJc6zXm7vFkrbRiBKXSUcSCEbBePpmwsEDFT8n3dKxj8yhOnVYMY
	 572ggbTKSwcngbW85Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([81.231.143.213]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MwR4R-1uJ7cp2G2P-0105rt; Tue, 21
 Oct 2025 08:26:22 +0200
Date: Tue, 21 Oct 2025 08:26:21 +0200
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Koji Nakamaru via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Koji Nakamaru <koji.nakamaru@gree.net>
Subject: Re: [PATCH] macOS: queue for munmap operations
Message-ID: <20251021062621.GA370@tb-raspi4>
References: <pull.1993.git.1760999702581.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1993.git.1760999702581.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:G4jO5ydk31L7kwbTzqSmjrWNBSfESZUaCfuMQYFxHmCPXPYHMlQ
 TvSbLkYiSd1rTRzUf9HuUeBaYK17jlordKI2bxtWFMM8nzGjR06R/XQQqMPFvJwidOPzpzO
 /dQFVWqa+GWMvP4pAebjDYnQEHNSr/Rz1si2Fotb0zUworTqJJnG/HxdAzI3DwZkoTsL+Yc
 L3VzXy9znNKK+QtN32onw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ruMKmrHFte0=;jeVSozoVaaQC3AJEhlr0bS1r3BB
 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
Content-Transfer-Encoding: quoted-printable

Some comments inline, all up to improvements

On Mon, Oct 20, 2025 at 10:35:02PM +0000, Koji Nakamaru via GitGitGadget w=
rote:
> From: Koji Nakamaru <koji.nakamaru@gree.net>
>=20
> Executing many mmap/munmap calls alternately can cause a huge load on
> macOS. In order to reduce it, we should temporarily store munmap
> operations in a queue and process them all at once when the queue is
> filled. When the program terminates, we can discard any remaining munmap
> operations as corresponding mmaped regions are automatically reclaimed.
>=20
> Add a queue for munmap operations to perform them all at once.
>=20

Suggestions for rewording:
In order to reduce the peak load store all munmap operations in a queue.
Process them all at once (and more efficient) when the queue is filled.
The queue may be ignored when the git process terminates. The operating
system will do all munmap() when the process exits.

> Here are some example timings. On the Linux kernel repository that
> requires about 1700 mmap/munmap calls:
>=20
>   time git ls-tree -r -l --full-tree 211ddde > /dev/null
>=20
>   Before:
>         real    0m2.083s
>         user    0m0.201s
>         sys     0m1.873s
>=20
>   After:
>         real    0m0.243s
>         user    0m0.179s
>         sys     0m0.052s
>=20
> On a private repository that requires about 943000 mmap/munmap calls:
>=20
>   time git ls-tree -r -l --full-tree xxxxxxx > /dev/null
>=20
>   Before:
>         real    27m15.138s
>         user    0m5.084s
>         sys     27m9.636s
>=20
>   After:
>         real    0m24.209s
>         user    0m3.055s
>         sys     0m21.123s
>=20
> Signed-off-by: Koji Nakamaru <koji.nakamaru@gree.net>
> ---
>     macOS: queue for munmap operations
>=20
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1993%2=
FKojiNakamaru%2Ffeature%2Fosx-queued-munmap-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1993/Koji=
Nakamaru/feature/osx-queued-munmap-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1993
>=20
>  Makefile                            |  1 +
>  compat/osxmmap.c                    | 49 +++++++++++++++++++++++++++++
>  compat/posix.h                      |  7 +++++
>  contrib/buildsystems/CMakeLists.txt |  4 +++
>  meson.build                         |  2 ++
>  5 files changed, 63 insertions(+)
>  create mode 100644 compat/osxmmap.c
>=20
> diff --git a/Makefile b/Makefile
> index f79c905bdc..058bc83753 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1654,6 +1654,7 @@ ifeq ($(uname_S),Darwin)
>  		COMPAT_CFLAGS +=3D -DAPPLE_COMMON_CRYPTO
>          endif
>  	PTHREAD_LIBS =3D
> +	COMPAT_OBJS +=3D compat/osxmmap.o
>  endif
> =20
>  ifdef NO_LIBGEN_H
> diff --git a/compat/osxmmap.c b/compat/osxmmap.c
> new file mode 100644
> index 0000000000..5f9cf633ca
> --- /dev/null
> +++ b/compat/osxmmap.c
> @@ -0,0 +1,49 @@
> +#include <pthread.h>
> +#include "../git-compat-util.h"
> +/* We need original mmap/munmap here. */
> +#undef mmap
> +#undef munmap
> +
> +/*
> + * OSX doesn't have any specific setting like Linux's vm.max_map_count,
> + * so COUNT_MAX can be any large number. We here set it to the default
> + * value of Linux's vm.max_map_count.
> + */
> +#define COUNT_MAX (65530)

Why the parantheses ?
And would a less generic name be better, like
MAX_UNMAP_COUNT

> +
> +struct munmap_queue {
> +	void *start;
> +	size_t length;
> +};
> +
> +void *git_mmap(void *start, size_t length, int prot, int flags, int fd,=
 off_t offset)
> +{
> +	/*
> +	 * We can simply discard munmap operations in the queue by
> +	 * restricting mmap arguments.
> +	 */
Should I read this as
The munmap queue is only ment to defere read-only mappings.
And that is what Git does at the moment.


> +	if (start !=3D NULL || flags !=3D MAP_PRIVATE || prot !=3D PROT_READ)
> +		die("invalid usage of mmap");
> +	return mmap(start, length, prot, flags, fd, offset);
> +}
> +
> +int git_munmap(void *start, size_t length)
> +{
> +	static pthread_mutex_t mutex;
> +	static struct munmap_queue *queue;
> +	static int count;
> +	int i;
> +
> +	pthread_mutex_lock(&mutex);
> +	if (!queue)
> +		queue =3D xmalloc(COUNT_MAX * sizeof(struct munmap_queue));
> +	queue[count].start =3D start;
> +	queue[count].length =3D length;
> +	if (++count =3D=3D COUNT_MAX) {
> +		for (i =3D 0; i < COUNT_MAX; i++)
> +			munmap(queue[i].start, queue[i].length);
> +		count =3D 0;
> +	}
> +	pthread_mutex_unlock(&mutex);
> +	return 0;
> +}
> diff --git a/compat/posix.h b/compat/posix.h
> index 067a00f33b..3fa1218289 100644
> --- a/compat/posix.h
> +++ b/compat/posix.h
> @@ -278,6 +278,13 @@ int git_munmap(void *start, size_t length);
> =20
>  #include <sys/mman.h>
> =20
> +#if defined(__APPLE__)
I think it would be better to have a global Makefile knob here.
Which
a) allows to take out this patch once the MacOs kernel is improved
b) allows to hook in this code for other OS
Something like DEFER_MUNMAPS - better suggestions welcome
> +#define mmap git_mmap
> +#define munmap git_munmap
> +void *git_mmap(void *start, size_t length, int prot, int flags, int fd,=
 off_t offset);
> +int git_munmap(void *start, size_t length);
> +#endif
> +
>  #endif /* NO_MMAP || USE_WIN32_MMAP */
> =20
>  #ifndef MAP_FAILED
> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/=
CMakeLists.txt
> index edb0fc04ad..5c08f2fe5c 100644
> --- a/contrib/buildsystems/CMakeLists.txt
> +++ b/contrib/buildsystems/CMakeLists.txt
> @@ -271,6 +271,10 @@ if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
>  		compat/strdup.c)
>  	set(NO_UNIX_SOCKETS 1)
> =20
> +elseif(CMAKE_SYSTEM_NAME STREQUAL "Darwin")
> +	list(APPEND compat_SOURCES
> +		compat/osxmmap.c)
> +
>  elseif(CMAKE_SYSTEM_NAME STREQUAL "Linux")
>  	add_compile_definitions(PROCFS_EXECUTABLE_PATH=3D"/proc/self/exe" HAVE=
_DEV_TTY )
>  	list(APPEND compat_SOURCES unix-socket.c unix-stream-server.c compat/l=
inux/procinfo.c)
> diff --git a/meson.build b/meson.build
> index cee9424475..b9b6e731b1 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1275,6 +1275,8 @@ elif host_machine.system() =3D=3D 'windows'
>    else
>      libgit_sources +=3D 'compat/mingw.c'
>    endif
> +elif host_machine.system() =3D=3D 'darwin'
> +  libgit_sources +=3D 'compat/osxmmap.c'
>  endif
> =20
>  if host_machine.system() =3D=3D 'linux'
>=20
> base-commit: 4253630c6f07a4bdcc9aa62a50e26a4d466219d1
> --=20
> gitgitgadget
>=20
