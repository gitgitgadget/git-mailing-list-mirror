Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C76241F453
	for <e@80x24.org>; Tue, 12 Feb 2019 18:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731978AbfBLSmP (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 13:42:15 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53166 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727469AbfBLSmO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 13:42:14 -0500
Received: by mail-wm1-f67.google.com with SMTP id m1so4180432wml.2
        for <git@vger.kernel.org>; Tue, 12 Feb 2019 10:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=b2w33TJ5LFbiwKaOJGq4BlKt2J6g8sGYuQUet+w1J1s=;
        b=aFBF0C6gkW/yvhiVoqtXAJFZXLG8ufGgGgERg0S7Pa83udcFuI0B0XHhaQEyUB/d8d
         4mP8ykIsl00JJAWof2SYhRvB0Rbe0Uv2+F0PGuIj2Qo0VSl7jy9zsWE10EGlDXCKE2c2
         KviFVyCCJXbc+LJHQ6Wr5aPWZmyhePVoo0Wuz4ObL1RU2Sq6vuz60FjOCtLWsQtWN33n
         sfiBSGq0M0bGtANXy9BidB3YJwppTO6vQGdPXFDPHHT+xjOQQoRbFV92jmbm7SHuc5bv
         4vl46XO80EBLQj8eF36dnYAqvd36CaPa+uxawx2EoWH8+E8wimh/5avFHKZFDTtRMg+L
         mm/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=b2w33TJ5LFbiwKaOJGq4BlKt2J6g8sGYuQUet+w1J1s=;
        b=JNRC6ncGdsa0Qtck/Mra2ykx8iis5Btx5Gjm+1SlEqTkpKiyME1m+S7T6jK1Tfd7Th
         eTBKYiTy+ipWL5e8oq0JXGJnk4gyNSM9G8QU6vyvqkxwoxA/guPKygCVSgENvC8dnuNL
         bCui0b1bqosTT9tPgCLBhgKI63FdrP/6aGFeaTvqDhd7KkC52ZNj0lLLkxXI4Js0CM/+
         vrd4CVRsQtPVhJnCee1vh6vUIN12PPGHbJifcPcdBJJi17qRqA0lWcPWqhIFOBuomoik
         MzNmAYCLjPtJskUAxm7D5I6yA60RQBSVayTTlwV5m3JLPyV16ck1RfdqR9oj4ppXeQRV
         3k2g==
X-Gm-Message-State: AHQUAuahT/4jh1+4Z/Lnf+BffzUubTJfmEkM7RexHq7/t52PKd94oDtY
        W/8LkEBINJqqy5SWLAmkvjJ9ckDB
X-Google-Smtp-Source: AHgI3IYovNekM7ABw5e4HMcFHEWv+jSaHcGwyX2PnM2wej/IpjZT50VsL+oj65KAnL7aX8XTzPjoYQ==
X-Received: by 2002:a1c:20d0:: with SMTP id g199mr182656wmg.111.1549996931749;
        Tue, 12 Feb 2019 10:42:11 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z1sm8370418wrw.28.2019.02.12.10.42.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 10:42:10 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, git-packagers@googlegroups.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git v2.21.0-rc0 broken on *BSD, maybe others
References: <xmqqh8dgqcqn.fsf@gitster-ct.c.googlers.com>
        <87sgwtjjbk.fsf@evledraar.gmail.com> <20190212124323.GA11677@ash>
        <xmqqlg2ldjg4.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 12 Feb 2019 10:42:10 -0800
In-Reply-To: <xmqqlg2ldjg4.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 12 Feb 2019 09:07:23 -0800")
Message-ID: <xmqqr2ccdf25.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> If I find time later in the day, I may forge your sign-off and
> fabricate log messages for both patches, but unfortunately I need to
> run a long errand today during the day, so it may not happen.

And here is the other one.  I have the s/is/if/ typofix already in there.

-- >8 --
From: Duy Nguyen <pclouds@gmail.com>
Date: Tue, 12 Feb 2019 21:14:41 +0700
Subject: [PATCH] git-compat-util: work around fileno(fp) that is a macro

On various BSD's, fileno(fp) is implemented as a macro that directly
accesses the fields in the FILE * object, which breaks a function that
accepts a "void *fp" parameter and calls fileno(fp) and expect it to
work.

Work it around by adding a compile-time knob FILENO_IS_A_MACRO that
inserts a real helper function in the middle of the callchain.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile          | 7 +++++++
 compat/fileno.c   | 7 +++++++
 config.mak.uname  | 2 ++
 git-compat-util.h | 8 ++++++++
 4 files changed, 24 insertions(+)
 create mode 100644 compat/fileno.c

diff --git a/Makefile b/Makefile
index 1a44c811aa..08d9961425 100644
--- a/Makefile
+++ b/Makefile
@@ -427,6 +427,8 @@ all::
 #
 # Define HAVE_GETDELIM if your system has the getdelim() function.
 #
+# Define FILENO_IS_A_MACRO if fileno() is a macro, not a real function.
+#
 # Define PAGER_ENV to a SP separated VAR=VAL pairs to define
 # default environment variables to be passed when a pager is spawned, e.g.
 #
@@ -1773,6 +1775,11 @@ ifdef HAVE_WPGMPTR
 	BASIC_CFLAGS += -DHAVE_WPGMPTR
 endif
 
+ifdef FILENO_IS_A_MACRO
+	COMPAT_CFLAGS += -DFILENO_IS_A_MACRO
+	COMPAT_OBJS += compat/fileno.o
+endif
+
 ifeq ($(TCLTK_PATH),)
 NO_TCLTK = NoThanks
 endif
diff --git a/compat/fileno.c b/compat/fileno.c
new file mode 100644
index 0000000000..7b105f4cd7
--- /dev/null
+++ b/compat/fileno.c
@@ -0,0 +1,7 @@
+#define COMPAT_CODE
+#include "../git-compat-util.h"
+
+int git_fileno(FILE *stream)
+{
+	return fileno(stream);
+}
diff --git a/config.mak.uname b/config.mak.uname
index 3ee7da0e23..23eac5ac9d 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -221,6 +221,7 @@ ifeq ($(uname_S),FreeBSD)
 	HAVE_BSD_KERN_PROC_SYSCTL = YesPlease
 	PAGER_ENV = LESS=FRX LV=-c MORE=FRX
 	FREAD_READS_DIRECTORIES = UnfortunatelyYes
+	FILENO_IS_A_MACRO = UnfortunatelyYes
 endif
 ifeq ($(uname_S),OpenBSD)
 	NO_STRCASESTR = YesPlease
@@ -233,6 +234,7 @@ ifeq ($(uname_S),OpenBSD)
 	HAVE_BSD_SYSCTL = YesPlease
 	HAVE_BSD_KERN_PROC_SYSCTL = YesPlease
 	PROCFS_EXECUTABLE_PATH = /proc/curproc/file
+	FILENO_IS_A_MACRO = UnfortunatelyYes
 endif
 ifeq ($(uname_S),MirBSD)
 	NO_STRCASESTR = YesPlease
diff --git a/git-compat-util.h b/git-compat-util.h
index 09b0102cae..7899f42f5e 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1220,6 +1220,14 @@ struct tm *git_gmtime_r(const time_t *, struct tm *);
 #define getc_unlocked(fh) getc(fh)
 #endif
 
+#ifdef FILENO_IS_A_MACRO
+int git_fileno(FILE *stream);
+# ifndef COMPAT_CODE
+#  undef fileno
+#  define fileno(p) git_fileno(p)
+# endif
+#endif
+
 /*
  * Our code often opens a path to an optional file, to work on its
  * contents when we can successfully open it.  We can ignore a failure
-- 
2.21.0-rc0-36-ge9bd4aa026

