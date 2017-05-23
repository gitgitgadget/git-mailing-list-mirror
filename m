Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEB2320281
	for <e@80x24.org>; Tue, 23 May 2017 19:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764515AbdEWTZg (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 15:25:36 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33754 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1764472AbdEWTZb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 15:25:31 -0400
Received: by mail-wm0-f67.google.com with SMTP id b84so25955433wmh.0
        for <git@vger.kernel.org>; Tue, 23 May 2017 12:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=PiW62jxjE8nZD7SCU2WqaTpCNYD3OuOt5OrjnN+6JKs=;
        b=dGe/W/r+tLx7ja9AArH5v0lBexpZxxTZ+xgDKcrRcjX78XLDilZblIet2w50YpQaez
         iCs3RmnUHRI9tGpeKIN4VTI8WAi9qzZZGmjzBbpptNpdaBt/JhaoFy+E4XaK+4zGxfHY
         +a9YDL93zwtX7IzHNvQC5fmULw+0asYMC7viP140v7wSuSwbm5G/AKP/KtNmgxpxc7nd
         WNSMN/OvBkdElPD2O4UrKLrRpFnG475Vcn7pZKC9XgCFXjWXZjuH7sK8vTWP+6IZKc2u
         BrdfrRUWwMixSnykBNlTj1TVU7EC5VAD8noBEvvW6zDwBgFm3/a3ZBWCTgM5l5BIqX+R
         tf3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=PiW62jxjE8nZD7SCU2WqaTpCNYD3OuOt5OrjnN+6JKs=;
        b=mQhXRIp2Xk8oIijJs+4wRkLBIU4GCoz2yVAskwdhR+MhiRg6kDpA6AUhbA2kcxv7Xq
         1e9E6dEbu31GxkulZhpb/CIPXph9vFyK63z+KI6geISRw4FMRrLylcQLjtG6XWKmhaIs
         66YE+Ma4nxGx/PJI72tZ01fYe6EKRMk2lKVXfIXJeWVLgeWB4ck9I87N+V2Qn1bdIf0o
         p9tlyEYFRgpmkazMj+fsCqtq+Rffl1AG/zmkYVpoCuk8tL8AJ0c+Zu7OkNhwKosoeMxD
         tI+ntZJQxs9WN6MkwPCIU5UI2dNad5hBUCW27mkj29or02RlcM8z/gf2aIUUYvl/CZFk
         jrBA==
X-Gm-Message-State: AODbwcD9R8H31eHi2uXwvrbHSXOX1sDyhJFxDJzxWmAJK5QdfA6LN2dW
        SjRAlQrrH+3V3A==
X-Received: by 10.28.63.9 with SMTP id m9mr3666205wma.87.1495567529829;
        Tue, 23 May 2017 12:25:29 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id a24sm2203480wra.17.2017.05.23.12.25.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 May 2017 12:25:28 -0700 (PDT)
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
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Simon Ruderich <simon@ruderich.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 6/7] grep: un-break building with PCRE < 8.20
Date:   Tue, 23 May 2017 19:24:52 +0000
Message-Id: <20170523192453.14172-7-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169
In-Reply-To: <20170523192453.14172-1-avarab@gmail.com>
References: <20170523192453.14172-1-avarab@gmail.com>
In-Reply-To: <xmqqshjzqe9o.fsf@gitster.mtv.corp.google.com>
References: <xmqqshjzqe9o.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend my change earlier in this series ("grep: add support for the
PCRE v1 JIT API", 2017-04-11) to un-break the build on PCRE v1
versions earlier than 8.20.

The 8.20 release was the first release to have JIT & pcre_jit_stack in
the headers, so a mock type needs to be provided for it on those
releases.

Now git should compile with all PCRE versions that it supported before
my JIT change.

I've tested it as far back as version 7.5 released on 2008-01-10, once
I got down to version 7.0 it wouldn't build anymore with GCC 7.1.1,
and I couldn't be bothered to anything older than 7.5 as I'm confident
that if the build breaks on those older versions it's not because of
my JIT change.

See the "un-break" change in this series ("grep: un-break building
with PCRE < 8.32", 2017-05-10) for why this isn't squashed into the
main PCRE JIT commit.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/grep.h b/grep.h
index 73ef0ef8ec..b7b9d487b0 100644
--- a/grep.h
+++ b/grep.h
@@ -11,6 +11,9 @@
 #ifndef PCRE_STUDY_JIT_COMPILE
 #define PCRE_STUDY_JIT_COMPILE 0
 #endif
+#if PCRE_MAJOR <= 8 && PCRE_MINOR < 20
+typedef int pcre_jit_stack;
+#endif
 #else
 typedef int pcre;
 typedef int pcre_extra;
-- 
2.13.0.303.g4ebf302169

