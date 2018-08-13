Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 253341F404
	for <e@80x24.org>; Mon, 13 Aug 2018 20:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbeHMXEq (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 19:04:46 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34359 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728540AbeHMXEp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 19:04:45 -0400
Received: by mail-wm0-f67.google.com with SMTP id l2-v6so8615011wme.1
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 13:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5uKQrWEF9IrESbvsNwoQqXPTvIp83DTkD5HlZRY2xDc=;
        b=ShRH7oHjT2jUYCA2OQhVNW7AHsP3x7PiB5lEEDUallVTt3zZIYJTOvPB+SmWnhuj61
         CrNkSmGO3JTwz52XLwU5iKmQR8Fxg43LVAH9dsNsdtXaBvrd5nH3Vb/qTtW5nE2vlxr7
         gLZT0LDdSjDjcT1uPm3buK5uRxK6h09pXx/pIw7HWrOmOIHOZZl9abizFDACIAc+508v
         6UFcZ4n/BTuwU9xM7BxVncp+y6bCodK6evG4x/nreHmD2ZD0Zh3/3dRIo+M6xVL1uMH3
         lQ0WdUu/0bIHNGjdOftUQam0v9GPrbVM8xvDIAsOmAB/4HcSdrEHbNQ4Sah1AyCxwpId
         WQZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=5uKQrWEF9IrESbvsNwoQqXPTvIp83DTkD5HlZRY2xDc=;
        b=tME6MevUHoSdwUAa+oswqr00/P/NoNIFUJ47Kelk3EM0bJchyFn3g+sKRhUaiYPIKv
         0bIqkDtRzk131bD8bJamncGwZQffS4yvBqsu7EWJEGuIxHfH5lFzI16EtMrXEfRhwOjK
         fFohjhacp5kVHi2mEyjUSs5zv79buAU91smUxzzmWaz8gPxF8Irh3ikNEEU6FFJNImey
         VUSjTV47SWsmxiN4dWuhJ9tqraAlIMXffpH2/pdkhVO476OiBbAKpXtCMLvSvahIcfQT
         XWHR/mEuQL7QY466rsPf1rGVVmtrZAWDDYCm5/p4L/Roy7ieu0s5ERE/DzCkcRBNpydb
         m61g==
X-Gm-Message-State: AOUpUlEnD70R84DLDc9Z7L8+kN2UJmOKZYnG9rDMRF1QqMGzCgQ5stEd
        P9XdyowsBNKKT3YEsWSBKMk=
X-Google-Smtp-Source: AA+uWPzOxQ61ZLkXvTijXRhfkVcrTg666gRpFTMYWdqFYUdggGkLnjLBaRwJbsnIiuKJmRWXiaQozA==
X-Received: by 2002:a1c:9550:: with SMTP id x77-v6mr8617033wmd.135.1534191657919;
        Mon, 13 Aug 2018 13:20:57 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id i125-v6sm17170690wmd.23.2018.08.13.13.20.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 13:20:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jeff Hostetler <git@jeffhostetler.com>
Subject: Re: [PATCH] mingw: enable atomic O_APPEND
References: <pull.17.git.gitgitgadget@gmail.com>
        <811ded48-6f33-c46e-7bae-b9f7c7e8764c@kdbg.org>
        <xmqqin4i83zg.fsf@gitster-ct.c.googlers.com>
        <bc9132ab-3030-07e3-03d1-d2ddae6a1b45@kdbg.org>
Date:   Mon, 13 Aug 2018 13:20:56 -0700
In-Reply-To: <bc9132ab-3030-07e3-03d1-d2ddae6a1b45@kdbg.org> (Johannes Sixt's
        message of "Mon, 13 Aug 2018 21:02:50 +0200")
Message-ID: <xmqqr2j23tnb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> The Windows CRT implements O_APPEND "manually": on write() calls, the
> file pointer is set to EOF before the data is written. Clearly, this is
> not atomic. And in fact, this is the root cause of failures observed in
> t5552-skipping-fetch-negotiator.sh and t5503-tagfollow.sh, where
> different processes write to the same trace file simultanously; it also
> occurred in t5400-send-pack.sh, but there it was worked around in
> 71406ed4d6 ("t5400: avoid concurrent writes into a trace file",
> 2017-05-18).
>
> Fortunately, Windows does support atomic O_APPEND semantics using the
> file access mode FILE_APPEND_DATA. Provide an implementation that does.
>
> This implementation is minimal in such a way that it only implements
> the open modes that are actually used in the Git code base. Emulation
> for other modes can be added as necessary later. To become aware of
> the necessity early, the unusal error ENOSYS is reported if an
> unsupported mode is encountered.
>
> Diagnosed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Helped-by: Jeff Hostetler <git@jeffhostetler.com>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  compat/mingw.c | 41 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 39 insertions(+), 2 deletions(-)

Nice.

I wonder how much more expensive using this implementation is
compared with the original "race susceptible" open(), when raciness
is known not to be an issue (e.g. there is higher level lock that
protects the appending).

If it turns out to be quite more costly, I do not think we'd mind
introducing a thin wrapper

#ifndef race_safe_append_open
#ifndef race_safe_append_open(fn) open(fn, O_WRONLY|O_APPEND|O_CREAT, 0666)
#endif

in git-compat-util.h after it includes "compat/mingw.h" and replace
the call to open(... O_APPEND ...) in trace.c::get_trace_fd() with a
call to that wrapper.  That way, other codepaths that use O_APPEND
(namely, reflog and todo-list writers) can avoid the additional
cost, if any.

Some may find it beneficial from code readability POV because that
approach marks the codepath that needs to have non-racy fd more
explicitly.

I am assuming that in this case other users of O_APPEND are not
performance critical, so hopefully the following is only theoretical
and not necessary.

 git-compat-util.h | 5 +++++
 trace.c           | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 9a64998b24..a981c50800 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -218,6 +218,11 @@
 #else
 #include <stdint.h>
 #endif
+
+#ifndef race_safe_append_open
+#define race_safe_append_open(fn) open(fn, O_WRONLY|O_APPEND|O_CREAT, 0666)
+#endif
+
 #ifdef NO_INTPTR_T
 /*
  * On I16LP32, ILP32 and LP64 "long" is the save bet, however
diff --git a/trace.c b/trace.c
index fc623e91fd..bef9cee1da 100644
--- a/trace.c
+++ b/trace.c
@@ -47,7 +47,7 @@ static int get_trace_fd(struct trace_key *key)
 	else if (strlen(trace) == 1 && isdigit(*trace))
 		key->fd = atoi(trace);
 	else if (is_absolute_path(trace)) {
-		int fd = open(trace, O_WRONLY | O_APPEND | O_CREAT, 0666);
+		int fd = race_safe_append_open(trace);
 		if (fd == -1) {
 			warning("could not open '%s' for tracing: %s",
 				trace, strerror(errno));
