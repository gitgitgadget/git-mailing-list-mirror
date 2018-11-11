Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11EBB1F87F
	for <e@80x24.org>; Sun, 11 Nov 2018 06:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbeKKQLA (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Nov 2018 11:11:00 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35681 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbeKKQK7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Nov 2018 11:10:59 -0500
Received: by mail-ot1-f65.google.com with SMTP id 81so5291659otj.2
        for <git@vger.kernel.org>; Sat, 10 Nov 2018 22:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GuoJPXfhSLP0jMlhy/1pwwfT7gnHll7lj2zkReDrCic=;
        b=ttOhZ4I2S+c+su5jAdL8CaRu/+VTy63MpaPM4zC49ufgZroMZQnbxocFaI8/AP/dnN
         SE4MH7J+ai2p/BwYw3019k6oODgj5vaHqQM8T0D+h/hdzMV1PhkxYfvOYKAUy45XD+gL
         ztclLFDLyJ6uchhsQeXOdDsEiFJ4Rqop8DbYXiEj3dIDJNM/dImZpBNiw0tZrBGgL557
         S1UFILATj3JBwohpcj6Psmz0UaJRYuNRWBInETdytbi+aFuABBVjEGHDLygpnEIcifpf
         FMrqdFqHf5bYhw3Za7P8PTXo6tFgL6I7HLAkrsY5KFOVLh3qzxLMlJ1tU+BsIPQqEzha
         vUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GuoJPXfhSLP0jMlhy/1pwwfT7gnHll7lj2zkReDrCic=;
        b=gmBm5tAXa6OWJeIMeUekvWH/NSxIdyCt4LpBfBYw8/oWZFk/sy2i1n3LD+R8txwuj5
         9fsjxuiVNVqCpxAHDr0AUIsAklspADNQcUum9dI0HZjse2lJZ7rmlfwPV5FvqVPnW3o2
         JF7sOHTCivJuXUmc8F5Neg/uZ6v8vjgG+3djXf/k94AR80tLvKSyUYtjXLyismFTakQY
         MZ61yXfoCzfe4DuPRBTPPiI+JQMXzfwN9mRE9lsR3FbrR0rGIcYhDXixnKC2ie0+slZU
         IiG/C5YHg6OR4LHPH1fagdbUCdKn7/1e2ye4oNnTB/eyG6zp77BDmp3uwSo7RdVO1w5t
         dlEg==
X-Gm-Message-State: AGRZ1gL4tsW55bSxswxboG9FgR1B/6E8gcmQ8sBUYUdzOrwB20vxLDkl
        t+Ghc8A0wsO1SKgpBVmpBjNU3JTn
X-Google-Smtp-Source: AJdET5cvvkvGVDboIecU82hecuA/nFV+OeDW7sxL0wIbmRkGm6fSWOFUs6Q2JdhTunjewfmquk3vOg==
X-Received: by 2002:a9d:5f06:: with SMTP id f6mr9594623oti.258.1541917401319;
        Sat, 10 Nov 2018 22:23:21 -0800 (PST)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id f34sm1286855otb.25.2018.11.10.22.23.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 10 Nov 2018 22:23:20 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     larsxschneider@gmail.com, sandals@crustytoothpaste.net,
        peff@peff.net, me@ttaylorr.com, jrnieder@gmail.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH 02/10] git-fast-export.txt: clarify misleading documentation about rev-list args
Date:   Sat, 10 Nov 2018 22:23:04 -0800
Message-Id: <20181111062312.16342-3-newren@gmail.com>
X-Mailer: git-send-email 2.19.1.866.g82735bcbde
In-Reply-To: <20181111062312.16342-1-newren@gmail.com>
References: <CABPp-BEefqYADr8SVvh6uFWkp96PDv7qfKK1c9O1WUnPy3wqrw@mail.gmail.com>
 <20181111062312.16342-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-fast-export.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index ce954be532..677510b7f7 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -119,7 +119,8 @@ marks the same across runs.
 	'git rev-list', that specifies the specific objects and references
 	to export.  For example, `master~10..master` causes the
 	current master reference to be exported along with all objects
-	added since its 10th ancestor commit.
+	added since its 10th ancestor commit and all files common to
+	master\~9 and master~10.
 
 EXAMPLES
 --------
-- 
2.19.1.866.g82735bcbde

