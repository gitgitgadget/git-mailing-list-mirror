Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 681A01F404
	for <e@80x24.org>; Fri, 31 Aug 2018 06:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbeHaKjr (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 06:39:47 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:38283 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbeHaKjr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 06:39:47 -0400
Received: by mail-io0-f180.google.com with SMTP id y3-v6so9606235ioc.5
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 23:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AyKQakHdWOaoHGgbK/EsF6argFCutiB7Lp2cWEgmygw=;
        b=OE9MctYl/JWMdg9BCzLRGq6NKGGWqCtMWQbSyqfezZ9KWf2y+vtGUaY6FkYj02NmRw
         7CzY51LwDmadjYSh80q6D6r9GfpI36xMLm/wntiEwytLCbJ0AAxS8QOq6VU2LSxVHlVJ
         y4qNXAyKJWqkfZlhJNYIxUOsbPVyoxruu1BC18ddmPN5xNjtR177xakVLRGj4Nxg7A0v
         cxZHFkN8KGYxEA0BzA+SAFTiWAweJ1fZCVqFD7ICZ9B6SmOobb7FjQT8GO/j99qHE7bM
         V6MCLIVDjypylZk7FXSNDdFhqR3JtaVZQcuNidi9N08pv/VP30lbNCZIMnXyuZbqeuIA
         V9wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=AyKQakHdWOaoHGgbK/EsF6argFCutiB7Lp2cWEgmygw=;
        b=J1/whR38eLse5iusb8PW66nVTbeSwVxOsSAIhV1FCeX/iI5+C/mCow3KXBo2/wfjZz
         6+lri8bPjnzXD1Wb7w38zJOZEj5bb4zZtUAUJSZMYWFQgpZS62nxJj2GUz26Mci3mIJH
         eXkI4tyUEGYgwBB3U1rtccaTqDFf14XsoPT5k70wWevZ8aRaFXV9Qz+BrCO7BjOFnj+0
         r8OjZCavEhn4Dh5G2fFd802MHsZ0jS+pAmy21DYYdTnxBhNdDJP+2GYSMkhG5G8WSZ+c
         eCqRRoUkSqqbry1QQ4sm1/A8hHkL/H3oq0Cux3ev/enQd4rBO3ZdfrLQkhAsFKvhZu3M
         cX7g==
X-Gm-Message-State: APzg51CAQ3qctBmDTgtCl3IyN+jEQOmC4RS3eAimvmiIavwyNKuD1rzB
        CjwDOt1kJXGJi8qO0OrakS6tsLwJ
X-Google-Smtp-Source: ANB0VdbkLME/dshdn2Zc/6FLi2+3di3q2G/9YNOd0xre/9CBrTQtyuDoeuoszlJuf6vpl3lk6PgScw==
X-Received: by 2002:a6b:5817:: with SMTP id m23-v6mr11669199iob.55.1535697231104;
        Thu, 30 Aug 2018 23:33:51 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id k18-v6sm3734531iom.73.2018.08.30.23.33.50
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 30 Aug 2018 23:33:50 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 1/3] doc-diff: fix non-portable 'man' invocation
Date:   Fri, 31 Aug 2018 02:33:16 -0400
Message-Id: <20180831063318.33373-2-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.19.0.rc1.352.gb1634b371d
In-Reply-To: <20180831063318.33373-1-sunshine@sunshineco.com>
References: <20180830195546.GA22407@sigill.intra.peff.net>
 <20180831063318.33373-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

doc-diff invokes 'man' with the -l option to force "local" mode,
however, neither MacOS nor FreeBSD recognize this option. On those
platforms, if the argument to 'man' contains a slash, it is
automatically interpreted as a file specification, so a "local"-like
mode is not needed. And, it turns out, 'man' which does support -l
falls back to enabling -l automatically if it can't otherwise find a
manual entry corresponding to the argument. Since doc-diff always
passes an absolute path of the nroff source file to 'man', the -l
option kicks in anyhow, despite not being specified explicitly.
Therefore, make the invocation portable to the various platforms by
simply dropping -l.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/doc-diff | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/doc-diff b/Documentation/doc-diff
index f483fe427c..c2906eac5e 100755
--- a/Documentation/doc-diff
+++ b/Documentation/doc-diff
@@ -69,7 +69,7 @@ generate_render_makefile () {
 		printf '%s: %s\n' "$dst" "$src"
 		printf '\t@echo >&2 "  RENDER $(notdir $@)" && \\\n'
 		printf '\tmkdir -p $(dir $@) && \\\n'
-		printf '\tMANWIDTH=80 man -l $< >$@+ && \\\n'
+		printf '\tMANWIDTH=80 man $< >$@+ && \\\n'
 		printf '\tmv $@+ $@\n'
 	done
 }
-- 
2.19.0.rc1.352.gb1634b371d

