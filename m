Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CDF4201C8
	for <e@80x24.org>; Wed, 15 Nov 2017 12:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756734AbdKOMwO (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Nov 2017 07:52:14 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:38434 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751327AbdKOMwN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Nov 2017 07:52:13 -0500
Received: by mail-wm0-f46.google.com with SMTP id z3so2792292wme.3
        for <git@vger.kernel.org>; Wed, 15 Nov 2017 04:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MnB17C9EGYcbW+TeTxSNlPiXKL+gVdkJBzr9GX/Q7pg=;
        b=Oc8LVus+tfzxcBFS4dKBn7YtCo1pUSV/5DQxIEd+unYMzQJ4fPecEOr3O6uxmwwqv+
         vis/jy5tVLv6a8Rxtyx/lCTKXlh7D14YF04uibvruMGPlkiwqKxUwCAsAznQnGk3ushU
         35VqU5hkkNo0Z6JHmlp0bP2CjEIB69A/aC2rx9pJiC2npvtb3+/gRijXYr0zHwsS1gvO
         IVaF0lQeGXk9TdxMbg2T4PjG0d17ZN/ejKPBIwDOPXYqFLwwaBvkvU+Y0Lhj7M3xo9D4
         rQ1ibCR0mbnUp8O9yVSya4/E9JR4YmwD80nYlLdtkImNbPhEIUxDzHP7OgKgrLXxC0Ea
         GdIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MnB17C9EGYcbW+TeTxSNlPiXKL+gVdkJBzr9GX/Q7pg=;
        b=lLnScfLyBIVIZdANdnt1UMGCoqiC2iEWleznUkDXUD3u5VE3gSNKnK214hSv3JBbUE
         x0dV7EjAzjEnvRElF4IyeeHNskTh7n4Aw9CcZMAJ/K57Gt4yaUWd15ztEPYCTJipaxWC
         Fmc5QXALBeJoMM82waqpXemw1+nSeI1unFcawvAM/KzPufPR7GXsFhBzdjGEah8jatVP
         o0opsDy0ILbBk7Wd3b/gKCqNgOOVSddlNUdac/q8k+kicCwhCs1u/fwiKkm6aAEsZz9Y
         5OLyyyVzObg9L+CWT+FofHfK8KPdeOItG3FlrdsVpuJYQoJ2dO86CgY71/28oOIdRQyX
         ihXA==
X-Gm-Message-State: AJaThX63kTImyxd2GG1+Te1NOQmNUwZi3Di72JKIJ9JN4cMILBDL6ayS
        kXFaPTB2PT01dCDTDAHOwe3Stq5i
X-Google-Smtp-Source: AGs4zMYqRW+oklIY5YW41JWDwYK1AKFmkxyZ+IbBk9d398NL7GmACrZutFBVjDTrjVWuCd9BszoArw==
X-Received: by 10.80.170.28 with SMTP id o28mr21700198edc.93.1510750331840;
        Wed, 15 Nov 2017 04:52:11 -0800 (PST)
Received: from christian-Latitude-E6330.booking.pcln.com ([185.24.142.26])
        by smtp.gmail.com with ESMTPSA id k51sm18648898ede.42.2017.11.15.04.52.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 15 Nov 2017 04:52:10 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Dominik Mahrer <teddy@teddy.ch>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Makefile: check that tcl/tk is installed
Date:   Wed, 15 Nov 2017 13:52:00 +0100
Message-Id: <20171115125200.17006-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.15.0.165.g42c5887
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By default running `make install` in the root directory of the
project will set TCLTK_PATH to `wish` and then go into the "git-gui"
and "gitk-git" sub-directories to build and install these 2
sub-projects.

When Tcl/Tk is not installed, the above will succeed if gettext
is installed, as Tcl/Tk is only required as a substitute for msgfmt
when msgfmt is not installed. But then running the installed gitk
and git-gui will fail.

If neither Tcl/Tk nor gettext are installed, then processing po
files will fail in the git-gui directory. The error message when
this happens is very confusing to new comers as it is difficult
to understand that we tried to use Tcl/Tk as a substitute for
msgfmt, and that the solution is to either install gettext or
Tcl/Tk, or to set both NO_GETTEXT and NO_TCLTK.

To improve the current behavior when Tcl/Tk is not installed,
let's just check that TCLTK_PATH points to something and error
out right away if this is not the case.

This should benefit people who actually want to install and use
git-gui or gitk as they will have to install Tcl/Tk anyway, and
it is better for them if they are told about installing it soon
in the build process, rather than if they have to debug it after
installing.

For people who don't want to use git-gui or gitk, this forces
them to specify NO_TCLTK. If they don't have gettext, this will
make it much easier to fix the problems they would have had to
fix anyway. If they have gettext, setting NO_TCLTK is a small
additional step they will have to make, but it might be a good
thing as it will not install what they don't want and it will
build a bit faster.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Makefile | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Makefile b/Makefile
index ee9d5eb11e..ada6164e15 100644
--- a/Makefile
+++ b/Makefile
@@ -1636,6 +1636,13 @@ ifeq ($(TCLTK_PATH),)
 NO_TCLTK = NoThanks
 endif
 
+ifndef NO_TCLTK
+	has_tcltk := $(shell type $(TCLTK_PATH) 2>/dev/null)
+	ifndef has_tcltk
+$(error "Tcl/Tk is not installed ('$(TCLTK_PATH)' not found). Consider setting NO_TCLTK or installing Tcl/Tk")
+	endif
+endif
+
 ifeq ($(PERL_PATH),)
 NO_PERL = NoThanks
 endif
-- 
2.15.0.165.g42c5887

