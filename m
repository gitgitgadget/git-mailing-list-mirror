Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD1D25EF8D
	for <git@vger.kernel.org>; Wed,  9 Apr 2025 14:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744209422; cv=none; b=hIon3ntRbCxpUPxtCDF+GQG9rWL4+WlXEy6R10r2OjrQv6ibDbg0GODVHBrrEJr9y2LYNznU/Ge6I8SiI4sGEF8t8ia2SB8u99Ig9ldFiyrsaGhQzqMFHsNhUgt8vDQxROFu/PpwlLuPTUNQmc99PjS3UYPWoW/wQxMDrXdTOe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744209422; c=relaxed/simple;
	bh=DWLDLeK6IFumZ62XKf+p2W0h9OB7pUCjacQHOLOdvu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jM2IN6FPinHleEhrIQhrIbHI5tz4fWC+Bie8qBdXip945s5EMDCPMqTph9jFt5TvaBjq/pa41TVTfabi+K0Xt5iBB4z9tM/yhRoPXBXkaWmBZHtBfZfOvh3vWRe0FN+XXaafl5l1qGE+cvs0UFD8wFZgtjDTpH0f3Ke5vyMg4VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fuXn6W3N; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fuXn6W3N"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-85b5e49615aso634531439f.1
        for <git@vger.kernel.org>; Wed, 09 Apr 2025 07:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744209419; x=1744814219; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AsFMHh2HprWaO8yO7dJUB8RRtEEfIjN72vKPmxO3uQk=;
        b=fuXn6W3N0jlhpHiGs0LlQO+rbZxKaFD+R3ira+/o4JdFA8J4Ylzd1STePKkCd9iz4i
         dR3tibK2s/zrAS7In/mA6/nudwcNdq79mjDZ5HfowCV2Tq8CwKZKb3pz0+P3nX4PfphW
         HlDQl8dgQgvTaDgKUPvA+Bi0zXYwruVm/BC3qotgrKE66kaJkPvIMXXb0Bv/LuG4HeBx
         3dUn6YkH3vE1Oq9tDTYIKkTOFuCRpw7ecuYCc3I9A6UJqR2qy6RQWD9x3mNgmk9k3XG7
         W+4G/kN/He5PNMYineDO+7RjZ9VIB6/9IdhPc4i7NNmN3X3eADvjYH1AzuwWlGPsmr0B
         w9nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744209419; x=1744814219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AsFMHh2HprWaO8yO7dJUB8RRtEEfIjN72vKPmxO3uQk=;
        b=pxQu1h3sr+aw8gC1TsBmq8a0ogZBexsqY7dh/OJXkzRISH54nSz7glBQAYO4oS5Q8F
         gqhC3THpexKI5IIwZqrxTg80SahUtfn98P4/9dfKbdV4n5bU73BxzmIGCedy1oqJSU/W
         c/unIvx5DTL6njBKzFkJuUga404PUf91vCAPtkJLE2XsEexnEJ1pR9jP2vvrqwJMwHGp
         vE0gND4eAN5sOb/aIwIysvp/9E5xb3tSrvJ13aB4RHwbloL1Wl3HadCr/A5rzUUlR5Ev
         mJDd4erJGHFpHyynmbbPq2U/MfSV27yuifFBQATkgSXLcmqxca+nTPeT6TTZNKIGHnx9
         S2LQ==
X-Gm-Message-State: AOJu0YygSDtOh6NHIrzfQYMdeNIapWcFOqFKTz3AXuEHMcM8fwP0EurU
	2b4bXOA43a/lZ0+QnUd48ealKHkPW8tT+ZMtLYFW3cBZqAYVhzdYO4zPhrI1pofQVAEwDDQHr8R
	iVNXjYLPb05iqYS3nxaLCq8djvwFLyg==
