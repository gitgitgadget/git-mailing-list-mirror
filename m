Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91D971F461
	for <e@80x24.org>; Mon,  8 Jul 2019 16:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730010AbfGHQhz (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jul 2019 12:37:55 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53005 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729506AbfGHQhy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jul 2019 12:37:54 -0400
Received: by mail-wm1-f67.google.com with SMTP id s3so173015wms.2
        for <git@vger.kernel.org>; Mon, 08 Jul 2019 09:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2xXqebNTZyy/qKd0wKsFDUyNRx/QP5rWyLVrMPAhmVU=;
        b=PYnRx8zbQNrEeaVRHIohl6gWIJAMFzUIY2PvuO+J5MqbX+vIKEGfMkYKZ7DGiVMjWB
         jzdo7T1IBgTFu7iQApGbjklY22G4tPD5FwiwkWJAxxgkbGvSUpX+KCWDFPWto+dYcv+e
         8Rao5IOZHwgHVVVxVT9Fl7/EoNMELh699gXi45UeAPidgD+F/9Xl9cXgCayBNCkWXwUi
         SAIzxP5JuqARcbljvLKlqxJlz7hpiQRwmepuFx8xETmcTwwU6G1A/GOhIVAVQcKxKLYd
         d3Sn0BMQ2Ieax5+Rzjcw/tgs0D5voEqQcGZEimW64J2n2FMp9/MrNonb3HbOtGWzHlnx
         OKhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2xXqebNTZyy/qKd0wKsFDUyNRx/QP5rWyLVrMPAhmVU=;
        b=MedK8HP3Bla1j1a2e6C3YS/5ewxmP5AN75k5US7NAwshKzcxagCSXzB1njRiW7Fwki
         wknWX/yg/x7uPnO8xW510lm9E9hrNtFFE/QyjEleKRpOdAVt4MjMLFAYKCmMtCZA0y93
         +nIQJqP6ZHK/l/Vd7/wJUZFgwJaULyUv04k8vm1yNsXdEEXMJknOPCmvlx9588C5CoGa
         d0tL6F87TOlpPkmwajQMmRKo2OLiqttPhsYB8v1WcrT+fLBjDvNoYkzxTWialbAXgLYH
         92hWEcjNHjiThlrwtW24Sqfhsvpuhd1AfTlG/JHbubiqqms+vrs+20VugOIG+AyZpLS8
         HD4g==
X-Gm-Message-State: APjAAAVRIFT70aYEYBPSjbDA4t+6BCh3QiTjeQdzlNiQ29cweCca2Oqv
        Oazn5F7vt+XfOhq+BQ5dqS/V52yN
X-Google-Smtp-Source: APXvYqx+gEoOw6XZ3ua4IUbD006bsRVdQCJj8TEEqGTtRm18Ls+JxyShy/iyEBSid/LO7h/ycaP5vQ==
X-Received: by 2002:a7b:c0c6:: with SMTP id s6mr4907274wmh.115.1562603872265;
        Mon, 08 Jul 2019 09:37:52 -0700 (PDT)
Received: from localhost ([95.148.214.18])
        by smtp.gmail.com with ESMTPSA id g11sm14442258wru.24.2019.07.08.09.37.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 09:37:51 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 01/14] apply: replace marc.info link with public-inbox
Date:   Mon,  8 Jul 2019 17:33:02 +0100
Message-Id: <20190708163315.29912-2-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a
In-Reply-To: <20190708163315.29912-1-t.gummerer@gmail.com>
References: <20190705170630.27500-1-t.gummerer@gmail.com>
 <20190708163315.29912-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

public-inbox.org links include the whole message ID by default.  This
means the message can still be found even if the site goes away, which
is not the case with the marc.info link.  Replace the marc.info link
with a more future proof one.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 apply.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/apply.c b/apply.c
index f15afa9f6a..599cf8956f 100644
--- a/apply.c
+++ b/apply.c
@@ -478,7 +478,7 @@ static char *find_name_gnu(struct apply_state *state,
 
 	/*
 	 * Proposed "new-style" GNU patch/diff format; see
-	 * http://marc.info/?l=git&m=112927316408690&w=2
+	 * https://public-inbox.org/git/7vll0wvb2a.fsf@assigned-by-dhcp.cox.net/
 	 */
 	if (unquote_c_style(&name, line, NULL)) {
 		strbuf_release(&name);
-- 
2.22.0.510.g264f2c817a

