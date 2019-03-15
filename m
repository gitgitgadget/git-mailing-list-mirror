Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECE3020248
	for <e@80x24.org>; Fri, 15 Mar 2019 16:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729443AbfCOQAV (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 12:00:21 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:44460 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729406AbfCOQAU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 12:00:20 -0400
Received: by mail-wr1-f47.google.com with SMTP id w2so10095497wrt.11
        for <git@vger.kernel.org>; Fri, 15 Mar 2019 09:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sxg3A3VeqUoOLalA8W9tVQdvu/dmzw/RhmnRwu5BHC4=;
        b=VmE02Zxsds/IlxpkK+G2KVJPKMVtVA3OCSqvBjnxxadaHxqLjwNdxSYmsjV2BVXfMb
         bGkN3IzwyYhGHEcDH7n0+36V7fFaEuXHCg0tXUn42oGJw3KKev16ayWGyOT0tlwNpPlk
         bHRuSGOw+J9QrQi+XA/VEJEaKfaA0pA3uRvbwZcgJB7Nrz/yq0uWpGIuF3sEWTFlam4d
         1TXh984Y90k4WR5D+V6OTX87ptCycoZJd154lWl6qGmmwtUS3WQHKjD0iFZz76TJfhD4
         /W8wbfXMi73YqMdNcCpK7fEKS3DFQ4AAF/zbx4FfMsB7x5addTnbUdhCPGaTTtXohybR
         /o3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sxg3A3VeqUoOLalA8W9tVQdvu/dmzw/RhmnRwu5BHC4=;
        b=B+YH2fe0y+eUERSJIiNM7oq4ui4uhGQC62R0qQZ1oBPaVD9QCMg0No/h+8iUpqRgjN
         WsHz8LWyMYKaH36iskiDaeleTc9NpvanPgZE84wRYQmDH4R41AkhpNRVfgOcdyhaxNQk
         i2MkJYwPDvKHS3HDDSJK6n1wSBLTfgnYh2zp3m0iSJOsFey0pIn+/ss95t4mS4aLIGec
         lncbpXKMLD+nECfm4EdLfW/QhA0yqCiD71JdLfPh6nJ/8hh2WnELqFWnnqgZOIisl1pD
         EKrPx+MOqd4Gts6Ba7m2Oa7zicbPkRUJf20Z6uJKvllpsykM8Z6M8W3cPhBJ2ZVItuDx
         dmaA==
X-Gm-Message-State: APjAAAW1CRLLMiBohgDhw0edV0Z7HN8CB6NkXw9NSYXIPyupa7z729Tt
        5ppZjQpzbI5YI8Ufe3hLyI/5mSe6aC8=
X-Google-Smtp-Source: APXvYqwY+FX3T8snPIxRuHuR6AfwXYE6BVNeWUeJ3H2SwQvVIVjG48j30hrORJAKrgAbnn0oaY408w==
X-Received: by 2002:adf:f68d:: with SMTP id v13mr1510960wrp.6.1552665617644;
        Fri, 15 Mar 2019 09:00:17 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a18sm467766wmm.14.2019.03.15.09.00.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 15 Mar 2019 09:00:16 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 5/8] reflog tests: test for the "points nowhere" warning
Date:   Fri, 15 Mar 2019 16:59:56 +0100
Message-Id: <20190315155959.12390-6-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928
In-Reply-To: <20190314123439.4347-1-avarab@gmail.com>
References: <20190314123439.4347-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "git reflog expire" command when given an unknown reference has
since 4264dc15e1 ("git reflog expire", 2006-12-19) when this command
was implemented emit an error, but this has never been tested for.

Let's test for it, also under gc.reflogExpire{Unreachable,}=never in
case a future change is tempted to take shortcuts in the presence of
such config.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1410-reflog.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index 42f5ac9ed95..e8f8ac97856 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -250,6 +250,16 @@ test_expect_success 'gc.reflogexpire=false' '
 
 '
 
+test_expect_success 'git reflog expire unknown reference' '
+	test_config gc.reflogexpire never &&
+	test_config gc.reflogexpireunreachable never &&
+
+	test_must_fail git reflog expire master@{123} 2>stderr &&
+	test_i18ngrep "points nowhere" stderr &&
+	test_must_fail git reflog expire does-not-exist 2>stderr &&
+	test_i18ngrep "points nowhere" stderr
+'
+
 test_expect_success 'checkout should not delete log for packed ref' '
 	test $(git reflog master | wc -l) = 4 &&
 	git branch foo &&
-- 
2.21.0.360.g471c308f928

