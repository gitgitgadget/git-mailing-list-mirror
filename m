Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B0061F404
	for <e@80x24.org>; Fri, 10 Aug 2018 19:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbeHJWSh (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 18:18:37 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38745 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbeHJWSg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 18:18:36 -0400
Received: by mail-pf1-f193.google.com with SMTP id x17-v6so4989504pfh.5
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 12:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iInjvwKWV9PElSt1y3/i59iclxb//c1TR/NQf6OyXRU=;
        b=o5tHugc8vuWDu7BXhpTnBnWDi/J4LYQ1k9XEwiLRBkrLrxzI1O6HcbhTj2iNHrgD0i
         YhDCgc13uAN407WvTKQdaDo8fB/m9A9m1w2hOXeYoyHB7pD5VcpPWpciFD52m6SSucol
         G57r4guuyG9bb6YafXiOZ5BY4nbYQyrLV5UZYZsVSycVX8mDvmOhEvppQ83ZquqQcJg1
         a01Uw0pbibKQ1uUvbxFJFELMeWBI6kCCZx/Nfn8+CYJvaUnXt0/xAO7SAvD/ez5e6XYJ
         Gfss0dAU+RZ6827S4j+hVYDpj2VKiY2zGn7wwpBJgjvgKTYfaOed8zksyv6kiT6mERc9
         G/iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iInjvwKWV9PElSt1y3/i59iclxb//c1TR/NQf6OyXRU=;
        b=cYyf+4/W6kj8f7W155dPN5EdUqho40xSx5/U0b7zTyQKFRC6ZRqsUIUukUYAeuC29s
         f0nzJneQRlROsto1fwGaJCDKzeKuP+J10HyDM+cQMP1LHkPCs+H9Jk+mvapSKfNHqHFg
         3BPx9WDZTkqEWI7grCbeiK9IUg2pL0b9OgzdpuEtqeVu6WqhPyNkcoJB3khhTeZ0wenZ
         lTBCtj26Pj5P2Ms7DfLdQ1XFR7+dnXCQYqcuRUTGYSMz7fgQpTQyFQEHsfC6x47ODlcZ
         TlvNwdUDqKw0BcfSK3QOI2F7F6YyHG78Ksslrg7AwSYlGGpTRflXrL+PF2BePDdqpuoX
         UhVw==
X-Gm-Message-State: AOUpUlH9s2pJanRr5AtSEhRn5j7oClmrhL4ihxHKesI1RgfjmAwdBduf
        H74Y+lWLo/ZiJCelDQFNOEKkdwQv
X-Google-Smtp-Source: AA+uWPw0L8r2oNsDSoHZdFU2y+xrWmDdIIoDS7UPyt3foe/BRgyyVKas+T5XrZn0cfM7rooeXxB/+g==
X-Received: by 2002:a62:4fd9:: with SMTP id f86-v6mr8285871pfj.110.1533930439725;
        Fri, 10 Aug 2018 12:47:19 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id n80-v6sm27864696pfb.95.2018.08.10.12.47.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 12:47:18 -0700 (PDT)
Date:   Fri, 10 Aug 2018 12:47:18 -0700 (PDT)
X-Google-Original-Date: Fri, 10 Aug 2018 19:47:12 GMT
Message-Id: <pull.17.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.17.git.gitgitgadget@gmail.com>
References: <pull.17.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/4] t5552: fix flakiness by introducing proper locking for GIT_TRACE
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I reported a couple of times that t5552 is not passing reliably. It has now
reached next, and will no doubt infect master soon.

Turns out that it is not a Windows-specific issue, even if it occurs a lot 
more often on Windows than elsewhere. (And even if it is apparently
impossible to trigger on Linux.)

