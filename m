Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D05F20A40
	for <e@80x24.org>; Mon, 20 Nov 2017 17:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751867AbdKTRP0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 12:15:26 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:42634 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751697AbdKTRPZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 12:15:25 -0500
Received: by mail-wm0-f52.google.com with SMTP id 5so19205075wmk.1
        for <git@vger.kernel.org>; Mon, 20 Nov 2017 09:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ZBpqNmI2VfQHxzRVk/6XK0xyEgrRQ3pg+B1eUZ3vJdc=;
        b=KhwK/qUO3dhFPXEfcp4dO1CO915sp0UmoCWE/PuS0O7+8gKbhoypnkXfBiYRl11lxX
         SnPH0Ps79x+H17MIIRUS9GdBNr6e2xMKEW5ocaAxf1U3Ql4USkZcGjbTQFso6ZyemyE6
         +KS65dYBnWaTz6ZHijnWeamKYnafJXBFgx04xfpjP+yc7VPOXIeu0GgYQdyc8NIfz4SC
         KNJMuiDl+Y0iOB8nuJLGKEBVaKl4Ita6n9jAkhrYhBbQQWhSaV8A2iovkIhM2TqXxEs8
         HcXTEUw/BYLB/VpG+IFk40ksEJl9IJrFUNW19SobV05uA5FbLMn3FjIe91hcO7l5LCEw
         fmFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZBpqNmI2VfQHxzRVk/6XK0xyEgrRQ3pg+B1eUZ3vJdc=;
        b=qqC+Vvs2fDnFt8ll35nSYotqaOKoddX1mWE+yw/adSPJnD3I5tqCIV649pVHHx0oIJ
         S9NDB07F8adrF4g1dGhAO6+RzQn4c0OOXVdPjbkuy7mED/NO1Ilshv6cUizGKnhKxvIs
         qSDWiV7OPRLM2sJApA8vhqY6/ltKxJDt2LDul/zHlelF7TJPPHVMKQdD+W+6HZkgFvNz
         w2KiLONMQoJbV+vGqsw6aEatP/zBGvk65KDscUJUPxHIH5Xwrjqtw4I47w+glHAQ97Wz
         UBpf+KDLU6A5a81rQZotI8mtVHSRXFDc14tEvsAr9wOnWLatHj8BklvU0ad/TnLb1gym
         Zv4g==
X-Gm-Message-State: AJaThX4KjoLzGPlhWF1h46yPRXCMVTlVAuhZPOu1xY73O6BYUt09XVSK
        ua/PECoBb0eMgHP3/5HD7lv45pop
X-Google-Smtp-Source: AGs4zMZMnWMzgPTSxFu/ADF61a2+kQpYoxlTTh7qB9oo8+5TuS+kSxLCZl2eCGP2yEvFBiONQeVQqw==
X-Received: by 10.28.217.75 with SMTP id q72mr10263814wmg.9.1511198123825;
        Mon, 20 Nov 2017 09:15:23 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id m23sm8243482wmc.29.2017.11.20.09.15.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 Nov 2017 09:15:22 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Dominik Mahrer <teddy@teddy.ch>,
        git-packagers@googlegroups.com, Todd Zullinger <tmz@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Makefile: check that tcl/tk is installed
Date:   Mon, 20 Nov 2017 18:15:17 +0100
Message-Id: <20171120171517.6365-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.15.0.165.g82024f6603.dirty
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

For packagers who want to build git-gui and gitk even if Tcl/Tk
is not installed, we provide the new BYPASS_TCLTK_CHECK variable.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Makefile | 13 +++++++++++++
 1 file changed, 13 insertions(+)

The changes compared to the previous version are related to the newly
introduced BYPASS_TCLTK_CHECK variable.

I agree that removing NO_TCLTK while introducing USE_TCLTK and not
building git-gui and gitk by default is perhaps simpler and probably
the right direction for the future, but I think it might be too big a
change for now or until the next major release (Git 3.0.0).

diff --git a/Makefile b/Makefile
index ee9d5eb11e..1637725780 100644
--- a/Makefile
+++ b/Makefile
@@ -318,6 +318,10 @@ all::
 # If not set it defaults to the bare 'wish'. If it is set to the empty
 # string then NO_TCLTK will be forced (this is used by configure script).
 #
+# The BYPASS_TCLTK_CHECK variable can be used when you want to build
+# the Tcl/Tk GUI but don't want to install Tcl/Tk on the build
+# machine.
+#
 # Define INTERNAL_QSORT to use Git's implementation of qsort(), which
 # is a simplified version of the merge sort used in glibc. This is
 # recommended if Git triggers O(n^2) behavior in your platform's qsort().
@@ -1636,6 +1640,15 @@ ifeq ($(TCLTK_PATH),)
 NO_TCLTK = NoThanks
 endif
 
+ifndef NO_TCLTK
+	ifndef BYPASS_TCLTK_CHECK
+		has_tcltk := $(shell type $(TCLTK_PATH) 2>/dev/null)
+		ifndef has_tcltk
+$(error "Tcl/Tk is not installed ('$(TCLTK_PATH)' not found). Consider setting NO_TCLTK or installing Tcl/Tk")
+		endif
+	endif
+endif
+
 ifeq ($(PERL_PATH),)
 NO_PERL = NoThanks
 endif
-- 
2.15.0.165.g82024f6603.dirty

