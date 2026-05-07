Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E9C2EACF2
	for <git@vger.kernel.org>; Thu,  7 May 2026 16:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778169618; cv=none; b=aL5XplT2Nt5vd4yfYuO6pm5Y3eaprxyxImnzgj0mzPdDu20D9FwBePLrIKnEmG/uM8re7rPsUf4V2ff6UPD2p8krujFY6F7owHvNOqf38p5whwilKpsbIpyPi96Sl00MkHteDsCsuc6bgZdIoSYEDqVI5mW6ZESXbDdxKUmwBEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778169618; c=relaxed/simple;
	bh=EoDrPu9SawnB+jPK/2QnPzJDKi1ADwYHwMjvP9rj7HM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=USU/FoPjA3tHJZDazTv/I3KVWPx/VQSIoeIl4EFiaazq4eJ3WNGwvyW47/rmNI2S/jWO1OvMAiDEm6DTjhz3xmEMNkeByMVjKJgkZNL9PX0MHrzTxXi/inE3kMdnKb/W8YMiOlDdPRUr2SeoMyFdCI2F0G4cDTRBA7nW0GzquSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hHMbjnRv; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHMbjnRv"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-651c366f7efso1054382d50.1
        for <git@vger.kernel.org>; Thu, 07 May 2026 09:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778169615; x=1778774415; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XlxullqFEnMV01Aj/uKEGcn4cu+lotyMi+wEBbM+sW0=;
        b=hHMbjnRve+Id9bTugBb3lDsO1j+Tk2tX2+9HNaFWi2OIjgsJUVndnWQEV3nV4h3PVv
         GJHkR2yVgMlO2dkV9knw5vGei+dvFPrJEeKCI+I5cDvxT3+StL2rRBoDQ7MPvzF+dNgu
         yBxLQ+fGmDUJJy62Viqn8AY5YVf/ROgYEytN+rxnOwBK+K/W+ioOPIIZGw9ZixhUeS6N
         Qf5ttY7BRLyLipmssj/t2kcB8wBCgTl2/d7P29V1lAOYKCiHmfL7uJMEi7pGnE91mfjG
         kP49/0rBo5tMueoWfysmEHPH4G0wGM4Z0e7GBheE8vudI8Up5180er1VqbCwKQfAfaFB
         Mq2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778169615; x=1778774415;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XlxullqFEnMV01Aj/uKEGcn4cu+lotyMi+wEBbM+sW0=;
        b=c0w0/VXPilwPp4yGHfZzA+dRgjsYICrewpZrmo/kjjw6GjAvjKT4sfM6s+JelAvham
         IatITuJP81MCPZzVGmemHFL26OvgWOOImWVBE2kScU2gLSejbyMCDuaM7EWhqpDNOLIb
         5KN50T0YzwkRYey5Vr1cL5IMBH7NoQeFssgXAkXjT2C9Hkmv1QjsFEk/nB09ocehqkqD
         LRz81AdhwAQY6tCNDLT4mUGSBF6uquI+7kUR+sSojZLh3SnkpcpWFnwPcO9AACp8Qu1t
         ow92AfPYC5bSl9XfQStdvNabVkCQdPOOH2yhrmOrjLa5XVd0H4PlGpCCD0Y1FbABeDXI
         e+DQ==
X-Gm-Message-State: AOJu0Yy6ZxpUebHDb6w76FBTmEpgkIcfUJDqZ1oa3gjhdc2SPvhsdWYz
	kaFIl5Xw9cn3/aHNkSIxRsdU811WmjVrMckTNe82MM/o88CUPHEGxuXjvTHAwQ==