X-Gm-Gg: ASbGncvOTIUu2xVz0pvU56ytqLNRp4K3YV7nUtyBHo8jUv3GU+Lz6zcDmu59fKMdK3d
	kvxFOrXQl7aMAqoX2cdjwzdflL1E4S2a3jkx54v+TlsWQ7hJ4MaWZjaZpGFgSoinCOg3Pv7dpJQ
	xw2YDvj/d9LRcpuy6RyFjVIfRR3VzWL9iMbV9a/TXuWJL9pwfXiroDxvg=
X-Google-Smtp-Source: AGHT+IGFeXqHbEZ0/tEWD++3KwBegH+QUwv2DoMBXsQpuv/x9JRH7PrOhdw9G+tCLkB6u2TGXdmNsPe6doGqENzrt3c=
X-Received: by 2002:a05:6602:3896:b0:85b:4941:3fe6 with SMTP id
 ca18e2360f4ac-861611d1b74mr393183339f.7.1744209419132; Wed, 09 Apr 2025
 07:36:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408-pks-split-object-file-v1-0-f1fd50191143@pks.im> <20250408-pks-split-object-file-v1-1-f1fd50191143@pks.im>
In-Reply-To: <20250408-pks-split-object-file-v1-1-f1fd50191143@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 9 Apr 2025 07:36:47 -0700
X-Gm-Features: ATxdqUG_GbNsfmrrMZ1-aiyQ-5DxXwxddN1F_9dBKz_I0vn6kkupX2gYwnADdU0
Message-ID: <CABPp-BFpU5iLUN6Fh_+UG2Y593TWp4E+C_QQxLg6b=Cb-30F6A@mail.gmail.com>
Subject: Re: [PATCH 1/9] object-file: move `safe_create_leading_directories()`
 into "dir.c"
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 3:37=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> The `safe_create_leading_directories()` function and its relatives

How is mkdir_in_gitdir() a relative of safe_create_leading_directories()?

I assumed the relation was "called by", but there is no such
relationship.  The rest of the patch looked fine, but I was puzzled
for a while trying to figure out what this relationship is.

> are
> located in "object-file.c", which is not a good fit as they provide
> generic functionality not related to objects at all. Move them into
> "dir.c".

Makes sense.


