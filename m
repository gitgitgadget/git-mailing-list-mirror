Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8C571F407
	for <e@80x24.org>; Sat,  9 Dec 2017 09:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751149AbdLIJnZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Dec 2017 04:43:25 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:34917 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751145AbdLIJnU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Dec 2017 04:43:20 -0500
Received: by mail-io0-f195.google.com with SMTP id r13so1405090iod.2
        for <git@vger.kernel.org>; Sat, 09 Dec 2017 01:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I5o0u6EmT5NsrCpfZUee5NKzh8oNcHSuY8Wv2CmWk1k=;
        b=SXryJpWchZepDx0SYuqeJgY4WXxCsxdzRww/DsTOB+uCnWt7lGAa6oGxrJUISUkqMA
         US6GNXn5+kyVfNyOkZ+7OCTZi60nfSn0GXs8rlE2NWb+2uQXHCxHTTU4GkQqxnQ4Jt0X
         0Ukb0FR+0hbFHXz87pBzNcH2RhngYXgyhtc5hCP/13BkObhsLHTyHK2u/HeSBVTWOjm1
         SIvUIXYw3l5J16JpA3eqBB0GflqKcJMadjN4jZSlta1D+XR9UOnqSgPOUGnVJJdimiwG
         Cp91W22Lu9fk9FAHS4WBSMm6b97IIIZWJYLXSLx4fJv+jRqak2GXeJRE4OQ/12bVHf0h
         9MpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=I5o0u6EmT5NsrCpfZUee5NKzh8oNcHSuY8Wv2CmWk1k=;
        b=cQI0OCoJUESkicwr7AEW87FcMDoIkDBktiop59chmMtjZwFM/vmbkEn7qgqau0ykPB
         B3dV18cG9vCN6WJDU+UZGmb5yAdEIBLA1RCXyoFXAb1l5qNxCpm1trDqja1DkTMY4+Xs
         odD1jpNXNK8vUuELVA3p3JbZ4ae3Xh8Aze1zTdisIVF9wUY3tlj0onpexNwfqS9MKpAL
         JlkcB0DaYcKsfMSl/BH5u9Gn5HXk351UQvv5i4v/Kvga9aT/MMYtPwj46M6V1nnezUvY
         iq7szJmu2up0yye27qO1hlGAPb4EGUmimUyAmchmPgszOnMT7dziAQsjY1bQeyMQfwqk
         oLSQ==
X-Gm-Message-State: AJaThX6IPEKImuLnZtgkoIdjm7LE2EeASd3GICfzEf/uEnpAGTsrIjoj
        0uPhiqqKlDxQ7oDRZhAIZYo=
X-Google-Smtp-Source: AGs4zMaY5oKSXo+ag+uB1v1VjoDbFPWyCOr1FJa8BUX2zFGKXoPEOLle1x1uFDiGQXOceeP9YN+odQ==
X-Received: by 10.107.129.139 with SMTP id l11mr46026691ioi.143.1512812599814;
        Sat, 09 Dec 2017 01:43:19 -0800 (PST)