X-Gm-Gg: Acq92OGJwFdT/ndau7VOsVkcYZxMZXItDTtB6jz6orzzxHzWCLiYlFnPxBAaE7Exba1
	dGKFjv85uQNrOUmKAIBg6/Ul2M79NguQARo5ivS1+VAE8qHVNJ773eIZVfYufiMOcbyNrhb2oQJ
	CBSjksGYKDIrZ1e2ir8dunaS5GeCrWETXCIsc3FPH/EOoWkSknOqYQoj/mypwSjNsPSqYJH+r9p
	SOYvVBoEQidZNiCZRnx/NjvLqYvru6oP+9HZwwOUzVGy2coaUF9QawD/CLbmk3UZ3YvRGXW8Y18
	kiWKTVHiXdF9yLFzyZQQ+Qxru0pXBkB7CBVG/6ry4BwD+OWZDEQeDEpmflljM80AxoEbYm/uwd7
	g1VVua7UPikq1U+MzS/debtoUtemBB6RvelBoEpzfF0+E9JLFyqTgWA0YPIkuZI73IaFUPKQJu7
	fSSmPDnCw7zbBsl9U8azGVeR5iAXw=
X-Received: by 2002:a05:690e:1b57:b0:650:1cdb:5f57 with SMTP id 956f58d0204a3-65c79877644mr7081138d50.5.1778169615236;
        Thu, 07 May 2026 09:00:15 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.176.153])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65d901b79b2sm93528d50.13.2026.05.07.09.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 09:00:14 -0700 (PDT)
Message-Id: <pull.2104.v2.git.1778169613.gitgitgadget@gmail.com>
In-Reply-To: <pull.2104.git.1777811392756.gitgitgadget@gmail.com>
References: <pull.2104.git.1777811392756.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 07 May 2026 16:00:07 +0000
Subject: [PATCH v2 0/6] mingw: stop using nedmalloc
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

Git for Windows' SDK wants to update GCC to v16. Since it is used in the CI
builds also of the git/git repository, it is crucial that GCC can compile
even the latter all right, but currently it does not, see
https://github.com/git-for-windows/git-sdk-64/actions/runs/25244795074.

