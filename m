Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 857461F406
	for <e@80x24.org>; Thu, 28 Dec 2017 14:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753454AbdL1OIA (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Dec 2017 09:08:00 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33996 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753277AbdL1OH7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Dec 2017 09:07:59 -0500
Received: by mail-wm0-f66.google.com with SMTP id y82so2021942wmg.1
        for <git@vger.kernel.org>; Thu, 28 Dec 2017 06:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=cQ7XaeHil4mLlpQm8kN0oNzxS66sLwDW9n+qOe8SQbU=;
        b=TqxdsagDDIERc8x7rdbUmOUrE3YzvPTig4djbzRQOvvSPsP0vi/tc11FL8ySNj2fBb
         J+lxRmAfffFfol7PeBn7IxUUvrvhpIhIKUYhXlEPmF1w3LtbBXYajTD/VOPsLrqutxTm
         3xl8oAf09szrDe8xr0QPF++932iWn5qAw9OUVeSuH/h1IUFOPogfBTXcZfnvst/z/tpD
         bb2zKCTWH7L2TA3Kxjw6aV58ocjU59ilfTIneQhrc7LaoLFlGGseX0abuIgnYAimrD4q
         ralwJSFLHvxpkQMSjmxtNKJnZEROVgm0itnPyJfLQ7073xOLy2RbzhYnuPvdTebp1llT
         nPHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=cQ7XaeHil4mLlpQm8kN0oNzxS66sLwDW9n+qOe8SQbU=;
        b=SPSkXgQNzHE8Pm+8dFhl2v6Pl+3kOItGa74t8pvWDlUm3v0V5DaWs6JXo4uFqEaQds
         yQENNQSJCHFg09vC1z+/DEnNbOCfITVYZWfFp364F4/y44oFTDCCa0f78CgPtPFJDOKI
         SsisLBXgXDejdaYiIEXTG3ZW8ohwDtqTe6SBCf6Sf9IPvZ7fycJeL57UUA24W9NRjNPM
         /ipiADAQ/qzHut1ikws16Iakr8+GQGRflISbQyS1mr2BygclN/DG3O0OCTaLwRhu1SqH
         poBztZPgIegy8RDcvFDJUp7FTe+0mEce5X2TvgdSoJQCIMrvKKisbiegtfnu0rPYPrE8
         98Kg==
X-Gm-Message-State: AKGB3mJOXuB1VkQOtB0NjnJ9F4uTiTsX+mD9s72+cL2Dz/11dymjdmsk
        TpA5tHofPohTzSK2dGaysapg/w0T
X-Google-Smtp-Source: ACJfBou36e0q+f31zTD0IU5cfNJrxl8CdAvAYuqmsdCobuwtiRp6II5hKYFDz84VKgOccJh+Y4L22Q==
X-Received: by 10.28.28.11 with SMTP id c11mr26649748wmc.161.1514470077532;
        Thu, 28 Dec 2017 06:07:57 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id g54sm33797478wrg.43.2017.12.28.06.07.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Dec 2017 06:07:56 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Sixt <j6t@kdbg.org>, git-for-windows@googlegroups.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/2] Makefile: NO_OPENSSL=1 should no longer imply BLK_SHA1=1
Date:   Thu, 28 Dec 2017 14:07:41 +0000
Message-Id: <20171228140742.26735-2-avarab@gmail.com>
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

Use the collision detecting SHA-1 implementation by default even when
NO_OPENSSL is set.

Setting NO_OPENSSL=UnfortunatelyYes has implied BLK_SHA1=1 ever since
the former was introduced in dd53c7ab29 (Support for NO_OPENSSL,
2005-07-29).  That implication should have been removed when the
default SHA-1 implementation changed from OpenSSL to DC_SHA1 in
e6b07da278 (Makefile: make DC_SHA1 the default, 2017-03-17).  Finish
what that commit started by removing the BLK_SHA1 fallback setting so
the default DC_SHA1 implementation will be used.

Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile     | 2 --
 configure.ac | 1 -
 2 files changed, 3 deletions(-)

diff --git a/Makefile b/Makefile
index 32c170687c..7e1da28b6f 100644
--- a/Makefile
+++ b/Makefile
@@ -23,7 +23,6 @@ all::
 # it at all).
 #
 # Define NO_OPENSSL environment variable if you do not have OpenSSL.
-# This also implies BLK_SHA1.
 #
 # Define USE_LIBPCRE if you have and want to use libpcre. Various
 # commands such as log and grep offer runtime options to use
@@ -1260,7 +1259,6 @@ ifndef NO_OPENSSL
 	endif
 else
 	BASIC_CFLAGS += -DNO_OPENSSL
-	BLK_SHA1 = 1
 	OPENSSL_LIBSSL =
 endif
 ifdef NO_OPENSSL
diff --git a/configure.ac b/configure.ac
index 2f55237e65..7f8415140f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -241,7 +241,6 @@ AC_MSG_NOTICE([CHECKS for site configuration])
 # a bundled SHA1 routine optimized for PowerPC.
 #
 # Define NO_OPENSSL environment variable if you do not have OpenSSL.
-# This also implies BLK_SHA1.
 #
 # Define OPENSSLDIR=/foo/bar if your openssl header and library files are in
 # /foo/bar/include and /foo/bar/lib directories.
-- 
2.15.1.424.g9478a66081

