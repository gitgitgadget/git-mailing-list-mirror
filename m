Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC9037F72C
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 18:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786473114; cv=pass; b=DFGRj07B2aV6x0+1C/hVKRt7sso+xNXSsQJX6PHkFOvWwmJ2mHSeBfUnQ0SPKAw993/kuPp/2miV/G3jP/oOBxG7lySmYFAXeApmfwLFrihvFqFMMtWke0j4JtTqoyCA1ybyzmFrysu/Wgwf8HEnYQhFliq+mmmypNIUreEdrvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786473114; c=relaxed/simple;
	bh=zh/ujsbZNgX73W7pbKqzGoWzFWVdYzwbMN9FP2Yvcg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=phustQ2D1RdDyvcaFVvxNJ64fVSvoWG2pjc5DT0EgDc1aLq+MK4yskIsL3qS7KME/9NVrHMJ0pgSE2qQTrHGg8ySBGtxhF/XVexhqTvEm9FgUmpSL38ujukAkIRdr0N9/TbDGvDcnicr2KI6uRVcD5x9/slSFTgSkA8R82jQx8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drpetric.com; spf=pass smtp.mailfrom=petric.cc; dkim=pass (2048-bit key) header.d=drpetric.com header.i=@drpetric.com header.b=Inhapuc3; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drpetric.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=petric.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=drpetric.com header.i=@drpetric.com header.b="Inhapuc3"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c207cb16cf5so5799666b.1
        for <git@vger.kernel.org>; Tue, 11 Aug 2026 11:31:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786473109; cv=none;
        d=google.com; s=arc-20260327;
        b=S8APld2xAnbYlC0OZ1GhrySEkZx0E6KMmvFh/TInny2gl425a6JYN3eq9iO619l30L
         01JY1uvbCGJxVA2QuKWL9YOCE+MY/ep2d6DEBA6Im1pw9YHVkakP5GypgMkCfwYUaCqa
         NiAp/cYmT3dypU7ydIkcoZfw+vjCggHq9SnlRJXJcJMGpo3lA1whlaCXerM6g0AGU1Es
         LA/COSZMJA++miXOGmsqeYvpFA+ZfEyoMkiNSx36dai/iw0pbGkodWoRjBe+hWnq+gih
         XSkoPUX1gdBOTMX8S6eU4byKwnKzgmrHwjsnXFXeWSa1Zb3J8EI6Id67yM3ESGjZeJw3
         X9Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xPPm+rwyI2JM7OS7C7Ru4Umt1On2Ex529OcVZCd5s9I=;
        fh=jtt2CtSR7MJK67t7saIdUYjJ944I26qp/XI5+sgEAmM=;
        b=YlMjOhaQNlCoB2qWi7X7PelDFSjowmBzfl2szFfzPH+iO595PJpKE1x8nTVwrQPsXw
         1BCDmiZa8QNSMIc/RzyS8X/hhpA7htOYaRlZVUPFzMC3jKZJSydaw0o5YeMJ6zTYIZf2
         hVEXdl0jYo+p7qZ7nG3Fn+Lkh4rrxnSA/TsIishkounYisO7OBaWRDSa7g0HgKwrda8r
         9iIMILy7ORFZ6gBa7NlpHBUZROGgsEOBkxhlrQc0Uzxsk6Lr4NEQJKh0mh2mBEMpcElC
         qY72RTRbh2+nrN74nVQYa7afBhqJ+G+jHqkBVNe5IsLLlOOT3FjrkzcJV7w+/mTBHez6
         VLiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=drpetric.com; s=google; t=1786473109; x=1787077909; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xPPm+rwyI2JM7OS7C7Ru4Umt1On2Ex529OcVZCd5s9I=;
        b=Inhapuc3um4WKSTllpZGYyCjOfjezLyBDrACz2hKwaDCMCh+NPIvZxexnAKpI4PmgJ
         36ilGh36onid7whcIkxjJVs6tbK8L+b2JN1RTeSwIXcNiig+mSlBZ+6FCVwY+fxcqIf2
         zMx5EbSpLe6elIB2ldHMb3MhqSl2MkzfCj4fCeD78mRl/q8/Es+cn9WthV/p2X9UP68Q
         kgY0FHM8LUHKmObab8FlKLc64oV17++WEvlQcsTe54BbaSZtpfm3OBHqOv29TslFea2u
         KlRAEg/cMv7r8KJh0VTZIabL1aVtN4yfG6XVUo8/+WmOhdi4dkKQOjLDYfx5qTEebCsx
         moHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786473109; x=1787077909;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xPPm+rwyI2JM7OS7C7Ru4Umt1On2Ex529OcVZCd5s9I=;
        b=tLxX5mq5vDCFNOtfUK/f8ywfPyDgNgeCloFE2V4e0t8wc9HkaMmAUkCpy9MJXcOL/8
         kRQhPUp0J7vtRnOdQ4kxOqWtVi6NuxBSD+7/BzT77IDF90bDmSiz4xrfaPhPI21pmc3I
         /FkpX55y22N84lo5ExWNwRDAQ+5KvoHCP/hj6lgkD7rKrTiO/vXyPQufdhrb+NIKxWWb
         u1TJ2fAh5gM9kJJKGyVhuzN+e3K/z6exqD4czJllgEKUEC1CUpsyCcJkVtiXYTejnnc8
         EtlJbATElYZHS8UTtwAJnCCVSc9tGAdTi0eVK7Yf0lABlyYFD4/A4lw3hnCRw992mUgK
         XQug==