Received: from flurp.local (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id m21sm1709354itb.43.2017.12.09.01.43.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Dec 2017 01:43:19 -0800 (PST)
Date:   Sat, 9 Dec 2017 04:43:10 -0500
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git List <git@vger.kernel.org>,
        Adric Norris <landstander668@gmail.com>
Subject: Re: [PATCH 1/2] git version --build-options: report the build
 platform, too
Message-ID: <20171209094310.GA60808@flurp.local>
References: <cover.1512752468.git.johannes.schindelin@gmx.de>
 <978adf12e85ec6c4d407ba09da82945a08ee1f8c.1512752468.git.johannes.schindelin@gmx.de>
 <20171208172324.GB14261@aiede.mtv.corp.google.com>
 <xmqq374l9kti.fsf@gitster.mtv.corp.google.com>
 <CAPig+cRrVRJ+H7c5Q3zLj6gjPegLFQmngGtiezgxTBTDqWSj0g@mail.gmail.com>
 <CAPig+cTq1LgRK_jXgLn+VY_qtDAJ27Ja-Uf-NwdG2g=tv9c=Yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cTq1LgRK_jXgLn+VY_qtDAJ27Ja-Uf-NwdG2g=tv9c=Yg@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 08, 2017 at 04:19:25PM -0500, Eric Sunshine wrote:
> On Fri, Dec 8, 2017 at 4:17 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> > On Fri, Dec 8, 2017 at 12:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
> >> Jonathan Nieder <jrnieder@gmail.com> writes:
> >>> Can this use GIT_BUILD_PLATFORM directly instead of going via the indirection
> >>> of a mutable static string?  That is, something like
> >>>
> >>>               printf("machine: %s\n", GIT_BUILD_PLATFORM);
> >>
> >> Good point.  And if this is externally identified as "machine",
> >> probably the macro should also use the same word, not "platform".
> >> We can go either way, as long as we are consistent, though.
> >
> > In Autoconf parlance, this would be called "host architecture" (GIT_HOST_ARCH).
> 
> My bad: "host cpu", rather (GIT_HOST_CPU).

Dscho, when you re-roll, perhaps replace the current patch with the
one below which determines the CPU type automatically rather than
having to manually maintain and augment a bunch of #ifdefs in help.h.

I took the liberty of renaming the #define to GIT_HOST_CPU to better
match Autoconf parlance since its conceivable that Git might some day
support cross-compilation officially via the configure script (which
doesn't yet work, though I have some patches which begin addressing
that, but that's a separate topic).

The original plan was to keep Adric Norris as author, but by the time
the patch was done and the commit message rewritten to match, I
realized that none of his work remained, thus ended up dropping his
authorship and both of your sign-offs. Sorry.

--- >8 ---
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sat, 9 Dec 2017 04:09:18 -0500
Subject: [PATCH] help: version --build-options: also report host CPU

It can be helpful for bug reports to include information about the
environment in which the bug occurs. "git version --build-options" can
help to supplement this information. In addition to the size of 'long'
already reported by --build-options, also report the host's CPU type.
Example output:

   $ git version --build-options
   git version 2.9.3.windows.2.826.g06c0f2f
   cpu: x86_64
   sizeof-long: 4

New Makefile variable HOST_CPU supports cross-compiling.

Suggested-by: Adric Norris <landstander668@gmail.com>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Makefile | 9 +++++++++
 help.c   | 1 +
 2 files changed, 10 insertions(+)

diff --git a/Makefile b/Makefile
index fef9c8d272..5587bccc93 100644
--- a/Makefile
+++ b/Makefile
@@ -425,6 +425,9 @@ all::
 #
 # to say "export LESS=FRX (and LV=-c) if the environment variable
 # LESS (and LV) is not set, respectively".
+#
+# When cross-compiling, define HOST_CPU as the canonical name of the CPU on
+# which the built Git will run (for instance "x86_64").
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -1095,6 +1098,12 @@ else
 BROKEN_PATH_FIX = '/^\# @@BROKEN_PATH_FIX@@$$/d'
 endif
 
+ifeq (,$(HOST_CPU))
+	BASIC_CFLAGS += -DGIT_HOST_CPU="\"$(firstword $(subst -, ,$(uname_M)))\""
+else
+	BASIC_CFLAGS += -DGIT_HOST_CPU="\"$(HOST_CPU)\""
+endif
+
 ifneq (,$(INLINE))
 	BASIC_CFLAGS += -Dinline=$(INLINE)
 endif
diff --git a/help.c b/help.c
index 88a3aeaeb9..cbcb159f36 100644
--- a/help.c
+++ b/help.c
@@ -412,6 +412,7 @@ int cmd_version(int argc, const char **argv, const char *prefix)
 	printf("git version %s\n", git_version_string);
 
 	if (build_options) {
+		printf("cpu: %s\n", GIT_HOST_CPU);
 		printf("sizeof-long: %d\n", (int)sizeof(long));
 		/* NEEDSWORK: also save and output GIT-BUILD_OPTIONS? */
 	}
-- 
2.15.1.502.gccaef8de57