The culprit is that two processes try to write simultaneously to the same
file specified via GIT_TRACE_PACKET, and it is not well defined how that
should work, even when only looking at the POSIX specification (the
documentation of write()
[http://pubs.opengroup.org/onlinepubs/9699919799/functions/write.html] says
"Applications should use some form of concurrency control.").

This patch series addresses that by locking the trace fd. I chose to use 
fcntl() for the Unix(-y) platforms we support instead of flock() (even if
the latter has much simpler semantics) because fcntl() is in POSIX while 
flock() is not. On Windows, I use the Win32 API function LockFileEx()
[https://docs.microsoft.com/en-us/windows/desktop/api/fileapi/nf-fileapi-lockfileex]
.

Of course, I have to admit that I am not super solid on the fcntl() 
semantics. Junio was nice enough to educate me on l_len = 0 meaning the
entire file. If anybody has more experience with locking file descriptors
referring not to files, but, say, to pipes or to an interactive terminal, I
would be very thankful for help (while the POSIX documentation states that
the errno should be EINVAL on a file descriptor that cannot be locked,
apparently macOS sets errno to EBADF when trying to lock a redirected stdout
)?

Changes since v1:

 * Touched up the cover letter and the first commit message (in particular,
   removed the bogus squash! line giving away just how much I rely on the 
   --autosquash feature these days).
 * Now we're locking the entire file via l_len = 0 (except on Windows).
 * To cover all bases, EINVAL is now also treated as "cannot lock this fd"
   (in addition to EBADF).
 * Removed some superfluous flock()-related left-overs from a previous
   attempt (that caused a lot of me fighting with Linux).

Johannes Schindelin (4):
  Introduce a function to lock/unlock file descriptors when appending
  mingw: implement lock_or_unlock_fd_for_appending()
  trace: lock the trace file to avoid racy trace_write() calls
  trace: verify that locking works

 Makefile               |   1 +
 compat/mingw.c         |  19 ++++++
 compat/mingw.h         |   3 +
 git-compat-util.h      |   2 +
 t/helper/test-tool.c   |   1 +
 t/helper/test-tool.h   |   1 +
 t/helper/test-trace.c  | 130 +++++++++++++++++++++++++++++++++++++++++
 t/t0070-fundamental.sh |   6 ++
 trace.c                |  11 +++-
 wrapper.c              |  16 +++++
 10 files changed, 189 insertions(+), 1 deletion(-)
 create mode 100644 t/helper/test-trace.c


base-commit: 42cc7485a2ec49ecc440c921d2eb0cae4da80549
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-17%2Fdscho%2Ffetch-negotiator-skipping-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-17/dscho/fetch-negotiator-skipping-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/17

Range-diff vs v1:

 1:  e449ed75f ! 1:  a19904682 Introduce a function to lock/unlock file descriptors when appending
     @@ -30,7 +30,7 @@
          added in this commit.
      
          But fcntl() allows a lot more versatile file region locking that we
     -    actually need, to by necessity the fcntl() emulation would be quite
     +    actually need, so by necessity the fcntl() emulation would be quite
          complex: To support the `l_whence = SEEK_CUR` (which we would use, if it
          did not require so much book-keeping due to our writing between locking
          and unlocking the file), we would have to call `SetFilePointerEx()`
     @@ -47,18 +47,16 @@
          to do, as we would once again fail to have an abstraction that clearly
          says what *exact*functionality we want to use.
      
     -    To set a precedent for a better approach, let's introduce a proper
     -    abstraction: a function that says in its name precisely what Git
     -    wants it to do (as opposed to *how* it does it on Linux):
     -    lock_or_unlock_fd_for_appending().
     +    This commit expressly tries to set a precedent for a better approach:
     +    Let's introduce a proper abstraction: a function that says in its name
     +    precisely what Git wants it to do (as opposed to *how* it does it on
     +    Linux): lock_or_unlock_fd_for_appending().
      
          The next commit will provide a Windows-specific implementation of this
          function/functionality.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     -    squash! Introduce a function to lock/unlock file descriptors when appending
     -
      diff --git a/git-compat-util.h b/git-compat-util.h
      --- a/git-compat-util.h
      +++ b/git-compat-util.h
     @@ -86,9 +84,11 @@
      +	struct flock flock;
      +
      +	flock.l_type = lock_it ? F_WRLCK : F_UNLCK;
     ++
     ++	/* (un-)lock the whole file */
      +	flock.l_whence = SEEK_SET;
      +	flock.l_start = 0;
     -+	flock.l_len = 0xffffffff; /* arbitrary number of bytes */
     ++	flock.l_len = 0;
      +
      +	return fcntl(fd, F_SETLKW, &flock);
      +}
 2:  8dda2d530 ! 2:  fa0c282aa mingw: implement lock_or_unlock_fd_for_appending()
     @@ -54,24 +54,3 @@
       #define has_dos_drive_prefix(path) \
       	(isalpha(*(path)) && (path)[1] == ':' ? 2 : 0)
       int mingw_skip_dos_drive_prefix(char **path);
     -
     -diff --git a/config.mak.uname b/config.mak.uname
     ---- a/config.mak.uname
     -+++ b/config.mak.uname
     -@@
     - 	NO_POSIX_GOODIES = UnfortunatelyYes
     - 	NATIVE_CRLF = YesPlease
     - 	DEFAULT_HELP_FORMAT = html
     -+	HAVE_FLOCK = YesWeEmulate
     - 
     - 	CC = compat/vcbuild/scripts/clink.pl
     - 	AR = compat/vcbuild/scripts/lib.pl
     -@@
     - 	NO_INET_NTOP = YesPlease
     - 	NO_POSIX_GOODIES = UnfortunatelyYes
     - 	DEFAULT_HELP_FORMAT = html
     -+	HAVE_FLOCK = YesWeEmulate
     -+
     - 	COMPAT_CFLAGS += -DNOGDI -Icompat -Icompat/win32
     - 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
     - 	COMPAT_OBJS += compat/mingw.o compat/winansi.o \
 3:  a53e72198 ! 3:  1f5c15c7e trace: lock the trace file to avoid racy trace_write() calls
     @@ -14,6 +14,17 @@
          To remedy this, let's lock the file descriptors for exclusive writing,
          using the function we just introduced in the previous commit.
      
     +    Note: while the POSIX documentation of fcntl() at
     +    http://pubs.opengroup.org/onlinepubs/9699919799/functions/fcntl.html
     +    suggests that the `errno` is set to `EINVAL` when being asked to
     +    lock a file descriptor that cannot be locked, on macOS it results in
     +    `EBADF` when trying to lock a redirected `stdout` (which the
     +    documentation claims should indicate that the file descriptor is not
     +    valid for writing).
     +
     +    To cover all our bases, we simply treat both `EINVAL` and `EBADF` as
     +    indicators that we cannot lock/unlock this file descriptor.
     +
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
      diff --git a/trace.c b/trace.c
     @@ -27,7 +38,7 @@
      +	int fd = get_trace_fd(key), locked;
      +
      +	locked = !lock_or_unlock_fd_for_appending(fd, 1);
     -+	if (!locked && errno != EBADF)
     ++	if (!locked && errno != EBADF && errno != EINVAL)
      +		warning("unable to lock file descriptor for %s: %s",
      +			key->key, strerror(errno));
      +	if (write_in_full(fd, buf, len) < 0) {
 4:  f57234154 ! 4:  38358ac74 trace: verify that locking works
     @@ -131,13 +131,13 @@
      +		strbuf_rtrim(&buf);
      +		if (!strcmp("lock", buf.buf)) {
      +			if (lock_or_unlock_fd_for_appending(fd, 1) < 0 &&
     -+			    errno != EBADF)
     ++			    errno != EBADF && errno != EINVAL)
      +				die_errno("'%s': lock", child_name);
      +			ACK("lock");
      +			locked = 1;
      +		} else if (!strcmp("unlock", buf.buf)) {
      +			if (lock_or_unlock_fd_for_appending(fd, 0) < 0 &&
     -+			    errno != EBADF)
     ++			    errno != EBADF && errno != EINVAL)
      +				die_errno("'%s': unlock", child_name);
      +			ACK("unlock");
      +			locked = 0;

-- 
gitgitgadget
