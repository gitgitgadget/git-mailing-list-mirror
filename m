Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 259431FCCA
	for <e@80x24.org>; Wed, 28 Jun 2017 17:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751941AbdF1RkX (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Jun 2017 13:40:23 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34979 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751540AbdF1RkW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2017 13:40:22 -0400
Received: by mail-pg0-f68.google.com with SMTP id f127so8962067pgc.2
        for <git@vger.kernel.org>; Wed, 28 Jun 2017 10:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=46zXCxZYPeUq5tiZYaFzBZ6YPgLQ9R8Vsox58CerPL8=;
        b=e6uh7GvOHx5n1LZoNlo6PNPiKmpTHotwJcc8YNwMRhBfRNFhlexAxHr/5Kq85q9jcy
         4ptIKIpLZSR8qfTbkzHzyv3KtKasiJIALI5Ij268I9AeqAb6qbaFSwBHIOf+TmpSCUtm
         nL+HE3jgzBw6nqy/3ErBCcRB9GVxl7V9kOp1HzEggzn077PZURiE8HDWzsj4JboF8+NZ
         qi37SXTXupasgQyAGTQquAFqBZRMWmSJhTSc4fJIdev/bVNOrYT98BayCmNgP0lHVHZ0
         MOcvHxviCNYGMbUuhrt0IQi0h6S8WsINO0+JfvtPX3Sz7+FHCXx3i+HEhnNex065MxRO
         qjtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=46zXCxZYPeUq5tiZYaFzBZ6YPgLQ9R8Vsox58CerPL8=;
        b=G9Af0KJrraEo1jzxc0p3t1zpa6wxCqVBeqg9qEW+qCSCDoiM+Gex2Mfv1fyjM8RVP1
         ctFm1yW7MgiDDGGNmzhdf4TlaZpN1MZfFIWAKiu6v8DJyVI2+2ZiwnmAtbhF3Jv7yMJD
         a8q7nq4epkBO5k8IVfnA+xq+fO5cCLQ6GOo346G5S+5WXhI7uXylQ4fduT71OKRZaycT
         vlMNyvP9HU0dIycUnxu4Zlj76mtPGNZuGthbGF4lPTAJrm6eu166u1tt5XOBbi/0oQOp
         kdwvG8FU4ex/7CBkmXeeaL1ZyJYDl32SWraK7XPBoI4W4K0N9hJX4cElFkoWnsOevAlZ
         5fzA==
X-Gm-Message-State: AKS2vOwjMPzFnF4U9wopZSn4NRlvd7wOyVk+X/QH+kewu6MUCH0G7gFl
        RAwurCya6Nfzzq9ZTYE=
X-Received: by 10.99.122.18 with SMTP id v18mr11640623pgc.142.1498671621042;
        Wed, 28 Jun 2017 10:40:21 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:88a2:2d61:9b86:f64d])
        by smtp.gmail.com with ESMTPSA id r27sm6453420pfe.0.2017.06.28.10.40.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 28 Jun 2017 10:40:20 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     tboegi@web.de
Cc:     git@vger.kernel.org
Subject: Re: [PATCH/RFC v1 1/1] cygwin: Allow pushing to UNC paths
References: <20170628162958.519-1-tboegi@web.de>
Date:   Wed, 28 Jun 2017 10:40:19 -0700
In-Reply-To: <20170628162958.519-1-tboegi@web.de> (tboegi@web.de's message of
        "Wed, 28 Jun 2017 18:29:58 +0200")
Message-ID: <xmqqefu4vwn0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tboegi@web.de writes:

> From: Torsten Bögershausen <tboegi@web.de>
>
> cygwin can use an UNC path like //server/share/repo
> $ cd //server/share/dir
> $ mkdir test
> $ cd test
> $ git init --bare
>
> However, when we try to push from a local Git repository to this repo,
> there are 2 problems:
> - Git converts the leading "//" into a single "/".
> - The remote repo is not accepted because setup.c calls
>   access(getenv(DB_ENVIRONMENT), X_OK)
>   and this call fails. In other words, checking the executable bit
>   of a directory mounted on a SAMBA share is not reliable (and not needed).
>
> As cygwin handles an UNC path so well, Git can support them better.
> - Introduce cygwin_offset_1st_component() which keeps the leading "//",
>   similar to what Git for Windows does.
> - Move CYGWIN out of the POSIX in the tests for path normalization in t0060.
> - Use cygwin_access() with a relaxed test for the executable bit on
>   a directory pointed out by an UNC path.

Thanks.

The offset-1st-component thing looks like a right thing to do.

I think the reason why you marked this as RFC is because you found
the "access" bit a bit iffy?  If so, I share the feeling.  If it
were called only from the codepath in setup.c::is_git_directory(),
it may be OK, but I suspect that there are other places that do care
about access() for other reasons in the codebase, and I am not sure
if it is safe to change the behaviour of access() like this.

