Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36B3D1FC34
	for <e@80x24.org>; Fri,  8 Dec 2017 22:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753360AbdLHWaZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 17:30:25 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39869 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753198AbdLHWaS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 17:30:18 -0500
Received: by mail-wm0-f65.google.com with SMTP id i11so5292735wmf.4
        for <git@vger.kernel.org>; Fri, 08 Dec 2017 14:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=iy4maFubCtqhXlgmUv/8Dlrzd5X0A6A1x1u1FAfj/N0=;
        b=UOIDQn9ax83v+zx3EM8cpKPZdvFCsUb0br7mK2SZZLDXR9Tlndju3cj8kOVq2wwiRk
         Mv+Zo4f2vRWp+b/UkufYiId2Sf1hKK2gbLwWTzbLzd7XugCMXrqxKcCeU+PRT7uuqfQT
         NIlqBPtztaHVLLoGHxDlnX39abQj5/AIXygq2UrMCVksXs6UWiS74W01KcHzsgmNFzYw
         xtSuCPh4tblYvGhs8UVRQJmUezDeQ5wt/1stD2aAO5qWWREkwhfUG/QlZcF7uMIS8nyM
         0pbgRShfu5qIYDBtLrE6/ykrHYED3M63JSF0IT4Gb9emRPvfr7gc8n550JgJm5tnGFFU
         /y5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=iy4maFubCtqhXlgmUv/8Dlrzd5X0A6A1x1u1FAfj/N0=;
        b=A0TanAjEgOFQHzchQNomhqCPzMvt+Laq9WL1N36bkdMRAnirynrvx8yGuuOFLMVxt1
         yv2EvWvaSwme5b/K673a0iJCO8uvkXjdfifzn6rxZJJZ4y+e8hnXDUFXbraq9jtvDOQV
         6PS1nwkPUQP5I6GmrwQd9nNy7PrjHnrZs+ybtJDmucPCl2oeP6RzQ8mEtYWGPgSXBode
         6M9lJqr0qLSUshOhWelQQz7dgBNbyFiAEph+AMApnJ+SS0hJxwvKRuQDnXC4UxIVOJm1
         kkzHRbvxuuxmzivrCVJO1xWVlZ0dy0lejZVtxyWTx/kiqbrobk97jf2IJgg8f+o5O3/b
         3Kgw==
X-Gm-Message-State: AKGB3mIcnoDpZKUqdzwLdcFp2g3DEgzirNPok8OIpsso/UG8plN+ATQw
        24ux7cuDzc2/G3vat3DqnYLmXQe3
X-Google-Smtp-Source: AGs4zMYsI9U7CwwSA5xyVaOLEkmc8Hx+JAqlnY0OfgZv/Jfretjx/grngwlazpNygRPS05hCPx58CA==
X-Received: by 10.28.30.213 with SMTP id e204mr4845281wme.40.1512772216767;
        Fri, 08 Dec 2017 14:30:16 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id o48sm9688661wrf.85.2017.12.08.14.30.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Dec 2017 14:30:15 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Takashi Iwai <tiwai@suse.de>,
        Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/5] Makefile: under "make dist", include the sha1collisiondetection submodule
Date:   Fri,  8 Dec 2017 22:29:58 +0000
Message-Id: <20171208223001.556-3-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20171208223001.556-1-avarab@gmail.com>
References: <20171208223001.556-1-avarab@gmail.com>
In-Reply-To: <20171128213214.12477-1-avarab@gmail.com>
References: <20171128213214.12477-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Include the sha1collisiondetection submodule when running "make
dist". Even though we've been shipping the sha1collisiondetection
submodule[1] and using it by default if it's checked out[2] anyone
downloading git as a tarball would just get an empty
sha1collisiondetection/ directory.

Doing this automatically is a feature that's missing from git-archive,
but in the meantime let's bundle this up into the tarball we
ship. This ensures that the DC_SHA1_SUBMODULE flag does what's
intended even in an unpacked tarball, and more importantly means we're
building the exact same code from the same paths from git.git and from
the tarball.

I am not including all the files in the submodule, only the ones git
actually needs (and the licenses), only including some files like this
would be a useful feature if git-archive ever adds the ability to
bundle up submodules.

1. commit 86cfd61e6b ("sha1dc: optionally use sha1collisiondetection
   as a submodule", 2017-07-01)
2. cac87dc01d ("sha1collisiondetection: automatically enable when
   submodule is populated", 2017-07-01)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Makefile b/Makefile
index dc886f8eda..3955b02b6a 100644
--- a/Makefile
+++ b/Makefile
@@ -2643,6 +2643,21 @@ dist: git-archive$(X) configure
 		$(GIT_TARNAME)/configure \
 		$(GIT_TARNAME)/version \
 		$(GIT_TARNAME)/git-gui/version
+ifdef DC_SHA1_SUBMODULE
+	@mkdir -p $(GIT_TARNAME)/sha1collisiondetection/lib
+	@cp sha1collisiondetection/LICENSE.txt \
+		$(GIT_TARNAME)/sha1collisiondetection/
+	@cp sha1collisiondetection/LICENSE.txt \
+		$(GIT_TARNAME)/sha1collisiondetection/
+	@cp sha1collisiondetection/lib/sha1.[ch] \
+		$(GIT_TARNAME)/sha1collisiondetection/lib/
+	@cp sha1collisiondetection/lib/ubc_check.[ch] \
+		$(GIT_TARNAME)/sha1collisiondetection/lib/
+	$(TAR) rf $(GIT_TARNAME).tar \
+		$(GIT_TARNAME)/sha1collisiondetection/LICENSE.txt \
+		$(GIT_TARNAME)/sha1collisiondetection/lib/sha1.[ch] \
+		$(GIT_TARNAME)/sha1collisiondetection/lib/ubc_check.[ch]
+endif
 	@$(RM) -r $(GIT_TARNAME)
 	gzip -f -9 $(GIT_TARNAME).tar
 
-- 
2.15.1.424.g9478a66081

