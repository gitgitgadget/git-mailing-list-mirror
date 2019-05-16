Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C29621F461
	for <e@80x24.org>; Thu, 16 May 2019 09:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfEPJeW (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 05:34:22 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36062 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfEPJeW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 05:34:22 -0400
Received: by mail-wm1-f65.google.com with SMTP id j187so2733457wmj.1
        for <git@vger.kernel.org>; Thu, 16 May 2019 02:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eQ+9qG1yyI2t7ULNU0ompfNtjAKUW7w2QwIPJI/Rkdo=;
        b=gRueI4EFHWR4oEq20Hx2njOU6CFfwK6+vRfhX0Bh/9gSqh5qfmdSOgGHEkR/ocBCIA
         djayuyylvq4UWQzCGqHfEoMv9AVxyex9oYUnOBI6JECieFaVJ/sT/kpovqA2qDoFCEGb
         ZMNoAVEtMFz6qxNU6rpJy+yIA/rzM0Yp2YfnzKYQoUxc5Y1bTQFahoJMR1leDA8scRyg
         uxPCPXxo3JO8EvpV81LT6c7WiuwSRloQ9+IMaz20gC1OMdXJw9ca7Az0esIhR3HJ6sJz
         f07fW/sFAo5mgV1cQ7yxtImmFoqQu4crq4lLG2MQG3y3FAecR0AX1JmzNNvf1wS/RKCP
         hgJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eQ+9qG1yyI2t7ULNU0ompfNtjAKUW7w2QwIPJI/Rkdo=;
        b=W26CnZxCMFUq16VgGyWQD6csQpGXXR+B3cuvBE8T+aqheIqowyKoeYapXda8/5YTad
         Wl5dkat1vbYOi/5WIVyyOlCK6df2e/1oS1acoSQvXGiE4WugKhIXhUa/NGgn2BcYjGba
         btM2b7TC9l0pRO6N8mkFnUxQZSW+eLKQQuLFKAPfvQAKMIvEMiLzOQE0S1caf5h6619H
         WpkGos6qHVJIiXIgKVC+lf4YDOseOrx6g3DLlX/u6inoSiehk1o1NBUsh9Kv2S8VE2rj
         Uf96U65y8JaSZ/BX95VaaEa05239/M4WoC0cGpNdDSVNb9SBHAaC4KRG3YTiZVCKKIEx
         Q3Wg==
X-Gm-Message-State: APjAAAUCnDLdiQfqKEd8H1gE7hPFDrqMt0DWAqn6my9ADwLHzFkbnJ+v
        mh67sV9dzTgV1juSHJSzfBfI+8YX
X-Google-Smtp-Source: APXvYqy3BtZJEheGKSrlK8DWvNRi1Jc9nv6rzaOYpID4Z+EI7c7vdHhLrioMD6Ziqpd1eyKotWO6GQ==
X-Received: by 2002:a1c:f311:: with SMTP id q17mr26947376wmq.144.1557999260182;
        Thu, 16 May 2019 02:34:20 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e8sm10367490wrc.34.2019.05.16.02.34.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 16 May 2019 02:34:19 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Osipov <michael.osipov@siemens.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] configure: Detect linking style for HP aCC on HP-UX
Date:   Thu, 16 May 2019 11:34:12 +0200
Message-Id: <20190516093412.14795-1-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a
In-Reply-To: <6aabf669-a73f-d23d-8d65-8b96eefbae4b@siemens.com>
References: <6aabf669-a73f-d23d-8d65-8b96eefbae4b@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Michael Osipov <michael.osipov@siemens.com>

HP aCC does not accept any of the previously tested CC_LD_DYNPATH
formats, but only its own[1] "-Wl,+b" format. Add it to configure.ac.

1. http://nixdoc.net/man-pages/hp-ux/man1/ld_pa.1.html

Signed-off-by: Michael Osipov <michael.osipov@siemens.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

I took the liberty of slightly amending the commit message.

 configure.ac | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index be3b55f1cc..a43b476402 100644
--- a/configure.ac
+++ b/configure.ac
@@ -475,8 +475,18 @@ else
       if test "$git_cv_ld_rpath" = "yes"; then
          CC_LD_DYNPATH=-rpath
       else
-         CC_LD_DYNPATH=
-         AC_MSG_WARN([linker does not support runtime path to dynamic libraries])
+         AC_CACHE_CHECK([if linker supports -Wl,+b,], git_cv_ld_wl_b, [
+            SAVE_LDFLAGS="${LDFLAGS}"
+            LDFLAGS="${SAVE_LDFLAGS} -Wl,+b,/"
+            AC_LINK_IFELSE([AC_LANG_PROGRAM([], [])], [git_cv_ld_wl_b=yes], [git_cv_ld_wl_b=no])
+            LDFLAGS="${SAVE_LDFLAGS}"
+         ])
+         if test "$git_cv_ld_wl_b" = "yes"; then
+            CC_LD_DYNPATH=-Wl,+b,
+          else
+             CC_LD_DYNPATH=
+             AC_MSG_WARN([linker does not support runtime path to dynamic libraries])
+          fi
       fi
    fi
 fi
-- 
2.21.0.1020.gf2820cf01a