>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/bugreport.c                |   2 +-
>  builtin/credential-cache--daemon.c |   2 +-
>  builtin/diagnose.c                 |   2 +-
>  builtin/fsck.c                     |   1 +
>  builtin/gc.c                       |   2 +-
>  builtin/init-db.c                  |   2 +-
>  builtin/log.c                      |   2 +-
>  commit-graph.c                     |   1 +
>  dir.c                              | 107 +++++++++++++++++++++++++++++++=
+++++-
>  dir.h                              |  35 ++++++++++++
>  midx-write.c                       |   1 +
>  object-file.c                      | 106 -------------------------------=
-----
>  object-file.h                      |  35 ------------
>  13 files changed, 150 insertions(+), 148 deletions(-)
>
> diff --git a/builtin/bugreport.c b/builtin/bugreport.c
> index 66d64bfd5ae..d07fa91c247 100644
> --- a/builtin/bugreport.c
> +++ b/builtin/bugreport.c
> @@ -1,6 +1,7 @@
>  #define USE_THE_REPOSITORY_VARIABLE
>  #include "builtin.h"
>  #include "abspath.h"
> +#include "dir.h"
>  #include "editor.h"
>  #include "gettext.h"
>  #include "parse-options.h"
> @@ -10,7 +11,6 @@
>  #include "hook.h"
>  #include "hook-list.h"
>  #include "diagnose.h"
> -#include "object-file.h"
>  #include "setup.h"
>  #include "version.h"
>
> diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cach=
e--daemon.c
> index e707618e743..80d29b4f5c0 100644
> --- a/builtin/credential-cache--daemon.c
> +++ b/builtin/credential-cache--daemon.c
> @@ -1,8 +1,8 @@
>  #define USE_THE_REPOSITORY_VARIABLE
>  #include "builtin.h"
>  #include "abspath.h"
> +#include "dir.h"
>  #include "gettext.h"
> -#include "object-file.h"
>  #include "parse-options.h"
>
>  #ifndef NO_UNIX_SOCKETS
> diff --git a/builtin/diagnose.c b/builtin/diagnose.c
> index 33c39bd5981..d5dadd6a48b 100644
> --- a/builtin/diagnose.c
> +++ b/builtin/diagnose.c
> @@ -2,8 +2,8 @@
>
>  #include "builtin.h"
>  #include "abspath.h"
> +#include "dir.h"
>  #include "gettext.h"
> -#include "object-file.h"
>  #include "parse-options.h"
>  #include "diagnose.h"
>
> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index 9c8a6d6a8df..32d40d8f9fc 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -1,5 +1,6 @@
>  #define USE_THE_REPOSITORY_VARIABLE
>  #include "builtin.h"
> +#include "dir.h"
>  #include "gettext.h"
>  #include "hex.h"
>  #include "config.h"
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 99431fd4674..b069629676c 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -16,6 +16,7 @@
>  #include "builtin.h"
>  #include "abspath.h"
>  #include "date.h"
> +#include "dir.h"
>  #include "environment.h"
>  #include "hex.h"
>  #include "config.h"
> @@ -28,7 +29,6 @@
>  #include "commit.h"
>  #include "commit-graph.h"
>  #include "packfile.h"
> -#include "object-file.h"
>  #include "object-store-ll.h"
>  #include "pack.h"
>  #include "pack-objects.h"
> diff --git a/builtin/init-db.c b/builtin/init-db.c
> index 196dccdd77a..39730c1b0ce 100644
> --- a/builtin/init-db.c
> +++ b/builtin/init-db.c
> @@ -6,9 +6,9 @@
>  #define USE_THE_REPOSITORY_VARIABLE
>  #include "builtin.h"
>  #include "abspath.h"
> +#include "dir.h"
>  #include "environment.h"
>  #include "gettext.h"
> -#include "object-file.h"
>  #include "parse-options.h"
>  #include "path.h"
>  #include "refs.h"
> diff --git a/builtin/log.c b/builtin/log.c
> index 0d4c579dad7..06ffaa93e86 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -10,11 +10,11 @@
>  #include "builtin.h"
>  #include "abspath.h"
>  #include "config.h"
> +#include "dir.h"
>  #include "environment.h"
>  #include "gettext.h"
>  #include "hex.h"
>  #include "refs.h"
> -#include "object-file.h"
>  #include "object-name.h"
>  #include "object-store-ll.h"
>  #include "pager.h"
> diff --git a/commit-graph.c b/commit-graph.c
> index 8286d5dda24..3fae20dc21b 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -4,6 +4,7 @@
>  #include "git-compat-util.h"
>  #include "config.h"
>  #include "csum-file.h"
> +#include "dir.h"
>  #include "gettext.h"
>  #include "hex.h"
>  #include "lockfile.h"
> diff --git a/dir.c b/dir.c
> index 28b0e03feb4..16ae3b5169d 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -17,7 +17,6 @@
>  #include "environment.h"
>  #include "gettext.h"
>  #include "name-hash.h"
> -#include "object-file.h"
>  #include "object-store-ll.h"
>  #include "path.h"
>  #include "refs.h"
> @@ -4132,3 +4131,109 @@ int path_match_flags(const char *const str, const=
 enum path_match_flags flags)
