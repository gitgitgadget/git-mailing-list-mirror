Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9B2A1F4F8
	for <e@80x24.org>; Fri,  7 Oct 2016 11:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752824AbcJGLbP (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 07:31:15 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35233 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752243AbcJGLbN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 07:31:13 -0400
Received: by mail-wm0-f68.google.com with SMTP id f193so2512927wmg.2
        for <git@vger.kernel.org>; Fri, 07 Oct 2016 04:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=N90Zie+R4USnNwU0vJGGkfci7oAXMvG7Puak9BfJIC0=;
        b=ZJtmS2bh1zeMpASHCOxqlG/eWz1QOuh1QhXBErCrzyhEDnWhYPmC0jY0CwPMb4N4Bb
         H2VTn7NWbAAQ/dWwuTqMS3jQsWOYB3Q6hZQscOaFCHJVwChjMzz0q3ZpMAfR7zNaEprl
         XvKi/mY4KsVrmu4LSTaHWN0AsFkifoIRdiI61damJzj7UJo3Ve3Lxh0LKG15Sz8fccnS
         nf8VBRUwID3e7IvdtSSzZOPtW68WZDjqhxsYuzBCPpwqEdQKUUlFPQ0M6Fc3TkNnGLmP
         icfSxlG8SAuDx+RInKiACLX687fW+yLWfo/kpco+R6FTU7eenP4ncBtc2/eoKX1A1cTT
         KJKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=N90Zie+R4USnNwU0vJGGkfci7oAXMvG7Puak9BfJIC0=;
        b=HHbUrtCr6YKMrip1mV3/eZpDIm1DAn6T8I+CSv5mw9myQcds6Wk9il/dYZGhJe9sui
         Uucfpyl1qb1nQVeFmTKZuEUFA+aJ6vIT+J7X296vBYDdemSfnYAXjNFyaHYf1w+8x5Iv
         pAkR7xYquKK+sQ1XTHCTGDnnNbSLvCqqlO/9lpt3c8VSjr1i4QrL4+aNpZDzvVFD+cs0
         Tql3kGNRTDjrHAL37HBMEA+yUOX/Qbcd5tEA8WYPGYuBkZA/ZY+p7BiUf+BzuTqNN3U1
         mx/24Jc6lPBYXPi366HBZ6JEG7GsPDgNimRs2TUANlQZW/43m3Yjljl0A98mR+N0CM8c
         5GcQ==
X-Gm-Message-State: AA6/9RkdPwvL4fKuuWA1r6Nn2bwqilNeqpqo8e/Wro3eu0Sd8B6avQU7QUzOYgugqqRDvA==
X-Received: by 10.194.105.104 with SMTP id gl8mr16700320wjb.83.1475839871763;
        Fri, 07 Oct 2016 04:31:11 -0700 (PDT)
Received: from [192.168.1.26] (dat198.neoplus.adsl.tpnet.pl. [83.23.19.198])
        by smtp.googlemail.com with ESMTPSA id w3sm2548347wmd.13.2016.10.07.04.31.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Oct 2016 04:31:10 -0700 (PDT)
Subject: Re: Regression: git no longer works with musl libc's regex impl
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
References: <20161004150848.GA7949@brightrain.aerifal.cx>
 <20161004152722.ex2nox43oj5ak4yi@sigill.intra.peff.net>
 <20161004154045.GT19318@brightrain.aerifal.cx>
 <alpine.DEB.2.20.1610041802310.35196@virtualbox>
 <CACBZZX4XPqZauD_M_ieOwVauT1fi3MQb4+6taELQaRG9M-Kz_w@mail.gmail.com>
 <20336ac7-a494-d725-f928-834b1b3194fe@ramsayjones.plus.com>
Cc:     Rich Felker <dalias@libc.org>, Jeff King <peff@peff.net>,
        musl@lists.openwall.com
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <4615e3c4-9793-3dce-c500-9091a9056379@gmail.com>
Date:   Fri, 7 Oct 2016 13:30:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20336ac7-a494-d725-f928-834b1b3194fe@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 07.10.2016 o 00:42, Ramsay Jones pisze: 
> On 06/10/16 20:18, Ævar Arnfjörð Bjarmason wrote:
[...]
>> But just to clarify, does anyone have any objection to making our
>> configure.ac compile a C program to check for this sort of thing?
>> Because that seems like the easiest solution to this class of problem.
> 
> Err, you do know that we already do that, right?
> 
> [see commit a1e3b669 ("autoconf: don't use platform regex if it lacks REG_STARTEND", 17-08-2010)]
> 
> In fact, if you run the auto tools on cygwin, you get a different setting
> for NO_REGEX than via config.mak.uname. Which is why I don't run configure
> on cygwin. :-D
> 
> [The issue is exposed by t7008-grep-binary.sh, where the cygwin native
> regex library matches '.' in a pattern with the NUL character. ie the
> test_expect_failure test passes.]

Huh.  So we have NO_REGEX support in ./configure, and people using
Git on untypical architectures and systems *can* make use of it.

It was just described wrongly, so in turn to have the more neutral
description, the same as in Makefile, let's do this:

-------- >8 ---------- >8 ------------- >8 ---------- >8 ----------
Subject: [PATCH] configure.ac: Improve description of NO_REGEX test

The commit 2f8952250a changed description of NO_REGEX build config
variable to be more neutral, and actually say that it is about
support for REG_STARTEND.  Change description in configure.ac to
be the same.

Change also the test message and variable name to match.  The test
just checks that REG_STARTEND is #defined.

Issue-found-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Jakub Narębski <jnareb@gmail.com>
---
 configure.ac | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/configure.ac b/configure.ac
index aa9c91d..7f39fd0 100644
--- a/configure.ac
+++ b/configure.ac
@@ -835,9 +835,10 @@ AC_CHECK_TYPE([struct addrinfo],[
 ])
 GIT_CONF_SUBST([NO_IPV6])
 #
-# Define NO_REGEX if you have no or inferior regex support in your C library.
-AC_CACHE_CHECK([whether the platform regex can handle null bytes],
- [ac_cv_c_excellent_regex], [
+# Define NO_REGEX if your C library lacks regex support with REG_STARTEND
+# feature.
+AC_CACHE_CHECK([whether the platform regex supports REG_STARTEND],
+ [ac_cv_c_regex_with_reg_startend], [
 AC_EGREP_CPP(yippeeyeswehaveit,
 	AC_LANG_PROGRAM([AC_INCLUDES_DEFAULT
 #include <regex.h>
@@ -846,10 +847,10 @@ AC_EGREP_CPP(yippeeyeswehaveit,
 yippeeyeswehaveit
 #endif
 ]),
-	[ac_cv_c_excellent_regex=yes],
-	[ac_cv_c_excellent_regex=no])
+	[ac_cv_c_regex_with_reg_startend=yes],
+	[ac_cv_c_regex_with_reg_startend=no])
 ])
-if test $ac_cv_c_excellent_regex = yes; then
+if test $ac_cv_c_regex_with_reg_startend = yes; then
 	NO_REGEX=
 else
 	NO_REGEX=YesPlease
-- 
2.10.0