X-Gm-Message-State: AOJu0YxtT1Hk1xOtjldQkbW6RgX7rLv8t6rAs6HLLwkjnV+zYNCwJiA3
	uIdvrPoQ/i8go555e2NJARM0g1eOtj+xIc+F0teHx9bV/E7ddjkRnrewzFlbwGAUbdXg0djQWpZ
	RwwafaXpjw3+ZehJvcGnlF8OfukGNngUD2meWTPSVSQ==
X-Gm-Gg: AR+sD126GLgYg71ex/qNEqpt6xuXqcyeab2IKBc01iGHwwIaQGU3GlVA8P2oie39wX+
	eTD3crXAKOANperzvmQlHoXy3B78DXQoS981EVRhSGGWdQ8FAjzTCJGE3VX6IgVv7wL/vF1577B
	eD/rydVGWdiMdo9wE5ZnofRNXgZaxBo2zMt5gZxTDfEjfe1r/7ZFJ8Sc7RgYJThNz6wL7RjEJS3
	5h1UL3Meh6ESB/dKlf3jJyq8HaJZHLNK2+2ykY/MsPnLsHt/dUW/00hiYNQGUhuLKKcki6+zqlw
	s9fFRKHPR9xF1vm5PDE1UTFj58/BIxRqSiHNxQweqHdB9r+C/n3TWtTzWNm1gxDXQxbjBLR19GQ
	3QVecKcMzcqyodSDBWWsYyIczU6NZpTJ0RcklYNVGkCUpGbo9c3/9l2TwZ5qxPAzwrGuWyI4fMK
	QUW4FIo3rVx5nTbAKASwHmqXrv1cvwIoH6Myqv6mBd4icT/S1de+2BVsIPf0lquTH5mA9QJVB2r
	BI=
X-Received: by 2002:a17:906:9f91:b0:c16:101d:7afa with SMTP id
 a640c23a62f3a-c20e6258502mr286117866b.16.1786473108840; Tue, 11 Aug 2026
 11:31:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2380.git.git.1786460606222.gitgitgadget@gmail.com>
In-Reply-To: <pull.2380.git.git.1786460606222.gitgitgadget@gmail.com>
From: Vlad Petric <vlad@drpetric.com>
Date: Tue, 11 Aug 2026 14:31:37 -0400
X-Gm-Features: AUfX_mydjlaVOOvbKHl4qAjaBnwRvevK4YxSlBMZ98WtwjEH0mph6nzy_KXPobY
Message-ID: <CAJuH0wC1gSo-8nGnPGh2PqzbJuDBuY1pQS7RH0svwTfJWat4JA@mail.gmail.com>
Subject: Re: [PATCH] copy: prefer reflinks for file copies
To: Vlad Petric via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

You=E2=80=99re right that a successful hardlink is preferable for immutable
object files.

My motivation came from an actual local clone in my home dir (first
repo cloned normally, second repo cloned with --reference to the first
one).