>                 return is_xplatform_dir_sep(*p);
>         BUG("unreachable");
>  }
> +
> +int mkdir_in_gitdir(const char *path)
> +{
> +       if (mkdir(path, 0777)) {
> +               int saved_errno =3D errno;
> +               struct stat st;
> +               struct strbuf sb =3D STRBUF_INIT;
> +
> +               if (errno !=3D EEXIST)
> +                       return -1;
> +               /*
> +                * Are we looking at a path in a symlinked worktree
> +                * whose original repository does not yet have it?
> +                * e.g. .git/rr-cache pointing at its original
> +                * repository in which the user hasn't performed any
> +                * conflict resolution yet?
> +                */
> +               if (lstat(path, &st) || !S_ISLNK(st.st_mode) ||
> +                   strbuf_readlink(&sb, path, st.st_size) ||
> +                   !is_absolute_path(sb.buf) ||
> +                   mkdir(sb.buf, 0777)) {
> +                       strbuf_release(&sb);
> +                       errno =3D saved_errno;
> +                       return -1;
> +               }
> +               strbuf_release(&sb);
> +       }
> +       return adjust_shared_perm(the_repository, path);
> +}
> +
> +static enum scld_error safe_create_leading_directories_1(char *path, int=
 share)
> +{
> +       char *next_component =3D path + offset_1st_component(path);
> +       enum scld_error ret =3D SCLD_OK;
> +
> +       while (ret =3D=3D SCLD_OK && next_component) {
> +               struct stat st;
> +               char *slash =3D next_component, slash_character;
> +
> +               while (*slash && !is_dir_sep(*slash))
> +                       slash++;
> +
> +               if (!*slash)
> +                       break;
> +
> +               next_component =3D slash + 1;
> +               while (is_dir_sep(*next_component))
> +                       next_component++;
> +               if (!*next_component)
> +                       break;
> +
> +               slash_character =3D *slash;
> +               *slash =3D '\0';
> +               if (!stat(path, &st)) {
> +                       /* path exists */
> +                       if (!S_ISDIR(st.st_mode)) {
> +                               errno =3D ENOTDIR;
> +                               ret =3D SCLD_EXISTS;
> +                       }
> +               } else if (mkdir(path, 0777)) {
> +                       if (errno =3D=3D EEXIST &&
> +                           !stat(path, &st) && S_ISDIR(st.st_mode))
> +                               ; /* somebody created it since we checked=
 */
> +                       else if (errno =3D=3D ENOENT)
> +                               /*
> +                                * Either mkdir() failed because
> +                                * somebody just pruned the containing
> +                                * directory, or stat() failed because
> +                                * the file that was in our way was
> +                                * just removed.  Either way, inform
> +                                * the caller that it might be worth
> +                                * trying again:
> +                                */
> +                               ret =3D SCLD_VANISHED;
> +                       else
> +                               ret =3D SCLD_FAILED;
> +               } else if (share && adjust_shared_perm(the_repository, pa=
th)) {
> +                       ret =3D SCLD_PERMS;
> +               }
> +               *slash =3D slash_character;
> +       }
> +       return ret;
> +}
> +
> +enum scld_error safe_create_leading_directories(char *path)
> +{
> +       return safe_create_leading_directories_1(path, 1);
> +}
> +
> +enum scld_error safe_create_leading_directories_no_share(char *path)
> +{
> +       return safe_create_leading_directories_1(path, 0);
> +}
> +
> +enum scld_error safe_create_leading_directories_const(const char *path)
> +{
> +       int save_errno;
> +       /* path points to cache entries, so xstrdup before messing with i=
t */
> +       char *buf =3D xstrdup(path);
> +       enum scld_error result =3D safe_create_leading_directories(buf);
> +
> +       save_errno =3D errno;
> +       free(buf);
> +       errno =3D save_errno;
> +       return result;
> +}
> diff --git a/dir.h b/dir.h
> index d7e71aa8daa..02c1f9420b0 100644
> --- a/dir.h
> +++ b/dir.h
> @@ -676,4 +676,39 @@ static inline int starts_with_dot_dot_slash_native(c=
onst char *const path)
>         return path_match_flags(path, what | PATH_MATCH_NATIVE);
>  }
>
> +/*
> + * Create the directory containing the named path, using care to be
> + * somewhat safe against races. Return one of the scld_error values to
> + * indicate success/failure. On error, set errno to describe the
> + * problem.
> + *
> + * SCLD_VANISHED indicates that one of the ancestor directories of the
> + * path existed at one point during the function call and then
> + * suddenly vanished, probably because another process pruned the
> + * directory while we were working.  To be robust against this kind of
> + * race, callers might want to try invoking the function again when it
> + * returns SCLD_VANISHED.
> + *
> + * safe_create_leading_directories() temporarily changes path while it
> + * is working but restores it before returning.
> + * safe_create_leading_directories_const() doesn't modify path, even
> + * temporarily. Both these variants adjust the permissions of the
> + * created directories to honor core.sharedRepository, so they are best
> + * suited for files inside the git dir. For working tree files, use
> + * safe_create_leading_directories_no_share() instead, as it ignores
> + * the core.sharedRepository setting.
> + */
> +enum scld_error {
> +       SCLD_OK =3D 0,
> +       SCLD_FAILED =3D -1,
> +       SCLD_PERMS =3D -2,
> +       SCLD_EXISTS =3D -3,
> +       SCLD_VANISHED =3D -4
> +};
> +enum scld_error safe_create_leading_directories(char *path);
> +enum scld_error safe_create_leading_directories_const(const char *path);
> +enum scld_error safe_create_leading_directories_no_share(char *path);
> +
> +int mkdir_in_gitdir(const char *path);
> +
>  #endif
> diff --git a/midx-write.c b/midx-write.c
> index a628ac24dcb..e01a867c583 100644
> --- a/midx-write.c
> +++ b/midx-write.c
> @@ -3,6 +3,7 @@
>  #include "git-compat-util.h"
>  #include "abspath.h"
>  #include "config.h"
> +#include "dir.h"
>  #include "hex.h"
>  #include "lockfile.h"
>  #include "packfile.h"
> diff --git a/object-file.c b/object-file.c
> index 772c311f188..23b2c8560be 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -91,112 +91,6 @@ static int get_conv_flags(unsigned flags)
>  }
>
>
> -int mkdir_in_gitdir(const char *path)
> -{
> -       if (mkdir(path, 0777)) {
> -               int saved_errno =3D errno;
> -               struct stat st;
> -               struct strbuf sb =3D STRBUF_INIT;
> -
> -               if (errno !=3D EEXIST)
> -                       return -1;
> -               /*
> -                * Are we looking at a path in a symlinked worktree
> -                * whose original repository does not yet have it?
> -                * e.g. .git/rr-cache pointing at its original
> -                * repository in which the user hasn't performed any
> -                * conflict resolution yet?
> -                */
> -               if (lstat(path, &st) || !S_ISLNK(st.st_mode) ||
> -                   strbuf_readlink(&sb, path, st.st_size) ||
> -                   !is_absolute_path(sb.buf) ||
> -                   mkdir(sb.buf, 0777)) {
> -                       strbuf_release(&sb);
> -                       errno =3D saved_errno;
> -                       return -1;
> -               }
> -               strbuf_release(&sb);
> -       }
> -       return adjust_shared_perm(the_repository, path);
> -}
> -
> -static enum scld_error safe_create_leading_directories_1(char *path, int=
 share)