Stepping back a bit.

The implementation of is_git_directory() wants to ensure that the
top level of the object database (i.e.  $GIT_OBJECT_DIRECTORY or
$GIT_DIR/objects) and the reference store (i.e. $GIT_DIR/refs) can
be "executed".  But what it really wants to see is that it is a
directory we can search.  If we had a regular file that is executable,
it would happily say "Yes!", even though that is clearly bogus and
not a Git repository.

So perhaps we would want a bit higher-level abstraction API
implemented as:

	int is_searchable_directory(const char *path)
	{
		struct stat st;

	        return (!stat(path, &st) && S_ISDIR(st.st_mode));
	}

on Cygwin (as SMB share may not give you correct access(2)), and

	int is_searchable_directory(const char *path)
	{
		struct stat st;

	        return (!stat(path, &st) && 
			S_ISDIR(st.st_mode) &&
			!access(path, X_OK));
	}

elsewhere, or something like that, and use that in the
implementation of is_git_directory()?

I dunno.  I see compat/mingw.c discards X_OK the same way you did,
so perhaps your version is a right solution at least in the shorter
term anyway.  

Regardless, I think that we would want to make sure that the thing
is a directory where is_git_directory() uses access(2).  But that
could be an orthogonal issue.

> Signed-off-by: Torsten Bögershausen <tboegi@web.de>
> ---
>  compat/cygwin.c       | 29 +++++++++++++++++++++++++++++
>  compat/cygwin.h       |  7 +++++++
>  config.mak.uname      |  1 +
>  git-compat-util.h     |  3 +++
>  t/t0060-path-utils.sh |  2 ++
>  5 files changed, 42 insertions(+)
>  create mode 100644 compat/cygwin.c
>  create mode 100644 compat/cygwin.h
>
> diff --git a/compat/cygwin.c b/compat/cygwin.c
> new file mode 100644
> index 0000000..d98e877
> --- /dev/null
> +++ b/compat/cygwin.c
> @@ -0,0 +1,29 @@
> +#include "../git-compat-util.h"
> +#include "../cache.h"
> +
> +int cygwin_offset_1st_component(const char *path)
> +{
> +	const char *pos = path;
> +	/* unc paths */
> +	if (is_dir_sep(pos[0]) && is_dir_sep(pos[1])) {
> +		/* skip server name */
> +		pos = strchr(pos + 2, '/');
> +		if (!pos)
> +			return 0; /* Error: malformed unc path */
> +
> +		do {
> +			pos++;
> +		} while (*pos && pos[0] != '/');
> +	}
> +	return pos + is_dir_sep(*pos) - path;
> +}
> +
> +#undef access
> +int cygwin_access(const char *filename, int mode)
> +{
> +	/* the execute bit does not work on SAMBA drives */
> +	if (filename[0] == '/' && filename[1] == '/' )
> +		return access(filename, mode & ~X_OK);
> +	else
> +		return access(filename, mode);
> +}
> diff --git a/compat/cygwin.h b/compat/cygwin.h
> new file mode 100644
> index 0000000..efa12ad
> --- /dev/null
> +++ b/compat/cygwin.h
> @@ -0,0 +1,7 @@
> +int cygwin_access(const char *filename, int mode);
> +#undef access
> +#define access cygwin_access
> +
> +
> +int cygwin_offset_1st_component(const char *path);
> +#define offset_1st_component cygwin_offset_1st_component
> diff --git a/config.mak.uname b/config.mak.uname
> index adfb90b..551e465 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -184,6 +184,7 @@ ifeq ($(uname_O),Cygwin)
>  	UNRELIABLE_FSTAT = UnfortunatelyYes
>  	SPARSE_FLAGS = -isystem /usr/include/w32api -Wno-one-bit-signed-bitfield
>  	OBJECT_CREATION_USES_RENAMES = UnfortunatelyNeedsTo
> +	COMPAT_OBJS += compat/cygwin.o
>  endif
>  ifeq ($(uname_S),FreeBSD)
>  	NEEDS_LIBICONV = YesPlease
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 047172d..db9c22d 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -189,6 +189,9 @@
>  #include <sys/sysctl.h>
>  #endif
>  
> +#if defined(__CYGWIN__)
> +#include "compat/cygwin.h"
> +#endif
>  #if defined(__MINGW32__)
>  /* pull in Windows compatibility stuff */
>  #include "compat/mingw.h"
> diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
> index 444b5a4..7ea2bb5 100755
> --- a/t/t0060-path-utils.sh
> +++ b/t/t0060-path-utils.sh
> @@ -70,6 +70,8 @@ ancestor() {
>  case $(uname -s) in
>  *MINGW*)
>  	;;
> +*CYGWIN*)
> +	;;
>  *)
>  	test_set_prereq POSIX
>  	;;