Git for Windows switched away from nedmalloc to mimalloc a long time ago,
but recent benchmarks across Windows, macOS, and Linux (see
https://github.com/git-for-windows/git/pull/6231) show no measurable benefit
from mimalloc over the platforms' default allocators, so rather than
upstreaming the mimalloc support, I will drop it from Git for Windows
entirely.

This series therefore disables nedmalloc for MINGW builds and removes the
vendored-in nedmalloc from Git's source code; my earlier sketch in
https://lore.kernel.org/git/00fd3145-b3d2-ddab-466d-d06fd27298ec@gmx.de/ had
the opposite ordering only because it assumed mimalloc would land first.
Since that's not going to happen, it's best to move forward with this, so
that the CI builds can switch to using GCC 16 (and the current Git for
Windows SDK) on Windows.

The patches that remove the vendored sources have a slightly unusual shape:
the Git mailing list rejects messages over 100kB and
compat/nedmalloc/malloc.c.h alone is ~196kB of source, so the deletion of
that file is split at section boundaries into three commits, each
comfortably under the cap.

Changes since v1:

 * Also remove nedmalloc from the CMake and Meson configurations in the
   first patch.
 * Add follow-up patches that drop the nedmalloc build-system plumbing and
   source files.

Johannes Schindelin (6):
  mingw: stop using nedmalloc
  mingw: drop the build-system plumbing for nedmalloc
  mingw: drop the small nedmalloc auxiliary files
  mingw: drop the first chunk of compat/nedmalloc/malloc.c.h
  mingw: drop the second chunk of compat/nedmalloc/malloc.c.h
  mingw: drop the rest of compat/nedmalloc/malloc.c.h

 Makefile                            |   17 -
 compat/nedmalloc/License.txt        |   23 -
 compat/nedmalloc/Readme.txt         |  136 -
 compat/nedmalloc/malloc.c.h         | 5761 ---------------------------
 compat/nedmalloc/nedmalloc.c        |  954 -----
 compat/nedmalloc/nedmalloc.h        |  180 -
 config.mak.uname                    |    4 -
 contrib/buildsystems/CMakeLists.txt |    3 +-
 contrib/vscode/init.sh              |    1 -
 meson.build                         |    2 -
 10 files changed, 1 insertion(+), 7080 deletions(-)
 delete mode 100644 compat/nedmalloc/License.txt
 delete mode 100644 compat/nedmalloc/Readme.txt
 delete mode 100644 compat/nedmalloc/malloc.c.h
 delete mode 100644 compat/nedmalloc/nedmalloc.c
 delete mode 100644 compat/nedmalloc/nedmalloc.h


base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2104%2Fdscho%2Fstop-using-nedmalloc-with-mingw-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2104/dscho/stop-using-nedmalloc-with-mingw-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2104

Range-diff vs v1:

 1:  b5d1ae93e4 ! 1:  d547877ae3 mingw: stop using nedmalloc
     @@ Commit message
          https://github.com/git-for-windows/git-sdk-64/actions/runs/25244795074.
      
          Rather than patch the unmaintained vendored sources to silence the
     -    warning, stop opting into nedmalloc altogether on MINGW. The platform
     -    allocator is what every non-MINGW build already uses, and a fresh
     -    build of git.git's master against a minimal Git for Windows SDK
     -    upgraded to GCC 16, with `USE_NED_ALLOCATOR` removed from the MINGW
     -    section, completes successfully.
     +    warning, stop opting into nedmalloc altogether on Windows. The
     +    platform allocator is what every non-MINGW build already uses, and a
     +    fresh build of git.git's master against a minimal Git for Windows SDK
     +    upgraded to GCC 16 completes successfully.
      
     -    The compat/nedmalloc/ subtree itself is left in place to keep this
     -    change minimal; nothing in the build links against it any longer, so
     -    it can be removed in a follow-up if desired.
     +    The compat/nedmalloc/ subtree itself is removed by subsequent commits
     +    in this series.
      
     -    Assisted-by: Claude Opus 4.7
     +    Assisted-by: Opus 4.7
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## config.mak.uname ##
     @@ config.mak.uname: ifeq ($(uname_S),MINGW)
               ifeq (/mingw64,$(subst 32,64,$(subst clangarm,mingw,$(prefix))))
       		# Move system config into top-level /etc/
       		ETC_GITCONFIG = ../etc/gitconfig
     +
     + ## contrib/buildsystems/CMakeLists.txt ##
     +@@ contrib/buildsystems/CMakeLists.txt: if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
     + 	add_compile_definitions(HAVE_ALLOCA_H NO_POSIX_GOODIES NATIVE_CRLF NO_UNIX_SOCKETS WIN32
     + 				_CONSOLE DETECT_MSYS_TTY STRIP_EXTENSION=".exe"  NO_SYMLINK_HEAD UNRELIABLE_FSTAT
     + 				NOGDI OBJECT_CREATION_MODE=1 __USE_MINGW_ANSI_STDIO=0
     +-				USE_NED_ALLOCATOR OVERRIDE_STRDUP MMAP_PREVENTS_DELETE USE_WIN32_MMAP
     ++				OVERRIDE_STRDUP MMAP_PREVENTS_DELETE USE_WIN32_MMAP
     + 				HAVE_WPGMPTR ENSURE_MSYSTEM_IS_SET HAVE_RTLGENRANDOM)
     + 	list(APPEND compat_SOURCES
     + 		compat/mingw.c
     +@@ contrib/buildsystems/CMakeLists.txt: if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
     + 		compat/win32/syslog.c
     + 		compat/win32/trace2_win32_process_info.c
     + 		compat/win32/dirent.c
     +-		compat/nedmalloc/nedmalloc.c
     + 		compat/strdup.c)
     + 	set(NO_UNIX_SOCKETS 1)
     + 
     +
     + ## meson.build ##
     +@@ meson.build: elif host_machine.system() == 'windows'
     +     'compat/win32/pthread.c',
     +     'compat/win32/syslog.c',
     +     'compat/win32mmap.c',
     +-    'compat/nedmalloc/nedmalloc.c',
     +   ]
     + 
     +   libgit_c_args += [
 -:  ---------- > 2:  7b5daae659 mingw: drop the build-system plumbing for nedmalloc
 -:  ---------- > 3:  a5ccd4dae3 mingw: drop the small nedmalloc auxiliary files
 -:  ---------- > 4:  95682cc2c6 mingw: drop the first chunk of compat/nedmalloc/malloc.c.h
 -:  ---------- > 5:  a605b58586 mingw: drop the second chunk of compat/nedmalloc/malloc.c.h
 -:  ---------- > 6:  90d4137018 mingw: drop the rest of compat/nedmalloc/malloc.c.h

-- 
gitgitgadget
