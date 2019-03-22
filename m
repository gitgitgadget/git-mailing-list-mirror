Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4925020248
	for <e@80x24.org>; Fri, 22 Mar 2019 09:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbfCVJdN (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 05:33:13 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37834 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbfCVJdL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 05:33:11 -0400
Received: by mail-wr1-f67.google.com with SMTP id w10so1551122wrm.4
        for <git@vger.kernel.org>; Fri, 22 Mar 2019 02:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E0uGOOeq6lqgk2yhZXTZCkmWL5ihuzOqLpzfPyn8IQ4=;
        b=P2j7XZ4OajDOgIq5MMfcII9VZKqxzXLqOGVytshgaNK1kRdbEIKXQfIb3FDRJ7P3ay
         uZoMYQG+TUmu2i1S3rAMNEBg8MZdOCtWSiIlX1axoKyUCL/lrgcg3600Kx2Gc1QCbXjV
         KtCYnKjDWl9OzFxGqaI6AsqMlsSgQdtKkO1ii3r43Wlba1SDSn/vqjDkVyC94ZKUQEcU
         s8uk4WGiGb19Z5XVO+vdKjb3jaoJXj5/KPARjiJMDMY+1Yv5GNJuHVxIu6VmUAuc+hA6
         +ZeVYiDcXFuvlHf1rlnWZhV1QzoYrLt7UBzPgKw6kkbZh0K3gswiBSJIyDB1vybH36MV
         PPCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E0uGOOeq6lqgk2yhZXTZCkmWL5ihuzOqLpzfPyn8IQ4=;
        b=g/VsEM1NyshIXKb1yeP253AOxyy0XxQpEx8Hsb9PwvGi0eO+1/OyxS2uNbAI9p6Y8K
         G3EpFG0791VwzjXDcsyPpjIq27z97wfxvnLGJWkpNXoq4KqJhZjR/Bn37PLp2eFRtGU/
         cJhP6xrlTty0GZu+sIFwIYsM5Du/XvGJZKLvrGJa0SDqbGhU/OUHjXrWhrS4dQIbGu7p
         yIB5dHDfG0wyN5o9tOk9kDDtN3NQH/yuZt20jrLCtBIxGC36UZBPq7ZDIWxU++ILbBr5
         s1TSQLXsv+lBeScEdoGRIkrcQNZZP/5e0F0Y/NCQVBAlsSQFFTzVPpRkROn42JEp+BuW
         yVHQ==
X-Gm-Message-State: APjAAAW1TPMezY4zT84QpeScIcJj0Hen5cWTnusYxJyHKFWcNRReCRN0
        IfAY8a8zZBdWop1XtkVerslEofsrDBM=
X-Google-Smtp-Source: APXvYqwNiw0OSKYnbooi+jv2S9nkN1O1kFRjgnAElVQtJbb+nu74KFNDv2F+lYIbzwLZtk2oz5+QWw==
X-Received: by 2002:a5d:6b4a:: with SMTP id x10mr5554732wrw.63.1553247189049;
        Fri, 22 Mar 2019 02:33:09 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y197sm3521447wmd.34.2019.03.22.02.33.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 22 Mar 2019 02:33:08 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Matt McCutchen <matt@mattmccutchen.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 07/11] gc docs: note how --aggressive impacts --window & --depth
Date:   Fri, 22 Mar 2019 10:32:38 +0100
Message-Id: <20190322093242.5508-8-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928
In-Reply-To: <20190321205054.17109-1-avarab@gmail.com>
References: <20190321205054.17109-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 07e7dbf0db (gc: default aggressive depth to 50, 2016-08-11) we
somewhat confusingly use the same depth under --aggressive as we do by
default.

As noted in that commit that makes sense, it was wrong to make more
depth the default for "aggressive", and thus save disk space at the
expense of runtime performance, which is usually the opposite of
someone who'd like "aggressive gc" wants.

But that's left us with a mostly-redundant configuration variable, so
let's clearly note in its documentation that it doesn't change the
default.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config/gc.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/gc.txt b/Documentation/config/gc.txt
index 56918a5008..f732fe5bfd 100644
--- a/Documentation/config/gc.txt
+++ b/Documentation/config/gc.txt
@@ -1,7 +1,8 @@
 gc.aggressiveDepth::
 	The depth parameter used in the delta compression
 	algorithm used by 'git gc --aggressive'.  This defaults
-	to 50.
+	to 50, which is the default for the `--depth` option when
+	`--aggressive` isn't in use.
 +
 See the documentation for the `--depth` option in
 linkgit:git-repack[1] for more details.
@@ -9,7 +10,8 @@ linkgit:git-repack[1] for more details.
 gc.aggressiveWindow::
 	The window size parameter used in the delta compression
 	algorithm used by 'git gc --aggressive'.  This defaults
-	to 250.
+	to 250, which is a much more aggressive window size than
+	the default `--window` of 10.
 +
 See the documentation for the `--window` option in
 linkgit:git-repack[1] for more details.
-- 
2.21.0.360.g471c308f928