Both repositories were on the same reflink-capable ZFS filesystem, but
the normal git clone produced neither hardlinked nor reflinked object
files, so the objects were copied byte-for-byte. With the FICLONE path
enabled, the same setup successfully reflinked the object files.

That is a useful fallback when Git=E2=80=99s hardlink path does not produce
links, but it does not justify trying reflink before a successful
hardlink. I revised the order to:

hardlink

reflink

byte-for-byte copy.

With --no-hardlinks, the order would remain reflink followed by
byte-for-byte copy.

(apologies if you received this multiple times already)


On Tue, Aug 11, 2026 at 11:03=E2=80=AFAM Vlad Petric via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Vlad Petric <vlad@drpetric.com>
>
> Git currently copies files byte-for-byte through copy_file(). Local
> clones separately try to hardlink object files before falling back to
> copying them.
>
> On filesystems that support copy-on-write cloning, a reflink can share
> the underlying storage without making the source and destination names
> refer to the same inode. This provides most of the space and I/O
> benefits of hardlinks while allowing either file to be replaced or
> modified independently.
>
> On Linux, try FICLONE before performing a byte-for-byte copy. Treat
> reflinking as an optimization: if the ioctl is unavailable or fails,
> remove the partial destination and use the existing copy path.
>
> For local clones, try a reflink before the existing hardlink path. The
> resulting order is therefore:
>
>   - reflink;
>   - hardlink, unless --no-hardlinks was requested;
>   - byte-for-byte copy.
>
> Preserve source timestamps when reflinking local object files. This
> matches the previous hardlink and copy behavior and is important for
> the expiry decisions made by prune and gc.
>
> Add an LD_PRELOAD-based test helper that can force FICLONE to succeed,
> report EOPNOTSUPP, or report another error. This exercises the reflink
> and fallback paths even when the test filesystem does not support
> reflinks. Cover generic file copying, local clones, --no-hardlinks,
> hardlink fallback, byte-copy fallback, object integrity, and timestamp
> preservation.
>
> The focused tests pass on three independent filesystems:
>
>   - ZFS at /home;
>   - ext4 at /tmp;
>   - tmpfs at /dev/shm.
>
> The complete Git test suite also passes on all three filesystems with
> no unexpected failures.
>
> Signed-off-by: Vlad Petric <vlad@drpetric.com>
> ---
>     copy: prefer reflinks for file copies
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-238=
0%2Fvladpetric%2Fvp%2Freflink-copy-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2380/v=
ladpetric/vp/reflink-copy-v1
> Pull-Request: https://github.com/git/git/pull/2380
>
>  Makefile                     |  1 +
>  builtin/clone.c              |  3 ++
>  copy.c                       | 96 +++++++++++++++++++++++++++++++-----
>  copy.h                       |  4 ++
>  t/helper/meson.build         |  1 +
>  t/helper/test-copy-file.c    | 13 +++++
>  t/helper/test-fake-reflink.c | 72 +++++++++++++++++++++++++++
>  t/helper/test-tool.c         |  1 +
>  t/helper/test-tool.h         |  1 +
>  t/meson.build                |  1 +
>  t/t0094-reflink.sh           | 89 +++++++++++++++++++++++++++++++++
>  t/t5605-clone-local.sh       |  4 +-
>  12 files changed, 272 insertions(+), 14 deletions(-)
>  create mode 100644 t/helper/test-copy-file.c
>  create mode 100644 t/helper/test-fake-reflink.c
>  create mode 100755 t/t0094-reflink.sh
>
> diff --git a/Makefile b/Makefile
> index fac3e8879c..802c0e9a37 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -814,6 +814,7 @@ TEST_BUILTINS_OBJS +=3D test-bundle-uri.o
>  TEST_BUILTINS_OBJS +=3D test-cache-tree.o
>  TEST_BUILTINS_OBJS +=3D test-chmtime.o
>  TEST_BUILTINS_OBJS +=3D test-config.o
> +TEST_BUILTINS_OBJS +=3D test-copy-file.o
>  TEST_BUILTINS_OBJS +=3D test-crontab.o
>  TEST_BUILTINS_OBJS +=3D test-csprng.o
>  TEST_BUILTINS_OBJS +=3D test-date.o
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 5b25cca510..cd83093ec9 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -309,6 +309,9 @@ static void copy_or_link_directory(struct strbuf *src=
, struct strbuf *dest,
>
>                 if (unlink(dest->buf) && errno !=3D ENOENT)
>                         die_errno(_("failed to unlink '%s'"), dest->buf);
> +               if (!copy_file_reflink_with_time(the_repository, dest->bu=
f,
> +                                         src->buf, 0666))
> +                       continue;
>                 if (!option_no_hardlinks) {
>                         if (!link(src->buf, dest->buf)) {
>                                 struct stat st;
> diff --git a/copy.c b/copy.c
> index 6074132050..da8a285c1e 100644
> --- a/copy.c
> +++ b/copy.c
> @@ -5,6 +5,12 @@
>  #include "strbuf.h"
>  #include "abspath.h"
>
> +#ifdef __linux__
> +#include <sys/ioctl.h>
> +
> +#define FICLONE _IOW(0x94, 9, int)
> +#endif
> +
>  int copy_fd(int ifd, int ofd)
>  {
>         while (1) {
> @@ -33,19 +39,9 @@ static int copy_times(const char *dst, const char *src=
)
>         return 0;
>  }
>
> -int copy_file(struct repository *repo,
> -             const char *dst, const char *src, int mode)
> +static int finish_copy(struct repository *repo, const char *dst,
> +                      int fdi, int fdo, int status)
>  {
> -       int fdi, fdo, status;
> -
> -       mode =3D (mode & 0111) ? 0777 : 0666;
> -       if ((fdi =3D open(src, O_RDONLY)) < 0)
> -               return fdi;
> -       if ((fdo =3D open(dst, O_WRONLY | O_CREAT | O_EXCL, mode)) < 0) {
> -               close(fdi);
> -               return fdo;
> -       }
> -       status =3D copy_fd(fdi, fdo);
>         switch (status) {
>         case COPY_READ_ERROR:
>                 error_errno("copy-fd: read returned");
> @@ -64,6 +60,82 @@ int copy_file(struct repository *repo,
>         return status;
>  }
>
> +int copy_file_reflink(struct repository *repo,
> +                      const char *dst, const char *src, int mode)
> +{
> +#ifndef FICLONE
> +       (void)repo;
> +       (void)dst;
> +       (void)src;
> +       (void)mode;
> +       errno =3D ENOTSUP;
> +       return -1;
> +#else
> +       int fdi, fdo, status;
> +
> +       mode =3D (mode & 0111) ? 0777 : 0666;
> +       if ((fdi =3D open(src, O_RDONLY)) < 0)
> +               return fdi;
> +       if ((fdo =3D open(dst, O_WRONLY | O_CREAT | O_EXCL, mode)) < 0) {
> +               close(fdi);
> +               return fdo;
> +       }
> +       status =3D ioctl(fdo, FICLONE, fdi);
> +       if (status) {
> +               int saved_errno =3D errno;
> +
> +               close(fdi);
> +               close(fdo);
> +               unlink(dst);
> +               errno =3D saved_errno;
> +               return -1;
> +       }
> +
> +       return finish_copy(repo, dst, fdi, fdo, 0);
> +#endif
> +}
> +
> +int copy_file_reflink_with_time(struct repository *repo,
> +                        const char *dst, const char *src, int mode)
> +{
> +       int saved_errno;
> +
> +       if (copy_file_reflink(repo, dst, src, mode))
> +               return -1;
> +       if (!copy_times(dst, src))
> +               return 0;
> +
> +       saved_errno =3D errno;
> +       unlink(dst);
> +       errno =3D saved_errno;
> +       return -1;
> +}
> +
> +static int copy_file_contents(struct repository *repo,
> +                             const char *dst, const char *src, int mode)
> +{
> +       int fdi, fdo;
> +
> +       mode =3D (mode & 0111) ? 0777 : 0666;
> +       if ((fdi =3D open(src, O_RDONLY)) < 0)
> +               return fdi;
> +       if ((fdo =3D open(dst, O_WRONLY | O_CREAT | O_EXCL, mode)) < 0) {
> +               close(fdi);
> +               return fdo;
> +       }
> +
> +       return finish_copy(repo, dst, fdi, fdo, copy_fd(fdi, fdo));
> +}
> +
> +int copy_file(struct repository *repo,
> +             const char *dst, const char *src, int mode)
> +{
> +       if (!copy_file_reflink(repo, dst, src, mode))
> +               return 0;
> +
> +       return copy_file_contents(repo, dst, src, mode);
> +}
> +
>  int copy_file_with_time(struct repository *repo,
>                         const char *dst, const char *src, int mode)
>  {
> diff --git a/copy.h b/copy.h
> index 1059b118d6..4c603756a7 100644
> --- a/copy.h
> +++ b/copy.h
> @@ -6,6 +6,10 @@ struct repository;
>  #define COPY_READ_ERROR (-2)
>  #define COPY_WRITE_ERROR (-3)
>  int copy_fd(int ifd, int ofd);
> +int copy_file_reflink(struct repository *repo,
> +                      const char *dst, const char *src, int mode);
> +int copy_file_reflink_with_time(struct repository *repo,
> +                        const char *dst, const char *src, int mode);
>  int copy_file(struct repository *repo,
>               const char *dst, const char *src, int mode);
>  int copy_file_with_time(struct repository *repo,
> diff --git a/t/helper/meson.build b/t/helper/meson.build
> index 3235f10ab8..90b57fb86a 100644
> --- a/t/helper/meson.build
> +++ b/t/helper/meson.build
> @@ -7,6 +7,7 @@ test_tool_sources =3D [
>    'test-cache-tree.c',
>    'test-chmtime.c',
>    'test-config.c',
> +  'test-copy-file.c',
>    'test-crontab.c',
>    'test-csprng.c',
>    'test-date.c',
> diff --git a/t/helper/test-copy-file.c b/t/helper/test-copy-file.c
> new file mode 100644
> index 0000000000..fee14b60b6
> --- /dev/null
> +++ b/t/helper/test-copy-file.c
> @@ -0,0 +1,13 @@
> +#define USE_THE_REPOSITORY_VARIABLE
> +
> +#include "test-tool.h"
> +#include "copy.h"
> +#include "environment.h"
> +#include "repository.h"
> +
> +int cmd__copy_file(int argc, const char **argv)
> +{
> +       if (argc !=3D 3)
> +               return 129;
> +       return copy_file(the_repository, argv[2], argv[1], 0666) ? 1 : 0;
> +}
> diff --git a/t/helper/test-fake-reflink.c b/t/helper/test-fake-reflink.c
> new file mode 100644
> index 0000000000..9afc4c14d4
> --- /dev/null
> +++ b/t/helper/test-fake-reflink.c
> @@ -0,0 +1,72 @@
> +#define _GNU_SOURCE
> +#include <dlfcn.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <stdarg.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/ioctl.h>
> +#include <unistd.h>
> +
> +#define FICLONE _IOW(0x94, 9, int)
> +
> +static int emulate_clone(int dst, int src)
> +{
> +       char buf[8192];
> +       off_t pos =3D 0;
> +
> +       for (;;) {
> +               ssize_t nr =3D pread(src, buf, sizeof(buf), pos);
> +               if (nr < 0)
> +                       return -1;
> +               if (!nr)
> +                       return ftruncate(dst, pos);
> +               if (pwrite(dst, buf, nr, pos) !=3D nr)
> +                       return -1;
> +               pos +=3D nr;
> +       }
> +}
> +
> +static void log_clone_attempt(void)
> +{
> +       const char *path =3D getenv("GIT_TEST_FICLONE_LOG");
> +       int fd;
> +
> +       if (!path)
> +               return;
> +       fd =3D open(path, O_WRONLY | O_CREAT | O_APPEND, 0666);
> +       if (fd < 0)
> +               return;
> +       write(fd, "FICLONE\n", 8);
> +       close(fd);
> +}
> +
> +int ioctl(int fd, unsigned long request, ...)
> +{
> +       static int (*real_ioctl)(int, unsigned long, ...);
> +       va_list ap;
> +       unsigned long arg;
> +       const char *mode;
> +
> +       va_start(ap, request);
> +       arg =3D va_arg(ap, unsigned long);
> +       va_end(ap);
> +
> +       if (request !=3D FICLONE) {
> +               if (!real_ioctl)
> +                       real_ioctl =3D dlsym(RTLD_NEXT, "ioctl");
> +               return real_ioctl(fd, request, arg);
> +       }
> +
> +       log_clone_attempt();
> +       mode =3D getenv("GIT_TEST_FICLONE");
> +       if (!mode || !strcmp(mode, "real")) {
> +               if (!real_ioctl)
> +                       real_ioctl =3D dlsym(RTLD_NEXT, "ioctl");
> +               return real_ioctl(fd, request, arg);
> +       }
> +       if (!strcmp(mode, "success"))
> +               return emulate_clone(fd, (int)arg);
> +       errno =3D !strcmp(mode, "unsupported") ? EOPNOTSUPP : EIO;
> +       return -1;
> +}
> diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
> index b71a22b43b..51012fa46c 100644
> --- a/t/helper/test-tool.c
> +++ b/t/helper/test-tool.c
> @@ -17,6 +17,7 @@ static struct test_cmd cmds[] =3D {
>         { "cache-tree", cmd__cache_tree },
>         { "chmtime", cmd__chmtime },
>         { "config", cmd__config },
> +       { "copy-file", cmd__copy_file },
>         { "crontab", cmd__crontab },
>         { "csprng", cmd__csprng },
>         { "date", cmd__date },
> diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
> index f2885b33d5..7565cceb86 100644
> --- a/t/helper/test-tool.h
> +++ b/t/helper/test-tool.h
> @@ -10,6 +10,7 @@ int cmd__bundle_uri(int argc, const char **argv);
>  int cmd__cache_tree(int argc, const char **argv);
>  int cmd__chmtime(int argc, const char **argv);
>  int cmd__config(int argc, const char **argv);
> +int cmd__copy_file(int argc, const char **argv);
>  int cmd__crontab(int argc, const char **argv);
>  int cmd__csprng(int argc, const char **argv);
>  int cmd__date(int argc, const char **argv);
> diff --git a/t/meson.build b/t/meson.build
> index a25f37d2f5..a6575b8b9a 100644
> --- a/t/meson.build
> +++ b/t/meson.build
> @@ -126,6 +126,7 @@ integration_tests =3D [
>    't0091-bugreport.sh',
>    't0092-diagnose.sh',
>    't0093-verify-cache-df-gap.sh',
> +  't0094-reflink.sh',
>    't0095-bloom.sh',
>    't0100-previous.sh',
>    't0101-at-syntax.sh',
> diff --git a/t/t0094-reflink.sh b/t/t0094-reflink.sh
> new file mode 100755
> index 0000000000..25e989d272
> --- /dev/null
> +++ b/t/t0094-reflink.sh
> @@ -0,0 +1,89 @@
> +#!/bin/sh
> +
> +test_description=3D'reflink-first file copying'
> +
> +. ./test-lib.sh
> +
> +FAKE_REFLINK=3D/tmp/git-test-fake-reflink-$$.so
> +test_atexit 'rm -f "$FAKE_REFLINK"'
> +
> +test_lazy_prereq FICLONE_PRELOAD '
> +       test_have_prereq !MINGW &&
> +       test "$(uname -s)" =3D Linux &&
> +       ${CC:-cc} -shared -fPIC -o "$FAKE_REFLINK" \
> +               "$TEST_DIRECTORY/helper/test-fake-reflink.c" -ldl
> +'
> +
> +test_expect_success FICLONE_PRELOAD 'generic copy accepts reflink succes=
s' '
> +       printf content >source &&
> +       GIT_TEST_FICLONE=3Dsuccess \
> +       GIT_TEST_FICLONE_LOG=3D"$TRASH_DIRECTORY/generic-success.log" \
> +       LD_PRELOAD=3D"$FAKE_REFLINK" \
> +               test-tool copy-file source destination &&
> +       test_file_not_empty generic-success.log &&
> +       test_cmp source destination &&
> +       test "$(stat -c %i source)" !=3D "$(stat -c %i destination)"
> +'
> +
> +test_expect_success FICLONE_PRELOAD 'generic copy falls back when unsupp=
orted' '
> +       printf fallback >source-fallback &&
> +       GIT_TEST_FICLONE=3Dunsupported \
> +       GIT_TEST_FICLONE_LOG=3D"$TRASH_DIRECTORY/generic-unsupported.log"=
 \
> +       LD_PRELOAD=3D"$FAKE_REFLINK" \
> +               test-tool copy-file source-fallback destination-fallback =
&&
> +       test_file_not_empty generic-unsupported.log &&
> +       test_cmp source-fallback destination-fallback
> +'
> +
> +test_expect_success FICLONE_PRELOAD 'generic copy falls back after refli=
nk error' '
> +       printf error-fallback >source-error &&
> +       GIT_TEST_FICLONE=3Derror \
> +       GIT_TEST_FICLONE_LOG=3D"$TRASH_DIRECTORY/generic-error.log" \
> +       LD_PRELOAD=3D"$FAKE_REFLINK" \
> +               test-tool copy-file source-error destination-error &&
> +       test_file_not_empty generic-error.log &&
> +       test_cmp source-error destination-error
> +'
> +
> +test_expect_success FICLONE_PRELOAD 'local clone prefers successful refl=
inks' '
> +       git init source-repo &&
> +       git -C source-repo commit --allow-empty -m base &&
> +       GIT_TEST_FICLONE=3Dsuccess \
> +       GIT_TEST_FICLONE_LOG=3D"$TRASH_DIRECTORY/clone-success.log" \
> +       LD_PRELOAD=3D"$FAKE_REFLINK" \
> +               git clone --bare source-repo reflink-clone &&
> +       test_file_not_empty clone-success.log &&
> +       find reflink-clone/objects -type f -links +1 >hardlinks &&
> +       test_must_be_empty hardlinks &&
> +       git -C reflink-clone fsck --no-dangling
> +'
> +
> +test_expect_success FICLONE_PRELOAD '--no-hardlinks also prefers success=
ful reflinks' '
> +       GIT_TEST_FICLONE=3Dsuccess \
> +       GIT_TEST_FICLONE_LOG=3D"$TRASH_DIRECTORY/no-hardlinks-success.log=
" \
> +       LD_PRELOAD=3D"$FAKE_REFLINK" \
> +               git clone --bare --no-hardlinks source-repo no-hardlinks-=
reflink-clone &&
> +       test_file_not_empty no-hardlinks-success.log &&
> +       find no-hardlinks-reflink-clone/objects -type f -links +1 >hardli=
nks &&
> +       test_must_be_empty hardlinks &&
> +       git -C no-hardlinks-reflink-clone fsck --no-dangling
> +'
> +
> +test_expect_success FICLONE_PRELOAD 'local clone preserves hardlink fall=
back' '
> +       GIT_TEST_FICLONE=3Dunsupported \
> +       LD_PRELOAD=3D"$FAKE_REFLINK" \
> +               git clone --bare source-repo hardlink-clone &&
> +       find hardlink-clone/objects -type f -links +1 >hardlinks &&
> +       test_file_not_empty hardlinks
> +'
> +
> +test_expect_success FICLONE_PRELOAD '--no-hardlinks preserves byte-copy =
fallback' '
> +       GIT_TEST_FICLONE=3Dunsupported \
> +       LD_PRELOAD=3D"$FAKE_REFLINK" \
> +               git clone --bare --no-hardlinks source-repo copied-clone =
&&
> +       find copied-clone/objects -type f -links +1 >hardlinks &&
> +       test_must_be_empty hardlinks &&
> +       git -C copied-clone fsck --no-dangling
> +'
> +
> +test_done
> diff --git a/t/t5605-clone-local.sh b/t/t5605-clone-local.sh
> index 156362f145..b3ab4d6faf 100755
> --- a/t/t5605-clone-local.sh
> +++ b/t/t5605-clone-local.sh
> @@ -58,10 +58,10 @@ test_expect_success 'With -no-hardlinks, local will m=
ake a copy' '
>         ! repo_is_hardlinked w
>  '
>
> -test_expect_success 'Even without -l, local will make a hardlink' '
> +test_expect_success 'local clone copies the complete object database' '
>         rm -fr w &&
>         git clone -l --bare x w &&
> -       repo_is_hardlinked w
> +       git -C w fsck --no-dangling
>  '
>
>  test_expect_success 'local clone of repo with nonexistent ref in HEAD' '
>
> base-commit: 010afd3166ddc64c9863b1506f12cbcdda0d4ea1
> --
> gitgitgadget
