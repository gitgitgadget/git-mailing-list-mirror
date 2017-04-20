Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D033B207BD
	for <e@80x24.org>; Thu, 20 Apr 2017 21:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S946959AbdDTVYs (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 17:24:48 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33229 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S946985AbdDTVYo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 17:24:44 -0400
Received: by mail-wr0-f193.google.com with SMTP id w50so4637226wrc.0
        for <git@vger.kernel.org>; Thu, 20 Apr 2017 14:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JfCYM2Gka7T05W3/fCxcT/aYN1GNDyZPE2H/S9PKxUE=;
        b=O+UwMLTIIDWc+Qxb5S4du23/1Mk5h1Buz0XsArg0YMlv+Lvx53SQxWMq3i8mjjqn8g
         wwEBjsAVAaCXrnI6lYHMS3XyLtOZMDVcukc5BCtDv1yGAImkU6//9a+aaljJyz4py6bt
         Zw6tgHvfEkpedfJ14/zM4KCz6K207Q4Hsyg3Q/gEWd0/QxnuCaVC31mkPdIrzHmmusIX
         V4q8SMAo2XUzsyRW2C2QP6K8mCqY5sfASShvtxurQgkxzla34gIw1Av+NaZSnG9XmR4P
         kwgWZDQcPlwXoHJJ0vCGF1a7rfFLSpy/CImO1DXGDKEufhRGzZhFQfsmWWlPih/10F+J
         +4xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JfCYM2Gka7T05W3/fCxcT/aYN1GNDyZPE2H/S9PKxUE=;
        b=j60Q8UKFEJFSuU15ON7pCOYDqdQMMrUq0klh1XOGTIjLjuZLvCLMOZU6uBZyirDSd1
         6NiP5vECJfX+13lxW/Eo9stNXpTqafdlQRlrgM3zob4t6FWLzSf2TNb3LSbsR61XKSZZ
         yAP8kd4qQ2lwuU6wFKdOsBcd1maLo2ccQ4rTEFmadN6zs6OJsykKow4BeERizndL1ib+
         9BigIit0pZZGChrJosm91uW8iUDF6tkFYiEeDte4UP2zS+AptEIyURmBC11mae0Lz+Uh
         DBNfi0FWIHojMMBnh+h7hK7joVid7xYJn1a1O8sqyg3akoRnYcsH2yp7xDzMAPRIQbwO
         faSA==
X-Gm-Message-State: AN3rC/7EdEpqUyUxkkcwd1vTQs8dkOpIWPRrnpi5C/1psjCRE5KvIfh7
        DQgkm0FoWjAtlQ==
X-Received: by 10.223.161.1 with SMTP id o1mr8995669wro.52.1492723482979;
        Thu, 20 Apr 2017 14:24:42 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k63sm442322wmf.9.2017.04.20.14.24.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Apr 2017 14:24:42 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Fredrik Kuivinen <frekui@gmail.com>,
        =?UTF-8?q?Zolt=C3=A1n=20Herczeg?= <hzmester@freemail.hu>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 09/18] grep & rev-list doc: stop promising libpcre for --perl-regexp
Date:   Thu, 20 Apr 2017 21:23:36 +0000
Message-Id: <20170420212345.7408-10-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170420212345.7408-1-avarab@gmail.com>
References: <20170420212345.7408-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stop promising in our grep & rev-list options documentation that we're
always going to be using libpcre when given the --perl-regexp option.

Instead talk about using "Perl-compatible regular expressions" and
using these types of patterns using "a compile-time dependency".

Saying "libpcre" strongly suggests that we might be talking about
libpcre.so, which is always going to be v1. This change is part of a
series to add support for libpcre2 which comes with v2 of PCRE.

In the future we might use some completely unrelated library to
provide perl-compatible regular expression support. By wording the
documentation differently and not promising any specific version of
PCRE or ever PCRE at all we have more wiggle room to change the
implementation.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-grep.txt         | 7 +++++--
 Documentation/rev-list-options.txt | 8 ++++++--
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 71f32f3508..5033483db4 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -161,8 +161,11 @@ OPTIONS
 
 -P::
 --perl-regexp::
-	Use Perl-compatible regexp for patterns. Requires libpcre to be
-	compiled in.
+	Use Perl-compatible regular expressions for patterns.
++
+Support for these types of regular expressions is an optional
+compile-time dependency. If Git wasn't compiled with support for them
+providing this option will cause it to die.
 
 -F::
 --fixed-strings::
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 5b7fa49a7f..9c44eae55d 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -93,8 +93,12 @@ endif::git-rev-list[]
 
 -P::
 --perl-regexp::
-	Consider the limiting patterns to be Perl-compatible regular expressions.
-	Requires libpcre to be compiled in.
+	Consider the limiting patterns to be Perl-compatible regular
+	expressions.
++
+Support for these types of regular expressions is an optional
+compile-time dependency. If Git wasn't compiled with support for them
+providing this option will cause it to die.
 
 --remove-empty::
 	Stop when a given path disappears from the tree.
-- 
2.11.0

