Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F8091F406
	for <e@80x24.org>; Thu, 28 Dec 2017 14:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753505AbdL1OID (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Dec 2017 09:08:03 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35651 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753277AbdL1OIB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Dec 2017 09:08:01 -0500
Received: by mail-wm0-f65.google.com with SMTP id a79so5079058wma.0
        for <git@vger.kernel.org>; Thu, 28 Dec 2017 06:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=5wJS7MlQhFIvKrZTmNb+GdFgk9Ths+WEgW+FXxlm63A=;
        b=jDB6MPvyDtPQ1COP5trh5oqnfSjVs6t/BZxE9mSk7IX8HazvjX+KnTCI3dMnxJAssZ
         fNIHCyRxrCJbCCsKPUX4kbuF+Mjm/8wBKX9/WpvADGUJcBSZ0iVODx+CAZFCoKZgtnnc
         ihFlSWsXWK3gBHtGCyxz78ILiuptLwXixuNYwq5SozLB4TmhcfHbdpqWiGJBl8mQd34u
         t+Dc82BJz4brjb0fFvkVHetz9ZF9MiJftq90i/VfrsemhHZyUDH6dAbPeHsqOxwlBdG2
         lmtC179cXqqveLpGNa675IGOqCLZePIvYhjKvooAtZo2NAS8WwbD+9b0Jn7i7t8DsCI5
         X46g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5wJS7MlQhFIvKrZTmNb+GdFgk9Ths+WEgW+FXxlm63A=;
        b=lZj/z+szMy27XhJlGWcfVNXqiw35WyzjsHkvDJG3TUhIM2tYtGS5PEbuBIPQDeYMuZ
         Kt3IB9NyieepAEFSldU9nzBPvC4f/dtPS6rg1hKzk0Jp+I/NNh3gx7aDMkJveBb3kRlt
         kS46zG+ooxz0PvOlMlNodQpAd6E1aONCgtTDbHWLiU7JhFLfh9yPtyDyEMuVhxWmMAF+
         6W/ik3aQ4fXYdMHubwAC7mfzOJPOK3N0raRHxQMhFCTpLWIUIPzx7yoZoDVQYlHzD0df
         Eq97T1bddoFXuuA3lKYCqGl5ujyVEpOzZxFMeMJhRdsMdz2PyKljJIa353Tkv6gA1rDU
         d48Q==
X-Gm-Message-State: AKGB3mKhWwzGLh/uFwzesx3o+aIkw2Al/OcC/Flq/58RlORGlsV4jT30
        AlWD9SbRv1D38aKjRsNveWVxxZlt
X-Google-Smtp-Source: ACJfBotqLDKU6Jqh1mHwfzBk7+tZqxX4lrilCwhPZuOPe6/e3onCUWA6T9EfXMwAwNEFTc8nIKsj8A==
X-Received: by 10.28.169.151 with SMTP id s145mr19041315wme.102.1514470079606;
        Thu, 28 Dec 2017 06:07:59 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id g54sm33797478wrg.43.2017.12.28.06.07.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Dec 2017 06:07:58 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Sixt <j6t@kdbg.org>, git-for-windows@googlegroups.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/2] Windows: stop supplying BLK_SHA1=YesPlease by default
Date:   Thu, 28 Dec 2017 14:07:42 +0000
Message-Id: <20171228140742.26735-3-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20171228140742.26735-1-avarab@gmail.com>
References: <20171228140742.26735-1-avarab@gmail.com>
In-Reply-To: <20171227233912.GB181628@aiede.mtv.corp.google.com>
References: <20171227233912.GB181628@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using BLK_SHA1 in lieu of the OpenSSL routines was done in
9bccfcdbff ("Windows: use BLK_SHA1 again", 2009-10-22), since DC_SHA1
is now the default for git in general it makes sense for Windows to
use that too, this looks like something that was missed back in
e6b07da278 ("Makefile: make DC_SHA1 the default", 2017-03-17).

As noted in 2cfc70f0de ("mingw: use OpenSSL's SHA-1 routines",
2017-02-09) OpenSSL has a performance benefit compared to BLK_SHA1 on
MinGW, so perhaps that and the Windows default should be changed
around again. That's a topic for another series, it seems clear that
this specific flag is nobody's explicit intention.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 config.mak.uname | 1 -
 1 file changed, 1 deletion(-)

diff --git a/config.mak.uname b/config.mak.uname
index 685a80d138..6a862abd35 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -361,7 +361,6 @@ ifeq ($(uname_S),Windows)
 	NO_REGEX = YesPlease
 	NO_GETTEXT = YesPlease
 	NO_PYTHON = YesPlease
-	BLK_SHA1 = YesPlease
 	ETAGS_TARGET = ETAGS
 	NO_INET_PTON = YesPlease
 	NO_INET_NTOP = YesPlease
-- 
2.15.1.424.g9478a66081