> -{
> -       char *next_component =3D path + offset_1st_component(path);
> -       enum scld_error ret =3D SCLD_OK;
> -
> -       while (ret =3D=3D SCLD_OK && next_component) {
> -               struct stat st;
> -               char *slash =3D next_component, slash_character;
> -
> -               while (*slash && !is_dir_sep(*slash))
> -                       slash++;
> -
> -               if (!*slash)
> -                       break;
> -
> -               next_component =3D slash + 1;
> -               while (is_dir_sep(*next_component))
> -                       next_component++;
> -               if (!*next_component)
> -                       break;
> -
> -               slash_character =3D *slash;
> -               *slash =3D '\0';
> -               if (!stat(path, &st)) {
> -                       /* path exists */
> -                       if (!S_ISDIR(st.st_mode)) {
> -                               errno =3D ENOTDIR;
> -                               ret =3D SCLD_EXISTS;
> -                       }
> -               } else if (mkdir(path, 0777)) {
> -                       if (errno =3D=3D EEXIST &&
> -                           !stat(path, &st) && S_ISDIR(st.st_mode))
> -                               ; /* somebody created it since we checked=
 */
> -                       else if (errno =3D=3D ENOENT)
> -                               /*
> -                                * Either mkdir() failed because
> -                                * somebody just pruned the containing
> -                                * directory, or stat() failed because
> -                                * the file that was in our way was
> -                                * just removed.  Either way, inform
> -                                * the caller that it might be worth
> -                                * trying again:
> -                                */
> -                               ret =3D SCLD_VANISHED;
> -                       else
> -                               ret =3D SCLD_FAILED;
> -               } else if (share && adjust_shared_perm(the_repository, pa=
th)) {
> -                       ret =3D SCLD_PERMS;
> -               }
> -               *slash =3D slash_character;
> -       }
> -       return ret;
> -}
> -
> -enum scld_error safe_create_leading_directories(char *path)
> -{
> -       return safe_create_leading_directories_1(path, 1);
> -}
> -
> -enum scld_error safe_create_leading_directories_no_share(char *path)
> -{
> -       return safe_create_leading_directories_1(path, 0);
> -}
> -
> -enum scld_error safe_create_leading_directories_const(const char *path)
> -{
> -       int save_errno;
> -       /* path points to cache entries, so xstrdup before messing with i=
t */
> -       char *buf =3D xstrdup(path);
> -       enum scld_error result =3D safe_create_leading_directories(buf);
> -
> -       save_errno =3D errno;
> -       free(buf);
> -       errno =3D save_errno;
> -       return result;
> -}
> -
>  int odb_mkstemp(struct strbuf *temp_filename, const char *pattern)
>  {
>         int fd;
> diff --git a/object-file.h b/object-file.h
> index 81b30d269c8..922f2bba8c9 100644
> --- a/object-file.h
> +++ b/object-file.h
> @@ -21,41 +21,6 @@ extern int fetch_if_missing;
>  int index_fd(struct index_state *istate, struct object_id *oid, int fd, =
struct stat *st, enum object_type type, const char *path, unsigned flags);
>  int index_path(struct index_state *istate, struct object_id *oid, const =
char *path, struct stat *st, unsigned flags);
>
> -/*
> - * Create the directory containing the named path, using care to be
> - * somewhat safe against races. Return one of the scld_error values to
> - * indicate success/failure. On error, set errno to describe the
> - * problem.
> - *
> - * SCLD_VANISHED indicates that one of the ancestor directories of the
> - * path existed at one point during the function call and then
> - * suddenly vanished, probably because another process pruned the
> - * directory while we were working.  To be robust against this kind of
> - * race, callers might want to try invoking the function again when it
> - * returns SCLD_VANISHED.
> - *
> - * safe_create_leading_directories() temporarily changes path while it
> - * is working but restores it before returning.
> - * safe_create_leading_directories_const() doesn't modify path, even
> - * temporarily. Both these variants adjust the permissions of the
> - * created directories to honor core.sharedRepository, so they are best
> - * suited for files inside the git dir. For working tree files, use
> - * safe_create_leading_directories_no_share() instead, as it ignores
> - * the core.sharedRepository setting.
> - */
> -enum scld_error {
> -       SCLD_OK =3D 0,
> -       SCLD_FAILED =3D -1,
> -       SCLD_PERMS =3D -2,
> -       SCLD_EXISTS =3D -3,
> -       SCLD_VANISHED =3D -4
> -};
> -enum scld_error safe_create_leading_directories(char *path);
> -enum scld_error safe_create_leading_directories_const(const char *path);
> -enum scld_error safe_create_leading_directories_no_share(char *path);
> -
> -int mkdir_in_gitdir(const char *path);
> -
>  int git_open_cloexec(const char *name, int flags);
>  #define git_open(name) git_open_cloexec(name, O_RDONLY)
>
>
> --
> 2.49.0.682.gc9b6a7b2b0.dirty
>
>
