Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 523831FC34
	for <e@80x24.org>; Fri,  8 Dec 2017 22:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753246AbdLHWaU (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 17:30:20 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:40539 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752631AbdLHWaQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 17:30:16 -0500
Received: by mail-wr0-f195.google.com with SMTP id q9so12107191wre.7
        for <git@vger.kernel.org>; Fri, 08 Dec 2017 14:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Z/dDCKGnp+TEeL4c5OcHnUoIVu7jN8Dzgdo9mrKZzPY=;
        b=ZQYHKiS/tebJp3ZBOZvbeeBWwodXEQOqjZcnYnFbYyRzhxv6OOwZE/i1TZOesZHnQZ
         G3quagfhml/VdJ/DHe7YuK5UTN4BNgcCdXZbkOT34wj4K1G1ovAti1wHLCzmJjlgyPmP
         iB7IGrTwfAqpuAFvovrzC8dVslWAbuz6JYfb4+rlj7mv3zQvGuUazHB3PP6ftMs9L3Do
         jlD3RvX/8dVT+gaSm6DTmO1TzhjtUmbponmC0LK9FS0fYM7851NerYshnP+WlrBNISyZ
         GDBV/3By6+thPIfnYE4CUeN0tr86VNsh3wq0KI1qaj5R6yR2mggUz0aUh+KxnJSH8Fsu
         yGtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Z/dDCKGnp+TEeL4c5OcHnUoIVu7jN8Dzgdo9mrKZzPY=;
        b=UzknrH8DWMQD1f/ziWgssxLYdysxjYXTjaMS5ru0rmlepDvmFjjjZU+w+Yd8pzOVqK
         zdcJ2Ct3OOdCAr1vg7VZjXPh348L5WJPZQT5GYLjH5atIFKnheVsFCCbdMeiOPUG9kCi
         uKQBjVpejilTnyM+K2JflqVk4yoHeh9HxVHJrFXvcy5kVEEJSjFr2d0ZRZpNGm7FOUL7
         RI8Qz+pOT9QJIkTo8FDJ9/k05rRrAHkDmWY46o77XMscTcu/ArLUWqd4pmTQhpq1BY3g
         XhGuT0D0GYe/lUVj9pEv+IR5442Ws27ySXsUhA3F6R5LPEwbPdtO0HgWkrgQ3IN2pWmX
         aA+w==
X-Gm-Message-State: AJaThX4c9RgSwrc7HW2XtcFs0qdsjDGh9trB7hEV4s+EITCielNGxho4
        TIEZvn8xsBjsVWwtPRJXX3EjYgRe
X-Google-Smtp-Source: AGs4zMblq5ddU+807bPAJkuj1dymSBOMXtcNo8T+JGSwtCIoHXc0Umyvm1uVbxzGs7u2qHVdyX6Zqw==
X-Received: by 10.223.195.203 with SMTP id d11mr27154050wrg.39.1512772214487;
        Fri, 08 Dec 2017 14:30:14 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id o48sm9688661wrf.85.2017.12.08.14.30.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Dec 2017 14:30:13 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Takashi Iwai <tiwai@suse.de>,
        Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/5] Makefile: don't error out under DC_SHA1_EXTERNAL if DC_SHA1_SUBMODULE=auto
Date:   Fri,  8 Dec 2017 22:29:57 +0000
Message-Id: <20171208223001.556-2-avarab@gmail.com>
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

Fix a logic error in the initial introduction of DC_SHA1_EXTERNAL. If
git.git has a sha1collisiondetection submodule checked out the logic
to set DC_SHA1_SUBMODULE=auto would interact badly with the check for
whether DC_SHA1_SUBMODULE was set.

It would error out, meaning that there's no way to build git with
DC_SHA1_EXTERNAL=YesPlease without deinit-ing the submodule.

Instead, adjust the logic to only fire if the variable is to something
else than "auto" which would mean it's a mistake on the part of
whoever's building git, not just the Makefile tripping over its own
logic.

1. 3964cbbb5c ("sha1dc: allow building with the external sha1dc
   library", 2017-08-15)
2. cac87dc01d ("sha1collisiondetection: automatically enable when
   submodule is populated", 2017-07-01)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Makefile b/Makefile
index fef9c8d272..dc886f8eda 100644
--- a/Makefile
+++ b/Makefile
@@ -1498,7 +1498,9 @@ else
 	LIB_OBJS += sha1dc_git.o
 ifdef DC_SHA1_EXTERNAL
 	ifdef DC_SHA1_SUBMODULE
+		ifneq ($(DC_SHA1_SUBMODULE),auto)
 $(error Only set DC_SHA1_EXTERNAL or DC_SHA1_SUBMODULE, not both)
+		endif
 	endif
 	BASIC_CFLAGS += -DDC_SHA1_EXTERNAL
 	EXTLIBS += -lsha1detectcoll
-- 
2.15.1.424.g9478a66081

