Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1B4A1F42D
	for <e@80x24.org>; Thu, 24 May 2018 19:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161214AbeEXTff (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 15:35:35 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33199 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034514AbeEXTf3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 15:35:29 -0400
Received: by mail-wm0-f66.google.com with SMTP id x12-v6so28805977wmc.0
        for <git@vger.kernel.org>; Thu, 24 May 2018 12:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=dJ4/3Raramh40AYPGpn9ktI3gete0PE9OmyooF+34mg=;
        b=YrarB9u9YoOMm+faDNJoW/fK0FViw9Fd6Lkpd/mEGDq3bmg7eCylkaOLIFoBSkrImv
         cy19H058TkvgVLfvZDTGNzsZ66Or/3LkCLsIhYciXdqCzV5XH1/BDxrjlixzAqVyV0Ww
         VTSDRTHzwLhDxLgbfm+j7N0xVlEP9LB+5qeo1YK/ve9fSmSjHio4odf6fmK9O1M+4UWa
         lwi2UeEcH3ci0Htafp2VhinLXUoBUVi3LdPNVzN0sSfV2qOg9cxEKSPMxEzEmia6VBUL
         jifPLDrrGzB0JAmCRNebRDXaxRQZUo8jPwhSqHAFjXCezyISqIIHrV60m1N+p/4pparp
         d+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=dJ4/3Raramh40AYPGpn9ktI3gete0PE9OmyooF+34mg=;
        b=Jn8MftmvXSINSf4+clxubhIzZLPept7pNtsjXbw1L8+ajNN0C6vb8850FlqwKtMuuj
         qT4hsbWULAmBCe7I71ODDMTCFWVYc+A5/gsdH3Ua1eHi4eyVGIr2MqXfcKk4f0keLVCE
         OVKJ/Dj43Wk75PZbLgzhR0RRZuAsksRbWZec1aimDOyI4JjUDIb30M7wBZRWuVA/ihvg
         M6lrBbZttvnbW1l03ubN/EL8Jb+SxSteJrsO/fcvlR1vZV+lfvaNVMY1x9RKoWGtcabB
         eLRJPWxcdzHeBOOGmYJ9hKtdLoQ70uW+9K2miLMa9nGj4cMMYqgNXYk7Keoh9DCWJbof
         T8ow==
X-Gm-Message-State: ALKqPwfHdQOcxPoiXV9UqiR+3Q+pUAKwsYkyKCuysQYph+J0exv7d/tu
        NLDGNAgrwyDdJWaShMK1N72j9E9f
X-Google-Smtp-Source: AB8JxZq/BHzUkfRRW6yHxxmjJd6k6vbWFh1LPXqtkQrHPwaeDLnTT6NWM/u9ebvsNato9QDD++NSew==
X-Received: by 2002:a1c:3505:: with SMTP id c5-v6mr9099826wma.35.1527190527985;
        Thu, 24 May 2018 12:35:27 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 136-v6sm7056887wmo.12.2018.05.24.12.35.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 May 2018 12:35:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/4] config doc: don't describe *.fetchObjects twice
Date:   Thu, 24 May 2018 19:35:13 +0000
Message-Id: <20180524193516.28713-2-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180524193516.28713-1-avarab@gmail.com>
References: <20180524193516.28713-1-avarab@gmail.com>
In-Reply-To: <20180524190214.GA21354@sigill.intra.peff.net>
References: <20180524190214.GA21354@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the copy/pasted description of the fetch.fsckObjects and
receive.fsckObjects variables to refer to transfer.fsckObjects
instead.

Let's not duplicate the description of what *.fsckObjects does twice.
instead let's refer to transfer.fsckObjects from both fetch.* and
receive.*.

I don't think this description of it makes much sense, but for now I'm
just moving the existing documentation around. Making it better will
be done in a later patch.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config.txt | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 84e2891aed..623dffd198 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1422,10 +1422,9 @@ fetch.recurseSubmodules::
 
 fetch.fsckObjects::
 	If it is set to true, git-fetch-pack will check all fetched
-	objects. It will abort in the case of a malformed object or a
-	broken link. The result of an abort are only dangling objects.
-	Defaults to false. If not set, the value of `transfer.fsckObjects`
-	is used instead.
+	objects. See `transfer.fsckObjects` for what's
+	checked. Defaults to false. If not set, the value of
+	`transfer.fsckObjects` is used instead.
 
 fetch.unpackLimit::
 	If the number of objects fetched over the Git native
@@ -2845,10 +2844,9 @@ receive.certNonceSlop::
 
 receive.fsckObjects::
 	If it is set to true, git-receive-pack will check all received
-	objects. It will abort in the case of a malformed object or a
-	broken link. The result of an abort are only dangling objects.
-	Defaults to false. If not set, the value of `transfer.fsckObjects`
-	is used instead.
+	objects. See `transfer.fsckObjects` for what's checked.
+	Defaults to false. If not set, the value of
+	`transfer.fsckObjects` is used instead.
 
 receive.fsck.<msg-id>::
 	When `receive.fsckObjects` is set to true, errors can be switched
@@ -3332,6 +3330,10 @@ transfer.fsckObjects::
 	When `fetch.fsckObjects` or `receive.fsckObjects` are
 	not set, the value of this variable is used instead.
 	Defaults to false.
++
+When set, the fetch or receive will abort in the case of a malformed
+object or a broken link. The result of an abort are only dangling
+objects.
 
 transfer.hideRefs::
 	String(s) `receive-pack` and `upload-pack` use to decide which
-- 
2.17.0.290.gded63e768a

