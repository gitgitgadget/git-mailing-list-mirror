Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52B061F405
	for <e@80x24.org>; Thu,  9 Aug 2018 17:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732368AbeHIUBU (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 16:01:20 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:42516 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731115AbeHIUBU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 16:01:20 -0400
Received: by mail-pl0-f65.google.com with SMTP id g6-v6so2836025plq.9
        for <git@vger.kernel.org>; Thu, 09 Aug 2018 10:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uQVZYKpQVYtjzHCBco0ng1VLyXfp+HeUTldyGl7pdoI=;
        b=oEe+fDCDOVevGFzeoioujy0cLDyFLMXzbd7Y7CKD3YPt3rYPViutUS3aBo61H2N/qH
         +TOpW0cPY4TItnjT1Pg1jHEmBJ5w1KJR56Cu9kEz4nALIAEm4Zm4VyQ97PuCco3W6dGc
         QEY5eJUk1cIPWnHva0dNrYjI2lcYvMGzaPsP6Q4/9EbfUccXlg3aTgwHVbE/v75fcsSL
         zVxHZpNgk4hOjyWt1FUVTsS64JET8iOZfASD/q2rnBQIWMU25W71B31zpGXM34mthKW8
         iCThfg3ck3uc0iDtXpKwcvdxLMe8mVWQFDEzP8bdzQouSGwgSC8vPNLl4ncyzVNHAXZp
         q57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uQVZYKpQVYtjzHCBco0ng1VLyXfp+HeUTldyGl7pdoI=;
        b=eKNgRJhN116vFavOyTWDbDEFRAx4z4Qjk+xHyvXPd4oxr6WBMLPm+7+zt/N1uBbiEG
         AJBBat8sVbbKGp0jPesHJkXgRQfTRhtG0Z2bXqhJrOFuFD5NCC10E7/36ZY8d7jpJBi5
         xoijCX4lxh3Y/TJMxQFgSHLnDoUNF37KvN50tBztYg84rqXUOVNKDpbEZLPGtg6ZUibY
         1j0PgNElM0i95kqcb41dKFmXqm8y/YboJZK4xa+biP9zapR3k9Hwzio0RmOtJO7su9u8
         zhZtCZZJcObQODjolQuHRaDXe/NRms2UuqdHyuG+4IKYtkx9FyzUr8N4CQhw/AnwChYE
         KVsA==
X-Gm-Message-State: AOUpUlEmcG1IzC/ivEojXng9B+uGjHfDnhIKS8JKhF2WgMpfFEofATOo
        6N7dMBAWor/BAj6cINZgai1wzNJE
X-Google-Smtp-Source: AA+uWPzp7bmnQrLhmOz+QMyNMf7Q9MfORQvvT9nui+fGFNcjW4cQMT4f2ovUTA8dzGTWAg2pI/+xfg==
X-Received: by 2002:a17:902:8ec8:: with SMTP id x8-v6mr2068710plo.308.1533836126538;
        Thu, 09 Aug 2018 10:35:26 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id p64-v6sm13777179pfa.47.2018.08.09.10.35.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 10:35:25 -0700 (PDT)
Date:   Thu, 09 Aug 2018 10:35:25 -0700 (PDT)
X-Google-Original-Date: Thu, 09 Aug 2018 17:35:18 GMT
Message-Id: <e449ed75fe3705692175017f98438815aeccf0fb.1533836122.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.17.git.gitgitgadget@gmail.com>
References: <pull.17.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/4] Introduce a function to lock/unlock file descriptors when
 appending
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This function will be used to make write accesses in trace_write() a bit
safer.

Note: this patch takes a very different approach for cross-platform
support than Git is historically taking: the original approach is to
first implement everything on Linux, using the functions available on
Linux, and then trying to emulate these functions on platforms that do
not have those functions such as Windows.

This leads to all kinds of undesirable quirks in Git's source code (and
performance characteristics) because of the lack of a proper abstraction
layer: instead of declaring functions for the functionality we
*actually* need, we abuse POSIX functions to say what we need, even if
those functions serve much broader purposes (and do not make at all
clear what the caller wants of them).

For example, when Git wants to determine whether a path refers to a
symbolic link, it calls lstat(). That POSIX function has to be emulated
on Windows, painstakingly filling all the information lstat() would,
only for the caller to throw away everything except that one bit of
information, and all of the time figuring out the mtime/atime/ctime and
file size and whatnot was spent in vain.

If we were to follow that approach, we would extend the fcntl()
emulation in compat/mingw.c after this commit, to support the function
added in this commit.

But fcntl() allows a lot more versatile file region locking that we
actually need, to by necessity the fcntl() emulation would be quite
complex: To support the `l_whence = SEEK_CUR` (which we would use, if it
did not require so much book-keeping due to our writing between locking
and unlocking the file), we would have to call `SetFilePointerEx()`
(after obtaining the `HANDLE` on which all Win32 API functions work
instead of the integer file descriptors used by all POSIX functions).
Multiplying the number of Win32 API round-trips. Of course, we could
implement an incomplete emulation of fcntl()'s F_WRLCK, but that would
be unsatisfying.

An alternative approach would be to use the `flock()` function, whose
semantics are much closer to existing Win32 API. But `flock()` is not
even a POSIX standard, so we would have to implement emulation of
`flock()` for *other* platforms. And it would again be the wrong thing
to do, as we would once again fail to have an abstraction that clearly
says what *exact*functionality we want to use.

To set a precedent for a better approach, let's introduce a proper
abstraction: a function that says in its name precisely what Git
wants it to do (as opposed to *how* it does it on Linux):
lock_or_unlock_fd_for_appending().

The next commit will provide a Windows-specific implementation of this
function/functionality.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

squash! Introduce a function to lock/unlock file descriptors when appending
---
 git-compat-util.h |  2 ++
 wrapper.c         | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 9a64998b2..13b83bade 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1202,6 +1202,8 @@ struct tm *git_gmtime_r(const time_t *, struct tm *);
 #define getc_unlocked(fh) getc(fh)
 #endif
 
+extern int lock_or_unlock_fd_for_appending(int fd, int lock_it);
+
 /*
  * Our code often opens a path to an optional file, to work on its
  * contents when we can successfully open it.  We can ignore a failure
diff --git a/wrapper.c b/wrapper.c
index e4fa9d84c..6c2116272 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -690,3 +690,17 @@ int xgethostname(char *buf, size_t len)
 		buf[len - 1] = 0;
 	return ret;
 }
+
+#ifndef GIT_WINDOWS_NATIVE
+int lock_or_unlock_fd_for_appending(int fd, int lock_it)
+{
+	struct flock flock;
+
+	flock.l_type = lock_it ? F_WRLCK : F_UNLCK;
+	flock.l_whence = SEEK_SET;
+	flock.l_start = 0;
+	flock.l_len = 0xffffffff; /* arbitrary number of bytes */
+
+	return fcntl(fd, F_SETLKW, &flock);
+}
+#endif
-- 
gitgitgadget

