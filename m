Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 909FF1F453
	for <e@80x24.org>; Tue, 12 Feb 2019 13:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729886AbfBLNpo (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 08:45:44 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38783 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbfBLNpo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 08:45:44 -0500
Received: by mail-pf1-f194.google.com with SMTP id q1so1325134pfi.5
        for <git@vger.kernel.org>; Tue, 12 Feb 2019 05:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jbP10s+dkZx37EtARnpbE7Pfk5d3u8JdvlFSEDlqMak=;
        b=EbvjcpxMbe2GT6CEwRljtqLkbRSB3ms3MBPM2vo7XLgcyOM4ivWEBbm9sZW1Vw4SZq
         ABDpXdC0aqf/U47LBr/kxVK9VbJjFvrMhTnoiApJSeNl3Fj6sabXRV7eMDgZTiDJqBR8
         kx1kA9ivNix75fapKK2LLWJHu+sKEAiDOXBl1az48ynldbPUl+oJYaNYm0qR8X6Zy4Rh
         OcBrthQp8d90Y6TQ7wUB2/9l8yl0Nvu1av2jckz4xOi57G4hD10CltjXFmDrutGbofEJ
         P6MLQH69VP7kLGqzOcEuypO4FHgK8AUiey65DqZ+a4JkgFTZEFlxG6eR6bi+rUzj5Dfu
         AmjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jbP10s+dkZx37EtARnpbE7Pfk5d3u8JdvlFSEDlqMak=;
        b=YVzY77sr0mEwFzPO8dWxAlN+rZFtkwp9gge8bqxM8GpfyQOFS2k/CMndxQGorOdeEY
         e1see71WzXIBpQI3JsEaRYw9k09xEQZutlkCxZ8P0ChC+hvUt0lpLTM6ROUpeigPe+yV
         QLoXQnfZ/JahoqHlKapNszwWRKR799tHv5jNBy/N6LcZA0iR4viWqDClQj4+wrcO0JYr
         gEP5iLklyuZlW0K6RGFWcYP8zN8AUnVu9GlfJjNUj0lcbyHyoeK1ru86TVYOyRKD88uO
         dZNxWg+B/eXeqC3bfX4JdJ8+xKHGEDhLGZ8LkOV9d0zdz4vWh31WivsUD9VZpS2pDCTh
         l+ww==
X-Gm-Message-State: AHQUAua5vH+d1DfRpfKkg24XE0H67HTFbGejFiIWP1S+3gnUBraEulCi
        xLJvEnZ5SbD86jDt8azvW3I=
X-Google-Smtp-Source: AHgI3IbKuvrQaTcuiNJuC6477VZ8H9StLt2AhICFFoaNZNIK9tKM6UhBGXByuYXun7T/KQMIADdUAQ==
X-Received: by 2002:aa7:8293:: with SMTP id s19mr1033256pfm.252.1549979142730;
        Tue, 12 Feb 2019 05:45:42 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id n13sm15094109pgp.81.2019.02.12.05.45.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 05:45:41 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 12 Feb 2019 20:45:37 +0700
Date:   Tue, 12 Feb 2019 20:45:37 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Dan McGregor <dan.mcgregor@usask.ca>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-compat-util: undefine fileno if defined
Message-ID: <20190212134537.GA26137@ash>
References: <20190201193004.88736-1-dan.mcgregor@usask.ca>
 <20190209023621.75255-1-dan.mcgregor@usask.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190209023621.75255-1-dan.mcgregor@usask.ca>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 08, 2019 at 08:36:21PM -0600, Dan McGregor wrote:
> Commit 8dd2e88a92 ("http: support file handles for HTTP_KEEP_ERROR",
> 2019-01-10) introduced an implicit assumption that rewind, fileno, and
> fflush are functions. At least on FreeBSD fileno is not, and as such
> passing a void * failed.
> 
> All systems tested (FreeBSD and NetBSD) that define fineo as a macro

OpenBSD or NetBSD? From this [1], it looks like OpenBSD fails while
NetBSD compiles ok (and fails to run some tests)

[1] https://gitlab.com/git-vcs/git-ci/pipelines/47139741/failures

> also have a function defined. Undefine the macro on these systems so
> that the function is used.

I don't think this is enough. At least fbsd defines this

#define    fileno(p)    (!__isthreaded ? __sfileno(p) : (fileno)(p))

so one of the two functions will be used depending on __isthreaded
flag. Your forcing to use fileno, ignoring __sfileno, is technically
not correct.

For the record, at least fbsd also defines feof, ferror, clearerr,
getc and putc in the same way. But at least I don't see how something
like feof(fp++) could cause bad side effects.

So, how about something like this? A teeny bit longer than your
version, but I think it's easier to control long term.

-- 8< --
diff --git a/Makefile b/Makefile
index 0e13a5b469..44cfc63fc4 100644
--- a/Makefile
+++ b/Makefile
@@ -433,6 +433,8 @@ all::
 #
 # Define HAVE_GETDELIM if your system has the getdelim() function.
 #
+# Define FILENO_IS_A_MACRO is fileno() is a macro, not a real function.
+#
 # Define PAGER_ENV to a SP separated VAR=VAL pairs to define
 # default environment variables to be passed when a pager is spawned, e.g.
 #
@@ -1800,6 +1802,11 @@ ifdef HAVE_WPGMPTR
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
index 786bb2f913..01f62674a4 100644
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
@@ -234,6 +235,7 @@ ifeq ($(uname_S),OpenBSD)
 	HAVE_BSD_KERN_PROC_SYSCTL = YesPlease
 	PROCFS_EXECUTABLE_PATH = /proc/curproc/file
 	FREAD_READS_DIRECTORIES = UnfortunatelyYes
+	FILENO_IS_A_MACRO = UnfortunatelyYes
 endif
 ifeq ($(uname_S),MirBSD)
 	NO_STRCASESTR = YesPlease
diff --git a/git-compat-util.h b/git-compat-util.h
index 29a19902aa..6573808ebd 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1234,6 +1234,14 @@ struct tm *git_gmtime_r(const time_t *, struct tm *);
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
-- 8< --

--
Duy
