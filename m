Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 616731F404
	for <e@80x24.org>; Sun, 28 Jan 2018 00:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752762AbeA1AgV (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Jan 2018 19:36:21 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:39385 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751609AbeA1AgU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Jan 2018 19:36:20 -0500
Received: by mail-lf0-f65.google.com with SMTP id w27so5053201lfd.6
        for <git@vger.kernel.org>; Sat, 27 Jan 2018 16:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V6a3Vtv7pwG6z2DqOIRtWVV49FUv+eiToZtCPjAcEVA=;
        b=p0MCV16Gl4meR3XmY2rB4t+vcADx+luFR2h7pmi2EfHWZa7WqVPxfyIW+/YSLeJG9i
         fuv2+t3AP9cOP4OAB22Ye51kacCyB7wc/2z6bYjE+JoW8XYYkWgWBD8ZFdLk0yoEKAD7
         Cg7clW10ShRAlH1Cu0cXImLGcGt3IDc1cBMM7se6p6C/RnbbV7pTJES0B7w65LUpGxhF
         +RxaForvdiOQ95Z2v9vlW+zhT83fC+3bjSnSBX/hFJmsZT1tjouRSTkW4Wv5IGeR9DND
         htd0wo3UA6r/kU2kk+1nDnaGiyRy0kUbJyVQ97Dp6qFN0w9FwmBGHqh1FxAXDYQr0OX7
         7m7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V6a3Vtv7pwG6z2DqOIRtWVV49FUv+eiToZtCPjAcEVA=;
        b=DsMePJnLhvgGULqcIom6ElGctJMh2OJPwvlyUulHDnelp+AQWi4E4vxVNNuaScFAFQ
         jvU42WZ5klLG7InPgfJaGBgufVVyVH9tJkTAAvW98rMTm/TtciYs6DrfG/gr0JbKVbAe
         CslNxL+k6Gt0aMLZpMVKVd8rPHV11AkmzBPGCB8glodpKqsCQH37uZaOhvQPf9YITFbn
         h7feA2ParFbiQ3COi5FEaUK6l68tfBjPWyyhlkKBAD6/y9Bau1EYcKhKUWziyiVGtdbL
         gzUaYcnQhinpia0ivTHgUpK8sZPMihH+x9YE0jY56R/EscvzqDbuQlMvXRrfI7fyL8JJ
         KHCw==
X-Gm-Message-State: AKwxytdaD4gzIwAFheyrCa0pOS2onibIAhYwPE1xw33Psln9MhZY8Z6j
        bacGfRntubuC3UzuPyY2GV53Ubx6
X-Google-Smtp-Source: AH8x225UxZvYEU/WoJTIlWJrTPxmYhesG8bt3APfcO3NLrifevZYRtm8Z+GR6spGG7zmAOUuc6x2gA==
X-Received: by 10.25.215.72 with SMTP id o69mr11128367lfg.103.1517099779490;
        Sat, 27 Jan 2018 16:36:19 -0800 (PST)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id h78sm2132437lfk.31.2018.01.27.16.36.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Jan 2018 16:36:18 -0800 (PST)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, sbeller@google.com,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 0/1] setup: recognise extensions.objectFormat
Date:   Sun, 28 Jan 2018 01:36:16 +0100
Message-Id: <cover.1517098675.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <af22d7feb8a8448fa3953c66e69a8257460bff07.1516800711.git.patryk.obara@gmail.com>
References: <af22d7feb8a8448fa3953c66e69a8257460bff07.1516800711.git.patryk.obara@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Compared to v1:

Implemented code suggestions from Duy Nguyễn (string for translation and
strbuf instead of char array). I also added an annotation in
repository-version.txt, clarifying, that this option is useful only for
development purpose for now.

Patryk Obara (1):
  setup: recognise extensions.objectFormat

 Documentation/technical/repository-version.txt | 12 ++++++++++++
 setup.c                                        | 27 ++++++++++++++++++++++++++
 t/t1302-repo-version.sh                        | 15 ++++++++++++++
 3 files changed, 54 insertions(+)


base-commit: 5be1f00a9a701532232f57958efab4be8c959a29
-- 
2.14.3

