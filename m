Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D54B71F404
	for <e@80x24.org>; Tue,  3 Apr 2018 15:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751561AbeDCPRI (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 11:17:08 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34507 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751244AbeDCPRH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 11:17:07 -0400
Received: by mail-lf0-f65.google.com with SMTP id c78-v6so20785323lfh.1
        for <git@vger.kernel.org>; Tue, 03 Apr 2018 08:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=q+A7/xnwk7jYy2qs5B6S6ath7Kmpq/ya8HKJUwgaZTU=;
        b=L4z5MJwwUexehu00OuRwG2eMV+Z0R2edd2Dh61aPrHuWDUxO4LhYtIOeSaPpu+ZNC4
         /LbZ/UUiwFIfoFqT8SAncK+JksLMsSAOU0RR0h6a25ChEO0H00aGLn70caCrYk/tfunG
         5lxOSvu1VncTINnBMdVm5JUSuPK0BWLfcnfFkCd3c2cuEICVQSTX/gPAssDX5Pd7isiO
         FGMvSHvghbHhSCm2mRXyioaR8x9t45nov9w8ztIoMtlhMmr4TLC+BJjnaBTYdp6h8IAm
         v5q92Kma+hxuhxy7jlPh0OyQ3pU7zrL5dve+p7zo/AqygXCTd5GilG7Y9x1JCBK4HwXv
         5Y3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=q+A7/xnwk7jYy2qs5B6S6ath7Kmpq/ya8HKJUwgaZTU=;
        b=pQ9jVNFatbvAkk+0ZYFgS27a5eXaKpNAC5G8J74fBQNt1OA3JR76kGq7rK+Vi+15iJ
         /xI14P50K/mU0IAN+SqkaAUMcx1lgc83KvfjcsaTP/XSN5uAS5WnbjcqaP0mKfkI4PPd
         K+VPMg5QBBQmkAL3fH1HMcVqNn8Tc59HZjRdvfoLYHGi3IujKCIrvKI2F6hOrTE+ATBx
         WqgCOqXRBxOpswpE2pg/4WrSvjIbGKTZ0WPu8yfl68FPchUunAIZ0DxHDDF0LcMtIdkv
         +8BOxsoP4yNEYdHppujxLtWFfZvltn7d2RFW+R4KBAyc8J0Cd+mHRc4GxBH2mTW28CwH
         Sn8g==
X-Gm-Message-State: ALQs6tCPkZlAveNNXTe4wXoJQ5ACMXOMZuO2pUlZ3HzUWaFbNgYf47cK
        70eS3zuF2/BqXmbxFXi9QV8=
X-Google-Smtp-Source: AIpwx48a1ZUyLO4BOTM361XCJHIxd9dLf9IrAe+p5ubNw4IAunqmFkxrwdGGnlJNvAiRL9MmDPtdZA==
X-Received: by 10.46.25.134 with SMTP id 6mr8794686ljz.14.1522768625873;
        Tue, 03 Apr 2018 08:17:05 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id d24-v6sm563899lfc.51.2018.04.03.08.17.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Apr 2018 08:17:04 -0700 (PDT)
Date:   Tue, 3 Apr 2018 17:17:00 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        ric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 4/3] Makefile: untangle DEVELOPER and -Werror
Message-ID: <20180403151700.GA24602@duynguyen.home>
References: <20180329150322.10722-1-pclouds@gmail.com>
 <20180331164009.2264-1-avarab@gmail.com>
 <CACsJy8CyB0igY365NMkswSgAi9_rf+XBOMQyJ7XW6iQxQiCEyQ@mail.gmail.com>
 <87woxove8d.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87woxove8d.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 03, 2018 at 11:19:46AM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> On Sat, Mar 31 2018, Duy Nguyen wrote:
