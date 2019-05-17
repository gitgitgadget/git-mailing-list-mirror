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
	by dcvr.yhbt.net (Postfix) with ESMTP id 96FD31F461
	for <e@80x24.org>; Fri, 17 May 2019 19:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbfEQT4V (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 May 2019 15:56:21 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33383 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728315AbfEQT4V (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 May 2019 15:56:21 -0400
Received: by mail-wr1-f68.google.com with SMTP id d9so8371977wrx.0
        for <git@vger.kernel.org>; Fri, 17 May 2019 12:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ycv4qi31GgN6u311riizt4LH741B4kTHClZlB9wR2zY=;
        b=aqOKf3tj6Rk8WtLmuq1bo09hJeGKSE6af8WYbwP9E06dSbhKrZ4sYJxrsfhiGf9/ql
         ucRO1aIsnONdZGdHgWbRqlh0R+i59t/LlNMx9Vo0Fmy9tvh0Bmt6grEQxwh4z8D0FzAN
         Yr1DArThgEPr5pQjGBPNJ631eMCTrOuXhWhoKPvEi6TxOwBO693mHzvaa+mz8Tlaq0uR
         1+HMnz1a6b0V0PYwAdx7eGP01ko1zJfFVF/8QOf35D4s7/vNIGlSoVBsIcJP2w+MLBqY
         QfwnoNe+LUDEbgfpYWN0YvPPZLqrcvVVYkWnPydgYb//2oc4Fwl+3lzsIpqTchQCXSiG
         YQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ycv4qi31GgN6u311riizt4LH741B4kTHClZlB9wR2zY=;
        b=jRo62ilk3C9Y5Dfy8U6IeqRoesm/B5WC0GqHYdK6qcHpfObv7XJaLJr/C2oMiVanCr
         nAqrnX8mkDolDhLwzioTnxoWEGNIixzp3I8madlIOZNYOFX76anfrovbAZmn888IsowY
         Kub7ds2fbrz8cV86zUWk2+zQuk0lR5k4KuSSMAVVfp16XBR0GKRFcgd3B9vdCPnB0Rdb
         7mUfoReaasxXbMgwUPYtv059AMwhZz7d8kUODJtKQUwL84+5iXw8TO2oknpeWKvAo2P9
         MJbZqXmIpGGM7hHPaPPM/Utg8Bdo2oVEowMrE/bpsq4vRL1HqI30PJKX34+u87VkKvSV
         svng==
X-Gm-Message-State: APjAAAWCfjVb0PrEPX76Zrn7xLewhRhElBxYRbjR3HSx+yF4nQL/QHBu
        GYG3QSGQMcBDo6sHWMfj4sbOW6z8rFw=
X-Google-Smtp-Source: APXvYqy14ntv898zbWwtYV7zQDKQ3LVqdUqmS+CqLcg4EngwOKHbi+9N+6cY8P5/X4HV0VjfkWSP0Q==
X-Received: by 2002:adf:ec8c:: with SMTP id z12mr25588045wrn.209.1558122979445;
        Fri, 17 May 2019 12:56:19 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r2sm18691149wrr.65.2019.05.17.12.56.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 17 May 2019 12:56:18 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Stephen Boyd <swboyd@chromium.org>, jrnieder@gmail.com,
        sandals@crustytoothpaste.net, sunshine@sunshineco.com,
        xypron.glpk@gmx.de, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/5] send-email: document --no-[to|cc|bcc]
Date:   Fri, 17 May 2019 21:55:43 +0200
Message-Id: <20190517195545.29729-4-avarab@gmail.com>
X-Mailer: git-send-email 2.22.0.rc0.259.g3cce4bfedb
In-Reply-To: <xmqqsgtd3fw3.fsf@gitster-ct.c.googlers.com>
References: <xmqqsgtd3fw3.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These options added in f434c083a0 ("send-email: add --no-cc, --no-to,
and --no-bcc", 2010-03-07) were never documented.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-send-email.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 1afe9fc858..8100ff4b0f 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -278,6 +278,10 @@ must be used for each option.
 Automating
 ~~~~~~~~~~
 
+--no-[to|cc|bcc]::
+	Clears any list of "To:", "Cc:", "Bcc:" addresses previously
+	set via config.
+
 --to-cmd=<command>::
 	Specify a command to execute once per patch file which
 	should generate patch file specific "To:" entries.
-- 
2.21.0.1020.gf2820cf01a

