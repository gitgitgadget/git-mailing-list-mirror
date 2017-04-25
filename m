Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BE27207E4
	for <e@80x24.org>; Tue, 25 Apr 2017 21:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1954718AbdDYVGa (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 17:06:30 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33763 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1948415AbdDYVG2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 17:06:28 -0400
Received: by mail-wm0-f65.google.com with SMTP id y10so17339755wmh.0
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 14:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EcF+lIKQCtzvs7MCT4uTunjtqrB/89ek8oh+DQDm5n0=;
        b=ihsfWi1x9WijYIJwG5Duqz0JUIor6MhaIgCFL46+qbUMAwFy4vSiVj+0EdOHtvt0XX
         v9sdMtiIfRXScAUDmoh1deTXVUksd7OCqXnrJz3tw2E+bWRj+q2zQYWI6mOoOFJOsxz1
         01OUdUFIxTMLNhcVCvGLafq9umWcLK96ueJUACx2TPp1Zof1gnUcDJzDGK74RFF4FcJd
         RDB8/a4PjdHnfnSat+iC1RuAjoai6P9ltSmkY6QR7xlAwuVTTo3vznhEo53u7XFIY9TZ
         mK8djcIbxoNVifmqIOfZFGoFHwRQvQR5wUXWFHPZHv6Pv+FXi9noT293ia45nv8kA1vj
         hb0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EcF+lIKQCtzvs7MCT4uTunjtqrB/89ek8oh+DQDm5n0=;
        b=DXCalhfBrgWGa/Fg4VIJ6cgPxoEh+KX7AOuF6FpyQ5ct/MwtlTjnnd46wI0zxn129Q
         ZCqvtmeqIyj/df1Cx7kZAqQd6UwEvggkdXehofBRMgkRm4pH5VSNwXFCwsMA6RcO6tNy
         YwQCTUVSjn2Bf8pWekZQpmBJe8/ALWsu2dXLaFJm0se6dOUz5rirRfEiA5MWqWaFzLM0
         1BqepRP0ixM28HXFx22OQWldG5if8iBy2jQXPbJdVglH3zTu/e1TmBE853TzTiJLa70w
         Rvvv9BG0o91czT3rH820nxpmGFirH22zMKloTYC6tey1WaD0HQLXJKTiYEyddLFVigIP
         HO4Q==
X-Gm-Message-State: AN3rC/665UGvuAN7uI3HLttufJNJragcJ1WBZB2QpHnk3Habk75n036D
        vg7rnyc/0VXs0A==
X-Received: by 10.28.21.203 with SMTP id 194mr15031441wmv.55.1493154381906;
        Tue, 25 Apr 2017 14:06:21 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id i71sm27519917wri.0.2017.04.25.14.06.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Apr 2017 14:06:21 -0700 (PDT)
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
Subject: [PATCH v4 07/19] grep: add a test for backreferences in PCRE patterns
Date:   Tue, 25 Apr 2017 21:05:36 +0000
Message-Id: <20170425210548.24612-8-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170425210548.24612-1-avarab@gmail.com>
References: <20170425210548.24612-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a test for backreferences such as (.)\1 in PCRE patterns. This
test ensures that the PCRE_NO_AUTO_CAPTURE option isn't turned
on. Before this change turning it on would break these sort of
patterns, but wouldn't break any tests.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t7810-grep.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index cee42097b0..ec8fe585a7 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -1102,6 +1102,13 @@ test_expect_success LIBPCRE 'grep -P -w pattern' '
 	test_cmp expected actual
 '
 
+test_expect_success LIBPCRE 'grep -P backreferences work (the PCRE NO_AUTO_CAPTURE flag is not set)' '
+	git grep -P -h "(?P<one>.)(?P=one)" hello_world >actual &&
+	test_cmp hello_world actual &&
+	git grep -P -h "(.)\1" hello_world >actual &&
+	test_cmp hello_world actual
+'
+
 test_expect_success 'grep -G invalidpattern properly dies ' '
 	test_must_fail git grep -G "a["
 '
-- 
2.11.0