> 
> > On Sat, Mar 31, 2018 at 6:40 PM, Ævar Arnfjörð Bjarmason
> > <avarab@gmail.com> wrote:
> >> Change the DEVELOPER flag, and the newly added EAGER_DEVELOPER flag
> >> which (approximately) enables -Wextra so that any combination of them
> >> and -Werror can be set.
> >>
> >> I've long wanted to use DEVELOPER=1 in my production builds, but on
> >> some old systems I still get warnings, and thus the build would
> >> fail. However if the build/tests fail for some other reason, it would
> >> still be useful to scroll up and see what the relevant code is warning
> >> about.
> >>
> >> This change allows for that. Now setting DEVELOPER will set -Werror as
> >> before, but if DEVELOPER_NONFATAL is set you'll get the same warnings,
> >> but without -Werror.
> >>
> >> I've renamed the newly added EAGER_DEVELOPER flag to
> >> DEVELOPER_EXTRA. The reason is that it approximately turns on -Wextra,
> >> and it'll be more consistent to add e.g. DEVELOPER_PEDANTIC later than
> >> inventing some new name of our own (VERY_EAGER_DEVELOPER?).
> >
> > Before we go with zillions of *DEVELOPER* maybe we can have something
> > like DEVOPTS where you can give multiple keywords to a single variable
> > to influence config.mak.dev. This is similar to COMPILER_FEATURES we
> > already have in there, but now it's driven by the dev instead of the
> > compiler. So you can have keywords like "gentle" (no -Werror) "extra"
> > (-Wextra with no suppression) and something else.
> 
> We could do that, but I don't think it's that bad. This patch is one
> extra option on top of yours,

And that eager this was marked experimental because I was not sure if
it was the right way :)

> and it's not going to result in some combinatorial explosion of
> options, i.e. if we add DEVELOPER_PEDANTIC we'll just add one extra
> flag.
> 
> But sure, we could make this some string we'd need to parse out similar
> to COMPILER_FEATURES, it just seems more complex to me for this task.

It's not that complex. With the EAGER_DEVELOPER patch removed, we can
have something like this where eager devs just need to put

    DEVOPTS = gentle no-suppression

and you put

    DEVOPTS = gentle

(bad naming, I didn't spend time thinking about names)

-- 8< --
diff --git a/Makefile b/Makefile
index e6680a8977..7b4e038e1d 100644
--- a/Makefile
+++ b/Makefile
@@ -435,6 +435,11 @@ all::
 # Define DEVELOPER to enable more compiler warnings. Compiler version
 # and faimily are auto detected, but could be overridden by defining
 # COMPILER_FEATURES (see config.mak.dev)
+#
+# When DEVELOPER is set, DEVOPTS can be used to control compiler options.
+# This variable contains keywords separated by whitespace. Two keywords
+# are recognized: "gentle" removes -Werror and "no-suppression"
+# removes all "-Wno-" options.
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
diff --git a/config.mak.dev b/config.mak.dev
index 716a14ecc7..1d7aba6a6a 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -1,4 +1,6 @@
+ifeq ($(filter gentle,$(DEVOPTS)),)
 CFLAGS += -Werror
+endif
 CFLAGS += -Wdeclaration-after-statement
 CFLAGS += -Wno-format-zero-length
 CFLAGS += -Wold-style-definition
@@ -21,6 +23,7 @@ CFLAGS += -Wextra
 # if a function is public, there should be a prototype and the right
 # header file should be included. If not, it should be static.
 CFLAGS += -Wmissing-prototypes
+ifeq ($(filter no-suppression,$(DEVOPTS)),)
 # These are disabled because we have these all over the place.
 CFLAGS += -Wno-empty-body
 CFLAGS += -Wno-missing-field-initializers
@@ -28,6 +31,7 @@ CFLAGS += -Wno-sign-compare
 CFLAGS += -Wno-unused-function
 CFLAGS += -Wno-unused-parameter
 endif
+endif
 
 # uninitialized warnings on gcc 4.9.2 in xdiff/xdiffi.c and config.c
 # not worth fixing since newer compilers correctly stop complaining
-- 8< --
